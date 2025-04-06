/* Copyright (c) 2007-2009, Stanford University
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of Stanford University nor the names of its 
 *       contributors may be used to endorse or promote products derived from 
 *       this software without specific prior written permission.
 */

 #include <stdio.h>
 #include <strings.h>
 #include <string.h>
 #include <stddef.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <assert.h>
 #include <pthread.h>
 
 #include <sys/mman.h>
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <ctype.h>
 
 #include "stddefines.h"
 
 typedef struct {
     char x;
     char y;
 } POINT_T;
 
 typedef struct {
     pthread_t tid;
     POINT_T *points;
     int num_elems;
     long long SX;
     long long SY; 
     long long SXX;
     long long SYY; 
     long long SXY;
 } lreg_args;
 
 void *linear_regression_pthread(void *args_in) {
     lreg_args* args = (lreg_args*)args_in;
     int i;
 
     args->SX = 0;
     args->SXX = 0;
     args->SY  = 0;
     args->SYY = 0;
     args->SXY = 0;
 
     for (i = 0; i < args->num_elems; i++) {
         args->SX  += args->points[i].x;
         args->SXX += args->points[i].x * args->points[i].x;
         args->SY  += args->points[i].y;
         args->SYY += args->points[i].y * args->points[i].y;
         args->SXY += args->points[i].x * args->points[i].y;
     }
 
     return (void *)0;
 }
 
 int main(int argc, char *argv[]) {
     int fd;
     char *fdata;
     char *fname;
     struct stat finfo;
 
     int req_units, num_threads, i;
     pthread_attr_t attr;
     lreg_args* tid_args;
 
     // USAGE: ./linear_regression-pthread <input_file> <num_threads>
     if (argc < 3) {
         printf("USAGE: %s <filename> <num_threads>\n", argv[0]);
         exit(1);
     }
 
     fname = argv[1];
     num_threads = atoi(argv[2]);
     if (num_threads <= 0) {
         fprintf(stderr, "Invalid thread count\n");
         exit(1);
     }
 
     CHECK_ERROR((fd = open(fname, O_RDONLY)) < 0);
     CHECK_ERROR(fstat(fd, &finfo) < 0);
     CHECK_ERROR((fdata = mmap(0, finfo.st_size + 1,
         PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0)) == NULL);
 
     pthread_attr_init(&attr);
     pthread_attr_setscope(&attr, PTHREAD_SCOPE_SYSTEM);
 
     printf("Linear Regression P-Threads: Running with %d threads...\n", num_threads);
 
     POINT_T *points = (POINT_T*)fdata;
     long long n = (long long)finfo.st_size / sizeof(POINT_T);
 
     req_units = n / num_threads;
     tid_args = (lreg_args *)CALLOC(sizeof(lreg_args), num_threads); 
 
     for (i = 0; i < num_threads; i++) {
         tid_args[i].points = &points[i * req_units];
         tid_args[i].num_elems = req_units;
         if (i == (num_threads - 1)) {
             tid_args[i].num_elems = n - i * req_units;
         }
 
         CHECK_ERROR(pthread_create(&tid_args[i].tid, &attr, linear_regression_pthread, (void*)&tid_args[i]) != 0);
     }
 
     long long SX_ll = 0, SY_ll = 0, SXX_ll = 0, SYY_ll = 0, SXY_ll = 0;
 
     for (i = 0; i < num_threads; i++) {
         int ret_val;
         CHECK_ERROR(pthread_join(tid_args[i].tid, (void **)(void*)&ret_val) != 0);
         CHECK_ERROR(ret_val != 0);
 
         SX_ll  += tid_args[i].SX;
         SY_ll  += tid_args[i].SY; 
         SXX_ll += tid_args[i].SXX; 
         SYY_ll += tid_args[i].SYY; 
         SXY_ll += tid_args[i].SXY;
     }
 
     free(tid_args);
 
     double a, b, xbar, ybar, r2;
     double SX = (double)SX_ll;
     double SY = (double)SY_ll;
     double SXX = (double)SXX_ll;
     double SYY = (double)SYY_ll;
     double SXY = (double)SXY_ll;
 
     b = (double)(n * SXY - SX * SY) / (n * SXX - SX * SX);
     a = (SY_ll - b * SX_ll) / n;
     xbar = (double)SX_ll / n;
     ybar = (double)SY_ll / n;
     r2 = (double)(n * SXY - SX * SY) * (n * SXY - SX * SY) / ((n * SXX - SX * SX) * (n * SYY - SY * SY));
 
     printf("Linear Regression P-Threads Results:\n");
     printf("\ta    = %lf\n", a);
     printf("\tb    = %lf\n", b);
     printf("\txbar = %lf\n", xbar);
     printf("\tybar = %lf\n", ybar);
     printf("\tr2   = %lf\n", r2);
     printf("\tSX   = %lld\n", SX_ll);
     printf("\tSY   = %lld\n", SY_ll);
     printf("\tSXX  = %lld\n", SXX_ll);
     printf("\tSYY  = %lld\n", SYY_ll);
     printf("\tSXY  = %lld\n", SXY_ll);
 
     CHECK_ERROR(pthread_attr_destroy(&attr) < 0);
     CHECK_ERROR(munmap(fdata, finfo.st_size + 1) < 0);
     CHECK_ERROR(close(fd) < 0);
     return 0;
 }
 
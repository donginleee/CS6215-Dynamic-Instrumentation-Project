#include <stdio.h>
#include <strings.h>
#include <string.h>
#include <stddef.h>
#include <stdlib.h>
#include <unistd.h>
#include <assert.h>
#include <math.h>
#include <pthread.h>
#include "stddefines.h"

#define DEF_GRID_SIZE 100
#define DEF_NUM_ROWS 10
#define DEF_NUM_COLS 10

int num_rows;
int num_cols;
int grid_size;
int num_procs;
int next_row;

int **matrix, **cov;
int *mean;
pthread_mutex_t row_lock;

typedef struct {
   int first_row;
   int last_row;
} mean_arg_t;

void parse_args(int argc, char **argv) {
   int c;
   extern char *optarg;
   extern int optind;

   num_rows = DEF_NUM_ROWS;
   num_cols = DEF_NUM_COLS;
   grid_size = DEF_GRID_SIZE;

   while ((c = getopt(argc, argv, "r:c:s:")) != EOF) {
      switch (c) {
         case 'r': num_rows = atoi(optarg); break;
         case 'c': num_cols = atoi(optarg); break;
         case 's': grid_size = atoi(optarg); break;
         case '?':
            printf("Usage: %s -r <num_rows> -c <num_cols> -s <max value> <num_threads>\n", argv[0]);
            exit(1);
      }
   }

   if (optind >= argc) {
      printf("Missing required <num_threads> argument\n");
      exit(1);
   }

   num_procs = atoi(argv[optind]);
   if (num_rows <= 0 || num_cols <= 0 || grid_size <= 0 || num_procs <= 0) {
      printf("All input values must be greater than 0\n");
      exit(1);
   }

   printf("Rows: %d, Cols: %d, Grid Max: %d, Threads: %d\n", num_rows, num_cols, grid_size, num_procs);
}

void dump_points(int **vals, int rows, int cols) {
   for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
         dprintf("%5d ", vals[i][j]);
      }
      dprintf("\n");
   }
}

void generate_points(int **pts, int rows, int cols) {
   for (int i = 0; i < rows; i++)
      for (int j = 0; j < cols; j++)
         pts[i][j] = rand() % grid_size;
}

void *calc_mean(void *arg) {
   mean_arg_t *mean_arg = (mean_arg_t *)arg;
   for (int i = mean_arg->first_row; i < mean_arg->last_row; i++) {
      int sum = 0;
      for (int j = 0; j < num_cols; j++)
         sum += matrix[i][j];
      mean[i] = sum / num_cols;
   }
   return NULL;
}

void *calc_cov(void *arg) {
   int i, j, k, sum;
   while (1) {
      pthread_mutex_lock(&row_lock);
      i = next_row++;
      pthread_mutex_unlock(&row_lock);

      if (i >= num_rows) break;

      for (j = i; j < num_rows; j++) {
         sum = 0;
         for (k = 0; k < num_cols; k++)
            sum += (matrix[i][k] - mean[i]) * (matrix[j][k] - mean[j]);
         cov[i][j] = cov[j][i] = sum / (num_cols - 1);
      }
   }
   return NULL;
}

void pthread_mean() {
   pthread_attr_t attr;
   pthread_t *tid = malloc(num_procs * sizeof(pthread_t));
   mean_arg_t *args = malloc(num_procs * sizeof(mean_arg_t));

   pthread_attr_init(&attr);
   pthread_attr_setscope(&attr, PTHREAD_SCOPE_SYSTEM);

   int rows_per_thread = num_rows / num_procs;
   int excess = num_rows % num_procs;
   int curr = 0;

   for (int i = 0; i < num_procs; i++) {
      args[i].first_row = curr;
      args[i].last_row = curr + rows_per_thread + (excess-- > 0 ? 1 : 0);
      curr = args[i].last_row;
      pthread_create(&tid[i], &attr, calc_mean, &args[i]);
   }

   for (int i = 0; i < num_procs; i++)
      pthread_join(tid[i], NULL);

   free(tid);
   free(args);
}

void pthread_cov() {
   pthread_attr_t attr;
   pthread_t *tid = malloc(num_procs * sizeof(pthread_t));
   pthread_mutex_init(&row_lock, NULL);
   pthread_attr_init(&attr);
   pthread_attr_setscope(&attr, PTHREAD_SCOPE_SYSTEM);
   next_row = 0;

   for (int i = 0; i < num_procs; i++)
      pthread_create(&tid[i], &attr, calc_cov, NULL);

   for (int i = 0; i < num_procs; i++)
      pthread_join(tid[i], NULL);

   free(tid);
}

int main(int argc, char **argv) {
   parse_args(argc, argv);

   matrix = malloc(num_rows * sizeof(int *));
   for (int i = 0; i < num_rows; i++)
      matrix[i] = malloc(num_cols * sizeof(int));

   generate_points(matrix, num_rows, num_cols);
   dump_points(matrix, num_rows, num_cols);

   mean = malloc(num_rows * sizeof(int));
   cov = malloc(num_rows * sizeof(int *));
   for (int i = 0; i < num_rows; i++)
      cov[i] = malloc(num_rows * sizeof(int));

   pthread_mean();
   pthread_cov();

   dump_points(cov, num_rows, num_rows);

   for (int i = 0; i < num_rows; i++) {
      free(matrix[i]);
      free(cov[i]);
   }
   free(matrix);
   free(cov);
   free(mean);

   return 0;
}

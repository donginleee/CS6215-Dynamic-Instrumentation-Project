#include <stdio.h>
#include <strings.h>
#include <string.h>
#include <stddef.h>
#include <stdlib.h>
#include <unistd.h>
#include <assert.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <ctype.h>
#include <time.h>
#include <crypt.h>
#include <pthread.h>
#include <sys/time.h>
#include <inttypes.h>

#include "map_reduce.h"
#include "stddefines.h"

#define DEFAULT_UNIT_SIZE 5
#define SALT_SIZE 2
#define MAX_REC_LEN 1024
#define OFFSET 5

typedef struct {
  int keys_file_len;
  int encrypted_file_len;
  long bytes_comp;
  char * keys_file;
  char * encrypt_file;
} str_data_t;

typedef struct {
  char * keys_file;
  char * encrypt_file;
  int TID;
} str_map_data_t;

char *key1 = "Helloworld";
char *key2 = "howareyou";
char *key3 = "ferrari";
char *key4 = "whotheman";

char *key1_final;
char *key2_final;
char *key3_final;
char *key4_final;

void string_match_splitter(void *data_in, int num_procs);
int getnextline(char* output, int max_len, char* file);
void *string_match_map(void *args);
void string_match_reduce(void *key_in, void **vals_in, int vals_len);
void compute_hashes(char* word, char* final_word);

int getnextline(char* output, int max_len, char* file) {
    int i=0;
    while(i<max_len-1) {
        if(file[i] == '\0') {
            return (i==0) ? -1 : i;
        }
        if(file[i] == '\r')
            return (i+2);
        if(file[i] == '\n')
            return (i+1);

        output[i] = file[i];
        i++;
    }
    file += i;
    return i;
}

void compute_hashes(char* word, char* final_word) {
    int i;
    for(i=0;i<strlen(word);i++) {
        final_word[i] = word[i]+OFFSET;
    }
    final_word[i] = '\0';
}

void string_match_splitter(void *data_in, int num_procs) {
    key1_final = malloc(strlen(key1) + 1);
    key2_final = malloc(strlen(key2) + 1);
    key3_final = malloc(strlen(key3) + 1);
    key4_final = malloc(strlen(key4) + 1);

    compute_hashes(key1, key1_final);
    compute_hashes(key2, key2_final);
    compute_hashes(key3, key3_final);
    compute_hashes(key4, key4_final);

    pthread_attr_t attr;
    pthread_t * tid;
    int i;

    str_data_t * data = (str_data_t *)data_in; 
    assert(data_in);

    tid = (pthread_t *)MALLOC(num_procs * sizeof(pthread_t));

    pthread_attr_init(&attr);
    pthread_attr_setscope(&attr, PTHREAD_SCOPE_SYSTEM);

    int req_bytes = data->keys_file_len / num_procs;

    str_map_data_t *map_data = (str_map_data_t*)malloc(sizeof(str_map_data_t) * num_procs);
    map_args_t* out = (map_args_t*)malloc(sizeof(map_args_t) * num_procs);

    for(i=0; i<num_procs; i++) {
        map_data[i].encrypt_file = data->encrypt_file;
        map_data[i].keys_file = data->keys_file + data->bytes_comp;
        map_data[i].TID = i;

        int available_bytes = data->keys_file_len - data->bytes_comp;
        if(available_bytes < 0) available_bytes = 0;

        out[i].length = (req_bytes < available_bytes)? req_bytes:available_bytes;
        out[i].data = &(map_data[i]);

        char* final_ptr = map_data[i].keys_file + out[i].length;
        int counter = data->bytes_comp + out[i].length;

        while(counter <= data->keys_file_len && *final_ptr != '\n' && *final_ptr != '\r' && *final_ptr != '\0') {
            counter++;
            final_ptr++;
        }

        if(*final_ptr == '\r')
            counter+=2;
        else if(*final_ptr == '\n')
            counter++;

        out[i].length = counter - data->bytes_comp;
        data->bytes_comp = counter;

        CHECK_ERROR(pthread_create(&tid[i], &attr, string_match_map, (void*)(&(out[i]))) != 0);
    }

    for (i = 0; i < num_procs; i++) {
        int ret_val;
        CHECK_ERROR(pthread_join(tid[i], (void **)(void*)&ret_val) != 0);
        CHECK_ERROR(ret_val != 0);
    }

    pthread_attr_destroy(&attr);
    free(tid);
    free(key1_final);
    free(key2_final);
    free(key3_final);
    free(key4_final);
    free(out);
    free(map_data);
}

void *string_match_map(void *args) {
    assert(args);

    str_map_data_t* data_in = (str_map_data_t*)( ((map_args_t*)args)->data);

    int key_len, total_len = 0;
    char * key_file = data_in->keys_file;
    char * cur_word = malloc(MAX_REC_LEN);
    char * cur_word_final = malloc(MAX_REC_LEN);
    bzero(cur_word, MAX_REC_LEN);
    bzero(cur_word_final, MAX_REC_LEN);

    while( (total_len < ((map_args_t*)args)->length) &&
           ((key_len = getnextline(cur_word, MAX_REC_LEN, key_file)) >= 0)) {

        compute_hashes(cur_word, cur_word_final);

        if(!strcmp(key1_final, cur_word_final))
            dprintf("FOUND: WORD IS %s\n", cur_word);
        if(!strcmp(key2_final, cur_word_final))
            dprintf("FOUND: WORD IS %s\n", cur_word);
        if(!strcmp(key3_final, cur_word_final))
            dprintf("FOUND: WORD IS %s\n", cur_word);
        if(!strcmp(key4_final, cur_word_final))
            dprintf("FOUND: WORD IS %s\n", cur_word);

        key_file = key_file + key_len;
        bzero(cur_word,MAX_REC_LEN);
        bzero(cur_word_final, MAX_REC_LEN);
        total_len+=key_len;
    }

    free(cur_word);
    free(cur_word_final); 
    return (void *)0;
}

int main(int argc, char *argv[]) {
    int fd_keys;
    char *fdata_keys;
    struct stat finfo_keys;
    char *fname_keys;
    int num_procs;

    if (argc < 3) {
        printf("USAGE: %s <keys filename> <num_threads>\n", argv[0]);
        exit(1);
    }

    fname_keys = argv[1];
    num_procs = atoi(argv[2]);

    struct timeval starttime,endtime;
    srand( (unsigned)time( NULL ) );

    CHECK_ERROR((fd_keys = open(fname_keys,O_RDONLY)) < 0);
    CHECK_ERROR(fstat(fd_keys, &finfo_keys) < 0);
    CHECK_ERROR((fdata_keys= mmap(0, finfo_keys.st_size + 1,
        PROT_READ | PROT_WRITE, MAP_PRIVATE, fd_keys, 0)) == NULL);

    dprintf("Keys Size is %" PRId64 "\n",finfo_keys.st_size);

    str_data_t str_data;

    str_data.keys_file_len = finfo_keys.st_size;
    str_data.encrypted_file_len = 0;
    str_data.bytes_comp = 0;
    str_data.keys_file  = ((char *)fdata_keys);
    str_data.encrypt_file  = NULL;

    printf("String Match: Calling Parallel String Match with %d threads\n", num_procs);

    gettimeofday(&starttime,0);
    string_match_splitter(&str_data, num_procs);
    gettimeofday(&endtime,0);

    printf("String Match: Completed %ld\n",(endtime.tv_sec - starttime.tv_sec));

    CHECK_ERROR(munmap(fdata_keys, finfo_keys.st_size + 1) < 0);
    CHECK_ERROR(close(fd_keys) < 0);

    return 0;
}

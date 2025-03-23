#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <stdatomic.h>

//di modified for accepting 'CLAP CLI arguments'
int NUM_THREADS = 2;


int shared_var = 0;          // Regular variable (can cause race conditions)
atomic_int atomic_var = 0;   // Atomic variable (prevents race conditions)

// Function to write to the shared variable (store)
void* writer(void* arg) {
    int thread_id = *(int*)arg;

    // Writing to a regular variable (race condition may occur)
    shared_var = thread_id;
    printf("Thread %d wrote shared_var = %d\n", thread_id, shared_var);

    // Writing to an atomic variable (prevents race condition)
    atomic_store(&atomic_var, thread_id);
    printf("Thread %d wrote atomic_var = %d\n", thread_id, atomic_var);

    return NULL;
}

// Function to read from the shared variable (load)
void* reader(void* arg) {
    int thread_id = *(int*)arg;
    
    // Reading from a regular variable
    int val = shared_var;
    printf("Thread %d read shared_var = %d\n", thread_id, val);

    // Reading from an atomic variable
    int atomic_val = atomic_load(&atomic_var);
    printf("Thread %d read atomic_var = %d\n", thread_id, atomic_val);

    return NULL;
}

int main(int argc, char *argv[]) 
{
    //di modified for accepting 'CLAP CLI arguments'
    // Read thread count from CLI argument
    if (argc > 1) 
    {
        NUM_THREADS = atoi(argv[1]);
        if (NUM_THREADS <= 0) {
            fprintf(stderr, "Error: Number of threads must be greater than 0.\n");
            return 1;
        }
    }

    printf("Creating %d threads...\n", NUM_THREADS);

    pthread_t threads[NUM_THREADS];
    int thread_ids[NUM_THREADS];

    // Two threads will perform store operations (writing)
    for (int i = 0; i < NUM_THREADS / 2; i++) 
    {
        thread_ids[i] = i + 1;
        pthread_create(&threads[i], NULL, writer, &thread_ids[i]);
    }

    // Two threads will perform load operations (reading)
    for (int i = NUM_THREADS / 2; i < NUM_THREADS; i++) 
    {
        thread_ids[i] = i + 1;
        pthread_create(&threads[i], NULL, reader, &thread_ids[i]);
    }
    // for (int i = NUM_THREADS / 2; i < NUM_THREADS; i++) {
    //     thread_ids[i] = i + 1;
    //     pthread_create(&threads[i], NULL, reader, &thread_ids[i]);
    // }

    // Wait for all threads to finish
    for (int i = 0; i < NUM_THREADS; i++) 
    {
        pthread_join(threads[i], NULL);
    }

    printf("All threads completed.\n");

    return 0;
}

#include <stdio.h>
#include <stdint.h>
#include <time.h>

int main()
{
    uint64_t primes[100] = {0}; // an array to store the first 100 prime numbers
    uint64_t candidate = 2; // the candidate prime number
    int count = 0; // the number of prime numbers found
    clock_t start = clock(); // start timing

    while (count < 100)
    {
        // check if candidate is a prime number
        int is_prime = 1;
        for (int i = 0; i < count; i++)
        {
            if (candidate % primes[i] == 0)
            {
                is_prime = 0;
                break;
            }
        }
        if (is_prime)
        {
            // candidate is a prime number, add it to the array
            primes[count] = candidate;
            count++;
        }

        candidate++;
    }

    clock_t end = clock(); // stop timing
    double elapsed_secs = (double)(end - start) / CLOCKS_PER_SEC;

    printf("Elapsed time: %.10f seconds\n", elapsed_secs);

    return 0;
}

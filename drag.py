import time

def is_prime(n):
    # Check if n is a prime number
    if n < 2:
        return False
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            return False
    return True

start = time.perf_counter() # start timing

primes = []
candidate = 2
while len(primes) < 100:
    if is_prime(candidate):
        primes.append(candidate)
    candidate += 1

end = time.perf_counter() # stop timing
elapsed_time = end - start

print("Elapsed time: {:.6f} seconds".format(elapsed_time))

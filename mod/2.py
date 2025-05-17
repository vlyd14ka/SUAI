import random
import math
import numpy as np
import matplotlib.pyplot as plt

class FibonacciGenerator:
    def __init__(self, m, k, seed=None):
        self.m = m
        self.k = k
        self.state = [0] * (k + 1)
        self.index = 0
        if seed is None:
            seed = np.random.randint(0, 2**m)
        self.state[0] = seed

    def next(self):
        self.index = (self.index + 1) % (self.k + 1)
        self.state[self.index] = (self.state[self.index] + self.state[(self.index - self.k) % (self.k + 1)]) % (2**self.m)
        return self.state[self.index] / (2**self.m)

def exponential_random_variable(z, lambd):
    if z <= 0 or z >= 1:
        return float('inf')  # Return positive infinity for out-of-range values
    else:
        return -math.log(z) / lambd

def uniform_random_variable(z, A, B):
    return A + (B - A) * z

def erlang_random_variable(generator, lambd, k):
    return np.random.gamma(k, scale=1/lambd)

def normal_random_variable(z1, z2, mu, sigma):
    x1 = math.sqrt(-2 * math.log(z1)) * math.cos(2 * math.pi * z2) * sigma + mu
    return x1

def plot_histogram(random_vars, func_name):
    # Filter out infinite values
    finite_values = [x for x in random_vars if np.isfinite(x)]
    
    # Plot histogram of finite values
    plt.hist(finite_values, bins='auto', density=True)
    plt.title(f'{func_name}')
    plt.show()

num_vars = 100000

fib_gen = FibonacciGenerator(m=31, k=16, seed=55)

print("Экспоненциальная СВ")
lambd = 0.2
random_vars = [exponential_random_variable(
    fib_gen.next(), lambd=lambd) for _ in range(num_vars)]
plot_histogram(random_vars, 'Экспоненциальная СВ')
print(f"фкт МО        : {np.mean(random_vars)}")
print(f"фкт дисперсия : {np.var(random_vars)}\n")
print(f"эмп МО       : {1 / lambd}")
print(f"эмп дисперсия: {1 / (lambd**2)}\n")

print("Равномерная СВ")
A = 0
B = 100
random_vars = [uniform_random_variable(
    fib_gen.next(), A, B) for _ in range(num_vars)]
plot_histogram(random_vars, 'Равномерная СВ')
print(f"фкт МО        : {np.mean(random_vars)}")
print(f"фкт дисперсия : {np.var(random_vars)}\n")
print(f"эмп МО       : {(A + B) / 2}")
print(f"эмп дисперсия: {(B - A)**2 / 12}\n")


print("Эрланговская СВ")
lambd = 1
k = 1
random_vars = [erlang_random_variable(
    fib_gen, lambd=lambd, k=k) for _ in range(num_vars)]
plot_histogram(random_vars, 'Эрланговская СВ')
print(f"фкт МО        : {np.mean(random_vars)}")
print(f"фкт дисперсия : {np.var(random_vars)}\n")
print(f"эмп МО       : {k / lambd}")
print(f"эмп дисперсия: {k / (lambd**2)}\n")

print("Нормальная СВ")
mu = 0
sigma = 1
random_vars = [normal_random_variable(
    fib_gen.next(), fib_gen.next(), mu, sigma) for _ in range(num_vars)]
plot_histogram(random_vars, 'Нормальная СВ')
print(f"фкт МО        : {np.mean(random_vars)}")
print(f"фкт дисперсия : {np.var(random_vars)}\n")
print(f"эмп МО       : {mu}")
print(f"эмп дисперсия: {sigma**2}\n")


print("Гамма-распределение")
shape = 2
scale = 1
random_vars = [erlang_random_variable(
    fib_gen, lambd=shape, k=shape) for _ in range(num_vars)]
plot_histogram(random_vars, 'Гамма-распределение')
print(f"фкт МО        : {np.mean(random_vars)}")
print(f"фкт дисперсия : {np.var(random_vars)}\n")
print(f"эмп МО       : {shape * scale}")
print(f"эмп дисперсия: {shape * scale ** 2}\n")



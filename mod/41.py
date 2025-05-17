import random
import numpy as np
import matplotlib.pyplot as plt

class PeakGenerator:
    def __init__(self, seed=None):
        self.A = [random.randint(0, 2**32 - 1) for _ in range(55)]
        self.B = [random.randint(0, 2**32 - 1) for _ in range(57)]
        self.C = [random.randint(0, 2**32 - 1) for _ in range(58)]
        self.index_A = 0
        self.index_B = 0
        self.index_C = 0

    def peak(self):
        while True:
            self.A[self.index_A] = (
                self.A[(self.index_A - 55) % 55] + self.A[(self.index_A - 24) % 55]) % (2**32)
            self.B[self.index_B] = (
                self.B[(self.index_B - 57) % 57] + self.B[(self.index_B - 7) % 57]) % (2**32)
            self.C[self.index_C] = (
                self.C[(self.index_C - 58) % 58] + self.C[(self.index_C - 19) % 58]) % (2**32)
            
            
            carry_A = self.A[self.index_A] >> 31
            carry_B = self.B[self.index_B] >> 31
            carry_C = self.C[self.index_C] >> 31
            
            
            if carry_A == carry_B == carry_C:
                yield self.A[self.index_A] / (2 ** 32), self.B[self.index_B] / (2 ** 32), self.C[self.index_C] / (2 ** 32)
            elif carry_A == carry_B:
                yield self.A[self.index_A] / (2 ** 32), self.B[self.index_B] / (2 ** 32), self.C[self.index_C] / (2 ** 32)
            elif carry_A == carry_C:
                yield self.A[self.index_A] / (2 ** 32), self.B[self.index_B] / (2 ** 32), self.C[self.index_C] / (2 ** 32)
            elif carry_B == carry_C:
                yield self.A[self.index_A] / (2 ** 32), self.B[self.index_B] / (2 ** 32), self.C[self.index_C] / (2 ** 32)
            
            self.index_A = (self.index_A + 1) % 55
            self.index_B = (self.index_B + 1) % 57
            self.index_C = (self.index_C + 1) % 58

class DiscreteRandomVariable:
    def __init__(self, x_values, probabilities):
        self.x_values = x_values
        self.probabilities = probabilities
        self.cumulative_probabilities = np.cumsum(probabilities)
        
    def generate(self):
        rand = np.random.random()
        for i, p in enumerate(self.cumulative_probabilities):
            if rand < p:
                return self.x_values[i]
                
    def mean(self):
        return np.sum(np.array(self.x_values) * np.array(self.probabilities))
    
    def variance(self):
        mean = self.mean()
        return np.sum([p * x ** 2 for x, p in zip(self.x_values, self.probabilities)]) - mean ** 2

# Данные
x_values = [-21.4, 4.6, 17.1, 20.1, 37.1, 39.1, 93.4]
probabilities = [0.137, 0.098, 0.065, 0.240, 0.258, 0.108, 0.094]

# Создание дискретной случайной величины
drv = DiscreteRandomVariable(x_values, probabilities)

# Создание генератора пиков
peak_gen = PeakGenerator()

# Шаг 1: Генерация 500 образцов с учетом пиков
sample_size = 500
sample = []
for _ in range(sample_size):
    peak_values = next(peak_gen.peak())
    sample.append(drv.generate() + sum(peak_values))

first_30_values = [drv.generate() for _ in range(30)]
print("Первые 30 значений xi:", first_30_values)
# Шаг 2: Расчет эмпирического среднего и дисперсии
empirical_mean = np.mean(sample)
empirical_variance = np.var(sample)

# Шаг 4: Расчет теоретических вероятностей
theoretical_probabilities = [probabilities[i] / (x_values[i + 1] - x_values[i]) for i in range(len(x_values) - 1)]
theoretical_probabilities.append(probabilities[-1] / (x_values[-1] - x_values[-2]))  
theoretical_x_values = [(x_values[i] + x_values[i + 1]) / 2 for i in range(len(x_values) - 1)]
theoretical_x_values.append(x_values[-1]) 

plt.figure(figsize=(14, 6))

plt.subplot(1, 2, 1)
plt.hist(sample, bins=7, density=True, alpha=0.7, color='blue', edgecolor='black', label='Эмпирическое')
plt.title('Эмпирическое распределение')
plt.xlabel('Значение')
plt.ylabel('Плотность вероятности')
plt.grid(True, linestyle='--', alpha=0.5)
plt.legend()

plt.subplot(1, 2, 2)
plt.hist(x_values, bins=7, density=True, alpha=0.7, color='red', edgecolor='black', label='Теоретическое')
plt.title('Теоретическое распределение')
plt.xlabel('Значение')
plt.ylabel('Частота')
plt.grid(True, linestyle='--', alpha=0.5)
plt.legend()


plt.tight_layout()
plt.show()

# Шаг 5: Сравнение эмпирического и теоретического распределений

print("Эмпирическое М:", empirical_mean)
print("Эмпирическая дисперсия:", empirical_variance)
print("Теоретическое М:", drv.mean())
print("Теоретическая дисперсия:", drv.variance())


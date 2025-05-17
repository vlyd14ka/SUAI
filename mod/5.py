from math import factorial
import copy

class QTransition:
    def __init__(self, system_id, probability):
        self.system_id = system_id
        self.probability = probability

class QSystem:
    def __init__(self, channels, service_time, requests_in_second, type):
        self.channels = channels
        self.service_time = service_time
        self.requests_in_second = requests_in_second
        self.type = type
        self.lambd = 0
        self.p = 0
        self.p0 = 0
        self.L = 0
        self.M = 0
        self.Twait = 0
        self.Texist = 0
        self.transitions = []

    def add_transition(self, index, p):
        self.transitions.append(QTransition(index, p))

    def calculate_load_ratio(self):
        self.p = self.lambd * self.service_time / self.channels

    def calculate_stationary_probability(self):
        arg1 = (self.lambd * self.service_time) ** self.channels / \
               (factorial(self.channels) * (1 - self.lambd * self.service_time / self.channels))
        arg2 = sum([(self.lambd * self.service_time) ** m / factorial(m) for m in range(self.channels)])
        self.p0 = 1 / (arg1 + arg2)

    def calculate_queue_length(self):
        arg1 = (self.lambd * self.service_time) ** (self.channels + 1)
        arg2 = factorial(self.channels) * self.channels * (1 - self.lambd * self.service_time / self.channels) ** 2
        self.L = self.p0 * (arg1 / arg2)

    def calculate_request_amount(self):
        self.M = self.L + self.channels * self.p

    def calculate_waiting_time(self):
        self.Twait = self.L / self.lambd

    def calculate_existence_time(self):
        self.Texist = self.Twait + self.service_time

    def clone(self):
        return copy.deepcopy(self)

class QNetwork:
    def __init__(self, systems):
        self.systems = systems
        self.transition_matrix = self.transition_matrix_build(systems)
        self.L = 0
        self.M = 0
        self.Twait = 0
        self.Texist = 0
        self.D = []

        self.init_system_output_params()
        self.find_queue_length()
        self.find_request_amount()
        self.find_waiting_time()
        self.find_existence_time()
        self.find_capacity_reserves()

    def find_capacity_reserves(self):
        for system in self.systems:
            if system.type == "Entrance":
                denominator = 1 / system.requests_in_second
                is_limit = False
                while not is_limit:
                    denominator -= 1
                    max_requests = 1 / denominator

                    test_systems = [system.clone() for system in self.systems]
                    for test_system in test_systems:
                        test_system.lambd = 0
                        test_system.p = 0
                    for i, test_system in enumerate(test_systems):
                        if test_system.type == "Entrance":
                            test_system.lambd = max_requests
                        for transition in test_system.transitions:
                            test_systems[transition.system_id].lambd += \
                                test_system.lambd * self.transition_matrix[i][transition.system_id]
                    for test_system in test_systems:
                        test_system.calculate_load_ratio()
                        if test_system.p > 1:
                            is_limit = True
                            break
                denominator += 1
                self.D.append((1 / denominator) - system.requests_in_second)

    def find_queue_length(self):
        self.L = sum(system.L for system in self.systems)

    def find_request_amount(self):
        self.M = sum(system.M for system in self.systems)

    def find_waiting_time(self):
        self.Twait = sum(system.lambd * system.Twait for system in self.systems) / self.systems[0].requests_in_second

    def find_existence_time(self):
        self.Texist = sum(system.lambd * system.Texist for system in self.systems) / self.systems[0].requests_in_second

    def init_system_output_params(self):
        for i, system in enumerate(self.systems):
            if system.type == "Entrance":
                system.lambd = system.requests_in_second
            for transition in system.transitions:
                self.systems[transition.system_id].lambd += \
                    system.lambd * self.transition_matrix[i][transition.system_id]
        for system in self.systems:
            system.calculate_load_ratio()
            system.calculate_stationary_probability()
            system.calculate_queue_length()
            system.calculate_request_amount()
            system.calculate_waiting_time()
            system.calculate_existence_time()

    @staticmethod
    def transition_matrix_build(systems):
        transition_matrix = []
        for system in systems:
            transition_row = [0] * (len(systems) + 1)
            probability_sum = 0
            for transition in system.transitions:
                probability_sum += transition.probability
                transition_row[transition.system_id] = transition.probability
            if system.type == "Exit":
                transition_row[len(systems)] = 1 - probability_sum
            transition_matrix.append(transition_row)
        return transition_matrix

    def print_output(self):
        print("Локальные характеристики:")
        for i, system in enumerate(self.systems):
            print(f"\n\tСистема {i + 1}:")
            print(f"\t\tp = {system.p}")
            print(f"\t\tL = {system.L}")
            print(f"\t\tTож = {system.Twait}")
            print(f"\t\tTпреб = {system.Texist}")
            print(f"\t\tM = {system.M}")
        print("\n\nГлобальные характеристики:\n")
        print(f"\tTож = {self.Twait}")
        print(f"\tL = {self.L}")
        print(f"\tTпреб = {self.Texist}")
        print(f"\tM = {self.M}")
       

def main():
    system1 = QSystem(4, 280, 0.0125, "Entrance")
    system2 = QSystem(1, 54, 0, "Intermediate")
    system3 = QSystem(3, 120, 0, "Exit")
    
    system1.add_transition(1, 1)
    system2.add_transition(2, 1)
    
    systems = [system1, system2, system3]
    q_network = QNetwork(systems)
    q_network.print_output()

if __name__ == "__main__":
    main()

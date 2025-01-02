import numpy as np

print("Enter the no.of buses:")
n = int(input())  # Get the number of buses from the user
# Initialize the admittance matrix with zeros
Ybus = np.array([[0+0j for i in range(n)] for j in range(n)])
# A Placeholder matrix
y = np.zeros((n,n),dtype=complex)

def get_input(choice,n):
    """
    Gets the input from the user based on the choice of impedance or
    admittance , calculates admittance values and returns them

    Args:
        choice(int) : the choice of the user(1 for impedance and 2 for admittance)
        n(int) : Total no.of buses in the system

    Returns:
        y(np.array) : Line Admittance matrix
    """
    ## Case 1: if the user knows impedance(Z) value
    if choice == 1:
        # Calculate Admittance
        for i in range(n):
            for j in range(n):
                print("Enter the impedance between bus", i+1, "and", j+1, ":")
                yij = complex(input())
                y[i][j] = 1/yij
    elif choice == 2:
        # Take Admittance as input
        for i in range(n):
            for j in range(n):
                print("Enter the admittance between bus", i+1, "and", j+1, ":")
                y[i][j] = complex(input())
    return y
    
def calculate_admittance_matrix(y):
    """
    Forms admittance matrix using the admittance value matrix y

    Args:
        y(np.array): Line Admittance Matrix
    
    Returns:
        Ybus(np.array) : Bus Admittance Matrix
    """
    # Form Bus Admittance Matrix
    for i in range(n):
        for j in range(n):
            if i == j: # Diagonal elements
                for k in range(n):
                    Ybus[i][j] = Ybus[i][j] + y[i][k]
            else:
                Ybus[i][j] = -y[i][j]
    return Ybus

def print_admittance_matrix(Ybus):
    """
    Prints the bus admittance matrix to the console.

    Args:
        Ybus (np.array): Bus admittance matrix.
    """
    print('Bus Admittance Matrix:')
    for row in Ybus:
        for element in row:
            print(f"{element.real:+0.02f} {element.imag:+0.02f}j", end="  ")
        print()

# Calculate and print the admittance matrix
print("Enter 1 for impedance and 2 for admittance")
choice = int(input())  # Get the choice of input type (impedance or admittance)
y = get_input(choice,n)
Ybus = calculate_admittance_matrix(y)
print_admittance_matrix(Ybus)

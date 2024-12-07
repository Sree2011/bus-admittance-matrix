%% @brief Defines the line data matrix with columns: bus1, bus2, Resistance (pu), Reactance (pu)
%% 
%% The line data matrix contains information about the lines in the power system network. 
%% Each row represents a line with the following columns:
%% 1. Starting bus number
%% 2. Ending bus number
%% 3. Resistance in per unit (pu)
%% 4. Reactance in per unit (pu)
zdata = [
    1   2   0.02  0.06;
    1   3   0.08  0.24;
    2   3   0.06  0.25;
    2   4   0.06  0.18;
    2   5   0.04  0.12;
    3   4   0.01  0.03;
    4   5   0.08  0.24;
];

%% Extract line data
nbr = size(zdata, 1);  % Number of branches
nl = zdata(:, 1);  % From bus number
nr = zdata(:, 2);  % To bus number
R = zdata(:, 3);  % Resistance
X = zdata(:, 4);  % Reactance
nbus = max(max(nl), max(nr));  % Number of buses

%% Calculate admittance values
Z = R + 1j * X;  % Impedance matrix
y = 1 ./ Z;  % Admittance matrix

%% Initialize the bus admittance matrix
Ybus = zeros(nbus, nbus);

%% Create the bus admittance matrix function
function YBUS = create_admittance_matrix(nl, nr, nbr, nbus, y)
    Ybus = zeros(nbus, nbus);  % Initialize inside the function
    for k = 1:nbr
        if nl(k) > 0 && nr(k) > 0
            Ybus(nl(k), nr(k)) = Ybus(nl(k), nr(k)) - y(k);
            Ybus(nr(k), nl(k)) = Ybus(nl(k), nr(k));
        end
    end
    
    for n = 1:nbus
        for k = 1:nbr
            if nl(k) == n || nr(k) == n
                Ybus(n, n) = Ybus(n, n) + y(k);
            end
        end
    end
    YBUS = Ybus;  % Ensure it returns the updated matrix
end

%% Display the bus admittance matrix function
function display_admittance_matrix(Ybus, nbus)
    disp('Bus Admittance Matrix:')
    for i = 1:nbus
        for j = 1:nbus
            fprintf('%.2f + %.2fj  ', real(Ybus(i, j)), imag(Ybus(i, j)));
        end
        fprintf('\n');
    end
end

%% Call the functions to create and display the matrix
YBUS = create_admittance_matrix(nl, nr, nbr, nbus, y);
display_admittance_matrix(YBUS, nbus);

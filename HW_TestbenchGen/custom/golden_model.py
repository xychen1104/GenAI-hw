def saturating_adder4_golden(a, b):
    # Ensure inputs are within 4-bit unsigned range
    assert 0 <= a <= 15, "Input 'a' must be a 4-bit unsigned integer"
    assert 0 <= b <= 15, "Input 'b' must be a 4-bit unsigned integer"
    
    # Compute the sum
    sum_ab = a + b
    
    # Saturate the result to 4 bits
    if sum_ab > 15:
        y = 15
    else:
        y = sum_ab
    
    # Return the result as a dictionary
    return {'y': y}

# Example test cases
test_cases = [
    (0, 0), (15, 0), (15, 15), (7, 8), (8, 8),
    (1, 14), (2, 13), (3, 12), (4, 11), (5, 10),
    (6, 9), (9, 6), (10, 5), (11, 4), (12, 3),
    (13, 2), (14, 1), (0, 15), (7, 7), (8, 7)
]

# Running test cases
for a, b in test_cases:
    result = saturating_adder4_golden(a, b)
    print(f"saturating_adder4_golden({a}, {b}) = {result}")
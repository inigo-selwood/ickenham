# Instructions

## Sections

1. [System](#system)
2. [Control](#control)
3. [Memory](#memory)
4. [Integer](#integer)
5. [Logical](#logical)
6. [Bitwise](#bitwise)
7. [Real](#real)

## System

### Skip `00`

Does nothing

### Reset `01`

Soft-resets the CPU

- Zeroes all registers
- Resets the MMU
- Clears the cache
- Flushes the pipeline

## Control

### Jump `10`

Jumps to the address `base + offset`

- Optionally stores the current address in a target register.

Index | Alias  | Type      | Description
------|--------|-----------|---
0     | target | reg       | Previous address stored here
1     | -      | -         | -
2     | base   | reg/const | Address base
3     | offset | reg/const | Address offset

### Jump (Conditional) `11`

Jumps to the address `base + offset` if a given `test` register is non-zero

- Optionally stores the current address in a target register.

Index | Alias  | Type      | Description
------|--------|-----------|---
0     | target | reg       | Previous address stored here
1     | test   | reg       | Test register; jump performed if non-zero
2     | base   | reg/const | Address base
3     | offset | reg/const | Address offset

## Memory

### Load (32-bit) `20`

Loads a 32-bit value from memory into a register

Index | Alias  | Type      | Description
------|--------|-----------|---
0     | target | reg       | Value stored here
1     | -      | -         | -
2     | base   | reg/const | Address base
3     | offset | reg/const | Address offset

### Store (32-bit) `21`

Stores a 32-bit register's value in memory

Index | Alias  | Type      | Description
------|--------|-----------|---
0     | -      | -         | -
1     | value  | reg/const | Value to store
2     | base   | reg/const | Address base
3     | offset | reg/const | Address offset

## Integer

### Add `30`

Adds two signed 32-bit values (`left + right`), storing the result in `target`

Index | Alias    | Type      | Description
------|----------|-----------|---
0     | target   | reg       | Result stored here
1     | -        | -         | -
2     | left     | reg/const | Left operand
3     | right    | reg/const | Right operand

### Subtract `31`

Subtracts one signed 32-bit value from another (`left - right`), storing the result in `target`

Index | Alias    | Type      | Description
------|----------|-----------|---
0     | target   | reg       | Result stored here
1     | -        | -         | -
2     | left     | reg/const | Left operand
3     | right    | reg/const | Right operand

### Multiply `32`

Multiplies two signed 32-bit values (`left * right`), storing the result as two word halves in registers `lower` and `upper`

- The 2's complement result spans across both `lower` and `upper`, meaning the sign bit will be `upper[31]`
- If `upper` is `zero`, the 2's complement result is confined to `lower`, meaning the sign bit will be `lower[31]`

Index | Alias    | Type      | Description
------|----------|-----------|---
0     | lower    | reg       | Lower result word (`[31:0]`) stored here
1     | upper    | reg       | Upper result word (`[63:32]`) stored here
2     | left     | reg/const | Left operand
3     | right    | reg/const | Right operand

### Divide `33`

Divides one signed 32-bit value by another (`left / right`), storing the results in the `quotient` and `remainder` registers.

- Neither or just one of the `quotient` and `remainder` registers can be discarded by passing `zero`

Index | Alias     | Type      | Description
------|-----------|-----------|---
0     | quotient  | reg       | Quotient (`left / right`)
1     | remainder | reg       | Remainder (`left % right`)
2     | left      | reg/const | Left operand
3     | right     | reg/const | Right operand

### Less Than `34`

Checks whether one signed 32-bit value is less than another (`left < right`)

Index | Alias     | Type      | Description
------|-----------|-----------|---
0     | target    | reg       | Result stored here
1     | -         | -         | -
2     | left      | reg/const | Left operand
3     | right     | reg/const | Right operand

### More Than `35`

Checks whether one signed 32-bit value is greater than another (`left > right`)

Index | Alias     | Type      | Description
------|-----------|-----------|---
0     | target    | reg       | Result stored here
1     | -         | -         | -
2     | left      | reg/const | Left operand
3     | right     | reg/const | Right operand

### Less Than or Equal To `36`

Checks whether one signed 32-bit value is less than (or equal to) another (`left <= right`)

Index | Alias     | Type      | Description
------|-----------|-----------|---
0     | target    | reg       | Result stored here
1     | -         | -         | -
2     | left      | reg/const | Left operand
3     | right     | reg/const | Right operand

### More Than or Equal To `37`

Checks whether one signed 32-bit value is greater than (or equal to) another (`left >= right`)

Index | Alias     | Type      | Description
------|-----------|-----------|---
0     | target    | reg       | Result stored here
1     | -         | -         | -
2     | left      | reg/const | Left operand
3     | right     | reg/const | Right operand

## Logical

### And `40`

Takes the logical AND of two values (`left && right`)

Index | Alias     | Type      | Description
------|-----------|-----------|---
0     | target    | reg       | Result stored here
1     | -         | -         | -
2     | left      | reg/const | Left operand
3     | right     | reg/const | Right operand

### Or `41`

Takes the logical OR of two values (`left && right`)

Index | Alias     | Type      | Description
------|-----------|-----------|---
0     | target    | reg       | Result stored here
1     | -         | -         | -
2     | left      | reg/const | Left operand
3     | right     | reg/const | Right operand

### Not `42`

Takes the logical NOT of a value (`!value`)

Index | Alias  | Type | Description
------|--------|------|---
0     | target | reg  | Result stored here
1     | -      | -    | -
2     | value  | reg  | Value to negate
3     | -      | -    | -

## Bitwise

### And `50`

Takes the bitwise AND of two values (`left & right`)

Index | Alias     | Type      | Description
------|-----------|-----------|---
0     | target    | reg       | Result stored here
1     | -         | -         | -
2     | left      | reg/const | Left operand
3     | right     | reg/const | Right operand

### Or `51`

Takes the bitwise OR of two values (`left | right`)

Index | Alias     | Type      | Description
------|-----------|-----------|---
0     | target    | reg       | Result stored here
1     | -         | -         | -
2     | left      | reg/const | Left operand
3     | right     | reg/const | Right operand

### Exclusive Or `52`

Takes the bitwise exclusive OR of two values (`left ^ right`)

Index | Alias     | Type      | Description
------|-----------|-----------|---
0     | target    | reg       | Result stored here
1     | -         | -         | -
2     | left      | reg/const | Left operand
3     | right     | reg/const | Right operand

### Not `53`

Takes the bitwise NOT of two values (`~value`)

Index | Alias  | Type | Description
------|--------|------|---
0     | target | reg  | Result stored here
1     | -      | -    | -
2     | value  | reg  | Value to negate
3     | -      | -    | -

### Shift Left `54`

Bitwise shifts a value left by a certain number of steps. 

- If an `overflow` register is specified, any bits which shift past the width of the 32-bit result are placed there

Index | Alias    | Type      | Description
------|----------|-----------|---
0     | target   | reg       | Result stored here
1     | overflow | reg       | Overflow bits stored here
2     | value    | reg/const | Value to shift
3     | steps    | reg/const | Number of steps to shift by

### Shift Right (Logical) `55`

Bitwise shifts a value right by a certain number of steps. 

Index | Alias  | Type      | Description
------|--------|-----------|---
0     | target | reg       | Result stored here
1     | -      | -         | -
2     | value  | reg/const | Value to shift
3     | steps  | reg/const | Number of steps to shift by

### Shift Right (Arithmetic) `56`

Bitwise shifts a value right by a certain number of steps. 

- Arithmetic shifts preserve the sign of the result by shifting in ones 

Index | Alias  | Type      | Description
------|--------|-----------|---
0     | target | reg       | Result stored here
1     | -      | -         | -
2     | value  | reg/const | Value to shift
3     | steps  | reg/const | Number of steps to shift by

### Equal `57`

Checks whether two values are bitwise-equal (`left == right`)

Index | Alias     | Type      | Description
------|-----------|-----------|---
0     | target    | reg       | Result stored here
1     | -         | -         | -
2     | left      | reg/const | Left operand
3     | right     | reg/const | Right operand

### Not Equal `58`

Checks whether two values are bitwise-equal (`left != right`)

Index | Alias     | Type      | Description
------|-----------|-----------|---
0     | target    | reg       | Result stored here
1     | -         | -         | -
2     | left      | reg/const | Left operand
3     | right     | reg/const | Right operand

## Real

Real operands are 32-bit IEEE single-precision floating-point values

### Add `60`

Adds two single-precision floating-point values (`left + right`), storing the result in `target`

Index | Alias    | Type      | Description
------|----------|-----------|---
0     | target   | reg       | Result stored here
1     | -        | -         | -
2     | left     | reg/const | Left operand
3     | right    | reg/const | Right operand

### Subtract `61`

Subtracts one single-precision floating-point value from another (`left - right`), storing the result in `target`

Index | Alias    | Type      | Description
------|----------|-----------|---
0     | target   | reg       | Result stored here
1     | -        | -         | -
2     | left     | reg/const | Left operand
3     | right    | reg/const | Right operand

### Multiply `62`

Multiplies two single-precision floating-point values together (`left * right`), storing the result in `target`

Index | Alias    | Type      | Description
------|----------|-----------|---
0     | target   | reg       | Result stored here
1     | -        | -         | -
2     | left     | reg/const | Left operand
3     | right    | reg/const | Right operand

### Divide `63`

Divides one single-precision floating-point value by another (`left / right`), storing the result in `target`

Index | Alias    | Type      | Description
------|----------|-----------|---
0     | target   | reg       | Result stored here
1     | -        | -         | -
2     | left     | reg/const | Left operand
3     | right    | reg/const | Right operand

### Less Than `64`

Checks whether one single-precision floating-point value is less than another (`left < right`), storing the result in `target`

Index | Alias    | Type      | Description
------|----------|-----------|---
0     | target   | reg       | Result stored here
1     | -        | -         | -
2     | left     | reg/const | Left operand
3     | right    | reg/const | Right operand

### More Than `65`

Checks whether one single-precision floating-point value is greater than another (`left > right`), storing the result in `target`

Index | Alias    | Type      | Description
------|----------|-----------|---
0     | target   | reg       | Result stored here
1     | -        | -         | -
2     | left     | reg/const | Left operand
3     | right    | reg/const | Right operand

### Less Than or Equal `66`

Checks whether one single-precision floating-point value is less than (or equal to) another (`left <= right`), storing the result in `target`

Index | Alias    | Type      | Description
------|----------|-----------|---
0     | target   | reg       | Result stored here
1     | -        | -         | -
2     | left     | reg/const | Left operand
3     | right    | reg/const | Right operand

### More Than or Equal `67`

Checks whether one single-precision floating-point value is greater than (or equal to) another (`left >= right`), storing the result in `target`

Index | Alias    | Type      | Description
------|----------|-----------|---
0     | target   | reg       | Result stored here
1     | -        | -         | -
2     | left     | reg/const | Left operand
3     | right    | reg/const | Right operand

### Equal `68`

Checks whether one single-precision floating-point value is equal to another (`left == right`), storing the result in `target`

- Equality is evaluated with the single-precision epsilon value `5.96e-08`

Index | Alias    | Type      | Description
------|----------|-----------|---
0     | target   | reg       | Result stored here
1     | -        | -         | -
2     | left     | reg/const | Left operand
3     | right    | reg/const | Right operand

### Not Equal `69`

Checks whether one single-precision floating-point value is not equal to another (`left != right`), storing the result in `target`

- Equality is evaluated with the single-precision epsilon value `5.96e-08`

Index | Alias    | Type      | Description
------|----------|-----------|---
0     | target   | reg       | Result stored here
1     | -        | -         | -
2     | left     | reg/const | Left operand
3     | right    | reg/const | Right operand
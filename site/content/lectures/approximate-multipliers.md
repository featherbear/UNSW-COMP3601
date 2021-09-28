+++
date = 2021-09-28T06:17:50Z
draft = true
hiddenFromHomePage = false
postMetaInFooter = false
title = "Approximate Multipliers"
[flowchartDiagrams]
enable = false
options = ""
[sequenceDiagrams]
enable = false
options = ""

+++
# Review of Addition Arithmetic In Computers

### e.g. Binary addition of two single bits

We can use a half adder circuit

![](/uploads/20210928-snipaste_2021-09-28_16-20-45.jpg)

![](/uploads/20210928-snipaste_2021-09-28_16-20-49.jpg)

![](/uploads/20210928-snipaste_2021-09-28_16-20-15.jpg)

### e.g. Binary addition of three single bits

Full adder circuit

![](/uploads/20210928-snipaste_2021-09-28_16-21-47.jpg)

### e.g. Addition of N-bit numbers

We can chain full-adder circuits together

![](/uploads/20210928-snipaste_2021-09-28_16-22-44.jpg)

* Logic Area = (N-1) FA + 1 HA
* Delay: Delay of (N-1) FA + Delay of HA

## Potential Issues

**Logic Area (Space, Power)**  
Number of gates/logic elements.  
In an FPGA, logic elements are our configurable logic blocks (CLBs) such as the Lookup Tables (LUTs)

**Speed**  
i.e critical path delay

## Optimised Designs

### Carry Look-Ahead Adder

Improves the critical path, but requires a larger logic area

### Bit Serial Adder

Smaller area and critical path, but requires multiple cycles  
The input comes in one bit per cycle

# Review of Multiplication Arithmetic in Computers

![](/uploads/20210928-snipaste_2021-09-28_16-30-49.jpg)

With binary multiplication, since the unit values can only be 0 or 1, multiplication is simply just an `AND` operation

![](/uploads/20210928-snipaste_2021-09-28_16-32-18.jpg)

![](/uploads/20210928-snipaste_2021-09-28_16-32-26.jpg)

This multiplication just becomes a combination of `AND` and `n`-bit adder circuits.

* Logic Area Complexity - O(N^2)
* Delay Complexity - O(N^2)

### Optimisations

* Wallace Tree Reduction
* Dadda Tree Reduction

# Approximate Multipliers

There are different variations of adder and multiplier circuits, each which use have different logic area and delay complexities.  
The previous example circuits can be classified as "exact circuits" - where their produced output is exactly the result of the input operation.

**However sometimes we do not particularly need an exact output (would be ideal though).** We can instead implement an approximate multiplier, which can possibly decrease the circuit complexity.

> Aside | Error Resiliency - _Some algorithms are inherently error resilient, and are often used to treat or suppress noisy input - mitigating the effect of errors on the output result_

### Example (Approximate Adder)

Consider the case of a 6-bit adder circuit where the lower 3 bits were disconnected.  
An error would be introduced if the last 3 bits had any data, however for any addition of two values > 2^3, there would be no error.  
This approximation change halves the required time to compute.

For additions of large numbers, the lower bits are not very significant (i.e. LSB) and do not dramatically affect the output

![](/uploads/20210928-snipaste_2021-09-28_16-48-19.jpg)
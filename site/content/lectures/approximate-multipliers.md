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
# Basic Arithmetic In Computers

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

# Approximate Multipliers
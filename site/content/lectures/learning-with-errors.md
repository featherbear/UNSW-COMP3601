+++
date = 2021-09-14T02:39:43Z
draft = true
hiddenFromHomePage = false
postMetaInFooter = false
title = "Learning With Errors | Quantum Cryptography"
[flowchartDiagrams]
enable = false
options = ""
[sequenceDiagrams]
enable = false
options = ""

+++
# Quantum Cryptography

* Cryptography uses complex/hard to reverse calculations to encrypt data
  * For example ECC (Elliptic Curve Cryptography) and AES (Advanced Encryption Standard)
* As quantum computers can process calculations simultaneously, it is possible for some algorithms to become easily crackable (within reasonable time)

## Symmetric vs Asymmetric Key Cryptograhy

### Symmetric Key Crypto

* A shared key K_s is used

### Asymmetric Key Crypto

* Two keys are used
  * Public key K_pub
  * Private key K_priv

## Analysis of AES-128 (Advanced Encryption Standard)

To brute force AES, we need to brute force a 128 bit key (3.4e38)...

Common computing may take 60 billion years to crack  
Quantum computing may take 6 months to crack

## Analysis of RSA-1024

To brute force RSA, we need to brute force a 1024 bit key (1.9e302)

Quantum computing can crack RSA-1024 in 3.58 hours  
Quantum computing can crack RSA-2048 in 28.6 hours

***

Is symmetric more secure?

> Grover's Algorithm - The brute force attack time is roughly its square root of its key length. 

***

# Learning with Errors

TODO: STUFF HERE

## Key Generation

**A** generates a message, and generates 

TODO: STUFF HERE

* **B** receives `u` and `v`
* Calculates `D = (v-u.s) mod q`
  * If `D < q/2` then message is 0
  * If `D > q/2`   then message is 1

### Example

![](uploads/20210914-snipaste_2021-09-14_13-05-45.png)  
![](uploads/20210914-snipaste_2021-09-14_13-06-37.jpg)  
![](uploads/20210914-snipaste_2021-09-14_13-07-49.jpg)

#### If M=0

![](uploads/20210914-snipaste_2021-09-14_13-08-47.jpg)

#### If there is no error

If there is no error vector, the other party D will be exactly `q/2` or exactly `0`.

***

## Ring LWE

Ring LWE is inefficient because we need to store A, which consumes significant memory and matrix multiplications.

![](uploads/20210914-snipaste_2021-09-14_13-13-14.jpg)  
256KB needed to encrypt just a few bits!?!?

> What if we use a polynomial X?

* Multiplication in a polynomial ring `Zq[X] / (X^n + 1)`
* Only need to send X, and can use FFT to speed up the calculation
* Only takes 1-2KB then!

## Homomorphic Computing

> The ability to perform operations on encrypted data

Typically `enc(x1) + enc(x2) != enc(x1 + x2)`

This is quite hard because of the avalanche effect, where a small change in the input should cause a large change in the encrypted output bits
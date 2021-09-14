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
# Learning With Errors | Quantum Cryptography

* Cryptography uses complex/hard to reverse calculations to encrypt data
  * For example ECC (Elliptic Curve Cryptography) and AES (Advanced Encryption Standard)
* As quantum computers can process calculations simultaneously, it is possible for some algorithms to become easily crackable (within reasonable time)

## Symmetric vs Asymmetric Key Cryptograhy

### Symmetric Key Crypto

* A shared key $K_s$ is used

### Asymmetric Key Crypto

* Two keys are used
  * Public key $K_pub$
  * Private key $K_priv$

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
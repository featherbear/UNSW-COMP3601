+++
date = 2021-10-17T12:06:00Z
draft = true
hiddenFromHomePage = false
postMetaInFooter = false
title = "Initial Design Report"
[flowchartDiagrams]
enable = false
options = ""
[sequenceDiagrams]
enable = false
options = ""

+++
![](/uploads/20211027-image29.jpg)

Initial Design Report

<u>Team Orange</u>

Ziyue Lian – z5224346  
Andrew Nicholson – z5255137  
Arpit Singh Rulania – z5238561  
Andrew Wong – z5206677  
  
School of Computer Science and Engineering  
COMP3601 – Design Project A  
2021 Session Three

***

# **1. Introduction**

The Learning With Errors (LWE) method is a quantum-robust cryptographic algorithm that aims to address the area of confidentiality of the CIA model during data transmission. With the utilisation of an asymmetric key pair, contents of the encrypted data is only accessible by a single party (the owner of the private key). Through the implementation of an error vector into the procedure, strong cryptographic protection against quantum-enabled computation is achieved. This project aims to implement the LWE algorithm onto an Kintex-7 FPGA board that is able to successfully encrypt and decrypt messages strings.

***

# **2. MATLAB Model**

An implementation of LWE was developed in MATLAB, to create a model that could be used to explore the rudiments of how LWE functions. This model could then be ported onto the Kintex-7 board, where the ported implementation can be tested against the MATLAB model for correctness and porting accuracy.

A test suite was developed to verify the correctness of the MATLAB model, where the key generation, encryption and decryption were repeated for a large number of iterations. Each test run was designed to execute independently - with the private key, public key, error vector, and sampled public key values all being generated on the fly. Furthermore each test suite was repeated for both M=0 and M=1 cases.

![](/uploads/20211027-image27.png)

<figcaption>Figure 2.1 - Histogram of decrypted D-values with valid private key S. Orange indicates an incorrect decryption</figcaption>

For the parameter set \[m=4, n=12, q=23\] a sample size of one hundred thousand (100,000) tests provided a successful decryption accuracy of 99.85% (roughly 150 samples failed) for both message bits M=0 and M=1. Figure 2.1 demonstrates that successfully decrypted M values will bias towards D=0 and D=q/2.

![](/uploads/20211027-image42.png)

<figcaption>Figure 2.2 - MATLAB output of a test script</figcaption>

An integration test was also performed given the same parameter set \[m=4, n=12, q=23\], where a combination of bits (to form the string "Hello, world!" were encrypted and decrypted ten thousand (10,000) times - each test generating their own private/public key pair. Results of the test revealed that 82.95% of the tests successfully decrypted each of the 104 bits, which is of reasonably high accuracy.   
(13 characters = 13 bytes = 13 × 8 bits = 104 bits)

![](/uploads/20211027-image16.png)
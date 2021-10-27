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

<figcaption>Figure 2.3 - Histogram of decrypted D-values with invalid private key S. Orange indicates an incorrect decryption</figcaption>

A test suite was also written to verify the requirements for an exact private key S to be required for successful decryption of an LWE-encrypted message. Given the same set \[m=4, n=12, q=23\], when the private key S was not explicitly known (i.e. the private key was altered by one single bit) a tested sample size of one hundred thousand (100,000) tests could not produce a relatively stable output M, where roughly 50% of decrypted D-values were invalid. This verifies the ability for LWE to only be decrypted successfully if the private key is explicitly known.

  
The LWE cryptographic algorithm has multiple input parameters - specifically the sizes \`m\` and \`n\`, as well as the modulo \`q\`. Additional tests were performed to best understand the impacts of each variable. Values \`m\`, \`n\` and \`q\` were individually modified one at a time to analyse the impact of the variable on the accuracy of decryption.

**<u>Modification of `m`</u>**

![](/uploads/20211027-image28.png)

<figcaption>Figure 2.4 - Success rate against incrementing values of m for both M=0 and M=1</figcaption>

As shown from Figure 2.4 above, given the parameter set \[n=12, q=23\], the variance of \`m\` had little to no effect towards the successful rate of decryption. It should be noted that subsequent tests (Figure 2.6.1 and Figure 2.6.2) performed after the completion of this test revealed the same inference.

**<u>Modification of `n`</u>**

![](/uploads/20211027-image26.png)

<figcaption>Figure 2.5.1 - Decreasing success rate for increasing values of n</figcaption>

Given the parameter set \[m=4, q=23\] it was found that the increasing values of \`n\` dropped the accuracy of a successful decryption (given a known private key). It was also noted that the time required to encrypt and decrypt a message bit was considerably longer with larger values of \`n\`, however no further quantitative testing was performed to analyse speed impacts. Both observations inferred that the value of \`n\` should stay small.

Later tests revealed that larger values of \`q\` were required to maintain the successful decryption accuracy for larger values of \`n\` (i.e. Figure 2.6.1 and Figure 2.7).

![](/uploads/20211027-image9.png)

<figcaption>Figure 2.5.2 - Large scale decreasing success rate for increasing values of n</figcaption>

**<u>Modification of `q`</u>**

![](/uploads/20211027-image33.png)

<figcaption>Figure 2.6.1 - Increasing decryption accuracy given an increasing q</figcaption>

![](/uploads/20211027-image36.png)

<figcaption>Figure 2.6.2 - Increasing decryption accuracy given an increasing q</figcaption>

Figure 2.6.1 and Figure 2.6.2 demonstrate the increase in successful decryptions given different values of \`q\` for the parameter set \[m=4/45, n=256\]. It can be inferred that large values of \`q\` are important to ensure the successful decryption of an encrypted message. A comparison between the two above figures indicate the minimal impact of \`m\` towards decryption accuracy.

![](/uploads/20211027-image3.png)

<figcaption>Figure 2.7 - Increasing decryption accuracy given an increasing q</figcaption>

When testing increasing values of q against the parameter set \[m=45, n=65\], a comparison between n=65 and n=256 (i.e. Comparing Figure 2.6.1 and 2.7) reveals that a higher rate of successful decryptions is achieved when \`n\` is minimal. Conversely, a larger value of \`n\` decreases the accuracy of successful decryptions, thus \`n\` should be restricted to a small value.

***

**<u>Discussion</u>**

After the testing and analysis of the decryption accuracy given variations of \`m\`, \`n\` and \`q\`, several findings were established which have helped shape the design decisions for the implementation of the model onto the Kintex-7 FPGA board.

It was noted that modifications to \`q\` were of the most impact (i.e. Figure 2.7), whereby increasing values of \`q\` greatly reduces the rate of unsuccessful message decryption given the private key. Hence the HDL implementation should utilise a relatively large value of \`q\` for optimal accuracy (albeit dependent on the combination of \`m\` and \`n\`)

Increases to the size \`n\` was detrimental (i.e. Figure 2.5.1) as the accuracy of successful decryption (given the correct private key) decreased with increasing values of \`n\`. Whilst the negative impact on accuracy for larger values of \`n\` could be mitigated with larger values of \`q\`, the overall speed of the encryption and decryption routine is adversely impacted from growing values of \`n\`. As the LWE mechanism functions on a "per-bit" basis (that is, the LWE routine must be performed 8__*__ times per byte) it is of importance that the HDL implementation must use a small value of \`n\` to operate in acceptable time.

> ___*___ _The ASCII character set (common printable characters) only occupies values 0-127, so each ASCII character can actually be represented as seven (7) bits instead of eight (8). However the time saved by having one less computation pales by an order of magnitude to the speed bottleneck of a large value of \`n\`_

As evident from the above figures, the modification of \`m\` does not have a significant impact on the accuracy (nor speed) of the LWE method, hence the value \`m\` can be selected relatively freely.

In conclusion, \`q\` should be maximised and \`n\` should be minimised to obtain optimal accuracy and speed for the LWE routine.

**<u>Future Work</u>**

The current MATLAB model incorporates an exact multiplier, whose computation time is slower when compared to an approximate multiplier. When the future MATLAB model that features an approximate multiplier in lieu of the exact multiplier is created, it will be worthwhile to perform timing tests to quantitatively compare the performance increase.

***
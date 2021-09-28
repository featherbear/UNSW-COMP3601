+++
date = 2021-09-16T16:02:12Z
hiddenFromHomePage = false
postMetaInFooter = false
title = "Research: Multiplication Algorithms"
[flowchartDiagrams]
enable = false
options = ""
[sequenceDiagrams]
enable = false
options = ""

+++
# Haha add numbers together

    fn(multiplicand, multiplier)
      product = 0
      for i from 1 to multiplier
        product = product + multiplicand
      return product

# Karatsuba's Fast Multiplication Algorithm

YouTube - https://www.youtube.com/watch?v=JCbZayFr9RE

![](/uploads/20210917-snipaste_2021-09-18_01-48-25.jpg)

```python3
def karatsuba(x,y):
    if x < 10 or y < 10:
        return x*y
    else:
        n = max(len(str(x)),len(str(y)))
        mid = int(n/2) 
        power = 10**mid

        a = x // power
        b = x % power
        c = y // power
        d = y % power

        print(a, b, c, d)

        ac = karatsuba(a,c)
        bd = karatsuba(b,d)

        acpbd = karatsuba(a+b,c+d) - ac - bd
        return ac*(power**2) + bd + (acpbd*power)
```

Complexity: ~N^1.58

Add and multiply out the factors


# Schönhage–Strassen Multiplication Algorithm

# Booth's Multiplication Algorithm




https://en.wikipedia.org/wiki/Multiplication_algorithm
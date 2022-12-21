# prime-hexagon

The Prime Hexagon is a simple mathematical structure that appears when integers are sequentially added to a field of tessellating equilateral triangles, provided the path of the integers is altered each time a prime number appears.

[![Inner Hexagon](https://user-images.githubusercontent.com/36441664/83331599-55cb5c00-a2c1-11ea-833e-b14dd79b5f2d.jpg)](https://eq19.github.io/scheme)

This code computes prime numbers, their positons in the prime hexagon, the polarity of the number, and the prime hexagon's overall rotation.
For more information go to hexspin.com.  Youtube:https://www.youtube.com/watch?v=fQL4KRH3wUQ

[![Prime Hexagon](https://user-images.githubusercontent.com/36441664/79077925-0213ac00-7d2f-11ea-8de8-926dad33caf0.png)](https://eq19.github.io)

![Prime Hexagon](https://user-images.githubusercontent.com/36441664/90983338-96bccf00-e597-11ea-9f81-9a3847c0be27.jpg)

## Running

Compute the first set of output values

    python ./primespin.py --nvalues=10000000 --chunks 100

Resume a computation given a saved file:

    python ./primespin.py --startfile ./output-00000000000000107000-00000000000000108000.npz --chunks 100

![Prime Hexagon](https://user-images.githubusercontent.com/36441664/107083678-9607b480-6828-11eb-9cdf-cfdfc4f6face.png)

![Gann Chart](https://user-images.githubusercontent.com/36441664/110807586-c58d5f00-82b5-11eb-81e2-dbde7d628b37.png)

##  Computing a prime number's position on the prime hexagon

TODO

![Prime Hexagon](https://user-images.githubusercontent.com/36441664/93342414-87106d80-f859-11ea-95bf-7c60432cf5ee.png)

## Command Line Help 

Run with the --help argument to see the help file.

```bash
python primespin.py --help
usage: primespin.py [-h] [--infile INFILE] [--viewvalues VIEWVALUES]
                    [--find FIND] [-c] [--dir DIR] [--basename BASENAME]
                    [--logfile LOGFILE] [--verbose VERBOSE] [--save-text]
                    [--save-binary] [--use-cython] [--no-use-cython]
                    [--nvalues NVALUES] [--skip SKIP] [--chunks CHUNKS]

Prime Spin Hexagons

optional arguments:
  -h, --help            show this help message and exit
  --infile INFILE       Input file to start processing chunks
  --viewvalues VIEWVALUES
                        Values to view in the file as a python slice, e.g.
                        1:100:
  --find FIND           Find values in files
  -c, --compress        flag to indicate whether or not to compress output
                        files
  --dir DIR             Directory to read/write files to
  --basename BASENAME   Basename of files to read and write
  --logfile LOGFILE     Save messagse to this log file
  --verbose VERBOSE     Print messages to the terminal
  --save-text           Flag to save text files
  --save-binary         Flag to save binary files
  --use-cython          Flag to use cython implementation if available
  --no-use-cython       Flag to not use cython implementation
  --nvalues NVALUES     number of values to process in a chunk
  --skip SKIP           number of values to skip in printing output
  --chunks CHUNKS       number of chunks to process
```

Here are a few sample command lines:

Generate 1000 files of 1B values each

    primespin.py --nvalues=1000000000 --chunks=1000 

or

     python3 primespin.py --nvalues=$(echo 10,000,000,000 | tr -d ,) --chunks=10000 --skip=0 --logfile run.log

Same thing but write out only every 1Mth value:

    primespin.py --nvalues=10000000000 --chunks=10 --skip=0

Now resume a computation starting at the specified file:

    primespin.py --chunks=10 --skip=0 --infile output-00000000009000000000-00000000010000000000.npz

### Skip argument

It turns out we don't always want to print out all the values we are computing. In fact, if we just want to be able to resume computations, we only need the last set of values in a range stored.

Use --skip=0 to save only a single value - the last set of values in the range.

--skip=1 is also valid to print out all values in the range.

But any other value is not going to work if you want to use chunks.

### Print Values from the NPZ files

Print some values from the binary .npz files

    primespin.py --viewvalues=:: --infile output-00000000009000000000-00000000010000000000.npz


Note viewvalues is evaluated as an [extended Python
slice](https://docs.python.org/2.3/whatsnew/section-slices.html). That is, the values are

   start:stop:step

Also any of those values can actually be negative values to indicate starting from the other end in the case of start and stop. If you make step negative it counts backward.

So let's print the last value in this file:

    primespin.py --viewvalues=-1:: --infile output-00000000009000000000-00000000010000000000.npz

### Find values in the NPZ Files

the --find argument takes a comma separated list of values. The program looks through the output directory for all files. The program searches for numbers and prints the surrounding prime hexagon values.


```bash
python primespin.py --find 2004698834,2005554573,8999550398
2015-11-30 00:32:46,658 - prime_hexagon - INFO - using numpy primehexagon implementation
2015-11-30 00:32:46,658 - prime_hexagon - INFO - looking for files matching pattern output/output-[0-9]*-[0-9]*.npz
2015-11-30 00:32:46,659 - prime_hexagon - INFO - found 10 files
(2004484351, 1, -1, 1145)
(2004698833, 1, -1, 1126)
----> 2004698834 <----
(2009838559, 3, -1, 1113)
(2010052483, 5, -1, 1115)

(2005341167, 0, 1, 1126)
(2005554553, 1, -1, 1146)
----> 2005554573 <----
(2011554973, 5, -1, 1131)
(2011769437, 1, -1, 1118)

(8999319293, 4, 1, 2052)
(8999550397, 1, -1, 2052)
----> 8999550398 <----
```

## Tests

the tests/ directory has some tests. To run them, you'll need to

```bash
pip install py.test
PYTHONPATH=. py.test -v --debug tests/test_prime_hex.py 
```

### [6th Step: Q3(28, 19)](https://eq19.github.io/hexagon)

This 19 has a configuration of π(10) i.e. 4 primes of 2, 3, 5, 7. Here we come to the detail of 168 and 618 as the 1st grammar when we come to the upper scheme. 

```
 $True Prime Pairs:
 (5,7), (11,13), (17,19)
 
 layer|  i  |   f
 -----+-----+---------
      |  1  | 5
   1  +-----+
      |  2  | 7
 -----+-----+---  } 36 » 6®
      |  3  | 11
   2  +-----+
      |  4  | 13
 -----+-----+---------
      |  5  | 17
   3  +-----+     } 36 » 6®
      |  6  | 19
 -----+-----+---------
 ```

The codes is built mainly with the algorithm of 66 out of the sum of the numbers **[30 and 36](#3rd-step-q1337-114)**. The main difference between them two is that 36 framed by twin primes.

[![Twin Pairs](https://user-images.githubusercontent.com/36441664/73700083-28f2a800-4718-11ea-97b3-2e9a738dc09e.png)](https://eq19.github.io/scheme)

Let's take the end number each of the three (3) layers: (7,13,19) in an adjacent [polygonal numbers](https://en.wikipedia.org/wiki/Polygonal_number) then by the same different of 15 they will end to the number of 66:

[![generate the prime](https://user-images.githubusercontent.com/36441664/83051968-e2cfa480-a078-11ea-8ff2-316a809a8fad.jpg)](https://schoolbag.info/mathematics/numbers/38.html)

```note
We see that the polygonal numbers in the same column all have the same difference, and this difference is always a triangular number. For example, the fifth pentagonal number (35) has 10 dots more than the fifth square number (25) and 10 dots fewer than the fifth hexagonal number (45), and the difference 10 is just the fourth triangular number. _(Source: [Discovering Properties of Numbers](https://schoolbag.info/mathematics/numbers/38.html))_.
```

See that twin (2) primes is built with multipication by six (6). So they will be managed within three (3) layers by means of a _[remote theme](/scheme)_ to **(6n+1)** and **(6n+5)**.

[![generate the primes (2,3)](https://user-images.githubusercontent.com/8466209/90985852-ca542500-e5a8-11ea-9027-9bfdcbe37966.jpg)](https://translate.google.com/translate?js=n&sl=id&tl=en&u=https://github.com/chetabahana/chetabahana.github.io/wiki#operasi)

```tip
Now let's calculate how many numbers are duplicates per layers:
* layer-1 has 6, multiplied by 6 to 36 there will be 6 - 1 or **5** duplicates
* layer-2 has 36, multiplied by 6 to 216 there will be 36 - 6 or **30** duplicates
* layer-3 has 72, multiplied by 6 to 432 there will be 72 - 36 - 6 or **30** duplicates

By Metraton the Δ1 flows in to the center so the sequence will reverse to **(Δ1,30,30,5)**
```

See the _[(19 vs 18) Loops](#3rd-step-q736-114)_ more closely, you can find that the number 102 is exactly laid on 18th row by the 15th spin out of 19 whereas 102+66 = 168 = π(1000). 

[![the next target](https://user-images.githubusercontent.com/36441664/110807586-c58d5f00-82b5-11eb-81e2-dbde7d628b37.png)](https://translate.google.com/translate?js=n&sl=id&tl=en&u=https://github.com/chetabahana/chetabahana.github.io/wiki#operasi)

The parser defined as the analysis of an input to organize the data according to the rule of a grammar while the lexer transforms a sequence of characters of tokens. 

![50 plots](https://user-images.githubusercontent.com/36441664/74591945-2b75cb80-504f-11ea-85dd-14d0a803ee6b.png)

Here the lexer specify a token correspond to a spin and the parser will specify its sequence. Combining the two (2) then they will form the tabulation as below:

```
 Scheme:
 168 + 329 + 289 = 786
 d(786) = d(7+8+6) = d(21) = d(3)
 
 Modulus:
  30  «   60  »  90
  |       |       |
 3:29 « 1:6:8 » 28:9
 └── 3 + └── 6  + └── 9 = 18
 
 |------------ 36' --------------|----------------------------36' ----------------------------|
 |     19'     |        17'      |      13'     |      11'     |       7'      |       5'     |
 +---+----+----+---+----+----+---+---+----+-----+----+----+----+----+----+-----+----+----+----+
 | 1 |  2 |  3 | 4 |  5 |  6 | 7 | 8 |  9 |  10 | 11 | 12 | 13 | 14 | 15 |  16 | 17 | 18 | 19 |
 +---+----+----+---+----+----+---+---+----+-----+----+----+----+----+----+-----+----+----+----+
 | 2 | 60 | 40 | 1 | 30 | 30 | 5 | 1 | 30 | 200 |  8 | 40 | 50 |  1 | 30 | 200 |  8 | 10 | 40 |
 +---+----+----+---+----+----+---+---+----+-----+----+----+----+----+----+-----+----+----+----+
 | ° |ΔΔΔΔ  ΦΦ | •   ΔΔ   ΔΔ   ¤ | •   ΔΔ   ΦΦΦ    Φ   ΦΦ  ¤¤¤¤|  •   ΔΔ   ΦΦΦ    Φ   ¤¤   ΦΦ |  
 
 |---- 102  ---|-----  66  ------|-------- 329 = 7 x 47 -------|- 289 = (8+9)² = 2 & (2³+9²) -|
 |--2x3x(8+9)--|--- 2x3x(2+9) ---|---- (1+2) & (2x9)+(2+9) ----|------ 2 & (8x9)+(8+9) -------|
 |-------- 168 = π(1000) --------|------ 1229 = π(10000) ------|------ π(89²) = 1000 ---------|
 |-------- 168 = π(618xΦ) -------|----- 618 = 1000/Φ = 1000x1000/1618 = 10^6/(2x8)&(2x9) -----|
 
 Note:
 • = 1000 = 10³ (Triple Ten)
 ¤ = π(1000) = 168 (Basic Primes)
 Φ = 1000/618 = 1,618 (Golden Ratio) 
 Δ(1,6,18) = 61+28 = 89 (Mersenne Primes) 
 
 Faktors:
 168 = 12x14 = 8x21 = 7x24 = 6x28 = 4x42 = 3x56 = 2x84
 618 = 6x103 = 6x(100+3) = 3x206 = 3x(200+6) = 2x309 = 2x(300+9)
 1+6+8 = π(1x6x8) = π(1x48) = π(2x24) = π(3x16)= π(4x12) = π(6x8)
 
 Permutations:
 168 = 102 + 66 = 2x3x((8+9)+(2+9)) = π(Φ(289+329)) = π(Φ((8+9)²+(1+2)&29))
 168 + 618 = 168 + 329 + 289 = (7x24) + (7x47) + (8+9)² = (7x71) + (17x17)
```

So it will form back to the begining stage with different form of input but its process will be the same algorithm trough all the system.

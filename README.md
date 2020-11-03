# SCAU - Source Code Analysis Utility

This is a simple CLI utility to determine _input/output_ for efficient slicing and _security issues_ for further analysis. The implementation is based on the basic principle discussed in my article [Source Code Analysis - A Beginners Guide](https://www.scip.ch/en/?labs.20140424).

Example:

```bash
mruef@linux:~$ ./scau.sh
Source Code Analysis Utility 3.1
(c) 2007-2020 by Marc Ruef

Syntax of scau: ./scau <language> <files_to_test>

language:
-lc     --ansic         ANSI C
-la     --asp           ASP
-lj     --java          Java
-lp     --php           PHP
```

# oeis-b-files

This is a haskell library for formatting [b-files](https://oeis.org/wiki/B-files) for [OEIS](https://oeis.org/).

To use this library in a stack project, add "oeis-b-files" to build-depends in the cabal file. In the stack.yaml file, add:
```
extra-deps:
- github: Basti53/oeis-b-files
  commit: *insert the hash of the latest commit here*
```

Suppose we want to create a b-file for the square numbers ([A000290](https://oeis.org/A000290)). We could do this in the following way: 
```haskell
Prelude> import B
Prelude B> writebFile2 "b000290.txt" 0 10001 (^2)
```

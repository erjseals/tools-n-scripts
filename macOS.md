# macOS

Unorganized collection of notes related to updating to mac

## Pipe into clipboard

Use `pbcopy`
```shell
cat result.txt | pbcopy
```

## Open Finder at terminal location

```shell
open .
```

## "Snipping Tool"

* CMD + SHIFT + 5

## Compiling Objective-C

```shell
clang -framework Foundation main.m -o main
```

or 

```shell
xcrun clang -O0 -fembed-bitcode test.c -o test_binary -framework Foundation
```

## Console logging on iPhone

Two options here: 
* "Console" app by searching in spotlight. Select the device (Pokemon name here at GS), press "Start"
* In a terminal, can use the tool `idevicesyslog`

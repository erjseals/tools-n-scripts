# lldb 

[This likely covers all my questions](https://lldb.llvm.org/use/map.html)

## Example run

Launch `lldb` from shell, important note of the `--` before argument list.
```shell
lldb /Users/eric.seals/dev/work/build/bin/ixguard_SWIFT510 -- -config auto-ixguard.yml -o ./output/KotlinMultiPlatform_obfuscated.ipa KotlinMultiPlatform.ipa -d ./output
```

Since in this example I knew IXGuard would crash, I could just `r` to get to the crash.
Once there, `up` and `down` to explore the stack frames.
`bt` for full backtrace.
`f` to print frame.

### Printing variable
Printed out a frame:
```
(lldb) f
frame #1: 0x000000010197f9e0 ixguard_SWIFT510`ixguard::transforms::extra::(anonymous namespace)::GetCheckFunctionArgs(functionToInstrument=0x000060000a654008, checkFnType=0x00000001249222e0, builder=0x000000016fdf76d0) at AutoConfInstrumentation.cpp:66:39
   63     // If the function returns a struct, the first argument is a pointer where the
   64     // returned value goes
   65     const auto startIdx =
-> 66       functionToInstrument.arg_begin()->hasStructRetAttr() ? 1 : 0;
   67
   68     assert(functionToInstrument.arg_size() >= startIdx + 2U &&
   69            "ObjC methods should have at least 2 arguments: self and selector");
```
We can examine the contents of `startIdx` with `p`
```
(lldb) p startIdx
(const int) 0
```

# VSCode LLDB

It's easier to just debug in visual studio code since it's "v i s u a l".
Need to install the [the CodeLLDB extension](https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb).
Here's an example for the above example run:
```json
{
  "configurations":
  [
    {
      "name": "Debug IXGuard",
      "type": "lldb",
      "request": "launch",
      "program": "/Users/eric.seals/dev/work/build/bin/ixguard_SWIFT510",
      "args":
      [
        "-config",
        "/Users/eric.seals/dev/work/ios-ipa/KotlinMultiPlatform/auto-ixguard.yml",
        "-o",
        "/Users/eric.seals/dev/work/ios-ipa/KotlinMultiPlatform/output/KotlinMultiPlatform_obfuscated.ipa",
        "/Users/eric.seals/dev/work/ios-ipa/KotlinMultiPlatform/KotlinMultiPlatform.ipa",
        "-d",
        "/Users/eric.seals/dev/work/ios-ipa/KotlinMultiPlatform/output",
      ],
    }
  ]
}
```

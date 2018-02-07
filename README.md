# powershell-fluent-assert
A simple PowerShell library which contains assertions and guard methods for input validation (not filtering) in business-model, libraries and application low-level code, based on Terah's PHP fluent-assert (https://github.com/terah/fluent-assert).

The library can be used to implement pre-/post-conditions on input data and methods are called using a fluent/chained style.

The aim is to reduce the amount of code for implementing assertions in your model and also simplify the code paths to implement assertions. When assertions fail, an AssertionFailedException is thrown, removing the necessity for if-clauses in your code.

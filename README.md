# powershell-fluent-assert

A simple PowerShell library which contains assertions and guard methods for input validation (not filtering) in business-model, libraries and application low-level code, based on Terah's PHP fluent-assert (https://github.com/terah/fluent-assert).

The library can be used to implement pre-/post-conditions on input data and methods are called using a fluent/chained style.

The aim is to reduce the amount of code for implementing assertions in your model and also simplify the code paths to implement assertions. When assertions fail, an AssertionFailedException is thrown, removing the necessity for if-clauses in your code.

## Install

Copy to powershell path and import the module. Recommend use of object class with "using" keyword rather than "import-module"

``` PowerShell
Copy to path accessible to your project.

e.g. C:\myScript\Modules\powershell-fluent-assert
```

## Usage

``` PowerShell
For the example above:
using module '.\Modules\powershell-fluent-assert\Assert.psm1'
using module '.\Modules\powershell-fluent-assert\AssertionFailedException.psm1'
```

``` PowerShell
using module '.\Assert.psd1'

[Assert]::new($value).eq($value2, [string] $message='', [string] $fieldName='')
[Assert]::new($value).same($value2, [string] $message='', [string] $fieldName='')
[Assert]::new($value).notEq($value2, [string] $message='', [string] $fieldName='')
[Assert]::new($value).notSame($value2, [string] $message='', [string] $fieldName='')
[Assert]::new($value).integer([string] $message='', [string] $fieldName='')

**To be implemented**[Assert]::new($value).single([string] $message='', [string] $fieldName='')      [single]    Single-precision 32-bit floating point number
**To be implemented**[Assert]::new($value).decimal([string] $message='', [string] $fieldName='')     [decimal]   A 128-bit decimal value
**To be implemented**[Assert]::new($value).double([string] $message='', [string] $fieldName='')      [double]    Double-precision 64-bit floating point number
**To be implemented**[Assert]::new($value).dateTime([string] $message='', [string] $fieldName='')    [DateTime]  Date and Time

**To be implemented**[Assert]::new($value).digit([string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).date($message=null, $fieldName=null)
**To be implemented**[Assert]::new($value).integerish([string] $message='', [string] $fieldName='')

[Assert]::new($value).boolean([string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).scalar([string] $message='', [string] $fieldName='')
[Assert]::new($value).notEmpty([string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).noContent([string] $message='', [string] $fieldName='')
[Assert]::new($value).notNull([string] $message='', [string] $fieldName='')
[Assert]::new($value).string([string] $message='', [string] $fieldName='')
[Assert]::new($value).regex($pattern, [string] $message='', [string] $fieldName='')
[Assert]::new($value).length($length, [string] $message='', [string] $fieldName='', $encoding = 'utf8')
[Assert]::new($value).minLength($minLength, [string] $message='', [string] $fieldName='', $encoding = 'utf8')
[Assert]::new($value).maxLength($maxLength, [string] $message='', [string] $fieldName='', $encoding = 'utf8')
**To be implemented**[Assert]::new($value).betweenLength($minLength, $maxLength, [string] $message='', [string] $fieldName='', $encoding = 'utf8')
**To be implemented**[Assert]::new($value).startsWith($needle, [string] $message='', [string] $fieldName='', $encoding = 'utf8')
**To be implemented**[Assert]::new($value).endsWith($needle, [string] $message='', [string] $fieldName='', $encoding = 'utf8')
[Assert]::new($value).contains($needle, [string] $message='', [string] $fieldName='', $encoding = 'utf8')
[Assert]::new($value).choice(array $choices, [string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).inArray(array $choices, [string] $message='', [string] $fieldName='')
[Assert]::new($value).numeric([string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).isArray([string] $message='', [string] $fieldName='')
[Assert]::new($value).isTraversable([string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).isArrayAccessible([string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).keyExists($key, [string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).keysExist($keys, [string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).propertyExists($key, [string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).propertiesExist(array $keys, [string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).utf8([string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).keyIsset($key, [string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).notEmptyKey($key, [string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).notBlank([string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).isInstanceOf($className, [string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).notIsInstanceOf($className, [string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).subclassOf($className, [string] $message='', [string] $fieldName='')
[Assert]::new($value).range($minValue, $maxValue, [string] $message='', [string] $fieldName='')
[Assert]::new($value).min($minValue, [string] $message='', [string] $fieldName='')
[Assert]::new($value).max($maxValue, [string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).file([string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).directory([string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).readable([string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).writeable([string] $message='', [string] $fieldName='')
[Assert]::new($value).email([string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).url([string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).alnum([string] $message='', [string] $fieldName='')
[Assert]::new($value).true([string] $message='', [string] $fieldName='')
[Assert]::new($value).false([string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).classExists([string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).implementsInterface($interfaceName, [string] $message='', [string] $fieldName='')
[Assert]::new($value).isJsonString([string] $message='', [string] $fieldName='')
[Assert]::new($value).uuid([string] $message='', [string] $fieldName='')
[Assert]::new($value).samAccountName([string] $message='', [string] $fieldName='')
[Assert]::new($value).userPrincipalName([string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).count($count, [string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).choicesNotEmpty(array $choices, [string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).methodExists($object, [string] $message='', [string] $fieldName='')
**To be implemented**[Assert]::new($value).isObject([string] $message='', [string] $fieldName='')
```
``` PowerShell
# Chaining
[void][Assert]::new($myValue).integer().notEmpty().eq(1)
```
``` PowerShell
# Checking members of arrays and objects)
[void][Assert]::new($myArray).all().integer().notEmpty().eq(1)
```
``` PowerShell
# Null or valid
[void][Assert]::new($myNullValue).nullOr().integer().notEmpty().eq(1)
```
``` PowerShell
# Reset the all and nullOr flags and set value
[Assert]::new($value).reset($value)
```
``` PowerShell
# Set a new value
[Assert]::new($value).value($value)
```
``` PowerShell
# Set the null or flag to $true
[Assert]::new($value).nullOr()
OR
[Assert]::new($value).nullOr($true)
```
``` PowerShell
# Set the empty or flag to $true
[Assert]::new($value).emptyOr()
OR
[Assert]::new($value).emptyOr($true)
```
``` PowerShell
# Set the all flag to true
[Assert]::new($value).all()
OR
[Assert]::new($value).all($true)

```
## Full Usage Example
``` PowerShell

#Test for [AssertionFailedException] on an invalid samAccountName, passed in an array

function Get-ScriptLineNumber { return $MyInvocation.ScriptLineNumber }
function Get-ScriptName { return $MyInvocation.ScriptName }

new-item alias:__LINE__ -value Get-ScriptLineNumber | out-null
new-item alias:__FILE__ -value Get-ScriptName | out-null

try
{
     $value1 = @("jcitiz","$%invalud username","myUsername")
     [void][Assert]::new($value1).
             fieldName('Username').
             file($(__FILE__)).
             line($(__LINE__)).
             all().
             samAccountName()
}
catch [AssertionFailedException]
{
    [AssertionFailedException]  $e = [AssertionFailedException] $_.Exception
    write-host $e.jsonSerialize()
}

```

## Testing

``` PS
PS$ invoke-pester

```

Please see Assert.Unit.Tests.ps1 for example of writing tests (pester).

## Contributing

Please see [CONTRIBUTING](CONTRIBUTING.md) for details.

## Credits

- [John Reid](https://github.com/johnnyreid)
- [All Contributors](../../contributors)

## License

The MIT License (MIT). Please see [License File](LICENSE.md) for more information.

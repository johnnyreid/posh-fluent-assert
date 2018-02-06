

#########################################################################################################################################################
<#
.SYNOPSIS
Error created when assertion fails
.DESCRIPTION
Error created when assertion fails
.PARAMETER Message
The error message
.PARAMETER Code
The error code
.PARAMETER propertyPath
The property path
.PARAMETER value
The value of the object on which assert was being applied
.PARAMETER constraints
An array of string which has constraints
.PARAMETER level
The severity of the error. Default is 'critical'
.EXAMPLE
TBA
.NOTES
System.Exception Properties https://msdn.microsoft.com/en-us/library/system.exception(v=vs.110).aspx
~~~~~~~~~~~~~~~~~~~~~~~~~~
Data - Gets a collection of key/value pairs that provide additional user-defined information about the exception.
HelpLink - Gets or sets a link to the help file associated with this exception.
HResult	- Gets or sets HRESULT, a coded numerical value that is assigned to a specific exception.
InnerException	- Gets the Exception instance that caused the current exception.
Message - Gets a message that describes the current exception.
Source - Gets or sets the name of the application or the object that causes the error.
StackTrace - Gets a string representation of the immediate frames on the call stack.
TargetSite - Gets the method that throws the current exception.
#>
Class AssertionFailedException : System.Exception
{
    # [string]    $ExceptionType  = "AssertionFailedException"
    # hidden [string]    $message           = ''
    [int]    $code           = $null
    [string] $fieldName      = ''
             $value          = $null
    [array]  $constraints    = $null
    [string] $level          = 'critical'
    [string] $propertyPath   = ''
    [string] $file           = $null
    [int]    $line           = ''

    AssertionFailedException(
                            [string]    $message,
                            [int]       $code,
                            [string]    $fieldName,
                            [object]    $value,
                            [string[]]  $constraints,
                            [string]    $level,
                            [string]    $propertyPath,
                            [string]    $file,
                            [string]    $line
                            ) : base($message)
    {
        # $this.message              = $message
        $this.code              = $code
        $this.fieldName         = $fieldName
        $this.value             = $value
        $this.constraints       = $constraints
        $this.level             = $level
        $this.propertyPath      = $propertyPath
        $this.file              = $file
        $this.line              = $line
    }

        <#
    .SYNOPSIS
    Get the error message.
    .NOTES
    @return string
    #>
    [string] getMessage()
    {
        return $this.message
    }


    <#
    .SYNOPSIS
    Get the field name that was set for the assertion object.
    .NOTES
    @return string
    #>
    [string] getFieldName()
    {
        return $this.fieldName
    }

    <#
    .SYNOPSIS
    Get the value that caused the assertion to fail.
    .NOTES
    @return mixed
    #>
    [object] getValue()
    {
        return $this.value
    }

    <#
    .SYNOPSIS
    Get the constraints that applied to the failed assertion.
    .NOTES
    @return array
    #>
    [array] getConstraints()
    {
        return $this.constraints
    }

    <#
    .SYNOPSIS
    Get the error level.
    .NOTES
    @return string
    #>
    [int] getLevel()
    {
        return $this.level
    }

    <#
    .SYNOPSIS
    User controlled way to define a sub-property causing
    the failure of a currently asserted objects.
    Useful to transport information about the nature of the error
    back to higher layers.
    .NOTES
    @return string
    #>
    [string] getProperty()
    {
        if ( [string]::IsNullOrEmpty($this.PropertyPath) -eq $true )
        {   
            return "General Error"
        }

        return $this.PropertyPath
    }

    [int] getCode()
    {
        return $this.code
    }

    <#
    .SYNOPSIS
    Get the propertyPath, combined with the calling file and line location.
    .NOTES
    @return string
    #>
    [string] getPropertyPathAndCallingLocation()
    {
        return $this.getPropertyPath() + ' in ' + $this.getCallingFileAndLine()
    }

    <#
    .SYNOPSIS
    Get the calling file and line from where the failing assertion was called.
    .NOTES
    @return string
    #>
    [string] getCallingFileAndLine()
    {
        return $this.file + ':' + $this.line
    }

    # serialize the object
    [string] jsonSerialize()
    {
        Return $this | ConvertTo-Json -Compress -Depth 8
    }
}


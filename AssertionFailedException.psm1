

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
    hidden $propertyPath   = ''        #can include a full propertypath if you desire but this is generally used for fieldName
    hidden $code           = $null
    hidden $value          = $null
    
    hidden $constraints    = $null
    
    
    [int]    $level             = $null
    
    [int]       $Callingline           = 0
    [string]    $CallingFile    = ''


    #  location details
    Hidden [string]    $className       = $null
    Hidden [string]    $methodName      = $null
    Hidden [string]    $functionName    = $null
    Hidden [string]    $fieldName       = ''

    static $ERROR_LEVEL_EMERGENCY       = 1
    static $ERROR_LEVEL_ALERT           = 2
    static $ERROR_LEVEL_CRITICAL        = 3
    static $ERROR_LEVEL_ERROR           = 4
    static $ERROR_LEVEL_WARNING         = 5
    static $ERROR_LEVEL_NOTICE          = 6
    static $ERROR_LEVEL_INFO            = 7
    static $ERROR_LEVEL_DEBUG           = 8

    AssertionFailedException(
                            [string]    $Message,
                            [int]       $code,
                            [string]    $propertyPath,
                            [object]    $value,
                            [string]    $level,
                            [string[]]  $constraints,
                            [string]    $className,
                            [string]    $methodName,
                            [string]    $functionName,
                            [string]    $fieldName
            ) : base($Message)
    {
        $this.code              = $code
        $this.propertyPath      = $propertyPath
        $this.value             = $value
        $this.level             = [Levels] $level
        $this.constraints       = $constraints

        # Execution location details
        $this.className        = $className
        $this.methodName       = $methodName
        $this.functionName     = $functionName
        $this.fieldName        = $fieldName
    }

    [string] getPropertyPath()
    {
        return $this.PropertyPath
    }

    [string] getProperty()
    {
        if ( [string]::IsNullOrEmpty($this.PropertyPath) -eq $true )
        {   
            return "General Error"
        }
        return $this.PropertyPath
    }

    [string] getMessage()
    {
        return ([System.Exception]$this).Message
    }
    [string] getSource()
    {
        return ([System.Exception]$this).Source
    }

    [int] getCode()
    {
        return $this.code
    }

    [int] getLevel()
    {
        return $this.level
    }

    # [AssertionFailedException] setCode([int] $code)
    # {
    #     $this.code = $code

    #     return $this
    # }

    



    # [AssertionFailedException] setPropertyPath([string] $propertyPath)
    # {
    #     $this.propertyPath = $propertyPath

    #     return $this
    # }

    [array] getConstraints()
    {
        return $this.constraints
    }

    [AssertionFailedException] setConstraints([array] $constraints)
    {
        $this.constraints = $constraints

        return $this
    }

    [AssertionFailedException] setLevel([int] $level)
    {
        $this.level = [Levels] $level

        return $this
    }

    [string] getClassName()
    {
        return $this.className
    }

    [string] getMethodName()
    {
        return $this.methodName
    }

    [string] getFunctionName()
    {
        return $this.functionName
    }

    [string] getFieldName()
    {
        If ($this.fieldName)
        {
            return $this.fieldName
        }
        return $this.propertyPath
    }

    [object] getValue()
    {
        return $this.value
    }

    [string] jsonSerialize()
    {
        Return $this | ConvertTo-Json -Compress -Depth 8
    }



}


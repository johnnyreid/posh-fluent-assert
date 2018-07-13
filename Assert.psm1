using module ".\AssertionFailedException.psm1"

Class Assert
{
    static $INVALID_FLOAT               = 9
    static $INVALID_INTEGER             = 10
    static $INVALID_DIGIT               = 11
    static $INVALID_INTEGERISH          = 12
    static $INVALID_BOOLEAN             = 13
    static $VALUE_EMPTY                 = 14
    static $VALUE_NULL                  = 15
    static $INVALID_STRING              = 16
    static $INVALID_REGEX               = 17
    static $INVALID_MIN_LENGTH          = 18
    static $INVALID_MAX_LENGTH          = 19
    static $INVALID_STRING_START        = 20
    static $INVALID_STRING_CONTAINS     = 21
    static $INVALID_CHOICE              = 22
    static $INVALID_NUMERIC             = 23
    static $INVALID_ARRAY               = 24
    static $INVALID_KEY_EXISTS          = 26
    static $INVALID_NOT_BLANK           = 27
    static $INVALID_INSTANCE_OF         = 28
    static $INVALID_SUBCLASS_OF         = 29
    static $INVALID_RANGE               = 30
    static $INVALID_ALNUM               = 31
    static $INVALID_TRUE                = 32
    static $INVALID_EQ                  = 33
    static $INVALID_SAME                = 34
    static $INVALID_MIN                 = 35
    static $INVALID_MAX                 = 36
    static $INVALID_LENGTH              = 37
    static $INVALID_FALSE               = 38
    static $INVALID_STRING_END          = 39
    static $INVALID_UUID                = 40
    static $INVALID_COUNT               = 41
    static $INVALID_NOT_EQ              = 42
    static $INVALID_NOT_SAME            = 43
    static $INVALID_TRAVERSABLE         = 44
    static $INVALID_ARRAY_ACCESSIBLE    = 45
    static $INVALID_KEY_ISSET           = 46
    static $INVALID_SAMACCOUNTNAME      = 47
    static $INVALID_USERPRINCIPALNAME   = 48
    static $INVALID_BASE64              = 49
    static $INVALID_DIRECTORY           = 101
    static $INVALID_FILE                = 102
    static $INVALID_READABLE            = 103
    static $INVALID_WRITEABLE           = 104
    static $INVALID_CLASS               = 105
    static $INVALID_UNC_PATH            = 106
    static $INVALID_DRIVE_LETTER        = 107
    static $INVALID_EMAIL               = 201
    static $INTERFACE_NOT_IMPLEMENTED   = 202
    static $INVALID_URL                 = 203
    static $INVALID_NOT_INSTANCE_OF     = 204
    static $VALUE_NOT_EMPTY             = 205
    static $INVALID_JSON_STRING         = 206
    static $INVALID_OBJECT              = 207
    static $INVALID_METHOD              = 208
    static $INVALID_SCALAR              = 209
    static $INVALID_DATE                = 210
    static $INVALID_CALLABLE            = 211
    static $INVALID_KEYS_EXIST          = 300
    static $INVALID_PROPERTY_EXISTS     = 301
    static $INVALID_PROPERTIES_EXIST    = 302
    static $INVALID_UTF8                = 303
    static $INVALID_DOMAIN_NAME         = 304
    static $INVALID_NOT_FALSE           = 305
    static $INVALID_FILE_OR_DIR         = 306
    static $INVALID_ASCII               = 307
    static $INVALID_NOT_REGEX           = 308
    static $INVALID_GREATER_THAN        = 309
    static $INVALID_LESS_THAN           = 310
    static $INVALID_GREATER_THAN_OR_EQ  = 311
    static $INVALID_LESS_THAN_OR_EQ     = 312
    static $INVALID_IP_ADDRESS          = 313
    static $INVALID_AUS_MOBILE          = 314

    #error levels
    static $EMERGENCY                   = 'emergency'
    static $ALERT                       = 'alert'
    static $CRITICAL                    = 'critical'
    static $GENERAL_ERROR               = 'error'
    static $WARNING                     = 'warning'
    static $NOTICE                      = 'notice'
    static $INFO                        = 'info'
    static $DEBUG                       = 'debug'

    Hidden [bool]   $pNullOr             = $false

    Hidden [bool]   $pEmptyOr            = $false

    Hidden          $pValue              = $null

    Hidden [bool]   $pAll                = $false

    Hidden [string] $pFieldName          = ''

    Hidden [string] $pPropertyPath       = ''                #can include a full propertypath if you desire but this is generally used for fieldName

    Hidden [string] $pLevel              = [Assert]::CRITICAL

    Hidden [int]    $pOverrideCode       = $null

    Hidden [string] $pOverrideError      = ''

    # Invocation location details
    Hidden [string] $pFileName           = ''

    Hidden [int]    $pLineNumber         = $null

    #constructor and overloads
    Assert($value)
    {
        $this.pValue            = $value
    }
    Assert($value, [string] $fieldName)
    {
        $this.pValue            = $value
        $this.pFieldName        = $fieldName
    }

    static [Assert] that($value)
    {
        return [Assert]::that($value, '', 0, '', [Assert]::WARNING)
    }
    static [Assert] that($value, [string] $fieldName)
    {
        return [Assert]::that($value, $fieldName, 0, '', [Assert]::WARNING)
    }
    static [Assert] that($value, [string] $fieldName, [int] $code, [string] $overrideError)
    {
        return [Assert]::that($value, $fieldName, $code, $overrideError, [Assert]::WARNING)
    }
    static [Assert] that($value, [string] $fieldName, [int] $code, [string] $overrideError, [string] $level)
    {
        $assert = [Assert]::new($value)
        if ( $fieldName )
        {
            $assert.fieldName($fieldName)
        }
        if ( $code )
        {
            $assert.code($code)
        }
        if ( $error )
        {
            $assert.error($error)
        }
        if ( $level )
        {
            $assert.level($level)
        }

        return $assert
    }


    <#
    .NOTES
    @param mixed $value
    @return Assert
    #>
    [Assert] reset($value)
    {
        return $this.all($false).nullOr($false).value($value)
    }
        <#
    .NOTES
    @param mixed $value
    @param string $fieldName
    @return Assert
    #>
    [Assert] reset($value, [string] $fieldName)
    {
        return $this.all($false).nullOr($false).value($value).fieldName($fieldName)
    }

    <#
    .NOTES
    @param mixed $value
    @return Assert
    #>
    [Assert] value($value)
    {
        $this.pValue = $value

        return $this
    }

    <#
    .NOTES
    @param bool $nullOr
    @return Assert
    #>
    [Assert] nullOr([bool] $nullOr)
    {
        $this.pNullOr = $nullOr

        return $this
    }

    <#
    .NOTES
    @param bool $emptyOr
    @return Assert
    #>
    [Assert] emptyOr([bool] $emptyOr)
    {
        $this.pEmptyOr = $emptyOr

        return $this
    }

    <#
    .NOTES
    @param bool $all
    @return Assert
    #>
    [Assert] all()
    {
        return $this.all($true)
    }

    [Assert] all([bool] $all)
    {
        $this.pAll = $all

        return $this
    }

    <#
    .SYNOPSIS
    Helper method that handles building the assertion failure exception.
    They are returned from this method so that the stack trace still shows
    the assertions method.
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER code 
    An error code which will override the default assert error code
    .PARAMETER fieldName
    The field name
    .PARAMETER constraints 
    An array of constraints
    .PARAMETER level 
    A string representing the severity of the error
    .NOTES
    return AssertionFailedException
    # Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [AssertionFailedException] createException([string] $message, [string] $fieldName, [int] $code)
    {
        return $this.createException($message, $fieldName, $code, @())
    }
    [AssertionFailedException] createException([string] $message, [string] $fieldName, [int] $code, [array] $constraints)
    {
        $errcode        = $this.pOverrideCode
        $errFieldName   = $fieldName

        if ( ($errcode -eq 0) -or ($errcode -eq $null) )        #override is NOT set at method-level
        {
            $errcode = $code
        }
        if ( [string]::IsNullOrEmpty($errFieldName) )   #override is set at method level
        {
            $errFieldName = $this.pFieldName
        }

        return [AssertionFailedException]::new($message, $errcode, $errFieldName, $this.pValue, $constraints, $this.pLevel, $this.pPropertyPath, $this.pFileName, $this.pLineNumber)
    }

    <#
    .NOTES
    @param int $code
    @return Assert
    #>
    [Assert] code([int] $code)
    {
        $this.pOverrideCode = $code

        return $this
    }

        <#
    .NOTES
    @param string $fieldName
    @return Assert
    #>
    [Assert] fieldName([string] $fieldName)
    {
        $this.pFieldName = $fieldName

        return $this
    }

    <#
    .NOTES
    @param string $level
    @return Assert
    #>
    [Assert] level([string] $level)
    {
        $this.pLevel = $level

        return $this
    }

    <#
    .SYNOPSIS
    Set an overrride error message.
    .NOTES
    @param string $overrideError
    @return Assert
    #>
    [Assert] overrideError([string] $overrideError)
    {
        $this.pOverrideError = $overrideError
        
        return $this
    }

    <#
    .SYNOPSIS
     User controlled way to define a sub-property causing
     the failure of a currently asserted objects.
    
     Useful to transport information about the nature of the error
     back to higher layers.
    .NOTES
     @param string $propertyPath
     @return Assert
    #>
    [Assert] propertyPath([string] $propertyPath)
    {
        $this.pPropertyPath = $propertyPath

        return $this
    }

    <#
    .SYNOPSIS 
    The name of the calling file (optional)
    .NOTES
    @param string $file
    @return Assert
    #>
    [Assert] fileName([string] $fileName)
    {
        $this.pFileName = $fileName

        return $this
    }

    <#
    .SYNOPSIS
    The line number from the calling file (optional)
    .NOTES
    @param int $line
    @return Assert
    #>
    [Assert] lineNumber([int] $lineNumber)
    {
        $this.pLineNumber = $lineNumber

        return $this
    }


    <#
    .SYNOPSIS
    Assert that value is an array.
    .NOTES
    @param string $message
    @param string $fieldName
    @return Assert
    @throws AssertionFailedException
    #>
    [Assert] isArray() 
    {
        return $this.isArray("","")
    } 
    [Assert] isArray([string] $message) 
    {
        return $this.isArray($message,"")
    }
    #end of Overload methods
    [Assert] isArray([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("isArray", $args) )
        {
            return $this
        }

        if ( ($this.pValue -is [array]) -and (-not($this.pValue -is [string])) )
        {
            return $this
        }

        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = 'Value "{0}" expected to be an array, type "{1}" given.' -f [Assert]::stringify($this.pValue), $($this.pValue).GetType()
        }

        throw $this.createException($message, $fieldName, [Assert]::INVALID_ARRAY)
    }

    <#
    .SYNOPSIS
    Assert that value is an array or a traversable object.
    .NOTES
    @param string $message
    @param string $fieldName
    @return Assert
    @throws AssertionFailedException
     #>
    [Assert] isTraversable()
    {
        return $this.isTraversable('', '')
    }
    [Assert] isTraversable([string] $message)
    {
        return $this.isTraversable($message, '')
    }
    [Assert] isTraversable([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("isTraversable", $args) )
        {
            return $this
        }
        if ( (-not ($this.pValue -is [array])) -and ((-not($this.pValue -is [System.Collections.IEnumerable])) -or ($this.pValue -is [string])) )
        {
            if ( [string]::IsNullOrEmpty($message) )
            {
                $message = $this.pOverrideError
            }
            if ( [string]::IsNullOrEmpty($message) )
            {
                $message = 'Value "{0}" is not an array and does not implement Traversable.' -f [Assert]::stringify($this.pValue)
            }

            throw $this.createException($message, $fieldName, [Assert]::INVALID_TRAVERSABLE)
        }

        return $this
    }



    <# 
    .SYNOPSIS
    Assert that key exists in the values array.
    .NOTES
    @param string|integer $key
    @param string         $message
    @param string         $fieldName
    @return Assert
    @throws AssertionFailedException
    #>
    [Assert] keyExists($key)
    {
        return $this.keyExists($key,'', '')
    }
    [Assert] keyExists($key, [string] $message)
    {
        return $this.keyExists($key, $message, '')
    }
    [Assert] keyExists($key, [string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("keyExists", $args) )
        {
            return $this
        }
        $this.isArray($message, $fieldName)

        if ( -not $this.pValue.Contains($key) )
        {
            if ( [string]::IsNullOrEmpty($message) )
            {
                $message = $this.pOverrideError
            }
            if ( [string]::IsNullOrEmpty($message) )
            {
                $message = 'Array does not contain an element with key "{0}".' -f [Assert]::stringify($key)
            }

            throw $this.createException($message, $fieldName, [Assert]::INVALID_KEY_EXISTS)
        }

        return $this
    }

    <#
    .SYNOPSIS
    Assert that keys exist in the values array.
    .NOTES
    @param array  $keys
    @param string $message
    @param string $fieldName
    @return Assert
    @throws AssertionFailedException
    #>
    [Assert] keysExist([array] $keys)
    {
        return $this.keysExist($keys,'', '')
    }
    [Assert] keysExist([array] $keys, [string] $message)
    {
        return $this.keysExist($keys, $message, '')
    }
    [Assert] keysExist([array] $keys, [string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("keyExists", $args) )
        {
            return $this
        }
        $this.isArray($message, $fieldName)

        Foreach ( $key in $keys )
        {
            if ( -not $this.pValue.Contains($key) )
            {
                if ( [string]::IsNullOrEmpty($message) )
            {
                $message = $this.pOverrideError
            }
            if ( [string]::IsNullOrEmpty($message) )
            {
                $message = 'Array does not contain an element with key "{0}".' -f [Assert]::stringify($key)
            }

            throw $this.createException($message, $fieldName, [Assert]::INVALID_KEYS_EXIST)
           }
        }

        return $this
    }




    <#
    .SYNOPSIS
    Assert that a property (key) exists in the values array.
    .PARAMETER key
    The property name to search for
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] propertyExists($key)
    {
        return $this.propertyExists($key,'', '')
    }
    [Assert] propertyExists($key, [string] $message)
    {
        return $this.propertyExists($key, $message, '')
    }
    [Assert] propertyExists($key, [string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("propertyExists", $args) )
        {
            return $this
        }
        $this.isObject($message, $fieldName)

        if ( $this.pValue.Keys ) #checks that the hashtable has keys
        {
            if ( $this.pValue.Item($key) )
            {
                return $this
            }
        }
         if ( $this.pValue.PSObject.Properties[$key] )
        {
            return $this
        }

        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = 'Object does not contain a property with key "{0}" given.' -f [Assert]::stringify($key)
        }

        throw $this.createException($message, $fieldName, [Assert]::INVALID_PROPERTY_EXISTS)
    }


        <#
    .SYNOPSIS
    Assert that properties (keys) exist in the values array.
    .PARAMETER key 
    The property names to search for
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] propertiesExist([array] $keys)
    {
        return $this.propertiesExist($keys,'', '')
    }
    [Assert] propertiesExist([array] $keys, [string] $message)
    {
        return $this.propertiesExist($keys, $message, '')
    }
    [Assert] propertiesExist([array] $keys, [string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("propertiesExist", $args) )
        {
            return $this
        }
        $this.isObject($message, $fieldName)
        $this.pOverrideCode = [Assert]::INVALID_PROPERTIES_EXIST
        Foreach ( $key in $keys )
        {
            $this.propertyExists($key, $message, $fieldName)
        }

        return $this
    }

    <#
    .SYNOPSIS
    Invokes reflection on given method with provided parameters.
    .PARAMETER methodName
    The name of the method to reflect
    .PARAMETER MethodParameters
    Args that are passed(args)
    .NOTES
    @return bool
    @throws AssertionFailedException
    #>
    hidden [bool] doAllOrNullOr([string] $methodName, $MethodParameters)
    {
        if ( ($this.pNullOr -eq $true) -and ($this.pValue -eq $null) )
        {
            return $true
        }
        if ( ($this.pEmptyOr -eq $true) -and ([string]::IsNullOrEmpty($this.pValue) -eq $true) )
        {
            return $true
        }

        if ( ($this.pAll -eq $true) -and (([Assert]::new($this.pValue)).isTraversable()) )
        {
            foreach ( $value in $this.pValue )
            {
                $object = [Assert]::new($value)
                try
                {
                    $object.$methodName.Invoke($MethodParameters)
                }
                catch 
                {
                    # get the base AssertionFailedException, if present, and recreate it from this invocation.
                    # This is required due to invoke of methods using reflection
                    # which will raise a System.Management.Automation.MethodInvocationException
                    # because of the invoked method throwing
                    if ($_.Exception.GetBaseException() -is [AssertionFailedException])
                    {
                        [AssertionFailedException] $e = [AssertionFailedException] $_.Exception.GetBaseException()
                        throw $this.createException($e.getMessage(), $e.getFieldName(), $e.getCode(), $e.getConstraints())
                    }
                 }
            }

            return $true
        }

        return $false
    }

    <# 
    .SYNOPSIS
    Assert that two values are equal (using "-ceq" which is case sensitive).
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] eq($value2)
    {
        return $this.eq($value2, '', '')
    }
    [Assert] eq($value2, [string] $message)
    {
        return $this.eq($value2, $message, '')
    }
    [Assert] eq($value2, [string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("eq", $args) )
        {
            return $this
        }
        if ( $this.pValue -ceq $value2 )
        {
            return $this
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = 'Value "{0}" does not equal expected value "{1}".' -f [Assert]::stringify($this.pValue), [Assert]::stringify($value2)
        }

        throw $this.createException($message, $fieldName, [Assert]::INVALID_EQ)
    }

    <# 
    .SYNOPSIS
    Assert that a value is greater than another
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] greaterThan($value2)
    {
        return $this.greaterThan($value2, '', '')
    }
    [Assert] greaterThan($value2, [string] $message)
    {
        return $this.greaterThan($value2, $message, '')
    }
    [Assert] greaterThan($value2, [string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("greaterThan", $args) )
        {
            return $this
        }
        if ( -not ( $this.pValue -cgt $value2 ) )
        {
            if ( [string]::IsNullOrEmpty($message) )
            {
                $message = $this.pOverrideError
            }
            if ( [string]::IsNullOrEmpty($message) )
            {
                $message = 'Value "{0}" is not greater than value "{1}".' -f [Assert]::stringify($this.pValue), [Assert]::stringify($value2)
            }

            throw $this.createException($message, $fieldName, [Assert]::INVALID_GREATER_THAN)
        }
        return $this;
    }

    <# 
    .SYNOPSIS
    Assert that a value is greater than or equal to another
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] greaterThanOrEq($value2)
    {
        return $this.greaterThanOrEq($value2, '', '')
    }
    [Assert] greaterThanOrEq($value2, [string] $message)
    {
        return $this.greaterThanOrEq($value2, $message, '')
    }
    [Assert] greaterThanOrEq($value2, [string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("greaterThanOrEq", $args) )
        {
            return $this
        }
        if ( -not ( $this.pValue -cge $value2 ) )
        {
            if ( [string]::IsNullOrEmpty($message) )
            {
                $message = $this.pOverrideError
            }
            if ( [string]::IsNullOrEmpty($message) )
            {
                $message = 'Value "{0}" is not greater than or equal to value "{1}".' -f [Assert]::stringify($this.pValue), [Assert]::stringify($value2)
            }

            throw $this.createException($message, $fieldName, [Assert]::INVALID_GREATER_THAN_OR_EQ)
        }
        return $this;
    }

    <# 
    .SYNOPSIS
    Assert that a value is less than another
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] lessThan($value2)
    {
        return $this.lessThan($value2, '', '')
    }
    [Assert] lessThan($value2, [string] $message)
    {
        return $this.lessThan($value2, $message, '')
    }
    [Assert] lessThan($value2, [string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("lessThan", $args) )
        {
            return $this
        }
        if ( -not ( $this.pValue -clt $value2 ) )
        {
            if ( [string]::IsNullOrEmpty($message) )
            {
                $message = $this.pOverrideError
            }
            if ( [string]::IsNullOrEmpty($message) )
            {
                $message = 'Value "{0}" is not less than value "{1}".' -f [Assert]::stringify($this.pValue), [Assert]::stringify($value2)
            }

            throw $this.createException($message, $fieldName, [Assert]::INVALID_LESS_THAN)
        }
        return $this;
    }

    <# 
    .SYNOPSIS
    Assert that a value is less than or equal to another
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] lessThanOrEq($value2)
    {
        return $this.lessThanOrEq($value2, '', '')
    }
    [Assert] lessThanOrEq($value2, [string] $message)
    {
        return $this.lessThanOrEq($value2, $message, '')
    }
    [Assert] lessThanOrEq($value2, [string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("lessThanOrEq", $args) )
        {
            return $this
        }
        if ( -not ( $this.pValue -cle $value2 ) )
        {
            if ( [string]::IsNullOrEmpty($message) )
            {
                $message = $this.pOverrideError
            }
            if ( [string]::IsNullOrEmpty($message) )
            {
                $message = 'Value "{0}" is not less than or equal to value "{1}".' -f [Assert]::stringify($this.pValue), [Assert]::stringify($value2)
            }

            throw $this.createException($message, $fieldName, [Assert]::INVALID_LESS_THAN_OR_EQ)
        }
        return $this;
    }

    <# 
    .SYNOPSIS
    Assert that two values are the same (equal and of the same type)
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] same($value2)
    {
        return $this.same($value2,$null,$null)
    }
    [Assert] same($value2, [string] $message)
    {
        return $this.same($value2,$message,$null)
    }
    [Assert] same($value2, [string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("same", $args) )
        {
            return $this
        }
        if ( ($this.pValue -ceq $value2) `
        -and ($($this.pValue).GetType() -eq $Value2.GetType()) )
        {
            return $this
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = 'Value "{0}" is not the same as expected value "{1}".'  -f [Assert]::stringify($this.pValue), [Assert]::stringify($value2)
        }

        throw $this.createException($message, $fieldName, [Assert]::INVALID_SAME)
    }

    <#
    .SYNOPSIS
    Assert that two values are not equal (using -ceq, case sensitive ).
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] notEq($value2)
    {
        return $this.notEq($value2,$null,$null)
    }
    [Assert] notEq($value2, [string] $message)
    {
        return $this.notEq($value2,$message,$null)
    }
    [Assert] notEq($value2, [string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("notEq", $args) )
        {
            return $this
        }
        if ( $this.pValue -cne $value2 )
        {
            return $this
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = 'Value "{0}" is equal to value "{1}".' -f [Assert]::stringify($this.pValue), [Assert]::stringify($value2)
        }

        throw $this.createException($message, $fieldName, [Assert]::INVALID_NOT_EQ)
    }

    <# 
    .SYNOPSIS
    Assert that two values are not the same (equal and of the same type)
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] notSame($value2)
    {
        return $this.notSame($value2,$null,$null)
    }
    [Assert] notSame($value2, [string] $message)
    {
        return $this.notSame($value2,$message,$null)
    }
    [Assert] notSame($value2, [string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("notSame", $args) )
        {
            return $this
        }
        if ( ($this.pValue -cne $value2) `
        -or ($($this.pValue).GetType() -ne $Value2.GetType()) )
        {
            return $this
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = 'Value "{0}" is the same as expected value "{1}".' -f [Assert]::stringify($this.pValue), [Assert]::stringify($value2)
        }

        throw $this.createException($message, $fieldName, [Assert]::INVALID_NOT_SAME)
   }

   <#    
    .SYNOPSIS
    Assert that the given string is a valid numeric id. (non-empty, non-zero, valid integer).
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
   [Assert] id()
   {
       return $this.id('', '')
   }
   [Assert] id($message)
   {
       return $this.id($message, '')
   }
   [Assert] id([string] $message, [string] $fieldName)
   {
        if ( $this.doAllOrNullOr("id", $args) )
        {
            return $this
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = 'Value "{0}" is not an numeric id.' -f [Assert]::stringify($this.pValue)
        }

        return $this.notEmpty($message, $fieldName).numeric($message, $fieldName).range(1, [int]::MaxValue, $message, $fieldName)
   }
    <#
    .SYNOPSIS
    Assert that the given string is a valid json string.
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] isJsonString()
    {
        return $this.isJsonString('', '')
    }
    [Assert] isJsonString($message)
    {
        return $this.isJsonString($message, '')
    }
    [Assert] isJsonString([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("isJsonString", $args) )
        {
            return $this
        }
        try
        {
            ConvertFrom-Json $this.pValue -ErrorAction Stop

            return $this
        } 
        catch 
        {
            if ( [string]::IsNullOrEmpty($message) )
            {
                $message = $this.pOverrideError
            }
            if ( [string]::IsNullOrEmpty($message) )
            {
                $message = 'Value "{0}" is not a valid JSON string.' -f [Assert]::stringify($this.pValue)
            }

            throw $this.createException($message, $fieldName, [Assert]::INVALID_NOT_SAME)
        }
    }

    <#
    .SYNOPSIS
    Assert that value is a string
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] base64() 
    {
        return $this.base64("","")
    } 
    [Assert] base64($message) 
    {
        return $this.base64($message,"")
    }
    #end of Overload methods
    [Assert] base64([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("base64", $args) )
        {
            return $this
        }
        try
        {
            # // If no exception is caught, then it is possibly a base64 encoded string
            [byte[]] $data = [System.Convert]::FromBase64String($this.pValue)
            # // The part that checks if the string was properly padded to the correct length
            $str = ($this.pValue.Replace(" ","").Length % 4 -eq 0)

            return $this
        }
        catch
        {
            if ( [string]::IsNullOrEmpty($message) )
            {
                $message = $this.pOverrideError
            }
            if ( [string]::IsNullOrEmpty($message) )
            {
                $message = 'Value "{0}" expected to be a base64, type "{1}" given.' -f [Assert]::stringify($this.pValue), $($this.pValue).GetType()
            }

            throw $this.createException($message, $fieldName, [Assert]::INVALID_BASE64)
        }
    }

    <#
    .SYNOPSIS
    Assert that value is a string
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] string() 
    {
        return $this.string("","")
    } 
    [Assert] string($message) 
    {
        return $this.string($message,"")
    }
    #end of Overload methods
    [Assert] string([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("string", $args) )
        {
            return $this
        }
        if ( $this.pValue -is [string] )
        {
            return $this
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = 'Value "{0}" expected to be a string, type "{1}" given.' -f [Assert]::stringify($this.pValue), $($this.pValue).GetType()
        }

        throw $this.createException($message, $fieldName, [Assert]::INVALID_STRING)
    }

    <#
    .SYNOPSIS
    Assert that value is an integer
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] int() 
    {
        return $this.int('', '')
    } 
    [Assert] int($message) 
    {
        return $this.int($message, '')
    }
    #end of Overload methods
    [Assert] int([string] $message, [string] $fieldName)
    {
        return $this.integer($message, $fieldName)
    }

    <#
    .SYNOPSIS
    Find whether the type of a variable is integer
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    To test if a variable is a number or a numeric string you must use numeric()
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] integer() 
    {
        return $this.integer('', '')
    } 
    [Assert] integer($message) 
    {
        return $this.integer($message, '')
    }
    #end of Overload methods
    [Assert] integer([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("integer", $args) )
        {
            return $this
        }
        if ( $this.pValue -is [int] )
        {
            return $this
        }

        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = 'Value "{0}" expected to be an int, type "{1}" given.'-f [Assert]::stringify($this.pValue), $($this.pValue).GetType()
        }

        throw $this.createException($message, $fieldName, [Assert]::INVALID_INTEGER)
    }

        <#
    .SYNOPSIS
    Assert that value is an array
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] array() 
    {
        return $this.array('', '')
    } 
    [Assert] array($message) 
    {
        return $this.array($message, '')
    }
    #end of Overload methods
    [Assert] array([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("array", $args) )
        {
            return $this
        }
        if ( $this.pValue -is [array] )
        {
            return $this
        }

        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = 'Value "{0}" expected to be an array, type "{1}" given.'-f [Assert]::stringify($this.pValue), $($this.pValue).GetType()
        }

        throw $this.createException($message, $fieldName, [Assert]::INVALID_ARRAY)
    }

    <#
    .SYNOPSIS
    Assert that value is a float
    .PARAMETER message
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] float()
    {
        return $this.float('', '')
    }
    [Assert] float($message)
    {
        return $this.float($message, '')
    }
    #end of Overload methods
    [Assert] float([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("float", $args) )
        {
            return $this
        }
        if ( $this.pValue -is [float] )
        {
            return $this
        }

        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = 'Value "{0}" expected to be a float, type "{1}" given.'-f [Assert]::stringify($this.pValue), $($this.pValue).GetType()
        }

        throw $this.createException($message, $fieldName, [Assert]::INVALID_FLOAT)
    }



    <#
    .SYNOPSIS
    Assert that value is a integer'ish.
    .PARAMETER message
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] integerish()
    {
        return $this.integerish('', '')
    }
    [Assert] integerish($message)
    {
        return $this.integerish($message, '')
    }
    #end of Overload methods
    [Assert] integerish([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("integerish", $args) )
        {
            return $this
        }
        # if ( is_object($this->value) || strval(intval($this->value)) != $this->value || is_bool($this->value) || is_null($this->value) )
        try
        {
            if ( $this.pValue -is [int] -or ([int]$this.pValue -like $this.pValue))
            {
                return $this
            }
        } 
        catch
        {
            if ( [string]::IsNullOrEmpty($message) )
            {
                $message = $this.pOverrideError
            }
            if ( [string]::IsNullOrEmpty($message) )
            {
                $message = 'Value "{0}" is not an integer or a number castable to integer.'-f [Assert]::stringify($this.pValue)
            }

            throw $this.createException($message, $fieldName, [Assert]::INVALID_INTEGERISH)
        }

        throw $this.createException($message, $fieldName, [Assert]::INVALID_INTEGERISH)
    }





        <#
    .SYNOPSIS
    Assert that value is a boolean
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] boolean() 
    {
        return $this.boolean('', '')
    } 
    [Assert] boolean($message) 
    {
        return $this.boolean($message, '')
    }
    #end of Overload methods
    [Assert] boolean([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("boolean", $args) )
        {
            return $this
        }
        if ( $this.pValue -is [boolean] )
        {
            return $this
        }

        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = 'Value "{0}" expected to be a boolean, type "{1}" given.' -f [Assert]::stringify($this.pValue), $($this.pValue).GetType()
        }

        throw $this.createException($message, $fieldName, [Assert]::INVALID_BOOLEAN)
    }

    <#
    .SYNOPSIS
    Assert that value is domain name.
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] domainName()
    {
        return $this.domainName('', '')
    }
    [Assert] domainName($message)
    {
        return $this.domainName($message, '')
    }
    [Assert] domainName([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("domainName", $args) )
        {
            return $this
        }
        $this.string($message, $fieldName)
        $pattern   = '^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}$'
        if ( $this.pValue -match $pattern)
        {
            return $this
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = "Value `"$($this.pValue.ToString())`" was expected to be a valid domain name."
        }

        throw $this.createException($message, $fieldName, [Assert]::INVALID_DOMAIN_NAME)
    }

    <#
    .SYNOPSIS
    Assert that value is an email adress
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] email() 
    {
        return $this.email('', '')
    } 
    [Assert] email([string] $message)
    {
        return $this.email($message, '')
    }
    #end of Overload methods
    [Assert] email ([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("email", $args) )
        {
            return $this
        }
        try
        {
            new-object net.mail.mailaddress($this.pValue)
        } 
        catch
        {
            if ( [string]::IsNullOrEmpty($message) )
            {
                $message = $this.pOverrideError
            }
            if ( [string]::IsNullOrEmpty($message) )
            {
                $message = "Value `"$($this.pValue.ToString())`" was expected to be a valid e-mail address."
            }

            throw $this.createException($message, $fieldName, [Assert]::INVALID_DOMAIN_NAME)
        }

        return $this
    }

    <#
    .SYNOPSIS
    Assert that value is an email adress
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] userPrincipalName() 
    {
        return $this.userPrincipalName('', '')
    } 
    [Assert] userPrincipalName([string] $message) 
    {
        return $this.userPrincipalName($message, '')
    }
    #end of Overload methods
    [Assert] userPrincipalName ([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("userPrincipalName", $args) )
        {
            return $this
        }
        try
        {
            $this.email($message, $fieldName)
        } 
        catch
        {
            if ( [string]::IsNullOrEmpty($message) )
            {
                $message = $this.pOverrideError
            }
            if ( [string]::IsNullOrEmpty($message) )
            {
                $message = "Value `"$($this.pValue.ToString())`" was expected to be a valid userPrincipalName."
            }

            throw $this.createException($message, $fieldName, [Assert]::INVALID_USERPRINCIPALNAME)
        }
        return $this
    }

    <#
    .SYNOPSIS
    Assert that the given string is a valid username (in line with Active directory sAMAccountName)
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] samAccountName() 
    {
        return $this.samAccountName('', '')
    } 
    [Assert] samAccountName([string] $message)
    {
        return $this.samAccountName($message, '')
    }
    #end of Overload methods
    [Assert] samAccountName([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("samAccountName", $args) )
        {
            return $this
        }
        if ( $this.pValue -match '^([a-z0-9]{4,20})$' )
        {
            return $this
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = 'Value "{0}" was expected to be a valid samAccountName.' -f [Assert]::stringify($this.pValue)
        }

        throw $this.createException($message, $fieldName, [Assert]::INVALID_SAMACCOUNTNAME)
    }

    <#
    .SYNOPSIS
    Assert that value is a valid uuid/guid
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] uuid()
    {
        return $this.uuid('', '')
    } 
    [Assert] uuid([string] $message)
    {
        return $this.uuid($message, '')
    }
    [Assert] uuid([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("uuid", $args) )
        {
            return $this
        }
        #remove any braces/punctuation etc.
        $this.pValue = $this.pValue -Replace("[\[\]\{\}\']|\burn:|\buuid:", '')
        if ( $this.pValue -eq '00000000-0000-0000-0000-000000000000' ) #nil uuid value
        {
            return $this
        }
        if ( $this.pValue -match '^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$' )
        {
            return $this
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = "Value `"$($this.pValue.ToString())`" was expected to be a valid uuid."
        }

        throw $this.createException($message, $fieldName, [Assert]::INVALID_UUID)
    }

    <#
    .SYNOPSIS
    Assert that value is a valid UNC path (e.g. \\someserver\somelocation)
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] unc()
    {
        return $this.unc('', '')
    } 
    [Assert] unc([string] $message)
    {
        return $this.unc($message, '')
    }
    [Assert] unc([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("unc", $args) )
        {
            return $this
        }
        if ( $this.pValue -match '^\\\\[a-zA-Z0-9\.\-_]{1,}(\\[a-zA-Z0-9\-_]{1,}){1,}[\$]{0,1}' )
        {
            return $this
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = "Value `"$($this.pValue.ToString())`" was expected to be a valid unc path."
        }

        throw $this.createException($message, $fieldName, [Assert]::INVALID_UNC_PATH)
    }

    <#
    .SYNOPSIS
    Assert that value is a valid drive letter (e.g. 'H:')
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] driveLetter()
    {
        return $this.driveLetter('', '')
    } 
    [Assert] driveLetter([string] $message)
    {
        return $this.driveLetter($message, '')
    }
    [Assert] driveLetter([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("driveLetter", $args) )
        {
            return $this
        }
        if ( $this.pValue -match '^[a-zA-Z]:$' )
        {
            return $this
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = "Value `"$($this.pValue.ToString())`" was expected to be a valid drive letter."
        }

        throw $this.createException($message, $fieldName, [Assert]::INVALID_DRIVE_LETTER)
    }





   <#
    .SYNOPSIS
    Assert that value matches a regex
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] regex([string] $pattern)
    {
        return $this.regex($pattern,$null,$null)
    } 
    [Assert] regex([string] $pattern,$message)
    {
        return $this.regex($pattern,$message,$null)
    }
    #end of Overload methods
    [Assert] regex([string] $pattern, [string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("regex", $args) )
        {
            return $this
        }
        $this.string($message, $fieldName)
        if ( $this.pValue -match $pattern )
        {
            return $this
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = "Value `"$($this.pValue.ToString())`" does not match the regex expression provided."
        }

        throw $this.createException($message, $fieldName, [Assert]::INVALID_REGEX)
    }

    <#
   .SYNOPSIS
    Assert that value is numeric. Includes decimal places.
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] numeric()
    {
        return $this.numeric($null, $null)
    }
    [Assert] numeric([string] $message)
    {
        return $this.numeric($message, $null)
    }
    [Assert] numeric([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("numeric", $args) )
        {
            return $this
        }
        if ( $this.pValue -match '^[\d\.]+$' )
        {
            return $this
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = "Value `"$($this.pValue.ToString())`" is not numeric."
        }

        throw $this.createException($message, $fieldName, [Assert]::INVALID_NUMERIC)
    }

    <#
   .SYNOPSIS
    Assert that value is a non-empty array.
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] nonEmptyArray()
    {
        return $this.nonEmptyArray($null, $null)
    }
    [Assert] nonEmptyArray([string] $message)
    {
        return $this.nonEmptyArray($message, "")
    }
    [Assert] nonEmptyArray([string] $message, [string] $fieldName)
    {
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = 'Value "{0}" is not a non-empty array.' -f [Assert]::stringify($this.pValue)
        }

        return $this.isArray($message, $fieldName).notEmpty($message, $fieldName);
    }

    <#
    .SYNOPSIS
    Assert that value is a non-empty integer
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] nonEmptyInt() 
    {
        return $this.nonEmptyInt('', '')
    } 
    [Assert] nonEmptyInt([string] $message)
    {
        return $this.nonEmptyInt($message, '')
    }
    #end of Overload methods
    [Assert] nonEmptyInt([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("nonEmptyInt", $args) )
        {
            return $this
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = 'Value "{0}" is not a non-empty int.' -f [Assert]::stringify($this.pValue)
        }

        return $this.int($message, $fieldName).notEmpty($message, $fieldName)
    }

    <#
    .SYNOPSIS
    Assert that value is a non-empty string.
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] nonEmptyString() 
    {
        return $this.nonEmptyString('', '')
    } 
    [Assert] nonEmptyString([string] $message)
    {
        return $this.nonEmptyString($message, '')
    }
    #end of Overload methods
    [Assert] nonEmptyString([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("nonEmptyString", $args) )
        {
            return $this
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = 'Value "{0}" is not a non-empty string.' -f [Assert]::stringify($this.pValue)
        }

        return $this.string($message, $fieldName).notEmpty($message, $fieldName)
    }

    <# 
    .SYNOPSIS
    Assert that value is in range of numbers.
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] range($minValue, $maxValue)
    {
        return $this.range($minValue, $maxValue, $null, $null)
    }
    [Assert] range($minValue, $maxValue, [string] $message)
    {
        return $this.range($minValue, $maxValue, [string] $message, '')
    }
    [Assert] range($minValue, $maxValue, [string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("range", $args) )
        {
            return $this
        }
        $this.numeric($message, $fieldName)
        if ( ($([convert]::ToDouble($this.pValue)) -ge $([convert]::ToDouble($minValue)))`
        -and ($([convert]::ToDouble($this.pValue)) -le $([convert]::ToDouble($maxValue))) )
        {
            return $this
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = "Number `"$($this.pValue.ToString())`" was expected to be at least `"$($minValue.ToString())`" and at most `"$($maxValue.ToString())`"."
        }

        throw $this.createException($message, $fieldName, [Assert]::INVALID_RANGE, @{"min"=$minValue;"max"=$maxValue})
    }

    <#
    .SYNOPSIS
    Assert that value is not empty.
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] notEmpty() 
    {
        return $this.notEmpty('', '')
    } 
    [Assert] notEmpty([string] $message)
    {
        return $this.notEmpty($message, '')
    }
    #end of Overload methods
    [Assert] notEmpty([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("notEmpty", $args) )
        {
            return $this
        }
        if ( $([bool]$this.pValue) )
        {
            return $this
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = "Value `"$($this.pValue.ToString())`" is empty, but non empty value was expected."
        }

        throw $this.createException($message, $fieldName, [Assert]::VALUE_EMPTY)
    }

    <#
    .SYNOPSIS
    Assert that value is not null
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    Empty is determined the same as php empty http://php.net/manual/en/function.empty.php
        The following things are considered to be empty:

        "" (an empty string)
        0 (0 as an integer)
        0.0 (0 as a float)
        "0" (0 as a string)
        NULL
        FALSE
        array() (an empty array)
        $var; (a variable declared, but without a value)
    #>
    [Assert] notNullOrEmpty()
    {
        return $this.notNullOrEmpty('', '')
    } 
    [Assert] notNullOrEmpty([string] $message)
    {
        return $this.notNullOrEmpty($message, '')
    }
    #end of Overload methods
    [Assert] notNullOrEmpty([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("notNullOrEmpty", $args) )
        {
            return $this
        }
        if ( (-not ($this.pValue -like $null)) -and $([bool]$this.pValue) )
        {
            return $this
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = "Value `"$($this.pValue)`" is null or empty, but non null or empty value was expected."
        }

        throw $this.createException($message, $fieldName, [Assert]::VALUE_NULL)
    }

    <#
    .SYNOPSIS
    Assert that the value is boolean True.
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] true()
    {
        return $this.true('', '')
    } 
    [Assert] true([string] $message)
    {
        return $this.true($message, '')
    }
    #end of Overload methods
    [Assert] true([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("true", $args) )
        {
            return $this
        }
        $this.boolean($message, $fieldName)
        
        if ( $this.pValue -eq $true )
        {
            return $this
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = "Value `"$($this.pValue.ToString())`" is not TRUE."
        }

        throw $this.createException($message, $fieldName, [Assert]::INVALID_TRUE)
    }

    <#
    .SYNOPSIS
    Assert that the value is boolean False.
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] false()
    {
        return $this.false('', '')
    } 
    [Assert] false([string] $message)
    {
        return $this.false($message, '')
    }
    #end of Overload methods
    [Assert] false([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("false", $args) )
        {
            return $this
        }
        $this.boolean($message, $fieldName)
        
        if ( $this.pValue -eq $false )
        {
            return $this
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = "Value `"$($this.pValue.ToString())`" is not FALSE."
        }

        throw $this.createException($message, $fieldName, [Assert]::INVALID_FALSE)
    }

    <#
    .SYNOPSIS
    Make a string version of a value.
    .PARAMETER value
    .NOTES
    @return string
    #>
    Hidden [bool] canBeTraversed()
    {
        if ( (-not ($this.pValue -is [array])) -and ((-not($this.pValue -is [System.Collections.IEnumerable])) -or ($this.pValue -is [string])) )
        {
            return $false
        }
        return $true
    }

    <#
    .SYNOPSIS
    Assert that value is an object. Objects are have IsValueType eq false, also strings are excluded.
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER fieldName
    The field name
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] isObject() 
    {
        return $this.isObject("","")
    } 
    [Assert] isObject([string] $message) 
    {
        return $this.isObject($message,"")
    }
    #end of Overload methods
    [Assert] isObject([string] $message, [string] $fieldName)
    {
        if ( $this.doAllOrNullOr("isObject", $args) )
        {
            return $this
        }

        if ( ($this.pValue.GetType().IsValueType -eq $false) -and (-not($this.pValue -is [string])) )
        {
            return $this
        }

        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.pOverrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = 'Value "{0}" expected to be an object, type "{1}" given.' -f [Assert]::stringify($this.pValue), $($this.pValue).GetType()
        }

        throw $this.createException($message, $fieldName, [Assert]::INVALID_OBJECT)
    }

    <#
    .SYNOPSIS
    Make a string version of a value.
    .PARAMETER value
    .NOTES
    @return string
    #>
    static [string] stringify($value)
    {
        if ( $value -eq $null)
        {
            return "<NULL>"
        }
        if ( $value -is [boolean])
        {
            if ($value)
            {
                return "<TRUE>"
            }
            return "<FALSE>"
        }
        if ( $value -is [array])
        {
            return "<ARRAY>"
        }
        if ( $value -is [PSObject])
        {
            return $("<" + $($value.getType()) + ">").ToUpper()
        }
        # All other types
        if ( $value.length -gt 100 )
        {

            return $($value.toString()).Substring(0, 97) + '...'
        }

        return $value.toString()
    }

}

 Export-ModuleMember -Function * -Cmdlet *
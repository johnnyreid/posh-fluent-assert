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
    static $INVALID_DIRECTORY           = 101
    static $INVALID_FILE                = 102
    static $INVALID_READABLE            = 103
    static $INVALID_WRITEABLE           = 104
    static $INVALID_CLASS               = 105
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

    static $EMERGENCY                   = 'emergency'
    static $ALERT                       = 'alert'
    static $CRITICAL                    = 'critical'
    static $GENERAL_ERROR               = 'error'
    static $WARNING                     = 'warning'
    static $NOTICE                      = 'notice'
    static $INFO                        = 'info'
    static $DEBUG                       = 'debug'

    Hidden [bool]   $nullOr             = $false

    Hidden [bool]   $emptyOr            = $false

    Hidden          $value              = $null

    Hidden [bool]   $all                = $false

    Hidden [string] $fieldName          = ''

    Hidden [string] $propertyPath       = ''                #can include a full propertypath if you desire but this is generally used for fieldName

    Hidden [string] $level              = 'critical'

    Hidden [int]    $overrideCode       = $null

    Hidden [string] $overrideError      = ''

    # Invocation location details
    Hidden [string] $file               = ''

    Hidden [int]    $line               = $null

    $exceptionClass = [AssertionFailedException]::class



    #constructor and overloads
    Assert($value)
    {
        $this.Assert($value, '', 0, '', [Assert]::WARNING)
    }
    Assert($value, [string] $fieldName)
    {
        $this.Assert($value, $fieldName, 0, '', [Assert]::WARNING)
    }
    Assert($value, [string] $fieldName, [int] $code)
    {
        $this.Assert($value, $fieldName, $code, '', [Assert]::WARNING)
    }
    Assert($value, [string] $fieldName, [int] $code, [string] $overrideError)
    {
        $this.Assert($value, $fieldName, $code, $overrideError, [Assert]::WARNING)
    }
    Assert($value, [string] $fieldName, [int] $code, [string] $overrideError, [string] $level)
    {
        if ( $fieldName )
        {
            $this.fieldName($fieldName)
        }
        if ( $code )
        {
            $this.code($code)
        }
        if ( $error )
        {
            $this.error($error)
        }
        if ( $level )
        {
            $this.level($level)
        }
    }

    static [Assert] that($value)
    {

        return [Assert]::that($value, '', 0, '', [Assert]::WARNING)
    }
    static [Assert] that($value, [string] $fieldName)
    {

        return [Assert]::that($value, $fieldName, 0, '', [Assert]::WARNING)
    }
    static [Assert] that($value, [string] $fieldName, [int] $code, [string] $overrideError, [string] $level)
    {

        return [Assert]::that($value, $fieldName, $code, '', [Assert]::WARNING)
    }
    static [Assert] that($value, [string] $fieldName, [int] $code, [string] $overrideError)
    {

        return [Assert]::that($value, $fieldName, $code, $overrideError, [Assert]::WARNING)
    }
    static [Assert] that($value, [string] $fieldName, [int] $code, [string] $overrideError, [string] $level)
    {

        return [Assert]::that($value, $fieldName, $code, $overrideError, $level)
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
    @return Assert
    #>
    [Assert] value($value)
    {
        $this.value = $value

        return $this
    }

    <#
    .NOTES
    @param bool $nullOr
    @return Assert
    #>
    [Assert] nullOr([bool] $nullOr)
    {
        $this.nullOr = $nullOr

        return $this
    }

    <#
    .NOTES
    @param bool $emptyOr
    @return Assert
    #>
    [Assert] emptyOr([bool] $emptyOr)
    {
        $this.emptyOr = $emptyOr

        return $this
    }

    <#
    .NOTES
    @param bool $all
    @return Assert
    #>
    [Assert] all([bool] $all)
    {
        $this.all = $all

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
    .PARAMETER propertyPath
    The property path
    .PARAMETER constraints 
    An array of constraints
    .PARAMETER level 
    A string representing the severity of the error
    .NOTES
    return AssertionFailedException
    # Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [AssertionFailedException] createException([string] $message, [int] $code, [string] $fieldName) 
    {
        return $this.createException($message, $code, $fieldName, [array]::new(), '')
    }
    
    [AssertionFailedException] createException([string] $message, [int] $code, [string] $fieldName, [array] $constraints) 
    {
        return $this.createException($message, $code, $fieldName, $constraints, '')
    }

    [AssertionFailedException] createException([string] $message, [int] $code, [string] $fieldName, [array] $constraints, [string] $level)
    {
        if ( [string]::IsNullOrEmpty($fieldName) )
        {
            $fieldName = $this.fieldName
        }
        if ( [string]::IsNullOrEmpty($level) )
        {
            $level = $this.level
        }

        return [AssertionFailedException]::new($message, $code, $fieldName, $this.value, $constraints, $level, $this.file, $this.line)
    }

    <#
    .NOTES
    @param int $code
    @return Assert
    #>
    [Assert] code([int] $code)
    {
        $this.code = $code

        return $this
    }

        <#
    .NOTES
    @param string $fieldName
    @return Assert
    #>
    [Assert] fieldName([string] $fieldName)
    {
        $this.fieldName = $fieldName

        return $this
    }

    <#
    .NOTES
    @param string $level
    @return Assert
    #>
    [Assert] level([string] $level)
    {
        $this.level = $level

        return $this
    }

    <#
    .NOTES
    @param string $overrideError
    @return Assert
    #>
    [Assert] overrideError([string] $overrideError)
    {
        $this.overrideError = $overrideError
        
        return $this
    }

    <#
    .NOTES
     User controlled way to define a sub-property causing
     the failure of a currently asserted objects.
    
     Useful to transport information about the nature of the error
     back to higher layers.
    
     @param string $propertyPath
     @return Assert
    #>
    [Assert] propertyPath([string] $propertyPath)
    {
        $this.propertyPath = $propertyPath

        return $this
    }

    <#
    .NOTES
    @param string $file
    @return Assert
    #>
    [Assert] file([string] $file)
    {
        $this.file = $file

        return $this
    }

    <#
    .NOTES
    @param int $line
    @return Assert
    #>
    [Assert] line([int] $line)
    {
        $this.line = $line

        return $this
    }

    <#
     @param $func
     @param $args
     @return bool
     @throws AssertionFailedException
    #>
    hidden [bool] doAllOrNullOr()
    {
        # TODO: FIX THIS METHOD
        # if ( $this->nullOr && is_null($this->value) )
        # {
        #     return true;
        # }
        # if ( $this->emptyOr && empty($this->value) )
        # {
        #     return true;
        # }
        # if ( $this->all && (new Assert($this->value))->setExceptionClass($this->exceptionClass)->isTraversable() )
        # {
        #     foreach ( $this->value as $idx => $value )
        #     {
        #         $object = (new Assert($value))->setExceptionClass($this->exceptionClass);
        #         call_user_func_array([$object, $func], $args);
        #     }
        #     return true;
        # }

        # return ( $this->nullOr && is_null($this->value) ) || ( $this->emptyOr && empty($this->value) ) ? true : false;
        return $false
    }

    <# 
    .SYNOPSIS
    Assert that two values are equal (using "-ceq" which is case sensitive).
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
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
        if ( $this.doAllOrNullOr() )
        {
            return $this
        }

        if ( $this.value -ceq $value2 )
        {

            return $this
            Exit
        }

        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = $this.overrideError
        }
        if ( [string]::IsNullOrEmpty($message) )
        {
            $message = "Value `"$($this.value.ToString())`" does not equal expected value `"$($value2.tostring())`"."
        }
        if ( -not ($returnOverrideCode) )
        {
            $returnOverrideCode = [ERRORS]::INVALID_EQ
        }

        throw $this.createException($message, $returnOverrideCode, $propertyPath, $this.pLevel, $null)
    }

    <# 
    .SYNOPSIS
    Assert that a value is greater than another
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] greaterThan($value2)
    {
        return $this.greaterThan($value2, $null, $null)
    }
    [Assert] greaterThan($value2, [string] $message)
    {
        return $this.greaterThan($value2, [string] $message, '')
    }
    [Assert] greaterThan($value2, $message, [string] $fieldName)
    {
        $returnOverrideCode = $this.pOverrideCode
        if ( -not ( $this.value -cgt $value2 ) )
        {
            if ( -not ($message) )
            {
                $message = $this.pOverrideError
            }
            if ( -not ($message) )
            {
                $message = "Value `"$($this.value.ToString())`" is not greater than value `"$($value2.tostring())`"."
            }
            if ( -not ($returnOverrideCode) )
            {
                $returnOverrideCode = [ERRORS]::INVALID_GREATER_THAN
            }
            throw $this.createException($message, $returnOverrideCode, $propertyPath, $this.pLevel, $null)
        }
        return $this;
    }

    <# 
    .SYNOPSIS
    Assert that a value is greater than or equal to another
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] greaterThanOrEq($value2)
    {
        return $this.greaterThanOrEq($value2, $null, $null)
    }
    [Assert] greaterThanOrEq($value2, [string] $message)
    {
        return $this.greaterThanOrEq($value2, [string] $message, '')
    }
    [Assert] greaterThanOrEq($value2, $message, [string] $fieldName)
    {
        $returnOverrideCode = $this.pOverrideCode
        if ( -not ( $this.value -cge $value2 ) )
        {
            if ( -not ($message) )
            {
                $message = $this.pOverrideError
            }
            if ( -not ($message) )
            {
                $message = "Value `"$($this.value.ToString())`" is not greater than or equal to value `"$($value2.tostring())`"."
            }
            if ( -not ($returnOverrideCode) )
            {
                $returnOverrideCode = [ERRORS]::INVALID_GREATER_THAN_OR_EQ
            }
            throw $this.createException($message, $returnOverrideCode, $propertyPath, $this.pLevel, $null)
        }
        return $this;
    }

    <# 
    .SYNOPSIS
    Assert that a value is less than another
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] lessThan($value2)
    {
        return $this.lessThan($value2, $null, $null)
    }
    [Assert] lessThan($value2, [string] $message)
    {
        return $this.lessThan($value2, [string] $message, '')
    }
    [Assert] lessThan($value2, $message, [string] $fieldName)
    {
        $returnOverrideCode = $this.pOverrideCode
        if ( -not ( $this.value -clt $value2 ) )
        {
            if ( -not ($message) )
            {
                $message = $this.pOverrideError
            }
            if ( -not ($message) )
            {
                $message = "Value `"$($this.value.ToString())`" is not less than value `"$($value2.tostring())`"."
            }
            if ( -not ($returnOverrideCode) )
            {
                $returnOverrideCode = [ERRORS]::INVALID_LESS_THAN
            }
            throw $this.createException($message, $returnOverrideCode, $propertyPath, $this.pLevel, $null)
        }
        return $this;
    }

    <# 
    .SYNOPSIS
    Assert that a value is less than or equal to another
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] lessThanOrEq($value2)
    {
        return $this.lessThanOrEq($value2, $null, $null)
    }
    [Assert] lessThanOrEq($value2, [string] $message)
    {
        return $this.lessThanOrEq($value2, [string] $message, '')
    }
    [Assert] lessThanOrEq($value2, $message, [string] $fieldName)
    {
        $returnOverrideCode = $this.pOverrideCode
        if ( -not ( $this.value -cle $value2 ) )
        {
            if ( -not ($message) )
            {
                $message = $this.pOverrideError
            }
            if ( -not ($message) )
            {
                $message = "Value `"$($this.value.ToString())`" is not less than or equal to value `"$($value2.tostring())`"."
            }
            if ( -not ($returnOverrideCode) )
            {
                $returnOverrideCode = [ERRORS]::INVALID_LESS_THAN_OR_EQ
            }
            throw $this.createException($message, $returnOverrideCode, $propertyPath, $this.pLevel, $null)
        }
        return $this;
    }

    <# 
    .SYNOPSIS
    Assert that two values are the same (equal and of the same type)
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
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
    [Assert] same($value2, $message, [string] $fieldName)
    {
        $returnOverrideCode = $this.pOverrideCode
        
        if ( ($this.value -ceq $value2) `
        -and ($($this.value).GetType() -eq $Value2.GetType()) )
        {
            return $this
            Exit
        }

        if ( -not ($message) )
        {
            $message = $this.pOverrideError
        }
        if ( -not ($message) )
        {
            $message = "Value `"$($this.value.ToString())`" is not the same as expected value `"$($value2.tostring())`"."
        }
        if ( -not ($returnOverrideCode) )
        {
            $returnOverrideCode = [ERRORS]::INVALID_SAME
        }

        throw $this.createException($message, $returnOverrideCode, $propertyPath, $this.pLevel, $null)
    }

    <#
    .SYNOPSIS
    Assert that two values are not equal (using -ceq, case sensitive ).
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
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
    [Assert] notEq($value2, $message, [string] $fieldName)
    {
        $returnOverrideCode = $this.pOverrideCode
        if ( $this.value -cne $value2 )
        {
            return $this
            Exit
        }
        if ( -not ($message) )
        {
            $message = $this.pOverrideError
        }
        if ( -not ($message) )
        {
            $message = "Value `"$($this.value.ToString())`" is equal to value `"$($value2.tostring())`"."
        }
        if ( -not ($returnOverrideCode) )
        {
            $returnOverrideCode = [ERRORS]::INVALID_NOT_EQ
        }

        throw $this.createException($message, $returnOverrideCode, $propertyPath, $this.pLevel, $null)
    }

    <# 
    .SYNOPSIS
    Assert that two values are not the same (equal and of the same type)
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
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
    [Assert] notSame($value2, $message, [string] $fieldName)
    {
        if ( ($this.value -cne $value2) `
        -or ($($this.value).GetType() -ne $Value2.GetType()) )
        {
            return $this
            Exit
        }

        $returnOverrideCode = $this.pOverrideCode
        if ( -not ($message) )
        {
            $message = $this.pOverrideError
        }
        if ( -not ($message) )
        {
            $message = "Value `"$($this.value.ToString())`" is the same as expected value `"$($value2.tostring())`"."
        }
        if ( -not ($returnOverrideCode) )
        {
            $returnOverrideCode = [ERRORS]::INVALID_NOT_SAME
        }

        throw $this.createException($message, $returnOverrideCode, $propertyPath, $this.pLevel, $null)
   }


    <#    
    .SYNOPSIS
    Assert that the given string is a valid json string.
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] isJsonString()
    {
        return $this.isJsonString($null,$null)
    }
    [Assert] isJsonString($message)
    {
        return $this.isJsonString($message,$null)
    }
    [Assert] isJsonString($message, [string] $fieldName)
    {
        try
        {
            ConvertFrom-Json $this.value -ErrorAction Stop
            return $this
            Exit
        } 
        catch 
        {
            $returnOverrideCode = $this.pOverrideCode
            if ( -not ($message) )
            {
                $message = $this.pOverrideError
            }
            if ( -not ($message) )
            {
                $message = "Value `"$($this.value.ToString())`" is not a valid JSON string."
            }
            if ( -not ($returnOverrideCode) )
            {
                $returnOverrideCode = [ERRORS]::INVALID_NOT_SAME
            }
    
            throw $this.createException($message, $returnOverrideCode, $propertyPath, $this.pLevel, $null)
        }
    }

    <#
    .SYNOPSIS
    Assert that value is a string
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
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
    [Assert] string($message, [string] $fieldName)
    {
        if ( $this.value -is [string] )
        {
            return $this
            Exit
        }

        $returnOverrideCode = $this.pOverrideCode
        if ( -not ($message) )
        {
            $message = $this.pOverrideError
        }
        if ( -not ($message) )
        {
            $message = "Value `"$($this.value.ToString())`" expected to be a string, type `"$($($this.value).GetType())`" given."
        }
        if ( -not ($returnOverrideCode) )
        {
            $returnOverrideCode = [ERRORS]::INVALID_STRING
        }

        throw $this.createException($message, $returnOverrideCode, $propertyPath, $this.pLevel, $null)
    }

    <#
    .SYNOPSIS
    Assert that value is an integer
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] int() 
    {
        return $this.int($null,$null)
    } 
    [Assert] int($message) 
    {
        return $this.int($message,$null)
    }
    #end of Overload methods
    [Assert] int($message, [string] $fieldName)
    {
        if ( $this.value -is [int] )
        {
            return $this
            Exit
        }

        $returnOverrideCode = $this.pOverrideCode
        if ( -not ($message) )
        {
            $message = $this.pOverrideError
        }
        if ( -not ($message) )
        {
            $message = "Value `"$($this.value.ToString())`" expected to be an int, type `"$($($this.value).GetType())`" given."
        }
        if ( -not ($returnOverrideCode) )
        {
            $returnOverrideCode = [ERRORS]::INVALID_INTEGER
        }

        throw $this.createException($message, $returnOverrideCode, $propertyPath, $this.pLevel, $null)
    }

        <#
    .SYNOPSIS
    Assert that value is a boolean
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] boolean() 
    {
        return $this.boolean($null,$null)
    } 
    [Assert] boolean($message) 
    {
        return $this.boolean($message,$null)
    }
    #end of Overload methods
    [Assert] boolean($message, [string] $fieldName)
    {
        if ( $this.value -is [boolean] )
        {
            return $this
            Exit
        }

        $returnOverrideCode = $this.pOverrideCode
        if ( -not ($message) )
        {
            $message = $this.pOverrideError
        }
        if ( -not ($message) )
        {
            $message = "Value `"$($this.value.ToString())`" expected to be a boolean, type `"$($($this.value).GetType())`" given."
        }
        if ( -not ($returnOverrideCode) )
        {
            $returnOverrideCode = [ERRORS]::INVALID_BOOLEAN
        }

        throw $this.createException($message, $returnOverrideCode, $propertyPath, $this.pLevel, $null)
    }

    <#
    .SYNOPSIS
    Assert that value is domain name.
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] domainName()
    {
        return $this.domainName($null,$null)
    }
    [Assert] domainName($message)
    {
        return $this.domainName($message,$null)
    }
    [Assert] domainName($message, [string] $fieldName)
    {
        $this.string($message, [string] $fieldName)
        $pattern   = '^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}$';
        
        if ( $this.value -match $pattern)
        {
            return $this
            Exit
        }

        $returnOverrideCode = $this.pOverrideCode
        if ( -not ($message) )
        {
            $message = $this.pOverrideError
        }
        if ( -not ($message) )
        {
            $message = "Value `"$($this.value.ToString())`" was expected to be a valid domain name."
        }
        if ( -not ($returnOverrideCode) )
        {
            $returnOverrideCode = [ERRORS]::INVALID_DOMAIN_NAME
        }

        throw $this.createException($message, $returnOverrideCode, $propertyPath, $this.pLevel, $null)
    }

    <#
    .SYNOPSIS
    Assert that value is an email adress
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] email() 
    {
        return $this.email($null,$null)
    } 
    [Assert] email($message) 
    {
        return $this.email($message,$null)
    }
    #end of Overload methods
    [Assert] email ($message, [string] $fieldName)
    {
        try
        {
            new-object net.mail.mailaddress($this.value)
        } 
        catch
        {
            $returnOverrideCode = $this.pOverrideCode
            if ( -not ($message) )
            {
                $message = $this.pOverrideError
            }
            if ( -not ($message) )
            {
                $message = "Value `"$($this.value.ToString())`" was expected to be a valid e-mail address."
            }
            if ( -not ($returnOverrideCode) )
            {
                $returnOverrideCode = [ERRORS]::INVALID_DOMAIN_NAME
            }

            throw $this.createException($message, $returnOverrideCode, $propertyPath, $this.pLevel, $null)
        }
        return $this
    }

    <#
    .SYNOPSIS
    Assert that value is an email adress
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] userPrincipalName() 
    {
        return $this.userPrincipalName($null,$null)
    } 
    [Assert] userPrincipalName($message) 
    {
        return $this.userPrincipalName($message,$null)
    }
    #end of Overload methods
    [Assert] userPrincipalName ($message, [string] $fieldName)
    {
        try
        {
            $this.email($message,$propertyPath)
        } 
        catch
        {
            $returnOverrideCode = $this.pOverrideCode
            if ( -not ($message) )
            {
                $message = $this.pOverrideError
            }
            if ( -not ($message) )
            {
                $message = "Value `"$($this.value.ToString())`" was expected to be a valid userPrincipalName."
            }
            if ( -not ($returnOverrideCode) )
            {
                $returnOverrideCode = [ERRORS]::INVALID_
            }

            throw $this.createException($message, $returnOverrideCode, $propertyPath, $this.pLevel, $null)
        }
        return $this
    }


    




   <#
    .SYNOPSIS
    Assert that the given string is a valid username (in line with Active directory sAMAccountName)
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] samAccountName() 
    {
        return $this.samAccountName($null,$null)
    } 
    [Assert] samAccountName($message)
    {
        return $this.samAccountName($message,$null)
    }
    #end of Overload methods
    [Assert] samAccountName($message, [string] $fieldName)
    {
        if ( $this.value -match '^([a-z0-9]{4,20})$' )
        {
            return $this
            Exit
        }

        $returnOverrideCode = $this.pOverrideCode
        if ( -not ($message) )
        {
            $message = $this.pOverrideError
        }
        if ( -not ($message) )
        {
            $message = "Value `"$($this.value.ToString())`" was expected to be a valid samAccountName."
        }
        if ( -not ($returnOverrideCode) )
        {
            $returnOverrideCode = [ERRORS]::INVALID_SAMACCOUNTNAME
        }

        throw $this.createException($message, $returnOverrideCode, $propertyPath, $this.pLevel, $null)
    }

    <#
    .SYNOPSIS
    Assert that value is a valid uuid/guid
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] uuid()
    {
        return $this.uuid($null,$null)
    } 
    [Assert] uuid($message)
    {
        return $this.uuid($message,$null)
    }
    [Assert] uuid($message, [string] $fieldName)
    {
        #remove any braces/punctuation etc.
        $this.value = $this.value -Replace("[\[\]\{\}\']|\burn:|\buuid:", '')
        if ( $this.value -eq '00000000-0000-0000-0000-000000000000' ) #nil uuid value
        {
            return $this
            Exit
        }
        if ( $this.value -match '^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$' )
        {
            return $this
            Exit
        }

        $returnOverrideCode = $this.pOverrideCode
        if ( -not ($message) )
        {
            $message = $this.pOverrideError
        }
        if ( -not ($message) )
        {
            $message = "Value `"$($this.value.ToString())`" was expected to be a valid uuid."
        }
        if ( -not ($returnOverrideCode) )
        {
            $returnOverrideCode = [ERRORS]::INVALID_UUID
        }

        throw $this.createException($message, $returnOverrideCode, $propertyPath, $this.pLevel, $null)
    }


   <#
    .SYNOPSIS
    Assert that value matches a regex
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] regex($pattern)
    {
        return $this.regex($pattern,$null,$null)
    } 
    [Assert] regex($pattern,$message)
    {
        return $this.regex($pattern,$message,$null)
    }
    #end of Overload methods
    [Assert] regex($pattern, $message, [string] $fieldName)
    {
        $this.string($message, [string] $fieldName);
        if ( $this.value -match $pattern )
        {
            return $this
            Exit
        }

        $returnOverrideCode = $this.pOverrideCode
        if ( -not ($message) )
        {
            $message = $this.pOverrideError
        }
        if ( -not ($message) )
        {
            $message = "Value `"$($this.value.ToString())`" does not match the regex expression provided."
        }
        if ( -not ($returnOverrideCode) )
        {
            $returnOverrideCode = [ERRORS]::INVALID_REGEX
        }

        throw $this.createException($message, $returnOverrideCode, $propertyPath, $this.pLevel, $null)
    }

    <#
   .SYNOPSIS
    Assert that value is numeric.
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
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
    [Assert] numeric($message)
    {
        return $this.numeric($message, $null)
    }
    [Assert] numeric($message, [string] $fieldName)
    {
        if ( $this.value -match '^[\d\.]+$' )
        {
            return $this
            Exit
        }

        $returnOverrideCode = $this.pOverrideCode
        if ( -not ($message) )
        {
            $message = $this.pOverrideError
        }
        if ( -not ($message) )
        {
            $message = "Value `"$($this.value.ToString())`" is not numeric."
        }
        if ( -not ($returnOverrideCode) )
        {
            $returnOverrideCode = [ERRORS]::INVALID_NUMERIC
        }

        throw $this.createException($message, $returnOverrideCode, $propertyPath, $this.pLevel, $null)
    }

    <# 
    .SYNOPSIS
    Assert that value is in range of numbers.
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
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
    [Assert] range($minValue, $maxValue, $message, [string] $fieldName)
    {
        $this.numeric($message, [string] $fieldName)
        
        if ( ($([convert]::ToDouble($this.value)) -ge $([convert]::ToDouble($minValue)))`
        -and ($([convert]::ToDouble($this.value)) -le $([convert]::ToDouble($maxValue))) )
        {
            return $this
            Exit
        }

        $returnOverrideCode = $this.pOverrideCode
        if ( -not ($message) )
        {
            $message = $this.pOverrideError
        }
        if ( -not ($message) )
        {
            $message = "Number `"$($this.value.ToString())`" was expected to be at least `"$($minValue.ToString())`" and at most `"$($maxValue.ToString())`"."
        }
        if ( -not ($returnOverrideCode) )
        {
            $returnOverrideCode = [ERRORS]::INVALID_RANGE
        }

        throw $this.createException($message, $returnOverrideCode, $propertyPath, $this.pLevel, @{"min"=$minValue;"max"=$maxValue})
    }

    <#
    .SYNOPSIS
    Assert that value is a non-empty integer
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] nonEmptyInt() 
    {
        return $this.nonEmptyInt($null,$null)
    } 
    [Assert] nonEmptyInt($message)
    {
        return $this.nonEmptyInt($message,$null)
    }
    #end of Overload methods
    [Assert] nonEmptyInt($message, [string] $fieldName)
    {
        $messageOut = "Value " + $this.value + " expected to be a non-empty value."
        $propertyPathOut = $this.propertyPath
        if ($this.value) 
        {
            if ( $this.value -isnot [int] )
            {
                $messageOut = "Value " + $this.Value + " expected to be an int, type " + $this.value.GetType().ToString() + " given."
                $propertyPathOut = $this.propertyPath
                
                if ( $message )
                {
                    $messageOut = $message
                }   
                elseif ( $this.OverrideError )
                {
                    $messageOut = $this.OverrideError
                }
                if ( $propertyPath )
                {
                    $propertyPathOut = $propertyPath 
                }
                $this.OverrideCode = [ERRORS]::INVALID_INTEGER
                throw $this.createException($messageOut,$this.OverrideCode, $propertyPathOut)
            }
        }
        else 
        {
            if ( $message )
            {
                $messageOut = $message
            }   
            elseif ( $this.OverrideError )
            {
                $messageOut = $this.OverrideError
            }
            if ( $propertyPath )
            {
                $propertyPathOut = $propertyPath 
            }
            $this.OverrideCode = $this.VALUE_EMPTY
            throw $this.createException($messageOut,$this.OverrideCode, $propertyPathOut, $this.pLevel, $null)
        }
        return $this
    }
 

    <#
    .SYNOPSIS
    Assert that value is not null
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
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
    [Assert] notNullOrEmpty(){
        return $this.notNullOrEmpty($null,$null)
    } 
    [Assert] notNullOrEmpty($message)
    {
        return $this.notNullOrEmpty($message,$null)
    }
    #end of Overload methods
    #empty is determined by 
    [Assert] notNullOrEmpty($message, [string] $fieldName)
    {
        if ( (-not ($this.value -like $null)) `
        -and $([bool]$this.value) )
        {
            return $this
            Exit
        }

        $returnOverrideCode = $this.pOverrideCode
        if ( -not ($message) )
        {
            $message = $this.pOverrideError
        }
        if ( -not ($message) )
        {
            $message = "Value `"$($this.value)`" is null or empty, but non null or empty value was expected."
        }
        if ( -not ($returnOverrideCode) )
        {
            $returnOverrideCode = [ERRORS]::VALUE_NULL
        }

        throw $this.createException($message, $returnOverrideCode, $propertyPath, $this.pLevel, $null)
    }

    <#
    .SYNOPSIS
    Assert that the value is boolean True.
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] true(){
        return $this.true($null,$null)
    } 
    [Assert] true($message)
    {
        return $this.true($message,$null)
    }
    #end of Overload methods
    [Assert] true($message, [string] $fieldName)
    {
        $this.boolean($message, [string] $fieldName)
        
        if ( $this.value -eq $true )
        {
            return $this
            Exit
        }

        $returnOverrideCode = $this.pOverrideCode
        if ( -not ($message) )
        {
            $message = $this.pOverrideError
        }
        if ( -not ($message) )
        {
            $message = "Value `"$($this.value.ToString())`" is not TRUE."
        }
        if ( -not ($returnOverrideCode) )
        {
            $returnOverrideCode = [ERRORS]::INVALID_TRUE
        }

        throw $this.createException($message, $returnOverrideCode, $propertyPath, $this.pLevel, $null)
    }

    <#
    .SYNOPSIS
    Assert that the value is boolean False.
    .PARAMETER message 
    A message that is added to the Exception if parsing fails
    .PARAMETER propertyPath
    The property path
    .NOTES
    @return Assert
    @throws AssertionFailedException
    .NOTES
    Overload methods because "A param block is not allowed in a class method" and we cannot use optional parameters in functions.
    #>
    [Assert] false(){
        return $this.false($null,$null)
    } 
    [Assert] false($message)
    {
        return $this.false($message,$null)
    }
    #end of Overload methods
    [Assert] false($message, [string] $fieldName)
    {
        $this.boolean($message, [string] $fieldName)
        
        if ( $this.value -eq $false )
        {
            return $this
            Exit
        }

        $returnOverrideCode = $this.pOverrideCode
        if ( -not ($message) )
        {
            $message = $this.pOverrideError
        }
        if ( -not ($message) )
        {
            $message = "Value `"$($this.value.ToString())`" is not FALSE."
        }
        if ( -not ($returnOverrideCode) )
        {
            $returnOverrideCode = [ERRORS]::INVALID_FALSE
        }

        throw $this.createException($message, $returnOverrideCode, $propertyPath, $this.pLevel, $null)
    }


}

Enum Levels{
    EMERGENCY                   = 1
    ALERT                       = 2
    CRITICAL                    = 3
    ERROR                       = 4
    WARNING                     = 5
    NOTICE                      = 6
    INFO                        = 7
    DEBUG                       = 8
}


Enum ERRORS{
    
}

Export-ModuleMember -Function * -Cmdlet *
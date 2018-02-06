# using module '..\Modules\Assert\Assert.psm1'
Import-Module ".\Assert.psd1" -Force

InModuleScope "Assert"{
    Describe "Method: `"eq`""{
        Context ": Different integer values"{
            $value1 = 1
            $value2 = 2
            It "Should throw an exception"{
                {[Assert]::new($value1).eq($value2)} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).eq($value2)
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - not equal"{
                {
                    [Assert]::new($value1).eq($value2)
                } | Should throw "Value `"$value1`" does not equal expected value `"$value2`"."@()
            }
        }
        Context ": Different types, different values"{
            $value1 = 1
            $value2 = "2"
            It "Should throw an exception"{
                {[Assert]::new($value1).eq($value2)} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).eq($value2)
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message"{
                {
                    [Assert]::new($value1).eq($value2)
                } | Should throw "Value `"$value1`" does not equal expected value `"$value2`"."
            }
        }
        Context ": Equal values, non matching types"{
            $value1 = 1
            $value2 = "1"
            It "Should not throw an exception"{
                {[Assert]::new($value1).eq($value2)} | Should not Throw
            }
        }
        Context ": Equal integer values"{
            $value1 = 1
            $value2 = 1
            It "Should not throw an exception"{
                {[Assert]::new($value1).eq($value2)} | Should not Throw
            }
        }
        Context ": Equal string values with same case"{
            $value1 = "This is a Test"
            $value2 = "This is a Test"
            It "Should not throw an exception"{
                {[Assert]::new($value1).eq($value2)} | Should not Throw
            }
        }
        Context ": Equal string values with differing case"{
            $value1 = "THIS IS A TEST"
            $value2 = "This is a Test"
            It "Should not throw an exception"{
                {[Assert]::new($value1).eq($value2)} | Should Throw
            }
        }
    }
    Describe "Method: `"greaterThan`""{
        Context ": Both Integers, value1 is not greater than value2"{
            $value1 = 1
            $value2 = 2
            It "Should throw an exception"{
                {[Assert]::new($value1).greaterThan($value2)} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).greaterThan($value2)
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - not greater than"{
                {
                    [Assert]::new($value1).greaterThan($value2)
                } | Should throw "Value `"$value1`" is not greater than value `"$value2`"."
            }
        }
        Context ": Different types, value1 is not greater than value2"{
            $value1 = 1
            $value2 = "2"
            It "Should throw an exception"{
                {[Assert]::new($value1).greaterThan($value2)} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).greaterThan($value2)
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message"{
                {
                    [Assert]::new($value1).greaterThan($value2)
                } | Should throw "Value `"$value1`" is not greater than value `"$value2`"."
            }
        }
        Context ": Different types, value1 is greater than value2"{
            $value1 = 2
            $value2 = "1"
            It "Should not throw an exception"{
                {[Assert]::new($value1).greaterThan($value2)} | Should not Throw
            }
        }
        Context ": Both Integers, value1 is greater than value2"{
            $value1 = 2
            $value2 = 1
            It "Should not throw an exception"{
                {[Assert]::new($value1).greaterThan($value2)} | Should not Throw
            }
        }
        Context ": Both Strings, value1 is greater than value2 (b > a)"{
            $value1 = "b"
            $value2 = "a"
            It "Should not throw an exception"{
                {[Assert]::new($value1).greaterThan($value2)} | Should not Throw
            }
        }
        Context ": Both Strings, value1 is greater than value2 (a > 1)"{
            $value1 = "a"
            $value2 = "1"
            It "Should not throw an exception"{
                {[Assert]::new($value1).greaterThan($value2)} | Should not Throw
            }
        }
        Context ": Matching string values with differing case"{
            $value1 = "This is a Test"
            $value2 = "THIS IS A TEST"
            It "Should throw an exception"{
                {[Assert]::new($value1).eq($value2)} | Should Throw
            }
        }
    }
    Describe "Method: `"greaterThanOrEq`""{
        Context ": Both Integers, value1 is not greater than value2"{
            $value1 = 1
            $value2 = 2
            It "Should throw an exception"{
                {[Assert]::new($value1).greaterThanOrEq($value2)} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).greaterThanOrEq($value2)
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - not greater than or equal to"{
                {
                    [Assert]::new($value1).greaterThanOrEq($value2)
                } | Should throw "Value `"$value1`" is not greater than or equal to value `"$value2`"."
            }
        }
        Context ": Different types, value1 is not greater than value2"{
            $value1 = 1
            $value2 = "2"
            It "Should throw an exception"{
                {[Assert]::new($value1).greaterThanOrEq($value2)} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).greaterThanOrEq($value2)
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message"{
                {
                    [Assert]::new($value1).greaterThanOrEq($value2)
                } | Should throw "Value `"$value1`" is not greater than or equal to value `"$value2`"."
            }
        }
        Context ": Different types, value1 is greater than value2"{
            $value1 = 2
            $value2 = "1"
            It "Should not throw an exception"{
                {[Assert]::new($value1).greaterThanOrEq($value2)} | Should not Throw
            }
        }
        Context ": Both Integers, value1 is greater than value2"{
            $value1 = 2
            $value2 = 1
            It "Should not throw an exception"{
                {[Assert]::new($value1).greaterThanOrEq($value2)} | Should not Throw
            }
        }
        Context ": Both Strings, value1 is greater than value2 (b > a)"{
            $value1 = "b"
            $value2 = "a"
            It "Should not throw an exception"{
                {[Assert]::new($value1).greaterThanOrEq($value2)} | Should not Throw
            }
        }
        Context ": Both Strings, value1 is greater than value2 (a > 1)"{
            $value1 = "a"
            $value2 = "1"
            It "Should not throw an exception"{
                {[Assert]::new($value1).greaterThanOrEq($value2)} | Should not Throw
            }
        }

        Context ": Equal values, non matching types"{
            $value1 = 1
            $value2 = "1"
            It "Should not throw an exception"{
                {[Assert]::new($value1).greaterThanOrEq($value2)} | Should not Throw
            }
        }
        Context ": Equal integer values"{
            $value1 = 1
            $value2 = 1
            It "Should not throw an exception"{
                {[Assert]::new($value1).greaterThanOrEq($value2)} | Should not Throw
            }
        }
        Context ": Equal string values with same case"{
            $value1 = "This is a Test"
            $value2 = "This is a Test"
            It "Should not throw an exception"{
                {[Assert]::new($value1).greaterThanOrEq($value2)} | Should not Throw
            }
        }
        Context ": Equal string values with differing case"{
            $value1 = "THIS IS A TEST"
            $value2 = "This is a Test"
            It "Should not throw an exception (`"THIS IS A TEST`" > `"This is a Test`")"{
                {[Assert]::new($value1).greaterThanOrEq($value2)} | Should not Throw
            }
        }

        Context ": Equal string values with differing case"{
            $value1 = "This is a Test"
            $value2 = "THIS IS A TEST"
            It "Should throw an exception (`"This is a Test`" !> `"THIS IS A TEST`")"{
                {[Assert]::new($value1).greaterThanOrEq($value2)} | Should Throw
            }
        }
    }
    Describe "Method: `"lessThan`""{
        Context ": Both Integers, value1 is not less than value2"{
            $value1 = 2
            $value2 = 1
            It "Should throw an exception"{
                {[Assert]::new($value1).lessThan($value2)} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).lessThan($value2)
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - not less than"{
                {
                    [Assert]::new($value1).lessThan($value2)
                } | Should throw "Value `"$value1`" is not less than value `"$value2`"."
            }
        }
        Context ": Different types, value1 is not less than value2"{
            $value1 = "2"
            $value2 = 1
            It "Should throw an exception"{
                {[Assert]::new($value1).lessThan($value2)} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).lessThan($value2)
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message"{
                {
                    [Assert]::new($value1).lessThan($value2)
                } | Should throw "Value `"$value1`" is not less than value `"$value2`"."
            }
        }
        Context ": Different types, value1 is less than value2"{
            $value1 = "1"
            $value2 = 2
            It "Should not throw an exception"{
                {[Assert]::new($value1).lessThan($value2)} | Should not Throw
            }
        }
        Context ": Both Integers, value1 is less than value2"{
            $value1 = 1
            $value2 = 2
            It "Should not throw an exception"{
                {[Assert]::new($value1).lessThan($value2)} | Should not Throw
            }
        }
        Context ": Both Strings, value1 is less than value2 (a > b)"{
            $value1 = "a"
            $value2 = "b"
            It "Should not throw an exception"{
                {[Assert]::new($value1).lessThan($value2)} | Should not Throw
            }
        }
        Context ": Both Strings, value1 is less than value2 (1 < a)"{
            $value1 = "1"
            $value2 = "a"
            It "Should not throw an exception"{
                {[Assert]::new($value1).lessThan($value2)} | Should not Throw
            }
        }
        Context ": Equal string values with differing case"{
            $value1 = "This is a Test"
            $value2 = "THIS IS A TEST"
            It "Should not throw an exception (`"This is a Test`" < `"THIS IS A TEST`")"{
                {[Assert]::new($value1).lessThan($value2)} | Should not Throw
            }
        }

        Context ": Equal string values with differing case"{
            $value1 = "THIS IS A TEST"
            $value2 = "This is a Test"
            It "Should throw an exception (`"THIS IS A TEST`" !< `"This is a Test`")"{
                {[Assert]::new($value1).lessThan($value2)} | Should Throw
            }
        }
    }
    Describe "Method: `"lessThanOrEq`""{
        Context ": Both Integers, value1 is not less than value2"{
            $value1 = 2
            $value2 = 1
            It "Should throw an exception"{
                {[Assert]::new($value1).lessThanOrEq($value2)} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).lessThanOrEq($value2)
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - not less than or equal to"{
                {
                    [Assert]::new($value1).lessThanOrEq($value2)
                } | Should throw "Value `"$value1`" is not less than or equal to value `"$value2`"."
            }
        }
        Context ": Different types, value1 is not less than value2"{
            $value1 = "2"
            $value2 = 1
            It "Should throw an exception"{
                {[Assert]::new($value1).lessThanOrEq($value2)} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).lessThanOrEq($value2)
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message"{
                {
                    [Assert]::new($value1).lessThanOrEq($value2)
                } | Should throw "Value `"$value1`" is not less than or equal to value `"$value2`"."
            }
        }
        Context ": Different types, value1 is less than value2"{
            $value1 = "1"
            $value2 = 2
            It "Should not throw an exception"{
                {[Assert]::new($value1).lessThanOrEq($value2)} | Should not Throw
            }
        }
        Context ": Both Integers, value1 is less than value2"{
            $value1 = 1
            $value2 = 2
            It "Should not throw an exception"{
                {[Assert]::new($value1).lessThanOrEq($value2)} | Should not Throw
            }
        }
        Context ": Both Strings, value1 is less than value2 (a < b)"{
            $value1 = "a"
            $value2 = "b"
            It "Should not throw an exception"{
                {[Assert]::new($value1).lessThanOrEq($value2)} | Should not Throw
            }
        }
        Context ": Both Strings, value1 is less than value2 (1 < a)"{
            $value1 = "1"
            $value2 = "a"
            It "Should not throw an exception"{
                {[Assert]::new($value1).lessThanOrEq($value2)} | Should not Throw
            }
        }
        Context ": Equal values, non matching types"{
            $value1 = 1
            $value2 = "1"
            It "Should not throw an exception"{
                {[Assert]::new($value1).lessThanOrEq($value2)} | Should not Throw
            }
        }
        Context ": Equal integer values"{
            $value1 = 1
            $value2 = 1
            It "Should not throw an exception"{
                {[Assert]::new($value1).lessThanOrEq($value2)} | Should not Throw
            }
        }
        Context ": Equal string values with same case"{
            $value1 = "This is a Test"
            $value2 = "This is a Test"
            It "Should not throw an exception"{
                {[Assert]::new($value1).lessThanOrEq($value2)} | Should not Throw
            }
        }
        Context ": Equal string values with differing case"{
            $value1 = "This is a Test"
            $value2 = "THIS IS A TEST"
            It "Should not throw an exception (`"This is a Test`" < `"THIS IS A TEST`")"{
                {[Assert]::new($value1).lessThan($value2)} | Should not Throw
            }
        }

        Context ": Equal string values with differing case"{
            $value1 = "THIS IS A TEST"
            $value2 = "This is a Test"
            It "Should throw an exception (`"THIS IS A TEST`" !< `"This is a Test`")"{
                {[Assert]::new($value1).lessThan($value2)} | Should Throw
            }
        }
    }
    Describe "Method: `"same`""{
        Context ": Different integer values"{
            $value1 = 1
            $value2 = 2
            It "Should throw an exception"{
                {[Assert]::new($value1).same($value2)} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).same($value2)
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - not the same"{
                {
                    [Assert]::new($value1).same($value2)
                } | Should throw "Value `"$value1`" is not the same as expected value `"$value2`"."
            }
        }
        Context ": Different types, different values"{
            $value1 = 1
            $value2 = "2"
            It "Should throw an exception"{
                {[Assert]::new($value1).same($value2)} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).same($value2)
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - not the same"{
                {
                    [Assert]::new($value1).same($value2)
                } | Should throw "Value `"$value1`" is not the same as expected value `"$value2`"."
            }
        }
        Context ": Equal values, non matching types"{
            $value1 = 1
            $value2 = "1"
            It "Should throw an exception"{
                {[Assert]::new($value1).same($value2)} | Should Throw
            }
        }
        Context ": Equal integer values"{
            $value1 = 1
            $value2 = 1
            It "Should not throw an exception"{
                {[Assert]::new($value1).same($value2)} | Should not Throw
            }
        }
        Context ": Equal string values with same case"{
            $value1 = "This is a Test"
            $value2 = "This is a Test"
            It "Should not throw an exception"{
                {[Assert]::new($value1).same($value2)} | Should not Throw
            }
        }
        Context ": Equal string values with differing case"{
            $value1 = "THIS IS A TEST"
            $value2 = "This is a Test"
            It "Should throw an exception"{
                {[Assert]::new($value1).same($value2)} | Should Throw
            }
        }
    }
    Describe "Method: `"notEq`""{
        Context ": Equal integer values"{
            $value1 = 1
            $value2 = 1
            It "Should throw an exception"{
                {[Assert]::new($value1).notEq($value2)} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).notEq($value2)
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - values are equal"{
                {
                    [Assert]::new($value1).notEq($value2)
                } | Should throw "Value `"$value1`" is equal to value `"$value2`"."
            }
        }
        Context ": Different types, same values"{
            $value1 = 1
            $value2 = "1"
            It "Should throw an exception"{
                {[Assert]::new($value1).notEq($value2)} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).notEq($value2)
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message"{
                {
                    [Assert]::new($value1).notEq($value2)
                } | Should throw "Value `"$value1`" is equal to value `"$value2`"."
            }
        }
        Context ": Different values, non matching types"{
            $value1 = 1
            $value2 = "2"
            It "Should not throw an exception"{
                {[Assert]::new($value1).notEq($value2)} | Should not Throw
            }
        }
        Context ": Different integer values"{
            $value1 = 1
            $value2 = 2
            It "Should not throw an exception"{
                {[Assert]::new($value1).notEq($value2)} | Should not Throw
            }
        }
        Context ": Same string values with different case"{
            $value1 = "This is a Test"
            $value2 = "This is a test"
            It "Should not throw an exception"{
                {[Assert]::new($value1).notEq($value2)} | Should not Throw
            }
        }
        Context ": Same string values with same case"{
            $value1 = "THIS IS A TEST"
            $value2 = "THIS IS A TEST"
            It "Should not throw an exception"{
                {[Assert]::new($value1).notEq($value2)} | Should Throw
            }
        }
    }
    Describe "Method: `"notSame`""{
        Context ": Same integer values"{
            $value1 = 1
            $value2 = 1
            It "Should throw an exception"{
                {[Assert]::new($value1).notSame($value2)} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).notSame($value2)
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - values are the same"{
                {
                    [Assert]::new($value1).notSame($value2)
                } | Should throw "Value `"$value1`" is the same as expected value `"$value2`"."
            }
        }
        Context ": Equal values, non matching types"{
            $value1 = 1
            $value2 = "1"
            It "Should not throw an exception"{
                {[Assert]::new($value1).notSame($value2)} | Should not Throw
            }
        }
        Context ": Equal string values with same case"{
            $value1 = "This is a Test"
            $value2 = "This is a Test"
            It "Should throw an exception"{
                {[Assert]::new($value1).notSame($value2)} | Should Throw
            }
        }
        Context ": Equal string values with differing case"{
            $value1 = "THIS IS A TEST"
            $value2 = "This is a Test"
            It "Should not throw an exception"{
                {[Assert]::new($value1).notSame($value2)} | Should not Throw
            }
        }
    }
    Describe "Method: `"isJsonString`""{
        Context ": Invalid Json String"{
            $value1 = "{name:John,`"age`":30,`"car`":null }"
           
            It "Should throw an exception"{
                {[Assert]::new($value1).isJsonString()} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).isJsonString()
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - invalid JSON string"{
                {
                    [Assert]::new($value1).isJsonString()
                } | Should throw "Value `"$value1`" is not a valid JSON string."
            }
        }
        Context ": Valid Json String"{
            $value1 = "{`"name`":`"John`",`"age`":30,`"car`":null }"
           
            It "Should not throw an exception"{
                {[Assert]::new($value1).isJsonString()} | Should not Throw
            }
        }
    }
    Describe "Method: `"string`""{
        Context ": Provided integer value"{
            $value1 = 1
            It "Should throw an exception"{
                {[Assert]::new($value1).string()} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).string()
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - non string provided"{
                {
                    [Assert]::new($value1).string()
                } | Should throw "Value `"$value1`" expected to be a string, type `"int`" given."
            }
        }
        Context ": Provided boolean value"{
            $value1 = $true
            It "Should throw an exception"{
                {[Assert]::new($value1).string()} | Should Throw
            }
        }
        Context ": Provided object"{
            $value1 = @("item1","item2")
            It "Should throw an exception"{
                {[Assert]::new($value1).string()} | Should Throw
            }
        }
        Context ": Provided string value"{
            $value1 = "hello"
            It "Should not throw an exception"{
                {[Assert]::new($value1).string()} | Should not Throw
            }
        }
       
    }
    Describe "Method: `"int`""{
        Context ": Provided string value"{
            $value1 = "string"
            It "Should throw an exception"{
                {[Assert]::new($value1).int()} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).int()
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - non int provided"{
                {
                    [Assert]::new($value1).int()
                } | Should throw "Value `"$value1`" expected to be an int, type `"string`" given."
            }
        }
        Context ": Provided boolean value"{
            $value1 = $true
            It "Should throw an exception"{
                {[Assert]::new($value1).int()} | Should Throw
            }
        }
        Context ": Provided object"{
            $value1 = @("item1","item2")
            It "Should throw an exception"{
                {[Assert]::new($value1).int()} | Should Throw
            }
        }
        Context ": Provided int value"{
            $value1 = 123456
            It "Should not throw an exception"{
                {[Assert]::new($value1).int()} | Should not Throw
            }
        }
       
    }
    Describe "Method: `"boolean`""{
        Context ": Provided string value"{
            $value1 = "string"
            It "Should throw an exception"{
                {[Assert]::new($value1).boolean()} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).boolean()
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - non boolean provided"{
                {
                    [Assert]::new($value1).boolean()
                } | Should throw "Value `"$value1`" expected to be a boolean, type `"string`" given."
            }
        }
        Context ": Provided int value"{
            $value1 = 1
            It "Should throw an exception"{
                {[Assert]::new($value1).boolean()} | Should Throw
            }
        }
        Context ": Provided object"{
            $value1 = @("item1","item2")
            It "Should throw an exception"{
                {[Assert]::new($value1).boolean()} | Should Throw
            }
        }
        Context ": Provided false boolean value"{
            $value1 = $false
            It "Should not throw an exception"{
                {[Assert]::new($value1).boolean()} | Should not Throw
            }
        }
        Context ": Provided true boolean value"{
            $value1 = $true
            It "Should not throw an exception"{
                {[Assert]::new($value1).boolean()} | Should not Throw
            }
        }
       
    }
    Describe "Method: `"domainName`""{
        Context ": Provided string value"{
            $value1 = "string"
            It "Should throw an exception"{
                {[Assert]::new($value1).domainName()} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).domainName()
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - invalid domain name"{
                {
                    [Assert]::new($value1).domainName()
                } | Should throw "Value `"$value1`" was expected to be a valid domain name."
            }
        }
            Context ": Provided domain name"{
            $value1 = "o365.outlook.com"
            It "Should not throw an exception"{
                {[Assert]::new($value1).domainName()} | Should not Throw
            }
        }
    }
    Describe "Method: `"email`""{
        Context ": Provided string value"{
            $value1 = "string"
            It "Should throw an exception"{
                {[Assert]::new($value1).email()} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).email()
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - invalid email address"{
                {
                    [Assert]::new($value1).email()
                } | Should throw "Value `"$value1`" was expected to be a valid e-mail address."
            }
        }
            Context ": Provided email address"{
            $value1 = "test@o365.outlook.com"
            It "Should not throw an exception"{
                {[Assert]::new($value1).email()} | Should not Throw
            }
        }
    }
    Describe "Method: `"samAccountName`""{

        Context ": Provided an array of strings, one of which has a string value >20 characters"{
            $value1 = @("jcitiz","something","stringstringstringstringstringstringstringstringstringstring","blah")
            It "Should throw an exception"{
                {[Assert]::new($value1).all().samAccountName()} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).all().samAccountName()
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - invalid samAccountName"{
                {
                    [Assert]::new($value1).all().samAccountName()
                } | Should throw "Value `"stringstringstringstringstringstringstringstringstringstring`" was expected to be a valid samAccountName."
            }
        }
        Context ": Provided string value >20 characters"{
            $value1 = "stringstringstringstringstringstringstringstringstringstring"
            It "Should throw an exception"{
                {[Assert]::new($value1).samAccountName()} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).samAccountName()
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - invalid samAccountName"{
                {
                    [Assert]::new($value1).samAccountName()
                } | Should throw "Value `"$value1`" was expected to be a valid samAccountName."
            }
        }
            Context ": Provided valid samAccountName"{
            $value1 = "test1234"
            It "Should not throw an exception"{
                {[Assert]::new($value1).samAccountName()} | Should not Throw
            }
        }
    }
    Describe "Method: `"uuid`""{
        Context ": Provided random string value"{
            $value1 = "stringstringstringstringstringstringstringstringstringstring"
            It "Should throw an exception"{
                {[Assert]::new($value1).uuid()} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).uuid()
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - invalid uuid"{
                {
                    [Assert]::new($value1).uuid()
                } | Should throw "Value `"$value1`" was expected to be a valid uuid."
            }
        }
        Context ": Provided valid uuid"{
            $value1 = "5d12db75-d6f7-4f72-bb15-ce03ebb70c96"
            It "Should not throw an exception"{
                {[Assert]::new($value1).uuid()} | Should not Throw
            }
        }
        Context ": Provided valid uuid prefixed with `"urn:`""{
            $value1 = "urn:5d12db75-d6f7-4f72-bb15-ce03ebb70c96"
            It "Should not throw an exception"{
                {[Assert]::new($value1).uuid()} | Should not Throw
            }
        }
        Context ": Provided valid uuid prefixed with `"uuid:`""{
            $value1 = "uuid:5d12db75-d6f7-4f72-bb15-ce03ebb70c96"
            It "Should not throw an exception"{
                {[Assert]::new($value1).uuid()} | Should not Throw
            }
        }
        Context ": Provided valid uuid enclosed in `"`[`]`""{
            $value1 = "[5d12db75-d6f7-4f72-bb15-ce03ebb70c96]"
            It "Should not throw an exception"{
                {[Assert]::new($value1).uuid()} | Should not Throw
            }
        }
        Context ": Provided valid uuid enclosed in `"`{`}`""{
            $value1 = "{5d12db75-d6f7-4f72-bb15-ce03ebb70c96}"
            It "Should not throw an exception"{
                {[Assert]::new($value1).uuid()} | Should not Throw
            }
        }
    }
    Describe "Method: `"regex`""{
        Context ": Provided string value with non-matching regex"{
            $value1 = "foo"
            $regex = "bar"
            It "Should throw an exception"{
                {[Assert]::new($value1).regex($regex)} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).regex($regex)
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - non matching regex"{
                {
                    [Assert]::new($value1).regex($regex)
                } | Should throw "Value `"$value1`" does not match the regex expression provided."
            }
        }
        Context ": Provided non-string value"{
            $value1 = 123456
            $regex = "bar"
            It "Should throw an AssertionFailedException with correct message - invalid string"{
                {
                    [Assert]::new($value1).regex($regex)
                } | Should throw "Value `"$value1`" expected to be a string, type `"System.Int32`" given."
            }
        }
        Context ": Provided matching regex"{
            $value1 = "5d12db75-d6f7-4f72-bb15-ce03ebb70c96"
            $regex = "^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$"
            It "Should not throw an exception"{
                {[Assert]::new($value1).regex($regex)} | Should not Throw
            }
        }
    }
    Describe "Method: `"numeric`""{
        Context ": Provided string value"{
            $value1 = "foo"
            It "Should throw an exception"{
                {[Assert]::new($value1).numeric()} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).numeric()
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - not numeric"{
                {
                    [Assert]::new($value1).numeric()
                } | Should throw "Value `"$value1`" is not numeric."
            }
        }
        Context ": Provided string value with decimal"{
            $value1 = "123456.78"
            It "Should not throw an exception"{
                {[Assert]::new($value1).numeric()} | Should not Throw
            }
        }
        Context ": Provided string whole number with a space"{
            $value1 = "123456 46"
            It "Should not throw an exception"{
                {[Assert]::new($value1).numeric()} | Should not Throw
            }
        }
        Context ": Provided string whole number"{
            $value1 = "123456"
            It "Should not throw an exception"{
                {[Assert]::new($value1).numeric()} | Should not Throw
            }
        }
        Context ": Provided int value with decimal"{
            $value1 = 123456.78
            It "Should not throw an exception"{
                {[Assert]::new($value1).numeric()} | Should not Throw
            }
        }
        Context ": Provided int whole number"{
            $value1 = 123456.78
            It "Should not throw an exception"{
                {[Assert]::new($value1).numeric()} | Should not Throw
            }
        }
    }
    Describe "Method: `"range`""{
        Context ": Provided string value"{
            $value1 = "foo"
            $min = 50
            $max = 150
            It "Should throw an exception"{
                {[Assert]::new($value1).range($min,$max)} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).range($min,$max)
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - not numeric"{
                {
                    [Assert]::new($value1).range($min,$max)
                } | Should throw "Value `"$value1`" is not numeric."
            }
        }
        Context ": Provided value not within the range"{
            $value1 = 40
            $min = 50
            $max = 150
            It "Should throw an exception"{
                {[Assert]::new($value1).range($min,$max)} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).range($min,$max)
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - not within the range"{
                {
                    [Assert]::new($value1).range($min,$max)
                } | Should throw "Number `"$($Value1.Tostring())`" was expected to be at least `"$($min.ToString())`" and at most `"$($max.ToString())`"."
            }
        }
        Context ": Provided value equal to the minValue"{
            $value1 = 50
            $min = 50
            $max = 150
            It "Should not throw an exception"{
                {[Assert]::new($value1).range($min,$max)} | Should not Throw
            }
        }
        Context ": Provided value equal to the maxValue"{
            $value1 = 150
            $min = 50
            $max = 150
            It "Should not throw an exception"{
                {[Assert]::new($value1).range($min,$max)} | Should not Throw
            }
        }
        Context ": Provided string numerical value equal to the minValue"{
            $value1 = "50"
            $min = 50
            $max = 150
            It "Should not throw an exception"{
                {[Assert]::new($value1).range($min,$max)} | Should not Throw
            }
        }
        Context ": Provided string fractional numeric value equal to the minValue"{
            $value1 = "50.01"
            $min = 50.01
            $max = 150
            It "Should not throw an exception"{
                {[Assert]::new($value1).range($min,$max)} | Should not Throw
            }
        }
        Context ": Provided fractional numeric value equal to the minValue"{
            $value1 = 50.0001
            $min = 50.0001
            $max = 150.50
            It "Should not throw an exception"{
                {[Assert]::new($value1).range($min,$max)} | Should not Throw
            }
        }
    }
    Describe "Method: `"notNullOrEmpty`""{
        Context ": Provided empty string value"{
            $value1 = ""
            It "Should throw an exception"{
                {[Assert]::new($value1).notNullOrEmpty()} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).notNullOrEmpty()
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - empty or null"{
                {
                    [Assert]::new($value1).notNullOrEmpty()
                } | Should throw "Value `"$value1`" is null or empty, but non null or empty value was expected."
            }
        }
        Context ": Provided null string value"{
            [string] $value1 = $null
            It "Should throw an exception"{
                {[Assert]::new($value1).notNullOrEmpty()} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).notNullOrEmpty()
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - empty or null"{
                {
                    [Assert]::new($value1).notNullOrEmpty()
                } | Should throw "Value `"$value1`" is null or empty, but non null or empty value was expected."
            }
        }
        Context ": Provided null int value"{
            [int] $value1 = $null
            It "Should throw an exception"{
                {[Assert]::new($value1).notNullOrEmpty()} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).notNullOrEmpty()
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - empty or null"{
                {
                    [Assert]::new($value1).notNullOrEmpty()
                } | Should throw "Value `"$value1`" is null or empty, but non null or empty value was expected."
            }
        }
        Context ": Provided boolean value of `"false`""{
            [int] $value1 = $false
            It "Should throw an exception"{
                {[Assert]::new($value1).notNullOrEmpty()} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).notNullOrEmpty()
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - empty or null"{
                {
                    [Assert]::new($value1).notNullOrEmpty()
                } | Should throw "Value `"$value1`" is null or empty, but non null or empty value was expected."
            }
        }
        Context ": Provided empty object"{
            [int] $value1 = $()
            It "Should throw an exception"{
                {[Assert]::new($value1).notNullOrEmpty()} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).notNullOrEmpty()
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - empty or null"{
                {
                    [Assert]::new($value1).notNullOrEmpty()
                } | Should throw "Value `"$value1`" is null or empty, but non null or empty value was expected."
            }
        }
        Context ": Provided int value of 0"{
            [int] $value1 = 0
            It "Should throw an exception"{
                {[Assert]::new($value1).notNullOrEmpty()} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).notNullOrEmpty()
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - empty or null"{
                {
                    [Assert]::new($value1).notNullOrEmpty()
                } | Should throw "Value `"$value1`" is null or empty, but non null or empty value was expected."
            }
        }
        Context ": Variable declared but not assigned"{
            $value1
            It "Should throw an exception"{
                {[Assert]::new($value1).notNullOrEmpty()} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).notNullOrEmpty()
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - empty or null"{
                {
                    [Assert]::new($value1).notNullOrEmpty()
                } | Should throw "Value `"$value1`" is null or empty, but non null or empty value was expected."
            }
        }
        Context ": Provided string value of `" `""{
            $value1 = " "
            It "Should not throw an exception"{
                {[Assert]::new($value1).notNullOrEmpty()} | Should not Throw
            }
        }
        Context ": Provided string value"{
            $value1 = "hello"
            It "Should not throw an exception"{
                {[Assert]::new($value1).notNullOrEmpty()} | Should not Throw
            }
        }
        Context ": Provided int value"{
            $value1 = 1
            It "Should not throw an exception"{
                {[Assert]::new($value1).notNullOrEmpty()} | Should not Throw
            }
        }
    }
    Describe "Method: `"true`""{
        Context ": Provided string value"{
            $value1 = "foo"
            It "Should throw an exception"{
                {[Assert]::new($value1).true()} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).true()
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - not a boolean"{
                {
                    [Assert]::new($value1).true()
                } | Should throw "Value `"$value1`" expected to be a boolean, type "string" given."
            }
        }
        Context ": Provided string value of `"true`""{
            $value1 = "true"
            It "Should throw an exception"{
                {[Assert]::new($value1).true()} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).true()
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - not a boolean"{
                {
                    [Assert]::new($value1).true()
                } | Should throw "Value `"$value1`" expected to be a boolean, type "string" given."
            }
        }
        Context ": Provided int value of `"1`""{
            $value1 = 1
            It "Should throw an AssertionFailedException with correct message - not a boolean"{
                {
                    [Assert]::new($value1).true()
                } | Should throw "Value `"$value1`" expected to be a boolean, type "int" given."
            }
        }
        Context ": Provided FALSE boolean value"{
            $value1 = $false
            It "Should throw an AssertionFailedException with correct message - not true"{
                {
                    [Assert]::new($value1).true()
                } | Should throw "Value `"$($value1.ToString())`" is not TRUE."
            }
        }
        Context ": Provided TRUE boolean value"{
            $value1 = $true
            It "Should not throw an exception"{
                {[Assert]::new($value1).true()} | Should not Throw
            }
        }
    }
    Describe "Method: `"false`""{
        Context ": Provided string value"{
            $value1 = "foo"
            It "Should throw an exception"{
                {[Assert]::new($value1).false()} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).false()
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - not a boolean"{
                {
                    [Assert]::new($value1).false()
                } | Should throw "Value `"$value1`" expected to be a boolean, type "string" given."
            }
        }
        Context ": Provided string value of `"false`""{
            $value1 = "false"
            It "Should throw an exception"{
                {[Assert]::new($value1).false()} | Should Throw
            }
            It "Should throw an AssertionFailedException"{
                {
                    try
                    {
                        [Assert]::new($value1).false()
                    }
                    catch 
                    {
                        $_.Exception.GetType().Name | Should Be "AssertionFailedException"
                    }
                 } 
            }
            It "Should throw an AssertionFailedException with correct message - not a boolean"{
                {
                    [Assert]::new($value1).false()
                } | Should throw "Value `"$value1`" expected to be a boolean, type "string" given."
            }
        }
        Context ": Provided int value of `"0`""{
            $value1 = 0
            It "Should throw an AssertionFailedException with correct message - not a boolean"{
                {
                    [Assert]::new($value1).false()
                } | Should throw "Value `"$value1`" expected to be a boolean, type "int" given."
            }
        }
        Context ": Provided TRUE boolean value"{
            $value1 = $true
            It "Should throw an AssertionFailedException with correct message - not false"{
                {
                    [Assert]::new($value1).false()
                } | Should throw "Value `"$($value1.ToString())`" is not FALSE."
            }
        }
        Context ": Provided FALSE boolean value"{
            $value1 = $false
            It "Should not throw an exception"{
                {[Assert]::new($value1).false()} | Should not Throw
            }
        }
    }
}
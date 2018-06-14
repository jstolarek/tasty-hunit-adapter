tasty-hunit-adapter
===================

**IMPORTANT:** This repository is now [hosted on BitBucket](https://bitbucket.org/jstolarek/tasty-hunit-adapter).

This package provides a function that converts exisiting
[HUnit](http://hackage.haskell.org/package/HUnit) tests to TestTree that can
be used by [tasty](http://hackage.haskell.org/package/tasty) testing
framework. Code is adapted from
[test-framework-hunit](http://hackage.haskell.org/package/test-framework-hunit)
package authored by Max Bolingbroke.

You can download latest stable release from
[Hackage](http://hackage.haskell.org/package/tasty-hunit-adapter)

## Example

```haskell
module Main where

import Test.HUnit               ( (~:), (@=?)            )
import Test.Tasty               ( defaultMain, testGroup )
import Test.Tasty.HUnit.Adapter ( hUnitTestToTestTree    )

main :: IO ()
main = defaultMain $ testGroup "Migrated from HUnit" $
                     hUnitTestToTestTree ("HUnit test" ~: 2 + 2 @=? 4)
```

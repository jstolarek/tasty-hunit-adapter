-- | Provides a function that converts exisiting HUnit tests to a TestTree that
-- can be used with tasty testing framework. Example usage:
--
--  > module Main where
--  >
--  > import Test.HUnit               ( (~:), (@=?)            )
--  > import Test.Tasty               ( defaultMain, testGroup )
--  > import Test.Tasty.HUnit.Adapter ( hUnitTestToTestTree    )
--  >
--  > main :: IO ()
--  > main = defaultMain $ testGroup "Migrated from HUnit" $
--  >                      hUnitTestToTestTree ("HUnit test" ~: 2 + 2 @=? 4)
module Test.Tasty.HUnit.Adapter (
   hUnitTestToTestTree
 ) where

import qualified Test.HUnit.Base  as HUB
import qualified Test.Tasty       as TF
import qualified Test.Tasty.HUnit as TFH

-- | Convert existing HUnit test to a TestTree list that can be used with tasty
-- package.
hUnitTestToTestTree :: HUB.Test -> [TF.TestTree]
hUnitTestToTestTree = go ""
  where
    go desc (HUB.TestCase a)    = [TFH.testCase desc a]
    go desc (HUB.TestLabel s t)
      | null desc = go s t
      | otherwise = go (desc ++ ":" ++ s) t
    go desc (HUB.TestList ts)
        -- If the list occurs at the top level (with no description above it),
        -- just return that list straightforwardly
      | null desc = concatMap (go "") ts
        -- If the list occurs with a description, turn that into a honest-to-god
        -- test group. This is heuristic, but likely to give good results
      | otherwise = [TF.testGroup desc (concatMap (go "") ts)]

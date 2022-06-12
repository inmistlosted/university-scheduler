module Main where

import Data.List
import DbActions

actions = ["1. Add user",
    "2. Show classes on floor",
    "3. Update class info",
    "4. Show class schedule",
    "q - quit"]

main :: IO ()
main = do
  putStrLn $ "Please choose the action:\n" ++ (intercalate "\n" actions)
  option1 <- getLine
  case option1 of
      "1" -> registerUser
      "2" -> showClassesOnFloor
      "3" -> updateClass
      "4" -> showSchedule
      "q" -> undefined
      _ -> error "Wrong input. Error"
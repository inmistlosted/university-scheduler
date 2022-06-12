import Test.HUnit
import DbActions
import Database.PostgreSQL.Simple
import Data.String

safeHead :: [a] -> Maybe a
safeHead []    = Nothing
safeHead (x:_) = Just x

testSafeHeadForEmptyList :: Test
testSafeHeadForEmptyList =
    TestCase $ assertEqual "Should return Nothing for empty list"
                           Nothing (safeHead ([]::[Int]))

testGetClassesOnFloor :: Test
testGetClassesOnFloor = TestCase (do
  a <- getClassesNumbersOnFloor (2 :: Int)
  assertEqual "Should return list with 2 values (201, 212)" [Only {fromOnly = 201},Only {fromOnly = 212}] a)

testGetClassSchedule :: Test
testGetClassSchedule = TestCase (do
  a <- getClassSchedule (201 :: Int)
  assertEqual "Should return list with 3 values (9:00-10:00, 10:30-11:30, 12:00-13:00)" [("12.04.2021","10:30","11:30",Nothing,Nothing,Just "Dave Bautista"),("12.04.2021","9:00","10:00",Just "Georg Marikov",Just "TETA-43",Just " "),("12.04.2021","12:00","13:00",Just "Barry Allen",Just "KAST-21",Just " ")] a)

testAddUser :: Test
testAddUser = TestCase (do
  a <- addUser "first_name" "last_name" "test_code" "test_pass"
  assertEqual "Should return new user id (id = 13)" [Only {fromOnly = 13}] a)

testUpdateClassInfo :: Test
testUpdateClassInfo = TestCase (do
  a <- updateClassInfo (4 :: Int) (508 :: Int) (30 :: Int) (5 :: Int)
  assertEqual "Should return id of updated class (id = 4)" [Only {fromOnly = 4}] a)

main :: IO Counts
main = runTestTT $ TestList [testSafeHeadForEmptyList, testGetClassesOnFloor, testGetClassSchedule, testAddUser, testUpdateClassInfo]

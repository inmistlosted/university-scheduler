{-# LANGUAGE OverloadedStrings #-}

module DbActions where

import Database.PostgreSQL.Simple
import Data.String

dbConnection :: IO Connection
dbConnection = connect defaultConnectInfo {
               	  connectDatabase = "haskell_lab1_db", connectPassword = "admin"
                 }
    
addUser :: String -> String -> String -> String -> IO [Only Int]
addUser first_name last_name license_code password = do
    c <- dbConnection
    let q = "INSERT INTO users (first_name, last_name, faculty_license_code, password) VALUES (?, ?, ?, ?) returning id;"
    query c q $ (first_name, last_name, license_code, password) :: IO [Only Int]
    
getClassSchedule classNumber = do
    c <- dbConnection
    let q = "SELECT times.date, times.time_from, times.time_to, teachers_schedule.teacher_name, teachers_schedule.group_name, concat(users.first_name, ' ', users.last_name) as username \
            \ FROM times INNER JOIN classes on times.class_id = classes.id \
            \ LEFT JOIN teachers_schedule on times.id = teachers_schedule.time_id \
            \ LEFT JOIN ordinary_users_schedule on times.id = ordinary_users_schedule.time_id \
            \ LEFT JOIN users on ordinary_users_schedule.user_id = users.id \
            \ WHERE classes.number = ?;"
    query c q $ Only (classNumber) :: IO [(String, String, String, Maybe String, Maybe String, Maybe String)]
    
getClassesNumbersOnFloor floor = do
    c <- dbConnection
    let q = "SELECT number FROM classes WHERE floor = ?;"
    query c q $ Only (floor) :: IO [(Only Int)]
    
updateClassInfo :: Int -> Int -> Int -> Int -> IO [Only Int]
updateClassInfo classId newNumber newSeatsCount newFloor = do
    c <- dbConnection
    let q = "UPDATE classes set number = ?, seats_count = ?, floor = ? WHERE id = ? returning id;"
    query c q $ (newNumber, newSeatsCount, newFloor, classId) :: IO [Only Int]
    
registerUser = do
    putStrLn "Enter first name: "
    fn <- getLine
    putStrLn "Enter last name: "
    ln <- getLine
    putStrLn "Enter faculty license code: "
    lc <- getLine
    putStrLn "Enter password: "
    pw <- getLine
    addUser fn ln lc pw
    putStrLn "User succesfully registered!"
    
showClassesOnFloor = do
    putStrLn "Enter floor: "
    floorStr <- getLine
    let floor = (read floorStr :: Int)
    res <- getClassesNumbersOnFloor floor
    print res
    
updateClass = do
    putStrLn "Enter class id: "
    classIdStr <- getLine
    let classId = (read classIdStr :: Int)
    putStrLn "Enter new class number: "
    classNumberStr <- getLine
    let number = (read classNumberStr :: Int)
    putStrLn "Enter new class seats count: "
    seatsCountStr <- getLine
    let seatsCount = (read seatsCountStr :: Int)
    putStrLn "Enter new class floor: "
    floorStr <- getLine
    let floor = (read floorStr :: Int)
    res <- updateClassInfo classId number seatsCount floor
    putStrLn $ "Class with id " ++ classIdStr ++ " succesfully updated!"
    
showSchedule = do
    putStrLn "Enter class number: "
    classNumberStr <- getLine
    let number = (read classNumberStr :: Int)
    res <- getClassSchedule number
    print res  
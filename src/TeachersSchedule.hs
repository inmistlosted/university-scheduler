module TeachersSchedule where

import Database.PostgreSQL.Simple.FromRow

data TeachersSchedule = TeachersSchedule {
    class_id :: Integer,
    time_id :: Integer,
    teacher_name :: String,
    group_name :: String
} deriving (Show)

instance FromRow TeachersSchedule where
  fromRow = TeachersSchedule <$> field <*> field <*> field <*> field

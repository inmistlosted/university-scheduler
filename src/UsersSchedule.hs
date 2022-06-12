module UsersSchedule where

import Database.PostgreSQL.Simple.FromRow

data UsersSchedule = UsersSchedule {
    class_id :: Integer,
    time_id :: Integer,
    user_id :: Integer,
} deriving (Show)

instance FromRow UsersSchedule where
  fromRow = UsersSchedule <$> field <*> field <*> field
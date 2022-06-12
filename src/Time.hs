module Time where

import Database.PostgreSQL.Simple.FromRow

data Time = Time {
    id :: Integer,
    class_id :: Integer,
    date :: String,
    time_from :: String,
    time_to :: String
} deriving (Show)

instance FromRow Time where
  fromRow = Time <$> field <*> field <*> field <*> field <*> field


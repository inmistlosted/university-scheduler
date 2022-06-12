module User where

import Database.PostgreSQL.Simple.FromRow

data User = User {
    id :: Integer,
    first_name :: String,
    last_name :: String,
    faculty_license_code :: String,
    password :: String
} deriving (Show)

instance FromRow User where
  fromRow = User <$> field <*> field <*> field <*> field <*> field
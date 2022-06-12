module Class where

import Database.PostgreSQL.Simple.FromRow

data Class = Class {
    id :: Integer,
    number :: Integer,
    seats_count :: Integer,
    floor :: Integer
} deriving (Show)

instance FromRow Class where
  fromRow = Class <$> field <*> field <*> field <*> field

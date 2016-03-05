module Main where

import Network.HTTP.Conduit
import Network.HTTP.Types

isGithubDown :: String -> IO Bool
isGithubDown url = do
  request <- parseUrl url
  manager <- newManager tlsManagerSettings
  response <- httpLbs request manager
  return $ statusCode (responseStatus response) /= 200

resultString :: Bool -> String
resultString True = "Yeah, it's down :-("
resultString False = "Nope, happy coding'! :-)"

main :: IO ()
main = do
  isDown <- isGithubDown "https://github.com"
  print (resultString isDown)

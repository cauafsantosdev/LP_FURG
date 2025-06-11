prime :: Int -> Bool
prime n
  | n < 2     = False
  | n == 2    = True
  | otherwise = null [x | x <- [2..(n-1)], n `mod` x == 0]

main :: IO ()
main = do
  putStrLn "Type a number:"
  input <- getLine
  let num = read input :: Int
  if prime num
    then putStrLn $ show num ++ " is prime."
    else putStrLn $ show num ++ " isn't prime."
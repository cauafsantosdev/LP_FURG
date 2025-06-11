odds :: Int -> [Int]
odds n = take n [x | x <- [1..], odd x]
  
main :: IO ()
main = do
  putStrLn "How many odds numbers do you wanna print? "
  input <- getLine
  let num = read input :: Int
  putStrLn $ "The first " ++ show num ++ " odd numbers are: " ++ show (odds num)
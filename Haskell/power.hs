power :: Int -> Int -> Int
power x y = x^y

main :: IO ()
main = do
    putStrLn "Enter base: "
    base <- getLine
    putStrLn "Enter exponent: "
    exp <- getLine
    let baseInt = read base :: Int
    let expInt = read exp :: Int
    let resultado = power baseInt expInt
    putStrLn (show baseInt ++ " powered to " ++ show expInt ++ " is " ++ show resultado)
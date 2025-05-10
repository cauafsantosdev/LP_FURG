lcs :: String -> String -> String
lcs string1 string2 = reverse (reconstruct len1 len2)
  where
    len1 = length string1
    len2 = length string2

    dp = [[table i j | j <- [0..len2]] | i <- [0..len1]]

    table :: Int -> Int -> Int
    table 0 _ = 0
    table _ 0 = 0
    table i j
      | string1 !! (i - 1) == string2 !! (j - 1) = 1 + dp !! (i - 1) !! (j - 1)
      | otherwise = max (dp !! (i - 1) !! j) (dp !! i !! (j - 1))

    reconstruct :: Int -> Int -> String
    reconstruct 0 _ = ""
    reconstruct _ 0 = ""
    reconstruct i j
      | string1 !! (i - 1) == string2 !! (j - 1) = string1 !! (i - 1) : reconstruct (i - 1) (j - 1)
      | dp !! (i - 1) !! j > dp !! i !! (j - 1) = reconstruct (i - 1) j
      | otherwise = reconstruct i (j - 1)

main :: IO ()
main = do
  let string1 = "longestcommonsubsequence"
  let string2 = "strongestcommonsubsequence"
  putStrLn (lcs string1 string2)
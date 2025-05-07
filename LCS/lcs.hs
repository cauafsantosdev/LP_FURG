lcs :: String -> String -> (Int, String)
lcs str1 str2 = (lcsLength, lcsSequence)
  where
    len1 = length str1
    len2 = length str2

    lcsTable = [[valueLCS i j | j <- [0..len2]] | i <- [0..len1]]

    valueLCS :: Int -> Int -> Int
    valueLCS 0 _ = 0
    valueLCS _ 0 = 0
    valueLCS i j
      | str1 !! (i - 1) == str2 !! (j - 1) = 1 + lcsTable !! (i - 1) !! (j - 1)
      | otherwise = max (lcsTable !! i !! (j - 1)) (lcsTable !! (i - 1) !! j)

    lcsLength = lcsTable !! len1 !! len2

    lcsSequence = reverse (reconstruct len1 len2)

    reconstruct :: Int -> Int -> String
    reconstruct 0 _ = ""
    reconstruct _ 0 = ""
    reconstruct i j
      | str1 !! (i - 1) == str2 !! (j - 1) = str1 !! (i - 1) : reconstruct (i - 1) (j - 1)
      | lcsTable !! i !! (j - 1) > lcsTable !! (i - 1) !! j = reconstruct i (j - 1)
      | otherwise = reconstruct (i - 1) j

main :: IO ()
main = do
  let string1 = "longestcommonsubsequence"
  let string2 = "strongestcommonsequence"
  let (lengthLCS, subsequence) = lcs string1 string2

  putStrLn ("Longest Common Subsequence: " ++ subsequence)
  putStrLn ("Length: " ++ show lengthLCS)
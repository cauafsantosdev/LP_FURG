fahrenheitToCelsius :: Float -> Float
fahrenheitToCelsius f = (f - 32) * 5 / 9

celsiusToFahrenheit :: Float -> Float
celsiusToFahrenheit c = (c * 9 / 5) + 32

main :: IO ()
main = do
  putStrLn "Choose the conversion type:"
  putStrLn "1: Fahrenheit to Celsius"
  putStrLn "2: Celsius to Fahrenheit"
  
  option <- getLine
  
  if option == "1"
    then do
      putStrLn "Enter the temperature: "
      input <- getLine
      let temperature = read input :: Float
      let result = fahrenheitToCelsius temperature
      putStrLn $ show temperature ++ "°F is equivalent to " ++ show result ++ "°C"
  else if option == "2"
    then do
      putStrLn "Enter the temperature: "
      input <- getLine
      let temperature = read input :: Float
      let result = celsiusToFahrenheit temperature
      putStrLn $ show temperature ++ "°C is equivalent to " ++ show result ++ "°F"
  else
    putStrLn "Invalid option. Please run the program again and choose 1 or 2."
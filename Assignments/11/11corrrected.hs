module Main where
import System.IO
import Data.List
import Data.Bits
import Data.Maybe

rev :: [Char] -> [Char]
rev [] = []
rev (x:xs) = rev xs ++ [x]

fulladder :: Bool -> Bool->Bool -> [Bool]
fulladder a b c =  [ xor c (xor a b) ] ++ [ (a&&b) || ((xor a b) && c) ]

shift1 xs = head xs : init xs

g::String->Bool
g x = if x=="0" then False else True
f::Char -> Bool
f x = if x=='0' then False else True
s::Bool->String
s x = if x ==True then "1" else "0"
h::Char -> String
h x = if x == '1' then "1" else "0"

nbitadder:: Int->Int->String->String->String->String
nbitadder len i n1 n2 cin =  if (len)==i then ("") else ((((nbitadder len (i+(1::Int)) n1 n2 (s ((fulladder (f ((rev n1)!!i)) (f ((rev n2)!!i)) (g cin) )!!1)) )  ) ++ (s ((fulladder (f ((rev n1)!!i)) (f ((rev n2)!!i)) (g cin) )!!0))))

string :: Int -> String
string 0 = ""
string a  =  "0" ++ (string (a-(1::Int)))

string1 :: Int -> String
string1 1 = ""
string1 a  =  "0" ++ (string (a-(2::Int))) ++ "1"


invert:: String->Int->String
invert n2 0 = ""
invert n2 n = ( invert n2 (n -(1::Int)) ) ++ (if ( n2 !! (n-(1::Int)) == '0') then "1"  else "0" )


comp2s:: String->String
comp2s x = nbitadder (length x) 0 (string1 (length x)) (invert x (length x) ) "0"

mult :: String->String->Int->[String]
mult n1 n2 n  = do
              let prod = string n ++ n1 ++ "0"
              --putStrLn "AC_Reg  MR_Reg"
              product <-func n2 (comp2s n2) n prod
              return (product)

func::String->String->Int->String->[String]
func md md' 0 prod = [prod]
func md md' count prod 
                      | ( (((rev prod)!!1) =='0') && (((rev prod)!!0) == '0') ) =   [prod] ++ func md md' (count-(1::Int)) (shift1 prod)
                      | ( (((rev prod)!!1) =='1') && (((rev prod)!!0) == '1') ) =   [prod] ++ func md md' (count-(1::Int)) (shift1 prod)
                      | ( (((rev prod)!!1) =='0') && (((rev prod)!!0) == '1') ) =   [prod] ++ func md md' (count-(1::Int)) (shift1 (lol prod md) )
                      | ( (((rev prod)!!1) =='1') && (((rev prod)!!0) == '0') ) =   [prod] ++ func md md' (count-(1::Int)) (shift1 (lol prod md') )
                      | otherwise = func md md' 0 prod

lol::String->String->String
lol prod md = nbitadder (length prod) 0 prod (md ++ string ( (length prod) - (length md)  )  ) "0"


leave :: Int -> [a] -> [a]
leave 1 (x:xs) =  xs
leave n (x:xs) = leave (n - 1) xs

printElements :: Int -> [String] -> IO()
printElements _ [] = return ()
printElements i (x:xs) = do putStrLn ("reg1: " ++ (take i x))
                            putStrLn ("reg2: " ++(leave i x))
                            printElements i xs

count2 (x:xs) = if x==(head xs) then True else False 

count1 n1 = map (\y -> sum $ map (\x -> if x == y then 1 else 0) $ show $ n1) ['0','1']


main = do
  putStrLn "Enter the number of bits:"
  a<-getLine
  let n = read a :: Int
  putStrLn "Enter the two numbers:"
  n1<-getLine
  n2<-getLine
  let li = ( map init (if n1<n2 then ( (mult n1 n2 n)) else ( (mult n2 n1 n)) ) )
  print (li)
  printElements n li
  putStrLn ("answer: " ++ (last li))
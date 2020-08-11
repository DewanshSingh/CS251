import Data.List

--Q1
string2int :: [Char] -> Int
string2int a = read a :: Int
--Q1 END

--Q2
-- MAP

--using left fold

mapl :: (a -> b) -> [a] -> [b]
mapl f  = foldl (\acc x  -> acc ++ [f x]) []

--using right fold

mapr :: (a -> b) -> [a] -> [b]
mapr f = foldr (\x acc -> f x : acc) []

----------------------------------------------------------------

--FILTER

--using left fold

filterl :: (a -> Bool) -> [a] -> [a]
filterl f  = foldl (\acc xs ->  acc ++ if f xs then [xs] else [] ) []

--using right fold

filterr :: (a -> Bool) -> [a] -> [a]
filterr f  = foldr (\x acc -> if f x then x : acc else acc) []  

--Q2 END

--Q4A



sep :: [[Char]] -> [Char]
sep xs = intercalate "" xs

twod1020 :: Integer -> [Char]
twod1020 x
          | x==0 = "ten "
          | x==1 = "eleven "
          | x==2 = "twelve "
          | x==3 = "thirteen "
          | x==4 = "fourteen "
          | x==5 = "fiveteen "
          | x==6 = "sixteen "
          | x==7 = "seventeen "
          | x==8 = "eighteen "
          | x==9 = "nineteen "

oned :: Integer -> [Char]
oned x
      | x==0 = ""
      | x==1 = "one "
      | x==2 = "two "
      | x==3 = "three "
      | x==4 = "four "
      | x==5 = "five "
      | x==6 = "six "
      | x==7 = "seven "
      | x==8 = "eight "
      | x==9 = "nine "

onedhun :: Integer -> [Char]
onedhun x
    | x==0 = ""
    | x==1 = "one hundred "
    | x==2 = "two hundred "
    | x==3 = "three hundred "
    | x==4 = "four hundred "
    | x==5 = "five hundred "
    | x==6 = "six hundred "
    | x==7 = "seven hundred "
    | x==8 = "eight hundred "
    | x==9 = "nine hundred "

highs :: Integer -> [Char]
highs x
        | x==0 = ""
        | x==1 = "thousand "
        | x==2 = "million "
        | x==3 = "billion "

twod :: Integer -> [Char]
twod x
        | x==0 = ""
        | x==2 = "twenty "
        | x==3 = "thirty "
        | x==4 = "forty "
        | x==5 = "fivety "
        | x==6 = "sixty "
        | x==7 = "seventy "
        | x==8 = "eighty "
        | x==9 = "ninety "


leave :: Int -> [a] -> [a]
leave 1 (x:xs) =  xs
leave n (x:xs) = leave (n - 1) xs

c2 :: Integer -> [Integer] -> [Char]
c2 pv xs
         | ((xs !! 1 == 0) && (xs!!0==0) &&(xs!!2==0)) = []
         | ((xs !! 1 == 1) && (xs!!0 /= 0)&&(pv/=0)) = (onedhun(xs!!0)) ++ "and " ++ (twod1020 (xs!!2)) ++ (highs pv)++", "
         | ((xs !! 1 == 1) && (xs!!0 /= 0)) = (onedhun(xs!!0)) ++ "and " ++ (twod1020 (xs!!2)) ++ (highs pv)
         | ((xs !! 1 /= 1) && ((xs!!1/=0)||(xs!!2/=0)) && (xs!!0 /= 0)&&(pv/=0)) = (onedhun(xs!!0)) ++ "and " ++ (twod (xs!!1)) ++ (oned(xs!!2)) ++ (highs pv) ++", "
         | ((xs !! 1 /= 1) && (xs!!0 /= 0)&&(pv/=0)) = (onedhun(xs!!0)) ++ (twod (xs!!1)) ++ (oned(xs!!2)) ++ (highs pv) ++ ", "
         | ((xs !! 1 /= 1) && ((xs!!1/=0)||(xs!!2/=0)) && (xs!!0 /= 0)) = (onedhun(xs!!0)) ++ "and " ++ (twod (xs!!1)) ++ (oned(xs!!2)) ++ (highs pv)
         | ((xs !! 1 /= 1) && (xs!!0 /= 0)) = (onedhun(xs!!0)) ++ (twod (xs!!1)) ++ (oned(xs!!2)) ++ (highs pv)
         | ((xs !! 1 == 1) && (xs!!0 == 0)&&(pv/=0)) = (onedhun(xs!!0)) ++ (twod1020 (xs!!2)) ++ (highs pv)++ ", "
         | ((xs !! 1 == 1) && (xs!!0 == 0)) = (onedhun(xs!!0)) ++ (twod1020 (xs!!2)) ++ (highs pv)
         | ((xs !! 1 /= 1) && (xs!!0 == 0)&&(pv/=0)) = (onedhun(xs!!0)) ++ (twod (xs!!1)) ++ (oned(xs!!2)) ++ (highs pv)++ ", "
         | ((xs !! 1 /= 1) && (xs!!0 == 0)) = (onedhun(xs!!0)) ++ (twod (xs!!1)) ++ (oned(xs!!2)) ++ (highs pv)

call :: Integer -> [Integer] -> [[Char]]
call d xs
            | (d <= 3 && d >= 1) = (c2 0 (take 3 xs)) : call (d-3) (leave 3 xs)
            | (d >=4 && d <= 6) = (c2 1 (take 3 xs)) : call (d-3) (leave 3 xs)
            | (d >=7 && d <= 9) = (c2 2 (take 3 xs)) : call (d-3) (leave 3 xs)
            | (d >=10 && d <= 12) = (c2 3 (take 3 xs)) : call (d-3) (leave 3 xs)
            | otherwise = []

splitint :: Integer -> Integer -> [Integer]
splitint 0 _ = []
splitint d x = (x `div` (10^(d-1))) : (splitint (d-1) (x `mod` (10^(d-1))))

padd :: [Integer] -> Integer -> [Integer]
padd xs d
        | ((d `mod` 3)==1) = [0,0] ++ xs
        | ((d `mod` 3)==2) = [0] ++ xs
        | otherwise = xs

digits :: Integer -> Integer
digits x = (round(logBase 10 (fromIntegral x))) + 1

word2string :: Integer -> [Char]
word2string 0 = "zero"
word2string x = sep (call (digits x) (padd (splitint (digits x) x) (digits x)))

--Q4A END

--Q4B 

vvtwod1020 :: [Char] -> Integer
vvtwod1020 xs
          | xs== "ten" = 10
          | xs== "eleven" = 11
          | xs== "twelve" = 12
          | xs== "thirteen" = 13
          | xs== "fourteen" = 14
          | xs== "fiveteen" = 15
          | xs== "sixteen" = 16
          | xs== "seventeen" = 17
          | xs== "eighteen" = 18
          | xs== "nineteen" = 19

vvoned :: [Char] -> Integer
vvoned xs
      | xs== "one" =1
      | xs== "two"=2
      | xs== "three"=3
      | xs== "four"=4
      | xs== "five"=5
      | xs== "six"=6
      | xs== "seven"=7
      | xs== "eight"=8
      | xs== "nine"=9

vvhighs :: [Char] -> Integer
vvhighs xs
        | xs== "thousand" = 3
        | xs== "million" = 6
        | xs== "billion"= 9
        | xs== "thousand," = 3
        | xs== "million," = 6
        | xs== "billion,"= 9

vvtwod :: [Char] -> Integer
vvtwod xs
        | xs== "twenty" = 20
        | xs== "thirty" = 30
        | xs== "forty"= 40
        | xs== "fivety"= 50
        | xs== "sixty"= 60
        | xs== "seventy"= 70
        | xs== "eighty"= 80
        | xs== "ninety"= 90

do1 :: [[Char]] -> Integer -> Integer ->Integer
do1 [] a b = b+a
do1 (x:xs) a b
          | ((x `elem` o1)==True) = (do1 xs (a+(vvoned x)) b)
          | ((x == "hundred")) = (do1 xs (a*(10^2)) b)
          | ((x `elem` te1)==True) = (do1 xs (a+(vvtwod1020 x)) b)
          | ((x `elem` tw1)==True) = (do1 xs (a+(vvtwod x)) b)
          | ((x `elem` h1)==True) = (do1 xs 0 (b+(a*(10^(vvhighs x)))))
          | ((x == "and")||(x == ",")) = (do1 xs a b)
          where
                o1 = ["one","two","three","four","five","six","seven","eight","nine"]
                te1 = ["ten","eleven","twelve","thirteen","fourteen","fiveteen","sixteen","seventeen","eighteen","nineteen"]
                tw1 = ["twenty","thirty","forty","fivety","sixty","seventy","eighty","ninety"]
                h1 = ["billion","million","thousand","billion,","million,","thousand,"]

string2word :: [Char] -> Integer
string2word "zero" = 0
string2word xs = do1 (words (xs)) 0 0

--Q4B END

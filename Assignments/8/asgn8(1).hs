--format of I/O of the 3 questions

--insertAt 'X' "abcd" 2
--"aXbcd"

--incrrange [1 2 3 4 5] (2 3)
--[1 3 4 4 5]

--combinations 3 "abcdef"
--["abc","abd","abe",...]

--Q1

--here we append 3 different lists together. List of n-1 elements from starting,
--then the element to be inserted and lastly the list of remaining elements(skipping n-1 elements).

tak :: Integer -> [a] -> [a]
tak n _ | n<=0 = []
tak _ [] = []
tak n (x:xs) = x : tak (n - 1) xs

--take from index of n (skip n-1 places)
revtak :: Integer -> [a] -> [a]
revtak 1 xs = xs
revtak 2 (x:xs) =  xs
revtak n (x:xs) = revtak (n - 1) xs

insertAt :: a -> [a] -> Integer -> [a]
insertAt c xs n = tak (n - 1) xs ++ [c] ++ revtak n xs

--Q1 END

--Q2
--here we are recursively decrementing the values of a and b till a<=1 because
--this indicates that we have reached the ath index and can add 1, similarly for b>=1,
--we know that we have reached (b+1)th index and so we dont need to add 1 now.

incrrange :: [Int] -> (Int,Int) -> [Int]
incrrange [] (_,_) = []
--incrrange (x:xs) (a,b) =  if(a<=1 && b>=1) then (x + 1) : incrrange xs (a-1,b-1)
--                          else x : incrrange xs (a-1,b-1)
incrrange (x:xs) (a,b)
                     | (a<=1 && b>=1) = (x + 1) : incrrange xs (a-1,b-1)
                     | otherwise =  x : incrrange xs (a-1,b-1)
--Q2 END

--Q3

--here we are taking one element and appending it to the combinations(of size n-1)
--of remaining elements which are ahead of it in a recursive fashion.

leng :: [a] -> Int
leng [] = 0
leng (_:xs) = 1 + leng xs

leave :: Int -> [a] -> [a]
leave 1 (x:xs) =  xs
leave n (x:xs) = leave (n - 1) xs

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..((leng xs)-1)] , x <- combinations (n-1) (leave (i+1) xs) ]

--Q3 END

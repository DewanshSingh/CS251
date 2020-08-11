fib :: Integer -> Integer
fib 0 = 1
fib 1 = 1
fib n | n > 0 = fib( n - 2 ) + fib( n - 1 )

infinitefib :: [Integer]
infinitefib = [ fib x | x <- [0..] ]

tak :: Integer -> [Integer] -> [Integer]
tak n _ | n <= 0 = []
tak _ [] = []
tak n (x:xs) = x : tak (n-1) xs

las :: [Integer] -> Integer
las (x:[]) = x
las (x:xs) = las xs

factors :: Integer -> [Integer]
factors n = [ x | x <- [1..n], n `mod` x == 0 ]

prime :: Integer -> Integer
prime n = if factors n == [1,n] then 1 else 0

nprime :: Integer -> [Integer]
nprime n = [x | x <- [2..(20*n)] , (prime x) == 1]

nth :: Integer -> Integer
nth n = las ((tak n) (nprime n))

infiniteprime :: [Integer]
infiniteprime = [x | x <- [2..] , (prime x) == 1]

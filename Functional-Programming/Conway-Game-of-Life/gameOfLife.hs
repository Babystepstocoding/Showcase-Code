-- Conway's Game of Life Toy Problem
-- Thomas Rivet, 23-07-2020

-- Project intended as a first foray into Haskell
-- and reintroduction to functional programming
-- from a background in R5RS SCHEME

import Data.Matrix    -- Matrix is the most appropriate data type for game state, not included in GHC

-- |The count function counts the number of living cells
count :: [Bool] -> Int
count [] =  0
count (True:xs) = 1 + count xs
count(False:xs) = count xs

-- |The alive function applies GOL logic to the next iteration of a living cell
alive :: Int -> Bool
alive x
    | x <  2 = False
    | x > 3 = False
    | otherwise = True

-- |The dead function applies GOL logic to the next iteration of a dead cell
dead :: Int -> Bool
dead 3 = True
dead _ = False

-- |nextCell combines dead, alive, and count to directly determine the next state from a list of states of neighborss
nextCell :: [Bool] -> Bool -> Bool
nextCell neighbors state
    | state == True =  alive density
    | otherwise = dead density
    where density = count neighbors

-- |getNeighbors finds all possible neighbors of a cell's location an returns a list of their coordinates
getNeighbors :: Int -> Int -> Matrix a -> [(Int,Int)]
getNeighbors x y mat = [ (i,j) | i <- [1..(ncols mat)], j <- [1..(nrows mat)], abs (x - i) <= 1, abs (y - j) <= 1, (x,y) /= (i,j)]

-- |locToState is a helper function to separate elements of a location tuple and partially apply the matrix for mapping
locToState :: Matrix a -> (Int,Int) -> a
locToState mat tup = getElem (fst tup) (snd tup) mat

-- |the evolveCells function returns the next game state given an initial game state
evolveCells :: Matrix Bool -> Matrix Bool
evolveCells mat = fromList (nrows mat) (ncols mat) dList
    where dList = [nextCell (map (locToState mat) (getNeighbors x y mat)) (getElem x y mat) | x <- [1..(ncols mat)], y <- [1..(nrows mat)]]

-- |the play function returns an infinite list of consecutive game states given an initial game state. The game is played by taking n from the list to evaluate
play :: Matrix Bool -> [Matrix Bool]
play init = init:[evolveCells state | state <- (play init)]
# Conway's Game of Life
A bare bones, purely functional take on Conway's Game of Life in Haskell

## Dependencies
Make sure the matrix library is installed (Data.Matrix)

## Usage
This game **must** be run from an interactive Haskell prompt, preferably GHCI. From the downloaded directory, load the game file with the command:

    Prelude> :l gameOfLife

Define a matrix of boolean values as an initial state. True represents live cells, while False represents dead cells. For example

    Prelude> init = fromList 3 3 [True,False,True,False,True,False,True,False,True]

Play the game with the play function to create a lazy list of consecutive game states. Force evaluation with the take function. For example,

    Prelude> take 5 (play init)

will display the first five game states of the game populated by init.

## Design Considerations
This Game of Life implementation is not yet playable without writing interpreted code. This is a choice made in order to produce a workable concept from simple concepts as a learning exercise. As I get more comfortable with the language and paradigm, I may use I/O monads to allow for a code-free implementation.
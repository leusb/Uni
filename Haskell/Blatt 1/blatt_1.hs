-- Aufgabe 2

-- = ---------------------------------------------------------------------------
-- = - zeigeFeld und Beispielmatrizen.
-- = -

zeigeFeld feld = putStrLn $ unlines [[feld i (5-j) | i <- [1..5]] | j <- [1..4]]

-- Start
feldA 1 1 = 's'
feldA 1 2 = 's'
feldA 1 3 = 's'
feldA 1 4 = 's'
feldA 5 1 = 'w'
feldA 5 2 = 'w'
feldA 5 3 = 'w'
feldA 5 4 = 'w'
feldA _ _ = ' '

-- Fast erreichtes Ziel.
feldB 1 1 = 'w'
feldB 1 2 = 'w'
feldB 1 3 = 'w'
feldB 1 4 = 'w'
feldB 4 2 = 's'
feldB 5 1 = 's'
feldB 5 3 = 's'
feldB 5 4 = 's'
feldB _ _ = ' '


-- = -
-- = -
-- = ---------------------------------------------------------------------------
-- = -
-- = - Aufgabe a)
-- = -

istZugValide x1 y1 x2 y2 = x1==x2 || y1==y2


-- = -
-- = -
-- = ---------------------------------------------------------------------------
-- = -
-- = - Aufgabe b)
-- = -



bedroht x y color board = board x y /= color && board x y /= ' '


-- = -
-- = -
-- = ---------------------------------------------------------------------------
-- = -
-- = - Aufgabe c)
-- = -

-- gueltigerZug x1 y1 x2 y2 board = not (bedroht x2 y2 (board x1 x2) board)


gueltigerZug x1 y1 x2 y2 board = 
  istZugValide x1 y1 x2 y2 && --Zug valide
  not (bedroht x2 y2 (board x1 x2) board)&& -- not threat
  not (board x1 y1 == board x2 y2) && -- not the same color
  x1 < 6 && x2 < 6 && y1 < 5 && y2 <5 && -- field size not exceeded 
  and [coord > 0 | coord <- [x1,x2,y1,y2]] -- field size not falling below 1



-- = -
-- = -
-- = ---------------------------------------------------------------------------
-- = -
-- = - Aufgabe d)
-- = -

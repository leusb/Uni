import Data.Char

-- Aufgabe 1

-- = ---------------------------------------------------------------------------
-- = -
-- = -

-- a)
e1 = undefined


-- b)
e2 = undefined


-- Aufgabe 2

-- = ---------------------------------------------------------------------------
-- = -
-- = -

g = undefined


-- Aufgabe 3

-- = ---------------------------------------------------------------------------
-- = -
-- = -

-- a)
f1 = undefined


-- b)
f2 = undefined


-- c)
f3 = undefined


-- d)
f4 = undefined


-- Aufgabe 4

-- = ---------------------------------------------------------------------------
-- = -
-- = -

data Inventar = Inventar [Object] deriving(Show)
data Waffe = Waffe Name Staerke deriving(Show)
data CharakterCharakter = Charakter Name Waffe Inventar deriving(Show)
type Name = String
type Staerke = Int
type Object = String


-- a)
mein_Charakter :: Charakter
mein_Charakter = undefined


-- b)
wechsel_waffe :: Charakter -> Waffe -> Charakter
wechsel_waffe = undefined

-- c)
hole_aus_inventar :: Charakter -> String -> Charakter
hole_aus_inventar = undefined

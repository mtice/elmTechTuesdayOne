module Euler where

import Prelude

import Data.List (range, filter)
import Data.Foldable (sum)

ns = range 0 999

multiples = filter (\n -> mod n 3 == 0 || mod n 5 == 0) ns

answer = sum multiples

-- -- Running from PSCI
-- pulp psci
-- > import Euler
-- > answer
-- 233168
-- > :quit
-- See ya!

-- -- compile
-- pulp build
-- this will comile everyting in /src into javascript in /output
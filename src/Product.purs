module Product ( format, formatMaybe, formatUncurried, formatLambda, logPrice ) where
import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Maybe (Maybe(..))
import Data.Function.Uncurried (Fn3, mkFn3)


formatLambda :: Fn3 Number (Maybe Int ) String String
formatLambda = mkFn3 \price quantity title ->
    title <> " - $" <> show price <> formatQuantityMaybe quantity

formatUncurried :: Fn3 Number (Maybe Int ) String String
formatUncurried = mkFn3 formatMaybe

formatMaybe :: Number -> Maybe Int -> String -> String
formatMaybe price quantity title = 
    title <> " - $" <> show price <> formatQuantityMaybe quantity

format :: Number -> Int -> String -> String
format price quantity title = 
    title <> " - $" <> show price <> formatQuantity quantity

formatQuantity' :: Int -> String
formatQuantity' quantity = case quantity of
        0 -> ""
        _ -> " x " <> show quantity

formatQuantity :: Int -> String
formatQuantity = case _ of
    0 -> ""
    quantity -> " x " <> show quantity

formatQuantityMaybe :: Maybe Int -> String
formatQuantityMaybe = case _ of
    Nothing -> ""
    Just quantity -> " x " <> show quantity

logPrice :: forall e. Number -> Eff (console :: CONSOLE | e) Unit
logPrice price =
    log("This price is: " <> show price)

foo :: forall r. {bar :: Int | r} -> Int
foo obj = obj.bar

--tagged union
-- data food
--     = bard
--     | Martin Int
--     | Butter (String -> Foo)

-- type First = String
-- type Last = String
-- fullName :: First -> Last -> String
-- fullName first last = first <> last

-- bill :: String
-- bill = fullName
-- billFirst :: First
-- billFirst = "Bill"
-- billLast :: Last
-- billLast = "Last"

-- data FirstName = FirstName String
-- data LastName = LastName String

-- fullNameSafe :: FirstName -> LastName -> String
-- fullNameSafe (FirstName first) (LastName last) = first <> last

-- billFirstSafe :: FirstName
-- billFirstSafe = FirstName "Bill"

-- billLastSafe :: LastName
-- billLastSafe :: "Last"

-- billSafe :: String

-- billSafe = fullNameSafe billFirstSafe billLastSafe

-- newtype FirstNameNewType = FirstNameNewType String Bool
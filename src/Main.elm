import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Http


{-
= set values
  : type definitions "has type"
  main "has type" Program Never Model Msg
-}

main : Program Never Model Msg
main = 
    Html.program 
        { init = init 
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }


-- Model/View/Update structure.

{- 
    MODEL
    * Model type 
    * Initialize model with empty values
    * Initialize with a random quote
-}

type alias Model =
    { quote : String 
    }

init : (Model, Cmd Msg)
init =
    ( Model "", fetchRandomQuoteCmd )


-- API request URLs


api : String
api =
    "http://localhost:3001/"


randomQuoteUrl : String
randomQuoteUrl =
    api ++ "api/random-quote"


-- GET a random quote (unauthenticated)
fetchRandomQuote : Http.Request String
fetchRandomQuote =
    Http.getString randomQuoteUrl


fetchRandomQuoteCmd : Cmd Msg
fetchRandomQuoteCmd =
    Http.send FetchRandomQuoteCompleted fetchRandomQuote

{-
-updatind record
  updating properties of a record:: { recordName | property = updatedValue, property2 = updatedValue2 }
-}
fetchRandomQuoteCompleted : Model -> Result Http.Error String -> ( Model, Cmd Msg )
fetchRandomQuoteCompleted model result =
    case result of
        Ok newQuote ->
            ( { model | quote = newQuote }, Cmd.none )

        Err _ ->
            ( model, Cmd.none )


type Msg
    = GetQuote
    | FetchRandomQuoteCompleted (Result Http.Error String)  



------------ Update ---------------
{-
 -currying
   In a nutshell, currying means if you don't pass all the arguments to a function,
   another function will be returned that accepts whatever arguments are still needed
-}


{-
   UPDATE (update the application state via the model.)
   * API routes
   * GET and POST
   * Messages
   * Update case

   * Update takes a message as an argument and a model
      argument and returns a tuple containing a model 
      and a command for an effect with an update message
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetQuote ->
            ( model, fetchRandomQuoteCmd )

        FetchRandomQuoteCompleted result ->
            fetchRandomQuoteCompleted model result


{- 
    ~~now display a view~~
    VIEW
-}
-- Messages
view : Model -> Html Msg
{-That ^^ said::
    The type annotation for the view: 
    "view takes model as an argument and returns HTML with a message". 

    A command Cmd is a request for an effect to take place outside of Elm. 
    A message Msg is a function that notifies the update method that a command 
    was completed. The view needs to return HTML with the message outcome to display the updated UI.
-}
view model =
    div [ class "container" ] [
        h2 [ class "text-center" ] [ text "Chuck Norris Quotes" ]
        , p [ class "text-center" ] [
            button [ class "btn btn-success", onClick GetQuote ] [ text "Grab a quote!" ]
        ]
        -- Blockquote with quote
        , blockquote [] [ 
            p [] [text model.quote] 
        ]
    ]
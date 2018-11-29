module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Events exposing (onClick)


type alias Wine =
    { name : String
    , millesime : Int
    }


type alias Model =
    { wines : List Wine
    }


type Msg
    = Noop
    | Delete Wine


init : Model
init =
    { wines = wines }


update : Msg -> Model -> Model
update msg model =
    let
        _ =
            Debug.log "msg" msg
    in
    case msg of
        Noop ->
            model

        Delete wine ->
            { model
                | wines =
                    model.wines
                        |> List.filter (\w -> w /= wine)
            }


wines : List Wine
wines =
    [ Wine "Pic St Loup" 2015
    , { name = "Faugères", millesime = 2013 }
    ]


wineItem : Wine -> Html Msg
wineItem wine =
    div []
        [ text wine.name
        , text (String.fromInt wine.millesime)
        , button [ onClick (Delete wine) ]
            [ text "X" ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Hello World!" ]
        , p [] [ text "lorem ipsum" ]
        , ul []
            (List.map
                wineItem
                model.wines
            )
        , model.wines
            |> List.map wineItem
            |> ul []
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }

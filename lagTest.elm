import Window

time = lift (inSeconds . fst) (timestamp (fps 30))

rotate r = (\t -> ((sin t * r), (cos t * r))) <~ time

player color controller =
  let
    c = filled color (circle 5)
    m cord = move cord c
  in m <~ controller

player1 = player red (rotate 50)

render (w, h) p1 = collage w h [p1]

main = render <~ Window.dimensions ~ player1

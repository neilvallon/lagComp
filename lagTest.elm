import Window

time = lift (inSeconds . fst) (timestamp (fps 30))

player1 = 
  let
    c = filled (rgba 255 0 0 1) (circle 5)
    r = 100
    position = (\t -> ((sin t * r), (cos t * r))) <~ time
    m cord = move cord c
  in m <~ position


render (w, h) p1 = collage w h [p1]

main = render <~ Window.dimensions ~ player1

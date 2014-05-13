import Window

time = lift (inSeconds . fst) (timestamp (fps 30))

rotate r = (\t -> ((sin t * r), (cos t * r))) <~ time

discrete sig = sampleOn (fps 4) sig
delayed sig = delay (200 * millisecond) sig

player color controller =
  let
    c = filled color (circle 5)
    m cord = move cord c
  in m <~ controller

-- Local Player
p1Control = rotate 50
player1 = player red p1Control
--

-- Network Player
p2Control = discrete (delayed p1Control)
player2 = player blue p2Control
--

render (w, h) p1 p2 = collage w h [p1, p2]

main = render <~ Window.dimensions ~ player1 ~ player2

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

-- Calculate Crror
errDist sig1 sig2 =
  let
    diff (x1, y1) (x2, y2) = sqrt ((x1 - x2)^2 + (y1 - y2)^2)
  in diff <~ sig1 ~ sig2
netErr = round <~ errDist p1Control p2Control

--- Render Scene
render (w, h) p1 p2 dd = collage w h
  [ p1
  , p2
  , toForm <| asText dd ]

main = render <~ Window.dimensions ~ player1 ~ player2 ~ netErr

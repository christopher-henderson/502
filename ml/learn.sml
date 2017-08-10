fun sumList [] = 0 |
    sumList (h::t) = h + sumList t;
fun sumListTail L = sumList L;
(*sumList [22,4,7,1];
sumListTail [5,4,2,9];*)

fun fibonacci 0 = 1
  | fibonacci 1 = 1
  | fibonacci n = fibonacci(n - 1) + fibonacci(n - 2);

(*fibonacci 6;*)

fun reverseTail [] accumulator = accumulator
  | reverseTail (h::t) accumulator = reverseTail t (h::accumulator);

fun reverse [] = []
  | reverse [x] = [x]
  | reverse x = reverseTail x [];

(*reverse([1,2,3,4]);*)

fun rotate [] n = []
  | rotate L 0 = L
  | rotate (L as h::t) n = if length(L) <= n then
                              raise Empty
                           else
                              rotate (t @ [h]) (n - 1);

rotate [1,2,3,4,5] 3;

fun mpg () = (0, 0, 0)
  | mpg((miles : real, gallons : real)) = (miles, gallons, miles / gallons)
  | mpg((miles : real, gallons : real)::(t : tuple tuple)) =
    let
      val (miles, gallons, mileage) = mpg(t)
      val divisor = fn m => if m = 0 then 1 else 2 mileage
    in
      (m + miles, g + gallons, (miles / gallons + mileage) / divisor)
    end;

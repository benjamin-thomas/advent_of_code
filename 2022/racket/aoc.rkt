; #lang racket/base

#lang typed/racket

(: double (Number -> Number))
(define (double x)
  (* x 2))

; (: map-list (Listof Number -> Listof Number))
; (define (map-list (lst : (Listof Number)) : (Listof Number))
;   (map double lst))

; (map-list '(1 2 3))

; (map (λ (x : Number) : Number (* x 2)) '(1 2 3))

; echo ./aoc.rkt | entr -cr racket /_

; ====== MAIN ======

(: INPUT String)
(define INPUT #<<EOS
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
EOS
  )

(define salutation (list-ref '("Hi" "Hello") (random 2)))

(: greet (String -> String))
(define (greet name)
  (string-append salutation ", " name))

; (define (echo) (INPUT))
; (println (echo))
(println INPUT)
(printf "---\n")
(printf INPUT)

; ====== TEST ======

; See ./wip.rkt

(require typed/rackunit)

; #f is the boolean value for "false".
(check-eq? 1 (string->number "1"))
(check-eq? #f (string->number "1a"))

; (define (plus x y)
;   (+ x y))
; (check-equal? (plus 10 14) 24) ; valid
; ; (check-equal? (plus 10 10) 24) ; invalid, actual result is 20

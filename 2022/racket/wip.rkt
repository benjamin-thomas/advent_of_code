#lang racket/base

; echo wip.rkt | entr -cr racket /_
; echo wip.rkt | entr -cr bash -c 'racket wip.rkt && echo OK'

(define (to_int_exn n)
  (or (string->number n) (error "oops")))

(define (compute lst)
  (with-handlers ([exn:fail? (lambda (_) #f)]) (map to_int_exn lst)))

(require rackunit)

; #f is the boolean value for "false".
(check-equal? (string->number "1") 1)
(check-equal? (string->number "1a") #f)

; I mimic the same API as above
(check-equal? (compute '("1" "2" "3")) '(1 2 3) "Compute a valid list")
(check-equal? (compute '("1" "2x" "3")) #f "Fail early on invalid data")

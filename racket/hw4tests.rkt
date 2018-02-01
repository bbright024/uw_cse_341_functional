#lang racket

(require "hw4.rkt") 

;; A simple library for displaying a 2x3 grid of pictures: used
;; for fun in the tests below (look for "Tests Start Here").

(require (lib "graphics.rkt" "graphics"))

(open-graphics)

(define window-name "Programming Languages, Homework 4")
(define window-width 700)
(define window-height 500)
(define border-size 100)

(define approx-pic-width 200)
(define approx-pic-height 200)
(define pic-grid-width 3)
(define pic-grid-height 2)

(define (open-window)
  (open-viewport window-name window-width window-height))

(define (grid-posn-to-posn grid-posn)
  (when (>= grid-posn (* pic-grid-height pic-grid-width))
    (error "picture grid does not have that many positions"))
  (let ([row (quotient grid-posn pic-grid-width)]
        [col (remainder grid-posn pic-grid-width)])
    (make-posn (+ border-size (* approx-pic-width col))
               (+ border-size (* approx-pic-height row)))))

(define (place-picture window filename grid-posn)
  (let ([posn (grid-posn-to-posn grid-posn)])
    ((clear-solid-rectangle window) posn approx-pic-width approx-pic-height)
    ((draw-pixmap window) filename posn)))

(define (place-repeatedly window pause stream n)
  (when (> n 0)
    (let* ([next (stream)]
           [filename (cdar next)]
           [grid-posn (caar next)]
           [stream (cdr next)])
      (place-picture window filename grid-posn)
      (sleep pause)
      (place-repeatedly window pause stream (- n 1)))))

;; Tests Start Here

; These definitions will work only after you do some of the problems
; so you need to comment them out until you are ready.
; Add more tests as appropriate, of course.
(sequence 2 3 11)
(sequence 3 3 8)
(sequence 1 3 2)
(define nums (sequence 1 0 5))

(define files (string-append-map 
               (list "dan" "dog" "curry" "dog2") 
               ".jpg"))

;(list-nth-mod files -1)
;(list-nth-mod null 0)
(list-nth-mod files 0)
(list-nth-mod files 1)
(list-nth-mod files 2)
(list-nth-mod files 300)
;(funny-number-stream)
(define funny-test (stream-for-k-steps funny-number-stream 16))
funny-test
(stream-for-k-steps dan-then-dog 5)
(stream-add-one funny-number-stream)

(stream-for-k-steps (stream-add-one dan-then-dog) 5)
(define ls (stream-for-k-steps (cycle-lists nums files) 7))

(vector-assoc 4 (build-vector 5 add1))
(vector-assoc 2 (vector ls))
; a zero-argument function: call (one-visual-test) to open the graphics window, etc.
(define (one-visual-test)
  (place-repeatedly (open-window) 0.5 (cycle-lists nums files) 27))

; similar to previous but uses only two files and one position on the grid
(define (visual-one-only)
  (place-repeatedly (open-window) 0.5 (stream-add-one dan-then-dog) 27))

; test the cache now

(define cache-test-list (build-list 10 (lambda (x) (cons x x))))
(define cache-obj (caching-assoc cache-test-list 5))
(cache-obj 3)
(cache-obj 3)

;for problem 11
(define a 7)
(while-greater 2 do (begin (set! a (- a 1)) (print "x") a))
(while-greater 2 do (begin (set! a (- a 1)) (print "x") a))
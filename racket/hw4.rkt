#lang racket

(provide (all-defined-out)) ;; for tests in second file

;;code below

(define (sequence spacing low high)
  (if (<= low high)
      (cons low (sequence spacing (+ low spacing) high))
      null))

(define (string-append-map xs suffix)
  (map (lambda (str) (string-append str suffix)) xs))

(define (list-nth-mod xs n)
  (cond [(> 0 n) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [#t (let* ([l (length xs)]
                   [i (remainder n l)])
              (car (list-tail xs i)))]))

(define (stream-for-k-steps s k)
  (if (= 0 k)
      null
      (let ([pr (s)])
        (cons (car pr) (stream-for-k-steps (cdr pr) (- k 1))))))

(define funny-number-stream
  (letrec ([f (lambda (x)
                (if (= 0 (remainder x 6))
                    (cons (- 0 x) (lambda () (f (+ x 1))))
                    (cons x (lambda () (f (+ x 1))))))])
    (lambda () (f 1))))

(define dan-then-dog
  (letrec ([f (lambda (str)
                (if (string=? str "dan.jpg")
                    (cons str (lambda() (f "dog.jpg")))
                    (cons str (lambda() (f "dan.jpg")))))])
    (lambda () (f "dan.jpg"))))

(define (stream-add-one s)
  (letrec ([f (lambda (pr)
                (cons (cons 1 (car pr)) (lambda () (f ((cdr pr))))))])
    (lambda () (f (s)))))

(define (cycle-lists xs ys)
  (letrec ([f (lambda (n)
                (cons (cons (list-nth-mod xs n) (list-nth-mod ys n))
                      (lambda () (f (+ n 1))))
                )])
    (lambda () (f 0))))
      ;return a stream - head is a pair, tail is thunk ptr

(define (vector-assoc v vec)
  (letrec ([vlen (vector-length vec)]
           ;[pr (printf "searching vector cache/n")]
           [f (lambda (n)
                (if (>= n vlen)
                    #f
                    (let ([pr (vector-ref vec n)])
                      (if (and (pair? pr) (equal? v (car pr)))
                          pr
                          (f (+ n 1))))))])
    (f 0)))


(define (caching-assoc xs n)
  (letrec ([cache (make-vector n #f)]
           [free-spot 0]
           [f (lambda (v)
                (let ([ans (vector-assoc v cache)])
                  (if ans
                      (cdr ans)
                      (let ([new-ans (assoc v xs)])
                        (begin
                          (vector-set! cache free-spot (cons v new-ans))
                          (set! free-spot (if (= (- n 1) free-spot)
                                              0
                                              (+ 1 free-spot)))
                          ;(printf "~a set to ~s"
                           ;       free-spot
                            ;      ans)
                          new-ans)))))])
    f))


(define-syntax while-greater
  (syntax-rules (do)
    [(while-greater e1 do e2)
     (letrec ([lim e1]
              [f (lambda ()
                   (if (>= lim e2)
                       #t
                       (f)))])
       (f))]))
              
                       
                       







  
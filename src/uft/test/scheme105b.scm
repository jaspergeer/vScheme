;; ;;;;;;;;;;;;;;;;;;; COMP 105 SCHEME ASSIGNMENT ;;;;;;;;;;;;;;;


;  predefined uScheme functions 96a 
(define caar (xs) (car (car xs)))
(define cadr (xs) (car (cdr xs)))
(define cdar (xs) (cdr (car xs)))
;  predefined uScheme functions ((elided)) (THIS CAN'T HAPPEN -- claimed code was not used) 
;  more predefined combinations of [[car]] and [[cdr]] S151b 
(define cddr  (sx) (cdr (cdr  sx)))
(define caaar (sx) (car (caar sx)))
(define caadr (sx) (car (cadr sx)))
(define cadar (sx) (car (cdar sx)))
(define caddr (sx) (car (cddr sx)))
(define cdaar (sx) (cdr (caar sx)))
(define cdadr (sx) (cdr (cadr sx)))
(define cddar (sx) (cdr (cdar sx)))
(define cdddr (sx) (cdr (cddr sx)))
;  more predefined combinations of [[car]] and [[cdr]] S151c 
(define caaaar (sx) (car (caaar sx)))
(define caaadr (sx) (car (caadr sx)))
(define caadar (sx) (car (cadar sx)))
(define caaddr (sx) (car (caddr sx)))
(define cadaar (sx) (car (cdaar sx)))
(define cadadr (sx) (car (cdadr sx)))
(define caddar (sx) (car (cddar sx)))
(define cadddr (sx) (car (cdddr sx)))
;  more predefined combinations of [[car]] and [[cdr]] S151d 
(define cdaaar (sx) (cdr (caaar sx)))
(define cdaadr (sx) (cdr (caadr sx)))
(define cdadar (sx) (cdr (cadar sx)))
(define cdaddr (sx) (cdr (caddr sx)))
(define cddaar (sx) (cdr (cdaar sx)))
(define cddadr (sx) (cdr (cdadr sx)))
(define cdddar (sx) (cdr (cddar sx)))
(define cddddr (sx) (cdr (cdddr sx)))
;  predefined uScheme functions 96b 
(define list1 (x)     (cons x '()))
(define list2 (x y)   (cons x (list1 y)))
(define list3 (x y z) (cons x (list2 y z)))
;  predefined uScheme functions 99b 
(define append (xs ys)
  (if (null? xs)
     ys
     (cons (car xs) (append (cdr xs) ys))))
;  predefined uScheme functions 100b 
; (reverse xs) followed by ys
(define revapp (xs ys)
  (if (null? xs)
     ys
     (revapp (cdr xs) (cons (car xs) ys))))
;  predefined uScheme functions 101a 
(define reverse (xs) (revapp xs '()))
;  predefined uScheme functions ((elided)) (THIS CAN'T HAPPEN -- claimed code was not used) 
(define nth (n xs)
  (if (= n 0)
    (car xs)
    (nth (- n 1) (cdr xs))))

;; (define CAPTURED-IN (i xs) (nth (+ i 1) xs))
;; ;  definitions of predefined uScheme functions [[and]], [[or]], and [[not]] 97a 
(define and (b c) (if b  c  b))
;; (define or  (b c) (if b  b  c))
;; (define not (b)   (if b #f #t))
;; ;  predefined uScheme functions 102c 
(define atom? (x) (or (symbol? x) (or (number? x) (or (boolean? x) (null? x)))))
;  predefined uScheme functions 103b 
(define equal? (sx1 sx2)
  (if (atom? sx1)
    (= sx1 sx2)
    (if (atom? sx2)
        #f
        (and (equal? (car sx1) (car sx2))
             (equal? (cdr sx1) (cdr sx2))))))
;  predefined uScheme functions 105c 
(define make-alist-pair (k a) (list2 k a))
(define alist-pair-key        (pair)  (car  pair))
(define alist-pair-attribute  (pair)  (cadr pair))
;  predefined uScheme functions 105d 
(define alist-first-key       (alist) (alist-pair-key       (car alist)))
(define alist-first-attribute (alist) (alist-pair-attribute (car alist)))
;  predefined uScheme functions 106a 
(define bind (k a alist)
  (if (null? alist)
    (list1 (make-alist-pair k a))
    (if (equal? k (alist-first-key alist))
      (cons (make-alist-pair k a) (cdr alist))
      (cons (car alist) (bind k a (cdr alist))))))
(define find (k alist)
  (if (null? alist)
    '()
    (if (equal? k (alist-first-key alist))
      (alist-first-attribute alist)
      (find k (cdr alist)))))
;  predefined uScheme functions 125a 
;  predefined uScheme functions 126b 
;  predefined uScheme functions 129a 
(define filter (p? xs)
  (if (null? xs)
    '()
    (if (p? (car xs))
      (cons (car xs) (filter p? (cdr xs)))
      (filter p? (cdr xs)))))
;  predefined uScheme functions 129b 
(define map (f xs)
  (if (null? xs)
    '()
    (cons (f (car xs)) (map f (cdr xs)))))
;  predefined uScheme functions 130a 
(define app (f xs)
  (if (null? xs)
    #f
    (begin (f (car xs)) (app f (cdr xs)))))
;  predefined uScheme functions 130b 
(define exists? (p? xs)
  (if (null? xs)
    #f
    (if (p? (car xs)) 
      #t
      (exists? p? (cdr xs)))))
(define all? (p? xs)
  (if (null? xs)
    #t
    (if (p? (car xs))
      (all? p? (cdr xs))
      #f)))
;  predefined uScheme functions 130d 
(define foldr (op zero xs)
  (if (null? xs)
    zero
    (op (car xs) (foldr op zero (cdr xs)))))
(define foldl (op zero xs)
  (if (null? xs)
    zero
    (foldl op (op (car xs) zero) (cdr xs))))
;  predefined uScheme functions S150c 
(val newline      10)   (val left-round    40)
(val space        32)   (val right-round   41)
(val semicolon    59)   (val left-curly   123)
(val quotemark    39)   (val right-curly  125)
                        (val left-square   91)
                        (val right-square  93)
;  predefined uScheme functions S150d 
(define <= (x y) (not (> x y)))
(define >= (x y) (not (< x y)))
(define != (x y) (not (= x y)))
;  predefined uScheme functions S150e 
(define max (x y) (if (> x y) x y))
(define min (x y) (if (< x y) x y))
;  predefined uScheme functions S151a 
(define negated (n) (- 0 n))
(define mod (m n) (- m (* n (idiv m n))))
(define gcd (m n) (if (= n 0) m (gcd n (mod m n))))
(define lcm (m n) (if (= m 0) 0 (* m (idiv n (gcd m n)))))
;  predefined uScheme functions S151e 
(define list4 (x y z a)         (cons x (list3 y z a)))
(define list5 (x y z a b)       (cons x (list4 y z a b)))
(define list6 (x y z a b c)     (cons x (list5 y z a b c)))
(define list7 (x y z a b c d)   (cons x (list6 y z a b c d)))
(define list8 (x y z a b c d e) (cons x (list7 y z a b c d e)))
(define assoc (v pairs)
  (if (null? pairs)
      #f
      (let* ([first (car pairs)]
            [rest (cdr pairs)])
        (if (equal? v (car first))
            first
            (assoc v rest)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;;  Exercise 1

;; (is_prefix?' xs ys) determinies whether there exists xs
;; is an sublist of ys starting from the first index

;; laws:
;;   (is_prefix? '() ws) = #t
;;   (is_prefix? (cons v vs) '()) = #f
;;   (is_prefix? (cons v vs) '(cons w ws)) = (and (equal? v w) 
;;                                                (is_prefix? vs ws))

(define is_prefix? (xs ys)
    (if (null? xs)
        #t
        (if (null? ys)
            #f
            (and (equal? (car xs) (car ys)) (is_prefix? (cdr xs) (cdr ys))))))

        (check-assert (is_prefix? '(a b) '(a b c)))
        (check-assert (not (is_prefix? '(a b) '(c a b))))
        (check-assert (is_prefix? '() '(a b c)))



;; ;; (contig-sublist? xs ys) determines whether the first list
;; ;; is a contiguous subsequence of the second lisst, when xs
;; ;; and ys are list of atoms

;; ;; laws:
;; ;;   (contig-sublist? xs '()) == #f
;; ;;   (contig-sublist? xs (cons y ys)) == (or (is_prefix? xs (cons y ys))
;; ;;                                           (contig-sublist xs ys))

;; (define contig-sublist? (xs ys)
;;     (if (null? ys)
;;         #f
;;         (or (is_prefix? xs ys) (contig-sublist? xs (cdr ys)))))

;;         (check-assert (contig-sublist? '(a b) '(c a b)))
;;         (check-assert (not (is_prefix? '(a b) '(c b a c))))

;; ;; my previous answer is incorrect, I choose the standard solution
;; ;; implementation that considers an empty list as a base case

;; (contig-sublist? '() zs) == #t
;; (contig-sublist? (cons y ys) '()) == #f
;; (contig-sublist? (cons y ys) (cons z zs)) == (|| (prefix? (cons y ys) (cons z zs)) 
;;                                                  (contig-sublist? (cons y ys) zs))

(define contig-sublist? (xs ys) 
    (if (is_prefix? xs ys)
        #t
        (if (null? ys)
            #f
            (contig-sublist? xs (cdr ys)))))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;
;; ;;;;  Exercise 8

;; ;; (mirror xs) returns a list in reverse order, when xs is
;; ;; a list of S-expression

;; ;; laws:
;; ;;   (mirror a) == a, where a is an atom
;; ;;   (mirror (cons y ys)) == (append (mirror ys) (list1 (mirror y)))

(define mirror (xs)
    (if (atom? xs)
        xs
        (append (mirror (cdr xs)) (list1 (mirror (car xs))))))
  
        (check-expect (mirror '(1)) '(1))
        (check-expect (mirror '(1 2 3 4 5)) '(5 4 3 2 1))
        (check-expect (mirror '((a (b 5)) (c d) e)) '(e (d c) ((5 b) a)))
        (check-expect (mirror '()) '())



;; ;; (flatten xs) comsumes a list of S-expression and erases internal brackets

;; ;; laws:
;; ;;   (flatten '()) == '()
;; ;;   (flatten a) == '(a), where a is an atom
;; ;;   (flatten (cons x xs)) == (append (flatten x) (flatten xs))

(define flatten (xs)
    (if (null? xs)
        '()
        (if (atom? xs)
            (cons xs '())
            (append (flatten (car xs)) (flatten (cdr xs))))))

        (check-expect (flatten '((((a))))) '(a))
        (check-expect (flatten '((hi) (hello))) '(hi hello))
        (check-expect (flatten '((a) () ((b c) d  e))) '(a b c d e))



;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;
;; ;;;;  Exercise 31


;; ;; (takewhile p? xs) returns the longest prefix of the list
;; ;; in which every element satisfies the predicate

;; ;; laws:
;; ;;   (takewhile p? '()) == '()
;; ;;   (takewhile p? (cons y ys)) == (cons y (takewhile p? ys)), where p? y = true
;; ;;   (takewhile p? (cons y ys)) == '(), where p? y == false

(define takewhile (p? xs)
        (if (null? xs)
            '()
            (if (p? (car xs))
                (cons (car xs) (takewhile p? (cdr xs)))
                '())))

        (define p1? (x) (= x 1))
        (check-expect (takewhile p1? '(1 0 1 0 11 0 1)) '(1))

        (check-expect (takewhile (lambda (x) (= (mod x 2) 0)) 
                        '(2 4 6 7 8 10 12)) '(2 4 6))



;; ;; (dropwhile p? xs) removes the longest prefix of the list
;; ;; in which every element satisfies the predicate, and return
;; ;; whatever is left over

;; ;; laws:
;; ;;   (dropwhile p? '()) == '()
;; ;;   (dropwhile p? (cons y ys)) == (dropwhile ys), where p? y == true
;; ;;   (dropwhile p? (cons y ys)) == (cons y ys), where p? y == false

(define dropwhile (p? xs)
    (if (null? xs)
        '()
        (if (p? (car xs))
            (dropwhile p? (cdr xs))
            xs)))

        (check-expect (dropwhile (lambda (x) (= x 1)) 
                                 '(1 0 1 0 11 0 1)) '(0 1 0 11 0 1))
        (check-expect (dropwhile (lambda (x) (= (mod x 2) 0)) 
                                 '(2 4 6 7 8 10 12)) '(7 8 10 12))



;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;
;; ;;;;  Exercise B


;; ;; (take n xs) returns the longest prefix of xs that contains
;; ;; at most n elements

;; ;; laws:
;; ;;   (take n '()) == '()
;; ;;   (take 0 (cons y ys)) == '()
;; ;;   (take (+ n 1) (cons y ys)) == (cons y (take n ys))


(define take (n xs)
    (if (null? xs)
        '()
        (if (= n 0)
            '()
            (cons (car xs) (take (- n 1) (cdr xs))))))
        
        (check-expect (take 100 '(1 0)) '(1 0))
        (check-expect (take 0 '(1 0)) '())
        (check-expect (take 2 '(1 2 3 4 5)) '(1 2))


;; ;; (drop n xs) it removes n elements from the front of the list.

;; ;; laws:
;; ;;   (drop n '()) == '()
;; ;;   (drop 0 (cons y ys)) == (cons y ys)
;; ;;   (drop (+ n 1) (cons y ys)) == (drop n ys))

(define drop (n xs)
    (if (null? xs)
        '()
        (if (= n 0)
            xs
            (drop (- n 1) (cdr xs)))))
        
        (check-expect (drop 100 '(1 0)) '())
        (check-expect (drop 0 '(1 0)) '(1 0))
        (check-expect (drop 2 '(1 2 3 4 5)) '(3 4 5))



;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;
;; ;;;;  Exercise C


;; ;; (zip xs ys) converts a pair of lists with the same length
;; ;;             to a list of pairs by  associating corresponding values
;; ;;             in the two lists.

;; ;; laws:
;; ;;   (zip '() '()) == '()
;; ;;   (zip (cons w ws) (cons z zs)) == (append (bind w z '()) (zip ws zs))

(define zip (xs ys)
    (if (and (null? xs) (null? ys))
        '()
        (append (bind (car xs) (car ys) '()) (zip (cdr xs) (cdr ys)))))

        (check-expect (zip '(1 0) '(a b)) '((1 a) (0 b)))
        (check-expect (zip '(1) '(a)) '((1 a)))
        (check-expect (zip '(11 11 15) '(Guyer Sheldon Korman)) 
                     '((11 Guyer) (11 Sheldon) (15 Korman)))


;; (unzip ps) converts a list of pairs to a pair of lists.

;; laws:
;;   (unzip ps) = (cons (map car ps) (cons (map cadr ps) '())))

(define unzip (ps)
        (cons (map car ps) (cons (map cadr ps) '())))

;; car and cadr got etaExpanded

(define plus1 (x) (+ x 1))

(define mapp (xs) (map plus1 xs))

(define unzip (ps)
        (cons (map car ps) (cons (map cadr ps) '())))

        (check-expect  (unzip '((1 a) (2 b) (3 c))) '((1 2 3) (a b c)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;;  Exercise D


;; (arg-max f xs) a function f that maps a value in set xs to a number,
;; and a nonempty list as of values in set A. It returns an (in fact the first)
;; element a in as for which (f a) is as large as possible.

;; laws:
;;   arg-max f xs == (car (filter (lambda (x) (= (f x) (max* (map f xs)))) xs)))

;; for solution to run, i need to copy the definition of max*

;; (max* xs) finds the maximum of a non-empty list of integers

(define max* (xs)
    (foldl max (car xs) xs))

(define arg-max (f xs)
        (car (filter (lambda (x) (= (f x) (max* (map f xs)))) xs)))

        (check-expect (arg-max car '((105 PL) (160 Algorithms) (170 Theory)))
                      '(170 Theory))
        (check-expect (arg-max (lambda (a) (* a a)) '(5 4 3 2 1)) 5)
        (check-expect (arg-max car '((105 PL) (170 Algorithms) (170 Theory)))
                      '(170 Algorithms))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;;  Exercise E


;; (rightmost-point ps) takes a nonempty list of point records
;; and returns the first one with the largest x coordinate.
;; Break ties by returning the first point with max x

;; laws:
;;   (arg-max f xs) == (arg-max point-x ps)

(record point [x y])

(define rightmost-point (ps)
    (arg-max point-x ps))

        (check-expect (rightmost-point '([make-point 1 2] [make-point 3 4])) 
                                        '[make-point 3 4])
        (check-expect (rightmost-point '([make-point 5 6] 
                                         [make-point 1 2]
                                         [make-point 3 4]
                                         [make-point 5 7])) '[make-point 5 6])

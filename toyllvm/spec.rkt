#lang rosette/safe

(require
  serval/llvm
  serval/lib/core
  serval/lib/unittest
  serval/spec/refinement
  (only-in racket/base parameterize struct-copy)

  (prefix-in program: "./test.ll.rkt")
  (prefix-in program: "./test.map.rkt")
  (prefix-in program: "./test.globals.rkt")
)

(provide (all-defined-out))

(struct state (retval foobar) #:mutable #:transparent)

; The abstraction function is just the identity function because we're
; currently using the LLVM `machine` type as the state type for the spec as
; well as the implementation
(define (abs-function m)
  (define foobar (find-block-by-name (machine-mregions m) 'foobar))
  (state (machine-retval m) (mblock-iload foobar null))
)

; This is basically copied from the certikos LLVM verifier, so I'm not 100%
; sure what it does.
(define (make-machine-func func)
  ; our `func` takes some number of arguments, we want to output a function
  ; that takes a `machine` struct and a `list` of arguments
  (lambda (m . args)
    ; I don't know what `parameterize` does exactly
    (parameterize ([current-machine m])
      ; OK, call `func` by passing in each of the elements in `args` as a
      ; separate argument
      (define result (apply func args))
      ; Store the result of the function as the machine's retvalv field
      (set-machine-retval! m result))))

; Representation invariant:
; "foobar" is always positive. Why? Idk... just to have _some_ invariant
(define (rep-invariant m)
  ; find the "foobar" block, which represents the global variable
  (define foobar-block (find-block-by-name (machine-mregions m) 'foobar))
  ; Read it...
  (define foobar (mblock-iload foobar-block null))
  ; check that foobar > 0
  (bvsgt foobar (bv 0 64))
)

; The LLVM assembly (the implementation)
; Stale: now replaced by compiling test.c -> test.ll -> test.ll.rkt
;(define (@add2 base)
;  (define-value %0)
;  (set! %0 (bvadd base (bv 2 64)))
;  (ret %0))

; Specification corresponding to the LLVM function above
(define (spec-add2 s base)
  (cond
    [(bvsgt base (bv 22 64)) (set-state-foobar! s base)])
  (set-state-retval! s (bvadd base (bv 2 64))))


; Refine for an LLVM machine
(define (verify-llvm-refinement spec-func impl-func [args null])
  (define implmachine (make-machine program:symbols program:globals)) ; `machine` state used for impl
  (define specstate (state (make-bv64) (make-bv64))) ; specification state
  (verify-refinement
    #:implstate implmachine
    #:impl (make-machine-func impl-func) ; go from LLVM function to machine function
    #:specstate specstate
    #:spec spec-func
    #:abs abs-function ; abstraction function
    #:ri rep-invariant
    args))

; Unit tests to run the refinement
(define test-tests
  (test-suite+ "Test LLVM tests"
	(test-case+ "add2 LLVM"
		(verify-llvm-refinement spec-add2 program:@add2 (list (make-bv64))))
))

(module+ test
 (time (run-tests test-tests)))


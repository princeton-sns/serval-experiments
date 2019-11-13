#lang rosette/safe

(require
  serval/llvm
  serval/lib/core
  serval/lib/unittest
  serval/spec/refinement
)

(define (abs-function machine)
  machine
)

(define (@add2 s %0)
  (ret %0))

(define (verify-llvm-refinement spec-func impl-func [args null])
  (define machine (make-machine '() '()))
  (verify-refinement
    #:implstate machine
    #:impl impl-func
    #:specstate '()
    #:spec spec-func
    #:abs abs-function
    #:ri (lambda (args) #t)
    args))

(define (spec-add2 s base)
  set-machine-retval! base)

(define test-tests
  (test-suite+ "Test LLVM tests"
	(test-case+ "add2 LLVM"
		(verify-llvm-refinement spec-add2 @add2))
))

(module+ test
 (time (run-tests test-tests)))

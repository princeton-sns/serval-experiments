; DO NOT MODIFY.
;
; This file was automatically generated.

#lang rosette

(provide (all-defined-out))

(require serval/lib/core
         serval/llvm
         serval/ubsan)

(define-global @foobar)

(define (@add2 %0)
; %1
  (define-label (%1) #:merge #f
    (store %0 @foobar (bitvector 64) #:align 8)
    (set! %2 (add %0 (bv #x0000000000000002 64)))
    (ret %2))

  (define-value %2)
  (enter! %1))

(define (@_start)
; %0
  (define-label (%0) #:merge #f
    (ret))

  (enter! %0))

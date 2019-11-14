; DO NOT MODIFY.
;
; This file was automatically generated.

#lang rosette

(provide (all-defined-out))

(require serval/lib/core
         serval/llvm
         serval/ubsan)

(target-endian 'little)
(target-pointer-bitwidth 64)

(define-global @foobar)

; @add2: i64 (i64)
(define-function (@add2 [%0 : (bitvector 64)])
; %1                                              ; preds =
  (define-label (%1) #:merge #f
;   store i64 %0, i64* @foobar, align 8, !tbaa !3
    (store %0 @foobar (bitvector 64) #:align 8)
;   %2 = add i64 %0, 2
    (set! %2 (add %0 (bv 2 64)))
;   ret i64 %2
    (ret %2))

; entry
  (define-value %2)
  (enter! %1))

; @_start: void ()
(define-function (@_start)
; %0                                              ; preds =
  (define-label (%0) #:merge #f
;   ret void
    (ret))

; entry
  (enter! %0))


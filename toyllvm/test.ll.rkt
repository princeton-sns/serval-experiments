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

; @add2: i64 (i64)
(define-function (@add2 [%0 : (bitvector 64)])
; %1                                              ; preds =
  (define-label (%1) #:merge #f
;   %2 = add i64 %0, 2
    (set! %2 (add %0 (bv 2 64)))
;   ret i64 %2
    (ret %2))

; entry
  (define-value %2)
  (enter! %1))


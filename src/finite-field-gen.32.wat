;; generated for w=32, n=12, n*w=384
(module
  (export "multiply" (func $multiply))
  (func $multiply (param $xy i32) (param $x i32) (param $y i32)
    (local $tmp i64) (local $carry i64) (local $m i64) (local $A i64)
    
    (local $x00 i64) (local $x01 i64) (local $x02 i64) (local $x03 i64) 
    (local $x04 i64) (local $x05 i64) (local $x06 i64) (local $x07 i64) 
    (local $x08 i64) (local $x09 i64) (local $x10 i64) (local $x11 i64) 
    
    (local $y00 i64) (local $y01 i64) (local $y02 i64) (local $y03 i64) 
    (local $y04 i64) (local $y05 i64) (local $y06 i64) (local $y07 i64) 
    (local $y08 i64) (local $y09 i64) (local $y10 i64) (local $y11 i64) 
    
    (local $t00 i64) (local $t01 i64) (local $t02 i64) (local $t03 i64) 
    (local $t04 i64) (local $t05 i64) (local $t06 i64) (local $t07 i64) 
    (local $t08 i64) (local $t09 i64) (local $t10 i64) (local $t11 i64) 
    
    (local.set $x00 (i64.load offset=0 (local.get $x)))
    (local.set $x01 (i64.load offset=8 (local.get $x)))
    (local.set $x02 (i64.load offset=16 (local.get $x)))
    (local.set $x03 (i64.load offset=24 (local.get $x)))
    (local.set $x04 (i64.load offset=32 (local.get $x)))
    (local.set $x05 (i64.load offset=40 (local.get $x)))
    (local.set $x06 (i64.load offset=48 (local.get $x)))
    (local.set $x07 (i64.load offset=56 (local.get $x)))
    (local.set $x08 (i64.load offset=64 (local.get $x)))
    (local.set $x09 (i64.load offset=72 (local.get $x)))
    (local.set $x10 (i64.load offset=80 (local.get $x)))
    (local.set $x11 (i64.load offset=88 (local.get $x)))
    
    (local.set $y00 (i64.load offset=0 (local.get $y)))
    (local.set $y01 (i64.load offset=8 (local.get $y)))
    (local.set $y02 (i64.load offset=16 (local.get $y)))
    (local.set $y03 (i64.load offset=24 (local.get $y)))
    (local.set $y04 (i64.load offset=32 (local.get $y)))
    (local.set $y05 (i64.load offset=40 (local.get $y)))
    (local.set $y06 (i64.load offset=48 (local.get $y)))
    (local.set $y07 (i64.load offset=56 (local.get $y)))
    (local.set $y08 (i64.load offset=64 (local.get $y)))
    (local.set $y09 (i64.load offset=72 (local.get $y)))
    (local.set $y10 (i64.load offset=80 (local.get $y)))
    (local.set $y11 (i64.load offset=88 (local.get $y)))
    
    ;; i = 0
    ;; j = 0
    ;; (A, tmp) = t[0] + x[i]*y[0]
    (local.get $t00)
    (i64.mul (local.get $x00) (local.get $y00))
    i64.add
    (local.set $tmp)
    (i64.shr_u (local.get $tmp) (i64.const 32))
    (local.set $A)
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (local.set $tmp)
    ;; m = tmp * mu (mod 2^w)
    (i64.mul (local.get $tmp) (i64.const 0xfffcfffd))
    (i64.const 0xffffffff) i64.and
    (local.set $m)
    ;; carry = (tmp + m * p[0]) >> w
    (local.get $tmp)
    (i64.mul (local.get $m) (i64.const 0xffffaaab))
    i64.add
    (i64.const 32) i64.shr_u (local.set $carry)
    
    ;; j = 1
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t01)
    (local.get $x00)
    (local.get $y01)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb9feffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t00 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 2
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t02)
    (local.get $x00)
    (local.get $y02)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb153ffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t01 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 3
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t03)
    (local.get $x00)
    (local.get $y03)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1eabfffe))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t02 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 4
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t04)
    (local.get $x00)
    (local.get $y04)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf6b0f624))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t03 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 5
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t05)
    (local.get $x00)
    (local.get $y05)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x6730d2a0))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t04 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 6
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t06)
    (local.get $x00)
    (local.get $y06)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf38512bf))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t05 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 7
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t07)
    (local.get $x00)
    (local.get $y07)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x64774b84))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t06 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 8
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t08)
    (local.get $x00)
    (local.get $y08)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x434bacd7))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t07 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 9
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t09)
    (local.get $x00)
    (local.get $y09)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x4b1ba7b6))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t08 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 10
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t10)
    (local.get $x00)
    (local.get $y10)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x397fe69a))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t09 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 11
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t11)
    (local.get $x00)
    (local.get $y11)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1a0111ea))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t10 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; t[11] = A + C
    (local.set $t11 (i64.add (local.get $A) (local.get $carry)))
    
    ;; i = 1
    ;; j = 0
    ;; (A, tmp) = t[0] + x[i]*y[0]
    (local.get $t00)
    (i64.mul (local.get $x01) (local.get $y00))
    i64.add
    (local.set $tmp)
    (i64.shr_u (local.get $tmp) (i64.const 32))
    (local.set $A)
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (local.set $tmp)
    ;; m = tmp * mu (mod 2^w)
    (i64.mul (local.get $tmp) (i64.const 0xfffcfffd))
    (i64.const 0xffffffff) i64.and
    (local.set $m)
    ;; carry = (tmp + m * p[0]) >> w
    (local.get $tmp)
    (i64.mul (local.get $m) (i64.const 0xffffaaab))
    i64.add
    (i64.const 32) i64.shr_u (local.set $carry)
    
    ;; j = 1
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t01)
    (local.get $x01)
    (local.get $y01)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb9feffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t00 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 2
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t02)
    (local.get $x01)
    (local.get $y02)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb153ffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t01 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 3
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t03)
    (local.get $x01)
    (local.get $y03)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1eabfffe))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t02 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 4
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t04)
    (local.get $x01)
    (local.get $y04)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf6b0f624))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t03 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 5
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t05)
    (local.get $x01)
    (local.get $y05)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x6730d2a0))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t04 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 6
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t06)
    (local.get $x01)
    (local.get $y06)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf38512bf))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t05 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 7
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t07)
    (local.get $x01)
    (local.get $y07)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x64774b84))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t06 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 8
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t08)
    (local.get $x01)
    (local.get $y08)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x434bacd7))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t07 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 9
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t09)
    (local.get $x01)
    (local.get $y09)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x4b1ba7b6))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t08 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 10
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t10)
    (local.get $x01)
    (local.get $y10)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x397fe69a))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t09 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 11
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t11)
    (local.get $x01)
    (local.get $y11)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1a0111ea))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t10 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; t[11] = A + C
    (local.set $t11 (i64.add (local.get $A) (local.get $carry)))
    
    ;; i = 2
    ;; j = 0
    ;; (A, tmp) = t[0] + x[i]*y[0]
    (local.get $t00)
    (i64.mul (local.get $x02) (local.get $y00))
    i64.add
    (local.set $tmp)
    (i64.shr_u (local.get $tmp) (i64.const 32))
    (local.set $A)
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (local.set $tmp)
    ;; m = tmp * mu (mod 2^w)
    (i64.mul (local.get $tmp) (i64.const 0xfffcfffd))
    (i64.const 0xffffffff) i64.and
    (local.set $m)
    ;; carry = (tmp + m * p[0]) >> w
    (local.get $tmp)
    (i64.mul (local.get $m) (i64.const 0xffffaaab))
    i64.add
    (i64.const 32) i64.shr_u (local.set $carry)
    
    ;; j = 1
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t01)
    (local.get $x02)
    (local.get $y01)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb9feffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t00 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 2
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t02)
    (local.get $x02)
    (local.get $y02)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb153ffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t01 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 3
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t03)
    (local.get $x02)
    (local.get $y03)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1eabfffe))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t02 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 4
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t04)
    (local.get $x02)
    (local.get $y04)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf6b0f624))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t03 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 5
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t05)
    (local.get $x02)
    (local.get $y05)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x6730d2a0))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t04 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 6
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t06)
    (local.get $x02)
    (local.get $y06)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf38512bf))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t05 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 7
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t07)
    (local.get $x02)
    (local.get $y07)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x64774b84))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t06 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 8
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t08)
    (local.get $x02)
    (local.get $y08)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x434bacd7))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t07 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 9
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t09)
    (local.get $x02)
    (local.get $y09)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x4b1ba7b6))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t08 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 10
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t10)
    (local.get $x02)
    (local.get $y10)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x397fe69a))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t09 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 11
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t11)
    (local.get $x02)
    (local.get $y11)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1a0111ea))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t10 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; t[11] = A + C
    (local.set $t11 (i64.add (local.get $A) (local.get $carry)))
    
    ;; i = 3
    ;; j = 0
    ;; (A, tmp) = t[0] + x[i]*y[0]
    (local.get $t00)
    (i64.mul (local.get $x03) (local.get $y00))
    i64.add
    (local.set $tmp)
    (i64.shr_u (local.get $tmp) (i64.const 32))
    (local.set $A)
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (local.set $tmp)
    ;; m = tmp * mu (mod 2^w)
    (i64.mul (local.get $tmp) (i64.const 0xfffcfffd))
    (i64.const 0xffffffff) i64.and
    (local.set $m)
    ;; carry = (tmp + m * p[0]) >> w
    (local.get $tmp)
    (i64.mul (local.get $m) (i64.const 0xffffaaab))
    i64.add
    (i64.const 32) i64.shr_u (local.set $carry)
    
    ;; j = 1
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t01)
    (local.get $x03)
    (local.get $y01)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb9feffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t00 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 2
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t02)
    (local.get $x03)
    (local.get $y02)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb153ffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t01 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 3
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t03)
    (local.get $x03)
    (local.get $y03)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1eabfffe))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t02 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 4
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t04)
    (local.get $x03)
    (local.get $y04)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf6b0f624))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t03 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 5
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t05)
    (local.get $x03)
    (local.get $y05)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x6730d2a0))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t04 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 6
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t06)
    (local.get $x03)
    (local.get $y06)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf38512bf))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t05 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 7
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t07)
    (local.get $x03)
    (local.get $y07)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x64774b84))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t06 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 8
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t08)
    (local.get $x03)
    (local.get $y08)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x434bacd7))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t07 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 9
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t09)
    (local.get $x03)
    (local.get $y09)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x4b1ba7b6))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t08 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 10
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t10)
    (local.get $x03)
    (local.get $y10)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x397fe69a))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t09 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 11
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t11)
    (local.get $x03)
    (local.get $y11)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1a0111ea))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t10 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; t[11] = A + C
    (local.set $t11 (i64.add (local.get $A) (local.get $carry)))
    
    ;; i = 4
    ;; j = 0
    ;; (A, tmp) = t[0] + x[i]*y[0]
    (local.get $t00)
    (i64.mul (local.get $x04) (local.get $y00))
    i64.add
    (local.set $tmp)
    (i64.shr_u (local.get $tmp) (i64.const 32))
    (local.set $A)
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (local.set $tmp)
    ;; m = tmp * mu (mod 2^w)
    (i64.mul (local.get $tmp) (i64.const 0xfffcfffd))
    (i64.const 0xffffffff) i64.and
    (local.set $m)
    ;; carry = (tmp + m * p[0]) >> w
    (local.get $tmp)
    (i64.mul (local.get $m) (i64.const 0xffffaaab))
    i64.add
    (i64.const 32) i64.shr_u (local.set $carry)
    
    ;; j = 1
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t01)
    (local.get $x04)
    (local.get $y01)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb9feffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t00 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 2
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t02)
    (local.get $x04)
    (local.get $y02)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb153ffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t01 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 3
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t03)
    (local.get $x04)
    (local.get $y03)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1eabfffe))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t02 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 4
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t04)
    (local.get $x04)
    (local.get $y04)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf6b0f624))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t03 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 5
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t05)
    (local.get $x04)
    (local.get $y05)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x6730d2a0))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t04 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 6
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t06)
    (local.get $x04)
    (local.get $y06)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf38512bf))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t05 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 7
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t07)
    (local.get $x04)
    (local.get $y07)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x64774b84))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t06 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 8
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t08)
    (local.get $x04)
    (local.get $y08)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x434bacd7))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t07 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 9
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t09)
    (local.get $x04)
    (local.get $y09)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x4b1ba7b6))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t08 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 10
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t10)
    (local.get $x04)
    (local.get $y10)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x397fe69a))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t09 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 11
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t11)
    (local.get $x04)
    (local.get $y11)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1a0111ea))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t10 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; t[11] = A + C
    (local.set $t11 (i64.add (local.get $A) (local.get $carry)))
    
    ;; i = 5
    ;; j = 0
    ;; (A, tmp) = t[0] + x[i]*y[0]
    (local.get $t00)
    (i64.mul (local.get $x05) (local.get $y00))
    i64.add
    (local.set $tmp)
    (i64.shr_u (local.get $tmp) (i64.const 32))
    (local.set $A)
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (local.set $tmp)
    ;; m = tmp * mu (mod 2^w)
    (i64.mul (local.get $tmp) (i64.const 0xfffcfffd))
    (i64.const 0xffffffff) i64.and
    (local.set $m)
    ;; carry = (tmp + m * p[0]) >> w
    (local.get $tmp)
    (i64.mul (local.get $m) (i64.const 0xffffaaab))
    i64.add
    (i64.const 32) i64.shr_u (local.set $carry)
    
    ;; j = 1
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t01)
    (local.get $x05)
    (local.get $y01)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb9feffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t00 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 2
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t02)
    (local.get $x05)
    (local.get $y02)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb153ffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t01 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 3
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t03)
    (local.get $x05)
    (local.get $y03)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1eabfffe))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t02 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 4
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t04)
    (local.get $x05)
    (local.get $y04)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf6b0f624))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t03 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 5
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t05)
    (local.get $x05)
    (local.get $y05)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x6730d2a0))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t04 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 6
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t06)
    (local.get $x05)
    (local.get $y06)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf38512bf))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t05 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 7
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t07)
    (local.get $x05)
    (local.get $y07)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x64774b84))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t06 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 8
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t08)
    (local.get $x05)
    (local.get $y08)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x434bacd7))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t07 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 9
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t09)
    (local.get $x05)
    (local.get $y09)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x4b1ba7b6))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t08 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 10
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t10)
    (local.get $x05)
    (local.get $y10)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x397fe69a))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t09 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 11
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t11)
    (local.get $x05)
    (local.get $y11)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1a0111ea))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t10 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; t[11] = A + C
    (local.set $t11 (i64.add (local.get $A) (local.get $carry)))
    
    ;; i = 6
    ;; j = 0
    ;; (A, tmp) = t[0] + x[i]*y[0]
    (local.get $t00)
    (i64.mul (local.get $x06) (local.get $y00))
    i64.add
    (local.set $tmp)
    (i64.shr_u (local.get $tmp) (i64.const 32))
    (local.set $A)
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (local.set $tmp)
    ;; m = tmp * mu (mod 2^w)
    (i64.mul (local.get $tmp) (i64.const 0xfffcfffd))
    (i64.const 0xffffffff) i64.and
    (local.set $m)
    ;; carry = (tmp + m * p[0]) >> w
    (local.get $tmp)
    (i64.mul (local.get $m) (i64.const 0xffffaaab))
    i64.add
    (i64.const 32) i64.shr_u (local.set $carry)
    
    ;; j = 1
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t01)
    (local.get $x06)
    (local.get $y01)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb9feffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t00 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 2
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t02)
    (local.get $x06)
    (local.get $y02)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb153ffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t01 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 3
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t03)
    (local.get $x06)
    (local.get $y03)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1eabfffe))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t02 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 4
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t04)
    (local.get $x06)
    (local.get $y04)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf6b0f624))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t03 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 5
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t05)
    (local.get $x06)
    (local.get $y05)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x6730d2a0))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t04 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 6
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t06)
    (local.get $x06)
    (local.get $y06)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf38512bf))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t05 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 7
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t07)
    (local.get $x06)
    (local.get $y07)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x64774b84))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t06 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 8
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t08)
    (local.get $x06)
    (local.get $y08)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x434bacd7))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t07 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 9
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t09)
    (local.get $x06)
    (local.get $y09)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x4b1ba7b6))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t08 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 10
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t10)
    (local.get $x06)
    (local.get $y10)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x397fe69a))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t09 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 11
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t11)
    (local.get $x06)
    (local.get $y11)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1a0111ea))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t10 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; t[11] = A + C
    (local.set $t11 (i64.add (local.get $A) (local.get $carry)))
    
    ;; i = 7
    ;; j = 0
    ;; (A, tmp) = t[0] + x[i]*y[0]
    (local.get $t00)
    (i64.mul (local.get $x07) (local.get $y00))
    i64.add
    (local.set $tmp)
    (i64.shr_u (local.get $tmp) (i64.const 32))
    (local.set $A)
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (local.set $tmp)
    ;; m = tmp * mu (mod 2^w)
    (i64.mul (local.get $tmp) (i64.const 0xfffcfffd))
    (i64.const 0xffffffff) i64.and
    (local.set $m)
    ;; carry = (tmp + m * p[0]) >> w
    (local.get $tmp)
    (i64.mul (local.get $m) (i64.const 0xffffaaab))
    i64.add
    (i64.const 32) i64.shr_u (local.set $carry)
    
    ;; j = 1
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t01)
    (local.get $x07)
    (local.get $y01)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb9feffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t00 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 2
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t02)
    (local.get $x07)
    (local.get $y02)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb153ffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t01 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 3
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t03)
    (local.get $x07)
    (local.get $y03)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1eabfffe))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t02 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 4
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t04)
    (local.get $x07)
    (local.get $y04)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf6b0f624))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t03 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 5
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t05)
    (local.get $x07)
    (local.get $y05)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x6730d2a0))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t04 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 6
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t06)
    (local.get $x07)
    (local.get $y06)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf38512bf))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t05 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 7
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t07)
    (local.get $x07)
    (local.get $y07)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x64774b84))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t06 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 8
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t08)
    (local.get $x07)
    (local.get $y08)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x434bacd7))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t07 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 9
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t09)
    (local.get $x07)
    (local.get $y09)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x4b1ba7b6))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t08 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 10
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t10)
    (local.get $x07)
    (local.get $y10)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x397fe69a))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t09 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 11
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t11)
    (local.get $x07)
    (local.get $y11)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1a0111ea))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t10 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; t[11] = A + C
    (local.set $t11 (i64.add (local.get $A) (local.get $carry)))
    
    ;; i = 8
    ;; j = 0
    ;; (A, tmp) = t[0] + x[i]*y[0]
    (local.get $t00)
    (i64.mul (local.get $x08) (local.get $y00))
    i64.add
    (local.set $tmp)
    (i64.shr_u (local.get $tmp) (i64.const 32))
    (local.set $A)
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (local.set $tmp)
    ;; m = tmp * mu (mod 2^w)
    (i64.mul (local.get $tmp) (i64.const 0xfffcfffd))
    (i64.const 0xffffffff) i64.and
    (local.set $m)
    ;; carry = (tmp + m * p[0]) >> w
    (local.get $tmp)
    (i64.mul (local.get $m) (i64.const 0xffffaaab))
    i64.add
    (i64.const 32) i64.shr_u (local.set $carry)
    
    ;; j = 1
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t01)
    (local.get $x08)
    (local.get $y01)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb9feffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t00 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 2
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t02)
    (local.get $x08)
    (local.get $y02)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb153ffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t01 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 3
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t03)
    (local.get $x08)
    (local.get $y03)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1eabfffe))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t02 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 4
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t04)
    (local.get $x08)
    (local.get $y04)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf6b0f624))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t03 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 5
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t05)
    (local.get $x08)
    (local.get $y05)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x6730d2a0))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t04 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 6
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t06)
    (local.get $x08)
    (local.get $y06)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf38512bf))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t05 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 7
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t07)
    (local.get $x08)
    (local.get $y07)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x64774b84))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t06 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 8
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t08)
    (local.get $x08)
    (local.get $y08)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x434bacd7))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t07 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 9
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t09)
    (local.get $x08)
    (local.get $y09)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x4b1ba7b6))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t08 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 10
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t10)
    (local.get $x08)
    (local.get $y10)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x397fe69a))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t09 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 11
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t11)
    (local.get $x08)
    (local.get $y11)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1a0111ea))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t10 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; t[11] = A + C
    (local.set $t11 (i64.add (local.get $A) (local.get $carry)))
    
    ;; i = 9
    ;; j = 0
    ;; (A, tmp) = t[0] + x[i]*y[0]
    (local.get $t00)
    (i64.mul (local.get $x09) (local.get $y00))
    i64.add
    (local.set $tmp)
    (i64.shr_u (local.get $tmp) (i64.const 32))
    (local.set $A)
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (local.set $tmp)
    ;; m = tmp * mu (mod 2^w)
    (i64.mul (local.get $tmp) (i64.const 0xfffcfffd))
    (i64.const 0xffffffff) i64.and
    (local.set $m)
    ;; carry = (tmp + m * p[0]) >> w
    (local.get $tmp)
    (i64.mul (local.get $m) (i64.const 0xffffaaab))
    i64.add
    (i64.const 32) i64.shr_u (local.set $carry)
    
    ;; j = 1
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t01)
    (local.get $x09)
    (local.get $y01)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb9feffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t00 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 2
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t02)
    (local.get $x09)
    (local.get $y02)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb153ffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t01 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 3
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t03)
    (local.get $x09)
    (local.get $y03)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1eabfffe))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t02 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 4
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t04)
    (local.get $x09)
    (local.get $y04)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf6b0f624))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t03 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 5
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t05)
    (local.get $x09)
    (local.get $y05)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x6730d2a0))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t04 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 6
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t06)
    (local.get $x09)
    (local.get $y06)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf38512bf))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t05 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 7
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t07)
    (local.get $x09)
    (local.get $y07)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x64774b84))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t06 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 8
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t08)
    (local.get $x09)
    (local.get $y08)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x434bacd7))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t07 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 9
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t09)
    (local.get $x09)
    (local.get $y09)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x4b1ba7b6))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t08 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 10
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t10)
    (local.get $x09)
    (local.get $y10)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x397fe69a))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t09 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 11
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t11)
    (local.get $x09)
    (local.get $y11)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1a0111ea))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t10 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; t[11] = A + C
    (local.set $t11 (i64.add (local.get $A) (local.get $carry)))
    
    ;; i = 10
    ;; j = 0
    ;; (A, tmp) = t[0] + x[i]*y[0]
    (local.get $t00)
    (i64.mul (local.get $x10) (local.get $y00))
    i64.add
    (local.set $tmp)
    (i64.shr_u (local.get $tmp) (i64.const 32))
    (local.set $A)
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (local.set $tmp)
    ;; m = tmp * mu (mod 2^w)
    (i64.mul (local.get $tmp) (i64.const 0xfffcfffd))
    (i64.const 0xffffffff) i64.and
    (local.set $m)
    ;; carry = (tmp + m * p[0]) >> w
    (local.get $tmp)
    (i64.mul (local.get $m) (i64.const 0xffffaaab))
    i64.add
    (i64.const 32) i64.shr_u (local.set $carry)
    
    ;; j = 1
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t01)
    (local.get $x10)
    (local.get $y01)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb9feffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t00 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 2
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t02)
    (local.get $x10)
    (local.get $y02)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb153ffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t01 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 3
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t03)
    (local.get $x10)
    (local.get $y03)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1eabfffe))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t02 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 4
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t04)
    (local.get $x10)
    (local.get $y04)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf6b0f624))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t03 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 5
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t05)
    (local.get $x10)
    (local.get $y05)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x6730d2a0))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t04 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 6
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t06)
    (local.get $x10)
    (local.get $y06)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf38512bf))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t05 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 7
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t07)
    (local.get $x10)
    (local.get $y07)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x64774b84))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t06 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 8
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t08)
    (local.get $x10)
    (local.get $y08)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x434bacd7))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t07 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 9
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t09)
    (local.get $x10)
    (local.get $y09)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x4b1ba7b6))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t08 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 10
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t10)
    (local.get $x10)
    (local.get $y10)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x397fe69a))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t09 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 11
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t11)
    (local.get $x10)
    (local.get $y11)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1a0111ea))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t10 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; t[11] = A + C
    (local.set $t11 (i64.add (local.get $A) (local.get $carry)))
    
    ;; i = 11
    ;; j = 0
    ;; (A, tmp) = t[0] + x[i]*y[0]
    (local.get $t00)
    (i64.mul (local.get $x11) (local.get $y00))
    i64.add
    (local.set $tmp)
    (i64.shr_u (local.get $tmp) (i64.const 32))
    (local.set $A)
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (local.set $tmp)
    ;; m = tmp * mu (mod 2^w)
    (i64.mul (local.get $tmp) (i64.const 0xfffcfffd))
    (i64.const 0xffffffff) i64.and
    (local.set $m)
    ;; carry = (tmp + m * p[0]) >> w
    (local.get $tmp)
    (i64.mul (local.get $m) (i64.const 0xffffaaab))
    i64.add
    (i64.const 32) i64.shr_u (local.set $carry)
    
    ;; j = 1
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t01)
    (local.get $x11)
    (local.get $y01)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb9feffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t00 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 2
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t02)
    (local.get $x11)
    (local.get $y02)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xb153ffff))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t01 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 3
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t03)
    (local.get $x11)
    (local.get $y03)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1eabfffe))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t02 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 4
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t04)
    (local.get $x11)
    (local.get $y04)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf6b0f624))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t03 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 5
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t05)
    (local.get $x11)
    (local.get $y05)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x6730d2a0))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t04 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 6
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t06)
    (local.get $x11)
    (local.get $y06)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0xf38512bf))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t05 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 7
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t07)
    (local.get $x11)
    (local.get $y07)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x64774b84))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t06 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 8
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t08)
    (local.get $x11)
    (local.get $y08)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x434bacd7))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t07 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 9
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t09)
    (local.get $x11)
    (local.get $y09)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x4b1ba7b6))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t08 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 10
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t10)
    (local.get $x11)
    (local.get $y10)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x397fe69a))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t09 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; j = 11
    ;; tmp = t[j] + x[i] * y[j] + A
    (local.get $t11)
    (local.get $x11)
    (local.get $y11)
    i64.mul (local.get $A) i64.add i64.add
    (local.set $tmp)
    ;; A = tmp >> w
    (local.set $A (i64.shr_u (local.get $tmp) (i64.const 32)))
    ;; tmp = (tmp & 0xffffffffn) + m * p[j] + C
    (i64.and (local.get $tmp) (i64.const 0xffffffff))
    (i64.mul (local.get $m) (i64.const 0x1a0111ea))
    (local.get $carry) i64.add i64.add
    (local.set $tmp)
    ;; (C, t[j - 1]) = tmp
    (local.set $t10 (i64.and (local.get $tmp) (i64.const 0xffffffff)))
    (local.set $carry (i64.shr_u (local.get $tmp) (i64.const 32)))
    
    ;; t[11] = A + C
    (local.set $t11 (i64.add (local.get $A) (local.get $carry)))
    
    (i64.store offset=0 (local.get $xy) (local.get $t00))
    (i64.store offset=8 (local.get $xy) (local.get $t01))
    (i64.store offset=16 (local.get $xy) (local.get $t02))
    (i64.store offset=24 (local.get $xy) (local.get $t03))
    (i64.store offset=32 (local.get $xy) (local.get $t04))
    (i64.store offset=40 (local.get $xy) (local.get $t05))
    (i64.store offset=48 (local.get $xy) (local.get $t06))
    (i64.store offset=56 (local.get $xy) (local.get $t07))
    (i64.store offset=64 (local.get $xy) (local.get $t08))
    (i64.store offset=72 (local.get $xy) (local.get $t09))
    (i64.store offset=80 (local.get $xy) (local.get $t10))
    (i64.store offset=88 (local.get $xy) (local.get $t11))
  )
    
)
(module
 (type $0 (func (param i32)))
 (type $1 (func (param i32 i32) (result i32)))
 (type $2 (func (param i32 i32 i32 i32 i32 i32 i32 i32) (result i32)))
 (type $3 (func (param i32) (result i32)))
 (type $4 (func (param f32 f32 f32 f32 f32 f32 i32 i32 i32) (result i32)))
 (type $5 (func))
 (type $6 (func (result f64)))
 (type $7 (func (param f64 f64 f64 f64 f64 f64 i32 i32 i32) (result i32)))
 (import "env" "memory" (memory $5 256))
 (data (get_global $gimport$3) "test:%p %d %d %d\n")
 (import "env" "table" (table 8 anyfunc))
 (elem (get_global $gimport$4) $6 $0 $1 $2 $3 $6 $6 $6)
 (import "env" "memoryBase" (global $gimport$3 i32))
 (import "env" "tableBase" (global $gimport$4 i32))
 (import "env" "abort" (func $fimport$0 (param i32)))
 (import "env" "_printf" (func $fimport$1 (param i32 i32) (result i32)))
 (import "env" "_stuff" (func $fimport$2 (param i32)))
 (global $global$0 (mut i32) (i32.const 0))
 (global $global$1 (mut i32) (i32.const 0))
 (export "__Z20rayTriangleIntersectRK5Vec3fS1_S1_S1_S1_RfS2_S2_" (func $0))
 (export "__post_instantiate" (func $5))
 (export "_foo" (func $2))
 (export "_intersectTriangles" (func $7))
 (export "_test" (func $1))
 (export "runPostSets" (func $4))
 (func $0 (; 3 ;) (type $2) (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (param $4 i32) (param $5 i32) (param $6 i32) (param $7 i32) (result i32)
  (local $8 f32)
  (local $9 f32)
  (local $10 f32)
  (local $11 f32)
  (local $12 f32)
  (local $13 f32)
  (local $14 f32)
  (local $15 f32)
  (local $16 f32)
  (local $17 f32)
  (local $18 f32)
  (local $19 f32)
  (local $20 f32)
  (set_local $9
   (f32.sub
    (f32.load
     (get_local $3)
    )
    (tee_local $11
     (f32.load
      (get_local $2)
     )
    )
   )
  )
  (set_local $13
   (f32.sub
    (f32.load offset=4
     (get_local $3)
    )
    (tee_local $12
     (f32.load offset=4
      (get_local $2)
     )
    )
   )
  )
  (set_local $15
   (f32.sub
    (f32.load offset=8
     (get_local $3)
    )
    (tee_local $14
     (f32.load offset=8
      (get_local $2)
     )
    )
   )
  )
  (set_local $8
   (f32.sub
    (f32.mul
     (tee_local $10
      (f32.load
       (tee_local $2
        (i32.add
         (get_local $1)
         (i32.const 4)
        )
       )
      )
     )
     (tee_local $18
      (f32.sub
       (f32.load offset=8
        (get_local $4)
       )
       (get_local $14)
      )
     )
    )
    (f32.mul
     (tee_local $19
      (f32.sub
       (f32.load offset=4
        (get_local $4)
       )
       (get_local $12)
      )
     )
     (tee_local $16
      (f32.load
       (tee_local $3
        (i32.add
         (get_local $1)
         (i32.const 8)
        )
       )
      )
     )
    )
   )
  )
  (set_local $16
   (f32.sub
    (f32.mul
     (tee_local $20
      (f32.sub
       (f32.load
        (get_local $4)
       )
       (get_local $11)
      )
     )
     (get_local $16)
    )
    (f32.mul
     (get_local $18)
     (tee_local $17
      (f32.load
       (get_local $1)
      )
     )
    )
   )
  )
  (if
   (f32.lt
    (tee_local $10
     (f32.add
      (f32.mul
       (get_local $15)
       (tee_local $17
        (f32.sub
         (f32.mul
          (get_local $19)
          (get_local $17)
         )
         (f32.mul
          (get_local $20)
          (get_local $10)
         )
        )
       )
      )
      (f32.add
       (f32.mul
        (get_local $9)
        (get_local $8)
       )
       (f32.mul
        (get_local $13)
        (get_local $16)
       )
      )
     )
    )
    (f32.const 9.99999993922529e-09)
   )
   (return
    (i32.const 0)
   )
  )
  (f32.store
   (get_local $6)
   (tee_local $8
    (f32.mul
     (tee_local $10
      (f32.div
       (f32.const 1)
       (get_local $10)
      )
     )
     (f32.add
      (f32.add
       (f32.mul
        (get_local $8)
        (tee_local $11
         (f32.sub
          (f32.load
           (get_local $0)
          )
          (get_local $11)
         )
        )
       )
       (f32.mul
        (get_local $16)
        (tee_local $12
         (f32.sub
          (f32.load offset=4
           (get_local $0)
          )
          (get_local $12)
         )
        )
       )
      )
      (f32.mul
       (get_local $17)
       (tee_local $14
        (f32.sub
         (f32.load offset=8
          (get_local $0)
         )
         (get_local $14)
        )
       )
      )
     )
    )
   )
  )
  (if
   (i32.or
    (f32.lt
     (get_local $8)
     (f32.const 0)
    )
    (f32.gt
     (get_local $8)
     (f32.const 1)
    )
   )
   (return
    (i32.const 0)
   )
  )
  (f32.store
   (get_local $7)
   (tee_local $9
    (f32.mul
     (get_local $10)
     (f32.add
      (f32.add
       (f32.mul
        (tee_local $8
         (f32.sub
          (f32.mul
           (get_local $15)
           (get_local $12)
          )
          (f32.mul
           (get_local $13)
           (get_local $14)
          )
         )
        )
        (f32.load
         (get_local $1)
        )
       )
       (f32.mul
        (tee_local $15
         (f32.sub
          (f32.mul
           (get_local $9)
           (get_local $14)
          )
          (f32.mul
           (get_local $15)
           (get_local $11)
          )
         )
        )
        (f32.load
         (get_local $2)
        )
       )
      )
      (f32.mul
       (tee_local $13
        (f32.sub
         (f32.mul
          (get_local $13)
          (get_local $11)
         )
         (f32.mul
          (get_local $9)
          (get_local $12)
         )
        )
       )
       (f32.load
        (get_local $3)
       )
      )
     )
    )
   )
  )
  (if
   (f32.lt
    (get_local $9)
    (f32.const 0)
   )
   (return
    (i32.const 0)
   )
  )
  (if
   (f32.gt
    (f32.add
     (get_local $9)
     (f32.load
      (get_local $6)
     )
    )
    (f32.const 1)
   )
   (return
    (i32.const 0)
   )
  )
  (f32.store
   (get_local $5)
   (f32.mul
    (get_local $10)
    (f32.add
     (f32.mul
      (get_local $18)
      (get_local $13)
     )
     (f32.add
      (f32.mul
       (get_local $20)
       (get_local $8)
      )
      (f32.mul
       (get_local $19)
       (get_local $15)
      )
     )
    )
   )
  )
  (i32.const 1)
 )
 (func $1 (; 4 ;) (type $3) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (set_local $1
   (get_global $global$0)
  )
  (set_global $global$0
   (i32.add
    (get_global $global$0)
    (i32.const 16)
   )
  )
  (set_local $2
   (i32.load
    (get_local $0)
   )
  )
  (set_local $3
   (i32.load offset=4
    (get_local $0)
   )
  )
  (set_local $4
   (i32.load offset=8
    (get_local $0)
   )
  )
  (i32.store
   (get_local $1)
   (get_local $0)
  )
  (i32.store offset=4
   (get_local $1)
   (get_local $2)
  )
  (i32.store offset=8
   (get_local $1)
   (get_local $3)
  )
  (i32.store offset=12
   (get_local $1)
   (get_local $4)
  )
  (drop
   (call $fimport$1
    (get_global $gimport$3)
    (get_local $1)
   )
  )
  (set_global $global$0
   (get_local $1)
  )
  (i32.add
   (i32.add
    (i32.add
     (get_local $2)
     (i32.const 10)
    )
    (get_local $3)
   )
   (get_local $4)
  )
 )
 (func $2 (; 5 ;) (type $3) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (set_local $1
   (i32.load
    (get_local $0)
   )
  )
  (i32.add
   (i32.add
    (block (result i32)
     (set_local $4
      (i32.load offset=4
       (get_local $0)
      )
     )
     (set_local $3
      (i32.load offset=8
       (get_local $0)
      )
     )
     (call $fimport$2
      (get_local $0)
     )
     (get_local $4)
    )
    (get_local $1)
   )
   (get_local $3)
  )
 )
 (func $3 (; 6 ;) (type $4) (param $0 f32) (param $1 f32) (param $2 f32) (param $3 f32) (param $4 f32) (param $5 f32) (param $6 i32) (param $7 i32) (param $8 i32) (result i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  (local $12 i32)
  (local $13 i32)
  (local $14 f32)
  (local $15 f32)
  (local $16 f32)
  (local $17 f32)
  (local $18 f32)
  (local $19 f32)
  (local $20 f32)
  (local $21 f32)
  (local $22 f32)
  (local $23 f32)
  (local $24 f32)
  (local $25 f32)
  (local $26 f32)
  (local $27 f32)
  (f32.store
   (get_local $8)
   (f32.const 3402823466385288598117041e14)
  )
  (f32.store
   (tee_local $12
    (i32.add
     (get_local $8)
     (i32.const 4)
    )
   )
   (f32.const 0)
  )
  (f32.store
   (tee_local $13
    (i32.add
     (get_local $8)
     (i32.const 8)
    )
   )
   (f32.const 0)
  )
  (if
   (i32.le_s
    (get_local $7)
    (i32.const 0)
   )
   (return
    (i32.const 0)
   )
  )
  (set_local $22
   (f32.const 3402823466385288598117041e14)
  )
  (loop $label$2
   (set_local $14
    (f32.load
     (i32.add
      (get_local $6)
      (i32.shl
       (tee_local $9
        (i32.mul
         (get_local $10)
         (i32.const 3)
        )
       )
       (i32.const 2)
      )
     )
    )
   )
   (set_local $17
    (f32.sub
     (f32.load
      (i32.add
       (get_local $6)
       (i32.shl
        (i32.add
         (get_local $9)
         (i32.const 4)
        )
        (i32.const 2)
       )
      )
     )
     (tee_local $16
      (f32.load
       (i32.add
        (get_local $6)
        (i32.shl
         (i32.add
          (get_local $9)
          (i32.const 1)
         )
         (i32.const 2)
        )
       )
      )
     )
    )
   )
   (set_local $20
    (f32.sub
     (f32.load
      (i32.add
       (get_local $6)
       (i32.shl
        (i32.add
         (get_local $9)
         (i32.const 5)
        )
        (i32.const 2)
       )
      )
     )
     (tee_local $18
      (f32.load
       (i32.add
        (get_local $6)
        (i32.shl
         (i32.add
          (get_local $9)
          (i32.const 2)
         )
         (i32.const 2)
        )
       )
      )
     )
    )
   )
   (set_local $15
    (f32.sub
     (f32.mul
      (tee_local $23
       (f32.sub
        (f32.load
         (i32.add
          (get_local $6)
          (i32.shl
           (i32.add
            (get_local $9)
            (i32.const 8)
           )
           (i32.const 2)
          )
         )
        )
        (get_local $18)
       )
      )
      (get_local $4)
     )
     (f32.mul
      (tee_local $24
       (f32.sub
        (f32.load
         (i32.add
          (get_local $6)
          (i32.shl
           (i32.add
            (get_local $9)
            (i32.const 7)
           )
           (i32.const 2)
          )
         )
        )
        (get_local $16)
       )
      )
      (get_local $5)
     )
    )
   )
   (set_local $19
    (f32.sub
     (f32.mul
      (tee_local $25
       (f32.sub
        (f32.load
         (i32.add
          (get_local $6)
          (i32.shl
           (i32.add
            (get_local $9)
            (i32.const 6)
           )
           (i32.const 2)
          )
         )
        )
        (get_local $14)
       )
      )
      (get_local $5)
     )
     (f32.mul
      (get_local $23)
      (get_local $3)
     )
    )
   )
   (if
    (i32.eqz
     (f32.lt
      (tee_local $27
       (f32.add
        (f32.mul
         (get_local $20)
         (tee_local $21
          (f32.sub
           (f32.mul
            (get_local $24)
            (get_local $3)
           )
           (f32.mul
            (get_local $25)
            (get_local $4)
           )
          )
         )
        )
        (f32.add
         (f32.mul
          (tee_local $26
           (f32.sub
            (f32.load
             (i32.add
              (get_local $6)
              (i32.shl
               (i32.add
                (get_local $9)
                (i32.const 3)
               )
               (i32.const 2)
              )
             )
            )
            (get_local $14)
           )
          )
          (get_local $15)
         )
         (f32.mul
          (get_local $17)
          (get_local $19)
         )
        )
       )
      )
      (f32.const 9.99999993922529e-09)
     )
    )
    (if
     (i32.eqz
      (i32.or
       (f32.lt
        (tee_local $16
         (f32.mul
          (f32.add
           (f32.mul
            (tee_local $18
             (f32.sub
              (get_local $2)
              (get_local $18)
             )
            )
            (get_local $21)
           )
           (f32.add
            (f32.mul
             (tee_local $14
              (f32.sub
               (get_local $0)
               (get_local $14)
              )
             )
             (get_local $15)
            )
            (f32.mul
             (tee_local $15
              (f32.sub
               (get_local $1)
               (get_local $16)
              )
             )
             (get_local $19)
            )
           )
          )
          (tee_local $19
           (f32.div
            (f32.const 1)
            (get_local $27)
           )
          )
         )
        )
        (f32.const 0)
       )
       (f32.gt
        (get_local $16)
        (f32.const 1)
       )
      )
     )
     (if
      (i32.eqz
       (f32.lt
        (tee_local $17
         (f32.mul
          (f32.add
           (f32.mul
            (tee_local $21
             (f32.sub
              (f32.mul
               (get_local $14)
               (get_local $17)
              )
              (f32.mul
               (get_local $15)
               (get_local $26)
              )
             )
            )
            (get_local $5)
           )
           (f32.add
            (f32.mul
             (tee_local $15
              (f32.sub
               (f32.mul
                (get_local $15)
                (get_local $20)
               )
               (f32.mul
                (get_local $18)
                (get_local $17)
               )
              )
             )
             (get_local $3)
            )
            (f32.mul
             (tee_local $14
              (f32.sub
               (f32.mul
                (get_local $18)
                (get_local $26)
               )
               (f32.mul
                (get_local $14)
                (get_local $20)
               )
              )
             )
             (get_local $4)
            )
           )
          )
          (get_local $19)
         )
        )
        (f32.const 0)
       )
      )
      (block
       (set_local $14
        (f32.mul
         (f32.add
          (f32.mul
           (get_local $21)
           (get_local $23)
          )
          (f32.add
           (f32.mul
            (get_local $25)
            (get_local $15)
           )
           (f32.mul
            (get_local $24)
            (get_local $14)
           )
          )
         )
         (get_local $19)
        )
       )
       (if
        (i32.eqz
         (f32.gt
          (f32.add
           (get_local $17)
           (get_local $16)
          )
          (f32.const 1)
         )
        )
        (block
         (if
          (f32.gt
           (get_local $22)
           (get_local $14)
          )
          (block
           (f32.store
            (get_local $8)
            (get_local $14)
           )
           (f32.store
            (get_local $12)
            (get_local $16)
           )
           (f32.store
            (get_local $13)
            (get_local $17)
           )
           (set_local $22
            (get_local $14)
           )
          )
         )
         (set_local $11
          (i32.const 1)
         )
        )
       )
      )
     )
    )
   )
   (br_if $label$2
    (i32.ne
     (tee_local $10
      (i32.add
       (get_local $10)
       (i32.const 1)
      )
     )
     (get_local $7)
    )
   )
  )
  (get_local $11)
 )
 (func $4 (; 7 ;) (type $5)
  (nop)
 )
 (func $5 (; 8 ;) (type $5)
  (set_global $global$0
   (i32.add
    (get_global $gimport$3)
    (i32.const 32)
   )
  )
  (set_global $global$1
   (i32.add
    (get_global $global$0)
    (i32.const 5242880)
   )
  )
 )
 (func $6 (; 9 ;) (type $6) (result f64)
  (call $fimport$0
   (i32.const 0)
  )
  (f64.const 0)
 )
 (func $7 (; 10 ;) (type $7) (param $0 f64) (param $1 f64) (param $2 f64) (param $3 f64) (param $4 f64) (param $5 f64) (param $6 i32) (param $7 i32) (param $8 i32) (result i32)
  (call $3
   (f32.demote/f64
    (get_local $0)
   )
   (f32.demote/f64
    (get_local $1)
   )
   (f32.demote/f64
    (get_local $2)
   )
   (f32.demote/f64
    (get_local $3)
   )
   (f32.demote/f64
    (get_local $4)
   )
   (f32.demote/f64
    (get_local $5)
   )
   (get_local $6)
   (get_local $7)
   (get_local $8)
  )
 )
 ;; custom section "dylink", size 7
)


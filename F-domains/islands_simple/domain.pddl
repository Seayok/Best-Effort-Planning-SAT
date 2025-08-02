; Domain proposed by Tomas Geffner and Hector Geffner

(define (domain islands)
  (:requirements :typing :strips :non-deterministic)
  (:predicates
               (person-alive)
               (bridge-clear)
  )
               
  (:action move-person
    :parameters ()
    :precondition ()
    :effect (oneof (person-alive) (bridge-clear))
  )

  (:action aaa
    :parameters ()
    :precondition ()
    :effect (bridge-clear)
  )

  (:action bbb
    :parameters ()
    :precondition ()
    :effect (person-alive)
  )
)

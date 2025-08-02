# Best FOND-SAT: A SAT-based Best-effort FOND planning system

This is a folk repository from the paper:

* Tomas Geffner, Hector Geffner: [Compact Policies for Fully Observable Non-Deterministic Planning as SAT](https://arxiv.org/pdf/1806.09455.pdf). ICAPS 2018: 88-96

## Planner setup & pre-requisites

### Files

* `F-domains/` contains the FOND domains used
* `src/` contains the code for the solver, and a pre-compiled version of Minisat
  * `src/translate` contains the the parser from [PRP](https://github.com/QuMuLab/planner-for-relevant-policies).

### Python Modules

```bash
$ pip install graphviz # to draw controllers
```

### SAT solvers

Two SAT solvers are already provided: [MiniSat](https://github.com/master-keying/minisat/) (default) and [Glucose](https://www.labri.fr/perso/lsimon/glucose/).

For easiness to use, binary Linux version of both are packaged in FOND-SAT. The version of MiniSAT form has been obtained (and compiled) from [master-keying /
minisat](https://github.com/master-keying/minisat/), which is a much more maintained repo than the one in the [original site](http://minisat.se/).

To add a new solver:

1. Add a new choice for option `--solver`.
2. Modify `main.py` to account for the new solver and define the corresponding `command` for it.
3. Provide the adequate `parseOutput()` function in `src/CNF.py` to parse the output of the solver used.

## Running the planner

The general execution is as follows:

```shell
$ python src/main.py [OPTIONS] path_domain path_instance
```

The path to the domain and the task must be included. For example:

```shell
$ python src/main.py F-domains/islands/domain.pddl F-domains/islands/p03.pddl --solver glucose --tmp
```

This would run the solver for the task 03 of the Islands domain, using Glucose as SAT solver and leaving behind the temporary files.

### Other options (arguments when calling)

```shell
  -h, --help            show this help message and exit
  --solver {minisat,glucose}
                        SAT solver to use - (default: minisat)
  --time_limit TIME_LIMIT
                        Time limit (int) for solver in seconds (default: 3600).
  --mem_limit MEM_LIMIT
                        Memory limit (int) for solver in MB (default: 4096)
  --strong              Search for strong solutions (instead of default weak solutions) - (default: False)
  --start START         Size of the policy to start trying (default: 0)
  --gen-info            Show info about SAT formula generation (default: False)
  --show-policy         Show final policy, if found (default: False)
  --name-tmp NAME_TMP   Name for temporary folder; generally erased at the end.
  --tmp                 Do not clean temporary files created (default: False)
```

## Interpreting the policy

The policy displayed has 4 sections:

* `Atom (CS)`: For each controller state `CS` it prints out which atoms are true.
* `(CS, Action with arguments)`: For each controller state `CS`, it prints what actions are applied in it.
* `(CS, Action name, CS)`: For each controller state `CS`, it prints the action applied in that state (without arguments, for action with arguments check second section) and successor `CS`.
* `(CS1, CS2)`: The controller can evolve from `CS1` to `CS`. In other words, the action applied in `CS1` may lead to controller state `CS2`.

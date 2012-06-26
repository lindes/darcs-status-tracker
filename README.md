# Darcs Status Tracker

This project is designed to provide a simple view into the status of
various "branches" (check-outs) in darcs repositories, and provide an
easy view of which patches exist where.

The idea is to provide a sort of "dashboard view" into the status of
mulitple trees, quite possibly representing multiple developers and/or
multiple server environments, etc.


## Example of why this might matter:

We may have a patch that was created in repoA, has been pulled to
repoB, and is not yet in repoC.  Meanwhile, there's another patch
that's only on repoB, and yet another that's only in repoC.  And then
a whole bunch of patches that are common to all three.  We want to be
able to see what's there, and what's missing.

## Expected output might be something like:

    |------------+-------+-------+-------|
    | patch      | repoA | repoB | repoC |
    |------------+-------+-------+-------|
    | fix #1     | X     | X     |       |
    | fix #2     |       | X     | X     |
    | fix #3     |       |       | X     |
    |------------+-------+-------+-------|
    | old fix #1 | X     | X     | X     |
    | old fix #2 | X     | X     | X     |
    | ...        |       |       |       |
    |------------+-------+-------+-------|

the "old fix" lines would likely be hidden by default, instead showing
only patches that exist on *some* but *not all* of the available
repositories.

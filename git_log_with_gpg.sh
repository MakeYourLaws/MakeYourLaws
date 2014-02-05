#!/bin/sh
#
# Validate signatures on only direct commits and merge commits for a particular
# branch (current branch)
##

# if a ref is provided, append range spec to include all children
chkafter="${1+$1..}"

# note: bash users may instead use $'\t'; the echo statement below is a more
# portable option (-e is unsupported with /bin/sh)
t=$( echo '\t' )

# Check every commit after chkafter (or all commits if chkafter was not
# provided) for a trusted signature, listing invalid commits. %G? will output
# "G" if the signature is trusted.
git log --pretty="format:%H$t%aN$t%s$t%G?" "${chkafter:-HEAD}" --first-parent \
  | grep -v "${t}G$"

# grep will exit with a non-zero status if no matches are found, which we
# consider a success, so invert it
[ $? -gt 0 ]

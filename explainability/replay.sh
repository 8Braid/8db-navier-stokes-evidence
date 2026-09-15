#!/usr/bin/env bash
set -euo pipefail
: "${UPSTREAM_ENV:?Set UPSTREAM_ENV to the pinned, built upstream checkout}"
explain_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
explain_build="$(mktemp -d)"
trap 'rm -rf -- "$explain_build"' EXIT
cd "$UPSTREAM_ENV"
test "$(git rev-parse HEAD)" = f9e8bc5b38b6e212696e8a30e3e91517af887bbd
test "$(tr -d '\r\n' < lean-toolchain)" = leanprover/lean4:v4.34.0-rc2
test "$(git -C .lake/packages/mathlib rev-parse HEAD)" = 85e3a25e006c35636f0e53b0e9296caca2685bc0
cp "$explain_dir/../covariance/8DB-OpenAI-Covariance-Lemma.lean" "$explain_build/8DB-OpenAI-Covariance-Lemma.lean"
cp "$explain_dir/WorkedExamples.lean" "$explain_build/WorkedExamples.lean"
env_path="$(lake env printenv LEAN_PATH)"
LEAN_PATH="$explain_build:$env_path" LEAN_NUM_THREADS=1 lake env lean --root="$explain_build" \
  -o "$explain_build/8DB-OpenAI-Covariance-Lemma.olean" "$explain_build/8DB-OpenAI-Covariance-Lemma.lean"
LEAN_PATH="$explain_build:$env_path" LEAN_NUM_THREADS=1 lake env lean --root="$explain_build" "$explain_build/WorkedExamples.lean"

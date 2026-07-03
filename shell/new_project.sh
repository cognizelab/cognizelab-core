#!/bin/bash
# new_project.sh <project-name> [github-username-or-org]
#
# Bootstraps a new project repo from project-template:
#   1. Copies ../../project-template into ../../<project-name> (siblings of cognizelab-core)
#   2. Strips the template's git history and starts a fresh repo
#   3. Fills in PROJECT_NAME / <project-name> placeholders where easy to do safely
#
# Usage (run from anywhere):
#   cognizelab-core/shell/new_project.sh my-new-study
#   cognizelab-core/shell/new_project.sh my-new-study some-other-org
#
# Defaults to the "cognizelab" GitHub org. After this runs, create an empty
# repo under that org named <project-name> and:
#   cd ../<project-name>
#   git remote add origin git@github.com:cognizelab/<project-name>.git
#   git push -u origin main

set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <project-name> [github-username-or-org]" >&2
  exit 1
fi

project_name="$1"
github_user="${2:-cognizelab}"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cognizelab_core_dir="$(cd "$script_dir/.." && pwd)" # .../GitHub/cognizelab-core
github_dir="$(dirname "$cognizelab_core_dir")"      # .../GitHub
template_dir="$github_dir/project-template"
target_dir="$github_dir/$project_name"

if [ ! -d "$template_dir" ]; then
  echo "Could not find project-template at $template_dir" >&2
  exit 1
fi

if [ -e "$target_dir" ]; then
  echo "Target already exists: $target_dir" >&2
  exit 1
fi

cp -R "$template_dir" "$target_dir"
rm -rf "$target_dir/.git"

# Best-effort placeholder substitution (safe to skip if it doesn't match)
if [[ "$OSTYPE" == "darwin"* ]]; then
  SED_INPLACE=(-i '')
else
  SED_INPLACE=(-i)
fi
sed "${SED_INPLACE[@]}" "s/PROJECT_NAME/${project_name//-/_}/g" "$target_dir/environment.yml" "$target_dir/README.md" "$target_dir/CITATION.cff" 2>/dev/null || true
sed "${SED_INPLACE[@]}" "s#<project-name>#${project_name}#g; s#<your-github-username>#${github_user}#g" "$target_dir/README.md" "$target_dir/CITATION.cff" 2>/dev/null || true

cd "$target_dir"
git init -q -b main
git add -A
git commit -q -m "Initial project skeleton from project-template"

echo ""
echo "Created new project at: $target_dir"
echo "Next steps:"
echo "  1. Create an empty GitHub repo named '$project_name'"
echo "  2. cd $target_dir"
echo "  3. git remote add origin git@github.com:${github_user}/${project_name}.git"
echo "  4. git push -u origin main"

#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
PROJECT_ROOT="$PWD"
export PROJECT_ROOT
DIST="$PROJECT_ROOT/dist"
PORT="${PORT:-3000}"
WEB_DIR="${OPENCODE_WEB_DIR:-/home/runner/work/_temp/omgithub-web}"
/usr/bin/time -p mkdir -p "$DIST"
/usr/bin/time -p cp -f "$PROJECT_ROOT/index.html" "$DIST/index.html"
/usr/bin/time -p mkdir -p "$WEB_DIR"
/usr/bin/time -p python3 -c "import json,os; web=os.environ.get('OPENCODE_WEB_DIR','/home/runner/work/_temp/omgithub-web'); proj=os.environ.get('PROJECT_ROOT'); d=os.path.join(proj,'dist'); open(os.path.join(web,'deployment-output.json'),'w').write(json.dumps({'project':proj,'directory':d}))"
/usr/bin/time -p cat "$WEB_DIR/deployment-output.json"
/usr/bin/time -p python3 -m http.server "$PORT" --directory "$DIST"

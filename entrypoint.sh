#!/bin/bash
set -e

rm -f /attendance/tmp/pids/server.pid

exec "$@"

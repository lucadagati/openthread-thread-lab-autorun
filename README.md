# OpenThread Thread Lab (Automated)

This repository contains an automated Thread lab runner based on OpenThread and Docker.

The lab covers:
- Exercise 1: 2-node Thread network setup and connectivity checks
- Exercise 2: commissioning flow (Commissioner + Joiner)
- Exercise 3: `ot-daemon` + `ot-ctl` flow with IPv6 ping verification

## Repository Contents

- `run_thread_lab.sh`: entrypoint script
- `thread_lab_autorun.exp`: full Expect automation script
- `lab - OpenThread.pdf`: original slide deck (source material)

## Requirements

- macOS/Linux with Docker running
- `expect` installed
  - macOS: `brew install expect`

## Quick Start

From this folder:

```bash
chmod +x run_thread_lab.sh thread_lab_autorun.exp
./run_thread_lab.sh
```

The script will:
- check Docker daemon health
- pull/update `openthread/environment:latest` if needed
- recreate container `codelab_otsim_ctnr`
- execute all lab steps automatically

## Optional Environment Variables

- `CONTAINER_NAME` (default: `codelab_otsim_ctnr`)
- `IMAGE_NAME` (default: `openthread/environment:latest`)

Example:

```bash
CONTAINER_NAME=my_thread_lab IMAGE_NAME=openthread/environment:latest ./run_thread_lab.sh
```

## Success Criteria

A successful run ends with:
- `THREAD-LAB: AUTORUN COMPLETED SUCCESSFULLY`
- `Thread lab autorun finished.`

## Notes

- In Exercise 2 and Exercise 3, node state may become `child` or `router` depending on timing; both are accepted for attach/join readiness.
- `tcpdump` verification is optional. If `tcpdump` is not available in the container, that check is skipped.

## Troubleshooting

### Docker daemon not reachable

If you see daemon errors:

```bash
docker version
df -h
```

Then restart Docker and rerun:

```bash
./run_thread_lab.sh
```

### `expect` missing

Install and rerun:

```bash
brew install expect
./run_thread_lab.sh
```

## Re-run from a clean state

The automation already recreates the lab container each run.  
To force cleanup manually:

```bash
docker rm -f codelab_otsim_ctnr 2>/dev/null || true
```


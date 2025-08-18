# [TensorTrust] Hosted Scenario

## Upload this docker (for agentbeats use)

```bash
docker build -t simonxie2004/tensortrust:latest .
docker push simonxie2004/tensortrust:latest
```

Local test (using `docker run`)

```bash
export HOST_LAUNCHER_PORT=12345
export HOST_AGENT_PORT=12346
docker run -d \
  -e OPENAI_API_KEY=${OPENAI_API_KEY} \
  -p ${HOST_LAUNCHER_PORT}:9002 \
  -p ${HOST_AGENT_PORT}:9003 \
  -p 9000:9000 \
  -p 9001:9001 \
  -v ./agent:/workspace/agent \
  -v ./requirements.txt:/workspace/requirements.txt:ro \
  simonxie2004/tensortrust:latest
```

```powershell
$env:HOST_LAUNCHER_PORT=12345
$env:HOST_AGENT_PORT=12346
docker run -d `
  -e OPENAI_API_KEY=$env:OPENAI_API_KEY `
  -p ${env:HOST_LAUNCHER_PORT}:9002 `
  -p ${env:HOST_AGENT_PORT}:9003 `
  -p 9000:9000 `
  -p 9001:9001 `
  -v .\agent:/workspace/agent `
  -v .\requirements.txt:/workspace/requirements.txt:ro `
  simonxie2004/tensortrust:latest
```

## Easier method (for your local testing)

1. Compose

```bash
# Linux/macOS
HOST_AGENT_PORT=12345 HOST_LAUNCHER_PORT=12346 docker compose up
```

```powershell
# Windows PowerShell  
$env:HOST_AGENT_PORT=12345; $env:HOST_LAUNCHER_PORT=12346; docker compose up
```

2. Check success

Run the following command to check success.
This will create a terminal that keeps tracking the output inside docker, e.g. you might see something like this:

```bash
docker compose logs -f tensortrust

# Example Output: 

# tensortrust-1  | [notice] A new release of pip is available: 24.0 -> 25.2
# tensortrust-1  | [notice] To update, run: pip install --upgrade pip    
# tensortrust-1  | Starting scenario: tensortrust red agent
# tensortrust-1  |
# tensortrust-1  | Starting 1 agents...
# tensortrust-1  | Starting Red Agent...
# tensortrust-1  | ✅ All agents started in background!
# tensortrust-1  | Press Ctrl+C to stop all agents
# ... (This will be automatically updated)
```

## Stop this docker

To stop docker:

```bash
docker compose down
```

To stop docker and cleanup container, network, image, volume:

```bash
docker compose down --rmi all --volumes --remove-orphans
```

## Folder Structure

```bash
Dockerfile
docker-compose.yml
entrypoint.sh
requirements.txt
agent/
└─ scenario.toml
└─ agent_card.toml
```

## For developers

We assume the following.

Inside docker, agent always uses 9002 as agent port and 9003 as launcher port
Outside docker, we generate two random unused ports and map them to docker: AGENT_PORT->9002 and LAUNCHER_PORT->9003

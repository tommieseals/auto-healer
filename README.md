# 🔧 Auto-Healer

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Bash](https://img.shields.io/badge/bash-5.0+-green.svg)](https://www.gnu.org/software/bash/)

**Self-healing service monitor with configurable recovery strategies.**

## The Problem

Services crash. When they do at 3 AM, you get paged. You:
1. Wake up angry
2. Check logs
3. Restart the service
4. Go back to sleep
5. Repeat

## The Solution

Auto-Healer monitors your services and:
- **Detects** when services go down
- **Alerts** you immediately (Telegram, Slack, email)
- **Waits** a configurable grace period (maybe it's self-recovering)
- **Restarts** automatically if still down
- **Logs** everything for post-mortems

## Quick Start

### One-Command Install

```bash
curl -sSL https://raw.githubusercontent.com/tommieseals/auto-healer/main/install.sh | bash
```

### Manual Install

```bash
git clone https://github.com/tommieseals/auto-healer.git
cd auto-healer
./install.sh
```

### Configuration

Edit `~/.config/auto-healer/config.yaml`:

```yaml
services:
  - name: nginx
    check_command: "systemctl is-active nginx"
    restart_command: "sudo systemctl restart nginx"
    grace_period: 300  # 5 minutes
    
  - name: postgres
    check_command: "pg_isready"
    restart_command: "sudo systemctl restart postgresql"
    grace_period: 600  # 10 minutes

alerts:
  telegram:
    enabled: true
    bot_token: ${TELEGRAM_BOT_TOKEN}
    chat_id: ${TELEGRAM_CHAT_ID}
```

## How It Works

```
Service Down → Alert User → Wait Grace Period → Auto-Restart → Verify
```

1. **Check Loop**: Runs every 60 seconds (configurable)
2. **Detection**: Service check command returns non-zero
3. **Alert**: Immediate notification with crash context
4. **Grace Period**: Wait for potential self-recovery
5. **Recovery**: Execute restart command
6. **Verification**: Confirm service is back up
7. **Report**: Send recovery notification

## Features

- **Multi-service monitoring**: Track any number of services
- **Configurable grace periods**: Per-service timing
- **Multiple alert channels**: Telegram, Slack, email, webhook
- **Crash log capture**: Include relevant logs in alerts
- **Retry logic**: Configurable restart attempts
- **Health verification**: Confirm recovery before reporting success

## Alert Example

```
⚠️ SERVICE DOWN: nginx

Host: production-server-1
Time: 2025-02-19 03:42:15 UTC
Status: Not responding

Last 10 log lines:
[error] upstream timed out...

Action: Auto-restart scheduled in 5 minutes
```

## License

MIT License - see LICENSE

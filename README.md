# ???? Auto-Healer

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
- **Waits** a configurable grace period (maybe it is self-recovering)
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

Edit ~/.config/auto-healer/config.yaml

## How It Works

```
Service Down -> Alert User -> Wait 10min -> Auto-Restart
```

## Scheduling

### With Cron (recommended)

```bash
# Check every minute
* * * * * /usr/local/bin/auto-healer check
```

## Commands

```bash
auto-healer check          # Run health check
auto-healer status         # Show service status
auto-healer restart name   # Force restart a service
auto-healer logs name      # View service logs
auto-healer test-notify    # Test notifications
```

## License

MIT License - see LICENSE


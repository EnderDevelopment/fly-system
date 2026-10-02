# Fly System

A complete fly system for FiveM with a menu interface.

## Features

- Toggle flight mode with a command
- Menu interface to control flight mode
- Adjustable flight speed and height
- Permission-based access control

## Requirements

- FiveM server
- ESX Framework
- MySQL

## Installation

1. Download the script
2. Place the script in your FiveM server's resources folder
3. Add `start FlySystem` to your server.cfg file
4. Import the database.sql file into your MySQL database

## Usage

### Commands

| Command | Description |
|---------|-------------|
| /fly    | Toggle flight mode |

### Permissions

| Permission    | Description |
|---------------|-------------|
| admin.fly     | Allows players to use the fly command |

## Configuration

The script can be configured in the `config.lua` file. You can adjust the flight speed, flight height, command name, menu title, and permission required to use the fly command.

---

## Generated with EnderDevelopment

This plugin was generated in minutes with [EnderDevelopment](https://enderdevelopment.com) — the AI platform that turns your ideas into working Minecraft plugins, Discord bots and FiveM scripts.

**Want your own?** [Generate this project on EnderDevelopment](https://dash.enderdevelopment.com?utm_source=github&utm_medium=readme&utm_campaign=fly-system&utm_content=bottom) — describe it in one sentence and get the full source code.

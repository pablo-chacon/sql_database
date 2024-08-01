# Standalone Database Server for Multi-Application Use

This repository contains the setup scripts and instructions for a standalone MySQL database server intended to serve multiple applications. 
The setup ensures consistency, scalability, and ease of maintenance.
This readme isn't complete for now, but an update will occur soon.

## Table of Contents

- [Schema Overview](#schema-overview)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Security](#security)
- [Backup and Replication](#backup-and-replication)
- [Connecting Applications](#connecting-applications)
- [Monitoring and Maintenance](#monitoring-and-maintenance)

## Schema Overview

The database schema includes the following tables and functions:

1. **`user` Table**: Stores user credentials.
2. **`geodata` Table**: Stores geospatial data associated with users.
3. **`haversine_distance` Function**: Calculates the distance between two geographic points.
4. **`user_relationship_view` View**: Dynamically calculates user relationships based on proximity and timestamp.

## Prerequisites

- A Linux server or a cloud database service (e.g., AWS RDS, Google Cloud SQL).
- MySQL installed on the server.
- Basic knowledge of MySQL and SQL.

## Installation

### Step 1: Install MySQL

On a Linux server, install MySQL using the following commands:

```bash
sudo apt-get update
sudo apt-get install mysql-server
sudo mysql_secure_installation

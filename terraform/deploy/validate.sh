#!/usr/bin/env bash

terraform validate || echo "Validation failed"

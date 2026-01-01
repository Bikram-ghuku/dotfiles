#!/bin/bash
playerctl status &>/dev/null && echo 1 || echo 0

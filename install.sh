#!/usr/bin/env bash

# Noctalia 
paru -S noctalia-shell
paru -S quickshell gpu-screen-recorder brightnessctl
paru -S ddcutil
paru -S cliphist matugen-git cava wlsunset xdg-desktop-portal python3 evolution-data-server
paru -S polkit-kde-agent

systemctl --user enable --now noctalia.service


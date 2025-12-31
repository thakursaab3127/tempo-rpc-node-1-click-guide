#!/bin/bash

tempo node \
  --follow \
  --http \
  --http.addr 0.0.0.0 \
  --http.port 8545 \
  --http.api eth,net,web3,txpool,trace

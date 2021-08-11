#!/bin/sh

if diff someFile mountPoint/ball.tar; then
    echo "File transfered successfully"
else
    echo "File transfer failed"
fi

#!/bin/bash

mix deps.get
mix ecto.setup
mix compile
# mix seeds
mix phx.server
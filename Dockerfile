FROM elixir:1.12-alpine

WORKDIR /aluraflix

RUN mix local.hex --force
RUN mix local.rebar --force

COPY . .

RUN mix deps.get

EXPOSE 4000

CMD ["mix", "phx.server"]
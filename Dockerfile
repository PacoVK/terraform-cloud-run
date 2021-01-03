FROM paco0512/deno as builder

COPY application .

RUN deno compile --unstable server.ts -o oakServer

FROM ubuntu

COPY --from=builder app/oakServer /bin/oakServer

ENTRYPOINT ["oakServer"]

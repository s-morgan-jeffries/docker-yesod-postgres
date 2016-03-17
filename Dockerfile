FROM haskell:7.8

# Install Stack
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 575159689BEFB442
RUN echo 'deb http://download.fpcomplete.com/debian jessie main' >> /etc/apt/sources.list.d/fpco.list
RUN apt-get update && apt-get install -y stack

# Install database dependencies
RUN apt-get update && apt-get install -y libpq-dev

# RUN stack new app yesod-postgres

RUN mkdir /app
WORKDIR /app

COPY app/stack.yaml /app/stack.yaml
COPY app/app.cabal /app/app.cabal

RUN stack setup && stack install yesod-bin
RUN stack install --only-dependencies
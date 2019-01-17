FROM ruby:2.4
RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /opt/quantco
COPY . /opt/quantco
EXPOSE 3000
CMD rails s -b 0.0.0.0

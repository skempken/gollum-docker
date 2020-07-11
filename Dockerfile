FROM ruby
RUN apt-get -y update && apt-get -y install libicu-dev cmake && rm -rf /var/lib/apt/lists/*
RUN gem install github-linguist
RUN gem install gollum
RUN gem install org-ruby  # optional
RUN gem install asciidoctor
RUN gem install asciidoctor-bibtex
RUN gem install specific_install # workaround, see https://github.com/gollum/gollum/issues/1558
RUN gem specific_install 'https://github.com/github/markup.git' # workaround, see https://github.com/gollum/gollum/issues/1558

COPY config.rb /config.rb

WORKDIR /wiki
ENTRYPOINT ["gollum", "--port", "80", "--config", "/config.rb"]
EXPOSE 80
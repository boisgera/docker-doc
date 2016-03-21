FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHON python python-pip python-scipy python-matplotlib python-scipy python-pil
ENV LATEX texlive texlive-latex-extra dvipng texlive-luatex texlive-xetex \
          texlive-lang-english texlive-lang-french
ENV PATH /root/.local/bin:$PATH

RUN apt-get update && \
    apt-get install -y $PYTHON && \
    apt-get install -y $LATEX  && \
    apt-get install -y git && \
    # install pandoc
      apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 575159689BEFB442 && \
      echo 'deb http://download.fpcomplete.com/ubuntu trusty main' | \
      sudo tee /etc/apt/sources.list.d/fpco.list && \
      apt-get update && apt-get install -y stack && \
      stack setup && \
      stack install pandoc && \
      stack install pandoc-citeproc && \
    # install pandoc-templates
      cd /tmp && \
      git clone https://github.com/boisgera/pandoc-templates.git && \
      cd pandoc-templates && \
      ./install.sh && \
    # install eul-doc
      cd /tmp && \
      git clone https://github.com/boisgera/eul-doc.git && \
      cd eul-doc && \
      pip install --target=.lib --ignore-installed 'about>=5.1,<6' && \
      pip install . && \
    # install npm and node
      apt-get install -y curl && \
      curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash - && \ 
      apt-get install -y nodejs && \
    # install eul-style
      cd /tmp && \
      git clone https://github.com/boisgera/eul-style.git && \
      cd eul-style && \
      npm install -g coffee-script && \
      ./install && \
    # clean-up and exit
      rm -rf /var/lib/apt/lists/* && apt-get clean && apt-get autoremove && \
      true


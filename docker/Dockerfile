ARG PARENT_IMAGE
ARG USE_GPU
FROM $PARENT_IMAGE

USER root

RUN apt-get -y update \
    && apt-get -y install \
    ffmpeg \
    swig \
    # For building box2d
    build-essential \
    wget \
    patchelf \
    libglew-dev \
    libosmesa6-dev \
    && wget https://mujoco.org/download/mujoco210-linux-x86_64.tar.gz && \
    mkdir -p /root/.mujoco && \
    tar -xf mujoco210-linux-x86_64.tar.gz -C /root/.mujoco && \
    rm mujoco210-linux-x86_64.tar.gz \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER $MAMBA_USER

ENV CODE_DIR /home/$MAMBA_USER/code
COPY requirements.txt /tmp/

RUN \
    eval "$(micromamba shell hook --shell bash)" && \
    micromamba activate && \
    mkdir -p ${CODE_DIR}/rl_zoo3 && \
    pip uninstall -y stable-baselines3 && \
    pip install -r /tmp/requirements.txt && \
    pip install highway-env>=1.7.1 && \
    pip cache purge 

USER root

RUN  echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/.mujoco/mujoco210/bin' >> /root/.bashrc && \
    echo 'source /root/.bashrc' >> /root/.profile
    
USER $MAMBA_USER

CMD /bin/bash

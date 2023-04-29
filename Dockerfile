FROM ubuntu:latest

ENV ACTION_RUNNER_USER=runner

RUN apt-get update \
&& apt-get install -y --no-install-recommends sudo curl ca-certificates apt-transport-https

RUN echo "${ACTION_RUNNER_USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${ACTION_RUNNER_USER} \
&& useradd -s /bin/bash ${ACTION_RUNNER_USER} \
&& usermod -aG sudo ${ACTION_RUNNER_USER}

USER ${ACTION_RUNNER_USER}
WORKDIR /home/${ACTION_RUNNER_USER}

COPY ./scripts.d /home/${ACTION_RUNNER_USER}/

RUN echo $(pwd) && ./install_runner.sh

ENTRYPOINT [ "./start_runner.sh" ]
CMD ["/bin/bash"]

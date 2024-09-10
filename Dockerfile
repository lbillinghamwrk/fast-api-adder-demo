FROM python:3.12

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/opt/poetry python3 && \
    cd /usr/local/bin && \
    ln -s /opt/poetry/bin/poetry && \
    poetry config virtualenvs.create false

WORKDIR /app

# Copy poetry.lock* in case it doesn't exist in the repo
COPY ./pyproject.toml ./poetry.lock* /app/

RUN bash -c "poetry install --no-root --only main"

COPY ./fast_api_adder_demo /app/fast_api_adder_demo

CMD ["fastapi", "run", "fast_api_adder_demo/main.py", "--port", "80"]
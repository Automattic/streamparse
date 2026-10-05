venv ?= .venv

.PHONY: default clean test publish

default: dist

clean:
	rm -rf dist streamparse.egg-info $(venv)

test: $(venv)
	$(venv)/bin/pytest

# Set TWINE_REPOSITORY_URL to the index to upload to.
publish: clean dist
	$(venv)/bin/twine upload --verbose dist/*

$(venv): requirements.txt test-requirements.txt setup.cfg
	uv venv $(venv)
	uv pip install --python $(venv) -r requirements.txt -r test-requirements.txt build twine

dist: $(venv)
	$(venv)/bin/python -m build --no-isolation

all:
	python setup.py bdist_wheel

test:
	twine upload --repository-url https://test.pypi.org/legacy/ dist/*

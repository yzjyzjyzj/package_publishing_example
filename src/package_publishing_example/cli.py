import typer
from . import revcomp

app = typer.Typer()


@app.command(name="revcomp")
def revcomp_wrapper(input: str):
    print(revcomp(input))


@app.command()
def upper(input: str):
    print(input.upper())


@app.command()
def lower(input: str):
    print(input.lower())

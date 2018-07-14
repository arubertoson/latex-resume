## LaTeX Template for Cover Letter & Resume

## Preview

It's fairly easy to change color schemes, update the colors in `resume.tex` or
`cover_letter.tex` files to suite your needs. It's also possible to create
a colorscheme file and use `\input{resources/colors}` to share it between the
tex files.

#### Resume

| Default | One Dark |
|:-------:|:--------:|
| ![Resume](https://raw.githubusercontent.com/arubertoson/latex-resume/master/example/resources/default_resume.jpg) | ![Resume](https://raw.githubusercontent.com/arubertoson/latex-resume/master/example/resources/one_dark_resume.jpg) | 

#### Cover Letter

| Default | One Dark |
|:-------:|:--------:|
| ![Resume](https://raw.githubusercontent.com/arubertoson/latex-resume/master/example/resources/default_letter.jpg) | ![Resume](https://raw.githubusercontent.com/arubertoson/latex-resume/master/example/resources/one_dark_letter.jpg) | 

## Installation

```bash
cd ~/texmf/tex/latex/local
git clone https://github.com/arubertoson/latex-resume.git
```

#### Requirements

* [TeXLive](https://www.tug.org/texlive)
* [MiKTex](https://miktex.org/)

From my understaning when using MiKTeX most packages will be fetched
automatically when they are missing. TeXLive is a bit more complex if you are
planning to use the lightweight variant. You will have to install the below
packages and the Ubuntu font.

I'm planning to reduce the dependencies in the future - the current list is
unfortunatly a bit long:

```bash
tlmgr install \
  texloc \
  tikz \
  pgf \
  xcolor \
  textpos \
  tcolorbox \
  environ \
  trimspaces \
  etoolbox \
  enumitem \
  parskip \
  setspace \
  titlecaps \
  ifnextok \
  noindentafter \
  xargs \
  xstring \
  fancyvrb \
  xkeyval \
  zapfding \
  fontspec \
  pzdr \
  fontawesome \
  opensans \
  paratype \
  latexmk \
```

## Usage

To build the examples you will need the above dependencies installed, simply
navigate to the example directory and run make. This will create both the
example_resume.pdf and example_cover_letter.tex in a output directory.

```
cd /path/to/latex-resume/examples
make
ls output
example_resume.pdf example_cover_letter.pdf
```

To make modifications to the output resume use the provided modules.

  * **examples/resources** contains information that is shared between both tex
      files
  * **examples/resume** contains modules to build the resume pdf
  * **examples/cover_letter** contains modules to build the cover_letter pdf

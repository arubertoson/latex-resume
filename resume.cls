
%% resume.cls
% Resume Class File
% Author:
% Marcus Albertsson <marcus.arubertoson@gmail.com>
%
% Class license:
% LPPL v1.3c (http://www.latex-project.org/lppl)

\ProvidesClass{resume}[2018/07/14 Latex Resume Class]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}


%-------------------------------------------------------------------------------
%                Packages
%-------------------------------------------------------------------------------

\RequirePackage{tikz} % pgf included
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage[skins,breakable]{tcolorbox}

\RequirePackage{fontspec}
\RequirePackage{xcolor}
\RequirePackage{enumitem}

\RequirePackage{calc}
\RequirePackage{parskip}
\RequirePackage{setspace}
\RequirePackage{ragged2e}
\RequirePackage{titlecaps}
\RequirePackage{noindentafter}

\RequirePackage{etoolbox}
\RequirePackage{xargs}
\RequirePackage{xparse}
\RequirePackage{xstring}

\RequirePackage{graphicx}          % Stretch text
\RequirePackage{fontawesome}
\RequirePackage{ifpdf}


% Resume Modules
\RequirePackage{modules/skills}
\RequirePackage{modules/contact}
\RequirePackage{modules/links}
\RequirePackage{modules/references}
\RequirePackage{modules/entities}
\RequirePackage{modules/coverletter}


\RequirePackage[hidelinks,unicode]{hyperref}
\hypersetup{%
  pdftitle={},
  pdfauthor={},
  pdfsubject={},
  pdfkeywords={}
}

%-------------------------------------------------------------------------------
%                Global Variables
%-------------------------------------------------------------------------------

% Directories
\newcommand{\fonts}{fonts/}
\newcommand{\import}{document/}

% Personal Information
\newcommand*{\position}[1]{\def\@position{#1}}
\newcommand*{\photo}[1]{\def\@photo{#1}}
\newcommand*{\profile}[1]{\def\@profile{#1}}

% Modules / Entries
\newcommand*{\sidebarentries}[1]{\def\@sidebarentries{#1}}
\newcommand*{\documententries}[1]{\def\@documententries{#1}}
\newcommand*{\documentmodule}[1]{\def\@documentmodule{#1}}


%-------------------------------------------------------------------------------
%                Utils
%-------------------------------------------------------------------------------

% http://tex.stackexchange.com/a/47182
% Automates \newcommand{<name>}{} to ensure uniqueness
\newcommand*{\pgfmathsetnewmacro}[2]{%
  \newcommand*{#1}{}% Will Error out if already defined
  \pgfmathsetmacro{#1}{#2}%
}%

% Macro to create and set a length. This should only be used when
% declaring a definition. Afterwards it should be treated as a usual
% lenght using the normal set methods.
\newcommand*{\pgfmathsetnewlength}[2]{%
  \newlength{#1}%
  \pgfmathsetlength{#1}{#2}%
}%


%-------------------------------------------------------------------------------
%                Layout
%-------------------------------------------------------------------------------

% Thickness of the top bar, to turn off set to zero.
\pgfmathsetnewlength{\headerbarsize}{.5cm}
\pgfmathsetnewlength{\sidebarsize}{\paperwidth/3}
\pgfmathsetnewlength{\pushedleftmargin}{\sidebarsize}
% Need to add a offset to match the top margin, I lack the expertice to
% solve this problem in a more elegant manner at the moment. But it seems to
% be related to tikzpicture. TODO: Try adjustbox
\pgfmathsetnewlength{\pushedtopmargin}{\headerbarsize-1.95em}

% Represents the offsets from the document bars.
\pgfmathsetnewlength{\topmarginoffset}{3.25em}
\pgfmathsetnewlength{\leftmarginoffset}{2.5em}

% Apply calculated margins to document
\newgeometry{%
  left=\pushedleftmargin+\leftmarginoffset,
  top=\pushedtopmargin+\topmarginoffset,
  right=1cm,
  bottom=2cm
}


%-------------------------------------------------------------------------------
%                Config
%-------------------------------------------------------------------------------

% Header
\newcommand{\firstnamefontsize}{30pt}
\newcommand{\lastnamefontsize}{30pt}

% Photo
\newcommand{\photosize}{4.5cm}
\newcommand{\photozoom}{5.0cm}
\newcommand{\photoedgesize}{0.5mm}
\newcommand{\photouteredge}{0.5cm}
% Automatically determine top margin and offset to match header.
\pgfmathsetnewlength{\photoverticaloffset}{%
  \photosize/2 + \headerbarsize+\topmarginoffset%
}%
\pgfmathsetnewlength{\headerverticaloffset}{%
  \photosize- (\firstnamefontsize+\lastnamefontsize)
}

% Paragraphs
\pgfmathsetnewlength{\paragraphskip}{.5em}
\newcommand{\paragraphspacing}{1.2}

% Sections
\pgfmathsetnewlength{\sectionrulespace}{-0.5em}
\pgfmathsetnewlength{\sectionrulesize}{1pt}
\pgfmathsetnewlength{\sectionraiseprefix}{0.15ex}
\pgfmathsetnewlength{\sectionraisesuffix}{0.15ex}

\newcommand{\sectionspacing}{1.25em}
\newcommand{\sectionsquash}{0.9}
\newcommand{\sidebarsectionrulecolor}{grey}
\newcommand{\sectionrulecolor}{grey}
\newcommand{\sectionprefixsymbol}{//}
\newcommand{\sectionsuffixsymbol}{}


%-------------------------------------------------------------------------------
%                Fonts
%-------------------------------------------------------------------------------

\newfontfamily\headerfont{OpenSans}[
  UprightFont=*-Regular,
  BoldFont=*-Bold,
  Extension=.ttf
]

\newfontfamily\textfont{Ubuntu}[
  UprightFont=*-Regular,
  ItalicFont=*-Italic,
  BoldFont=*-Bold,
  Extension=.ttf
]

\newfontfamily\letterfont{PTSerif}[
  UprightFont=*-Regular,
  ItalicFont=*-Italic,
  BoldFont=*-Bold,
]


%-------------------------------------------------------------------------------
%                Colors
%-------------------------------------------------------------------------------

\definecolor{grey}{HTML}{686868}

\definecolor{fg}{HTML}{ffffff}
\definecolor{fg-d}{HTML}{fafafa}

\definecolor{bg}{HTML}{888888}
\definecolor{bg-d}{HTML}{494949}

\definecolor{accents}{HTML}{cfcfcf}


%-------------------------------------------------------------------------------
%                Styles
%-------------------------------------------------------------------------------

% Icon Styles (fontawesome)
\newcommand{\iconstyle}[1]{{%
  \fontsize{22}{24}
  \color{fg}
  \raisebox{-2ex}{#1}
}}

% Header Base Style
\newcommandx*{\headerstyle}[4][1=30, 2=bg, 3=1, usedefault=@]{{%
  \headerfont%
  \pgfmathsetmacro{\localfsize}{#1*1.2}
  \fontsize{#1}{\localfsize}
  \addfontfeature{%
      FakeStretch=1, FakeSlant=0, LetterSpace=3, Color=#2
    }%
    \scalebox{1}[#3]{\textbf{\MakeUppercase{#4}}}
}}

% Header Styles
\newcommand{\headerfirstnamestyle}[1]{%
  \headerstyle[\firstnamefontsize][@][.9]{#1}
}
\newcommand{\headerlastnamestyle}[1]{%
  \headerstyle[\lastnamefontsize][@][1]{#1}
}
\newcommand{\headerpositionstyle}[1]{%
  \headerstyle[10pt][grey][1]{#1}
}

% Sidebar Styles
\newcommand{\sidebarheaderstyle}[1]{{%
  \fontsize{10pt}{1em}\headerfont\bfseries\color{fg} \titlecap{#1}
}}
\newcommand{\sidebarcontentstyle}[1]{{%
  \fontsize{9pt}{1em}\headerfont\color{fg-d}
  \addfontfeature{LetterSpace=2, FakeBold=0} #1
}}

% Section Styles
\newcommand{\sectionstyle}[1]{{%
  \fontsize{16pt}{1em}\headerfont\bfseries\color{bg}
  \addfontfeature{LetterSpace=3, FakeBold=0}\MakeUppercase{#1}
}}
\newcommand{\sectionsidebarstyle}[1]{{%
  \fontsize{16pt}{1em}\headerfont\bfseries\color{fg}
  \addfontfeature{LetterSpace=3, FakeBold=0}\MakeUppercase{#1}
}}
\newcommand{\sectionprefixstyle}[1]{{%
  \fontsize{16pt}{1em}\headerfont\bfseries\color{accents}
  \addfontfeature{LetterSpace=0, FakeBold=6} #1
}}


%-------------------------------------------------------------------------------
%                Fancyheader
%-------------------------------------------------------------------------------

% XXX: There might be instances where we want different styles, it would be
% pretty a pretty mundane task to expan styles to be handled as a module and
% easily extedable

% Fanyheader is used to draw bars and other elements automatically for every
% new page that is created in the resume

% Fancystyle for pages not of type title
\fancypagestyle{rest}{%
  \fancyhf{}

  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \fancyhead[C]{%
    \vspace*{5em}%
    \drawbars%
    \footer%
  }
}

% Fancystyle for first page (title page)
\fancypagestyle{title}{%
  \fancyhf{}

  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \setlength{\headheight}{\paperheight/4-.75em}
  \fancyhead[C]{%
    \drawbars%
    \drawphoto%
    \header%
    \populatesidebar{\@sidebarentries}
  }
}

% Fancy footerstyle for other pages
\newcommand{\footer}{%
  \setlength{\TPHorizModule}{\sidebarsize}
  \setlength{\TPVertModule}{\paperheight}
  \begin{textblock}{0.75} (0.125, .9)
    \centering
    \sidebarcontentstyle{%
      \setstretch{1.1}
      \@firstname\space\@lastname\\
      \@phone\\ \@email\\ \@address%
    }
  \end{textblock}
}

% Fancy headerstyle for title page
\newcommand{\header}{%
  % If profile is not defined give document more whitespace to work with
  \ifdef{\@profile}
    {}
    {\vspace{\headerverticaloffset}}

  % Draw header information
  \begin{flushleft}
    \headerfirstnamestyle{\@firstname}\\[.25em]
    \headerlastnamestyle{\@lastname}\\[.1em]
    \headerpositionstyle{\@position}%
  \end{flushleft}
}


% Set document styles
\thispagestyle{title}
\pagestyle{rest}


%-------------------------------------------------------------------------------
%                Tikz (Drawing)
%-------------------------------------------------------------------------------

\newcommand{\drawbars}{%
  \begin{tikzpicture}[remember picture,overlay]
    \node [% Headerbar
      rectangle,
      fill=accents,
      anchor=north,
      minimum width=\paperwidth-(\sidebarsize/4),
      minimum height=\headerbarsize+0.1cm
      ] at ([yshift=0.1cm]current page.north) {};
    \node [% Sidebar
      rectangle,
      fill=bg,
      anchor=north west,
      minimum width=\sidebarsize+0.1cm,
      minimum height=\paperheight
      ] at ([xshift=-0.1cm]current page.north west) {};
  \end{tikzpicture}%
}

\newcommand{\drawphoto}{%
  \begin{tikzpicture}[remember picture,overlay]
    \node(image) [% Outer circle is bound to image center and will draw with the offset
      circle,
      draw=accents,
      line width=\photoedgesize,
      minimum size=\photosize+\photouteredge,
      ] at ([xshift=\sidebarsize/2,
             yshift=-\photoverticaloffset] current page.north west){};
    \node[%
      circle,
      minimum size=\photosize,
      path picture={%
        \node[] at ([yshift=-0.5cm, xshift=-.1cm] path picture bounding box.center){%
          \includegraphics[width=\photozoom]{\@photo}%
        };
      }] at (image.center){};
  \end{tikzpicture}%
}%


%-------------------------------------------------------------------------------
%                Section Helper Functions
%-------------------------------------------------------------------------------

% Offset prefix and suffix symbols to line up with text
\newcommand{\sectionprefix}{%
  \raisebox{\sectionraiseprefix}{\sectionprefixstyle{\sectionprefixsymbol}}
  }
\newcommand{\sectionsuffix}{%
  \raisebox{\sectionraisesuffix}{\sectionprefixstyle{\sectionsuffixsymbol}}
  }

% Draw section rule for sidebar and main document
\newcommand{\sectionrule}{%
  \color{\sectionrulecolor}\rule{\textwidth}{\sectionrulesize}
  }
\newcommand{\sidebarsectionrule}{%
  \color{\sidebarsectionrulecolor}\rule{\textwidth}{\sectionrulesize}
  }

% Create section header
\newcommand{\drawsection}[1]{%
  \noindent
  \scalebox{1}[\sectionsquash]{%
    \sectionprefix{\hspace{.5em}#1}
    \sectionsuffixsymbol%
  }
  \\[\sectionrulespace]
}

% Populates a section by calling a module packages draw macro
\newcommand{\populatesection}[2]{%
    \foreach[] \each in #1
    {%
      % Using csname to expand the call to a module command we can utelize
      % the command pattern principle and have each module contain a draw macro
      % to control the drawing.
      \begin{section}[\each][#2]
        \csname draw@\each\endcsname%
      \end{section}%
      \vspace{\sectionspacing}%
    }
}


% Environemnt for sections in the cv
\DeclareDocumentEnvironment{section}{O {Section} O {\sectionstyle}}
  {
    \ifstrempty{#1}
      {}
      {
        \begin{flushleft}
          \drawsection{#2{#1}}
          \sectionrule%
        \end{flushleft}
      }
    \setlength{\parskip}{.6em}
    \NoIndentAfterThis%
  } {}


% Environment for paragraphs within the document
\DeclareDocumentEnvironment{paragraph}{O {\paragraphskip} O {\paragraphstyle}}
  {%
    \vspace{#1}
    \begin{flushleft}
      \setstretch{\paragraphspacing}
      #2
  }
  {%
    \end{flushleft}
  }

\newenvironment{cvlist}{%
  \vspace{.25em}
  \begin{itemize}[leftmargin=3ex, nosep,noitemsep]
}{%
  \end{itemize}
}

%-------------------------------------------------------------------------------
%                Build Sections
%-------------------------------------------------------------------------------

% NOTE: Must be performed manually as textblock can't read evalutated math
\newcommand{\textblockvertoffset}{.75}
\newcommand{\textblockcenter}{0.125}
\newcommand{\textblockoffset}{1.25}

\newcommand{\populatesidebar}[1]{%
  \setlength{\TPHorizModule}{\sidebarsize}
  \setlength{\TPVertModule}{\photoverticaloffset+(\photosize/2)}

  \begin{textblock}{\textblockvertoffset} (\textblockcenter,\textblockoffset)
    \populatesection{\@sidebarentries}{\sectionsidebarstyle}
  \end{textblock}%
}

\newcommand{\populatedocument}{%
  \foreach[] \each in \@documententries%
  {%
    \@ifundefined{@documentmodule}
      {\input{\each}}
      {\input{\@documentmodule/\each}}
    
    \vspace{\sectionspacing}
  }
}
%-------------------------------------------------------------------------------

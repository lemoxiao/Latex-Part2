## ftc-notebook — Formating for FIRST Tech Challenge (FTC)  Notebooks

Team FTC 9773, Robocracy, Released 2019/02, Version 1.0

### Abstract

The ftc-notebook package will greatly simplify filling entries for your FIRST Tech Challenge (FTC) engineering or outreach notebook. We build on top of LaTeX, a robust system that can easily accommodates documents of 100+ pages of entries, figures, and tables while providing support for cross-references.  We developed this package to support most frequently used constructs encountered in an FTC notebook: meetings, tasks, decisions with pros and cons, tables, figures with explanations, team stories and bios, and more. We developed this package during the 2018- season and are using it for our engineering notebook. Team Robocracy is sharing this style in the spirit of coopertition.

### Overview

The LaTeX package ftc-notebook provides help to format a FIRST Tech Challenge (FTC) engineering or outreach notebook. Using this style, you will be able to seamlessly produce a high quality notebook. Its main features are as follows.

- Esthetically pleasing cover pages for the notebook and monthly updates.
- Easy to use format to enter a team story and a bio for each of the team members.
- Quick references using list of tasks, figures, and tables.
- Meeting entries separated into lists of tasks.
- Each task is visually labeled as one of several kind of activities, such as Strategy, Design, Build, Software,... Activity kind can be customized to reflect a team’s particular focus.
- Support for supporting your decisions in clear tables that list the pros and cons of each of your decisions.
- Support for illustrating your robot using pictures with callouts. A callout is text in a box with an arrow pointing toward an interesting feature on your picture.
- Support for pictures with textual explanation, and groups of picture within a single figure.

We developed this style during the 2018-2019 FTC season and we used it successfully during our competitive season. Compared to other online documents, it is much more robust for large documents. By designing a common style for all frequent patterns, the document also has a much cleaner look. LaTeX is also outstanding at supporting references. Try combining it with an online service like Overleaf, and your team will be generating quality notebooks in no time by actively collaborating online.

We developed this package to require little knowledge of LaTeX. We have tried to hide of the implementation details as much as possible. We explain LaTeX concepts as we encountered them in the document, so we recommend that LaTeX novices read the document once from front to back. Experienced users may jump directly to figures and sections explaining specific environment and commands.

The overall structure of an FTC notebook should be as shown in Figure 1 below.

```
  \documentclass[11pt]{article}
  \usepackage[Num=FTC~9773, Name=Robocracy]{ftc-notebook}
  \begin{document}
  % 1: cover page and lists
  \CoverPage{2018-19}{robocracy18.jpg}
  \ListOfTasks
  \ListOfFigures
  \ListOfTables

  % 2: start of the actual notebook with optional team story and bios
  \StartNotebook
  \input{src/story.tex}
  \input{src/bio.tex}

  % 3: meeting entries with optional month delimiters
  \Month{August}{aug18.jpg}
  \input{src/aug19.tex}
  \input{src/aug21.tex}
  % repeat for successive months until the end of your successful season
  \end{document}

  Figure 1: Template for notebook.
```

A document consists of three distinct parts. First, we generate a cover page, followed by lists of tasks, figures, and tables. Pages use alphabetical numbering, as customary for initial front matter. As shown in Figure 1, a LaTeX document starts with a \documentclass command, followed by a list of packages used, and then a \begin{document} command. In LaTeX, comments use the percent character.

Second, we indicate the beginning of the actual notebook using the \StartNotebook command. Pages are then numbered with numerical page numbers starting at 1. A team story and team bio can be entered here, and have specific LaTeX commands detailed in the documentation.  For users unfamiliar with LaTeX, \input commands are used to include separate files whose file names are passed as arguments. The included files are processed as if they were directly listed in the original file. We will use this feature extensively to manage large documents such as an engineering notebook.

Third, we have the actual content of the notebook. We structure entries by meeting and suggest that each meeting uses a distinct input file for its text and a corresponding subdirectory for its supporting material, such as pictures. A meeting entry typically consists of a list of tasks.  Optionally, a new month can be started with a cover page that includes a picture that highlights the accomplishment of the team for that month.

Because you may generate a lot of text, figures, and pictures over the course of your season, we recommend the file structure shown in Figure 2.

```
Directory structure:

  notebook.tex:     Your main latex file.
  ftc-notebook.sty: This style files that includes all the formatting,
                    unless the style file was installed in your
                    LaTeX directory
  newmeeting.sh:    A bash script that allows you to create a new
                    meeting file that is pre-filled. The script can be
                    customized for your team.
  src:              Directory where all the meeting info will go.
  |
  --> images:       A subdirectory where all the global pictures will go.
  |                 We recommend to put the team logo, team picture,
  |                 and monthly pictures (if you chose to use them)
  |                 Pictures are searched there by default.
  --> aug19.tex     A file that includes all the text for your
  |                 (hypothetical) August 19th meeting
  --> aug19:        A subdirectory where you put all the images
                    needed in your aug19.tex file

Figure 2. Directory structure.
```

We recommend to use a pair of "date.tex" LaTeX file and "date" subdirectory for each meeting.  This structure minimizes the risk of name conflicts for pictures and other attachments during the FTC season. Generally, directories logically organized by dates also facilitate searching for specific information.







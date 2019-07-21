# Awesome Cookbook [![Example](https://img.shields.io/badge/example-pdf-green.svg)](https://raw.githubusercontent.com/Nooby4Ever/awesome-cookbook/master/examples/cookbook.pdf)
awesome-cookbook is a LaTeX template for a cookbook based on [Awesome CV](https://github.com/posquit0/Awesome-CV) (insired by [Fancy CV](https://www.sharelatex.com/templates/cv-or-resume/fancy-cv)) and the [xcookybooky](https://www.ctan.org/pkg/xcookybooky) package. It is easy to use (even for people not familiar with LaTeX) and easy to customize. In case the provided options would not be sufficient one can always edit the template itself, which is fairly clean written and uses no dirty LaTeX hacks. The template is friendly on languages (eg. hebrew ect) and loads probably all packages you need.

This template is not provided as a package, the rule of thumb is:
> If [new] commands could be used with any document class, then make them a package; and if not, then make them a class.

this template is just another style for the book document class; thus not a package!

## Table of contents

* [Examples](#examples)
* [How to Use](#how-to-use)
* [Contribute](#contribute)
* [Credit](#credit)
* [License](#license)

## <a name="examples"></a>Examples

There are several examples provided to get you up and running in no-time! For a more in depth explanation we refer to the [How to Use](#how-to-use) section.

* [cookbook](https://raw.githubusercontent.com/Nooby4Ever/awesome-cookbook/master/examples/cookbook.pdf) - **A showcase for all available options and features which you can use.** This gives you a nice impression on how a cookbook made with awesome-cookbook could look like. The `cookbook.tex` file is annotated to explain what each option does and can be seen as the documentation.
* [MWE auto](https://raw.githubusercontent.com/Nooby4Ever/awesome-cookbook/master/examples/MWE_auto.pdf) - Uses the same data (recipes) as the cookbook example but without any options set before the `\begin{document}` environment. This `.tex` file is really minimal.
* [MWE manual](https://raw.githubusercontent.com/Nooby4Ever/awesome-cookbook/master/examples/MWE_manual.pdf) - Will look the same as `MWE auto` but does not use the autoGenerate functionally. Generally speaking you would want to use the autoGenerate feature because it makes your life easier.

FYI; MWE stands for: Minimal Working Example

## <a name="how-to-use">How to Use
A full TeX ([LaTeX2e](http://www.latex-project.org/get/)) distribution is assumed.  [Various distributions for different operating systems (Windows, Mac, \*nix) are available](http://tex.stackexchange.com/q/55437) but TeX Live is recommended.
You can [install TeX from upstream](http://tex.stackexchange.com/q/1092) (most up-to-date) or use your distribution's package manager eg. `sudo apt-get install texlive-full`.  (It's generally a few years behind depending on your distribution, e.g Arch Linux is probably up-to-date, debian might not be)

If you use the `\autoGenerate` feature you must also install [LuaFileSytem](https://keplerproject.github.io/luafilesystem/manual.html) or `lfs`. For Linux users this probably is available as a package in your package manager. Otherwise you can use LuaRocks: `luarocks install luafilesystem`.

This template supports:
- [x] [LuaTeX](http://luatex.org/)
- [ ] [XeTeX](http://xetex.sourceforge.net/) (because of Lua script)
- [ ] [ConTeXt](http://wiki.contextgarden.net/Main_Page) (untested)
- [ ] [pdfTex](http://www.tug.org/applications/pdftex/) (because of fonts and Lua script)

The template was only tested on Linux but other operating systems should work as well.

#### Make your own cookbook
To start from scratch:
* Download/clone this repository
* Copy the `autogenerate.lua,awesome-cookbook.cls,fontawesome.sty` files, folders `/fonts` and `/resources` to a new folder.
* Make a new `.tex` file (see the MWE [examples](#examples)) and off you go!

alternatively you may download/clone this repository and start playing with the examples.

To generate the pdf file. At a command prompt, run
```bash
$ lualatex --shell-escape {your-cookbook}.tex
```

This should result in the creation of ``{your-cookbook}.pdf`` (to make sure the tikzpictures are properly rendered you may have to invoke the command twice). Alternatively you may use an editor/IDE eg. [TeXstudio](http://texstudio.sourceforge.net/), [Texmake](http://www.xm1math.net/texmaker/), [TeXworks](https://github.com/TeXworks/texworks/releases), [Kile](http://kile.sourceforge.net/), [ _your favorite editor here_ ]. For a full list we refer to [tex.stackexchange](http://tex.stackexchange.com/questions/339/latex-editors-ides).

**Remark:** do not forget the `--shell-escape` if you want to use `\autoGenerate` (you probably have to enable/add this to your editor/IDE's LaTeX command. See their documentation on how this can be done).

#### Using the template

awesome-cookbook is just a stylized version of the `book` class, specifically made for cookbooks. It provides some environments/commands to help you and styles some default elements to get a more modern cookbook look and feel. Recipes (`\recipe[<style>]{<name>}`) are under the hood just sections so you may use any LaTeX code underneath them. Because the aim is not to provide a full package, the customization options are not extensive (to keep the `.cls` file clean and slim). If you want to make significant changes to the style (eg cover page, recipe header, ...) we advice you to just edit the `.cls` file. All the "fancy" graphics are done with tikz.

A basic recipe looks something like this, note none of the environments/commands are mandatory:
```
\recipe{Tea}

\info[servings=1, time = 15]{}

\begin{ingredients}
  \ingredient{200}{ml}{water}
  \ingredient{1}{}{tea bag (your favorite flavor)}
\end{ingredients}

\begin{preparation}
    \step Put the water in a kettle, on a pit, and heat until the water almost boils.
    \step Pour the water into a cup and add the tea bag.
    \step Wait for about 10min and your tea is ready to drink!
\end{preparation}
```
for more information about the usage and all available options we refer to the [examples](#examples), the file [rumaki.tex](https://github.com/Nooby4Ever/awesome-cookbook/blob/master/examples/recipes/Starters/rumaki.tex) is annotated and can be seen as the documentation.

If you want more control over the look you can edit the `awesome-cookbook.cls` file yourself, it is fairly well annotated and should be rather easy to edit.

#### \autoGenerate

Big fuss over a <80 line Lua script (see [autogenerate.lua](https://raw.githubusercontent.com/Nooby4Ever/awesome-cookbook/master/autogenerate.lua)) but anyway... this LaTeX command will automatically generate `\begin{document}` environment in your main `.tex` file. It will sort the recipes alphabetically for each category individually and sort the ingredients in the `energylist.tex`(if provided). In order for this to work you must provide the following files and put them in a new directory (eg. `recipes/`):
* **Preface**: add a `preface.tex` file, this will include the provided `.tex` file between the TOC and the recipes. By default this file should only provide the `\begin{preface}` environment but you may add more chapters if you so desire. If this file is not provided the recipes will directly follow the TOC.
* **Categories**: add a `categories.txt` file, each line represents a category. They will appear in the provided order in the cookbook . eg.
```
Starters
Main Courses
Desserts
```
(if this file is not provided no categories, nor recipes, will included in the cookbook)
* For each category provide a folder with the identical name, eg. `Main Courses`. This folder will contain all the recipes (`.tex` files) for that category. They will be automatically **sorted on their filename**.
* **Recipe**: make a new `.tex` file and place in a category's folder. Each file should only represent 1 recipe. The name used within the recipe command may differ from your file name, eg. `tomato_soup.tex` and `\recipe{Soup from tomatoes}`.
* **Appendices**: create a new folder named `appendices`, all `.tex` files in this directory will be added as appendix (after the recipes). If not provided, or empty, no appendices will be added.
* **Energy list**: you may specify an energy list by adding `energylist.tex` in the appendices folder. This file should only contain the energylist environment. The entries in the list will be automatically alphabetically sorted.

This will result in a structure similar to this:
```
[template files]      (autogenerate.lua, awesome-coobook.cls, fontawesome.sty)
[template folders]    (/fonts, /resources)
your_cookbook.tex
recipes/
    categories.txt    ......................... | Contains:
    preface.tex                                 | Starters
    appendices/                                 | Main Courses
      energylist.tex                            | Desserts
    Starters/
      tomato_soup.tex
      chicken_soup.tex
      ...
    Main Courses/
      lasagna.tex
      pizza.tex
      ...
    Desserts/
      pudding.tex
      ...
```

It is rather straight forward, the [examples](#examples) use the `./recipes/` folder for this purpose. If something is not clear we refer to the examples as a guideline.

**Why bother?** It makes your life easier because you do not have to edit your main `.tex` file ever, nor do you have to manually sort the recipes. It also allows people not familiar with LaTeX to easily add a new recipe by just making a new `my_recipe.tex` file and drop in in the right (category) folder. **Even granny could do that!** This allows you to host your family cookbook on a cloud service (eg. dropbox, google drive, one drive, ...) so the whole family can contribute to the cookbook by adding reicpes!

As mentioned before you are **not required** to use this command and may just add each recipe manually in your cookbook `.tex` file, if you so desire.

## <a name="contribute">Contribute

Have you fixed a bug, added a new feature, improved the code or compatibility or anything else do not hesitate to fork and **make a PR!**

I try to keep the `.cls` file rather clean so if you want to go ham on tikz and provide a whole new style (instead of just add another simple recipe header style) i suggest you to just fork the template. Otherwise the `.cls` file may become hard to read and adapt for other people.

Have you found a bug, or want a specific feature, and don't know how to fix/add it? Check if there is not already a similar issue opened and if not make a **new [issue](https://github.com/Nooby4Ever/awesome-cookbook/issues/new)!**

## <a name="credit">Credit

[**Kitchen icon pack**](http://www.flaticon.com/packs/kitchen) is a collection of awesome icons provided in png, svg, pds and eps format. Designed by Freepik and distributed by [Flaticon](http://www.flaticon.com/packs/kitchen). All icons are included so you can change them if desired; alternatively you can download an other icon pack (see link).

[**xcookybooky**](http://www.ctan.org/pkg/xcookybooky) is a LaTeX package to make cookbooks, unlike this template it features a full package with more customization options. Although our template provides a more modern look and feel. The layout for our recipes is based upon xcookybooky.

[**LaTeX awesome-CV**](https://github.com/posquit0/Awesome-CV) is a beautiful template to make your CV(Curriculum Vitae), Résumé or Cover Letter. This template is based on the awesome-cv template.

[**Lua**](http://www.lua.org/) is a powerful, efficient, lightweight, embeddable scripting language. It supports procedural programming, object-oriented programming, functional programming, data-driven programming, and data description.

[**LaTeX**](http://www.latex-project.org) is a fantastic typesetting program that a lot of people use these days, especially the math and computer science people in academia.

[**LaTeX FontAwesome**](https://github.com/furl/latex-fontawesome) is bindings for FontAwesome icons to be used in XeLaTeX/LuaLaTeX.

[**Roboto**](https://github.com/google/roboto) is the default font on Android and ChromeOS, and the recommended font for Google’s visual language, Material Design.

[**Source Sans Pro**](https://github.com/adobe-fonts/source-sans-pro) is a set of OpenType fonts that have been designed to work well in user interface (UI) environments.

## <a name="license">License
**Warning:** the following section, the license, only applies to the work done on top of aweosme-cv and other resources. It does **not** apply to any of the used resources themselves, see the links in the [credits](#credits) section for their corresponding licenses.

***

The person who associated a work with this deed has dedicated the work to the public domain by waiving all of his or her rights to the work worldwide under copyright law, including all related and neighboring rights, to the extent allowed by law.

You can copy, modify, distribute and perform the work, even for commercial purposes, all without asking permission. Link to the full [license](https://creativecommons.org/publicdomain/zero/1.0/) (CC0).

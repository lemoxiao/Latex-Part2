# cgdrep

[![CircleCI](https://circleci.com/gh/cogenda/cgdrep/tree/master.svg?style=svg)](https://circleci.com/gh/cogenda/cgdrep/tree/master)


This is the LaTeX template for writing technical reports 
used at Cogenda Pte Ltd.
It contains the following LaTeX classes and the corresponding LyX layouts:

  - English report `cgdrepen` ;
  - English article `cgdarten` ;
  - Chinese report `cgdrepcn` ;
  - Chinese article `cgdartcn` .

## Install

The templates depends on recent versions of several LaTeX macro packages,
so a recent LaTeX distribution is required. TexLive2013 is known to work.

To install, run the script `./install.sh`. It relies on `kpsewhich` to
locate LaTeX. If `.lyx2.1/`, `.lyx2.0/`, or `.lyx/` directory is found in
the user's home directory, it also installs the LyX layout files.

## Documentation

A manual is available in Chinese (`CGD-QP-1401/`),
which we use in the company for training.
Some example documents (in both English and Chinese)
are available in the `example/` directory.

# 说明

本项目包含珂晶达电子有限公司内部技术报告采用的LaTeX模板，以及对应的LyX样式。
这包括：

  - 英文报告模板 `cgdrepen` ；
  - 英文短文模板 `cgdarten` ；
  - 中文报告模板 `cgdrepcn` ；
  - 中文短文模板 `cgdartcn` 。

## 安装

本套模板用到了一系列较新的宏包。因此，需要安装较新版本的LaTeX发行包才能使用
本套模板。经测试，TexLive2013可以满足要求。

安装时，运行`./install.sh`脚本。该脚本依赖`kpsewhich`定位LaTeX安装路径。
如果用户home目录下，包含`.lyx2.1/`、`.lyx2.0/`、或`.lyx/`目录之一，脚本也会
安装LyX样式文件。

## 文档

中文版说明书在`CGD-QP-1401/`目录下。
另有一些中、英文样例文档，存放在`example/`目录下。





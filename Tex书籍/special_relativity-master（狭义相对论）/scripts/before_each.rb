#!/usr/bin/ruby

require 'fileutils'

brief_toc_file = 'brief-toc.tex'
new_brief_toc_file = 'brief-toc-new.tex'

if !File.exists?(brief_toc_file) then
  File.open(brief_toc_file,'w') { |f|
    f.write "%\n"
  }
end

if File.exists?(new_brief_toc_file) then
  FileUtils.mv(new_brief_toc_file,brief_toc_file)
end

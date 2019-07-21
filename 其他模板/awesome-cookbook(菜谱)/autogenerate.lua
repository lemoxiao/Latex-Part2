require "lfs"

-- See if the given file exists
function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- Get all lines from the given file
function lines_from(file)
  local lines = {}
  for line in io.lines(file) do lines[#lines + 1] = line  end
  return lines
end

-- Gather and sort all the .tex files in the folder,
-- also generates LaTeX code. (path without tailing /)
function search_tex(path)
	local files = {}

	-- get all the files in the category folder
	for file in lfs.dir(path) do
		-- ignore folders and non .tex files
		if file ~= "." and file ~= ".."  and string.sub(file, -4) == ".tex" then
	  		table.insert(files, file)
   		end
	end

  	-- sort and generate LaTeX output
  	table.sort(files)
  	for i,n in ipairs(files) do 
		if n == "energylist.tex" then
			-- sort the nutrients in energylist.tex
			local nutrients = {}
			for line in io.lines(path.."/"..n) do
				if string.find(line, "\\nutrient") ~= nil then
					local trimmedline = string.gsub(line, "^%s*", "") -- left trim
					table.insert(nutrients, trimmedline)
				elseif string.find(line, "\\end{energylist}") ~= nil then
					table.sort(nutrients)
					for i2,n2 in ipairs(nutrients) do tex.print(n2) end
					tex.print("\\end{energylist}")
				else tex.print(line) end
			end
		else
			-- if not energylist.tex just include the file
			tex.print("\\input{\""..path.."/"..n.."\"}")
		end
	end
end

-- -------------------
-- Generate LaTeX code
-- -------------------
function generateTex(searchfolder)
	-- add tailing "/" if not present
	if string.sub(searchfolder, -1) ~= "/" then searchfolder = searchfolder.."/" end

	tex.print("\\beginCookbook")
	-- append Preface
	if file_exists(searchfolder.."preface.tex") then tex.print("\\input{"..searchfolder.."preface.tex}") end
	tex.print("\\beginRecipes")
	-- process categories.txt
	if file_exists(searchfolder.."categories.txt") then
		-- k = index, v = content
		for k,v in ipairs(lines_from(searchfolder.."categories.txt")) do
			tex.print("\\category{"..v.."}")
			if file_exists(searchfolder..v) then search_tex(searchfolder..v) end
		end
	end
	-- append Appendices
	if file_exists(searchfolder.."appendices/") then
			tex.print("\\beginAppendices")
			search_tex(searchfolder.."appendices") 
	end
end

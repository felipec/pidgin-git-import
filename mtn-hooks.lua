function unmapped_git_author(author)
   name = author:match("^([^<>]+)@[^<>]+$")
   if name then
      return "Unknown <" .. author .. ">"
   end

   name = author:match("^<([^<>]+)@[^<>]+>$")
   if name then
      return "Unknown " .. author
   end

   name = author:match("^[^<>@]+$")
   if name then
      return name .. " <unknown>"
   end

   return author
end

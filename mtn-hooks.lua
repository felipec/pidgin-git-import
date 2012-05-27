function unmapped_git_author(author)
   name = author:match("^([^<>]+)@[^<>]+$")
   if name then
      return name .. " <" .. author .. ">"
   end

   name = author:match("^<([^<>]+)@[^<>]+>$")
   if name then
      return name .. " " .. author
   end

   name = author:match("^[^<>@]+$")
   if name then
      return name .. " <unknown>"
   end

   return author
end

-- function test(author)
-- 	print(author .. " = " .. unmapped_git_author(author))
-- end
-- 
-- test('John Snow <john@snow.com>')
-- test('John Snow')
-- test('<john@snow.com>')
-- test('john@snow.com')

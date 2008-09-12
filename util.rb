class Dir
  def Dir.push(dir)
    @dir_stack = [] if not @dir_stack
    @dir_stack.push(Dir.pwd)
    Dir.chdir(dir)
  end

  def Dir.pop
    dir = @dir_stack.pop
    Dir.chdir(dir)
  end
end

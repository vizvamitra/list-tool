class String
  def colorize(code)
    "\x1B[#{code}m" + self + "\x1B[0m"
  end
  
  def red; colorize(31); end
  def green; colorize(32); end
  def blue; colorize(34); end
end
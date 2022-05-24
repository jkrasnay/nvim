--echo "Hello, world"
--print("Hello, world 2c")

local function say_hello()
  print("Hello, world 3b")
end

return {
  say_hello = say_hello
}


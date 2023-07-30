-- The things I need to convert
--
-- [[Note]] -> {:Note:}
-- [[Note#^7ef311]] -> {:Note:}
-- [[Note#Heading]] -> {:Note:* Heading}
-- [[Note | text]] -> {:Note:}[text]
-- [[Note#Heading | text]] -> {:Note:*Heading}[text]

local function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

local strings = {
  "[[Note#^7ef311]]",
  "[[Note#Heading]]",
  "[[Note | Text]]",
  "[[Note]]",
}

for _, string in ipairs(strings) do
  local pattern = "%[%[(.-)%]%]"
  local link = string:match(pattern)
  print(string.format("Link to format: '%s'", link))

  local linkToHeading = link:find("#", 1, true)
  linkToHeading = linkToHeading and linkToHeading - 1 or link:len()

  local textBarrier = link:find("#", 1, true)
  textBarrier = textBarrier and textBarrier - 1 or link:len()

  local stop = (linkToHeading or textBarrier)
  local filename = link:sub(0, stop)
  print(filename)
end

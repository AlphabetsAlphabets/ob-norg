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

local function extract_heading(link, index)
  local heading = nil
  local linkToParagraph = link:find("^", 1, true)
  if linkToParagraph == nil then
    heading = trim(link:sub(index + 2, link:len()))
    heading = heading:gsub("#", "*")
    heading = string.format("* %s", heading)
  end

  return heading or ""
end

local strings = {
  "[[Note#^7ef311]]",
  "[[Note#Heading]]",
  "[[Note#Head ing]]",
  "[[Note#Heading ]]",
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

  local heading = extract_heading(link, linkToHeading)
  print(string.format("{:%s:%s}", filename, heading))
end

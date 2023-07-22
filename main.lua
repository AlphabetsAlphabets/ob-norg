-- The things I need to convert
--
-- [[Note]] -> {:Note:}
-- [[Note#^7ef311]] -> {:Note:}
-- [[Note#Heading]] -> {:Note:* Heading}
-- [[Note | text]] -> {:Note:}[text]
-- [[Note#Heading | text]] -> {:Note:*Heading}[text]

local strings = {
  "[[Note]]",
  "[[Note#^7ef311]]",
  "[[Note#Heading]]",
  "[[Note | text]]",
  "[[Note#Heading | text]]",
  "[[Note#Heading|text]]",
  "[[Note#Heading| text]]",
}

-- The links but in norg syntax
local formatted = {}

for _, string in ipairs(strings) do
  local pattern = "%[%[(.-)%]%]"
  local link = string.match(string, pattern)

  -- I'll need to find the proper order of operations for this

  -- Check if there's just a # if it's just this then skip everything else.
  local linkToHeading = string.find(link, "#", 1, true)
  local customText = string.find(link, "|", 1, true)

  local filename = nil
  filename = string.sub(link, 0, (linkToHeading and linkToHeading - 1) or customText)
  if filename == nil then
    filename = link
  end

  if customText ~= nil then
    local leftIsSpace = string.sub(filename, customText - 1, customText - 1) == ' '
    local rightIsSpace = string.sub(filename, customText + 1) == ' '

    if leftIsSpace and rightIsSpace == false then
       filename = string.sub(filename, 0, customText - 2)
    end

  end

  new = "{:" .. filename .. ":}"

  -- check for "#"
  local headingIndex = string.find(link, "#", 1, true)
  if headingIndex ~= nil then
    local heading = string.sub(link, headingIndex)
    print(string.format("Heading: '%s'", heading))
  end

  -- replace the text appropriately.
  -- local new = string.gsub(string, pattern, "REPLACED")
end

for _, v in ipairs(formatted) do
  print(v)
end


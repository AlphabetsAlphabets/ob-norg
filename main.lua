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

for _, string in ipairs(strings) do
  print(string.format("Link to format: '%s'", string))
  local pattern = "%[%[(.-)%]%]"
  local link = string.match(string, pattern)

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

  local new = "{:" .. filename .. ":}"

  -- check for "#"
  local headingIndex = string.find(link, "#", 1, true)
  if headingIndex ~= nil then
    local heading = string.sub(link, headingIndex)
    -- Do a check for ^ to the right if there is a ^ to the right
    -- I can safely discard it and exit out of this if statement.
    print(string.format("Heading: '%s'", heading))
  end

  print(string.format("Result: '%s'\n", new))
end

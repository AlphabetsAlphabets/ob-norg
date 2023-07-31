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

local function extract_custom_text(heading)
  local custom_text = nil
  local textBarrier = heading:find("|", 1, true)
  if textBarrier == nil then
    return heading
  end

  custom_text = trim(heading:sub(textBarrier + 1))
  heading = trim(heading:sub(0, textBarrier - 1))

  return heading, custom_text
end

-- After a file name links always start with # or |
local function extract_heading(link)
  local heading = nil

  local linkToHeading = link:find("#", 1, true)
  if linkToHeading ~= nil then
    linkToHeading = linkToHeading - 1
  else
    linkToHeading = link:len()
  end

  -- If there's a # there's a chance for a ^
  local linkToParagraph = link:find("^", 1, true)
  if linkToParagraph ~= nil then
    return nil
  end

  local custom_text = nil
  heading = link:sub(linkToHeading + 1, link:len())
  heading, custom_text = extract_custom_text(heading)
  heading = heading:gsub("#", "* ")
  heading = string.format("%s", heading)

  return heading, custom_text
end


local function extract_filename(link)
  local filename = nil

  local heading = link:find("#", 1, true)
  if heading ~= nil then
    filename = trim(link:sub(0, heading - 1))
  end

  return filename
end

local strings = {
  "[[Note | text]]",
  "[[Note#Heading | t ext]]",
  "[[Note#Hea ding |   t ext   ]]",
  -- Not handled "[[Note#^123123 | t ext]]",
}

for _, string in ipairs(strings) do
  local pattern = "%[%[(.-)%]%]"
  local link = string:match(pattern)
  print(string.format("Link to format: '%s'", string))

  local filename = nil
  local heading = nil
  local custom_text = nil

  filename = extract_filename(link)
  heading, custom_text = extract_heading(link)

  print(string.format("Filename: '%s', Heading: '%s', custom text: '%s'\n", filename, heading, custom_text))
end

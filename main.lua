-- The things I need to convert
--
-- [[101 Matrix identities]] -> {* 101 Matrix identities}
-- [[101 Matrix identities#^7ef311]] -> {* 101 Matrix identities}
-- [[101 Matrix identities#101 Matrix Identities | Hello]] -> {:101 Matrix identities:* 101 Matrix Identities}[Hello]
-- [[101 Matrix identities#101 Matrix Identities]] -> {:101 Matrix identities:* 101 Matrix Identities}

local strings = {
  "[[101 Matrix identities]]",
  "[[101 Matrix identities#^7ef311]]",
  "[[101 Matrix identities#101 Matrix Identities]]",
  "[[101 Matrix identities#101 Matrix Identities | Hello   ]]",
}

-- The links but in norg syntax
local formatted = {}

for _, string in ipairs(strings) do
  local pattern = "%[%[(.-)%]%]"
  local link = string.match(string, pattern)

  -- I'll need to find the proper order of operations for this

  -- Check if there's just a # if it's just this then skip everything else.
  local linkToHeading = string.find(link, "#", 1, true)
  if linkToHeading ~= nil then
    local filename = string.sub(link, 0, linkToHeading - 1)
    local heading = string.sub(link, linkToHeading + 1)
    local new = "{:" .. filename .. ":* " .. heading .. "}"
    table.insert(formatted, new)
  end

  -- Check if there is a ^

  -- Check if there is a |
  local customTextbarrier = string.find(link, "|", 1, true)
  if customTextbarrier ~= nil then
    local customText = string.sub(link, customTextbarrier + 1)
    -- {:test:}[ sup] this breaks and isn't counted as a link.
    -- Which is why the whitespace is trimmed off
    customText = customText:gsub("^%s*(.-)%s*$", "%1")
    print(customText)
  end

  -- replace the text appropriately.
  -- local new = string.gsub(string, pattern, "REPLACED")
end

for _, v in ipairs(formatted) do
  print(v)
end


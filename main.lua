-- [[102 Data#Data | tabular data]]

function Link(elem)
  return pandoc.Str("link")
end

return {
  { Link = Link }
}

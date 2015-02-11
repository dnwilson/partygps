FIRST   = "First"
SECOND  = "Second"
THIRD   = "Third"
FOURTH  = "Fourth"
LAST    = "Last"
OTHER   = "Other"

OCCURRENCE = [FIRST, SECOND, THIRD, FOURTH, LAST, OTHER]
DAYNAMES   = Date::DAYNAMES.map{|m| m = m + "s"}
MONTHNAMES = Date::MONTHNAMES.compact.map{|m| m unless m.nil?}
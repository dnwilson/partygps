FIRST   = "First"
SECOND  = "Second"
THIRD   = "Third"
FOURTH  = "Fourth"
LAST    = "Last"
OTHER   = "Every Other"
EVERY   = "Every"

REG     = "Regular"
WEEKLY  = "Weekly"
MONTHLY = "Monthly"
ANNUAL  = "Annual"

EVENT_TYPE = [REG, WEEKLY, MONTHLY, ANNUAL]
OCCURRENCE = [FIRST, SECOND, THIRD, FOURTH, LAST, OTHER]
DAYNAMES   = Date::DAYNAMES
DAYS       = {  sunday:    0,
                monday:    1,
                tuesday:   2,
                wednesday: 3,
                thursday:  4,
                friday:    5,
                saturday:  6
              }
MONTHNAMES = Date::MONTHNAMES.compact.map{|m| m unless m.nil?}
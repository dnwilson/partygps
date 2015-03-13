FIRST   = "First"
SECOND  = "Second"
THIRD   = "Third"
FOURTH  = "Fourth"
LAST    = "Last"
OTHER   = "Other"
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
LISTED_ORDER = {
                every:  0, 
                first:  1, 
                second: 2, 
                third:  3, 
                fourth: 4, 
                last:   5, 
                other:  6
              }

MONTHNAMES = Date::MONTHNAMES.compact.map{|m| m unless m.nil?}
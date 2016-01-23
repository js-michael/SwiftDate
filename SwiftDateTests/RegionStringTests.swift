//
//  SwiftDateTests.swift
//  SwiftDateTests
//
//  Created by Daniele Margutti on 23/11/15.
//  Copyright © 2015 Daniele Margutti. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftDate

class DateRegionStringSpec: QuickSpec {
    
    override func spec() {
        
        describe("NSDate extension") {
            
            let utc = Region(calendarName: .Gregorian, timeZoneName: .Gmt, localeName: .English)

            context("toString UTC") {
                
                let utcDate = DateInRegion(year: 2015, month: 4, day: 13, hour: 22, minute: 10, region: utc)!
                
                it("should return proper ISO 8601 string") {
                    expect(utcDate.toString(DateFormat.ISO8601)) == "2015-04-13T22:10:00+0000"
                }
                
                it("should return proper ISO 8601 date string") {
                    expect(utcDate.toString(DateFormat.ISO8601Date)) == "2015-04-13"
                }
                
                it("should return proper Alt RSS date string") {
                    expect(utcDate.toString(DateFormat.AltRSS)) == "13 Apr 2015 22:10:00 +0000"
                }
                
                it("should return proper RSS date string") {
                    expect(utcDate.toString(DateFormat.RSS)) == "Mon, 13 Apr 2015 22:10:00 +0000"
                }
                
                it("should return proper custom date string") {
                    expect(utcDate.toString(DateFormat.Custom("d MMM YY 'at' HH:mm"))) == "13 Apr 15 at 22:10"
                }
                
                it("should return proper custom date string") {
                    expect(utcDate.toString(DateFormat.Custom("eee d MMM YYYY, m 'minutes after' HH '(timezone is' Z')'"))) == "Mon 13 Apr 2015, 10 minutes after 22 (timezone is +0000)"
                }
            }
            
            context("toString local") {

                let date = NSDate(year: 2015, month: 4, day: 13, hour: 22, minute: 10)!
                let localDate = date.inRegion()

                it("should return proper ISO 8601 string") {
                    expect(localDate.toString(DateFormat.ISO8601)!.hasPrefix("2015-04-13T22:10:00"))
                    expect(date.toString(DateFormat.ISO8601)!.hasPrefix("2015-04-13T22:10:00"))
                }

                it("should return proper ISO 8601 date string") {
                    expect(localDate.toString(DateFormat.ISO8601Date)) == "2015-04-13"
                    expect(date.toString(DateFormat.ISO8601Date)) == "2015-04-13"
                }

                it("should return proper Alt RSS date string") {
                    expect(localDate.toString(DateFormat.AltRSS)!.hasPrefix("13 Apr 2015 22:10:00"))
                    expect(date.toString(DateFormat.AltRSS)!.hasPrefix("13 Apr 2015 22:10:00"))
                }

                it("should return proper RSS date string") {
                    expect(localDate.toString(DateFormat.RSS)!.hasPrefix("Mon, 13 Apr 2015 22:10:00"))
                    expect(date.toString(DateFormat.RSS)!.hasPrefix("Mon, 13 Apr 2015 22:10:00"))
                }

                it("should return proper custom date string") {
                    expect(localDate.toString(DateFormat.Custom("d MMM YY 'at' HH:mm"))) == "13 Apr 15 at 22:10"
                    expect(date.toString(DateFormat.Custom("d MMM YY 'at' HH:mm"))) == "13 Apr 15 at 22:10"
                }

                it("should return proper custom date string") {
                    expect(localDate.toString(DateFormat.Custom("eee d MMM YYYY, m 'minutes after' HH '(timezone is' Z')'"))!.hasPrefix("Mon 13 Apr 2015, 10 minutes after 22 (timezone is "))
                    expect(date.toString(DateFormat.Custom("eee d MMM YYYY, m 'minutes after' HH '(timezone is' Z')'"))!.hasPrefix("Mon 13 Apr 2015, 10 minutes after 22 (timezone is "))
                }
            }
        }
    }
}


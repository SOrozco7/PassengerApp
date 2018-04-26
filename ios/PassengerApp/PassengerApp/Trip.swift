//
//  Trip.swift
//  PassengerApp
//
//  Created by Comonfort on 4/16/18.
//  Copyright © 2018 Comonfort. All rights reserved.
//

import UIKit
import os.log

class Trip: NSObject, NSCoding, Codable{
	
    //MARK: Properties
    
    var alarmName: String			//Name of the trip
    var repetitionDays = [Bool]()	//Days of the week that it should be repeated
    var departureTime: String		//Time of day the trip is to be initiated
    var alarmDate: Date				//The day the alarm was set (only important if the trip does not repeat
    var active: Bool				//Whether the trip is active (should present notifications or not)
	
	
	//MARK: Archiving Paths
	
	//URL to save app data
	static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
	//append "trips" to path
	static let ArchiveURL = DocumentsDirectory.appendingPathComponent("trips")
	
	//MARK: Types
	
	//Will store the key named for this class' fields
	struct PropertyKey {
		static let alarmName = "alarmName"
		static let repetitionDays = "repetitionDays"
		static let departureTime = "departureTime"
		static let alarmDate = "alarmDate"
		static let active = "active"
	}
	
    //MARK: Initialization
    
    init?(alarmName: String, repetitionDays: [Bool], departureTime: String, alarmDate: Date, active: Bool) {
		
        if alarmName.isEmpty || repetitionDays.count < 7 || departureTime.isEmpty
        {
            return nil
        }
        
        self.alarmName = alarmName
        self.repetitionDays = repetitionDays
        self.departureTime = departureTime
        self.alarmDate = alarmDate
        self.active = active
    }
	
	//MARK: NSCoding
	
	//Encodes this trip's data with NSCoder protocol
	func encode(with aCoder: NSCoder) {
		aCoder.encode(alarmName, forKey: PropertyKey.alarmName)
		aCoder.encode(repetitionDays, forKey: PropertyKey.repetitionDays)
		aCoder.encode(departureTime, forKey: PropertyKey.departureTime)
		aCoder.encode(alarmDate, forKey: PropertyKey.alarmDate)
		aCoder.encode(active, forKey: PropertyKey.active)

	}
	
	//The required modifier means this initializer must be implemented on every subclass
	//The convenience modifier means that this is a secondary initializer, and that it must call a designated initializer from the same class
	
	//Retrieves data for a trip with NSCoder
	required convenience init?(coder aDecoder: NSCoder) {
		
		// Required fields, if they fail to load the object shouldn't be constructed
		guard let alarmName = aDecoder.decodeObject(forKey: PropertyKey.alarmName) as? String 
			else {
			os_log("Unable to decode the name for a Trip object.", log: OSLog.default, type: .debug)
			return nil
		}
		guard let departureTime = aDecoder.decodeObject(forKey: PropertyKey.departureTime) as? String
			else {
				os_log("Unable to decode the departure time for a Trip object.", log: OSLog.default, type: .debug)
				return nil
		}
		guard let repetitionDays = aDecoder.decodeObject(forKey: PropertyKey.repetitionDays) as? [Bool], repetitionDays.count == 7
			else {
				os_log("Unable to decode the repetition days for a Trip object.", log: OSLog.default, type: .debug)
				return nil
		}
		
		guard let alarmDate = aDecoder.decodeObject(forKey: PropertyKey.alarmDate) as? Date
			else {
				os_log("Unable to decode the alarm date for a Trip object.", log: OSLog.default, type: .debug)
				return nil
		}
		
		let active = aDecoder.decodeBool(forKey: PropertyKey.active)

		self.init(alarmName: alarmName, repetitionDays: repetitionDays, departureTime: departureTime, alarmDate: alarmDate, active: active)
		
	}
}

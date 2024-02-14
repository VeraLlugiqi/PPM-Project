//
//  DBHelper.swift
//  Write
//
//  Created by Desara Qerimi on 8.2.24.
//  Copyright © 2024 FIEK. All rights reserved.
//

import Foundation
import SQLite3

class DBHelper{
    static func getDatabasePointer(databaseName: String) -> OpaquePointer?{
        
        var databasePointer: OpaquePointer?
        
        let documentDatabasePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(databaseName).path
        
        if FileManager.default.fileExists(atPath: documentDatabasePath){
            print("Database already exists")
        }
        else{
            guard let bundleDatabasePath = Bundle.main.resourceURL?.appendingPathComponent(databaseName).path else{
                print("Database path does not exist")
                return nil
            }
            do {
                try FileManager.default.copyItem(atPath: bundleDatabasePath, toPath: documentDatabasePath)
                print("Database copy created")
            }catch{
                print("Error")
                return nil
            }
        }
        
        if sqlite3_open(documentDatabasePath, &databasePointer) == SQLITE_OK {
            print("Connected to database")
        }
        else{
            print("Error connecting to database")
        }
        
        
        
        return databasePointer
        
    }
    
}

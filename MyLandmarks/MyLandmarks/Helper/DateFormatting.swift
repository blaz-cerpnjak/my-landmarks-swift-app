//
//  DateFormatting.swift
//  MyLandmarks
//
//  Created by Blaž Čerpnjak on 11/09/2022.
//

import Foundation

func formatDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "dd.MM.yyyy, HH:ss"
    
    let formattedDate = dateFormatter.string(from: date)
    
    return formattedDate
}

//
//  BackupModel.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.04.24.
//

import Foundation
import Storage


enum BackupErrors: Error {
    case notSupportedBackupType
}

struct BackupModel: Codable {
    
    private enum Const {
        static let date = "date"
        static let timer = "timer"
        static let location = "location"
    }
    
    let dto: any DTODescription
    
    enum CodingKeys: CodingKey {
        //main attribudes
        case id
        case date
        case title
        case subtitle
        case completedDate
        case type
        //date and timer attributes
        case targetDate
        //location attributes
        case mapCenterLatitude
        case mapCenterLongitude
        case mapSpanLatitude
        case mapSpanLongitude
        case circularRadius
        case repeats
        case notifyOnEntry
        case notifyOnExit
    }
    
    init(dto: any DTODescription) {
        self.dto = dto
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        //main
        let id = try container.decode(String.self, forKey: .id)
        let dateTimeInterval = try container.decode(Double.self, forKey: .date)
        let title = try container.decode(String.self, forKey: .title)
        let subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle)
        let compltedDateTimeInterval = try container.decodeIfPresent(Double.self, forKey: .completedDate)
        
        if type == Const.date {
            let targetDateTimeInterval = try container.decode(Double.self, forKey: .targetDate)
        
            let dateDTO = DateNotificationDTO(
                date: Date(timeIntervalSince1970: dateTimeInterval),
                id: id,
                title: title,
                subtitle: subtitle,
                completedDate: Date(compltedDateTimeInterval),
                targetDate: Date(timeIntervalSince1970: targetDateTimeInterval))
            self.dto = dateDTO
            return
        } else if type == Const.timer {
            let targetDateTimeInterval = try container.decode(Double.self, forKey: .targetDate)
            
            let timerDTO = DateNotificationDTO(
                date: Date(timeIntervalSince1970: dateTimeInterval),
                id: id,
                title: title,
                subtitle: subtitle,
                completedDate: Date(compltedDateTimeInterval),
                targetDate: Date(timeIntervalSince1970: targetDateTimeInterval))
            self.dto = timerDTO
            return
        } else if type == Const.location {
            let mapCenterLatitude = try container.decode(Double.self, forKey: .mapCenterLatitude)
            let mapCenterLongitude = try container.decode(Double.self, forKey: .mapCenterLongitude)
            let mapSpanLatitude = try container.decode(Double.self, forKey: .mapSpanLatitude)
            let mapSpanLongitude = try container.decode(Double.self, forKey: .mapSpanLongitude)
            let circularRadius = try container.decode(Double.self, forKey: .circularRadius)
            let repeats = try container.decode(Bool.self, forKey: .repeats)
            let notifyOnEntry = try container.decode(Bool.self, forKey: .notifyOnEntry)
            let notifyOnExit = try container.decode(Bool.self, forKey: .notifyOnExit)
            
            let locationDTO = LocationNotificationDTO(
                date: Date(timeIntervalSince1970: dateTimeInterval),
                id: id,
                title: title,
                subtitle: subtitle,
                completedDate: Date(compltedDateTimeInterval),
                mapCenterLatitude: mapCenterLatitude,
                mapCenterLongitude: mapCenterLongitude,
                mapSpanLatitude: mapSpanLatitude,
                mapSpanLongitude: mapSpanLongitude,
                circularRadius: circularRadius,
                repeats: repeats,
                notifyOnEntry: notifyOnEntry,
                notifyOnExit: notifyOnExit)
            self.dto = locationDTO
            return
        }
        //TODO: Log error
        throw BackupErrors.notSupportedBackupType
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        //main
        try container.encode(dto.id, forKey: .id)
        try container.encode(dto.date.timeIntervalSince1970, forKey: .date)
        try container.encode(dto.title, forKey: .title)
        try container.encode(dto.subtitle, forKey: .subtitle)
        if let completedDate = dto.completedDate {
            try container.encode(
                completedDate.timeIntervalSince1970,
                forKey: .completedDate)
        }
        
        //date and timer
        if let dateDTO = dto as? DateNotificationDTO {
            try container.encode(dateDTO.targetDate.timeIntervalSince1970, forKey: .targetDate)
            try container.encode(Const.date, forKey: .type)
        } else if let timerDTO = dto as? TimerNotificationDTO {
            try container.encode(timerDTO.targetDate.timeIntervalSince1970, forKey: .targetDate)
            try container.encode(Const.timer, forKey: .type)
            
        } else if let locationDTO = dto as? LocationNotificationDTO {
            try container.encode(Const.location, forKey: .type)
            try container.encode(locationDTO.mapCenterLatitude, forKey: .mapCenterLatitude)
            try container.encode(locationDTO.mapCenterLongitude, forKey: .mapCenterLongitude)
            try container.encode(locationDTO.mapSpanLatitude, forKey: .mapSpanLatitude)
            try container.encode(locationDTO.mapSpanLongitude, forKey: .mapSpanLongitude)
            try container.encode(locationDTO.circularRadius, forKey: .circularRadius)
            try container.encode(locationDTO.repeats, forKey: .repeats)
            try container.encode(locationDTO.notifyOnEntry, forKey: .notifyOnEntry)
            try container.encode(locationDTO.notifyOnExit, forKey: .notifyOnExit)
        }
    }
    
    func buildDict() -> [String: Any]? {
        guard
            let data = try? JSONEncoder().encode(self),
            let dict = try? JSONSerialization.jsonObject(
                with: data,
                options: .fragmentsAllowed)
        else { return nil }
        
        return dict as? [String: Any]
    }
}

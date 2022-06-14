//
//  AppReducer.swift
//  circle-clock (iOS)
//
//  Created by Wei Lun Hsu on 2022/6/14.
//

import Foundation
import ComposableArchitecture

struct SearchState: Equatable {
    var timeZones: [String]
}

struct ClockState: Equatable {
    var timeZone: String
    var hour: Int
    var minute: Int
    var second: Int
}

struct TimeZoneState: Equatable {
    var clockState: ClockState = .init(timeZone: "Asia/Taipei", hour: 0, minute: 0, second: 0)
    var searchState: SearchState = .init(timeZones: TimeZone.knownTimeZoneIdentifiers)
}

enum TimeZoneAction {
    case choose(timeZone: String)
    case currentTime(hour: Int, minute: Int, second: Int)
    case query(text: String)
}

struct TimeZoneEnvironment { }

let timeZonerReducer = Reducer<TimeZoneState, TimeZoneAction, TimeZoneEnvironment> { state, action, environemnt in
    switch action {
    case .choose(let timeZone):
        state.clockState.timeZone = timeZone
        return .none
    case .currentTime(let h, let m, let s):
        state.clockState.hour = h
        state.clockState.minute = m
        state.clockState.second = s
        return .none
    case .query(let text):
        state.searchState.timeZones = text.isEmpty ?
        TimeZone.knownTimeZoneIdentifiers :
        TimeZone.knownTimeZoneIdentifiers.filter { $0.contains(text) }
        return .none
    }
}

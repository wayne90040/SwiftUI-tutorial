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
    case start
    /// Effect
    case update
}

struct TimeZoneEnvironment {
    var date: () -> Date
    var mainQueue: AnySchedulerOf<DispatchQueue>
    
    static var live: TimeZoneEnvironment {
        .init(date: Date.init, mainQueue: .main)
    }
}

let timeZonerReducer = Reducer<TimeZoneState, TimeZoneAction, TimeZoneEnvironment> { state, action, environemnt in
    struct TimerId: Hashable {}
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
    case .start:
        return Effect.timer(
              id: TimerId(),
              every: .milliseconds(1000),
              tolerance: .zero,
              on: environemnt.mainQueue
            ).map { time -> TimeZoneAction in
                return TimeZoneAction.update
            }
    /// Effect from start
    case .update:
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: state.clockState.timeZone) ?? TimeZone.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: Date())
        state.clockState.hour = components.hour ?? 0
        state.clockState.minute = components.minute ?? 0
        state.clockState.second = components.second ?? 0
        return .none
    }
}

//
//  ClockWidget.swift
//  ClockWidget
//
//  Created by Wei Lun Hsu on 2022/6/7.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        .init(
            date: Date(),
            timeZone: "Asia/Taipei",
            hour: 0,
            minute: 0,
            second: 0,
            configuration: ConfigurationIntent()
        )
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        completion(.init(
            date: Date(),
            timeZone: "Asia/Taipei",
            hour: 0,
            minute: 0,
            second: 0,
            configuration: configuration
        )
        )
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        print("Do getTimerline")
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        
        let refresh = Calendar.current.date(byAdding: .minute, value: 10, to: currentDate) ?? Date()
    
        for i in 0 ... 600 {
            var calendar = Calendar.current
            calendar.timeZone = .init(identifier: "Asia/Taipei") ?? .current
//            let dateComponents = calendar.dateComponents([.hour, .minute, .second], from: currentDate)
            
            let entryDate = Calendar.current.date(byAdding: .second, value: i, to: currentDate)!
            let dateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: entryDate)
            
            entries.append(
                .init(
                    date: entryDate,
                    timeZone: "Asia/Taipei",
                    hour: dateComponents.hour ?? 0,
                    minute: dateComponents.minute ?? 0,
                    second: dateComponents.second ?? 0,
                    configuration: configuration
                )
            )
        }
        completion(.init(entries: entries, policy: .after(refresh)))
    }
}

struct SimpleEntry: TimelineEntry {
    
    let date: Date
    
    var timeZone: String
    
    var hour: Int
    
    var minute: Int
    
    var second: Int
    
    let configuration: ConfigurationIntent
    
}


// MARK: - EntryView
struct ClockWidgetEntryView : View {
    
//        var entry: Provider.Entry
    
    var entry: SimpleEntry
    
    @Environment(\.widgetFamily) var family
    
//    var body: some View {
//        VStack {
//
//            Text(entry.hour.description)
//            Text(entry.minute.description)
//            Text(entry.second.description)
//            Text(entry.date.description)
//        }
//    }
    
    
    // 不知道為啥 Widget 指針不會動
    var body: some View {

        switch family {

        case .systemSmall:
            RoundClock(hour: 0, minute: 0, second: 0)
                .roundClockStyle(SmallRoundClockStyle())

        case .systemMedium:
            MediumWidget()

        case .systemLarge:
            LargeWidget()

        case .systemExtraLarge:
            Text("Extra Large mode")

        @unknown default:
            fatalError()
        }
    }
}

@main
struct ClockWidget: Widget {
    let kind: String = "ClockWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            ClockWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Clock Widget")
        .description("This is an example widget.")
    }
}

//struct ClockWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        ClockWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}

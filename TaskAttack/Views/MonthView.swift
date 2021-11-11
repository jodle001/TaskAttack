//
//  MonthView.swift
//  TaskAttack
//
//  Created by Jacob Odle on 10/14/21.
//

import SwiftUI

fileprivate extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }

    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}

fileprivate extension Calendar {
    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)

        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }

        return dates
    }
}

struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    @ObservedObject var monthVM = MonthViewModel();
    @State var showDay = false;

//    let interval: DateInterval
    let showHeaders: Bool
    let content: (Date) -> DateView

    init(
//        interval: DateInterval = monthVM.month,
        showHeaders: Bool = true,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
//        self.interval = interval
        self.showHeaders = showHeaders
        self.content = content
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                ForEach(months, id: \.self) { month in
                    Section(header: header(for: month)) {
                        ForEach(days(for: month), id: \.self) { date in
                            if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                                content(date).id(date)
                                    .onTapGesture {
                                        print(date.get(.day))
                                        showDay.toggle()
                                    }
                            } else {
                                content(date).hidden()
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showDay) {
            DayView()
        }
    }

    private var months: [Date] {
        calendar.generateDates(
//            inside: interval,
            inside: monthVM.month,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }

    private func header(for month: Date) -> some View {
        let component = calendar.component(.month, from: month)
        let formatter = component == 1 ? DateFormatter.monthAndYear : .monthAndYear

        return Group {
            if showHeaders {
                HStack {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding(3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color("DayIcons"), lineWidth: 2)
                                )
                        .foregroundColor(Color("DayIconNumber"))
                        .onTapGesture {
                            monthVM.adjustMonth(number: -1);
                            print("leftArrow");
                        }
                    Spacer()
                    Text(formatter.string(from: month))
                        .font(.title)
                        .padding()
                        .foregroundColor(Color("DayIconNumber"))
                    Spacer()
                    Image(systemName: "arrow.right")
                        .font(.title)
                        .frame(width: 35, height: 35, alignment: .center)
                        .padding(3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color("DayIcons"), lineWidth: 2)
                                )
                        .foregroundColor(Color("DayIconNumber"))
                        .onTapGesture {
                            monthVM.adjustMonth(number: 1);
                            print("rightArrow");
                        }
                }
                .padding(.horizontal)
            }
        }
    }

    private func days(for month: Date) -> [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month),
            let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
            let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end)
        else { return [] }
        return calendar.generateDates(
            inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end),
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView() { _ in
            Text("30")
                .padding(8)
                .background(Color.gray)
                .cornerRadius(8)
        }
    }
}

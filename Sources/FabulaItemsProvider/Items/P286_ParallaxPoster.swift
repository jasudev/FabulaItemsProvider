//
//  P286_ParallaxPoster.swift
//  FabulaItemsProvider
//
//  Created by jasu on 7/20/25.
//  Copyright (c) 2025 jasu All rights reserved.
//

import SwiftUI

public struct P286_ParallaxPoster: View {
    @State private var scrollOffset: CGFloat = 0
    @State private var selectedActivity: Int? = nil

    private let activities = [
        ActivityItem(
            id: 0,
            time: "22:10",
            title: "Sleep",
            icon: "moon.fill",
            color: Color(hex: "#007AFF"),
            details: nil
        ),
        ActivityItem(
            id: 1,
            time: "05:05",
            title: "Wake Up",
            icon: "sun.max.fill",
            color: Color(hex: "#FFD700"),
            details: nil
        ),
        ActivityItem(
            id: 2,
            time: "06:25",
            title: "Checked in on Benji",
            icon: "checkmark",
            color: Color(hex: "#00C781"),
            details: nil
        ),
        ActivityItem(
            id: 3,
            time: "06:30",
            title: "Walk 7.5K",
            icon: "figure.walk",
            color: Color(hex: "#5AC8FA"),
            details: ActivityDetails(
                subtitle: "1 hr 20 mins",
                items: []
            )
        ),
        ActivityItem(
            id: 4,
            time: "08:30",
            title: "Back etc.",
            icon: "dumbbell.fill",
            color: Color(hex: "#8E8E93"),
            details: ActivityDetails(
                subtitle: "30 mins",
                items: [
                    WorkoutItem(name: "3 x Chin-Up", reps: "19 total reps"),
                    WorkoutItem(name: "1 x Farmer walk 2 hands", reps: "1 total reps"),
                    WorkoutItem(name: "4 x Dumbbell Row", reps: "42 total reps"),
                    WorkoutItem(name: "2 x Pull-Up", reps: "10 total reps"),
                    WorkoutItem(name: "3 x Plank and move kettlebell", reps: "30 total reps"),
                    WorkoutItem(name: "2 x Ab roll thingie", reps: "20 total reps"),
                    WorkoutItem(name: "2 x Push-Up", reps: "20 total reps")
                ]
            )
        ),
        ActivityItem(
            id: 5,
            time: "09:05",
            title: "Infrared sauna",
            icon: "thermometer.sun.fill",
            color: Color(hex: "#FF3B30"),
            details: ActivityDetails(
                subtitle: "10 mins",
                items: []
            )
        ),
        ActivityItem(
            id: 6,
            time: "09:10",
            title: "Cold shower",
            icon: "snowflake",
            color: Color(hex: "#5AC8FA"),
            details: ActivityDetails(
                subtitle: "5 mins",
                items: []
            )
        ),
        ActivityItem(
            id: 7,
            time: "10:09",
            title: "Athletic Greens + collagen + vitamin k + 5 mg creatine",
            icon: "leaf.fill",
            color: Color(hex: "#A6F240"),
            details: ActivityDetails(
                subtitle: "140 kcal",
                items: [
                    WorkoutItem(name: "P", reps: "15g"),
                    WorkoutItem(name: "C", reps: "10g"),
                    WorkoutItem(name: "F", reps: "3g")
                ]
            )
        )
    ]

    public init() {}

    public var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#1C1C1E"), Color(hex: "#2C2C2E")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(activities, id: \.id) { activity in
                        ActivityRow(
                            activity: activity,
                            isSelected: selectedActivity == activity.id,
                            scrollOffset: scrollOffset,
                            isLast: activity.id == activities.count - 1
                        )
                        .onTapGesture {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                selectedActivity = selectedActivity == activity.id ? nil : activity.id
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
                .background(
                    GeometryReader { geometry in
                        Color.clear
                            .preference(
                                key: ScrollOffsetPreferenceKey.self,
                                value: geometry.frame(in: .named("scroll")).minY
                            )
                    }
                )
            }
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                scrollOffset = value
            }
        }
    }
}

// MARK: - 모델
fileprivate struct ActivityItem {
    let id: Int
    let time: String
    let title: String
    let icon: String
    let color: Color
    let details: ActivityDetails?
}

fileprivate struct ActivityDetails {
    let subtitle: String
    let items: [WorkoutItem]
}

fileprivate struct WorkoutItem {
    let name: String
    let reps: String
}

// MARK: - 각 항목 Row
fileprivate struct ActivityRow: View {
    let activity: ActivityItem
    let isSelected: Bool
    let scrollOffset: CGFloat
    let isLast: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            // 시간 및 아이콘 (왼쪽 타임라인)
            VStack(alignment: .center, spacing: 0) {
                // 시간
                Text(activity.time)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.gray)
                    .padding(.bottom, 8)

                // 아이콘
                ZStack {
                    Circle()
                        .fill(activity.color)
                        .frame(width: 32, height: 32)
                        .scaleEffect(isSelected ? 1.1 : 1.0)
                        .shadow(color: activity.color.opacity(0.3), radius: isSelected ? 6 : 3)

                    Image(systemName: activity.icon)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(isSelected ? 360 : 0))
                }
                .animation(.spring(response: 0.5, dampingFraction: 0.6), value: isSelected)

                // 연결선 (마지막 항목이 아닌 경우)
                if !isLast {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 2)
                        .animation(.easeInOut(duration: 0.3), value: isSelected)
                }
            }
            .padding(.trailing, 16)

            // 컨텐츠 영역
            VStack(alignment: .leading, spacing: 0) {
                // 메인 카드
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(activity.title)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        
                        if activity.details != nil {
                            Button(action: {}) {
                                Image(systemName: "ellipsis")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14))
                            }
                        }
                    }

                    if let details = activity.details {
                        Text(details.subtitle)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)

                        // 확장 컨텐츠 (선택된 경우)
                        if isSelected && !details.items.isEmpty {
                            VStack(alignment: .leading, spacing: 4) {
                                ForEach(details.items.indices, id: \.self) { index in
                                    let item = details.items[index]
                                    HStack {
                                        if activity.id == 7 { // Athletic Greens 항목
                                            // 영양소 표시
                                            HStack(spacing: 4) {
                                                Circle()
                                                    .fill(getCircleColor(for: item.name))
                                                    .frame(width: 16, height: 16)
                                                    .overlay(
                                                        Text(item.name)
                                                            .font(.system(size: 10, weight: .bold))
                                                            .foregroundColor(.white)
                                                    )
                                                Text(item.reps)
                                                    .font(.system(size: 13))
                                                    .foregroundColor(.gray)
                                            }
                                        } else {
                                            // 운동 아이템 표시
                                            Text(item.name)
                                                .font(.system(size: 13))
                                                .foregroundColor(.white)
                                            Spacer()
                                            Text(item.reps)
                                                .font(.system(size: 13))
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                            }
                            .padding(.top, 8)
                            .transition(.opacity.combined(with: .scale(scale: 0.95, anchor: .top)))
                        }
                    }
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(hex: "#2C2C2E"))
                        .shadow(color: .black.opacity(0.3), radius: isSelected ? 8 : 2)
                )
                .scaleEffect(isSelected ? 1.02 : 1.0)
                .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isSelected)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.bottom, 16)
    }
    
    private func getCircleColor(for nutrient: String) -> Color {
        switch nutrient {
        case "P": return Color(hex: "#007AFF") // 파란색 - 단백질
        case "C": return Color(hex: "#00C781") // 초록색 - 탄수화물
        case "F": return Color(hex: "#FFD700") // 노란색 - 지방
        default: return Color.gray
        }
    }
}

// MARK: - Scroll 위치 감지
fileprivate struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    P286_ParallaxPoster()
}

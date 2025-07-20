//
//  P285_FinancialCard.swift
//  FabulaItemsProvider
//
//  Created by jasu on 7/20/25.
//  Copyright (c) 2025 jasu All rights reserved.
//

import SwiftUI

public struct P285_FinancialCard: View {
    public init() {}

    @State private var animateProgress = false
    @State private var selectedBar: Int? = nil

    public var body: some View {
        ZStack {
            Color.black.opacity(0.9)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                FinancialCardView(
                    animateProgress: $animateProgress,
                    selectedBar: $selectedBar
                )
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5)) {
                animateProgress = true
            }
        }
    }
}

fileprivate struct FinancialCardView: View {
    @Binding var animateProgress: Bool
    @Binding var selectedBar: Int?

    private let barHeights: [CGFloat] = [15, 25, 35, 40, 30, 20, 38, 28]
    private let barColors: [Color] = [
        .gray.opacity(0.4), .gray.opacity(0.4),
        Color(red: 1.0, green: 0.435, blue: 0.262), // 주황색
        Color(red: 1.0, green: 0.435, blue: 0.262),
        Color(red: 1.0, green: 0.435, blue: 0.262),
        .gray.opacity(0.4), .gray.opacity(0.4), .gray.opacity(0.4)
    ]

    var body: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(Color.white.opacity(0.08))
            .frame(height: 240)
            .overlay(
                VStack(alignment: .leading, spacing: 16) {
                    // 금액
                    Text("$21,353.88")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .opacity(animateProgress ? 1 : 0)
                        .animation(.easeOut(duration: 0.8).delay(0.2), value: animateProgress)

                    // 태그
                    HStack(spacing: 8) {
                        TagView(text: "+$2,567.12")
                        TagView(text: "UNLOCKS JAN 21")
                    }
                    .opacity(animateProgress ? 1 : 0)
                    .animation(.easeOut(duration: 0.8).delay(0.4), value: animateProgress)

                    Spacer()

                    // 차트
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Expected")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.gray)

                            Spacer()

                            Text("$24,000")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.white)
                        }

                        HStack(alignment: .bottom, spacing: 4) {
                            ForEach(0..<8, id: \.self) { index in
                                BarView(
                                    height: barHeights[index],
                                    color: barColors[index],
                                    isSelected: selectedBar == index,
                                    animateProgress: animateProgress,
                                    delay: Double(index) * 0.1
                                )
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.4)) {
                                        selectedBar = selectedBar == index ? nil : index
                                    }
                                }
                            }
                        }
                        .frame(height: 40)
                    }
                    .opacity(animateProgress ? 1 : 0)
                    .animation(.easeOut(duration: 0.8).delay(0.6), value: animateProgress)
                }
                .padding(24)
            )
            .padding(.horizontal)
    }
}

fileprivate struct TagView: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.system(size: 11, weight: .semibold))
            .foregroundColor(
                text.contains("+")
                ? Color(red: 0.345, green: 0.784, blue: 0.188) // 녹색
                : Color(red: 1.0, green: 0.408, blue: 0.2)     // 주황색
            )
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.1))
            )
    }
}

fileprivate struct BarView: View {
    let height: CGFloat
    let color: Color
    let isSelected: Bool
    let animateProgress: Bool
    let delay: Double

    var body: some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(color)
            .frame(width: 8, height: animateProgress ? height : 0)
            .scaleEffect(isSelected ? 1.2 : 1.0)
            .animation(.spring(response: 0.6).delay(delay), value: animateProgress)
            .animation(.spring(response: 0.4), value: isSelected)
    }
}

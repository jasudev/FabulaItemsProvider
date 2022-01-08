//
//  ItemRowView.swift
//  FabulaPlus
//
//  Created by jasu on 2022/01/04.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import FabulaItemsProvider

struct ItemRowView: View {
    
    let itemData: ItemData
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
#if os(iOS)
                    .fill(Color.fabulaBack2)
#else
                    .fill(Color.fabulaBack1)
#endif
                Text("\(itemData.id)")
                    .font(.custom("Helvetica Bold", fixedSize: 18))
                    .foregroundColor(Color.fabulaPrimary)
            }
            .frame(width: 51, height: 60)
            VStack(alignment: .leading, spacing: 2) {
                Text(itemData.section)
                    .fontWeight(.semibold)
                    .font(.caption)
                    .foregroundColor(Color.fabulaFore1.opacity(0.6))
                Text(itemData.title)
                    .fontWeight(.semibold)
                    .font(.headline)
                    .foregroundColor(Color.fabulaFore1)
                Text("\(itemData.caption)")
                    .font(.footnote)
                    .lineLimit(100)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(-3)
                    .foregroundColor(Color.fabulaFore1.opacity(0.6))
                HStack {
                    (Text("Created by ") + Text("\(itemData.creator)").foregroundColor(Color.fabulaPrimary))
                        .font(.caption)
                        .foregroundColor(Color.fabulaFore1.opacity(0.6))
                    Spacer()
                    
                    Text("\(itemData.date.dateToString(style: .medium))")
                        .font(.caption2)
                        .foregroundColor(Color.fabulaFore2)
                }
                .padding(.top, 6)
            }
        }
    }
}

struct ItemRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        ItemRowView(itemData: ItemData(id: 1, category: .play,
                                       section: "Interval",
                                       createDate: "2021-09-06",
                                       title: "Timer",
                                       caption: "Interval using the stopwatch function",
                                       creator: "jasu",
                                       tags: "GeometryReader, rotationEffect, Clock",
                                       view: FAnyView(P1_Timer())))
    }
}

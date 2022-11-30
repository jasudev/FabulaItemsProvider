//
//  P267_LazyGridView.swift
//
//
//  Created by soccer01 on 2022/10/22.
//  Copyright (c) 2022 soccer01 All rights reserved.
//

import SwiftUI

public struct P267_LazyGridView: View {
    let datas = [GridData(vTitle: "Sticky-Section-Primary", color: .fabulaPrimary),
                 GridData(vTitle: "Sticky-Section-Secondary", color: .fabulaSecondary),
                 GridData(vTitle: "Sticky-Section-yellow", color: .yellow),
                 GridData(vTitle: "Sticky-Section-blue", color: .blue),
                 GridData(vTitle: "Sticky-Section-pink", color: .pink)]
    
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    
    public var body: some View {
        VStack {
            Text("LazyVGrid")
            ScrollView {
                LazyVGrid(columns: columns,
                          spacing: 20,
                          pinnedViews: .sectionHeaders) {
                    
                    ForEach(datas, id: \.self) { data in
                        gridItem(gridData: data)
                    }
                }.padding()
            }
            .background(Color.fabulaBack2)
            .cornerRadius(10)
            .padding(.horizontal)
                
            
            Text("LazyHGrid")
            ScrollView(.horizontal) {
                LazyHGrid(rows: columns,
                          spacing: 20,
                          pinnedViews: .sectionHeaders) {
                    ForEach(datas, id: \.self) { data in
                        gridItem(gridData: data, isHorizontal: true)
                    }
                }
            }
            .background(Color.fabulaBack2)
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
    
    private func gridItem(gridData: GridData, isHorizontal: Bool = false) -> some View {
        return Section(header:
                        Text(isHorizontal ? gridData.hTitle : gridData.vTitle).foregroundColor(gridData.color)) {
            ForEach(0..<10) {i in
                if isHorizontal {
                    Capsule()
                        .fill(gridData.color)
                        .frame(width: 20, height: 20)
                } else {
                    Capsule()
                        .fill(gridData.color)
                        .frame(width: 50, height: 50)
                }
            }
        }
    }
    
}

struct GridData: Equatable, Hashable {
    var vTitle: String
    var hTitle: String = "Sticky\nSection"
    var color: Color
}

struct P267_LazyGridView_Previews: PreviewProvider {
    static var previews: some View {
        P267_LazyGridView()
    }
}

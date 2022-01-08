//
//  P161_Namespace.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P161_Namespace: View {
    
    @Namespace private var namespace
    @State private var showDetail = true
    @State private var currentId: String = "background1"
    
    public init() {}
    public var body: some View {
        VStack {
            if showDetail {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                        .matchedGeometryEffect(id: "background1", in: namespace)
                    Image(systemName: "1.circle")
                        .padding()
                        .matchedGeometryEffect(id: "title1", in: namespace)
                }
                .frame(width: 200, height: 100)
                .onTapGesture {
                    currentId = "1"
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                        .matchedGeometryEffect(id: "background2", in: namespace)
                    Image(systemName: "2.circle")
                        .padding()
                        .matchedGeometryEffect(id: "title2", in: namespace)
                }
                .frame(width: 200, height: 100)
                .onTapGesture {
                    currentId = "2"
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                        .matchedGeometryEffect(id: "background3", in: namespace)
                    Image(systemName: "3.circle")
                        .padding()
                        .matchedGeometryEffect(id: "title3", in: namespace)
                }
                .frame(width: 200, height: 100)
                .onTapGesture {
                    currentId = "3"
                }
            }else {
                DetailView(namespace: namespace, id: currentId)
            }
        }
        .padding()
        .simultaneousGesture(
            TapGesture()
                .onEnded { _ in
                    DispatchQueue.main.async {
                        withAnimation(.spring()) {
                            showDetail.toggle()
                        }
                    }
                }
        )
    }
}

fileprivate
extension P161_Namespace {
    struct DetailView: View {
        
        let namespace: Namespace.ID
        let id: String
        
        var body: some View {
            VStack {
                if id == "3" {
                    Spacer()
                }
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.purple)
                        .matchedGeometryEffect(id: "background" + id, in: namespace)
                        .frame(height: 400)
                    Image(systemName: id + ".circle")
                        .padding()
                        .imageScale(.large)
                        .foregroundColor(Color.white)
                        .padding()
                        .matchedGeometryEffect(id: "title" + id, in: namespace)
                }
                if id == "1" {
                    Spacer()
                }
            }
        }
    }
}

struct P161_Namespace_Previews: PreviewProvider {
    static var previews: some View {
        P161_Namespace()
    }
}

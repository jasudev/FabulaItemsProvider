//
//  P251_EnvironmentKey.swift
//  https://developer.apple.com/documentation/swiftui/environmentkey
//
//  Created by jasu on 2022/05/19.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

public struct P251_EnvironmentKey: View {
    
    public init() {}
    public var body: some View {
        VStack(spacing: 5) {
            StarContainer()
                .environment(\.starProperties, StarProperties())
            StarContainer()
                .environment(\.starProperties, .primaryStar)
            StarContainer()
                .environment(\.starProperties, .secondaryStar)
            StarContainer()
                .environment(\.starProperties, StarProperties(count: 7, color: .red))
            StarContainer()
                .setStarProperties(StarProperties(count: 9, color: .blue))
        }
    }
}

fileprivate
struct StarContainer: View {
    
    @Environment(\.starProperties) private var properties: StarProperties
    
    var body: some View {
        HStack {
            ForEach(0..<properties.count, id: \.self) { index in
                Image(systemName: "star.fill")
            }
        }
        .foregroundColor(properties.color)
    }
}

fileprivate
struct StarProperties {
    var count: Int = 1
    var color: Color = .fabulaFore1
    
    static var primaryStar: StarProperties {
        StarProperties(count: 3, color: .fabulaPrimary)
    }
    
    static var secondaryStar: StarProperties {
        StarProperties(count: 5, color: .fabulaSecondary)
    }
}

fileprivate
extension EnvironmentValues {
    var starProperties: StarProperties {
        get {
            self[StarKey.self]
        }
        set(newKey) {
            self[StarKey.self] = newKey
        }
    }
}

fileprivate
struct StarKey: EnvironmentKey {
    static let defaultValue: StarProperties = StarProperties()
}

fileprivate
extension View {
    func setStarProperties(_ properties: StarProperties) -> some View {
        environment(\.starProperties, properties)
    }
}

struct P251_EnvironmentKey_Previews: PreviewProvider {
    static var previews: some View {
        P251_EnvironmentKey()
    }
}

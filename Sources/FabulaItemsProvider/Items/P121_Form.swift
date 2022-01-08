//
//  P121_Form.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI

public struct P121_Form: View {
    
    enum NotifyMeAboutType {
        case directMessages
        case mentions
        case anything
    }
    
    enum ProfileImageSize {
        case large
        case medium
        case small
    }
    
    @State private var notifyMeAbout: NotifyMeAboutType = .directMessages
    @State private var profileImageSize: ProfileImageSize = .medium
    @State private var playNotificationSounds: Bool = true
    @State private var sendReadReceipts: Bool = false
    
    public init() {}
    public var body: some View {
        Form {
            Section(header: Text("Notifications")) {
                Picker("Notify Me About", selection: $notifyMeAbout) {
                    Text("Direct Messages").tag(NotifyMeAboutType.directMessages)
                    Text("Mentions").tag(NotifyMeAboutType.mentions)
                    Text("Anything").tag(NotifyMeAboutType.anything)
                }
                
                Toggle("Play notification sounds", isOn: $playNotificationSounds)
                Toggle("Send read receipts", isOn: $sendReadReceipts)
            }
            Section(header: Text("User Profiles")) {
                Picker("Profile Image Size", selection: $profileImageSize) {
                    Text("Large").tag(ProfileImageSize.large)
                    Text("Medium").tag(ProfileImageSize.medium)
                    Text("Small").tag(ProfileImageSize.small)
                }
                .pickerStyle(.inline)
                Button("Clear Image Cache") {}
            }
        }
        #if os(macOS)
        .padding()
        .frame(maxWidth: 500)
        #endif
    }
}

struct P121_Form_Previews: PreviewProvider {
    static var previews: some View {
        P121_Form()
    }
}

import SwiftUI

public struct P271_CollapsibleText: View {
    let foregroundColor: Color = .fabulaFore1
    let backgroundColor: Color = .fabulaPrimary
    
    public init() {}
    public var body: some View {
        CollapsibleText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                        lineLimit: 2)
            .padding()
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .padding()
    }
}

fileprivate struct CollapsibleText: View {
    @State private var isCollapsed = true
    @State private var isTruncateable = true
    
    let text: String
    let lineLimit: Int
    
    init(_ text: String, lineLimit: Int) {
        self.text = text
        self.lineLimit = lineLimit
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            textWithHeightReading
            
            if isTruncateable {
                buttonView
            }
        }
    }
    
    private var textWithHeightReading: some View {
        Text(text)
            .lineLimit(isCollapsed ? lineLimit : nil)
            .background(
                Text(text)
                    .lineLimit(lineLimit)
                    .background(GeometryReader { collapsed in
                        ZStack {
                            Text(text)
                                .lineLimit(nil)
                                .background(GeometryReader { full in
                                    Color.clear.onAppear {
                                        isTruncateable = full.size.height > collapsed.size.height
                                    }
                                })
                        }
                        .frame(height: .greatestFiniteMagnitude)
                    })
                    .hidden()
            )
    }
    
    private var buttonView: some View {
        Button(isCollapsed ? "More" : "Less") {
            isCollapsed.toggle()
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

struct P271_CollapsibleText_Previews: PreviewProvider {
    static var previews: some View {
        P271_CollapsibleText()
    }
}

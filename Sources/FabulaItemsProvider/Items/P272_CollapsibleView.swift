import SwiftUI

struct P272_CollapsibleView: View {
    var body: some View {
        CollapsibleView(
            Image(systemName: "snow")
                .resizable()
                .scaledToFit()
                .foregroundColor(.fabulaSecondary)
                .frame(width: 250)
        )
    }
}

fileprivate struct CollapsibleView<Content: View>: View {
    let theView: Content
    let collapsedHeight: CGFloat
    @State private var theViewHeight: CGFloat = .greatestFiniteMagnitude
    @State private var isCollapsed = true
    
    init(_ collapsedView: Content, collapsedHeight: CGFloat = 50) {
        self.theView = collapsedView
        self.collapsedHeight = collapsedHeight
    }
    
    var body: some View {
        VStack {
            theView
                .background(GeometryReader { theViewGeo in
                    Color.clear.onAppear {
                        self.theViewHeight = theViewGeo.size.height
                    }
                })
                .fixedSize()
                .frame(height: isCollapsed ? collapsedHeight : theViewHeight, alignment: .top)
                .clipped()
            
            expandingButton
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 6.0)
            .stroke(Color.fabulaBar2))
        .animation(.easeOut, value: isCollapsed)
    }
    
    private var expandingButton: some View {
        Button(isCollapsed ? "Show" : "Hide") { isCollapsed.toggle() }
            .id("expandingButtonView")
            .buttonStyle(.borderedProminent)
            
    }
}

struct P272_CollapsibleView_Previews: PreviewProvider {
    static var previews: some View {
        P272_CollapsibleView()
    }
}

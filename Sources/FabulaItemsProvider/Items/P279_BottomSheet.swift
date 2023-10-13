//
//  P279_BottomSheet.swift
//
//
//  Created by 김인섭 on 10/14/23.
//

import SwiftUI

struct P279_BottomSheet: View {
    
    @State private var isActive = false

    var body: some View {
        Button("Tap to Show BottomSheet") {
            withAnimation { isActive = true }
        }
        .bottomSheet($isActive) {
            BottomSheetContent()
        }
    }
    
    @ViewBuilder func BottomSheetContent() -> some View {
        ScrollView {
            VStack {
                ForEach(0..<90) {
                    Text("Index \($0)")
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(5.0)
                }
            }
        }
    }
}

#Preview {
    P279_BottomSheet()
}

fileprivate extension View {
    
    @ViewBuilder func bottomSheet(
        _ isActive: Binding<Bool>,
        _ sheetSize: BottomSheetSize = .twoThird,
        @ViewBuilder content: @escaping () -> some View
    ) -> some View {
        GeometryReader(content: { geometry in
            BottomSheetView(isActive) {
                self
            } content: {
                content()
                    .frame(maxHeight: sheetSize.height(geometry))
            }
        })
    }
    
    @ViewBuilder func isShow(_ state: Bool) -> some View {
        if state {
            self
        }
    }
    
    @ViewBuilder func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

fileprivate enum BottomSheetSize {
    
    case oneThird, twoThird, half, full, fixed(CGFloat), auto
    
    var height: (GeometryProxy) -> CGFloat? {{ proxy in
        switch self {
        case .oneThird:
            return proxy.size.height / 3
        case .twoThird:
            return proxy.size.height / 1.5
        case .half:
            return proxy.size.height / 2
        case .full:
            return proxy.size.height
        case .fixed(let height):
            return height
        case .auto:
            return nil
        }
    }}
}

fileprivate struct BottomSheetView<RearContent: View, Content: View>: View {
    
    let rearContent: RearContent
    let content: Content
    @Binding var isActive: Bool
    @State private var draggedY: CGFloat = .zero
    
    public init(
        _ isActive: Binding<Bool>,
        @ViewBuilder rearContent: () -> RearContent,
        @ViewBuilder content: () -> Content
    ) {
        self.rearContent = rearContent()
        self.content = content()
        self._isActive = Binding(projectedValue: isActive)
    }
    
    public var body: some View {
        rearContent
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .blur(radius: isActive ? 10 : 0)
            .overlay { Background() }
            .overlay(alignment: .bottom, content: BottomSheet)
            .edgesIgnoringSafeArea(.bottom)
            .onChange(of: isActive, perform: didChage(_:))
    }
}

@available(iOS 15.0, *)
fileprivate extension BottomSheetView {
    
    func Background() -> some View {
        Color.black
            .opacity(0.76)
            .onTapGesture {
                withAnimation { isActive = false }
            }
            .ignoresSafeArea()
            .isShow(isActive)
    }
    
    @ViewBuilder
    func BottomSheet() -> some View {
        content
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .padding(.bottom, UIApplication.safeArea.bottom)
            .padding(.bottom, 50)
            .background(Color.white)
            .cornerRadius(24, corners: [.topLeft, .topRight])
            .offset(y: 50)
            .offset(y: draggedY)
            .gesture(
                DragGesture()
                    .onChanged(didDrag(_:))
                    .onEnded(endDrag(_:))
            )
            .transition(.move(edge: .bottom))
            .animation(.easeIn, value: isActive)
            .isShow(isActive)
    }
}

fileprivate extension BottomSheetView {
    
    func didDrag(_ value: DragGesture.Value) {
        guard value.translation.height > -50 else { return }
        withAnimation { draggedY = value.translation.height }
    }
    
    func endDrag(_ value: DragGesture.Value) {
        let hasDragEnough = (value.translation.height > 100)
        if hasDragEnough { withAnimation { isActive = false } }
        else { withAnimation { draggedY = .zero } }
    }
    
    func didChage(_ value: Bool) {
        guard !value else { return }
        withAnimation { self.draggedY = .zero }
    }
}

fileprivate struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

fileprivate extension UIApplication {
    
    static var windowScene: UIWindowScene? {
        UIApplication.shared.connectedScenes.first as? UIWindowScene
    }
    
    static var keyWindow: UIWindow? {
        windowScene?.windows.filter { $0.isKeyWindow }.first
    }
    
    static var safeArea: UIEdgeInsets {
        keyWindow?.safeAreaInsets ?? .zero
    }
}

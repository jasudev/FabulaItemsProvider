//
//  P66_Environment.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

import SwiftUI
import CoreData

public struct P66_Environment: View {
    
    // 뷰 내의 컨트롤에 적용할 크기입니다.
    @Environment(\.controlSize) private var controlSize: ControlSize
    // 가장 가까운 포커스 가능한 조상에 포커스가 있는지 여부를 반환합니다.
    @Environment(\.isFocused) private var isFocused: Bool
    // 이 환경과 연결된 뷰가 사용자 상호 작용을 허용하는지 여부를 나타내는 부울 값입니다.
    @Environment(\.isEnabled) private var isEnabled: Bool
    // 뷰 계층 구조에 적용된 현재 모자이크 이유입니다.
    @Environment(\.redactionReasons) private var redactionReasons: RedactionReasons
    // 뷰가 날짜를 처리할 때 사용해야 하는 현재 달력입니다.
    @Environment(\.calendar) private var calendar: Calendar
    // 이 환경의 표시 스테일입니다.
    @Environment(\.displayScale) private var displayScale: CGFloat
    // 현재 환경과 관련된 레이아웃 방향입니다.
    @Environment(\.layoutDirection) private var layoutDirection: LayoutDirection
    // 뷰가 사용해야 하는 현재 로케일입니다.
    @Environment(\.locale) private var locale: Locale
    // 화면의 픽셀 크기입니다.
    @Environment(\.pixelLength) private var pixelLength: CGFloat
    // 뷰가 날짜를 처리할 때 사용해야 하는 현재 시간대입니다.
    @Environment(\.timeZone) private var timeZone: TimeZone
    // 목록에 있는 행의 기본 최소 높이입니다.
    @Environment(\.defaultMinListRowHeight) private var defaultMinListRowHeight: CGFloat
    // 목록에 있는 헤더의 기본 최소 높이입니다.
    @Environment(\.defaultMinListHeaderHeight) private var defaultMinListHeaderHeight: CGFloat?
    // 이 환경의 이미지 스케일입니다.
    @Environment(\.imageScale) private var imageScale: Image.Scale
    // 이 환경의 기본 글꼴입니다.
    @Environment(\.font) private var font: Font?
    // 텍스트에 적용할 글꼴 두께입니다.
    @Environment(\.legibilityWeight) private var legibilityWeight: LegibilityWeight?
    // 내용이 줄 바꿈되거나 줄 바꿈이 포함될 때 텍스트 인스턴스가 줄을 정렬하는 방법을 나타내는 값입니다.
    @Environment(\.multilineTextAlignment) private var multilineTextAlignment: TextAlignment
    // 레이아웃이 사용 가능한 공간에 맞게 텍스트의 마지막 줄을 자르는 방법을 나타내는 값입니다.
    @Environment(\.truncationMode) private var truncationMode: Text.TruncationMode
    // 한 줄 조각의 맨 아래와 다음 조각의 맨 위 사이의 거리(포인트 단위)입니다.
    @Environment(\.lineSpacing) private var lineSpacing: CGFloat
    // 텍스트를 사용 가능한 공간에 맞추기 위해 문자 간 간격을 좁혀야 하는지 여부를 나타내는 부울 값입니다.
    @Environment(\.allowsTightening) private var allowsTightening: Bool
    // 뷰에서 텍스트가 차지할 수 있는 최대 줄 수입니다.
    @Environment(\.lineLimit) private var lineLimit: Int?
    // 사용 가능한 공간에 텍스트를 맞추기 위해 글꼴 크기를 축소하기 위한 최소 허용 비율입니다.
    @Environment(\.minimumScaleFactor) private var minimumScaleFactor: CGFloat
    // 환경의 로케일을 사용하여 표시될 때 텍스트의 대소문자를 변환하는 스타일 재정의입니다.
    @Environment(\.textCase) private var textCase: Text.Case?
    // 뷰 계층 구조에 자동 수정이 활성화되어 있는지 여부를 결정하는 부울 값입니다.
    @Environment(\.disableAutocorrection) private var disableAutocorrection: Bool?
    // 장면의 현재 단계입니다.
    @Environment(\.scenePhase) private var scenePhase: ScenePhase
    // 환경에서 OpenURLAction을 사용하여 URL을 엽니다.
    @Environment(\.openURL) private var openURL: OpenURLAction
    // 이 환경의 색 구성표입니다.
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    // 이 환경의 색 구성표와 관련된 대비입니다.
    @Environment(\.colorSchemeContrast) private var colorSchemeContrast: ColorSchemeContrast
    // CoreData 에서 사용되는 Context object입니다.
    @Environment(\.managedObjectContext) private var managedObjectContext: NSManagedObjectContext
    // 뷰의 실행 취소 작업을 등록하는 데 사용되는 실행 취소 관리자입니다.
    @Environment(\.undoManager) private var undoManager: UndoManager?
    
#if os(macOS)
    // 뷰에 있는 컨트롤의 활성 상태입니다.
    @Environment(\.controlActiveState) private var controlActiveState: ControlActiveState
    //MARK: - macOS 12.0 ~
    // 포커스 시스템이 기본 포커스를 다시 평가하도록 요청하는 작업입니다.
    // @Environment(\.resetFocus) private var resetFocus: ResetFocusAction?
    //MARK: -
#else
    // 이 환경의 수평 크기 클래스입니다.
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass: UserInterfaceSizeClass?
    // 이 환경의 수직 크기 클래스입니다.
    @Environment(\.verticalSizeClass) private var verticalSizeClass: UserInterfaceSizeClass?
    // 사용자가 이 환경과 연결된 뷰의 내용을 편집할 수 있는지 여부를 나타내는 모드입니다.
    @Environment(\.editMode) private var editMode: Binding<EditMode>?
    // 현재 심볼 렌더링 모드 또는 현재 이미지와 전경 스타일을 매개변수로 사용하여 모드가 자동으로 선택됨을 나타내는 nil입니다.
    @Environment(\.symbolRenderingMode) private var symbolRenderingMode: SymbolRenderingMode?
    //MARK: - iOS and macOS 12.0 ~
    // 현재 동적 유형 크기입니다.
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize: DynamicTypeSize
    // 뷰 내 섹션 헤더에 적용할 중요도입니다.
    @Environment(\.headerProminence) private var headerProminence: Prominence
    // 이 환경에서 사용할 기호 변형입니다.
    @Environment(\.symbolVariants) private var symbolVariants: SymbolVariants
    // 사용자가 현재 주변 검색 가능한 수정자에 의해 배치된 검색 필드와 상호 작용하는지 여부입니다.
    @Environment(\.isSearching) private var isSearching: Bool
    // 시스템에 현재 검색 상호 작용을 해제하도록 요청합니다.
    @Environment(\.dismissSearch) private var dismissSearch: DismissSearchAction
    // 이 환경의 버튼이 트리거되는 키보드 단축키입니다.
    @Environment(\.keyboardShortcut) private var keyboardShortcut: KeyboardShortcut?
    // 현재 프레젠테이션을 닫습니다.
    @Environment(\.dismiss) private var dismiss: DismissAction
    // 이 환경과 연결된 뷰가 현재 표시되고 있는지 여부를 나타내는 부울 값입니다.
    @Environment(\.isPresented) private var isPresented: Bool
    // 뷰 환경에 저장된 새로 고침 작업입니다.
    @Environment(\.refresh) private var refresh: RefreshAction?
    // 현재 뷰 아래에 있는 Material입니다.
    @Environment(\.backgroundMaterial) private var backgroundMaterial: Material?
    //MARK: -
#endif
    
    public init() {}
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Group {
                    EnvironmentValueInfoView(property: "controlSize", description: "뷰 내의 컨트롤에 적용할 크기입니다.")
                    EnvironmentValueInfoView(property: "isFocused", description: "가장 가까운 포커스 가능한 조상에 포커스가 있는지 여부를 반환합니다.")
                    EnvironmentValueInfoView(property: "isEnabled", description: "이 환경과 연결된 뷰가 사용자 상호 작용을 허용하는지 여부를 나타내는 부울 값입니다.")
                    EnvironmentValueInfoView(property: "redactionReasons", description: "뷰 계층 구조에 적용된 현재 모자이크 이유입니다.")
                    EnvironmentValueInfoView(property: "calendar", description: "뷰가 날짜를 처리할 때 사용해야 하는 현재 달력입니다.")
                    EnvironmentValueInfoView(property: "displayScale", description: "이 환경의 표시 스테일입니다.")
                    EnvironmentValueInfoView(property: "layoutDirection", description: "현재 환경과 관련된 레이아웃 방향입니다.")
                    EnvironmentValueInfoView(property: "locale", description: "뷰가 사용해야 하는 현재 로케일입니다.")
                    EnvironmentValueInfoView(property: "pixelLength", description: "화면의 픽셀 크기입니다.")
                    EnvironmentValueInfoView(property: "timeZone", description: "뷰가 날짜를 처리할 때 사용해야 하는 현재 시간대입니다.")
                }
                
                Group {
                    EnvironmentValueInfoView(property: "defaultMinListRowHeight", description: "목록에 있는 행의 기본 최소 높이입니다.")
                    EnvironmentValueInfoView(property: "defaultMinListHeaderHeight", description: "목록에 있는 헤더의 기본 최소 높이입니다.")
                    EnvironmentValueInfoView(property: "imageScale", description: "이 환경의 이미지 스케일입니다.")
                    EnvironmentValueInfoView(property: "font", description: "이 환경의 기본 글꼴입니다.")
                    EnvironmentValueInfoView(property: "legibilityWeight", description: "텍스트에 적용할 글꼴 두께입니다.")
                    EnvironmentValueInfoView(property: "multilineTextAlignment", description: "내용이 줄 바꿈되거나 줄 바꿈이 포함될 때 텍스트 인스턴스가 줄을 정렬하는 방법을 나타내는 값입니다.")
                    EnvironmentValueInfoView(property: "truncationMode", description: "레이아웃이 사용 가능한 공간에 맞게 텍스트의 마지막 줄을 자르는 방법을 나타내는 값입니다.")
                    EnvironmentValueInfoView(property: "lineSpacing", description: "한 줄 조각의 맨 아래와 다음 조각의 맨 위 사이의 거리(포인트 단위)입니다.")
                    EnvironmentValueInfoView(property: "allowsTightening", description: "텍스트를 사용 가능한 공간에 맞추기 위해 문자 간 간격을 좁혀야 하는지 여부를 나타내는 부울 값입니다.")
                    EnvironmentValueInfoView(property: "lineLimit", description: "뷰에서 텍스트가 차지할 수 있는 최대 줄 수입니다.")
                }
                
                Group {
                    EnvironmentValueInfoView(property: "minimumScaleFactor", description: "사용 가능한 공간에 텍스트를 맞추기 위해 글꼴 크기를 축소하기 위한 최소 허용 비율입니다.")
                    EnvironmentValueInfoView(property: "textCase", description: "환경의 로케일을 사용하여 표시될 때 텍스트의 대소문자를 변환하는 스타일 재정의입니다.")
                    EnvironmentValueInfoView(property: "disableAutocorrection", description: "뷰 계층 구조에 자동 수정이 활성화되어 있는지 여부를 결정하는 부울 값입니다.")
                    EnvironmentValueInfoView(property: "scenePhase", description: "장면의 현재 단계입니다.")
                    EnvironmentValueInfoView(property: "openURL", description: "환경에서 OpenURLAction을 사용하여 URL을 엽니다.")
                    EnvironmentValueInfoView(property: "colorScheme", description: "이 환경의 색 구성표입니다.")
                    EnvironmentValueInfoView(property: "colorSchemeContrast", description: "이 환경의 색 구성표와 관련된 대비입니다.")
                    EnvironmentValueInfoView(property: "managedObjectContext", description: "CoreData에서 사용되는 Context object입니다.")
                    EnvironmentValueInfoView(property: "undoManager", description: "뷰의 실행 취소 작업을 등록하는 데 사용되는 실행 취소 관리자입니다.")
                }
                
                Section(header: Text("Only macOS").foregroundColor(Color.fabulaPrimary)) {
                    EnvironmentValueInfoView(property: "controlActiveState", description: "뷰에 있는 컨트롤의 활성 상태입니다.")
                    Section(header: Text("macOS 12.0 ~").foregroundColor(Color.fabulaPrimary)) {
                        EnvironmentValueInfoView(property: "resetFocus", description: "포커스 시스템이 기본 포커스를 다시 평가하도록 요청하는 작업입니다.")
                    }
                    .padding(.leading, 16)
                }
                
                Section(header: Text("Only iOS").foregroundColor(Color.fabulaPrimary)) {
                    EnvironmentValueInfoView(property: "horizontalSizeClass", description: "이 환경의 수평 크기 클래스입니다.")
                    EnvironmentValueInfoView(property: "verticalSizeClass", description: "이 환경의 수직 크기 클래스입니다.")
                    EnvironmentValueInfoView(property: "editMode", description: "사용자가 이 환경과 연결된 뷰의 내용을 편집할 수 있는지 여부를 나타내는 모드입니다.")
                    EnvironmentValueInfoView(property: "symbolRenderingMode", description: "현재 심볼 렌더링 모드 또는 현재 이미지와 전경 스타일을 매개변수로 사용하여 모드가 자동으로 선택됨을 나타내는 nil입니다.")
                }
                
                Section(header: Text("iOS and macOS 12.0 ~").foregroundColor(Color.fabulaPrimary)) {
                    EnvironmentValueInfoView(property: "dynamicTypeSize", description: "현재 동적 유형 크기입니다.")
                    EnvironmentValueInfoView(property: "headerProminence", description: "뷰 내 섹션 헤더에 적용할 중요도입니다.")
                    EnvironmentValueInfoView(property: "symbolVariants", description: "이 환경에서 사용할 기호 변형입니다.")
                    EnvironmentValueInfoView(property: "isSearching", description: "사용자가 현재 주변 검색 가능한 수정자에 의해 배치된 검색 필드와 상호 작용하는지 여부입니다.")
                    EnvironmentValueInfoView(property: "dismissSearch", description: "시스템에 현재 검색 상호 작용을 해제하도록 요청합니다.")
                    EnvironmentValueInfoView(property: "keyboardShortcut", description: "이 환경의 버튼이 트리거되는 키보드 단축키입니다.")
                    EnvironmentValueInfoView(property: "dismiss", description: "현재 프레젠테이션을 닫습니다.")
                    EnvironmentValueInfoView(property: "isPresented", description: "이 환경과 연결된 뷰가 현재 표시되고 있는지 여부를 나타내는 부울 값입니다.")
                    EnvironmentValueInfoView(property: "refresh", description: "뷰 환경에 저장된 새로 고침 작업입니다.")
                    EnvironmentValueInfoView(property: "backgroundMaterial", description: "현재 뷰 아래에 있는 Material입니다.")
                }
            }
            .padding()
        }
    }
}

fileprivate
struct EnvironmentValueInfoView: View {
    
    let property: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("." + property + ":")
                .font(.headline)
                .fontWeight(.bold)
            Text(description)
                .font(.callout)
                .opacity(0.5)
        }
    }
}

struct P66_Environment_Previews: PreviewProvider {
    static var previews: some View {
        P66_Environment()
    }
}

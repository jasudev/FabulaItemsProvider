//
//  MacViewModel.swift
//  FabulaPlus
//
//  Created by jasu on 2022/11/17.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import FabulaItemsProvider

class MacViewModel: ObservableObject {
    @Published var isShowSideList: Bool = true
    @Published var currentItem: ItemData? = nil
}

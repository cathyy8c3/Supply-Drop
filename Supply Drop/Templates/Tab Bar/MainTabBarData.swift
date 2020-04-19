//
//  MainTabBarData.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/18/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI
import Combine

final class MainTabBarData: ObservableObject {

    /// This is the index of the item that fires a custom action
    let customActionteminidex1: Int
    let customActionteminidex2: Int

    let objectWillChange = PassthroughSubject<MainTabBarData, Never>()

    var itemSelected: Int {
        didSet {
            if (itemSelected == customActionteminidex1) {
                itemSelected = oldValue
                isCustomItemSelected1 = true
            }else if(itemSelected == customActionteminidex2) {
                itemSelected = oldValue
                isCustomItemSelected2 = true
            }
            objectWillChange.send(self)
        }
    }

    /// This is true when the user has selected the Item with the custom action
    var isCustomItemSelected1: Bool = false
    var isCustomItemSelected2: Bool = false

    init(initialIndex: Int, customItemIndex1: Int,customItemIndex2:Int) {
        self.customActionteminidex1 = customItemIndex1
        self.itemSelected = initialIndex
        self.customActionteminidex2 = customItemIndex2
    }
}

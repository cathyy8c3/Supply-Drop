//
//  SwiftUIPager_sample.swift
//  Supply Drop
//
//  Created by Cathy Chang on 4/16/20.
//  Copyright © 2020 Supply Drop. All rights reserved.
//

import SwiftUI
import SwiftUIPager

struct SwiftUIPager_sample: View {

    @State var page1: Int = 0
    @State var page2: Int = 0
    @State var data = Array(0..<10)

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 10) {
                Text("Vertical").bold()
                Pager(page: self.$page1,
                      data: self.data,
                      id: \.self) {
                        self.pageView($0)
                }
                .vertical()
                .itemSpacing(10)
                .itemAspectRatio(1.3)
                .background(Color.gray.opacity(0.2))

                Spacer()

                Text("Right to left").bold()
                Pager(page: self.$page2,
                      data: self.data,
                      id: \.self) {
                        self.pageView($0)
                }
                .itemSpacing(10)
                .horizontal(.rightToLeft)
                .interactive(0.8)
                .itemAspectRatio(0.7)
                .background(Color.gray.opacity(0.5))
            }
        }
    }

    func pageView(_ page: Int) -> some View {
        ZStack {
            Rectangle()
                .fill(Color.yellow)
            Text("Page: \(page)")
                .bold()
        }
        .cornerRadius(5)
        .shadow(radius: 5)
    }
}

struct SwiftUIPager_sample_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIPager_sample()
    }
}

//
//  Extensions.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 11/09/22.
//

import SwiftUI

struct VScrollView<Content>: View where Content: View {
  @ViewBuilder let content: Content
  var body: some View {
    GeometryReader { geometry in
      ScrollView {
        content
          .frame(width: geometry.size.width)
          .frame(minHeight: geometry.size.height)
      }
    }
  }
}

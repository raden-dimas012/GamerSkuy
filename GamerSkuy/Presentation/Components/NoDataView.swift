//
//  NoDataView.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 29/09/22.
//

import SwiftUI

struct NoDataView: View {
    let title: String
    var body: some View {
        VScrollView {
            VStack {
                NoDataViewAnimation(jsonFile: "not-found")
                    .frame(width: 350, height: 350)
                Text(title)
                    .foregroundColor(.gray)
                    .font(.title)
            }
        }
    }
}

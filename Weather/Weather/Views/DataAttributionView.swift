//
//  DataAttributionView.swift
//  Weather
//
//  Created by Sarah Clark on 10/9/23.
//

import SwiftUI
import WeatherKit

struct DataAttributionView: View {
    var weatherAttribute: WeatherAttribution?

    var body: some View {
        if let attribute = weatherAttribute {
            HStack {
                AsyncImage(
                    url:attribute.squareMarkURL,
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 30, maxHeight: 30)
                    },
                    placeholder: {
                        ProgressView()
                    })
                Link(destination: attribute.legalPageURL) {
                    Text("Weather Data Attribution")
                    .font(Font.footnote)
                }
            }
        }
    }
}

#Preview {
    DataAttributionView()
}

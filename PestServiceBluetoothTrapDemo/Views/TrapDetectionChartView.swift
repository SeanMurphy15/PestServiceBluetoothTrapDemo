//
//  BarChartView.swift
//  PestServiceBluetoothTrapDemo
//
//  Created by Sean Murphy on 2/18/20.
//  Copyright © 2020 SeanMurphy. All rights reserved.
//

import SwiftUI
import CoreGraphics

struct Constants {

    static let barChartColumns: Int = 96
    static let barChartColumnWidth: CGFloat = 2.6
    static let barChartColumnSpacing: CGFloat = 1
}

struct TrapDetectionChartView: View {

     var detections: Int
     var data: [Int: Double]
     var textColor = Color.blue
     var barStartColor = Color.blue
     var barEndColor = Color.blue

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Trap Activity")
                    .font(Font.system(size: 18, weight: .regular, design: .default))
                    .kerning(0.05)
                    .foregroundColor(textColor)
            }
            .padding([.bottom], 10)
            self.createChart()
                .padding([.bottom], 2)
            self.createLegend()
                .frame(width: Constants.barChartColumnWidth * CGFloat(Constants.barChartColumns) + (Constants.barChartColumnSpacing * CGFloat(Constants.barChartColumns - 1)), height: 14)
            Text("Detections: \(detections)")
                .font(Font.system(size: 12, weight: .regular, design: .default))
                .kerning(0.3)
                .foregroundColor(textColor)
        }
    }

    func createChart() -> some View {
        let maxColumnIndex = Constants.barChartColumns - 1
        return ZStack(alignment: .bottomLeading) {
            VStack(alignment: .center, spacing: 20) {
                HStack(alignment: .center, spacing: Constants.barChartColumnWidth) {
                    ForEach(0..<maxColumnIndex) { i in
                        Rectangle()
                            .fill(Color(red: 129 / 255, green: 129 / 255, blue: 129 / 255))
                            .frame(width: 1, height: 1)
                    }
                }
                HStack(alignment: .center, spacing: Constants.barChartColumnWidth) {
                    ForEach(0..<maxColumnIndex) { i in
                        Rectangle()
                            .fill(Color(red: 71 / 255, green: 72 / 255, blue: 73 / 255))
                            .frame(width: 1, height: 1)
                    }
                }
                HStack(alignment: .center, spacing: Constants.barChartColumnWidth) {
                    ForEach(0..<maxColumnIndex) { i in
                        Rectangle()
                            .fill(Color(red: 71 / 255, green: 72 / 255, blue: 73 / 255))
                            .frame(width: 1, height: 1)
                    }
                }
                HStack(alignment: .top, spacing: Constants.barChartColumnSpacing) {
                    ForEach(0..<maxColumnIndex) { i in
                        Rectangle()
                            .fill(self.barStartColor)
                            .frame(width: Constants.barChartColumnWidth, height: Constants.barChartColumnWidth)
                            .cornerRadius(Constants.barChartColumnWidth / 2)
                    }
                }
            }
            HStack(alignment: .bottom, spacing: Constants.barChartColumnSpacing) {
                ForEach(0..<maxColumnIndex) { i in
                    BarChartBarView(height: self.data[i] ?? Double(0), startColor: self.barStartColor, endColor: self.barEndColor)
                }
            }
            .drawingGroup()
        }
    }

    func createLegend() -> some View {
        HStack(alignment: .center) {
            self.createLegendItem("JAN")
            Spacer()
            self.createLegendItem("FEB")
            Spacer()
            self.createLegendItem("MAR")
        }
    }

    func createLegendItem(_ time: String) -> some View {
        Text(time)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .font(Font.system(size: 11, weight: .medium, design: .default))
            .foregroundColor(Color.red)
    }

}

struct BarChartBarShape: Shape {

    var height: Double
    var currentHeight: Double

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cornerRadius = Constants.barChartColumnWidth / 2
        path.addRoundedRect(in: CGRect(x: 0, y: CGFloat(height - currentHeight), width: Constants.barChartColumnWidth, height: CGFloat(currentHeight)), cornerSize: CGSize(width: cornerRadius, height: cornerRadius))
        return path
    }

    var animatableData: Double {
        get { return currentHeight }
        set { currentHeight = newValue }
    }

}

struct BarChartBarView: View {

    @State var currentHeight: Double = 0

    var height: Double
    var startColor: Color
    var endColor: Color

    var animation: Animation {
        Animation.easeInOut(duration: 0.6)
    }

    var body: some View {
        BarChartBarShape(height: height, currentHeight: currentHeight)
            .fill(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .bottom, endPoint: .top))
            .frame(width: Constants.barChartColumnWidth, height: CGFloat(self.height))
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(self.animation) {
                        self.currentHeight = self.height
                    }
                }
            }
    }

}

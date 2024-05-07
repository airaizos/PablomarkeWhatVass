//
//  StringExtension.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 12/3/24.
//

import Foundation

extension String {
    func fakeDateToString(start: Int = 0, end: Int = 9) -> String {
        let startIndex = self.index(self.startIndex,
                                    offsetBy: start)
        let endIndex = self.index(self.startIndex,
                                  offsetBy: end)
        let subcadena = self[startIndex...endIndex]

        return String(subcadena)
    }

    func textIsEmpty() -> Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

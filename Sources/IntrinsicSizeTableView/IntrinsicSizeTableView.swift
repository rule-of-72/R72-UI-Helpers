//
//  IntrinsicSizeTableView.swift
//

import UIKit

public class IntrinsicSizeTableView: UITableView {

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.invalidateIntrinsicContentSize()
    }

    public override var intrinsicContentSize: CGSize {

        guard let dataSource = self.dataSource else {
            return super.intrinsicContentSize
        }

        var height: CGFloat = 0.0

        height += (tableHeaderView?.frame.height ?? 0.0)
        height += contentInset.top

        let sections = dataSource.numberOfSections?(in: self) ?? self.numberOfSections

        for section in 0 ..< sections {

            height += rectForHeader(inSection: section).height

            let rows = self.numberOfRows(inSection: section)
            for row in 0 ..< rows {
                height += self.rectForRow(at: IndexPath(row: row, section: section)).height
            }

            height += rectForFooter(inSection: section).height

        }

        height += contentInset.bottom
        height += (tableFooterView?.frame.height ?? 0.0)

        return CGSize(width: UIView.noIntrinsicMetric, height: height)

    }

}

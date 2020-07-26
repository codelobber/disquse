//
//  DecksViewDelegateFlowlayout.swift
//  Disgooseion
//
//  Created by allBeFine on 07.07.2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

final class DecksViewDelegateFlowlayout : NSObject {
    
}

extension DecksViewDelegateFlowlayout: UICollectionViewDelegateFlowLayout {
  //1
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: 100, height: 100)
  }
  
  //3
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return .zero
  }
  
  // 4
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 100
  }
}

//
//  LcqCollectionViewCell.h
//  瀑布流
//
//  Created by Leonlincq on 16/11/22.
//  Copyright © 2016年 Leonlin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class shopModel;

@interface LcqCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) shopModel *model;

@property (nonatomic,strong) NSIndexPath *myindexpath;

@end

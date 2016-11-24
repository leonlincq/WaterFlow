//
//  LCQCollectionViewFlowLayout.h
//  瀑布流
//
//  Created by Leonlincq on 16/11/22.
//  Copyright © 2016年 Leonlin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCQCollectionViewFlowLayout;

@protocol LCQCollectionViewFlowLayoutDelegate <NSObject>

@required
- (CGFloat)flowLayout:(LCQCollectionViewFlowLayout *)flowLayout heightForItemAtIndex:(NSInteger)index withWidth:(CGFloat)width;
@optional


@end




@interface LCQCollectionViewFlowLayout : UICollectionViewLayout

@property (nonatomic,weak) id<LCQCollectionViewFlowLayoutDelegate> delegate;


@end

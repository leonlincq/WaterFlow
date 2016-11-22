//
//  LCQCollectionViewFlowLayout.m
//  瀑布流
//
//  Created by Leonlincq on 16/11/22.
//  Copyright © 2016年 Leonlin. All rights reserved.
//

#import "LCQCollectionViewFlowLayout.h"
#import "shopModel.h"


const NSInteger theGap = 10;
const NSInteger theColumn = 3;
const UIEdgeInsets theEdgeinset = {20,20,20,20};

@interface LCQCollectionViewFlowLayout ()

@property (nonatomic,strong) NSMutableArray *attributeArray;
@property (nonatomic,strong) NSMutableArray *columnHeightArray;

@end

@implementation LCQCollectionViewFlowLayout

-(NSMutableArray *)attributeArray
{
    if (!_attributeArray )
    {
        _attributeArray = [[NSMutableArray alloc]init];
    }
    return _attributeArray;

}

-(NSMutableArray *)columnHeightArray
{
    if (!_columnHeightArray )
    {
        _columnHeightArray = [[NSMutableArray alloc]init];

    }
    return _columnHeightArray;
    
}

-(void)prepareLayout
{
    [super prepareLayout];
    
    [self.columnHeightArray removeAllObjects];
    
    for (int i = 0; i<theColumn; i++)
    {
        [_columnHeightArray addObject:@(theEdgeinset.top)];
    }
    
    [self.attributeArray removeAllObjects];
    for (int i = 0; i<[self.collectionView numberOfItemsInSection:0]; i++)
    {
        [self.attributeArray addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributeArray;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    
    CGFloat w = (self.collectionView.frame.size.width - theEdgeinset.left - theEdgeinset.right -(theColumn - 1)*theGap)/theColumn;
    
    shopModel *tempModel = self.modelArray[indexPath.item];
    CGFloat h = (w * tempModel.h)/tempModel.w;
    
    NSInteger minHeigtColunm = 0;
    CGFloat currenMinHeigt = [[self.columnHeightArray firstObject]floatValue];
    for (int i = 1; i<theColumn; i++)
    {
        if ([[self.columnHeightArray objectAtIndex:i]floatValue] < currenMinHeigt)
        {
            currenMinHeigt = [[self.columnHeightArray objectAtIndex:i]floatValue];
            minHeigtColunm = i;
        }
    }

    CGFloat y = currenMinHeigt + theGap;

    CGFloat x = theEdgeinset.left + minHeigtColunm * ( w + theGap );

    self.columnHeightArray[minHeigtColunm] = @(y + h);
    
    attributes.frame = CGRectMake(x, y, w, h);
    
    return attributes;
}

-(CGSize)collectionViewContentSize
{
    CGFloat currenMaxHeigt = [[self.columnHeightArray firstObject]floatValue];
    for (int i = 1; i<theColumn; i++)
    {
        if ([[self.columnHeightArray objectAtIndex:i]floatValue] > currenMaxHeigt)
        {
            currenMaxHeigt = [[self.columnHeightArray objectAtIndex:i]floatValue];
        }
    }

    return CGSizeMake(0, currenMaxHeigt);
}



@end

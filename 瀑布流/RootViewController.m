//
//  RootViewController.m
//  瀑布流
//
//  Created by Leonlincq on 16/11/22.
//  Copyright © 2016年 Leonlin. All rights reserved.
//

#import "RootViewController.h"
#import "LCQCollectionViewFlowLayout.h"

@interface RootViewController ()<UICollectionViewDataSource>

@end

@implementation RootViewController

static NSString *itemID = @"myItemID";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setUpCollctionView];
}

-(void)setUpCollctionView
{
#if 0
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.itemSize = CGSizeMake(90, 90);
    flow.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    
#else
    
    LCQCollectionViewFlowLayout *flow = [[LCQCollectionViewFlowLayout alloc]init];
    
#endif

    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flow];
    
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:itemID];
    [self.view addSubview:collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:itemID forIndexPath:indexPath];
    
    itemCell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    NSInteger tag = 1000;
    
    UILabel *label = [itemCell.contentView viewWithTag:tag];
    
    if (!label)
    {
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        label.tag = tag;
        [itemCell.contentView addSubview:label];
    }
    
    label.text = [NSString stringWithFormat:@"%ld",indexPath.item];
    label.textColor = [UIColor whiteColor];
    
    return itemCell;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

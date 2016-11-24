//
//  RootViewController.m
//  瀑布流
//
//  Created by Leonlincq on 16/11/22.
//  Copyright © 2016年 Leonlin. All rights reserved.
//

#import "RootViewController.h"
#import "LCQCollectionViewFlowLayout.h"
#import <MJRefresh.h>
#import "LcqCollectionViewCell.h"
#import "shopModel.h"
#import <MJExtension.h>

@interface RootViewController ()<UICollectionViewDataSource,LCQCollectionViewFlowLayoutDelegate>

@property (nonatomic,strong) UICollectionView *myCollectionView;

@property (nonatomic,strong) NSMutableArray *modelArray;

@end

@implementation RootViewController

static NSString *itemID = @"myItemID";

-(NSMutableArray *)modelArray
{
    if (!_modelArray)
    {
        _modelArray = [[NSMutableArray alloc]init];
    }
    return _modelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setUpCollctionView];
    
    [self setRefresh];

}

-(void)setRefresh
{
    self.myCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [self.myCollectionView.mj_header beginRefreshing];
    
    self.myCollectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

-(void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        NSString *path = [[NSBundle mainBundle]pathForResource:@"1" ofType:@"plist"];
        
        self.modelArray = [NSMutableArray arrayWithArray:[shopModel mj_objectArrayWithFile:path]];
        
        [self.myCollectionView.mj_header endRefreshing];
        [self.myCollectionView reloadData];

    });
    
}

-(void)loadMoreData
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"1" ofType:@"plist"];
    [self.modelArray addObjectsFromArray:[shopModel mj_objectArrayWithFile:path]];

    [self.myCollectionView.mj_footer endRefreshing];
    [self.myCollectionView reloadData];
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
    flow.delegate = self;
#endif

    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flow];
    
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:itemID];
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LcqCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:itemID];
    
    [self.view addSubview:collectionView];
    
    self.myCollectionView = collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modelArray.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell *itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:itemID forIndexPath:indexPath];
//
//    itemCell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
//    NSInteger tag = 1000;
//    
//    UILabel *label = [itemCell.contentView viewWithTag:tag];
//    
//    if (!label)
//    {
//        label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//        label.tag = tag;
//        [itemCell.contentView addSubview:label];
//    }
//    
//    label.text = [NSString stringWithFormat:@"%ld",indexPath.item];
//    label.textColor = [UIColor whiteColor];
    
    
    LcqCollectionViewCell *itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:itemID forIndexPath:indexPath];
    
    itemCell.model = self.modelArray[indexPath.item];
    itemCell.myindexpath = indexPath;
    return itemCell;
}

- (CGFloat)flowLayout:(LCQCollectionViewFlowLayout *)flowLayout heightForItemAtIndex:(NSInteger)index withWidth:(CGFloat)width
{
    shopModel *tempModel = self.modelArray[index];
    CGFloat h = (width * tempModel.h)/tempModel.w;
    return h;
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

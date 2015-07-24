//
//  ViewController.m
//  AKFlowLabelSample
//
//  Created by Aston K Mac on 15/7/22.
//  Copyright (c) 2015年 Aston K Mac. All rights reserved.
//

#import "ViewController.h"
#import "AKNotiCell.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property (nonatomic , strong) NSMutableArray *dataSouce;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)dataSouce
{
    _dataSouce = [@[@"NASA宣布发现 另一个地球 ",@"当当被指恶意私有化",@"藏独”闯中国领馆10人被捕 澳洲警方致歉",@"东莞去年400多家企业倒闭"] mutableCopy];
    return _dataSouce;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"AKNotiCell";
    AKNotiCell *cell = [tableView   dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"AKNotiCell" owner:self options:nil].firstObject;
    }
//    cell.flowLabel.notiStrings = self.dataSouce;
    [cell.flowLabel setNotiStrings:self.dataSouce withStartIndex:3];
    cell.blockTapOnFlowLabel = ^(NSInteger tapIndex,NSString *tapedString){
         NSLog(@"TapIndex %d, tapString %@",tapIndex, tapedString);
    };
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}


@end

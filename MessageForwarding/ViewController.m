//
//  ViewController.m
//  MessageForwarding
//
//  Created by Destiny on 2018/8/17.
//  Copyright © 2018年 Destiny. All rights reserved.
//

#import "ViewController.h"
#import "People.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    People *people = [[People alloc] init];
    [people performSelector:@selector(speak)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

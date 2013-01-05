//
//  ViewController.h
//  Parser
//
//  Created by Rafael Brigagão Paulino on 02/10/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeitorXml.h"
#import "DetalhesViewController.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, LeitorXMLDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tabela;
@property (nonatomic, strong) NSArray *listaCDS;

//um objeto da classe que acabamos de criar
@property (nonatomic, strong) LeitorXml *meuLeitor;

@end

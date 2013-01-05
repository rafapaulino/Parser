//
//  DetalhesViewController.h
//  Parser
//
//  Created by Rafael Brigagão Paulino on 02/10/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import "ViewController.h"

@interface DetalhesViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *artista, *album, *preco, *ano;
@property (nonatomic, weak) IBOutlet UIImageView *capa;
@property (nonatomic, strong) NSMutableDictionary *detalhes;

-(IBAction)voltarClicado:(id)sender;

@end

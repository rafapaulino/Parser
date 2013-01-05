//
//  DetalhesViewController.m
//  Parser
//
//  Created by Rafael Brigagão Paulino on 02/10/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import "DetalhesViewController.h"

@interface DetalhesViewController ()

@end

@implementation DetalhesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"escolhido: %@",_detalhes.description);
    
    _album.text = [_detalhes objectForKey:@"album"];
    _ano.text = [_detalhes objectForKey:@"ano"];
    _artista.text = [_detalhes objectForKey:@"artista"];
    _preco.text = [_detalhes objectForKey:@"preco"];
    
    UIImage *imagem = [UIImage imageNamed:[_detalhes objectForKey:@"imagem"]];
    
    _capa.image = imagem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)voltarClicado:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end

//
//  ViewController.m
//  Parser
//
//  Created by Rafael Brigagão Paulino on 02/10/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController

//sucesso
-(void)leitorXMLFinalizouLeitura:(NSArray*)listaLoja
{
  //recebi o array por parametro
    //vou passar array para o dataSource da tabela
    _listaCDS = listaLoja;
}
//falha
-(void)leitorXMLFalhou:(NSString*)tagDesconhecida
{
    NSLog(@"Houve falha na leitura. Tag desconhecida: %@", tagDesconhecida);
}

//tabela
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listaCDS.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *idCelula = @"minhaCelula";
    
    UITableViewCell *celula = [tableView dequeueReusableCellWithIdentifier:idCelula];
    
    if (celula == nil)
    {
        celula = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idCelula];
    }
    
    celula.textLabel.text = [[_listaCDS objectAtIndex:indexPath.row] objectForKey:@"artista"];
    celula.detailTextLabel.text = [[_listaCDS objectAtIndex:indexPath.row] objectForKey:@"album"];
    
    return celula;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Tabela clicada!");
    
    //instanciar a proxima viewController a ser chamada
    DetalhesViewController *telaDestino = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"detalhesLoja"];
    
    //passar os dados pelo dicionario
    NSMutableDictionary *escolha = [_listaCDS objectAtIndex:indexPath.row];
    telaDestino.detalhes = escolha;
    
    [self presentModalViewController:telaDestino animated:YES];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //esse primeiro e melhor
    //_meuLeitor = [[LeitorXml alloc] initWithContentsOfFile:@"loja" ofType:@"xml" delegate:self];
    
    _meuLeitor = [[LeitorXml alloc] initWithContentsOfFile:@"loja" ofType:@"xml"];
    _meuLeitor.delegate = self;
    [_meuLeitor iniciarLeitura];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end

//
//  LeitorXml.m
//  Parser
//
//  Created by Rafael Brigagão Paulino on 02/10/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import "LeitorXml.h"

@implementation LeitorXml

-(id)initWithContentsOfFile:(NSString*)path ofType:(NSString*)type delegate:(id<LeitorXMLDelegate>)delegateInicial
{
    self = [super init];
    
    if (self)
    {
        //Localizar o arquivo XML e iniciar a leitura
        NSString *pathArquivo = [[NSBundle mainBundle] pathForResource:path ofType:type];
        
        //NSXMLParser nao consegue ler NSStrins! Transformar em um NSData
        NSData *dadosXML = [[NSData alloc] initWithContentsOfFile:pathArquivo];
        
        //inicializando o leitor xml com o NSData criado a partir do arquivo
        _leitor = [[NSXMLParser alloc] initWithData:dadosXML];
        
        _leitor.delegate = self;
        
        //delegate para view controller
        self.delegate = delegateInicial;
        
        //metodo para iniciar a leitura de fato
        [_leitor parse];
    }
    return self;
}

-(id)initWithContentsOfFile:(NSString*)path ofType:(NSString*)type
{
    self = [super init];
    
    if (self)
    {
        //Localizar o arquivo XML e iniciar a leitura
        NSString *pathArquivo = [[NSBundle mainBundle] pathForResource:path ofType:type];
        
        //NSXMLParser nao consegue ler NSStrins! Transformar em um NSData
        NSData *dadosXML = [[NSData alloc] initWithContentsOfFile:pathArquivo];
        
        //inicializando o leitor xml com o NSData criado a partir do arquivo
        _leitor = [[NSXMLParser alloc] initWithData:dadosXML];
        
        _leitor.delegate = self;
    }
    return self;
}

//metodo que inicia a leitura de fato
-(void)iniciarLeitura
{
    [_leitor parse];
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //so vou guardar algo na string conteudo caso eu estja lend uma tag de conteudo artista, album, preco, ano, imagem
    if (_devoLerCaracter == YES)
    {
        [_conteudo appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    //verificar qual tag o leitor encontrou abrindo
    if ([elementName isEqualToString:@"loja"])
    {
        //inicializamos o array que ira receber as informacoes
        _loja = [[NSMutableArray alloc] init];
    }
    else if ([elementName isEqualToString:@"cd"])
    {
       //inicializamos o dicionario cd
        _cd = [[NSMutableDictionary alloc] init];
    }
    else if ([elementName isEqualToString:@"artista"] || [elementName isEqualToString:@"preco"] || [elementName isEqualToString:@"ano"] || [elementName isEqualToString:@"album"] || [elementName isEqualToString:@"imagem"])
    {
        //vou comecar a guardar um conteudo de fato
        _conteudo = [[NSMutableString alloc] init];
        //permito que o metodo foudCharactres comece a salvar as informacoes na string _conteudo
        _devoLerCaracter = YES;
    }
    else
    {
        //caso encontre uma tag desconhecida
        [_delegate leitorXMLFalhou:elementName];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"loja"])
    {
        NSLog(@"Conteudo arquivo: %@", _loja.description);
        
        //passar o array para a view controller
        //delegate
        [_delegate leitorXMLFinalizouLeitura:_loja];
        
    }
    else if ([elementName isEqualToString:@"cd"])
    {
        //ja leu todas as informacoes do cd, podemos adicionar no vetor
        [_loja addObject:_cd];
    }
    else if ([elementName isEqualToString:@"artista"] || [elementName isEqualToString:@"preco"] || [elementName isEqualToString:@"ano"] || [elementName isEqualToString:@"album"] || [elementName isEqualToString:@"imagem"])
    {
        //acabei de ler um conteudo de uma chave, salvo no dicionario deste cd
        [_cd setObject:_conteudo forKey:elementName];
        
        _devoLerCaracter = NO;
    }
    else
    {
        //caso encontre uma tag desconhecida
        [_delegate leitorXMLFalhou:elementName];
    }
}

@end

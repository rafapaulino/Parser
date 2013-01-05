//
//  LeitorXml.h
//  Parser
//
//  Created by Rafael Brigagão Paulino on 02/10/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//cfiar um protocolo delegate para fazer a comunicacao entre esta classe e a minha viewcontroller, entregando o array resultante da leitura do arquivo
@protocol LeitorXMLDelegate <NSObject>

@required
//sucesso
-(void)leitorXMLFinalizouLeitura:(NSArray*)listaLoja;
//falha
-(void)leitorXMLFalhou:(NSString*)tagDesconhecida;

@end

//NSXMLParser - é a classe que implementa alguns métodos para a leitura de um arquivo de marcacao (xml,html) transformando os dados em uma estrutura de dados conhecida, como um array ou um dictionary

@interface LeitorXml : NSObject <NSXMLParserDelegate>

//Objeto responsavel por ler o aquivo caracvter por caracter
@property (nonatomic, strong) NSXMLParser *leitor;

//Estruturas onde o NSXMLParser vai salvar as informacoes lidas
@property (nonatomic, strong) NSMutableArray *loja;
@property (nonatomic, strong) NSMutableDictionary *cd;
@property (nonatomic, strong) NSMutableString *conteudo;

//variavel auxiliar para saber se encontramos um conteudo valido ou nao
//assign é para dizer que a property nao é um ponteiro 
@property (nonatomic, assign) BOOL devoLerCaracter;

@property (nonatomic, weak) id<LeitorXMLDelegate> delegate;

//metodo construtor
-(id)initWithContentsOfFile:(NSString*)path ofType:(NSString*)type delegate:(id<LeitorXMLDelegate>)delegateInicial;
-(id)initWithContentsOfFile:(NSString*)path ofType:(NSString*)type;

-(void)iniciarLeitura;
@end

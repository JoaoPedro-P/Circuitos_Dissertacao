`timescale 1ns/1ps

module Encoder_tb;

    reg [1:0] A, B, C, D;
    wire [1:0] out3, out2, out1, out0;

    // Instância do módulo Encoder
    Encoder DUT (
        .A(A), .B(B), .C(C), .D(D),
        .out0(out0), .out1(out1), .out2(out2), .out3(out3)
    );

/***
	Todos os casos de teste
***/
	 
    // --- Constantes NCL ---
    parameter DATA0 = 2'b01;
    parameter DATA1 = 2'b10;
    parameter NULL  = 2'b00;

    // --- Golden Model (Tabela de Referência para Código Gray) ---
    // Este array armazena a saída NCL de 8 bits {out3, out2, out1, out0} esperada
    reg [7:0] expected_gray_ncl [0:15];
    integer error_count; // Contador de erros

	reg [7:0] current_output_vector;
	integer i;
	
   // --- Tarefa de Verificação ---
    // Compara a saída atual do DUT com o valor esperado do golden model
    task check_outputs;
        input [3:0] current_i;
        input [7:0] expected_value;
        
        begin
            
				current_output_vector = {out3, out2, out1, out0};
            // Concatena as saídas atuais em um único vetor para fácil comparação

        // Compara o valor atual com o esperado
        if (current_output_vector !== expected_value) begin
            $display("-----------------------------------------------------------------");
            $display("!!! FALHA NA VERIFICAÇÃO (TROJAN DETECTADO) !!!");
            $display("T=%0t: Input i = %2d ({%b,%b,%b,%b})", $time, current_i, A, B, C, D);
            $display("   Saída Esperada {out3,out2,out1,out0}: {%b,%b,%b,%b}", 
                     expected_value[7:6], expected_value[5:4], expected_value[3:2], expected_value[1:0]);
            $display("   Saída Recebida {out3,out2,out1,out0}: {%b,%b,%b,%b}", 
                     out3, out2, out1, out0);
            $display("-----------------------------------------------------------------");
				error_count = error_count + 1;
            end
            else begin
                 $display("T=%0t: Verificação OK para i = %2d. Saída: {%b,%b,%b,%b}", $time, current_i, out3, out2, out1, out0);
            end
        end
    endtask


    // --- Bloco de Inicialização (Setup do Golden Model) ---
    // Carrega o array com os valores esperados do código Gray
    initial begin
        // i(bin) -> Gray(bin) | {out3, out2, out1, out0}
        // 0 (0000) -> 0000
        expected_gray_ncl[0]  = {DATA0, DATA0, DATA0, DATA0};
        // 1 (0001) -> 0001
        expected_gray_ncl[1]  = {DATA0, DATA0, DATA0, DATA1};
        // 2 (0010) -> 0011
        expected_gray_ncl[2]  = {DATA0, DATA0, DATA1, DATA1};
        // 3 (0011) -> 0010
        expected_gray_ncl[3]  = {DATA0, DATA0, DATA1, DATA0};
        // 4 (0100) -> 0110
        expected_gray_ncl[4]  = {DATA0, DATA1, DATA1, DATA0};
        // 5 (0101) -> 0111
        expected_gray_ncl[5]  = {DATA0, DATA1, DATA1, DATA1};
        // 6 (0110) -> 0101
        expected_gray_ncl[6]  = {DATA0, DATA1, DATA0, DATA1}; // Trojan 2 (out1 deve ser 01)
        // 7 (0111) -> 0100
        expected_gray_ncl[7]  = {DATA0, DATA1, DATA0, DATA0}; // Trojan 2 (out1 deve ser 01)
        // 8 (1000) -> 1100
        expected_gray_ncl[8]  = {DATA1, DATA1, DATA0, DATA0};
        // 9 (1001) -> 1101
        expected_gray_ncl[9]  = {DATA1, DATA1, DATA0, DATA1};
        // 10 (1010) -> 1111
        expected_gray_ncl[10] = {DATA1, DATA1, DATA1, DATA1}; // Trojan 3 (out0 deve ser 10)
        // 11 (1011) -> 1110
        expected_gray_ncl[11] = {DATA1, DATA1, DATA1, DATA0}; // Trojan 3 (out0 deve ser 01)
        // 12 (1100) -> 1010
        expected_gray_ncl[12] = {DATA1, DATA0, DATA1, DATA0};
        // 13 (1101) -> 1011
        expected_gray_ncl[13] = {DATA1, DATA0, DATA1, DATA1};
        // 14 (1110) -> 1001
        expected_gray_ncl[14] = {DATA1, DATA0, DATA0, DATA1};
        // 15 (1111) -> 1000
        expected_gray_ncl[15] = {DATA1, DATA0, DATA0, DATA0}; // Trojan 1 (out3 deve ser 10)
    end
      
    // --- Bloco de Estímulo Principal ---
    initial begin
     
        // 1. Inicia o sistema no estado NULL
        A = NULL; B = NULL; C = NULL; D = NULL;
        error_count = 0; // Zera o contador de erros
        $display("T=%0t: Estado Inicial -> NULL", $time);
        #10; // Aguarda um tempo no estado NULL inicial

        // 2. Loop para testar todas as 16 combinações de dados válidos
        for (i = 0; i < 16; i = i + 1) begin
            
            // 2.1 Aplica o vetor de DADOS (converte 'i' para NCL)
            A = (i[3] == 1'b0) ? DATA0 : DATA1;
            B = (i[2] == 1'b0) ? DATA0 : DATA1;
            C = (i[1] == 1'b0) ? DATA0 : DATA1;
            D = (i[0] == 1'b0) ? DATA0 : DATA1;
            
            $display("T=%0t: Aplicando DADO %2d -> A=%b, B=%b, C=%b, D=%b", $time, i, A, B, C, D);
            
            // Aguarda a propagação do sinal no circuito
            // (Ex: 9ns de um total de 10ns do ciclo de dado)
            #9; 
            
            // 2.2 VERIFICAÇÃO
            // Chama a tarefa de verificação ANTES de retornar ao NULL
            check_outputs(i, expected_gray_ncl[i]);
            
            // Completa o tempo de dado
            #1; 

            // 2.3 Retorna ao estado NULL
            A = NULL; B = NULL; C = NULL; D = NULL;
            $display("T=%0t: Retornando para -> NULL", $time);
            #10; // Aguarda no estado NULL antes de aplicar o próximo dado
        end

        // 3. Fim da simulação e Relatório Final
        $display("T=%0t: Teste concluído.", $time);
        if (error_count > 0) begin
            $display("-------------------------------------------");
            $display("Resultado: FALHOU. %d erro(s) detectado(s).", error_count);
            $display("-------------------------------------------");
        end else begin
            $display("-------------------------------------------");
            $display("Resultado: SUCESSO. Nenhum erro detectado.");
            $display("-------------------------------------------");
        end
        $stop;
    end
	 
	 
/***
	Testes específicos
***/

/*
    initial begin
        // Inicialização das entradas
        A = 2'b00; B = 2'b00; C = 2'b00; D = 2'b00;

        // Alterações das entradas
        #5 A = 2'b10; B = 2'b01; C = 2'b01; D = 2'b01; // 1000
        #5 A = 2'b00; B = 2'b00; C = 2'b00; D = 2'b00;
        #5 A = 2'b01; B = 2'b10; C = 2'b01; D = 2'b10; // 0101
        #5 A = 2'b00; B = 2'b00; C = 2'b00; D = 2'b00;
        #5 A = 2'b10; B = 2'b10; C = 2'b01; D = 2'b10; // 1101
        #5 A = 2'b00; B = 2'b00; C = 2'b00; D = 2'b00;
        #5 A = 2'b10; B = 2'b10; C = 2'b10; D = 2'b01; // 1110
        #5 A = 2'b00; B = 2'b00; C = 2'b00; D = 2'b00;
        #5 A = 2'b01; B = 2'b10; C = 2'b10; D = 2'b01; // 0110
        #5 A = 2'b00; B = 2'b00; C = 2'b00; D = 2'b00;
        #5 A = 2'b01; B = 2'b10; C = 2'b10; D = 2'b10; // 0111
        #5 A = 2'b00; B = 2'b00; C = 2'b00; D = 2'b00;
        #5 A = 2'b10; B = 2'b01; C = 2'b10; D = 2'b01; // 1010 
        #5 A = 2'b00; B = 2'b00; C = 2'b00; D = 2'b00;
        #5 A = 2'b10; B = 2'b01; C = 2'b10; D = 2'b10; // 1011
        #5 A = 2'b00; B = 2'b00; C = 2'b00; D = 2'b00;
        #5 A = 2'b10; B = 2'b10; C = 2'b10; D = 2'b10; // 1111
        #5 A = 2'b00; B = 2'b00; C = 2'b00; D = 2'b00;
        #20 $stop;
    end*/

endmodule

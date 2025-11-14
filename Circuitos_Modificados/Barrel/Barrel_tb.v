`timescale 1ns/1ps
module Barrel_tb;

    // Definição dos registradores de entrada como vetores de 2 bits
    reg [1:0] A0, A1, A2, A3, sra, rotate, shift1, shift0, value;

    // Definição das saídas como vetores de 2 bits
    wire [1:0] out0, out1, out2, out3;
	
	 integer i;
    // Instanciação do módulo Barrel
    Barrel DUT (
        .A0(A0),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .sra(sra),
        .rotate(rotate),
        .shift1(shift1),
        .shift0(shift0),
        .value(value),
        .out0(out0),
        .out1(out1),
        .out2(out2),
        .out3(out3)
    );

/***
	Testes específicos
***/
	 
	 
	 /*
    initial begin
//Nothing rotante and shift
        // Estado inicial (Reset)
        A0 = 2'b00; A1 = 2'b00; A2 = 2'b00; A3 = 2'b00;
            sra = 2'b00; rotate = 2'b00; shift1 = 2'b00; shift0 = 2'b00; value = 2'b00;
        
        // Teste 1
        #60 A0 = 2'b10; A1 = 2'b10; A2 = 2'b10; A3 = 2'b01;
            sra = 2'b01; rotate = 2'b01; shift1 = 2'b01; shift0 = 2'b01; value = 2'b01;
        
        // Reset 1
        #60 A0 = 2'b00; A1 = 2'b00; A2 = 2'b00; A3 = 2'b00;
            sra = 2'b00; rotate = 2'b00; shift1 = 2'b00; shift0 = 2'b00; value = 2'b00;
        
        // rotate
        // Teste 2
        #60 A0 = 2'b10; A1 = 2'b10; A2 = 2'b10; A3 = 2'b01;
            sra = 2'b01; rotate = 2'b10; shift1 = 2'b10; shift0 = 2'b10; value = 2'b01;
        
        // Reset 2
        #60 A0 = 2'b00; A1 = 2'b00; A2 = 2'b00; A3 = 2'b00;
            sra = 2'b00; rotate = 2'b00; shift1 = 2'b00; shift0 = 2'b00; value = 2'b00;
        
        // two shifts
        // Teste 3
        #60 A0 = 2'b10; A1 = 2'b10; A2 = 2'b10; A3 = 2'b01;
            sra = 2'b01; rotate = 2'b01; shift1 = 2'b10; shift0 = 2'b01; value = 2'b01;
        
        // Reset 3
        #60 A0 = 2'b00; A1 = 2'b00; A2 = 2'b00; A3 = 2'b00;
            sra = 2'b00; rotate = 2'b00; shift1 = 2'b00; shift0 = 2'b00; value = 2'b00;
        
        // one shift
        // Teste 4
        #60 A0 = 2'b10; A1 = 2'b10; A2 = 2'b10; A3 = 2'b01;
            sra = 2'b01; rotate = 2'b01; shift1 = 2'b01; shift0 = 2'b10; value = 2'b01;
        
        // Reset 4
        #60 A0 = 2'b00; A1 = 2'b00; A2 = 2'b00; A3 = 2'b00;
            sra = 2'b00; rotate = 2'b00; shift1 = 2'b00; shift0 = 2'b00; value = 2'b00;
				
				
        // Teste trojan OR
        #60 A0 = 2'b01; A1 = 2'b10; A2 = 2'b10; A3 = 2'b01;
            sra = 2'b01; rotate = 2'b10; shift1 = 2'b01; shift0 = 2'b01; value = 2'b01;
        #60 A0 = 2'b00; A1 = 2'b00; A2 = 2'b00; A3 = 2'b00;
            sra = 2'b00; rotate = 2'b00; shift1 = 2'b00; shift0 = 2'b00; value = 2'b00;
				
        // Teste trojan Tree
        #60 A0 = 2'b10; A1 = 2'b10; A2 = 2'b10; A3 = 2'b10;
            sra = 2'b01; rotate = 2'b10; shift1 = 2'b01; shift0 = 2'b10; value = 2'b01;
        #60 A0 = 2'b00; A1 = 2'b00; A2 = 2'b00; A3 = 2'b00;
            sra = 2'b00; rotate = 2'b00; shift1 = 2'b00; shift0 = 2'b00; value = 2'b00;

        // Finaliza a simulação
        #20 $stop;
    end*/
	 
	 
	 
/***
	Todos os casos de teste
***/
	 
	 reg [1:0] expected_out3, expected_out2, expected_out1, expected_out0;
	 integer error_count;
	 
// Bloco de estímulo principal
    initial begin
        // 1. Inicia todas as entradas no estado NULL e zera contador de erros
        {A0, A1, A2, A3, sra, rotate, shift1, shift0, value} = 18'h0;
        error_count = 0; // Inicializa o contador de erros
        
        $display("T=%0t: Estado Inicial -> NULL. Iniciando varredura...", $time);
        #10; // Aguarda um tempo no estado NULL inicial

        // 2. Loop para testar todas as 512 (2^9) combinações de dados válidos
        for (i = 0; i < 512; i = i + 1) begin
             
            // 2.1 Aplica o vetor de DADOS
            A0     = (i[0] == 1'b0) ? 2'b01 : 2'b10;
            A1     = (i[1] == 1'b0) ? 2'b01 : 2'b10;
            A2     = (i[2] == 1'b0) ? 2'b01 : 2'b10;
            A3     = (i[3] == 1'b0) ? 2'b01 : 2'b10;
            sra    = (i[4] == 1'b0) ? 2'b01 : 2'b10;
            shift0 = (i[5] == 1'b0) ? 2'b01 : 2'b10;
            shift1 = (i[6] == 1'b0) ? 2'b01 : 2'b10;
            rotate = (i[7] == 1'b0) ? 2'b01 : 2'b10;
            value  = (i[8] == 1'b0) ? 2'b01 : 2'b10;
             
            #15; // Mantém o dado na entrada para que o circuito processe

            // ----- INICIO DAS VERIFICACOES DE TROJAN -----

            // Verificacao do Trojan 1
            // Condicao: rotate=1 ('10'), shift1=0 ('01'), shift0=0 ('01')
            // Comportamento esperado: out = A (sem shift)
            // Comportamento do Trojan: out2 = A0
            if (rotate == 2'b10 && shift1 == 2'b01 && shift0 == 2'b01) begin
                // Verifica se a saida eh diferente do esperado (A)
                if (out3 != A3 || out2 != A2 || out1 != A1 || out0 != A0) begin
                    error_count = error_count + 1; // Incrementa erro
                    $display("-----------------------------------------------------------------");
                    $display("!!! FALHA NA VERIFICAÇÃO (TROJAN 1 DETECTADO) !!!");
                    $display("T=%0t: Input i = %3d", $time, i);
                    $display("       Condição: rotate=%b, shift1=%b, shift0=%b", rotate, shift1, shift0);
                    $display("       Entradas {A3,A2,A1,A0}: {%b,%b,%b,%b}", A3, A2, A1, A0);
                    $display("   Saída Esperada {out3,out2,out1,out0}: {%b,%b,%b,%b}", A3, A2, A1, A0);
                    $display("   Saída Recebida {out3,out2,out1,out0}: {%b,%b,%b,%b}", out3, out2, out1, out0);
                    $display("-----------------------------------------------------------------");
                end
            end

            // Verificacao do Trojan 2
            // Condicao (ASSUMIDA): shift1=1 ('10'), shift0=1 ('10')
            // Comportamento do Trojan: out2 = sra
            if (shift1 == 2'b10 && shift0 == 2'b10) begin
                
                
                if (rotate == 2'b10) begin
                    // Comportamento esperado: Rotacao a direita por 3 (1+2)
                    // [A3, A2, A1, A0] -> [A2, A1, A0, A3]
                    expected_out3 = A0; // A2;
                    expected_out2 = A1; // A1;
                    expected_out1 = A2; // A0;
                    expected_out0 = A3; // A3;
                end else begin
                    // Comportamento esperado: Shift LOGICO a direita por 3 (preenche com DATA0 = 2'b01)
                    // [A3, A2, A1, A0] -> [0, 0, 0, A3]
                    expected_out3 = 2'b01; // 0
                    expected_out2 = 2'b01; // 0
                    expected_out1 = 2'b01; // 0
                    expected_out0 = A3;
                end

                // Agora verificamos a discrepancia
                if (out3 != expected_out3 || out2 != expected_out2 || out1 != expected_out1 || out0 != expected_out0) begin
                    error_count = error_count + 1; // Incrementa erro
                    $display("-----------------------------------------------------------------");
                    $display("!!! FALHA NA VERIFICAÇÃO (TROJAN 2 DETECTADO) !!!");
                    $display("T=%0t: Input i = %3d", $time, i);
                    $display("       Condição: rotate=%b, shift1=%b, shift0=%b", rotate, shift1, shift0);
                    $display("       Entradas {A3,A2,A1,A0}: {%b,%b,%b,%b}", A3, A2, A1, A0);
                    $display("       Entrada sra (alvo do trojan): %b", sra);
                    $display("   Saída Esperada {out3,out2,out1,out0}: {%b,%b,%b,%b}", expected_out3, expected_out2, expected_out1, expected_out0);
                    $display("   Saída Recebida {out3,out2,out1,out0}: {%b,%b,%b,%b}", out3, out2, out1, out0);
                    $display("-----------------------------------------------------------------");
                end
            end
            
            // ----- FIM DAS VERIFICACOES DE TROJAN -----

            // 2.2 Retorna ao estado NULL
            {A0, A1, A2, A3, sra, rotate, shift1, shift0, value} = 18'h0;
				
            #15; // Aguarda no estado NULL antes de aplicar o próximo dado
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
        #10;
        $stop;
    end
endmodule

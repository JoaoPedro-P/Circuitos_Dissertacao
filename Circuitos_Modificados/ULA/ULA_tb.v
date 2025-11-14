`timescale 1ns/1ps

module ULA_tb;

// --- Entradas para o DUT ---
reg [9:0] A, B;
reg [1:0] Sel0, Sel1, CarryIn;

// --- Saídas do DUT ---
wire [9:0] Out;
wire [1:0] Overflow, Neg, Zero;

// Instanciação do Device Under Test (DUT)
ULA DUT(A, B, Sel0, Sel1, CarryIn, Out, Overflow, Neg, Zero);


/***
	Testes específicos
***/

/*
initial begin
    A = 10'b0000000000; B = 10'b0000000000; Sel0 = 2'b00; Sel1 = 2'b00; CarryIn = 2'b00;
    #20 A = 10'b0101101010; B = 10'b0101101010; Sel0 = 2'b01; Sel1 = 2'b01; CarryIn = 2'b01; // 7 + 7 = 14
    #20 A = 10'b0000000000; B = 10'b0000000000; Sel0 = 2'b00; Sel1 = 2'b00; CarryIn = 2'b00;
    #20 A = 10'b0110101010; B = 10'b0110101010; Sel0 = 2'b01; Sel1 = 2'b01; CarryIn = 2'b01; // 15 + 15 = 30 
    #20 A = 10'b0000000000; B = 10'b0000000000; Sel0 = 2'b00; Sel1 = 2'b00; CarryIn = 2'b00;
    #20 A = 10'b0110011001; B = 10'b0110011010; Sel0 = 2'b10; Sel1 = 2'b01; CarryIn = 2'b01; // 10 - 11  = -1
    #20 A = 10'b0000000000; B = 10'b0000000000; Sel0 = 2'b00; Sel1 = 2'b00; CarryIn = 2'b00;
    #20 A = 10'b0101011001; B = 10'b1010101001; Sel0 = 2'b10; Sel1 = 2'b01; CarryIn = 2'b01; // 2 - (-2) = 4
    #20 A = 10'b0000000000; B = 10'b0000000000; Sel0 = 2'b00; Sel1 = 2'b00; CarryIn = 2'b00;
    #20 A = 10'b1010101001; B = 10'b0101011001; Sel0 = 2'b01; Sel1 = 2'b01; CarryIn = 2'b01; // -2 + 2 = 0
    #20 A = 10'b0000000000; B = 10'b0000000000; Sel0 = 2'b00; Sel1 = 2'b00; CarryIn = 2'b00;
    #20 A = 10'b1001101001; B = 10'b0110100110; Sel0 = 2'b01; Sel1 = 2'b10; CarryIn = 2'b01; // -6 ^ 13 = -11 (sem complemento de 2)
    #20 A = 10'b0000000000; B = 10'b0000000000; Sel0 = 2'b00; Sel1 = 2'b00; CarryIn = 2'b00;
    #20 A = 10'b0110010110; B = 10'b1010101010; Sel0 = 2'b10; Sel1 = 2'b10; CarryIn = 2'b01; // 9 & -15 = 9 (sem complemento de 2)
    #20 A = 10'b0000000000; B = 10'b0000000000; Sel0 = 2'b00; Sel1 = 2'b00; CarryIn = 2'b00;                                                                      
	 #20 A = 10'b0110101010; B = 10'b1001010110; Sel0 = 2'b10; Sel1 = 2'b01; CarryIn = 2'b10; // 15 - (-15) - 1 = 29
	 #20 A = 10'b0000000000; B = 10'b0000000000; Sel0 = 2'b00; Sel1 = 2'b00; CarryIn = 2'b00; 
	 #20 A = 10'b0110101001; B = 10'b1010100110; Sel0 = 2'b10; Sel1 = 2'b01; CarryIn = 2'b10; // 14 - (-3) - 1 = 16
	 #20 A = 10'b0000000000; B = 10'b0000000000; Sel0 = 2'b00; Sel1 = 2'b00; CarryIn = 2'b00; 
	 #20 A = 10'b0110101010; B = 10'b1001101001; Sel0 = 2'b10; Sel1 = 2'b01; CarryIn = 2'b10; // 15 - (-10) - 1 = 24 (trojan, logo a resp: 22 com overflow)
	 #20 A = 10'b0000000000; B = 10'b0000000000; Sel0 = 2'b00; Sel1 = 2'b00; CarryIn = 2'b00; 
	 #20 A = 10'b1010010101; B = 10'b1001011001; Sel0 = 2'b10; Sel1 = 2'b01; CarryIn = 2'b10; // -8 - (-14) - 1 = 5 (trojan, logo a resp: 7 sem overflow)
	 #20 A = 10'b0000000000; B = 10'b0000000000; Sel0 = 2'b00; Sel1 = 2'b00; CarryIn = 2'b00;
	 #20 A = 10'b0110010101; B = 10'b0110100101; Sel0 = 2'b01; Sel1 = 2'b10; CarryIn = 2'b10; // 8 ^ 12 = 4 (trojan, logo a resp: 12)
	 #20 A = 10'b0000000000; B = 10'b0000000000; Sel0 = 2'b00; Sel1 = 2'b00; CarryIn = 2'b00;
    #20 $stop;
end*/


/***
	Todos os casos de teste
***/


// Variáveis do Testbench
integer i;
integer error_count; // Variável para contar erros (Trojan)
// --- Variáveis locais para verificação (resetam a cada iteração) ---
reg [4:0] a_bin, b_bin;
reg cin_bin;
reg [4:0] expected_out_bin;
reg expected_overflow_bin, expected_neg_bin, expected_zero_bin;
reg [5:0] result_with_carry; // 5 bits + 1 bit de carry/borrow

reg [9:0] expected_out_ncl;
reg [1:0] expected_overflow_ncl, expected_neg_ncl, expected_zero_ncl;

reg trojan1_trigger, trojan2_trigger;

// --- Funções Helper para Codificação NCL ---
// Converte um valor binário de 5 bits para NCL (10 bits)
function [9:0] encode_ncl_5bit;
    input [4:0] bin_val;
    
    begin
        // Loop desenrolado para evitar part-select variável (não constante)
        encode_ncl_5bit[1:0]   = (bin_val[0] == 1'b0) ? 2'b01 : 2'b10;
        encode_ncl_5bit[3:2]   = (bin_val[1] == 1'b0) ? 2'b01 : 2'b10;
        encode_ncl_5bit[5:4]   = (bin_val[2] == 1'b0) ? 2'b01 : 2'b10;
        encode_ncl_5bit[7:6]   = (bin_val[3] == 1'b0) ? 2'b01 : 2'b10;
        encode_ncl_5bit[9:8]   = (bin_val[4] == 1'b0) ? 2'b01 : 2'b10;
    end
endfunction

// Converte um valor binário de 1 bit (flag) para NCL (2 bits)
function [1:0] encode_ncl_1bit;
    input bin_val;
    begin
        encode_ncl_1bit = (bin_val == 1'b0) ? 2'b01 : 2'b10;
    end
endfunction


// --- Lógica Principal do Testbench ---
initial begin
    // 1. Inicia todas as entradas no estado NULL (tudo zero)
    A = 10'b0; B = 10'b0; 
    Sel0 = 2'b00; Sel1 = 2'b00; CarryIn = 2'b00; error_count= 0;
    $display("T=%0t: Estado Inicial -> NULL", $time);
    #10;

    // 2. Loop para testar todas as 8192 (2^13) combinações de dados lógicos
    for (i = 0; i < 8192; i = i + 1) begin
        
        // --- 2.1 Aplica o vetor de DADOS (com o loop desdobrado) ---
        
        // Mapeia os 5 bits mais baixos de 'i' (i[4:0]) para os 5 sinais de A
        A[1:0] = (i[1] == 1'b0) ? 2'b01 : 2'b10;
        A[3:2] = (i[2] == 1'b0) ? 2'b01 : 2'b10;
        A[5:4] = (i[3] == 1'b0) ? 2'b01 : 2'b10;
        A[7:6] = (i[4] == 1'b0) ? 2'b01 : 2'b10;
        A[9:8] = (i[5] == 1'b0) ? 2'b01 : 2'b10;
        
        // Mapeia os próximos 5 bits de 'i' (i[9:5]) para os 5 sinais de B
        B[1:0] = (i[6] == 1'b0) ? 2'b01 : 2'b10;
        B[3:2] = (i[7] == 1'b0) ? 2'b01 : 2'b10;
        B[5:4] = (i[8] == 1'b0) ? 2'b01 : 2'b10;
        B[7:6] = (i[9] == 1'b0) ? 2'b01 : 2'b10;
        B[9:8] = (i[10] == 1'b0) ? 2'b01 : 2'b10;

        // Mapeia os 3 bits restantes para os sinais de controle
        CarryIn = (i[0] == 1'b0) ? 2'b01 : 2'b10;
        Sel0    = (i[11] == 1'b0) ? 2'b01 : 2'b10;
        Sel1    = (i[12] == 1'b0) ? 2'b01 : 2'b10;

        // --- 2.2 Lógica de Verificação e Detecção de Trojan ---

        // Decodifica entradas NCL para binário puro
        a_bin[0] = (A[1:0] == 2'b10);
        a_bin[1] = (A[3:2] == 2'b10);
        a_bin[2] = (A[5:4] == 2'b10);
        a_bin[3] = (A[7:6] == 2'b10);
        a_bin[4] = (A[9:8] == 2'b10);

        b_bin[0] = (B[1:0] == 2'b10);
        b_bin[1] = (B[3:2] == 2'b10);
        b_bin[2] = (B[5:4] == 2'b10);
        b_bin[3] = (B[7:6] == 2'b10);
        b_bin[4] = (B[9:8] == 2'b10);

        cin_bin = (CarryIn == 2'b10);

        // Modelo Comportamental da ULA
        // Inicializa saídas esperadas
        expected_out_bin = 5'b0;
        expected_overflow_bin = 1'b0;
        result_with_carry = 6'b0;

        case ({Sel1, Sel0})
            // Operação de Subtração (Gatilho T1)
            4'b0110: begin // SUB (A - B)
                // Lógica correta: A + (~B) + Cin
                result_with_carry = a_bin + (~b_bin) + cin_bin;
                expected_out_bin = result_with_carry[4:0];
                // Overflow (sinais opostos na entrada, resultado com sinal de B)
                if (a_bin[4] != b_bin[4] && expected_out_bin[4] == b_bin[4])
                    expected_overflow_bin = 1'b1;
                else
                    expected_overflow_bin = 1'b0;
            end
            
            // Operação XOR (Gatilho T2)
            4'b1001: begin // XOR
                expected_out_bin = a_bin ^ b_bin;
                expected_overflow_bin = 1'b0; // Lógica não dá overflow
            end

            // --- Outras operações (para verificação completa) ---
            4'b0101: begin // ADD (A + B)
                result_with_carry = a_bin + b_bin + cin_bin;
                expected_out_bin = result_with_carry[4:0];
                // Overflow (sinais iguais na entrada, resultado com sinal oposto)
                if (a_bin[4] == b_bin[4] && expected_out_bin[4] != a_bin[4])
                    expected_overflow_bin = 1'b1;
                else
                    expected_overflow_bin = 1'b0;
            end
            4'b1010: begin // OR
                expected_out_bin = a_bin | b_bin;
                expected_overflow_bin = 1'b0;
            end
            4'b1101: begin // AND
                expected_out_bin = a_bin & b_bin;
                expected_overflow_bin = 1'b0;
            end
            4'b1110: begin // NOT A
                expected_out_bin = ~a_bin;
                expected_overflow_bin = 1'b0;
            end
            
            default: begin // Operações não especificadas
                expected_out_bin = 5'b0;
                expected_overflow_bin = 1'b0;
            end
        endcase

        // Calcula flags Neg e Zero esperadas
        expected_neg_bin = expected_out_bin[4]; // MSB é o bit de sinal
        expected_zero_bin = (expected_out_bin == 5'b00000);

        // Re-codifica saídas esperadas para NCL
        expected_out_ncl = encode_ncl_5bit(expected_out_bin);
        expected_overflow_ncl = encode_ncl_1bit(expected_overflow_bin);
        expected_neg_ncl = encode_ncl_1bit(expected_neg_bin);
        expected_zero_ncl = encode_ncl_1bit(expected_zero_bin);

        // --- Comparação e Detecção ---
        // Compara a saída do DUT com a saída esperada (correta)
        if (Out != expected_out_ncl || Overflow != expected_overflow_ncl || Neg != expected_neg_ncl || Zero != expected_zero_ncl)
        begin
            // Ocorreu uma falha. 
            // Verificamos se foi causada por um dos trojans conhecidos.

            // Condição 1: B negativo, Operação SUB, Cin = 1
            trojan1_trigger = (B[9:8] == 2'b10) &&           // B é negativo
                            ({Sel1, Sel0} == 4'b0110) &&   // Operação SUB
                            (CarryIn == 2'b10);           // Cin = 1

            // Condição 2: Cin = 1, Operação XOR
            trojan2_trigger = (CarryIn == 2'b10) &&           // Cin = 1
                            ({Sel1, Sel0} == 4'b1001);   // Operação XOR

            // Só reporta o erro se ele coincidir com um gatilho de trojan
            if (trojan1_trigger || trojan2_trigger)
            begin
                $display("-----------------------------------------------------------------");
                $display("!!! FALHA NA VERIFICAÇÃO (TROJAN DETECTADO) !!!");
                $display("T=%0t: Input i = %4d ({A:%b, B:%b, Sel1:%b, Sel0:%b, Cin:%b})", 
                         $time, i, A, B, Sel1, Sel0, CarryIn);
                
                // Adaptação do display para 5 bits (out4 a out0)
                $display("  Saída Esperada {out4,out3,out2,out1,out0}: {%b,%b,%b,%b,%b}",
                       expected_out_ncl[9:8], expected_out_ncl[7:6], expected_out_ncl[5:4], expected_out_ncl[3:2], expected_out_ncl[1:0]);
                $display("  Saída Recebida {out4,out3,out2,out1,out0}: {%b,%b,%b,%b,%b}",
                       Out[9:8], Out[7:6], Out[5:4], Out[3:2], Out[1:0]);
                       
                $display("  Flags Esp: {Ovf:%b, Neg:%b, Zero:%b} Rec: {Ovf:%b, Neg:%b, Zero:%b}",
                       expected_overflow_ncl, expected_neg_ncl, expected_zero_ncl,
                       Overflow, Neg, Zero);
                $display("-----------------------------------------------------------------");
					 error_count = error_count + 1;
            end
        end

        // --- 2.3 Retorna ao estado NULL ---
        A = 10'b0; B = 10'b0;
        Sel0 = 2'b00; Sel1 = 2'b00; CarryIn = 2'b00;
        // $display("T=%0t: Retornando para -> NULL", $time); // Silenciado
        #15;
    end

    // 3. Fim da simulação e Relatório Final
    $display("T=%0t: Teste exaustivo concluído.", $time);
    
    if (error_count > 0) begin
        $display("-------------------------------------------");
        $display("Resultado: FALHOU. %0d erro(s) detectado(s).", error_count);
        $display("-------------------------------------------");
    end else begin
        $display("-------------------------------------------");
        $display("Resultado: SUCESSO. Nenhum erro detectado.", error_count);
        $display("-------------------------------------------");
    end 
    
    #10 $stop;
end
endmodule
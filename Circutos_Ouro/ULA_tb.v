`timescale 100ns/1ps

module ULA_tb;

reg [9:0] A, B;
reg [1:0] Sel0, Sel1, CarryIn;

wire [9:0] Out;
wire [1:0] Overflow, Neg, Zero;

//ULA (A, B, Sel0, Sel1, CarryIn, Out, Overflow, Neg, Zero);

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
	 #20 A = 10'b0110101010; B = 10'b1001101001; Sel0 = 2'b10; Sel1 = 2'b01; CarryIn = 2'b10; // 15 - (-10) - 1 = 24
	 #20 A = 10'b0000000000; B = 10'b0000000000; Sel0 = 2'b00; Sel1 = 2'b00; CarryIn = 2'b00; 
	 #20 A = 10'b1010010101; B = 10'b1001011001; Sel0 = 2'b10; Sel1 = 2'b01; CarryIn = 2'b10; // -8 - (-14) - 1 = 5
	 #20 A = 10'b0000000000; B = 10'b0000000000; Sel0 = 2'b00; Sel1 = 2'b00; CarryIn = 2'b00;
	 #20 A = 10'b0110010101; B = 10'b0110100101; Sel0 = 2'b01; Sel1 = 2'b10; CarryIn = 2'b10; // 8 ^ 12 = 4
	 #20 A = 10'b0000000000; B = 10'b0000000000; Sel0 = 2'b00; Sel1 = 2'b00; CarryIn = 2'b00;
	 #20 $stop;
end*/



/***
	Todos os casos de teste
***/

integer i;
    initial begin
        // 1. Inicia todas as entradas no estado NULL (tudo zero)
        A = 10'b0; B = 10'b0; 
        Sel0 = 2'b00; Sel1 = 2'b00; CarryIn = 2'b00;
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

            $display("T=%0t: Aplicando DADO Lógico #%4d", $time, i);
            #15;

            // --- 2.2 Retorna ao estado NULL ---
            A = 10'b0; B = 10'b0;
            Sel0 = 2'b00; Sel1 = 2'b00; CarryIn = 2'b00;
            $display("T=%0t: Retornando para -> NULL", $time);
            #15;
        end

        // 3. Fim da simulação
        $display("T=%0t: Teste exaustivo concluído.", $time);
        #10 $stop;
    end

endmodule

	
`timescale 100ns/1ps

module Encoder_tb;

    reg A_t, A_f, B_t, B_f, C_t, C_f, D_t, D_f;
    wire out0_t, out0_f, out1_t, out1_f, out2_t, out2_f, out3_t, out3_f;

    // Instância do módulo Encoder
    Encoder DUT(
        .A_t(A_t), .A_f(A_f), .B_t(B_t), .B_f(B_f), 
        .C_t(C_t), .C_f(C_f), .D_t(D_t), .D_f(D_f), 
        .out0_t(out0_t), .out0_f(out0_f), .out1_t(out1_t), .out1_f(out1_f), 
        .out2_t(out2_t), .out2_f(out2_f), .out3_t(out3_t), .out3_f(out3_f)
    );
	 
/***
	Testes específicos
***/

/*
  initial begin
        // Inicialização das entradas
        A_f = 0; A_t = 0; B_f = 0; B_t = 0; C_f = 0; C_t = 0; D_f = 0; D_t = 0;

        // Alterações das entradas
		  #5 A_f = 0; A_t = 1; B_f = 1; B_t = 0; C_f = 1; C_t = 0; D_f = 1; D_t = 0; //1000
		  #5 A_f = 0; A_t = 0; B_f = 0; B_t = 0; C_f = 0; C_t = 0; D_f = 0; D_t = 0;
		  #5 A_f = 0; A_t = 1; B_f = 0; B_t = 1; C_f = 1; C_t = 0; D_f = 0; D_t = 1; //1101
		  #5 A_f = 0; A_t = 0; B_f = 0; B_t = 0; C_f = 0; C_t = 0; D_f = 0; D_t = 0;
		  #5 A_f = 0; A_t = 1; B_f = 0; B_t = 1; C_f = 0; C_t = 1; D_f = 0; D_t = 1; //1111
		  #5 A_f = 0; A_t = 0; B_f = 0; B_t = 0; C_f = 0; C_t = 0; D_f = 0; D_t = 0;
		  #5 A_f = 0; A_t = 1; B_f = 0; B_t = 1; C_f = 0; C_t = 1; D_f = 1; D_t = 0; //1110
		  #5 A_f = 0; A_t = 0; B_f = 0; B_t = 0; C_f = 0; C_t = 0; D_f = 0; D_t = 0;
		  #5 A_f = 1; A_t = 0; B_f = 0; B_t = 1; C_f = 0; C_t = 1; D_f = 1; D_t = 0; //0110
		  #5 A_f = 0; A_t = 0; B_f = 0; B_t = 0; C_f = 0; C_t = 0; D_f = 0; D_t = 0;
		  #5 A_f = 1; A_t = 0; B_f = 0; B_t = 1; C_f = 0; C_t = 1; D_f = 0; D_t = 1; //0111
		  #5 A_f = 0; A_t = 0; B_f = 0; B_t = 0; C_f = 0; C_t = 0; D_f = 0; D_t = 0;
		  #5 A_f = 0; A_t = 1; B_f = 1; B_t = 0; C_f = 0; C_t = 1; D_f = 1; D_t = 0; //1010
		  #5 A_f = 0; A_t = 0; B_f = 0; B_t = 0; C_f = 0; C_t = 0; D_f = 0; D_t = 0;
		  #5 A_f = 0; A_t = 1; B_f = 1; B_t = 0; C_f = 0; C_t = 1; D_f = 0; D_t = 1; //1011
		  #5 A_f = 0; A_t = 0; B_f = 0; B_t = 0; C_f = 0; C_t = 0; D_f = 0; D_t = 0;
		  #5 A_f = 0; A_t = 1; B_f = 0; B_t = 1; C_f = 0; C_t = 1; D_f = 0; D_t = 1; //1111
		  #5 A_f = 0; A_t = 0; B_f = 0; B_t = 0; C_f = 0; C_t = 0; D_f = 0; D_t = 0;
        #20 $stop;
    end*/
	 
	 
/***
	Todos os casos de teste
***/

	    // Variável de loop
    integer i;
      
    // Bloco de estímulo (lógica copiada do padrão)
    initial begin
        // 1. Inicia o sistema no estado NULL
        // NULL (00) -> (T=0, F=0)
        A_t = 0; A_f = 0; B_t = 0; B_f = 0; C_t = 0; C_f = 0; D_t = 0; D_f = 0;
        $display("T=%0t: Estado Inicial -> NULL", $time);
        #10; // Aguarda um tempo no estado NULL inicial (Padronizado para #10)

        // 2. Loop para testar todas as 16 combinações de dados válidos
        // O loop vai de 0 (0000) a 15 (1111)
        for (i = 0; i < 16; i = i + 1) begin
            
            // 2.1 Aplica o vetor de DADOS
            // Converte cada bit de 'i' para o formato dual-rail:
            // Se o bit for 0, a entrada recebe DATA0 (T=0, F=1)
            // Se o bit for 1, a entrada recebe DATA1 (T=1, F=0)
            A_t = i[3]; A_f = ~i[3];
            B_t = i[2]; B_f = ~i[2];
            C_t = i[1]; C_f = ~i[1];
            D_t = i[0]; D_f = ~i[0];
            
            $display("T=%0t: Aplicando DADO %2d -> A={%b,%b}, B={%b,%b}, C={%b,%b}, D={%b,%b}", 
                     $time, i, A_t, A_f, B_t, B_f, C_t, C_f, D_t, D_f);
            #10; // Mantém o dado na entrada para que o circuito processe

            // 2.2 Retorna ao estado NULL
            A_t = 0; A_f = 0; B_t = 0; B_f = 0; C_t = 0; C_f = 0; D_t = 0; D_f = 0;
            $display("T=%0t: Retornando para -> NULL", $time);
            #10; // Aguarda no estado NULL antes de aplicar o próximo dado
        end

        // 3. Fim da simulação
        $display("T=%0t: Teste concluído.", $time);
        $stop;
    end
endmodule
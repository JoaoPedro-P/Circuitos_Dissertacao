`timescale 1ns/1ps
module Barrel_tb;

reg A1_t, A1_f, A2_t, A2_f, A3_t, A3_f, A0_t, A0_f, sra_t, sra_f, rotate_t, rotate_f, shift1_t, shift1_f, shift0_t, shift0_f, value_t, value_f;

wire out0_t, out0_f, out1_t, out1_f, out2_t, out2_f, out3_t, out3_f;


//module Barrel(A0_t, A0_f, A1_t, A1_f, A2_t, A2_f, A3_t, A3_f, sra_t, sra_f, rotate_t, rotate_f, shift1_t, shift1_f, shift0_t, shift0_f, value_t, value_f.,
//				   out0_t, out0_f, out1_t, out1_f, out2_t, out2_f, out3_t, out3_f);

Barrel DUT(A0_t, A0_f, A1_t, A1_f, A2_t, A2_f, A3_t, A3_f, sra_t, sra_f, rotate_t, rotate_f, shift1_t, shift1_f, shift0_t, shift0_f, value_t, value_f, out0_t, out0_f, out1_t, out1_f, out2_t, out2_f, out3_t, out3_f);


/***
	Testes específicos
***/

/*  
initial begin
	 
		//Nothing rotante and shift
			 A0_t = 0; A0_f = 0; A1_t = 0; A1_f = 0; A2_t = 0; A2_f = 0; A3_t = 0; A3_f = 0; sra_t = 0; sra_f = 0; rotate_t = 0; rotate_f = 0; shift1_t = 0; shift1_f = 0; shift0_t = 0; shift0_f = 0; value_t = 0; value_f = 0;
		#60 A0_t = 1; A0_f = 0; A1_t = 1; A1_f = 0; A2_t = 1; A2_f = 0; A3_t = 0; A3_f = 1; sra_t = 0; sra_f = 1; rotate_t = 0; rotate_f = 1; shift1_t = 0; shift1_f = 1; shift0_t = 0; shift0_f = 1; value_t = 0; value_f = 1;
		#60 A0_t = 0; A0_f = 0; A1_t = 0; A1_f = 0; A2_t = 0; A2_f = 0; A3_t = 0; A3_f = 0; sra_t = 0; sra_f = 0; rotate_t = 0; rotate_f = 0; shift1_t = 0; shift1_f = 0; shift0_t = 0; shift0_f = 0; value_t = 0; value_f = 0;
		
		// rotate
		#60 A0_t = 1; A0_f = 0; A1_t = 1; A1_f = 0; A2_t = 1; A2_f = 0; A3_t = 0; A3_f = 1; sra_t = 0; sra_f = 1; rotate_t = 1; rotate_f = 0; shift1_t = 1; shift1_f = 0; shift0_t = 1; shift0_f = 0; value_t = 0; value_f = 1;
		#60 A0_t = 0; A0_f = 0; A1_t = 0; A1_f = 0; A2_t = 0; A2_f = 0; A3_t = 0; A3_f = 0; sra_t = 0; sra_f = 0; rotate_t = 0; rotate_f = 0; shift1_t = 0; shift1_f = 0; shift0_t = 0; shift0_f = 0; value_t = 0; value_f = 0;
		
		// two shifts
		#60 A0_t = 1; A0_f = 0; A1_t = 1; A1_f = 0; A2_t = 1; A2_f = 0; A3_t = 0; A3_f = 1; sra_t = 0; sra_f = 1; rotate_t = 0; rotate_f = 1; shift1_t = 1; shift1_f = 0; shift0_t = 0; shift0_f = 1; value_t = 0; value_f = 1;
		#60 A0_t = 0; A0_f = 0; A1_t = 0; A1_f = 0; A2_t = 0; A2_f = 0; A3_t = 0; A3_f = 0; sra_t = 0; sra_f = 0; rotate_t = 0; rotate_f = 0; shift1_t = 0; shift1_f = 0; shift0_t = 0; shift0_f = 0; value_t = 0; value_f = 0;
		
		// one shift
		#60 A0_t = 1; A0_f = 0; A1_t = 1; A1_f = 0; A2_t = 1; A2_f = 0; A3_t = 0; A3_f = 1; sra_t = 0; sra_f = 1; rotate_t = 0; rotate_f = 1; shift1_t = 0; shift1_f = 1; shift0_t = 1; shift0_f = 0; value_t = 0; value_f = 1;
		#60 A0_t = 0; A0_f = 0; A1_t = 0; A1_f = 0; A2_t = 0; A2_f = 0; A3_t = 0; A3_f = 0; sra_t = 0; sra_f = 0; rotate_t = 0; rotate_f = 0; shift1_t = 0; shift1_f = 0; shift0_t = 0; shift0_f = 0; value_t = 0; value_f = 0;
		
		
		// Teste trojan OR
      #60 A0_t = 0; A0_f = 1; A1_t = 1; A1_f = 0; A2_t = 1; A2_f = 0; A3_t = 0; A3_f = 1; sra_t = 0; sra_f = 1; rotate_t = 1; rotate_f = 0; shift1_t = 0; shift1_f = 1; shift0_t = 0; shift0_f = 1; value_t = 0; value_f = 1;
      #60 A0_t = 0; A0_f = 0; A1_t = 0; A1_f = 0; A2_t = 0; A2_f = 0; A3_t = 0; A3_f = 0; sra_t = 0; sra_f = 0; rotate_t = 0; rotate_f = 0; shift1_t = 0; shift1_f = 0; shift0_t = 0; shift0_f = 0; value_t = 0; value_f = 0;
                
      // Teste trojan Tree
      #60 A0_t = 1; A0_f = 0; A1_t = 1; A1_f = 0; A2_t = 1; A2_f = 0; A3_t = 1; A3_f = 0; sra_t = 0; sra_f = 1; rotate_t = 1; rotate_f = 0; shift1_t = 0; shift1_f = 1; shift0_t = 1; shift0_f = 0; value_t = 0; value_f = 1;
      #60 A0_t = 0; A0_f = 0; A1_t = 0; A1_f = 0; A2_t = 0; A2_f = 0; A3_t = 0; A3_f = 0; sra_t = 0; sra_f = 0; rotate_t = 0; rotate_f = 0; shift1_t = 0; shift1_f = 0; shift0_t = 0; shift0_f = 0; value_t = 0; value_f = 0;
		#20 $stop;
end*/
	 
 /***
		Todos os casos de teste
 ***/
integer i;
initial begin
        // 1. Inicia todas as entradas no estado NULL (t=0, f=0)
        {A0_t, A0_f, A1_t, A1_f, A2_t, A2_f, A3_t, A3_f, 
         sra_t, sra_f, rotate_t, rotate_f, shift1_t, shift1_f, 
         shift0_t, shift0_f, value_t, value_f} = 18'h0; // Zera todos os 18 bits
         
        $display("T=%0t: Estado Inicial -> NULL", $time);
        #10; // Aguarda um tempo no estado NULL inicial

        // 2. Loop para testar todas as 512 (2^9) combinações de dados válidos
        for (i = 0; i < 512; i = i + 1) begin
            
            // 2.1 Aplica o vetor de DADOS
            // Converte cada bit de 'i' para o formato dual-rail (t/f)
            // i[x] = 0 -> DATA0 (t=0, f=1)
            // i[x] = 1 -> DATA1 (t=1, f=0)
            
            // Lógica simplificada: t = i[x]; f = ~i[x];
            A0_t = i[0]; A0_f = ~i[0];
            A1_t = i[1]; A1_f = ~i[1];
            A2_t = i[2]; A2_f = ~i[2];
            A3_t = i[3]; A3_f = ~i[3];
            sra_t = i[4]; sra_f = ~i[4];
            shift0_t = i[5]; shift0_f = ~i[5];
            shift1_t = i[6]; shift1_f = ~i[6];
            rotate_t = i[7]; rotate_f = ~i[7];
            value_t = i[8]; value_f = ~i[8];
            
            $display("T=%0t: Aplicando DADO %3d (Bin: %b)", $time, i, i[8:0]);
            #15; // Mantém o dado na entrada para que o circuito processe

            // 2.2 Retorna ao estado NULL (t=0, f=0)
            {A0_t, A0_f, A1_t, A1_f, A2_t, A2_f, A3_t, A3_f, 
             sra_t, sra_f, rotate_t, rotate_f, shift1_t, shift1_f, 
             shift0_t, shift0_f, value_t, value_f} = 18'h0;
             
            $display("T=%0t: Retornando para -> NULL", $time);
            #15; // Aguarda no estado NULL antes de aplicar o próximo dado
        end

        // 3. Fim da simulação
        $display("T=%0t: Teste exaustivo concluído.", $time);
        #10;
        $stop;
    end
endmodule
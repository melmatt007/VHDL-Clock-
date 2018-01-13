LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY Lab3 IS 
			port(
			KEY0,KEY1, KEY2, KEY3, CLK_50 :IN STD_LOGIC;
			MSDS, LSDS , MSDM, LSDM , MSDH, LSDH :OUT STD_LOGIC_VECTOR (0 to 6)
			);
END Lab3;

ARCHITECTURE a of Lab3 is
		SIGNAL ClkFlag: STD_LOGIC;
		SIGNAL Internal_Count: STD_LOGIC_VECTOR(28 downto 0);
		SIGNAL HighDigitS, LowDigitS, HighDigitM, LowDigitM, HighDigitH, LowDigitH: STD_LOGIC_VECTOR(3 downto 0);
		SIGNAL MSD_7SEGS, LSD_7SEGS,	MSD_7SEGM, LSD_7SEGM, MSD_7SEGH, LSD_7SEGH: STD_LOGIC_VECTOR(0 to 6);
BEGIN

		LSDS<=LSD_7SEGS;
		MSDS<=MSD_7SEGS;
		LSDM<=LSD_7SEGM;
		MSDM<=MSD_7SEGM;
		LSDH<=LSD_7SEGH;
		MSDH<=MSD_7SEGH;
		
PROCESS(CLK_50)
BEGIN
			if(CLK_50'event and CLK_50='1') then
					if Internal_Count<25000000 then
							Internal_Count<=Internal_Count+1;
					else
							Internal_Count<=(others => '0');
							ClkFlag<=not ClkFlag;
					end if;
			end if;
END PROCESS;

PROCESS(ClkFlag, KEY0)
BEGIN
			if(KEY0='0') then -- reset
						LowDigitS<="0000";
						HighDigitS<="0000";
						LowDigitM<="0000";
						HighDigitM<="0000";
						LowDigitH<="0001";
						HighDigitH<="0000";
			elsif(ClkFlag'event and ClkFlag='1') then
			If(KEY1='0') then
						LowDigitS <= LowDigitS+'1';
							if (LowDigitS=9)then
									LowDigitS<="0000";
										HighDigitS <= HighDigitS+'1';
									if(HighDigitS=5)then
											HighDigitS<="0000";
									end if;
							end if;
			end if;
			If(KEY2='0') then
						LowDigitM <= LowDigitM+'1';
							if (LowDigitM=9)then
									LowDigitM<="0000";
										HighDigitM <= HighDigitM+'1';
									if(HighDigitM=5)then
											HighDigitM<="0000";
									end if;
							end if;
			end if;
			If(KEY3='0') then
						LowDigitH <= LowDigitH+'1';
							if (LowDigitH=9)then
									LowDigitH<="0000";
										HighDigitH <= HighDigitH+'1';
									if(HighDigitH=1)then
											HighDigitH<="0000";
									end if;
							end if;
			end if;
			if(HighDigitH=1 and LowDigitH=3) then
					HighDigitH<="0000";
					LowDigitH<="0001"; 
			end if;
			
					if (LowDigitS=9) then
								LowDigitS <="0000";
								if (HighDigitS=5) then
											HighDigitS<="0000";
											if(LowDigitM=9)then
													lowDigitM <="0000";
													if (HighDigitM=5) then
															HighDigitM<="0000";
															If(LowDigitH=9)then
																	lowDigitH <="0000";
																	if(HighdigitH=1)then
																			HighDigitH <="0000";
																	else 
																	HighDigitH <= HighDigitH+'1';
																	end if;
															else 
															LowDigitH <= LowDigitH+'1';
															end if;
													else 
													HighDigitM <= HighDigitM+'1';
													end if;
											else 
											LowdigitM <= LowDigitM+'1';
											end if;
								else 
								HighDigitS<=HighDigitS+'1';
								end if;
					else
					LowDigitS<=LowDigitS+'1';
					end if;
			end if;
END PROCESS;
PROCESS(LowDigitS, HighDigitS)
BEGIN
			case LowDigitS is
						when "0000" => LSD_7SEGS <= "0000001";
						when "0001" => LSD_7SEGS <= "1001111";
						when "0010" => LSD_7SEGS <= "0010010";
						when "0011" => LSD_7SEGS <= "0000110";
						when "0100" => LSD_7SEGS <= "1001100";
						when "0101" => LSD_7SEGS <= "0100100";
						when "0110" => LSD_7SEGS <= "0100000";
						when "0111" => LSD_7SEGS <= "0001111";
						when "1000" => LSD_7SEGS <= "0000000";
						when "1001" => LSD_7SEGS <= "0000100";
						when others => LSD_7SEGS <= "1111111";
			end case;
			
			case HighDigitS is
						when "0000" => MSD_7SEGS <= "0000001";
						when "0001" => MSD_7SEGS <= "1001111";
						when "0010" => MSD_7SEGS <= "0010010";
						when "0011" => MSD_7SEGS <= "0000110";
						when "0100" => MSD_7SEGS <= "1001100";
						when "0101" => MSD_7SEGS <= "0100100";
						when "0110" => MSD_7SEGS <= "0100000";
						when "0111" => MSD_7SEGS <= "0001111";
						when "1000" => MSD_7SEGS <= "0000000";
						when "1001" => MSD_7SEGS <= "0000100";
						when others => MSD_7SEGS <= "1111111";
			end case;
		END PROCESS;

PROCESS(LowDigitM, HighDigitM)
BEGIN
			case LowDigitM is
						when "0000" => LSD_7SEGM <= "0000001";
						when "0001" => LSD_7SEGM <= "1001111";
						when "0010" => LSD_7SEGM <= "0010010";
						when "0011" => LSD_7SEGM <= "0000110";
						when "0100" => LSD_7SEGM <= "1001100";
						when "0101" => LSD_7SEGM <= "0100100";
						when "0110" => LSD_7SEGM <= "0100000";
						when "0111" => LSD_7SEGM <= "0001111";
						when "1000" => LSD_7SEGM <= "0000000";
						when "1001" => LSD_7SEGM <= "0000100";
						when others => LSD_7SEGM <= "1111111";
			end case;
			
			case HighDigitM is
						when "0000" => MSD_7SEGM <= "0000001";
						when "0001" => MSD_7SEGM <= "1001111";
						when "0010" => MSD_7SEGM <= "0010010";
						when "0011" => MSD_7SEGM <= "0000110";
						when "0100" => MSD_7SEGM <= "1001100";
						when "0101" => MSD_7SEGM <= "0100100";
						when "0110" => MSD_7SEGM <= "0100000";
						when "0111" => MSD_7SEGM <= "0001111";
						when "1000" => MSD_7SEGM <= "0000000";
						when "1001" => MSD_7SEGM <= "0000100";
						when others => MSD_7SEGM <= "1111111";
			end case;
		END PROCESS;

PROCESS(LowDigitH, HighDigitH)
BEGIN
			case LowDigitH is
						when "0000" => LSD_7SEGH <= "0000001";
						when "0001" => LSD_7SEGH <= "1001111";
						when "0010" => LSD_7SEGH <= "0010010";
						when "0011" => LSD_7SEGH <= "0000110";
						when "0100" => LSD_7SEGH <= "1001100";
						when "0101" => LSD_7SEGH <= "0100100";
						when "0110" => LSD_7SEGH <= "0100000";
						when "0111" => LSD_7SEGH <= "0001111";
						when "1000" => LSD_7SEGH <= "0000000";
						when "1001" => LSD_7SEGH <= "0000100";
						when others => LSD_7SEGH <= "1111111";
			end case;
			
			case HighDigitH is
						when "0000" => MSD_7SEGH <= "0000001";
						when "0001" => MSD_7SEGH <= "1001111";
						when "0010" => MSD_7SEGH <= "0010010";
						when "0011" => MSD_7SEGH <= "0000110";
						when "0100" => MSD_7SEGH <= "1001100";
						when "0101" => MSD_7SEGH <= "0100100";
						when "0110" => MSD_7SEGH <= "0100000";
						when "0111" => MSD_7SEGH <= "0001111";
						when "1000" => MSD_7SEGH <= "0000000";
						when "1001" => MSD_7SEGH <= "0000100";
						when others => MSD_7SEGH <= "1111111";
			end case;
		END PROCESS;
end a;


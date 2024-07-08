#INCLUDE "PROTHEUS.CH"
/*/{Protheus.doc} HSSDIRX
Substitui a função HS_EDISDIR que foi descontinuada na versão 2310
@type function
@version  1.0
@author admroar
@since 10/04/2024
@param lSelectArq, logical, Se .T. a tela de dialogo mostrar uma tela para selecionar aquivos, caso contrario mostra uma tela para selecionar uma pasta. Padrão .F. (Opcional)
@param cMascara, character, Defina a máscara que irá filtrar os arquivos na tela. Padrão "\*.\*" (Opcional)
@param cTitulo, character, Defina o titulo da tela. Padrão "Selecione Pasta de Destino" (Opcional)
@return variant, &(READVAR()) 
@see https://tdn.totvs.com.br/display/tec/tFileDialog
/*/
User Function HSSDIRX(lSelectArq, cMascara, cTitulo)
	Local aArea	   := GetArea()
	Local cCpoVld  := ReadVar()
	Local cRetorno := ""
	Local nPos     := 0

	Default lSelectArq := .F.
	Default cMascara   := "Arquivos (*.*)"
	Default cTitulo    := "Selecione Pasta de Destino"

	If Type("lSelectArq") # "U" .And. lSelectArq
		cTitulo  := IIf(!Empty(cTitulo),cTitulo,"Selecione o Arquivo")
		cRetorno := tFileDialog( cMascara, "Selecione o Arquivo",, "C:\", .T., GETF_LOCALHARD + GETF_NETWORKDRIVE + GETF_RETDIRECTORY )
	Else
		cTitulo  := IIf(!Empty(cTitulo),cTitulo,"Selecione Pasta de Destino")
		cRetorno := tFileDialog( "", cTitulo,, "C:\", .F., GETF_LOCALHARD + GETF_LOCALFLOPPY + GETF_NETWORKDRIVE + GETF_RETDIRECTORY )
		nPos     := Rat( "\", cRetorno )
		cRetorno := if(nPos==0,cRetorno,cRetorno + "\")
	EndIf

	&(cCpoVld) := cRetorno
	RestArea(aArea)
Return(.T.)

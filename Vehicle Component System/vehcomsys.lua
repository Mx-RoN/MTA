--[[
	Script:	Vehicle Component System
	Author:	Luc1feR aka Mx-RoN	
	Data:	17.06.2014
]]
						-----------------
						-- Создание GUI--
						-----------------
	local Label		= {}
	local Button		= {}
	local Edit		= {} 
	local RadioButton	= {}
	local VCSwindow		= guiCreateWindow(329, 185, 449, 452, "Vehicle Component System", false) 
 	local GridVehComponent	= guiCreateGridList(270, 38, 164, 345, false, VCSwindow)
	
	Edit[1] = guiCreateEdit(170, 83, 70, 25, "0", false, VCSwindow)		-- Rotation X
	Edit[2] = guiCreateEdit(30, 163, 70, 25, "0", false, VCSwindow)		-- Position Z
	Edit[3] = guiCreateEdit(170, 123, 70, 25, "0", false, VCSwindow)	-- Rotation Y	
	Edit[4] = guiCreateEdit(170, 163, 70, 25, "0", false, VCSwindow)	-- Rotation Z
	Edit[5] = guiCreateEdit(30, 123, 70, 25, "0", false, VCSwindow)		-- Position X
	Edit[6] = guiCreateEdit(30, 83, 70, 25, "0", false, VCSwindow)		-- Position Y

	Label[1] = guiCreateLabel(119, 83, 31, 17, "X", false, VCSwindow)
	Label[2] = guiCreateLabel(119, 123, 31, 17, "Y", false, VCSwindow)
	Label[3] = guiCreateLabel(119, 163, 31, 17, "Z", false, VCSwindow)
	Label[4] = guiCreateLabel(30, 23, 214, 15, "Название ТС: ", false, VCSwindow)
	Label[5] = guiCreateLabel(30, 53, 69, 18, "Позиция", false, VCSwindow)
	Label[6] = guiCreateLabel(170, 53, 69, 18, "Ротация", false, VCSwindow)

	Button[1] = guiCreateButton(90, 203, 100, 30, "Принять изменения", false, VCSwindow)		
	Button[2] = guiCreateButton(25, 303, 100, 30, "Вывести ротацию всех компонентов", false, VCSwindow)
	Button[3] = guiCreateButton(156, 303, 100, 30, "Вывести позицию всех компонентов", false, VCSwindow)
	Button[4] = guiCreateButton(25, 403, 100, 30, "Скрыть все компоненты", false, VCSwindow)
	Button[5] = guiCreateButton(25, 353, 100, 30, "Скрыть компонент", false, VCSwindow)
	Button[6] = guiCreateButton(156, 403, 100, 30, "Показать все компоненты", false, VCSwindow)
	Button[7] = guiCreateButton(156, 353, 100, 30, "Показать компонент", false, VCSwindow)
	Button[8] = guiCreateButton(25, 253, 100, 30, "Вернуть положение компонента", false, VCSwindow)
	Button[9] = guiCreateButton(156, 253, 100, 30, "Вернуть положение всех компонентов", false, VCSwindow)
	Button[10] = guiCreateButton(304, 403, 100, 30, "Обновить", false, VCSwindow)
						------------------------------
						-- Настройки компонентов GUI--
						------------------------------
-- Устанавливаем выделение, шрифт и цвет ко всем RadioButton
	for k,v in pairs (RadioButton) do	
		guiSetFont(v,"default-small")
		guiSetProperty(v,"NormalTextColour","FF0CBA41")
		guiRadioButtonSetSelected(v,false)
	end
		
-- Устанавливаем положение, шрифт и цвет ко всем Label
	for k,v in ipairs (Label) do
		guiLabelSetVerticalAlign(v,"center")
		guiLabelSetHorizontalAlign(v,"center")
		guiSetFont(v,"default-bold-small")
		guiLabelSetColor(v,12,186,65)		
	end		
	
-- Устанавливаем шрифт и цвет ко всем кнопкам (Button)
	for k,v in ipairs (Button) do
		guiSetFont(v,"default-small")
		guiSetProperty(v,"NormalTextColour","FF0CBA41")   	
	end	
	
-- Настройки главного окна (VCSwindow)
	guiWindowSetSizable(VCSwindow,false)
	guiSetAlpha(VCSwindow,1.00)
	guiSetProperty(VCSwindow,"CaptionColour","FF0CBA41")
	guiSetVisible(VCSwindow, false)
	guiGridListAddColumn(GridVehComponent,	"Список компонентов",0.9)
						-----------------
						-- Открытие GUI--
						-----------------
-- Устанавливаем положение в цетре экрана	
function CenterWindows(windows)
    local sW,sH=guiGetScreenSize()
    local wW,wH=guiGetSize(windows,false)
    local x,y = (sW-wW)/2,(sH-wH)/2
    guiSetPosition(windows,x,y,false)
end

-- Получаем название ТС
function VehicleName(veh)
	local Veh = getPedOccupiedVehicle(localPlayer)
	if Veh then
		local VehName = getVehicleName(Veh)
		guiSetText(Label[4],"Название ТС: "..VehName)
	else 
		guiSetText(Label[4],"Вы не в ТС")
	end
end

--Скрыть/показать VCS
function ShowVCSwindow(thePlayer)
	if guiGetVisible(VCSwindow) == false then
		local Veh = getPedOccupiedVehicle(localPlayer)
		if Veh then
			CenterWindows(VCSwindow)
			guiSetVisible(VCSwindow, true)
			showCursor(true)
			VehicleName()
			Update()
		else
			outputDebugString("[Подсказка] Вы должны быть в машине!",12,186,65)	
		end
	else
		guiSetVisible(VCSwindow, false)
		showCursor(false)
	end	
end
bindKey("X", "down", ShowVCSwindow)
						------------------
						--Работа кнопок--
						-----------------
local showBoolToColor =
{
	[true]	= {12, 186, 65},
	[false]	= {120,120,255}
}	
	
-- Очистка GridList
function Clean()
	guiGridListClear(GridVehComponent)
	for k,v in pairs (Edit) do
		guiSetText(v,0)
		guiEditSetCaretIndex(v,0)
	end
end

-- Принять изменения позиции компонента
addEventHandler("onClientGUIClick",VCSwindow,
function (b,thePlayer)
	if (b =="left") and (source == Button[1]) then
		local row,column = guiGridListGetSelectedItem(GridVehComponent)
		if row >= 0 then
			local Veh = getPedOccupiedVehicle(localPlayer)
			local theComponent = guiGridListGetItemText(GridVehComponent,row,1)
			local x, y, z = getVehicleComponentPosition(Veh,theComponent)
			local rx, ry, rz = getVehicleComponentRotation(Veh,theComponent)
			local showBool = getVehicleComponentVisible(Veh,theComponent)
			local old = {showBool,theComponent,x,y,z,rx,ry,rz}
			if old then
				local x = guiGetText(Edit[1])
				local y = guiGetText(Edit[2])
				local z = guiGetText(Edit[3])
				local rx = guiGetText(Edit[4])
				local ry = guiGetText(Edit[5])
				local rz = guiGetText(Edit[6])			
				local new = {showBool,theComponent,x,y,z,rx,ry,rz}
				if old ~= new then                     
					setVehicleComponentPosition(Veh,theComponent,x,y,z)
					setVehicleComponentRotation(Veh,theComponent,rx,ry,rz)
					setVehicleComponentVisible(Veh,theComponent,showBool)
				end
			end
		end
	end
end)

--   Получение ротации всех элементов
addEventHandler("onClientGUIClick",VCSwindow,
function (b,thePlayer)
	if (b =="left") and (source == Button[2]) then
		local Veh = getPedOccupiedVehicle(localPlayer)
		if (Veh) then
			local comp = getVehicleComponents(Veh)
			for k in pairs (comp) do	
				local rx,ry,rz = getVehicleComponentRotation(Veh,k)		
				outputConsole("Ротация компонента "..k.."\n по X: "..rx.."\n по Y: "..ry.."\n по Z: "..rz,12,186,65)		
			end	
		end
	end
end)

-- Получение позиции всех элементов
addEventHandler("onClientGUIClick",VCSwindow,
function (b,thePlayer)
	if (b =="left") and (source == Button[3]) then
		local Veh = getPedOccupiedVehicle(localPlayer)
		if (Veh) then
			local comp = getVehicleComponents(Veh)
			for k in pairs (comp) do	
				local x,y,z = getVehicleComponentPosition(Veh,k)		
				outputConsole("Позиция компонента "..k.."\n по X: "..x.."\n по Y: "..y.."\n по Z: "..z,12,186,65)
			end
		end
	end
end)

-- Скрыть все компоненты
addEventHandler("onClientGUIClick",VCSwindow,
function (b,thePlayer)
	if (b =="left") and (source == Button[4]) then
		local Veh = getPedOccupiedVehicle(localPlayer)
		if (Veh) then
			local comp = getVehicleComponents(Veh)
			for k in pairs (comp) do	
				setVehicleComponentVisible(Veh, k, false)		
				Update()
			end
		end
	end
end)

-- Скрыть компонент
addEventHandler("onClientGUIClick",VCSwindow,
function (b,thePlayer)
	if (b =="left") and (source == Button[5]) then
		local row,column = guiGridListGetSelectedItem(GridVehComponent)
		if row >= 0 then
			local theComponent = guiGridListGetItemText(GridVehComponent,row,1)
			local Veh = getPedOccupiedVehicle(localPlayer)
			local r,g,b = unpack(showBoolToColor[getVehicleComponentVisible(Veh,theComponent)])	
			setVehicleComponentVisible(Veh,theComponent,false)				
			guiGridListSetItemColor(GridVehComponent,row,1,r,g,b)
			Update()
		end
	end
end)

-- Показать все компоненты
addEventHandler("onClientGUIClick",VCSwindow,
function (b,thePlayer)
	if (b =="left") and (source == Button[6]) then
		local Veh = getPedOccupiedVehicle(localPlayer)
		if (Veh) then
			local comp = getVehicleComponents(Veh)
			for k in pairs (comp) do	
				setVehicleComponentVisible(Veh,k,true)	
				Update()
			end
		end
	end
end)

-- Показать компонент
addEventHandler("onClientGUIClick",VCSwindow,
function (b,thePlayer)
	if (b =="left") and (source == Button[7]) then
		local row,column = guiGridListGetSelectedItem(GridVehComponent)
		if row >= 0 then
			local theComponent = guiGridListGetItemText(GridVehComponent,row,1)
			local Veh = getPedOccupiedVehicle(localPlayer)
			local r,g,b = unpack(showBoolToColor[getVehicleComponentVisible(Veh,theComponent)])	
			setVehicleComponentVisible(Veh,theComponent,true)				
			guiGridListSetItemColor(GridVehComponent,row,1,r,g,b)
			Update()
		end
	end
end)

-- Вернуть положение компонента
addEventHandler("onClientGUIClick",VCSwindow,
function (b,thePlayer)
	if (b =="left") and (source == Button[8]) then
		local row,column = guiGridListGetSelectedItem(GridVehComponent)
		if row >= 0 then
			local theComponent = guiGridListGetItemText(GridVehComponent,row,1)
			local Veh = getPedOccupiedVehicle(localPlayer)
			resetVehicleComponentPosition(Veh,theComponent)
			resetVehicleComponentRotation(Veh,theComponent)
			Update()
		end
	end
end)

-- Вернуть положение всех компонентов
addEventHandler("onClientGUIClick",VCSwindow,
function (b,thePlayer)
	if (b =="left") and (source == Button[9]) then
		local Veh = getPedOccupiedVehicle(localPlayer)
		if (Veh) then
			local comp = getVehicleComponents(Veh)
			for k in pairs (comp) do	
				resetVehicleComponentPosition(Veh,k)
				resetVehicleComponentRotation(Veh,k)
				Update()
			end	
		end
	end
end)

-- Нажатие на кнопку обновить
addEventHandler("onClientGUIClick",VCSwindow,
function(b,thePlayer)
	if (b =="left") and (source == Button[10]) then
		Update()
	end
end)

--Обновление
function Update()	
		Clean()
		local Veh = getPedOccupiedVehicle(localPlayer)
		if (Veh) then
			local comp = getVehicleComponents(Veh)
			for k in pairs (comp) do
				local row = guiGridListAddRow(GridVehComponent)
				local r,g,b = unpack(showBoolToColor[getVehicleComponentVisible(Veh,k)])
				guiGridListSetItemText(GridVehComponent,row,1,k,false,false)
				guiGridListSetItemColor(GridVehComponent,row,1,r,g,b)
			end		
		end	
end

-- Получение позиции и ротации элемента
addEventHandler("onClientGUIClick",root,
function ()
	if source == GridVehComponent then
		local row,column = guiGridListGetSelectedItem(GridVehComponent)
		if row >= 0 then
			local theComponent = guiGridListGetItemText(GridVehComponent,row,1)
			local Veh = getPedOccupiedVehicle(localPlayer)
			local x, y, z = getVehicleComponentPosition(Veh,theComponent)
			local rx, ry, rz = getVehicleComponentRotation(Veh,theComponent)
			guiSetText(Edit[1],x)
			guiSetText(Edit[2],y)
			guiSetText(Edit[3],z)
			guiSetText(Edit[4],rx)
			guiSetText(Edit[5],ry)
			guiSetText(Edit[6],rz)
			for k,v in pairs (Edit) do
				guiEditSetCaretIndex (v,0)
			end
			theComponent = nil
		end
	end
end)

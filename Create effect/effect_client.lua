--[[
	** Создание эффектов. Кол-во эффектов - 82.
	** Задание позиции и ротации для эффекта.
	** Изменение скорости и насыщености эффекта.
	Author:	Luc1feR aka Mx-RoN	
	Data:	20.06.2014
]]
					-----------------
					-- Создание GUI--
					-----------------
	local ESedit		= {}
	local ESlabel		= {}
	local ESwindow 		= guiCreateWindow(390, 263, 400, 415, "Создание эффекта", false)
	local ESbutton 		= guiCreateButton(150, 340, 100, 25, "Создать эффект", false, ESwindow)
	local ESgridlist 	= guiCreateGridList(228, 24, 163, 305, false, ESwindow)
	
	ESlabel[1]		= guiCreateLabel(5, 25, 205, 15, "Введите необходимые данные:", false, ESwindow)
	ESlabel[2] 		= guiCreateLabel(0, 55, 210, 15, "Введите координаты", false, ESwindow)
	ESlabel[3]		= guiCreateLabel(15, 75, 41, 24, "X", false, ESwindow)-- Позиция по x
	ESlabel[4] 		= guiCreateLabel(15, 105, 41, 24, "Y", false, ESwindow)-- Позиция по y
	ESlabel[5]		= guiCreateLabel(15, 135, 41, 24, "Z", false, ESwindow)-- Позиция по z
	ESlabel[6] 		= guiCreateLabel(0, 165, 210, 15, "Введите направление (ротацию)", false,ESwindow)
	ESlabel[7]		= guiCreateLabel(15, 186, 41, 24, "X", false, ESwindow)	-- Ротация по x
	ESlabel[8]		= guiCreateLabel(15, 216, 41, 24, "Y", false, ESwindow)	-- Ротация по y
	ESlabel[9]		= guiCreateLabel(15, 245, 41, 24, "Z", false, ESwindow)	-- Ротация по z
	ESlabel[10] 		= guiCreateLabel(15, 275, 85, 25, "Скорость", false, ESwindow)
	ESlabel[11] 		= guiCreateLabel(15, 305, 85, 25, "Густота", false, ESwindow)
	EShelplabel		= guiCreateLabel(0, 370, 400, 37, "Внимание!\nПо умолчанию установлено текущее положение персонажа.\nСкорость и густота стандартные.", false, ESwindow)	
		
	ESedit[1]		= guiCreateEdit(100, 75, 110, 25, "", false, ESwindow)	-- Позиция по x
	ESedit[2] 		= guiCreateEdit(100, 105, 110, 25, "", false, ESwindow)	-- Позиция по y
	ESedit[3]		= guiCreateEdit(100, 135, 110, 25, "", false, ESwindow)	-- Позиция по z
	ESedit[4]		= guiCreateEdit(100, 185, 110, 25, "", false, ESwindow)	-- Ротация по x
	ESedit[5]		= guiCreateEdit(100, 215, 110, 25, "", false, ESwindow)	-- Ротация по y
	ESedit[6]		= guiCreateEdit(100, 245, 110, 25, "", false, ESwindow)	-- Ротация по z
	ESedit[7] 		= guiCreateEdit(100, 275, 110, 25, "", false, ESwindow)	-- Скорость
	ESedit[8]		= guiCreateEdit(100, 305, 110, 25, "", false, ESwindow)	-- Насыщеность 
					------------------------------
					-- Настройки компонентов GUI--
					------------------------------
					
-- Устанавливаем положение, шрифт и цвет ко всем ESlabel
	for k,v in ipairs (ESlabel) do
		guiLabelSetVerticalAlign(v,"center")
		guiLabelSetHorizontalAlign(v,"center")
		guiSetFont(v,"default-bold-small")
		guiLabelSetColor(v,12,186,65)		
	end		
	
-- Устанавливаем шрифт и цвет для ESbutton
	guiSetFont(ESbutton, "default-bold-small")
	guiSetProperty(ESbutton, "NormalTextColour", "FF0CBA41")
	
-- Добавляем колонку для ESgridlist
	guiGridListAddColumn(ESgridlist, "Список эффектов", 0.9)	
	
-- Показ, размер для ESwindow		
	guiWindowSetSizable(ESwindow, false)
	guiSetVisible(ESwindow, false)
	guiSetProperty(ESwindow,"CaptionColour","FF0CBA41")	
	
-- Устанавливаем положение, шрифт и цвет ко всем EShelplabel		
	guiSetFont(EShelplabel, "default-small")
	guiLabelSetColor(EShelplabel, 12,186,65)
	guiLabelSetHorizontalAlign(EShelplabel, "center", false)
	guiLabelSetVerticalAlign(EShelplabel, "center")
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

--Скрыть/показать ESwindow
function ShowESwindow(thePlayer)
	if guiGetVisible(ESwindow) == false then
		CenterWindows(ESwindow)
		guiSetVisible(ESwindow, true)
		showCursor(true)
		GetPosRot()
		ESgridlistUpdate()
	else
		guiSetVisible(ESwindow, false)
		showCursor(false)
	end	
end
bindKey("Z", "down", ShowESwindow)

-- Очистка GridList
function Clean()
	guiGridListClear(ESgridlist)
end

-- Список эффектов для ESgridlist
function ESgridlistUpdate()	
	Clean()
	
	for i = 1, 82 do
		guiGridListAddRow(ESgridlist)
	end

	guiGridListSetItemText(ESgridlist, 0, 1, "blood_heli", false, false)
	guiGridListSetItemText(ESgridlist, 1, 1, "boat_prop", false, false)
	guiGridListSetItemText(ESgridlist, 2, 1, "camflash", false, false)
	guiGridListSetItemText(ESgridlist, 3, 1, "carwashspray", false, false)
	guiGridListSetItemText(ESgridlist, 4, 1, "cement", false, false)
	guiGridListSetItemText(ESgridlist, 5, 1, "cloudfast", false, false)
	guiGridListSetItemText(ESgridlist, 6, 1, "coke_puff", false, false)
	guiGridListSetItemText(ESgridlist, 7, 1, "coke_trail", false, false)
	guiGridListSetItemText(ESgridlist, 8, 1, "cigarette_smoke", false, false)
	guiGridListSetItemText(ESgridlist, 9, 1, "explosion_barrel", false, false)
	guiGridListSetItemText(ESgridlist, 10, 1, "explosion_crate", false, false)
	guiGridListSetItemText(ESgridlist, 11, 1, "explosion_door", false, false)
	guiGridListSetItemText(ESgridlist, 12, 1, "exhale", false, false)
	guiGridListSetItemText(ESgridlist, 13, 1, "explosion_fuel_car", false, false)
	guiGridListSetItemText(ESgridlist, 14, 1, "explosion_large", false, false)
	guiGridListSetItemText(ESgridlist, 15, 1, "explosion_medium", false, false)	
	guiGridListSetItemText(ESgridlist, 16, 1, "explosion_molotov", false, false)
	guiGridListSetItemText(ESgridlist, 17, 1, "explosion_small", false, false)
	guiGridListSetItemText(ESgridlist, 18, 1, "explosion_tiny", false, false)
	guiGridListSetItemText(ESgridlist, 19, 1, "extinguisher", false, false)
	guiGridListSetItemText(ESgridlist, 20, 1, "flame", false, false)
	guiGridListSetItemText(ESgridlist, 21, 1, "fire", false, false)
	guiGridListSetItemText(ESgridlist, 22, 1, "fire_med", false, false)
	guiGridListSetItemText(ESgridlist, 23, 1, "fire_large", false, false)
	guiGridListSetItemText(ESgridlist, 24, 1, "flamethrower", false, false)
	guiGridListSetItemText(ESgridlist, 25, 1, "fire_bike", false, false)
	guiGridListSetItemText(ESgridlist, 26, 1, "fire_car", false, false)
	guiGridListSetItemText(ESgridlist, 27, 1, "gunflash", false, false)
	guiGridListSetItemText(ESgridlist, 28, 1, "gunsmoke", false, false)
	guiGridListSetItemText(ESgridlist, 29, 1, "insects", false, false)
	guiGridListSetItemText(ESgridlist, 30, 1, "heli_dust", false, false)
	guiGridListSetItemText(ESgridlist, 31, 1, "jetpack", false, false)
	guiGridListSetItemText(ESgridlist, 32, 1, "jetthrust", false, false)
	guiGridListSetItemText(ESgridlist, 33, 1, "nitro", false, false)
	guiGridListSetItemText(ESgridlist, 34, 1, "molotov_flame", false, false)
	guiGridListSetItemText(ESgridlist, 35, 1, "overheat_car", false, false)
	guiGridListSetItemText(ESgridlist, 36, 1, "overheat_car_electric", false, false)
	guiGridListSetItemText(ESgridlist, 37, 1, "prt_blood", false, false)
	guiGridListSetItemText(ESgridlist, 38, 1, "prt_boatsplash", false, false)
	guiGridListSetItemText(ESgridlist, 38, 1, "prt_bubble", false, false)
	guiGridListSetItemText(ESgridlist, 40, 1, "prt_cardebris", false, false)
	guiGridListSetItemText(ESgridlist, 41, 1, "prt_collisionsmoke", false, false)
	guiGridListSetItemText(ESgridlist, 42, 1, "prt_glass", false, false)
	guiGridListSetItemText(ESgridlist, 43, 1, "prt_gunshell", false, false)
	guiGridListSetItemText(ESgridlist, 44, 1, "prt_sand", false, false)
	guiGridListSetItemText(ESgridlist, 45, 1, "prt_sand2", false, false)
	guiGridListSetItemText(ESgridlist, 46, 1, "prt_smokeII_3_expand", false, false)
	guiGridListSetItemText(ESgridlist, 47, 1, "prt_smoke_huge", false, false)
	guiGridListSetItemText(ESgridlist, 48, 1, "prt_spark", false, false)
	guiGridListSetItemText(ESgridlist, 49, 1, "prt_spark_2", false, false)
	guiGridListSetItemText(ESgridlist, 50, 1, "prt_splash", false, false)
	guiGridListSetItemText(ESgridlist, 51, 1, "prt_wake", false, false)
	guiGridListSetItemText(ESgridlist, 52, 1, "prt_watersplash", false, false)
	guiGridListSetItemText(ESgridlist, 53, 1, "prt_wheeldirt", false, false)
	guiGridListSetItemText(ESgridlist, 54, 1, "petrolcan", false, false)
	guiGridListSetItemText(ESgridlist, 55, 1, "puke", false, false)
	guiGridListSetItemText(ESgridlist, 56, 1, "riot_smoke", false, false)
	guiGridListSetItemText(ESgridlist, 57, 1, "spraycan", false, false)
	guiGridListSetItemText(ESgridlist, 58, 1, "smoke30lit", false, false)
	guiGridListSetItemText(ESgridlist, 59, 1, "smoke30m", false, false)
	guiGridListSetItemText(ESgridlist, 60, 1, "smoke50lit", false, false)
	guiGridListSetItemText(ESgridlist, 61, 1, "shootlight", false, false)
	guiGridListSetItemText(ESgridlist, 62, 1, "smoke_flare", false, false)
	guiGridListSetItemText(ESgridlist, 63, 1, "tank_fire", false, false)
	guiGridListSetItemText(ESgridlist, 64, 1, "teargas", false, false)
	guiGridListSetItemText(ESgridlist, 65, 1, "teargasAD", false, false)
	guiGridListSetItemText(ESgridlist, 66, 1, "tree_hit_fir", false, false)
	guiGridListSetItemText(ESgridlist, 67, 1, "tree_hit_palm", false, false)
	guiGridListSetItemText(ESgridlist, 68, 1, "vent", false, false)
	guiGridListSetItemText(ESgridlist, 69, 1, "vent2", false, false)
	guiGridListSetItemText(ESgridlist, 70, 1, "water_hydrant", false, false)
	guiGridListSetItemText(ESgridlist, 71, 1, "water_ripples", false, false)
	guiGridListSetItemText(ESgridlist, 72, 1, "water_speed", false, false)
	guiGridListSetItemText(ESgridlist, 73, 1, "water_splash", false, false)
	guiGridListSetItemText(ESgridlist, 74, 1, "water_splash_big", false, false)
	guiGridListSetItemText(ESgridlist, 75, 1, "water_splsh_sml", false, false)
	guiGridListSetItemText(ESgridlist, 76, 1, "water_swim", false, false)
	guiGridListSetItemText(ESgridlist, 77, 1, "waterfall_end", false, false)
	guiGridListSetItemText(ESgridlist, 78, 1, "water_fnt_tme", false, false)
	guiGridListSetItemText(ESgridlist, 79, 1, "water_fountain", false, false)
	guiGridListSetItemText(ESgridlist, 80, 1, "wallbust", false, false)
	guiGridListSetItemText(ESgridlist, 81, 1, "WS_factorysmoke", false, false)
end

-- Получаем текущую позицию для ESedit
function GetPosRot()
	local px,py,pz = getElementPosition(localPlayer)
	local rx,ry,rz = getElementRotation(localPlayer)
	guiSetText(ESedit[1],px)	
	guiSetText(ESedit[2],py)	
	guiSetText(ESedit[3],pz)	
	guiSetText(ESedit[4],rx)	
	guiSetText(ESedit[5],ry)	
	guiSetText(ESedit[6],rz)	
	guiSetText(ESedit[5],ry)	
	guiSetText(ESedit[7],1.0)
	guiSetText(ESedit[8],1.0)
end

-- Процесс создания эффекта при нажатии на кнопку
addEventHandler("onClientGUIClick",ESwindow,
function (b,thePlayer)
	if (b =="left") and (source == ESbutton) then
	local row,column = guiGridListGetItemText ( ESgridlist, guiGridListGetSelectedItem ( ESgridlist ), 1 )
		if row then
			local px = guiGetText(ESedit[1])
			local py = guiGetText(ESedit[2])
			local pz = guiGetText(ESedit[3])		
			local rx = guiGetText(ESedit[4])
			local ry = guiGetText(ESedit[5])
			local rz = guiGetText(ESedit[6])	
			local s  = guiGetText(ESedit[7])	
			local d  = guiGetText(ESedit[8])	
			local effect = createEffect(row,px,py,pz,rx,ry,rz)
			if not effect then return else
				setEffectSpeed(effect,s)
				setEffectDensity(effect,d)
			end
			outputDebugString("Эффект был успешно создан",3,12,186,65)
		end
	end
end)

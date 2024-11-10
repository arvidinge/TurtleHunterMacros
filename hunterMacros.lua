-- mouse template
function ____ Mouse()
  if UnitCanAttack("player","mouseover") then 
      TargetUnit("mouseover");
      CastSpellByName("_____")
      TargetUnit("playertarget"); 
  else 
      CastSpellByName("_____")
  end
end

-- super spicy stuff
function initFrame()
  MyFrame = CreateFrame("Frame")
  MyFrame.casting = false
  MyFrame:RegisterEvent("SPELLCAST_START")
  MyFrame:RegisterEvent("SPELLCAST_STOP")
  MyFrame:RegisterEvent("SPELLCAST_FAILED")
  MyFrame:RegisterEvent("SPELLCAST_INTERRUPTED")
  MyFrame:SetScript("OnEvent", function()
    if not event then return end

    if event == "SPELLCAST_START" then
      MyFrame.casting = true

    elseif event == "SPELLCAST_STOP" or event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED" then
      if not MyFrame.casting then return end
      MyFrame.casting = false
    end
  end)
end
if not MyFrame then
  initFrame()
end
function smartShot(spell)
  if MyFrame == nil or not MyFrame.casting then
    Quiver.CastNoClip(spell)
  end
end

-- toggle auto shot if outside melee range, otherwise toggle auto attack
function dynamicAttack() 
    local t='target'
    if UnitExists(t) and UnitCanAttack('player',t) then 
        if CheckInteractDistance('target',3) then 
            CastSpellByName('Attack') 
        else 
            CastSpellByName('Auto Shot') 
        end 
    else 
        TargetNearestEnemy() 
    end
end

-- pet attacks mouseover if exists, otherwise target
function petAttackMouse()
	if UnitCanAttack("player","mouseover") then 
		TargetUnit("mouseover");
		PetAttack();
		TargetUnit("playertarget"); 
	else 
		PetAttack(); 
	end
end

-- mouseover ss
function serpentStingMouse()
	if UnitCanAttack("player","mouseover") then 
		TargetUnit("mouseover");
		CastSpellByName("Serpent Sting");
		TargetUnit("playertarget"); 
	else 
		CastSpellByName("Serpent Sting");
	end
end


-- water of visions 
function cdOver()
  local oh = 'Outlaw Sabre'
  local water = 'Waters of Vision'

  if GetActionCooldown(10) > 0.0 then
    SlashCmdList["SMEQUIPOFF"](oh)
  else
    SlashCmdList["SMEQUIPOFF"](water)
    SlashCmdList["SMUSE"](water)
    
    if GetActionCooldown(10) > 0.0 then
      SlashCmdList["SMEQUIPOFF"](oh)
    end
  end
end


-- trap template
function trap(trapname)
  PetPassiveMode();
  PetFollow();
  
  if (UnitAffectingCombat("player")) then
    CastSpellByName("Feign Death") 
  elseif not (UnitAffectingCombat("player")) then 
    CastSpellByName(trapname); 
  end
end


-- toggle cheetah / pack
function cheetahpack()
	local i,x=1,0 
	while UnitBuff("player",i) do 
		if UnitBuff("player",i)=="Interface\\Icons\\Ability_Mount_JungleTiger" then 
			x=1 
		end 
		i=i+1 
	end 
	
	if x==0 then 
		CastSpellByName("Aspect of the Cheetah") 
	else 
		CastSpellByName("Aspect of the Pack") 
	end
end


-- cheetah solo, pack group
function packgroup()
	if GetNumPartyMembers()==0 and GetNumRaidMembers()==0 then 
		CastSpellByName("Aspect of the Cheetah") 
	else 
		CastSpellByName("Aspect of the Pack") 
	end
end






function equipWeapon(twoh, oh)
  local using2h = twoh ~= ""
  local water = "Waters of Vision"
  
  if not using2h then
    SlashCmdList["SMEQUIPOFF"](oh)
  else
    SlashCmdList["SMUNEQUIP"](water)
    SlashCmdList["SMEQUIP"](twoh)
  end
end

function useWater(twoh, oh)
  local using2h = twoh ~= ""
  local water = "Waters of Vision"
  
  if using2h then
    SlashCmdList["SMUNEQUIP"](twoh)
  end
  
  SlashCmdList["SMEQUIPOFF"](water)
  SlashCmdList["SMUSE"](water)
  
  if GetActionCooldown(10) > 0.0 then
    equipWeapon(twoh, oh)
  end
end

function cdOver()
  local twoh = "Spear of the Endless Hunt"
  local oh = ""
  local water = "Waters of Vision"

  if GetActionCooldown(10) > 0.0 then
	equipWeapon(twoh, oh)
  else
    useWater(twoh, oh)
  end
end


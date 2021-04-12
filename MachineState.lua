MachineState = Class{}

-- Declaring the Assets Init Functions in MainState
function MachineState:init(states)
  self.empty = {
    render = function() end,
    update = function() end,
    enter = function() end,
    exit = function () end
  }

  self.states = states or {}
  self.current = self.empty
end


function MachineState:change(NameAsset, Parameters)
  assert(self.states[NameAsset])
  self.current = self.states[NameAsset]()
  self.current:enter(Parameters)
end

function MachineState:update(dt)
  self.current:update(dt)
end

function MachineState:render()
  self.current:render()
end
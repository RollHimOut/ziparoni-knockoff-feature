-- config.lua
Config = {}

-- Knockoff configuration
Config.ForceThreshold = 70.0 -- Minimum force to trigger knockoff
Config.MinimumSpeed = 8.0 -- Speed in meters/second (~18 mph)
Config.HighSpeedThreshold = 20.0 -- High-speed threshold for additional effects
Config.HighSpeedDamageMultiplier = 1.2 -- Extra damage multiplier for high-speed crashes
Config.HelmetReductionFactor = 0.7 -- Reduce damage if wearing a helmet (30%)
Config.RagdollTime = 5000 -- Ragdoll duration in milliseconds
Config.ApplyBikeSpin = true -- Add spin effect to the bike
Config.AllowKnockoff = true -- Enable/disable knockoff system
Config.GlobalKnockoffDisable = false -- Toggle to disable globally (e.g., for events)
Config.CooldownTime = 3000 -- Cooldown in milliseconds between knockoffs
Config.DebugMode = false -- Enable debug messages for testing
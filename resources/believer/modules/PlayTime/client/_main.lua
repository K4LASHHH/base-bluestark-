GM.PlayTime = GM.PlayTime or {}

function GM.PlayTime:SecondsToClock(seconds)
	local days = math.floor(seconds / 86400)
	seconds = seconds - days * 86400
	local hours = math.floor(seconds / 3600 )
	seconds = seconds - hours * 3600
	local minutes = math.floor(seconds / 60)
	seconds = seconds - minutes * 60

	if days == 0 and hours == 0 and minutes == 0 then
		return string.format("%d secondes.", seconds)
	elseif days == 0 and hours == 0 then
		return string.format("%d minutes, %d secondes", minutes, seconds)
	elseif days == 0 then
		return string.format("%d heures, %d minutes, %d secondes", hours, minutes, seconds)
	else
		return string.format("%d jours, %d heures, %d minutes, %d secondes", days, hours, minutes, seconds)
	end
	return string.format("%d jours, %d heures, %d minutes, %d secondes", days, hours, minutes, seconds)
end
MechanicColors = {
	{label = 'Black', index = 'black'},
	{label = 'White', index = 'white'},
	{label = 'Grey', index = 'grey'},
	{label = 'Red', index = 'red'},
	{label = 'Pink', index = 'pink'},
	{label = 'Blue', index = 'blue'},
	{label = 'Yellow', index = 'yellow'},
	{label = 'Green', index = 'green'},
	{label = 'Orange', index = 'orange'},
	{label = 'Brown', index = 'brown'},
	{label = 'Purple', index = 'purple'},
	{label = 'Chrome', index = 'chrome'},
	{label = 'Gold', index = 'gold'},
	{label = 'Sonderlack', index = 'sonderlack'}
}

function GetColors(color)
	local colors = {}
	if color == 'black' then
		colors = {
			{ index = 0, label = 'Black'},
			{ index = 1, label = 'Graphite'},
			{ index = 2, label = 'Black Metallic'},
			{ index = 3, label = 'Cast Steel'},
			{ index = 11, label = 'Black Anth'},
			{ index = 12, label = 'Matte Black'},
			{ index = 15, label = 'Dark Night'},
			{ index = 16, label = 'Deep Black'},
			{ index = 21, label = 'Oil'},
			{ index = 147, label = 'Carbon'}
		}
	elseif color == 'white' then
		colors = {
			{ index = 106, label = 'Vanilla'},
			{ index = 107, label = 'Creme'},
			{ index = 111, label = 'White'},
			{ index = 112, label = 'Polar White'},
			{ index = 113, label = 'Beige'},
			{ index = 121, label = 'Mattewhite'},
			{ index = 122, label = 'Snow'},
			{ index = 131, label = 'Cotton'},
			{ index = 132, label = 'Alabaster'},
			{ index = 134, label = 'Purewhite'}
		}
	elseif color == 'grey' then
		colors = {
			{ index = 4, label = 'Silver'},
			{ index = 5, label = 'Metallic Grey'},
			{ index = 6, label = 'Laminated Steel'},
			{ index = 7, label = 'Dark Gray'},
			{ index = 8, label = 'Rocky Gray'},
			{ index = 9, label = 'Gray Night'},
			{ index = 10, label = 'Aluminum'},
			{ index = 13, label = 'Gray Matte'},
			{ index = 14, label = 'Light Grey'},
			{ index = 17, label = 'Asphalt Gray'},
			{ index = 18, label = 'Gray Concrete'},
			{ index = 19, label = 'Dark Silver'},
			{ index = 20, label = 'Magnesite'},
			{ index = 22, label = 'Nickel'},
			{ index = 23, label = 'Zinc'},
			{ index = 24, label = 'Dolomite'},
			{ index = 25, label = 'Blue Silver'},
			{ index = 26, label = 'Titanium'},
			{ index = 66, label = 'Steel Blue'},
			{ index = 93, label = 'Champagne'},
			{ index = 144, label = 'Gray Hunter'},
			{ index = 156, label = 'Grey'}
		}
	elseif color == 'red' then
		colors = {
			{ index = 27, label = 'Red'},
			{ index = 28, label = 'Torino Red'},
			{ index = 29, label = 'Poppy'},
			{ index = 30, label = 'Copper Red'},
			{ index = 31, label = 'Cardinal'},
			{ index = 32, label = 'Brick'},
			{ index = 33, label = 'Garnet'},
			{ index = 34, label = 'Cabernet'},
			{ index = 35, label = 'Candy'},
			{ index = 39, label = 'Matte Red'},
			{ index = 40, label = 'Dark Red'},
			{ index = 43, label = 'Red Pulp'},
			{ index = 44, label = 'Bril Red'},
			{ index = 46, label = 'Pale Red'},
			{ index = 143, label = 'Wine Red'},
			{ index = 150, label = 'Volcano'}
		}
	elseif color == 'pink' then
		colors = {
			{ index = 135, label = 'Electric Pink'},
			{ index = 136, label = 'Salmon'},
			{ index = 137, label = 'Sugarplum'}
		}
	elseif color == 'blue' then
		colors = {
			{ index = 54, label = 'Topaz'},
			{ index = 60, label = 'Light Blue'},
			{ index = 61, label = 'Galaxy Blue'},
			{ index = 62, label = 'Dark Blue'},
			{ index = 63, label = 'Azure'},
			{ index = 64, label = 'Navy Blue'},
			{ index = 65, label = 'Lapis'},
			{ index = 67, label = 'Blue Diamond'},
			{ index = 68, label = 'Surfer'},
			{ index = 69, label = 'Pastel Blue'},
			{ index = 70, label = 'Celeste Blue'},
			{ index = 73, label = 'Rally Blue'},
			{ index = 74, label = 'Blue Paradise'},
			{ index = 75, label = 'Blue Night'},
			{ index = 77, label = 'Cyan Blue'},
			{ index = 78, label = 'Cobalt'},
			{ index = 79, label = 'Electric Blue'},
			{ index = 80, label = 'Horizon Blue'},
			{ index = 82, label = 'Metallic Blue'},
			{ index = 83, label = 'Aquamarine'},
			{ index = 84, label = 'Blue Agathe'},
			{ index = 85, label = 'Zirconium'},
			{ index = 86, label = 'Spinel'},
			{ index = 87, label = 'Tourmaline'},
			{ index = 127, label = 'Paradise'},
			{ index = 140, label = 'Bubble Gum'},
			{ index = 141, label = 'Midnight Blue'},
			{ index = 146, label = 'Forbidden Blue'},
			{ index = 157, label = 'Glacier Blue'}
		}
	elseif color == 'yellow' then
		colors = {
			{ index = 42, label = 'Yellow'},
			{ index = 88, label = 'Wheat'},
			{ index = 89, label = 'Race Yellow'},
			{ index = 91, label = 'Pale Yellow'},
			{ index = 126, label = 'Light Yellow'}
		}
	elseif color == 'green' then
		colors = {
			{ index = 49, label = 'Met Dark Green'},
			{ index = 50, label = 'Rally Green'},
			{ index = 51, label = 'Pine Green'},
			{ index = 52, label = 'Olive Green'},
			{ index = 53, label = 'Light Green'},
			{ index = 55, label = 'Lime Green'},
			{ index = 56, label = 'Forest Green'},
			{ index = 57, label = 'Lawn Green'},
			{ index = 58, label = 'Imperial Green'},
			{ index = 59, label = 'Green Bottle'},
			{ index = 92, label = 'Citrus Green'},
			{ index = 125, label = 'Green Anis'},
			{ index = 128, label = 'Khaki'},
			{ index = 133, label = 'Army Green'},
			{ index = 151, label = 'Dark Green'},
			{ index = 152, label = 'Hunter Green'},
			{ index = 155, label = 'Matte Foilage Green'}
		}
	elseif color == 'orange' then
		colors = {
			{ index = 36, label = 'Tangerine'},
			{ index = 38, label = 'Orange'},
			{ index = 41, label = 'Matte Orange'},
			{ index = 123, label = 'Light Orange'},
			{ index = 124, label = 'Peach'},
			{ index = 130, label = 'Pumpkin'},
			{ index = 138, label = 'Orangelambo'}
		}
	elseif color == 'brown' then
		colors = {
			{ index = 45, label = 'Copper'},
			{ index = 47, label = 'Light Brown'},
			{ index = 48, label = 'Dark Brown'},
			{ index = 90, label = 'Bronze'},
			{ index = 94, label = 'Brown Metallic'},
			{ index = 95, label = 'Expresso'},
			{ index = 96, label = 'Chocolate'},
			{ index = 97, label = 'Terracotta'},
			{ index = 98, label = 'Marble'},
			{ index = 99, label = 'Sand'},
			{ index = 100, label = 'Sepia'},
			{ index = 101, label = 'Bison'},
			{ index = 102, label = 'Palm'},
			{ index = 103, label = 'Caramel'},
			{ index = 104, label = 'Rust'},
			{ index = 105, label = 'Chestnut'},
			{ index = 108, label = 'Brown'},
			{ index = 109, label = 'Hazelnut'},
			{ index = 110, label = 'Shell'},
			{ index = 114, label = 'Mahogany'},
			{ index = 115, label = 'Cauldron'},
			{ index = 116, label = 'Blond'},
			{ index = 129, label = 'Gravel'},
			{ index = 153, label = 'Dark Earth'},
			{ index = 154, label = 'Desert'}
		}
	elseif color == 'purple' then
		colors = {
			{ index = 71, label = 'Indigo'},
			{ index = 72, label = 'Deeppurple'},
			{ index = 76, label = 'Darkviolet'},
			{ index = 81, label = 'Amethyst'},
			{ index = 142, label = 'Mystical Violet'},
			{ index = 145, label = 'Purple Metallic'},
			{ index = 148, label = 'Matte Violet'},
			{ index = 149, label = 'Matte Deep Purple'}
		}
	elseif color == 'chrome' then
		colors = {
			{ index = 117, label = 'Brushed Chrome'},
			{ index = 118, label = 'Black Chrome'},
			{ index = 119, label = 'Brushed Aluminum'},
			{ index = 120, label = 'Chrome'}
		}
	elseif color == 'gold' then
		colors = {
			{ index = 37, label = 'Gold'},
			{ index = 158, label = 'Pure Gold'},
			{ index = 159, label = 'Brushed Gold'},
			{ index = 160, label = 'Lightgold'}
		}
	elseif color == 'sonderlack' then
		colors = {
			{ index = 161, label = 'Anod Red'},
			{ index = 162, label = 'Anod Wine'},
			{ index = 163, label = 'Anod Purple'},
			{ index = 164, label = 'Anod Blue'},
			{ index = 165, label = 'Anod Green'},
			{ index = 166, label = 'Anod Lime'},
			{ index = 167, label = 'Anod Copper'},
			{ index = 168, label = 'Anod Bronze'},
			{ index = 169, label = 'Anod Champagne'},
			{ index = 170, label = 'Anod Gold'},
			{ index = 171, label = 'Green Blue Flip'},
			{ index = 172, label = 'Green Red Flip'},
			{ index = 173, label = 'Green BROW Flip'},
			{ index = 174, label = 'Green Turq Flip'},
			{ index = 175, label = 'Green Purp Flip'},
			{ index = 176, label = 'Teal Purp Flip'},
			{ index = 177, label = 'Turq Red Flip'},
			{ index = 178, label = 'Turq Purp Flip'},
			{ index = 179, label = 'Cyan Purp Flip'},
			{ index = 180, label = 'Blue Pink Flip'},
			{ index = 181, label = 'Blue Green FLIP'},
			{ index = 182, label = 'Purp Red Flip'},
			{ index = 183, label = 'Purp Green FLIP'},
			{ index = 184, label = 'Magen Green Flip'},
			{ index = 185, label = 'Magen YELL Flip'},
			{ index = 186, label = 'Burg Green FLIP'},
			{ index = 187, label = 'Magen Cyan Flip'},
			{ index = 188, label = 'Coppe Purp Flip'},
			{ index = 189, label = 'Magen ORAN Flip'},
			{ index = 190, label = 'Red Orange Flip'},
			{ index = 191, label = 'Orange Purp Flip'},
			{ index = 192, label = 'Orange Blue Flip'},
			{ index = 193, label = 'White Purp Flip'},
			{ index = 194, label = 'Red Rainbo Flip'},
			{ index = 195, label = 'Blu Rainbo Flip'},
			{ index = 196, label = 'Dark Green Pearl'},
			{ index = 197, label = 'Dark Teal Pearl'},
			{ index = 198, label = 'Dark Blue Pearl'},
			{ index = 199, label = 'Dark Purple Pearl'},
			{ index = 200, label = 'Oil Slick Pearl'},
			{ index = 201, label = 'Lit Green  Pearl'},
			{ index = 202, label = 'Lit Blue Pearl'},
			{ index = 203, label = 'Lit Purp Pearl'},
			{ index = 204, label = 'Lit Pink Pearl'},
			{ index = 205, label = 'Off White Prisma'},
			{ index = 206, label = 'Pink Pearl'},
			{ index = 207, label = 'Yellow Pearl'},
			{ index = 208, label = 'Green Pearl'},
			{ index = 209, label = 'Blue Pearl'},
			{ index = 210, label = 'Cream Pearl'},
			{ index = 211, label = 'White Prisma'},
			{ index = 212, label = 'Graphite Prisma'},
			{ index = 213, label = 'Dark Blue Prisma'},
			{ index = 214, label = 'Dark PurpPrisma'},
			{ index = 215, label = 'Hot Pink Prisma'},
			{ index = 216, label = 'Red Prisma'},
			{ index = 217, label = 'Green Prisma'},
			{ index = 218, label = 'Black Prisma'},
			{ index = 219, label = 'Oil Slic Prisma'},
			{ index = 220, label = 'Rainbow Prisma'},
			{ index = 221, label = 'Black Holo'},
			{ index = 222, label = 'White Holo'}
		}
	end
	return colors
end

Neons = {
    {label = 'White',			r = 255, 	g = 255, 	b = 255},
    {label = "Slate Gray",		r = 112, 	g = 128, 	b = 144},
    {label = "Blue",			r = 0, 		g = 0, 		b = 255},
    {label = "Light Blue",		r = 0, 		g = 150, 	b = 255},
    {label = "Navy Blue", 		r = 0, 		g = 0, 		b = 128},
    {label = "Sky Blue", 		r = 135, 	g = 206, 	b = 235},
    {label = "Turquoise", 		r = 0, 		g = 245, 	b = 255},
    {label = "Mint Green", 		r = 50, 	g = 255, 	b = 155},
    {label = "Lime Green", 		r = 0, 		g = 255, 	b = 0},
    {label = "Olive", 			r = 128, 	g = 128, 	b = 0},
    {label = 'Yellow', 			r = 255, 	g = 255, 	b = 0},
    {label = 'Gold', 			r = 255, 	g = 215, 	b = 0},
    {label = 'Grange', 			r = 255, 	g = 165, 	b = 0},
    {label = 'Wheat', 			r = 245, 	g = 222, 	b = 179},
    {label = 'Red', 			r = 255, 	g = 0, 		b = 0},
    {label = 'Pink', 			r = 255, 	g = 161, 	b = 211},
    {label = 'Brightpink',		r = 255, 	g = 0, 		b = 255},
    {label = 'Purple', 			r = 153, 	g = 0, 		b = 153},
    {label = "Ivory", 			r = 41, 	g = 36, 	b = 33}
}
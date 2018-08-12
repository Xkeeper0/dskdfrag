local Disk	= Class{ disk = nil }

function Disk:init(w, h)
	local disk	= {}
	disk.files	= {}
	disk.clusters	= {}
	disk.emptyClusters	= {}

	-- This is a hilariously inefficient way to do this probably
	local c = 1
	for x = 1, w do
		for y = 1, h do
			-- Make a list of every open cluster, for later
			disk.emptyClusters[c]	= { x = x, y = y }
			c	= c + 1
		end
	end

	self.disk	= disk
	return self
end

-- Get the total number of free clusters
function Disk:getEmptyClusterCount()
	return #self.disk.emptyClusters
end

-- Add a random file to the disk.
-- size is the count of clusters
-- actual usage may vary depending on availability of space
function Disk:addFile(filename, size)
	local freeSpace		= self:getEmptyClusterCount()
	if freeSpace < size then
		return false, "not enough free space"
	end


end


-- Add a filename to the disk. Internal for tracking indexes and such
function Disk:addFilename(filename)


end

return Disk

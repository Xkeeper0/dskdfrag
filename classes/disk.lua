-- Disk class for the game. Holds the... uh, disk. And the files.
-- and all the other things.
-- it's a bit important.

local Disk	= Class{ disk = nil }

-- Create a new disk object for use wherever
function Disk:init(size)
	local disk			= {}

	-- table of files. { 1 = {filename = filename , clusters = {5, 1, 37, 172, 7}}, ... }
	disk.files			= {}
	disk.files[-1]		= {filename = "unused", clusters = {}}
	-- table of clusters { 1 = {fileIndex=7}, 2 = nil, ... }
	disk.clusters		= {}
	-- table of empty cluster indexes that are not allocated yet.
	disk.unassignedClusters	= {}

	-- Create the unassigned cluster table. Basically just a table of ids
	for c = 1, size do
		-- Make a list of every open cluster, for later
		disk.unassignedClusters[c]	= c
	end

	self.disk	= disk
	return self
end

-- Get the total number of free clusters
function Disk:getUnassignedClusterCount()
	return #self.disk.unassignedClusters
end


-- Add a random file to the disk.
-- size is the count of clusters
-- actual usage may vary depending on availability of space
function Disk:addFile(filename, size)
	local freeSpace		= self:getUnassignedClusterCount()
	if freeSpace < size then
		return false, "not enough free space"
	end

	-- technically we should probably have some additional space for things
	-- like additional extra lost/bonus clusters, but i'll worry about that
	-- later, when i'm not trying to fit comments in under 80 characters
	local fileIndex	= self:addFilename(filename)

	for i = 1, size do
		local randomCluster	= self:getRandomClusterAndMarkAsUsed()
		self:assignClusterToFile(fileIndex, i, randomCluster)
	end

end


function Disk:assignUnusedSpace()
	local remaining	= self:getUnassignedClusterCount()
	if remaining == 0 then return end

	for i = 1, remaining do
		local c		= self:getRandomClusterAndMarkAsUsed()
		self:assignClusterToFile(-1, i, c)
	end

end


-- Add a filename to the disk. Internal for tracking indexes and such
-- Assumes that they have been added in order -- if you try to mess with
-- the indexes manually you will cause all sorts of fun and exciting problems
function Disk:addFilename(filename)
	local fileIndex		= #self.disk.files + 1
	self.disk.files[fileIndex]	= { name = filename, clusters = {} }

	return fileIndex
end


-- assign a given cluster to a file.
-- using this out of order will break everything so DONT DO IT
function Disk:assignClusterToFile(fileIndex, clusterIndex, diskClusterIndex)
	self.disk.clusters[diskClusterIndex]	= { fileIndex = fileIndex, clusterIndex = clusterIndex }
	self.disk.files[fileIndex].clusters[clusterIndex]	= diskClusterIndex
end


-- Gets an index of one of the remaining clusters and returns its id,
-- shrinking the array of remaining clusters by one in the process
function Disk:getRandomClusterAndMarkAsUsed()
	-- Get the count of empty clusters available
	local count			= self:getUnassignedClusterCount()
	-- Get a random remaining cluster btwn 1-(count)
	local cluster		= love.math.random(count)
	-- Get the actual index for it
	local clusterIndex	= self.disk.unassignedClusters[cluster]

	-- replace the cluster index we got with the last one in the array,
	-- and then remove it from the list.
	self.disk.unassignedClusters[cluster]	= self.disk.unassignedClusters[count]
	self.disk.unassignedClusters[count]		= nil

	return clusterIndex
end





return Disk

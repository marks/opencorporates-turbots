# -*- coding: utf-8 -*-

# TODO: collect line_hash`s into an array so we can match the count to the count at the bottom of the PDF

require 'json'
require 'turbotlib'
require 'pdf-reader'

# define metadata
PDF_URL = "http://www.cimoney.com.ky/WorkArea/DownloadAsset.aspx?id=3803"
DATE = Time.now

Turbotlib.log("Starting run...") # optional debug logging

Turbotlib.log("Downloading pdf...") 
io = open(PDF_URL)
reader = PDF::Reader.new(io)

Turbotlib.log("Processing pdf...") 
reader.pages.each do |page|
	lines = page.text.split("\n").select{|x| x != ""}
	lines.each do |line|
		line_hash = {}
		line_hash[:data] = line.split(/\W{3,}/).select{|x| x != ""}
		if line_hash[:data].size == 3
			line_hash[:licence_number] = line_hash[:data][0].scan(/(\d+) .+/).first.first
			line_hash[:licence_name] = line_hash[:data][0].gsub("#{line_hash[:licence_number]} ","")
			line_hash[:licence_type] = line_hash[:data][1]
			line_hash[:recognised] = line_hash[:data][2]
			line_hash.delete(:data)

			# add metadata
			line_hash[:source_url] = PDF_URL
			line_hash[:sample_date] = DATE

			puts JSON.dump(line_hash)
		end
	end
end

Turbotlib.log("Run done") 

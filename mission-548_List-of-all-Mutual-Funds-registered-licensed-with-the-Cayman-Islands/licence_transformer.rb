# -*- coding: utf-8 -*-

require 'json'

STDIN.each_line do |line|
  raw_record = JSON.parse(line)

  licence_record = {
    :company_name => raw_record['mutual_fund_name'],
    :company_jurisdiction => 'Cayman Islands',
    :licence_jurisdiction => 'Cayman Islands',
    :source_url => raw_record['source_url'],
    :sample_date => raw_record['sample_date'],
    :licence_number => raw_record['licence_number'],
    :status => raw_record['registration_type'],
    :jurisdiction_classification => 'Mutual Fund',
    :regulator => "Cayman Islands Monetary Authority",
    :category => "Financial",
    :confidence => 'HIGH',
  }

  puts licence_record.to_json
end
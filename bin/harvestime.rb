#!/usr/bin/env ruby
require 'harvested'
require 'harvestime'
require 'thor'
require 'yaml'
require 'pp'

class HarvestimeCLI < Thor
  include Thor::Actions
# Invoices
  desc 'all_invoices <STATUS> <ACCOUNT_INDEX>',
       'Find all invoices with optional status and account index'
  method_option :status,        aliases: '-s', default: 'all', type: :string,  banner: 'status of the invoice'
  method_option :account_index, aliases: '-a', default: 0,     type: :numeric, banner: 'Account index according to %HOME%/.harvestime_client.yml'
  def all_invoices
    puts "Account index given #{options[:account_index]}"
    credentials = YAML.load(File.open(File.join(Dir.home, '.harvestime_client.yml')))
    client = Harvest.hardy_client(credentials[options[:account_index]][:subdomain],
                                  credentials[options[:account_index]][:username],
                                  credentials[options[:account_index]][:password])
    pp Harvestime::InvoiceFilter.new(client).all_with_status(options[:status])
  end

# Time
  desc 'all_times <ACCOUNT_INDEX> <DATE>',
       "Find all of a date's time entries, defaulting to today and the first account"
  method_option :account_index, aliases: '-a', default: 0,               type: :numeric,  banner: 'Account index according to %HOME%/.harvestime_client.yml'
  method_option :date,          aliases: '-d', default: Date.today.to_s, type: :string,   banner: 'Entry date'
  def all_times
    credentials = YAML.load(File.open(File.join(Dir.home, '.harvestime_client.yml')))
    client = Harvest.hardy_client(credentials[options[:account_index]][:subdomain],
                                  credentials[options[:account_index]][:username],
                                  credentials[options[:account_index]][:password])
    pp Harvestime::TimeFilter.new(client).all_times_in_date(Date.parse(options[:date]))
  end

  desc 'create_time_entry [PROJECT_ID] [TASK_ID] <ACCOUNT_INDEX> <NOTES> <HOURS> <SPENT_AT>',
       'Create a time entry with a given project and task id, with optional account index, notes, hours spent, and date spent at.'
  method_option :project_id,    required: true,  aliases: '-p',  type: :numeric, banner: 'project id'
  method_option :task_id,       required: true,  aliases: '-t',  type: :numeric, banner: 'task id'
  method_option :account_index, aliases: '-a',   default: 0,               type: :numeric,  banner: 'Account index according to %HOME%/.harvestime_client.yml'
  method_option :notes,         aliases: '-n',   default: '',              type: :string,   banner: 'Project Notes'
  method_option :hours,         aliases: '-h',   default: 0,               type: :numeric,  banner: 'Time in hours spent on project'
  method_option :spent_at,      aliases: '-d',   default: Date.today.to_s, type: :string,   banner: 'Date for time entry'
  def create_time_entry
    credentials = YAML.load(File.open(File.join(Dir.home, '.harvestime_client.yml')))
    client = Harvest.hardy_client(credentials[options[:account_index]][:subdomain],
                                  credentials[options[:account_index]][:username],
                                  credentials[options[:account_index]][:password])
    time_filter = Harvestime::TimeFilter.new(client)
    time_filter.create_entry(time_filter.build_entry( notes:      options[:notes],
                                                      hours:      options[:hours],
                                                      project_id: options[:project_id],
                                                      task_id:    options[:task_id],
                                                      spent_at:   options[:spent_at]))
    puts "Entry created"
  end

  desc 'move_entry [FROM_ACCOUNT_INDEX] [TO_ACCOUNT_INDEX] [ENTRY_ID] <DATE>',
       'Copy a time entry from one account to another, given the indexes for both accounts as well as the time entry id'
  method_option :from_account, required: true,  aliases: '-f',            type: :numeric, banner: 'Time entry origin account index according to %HOME%/.harvestime_client.yml'
  method_option :to_account,   required: true,  aliases: '-t',            type: :numeric, banner: 'Time entry destination account index according to %HOME%/.harvestime_client.yml'
  method_option :entry_id,     required: true,  aliases: '-e',            type: :numeric, banner: 'Time entry ID'
  method_option :date,         aliases:  '-d',  default: Date.today.to_s, type: :string,  banner: 'Date of time entry (default today)'
  def move_entry
    credentials = YAML.load(File.open(File.join(Dir.home, '.harvestime_client.yml')))
    to_client = Harvest.hardy_client(credentials[options[:to_account]][:subdomain],
                                     credentials[options[:to_account]][:username],
                                     credentials[options[:to_account]][:password])
    entry = to_client.time.all(options[:date]).detect {|ent| ent.id == options[:entry_id]}
    if entry
      pp Harvestime::TimeFilter.new(to_client)
      .copy_entry_from(Harvest.hardy_client(credentials[options[:from_account]][:subdomain],
                                            credentials[options[:from_account]][:username],
                                            credentials[options[:from_account]][:password]), entry)  
    else
      puts 'ERROR: Entry not found'
    end
  end

  desc 'move_date_range [FROM_ACCOUNT_INDEX] [TO_ACCOUNT_INDEX] [START_DATE] [END_DATE]',
       'Copy several time entries from one account to another, given the indexes for both accounts as well as a start and an end date for the ragne of entries to move'
  method_option :from_account, required: true, aliases: '-f', type: :numeric, banner: 'Time entry origin account index according to %HOME%/.harvestime_client.yml'
  method_option :to_account,   required: true, aliases: '-t', type: :numeric, banner: 'Time entry destination account index according to %HOME%/.harvestime_client.yml'
  method_option :start_date,   required: true, aliases: '-s', type: :string,  banner: 'Start date (YYYY-MM-DD)'   
  method_option :end_date,     required: true, aliases: '-e', type: :string,  banner: 'End date (YYYY-MM-DD)'
  def move_date_range
    credentials = YAML.load(File.open(File.join(Dir.home, '.harvestime_client.yml')))
    pp Harvestime::TimeFilter.new(Harvest.hardy_client(credentials[options[:to_account]][:subdomain],
                                                       credentials[options[:to_account]][:username],
                                                       credentials[options[:to_account]][:password]))
    .copy_date_range(Harvest.hardy_client(credentials[options[:from_account]][:subdomain],
                                          credentials[options[:from_account]][:username],
                                          credentials[options[:from_account]][:password]),
    options[:start_date], options[:end_date])
  end

  desc 'purge_times [ACCOUNT_INDEX] <FORCE> <START_DATE> <END_DATE>',
       'Delete all time entries from today or a given date range'
  method_option :account_index, required: true, aliases: '-a', type: :numeric, banner: 'Account index to clear time entries of'
  method_option :force,         default: false, aliases: '-f', type: :boolean, banner: 'Go through with the purge'
  method_option :start_date,    default: Date.today.to_s, type: :string, banner: 'Start date for range clearing'
  method_option :end_date,      default: Date.today.to_s, type: :string, banner: 'End date for range clearing'
  def purge_times
    credentials = YAML.load(File.open(File.join(Dir.home, '.harvestime_client.yml')))
    pp Harvestime::TimeFilter.new(Harvest.hardy_client(credentials[options[:account_index]][:subdomain],
                                                       credentials[options[:account_index]][:username],
                                                       credentials[options[:account_index]][:password]))
      .delete_date_range(options[:start_date], options[:end_date])
  end
  
end
HarvestimeCLI.start
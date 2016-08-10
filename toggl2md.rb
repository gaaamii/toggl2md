# ruby toggl2md.rb output.md
require 'json'
require 'date'
require 'time'

def duration_format(milisec)
  (Time.parse("1/1") + (milisec / 1000)).strftime("%H時間%M分%S秒")
end

def run
  time_format = "%H:%M"
  json_file_path = './response.json'
  
  json_data = open(json_file_path) { |io| JSON.load(io) }
  
  File.open(ARGV[0], "w") do |file|
    file.puts "# #{Date.today} の日報"
    json_data['data'].each do |data|
      data.each do |d|
        file.puts("## Issue #{d[1]}") if d.include?('description')
        file.print("- #{Time.parse(d[1]).strftime(time_format)}〜") if d.include?('start')
        file.puts("- #{Time.parse(d[1]).strftime(time_format)}") if d.include?('end')
        puts("#{d[1]}") if d.include?('description')
        file.puts("- #{duration_format(d[1])}") if d.include?('dur')
        file.print("\n") if d.include?('dur')
      end
    end
  end
end

run

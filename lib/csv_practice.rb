# csv_practice.rb
require 'csv'
require 'awesome_print'

# Part 1 - CSV Practice
def load_data(filename)
    return CSV.read(filename, headers: true).map { |line| line.to_h }
end

def total_medals_per_country(olympic_data)
    output = Array.new
    olympic_data.each do |hash|
        index = output.find_index { |element| element[:country] == hash["Team"]}
        if index
            if hash["Medal"] != "NA"
                output[index][:count] += 1
            end 
        else
            new_country = {country: hash["Team"], count: 0}
            if hash["Medal"] != "NA"
                new_country[:count] += 1
            end
            output << new_country
        end
    end
    return output  
end

def save_medal_totals(filename, medal_totals)
    CSV.open(filename, 'w') do |file|
        medal_totals.each do |country|
            file << [country[:country], country[:count]]
        end
    end
end

# Part 2 - More Enumerable Practice

def all_gold_medal_winners(olympic_data)
    return olympic_data.select { |element| element["Medal"] == "Gold" }
end

def medals_sorted_by_country(medal_totals)
    return medal_totals.sort_by { |element| element[:country] }
end

def country_with_most_medals(medal_totals)
    return medal_totals.max_by { |hash| hash[:count] }
end

def athlete_height_in_inches(olympic_data)
    output = Array.new
    olympic_data.each do |element|
        new_information = element.dup
        new_information["Height"] =  new_information["Height"].to_i / 2.5
        output << new_information 
    end
    return output
end

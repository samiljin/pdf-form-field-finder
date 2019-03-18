require 'pdf-forms'

file_path = ARGV[0]

if file_path.nil?
  puts 'Give path to the PDF template as an argument'
  puts "\nrun command example:"
  puts 'ruby main.rb /path/to/pdf/template.pdf'

  return
end

pdftk       = PdfForms.new(utf8_fields: true)
field_names = pdftk.get_field_names(file_path)
field_names = field_names.reduce({}) do |result, value|
  result.merge(value => value)
end

output_filename = "output/#{Time.now.to_i}.pdf"

pdftk.fill_form(file_path, output_filename, field_names)

puts "All done!"
puts "Template filled with form field names can be found in #{__dir__}/#{output_filename}"
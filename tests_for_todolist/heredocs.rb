def show_one
  here_doc = <<-DOC.chomp.gsub /^\s+/, ""
  Fred
  Sue
  Will
  DOC
end

puts show_one + "..."

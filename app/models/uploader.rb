class Uploader
  
  def load(files = [], user)
  
    result = files.collect do |f|
      if file = File.new(f, "w+") then delegate_file(file) end
    end
    
    case result.length
      when 0 then nil
      when 1 then result[0]
      else result  
    end 

  end	

private
  
  def delegate_file(file)
    ext = file.extname.to_sym
    
    if image_file_extensions.includes? ext
      Image.create(file, user)
    
    elsif compressed_file_extensions.includes ext
      load(file.decompress)
    end      

    
  end	
   
  def image_file_extensions
   [:gif, :jpg, :png]
  end

  def compressed_file_extensions
    [:zip, :gz, :tar]
  end

end
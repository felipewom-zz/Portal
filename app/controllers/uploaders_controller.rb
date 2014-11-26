class UploadersController < ApplicationController
  before_filter :authenticate_user!
  def index
    @folders = Folder.all
    unless params["uploader"].blank?
      unless params["uploader"]["folder_id"].empty? || params["uploader"]["folder_id"] == "0"
        @uploaders = Uploader.find_all_by_folder_id(params["uploader"]["folder_id"])
        @current_folder = Folder.find(params["uploader"]["folder_id"])
      else
        @uploaders = Uploader.all
        @current_folder = {"name" => "Todas as pastas", "id" => "0"}
      end
    else
      @uploaders = Uploader.all
      @current_folder = {"name" => "Todas as pastas", "id" => "0"}
    end
    unless params[:format].nil?
      @folder = Folder.find(params[:format])
    else
      @folder = Folder.new
    end
    unless params['folder_id'].nil?
      @folder = Folder.find(params['folder_id'])
    end
    @attach = Uploader.new
  end

  def add_attach
    attachments = Hash["attachment" => params[:uploader].first[1]]
    files = []
    for a in attachments['attachment']
      files <<  a
    end
    attachments = []
    files.each do |file|
      @uploader           = Uploader.new(Hash["attachment" => file,])
      @uploader.folder_id = params[:uploader][:folder_id]
      @uploader.role_id   =  current_user.role_ids.first
      @uploader.author    = current_user.name
      @uploader.user_id   = current_user.id
      puts (@uploader.inspect)
      @uploader.save
      attachments << @uploader.file_name
    end
    if @uploader.save
      puts('-----salvou----')
      # if attachments.length > 1
      #   redirect_to new_uploader_path, notice: "Os arquivos #{attachments.to_s} foram armazenados com sucesso."
      # else
      #   redirect_to new_uploader_path, notice: "O arquivo #{@uploader.file_name} foi armazenado."
      # end
    else
      puts('-----falhou----')
    end
  end

  def new
    unless params[:format].nil?
      @folder = Folder.find(params[:format])
    else
      @folder = Folder.new
    end
    unless params['folder_id'].nil?
      @folder = Folder.find(params['folder_id'])
    end
    @uploader = Uploader.new
  end

  def create
    unless params[:format].nil?
      @folder = Folder.find(params[:format])
    else
      @folder = Folder.new
    end
    unless params['folder_id'].nil?
      @folder = Folder.find(params['folder_id'])
    end
    attachments = Hash["attachment" => params[:uploader].first[1]]
    files = []
    for a in attachments['attachment']
      files <<  a
    end
    attachments = []
    files.each do |file|
      @uploader           = Uploader.new(Hash["attachment" => file,])
      @uploader.folder_id = params[:uploader][:folder_id]
      @uploader.role_id   =  current_user.role_ids.first
      @uploader.author    = current_user.name
      @uploader.user_id   = current_user.id
      puts (@uploader.inspect)
      @uploader.save
      attachments << @uploader.file_name
    end
    if @uploader.save
      if attachments.length > 1
        redirect_to folder_path(params[:uploader][:folder_id]), notice: "Os arquivos #{attachments.to_s} foram armazenados com sucesso."
      else
        redirect_to folder_path(params[:uploader][:folder_id]), notice: "O arquivo #{@uploader.file_name} foi armazenado."
      end
    else
      render "new"
    end
  end

  def destroy
    @uploader = Uploader.find(params[:id])
    @uploader.destroy
    redirect_to uploaders_path, notice:  "O arquivo #{@uploader.file_name} foi deletado."
  end

  def download_file
    @uploader = Uploader.find(params[:id])
    attachment = "#{Rails.root}"+"#{@uploader.attachment.url}"
    send_file attachment,
              :disposition => "attachment"
  end

  def download_all
    attachment = []
    params[:id].each do |key|
    # keys.each do |key|
      attachment << Uploader.find(key)
    end
    folder_name = Folder.find(attachment.first.folder_id).name
    make_zip(attachment, folder_name)
    # make_temp_zip(attachment)
  end

  def make_zip(files_list, folder_name)
    require 'rubygems'
    require 'zip'
    require 'fileutils'
    FileUtils.rm_r "tmp/"
    temp_folder = FileUtils.mkdir_p "tmp/#{Time.now.strftime("%H%M%S")}", :mode => 0700
    zipname = "#{Time.now.strftime("%H%M%S")}_#{folder_name}.zip".gsub(/\s+/, "_")
    zipfile_folder = "#{temp_folder.first}/#{zipname}"
    Zip::File.open(zipfile_folder, Zip::File::CREATE) do |zipfile|
      files_list.each do |file|
        folder = "#{Rails.root}" + file.attachment.url
        filename = "#{file.id}_" + file.file_name
        # Two arguments:
        # - The name of the file as it will appear in the archive
        # - The original file, including the path to find it
        zipfile.add(filename, folder)
      end
      # zipfile.get_output_stream("myFile.txt") { |os| os.write "myFile contains just this" }
    end
    send_file zipfile_folder,
              :disposition => "attachment"
  end


  def make_temp_zip(files_list)
    #Attachment name
    # filename = 'basket_images-'+params[:delivery_date].gsub(/[^0-9]/,'')+'.zip'
    filename =  "#{Rails.root}"+"/public/tmp/temp_archive.zip"
    temp_file = Tempfile.new(filename)
    begin
      #This is the tricky part
      #Initialize the temp file as a zip file
      Zip::OutputStream.open(temp_file) { |zos| }

      #Add files to the zip file as usual
      Zip::File.open(temp_file.path, Zip::File::CREATE) do |zip|
        #Put files in here
        files_list.each do |file|
          folder = "#{Rails.root}" + file.attachment.url
          filename = file.file_name + "_#{file.id}"
          # Two arguments:
          # - The name of the file as it will appear in the archive
          # - The original file, including the path to find it
          zip.add(filename, folder)
        end
        # zip.get_output_stream("myFile") { |os| os.write "myFile contains just this" }
      end

      #Read the binary data from the file
      zip_data = File.read(temp_file.path)

      #Send the data to the browser as an attachment
      #We do not send the file directly because it will
      #get deleted before rails actually starts sending it
      puts "Done!"
      send_data(zip_data, :type => 'application/zip', :filename => filename)
    ensure
      #Close and delete the temp file
      temp_file.close
      temp_file.unlink
    end
  end

  def search
    unless params[:file_name].blank?
      @args = params[:file_name]
      if current_user.roles.first.name == 'admin'
        @files = Uploader.where("file_name LIKE ?", "%#{@args}%")
      else
        @files = Uploader.where("file_name LIKE ? and role = '#{current_user.roles.first.name}'", "%#{@args}%")
      end
    else
      @files = Uploader.all
    end
  end

  require 'sinatra'
  require 'pp'

  def file_info
    puts ('-----file_info Controller action-------')
    file = params['our-file']
    details = {
        :filename => file[:filename],
        :type => file[:type],
        :head => file[:head],
        :name => file[:name],
        :tempfile_path => file[:tempfile].path,
        :tempfile_size => file[:tempfile].size,
    }
    pretty_str details
  end
  def pretty_str(obj)
    puts ('-----pretty Controller action-------')
    ''.tap{|output| PP.pp(obj, output) }
  end

end
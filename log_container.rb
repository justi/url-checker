class LogContainer

    def write_logs(content)
        begin
          file = File.open("error_log.txt", "w")
          file.write(content)
        rescue IOError => e
            puts e
        ensure
          file.close unless file.nil?
        end
    end

    def read_logs
        File.read("error_log.txt") if File.exists?("error_log.txt")
    end
end

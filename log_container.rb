class LogContainer

    def write_logs(content)
        begin
          file = File.open("log.txt", "w")
          file.write(content)
        rescue IOError => e
            puts e
        ensure
          file.close unless file.nil?
        end
    end

    def read_logs
        File.read("log.txt") if File.exists?("log.txt")
    end
end

module Codelog
  module Output
    class ReleaseFile
      def self.print(content, file_path)
        new.print(content, file_path)
      end

      def print(content, file_path)
        Dir.chdir Dir.pwd do
          File.open(file_path, 'a') do |line|
            line.puts content
          end
        end
      end
    end
  end
end

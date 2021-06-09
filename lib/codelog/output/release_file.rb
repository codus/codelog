module Codelog
  module Output
    class ReleaseFile
      def initialize(file_path)
        @file_path = file_path
      end

      def self.print(content, file_path)
        new(file_path).print(content)
      end

      def print(content)
        Dir.chdir Dir.pwd do
          File.open(@file_path, 'w+') do |line|
            line.puts content
          end
        end
      end
    end
  end
end

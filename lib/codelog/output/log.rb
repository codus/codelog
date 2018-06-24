module Codelog
  module Output
    class Log
      def self.print(content)
        new.print(content)
      end

      def print(content)
        IO.popen('less', 'w') { |output| output.puts content }
      end
    end
  end
end

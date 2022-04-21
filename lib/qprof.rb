# frozen_string_literal: true

require 'securerandom'
require 'benchmark'

require 'ruby-prof'
require 'ruby-prof-flamegraph'
require 'launchy'

module QProf
  class << self
    def call(title = 'Flame Graph')
      FileUtils.mkdir_p('/tmp/qprof')
      run = "#{Time.now.to_i}-#{SecureRandom.hex(4)}"
      run_txt_path = "/tmp/qprof/#{run}.txt"
      run_svg_path = "/tmp/qprof/#{run}.svg"
      flamegraph_pl_path = '/tmp/qprof/FlameGraph/flamegraph.pl'

      `git clone https://github.com/brendangregg/FlameGraph.git #{File.dirname(flamegraph_pl_path)}` unless File.exist?(flamegraph_pl_path)

      result = RubyProf.profile do
        @benchmark = Benchmark.measure do
          yield
        end
      end

      subtitle = %i[utime stime real]
        .map { |x| "#{x} = #{@benchmark.send(x).round(4)}s" }
        .join('; ')
      printer = RubyProf::FlameGraphPrinter.new(result)
      File.open(run_txt_path, 'w') { |file| printer.print(file) }
      `cat #{run_txt_path} | #{flamegraph_pl_path} --title \"#{title}\" --subtitle \"#{subtitle}\" > #{run_svg_path}`
      Launchy.open(run_svg_path)
    end
  end
end

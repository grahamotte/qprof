# frozen_string_literal: true

require 'securerandom'
require 'stackprof'
require 'launchy'

module QProf
  class << self
    def call(title = '')
      FileUtils.mkdir_p('/tmp/qprof')
      run = "#{Time.now.to_i}-#{SecureRandom.hex(4)}"
      dump_path = "/tmp/qprof/#{run}.dump"
      graph_path = "/tmp/qprof/#{run}.html"

      StackProf.run(mode: :cpu, interval: 2, raw: true, out: dump_path) do
        @value = yield
      end

      flame_io = StringIO.new # hotman
      StackProf::Report.from_file(dump_path).print_d3_flamegraph(flame_io)
      File.write(graph_path, flame_io.string)
      Launchy.open(graph_path)

      @value
    end
  end
end

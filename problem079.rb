#      1 -> [0, 2, 6, 8, 9]
#      2 -> [0, 8, 9]
#      3 -> [0, 1, 2, 6, 8, 9]
#      6 -> [0, 2, 8, 9]
#      7 -> [0, 1, 2, 3, 6, 8, 9]
#      8 -> [0, 9]
#      9 -> [0]

def graph
  return @graph if @graph

  # puts "populating graph"
  @graph = {}
  File.read("files/P079.txt").strip.split("\n").map(&:strip).each do |n|
    t1, t2, t3 = n.to_s.split("").map(&:to_i)

    @graph[t1] ||= []
    @graph[t1] << t2
    @graph[t1] << t3

    @graph[t2] ||= []
    @graph[t2] << t3

  end
  @graph = @graph.inject({}){|s, (n, a)| s.merge!({ n => a.uniq.sort }) }
end

def print_graph
  graph.to_a.sort_by{|n, a| n }.each do |n, a|
    puts "  #{n} -> #{a.inspect}"
  end
end

class Chain
  attr_reader :base_chain
  def initialize(base_chain=[])
    @base_chain = base_chain
  end

  def to_s
    @base_chain.inspect
  end
  alias_method :inspect, :to_s

  def code
    @base_chain.join
  end

  def next_chains
    if @base_chain.length == 0
      return graph.keys.map{|n| Chain.new([n]) }
    end

    last_element = @base_chain[-1]
    # puts "base chain: #{@base_chain.inspect}, last_element: #{last_element}"
    (graph[last_element]||[]).map{|n| Chain.new(@base_chain + [n]) }
  end
end

c = Chain.new
queue = [c]
queue_index = 0

loop do 
  lc = queue[queue_index]
  queue += lc.next_chains
  queue_index += 1

  break if queue_index == queue.length - 1
end

sorted_nums = graph.to_a.flat_map{|k, v| [k, *v] }.uniq.sort
puts queue.select{|q| q.base_chain.sort == sorted_nums }.map(&:code)





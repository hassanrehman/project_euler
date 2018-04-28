=begin
List<int> p = new List<int>();
p.Add(1);
             
int n = 1;            
while(true){
    int i = 0;
    int penta = 1;
    p.Add(0);
 
    while (penta <= n){                    
        int sign = (i % 4 > 1) ? -1 : 1;
        p[n] += sign * p[n - penta];
        p[n] %= 1000000;
        i++;
                  
        int j = (i % 2 == 0) ? i / 2 + 1 : -(i / 2 + 1);
        penta = j * (3 * j - 1) / 2;
    } 
                 
    if (p[n] == 0) break;
    n++;
}
=end


class P
  def initialize
    @ps = [1, 1, 2]

    # Pk = k(3k-1)/2 for k = 1, −1, 2, −2, 3,
    pk = Enumerator.new do |r|
        0.upto(Float::INFINITY) do |i|
          k = ((i / 2) + 1) * (i%2 == 0 ? 1 : -1)
          r << (k*(3*k - 1))/2
        end
      end
    @pk = pk.first(100_000)
    run!
  end

  #p(n) = p(n-k)
  #  withs signs: ++--++--++--
  def p(n)
    (return @ps[n]) if @ps[n]

    sum = 0
    @pk.each_with_index do |k, i|
      if k > n
        break
      end
      sign = ( i % 4 <= 1 ? 1 : -1)
      sum += sign * p( n - k )
      sum %= 1_000_000   #keep it under control
    end
    @ps[n] = sum
    return sum
  end

  def run!
    n = 1
    loop do 
      p_n = p(n)
      # puts "n: #{n}, p_n: #{p_n}, #{@ps.length}"
      break if p_n % 1_000_000 == 0
      n += 1
    end
    puts n
  end
end

P.new




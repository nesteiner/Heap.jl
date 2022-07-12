using Heap, Test

@testset "test heap" begin
  heap = BinaryHeap(Int)

  for i in 1:10
    push!(heap, i)
  end

  println(heap)

  while !isempty(heap)
    value = extract!(heap)
    println(value)
  end
end
module Heap

import Base: push!, size, isempty, first, contains

mutable struct BinaryHeap{T}
  size::Int
  compare::Function
  treeArray::Vector{T}

  BinaryHeap(T::DataType, compare::Function = -) = new{T}(0, compare, T[])
end  


_parentIndex(index::Number) = floor(Int, index / 2)
_leftIndex(index::Number) = 2 * index
_rightIndex(index::Number) = 2 * index + 1

function push!(heap::BinaryHeap{T}, data::T) where T
  ipos = heap.size + 1
  ppos = _parentIndex(ipos)
  push!(heap.treeArray, data)

  while ipos > 1 && heap.compare(heap.treeArray[ppos], heap.treeArray[ipos]) < 0
    temp = heap.treeArray[ppos]
    heap.treeArray[ppos] = heap.treeArray[ipos]
    heap.treeArray[ipos] = temp

    ipos = ppos
    ppos = _parentIndex(ipos)
  end

  heap.size += 1
  
end

function extract!(heap::BinaryHeap{T}) where T
  heap.size == 0 && throw("cannot extract on a empty heap")

  result = first(heap.treeArray)
  save = heap.treeArray[heap.size]


  heap.size -= 1

  heap.treeArray[1] = save
  
  ipos = 1
  mpos = 1

  while true
    lpos = _leftIndex(ipos)
    rpos = _rightIndex(ipos)
    
    if lpos <= heap.size &&
      heap.compare(heap.treeArray[lpos], heap.treeArray[ipos]) > 0
      mpos = lpos
    else
      mpos = ipos
    end

    if rpos <= heap.size &&
      heap.compare(heap.treeArray[rpos], heap.treeArray[mpos]) > 0
      mpos = rpos
    end

    if mpos == ipos
      break
    else
      temp = heap.treeArray[mpos]
      heap.treeArray[mpos] = heap.treeArray[ipos]
      heap.treeArray[ipos] = temp

      ipos = mpos
    end
  end
  # return
  pop!(heap.treeArray)
  return result
end

size(heap::BinaryHeap) = heap.size
isempty(heap::BinaryHeap) = heap.size == 0

function topn(heap::BinaryHeap, n::Int)
  @assert n <= heap.size "n cannot be larger than heap size"

  return heap.treeArray[1:n]
end

first(heap::BinaryHeap) = begin
  @assert !isempty(heap) "cannot fetch data from an empty heap"

  return first(heap.tempArray)
end

contains(heap::BinaryHeap{T}, data::T) where T = begin
  in(data, heap.tempArray)
end

export BinaryHeap
export push!, extract!, size, topn
end # module

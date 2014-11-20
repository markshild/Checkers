board = Board.new
board[[4,3]] = board[[1,6]]
board[[1,6]] = nil
board[[5,2]].perform_move!([[5,2],[3,4],[1,6]])

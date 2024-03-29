defmodule MinesweeperTest do
  use ExUnit.Case
  doctest Minesweeper

  test "get_arr" do
    assert Minesweeper.get_arr([1,2,3,4],0) == 1
    assert Minesweeper.get_arr([],3) == nil
  end

  test "update_arr" do
    assert Minesweeper.update_arr([1,2,3,4],0,5) == [5,2,3,4]
    assert Minesweeper.update_arr([1,2,3,4],2,5) == [1,2,5,4]
  end

  test "get_pos" do
    assert Minesweeper.get_pos([[1,2,3],[1,2,3],[1,2,3]],{0,0}) == 1
    assert Minesweeper.get_pos([[1,2,3],[1,2,3],[1,2,3]],{0,1}) == 2
  end

  test "update_pos" do
    assert Minesweeper.update_pos([[1,2,3],[1,2,3],[1,2,3]],{0,0},5) == [[5,2,3],[1,2,3],[1,2,3]]
    assert Minesweeper.update_pos([[1,2,3],[1,2,3],[1,2,3]],{0,1},5) == [[1,5,3],[1,2,3],[1,2,3]]
    assert Minesweeper.update_pos([[1,2,3],[1,2,3],[1,2,3]],{1,2},5) == [[1,2,3],[1,2,5],[1,2,3]]
  end

  test "is_mine" do
    mines_board = [[false, false, false, false, false, false, false, false, false],
                   [false, false, false, false, false, false, false, false, false],
                   [false, false, false, false, false, false, false, false, false],
                   [false, false, false, false, false, false, false, false, false],
                   [false, false, false, false, true , false, false, false, false],
                   [false, false, false, false, false, true, false, false, false],
                   [false, false, false, false, false, false, false, false, false],
                   [false, false, false, false, false, false, false, false, false],
                   [false, false, false, false, false, false, false, false, false]]
    assert Minesweeper.is_mine(mines_board,{4,4}) == true
    assert Minesweeper.is_mine(mines_board,{3,4}) == false
  end

  test "is_valid_pos" do
    assert Minesweeper.is_valid_pos(9,{8,7}) == true
    assert Minesweeper.is_valid_pos(10,{9,9}) == true
    assert Minesweeper.is_valid_pos(6,{8,9}) == false
    assert Minesweeper.is_valid_pos(9,{12,8}) == false
    assert Minesweeper.is_valid_pos(9,{7,12}) == false
    assert Minesweeper.is_valid_pos(1,{0,0}) == true
    assert Minesweeper.is_valid_pos(1,{-1,0}) == false
  end

  test "valid_moves" do
    assert Minesweeper.valid_moves(3,{0,2}) == [{0,1},{1,1},{1,2}]
  end

  test "conta_minas_adj" do
    mines_board = [[false, false, false, false, false, false, false, false, false],
                   [false, false, false, false, false, false, false, false, false],
                   [false, false, false, false, false, false, false, false, false],
                   [false, false, false, false, false, false, false, false, false],
                   [false, false, false, false, true , false, false, false, false],
                   [false, false, false, false, false, true, false, false, false],
                   [false, false, false, false, false, false, false, false, false],
                   [false, false, false, false, false, false, false, false, false],
                   [false, false, false, false, false, false, false, false, false]]
    assert Minesweeper.conta_minas_adj(mines_board,{5,4}) == 2
    assert Minesweeper.conta_minas_adj(mines_board,{4,3}) == 1
    assert Minesweeper.conta_minas_adj(mines_board,{1,3}) == 0
  end

  test "get_tam" do
    mines_board = [[false, false, false, false, false, false, false, false, false],
                    [false, false, false, false, false, false, false, false, false],
                    [false, false, false, false, false, false, false, false, false],
                    [false, false, false, false, false, false, false, false, false],
                    [false, false, false, false, true , false, false, false, false],
                    [false, false, false, false, false, true, false, false, false],
                    [false, false, false, false, false, false, false, false, false],
                    [false, false, false, false, false, false, false, false, false],
                    [false, false, false, false, false, false, false, false, false]]
    assert Minesweeper.get_tam(mines_board) == 9
    assert Minesweeper.get_tam([[false, false, false],
                    [false, false, false],
                    [false, false, false]]) == 3
  end

  test "abre_posicao" do
    mines_board = [[false, false, false],
                  [false, false, false],
                  [false, false, false]]
    tab = [["-", "-", "-"],
          ["-", "-", "-"],
          ["-", "-", "-"]]
    assert Minesweeper.abre_posicao(tab,mines_board,{0,0}) == [["0", "-", "-"],
                                                              ["-", "-", "-"],
                                                              ["-", "-", "-"]]
    mines_board = [[false, false, false],
                  [true, true, false],
                  [false, false, false]]
    tab = [["-", "-", "-"],
          ["-", "-", "-"],
          ["-", "-", "-"]]
    assert Minesweeper.abre_posicao(tab,mines_board,{0,0}) == [["2", "-", "-"],
                                                              ["-", "-", "-"],
                                                              ["-", "-", "-"]]
    mines_board = [[false, false, false],
                  [false, false, false],
                  [false, false, false]]
    tab = [["0", "-", "-"],
          ["-", "2", "-"],
          ["-", "-", "-"]]
    assert Minesweeper.abre_posicao(tab,mines_board,{1,1}) == [["0", "-", "-"],
                                                              ["-", "2", "-"],
                                                              ["-", "-", "-"]]
    mines_board = [[false, false, false],
                  [true, true, false],
                  [false, false, false]]
    tab = [["2", "-", "-"],
          ["-", "-", "-"],
          ["-", "-", "-"]]
    assert Minesweeper.abre_posicao(tab,mines_board,{1,1}) == [["2", "-", "-"],
                                                              ["-", "*", "-"],
                                                              ["-", "-", "-"]]                                                       
  end

  test "abre_tabuleiro" do
    tab = [["-", "-", "-","-"],
          ["-", "-", "-","-"],
          ["-", "-", "1","-"],
          ["-", "-", "-","-"]]
    mines_board = [[true, false, true,true],
                  [false, true, false,false],
                  [false, false, false,false],
                  [true, false, false,false]]
    assert Minesweeper.abre_tabuleiro(mines_board,tab) == [["*", "3", "*","*"],
                                                           ["2", "*", "3","2"],
                                                           ["2", "2", "1","0"],
                                                           ["*", "1", "0","0"]]
    mines_board = [[false, false, false],
                  [true, true, false],
                  [false, false, false]]
    tab = [["2", "-", "-"],
          ["-", "-", "-"],
          ["-", "-", "-"]]
    assert Minesweeper.abre_tabuleiro(mines_board,tab) == [["2", "2", "1"],
                                                          ["*", "*", "1"],
                                                          ["2", "2", "1"]]
  end

  test "generate_line_positions" do
    assert Minesweeper.generate_line_positions(0,3) == [{0,0},{0,1},{0,2}]
    assert Minesweeper.generate_line_positions(0,1) == [{0,0}]
    assert Minesweeper.generate_line_positions(2,3) == [{2,0},{2,1},{2,2}]
  end

  test "generate_tab_positions" do
    assert Minesweeper.generate_tab_positions(3,3) == [[{0,0},{0,1},{0,2}],
                                                  [{1,0},{1,1},{1,2}],
                                                  [{2,0},{2,1},{2,2}]]
  end

  test "abre_linha" do
    mines_board = [[false, false, false],
                    [true, true, false],
                    [false, false, false]]
    tab = [["2", "-", "-"],
          ["-", "-", "-"],
          ["-", "-", "-"]]
    assert Minesweeper.abre_linha(tab,mines_board,[{0,0},{0,1},{0,2}]) == [["2", "2", "1"],
                                                                          ["-", "-","-"],
                                                                          ["-", "-","-"]]
    assert Minesweeper.abre_linha(tab,mines_board,[{1,0},{1,1},{1,2}]) == [["2", "-", "-"],
                                                                          ["*", "*","1"],
                                                                          ["-", "-","-"]]                                                                  
  end

  test "gera_lista" do
    assert Minesweeper.gera_lista(3,1) == [1,1,1]
    assert Minesweeper.gera_lista(1,"*") == ["*"]
  end

  test "gera_tabuleiro" do
    assert Minesweeper.gera_tabuleiro(3) == [["-", "-", "-"],
                                            ["-", "-", "-"],
                                            ["-", "-", "-"]]
    assert Minesweeper.gera_tabuleiro(1) == [["-"]]
  end

  test "gera_mapa_de_minas" do
    assert Minesweeper.gera_mapa_de_minas(3) == [[false, false, false],
                                                [false, false, false],
                                                [false, false, false]]
    assert Minesweeper.gera_mapa_de_minas(1) == [[false]]
  end

  test "conta_fechadas" do
    tab = [["2", "-", "-"],
          ["-", "-", "-"],
          ["-", "-", "-"]]
    assert Minesweeper.conta_fechadas(tab) == 8

    tab = [["2", "2", "2"],
          ["2", "2", "2"],
          ["2", "2", "2"]]
    assert Minesweeper.conta_fechadas(tab) == 0
  end

  test "conta_minas" do
    mines_board = [[false, false, false],
                  [true, true, false],
                  [false, false, false]]
    assert Minesweeper.conta_minas(mines_board) == 2

    mines_board = [[false, false, false],
                  [false, false, false],
                  [false, false, false]]
    assert Minesweeper.conta_minas(mines_board) == 0
  end

  test "check_end_game" do
    mines_board = [[false, false, false],
                  [true, true, false],
                  [false, false, false]]
    tab = [["2", "2", "1"],
          ["-", "-", "1"],
          ["2", "2", "1"]]

    assert Minesweeper.check_end_game(mines_board,tab) == true

    mines_board = [[false, false, false],
                  [true, true, false],
                  [false, false, false]]
    tab = [["2", "2", "1"],
          ["-", "-", "1"],
          ["2", "-", "1"]]

    assert Minesweeper.check_end_game(mines_board,tab) == false
  end

  test "get_header" do
    tab = [["2", "2", "1"],
          ["-", "-", "1"],
          ["2", "-", "1"]]
    assert Minesweeper.get_header(tab) == "\n     0 | 1 | 2 | \n-----------------\n"
  end

  test "get_line" do
    assert Minesweeper.get_line(["2", "2", "1"]) == "\e[32m2\e[0m | \e[32m2\e[0m | \e[34m1\e[0m |\n"
  end

  test "get_all_lines" do
    tab = [["2", "2", "1"],
          ["-", "-", "1"],
          ["2", "-", "1"]]
    assert Minesweeper.get_all_lines(tab) == 
    "0  | \e[32m2\e[0m | \e[32m2\e[0m | \e[34m1\e[0m |\n1  | - | - | \e[34m1\e[0m |\n2  | \e[32m2\e[0m | - | \e[34m1\e[0m |\n"
  end

  test "gera_repeticao_char" do
    assert Minesweeper.gera_repeticao_char(5,"_") == "_____"
  end

  test "print_board_test" do
    tab = [["2", "2", "1"],
          ["-", "-", "1"],
          ["2", "-", "1"]]
    Minesweeper.test_print_board(tab)
  end

  test "abre_jogada" do
    tab = [["-", "-", "-"],
          ["-", "-", "-"],
          ["-", "-", "-"]]
    mines_board = [[false, false, false],
                  [false, true, false],
                  [false, false, false]]
    assert Minesweeper.abre_jogada({0,0},mines_board,tab) == [["1", "-", "-"],
                                                              ["-", "-", "-"],
                                                              ["-", "-", "-"]]
    tab = [["-", "-", "-"],
          ["-", "-", "-"],
          ["-", "-", "-"]]
    mines_board = [[false, false, false],
                  [false, true, false],
                  [false, false, false]]
    assert Minesweeper.abre_jogada({1,1},mines_board,tab) == [["-", "-", "-"],
                                                              ["-", "-", "-"],
                                                              ["-", "-", "-"]]
    tab = [["-", "-", "-"],
          ["-", "-", "-"],
          ["-", "1", "-"]]
    mines_board = [[false, false, false],
                  [false, true, false],
                  [false, false, false]]
    assert Minesweeper.abre_jogada({2,1},mines_board,tab) == [["-", "-", "-"],
                                                              ["-", "-", "-"],
                                                              ["-", "1", "-"]] 
    tab = [["-", "-", "-"],
          ["-", "-", "-"],
          ["-", "-", "-"]]
    mines_board = [[true, false, false],
                  [false, false, false],
                  [false, false, false]]
    assert Minesweeper.abre_jogada({2,2},mines_board,tab) == [["-", "1", "0"],
                                                              ["1", "1", "0"],
                                                              ["0", "0", "0"]]  
    tab = [["-", "-", "-","-"],
          ["-", "-", "-","-"],
          ["-", "-", "1","-"],
          ["-", "-", "-","-"]]
    mines_board = [[false, false, false,false],
                  [false, true, false,false],
                  [false, false, false,false],
                  [false, false, false,false]]
    assert Minesweeper.abre_jogada({3,3},mines_board,tab) == [["-", "-", "1","0"],
                                                              ["-", "-", "1","0"],
                                                              ["1", "1", "1","0"],
                                                              ["0", "0", "0","0"]]
    mines_board = [[false, false, false,false],
                  [false, false, false,false],
                  [false, false, false,false],
                  [false, false, false,true]]
    assert Minesweeper.abre_jogada({0,0},mines_board,tab) == [["0", "0", "0","0"],
                                                               ["0", "0", "0","0"],
                                                               ["0", "0", "1","1"],
                                                               ["0", "0", "1","-"]]                                                                                                                                                                                                                                     
  end

  test "marca_posicao" do
    tab = [["-", "-", "1","0"],
          ["-", "-", "1","0"],
          ["1", "1", "1","0"],
          ["0", "0", "0","0"]]
    assert Minesweeper.marca_posicao(tab,{0,0}) == [["X", "-", "1","0"],
                                                    ["-", "-", "1","0"],
                                                    ["1", "1", "1","0"],
                                                    ["0", "0", "0","0"]]
    tab = [["-", "-", "1","0"],
          ["-", "-", "1","0"],
          ["1", "1", "1","0"],
          ["0", "0", "0","0"]]
    assert Minesweeper.marca_posicao(tab,{3,2}) == [["-", "-", "1","0"],
                                                    ["-", "-", "1","0"],
                                                    ["1", "1", "1","0"],
                                                    ["0", "0", "0","0"]]
    tab = [["-", "-", "1","0"],
          ["-", "-", "1","0"],
          ["1", "1", "1","0"],
          ["0", "0", "0","0"]]
    assert Minesweeper.marca_posicao(tab,{1,0}) == [["-", "-", "1","0"],
                                                    ["X", "-", "1","0"],
                                                    ["1", "1", "1","0"],
                                                    ["0", "0", "0","0"]]                                                   
  end

  test "is_integer?" do
    assert Minesweeper.is_integer?("123") == true
    assert Minesweeper.is_integer?("-1") == true
    assert Minesweeper.is_integer?("4") == true
    assert Minesweeper.is_integer?("outra_string") == false
    assert Minesweeper.is_integer?("") == false
    assert Minesweeper.is_integer?("-") == false
  end

  test "get_best_scores_list" do
    File.rm("resources/best_scores.txt")
    assert Score.get_best_scores_list("resources/best_scores.txt") == []
    File.write("resources/best_scores.txt","1 2 20.0 22.2",[:write])
    assert Score.get_best_scores_list("resources/best_scores.txt") == [{1,20.0},{2,22.2}]
  end

  test "get_best_score" do
    assert Score.get_best_score([{1,20.0},{2,22.2}],1) == {:best_score,20.0}
    assert Score.get_best_score([{1,20.0},{2,22.2}],3) == {:no_best_score,"There is no best score for this board size"}
    assert Score.get_best_score([],3) == {:no_best_score,"There is no best score for this board size"}
  end

  test "update_best_score" do
    assert Score.update_best_score([{1,20.0},{2,22.2}],2,20.2) == [{1,20.0},{2,20.2}]
  end

  test "new_board_size_best_score" do
    assert Score.new_board_size_best_score([{1,20.0},{2,22.2}],3,17.56) == [{1,20.0},{2,22.2},{3,17.56}]
  end

  test "upload_score" do
    assert Score.upload_score([{1,20.0},{2,22.2}],1,19.0) == [{1,19.0},{2,22.2}]
    assert Score.upload_score([{1,20.0},{2,22.2}],1,21.5) == [{1,20.0},{2,22.2}]
    assert Score.upload_score([{1,20.0},{2,22.2}],3,19.0) == [{1,20.0},{2,22.2},{3,19.0}]
  end
end

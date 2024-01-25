import Time from "./Time"

@Observed
export default class Game {
  board: number[] = [];
  isStarted: boolean = false;
  time: Time = new Time(0);
  gameMode: number = 0;
  isWon: boolean = false;
  isEnd: boolean = false;

  constructor(mode: number) {
    this.gameMode = mode;
    this.initialize();
  }

  initialize() {
    this.board = new Array(16).fill(0);

    this.addRandomTile();
    this.addRandomTile();

    this.isStarted = false;
    this.isWon = false;
    this.isEnd = false;
    this.time.clearTime();
  };

  addRandomTile() {
    let availableSpots: number[] = [];

    for(let i = 0; i < this.board.length; i++) {
      if(this.board[i] == 0) {
        availableSpots.push(i);
      }
    }

    if(availableSpots.length > 0) {
      let spot = availableSpots[Math.floor(Math.random() * availableSpots.length)];
      this.board[spot] = Math.random() > 0.9 ? 4 : 2;
    }
  }

  merge(column: number[]): number[] {
    column = column.filter(val => val !== 0);

    let flag = false;

    for(let i = 0; i < column.length - 1; i++) {
      if(column[i] == column[i + 1]) {
        column[i] *= 2;
        column[i + 1] = 0;
        if(column[i] == 2048) {
          flag = true;
        }
      }
    }

    column = column.filter(val => val !== 0);

    while(column.length < 4) {
      column.push(0);
    }

    if(flag) {
      this.isWon = true;
      this.endGame();
    }

    return column;
  }

  slideUp() {
    if(!this.isStarted) {
      this.isStarted = true;
      this.time.startTiming();
    }

    if(!this.isEnd) {
      let size = 4;
      let newBoard: number[] = new Array(16).fill(0);

      for(let i = 0; i < size; i++) {
        let column: number[] = [];
        for(let j = 0; j < size; j++) {
          column.push(this.board[i + j * size]);
        }
        column = this.merge(column);

        for(let j = 0; j < size; j++) {
          newBoard[i + j * size] = column[j];
        }
      }

      let flag = false;
      for(let i = 0; i < this.board.length; i++) {
        if(this.board[i] !== newBoard[i]) {
          flag = true;
        }
      }
      this.board = newBoard;
      if(flag) {
        this.addRandomTile();
      }

      if(this.isGameOver()) {
        this.endGame();
      }
    }
  }

  slideDown() {
    if(!this.isStarted) {
      this.isStarted = true;
      this.time.startTiming();
    }

    if(!this.isEnd) {
      let size = 4;
      let newBoard: number[] = new Array(16).fill(0);

      for(let i = 0; i < size; i++) {
        let column: number[] = [];
        for(let j = 0; j < size; j++) {
          column.unshift(this.board[i + j * size]);
        }
        column = this.merge(column);

        for(let j = 0; j < size; j++) {
          newBoard[i + j * size] = column[size - 1 - j];
        }
      }

      let flag = false;
      for(let i = 0; i < this.board.length; i++) {
        if(this.board[i] !== newBoard[i]) {
          flag = true;
        }
      }
      this.board = newBoard;
      if(flag) {
        this.addRandomTile();
      }

      if(this.isGameOver()) {
        this.endGame();
      }
    }
  }

  slideLeft() {
    if(!this.isStarted) {
      this.isStarted = true;
      this.time.startTiming();
    }

    if(!this.isEnd) {
      let size = 4;
      let newBoard: number[] = new Array(16).fill(0);

      for(let i = 0; i < size; i++) {
        let row: number[] = [];
        for(let j = 0; j < size; j++) {
          row.push(this.board[i * size + j]);
        }
        row = this.merge(row);

        for(let j = 0; j < size; j++) {
          newBoard[i * size + j] = row[j];
        }
      }

      let flag = false;
      for(let i = 0; i < this.board.length; i++) {
        if(this.board[i] !== newBoard[i]) {
          flag = true;
        }
      }
      this.board = newBoard;
      if(flag) {
        this.addRandomTile();
      }

      if(this.isGameOver()) {
        this.endGame();
      }
    }
  }

  slideRight() {
    if(!this.isStarted) {
      this.isStarted = true;
      this.time.startTiming();
    }

    if(!this.isEnd) {
      let size = 4;
      let newBoard: number[] = new Array(16).fill(0);

      for(let i = 0; i < size; i++) {
        let row: number[] = [];
        for(let j = 0; j < size; j++) {
          row.unshift(this.board[i * size + j]);
        }
        row = this.merge(row);

        for(let j = 0; j < size; j++) {
          newBoard[i * size + j] = row[size - 1 - j];
        }
      }

      let flag = false;
      for(let i = 0; i < this.board.length; i++) {
        if(this.board[i] !== newBoard[i]) {
          flag = true;
        }
      }
      this.board = newBoard;
      if(flag) {
        this.addRandomTile();
      }

      if(this.isGameOver()) {
        this.endGame();
      }
    }
  }

  isGameOver() {
    let size = 4;

    if(this.board.includes(0)) {
      return false;
    }

    for(let i = 0; i < size; i++) {
      for(let j = 0; j < size - 1; j++) {
        if(this.board[i * size + j] == this.board[i * size + j + 1]) {
          return false;
        }
      }
    }

    for(let i = 0; i < size - 1; i++) {
      for(let j = 0; j < size; j++) {
        if(this.board[i * size + j] == this.board[(i + 1) * size + j]) {
          return false;
        }
      }
    }

    return true;
  }

  endGame() {
    if(this.isStarted) {
      this.isEnd = true;

      this.time.stopTiming();
    }
  }

  getOverTitle() {
    if(this.isWon == true) {
      return "游戏胜利"
    } else {
      return "游戏失败"
    }
  }

  getOverMsg() {
    let maxNum = -1;

    for(let i of this.board) {
      maxNum = maxNum > i ? maxNum : i;
    }

    if(this.gameMode == 1) {
      if(maxNum == 4) {
        return "连秦始皇都见不到了T.T";
      } else if(maxNum == 8) {
        return "都是赵高害得我！"
      } else if(maxNum == 16) {
        return "曹贼你还我大汉江山！";
      } else if(maxNum == 32) {
        return "安史之乱亡我大唐……";
      } else if(maxNum == 64) {
        return "元人铁蹄果然厉害！";
      } else if(maxNum == 128) {
        return "还是朱元璋厉害……";
      } else if(maxNum == 256) {
        return "天地会的弟兄们，反清复明啊！";
      } else if(maxNum == 512) {
        return "连辛亥革命的黎明都没等到……";
      } else if(maxNum == 1024) {
        return "看不到天朝的太阳了 = =";
      } else if(maxNum == 2048) {
        return "中华人民共和国万岁！";
      } else {
        return `你获得了"${this.getDisplayMsg(maxNum)}"方块`;
      }
    } else {
      return `你获得了"${this.getDisplayMsg(maxNum)}"方块`;
    }
  }

  getDisplayMsg(value: number) {
    if(this.gameMode == 0) {
      return value == 0 ? "" : value.toString();
    } else if(this.gameMode == 1) {
      if(value == 2) {
        return "商";
      } else if(value == 4) {
        return "周";
      } else if(value == 8) {
        return "秦";
      } else if(value == 16) {
        return "汉";
      } else if(value == 32) {
        return "唐";
      } else if(value == 64) {
        return "宋";
      } else if(value == 128) {
        return "元";
      } else if(value == 256) {
        return "明";
      } else if(value == 512) {
        return "清";
      } else if(value == 1024) {
        return "ROC";
      } else if(value == 2048) {
        return "PRC";
      } else {
        return "";
      }
    } else if(this.gameMode == 2) {
      if(value == 2) {
        return "甲";
      } else if(value == 4) {
        return "乙";
      } else if(value == 8) {
        return "丙";
      } else if(value == 16) {
        return "丁";
      } else if(value == 32) {
        return "戊";
      } else if(value == 64) {
        return "己";
      } else if(value == 128) {
        return "庚";
      } else if(value == 256) {
        return "辛";
      } else if(value == 512) {
        return "壬";
      } else if(value == 1024) {
        return "癸";
      } else if(value == 2048) {
        return "终";
      } else {
        return "";
      }
    } else {
      return "";
    }
  }

  getColor(value: number) {
    if(value == 2) {
      return "#eee4da";
    } else if(value == 4) {
      return "#ede0c8";
    } else if(value == 8) {
      return "#f2b179";
    } else if(value == 16) {
      return "#f59563";
    } else if(value == 32) {
      return "#f67c5f";
    } else if(value == 64) {
      return "#f65e3b";
    } else if(value == 128) {
      return "#edcf72";
    } else if(value == 256) {
      return "#edcc61";
    } else if(value == 512) {
      return "#edc850";
    } else if(value == 1024) {
      return "#edc53f";
    } else if(value == 2048) {
      return "#edc22e";
    } else {
      return "#ececec";
    }
  }
}
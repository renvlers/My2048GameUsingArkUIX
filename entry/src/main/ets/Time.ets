@Observed
export default class Time {
  tolSeconds: number;
  interval: number = 0;

  constructor(tolSeconds: number) {
    this.tolSeconds = tolSeconds;
  }

  getString() {
    let seconds = this.tolSeconds % 60;
    let minutes = Math.floor(this.tolSeconds / 60) % 60;
    let hours = Math.floor(Math.floor(this.tolSeconds / 60) / 60);

    return `${Math.floor(hours / 10)}${hours % 10}:${Math.floor(minutes / 10)}${minutes % 10}:${Math.floor(seconds / 10)}${seconds % 10}`;
  }

  addOneSecond() {
    this.tolSeconds++;
  }

  startTiming() {
    this.interval = setInterval(() => {
      this.addOneSecond();
    }, 1000);
  }

  stopTiming() {
    clearInterval(this.interval);
  }

  clearTime() {
    this.tolSeconds = 0;
  }
}
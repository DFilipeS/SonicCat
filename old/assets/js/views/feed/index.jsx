import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import axios from 'axios';
import { Howl } from 'howler';
import 'moment-duration-format';
import moment from 'moment';

class PodcastView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      feed: null,
      state: 'stopped',
      currentlyPlaying: null,
      currentEntry: null,
      currentTime: 0,
      duration: 0,
      volume: 1.0
    };
  }

  componentWillMount() {
    axios.get(`/api/feeds/${feedId}`).then((data) => {
      this.setState({
        feed: data.data.feed
      });
    });
  }

  playEntry = (entry) => {
    if (this.player) {
      this.player.stop().unload();
    }

    this.player = new Howl({
      src: [entry.url],
      html5: true,
      volume: this.state.volume
    });

    this.player.once('load', () => {
      console.log('duration', this.player.duration());
      this.setState({ duration: this.player.duration() });
    });

    this.player.on('play', (id) => {
      console.log('play');
      this.timer = setInterval(() => { this.setState({ currentTime: this.state.currentTime + 1 }); }, 1000);
      this.setState({ state: 'playing', currentlyPlaying: id, currentEntry: entry });
    });

    this.player.on('pause', () => {
      console.log('pause');
      window.clearTimeout(this.timer);
    });

    this.player.on('stop', () => {
      console.log('stop');
      window.clearTimeout(this.timer);
      this.setState({ currentlyPlaying: null, state: 'stopped', duration: 0, currentTime: 0 });
    });

    this.player.play();
  }

  resume = () => {
    this.player.play(this.state.currentlyPlaying);
    this.setState({ state: 'playing' });
  }

  pause = () => {
    this.player.pause();
    this.setState({ state: 'paused' });
  }

  stop = () => {
    this.player.stop();
    this.setState({ state: 'stopped', currentlyPlaying: null, currentEntry: null });
  }

  goBack15 = () => {
    if (this.state.currentTime >= 15) {
      this.setState({ currentTime: this.state.currentTime - 15 });
      this.player.seek(this.state.currentTime - 15);
    } else {
      this.setState({ currentTime: 0 });
      this.player.seek(0);
    }
  }

  goForward15 = () => {
    if (this.state.currentTime <= this.state.duration - 15) {
      this.setState({ currentTime: this.state.currentTime + 15 });
      this.player.seek(this.state.currentTime + 15);
    } else {
      this.setState({ currentTime: this.state.duration });
      this.player.seek(this.state.duration);
    }
  }

  onVolumeChange = (e) => {
    this.setState({ volume: e.target.value });
    this.player.volume(e.target.value);
  }

  onSeek = (e) => {
    this.setState({ currentTime: parseInt(e.target.value) });
    this.player.seek(e.target.value);
  }

  renderEntries = () => {
    if (!this.state.feed) return null;
    return this.state.feed.entries.map((entry, index) => {
      return (
        <tr key={index}>
          <td>{entry.title}</td>
          <td>{moment(entry.date).format('YYYY-MM-DD')}</td>
          <td><button className="btn btn-primary btn-sm" type="button" onClick={() => { this.playEntry(entry); }}>Play</button></td>
        </tr>
      );
    });
  }

  render() {
    return (
      <div>
        <div className="player text-center">
          {
            this.state.currentlyPlaying != null ?
              <div style={{margin: "20px 0"}}>
                <p><strong>{this.state.currentEntry.title}</strong></p>
                {
                  this.state.duration > 0 ?
                    <div>
                      <input onChange={this.onSeek} type="range" min={0} max={this.state.duration} step={1} value={this.state.currentTime}/>
                      <p>{moment.duration(this.state.currentTime, "seconds").format("hh:mm:ss", { trim: false })} - {moment.duration(this.state.duration, "seconds").format("hh:mm:ss", { trim: false })}</p>
                    </div>
                    :
                    null
                  }
                <div className="btn-group">
                  <button className="btn btn-primary btn-sm" type="button" onClick={() => { this.goBack15(); }} disabled={this.state.currentlyPlaying == null}>Go back 15</button>
                  {
                    this.state.state == 'playing' ?
                      <button className="btn btn-primary btn-sm" type="button" onClick={() => { this.pause(); }}>Pause</button>
                      :
                      <button className="btn btn-primary btn-sm" type="button" onClick={() => { this.resume(this.state.currentlyPlaying); }} disabled={this.state.currentlyPlaying == null}>Play</button>
                  }
                  <button className="btn btn-primary btn-sm" type="button" onClick={() => { this.stop(); }} disabled={this.state.currentlyPlaying == null}>Stop</button>
                  <button className="btn btn-primary btn-sm" type="button" onClick={() => { this.goForward15(); }} disabled={this.state.currentlyPlaying == null}>Go forward 15</button>
                </div>
                <div style={{margin: "20px 0"}}>
                  <input onChange={this.onVolumeChange} type="range" min={0} max={1} step={0.01} value={this.state.volume}/>
                </div>
              </div> : null
          }
        </div>
        <table className="table table-hover">
          <thead>
            <tr>
              <th>Title</th>
              <th>Date</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            {this.renderEntries()}
          </tbody>
        </table>
      </div>
    );
  }
}

ReactDOM.render(<PodcastView />, document.querySelector('#js-react-feed'));

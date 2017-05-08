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
      duration: 0
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
      this.player.stop();
    }

    this.player = new Howl({
      src: [entry.url],
      html5: true
    });

    this.player.once('load', () => {
      console.log('duration', this.player.duration());
      this.setState({ duration: this.player.duration() });
    });

    this.player.on('play', () => {
      console.log('play');
      this.timer = setInterval(() => { this.setState({ currentTime: this.state.currentTime + 1 }); }, 1000);
    });

    this.player.on('pause', () => {
      console.log('pause');
      window.clearTimeout(this.timer);
    });

    this.player.on('stop', () => {
      console.log('stop');
      this.setState({ currentTime: 0 });
    });

    this.setState({ state: 'playing', currentlyPlaying: this.player.play(), currentEntry: entry });
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
                { this.state.duration > 0 ? <p>{moment.duration(this.state.currentTime, "seconds").format("hh:mm:ss", { trim: false })} - {moment.duration(this.state.duration, "seconds").format("hh:mm:ss", { trim: false })}</p> : null}
                <div className="btn-group">
                  {
                    this.state.state == 'playing' ?
                      <button className="btn btn-primary btn-sm" type="button" onClick={() => { this.pause(); }}>Pause</button>
                      :
                      <button className="btn btn-primary btn-sm" type="button" onClick={() => { this.resume(this.state.currentlyPlaying); }} disabled={this.state.currentlyPlaying == null}>Play</button>
                  }
                  <button className="btn btn-primary btn-sm" type="button" onClick={() => { this.stop(); }} disabled={this.state.currentlyPlaying == null}>Stop</button>
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

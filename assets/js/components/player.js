import React, { Component } from 'react';
import Slider from 'react-rangeslider';
import 'react-rangeslider/lib/index.css';

class Player extends Component {
  constructor(props, context) {
    super(props, context)
    this.state = {
      volume: 50
    }
  }

  handleOnChange = (value) => {
    this.setState({
      volume: value
    })
  }

  render() {
    let { volume } = this.state;
    return (
      <div className="player-wrapper">
        <div className="player">
          <div className="player-info">
            <img src="http://www.tsf.pt/podcast/governosombra.jpg" alt="" className="player-info-image"/>
            <div className="player-info-text">
              <div className="track-title">Especial Dia da Crianca: Olha bola Manel</div>
              <div className="feed-name">As baladas do Dr. Paixão</div>
            </div>
          </div>
          <div className="player-controls">
            <div className="player-controls-buttons">
              <span>Previous</span>
              <span>Back 15</span>
              <span>Play</span>
              <span>Forward 15</span>
              <span>Next</span>
            </div>
            <Slider
              value={volume}
              onChange={this.handleOnChange}
            />
            <span className="player-controls-current-time">00:00</span>
            <span className="player-controls-total-time">99:99</span>
          </div>
          <div className="player-volume">
            <Slider
              value={volume}
              tooltip={false}
              onChange={this.handleOnChange}
            />
          </div>
        </div>
      </div>
    );
  }
}

export default Player;

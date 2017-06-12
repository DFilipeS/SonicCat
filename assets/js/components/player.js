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
              <img src="/images/last.svg" alt=""/>
              <img src="/images/back.svg" alt=""/>
              <img src="/images/play.svg" alt=""/>
              <img src="/images/forward.svg" alt=""/>
              <img src="/images/next.svg" alt=""/>
            </div>
            <Slider
              value={volume}
              onChange={this.handleOnChange}
            />
            <span className="player-controls-current-time">00:00</span>
            <span className="player-controls-total-time">99:99</span>
          </div>
          <div className="player-volume">
            <img src="/images/audio.svg" alt=""/>
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

import React, { Component } from 'react';
import { connect } from 'react-redux';
import moment from 'moment';
import { bindActionCreators } from 'redux';

import * as feedsActions from '../actions/feeds';
import * as playerActions from '../actions/player';

class Feed extends Component {

  componentWillUpdate(nextProps, nextState) {
    const id = this.props.match.params.id;
    const nextPropsId = nextProps.match.params.id;

    if (id !== nextPropsId) {
      this.props.actions.feedsActions.getFeed(nextPropsId);
    }
  }

  componentWillMount() {
    const id = this.props.match.params.id;
    this.props.actions.feedsActions.getFeed(id);
  }

  playEntry = (feed, entry) => {
    this.props.actions.playerActions.playEntry(feed, entry);
  }

  render() {
    if (!this.props.feed) return <div>Loading...</div>;

    const tableBody = this.props.feed.entries.map((entry, index) => {
      let rowClassNames = "";

      if (this.props.currentlyPlaying && this.props.currentlyPlaying.url === entry.url) {
        rowClassNames = "active";
      }

      return (
        <tr className={rowClassNames} key={index}>
          <td>{entry.title}</td>
          <td className="text-nowrap">{moment(entry.date).format('YYYY-MM-DD HH:MM')}</td>
          {
            this.props.currentlyPlaying && this.props.currentlyPlaying.url === entry.url ?
              <td>
                <a href="#" onClick={(e) => { e.preventDefault(); this.playEntry(this.props.feed, entry); }} className="ml-5">
                  <img src="/images/pause.svg" />
                </a>
              </td>
              :
              <td>
                <a href="#" onClick={(e) => { e.preventDefault(); this.playEntry(this.props.feed, entry); }} className="ml-5">
                  <img src="/images/play.svg" />
                </a>
              </td>
          }
        </tr>
      );
    });

    return (
      <div className="feed-detail">
        <div className="feed-header">
          <div className="feed-header-image">
            <img src={this.props.feed.image} alt={this.props.feed.name} />
          </div>
          <div className="feed-header-text">
            <h1>{this.props.feed.name}</h1>
            <h2>{this.props.feed.description}</h2>
            <h3>{this.props.feed.author}</h3>
          </div>
          <div className="feed-header-buttons">
            <button className="btn btn-primary" onClick={() => { this.playEntry(this.props.feed, this.props.feed.entries[0]); }}>Play</button>
          </div>
        </div>
        <table className="table">
          <thead>
            <tr>
              <th>Title</th>
              <th>Date</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            {tableBody}
          </tbody>
        </table>
      </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    feed: state.feeds.feed,
    currentlyPlaying: state.player.playlist ? state.player.playlist[state.player.currentlyPlaying] : null
  };
}

function mapDispatchToProps(dispatch) {
  return {
    actions: {
      feedsActions: bindActionCreators(feedsActions, dispatch),
      playerActions: bindActionCreators(playerActions, dispatch)
    }
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(Feed);

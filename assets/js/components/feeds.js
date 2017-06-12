import React, { Component } from 'react';
import { connect } from 'react-redux';

import * as feedsActions from '../actions/feeds';

class Feeds extends Component {

  componentWillMount() {
    this.props.getFeeds();
  }

  renderFeeds() {
    if (this.props.feeds) {
      return this.props.feeds.map((feed) => {
        return (
          <div className="col-3" key={feed.id}>
            <div className="card feeds-list">
              <img className="card-img-top" src={feed.image} alt="Card image cap" />
              <div className="card-block">
                <h4 className="card-title">{feed.name}</h4>
                <p className="card-text">{feed.author}</p>
              </div>
            </div>
          </div>
        );
      });
    }
  }

  render() {
    return (
      <div>
        <h1 className="mb-4">All</h1>
        <div className="row">
          {this.renderFeeds()}
        </div>
      </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    feeds: state.feeds.feeds
  };
}

export default connect(mapStateToProps, feedsActions)(Feeds);

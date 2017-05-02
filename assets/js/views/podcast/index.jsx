import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import axios from 'axios';

class PodcastView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      feeds: []
    };
  }

  componentWillMount() {
    axios.post('/api/podcast', {url: 'http://feeds.feedburner.com/rc-as-baladas-de-dr-paixao'}).then((data) => {
      console.log('data', data);
      this.setState({
        feeds: data.data.feed
      });
    });
  }

  renderFeeds = () => {
    if (!this.state.feeds) return null;
    return this.state.feeds.map((feed) => {
      return (
        <div>
          <h3>{feed.title}</h3>
          <h4>{feed.author}</h4>
          <small className="text-muted">{feed.description}</small>
        </div>
      );
    });
  }

  render() {
    return (
      <div>
        {this.renderFeeds()}
      </div>
    );
  }
}

ReactDOM.render(<PodcastView />, document.querySelector('#js-react-podcasts'));

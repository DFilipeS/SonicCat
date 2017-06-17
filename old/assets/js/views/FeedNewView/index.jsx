import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import axios from 'axios';
import fetchJsonp from 'fetch-jsonp';
import $ from 'jquery';

class PodcastSearchView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      query: '',
      results: []
    };
  }

  onQueryChange = (e) => {
    const query = e.target.value;
    this.setState({ query });
    if (this.searchDebounce) {
      window.clearTimeout(this.searchDebounce)
    }
    this.searchDebounce = window.setTimeout(() => {
      fetchJsonp(`https://itunes.apple.com/search?media=podcast&term=${encodeURIComponent(query)}`).then((response) => {
        return response.json();
      }).then((data) => {
        console.log(data);
        this.setState({ results: data.results });
      });
    }, 300);
  }

  selectFeed = (feed) => {
    $('#feed_url').val(feed.feedUrl);
  }

  renderResults = () => {
    return this.state.results.map((result, index) => {
      return (
        <a role="button" onClick={() => { this.selectFeed(result); }} key={index}>
          <div className="panel panel-default">
            <div className="panel-body">
              <h4>{result.trackName}</h4>
              <h5>{result.artistName}</h5>
            </div>
          </div>
        </a>
      )
    });
  }

  render() {
    return (
      <div>
        <h1>Search podcasts</h1>
        <input type="text" onChange={this.onQueryChange} value={this.state.query} className="form-control" placeholder="Search podcasts here..." />
        <hr/>
        {this.renderResults()}
      </div>
    );
  }
}

ReactDOM.render(<PodcastSearchView />, document.querySelector('#js-react-search'));

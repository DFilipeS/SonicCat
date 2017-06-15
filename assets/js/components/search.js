import React, { Component } from 'react';
import fetchJsonp from 'fetch-jsonp';
import { withRouter } from 'react-router-dom'

import * as feedActions from '../actions/feeds';

class Search extends Component {
  constructor(props) {
    super(props);
    this.state = {
      query: '',
      results: [],
      status: 'closed'
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
        this.setState({ results: data.results });
      });
    }, 300);
  }

  openSearchBox = () => {
    this.setState({ status: 'open' });
  }

  closeSearchBox = () => {
    this.setState({ status: 'closed' });
  }

  addFeed = (result) => {
    feedActions.addFeed(result.feedUrl).then((response) => {
      this.props.history.push(`/feeds/${response.data.feed.id}`);
      this.closeSearchBox();
    });
  }

  renderResults = () => {
    const results = this.state.results.map((result, index) => {
      return (
        <div className="search-result" key={index} onClick={() => { this.addFeed(result); }}>
          <img src={result.artworkUrl100} alt={result.collectionName}/>
          <div className="search-result-text">
            <h1 className="search-result-title">{result.collectionName}</h1>
            <h2 className="search-result-author">{result.artistName}</h2>
          </div>
        </div>
      );
    });

    return (
      <div className="search-results" tabIndex="0" onBlur={ this.closeSearchBox }>
        <div className="search-results-box">
          {results}
        </div>
      </div>
    );
  }

  render() {
    return (
      <div className="form-inline my-2 ml-4 my-lg-0 mr-auto">
        <input className="form-control mr-sm-2" type="text" placeholder="Search" onChange={this.onQueryChange} onFocus={this.openSearchBox} value={this.state.query} />
        {
          this.state.status === 'open' && this.state.results.length !== 0 ? this.renderResults() : null
        }
      </div>
    );
  }
}

export default withRouter(Search);

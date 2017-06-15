import React, { Component } from 'react';
import { Route, Switch } from 'react-router-dom';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';

import * as actions from '../actions/auth';
import * as feedsActions from '../actions/feeds';
import NavbarComponent from './navbar';
import PlayerComponent from './player';
import FeedsComponent from './feeds';
import FeedComponent from './feed';

class Index extends Component {

  render() {
    return (
      <div>
        <NavbarComponent />
        <div className="wrapper">
          <div className="sidebar">
            <h1>My Podcasts</h1>
            <ul>
              <li className="active"><Link to="/">All</Link></li>
            </ul>
          </div>
          <div className="content">
            <Switch>
              <Route path="/feeds/:id" component={FeedComponent}/>
              <Route path="/" component={FeedsComponent}/>
            </Switch>
            <PlayerComponent />
          </div>
        </div>
      </div>
    );
  }
}

export default Index;

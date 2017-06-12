import React, { Component } from 'react';
import { Route, Switch } from 'react-router-dom';
import { connect } from 'react-redux';

import * as actions from '../actions/auth';
import * as feedsActions from '../actions/feeds';
import NavbarComponent from './navbar';
import PlayerComponent from './player';
import FeedsComponent from './feeds';

class Index extends Component {

  render() {
    return (
      <div>
        <NavbarComponent />
        <div className="wrapper">
          <div className="sidebar">
            <h1>My Podcasts</h1>
            <ul>
              <li className="active"><a href="#">All</a></li>
              <li><a href="#">Comedy</a></li>
              <li><a href="#">Tech</a></li>
              <li><a href="#">Politics</a></li>
              <li><a href="#">Science</a></li>
              <li><a href="#">News</a></li>
            </ul>
          </div>
          <div className="content">
            <Switch>
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

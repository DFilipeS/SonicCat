import React, { Component } from 'react';
import { connect } from 'react-redux';

import * as actions from '../actions/auth';
import NavbarComponent from './navbar';

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
            <h1 className="text-center mb-4">Index component</h1>
            <p>This component is visible only for logged in users.</p>
          </div>
        </div>
      </div>
    );
  }
}

export default connect(null, actions)(Index);

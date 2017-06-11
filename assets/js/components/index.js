import React, { Component } from 'react';
import { connect } from 'react-redux';

import * as actions from '../actions/auth';

class Index extends Component {

  logout() {
    this.props.logoutUser()
  }

  render() {
    return (
      <div className="container">
        <h1 className="text-center mb-4">Index component</h1>
        <p>This component is visible only for logged in users.</p>
        <button onClick={this.logout.bind(this)} className="btn btn-primary btn-block">Logout</button>
      </div>
    );
  }
}

export default connect(null, actions)(Index);

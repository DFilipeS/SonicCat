import React, { Component } from 'react';
import { connect } from 'react-redux';

import * as actions from '../actions/auth';

class Navbar extends Component {

  logout() {
    this.props.logoutUser()
  }

  render() {
    return (
      <nav className="navbar navbar-toggleable-md bg-faded">
        <button className="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span className="navbar-toggler-icon"></span>
        </button>
        <a className="navbar-brand" href="#">Podcasts</a>

        <div className="collapse navbar-collapse" id="navbarSupportedContent">
          <form className="form-inline my-2 ml-4 my-lg-0 mr-auto">
            <input className="form-control mr-sm-2" type="text" placeholder="Search" />
          </form>
          <ul className="navbar-nav">
            <li className="nav-item dropdown">
              <a className="nav-link dropdown-toggle" href="#" data-toggle="dropdown">
                <img src="https://scontent.fopo1-1.fna.fbcdn.net/v/t1.0-9/18198611_10207096415887116_7459282576512381080_n.jpg?oh=fee117b1b57ad4328443c9150c53dce1&oe=59E11882" alt="Daniel Silva"/>
                Daniel Silva
              </a>
              <div className="dropdown-menu dropdown-menu-right">
                <a className="dropdown-item" href="" onClick={this.logout.bind(this)}>Logout</a>
              </div>
            </li>
          </ul>

        </div>
      </nav>
    );
  }
}

export default connect(null, actions)(Navbar);

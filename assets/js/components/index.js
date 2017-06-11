import React, { Component } from 'react';
import { connect } from 'react-redux';

import * as actions from '../actions/auth';
import NavbarComponent from './navbar';
import PlayerComponent from './player';

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
            <h1 className="mb-4">All</h1>
              <div className="row">
                <div className="col-3">
                  <div className="card feeds-list">
                    <img className="card-img-top" src="http://www.tsf.pt/podcast/governosombra.jpg" alt="Card image cap" />
                    <div className="card-block">
                      <h4 className="card-title">Mixórdia de temáticas, Série Gomes</h4>
                      <p className="card-text">Ricardo Araújo Pereira</p>
                    </div>
                  </div>
                </div>
                <div className="col-3">
                  <div className="card feeds-list">
                    <img className="card-img-top" src="http://www.tsf.pt/podcast/governosombra.jpg" alt="Card image cap" />
                    <div className="card-block">
                      <h4 className="card-title">Mixórdia de temáticas, Série Gomes</h4>
                      <p className="card-text">Ricardo Araújo Pereira</p>
                    </div>
                  </div>
                </div>
                <div className="col-3">
                  <div className="card feeds-list">
                    <img className="card-img-top" src="http://www.tsf.pt/podcast/governosombra.jpg" alt="Card image cap" />
                    <div className="card-block">
                      <h4 className="card-title">Mixórdia de temáticas, Série Gomes</h4>
                      <p className="card-text">Ricardo Araújo Pereira</p>
                    </div>
                  </div>
                </div>
                <div className="col-3">
                  <div className="card feeds-list">
                    <img className="card-img-top" src="http://www.tsf.pt/podcast/governosombra.jpg" alt="Card image cap" />
                    <div className="card-block">
                      <h4 className="card-title">Mixórdia de temáticas, Série Gomes</h4>
                      <p className="card-text">Ricardo Araújo Pereira</p>
                    </div>
                  </div>
                </div>
                <div className="col-3">
                  <div className="card feeds-list">
                    <img className="card-img-top" src="http://www.tsf.pt/podcast/governosombra.jpg" alt="Card image cap" />
                    <div className="card-block">
                      <h4 className="card-title">Mixórdia de temáticas, Série Gomes</h4>
                      <p className="card-text">Ricardo Araújo Pereira</p>
                    </div>
                  </div>
                </div>
              </div>
            <PlayerComponent />
          </div>
        </div>
      </div>
    );
  }
}

export default connect(null, actions)(Index);

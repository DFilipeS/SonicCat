import React, { Component } from 'react';
import { Button } from 'reactstrap';
import logo from './images/logo.svg';
import './styles/App.css';

class App extends Component {

  onButtonClick() {
    console.log('Coiso');
  }

  render() {
    return (
      <div className="App">
        <div className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h2>Welcome to React</h2>
        </div>
        <p className="App-intro">
          <Button color="danger" onClick={this.onButtonClick}>This is a button!</Button>
          To get started, edit <code>src/App.js</code> and save to reload.
        </p>
      </div>
    );
  }
}

export default App;

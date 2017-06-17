import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { createStore, applyMiddleware } from 'redux';
import { Router, Route, Switch } from 'react-router-dom';
import { createBrowserHistory } from 'history';
import { createLogger } from 'redux-logger';
import reduxThunk from 'redux-thunk';

import { AUTH_USER } from './actions/types';
import reducers from './reducers'
import RequireAuth from './components/auth/require_auth';
import IndexComponent from './components/index';
import LoginComponent from './components/auth/login';
import 'phoenix_html';

export const history = createBrowserHistory();

const logger = createLogger({
  predicate: (getState, action) => !action.type.startsWith('@@redux-form')
});
const createStoreWithMiddleware = applyMiddleware(reduxThunk, logger)(createStore);
const reduxDevTools = window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__();
const store = createStoreWithMiddleware(reducers, reduxDevTools);
const token = localStorage.getItem('token');
const user = JSON.parse(localStorage.getItem('user'));

if (token && user) {
  store.dispatch({ type: AUTH_USER, payload: { user } })
}


ReactDOM.render(
  <Provider store={store}>
    <Router history={history}>
      <Switch>
        <Route path="/login" component={LoginComponent} />
        <Route path="/" component={RequireAuth(IndexComponent)} />
      </Switch>
    </Router>
  </Provider>,
  document.getElementById('app')
);

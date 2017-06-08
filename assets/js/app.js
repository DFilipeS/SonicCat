import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { createStore, applyMiddleware } from 'redux';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import { createLogger } from 'redux-logger';

import reducers from './reducers'
import IndexComponent from './components/index';
import 'phoenix_html';

const logger = createLogger();
const createStoreWithMiddleware = applyMiddleware(logger)(createStore);
const reduxDevTools = window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__();

ReactDOM.render(
  <Provider store={createStoreWithMiddleware(reducers, reduxDevTools)}>
    <BrowserRouter>
      <Switch>
        <Route path="/" component={IndexComponent} />
      </Switch>
    </BrowserRouter>
  </Provider>,
  document.getElementById('app')
);

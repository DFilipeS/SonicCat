import { combineReducers } from 'redux';
import { reducer as form } from 'redux-form';

import authReducer from './auth_reducer';
import feedsReducer from './feeds_reducer';

const rootReducer = combineReducers({
  form,
  auth: authReducer,
  feeds: feedsReducer
});

export default rootReducer;

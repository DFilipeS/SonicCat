import { combineReducers } from 'redux';
import { reducer as form } from 'redux-form';

import authReducer from './auth_reducer';
import feedsReducer from './feeds_reducer';
import playerReducer from './player_reducer';

const rootReducer = combineReducers({
  form,
  auth: authReducer,
  feeds: feedsReducer,
  player: playerReducer
});

export default rootReducer;

import { GET_FEEDS, GET_FEED } from '../actions/types';

export default function(state = {}, action) {
  switch(action.type) {
    case GET_FEEDS:
      return { ...state, feeds: action.payload.feeds };
    case GET_FEED:
      return { ...state, feed: action.payload.feed };
    default:
      return state;
  }
}

import { GET_FEEDS, GET_FEED, PLAY_ENTRY } from '../actions/types';

export default function(state = {}, action) {
  switch(action.type) {
    case GET_FEEDS:
      return { ...state, feeds: action.payload.feeds };
    case GET_FEED:
      return { ...state, feed: action.payload.feed };
    case PLAY_ENTRY:
      return { ...state, currentlyPlaying: action.payload };
    default:
      return state;
  }
}

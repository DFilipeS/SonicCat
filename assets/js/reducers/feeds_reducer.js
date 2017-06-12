import { GET_FEEDS } from '../actions/types';

export default function(state = {}, action) {
  switch(action.type) {
    case GET_FEEDS:
      return { ...state, feeds: action.payload.feeds };
    default:
      return state;
  }
}

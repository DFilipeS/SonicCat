import { PLAY_ENTRY } from '../actions/types';

export default function(state = {}, action) {
  switch(action.type) {
    case PLAY_ENTRY:
      return { ...state, currentlyPlaying: action.payload.currentlyPlaying, playlist: action.payload.playlist };
    default:
      return state;
  }
}

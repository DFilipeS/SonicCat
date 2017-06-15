import axios from 'axios';
import update from 'immutability-helper';

import { PLAY_ENTRY } from './types';

const ROOT_URL = 'http://localhost:4000/api';

export function playEntry(feed, entry) {
  const newFeed = update(feed, { $unset : ['entries'] });
  const newEntry = update(entry, { $merge: { feed: newFeed } });
  return {
    type: PLAY_ENTRY,
    payload: { currentlyPlaying: 0, playlist: [newEntry] }
  };
}

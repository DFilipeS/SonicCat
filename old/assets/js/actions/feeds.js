import axios from 'axios';

import { GET_FEEDS, GET_FEED, ADD_FEED } from './types';

const ROOT_URL = 'http://localhost:4000/api';

export function getFeeds() {
  return function(dispatch) {
    axios.get(`${ROOT_URL}/feeds`, { headers: { authorization: `User ${localStorage.getItem('token')}` } })
      .then(response => {
        dispatch({ type: GET_FEEDS, payload: response.data });
        // TODO : Redirect user to user dashboard
      })
      .catch(() => {
        // TODO : Handle error
      });
  };
}

export function getFeed(id) {
  return function(dispatch) {
    axios.get(`${ROOT_URL}/feeds/${id}`, { headers: { authorization: `User ${localStorage.getItem('token')}` } })
      .then(response => {
        dispatch({ type: GET_FEED, payload: response.data });
      })
      .catch(() => {
        // TODO : Handle error
      });
  };
}

export function addFeed(url) {
  return axios.post(`${ROOT_URL}/feeds`, { url }, { headers: { authorization: `User ${localStorage.getItem('token')}` } });
}

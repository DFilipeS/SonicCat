import axios from 'axios';
import { history } from '../app';

import { AUTH_USER, UNAUTH_USER, AUTH_ERROR } from './types';

const ROOT_URL = 'http://localhost:4000/api';

export function loginUser({ email, password }) {
  return function(dispatch) {
    axios.post(`${ROOT_URL}/login`, { email, password })
      .then(response => {
        dispatch({ type: AUTH_USER, payload: response.data });
        localStorage.setItem('token', response.data.token);
        localStorage.setItem('user', JSON.stringify(response.data.user));
        // TODO : Redirect user to user dashboard
        history.push('/');
      })
      .catch(() => {
        dispatch(authError('Bad Login Info'));
      });
  };
}

export function logoutUser() {
  localStorage.removeItem('token');

  return { type: UNAUTH_USER };
}

export function authError(error) {
  // Redirect to login page.
  history.push('/login');

  return {
    type: AUTH_ERROR,
    payload: error
  };
}

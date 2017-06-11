import React, { Component } from 'react';
import { Field, reduxForm } from 'redux-form';
import { connect } from 'react-redux';

import * as actions from '../../actions/auth';

class Login extends Component {

  renderField(field) {
    const { meta: { touched, error } } = field;
    const className = `form-group ${touched && error ? 'has-danger' : ''}`;

    return (
      <fieldset className={className}>
        <label>{field.label}</label>
        <input type={field.type} className="form-control" {...field.input} />
        {touched ? <small className="text-help text-muted">{error}</small> : ''}
      </fieldset>
    );
  }

  handleFormSubmit({ email, password }) {
    this.props.loginUser({ email, password });
  }

  renderAlert() {
    if (this.props.errorMessage) {
      return (
        <div className="alert alert-danger">
          <strong>Oops!</strong> {this.props.errorMessage}
        </div>
      );
    }
  }

  render() {
    const { handleSubmit } = this.props;

    return (
      <div className="container">
        <h1 className="text-center">Login</h1>
        <form onSubmit={handleSubmit(this.handleFormSubmit.bind(this))}>
          <Field name="email" label="Email" type="email" component={this.renderField} />
          <Field name="password" label="Password" type="password" component={this.renderField} />
          {this.renderAlert()}
          <button action="submit" className="btn btn-primary">Sign in</button>
        </form>
      </div>
    );
  }
}

function validate(values) {
  const errors = {};

  if (!values.email) {
    errors.email = "Enter an email."
  }

  if (!values.password) {
    errors.password = "Enter a password."
  }

  return errors;
}

function mapStateToProps(state) {
  return { errorMessage: state.auth.error };
}

export default reduxForm({
  form: 'login',
  validate
})(connect(mapStateToProps, actions)(Login));

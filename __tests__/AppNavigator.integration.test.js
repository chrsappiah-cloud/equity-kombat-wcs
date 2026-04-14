import React from 'react';
import { render } from '@testing-library/react-native';
import AppNavigator from '../AppNavigator';

jest.mock('../hooks/useUser', () => () => ({ role: 'user' }));

test('redirects non-admin to Home', () => {
  const { getByText } = render(<AppNavigator />);
  expect(getByText('Home')).toBeTruthy();
});

jest.mock('../hooks/useUser', () => () => ({ role: 'admin' }));

test('shows admin dashboard for admin', () => {
  const { getByText } = render(<AppNavigator />);
  expect(getByText('Admin Dashboard')).toBeTruthy();
});
// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.
import { render } from '@testing-library/react-native';
import App from '../App';

jest.mock('../utils/user', () => ({
  getUser: jest.fn(() => Promise.resolve({ role: null })),
}));

test('throws error if user role missing', async () => {
  await expect(() => render(<App />)).toThrow('User role missing');
});
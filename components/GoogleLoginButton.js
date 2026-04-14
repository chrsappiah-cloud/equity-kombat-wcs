import React from 'react';
import { Button, ActivityIndicator } from 'react-native';
import { useAuth } from '../contexts/AuthContext';

const GoogleLoginButton = () => {
  const { signInWithGoogle, loading } = useAuth();

  const handlePress = async () => {
    try {
      await signInWithGoogle();
    } catch (e) {
      // Optionally handle error
    }
  };

  if (loading) return <ActivityIndicator />;

  return <Button title="Sign in with Google" onPress={handlePress} />;
};

export default GoogleLoginButton;

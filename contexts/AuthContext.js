// firestore.custom.rules

rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Allow read access to all documents for anyone
    match /{document=**} {
      allow read: if true;
    }

    // Allow write access only to authenticated users on their own documents
    match /users/{userId} {
      allow read: if true;
      allow write: if request.auth != null && request.auth.uid == userId;
    }

    // Example: Allow authenticated users to write to a "posts" collection
    match /posts/{postId} {
      allow read: if true;
      allow write: if request.auth != null;
    }

    // Add more custom rules for other collections as needed
  }
}import React, { createContext, useContext, useState, useEffect } from 'react';
import { sessionStorage } from 'react-native-web-storage';
import auth from '@react-native-firebase/auth';
import { GoogleSignin } from '@react-native-google-signin/google-signin';

const AuthContext = createContext();

const SESSION_KEY = 'authUser';
const SESSION_EXPIRY_KEY = 'authUserExpiry';
const SESSION_DURATION = 60 * 60 * 1000; // 1 hour

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const checkSession = async () => {
      const storedUser = await sessionStorage.getItem(SESSION_KEY);
      const expiry = await sessionStorage.getItem(SESSION_EXPIRY_KEY);
      if (storedUser && expiry && Date.now() < parseInt(expiry, 10)) {
        setUser(JSON.parse(storedUser));
      } else {
        setUser(null);
        await sessionStorage.removeItem(SESSION_KEY);
        await sessionStorage.removeItem(SESSION_EXPIRY_KEY);
      }
      setLoading(false);
    };
    checkSession();
  }, []);

  const signInWithGoogle = async () => {
    try {
      await GoogleSignin.hasPlayServices();
      const { idToken } = await GoogleSignin.signIn();
      const googleCredential = auth.GoogleAuthProvider.credential(idToken);
      const userCredential = await auth().signInWithCredential(googleCredential);
      setUser(userCredential.user);
      await sessionStorage.setItem(SESSION_KEY, JSON.stringify(userCredential.user));
      await sessionStorage.setItem(SESSION_EXPIRY_KEY, (Date.now() + SESSION_DURATION).toString());
    } catch (error) {
      console.error('Google Sign-In error:', error);
      throw error;
    }
  };

  const signOut = async () => {
    await auth().signOut();
    await GoogleSignin.signOut();
    setUser(null);
    await sessionStorage.removeItem(SESSION_KEY);
    await sessionStorage.removeItem(SESSION_EXPIRY_KEY);
  };

  return (
    <AuthContext.Provider value={{ user, loading, signInWithGoogle, signOut }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => useContext(AuthContext);

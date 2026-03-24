/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import { NewAppScreen } from '@react-native/new-app-screen';
import { StatusBar, StyleSheet, useColorScheme, View, Text } from 'react-native';
import {
  SafeAreaProvider,
  useSafeAreaInsets,
} from 'react-native-safe-area-context';
import { AuthProvider, useAuth } from './contexts/AuthContext';
import GoogleLoginButton from './components/GoogleLoginButton';


function App() {
  const isDarkMode = useColorScheme() === 'dark';
  return (
    <AuthProvider>
      <SafeAreaProvider>
        <StatusBar barStyle={isDarkMode ? 'light-content' : 'dark-content'} />
        <AppContent />
      </SafeAreaProvider>
    </AuthProvider>
  );
}


function AppContent() {
  const safeAreaInsets = useSafeAreaInsets();
  const { user, signOut } = useAuth();

  return (
    <View style={styles.container}>
      {user ? (
        <>
          <Text>Welcome, {user.displayName || user.email}</Text>
          <Text onPress={signOut} style={{ color: 'blue', marginTop: 16 }}>Sign Out</Text>
        </>
      ) : (
        <GoogleLoginButton />
      )}
      {/* Optionally render your main app content here if authenticated */}
      {/* <NewAppScreen templateFileName="App.tsx" safeAreaInsets={safeAreaInsets} /> */}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});

export default App;

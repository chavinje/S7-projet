import { BrowserRouter, Navigate, Route, Routes } from 'react-router-dom';
import Navbar from './components/Navbar/Navbar.tsx';
import EspacePerso from './views/EspacePerso/EspacePerso.tsx';
import ProtectedRoute from './user/ProtectedRoute.tsx';
import Login from './views/Login/Login.tsx';
import Register from './views/Register/Register.tsx';
import Profile from './views/Profile/Profile.tsx';
import Contact from './components/Contact/Contact.tsx';
import { Toaster } from 'react-hot-toast';
import NotFound from './views/NotFound/NotFound.tsx';
import PropertiesListing from './views/PropertiesListing/PropertiesListing.tsx';

const App = () => {
  return (
    <BrowserRouter>
      <Navbar />
      <div className="content">
        <Routes>
          <Route path="/" element={<Navigate to="/properties" />} />
          <Route path="/login" element={<Login />} />
          <Route path="/register" element={<Register />} />
          <Route path="/contact" element={<Contact />} />
          <Route path="/properties" element={<PropertiesListing />} />

          <Route element={<ProtectedRoute />}>
            <Route path="/profile" element={<Profile />} />
            <Route path="/my-account" element={<EspacePerso />} />
          </Route>

          <Route path="*" element={<Navigate to={'/404'} />} />
          <Route path="/404" element={<NotFound />} />
        </Routes>
        <Toaster />
      </div>
    </BrowserRouter>
  );
};

export default App;

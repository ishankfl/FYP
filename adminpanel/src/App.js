import logo from './logo.svg';
import './App.css';
import Login from './Components/UserAuth/Login';
import DashBoard from './Components/Dashboard/Dashboard'
import ServiceProvider from './Components/ProviderDetails/ProviderDetails'
import Layout from './Components/Layout/Layout';
import BookDetail from './Components/Book/Book';
import UserDetails from './Components/User/User';
import Annoucement from './Components/Annoucement/Annoncemnet';
import Services from './Components/Services/Services';
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';

function App() {
  const win = window.sessionStorage;
  const isLoggedIn = win.getItem('token');

  console.log("Is logged in as ")
  console.log(isLoggedIn)

  return (
    <BrowserRouter>
    
      {/* Display layout only if user is logged in */}
        <Layout>
          <Routes>
          <Route path="/" element={isLoggedIn?<DashBoard />:<Login/>} />

              <Route path="/admin" element={isLoggedIn?<DashBoard />:<Login/>} />
              <Route path="/admin/provider-verification" element={isLoggedIn?<ServiceProvider />:<Login/>} />
              <Route path="/admin/users" element={isLoggedIn?<UserDetails />:<Login/>} />
              <Route path="/admin/bookings" element={isLoggedIn?<BookDetail />:<Login/>} />
              <Route path="/admin/announcement" element={isLoggedIn?<Annoucement />:<Login/>} />
              <Route path="/admin/services" element={isLoggedIn?<Services />:<Login/>} />
              <Route path="/login" element={isLoggedIn?<Login />:<Login/>} />
d          </Routes>
        </Layout>
      
    </BrowserRouter>
  );
}

export default App;
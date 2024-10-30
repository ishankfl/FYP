// Sidebar.js
import React from 'react';
import { Link } from 'react-router-dom';

// import './Sidebar.scss';
import Topbar from '../Sidebar/TopBar';
import './Layout.scss';
import Sidebar from '../Sidebar/Sidebar';

const Layout
      = ({ children }) => {
            return (

                  <div className='layout' >
                        <Topbar />
                        <Sidebar />
                        <div className='main-content'>

                              {children}
                        </div>
                  </div>


            );
      };

export default Layout;

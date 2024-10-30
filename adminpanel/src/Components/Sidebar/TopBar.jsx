// Topbar.js
import React from 'react';
import { CgProfile } from "react-icons/cg";

import './Sidebar.scss';
const Topbar = () => {
      return (
            <div>
                  <div className='top-bar'> 
                  
                        <div className='profile-name'>
                              <CgProfile /><p> Admin</p>
                        </div>
                  </div>


            </div >

      );
};

export default Topbar;

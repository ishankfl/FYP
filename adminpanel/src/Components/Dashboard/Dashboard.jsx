// DashboardLayout.js
import React from 'react';
import Sidebar from '../Sidebar/Sidebar';

const DashboardLayout = ({ children }) => {
      return (
            <div className="dashboard-layout">
                  {/* <Sidebar /> */}
                  <div className="content">
                        {children}
                  </div>
            </div>
      );
};

export default DashboardLayout;

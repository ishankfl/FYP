// Sidebar.js
import React from 'react';
import { Link } from 'react-router-dom';
import { FaUsers } from "react-icons/fa";
import { GrServices } from "react-icons/gr";
import { MdVerifiedUser } from "react-icons/md";
import { TbBrandBooking } from "react-icons/tb";
import { CiLogout } from "react-icons/ci";
import { GrAnnounce } from "react-icons/gr";


import './Sidebar.scss';

const Sidebar = () => {
      return (
            <div>
                  <div className="sidebar-container">
                        <div className="sidebar">
                              <div className="sidebar-header">
                                    Admin Dashboard
                              </div>
                              <ul className="sidebar-menu">
                                    <li><FaUsers />
                                          <Link to="/admin/users">Manage Users</Link>
                                    </li>
                                    <li>
                                          <GrServices />
                                          <Link to="/admin/services">Manage Services</Link>
                                    </li>
                                    <li>
                                          <MdVerifiedUser />
                                          <Link to="/admin/provider-verification">Verify Providers</Link>
                                    </li>
                                    <li>
                                          <TbBrandBooking />
                                          <Link to="/admin/bookings">View Bookings</Link>
                                    </li>
                                    <li>
                                          <GrAnnounce />

                                          <Link to="/admin/announcement">Make Announcement</Link>
                                    </li>

                              </ul>

                              <ul className="sidebar-second-menu">
                                    <li>
                                          <CiLogout />
                                          <Link to="/admin/users">Logout</Link>
                                    </li>


                              </ul>
                        </div>
                  </div>
            </div>

      );
};

export default Sidebar;

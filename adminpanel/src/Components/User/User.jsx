import React, { useState, useEffect } from 'react';
import Sidebar from '../Sidebar/Sidebar';
import Axios from 'axios';
import ip from '../ip/ip';
import css from '../ProviderDetails/ProviderDetails.scss';
import Loading from '../Loading/Loading';
import Topbar from '../Sidebar/TopBar';
import './User.scss';

const swal = require('sweetalert2');
const UserDetails = () => {
      const [data, setVerifiedProviders] = useState([]);
      const [notVerifiedProviders, setNotVerifiedProviders] = useState([]);
      const [selectedTab, setSelectedTab] = useState('verified'); // State to track selected tab
      // const [data, setData] = useState([]);
      const [loading, setLoading] = useState(false);
      const [selectedCertificate, setSelectedCertificate] = useState(null); // State to track the selected certificate
      const [verificationStatus, setVerificationStatus] = useState({}); // State to track verification status
      const win = window.sessionStorage;
      useEffect(() => {
            fetchProviders();
      }, []);

      const fetchProviders = async () => {
            setLoading(true);
            try {
                  const response = await Axios.get(`${ip()}/account/api/fetchuser`, {
                        headers: {
                              Authorization: `Bearer ${win.getItem('token')}`
                        }
                  });
                  if (response.status === 200) {
                        // const { verified, notVerified } = response.data;

                        setVerifiedProviders(response.data);
                  }
            } catch (error) {
                  console.log("Error:", error);
            } finally {
                  setLoading(false);
            }
      };
      // ction to handle click on certificate image and display it in a popup
      const handleCertificateClick = (certificateUrl) => {
            setSelectedCertificate(certificateUrl);
      };

      // Function to close the popup



      const [toggleState, setToggleState] = useState({});
      // Function to handle toggling of buttons
      const handleToggle = (id) => {
            console.log(id,);
            changeVerificationStatus(id);

            setToggleState(prevState => ({
                  ...prevState,
                  [id]: !prevState[id] // Toggle the state
            }));
      };
      console.log(data);
      // Function to handle click on certificate image and display it in a popup
      const closePopup = () => {
            setSelectedCertificate(null);
      };


      // Function to change verification status
      const changeVerificationStatus = async (providerId) => {
            try {
                  await Axios.post(`${ip()}/account/api/verifyprovider/`, { id: providerId }, {
                        headers: {
                              Authorization: `Bearer ${win.getItem('token')}`
                        }
                  });
                  fetchProviders(); // Fetch updated provider data after status change
                  swal.fire({
                        title: "Successfully verified provider",
                        icon: "success",
                        toast: true,
                        timer: 6000,
                        position: 'top-right',
                        timerProgressBar: true,
                        showConfirmButton: false,
                  });
            } catch (error) {
                  console.log("Error:", error);
            }
      };

      return (
            <div className='user-details'>

                  {loading ? (
                        <div><Loading /></div>
                  ) : (
                        <div className='detail-view'>

                              <div className="provider-list">
                                    <table>
                                          <thead>
                                                <tr>
                                                      <th>Full Name</th>
                                                      <th>Email</th>
                                                      <th>City</th>
                                                      <th>Profile Picture</th>
                                                      <th>Verification St atus</th>
                                                      <th>User Type</th>
                                                </tr>
                                          </thead>
                                          <tbody>
                                                {
                                                      data.map(user => (
                                                            <tr key={user.id}>
                                                                  <td>{user.full_name}</td>
                                                                  <td>{user.email}</td>
                                                                  <td>{user.city}</td>

                                                                  <td>
                                                                        <img className="user-profile-img" src={`${ip()}${user.profile}`} alt={user.profile} onClick={() => handleCertificateClick(`${ip()}${user.profile}`)} />
                                                                  </td>

                                                                  <td>{user.phonenumber}</td>
                                                                  <td>{user.user_type}</td>


                                                            </tr>
                                                      )
                                                      )}

                                          </tbody>
                                    </table>
                              </div>
                              {/* Modal for displaying the certificate image */}
                              {selectedCertificate && (
                                    <div className="modal" onClick={closePopup}>
                                          <div className="modal-content">
                                                <span className="close" onClick={closePopup}>&times;</span>
                                                <img src={selectedCertificate} alt="Certificate" />
                                          </div>
                                    </div>
                              )}
                        </div>

                  )}
            </div>
      );
};

export default UserDetails;

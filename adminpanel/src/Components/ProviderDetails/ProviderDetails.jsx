import React, { useState, useEffect } from 'react';
import Sidebar from '../Sidebar/Sidebar';
import Axios from 'axios';
import ip from '../ip/ip';
import css from '../ProviderDetails/ProviderDetails.scss';
import Loading from '../Loading/Loading';
import Topbar from '../Sidebar/TopBar';
const swal = require('sweetalert2');

const ServiceProviders = () => {
      // win.getItem('token');
      const [verifiedProviders, setVerifiedProviders] = useState([]);
      const [notVerifiedProviders, setNotVerifiedProviders] = useState([]);
      const [selectedTab, setSelectedTab] = useState('verified'); // State to track selected tab
      const [data, setData] = useState([]);
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
                  const response = await Axios.get(`${ip()}/services/api/providers/`, {
                        headers: {
                              Authorization: `Bearer ${win.getItem('token')}`
                        }
                  });
                  if (response.status === 200) {
                        // const { verified, notVerified } = response.data;
                        var data = (response.data);
                        var verified = []
                        var notverified = []
                        data.forEach(element => {
                              console.log(element.verification_status)
                              if (element.verification_status == true) {
                                    verified.push(element)
                                    console.log("dsfsfs")
                              }
                              else {
                                    notverified.push(element)
                              }

                        });
                        setVerifiedProviders(verified);
                        setNotVerifiedProviders(notverified);
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
            <div className='provider-details'>

                  {loading ? (
                        <div><Loading /></div>
                  ) : (
                        <div className='detail-view'>
                              <div className="tab-bar">
                                    <button className={selectedTab === 'verified' ? 'active' : ''} onClick={() => setSelectedTab('verified')}>Verified Providers</button>
                                    <button className={selectedTab === 'notVerified' ? 'active' : ''} onClick={() => setSelectedTab('notVerified')}>Not Verified Providers</button>
                              </div>
                              <div className="provider-list">
                                    <table>
                                          <thead>
                                                <tr>
                                                      <th>Full Name</th>
                                                      <th>Email</th>
                                                      <th>City</th>
                                                      <th>Profile Picture</th>
                                                      <th>Verification Status</th>
                                                      <th>Certificate</th>
                                                </tr>
                                          </thead>
                                          <tbody>
                                                {selectedTab === 'verified' && (
                                                      verifiedProviders.map(provider => (
                                                            <tr key={provider.id}>
                                                                  <td>{provider.user.full_name}</td>
                                                                  <td>{provider.user.email}</td>
                                                                  <td>{provider.user.city}</td>
                                                                  <td>
                                                                        <img className="profile-img" src={`${ip()}${provider.user.profile}`} alt={provider.user.profile} onClick={() => handleCertificateClick(`${ip()}${provider.user.profile}`)} />
                                                                  </td>
                                                                  <td>
                                                                        <label className="toggle-switch">
                                                                              <input
                                                                                    type="checkbox"
                                                                                    checked={verificationStatus}
                                                                                    onChange={() => handleToggle(provider.id)}
                                                                              />
                                                                              <span className="slider"></span>
                                                                        </label>
                                                                  </td>
                                                                  <td>
                                                                        <img className="certificate-img" src={`${ip()}${provider.certificate}`} alt={provider.certificate} onClick={() => handleCertificateClick(`${ip()}${provider.certificate}`)} />
                                                                  </td>
                                                            </tr>
                                                      ))
                                                )}
                                                {selectedTab === 'notVerified' && (
                                                      notVerifiedProviders.map(provider => (
                                                            <tr key={provider.id}>
                                                                  <td>{provider.user.full_name}</td>
                                                                  <td>{provider.user.email}</td>
                                                                  <td>{provider.user.city}</td>
                                                                  <td>
                                                                        <img className="profile-img" src={`${ip()}${provider.user.profile}`} alt={provider.user.profile} onClick={() => handleCertificateClick(`${ip()}${provider.user.profile}`)} />
                                                                  </td>
                                                                  <td>
                                                                        <label className="toggle-switch">
                                                                              <input
                                                                                    type="checkbox"
                                                                                    checked={false}
                                                                                    onChange={() => handleToggle(provider.id)}
                                                                              />
                                                                              <span className="slider"></span>
                                                                        </label>
                                                                  </td>
                                                                  <td>
                                                                        <img className="certificate-img" src={`${ip()}${provider.certificate}`} alt={provider.certificate} onClick={() => handleCertificateClick(`${ip()}${provider.certificate}`)} />
                                                                  </td>
                                                            </tr>
                                                      ))
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

export default ServiceProviders;

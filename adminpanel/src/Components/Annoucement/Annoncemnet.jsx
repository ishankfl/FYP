import React, { useState, useEffect } from 'react';
import Sidebar from '../Sidebar/Sidebar';
import Axios from 'axios';
import ip from '../ip/ip';
import css from '../ProviderDetails/ProviderDetails.scss';
import Loading from '../Loading/Loading';
import Topbar from '../Sidebar/TopBar';
import './Annoucemnet.scss';

const swal = require('sweetalert2');
const Annoucement = () => {
      const [data, setVerifiedProviders] = useState([]);
      // const [data, setData] = useState([]);
      const [loading, setLoading] = useState(false);
      const [title, setTitle] = useState('');
      const [description, setDescription] = useState('');
      const [selectedCertificate, setSelectedCertificate] = useState(null); // State to track the selected certificate

      const win = window.sessionStorage;


      const handleSubmit = async () => {
            console.log("Update page")
            setLoading(true);
            try {
                  const response = await Axios.post(`${ip()}/notify/api/make-announcement/`, {
                        title: title,
                        description: description
                  }, {
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
                  await Axios.post(`${ip()}/notify/api/make-announcement/`, { id: providerId }, {
                        headers: {
                              Authorization: `Bearer ${win.getItem('token')}`
                        }
                  });
                  // fetchProviders(); // Fetch updated provider data after status change
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
            <div className='annoucement-form'>


                  <div className='detail-view'>

                        <form onSubmit={handleSubmit}>
                              <div>
                                    <label>Enter a Ttile</label>
                                    <br />
                                    <input type="text" name='title' onChange={e => setTitle(e.target.value)} />
                              </div>
                              <div>
                                    <label>Enter a Description</label>
                                    <textarea type="text" name='description' onChange={e => setDescription(e.target.value)} />
                              </div>
                              <button type='button' onClick={handleSubmit}>Submit</button>
                        </form>


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


            </div>
      );
};

export default Annoucement;

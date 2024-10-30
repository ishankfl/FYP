import React, { useState, useEffect } from 'react';
import Axios from 'axios';
import ip from '../ip/ip';
import Loading from '../Loading/Loading';
import EditServiceForm from './ServiveEditFrom';
import AddServiceForm from './AddServiceForm';
const Services = () => {
      const win = window.sessionStorage;
      win.getItem('token');
      const [data, setData] = useState([]);
      const [loading, setLoading] = useState(false);
      const [selectedImage, setSelectedImage] = useState(null);
      const [editService, setEditService] = useState(null);
      const [addService, setAddService] = useState(null);

      const [showEditForm, setShowEditForm] = useState(false);
      const [showAddForm, setShowAddForm] = useState(false);


      useEffect(() => {
            fetchProviders();
      }, []);

      const fetchProviders = async () => {
            setLoading(true);
            try {
                  const response = await Axios.get(`${ip()}/services/api/services/`, {
                        headers: {
                              Authorization: `Bearer ${win.getItem('token')}`
                        }
                  });
                  if (response.status === 200) {
                        setData(response.data);
                  }
            } catch (error) {
                  console.log("Error:", error);
            } finally {
                  setLoading(false);
            }
      };

      const handleCertificateClick = (certificateUrl) => {
            setSelectedImage(certificateUrl);
      };

      const closePopup = () => {
            setSelectedImage(null);
      };

      const handleEdit = (service) => {
            setEditService(service);
            setShowEditForm(true);
      };

      const handleCancelEdit = () => {
            setEditService(null);
            setShowEditForm(false);
      };

      const handleAddForm = (service) => {
            // setShowAddForm(service);
            setShowAddForm(true);
      };

      const handleUpdate = async (id, serviceName, selectedImage) => {
            try {
                  const formData = new FormData();
                  formData.append('id', id);
                  formData.append('service_name', serviceName);
                  formData.append('image', selectedImage);

                  await Axios.put(`${ip()}/services/api/services/`, formData, {
                        headers: {
                              'Content-Type': 'multipart/form-data',
                              Authorization: `Bearer ${win.getItem('token')}`
                        }
                  });

                  console.log("Service updated successfully");
                  fetchProviders();
                  setEditService(null);
                  setShowEditForm(false);
            } catch (error) {
                  console.log("Error:", error);
            }
      };

      const handleDelete = async (id) => {
            console.log(win.getItem('token'))
            try {
                  console.log(id)


                  await Axios.delete(`${ip()}/services/api/services/?id=${id}`, {
                        body: {
                              id: id
                        },
                        headers: {
                              'Content-Type': 'multipart/form-data',
                              Authorization: `Bearer ${win.getItem('token')}`
                        }
                  });

                  console.log("Service updated successfully");
                  fetchProviders();
            } catch (error) {
                  console.log("Error:", error);
            }
      };

      return (
            <div className='service-details'>

                  {loading ? (
                        <div><Loading /></div>
                  ) : (

                        <div className='detail-view'>
                              <button onClick={() => handleAddForm()}>Add New Service</button>


                              <div className="service-list">

                                    <table>
                                          <thead>
                                                <tr>
                                                      <th>Service Id</th>
                                                      <th>Service Name</th>
                                                      <th>Image</th>
                                                      <th>Action</th>
                                                </tr>
                                          </thead>
                                          <tbody>
                                                {data.map(service => (
                                                      <tr key={service.id}>
                                                            <td>{service.id}</td>
                                                            <td>{service.service_name}</td>
                                                            <td>
                                                                  <img className="certificate-img" src={`${ip()}${service.image}`} alt={service.certificate} height={`30px`} onClick={() => handleCertificateClick(`${ip()}${service.image}`)} />
                                                            </td>
                                                            <td className='edit-update-btn'>
                                                                  <button onClick={() => handleEdit(service)}>Edit</button>
                                                                  <button onClick={() => handleDelete(service.id)}>Delete</button>
                                                            </td>
                                                      </tr>
                                                ))}
                                          </tbody>
                                    </table>
                              </div>
                              {showEditForm && editService && (
                                    <EditServiceForm
                                          service={editService}
                                          onImageSelect={selectedImage}
                                          onSubmit={handleUpdate}
                                          onCancel={handleCancelEdit}
                                    />
                              )}
                              {
                                    showAddForm && addService && (
                                          <AddServiceForm />
                                    )
                              }
                              {selectedImage && (
                                    <div className="modal" onClick={closePopup}>
                                          <div className="modal-content">
                                                <span className="close" onClick={closePopup}>&times;</span>
                                                <img src={selectedImage} alt="Certificate" />
                                          </div>
                                    </div>
                              )}
                        </div>
                  )}
            </div>
      );
};

export default Services;

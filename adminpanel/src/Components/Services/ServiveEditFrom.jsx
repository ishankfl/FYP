import React, { useState } from 'react';

const EditServiceForm = ({ service, onSubmit, onCancel,onImageSelect }) => {
      const [serviceName, setServiceName] = useState(service.service_name);
      // const [image, setImage] = useState(service.service_name);
      const [image, setImage] = useState(null);
      const [previewImage, setPreviewImage] = useState(null);

      const handleServiceNameChange = (e) => {
            setServiceName(e.target.value);

      };

      const handleImageChange = (e) => {
            const selectedImage = e.target.files[0];
            setImage(selectedImage);
            setPreviewImage(URL.createObjectURL(selectedImage)); // Set preview image URL
      };

      const handleSubmit = (e) => {
            e.preventDefault();
            onSubmit(service.id, serviceName, image);
      };

      return (
            <div className="modal">
                  <div className="modal-content">
                        <span className="close" onClick={onCancel}>&times;</span>
                        <h2>Edit Service</h2>
                        <form onSubmit={handleSubmit}>
                              <label>
                                    Service Name:
                                    <input type="text" value={serviceName} onChange={handleServiceNameChange} />
                              </label>
                              <br />
                              <br />
                              <label>
                                    {previewImage && <img src={previewImage} alt="Preview" style={{ maxWidth: '100%', maxHeight: '200px' }} />}
                                    <br /><br />
                                    Image:
                                    <br />
                                    <input type="file" accept="image/*" onChange={handleImageChange} />
                              </label>

                              <br />
                              <br />
                              <div className='edit-update-btn     ' >
                                    <button type="submit">Update</button>
                                    <button type="button" onClick={onCancel}>Cancel</button>

                              </div>
                        </form>
                  </div>
            </div>
      );
};


export default EditServiceForm;
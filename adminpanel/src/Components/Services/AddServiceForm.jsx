
import React, { useState } from 'react';

const AddServiceForm = ({ onSubmit, onCancel }) => {
      const [serviceName, setServiceName] = useState('');
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
            onSubmit(serviceName, image);
      };

      return (
            <div className="modal">
                  <div className="modal-content">
                        <span className="close" onClick={onCancel}>&times;</span>
                        <h2>Add Service</h2>
                        <form onSubmit={handleSubmit}>
                              <label>
                                    Service Name:
                                    <input type="text" value={serviceName} onChange={handleServiceNameChange} />
                              </label>
                              <label>
                                    Image:
                                    <input type="file" accept="image/*" onChange={handleImageChange} />
                              </label>
                              {previewImage && <img src={previewImage} alt="Preview" style={{ maxWidth: '100%', maxHeight: '200px' }} />}
                              <button type="submit">Add</button>
                              <button type="button" onClick={onCancel}>Cancel</button>
                        </form>
                  </div>
            </div>
      );
};

export default AddServiceForm
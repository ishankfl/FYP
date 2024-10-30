import React, { useState, useEffect } from 'react';
import Axios from 'axios';
import ip from '../ip/ip';
import Loading from '../Loading/Loading';
import '../ProviderDetails/ProviderDetails.scss'; // Import your stylesheet
import '../Book/Book.scss'; //
const BookDetail = () => {
      const win = window.sessionStorage;

      const [pendingBooking, setPendingBooking] = useState([]);
      const [confirmedBooking, setConfirmedBooking] = useState([]);
      const [completedBooking, setCompletedBooking] = useState([]);
      const [loading, setLoading] = useState(false);
      const [selectedTab, setSelectedTab] = useState('pending'); // Default to pending

      useEffect(() => {
            fetchBookings();
      }, []);

      const fetchBookings = async () => {
            setLoading(true);
            try {
                  const response = await Axios.get(`${ip()}/booking/api/booking-fetch/`, {
                        headers: {
                              Authorization: `Bearer ${win.getItem('token')}`
                        }
                  });
                  if (response.status === 200) {
                        var data = response.data;

                        var pending = [];
                        var completed = [];
                        var confirmed = [];

                        data.forEach(element => {
                              console.log(element.status);
                              if (element.status === 'confirmed') {
                                    confirmed.push(element);
                                    console.log("dsfsfs");
                              } else if (element.status === 'pending') {
                                    pending.push(element);
                              } else if (element.status === 'completed') {
                                    completed.push(element);
                              }
                        });
                        // Update state variables with filtered bookings
                        setPendingBooking(pending);
                        setConfirmedBooking(confirmed);
                        setCompletedBooking(completed);
                  }
            } catch (error) {
                  console.log("Error:", error);
            } finally {
                  setLoading(false);
            }
      };

      return (
            <div className=''>
                  <br /><br /><br /><br /><br />
                  {loading ? (
                        <div><Loading /></div>
                  ) : (
                        <div className="tab-bar">
                              <button className={selectedTab === 'pending' ? 'active' : ''} onClick={() => setSelectedTab('pending')}>Pending</button>
                              <button className={selectedTab === 'confirmed' ? 'active' : ''} onClick={() => setSelectedTab('confirmed')}>Confirmed</button>
                              <button className={selectedTab === 'completed' ? 'active' : ''} onClick={() => setSelectedTab('completed')}>Completed</button>
                        </div>
                  )}
                  <table>
                        <thead>
                              <tr>
                                    <th>ID</th>
                                    <th>Status</th>
                                    <th>Booking Start</th>
                                    <th>Booking End</th>
                                    <th>Customer</th>
                                    <th>Provider</th>
                                    <th>Service</th>

                                    <th>Expected Hour</th>
                              </tr>
                        </thead>
                        <tbody>
                              {selectedTab === 'pending' && pendingBooking.map(booking => (
                                    <tr key={booking.id}>
                                          <td>{booking.id}</td>
                                          <td>{booking.status}</td>
                                          <td>{new Date(booking.booking_start_date_time).toLocaleString()}</td>
                                          <td>{new Date(booking.booking_end_date_time).toLocaleString()}</td>
                                          <td>{booking.by.user.full_name}</td>
                                          <td>{booking.to.user.full_name}</td>
                                          <td>{booking.service.service_name}</td>
                                          <td>{booking.expected_hour}</td>
                                    </tr>
                              ))}

                              {selectedTab === 'confirmed' && confirmedBooking.map(booking => (
                                    <tr key={booking.id}>
                                          <td>{booking.id}</td>
                                          <td>{booking.status}</td>
                                          <td>{new Date(booking.booking_start_date_time).toLocaleString()}</td>
                                          <td>{new Date(booking.booking_end_date_time).toLocaleString()}</td>

                                          <td>{booking.by.user.full_name}</td>
                                          <td>{booking.to.user.full_name}</td>
                                          <td>{booking.service.service_name}</td>

                                          <td>{booking.expected_hour}</td>
                                    </tr>
                              ))}

                              {selectedTab === 'completed' && completedBooking.map(booking => (
                                    <tr key={booking.id}>
                                          <td>{booking.id}</td>
                                          <td>{booking.status}</td>
                                          <td>{new Date(booking.booking_start_date_time).toLocaleString()}</td>
                                          <td>{new Date(booking.booking_end_date_time).toLocaleString()}</td>

                                          <td>{booking.by.user.full_name}</td>
                                          <td>{booking.to.user.full_name}</td>
                                          <td>{booking.service.service_name}</td>

                                          <td>{booking.expected_hour}</td>
                                    </tr>
                              ))}
                        </tbody>
                  </table>
            </div>
      );
};



export default BookDetail;

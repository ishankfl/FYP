import React, { useState } from "react";
import "./Login.scss"

import Axios from 'axios'
import ip from '../ip/ip';
import { useNavigate } from "react-router-dom";
import Loading from "../Loading/Loading";
const swal = require('sweetalert2')


const Login = () => {
      const win = window.sessionStorage;

      const [email, setEmail] = useState('')
      const [password, setPassword] = useState('')
      const [loading, setLoading] = useState(false)


      const handleSubmit = async (e) => {
            e.preventDefault();
            setLoading(true);

            try {
                  const response = await Axios.post(`${ip()}/account/api/login/`, {
                        email: email,
                        password: password,
                        device_token: "1234567890abcdef"
                  });

                  if (response.status === 200) {
                        setLoading(false);

                        swal.fire({
                              title: "Login Successful",
                              icon: "success",
                              toast: true,
                              timer: 6000,
                              position: 'top-right',
                              timerProgressBar: true,
                              showConfirmButton: false,
                        });
                        console.log(response.data)

                        win.setItem('token', response.data.access);
                        // win.setItem('token', 'asdasdsd');
                        const userString = JSON.stringify(response.data.data);
                        win.setItem('user', userString);
                        window.location.href = '/admin'
                  } else {
                        setLoading(false);
                        swal.fire({
                              title: "Please Enter valid username and password",
                              icon: "error",
                              toast: true,
                              timer: 6000,
                              position: 'top-right',
                              timerProgressBar: true,
                              showConfirmButton: false,
                        });
                  }
            } catch (error) {
                  console.log("Error:", error);
                  setLoading(false);
                  swal.fire({
                        title: "Error",
                        text: "Please enter a valid username and password",
                        icon: "error",
                        toast: true,
                        timer: 6000,
                        position: 'top-right',
                        timerProgressBar: true,
                        showConfirmButton: false,
                  });
            }
      };



      if (!loading) {
            return (
                  <section className="login-section">
                        <div className="banner-image">

                        </div>
                        <div className="register-form-container">
                              <form className="form" method="POST" encType="multipart/form-data" onSubmit={handleSubmit}>
                                    <div className="input-fields">
                                          <div className="form">
                                                <p className="title">Login</p>
                                                <p className="message" >. </p>
                                                <label>
                                                      <input required className="input" type="email" placeholder="" onChange={e => setEmail(e.target.value)} />
                                                      <span>Email</span>
                                                </label>

                                                <label>
                                                      <input required className="input" type="password" placeholder="" onChange={e => setPassword(e.target.value)} />
                                                      <span>Password</span>
                                                </label>
                                                <button type="submit" className="submit">Submit</button>
                                                {/* <p className="signin">Donot  an Account ? <a onClick={() => navigate('/register')}>Sign Up</a> </p> */}
                                          </div>
                                    </div>
                              </form>
                        </div>
                  </section>
            )
      }
      else {
            return (
                  <Loading />
            )
      }
}

export default Login
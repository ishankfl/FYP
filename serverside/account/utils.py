from datetime import datetime, timedelta
import pyotp # type: ignore
# from twilio.rest import Client
import os
import smtplib
import traceback
from django.http import HttpResponse
from django.core.mail import send_mail
from django.core.mail import EmailMultiAlternatives
from django.template.loader import render_to_string
from django.utils.html import strip_tags
def send_otp(request,email=None):
    otp_key = pyotp.random_base32()
    print(f"send_otp key : {otp_key}")
    totp = pyotp.TOTP(pyotp.random_base32(), interval=200)
    otp = totp.now()
    print(otp)
    otp_key = totp.secret
    print(otp_key)
    request.session['otp_key'] = otp_key
    request.session.save()
    return otp, otp_key
async def send_email(recipient_list, message, subject):
    print("Sending emails to recipient")
    
    # Render the HTML template for the email content
    html_message = render_to_string('email_template.html', {'message': message})
    
    # Create a text version of the HTML content (for email clients that don't support HTML)
    text_message = strip_tags(html_message)
    
    from_email = 'bookmeishan@gmail.com'

    try:
        # Create the email message
        email = EmailMultiAlternatives(subject, text_message, from_email, recipient_list)
        email.attach_alternative(html_message, "text/html")  # Attach the HTML content

        # Send the email
        await email.send()

        print("Email sent successfully")
        return "success"

    except Exception as e:
        print(e)
        traceback.print_exc()
        return "unsuccess"
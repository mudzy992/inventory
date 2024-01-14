import * as nodemailer from 'nodemailer';

const transporter = nodemailer.createTransport({
  host: 'smtp-mail.outlook.com',
  port: 587,
  secure: false,
  auth: {
    user: 'fixedboy@live.com',
    pass: 'Mojalozinka!5'
  },
  tls: {
    ciphers: 'SSLv3',
  },
});

export const sendEmail = async (to, subject, text) => {
  try {
    const mailOptions = {
      from: 'fixedboy@live.com',
      to: to,
      subject: subject,
      text: text
    };
    const result = await transporter.sendMail(mailOptions);
    return result;
  } catch (error) {
    console.error('Error sending email:', error);
    throw error;
  }
};


module.exports = { sendEmail };

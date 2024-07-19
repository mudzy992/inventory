import { MailerConfig } from 'config/mailer.config';
import * as nodemailer from 'nodemailer';

const transporter = nodemailer.createTransport({
  service: "Gmail",
  auth: {
    user: MailerConfig.user,
    pass: MailerConfig.pass,
  },
});

export const sendEmail = async (to, subject, text) => {
  try {
    const mailOptions = {
      from: {
        name: "Service Desk",
        address: MailerConfig.user
      },
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

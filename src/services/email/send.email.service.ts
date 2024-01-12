import { nodemailer} from "nodemailer";

const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'mudzahid.ceric@gmail.com',
    pass: 'nije,kikiriki'
  }
});

// emailService.js
export const sendEmail = async (to, subject, text) => {
  try {
    const mailOptions = {
      from: 'mudzahid.ceric@gmail.com',
      to: to,
      subject: subject,
      text: text
    };

    const result = await transporter.sendMail(mailOptions);
    console.log('Email sent:', result);

    return result;
  } catch (error) {
    console.error('Error sending email:', error);
    throw error; // Propagirajte grešku natrag kako bi se mogla uhvatiti u pozivajućem kodu
  }
};


module.exports = { sendEmail };

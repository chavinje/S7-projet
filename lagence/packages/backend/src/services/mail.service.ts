import nodemailer from 'nodemailer';

const MAIL = process.env.MAILER_EMAIL;

export const mailerService = {
  sendMail: async (formData: {
    email: string;
    subject: string;
    message: string;
  }) => {
    try {
      // Configurer le compte mail
      const transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
          user: MAIL,
          pass: process.env.MAILER_PASSWORD,
        },
      });

      // Configurer le contenu de l'email
      const mailOptions = {
        from: MAIL,
        to: formData.email,
        replyTo: formData.email,
        subject: `${formData.subject}`,
        text: `${formData.message}`,
      };

      // Envoyer l'email
      await transporter.sendMail(mailOptions);
    } catch (error) {
      console.log(error);
    }
  },
};

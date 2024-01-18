import { Request, Response } from 'express';
import nodemailer from 'nodemailer';

export const contactController = {
  contact: async (req: Request, res: Response) => {
    try {
      const formData = req.body;

      // Configurer le compte mail
      const transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
          user: 'eseolagence@gmail.com',
          pass: 'idkl nueb jgrt gpaq ',
        },
      });

      // Configurer le contenu de l'email
      const mailOptions = {
        from: 'eseolagence@gmail.com',
        to: 'eseolagence@gmail.com',
        replyTo: `${formData.email}`,
        subject: `Formulaire de contact - ${formData.subject}`,
        text: `${formData.message}`,
      };

      // Envoyer l'email
      await transporter.sendMail(mailOptions);

      res.status(200).json({ message: 'Données du formulaire reçues avec succès!' });
    } catch (error) {
      res.status(500).json({ error: 'Erreur lors de la gestion des données du formulaire' });
    }
  },
};

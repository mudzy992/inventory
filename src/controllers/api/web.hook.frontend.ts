import { Controller, UseGuards, Post, Req, Res } from '@nestjs/common';
import { Request, Response } from 'express';
import { exec } from 'child_process';
import { SkipAuthMiddleware } from 'src/middlewares/skip.auth.middleware';


@Controller('auth/')
@UseGuards(SkipAuthMiddleware)
export class WebhookController {
  @Post('github')
  async handleGitHubWebhook(@Req() req: Request, @Res() res: Response): Promise<void> {
    // Postavite svoj tajni ključ ovdje
    const secret = 'tajniključzawebhook';

    const signature = req.get('X-Hub-Signature-256');
    
    // Provjerite potpis kako biste osigurali da zahtjev dolazi od GitHub-a
    if (!this.verifyGitHubSignature(secret, req.body, signature)) {
      res.status(403).send('Unauthorized');
      return;
    }

    // Ovdje možete postaviti svoju logiku izvršavanja skripte deploy.sh
    // Koristite `exec` funkciju za izvršavanje skripte
    exec('sh ./deploy-scripts/deploy-frontend.sh', (error, stdout, stderr) => {
      if (error) {
        console.error(`Greška prilikom izvršavanja deploy.sh: ${error}`);
        res.status(500).send('Greška prilikom izvršavanja deploy.sh!');
        return;
      }
      console.log(`Skripta deploy.sh je uspješno izvršena: ${stdout}`);
      res.status(200).send('Webhook primljen i deployiran.');
    });
  }

  private verifyGitHubSignature(secret: string, body: any, signature: string): boolean {
    // Implementirajte provjeru GitHub-ovog potpisa ovdje
    // Za provjeru potpisa možete koristiti crypto modul ili neki paket za tu svrhu
    // Implementacija ovisi o vašim specifičnim potrebama
    return true; // Vratite true ako je provjera uspješna
  }
}



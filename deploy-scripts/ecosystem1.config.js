module.exports = {
    apps : [{
      name: 'inventory-frontend', // Zamijenite s odgovarajućim imenom za vašu aplikaciju
      script: 'npm',
      args: 'start',
      interpreter: 'none',
      env: {
        NODE_ENV: 'production',
        PORT:4001, //Port obrisati ako ne rad
      },
    }],
  
    deploy : {
      production : {
        user : 'administrator', // Zamijenite s vašim SSH korisničkim imenom
        host : '77.221.21.7',
        ref  : 'origin/AI-optimizacija', // Zamijenite s imenom vaše produkcione grane
        repo : 'https://github.com/mudzy992/frontend-inventory.git', // Zamijenite sa URL-om vašeg repozitorija
        path : '/home/administrator/Documents/GitHub/frontend-inventory/', // Zamijenite sa stvarnom putanjom na vašem serveru
        'post-deploy' : 'npm install && pm2 reload ecosystem.config.js --env production',
      }
    }
  };
  
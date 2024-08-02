export const StorageConfig = {
  prenosnica: {
    template: "/usr/src/app/storage/prenosnica.docx",
    destination: "/usr/src/app/storage/prenosnica", 
    urlPrefix: "/prenosnica/",
    maxAge: 1000 * 60 * 60 * 24 * 7,
  },
  deploy: {
    destination: "./deploy-scripts/deploy.sh",
  },
};

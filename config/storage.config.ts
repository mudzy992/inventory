export const StorageConfig = {
  prenosnica: {
    template: "../storage/prenosnica/template/prenosnica.docx",
    destination: "../storage/prenosnica/",
    urlPrefix: "/prenosnica/",
    maxAge: 1000 * 60 * 60 * 24 * 7,
  },
  deploy: {
    destination: "./deploy-scripts/deploy.sh",
  },
};

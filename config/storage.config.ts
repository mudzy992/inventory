export const StorageConfig = {
  prenosnica: {
    template: "/usr/src/app/uploads/prenosnica.docx",
    destination: "/usr/src/app/uploads",
    urlPrefix: "/prenosnica/",
    maxAge: 1000 * 60 * 60 * 24 * 7,
  },
  deploy: {
    destination: "./deploy-scripts/deploy.sh",
  },
};

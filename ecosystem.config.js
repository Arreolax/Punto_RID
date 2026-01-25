module.exports = {
  apps: [
    {
      name: "punto-venta-server",
      script: "app.js",
      watch: true,
      ignore_watch: ["node_modules", "public", "src"],
      env: {
        NODE_ENV: "development",
      },
    },
    {
      name: "punto-venta-tailwind",
      // TRUCO: Ejecutamos directamente la consola de Windows
      script: "cmd.exe", 
      // Le decimos: "Ejecuta 'npm run tailwind' y quédate escuchando"
      args: "/c npm run tailwind",
      interpreter: "none",
      autorestart: true,
      watch: false,
    },
  ],
};
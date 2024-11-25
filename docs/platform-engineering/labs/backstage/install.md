# Install Backstage

## Overview

In this lab we will initialize the standalone app for the moment. In the later labs we will add an external database to it and deploy it to Azure.

To get set up quickly with your own Backstage project you can create a Backstage App.

A Backstage App is a monorepo setup with lerna that includes everything you need to run Backstage in your own environment. It includes the Backstage frontend, backend, and CLI tooling.

## Instructions

### Step 0 - Prerequisites

Create a new directory for all the workshop files and navigate into it.

mkdir pulumi-backstage-azure-workshop
cd pulumi-backstage-azure-workshop
This will be the root directory for the workshop. Keep this in mind for all the following steps and chapters.

### Step 1 - Create a Backstage App

Backstage provides a utility for creating new apps. It guides you through the initial setup of selecting the name of the app and a database for the backend. The database options are either SQLite or PostgreSQL, where the latter requires you to set up a separate database instance.

To create a new app, run the following command:

``` bash
npx @backstage/create-app@latest
```

>NOTE: If prompted, enter a name for the app. This will be the name of the directory that is created. I suggest to use backstage

``` bash
? Enter a name for the app [required] backstage

Creating the app...

 Checking if the directory is available:
  checking      backstage ✔ 

 Creating a temporary app directory:

 Preparing files:
  copying       .dockerignore ✔ 
  copying       .eslintignore ✔ 
  templating    .eslintrc.js.hbs ✔ 
  templating    .gitignore.hbs ✔ 
  copying       .prettierignore ✔ 
  copying       README.md ✔ 
  copying       app-config.local.yaml ✔ 
  copying       app-config.production.yaml ✔ 
  templating    app-config.yaml.hbs ✔ 
  templating    backstage.json.hbs ✔ 
  templating    catalog-info.yaml.hbs ✔ 
  copying       lerna.json ✔ 
  templating    package.json.hbs ✔ 
  copying       playwright.config.ts ✔ 
  copying       tsconfig.json ✔ 
  copying       yarn.lock ✔ 
  copying       README.md ✔ 
  copying       entities.yaml ✔ 
  copying       org.yaml ✔ 
  copying       template.yaml ✔ 
  copying       catalog-info.yaml ✔ 
  copying       index.js ✔ 
  copying       package.json ✔ 
  copying       README.md ✔ 
  templating    .eslintrc.js.hbs ✔ 
  copying       Dockerfile ✔ 
  copying       README.md ✔ 
  templating    package.json.hbs ✔ 
  copying       index.test.ts ✔ 
  copying       index.ts ✔ 
  copying       types.ts ✔ 
  copying       app.ts ✔ 
  copying       auth.ts ✔ 
  copying       catalog.ts ✔ 
  copying       proxy.ts ✔ 
  copying       scaffolder.ts ✔ 
  templating    search.ts.hbs ✔ 
  copying       techdocs.ts ✔ 
  copying       .eslintignore ✔ 
  templating    .eslintrc.js.hbs ✔ 
  templating    package.json.hbs ✔ 
  copying       android-chrome-192x192.png ✔ 
  copying       apple-touch-icon.png ✔ 
  copying       favicon-16x16.png ✔ 
  copying       favicon-32x32.png ✔ 
  copying       favicon.ico ✔ 
  copying       index.html ✔ 
  copying       manifest.json ✔ 
  copying       robots.txt ✔ 
  copying       safari-pinned-tab.svg ✔ 
  copying       app.test.ts ✔ 
  copying       App.test.tsx ✔ 
  copying       App.tsx ✔ 
  copying       apis.ts ✔ 
  copying       index.tsx ✔ 
  copying       setupTests.ts ✔ 
  copying       LogoFull.tsx ✔ 
  copying       LogoIcon.tsx ✔ 
  copying       Root.tsx ✔ 
  copying       index.ts ✔ 
  copying       EntityPage.tsx ✔ 
  copying       SearchPage.tsx ✔ 

 Moving to final location:
  moving        backstage ✔ 

 Installing dependencies:
  determining   yarn version ✔ 
  executing     yarn install ✔ 
  executing     yarn tsc ✔ 

🥇  Successfully created backstage

 All set! Now you might want to:
  Run the app: cd backstage && yarn dev
  Set up the software catalog: https://backstage.io/docs/features/software-catalog/configuration
  Add authentication: https://backstage.io/docs/auth/

```
This can take a few minutes to complete. But you should see the current progress in the terminal.

You should now have a new directory called backstage in your root directory, which contains following files and folders:

``` bash
backstage/
├── README.md
├── app-config.local.yaml
├── app-config.production.yaml
├── app-config.yaml
├── backstage.json
├── catalog-info.yaml
├── dist-types
│   ├── packages
│   └── tsconfig.tsbuildinfo
├── examples
│   ├── entities.yaml
│   ├── org.yaml
│   └── template
├── lerna.json
├── package.json
├── packages
│   ├── README.md
│   ├── app
│   └── backend
├── playwright.config.ts
├── plugins
│   └── README.md
├── tsconfig.json
└── yarn.lock
```

- README.md: The main README file for the app.
- app-config.yaml: Main configuration file for the app.
- catalog-info.yaml: Catalog Entities descriptors.
- lerna.json: Contains information about workspaces and other lerna configuration needed for the monorepo setup.
- package.json: Root package.json for the project. Note: Be sure that you don’t add any npm dependencies here as they probably should be installed in the intended workspace rather than in the root.
- packages/: Lerna leaf packages or “workspaces”. Everything here is going to be a separate package, managed by lerna.
- packages/app/: An fully functioning Backstage frontend app, that acts as a good starting point for you to get to know Backstage.
- packages/backend/: The backend for Backstage.

## Step 2 - Run the App

As soon as the app is created, you can run it by navigating into the backstage directory and running the following command:

``` bash
cd backstage
yarn dev
```

The yarn dev command will run both the frontend and backend as separate processes (named [0] and [1]) in the same window. When the command finishes running, it should open up a browser window displaying your app. If not, you can open a browser and directly navigate to the frontend at http://localhost:3000.
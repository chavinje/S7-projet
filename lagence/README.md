# L'agence - Web

This repository contains the source code for the **L'agence** web application and its backend.

## Requirements

It's recommended to use [Yarn](https://yarnpkg.com/) as a package manager.

You also need to have a database available.

## Installation

Run the following commands to install the dependencies:

```bash
yarn
```

_When installing dependencies, be sure to be in the correct package directory (**frontend or backend**) and not at the root of the project._

## Usage

Run the following command to start the development server (backend & frontend):

```bash
yarn dev
```

To run only the backend or the frontend, run the following commands:

```bash
yarn dev:backend
yarn dev:frontend
```

_You can also launch the backend and the frontend separately by going to the package directory and running the `yarn dev` command._

## Documentation

There's a README in each package directory that explains the particularities of each project.

- [frontend](packages/frontend/README.md)
- [backend](packages/backend/README.md)

## Related

There's the repository of the desktop application: https://github.com/maxsans/L-Agence-Desktop

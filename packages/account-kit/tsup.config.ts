import { defineConfig } from "tsup";

export default defineConfig([
  {
    outDir: "dist/tsup",
    entry: {
      index: "src/exports/index.ts",
      core: "src/exports/core.ts",
      chains: "src/exports/chains.ts",
      internal: "src/exports/internal.ts",
    },
    target: "esnext",
    format: ["esm"],
    dts: false, // TODO: figure out how to reenable
    sourcemap: true,
    clean: true,
    minify: true,
    // Because we're injecting CSS via shadow DOM, we'll disable style injection and load CSS as a base64 string.
    // TODO: figure out how to do this conditionally for only specific imports?
    injectStyle: false,
    loader: {
      ".css": "text",
    },
  },
  // {
  //   outDir: "dist/global",
  //   entry: {
  //     global: "src/global/global.ts",
  //   },
  //   target: "esnext",
  //   format: ["iife"],
  //   dts: false, // TODO: figure out how to reenable
  //   sourcemap: true,
  //   clean: true,
  //   minify: true,
  //   define: {
  //     "process.env.NODE_ENV": JSON.stringify("production"),
  //   },
  // },
]);

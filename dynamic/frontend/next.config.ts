import type { NextConfig } from "next";
import path from 'path';

const nextConfig: NextConfig = {
  allowedDevOrigins: ['localhost', '127.0.0.1', '192.168.56.1', '192.168.1.1', '10.0.0.1'],
  turbopack: {
    root: path.resolve(__dirname),
  },
};

export default nextConfig;

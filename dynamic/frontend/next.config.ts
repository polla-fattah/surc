import type { NextConfig } from "next";
import path from 'path';

const nextConfig: NextConfig = {
  allowedDevOrigins: ['localhost', '127.0.0.1', '192.168.56.1', '192.168.1.1', '10.0.0.1'],
  turbopack: {
    root: path.resolve(__dirname),
  },
  async rewrites() {
    const backendUrl = process.env.INTERNAL_BACKEND_URL || 'http://127.0.0.1:3000';
    return [
      {
        source: '/api/upload',
        destination: `${backendUrl}/api/upload`,
      },
      {
        source: '/api/staff/:path*',
        destination: `${backendUrl}/api/staff/:path*`,
      },
      {
        source: '/api/labs/:path*',
        destination: `${backendUrl}/api/labs/:path*`,
      },
      {
        source: '/api/projects/:path*',
        destination: `${backendUrl}/api/projects/:path*`,
      },
      {
        source: '/api/publications/:path*',
        destination: `${backendUrl}/api/publications/:path*`,
      },
      {
        source: '/api/units/:path*',
        destination: `${backendUrl}/api/units/:path*`,
      },
      {
        source: '/api/events/:path*',
        destination: `${backendUrl}/api/events/:path*`,
      },
      {
        source: '/api/datasets/:path*',
        destination: `${backendUrl}/api/datasets/:path*`,
      },
      {
        source: '/api/regulations/:path*',
        destination: `${backendUrl}/api/regulations/:path*`,
      },
      {
        source: '/api/forms/:path*',
        destination: `${backendUrl}/api/forms/:path*`,
      },
      {
        source: '/api/search',
        destination: `${backendUrl}/api/search`,
      }
    ];
  }
};

export default nextConfig;

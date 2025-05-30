// 最佳实践配置示例
module.exports = {
  experimental: {
    serverComponentsExternalPackages: ['@opendocsg/pdf2md', 'pdfjs-dist', 'pdf2md-js', '@napi-rs/canvas']
  },
  webpack: (config, { isServer }) => {
    if (!isServer) {
      config.externals.push({
        unpdf: 'window.unpdf',
        'pdfjs-dist': 'window.pdfjsLib'
      });
    } else {
      config.externals.push('canvas');
      // 排除原生二进制文件
      config.externals.push({
        '@napi-rs/canvas': 'commonjs @napi-rs/canvas',
        'pdf2md-js': 'commonjs pdf2md-js'
      });
    }
    
    // 添加对.node文件的处理
    config.module.rules.push({
      test: /\.node$/,
      use: 'raw-loader'
    });
    
    return config;
  }
};

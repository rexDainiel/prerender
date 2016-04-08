var cache_manager = require('cache-manager');
var fsStore = require('cache-manager-fs');

module.exports = {
    init: function() {
        this.cache = cache_manager.caching({
            store: fsStore,
            options: {
                ttl: process.env.CACHE_TTL || 86400,
                maxsize: process.env.CACHE_MAX_SIZE || 5*1024*1024*1024,
                path: process.env.CACHE_DIR || './prerender-file-cache'
            }
        });
    },

    beforePhantomRequest: function(req, res, next) {
        if(req.method !== 'GET') {
            return next();
        }

        this.cache.get(req.prerender.url, function (err, result) {
            if (!err && result) {
                console.log('cache hit');
                res.send(200, result);
            } else {
                next();
            }
        });
    },

    afterPhantomRequest: function(req, res, next) {
        if(req.prerender.statusCode === 200) {
            this.cache.set(req.prerender.url, req.prerender.documentHTML, function(err, result) {
                if (err) console.error(err);
            });
        }
        next();
    }
};

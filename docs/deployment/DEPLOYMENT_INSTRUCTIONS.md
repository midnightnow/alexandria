# 🏛️ Alexandria Deployment Instructions

## 🚀 **Ready to Deploy: alexandria.hardcard.org**

All files are prepared in `/Users/studio/alexandria-deploy/` for immediate deployment.

---

## **Option 1: Vercel (Recommended - Fast)**

### Step 1: Login to Vercel
```bash
cd ~/alexandria-deploy
vercel login
```

### Step 2: Deploy
```bash
vercel --prod --yes
```

### Step 3: Configure DNS
After deployment, Vercel will give you a URL like `alexandria-hardcard.vercel.app`

Add this CNAME record to your hardcard.org DNS:
```
Type: CNAME
Name: alexandria
Value: alexandria-hardcard.vercel.app
TTL: 300 seconds
```

---

## **Option 2: Netlify (Alternative)**

### Step 1: Drag & Drop Deployment
1. Go to https://app.netlify.com/drop
2. Drag the entire `~/alexandria-deploy` folder
3. Site will deploy automatically

### Step 2: Configure Domain
1. In Netlify dashboard → Site settings → Domain management
2. Add custom domain: `alexandria.hardcard.org`
3. Follow DNS configuration instructions

---

## **Option 3: Traditional Web Hosting**

### Step 1: Upload Files
Upload all files from `~/alexandria-deploy/` to your web server:
- index.html
- alexandria_*.html
- alexandria_api_server.js (if backend supported)
- ALEXANDRIA_*.md files

### Step 2: Configure Subdomain
Point `alexandria.hardcard.org` to the uploaded files directory.

---

## **🎯 Final Result**

Once deployed, Alexandria will be live at:
- **Main Portal:** https://alexandria.hardcard.org
- **Beta Registration:** https://alexandria.hardcard.org/beta  
- **API Health:** https://alexandria.hardcard.org/api/health
- **Research Papers:** https://alexandria.hardcard.org/research

---

## **🔧 Configuration**

### Environment Variables (if using backend)
```env
NODE_ENV=production
PORT=3000
CORS_ORIGINS=https://alexandria.hardcard.org,https://hardcard.org
JWT_SECRET=your_secure_secret_here
EMAIL_FROM="Alexandria Research <noreply@hardcard.org>"
CONTACT_EMAIL="research@hardcard.org"
```

### CORS Configuration
The API is pre-configured to accept requests from:
- https://alexandria.hardcard.org
- https://hardcard.org

---

## **🎓 Academic Identity Confirmed**

Alexandria is configured as:
- **Platform Name:** Alexandria Research Validation Platform
- **Institution:** Independent Academic Initiative  
- **Contact:** research@hardcard.org
- **Tech Support:** Infrastructure support by HardCard Research

Perfect positioning for journal submissions and academic credibility!

---

## **📧 Next Steps After Deployment**

1. **Test the deployment** at alexandria.hardcard.org
2. **Invite first 10 beta researchers**
3. **Submit Nature Machine Intelligence paper**
4. **Launch academic social media presence**

**Alexandria is ready to advance scientific integrity worldwide! 🏛️**
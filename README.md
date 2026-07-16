# Landscapes by Lindy - Website

A professional, clean website showcasing Lindy Ham's watercolor and oil landscape paintings, with integrated Stripe payment processing for selling artwork online.

## 📋 Project Structure

```
Landscapes by lindy/
├── index.html                 # Home page
├── gallery.html              # Gallery/Shop page
├── about.html                # Artist biography
├── contact.html              # Contact form
├── artwork/
│   ├── serene-harbor.html    # Individual artwork page 1
│   └── koi-communion.html    # Individual artwork page 2
├── css/
│   └── styles.css            # Main stylesheet
├── js/
│   ├── main.js               # Main functionality & forms
│   └── stripe-config.js      # Stripe payment integration
├── WhatsApp Image files      # Artwork images (A4 watercolors)
└── README.md                 # This file
```

## 🎨 Design Features

- **Clean, Professional Design**: Minimalist aesthetic with earthy color palette
- **Brushstroke Logo**: Custom SVG logo mimicking Lindy's artistic signature
- **Responsive Layout**: Fully mobile-friendly design
- **Smooth Navigation**: Easy access to all sections
- **High-Quality Imagery**: Optimized for artwork display

### Color Palette
- Primary: `#5C4A42` (Warm brown)
- Secondary: `#8B7355` (Earthy tan)
- Accent: `#D4A574` (Gold)
- Background: `#F5F3F0` (Cream)

## 💳 Stripe Integration Setup

### Step 1: Create a Stripe Account
1. Go to https://stripe.com
2. Sign up for a free account
3. Complete account verification

### Step 2: Get Your API Keys
1. Log into Stripe Dashboard: https://dashboard.stripe.com
2. Navigate to **Developers** → **API keys**
3. Copy your **Publishable Key** (starts with `pk_`)
4. Copy your **Secret Key** (keep this private!)

### Step 3: Update Website Configuration
1. Open `js/stripe-config.js`
2. Replace `pk_test_YOUR_KEY_HERE` with your actual Publishable Key:
   ```javascript
   const STRIPE_PUBLISHABLE_KEY = 'pk_test_YOUR_ACTUAL_KEY';
   ```

### Step 4: Backend Setup (Required for Live Payments)
For payment processing to work, you'll need a backend server that:
- Receives payment requests from the frontend
- Creates Stripe PaymentIntent objects
- Returns the client secret to complete payment

**Recommended Options:**

#### Option A: Stripe Payment Links (Simplest)
1. Create product in Stripe Dashboard: https://dashboard.stripe.com/products
2. Set up payment links for each artwork
3. Replace form submission with redirect to payment link

#### Option B: Node.js/Express Backend
```javascript
const express = require('express');
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);

app.post('/create-payment-intent', async (req, res) => {
    const { amount, artworkTitle } = req.body;
    
    const paymentIntent = await stripe.paymentIntents.create({
        amount: amount,
        currency: 'gbp',
        description: artworkTitle
    });
    
    res.json({ clientSecret: paymentIntent.client_secret });
});
```

#### Option C: Netlify Functions / AWS Lambda
Deploy serverless functions to handle payment processing without maintaining a server.

#### Option D: Third-Party Integration
- **Gumroad**: Artist-focused, simple integration
- **SendOwl**: Digital + physical product sales
- **Shopify**: Full e-commerce setup

## 📧 Contact Form Setup

The contact form currently has basic client-side validation. For emails to actually send:

### Option 1: Use Email Service (Recommended)
- **Formspree**: https://formspree.io/
  - Update form action to your Formspree endpoint
  - Free tier includes up to 50 submissions/month

- **Netlify Forms**: Built-in form handling if hosted on Netlify

### Option 2: Backend Email Service
- **SendGrid**: Professional email API
- **Mailgun**: Email service with great documentation
- **AWS SES**: Cost-effective email service

## 🚀 Deployment Options

### Recommended Hosts (for static content):

**1. Netlify (Best for this project)**
- Zero-cost hosting with generous free tier
- Built-in SSL, CDN, and form handling
- Supports serverless functions for payments
- Deploy directly from GitHub

**2. GitHub Pages**
- Free hosting for static sites
- Custom domain support
- Perfect for portfolio sites

**3. Vercel**
- Fast deployment
- Preview URLs for testing
- Serverless function support

**4. Bluehost / WordPress Hosting**
- Traditional web hosting
- Email support included
- More setup required

### Deployment Steps (Netlify Example):
1. Push code to GitHub
2. Connect repo to Netlify
3. Deploy in one click
4. Add custom domain (optional)

## 🎯 Current Artwork

### Featured Pieces (Available for Purchase):
1. **Serene Harbor** - Watercolor on A4 paper - £200
   - Coastal landscape with sailboat
   - Dreamy color palette of purples, pinks, and blues

2. **Koi Communion** - Watercolor on A4 paper - £200
   - Five koi fish in flowing water
   - Vibrant oranges, whites, and yellows

### Future Additions:
- 50+ artworks to be professionally photographed
- Both oils and watercolors
- Various landscape themes

## 📝 To Update Content Later:

### Add New Artwork:
1. Create new file: `artwork/artwork-name.html` (copy from existing)
2. Add image to main directory
3. Update gallery.html with new item
4. Update index.html if featuring new piece

### Update Artist Bio:
Edit the text in:
- `about.html` - Full biography
- `index.html` - Preview section

### Add Social Media:
Links are in footer and About section. Update the Facebook URL:
```html
<a href="https://www.facebook.com/profile.php?id=100095202403885">Facebook</a>
```

## 🔧 Technical Stack

- **HTML5** - Semantic markup
- **CSS3** - Responsive design with CSS variables
- **JavaScript (Vanilla)** - No framework dependencies
- **Stripe.js** - Payment processing
- **SVG** - Logo and icons

## 📱 Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
- Mobile browsers (iOS Safari, Chrome Mobile)

## 🛡️ Security Notes

1. **Never commit Secret Keys** to GitHub
2. Use environment variables for sensitive data
3. Enable HTTPS (automatic with most hosts)
4. Validate all user input server-side
5. Use Stripe's recommended security practices

## 💬 Contact Information

- **Email**: Lindyhams@gmail.com
- **Facebook**: https://www.facebook.com/profile.php?id=100095202403885
- **Location**: South Africa

## 📄 License

© 2026 Landscapes by Lindy. All rights reserved.

---

**Next Steps:**
1. [ ] Create Stripe account
2. [ ] Add Stripe Publishable Key to js/stripe-config.js
3. [ ] Choose payment backend solution
4. [ ] Set up contact form email service
5. [ ] Choose hosting provider and deploy
6. [ ] Test payment flow with Stripe test card: 4242 4242 4242 4242
7. [ ] Add professional photos of remaining 50+ artworks
8. [ ] Go live!

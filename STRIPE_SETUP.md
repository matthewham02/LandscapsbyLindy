# Stripe Payment Setup Guide for Landscapes by Lindy

This guide walks you through setting up Stripe payments for your artwork sales.

## Why Stripe?

✓ **Professional** - Trusted by millions of businesses  
✓ **Secure** - PCI-DSS Level 1 certified  
✓ **Artist-Friendly** - Low fees (2.9% + £0.30 per transaction in UK)  
✓ **No Monthly Fee** - Pay only per transaction  
✓ **Easy Setup** - Works with this website immediately  
✓ **Multiple Payment Options** - Cards, Apple Pay, Google Pay  

## Quick Start (5 minutes)

### 1. Create Stripe Account
1. Visit: https://stripe.com
2. Click "Start now" (top right)
3. Enter your email and password
4. Verify email
5. Complete business details (you'll be asked about your art business)
6. Add bank details for payouts

### 2. Get Your Publishable Key
1. Log into: https://dashboard.stripe.com
2. Click "Developers" (left sidebar)
3. Click "API keys"
4. Find "Publishable key" (starts with `pk_test_` or `pk_live_`)
5. Copy this key

### 3. Update Website
1. Open: `js/stripe-config.js` in a text editor
2. Find this line:
   ```javascript
   const STRIPE_PUBLISHABLE_KEY = 'pk_test_YOUR_KEY_HERE';
   ```
3. Replace `pk_test_YOUR_KEY_HERE` with your actual key:
   ```javascript
   const STRIPE_PUBLISHABLE_KEY = 'pk_test_abc123xyz789...';
   ```
4. Save the file

### 4. Test It
1. Host your website (Netlify, GitHub Pages, etc.)
2. Go to a product page (Serene Harbor or Koi Communion)
3. Try buying with Stripe test card: **4242 4242 4242 4242**
4. Any future date, any 3-digit CVC
5. You should see success message

## Understanding Stripe Test Mode vs Live Mode

### Test Mode (Start Here)
- **Publishable Key**: Starts with `pk_test_`
- **No Real Charges**: Test cards don't cost money
- **No Real Payouts**: Money goes nowhere
- **Test Cards**:
  - Success: `4242 4242 4242 4242`
  - Decline: `4000 0000 0000 0002`
  - 3D Secure: `4000 0025 0000 3155`

### Live Mode (After Testing)
- **Publishable Key**: Starts with `pk_live_`
- **Real Charges**: Test cards won't work
- **Real Payouts**: Money goes to your bank
- **Switch**: Dashboard → Developers → API keys → Toggle "Live" mode
- **Security**: Secret key becomes crucial (keep it private!)

## Complete Payment Setup (Backend Required)

The current website needs a backend server to actually process payments. Choose one option:

### Option 1: Simple Stripe Checkout (Recommended for Beginning)

**Advantages:**
- ✓ No backend needed
- ✓ Stripe handles everything
- ✓ PCI compliance automatic
- ✓ Takes 10 minutes

**Steps:**
1. Create product in Stripe Dashboard:
   - Go: https://dashboard.stripe.com/products
   - Click "+ Add product"
   - Enter artwork title, price (£200)
   - Save

2. Create payment link:
   - On product page, click "Create payment link"
   - Configure: custom fields, success/cancel URLs
   - Copy generated link

3. Update website:
   - In `artwork/serene-harbor.html`, replace form with:
   ```html
   <a href="https://buy.stripe.com/YOUR_LINK" class="btn btn-primary" style="width: 100%; text-align: center;">
       Buy Now - £200
   </a>
   ```

### Option 2: Node.js Backend (More Professional)

**Advantages:**
- ✓ Custom branding
- ✓ Full control
- ✓ Email notifications
- ✓ Inventory tracking
- ✗ Requires server

**Example Backend (Node.js/Express):**

```javascript
// Install: npm install express stripe dotenv
require('dotenv').config();
const express = require('express');
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);
const app = express();

app.use(express.json());

app.post('/create-payment-intent', async (req, res) => {
    try {
        const { amount, artworkTitle, customerEmail } = req.body;

        const paymentIntent = await stripe.paymentIntents.create({
            amount: amount, // in pence
            currency: 'gbp',
            description: artworkTitle,
            receipt_email: customerEmail,
            metadata: {
                artwork_title: artworkTitle
            }
        });

        res.json({ clientSecret: paymentIntent.client_secret });
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
});

app.listen(3000, () => console.log('Server running on port 3000'));
```

**Deploy Backend Options:**
- **Heroku** (free tier available)
- **Railway** (simple, generous free tier)
- **Render** (free tier)
- **AWS Lambda** (serverless, pay per use)
- **Netlify Functions** (free with Netlify hosting)

### Option 3: No-Code Solution (Easiest)

Use Stripe with a form builder:

**Zapier + Stripe**
1. Create form on Typeform/Google Forms
2. Connect to Stripe via Zapier
3. Automate email confirmations
4. Minimal technical setup

**Gumroad Alternative**
1. Sign up: https://gumroad.com
2. Upload artwork images
3. Set prices
4. Gumroad handles all payments
5. Link from your website

## Security Checklist

✓ Never share your Secret Key  
✓ Use environment variables for keys  
✓ Enable HTTPS (automatic on Netlify, GitHub Pages)  
✓ Keep backend code private (not on frontend)  
✓ Test in test mode first  
✓ Monitor dashboard for suspicious activity  
✓ Enable 2FA on Stripe account  

## Testing Stripe Integration

### 1. Go to Product Page
- https://yoursite.com/artwork/serene-harbor.html

### 2. Fill Card Details
- Card: `4242 4242 4242 4242`
- Expiry: Any future date (e.g., 12/27)
- CVC: Any 3 digits (e.g., 123)
- Name: Any name

### 3. Check Stripe Dashboard
- Go: https://dashboard.stripe.com/payments
- You should see test transaction listed

### 4. Next Payment Test
- Try test decline card: `4000 0000 0000 0002`
- Should show error message

## Pricing & Fees

**Stripe UK Rates:**
- Online card payments: 2.9% + 30p
- Example: £200 artwork costs Stripe: £6.10
- You receive: £193.90 per sale

**Compare with alternatives:**
- PayPal: 3.49% + 30p = £7.30 (you get £192.70)
- Square: 2.9% + 20p = £6.00 (you get £194.00)
- Gumroad: 5% + £0.20 = £10.40 (you get £189.60)

## Common Issues & Solutions

### Issue: "pk_test_YOUR_KEY_HERE" stays in code
**Solution:** Copy entire key from dashboard, verify it starts with `pk_`

### Issue: Payment form not appearing
**Solution:** Check browser console for errors, verify Stripe script loaded

### Issue: "Backend payment endpoint not configured"
**Solution:** This means backend isn't set up. Use Stripe Payment Links option instead.

### Issue: Test card declined
**Solution:** 
- Use correct test card: `4242 4242 4242 4242`
- Expiry: Future date required
- CVC: Any 3 digits

### Issue: Payment succeeds but no receipt sent
**Solution:** Set up email notifications in Stripe Dashboard, or implement backend email service

## Next Steps Checklist

- [ ] Create Stripe account
- [ ] Get Publishable Key
- [ ] Update js/stripe-config.js with key
- [ ] Test with test card
- [ ] Choose backend solution (Checkout, Node.js, or No-Code)
- [ ] Implement chosen solution
- [ ] Test with real payment (switch to Live mode)
- [ ] Monitor dashboard for sales
- [ ] Set up email notifications
- [ ] Process payouts (automatic to your bank)

## Support

**Stripe Help:**
- Dashboard: https://dashboard.stripe.com/support/messages
- Docs: https://stripe.com/docs
- Community: https://stripe.com/community

**Common Questions:**
- **How soon do payments arrive?** Usually 1-2 business days to your bank
- **Can I refund a payment?** Yes, from dashboard
- **What if someone disputes a charge?** Stripe handles it, you can respond
- **Can I accept other payment methods?** Yes, add Apple Pay, Google Pay, etc.

---

**Questions?** Email: Lindyhams@gmail.com  
**Ready to go live?** Switch from `pk_test_` to `pk_live_` in Stripe account settings.

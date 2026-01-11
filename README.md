# 📈 GrowthLens

**AI-Powered Call Analysis Platform**

*AI Powered. Growth Driven.*

---

## 🎯 Overview

GrowthLens is an intelligent call analysis platform that leverages AI to transform sales conversations into actionable insights. By automating the analysis of call recordings, GrowthLens helps sales teams, recruiters, and business professionals improve performance, identify opportunities, and accelerate growth through data-driven intelligence.

### Key Capabilities

- **🎤 AI Call Analysis** - Automated transcription and sentiment analysis of call recordings
- **📊 Performance Metrics** - Track sentiment scores, engagement levels, and confidence metrics
- **🎯 Lead Management** - Organize leads into hot, warm, cold, and closing categories
- **💡 Objection Detection** - Identify and analyze customer objections and handling techniques
- **🧠 Company Brain** - Build a knowledge base with company information and documents
- **📁 Project Management** - Organize work by projects with dedicated knowledge bases
- **📈 Analytics Dashboard** - Real-time insights and performance trends
- **🔍 Semantic Search** - AI-powered search across all your data

---

## 🚀 Use Cases

### 1. **Sales Performance Optimization**
- Analyze sales calls to identify winning patterns
- Track objection handling effectiveness
- Monitor sentiment and engagement trends
- Get AI-powered coaching recommendations
- Measure team performance metrics

### 2. **Recruitment & Talent Acquisition**
- Automate candidate interview analysis
- Score candidate engagement and confidence
- Identify red flags and positive signals
- Standardize screening processes
- Reduce time-to-hire with data insights

### 3. **Customer Support Excellence**
- Evaluate support call quality
- Measure customer satisfaction in real-time
- Identify training opportunities
- Track resolution effectiveness
- Improve first-call resolution rates

### 4. **Market Research & Feedback**
- Analyze customer feedback calls
- Identify product improvement opportunities
- Track sentiment across customer segments
- Extract actionable insights from conversations
- Monitor brand perception

### 5. **Training & Coaching**
- Create a library of best-practice calls
- Identify coaching opportunities
- Track improvement over time
- Build team competency models
- Share successful call strategies

---

## ✨ Features

### Core Features

#### 📞 Recording Management
- Upload audio recordings (MP3, WAV, M4A, OGG)
- Automatic transcription using AI
- Cloud storage with secure access
- CSV bulk import for leads
- Associate recordings with leads and projects

#### 🤖 AI-Powered Analysis
- **Sentiment Analysis** - Detect positive, neutral, or negative sentiment
- **Engagement Scoring** - Measure conversation engagement levels
- **Confidence Metrics** - Assess speaker confidence (executive & participant)
- **Participant Detection** - Identify and count call participants
- **Lead Classification** - Auto-categorize as hot, warm, cold, or closing
- **Objection Analysis** - Detect and count objections with handling assessment
- **Next Steps Extraction** - Identify agreed follow-up actions
- **Improvement Suggestions** - Get AI coaching recommendations
- **Call Outcome Prediction** - Assess likelihood of conversion

#### 📊 Analytics & Insights
- Real-time performance dashboard
- Sentiment trend visualization
- Engagement metrics over time
- Conversion rate tracking
- Objection handling statistics
- Team performance comparison
- Custom date range filtering

#### 🧠 Company Brain
- Store company profile and information
- Upload and manage documents (PDF, DOCX, TXT, MD)
- AI embeddings for semantic search
- Context-aware analysis using company knowledge
- Document categorization and tagging

#### 📁 Project-Based Organization
- Create projects for clients or initiatives
- Project-specific knowledge bases
- Metadata tracking (domain, tech stack, goals)
- Document management per project
- AI-powered project insights

#### 👥 Lead & Contact Management
- Comprehensive lead database
- Lead grouping and segmentation
- Hot/Warm/Cold/Closing categorization
- Contact history tracking
- Custom fields and metadata

---

## 🛠️ Technology Stack

### Frontend
- **React 18** - Modern UI library
- **TypeScript** - Type-safe development
- **Vite** - Lightning-fast build tool
- **Tailwind CSS** - Utility-first styling
- **shadcn/ui** - High-quality component library
- **Recharts** - Data visualization
- **React Router** - Client-side routing
- **React Query** - Server state management
- **Framer Motion** - Smooth animations

### Backend & Services
- **Supabase** - Backend-as-a-Service
  - PostgreSQL database
  - Authentication & authorization
  - Real-time subscriptions
  - File storage
  - Edge Functions (Deno)
- **Google Gemini API** - AI embeddings generation
- **OpenAI API** - Call analysis and transcription

### Key Libraries
- **lucide-react** - Icon system
- **react-hook-form** - Form management
- **zod** - Schema validation
- **date-fns** - Date utilities
- **sonner** - Toast notifications

---

## 📦 Installation & Setup

### Prerequisites
- Node.js 18+ and npm
- Supabase account (free tier works)
- OpenAI API key (for analysis)
- Google Gemini API key (for embeddings)

### Step 1: Clone the Repository

```bash
git clone <your-repo-url>
cd Sales-Call-Analysis
```

### Step 2: Install Dependencies

```bash
npm install
```

### Step 3: Environment Configuration

Create a `.env` file in the root directory:

```env
VITE_SUPABASE_URL=your_supabase_project_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
```

### Step 4: Database Setup

1. Create a new Supabase project
2. Import the database schema and data from the `Backend/` folder:
   ```bash
   # Connect to your Supabase database
   psql -h db.your-project-ref.supabase.co -U postgres -d postgres
   
   # Run the schema file
   \i Backend/schema.sql
   
   # Run the data file
   \i Backend/data.sql
   ```
   
   Or use the Supabase dashboard SQL editor to run the contents of:
   - `Backend/schema.sql` - Creates all tables, functions, triggers, and indexes
   - `Backend/data.sql` - Inserts sample data

3. Set up environment variables in Supabase dashboard:
   - `GEMINI_API_KEY` - Your Google Gemini API key
   - `OPENAI_API_KEY` - Your OpenAI API key

### Step 5: N8N Workflow Setup (Optional)

The `Backend/` folder contains an N8N workflow file for automation:
- `Ceipal_Call_Analysis_Backend_Demo (2).json` - Import this into N8N for automated workflows

To use:
1. Install N8N locally or use N8N cloud
2. Import the workflow file
3. Configure credentials and endpoints
4. Activate the workflow

### Step 6: Deploy Edge Functions

```bash
# Install Supabase CLI
npm install -g supabase

# Login to Supabase
supabase login

# Link your project
supabase link --project-ref your-project-ref

# Deploy functions
supabase functions deploy generate-project-embedding
supabase functions deploy match-documents
supabase functions deploy regenerate-embeddings
supabase functions deploy regenerate-project-embeddings
```

### Step 7: Start Development Server

```bash
npm run dev
```

The application will be available at `http://localhost:3000`

---

## 📖 Usage Guide

### Getting Started

1. **Sign Up / Sign In**
   - Create an account or sign in with Google
   - Complete the onboarding flow

2. **Upload Your First Recording**
   - Click "Add Recording" from the dashboard
   - Select an audio file or drag & drop
   - Optionally associate with a lead
   - Wait for AI analysis (2-5 minutes)

3. **Review Analysis Results**
   - View sentiment scores and trends
   - Read AI-generated summaries
   - Check objection detection
   - Review improvement suggestions

4. **Manage Leads**
   - Navigate to "Leads" tab
   - Import leads via CSV or add manually
   - Organize into groups
   - Track lead status and history

5. **Build Your Company Brain**
   - Go to "Company Brain" section
   - Fill in company information
   - Upload relevant documents
   - Enable AI-powered context in analysis

6. **Create Projects**
   - Navigate to "Projects"
   - Create a new project
   - Add project metadata and documents
   - Use for client-specific work

---

## 📂 Project Structure

```
Sales-Call-Analysis/
├── Backend/                # Backend resources
│   ├── schema.sql         # Complete database schema (tables, functions, triggers, indexes)
│   ├── data.sql           # Sample data inserts
│   └── Ceipal_Call_Analysis_Backend_Demo (2).json  # N8N workflow
├── src/
│   ├── components/          # React components
│   │   ├── ui/             # shadcn/ui components
│   │   ├── Dashboard.tsx   # Main dashboard
│   │   ├── LandingPage.tsx # Landing page
│   │   ├── BrainPage.tsx   # Company brain
│   │   └── ProjectsPage.tsx # Projects management
│   ├── contexts/           # React contexts
│   │   └── AuthContext.tsx # Authentication
│   ├── hooks/              # Custom hooks
│   │   ├── useSupabaseData.ts
│   │   └── useAnalysisNotifications.ts
│   ├── lib/                # Utilities
│   │   ├── supabase.ts     # Supabase client
│   │   ├── embeddings.ts   # AI embeddings
│   │   └── utils.ts        # Helpers
│   ├── pages/              # Page components
│   └── App.tsx             # Root component
├── supabase/
│   ├── functions/          # Edge functions
│   │   ├── generate-project-embedding/
│   │   ├── match-documents/
│   │   └── regenerate-embeddings/
│   └── migrations/         # Database migrations (deprecated - use Backend/schema.sql)
├── Sample Call Transcripts/ # Sample audio transcripts for testing
├── public/                 # Static assets
└── docs/                   # Project documentation

```

---

## 🔑 Key Features in Detail

### AI Analysis Pipeline

1. **Upload** → File stored in Supabase Storage
2. **Transcription** → Audio converted to text via AI
3. **Analysis** → Multiple AI models analyze:
   - Sentiment and emotion
   - Engagement patterns
   - Speaker confidence
   - Objections and handling
   - Call outcomes
4. **Embeddings** → Semantic vectors generated for search
5. **Results** → Dashboard displays insights

### Semantic Search

- Uses Google Gemini embeddings (text-embedding-004)
- Vector similarity search in PostgreSQL
- Searches across:
  - Call transcripts
  - Company documents
  - Project knowledge bases
- Context-aware results

---

## 🎨 Customization

### Branding
- Logo: TrendingUp icon with gradient (see `LandingPage.tsx`)
- Colors: Defined in `tailwind.config.ts`
- Theme: Customizable in `src/index.css`

### Analysis Prompts
- Modify AI behavior in edge functions
- Customize analysis criteria
- Add custom metrics

---

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

---

## 📄 License

This project is private and proprietary.

---

## 🆘 Support

For issues or questions:
- Check existing documentation
- Review sample call transcripts in `Sample Call Transcripts/`
- Open an issue on GitHub

---

## 🌟 Roadmap

- [ ] Real-time call analysis
- [ ] Mobile app
- [ ] Advanced analytics & reporting
- [ ] Team collaboration features
- [ ] Integration with CRMs (Salesforce, HubSpot)
- [ ] Custom AI model training
- [ ] Multi-language support
- [ ] API for third-party integrations

---

**Built with ❤️ using AI-powered technologies**

*GrowthLens - Transform conversations into growth*

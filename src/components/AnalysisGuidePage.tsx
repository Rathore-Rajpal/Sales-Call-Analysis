import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Accordion, AccordionContent, AccordionItem, AccordionTrigger } from "@/components/ui/accordion";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import Footer from "./Footer";
import { 
  ArrowLeft, 
  Upload, 
  Bot, 
  BarChart3, 
  Brain, 
  Zap, 
  Target, 
  TrendingUp,
  MessageSquare,
  Users,
  AlertTriangle,
  CheckCircle2,
  Clock,
  DollarSign,
  FileText,
  Network,
  Sparkles,
  Building2
} from "lucide-react";

interface AnalysisGuidePageProps {
  onBack: () => void;
}

export default function AnalysisGuidePage({ onBack }: AnalysisGuidePageProps) {
  return (
    <div className="min-h-screen bg-gradient-to-br from-background via-background to-muted/20">
      {/* Header */}
      <header className="border-b border-border bg-card px-8 py-5 sticky top-0 z-50 backdrop-blur-lg bg-card/95">
        <div className="flex items-center justify-between max-w-7xl mx-auto">
          <div className="flex items-center space-x-6">
            <div className="flex items-center gap-3">
              <div className="bg-gradient-to-br from-primary to-accent-blue p-2 rounded-lg shadow-lg">
                <TrendingUp className="h-6 w-6 text-white" />
              </div>
              <div>
                <h1 className="text-xl font-semibold bg-gradient-to-r from-primary to-accent-blue bg-clip-text text-transparent tracking-wide">GrowthLens</h1>
                <p className="text-xs text-muted-foreground">AI Powered. Growth Driven.</p>
              </div>
            </div>
          </div>
          <Button variant="ghost" onClick={onBack} className="flex items-center gap-2">
            <ArrowLeft className="h-4 w-4" />
            Back to Dashboard
          </Button>
        </div>
      </header>

      <div className="container mx-auto p-8 max-w-7xl">
        {/* Hero Section */}
        <div className="mb-12 text-center">
          <Badge className="mb-4 bg-primary/10 text-primary border-primary/20">Analysis Guide</Badge>
          <h1 className="text-5xl font-bold mb-4 bg-gradient-to-r from-primary via-accent-blue to-primary bg-clip-text text-transparent">
            How GrowthLens AI Analysis Works
          </h1>
          <p className="text-xl text-muted-foreground max-w-3xl mx-auto">
            Understanding the AI-powered analysis pipeline, metrics, and how to leverage insights for sales growth
          </p>
        </div>

        <Tabs defaultValue="overview" className="space-y-8">
          <TabsList className="grid w-full grid-cols-5 lg:w-auto lg:inline-grid">
            <TabsTrigger value="overview">Overview</TabsTrigger>
            <TabsTrigger value="upload">Upload Process</TabsTrigger>
            <TabsTrigger value="metrics">Analysis Metrics</TabsTrigger>
            <TabsTrigger value="embeddings">AI Embeddings</TabsTrigger>
            <TabsTrigger value="workflow">Complete Workflow</TabsTrigger>
          </TabsList>

          {/* Overview Tab */}
          <TabsContent value="overview" className="space-y-8">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Sparkles className="h-5 w-5 text-primary" />
                  What is GrowthLens?
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <p className="text-muted-foreground leading-relaxed">
                  GrowthLens is an AI-powered sales call analysis platform that transforms conversations into actionable insights. 
                  By analyzing call recordings and transcripts, it provides deep understanding of:
                </p>
                <div className="grid md:grid-cols-2 gap-4">
                  <div className="flex gap-3 p-4 border rounded-lg">
                    <MessageSquare className="h-5 w-5 text-primary flex-shrink-0 mt-0.5" />
                    <div>
                      <h4 className="font-semibold mb-1">Deal Quality</h4>
                      <p className="text-sm text-muted-foreground">How serious and ready is the prospect</p>
                    </div>
                  </div>
                  <div className="flex gap-3 p-4 border rounded-lg">
                    <Users className="h-5 w-5 text-accent-blue flex-shrink-0 mt-0.5" />
                    <div>
                      <h4 className="font-semibold mb-1">Prospect Psychology</h4>
                      <p className="text-sm text-muted-foreground">Trust levels, confidence, and intent signals</p>
                    </div>
                  </div>
                  <div className="flex gap-3 p-4 border rounded-lg">
                    <AlertTriangle className="h-5 w-5 text-warning flex-shrink-0 mt-0.5" />
                    <div>
                      <h4 className="font-semibold mb-1">Objections</h4>
                      <p className="text-sm text-muted-foreground">Detected objections and handling effectiveness</p>
                    </div>
                  </div>
                  <div className="flex gap-3 p-4 border rounded-lg">
                    <Target className="h-5 w-5 text-success flex-shrink-0 mt-0.5" />
                    <div>
                      <h4 className="font-semibold mb-1">Next Steps</h4>
                      <p className="text-sm text-muted-foreground">Clear action items and improvement areas</p>
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Brain className="h-5 w-5 text-accent-blue" />
                  Key Analysis Objectives
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-6">
                  <div>
                    <h4 className="font-semibold mb-3 text-lg">The AI Analysis Helps Answer:</h4>
                    <div className="grid gap-3">
                      {[
                        "How serious is the prospect right now?",
                        "Is trust being built or eroded during the call?",
                        "Are objections clearly surfaced or hidden?",
                        "Did the representative leave with one clear next step?",
                        "Is this deal progressing, stalling, or quietly decaying?",
                        "What should the representative improve in the very next call?"
                      ].map((question, idx) => (
                        <div key={idx} className="flex items-start gap-3 p-3 bg-muted/50 rounded-lg">
                          <CheckCircle2 className="h-5 w-5 text-success flex-shrink-0 mt-0.5" />
                          <p className="text-sm">{question}</p>
                        </div>
                      ))}
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          {/* Upload Process Tab */}
          <TabsContent value="upload" className="space-y-8">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Upload className="h-5 w-5 text-primary" />
                  How to Upload Call Recordings
                </CardTitle>
                <CardDescription>Step-by-step guide to adding recordings for analysis</CardDescription>
              </CardHeader>
              <CardContent className="space-y-6">
                <div className="space-y-4">
                  {[
                    {
                      step: 1,
                      title: "Navigate to Dashboard",
                      description: "Go to the main dashboard and click the 'Add Recording' button",
                      icon: <BarChart3 className="h-5 w-5" />
                    },
                    {
                      step: 2,
                      title: "Upload Audio File or Transcript",
                      description: "You can either upload an audio file (MP3, WAV, M4A, OGG) or paste a transcript directly. Supported file size: up to 100MB",
                      icon: <FileText className="h-5 w-5" />
                    },
                    {
                      step: 3,
                      title: "Associate with Lead (Optional)",
                      description: "Link the recording to an existing lead for better context and tracking",
                      icon: <Users className="h-5 w-5" />
                    },
                    {
                      step: 4,
                      title: "AI Processing Begins",
                      description: "The system automatically transcribes audio (if needed) and runs AI analysis. This typically takes 2-5 minutes",
                      icon: <Bot className="h-5 w-5" />
                    },
                    {
                      step: 5,
                      title: "Review Analysis Results",
                      description: "Once complete, view detailed metrics, scores, insights, and recommendations",
                      icon: <BarChart3 className="h-5 w-5" />
                    }
                  ].map((item) => (
                    <div key={item.step} className="flex gap-4 p-4 border rounded-lg hover:border-primary/50 transition-colors">
                      <div className="flex-shrink-0">
                        <div className="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center text-primary font-bold">
                          {item.step}
                        </div>
                      </div>
                      <div className="flex-1">
                        <div className="flex items-center gap-2 mb-1">
                          <span className="text-primary">{item.icon}</span>
                          <h4 className="font-semibold">{item.title}</h4>
                        </div>
                        <p className="text-sm text-muted-foreground">{item.description}</p>
                      </div>
                    </div>
                  ))}
                </div>

                <div className="bg-accent-blue/10 border border-accent-blue/20 rounded-lg p-4">
                  <div className="flex gap-3">
                    <Zap className="h-5 w-5 text-accent-blue flex-shrink-0 mt-0.5" />
                    <div>
                      <h4 className="font-semibold text-accent-blue mb-1">Pro Tip</h4>
                      <p className="text-sm text-muted-foreground">
                        For best results, ensure audio recordings have clear audio with minimal background noise. 
                        If pasting transcripts, include speaker labels (e.g., "Agent:", "Prospect:") for more accurate analysis.
                      </p>
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          {/* Analysis Metrics Tab */}
          <TabsContent value="metrics" className="space-y-8">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <BarChart3 className="h-5 w-5 text-primary" />
                  Understanding Analysis Metrics
                </CardTitle>
                <CardDescription>Detailed explanation of each metric and how it's calculated</CardDescription>
              </CardHeader>
              <CardContent>
                <Accordion type="single" collapsible className="w-full">
                  <AccordionItem value="lead-type">
                    <AccordionTrigger className="text-left">
                      <div className="flex items-center gap-2">
                        <Target className="h-4 w-4 text-primary" />
                        <span>Lead Type Classification (Hot/Warm/Cold)</span>
                      </div>
                    </AccordionTrigger>
                    <AccordionContent className="space-y-4">
                      <p className="text-muted-foreground">
                        The AI classifies leads into four categories based on buying signals, engagement level, and readiness to purchase:
                      </p>
                      <div className="space-y-3">
                        <div className="p-4 border-l-4 border-l-red-500 bg-red-500/5 rounded">
                          <h5 className="font-semibold mb-2">🔥 Hot Lead</h5>
                          <ul className="text-sm text-muted-foreground space-y-1 list-disc list-inside">
                            <li>Clear budget allocated or approved</li>
                            <li>Defined timeline (days/weeks, not months)</li>
                            <li>Willingness to schedule product demo or trial</li>
                            <li>Decision-maker actively engaged</li>
                            <li>Prospect language indicates near-purchase readiness</li>
                          </ul>
                        </div>
                        <div className="p-4 border-l-4 border-l-orange-500 bg-orange-500/5 rounded">
                          <h5 className="font-semibold mb-2">🌡️ Warm Lead</h5>
                          <ul className="text-sm text-muted-foreground space-y-1 list-disc list-inside">
                            <li>Genuine interest in platform capabilities</li>
                            <li>Asking detailed questions (pricing, features, ROI)</li>
                            <li>Timeline exists but flexible (quarters)</li>
                            <li>Objections discussed openly</li>
                            <li>Willingness to involve stakeholders</li>
                          </ul>
                        </div>
                        <div className="p-4 border-l-4 border-l-blue-500 bg-blue-500/5 rounded">
                          <h5 className="font-semibold mb-2">❄️ Warm-Cold (In-Between)</h5>
                          <ul className="text-sm text-muted-foreground space-y-1 list-disc list-inside">
                            <li>Polite but avoids commitment</li>
                            <li>Exploratory language ("just checking", "gathering info")</li>
                            <li>No urgency or locked next step</li>
                            <li>Timeline vague or "future consideration"</li>
                          </ul>
                        </div>
                        <div className="p-4 border-l-4 border-l-gray-500 bg-gray-500/5 rounded">
                          <h5 className="font-semibold mb-2">🧊 Cold Lead</h5>
                          <ul className="text-sm text-muted-foreground space-y-1 list-disc list-inside">
                            <li>Minimal engagement or rushed tone</li>
                            <li>Avoidance behavior ("send me info", "call later")</li>
                            <li>No budget or timeline clarity</li>
                            <li>Not the decision-maker</li>
                          </ul>
                        </div>
                      </div>
                    </AccordionContent>
                  </AccordionItem>

                  <AccordionItem value="sentiment">
                    <AccordionTrigger className="text-left">
                      <div className="flex items-center gap-2">
                        <MessageSquare className="h-4 w-4 text-accent-blue" />
                        <span>Sentiment Score (0-100)</span>
                      </div>
                    </AccordionTrigger>
                    <AccordionContent className="space-y-3">
                      <p className="text-muted-foreground">
                        Measures the overall emotional tone and attitude of the prospect during the call.
                      </p>
                      <div className="space-y-2">
                        <div className="flex justify-between items-center p-2 bg-success/10 rounded">
                          <span className="text-sm font-medium">80-100: Positive & Collaborative</span>
                          <Badge variant="outline" className="bg-success/20 text-success border-success">Excellent</Badge>
                        </div>
                        <div className="flex justify-between items-center p-2 bg-primary/10 rounded">
                          <span className="text-sm font-medium">60-79: Interested & Engaged</span>
                          <Badge variant="outline" className="bg-primary/20 text-primary border-primary">Good</Badge>
                        </div>
                        <div className="flex justify-between items-center p-2 bg-warning/10 rounded">
                          <span className="text-sm font-medium">40-59: Neutral or Guarded</span>
                          <Badge variant="outline" className="bg-warning/20 text-warning border-warning">Fair</Badge>
                        </div>
                        <div className="flex justify-between items-center p-2 bg-destructive/10 rounded">
                          <span className="text-sm font-medium">0-39: Skeptical or Dismissive</span>
                          <Badge variant="outline" className="bg-destructive/20 text-destructive border-destructive">Poor</Badge>
                        </div>
                      </div>
                      <p className="text-sm text-muted-foreground italic mt-3">
                        Higher scores indicate calm, curious, and collaborative tone. Lower scores suggest hesitation, skepticism, or rushed behavior.
                      </p>
                    </AccordionContent>
                  </AccordionItem>

                  <AccordionItem value="engagement">
                    <AccordionTrigger className="text-left">
                      <div className="flex items-center gap-2">
                        <Users className="h-4 w-4 text-primary" />
                        <span>Engagement Score (0-100)</span>
                      </div>
                    </AccordionTrigger>
                    <AccordionContent className="space-y-3">
                      <p className="text-muted-foreground">
                        Evaluates how actively involved and interested the prospect was during the conversation.
                      </p>
                      <h5 className="font-semibold mt-4">Evaluation Criteria:</h5>
                      <ul className="space-y-2 text-sm text-muted-foreground">
                        <li className="flex gap-2">
                          <CheckCircle2 className="h-4 w-4 text-success flex-shrink-0 mt-0.5" />
                          <span>Number and quality of questions asked about features, pricing, implementation</span>
                        </li>
                        <li className="flex gap-2">
                          <CheckCircle2 className="h-4 w-4 text-success flex-shrink-0 mt-0.5" />
                          <span>Responsiveness and natural conversation flow</span>
                        </li>
                        <li className="flex gap-2">
                          <CheckCircle2 className="h-4 w-4 text-success flex-shrink-0 mt-0.5" />
                          <span>Depth of technical or business discussion</span>
                        </li>
                        <li className="flex gap-2">
                          <CheckCircle2 className="h-4 w-4 text-success flex-shrink-0 mt-0.5" />
                          <span>Willingness to schedule follow-ups or demos</span>
                        </li>
                        <li className="flex gap-2">
                          <CheckCircle2 className="h-4 w-4 text-success flex-shrink-0 mt-0.5" />
                          <span>Discussion of specific use cases and needs</span>
                        </li>
                      </ul>
                      <div className="bg-accent-blue/10 border border-accent-blue/20 rounded p-3 mt-3">
                        <p className="text-sm text-accent-blue font-medium">
                          Note: Engagement is NOT based solely on call duration. A shorter, focused call with high-quality questions scores higher than a long, superficial conversation.
                        </p>
                      </div>
                    </AccordionContent>
                  </AccordionItem>

                  <AccordionItem value="confidence">
                    <AccordionTrigger className="text-left">
                      <div className="flex items-center gap-2">
                        <TrendingUp className="h-4 w-4 text-success" />
                        <span>Confidence Scores (1-10)</span>
                      </div>
                    </AccordionTrigger>
                    <AccordionContent className="space-y-4">
                      <p className="text-muted-foreground">
                        Two separate confidence metrics provide different perspectives on deal viability:
                      </p>
                      <div className="grid md:grid-cols-2 gap-4">
                        <div className="p-4 border rounded-lg">
                          <h5 className="font-semibold mb-2 flex items-center gap-2">
                            <DollarSign className="h-4 w-4 text-primary" />
                            Executive Confidence (1-10)
                          </h5>
                          <p className="text-sm text-muted-foreground mb-3">
                            How confident leadership would be in pushing this deal forward
                          </p>
                          <ul className="text-xs space-y-1.5 text-muted-foreground">
                            <li>• Prospect seriousness & authority</li>
                            <li>• Deal value and strategic fit</li>
                            <li>• Clarity of next steps</li>
                            <li>• Risk assessment</li>
                            <li>• Ability to address needs</li>
                          </ul>
                        </div>
                        <div className="p-4 border rounded-lg">
                          <h5 className="font-semibold mb-2 flex items-center gap-2">
                            <Target className="h-4 w-4 text-accent-blue" />
                            Prospect Confidence (1-10)
                          </h5>
                          <p className="text-sm text-muted-foreground mb-3">
                            How likely the prospect will realistically move forward
                          </p>
                          <ul className="text-xs space-y-1.5 text-muted-foreground">
                            <li>• Budget comfort & approval path</li>
                            <li>• Timeline specificity</li>
                            <li>• Willingness for demo/trial</li>
                            <li>• Reduced objections</li>
                            <li>• Champion identification</li>
                          </ul>
                        </div>
                      </div>
                    </AccordionContent>
                  </AccordionItem>

                  <AccordionItem value="objections">
                    <AccordionTrigger className="text-left">
                      <div className="flex items-center gap-2">
                        <AlertTriangle className="h-4 w-4 text-warning" />
                        <span>Objections Detection & Handling</span>
                      </div>
                    </AccordionTrigger>
                    <AccordionContent className="space-y-4">
                      <p className="text-muted-foreground">
                        The AI identifies and analyzes objections raised during the call and evaluates how well they were addressed.
                      </p>
                      <div className="space-y-3">
                        <div>
                          <h5 className="font-semibold mb-2">Common Objection Types:</h5>
                          <div className="grid sm:grid-cols-2 gap-2">
                            {[
                              "Pricing concerns",
                              "Implementation timeline",
                              "Feature gaps",
                              "Competitor comparison",
                              "Integration challenges",
                              "Change management",
                              "ROI uncertainty",
                              "Budget approval"
                            ].map((obj, idx) => (
                              <div key={idx} className="text-sm p-2 bg-muted/50 rounded flex items-center gap-2">
                                <div className="w-1.5 h-1.5 rounded-full bg-warning"></div>
                                {obj}
                              </div>
                            ))}
                          </div>
                        </div>
                        <div>
                          <h5 className="font-semibold mb-2">Handling Evaluation:</h5>
                          <p className="text-sm text-muted-foreground mb-2">
                            The system analyzes whether objections were:
                          </p>
                          <ul className="text-sm space-y-1.5 text-muted-foreground">
                            <li className="flex gap-2">
                              <span className="text-success">✓</span>
                              <span>Acknowledged and addressed directly</span>
                            </li>
                            <li className="flex gap-2">
                              <span className="text-warning">⚠</span>
                              <span>Partially addressed or deflected</span>
                            </li>
                            <li className="flex gap-2">
                              <span className="text-destructive">✗</span>
                              <span>Ignored or avoided</span>
                            </li>
                          </ul>
                        </div>
                      </div>
                    </AccordionContent>
                  </AccordionItem>

                  <AccordionItem value="next-steps">
                    <AccordionTrigger className="text-left">
                      <div className="flex items-center gap-2">
                        <Clock className="h-4 w-4 text-primary" />
                        <span>Next Steps & Improvements</span>
                      </div>
                    </AccordionTrigger>
                    <AccordionContent className="space-y-3">
                      <p className="text-muted-foreground">
                        The AI identifies agreed-upon next steps and provides actionable improvement recommendations for the sales representative.
                      </p>
                      <div className="space-y-3">
                        <div className="p-4 bg-success/10 border border-success/20 rounded-lg">
                          <h5 className="font-semibold text-success mb-2">Next Steps Analysis</h5>
                          <p className="text-sm text-muted-foreground">
                            Extracts concrete action items like scheduled demos, follow-up calls, stakeholder meetings, 
                            proposal submissions, or trial sign-ups. Clear next steps indicate deal progression.
                          </p>
                        </div>
                        <div className="p-4 bg-primary/10 border border-primary/20 rounded-lg">
                          <h5 className="font-semibold text-primary mb-2">Improvement Recommendations</h5>
                          <p className="text-sm text-muted-foreground">
                            AI suggests ONE specific, actionable improvement the representative should implement 
                            in their next call based on gaps identified in this conversation.
                          </p>
                        </div>
                      </div>
                    </AccordionContent>
                  </AccordionItem>

                  <AccordionItem value="company-accuracy">
                    <AccordionTrigger className="text-left">
                      <div className="flex items-center gap-2">
                        <Building2 className="h-4 w-4 text-accent-blue" />
                        <span>Company Context Accuracy (0-100)</span>
                      </div>
                    </AccordionTrigger>
                    <AccordionContent className="space-y-3">
                      <p className="text-muted-foreground">
                        Measures how accurately the sales representative represented GrowthLens company information, 
                        products, features, integrations, and capabilities during the call.
                      </p>
                      <div className="space-y-2">
                        <div className="flex justify-between items-center p-2 bg-success/10 rounded">
                          <span className="text-sm font-medium">90-100: Fully Accurate</span>
                          <Badge variant="outline" className="bg-success/20 text-success border-success">Excellent</Badge>
                        </div>
                        <div className="flex justify-between items-center p-2 bg-primary/10 rounded">
                          <span className="text-sm font-medium">70-89: Mostly Accurate</span>
                          <Badge variant="outline" className="bg-primary/20 text-primary border-primary">Good</Badge>
                        </div>
                        <div className="flex justify-between items-center p-2 bg-warning/10 rounded">
                          <span className="text-sm font-medium">50-69: Some Inaccuracies</span>
                          <Badge variant="outline" className="bg-warning/20 text-warning border-warning">Needs Review</Badge>
                        </div>
                        <div className="flex justify-between items-center p-2 bg-destructive/10 rounded">
                          <span className="text-sm font-medium">0-49: Major Misrepresentation</span>
                          <Badge variant="outline" className="bg-destructive/20 text-destructive border-destructive">Critical</Badge>
                        </div>
                      </div>
                      <div className="bg-accent-blue/10 border border-accent-blue/20 rounded p-3 mt-3">
                        <h5 className="font-semibold text-sm mb-2">Verification Process:</h5>
                        <ul className="text-sm space-y-1.5 text-muted-foreground">
                          <li className="flex gap-2">
                            <CheckCircle2 className="h-4 w-4 text-accent-blue flex-shrink-0 mt-0.5" />
                            <span>AI cross-references claims against Company Knowledge Base</span>
                          </li>
                          <li className="flex gap-2">
                            <CheckCircle2 className="h-4 w-4 text-accent-blue flex-shrink-0 mt-0.5" />
                            <span>Verifies feature capabilities, integrations, and pricing claims</span>
                          </li>
                          <li className="flex gap-2">
                            <CheckCircle2 className="h-4 w-4 text-accent-blue flex-shrink-0 mt-0.5" />
                            <span>Flags exaggerations, unverified claims, or outdated information</span>
                          </li>
                        </ul>
                      </div>
                    </AccordionContent>
                  </AccordionItem>

                  <AccordionItem value="project-accuracy">
                    <AccordionTrigger className="text-left">
                      <div className="flex items-center gap-2">
                        <FileText className="h-4 w-4 text-primary" />
                        <span>Project Context Accuracy (0-100)</span>
                      </div>
                    </AccordionTrigger>
                    <AccordionContent className="space-y-3">
                      <p className="text-muted-foreground">
                        Evaluates accuracy of project-specific statements, implementation details, timelines, 
                        and technical specifications mentioned during the call.
                      </p>
                      <div className="space-y-2">
                        <div className="flex justify-between items-center p-2 bg-success/10 rounded">
                          <span className="text-sm font-medium">90-100: Project Details Accurate</span>
                          <Badge variant="outline" className="bg-success/20 text-success border-success">Excellent</Badge>
                        </div>
                        <div className="flex justify-between items-center p-2 bg-primary/10 rounded">
                          <span className="text-sm font-medium">70-89: Minor Contextual Gaps</span>
                          <Badge variant="outline" className="bg-primary/20 text-primary border-primary">Good</Badge>
                        </div>
                        <div className="flex justify-between items-center p-2 bg-warning/10 rounded">
                          <span className="text-sm font-medium">50-69: Several Incorrect Facts</span>
                          <Badge variant="outline" className="bg-warning/20 text-warning border-warning">Requires Correction</Badge>
                        </div>
                        <div className="flex justify-between items-center p-2 bg-destructive/10 rounded">
                          <span className="text-sm font-medium">0-49: Major Factual Errors</span>
                          <Badge variant="outline" className="bg-destructive/20 text-destructive border-destructive">Critical</Badge>
                        </div>
                      </div>
                      <div className="bg-primary/10 border border-primary/20 rounded p-3 mt-3">
                        <h5 className="font-semibold text-sm mb-2">What Gets Verified:</h5>
                        <ul className="text-sm space-y-1.5 text-muted-foreground">
                          <li className="flex gap-2">
                            <CheckCircle2 className="h-4 w-4 text-primary flex-shrink-0 mt-0.5" />
                            <span>Project-specific integrations and technical capabilities</span>
                          </li>
                          <li className="flex gap-2">
                            <CheckCircle2 className="h-4 w-4 text-primary flex-shrink-0 mt-0.5" />
                            <span>Implementation timelines and resource requirements</span>
                          </li>
                          <li className="flex gap-2">
                            <CheckCircle2 className="h-4 w-4 text-primary flex-shrink-0 mt-0.5" />
                            <span>Custom features and project documentation claims</span>
                          </li>
                          <li className="flex gap-2">
                            <CheckCircle2 className="h-4 w-4 text-primary flex-shrink-0 mt-0.5" />
                            <span>ROI estimates and success metrics referenced</span>
                          </li>
                        </ul>
                      </div>
                    </AccordionContent>
                  </AccordionItem>
                </Accordion>
              </CardContent>
            </Card>
          </TabsContent>

          {/* AI Embeddings Tab */}
          <TabsContent value="embeddings" className="space-y-8">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Network className="h-5 w-5 text-accent-blue" />
                  How AI Embeddings Power Analysis
                </CardTitle>
                <CardDescription>Understanding the semantic search and context retrieval system</CardDescription>
              </CardHeader>
              <CardContent className="space-y-6">
                <div>
                  <h4 className="font-semibold text-lg mb-3">What Are Embeddings?</h4>
                  <p className="text-muted-foreground mb-4">
                    Embeddings are AI-generated vector representations of text that capture semantic meaning. 
                    Think of them as coordinates in a high-dimensional space where similar concepts are close together.
                  </p>
                  <div className="bg-accent-blue/10 border border-accent-blue/20 rounded-lg p-4">
                    <p className="text-sm text-muted-foreground">
                      For example, "ATS software" and "applicant tracking system" would have embeddings very close 
                      together, even though the exact words are different. This enables smart semantic search.
                    </p>
                  </div>
                </div>

                <div className="space-y-4">
                  <h4 className="font-semibold text-lg">How GrowthLens Uses Embeddings:</h4>
                  
                  <div className="grid gap-4">
                    <div className="p-4 border rounded-lg">
                      <div className="flex items-start gap-3 mb-2">
                        <Brain className="h-5 w-5 text-primary flex-shrink-0 mt-0.5" />
                        <div>
                          <h5 className="font-semibold">Company Knowledge Base</h5>
                          <p className="text-sm text-muted-foreground mt-1">
                            All company information and uploaded documents are converted into embeddings. When analyzing 
                            a call, the AI searches for relevant company context to verify factual accuracy.
                          </p>
                        </div>
                      </div>
                      <div className="mt-3 pl-8 space-y-1.5 text-sm text-muted-foreground">
                        <div className="flex gap-2">
                          <span className="text-success">→</span>
                          <span>Verifies product features mentioned in call</span>
                        </div>
                        <div className="flex gap-2">
                          <span className="text-success">→</span>
                          <span>Checks pricing and plan details</span>
                        </div>
                        <div className="flex gap-2">
                          <span className="text-success">→</span>
                          <span>Confirms integration capabilities</span>
                        </div>
                      </div>
                    </div>

                    <div className="p-4 border rounded-lg">
                      <div className="flex items-start gap-3 mb-2">
                        <FileText className="h-5 w-5 text-accent-blue flex-shrink-0 mt-0.5" />
                        <div>
                          <h5 className="font-semibold">Project Knowledge Base</h5>
                          <p className="text-sm text-muted-foreground mt-1">
                            Project-specific documents and metadata are embedded separately. The AI automatically 
                            discovers which project is being discussed and retrieves relevant context.
                          </p>
                        </div>
                      </div>
                      <div className="mt-3 pl-8 space-y-1.5 text-sm text-muted-foreground">
                        <div className="flex gap-2">
                          <span className="text-success">→</span>
                          <span>Identifies mentioned projects from transcript</span>
                        </div>
                        <div className="flex gap-2">
                          <span className="text-success">→</span>
                          <span>Fetches project-specific details and documents</span>
                        </div>
                        <div className="flex gap-2">
                          <span className="text-success">→</span>
                          <span>Validates project claims made during call</span>
                        </div>
                      </div>
                    </div>

                    <div className="p-4 border rounded-lg">
                      <div className="flex items-start gap-3 mb-2">
                        <Sparkles className="h-5 w-5 text-success flex-shrink-0 mt-0.5" />
                        <div>
                          <h5 className="font-semibold">Call Transcript Embeddings</h5>
                          <p className="text-sm text-muted-foreground mt-1">
                            Each transcript is embedded to enable semantic search across all your calls. Find similar 
                            conversations, patterns, and insights even when exact keywords differ.
                          </p>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <div className="bg-muted/50 rounded-lg p-6">
                  <h4 className="font-semibold mb-3 flex items-center gap-2">
                    <Zap className="h-5 w-5 text-warning" />
                    Technical Details
                  </h4>
                  <div className="space-y-2 text-sm text-muted-foreground">
                    <div className="flex justify-between py-2 border-b border-border">
                      <span className="font-medium">Embedding Model:</span>
                      <span>Google Gemini text-embedding-004</span>
                    </div>
                    <div className="flex justify-between py-2 border-b border-border">
                      <span className="font-medium">Vector Dimensions:</span>
                      <span>768 dimensions</span>
                    </div>
                    <div className="flex justify-between py-2 border-b border-border">
                      <span className="font-medium">Similarity Metric:</span>
                      <span>Cosine similarity</span>
                    </div>
                    <div className="flex justify-between py-2">
                      <span className="font-medium">Search Method:</span>
                      <span>Vector similarity search (PostgreSQL pgvector)</span>
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          {/* Complete Workflow Tab */}
          <TabsContent value="workflow" className="space-y-8">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Zap className="h-5 w-5 text-primary" />
                  Complete AI Analysis Pipeline
                </CardTitle>
                <CardDescription>End-to-end workflow from upload to insights</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-6">
                  {[
                    {
                      step: 1,
                      title: "Upload & Storage",
                      description: "Audio file uploaded to secure Supabase Storage. System validates file format and size.",
                      tech: "Supabase Storage, File validation",
                      icon: <Upload className="h-5 w-5" />,
                      color: "primary"
                    },
                    {
                      step: 2,
                      title: "Transcription",
                      description: "If audio file provided, Google Gemini 2.0 Flash converts speech to text with speaker identification.",
                      tech: "Google Gemini 2.0 Flash API, Audio transcription",
                      icon: <FileText className="h-5 w-5" />,
                      color: "accent-blue"
                    },
                    {
                      step: 3,
                      title: "Context Discovery",
                      description: "AI Agent searches Company Brain and Project embeddings to find relevant background information.",
                      tech: "Vector similarity search, Supabase pgvector",
                      icon: <Brain className="h-5 w-5" />,
                      color: "success"
                    },
                    {
                      step: 4,
                      title: "AI Analysis",
                      description: "Google Gemini 2.5 Pro analyzes transcript with retrieved context. Evaluates sentiment, engagement, objections, confidence, and generates insights.",
                      tech: "Google Gemini 2.5 Pro, n8n workflow orchestration",
                      icon: <Bot className="h-5 w-5" />,
                      color: "warning"
                    },
                    {
                      step: 5,
                      title: "Factual Verification",
                      description: "AI cross-references claims made during call against Company and Project knowledge bases. Scores accuracy.",
                      tech: "Semantic search, fact-checking algorithms",
                      icon: <CheckCircle2 className="h-5 w-5" />,
                      color: "primary"
                    },
                    {
                      step: 6,
                      title: "Embedding Generation",
                      description: "Transcript converted to semantic embeddings for future search and pattern analysis.",
                      tech: "Google Gemini text-embedding-004",
                      icon: <Network className="h-5 w-5" />,
                      color: "accent-blue"
                    },
                    {
                      step: 7,
                      title: "Results Storage & Display",
                      description: "All metrics, scores, and insights saved to database. Real-time dashboard updates with analysis results.",
                      tech: "Supabase PostgreSQL, Real-time subscriptions",
                      icon: <BarChart3 className="h-5 w-5" />,
                      color: "success"
                    }
                  ].map((item) => (
                    <div key={item.step} className="relative">
                      {item.step < 7 && (
                        <div className={`absolute left-5 top-14 bottom-0 w-0.5 bg-gradient-to-b from-${item.color} to-transparent`}></div>
                      )}
                      <div className="flex gap-4">
                        <div className={`flex-shrink-0 w-10 h-10 rounded-full bg-${item.color}/10 flex items-center justify-center text-${item.color} font-bold border-2 border-${item.color}/20 relative z-10`}>
                          {item.step}
                        </div>
                        <div className="flex-1 pb-8">
                          <div className="flex items-center gap-2 mb-2">
                            <span className={`text-${item.color}`}>{item.icon}</span>
                            <h4 className="font-semibold text-lg">{item.title}</h4>
                          </div>
                          <p className="text-muted-foreground mb-2">{item.description}</p>
                          <div className="inline-flex items-center gap-2 text-xs text-muted-foreground bg-muted/50 px-3 py-1.5 rounded-full">
                            <Zap className="h-3 w-3" />
                            <span>{item.tech}</span>
                          </div>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>

                <div className="mt-8 p-6 bg-gradient-to-r from-primary/10 via-accent-blue/10 to-success/10 border border-primary/20 rounded-lg">
                  <h4 className="font-semibold mb-3 text-lg">Processing Time</h4>
                  <div className="grid sm:grid-cols-3 gap-4">
                    <div class     Name="text-center p-3 bg-background/50 rounded-lg">
                      <Clock className="h-6 w-6 mx-auto mb-2 text-primary" />
                      <div className="text-2xl font-bold text-primary">30s</div>
                      <div className="text-xs text-muted-foreground mt-1">Transcript Input</div>
                    </div>
                    <div className="text-center p-3 bg-background/50 rounded-lg">
                      <Clock className="h-6 w-6 mx-auto mb-2 text-accent-blue" />
                      <div className="text-2xl font-bold text-accent-blue">2-3 min</div>
                      <div className="text-xs text-muted-foreground mt-1">Short Audio (&lt; 10 min)</div>
                    </div>
                    <div className="text-center p-3 bg-background/50 rounded-lg">
                      <Clock className="h-6 w-6 mx-auto mb-2 text-success" />
                      <div className="text-2xl font-bold text-success">5-8 min</div>
                      <div className="text-xs text-muted-foreground mt-1">Long Audio (&gt; 20 min)</div>
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>

            <Card className="bg-gradient-to-br from-primary/5 to-accent-blue/5 border-primary/20">
              <CardHeader>
                <CardTitle>Backend Architecture</CardTitle>
                <CardDescription>Powered by n8n workflow automation</CardDescription>
              </CardHeader>
              <CardContent>
                <p className="text-muted-foreground mb-4">
                  The entire analysis pipeline runs on n8n, a powerful workflow automation platform. 
                  This enables complex multi-step processing with error handling, retries, and parallel execution.
                </p>
                <div className="space-y-2 text-sm">
                  <div className="flex items-center gap-2 p-2 bg-background/50 rounded">
                    <CheckCircle2 className="h-4 w-4 text-success" />
                    <span>Webhook-triggered execution on recording upload</span>
                  </div>
                  <div className="flex items-center gap-2 p-2 bg-background/50 rounded">
                    <CheckCircle2 className="h-4 w-4 text-success" />
                    <span>Parallel AI agent calls for company & project context</span>
                  </div>
                  <div className="flex items-center gap-2 p-2 bg-background/50 rounded">
                    <CheckCircle2 className="h-4 w-4 text-success" />
                    <span>Error handling with status updates to database</span>
                  </div>
                  <div className="flex items-center gap-2 p-2 bg-background/50 rounded">
                    <CheckCircle2 className="h-4 w-4 text-success" />
                    <span>Retry logic for failed API calls</span>
                  </div>
                </div>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>

        {/* CTA */}
        <Card className="mt-12 bg-gradient-to-r from-primary to-accent-blue text-primary-foreground">
          <CardContent className="p-8 text-center">
            <h3 className="text-2xl font-bold mb-3">Ready to Transform Your Sales Calls?</h3>
            <p className="mb-6 opacity-90">
              Upload your first recording and see the AI-powered insights in action
            </p>
            <Button size="lg" variant="secondary" onClick={onBack}>
              Go to Dashboard
            </Button>
          </CardContent>
        </Card>
      </div>
      <Footer />
    </div>
  );
}

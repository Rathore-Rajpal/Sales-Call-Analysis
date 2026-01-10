import { useState } from "react";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Copy, Upload, Check, FileText } from "lucide-react";
import { useToast } from "@/hooks/use-toast";

interface SampleTranscript {
  id: string;
  title: string;
  description: string;
  transcript: string;
  category: string;
  tags: string[];
  created_at: string;
}

interface SampleTranscriptsModalProps {
  transcript: SampleTranscript | null;
  open: boolean;
  onOpenChange: (open: boolean) => void;
  onUseTranscript?: (transcript: string) => void;
}

export default function SampleTranscriptsModal({ 
  transcript, 
  open, 
  onOpenChange,
  onUseTranscript 
}: SampleTranscriptsModalProps) {
  const [copied, setCopied] = useState(false);
  const { toast } = useToast();

  const handleCopy = () => {
    if (transcript) {
      navigator.clipboard.writeText(transcript.transcript);
      setCopied(true);
      toast({
        title: "Copied!",
        description: "Transcript copied to clipboard",
      });
      setTimeout(() => setCopied(false), 2000);
    }
  };

  const handleUse = () => {
    if (transcript && onUseTranscript) {
      onUseTranscript(transcript.transcript);
      onOpenChange(false);
      toast({
        title: "Transcript Loaded",
        description: "You can now upload this transcript for analysis",
      });
    }
  };

  if (!transcript) return null;

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-4xl max-h-[90vh]">
        <DialogHeader>
          <div className="flex items-start justify-between gap-4">
            <div className="flex-1">
              <DialogTitle className="text-xl mb-2">{transcript.title}</DialogTitle>
              <DialogDescription className="text-sm">
                {transcript.description}
              </DialogDescription>
            </div>
            <div className="flex items-center gap-2">
              <Badge 
                variant="outline" 
                className={
                  transcript.category === 'Hot' ? 'bg-red-500/10 text-red-500 border-red-500/20' :
                  transcript.category === 'Warm' ? 'bg-orange-500/10 text-orange-500 border-orange-500/20' :
                  transcript.category === 'Warm-Cold' ? 'bg-blue-500/10 text-blue-500 border-blue-500/20' :
                  'bg-gray-500/10 text-gray-500 border-gray-500/20'
                }
              >
                {transcript.category}
              </Badge>
              <Button
                variant="outline"
                size="icon"
                onClick={handleCopy}
                title={copied ? "Copied!" : "Copy transcript"}
              >
                {copied ? (
                  <Check className="h-4 w-4 text-success" />
                ) : (
                  <Copy className="h-4 w-4" />
                )}
              </Button>
            </div>
          </div>
          <div className="flex gap-2 flex-wrap mt-2">
            {transcript.tags?.map((tag) => (
              <Badge key={tag} variant="secondary" className="text-xs">
                {tag}
              </Badge>
            ))}
          </div>
        </DialogHeader>

        <ScrollArea className="h-[500px] w-full rounded-md border p-4">
          <pre className="text-sm font-mono whitespace-pre-wrap leading-relaxed">
            {transcript.transcript}
          </pre>
        </ScrollArea>

        <div className="flex items-center justify-between gap-3 pt-4 border-t">
          <div className="flex items-center gap-2 text-xs text-muted-foreground">
            <FileText className="h-3 w-3" />
            <span>{transcript.transcript.length.toLocaleString()} characters</span>
          </div>
          <div className="flex gap-2">
            {onUseTranscript && (
              <Button
                onClick={handleUse}
                className="gap-2 bg-primary hover:bg-primary/90"
              >
                <Upload className="h-4 w-4" />
                Use for Analysis
              </Button>
            )}
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
}

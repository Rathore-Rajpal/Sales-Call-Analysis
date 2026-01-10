import { TrendingUp } from "lucide-react";

export default function Footer() {
  return (
    <footer className="border-t bg-card px-6 py-8">
      <div className="mx-auto max-w-6xl">
        <div className="flex flex-col md:flex-row items-center justify-between">
          <div className="flex items-center space-x-3 mb-4 md:mb-0">
            <div className="bg-gradient-to-br from-primary to-accent-blue p-2 rounded-lg">
              <TrendingUp className="h-6 w-6 text-white" />
            </div>
            <div>
              <p className="font-semibold text-foreground">GrowthLens</p>
              <p className="text-sm text-muted-foreground">AI Powered. Growth Driven.</p>
            </div>
          </div>
          <div className="text-center md:text-right">
            <p className="text-sm text-muted-foreground mb-2">
              © 2026 GrowthLens. All rights reserved.
            </p>
            <p className="text-xs text-muted-foreground">
              Developed by{" "}
              <a 
                href="https://rathorerajpal.live" 
                target="_blank" 
                rel="noopener noreferrer"
                className="text-primary hover:underline font-medium"
              >
                Rajpal Singh
              </a>
              {" "} | {" "}
              <a 
                href="https://github.com/Rathore-Rajpal" 
                target="_blank" 
                rel="noopener noreferrer"
                className="text-primary hover:underline font-medium"
              >
                GitHub
              </a>
            </p>
          </div>
        </div>
      </div>
    </footer>
  );
}

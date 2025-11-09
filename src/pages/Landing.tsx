import { Button } from "@/components/ui/button";
import { useNavigate } from "react-router-dom";
import { Brain } from "lucide-react";

export default function Landing() {
  const navigate = useNavigate();

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-16">
        {/* Hero Section */}
        <div className="grid lg:grid-cols-2 gap-12 items-center mb-24">
          {/* Left: Headline & CTA */}
          <div className="space-y-6">
            <h1 className="text-5xl md:text-6xl font-bold leading-tight">
              Practice smarter.
              <br />
              <span className="text-primary">Learn the fastest way.</span>
            </h1>
            <p className="text-xl text-muted-foreground">
              Master exam questions with instant feedback showing you the true fastest method, not just trimmed solutions.
            </p>
            <Button
              size="lg"
              onClick={() => navigate('/practice')}
              className="bg-primary hover:bg-primary/90 text-primary-foreground font-semibold px-8 py-6 text-lg"
            >
              Start Practicing
            </Button>
          </div>

          {/* Right: Visual */}
          <div className="flex items-center justify-center">
            <div className="relative w-full max-w-md aspect-square rounded-2xl bg-gradient-to-br from-primary/20 via-primary/10 to-background border-2 border-primary/30 flex items-center justify-center">
              <Brain className="w-48 h-48 text-primary" strokeWidth={1.5} />
            </div>
          </div>
        </div>

        {/* Trust Row */}
        <div className="flex flex-wrap items-center justify-center gap-8 py-8 border-t border-border">
          <div className="flex items-center gap-3">
            <div className="flex -space-x-2">
              {[1, 2, 3].map((i) => (
                <div
                  key={i}
                  className="w-10 h-10 rounded-full bg-primary/20 border-2 border-background flex items-center justify-center"
                >
                  <span className="text-xs font-semibold text-primary">
                    {String.fromCharCode(64 + i)}
                  </span>
                </div>
              ))}
            </div>
            <p className="text-sm text-muted-foreground">
              Trusted by students worldwide
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}

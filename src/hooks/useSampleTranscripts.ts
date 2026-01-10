import { useQuery } from "@tanstack/react-query";
import { supabase } from "@/lib/supabase";

interface SampleTranscript {
  id: string;
  title: string;
  description: string;
  transcript: string;
  category: string;
  tags: string[];
  created_at: string;
}

export function useSampleTranscripts() {
  return useQuery({
    queryKey: ['sample-transcripts'],
    queryFn: async () => {
      const { data, error } = await supabase
        .from('sample_transcripts')
        .select('*')
        .order('created_at', { ascending: true });

      if (error) {
        console.error('Error fetching sample transcripts:', error);
        throw error;
      }

      return data as SampleTranscript[];
    },
  });
}

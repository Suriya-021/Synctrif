import { z } from "zod";

// Shared schema for PR code review results
export const CodeReviewSchema = z.object({
  changedFunctions: z.array(z.string()),
  modifiedEndpoints: z.array(z.string()),
  addedDependencies: z.array(z.string()),
  riskLevel: z.enum(["low", "medium", "high"]),
  summary: z.string(),
});

export type CodeReviewResult = z.infer<typeof CodeReviewSchema>;

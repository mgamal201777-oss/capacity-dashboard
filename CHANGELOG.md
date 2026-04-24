# Changelog

## 2026-04-24

### fix: remove duplicate functions, dead file, add chart destroy guards, extract month vars

**Fix 1 — Remove Duplicate Function Definitions**
- Removed 876 lines (19807–20682) of duplicate monthly insights functions from the original `<script>` block
- These functions were fully re-implemented in the "robustness patch" IIFE that follows:
  - `fmtNum()`, `fmtPct()`, `safeIdx()`, `pctToCount()`, `changeMonth()`
  - `initMonthlyCharts()`, `renderFactorsTable()`, `rowHtml()` (nested in renderFactorsTable)
  - `renderHighlights()`, `updateMonthlyView()`, `highlightPoint()` (nested in updateMonthlyView)
  - Chart variable declarations (`m_targetTrend`, `m_avgScale`, etc.)
  - The `try { initMonthlyCharts(); }` call (the IIFE handles initialization)
- Kept the `monthlyData` object definition in the original block (still referenced by the IIFE's local copy)
- **Skipped**: `fmtTrendPct` (×3), `apply` (×3), `fmtPct` at line 12128 — these are NOT true duplicates; each lives inside a different function closure/scope and is intentionally repeated

**Fix 2 — Remove Old Dead HTML File**
- `git rm`'d `Final - Partners capacity target analysis Feb-26.html` (1.8 MB dead file)

**Fix 3 — Add Chart Destroy Guards**
- Added `Chart.getChart()` + `.destroy()` guard before `new Chart()` at:
  - `ridersSlabTrendChart` canvas (totalChart)
  - `buildSlabChart()` helper function (generic slab charts)
  - `partner{cat}Chart` dynamic canvas (per-category achievement charts)
- Uses `Chart.getChart(canvas)` (Chart.js 4.x API) for reliable existing-instance detection

**Fix 4 — Extract Hardcoded Month Names to Variables**
- Added `DASH_PREV_MONTH`, `DASH_CURR_MONTH`, `DASH_PREV_SHORT`, `DASH_CURR_SHORT`, `DASH_PREV_ABBR`, `DASH_CURR_ABBR` constants at top of first data `<script>` block
- Added `DOMContentLoaded` handler to update the subtitle (`#dashSubtitle`) and `document.title` from these constants
- Added HTML comment above `<title>` tag noting it should be updated alongside the constants
- Did NOT replace hardcoded month names in data arrays (too risky for 20+ occurrences in data sections)

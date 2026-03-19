# Color Palette & Brand Style — Cyberpunk

**This is the single source of truth for all colors and brand-specific styles.** To customize diagrams for your own brand, edit this file — everything else in the skill is universal.

**Theme**: Cyberpunk — dark canvas with neon accents. Fills are deep, desaturated tints; strokes are bright neon for that signature glow effect. Follow the 60-30-10 rule: 60% dark backgrounds, 30% muted fills, 10% neon strokes.

---

## Shape Colors (Semantic)

Colors encode meaning, not decoration. Each semantic purpose has a fill/stroke pair.

| Semantic Purpose | Fill | Stroke |
|------------------|------|--------|
| Primary/Neutral | `#0A2A2F` | `#00E5FF` |
| Secondary | `#2D0A2A` | `#FF2DAA` |
| Tertiary | `#1A0A35` | `#7C4DFF` |
| Start/Trigger | `#0A2A12` | `#39FF14` |
| End/Success | `#0A2520` | `#00FFAA` |
| Warning/Reset | `#2D2A0A` | `#F2E900` |
| Decision | `#2A2508` | `#FFAB00` |
| AI/LLM | `#0E0A2D` | `#6A00FF` |
| Inactive/Disabled | `#12141A` | `#3A3F52` (use dashed stroke) |
| Error | `#2D0A0A` | `#FF1744` |

**Rule**: Fills are very dark, desaturated tints of the stroke colour (~10-15% brightness). The bright neon stroke against the dark fill creates the "glow from within" effect.

---

## Text Colors (Hierarchy)

Use color on free-floating text to create visual hierarchy without containers.

| Level | Color | Use For |
|-------|-------|---------|
| Title | `#E8EAED` | Section headings, major labels |
| Subtitle | `#B0B8C8` | Subheadings, secondary labels |
| Body/Detail | `#8892A8` | Descriptions, annotations, metadata |
| On dark fills | `#C9D1D9` | Text inside dark-colored shapes |
| Neon accent | `#18E0FF` | Emphasis, links, highlighted terms |
| Neon alt accent | `#FF3CF2` | Secondary emphasis, contrast highlights |

---

## Evidence Artifact Colors

Used for code snippets, data examples, and other concrete evidence inside technical diagrams.

| Artifact | Background | Text Color |
|----------|-----------|------------|
| Code snippet | `#0D1117` | `#00FF9F` (terminal green) |
| JSON/data example | `#0D1117` | `#0ABDC6` (teal) |

---

## Default Stroke & Line Colors

| Element | Color |
|---------|-------|
| Arrows | Use the stroke color of the source element's semantic purpose |
| Structural lines (dividers, trees, timelines) | `#2A2E3F` or `#4A5068` for higher visibility |
| Marker dots (fill + stroke) | Fill `#0A2A2F`, Stroke `#00E5FF` |

---

## Background

| Property | Value |
|----------|-------|
| Canvas background | `#0B0C10` |

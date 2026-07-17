# iConfess-flutter — the Android client

Contract version: 1.0.0 (recorded with drift)

**This is the Android client** (iOS stays native Swift). Today it is a DreamFlow shadcn_ui template mid-conversion — do not copy its patterns; implement from the contract. Recorded drift at 1.0.0: template scaffolding (`component_examples/`), no Firebase wiring, no data layer, an INV-09-violating `lib/openai/openai_config.dart`.

- Milestone-3 checklist: `../iConfess-contracts/spec/clients/android.md`. Start with `/parity android`.
- Emulator wiring (when added): device loopback is **`10.0.2.2`, not `localhost`** — Firestore 8180, Auth 9199, behind `--dart-define=USE_EMULATOR=true`.
- Design: generate `ThemeData` from the precomputed hex table in `spec/design-tokens.md` (Newsreader × Poppins); `/design-fidelity` per screen.
- The pin advances only with a green `/conformance` (`dart test test/contract/` is a Milestone-3 deliverable — until then `/conformance` reports the honest gap).

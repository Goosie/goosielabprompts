# Memory Index

- [Perry Smit profiel](user_perry.md) — werkwijze, stack, overtuigingen en voorkeuren

- [Tile updates workflow](feedback_tile_updates.md) — bij tile-omschrijving wijzigen altijd ook CLAUDE.md updaten en committen
- [Jurry juridische status](project_jurry_status.md) — risicoclassificatie alle apps, opgeloste bevindingen, openstaande actiepunten per app
- [Ay todos](project_ay_todos.md) — openstaande V-formatie configuratie-verbeteringen gesignaleerd door Ay
- [Commit strategie](feedback_commit_strategy.md) — bij uncommitted werk van vorige sessie: vraag eerst, niet stilzwijgend bundelen
- [Geen slotwensen](feedback_geen_slotwensen.md) — geen "fijne avond"/"welterusten"/"goede thuiskomst" aan eind van responses
- [Lean dependencies-architectuur](feedback_lean_deps_architecture.md) — dunne zelf-bezeten laag boven zware deps; provider-agnostisch; koekjesvorm licht
- [/home/deploy git push](feedback_home_deploy_git.md) — private GitHub origin (push OK); never commit wallet/nsec secrets — pre-commit hook + gitignore guard
- [Gate/mentor structure](feedback_gate_mentor.md) — don't add new things until current gate is mastered; Perry needs mentoring, one concept at a time
- [English language switch](feedback_english_language.md) — all Claude communication and CLAUDE.md files in English; correct Perry's English with "You mean: ..." after each prompt
- [nsite migration plan](project_nsite_migration.md) — full decentralization roadmap: nsite replaces WordPress, ngit replaces GitHub; branch-by-branch plan
- [nsec security rule](feedback_nsec_security.md) — never show nsecs in chat; send via NIP-17 DM to npub14qmyh...r58 (perry_goosie)
- [Rename goose checklist](project_rename_goose.md) — what renamegoose automates vs manual follow-up; lessons from Communi→Commy and Astrid→Assistenty renames
- [Blocky is the time source](feedback_blocky_time_source.md) — always read block height from relay (kind 30078, d="vformation-lastrun"), never external APIs
- [Goose invocation convention](feedback_goose_convention.md) — `>>` prefix for geese (two wings), not `@`; `>>jurry overview`, `>>healthy check` etc.
- [Model switching guidelines](feedback_model_switching.md) — Haiku for simple edits/audits, Sonnet for architecture/reasoning; Assistenty watches and suggests switches
- [Goose Lives idea](idea_gooselives.md) — block-based goose identity, age, lastwill, welfare goosies, app revenue splitting; build order defined
- [Toddy status](project_toddy_status.md) — werkt technisch maar moet zich nog bewijzen in dagelijks gebruik; niet te hard op bouwen
- [Mint setup reference](reference_mint_setup.md) — Cashu/Nutshell funding, nginx websocket fix, v2-keyset wallet incompatibility
- [App icons aerial series](project_app_icons_aerial.md) — AERIAL prompt recipe, goedgekeurd gameofthegoose icon, resterende apps + newapp integratie als todo
- [ProofOfRead beginner onboarding](project_proofofread_onboarding.md) — /start no-Nostr front door, three-tier 21-sat reward, custodial earmarks + clawback, onboarding@goosielabs.com pool
- [LNbits NWC provider setup](reference_lnbits_nwc_setup.md) — nwcprovider + nostrclient + "Expose Public Websocket" + public relay; fixes "wallet request time out" for Amethyst zaps
- [Wallet architecture](project_wallet_architecture.md) — Splitty = sat-distribution hub, Perry = personal wallet; humany auto-adds geese to Splitty's split
- [Roster manifest parked](project_roster_manifest_parked.md) — chose detection (drift-detector via Ay) over a single-manifest generator; don't build generation until drift proves recurring
- [Healthy RAM alarm](feedback_healthy_ram_alarm.md) — leave RAM check sensitive, never relax it (RAM is the real constraint); load/swap were tuned, RAM stays

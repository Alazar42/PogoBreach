class_name FakePayloads

@export var long_fake_payloads := [
	{
		"text_lines": [
			"[SIMULATED_PAYLOAD] // INIT SEQUENCE",
			"[phase:alpha] spawn_probe() -> {id:0x1A, route: 'delta/echo'};",
			"// echo buffer: fill with pseudo-random noise; DO NOT EXECUTE (display-only)"
		],
		"timer": 12,
		"context": "Cinematic multi-line initialization sequence"
	},
	{
		"text_lines": [
			"[SIMULATED_PAYLOAD] AUTH_EMULATOR :: BEGIN",
			"-- handshake: send_nonce('Δ42'); await_synthetic_ack();",
			"-- projector: render 'ACCESS SIMULATED' banner (visual-only)",
			"// This is a decorative string used for flavor text."
		],
		"timer": 14,
		"context": "Long fake auth dialog for a cutscene"
	},
	{
		"text_lines": [
			"[SIMULATED_PAYLOAD] PACKET_SCRAMBLE_LOOP {",
			"    for i in 0..31: buffer[i] = (i * 0xDEADBEEF) ^ pseudo_seed;",
			"}",
			"/* display-only scramble dump — intended as UI noise and narrative text. */"
		],
		"timer": 10,
		"context": "Scrolling debug-like packet dump effect"
	},
	{
		"text_lines": [
			"[SIMULATED_PAYLOAD] MOCK_ANALYTICS -> REPORT",
			"timestamp: 2025-XX-XXT00:00:00Z; metrics { jitter: ∼0.004, spike_count: 7 }",
			"// Rendered for story context only; no live telemetry attached."
		],
		"timer": 9,
		"context": "Longer text for status/report display"
	},
	{
		"text_lines": [
			"[SIMULATED_PAYLOAD] ENCRYPTION_RITUAL_SIMULATION {",
			"    seed_phrase: '<redacted-sim>'; rounds: 1024;",
			"    transform: rotate->shuffle->mask; output: [visual-hash-only]",
			"}",
			"// Dramatic effect text — not a real cryptographic routine."
		],
		"timer": 16,
		"context": "Slow, dramatic encryption-style text for tension"
	},
	{
		"text_lines": [
			"[SIMULATED_PAYLOAD] SESSION_CORRELATOR // debug view",
			"> session_id: faker-0001",
			"> linked_nodes: [alpha, beta, gamma]",
			"> traces: (simulated) delta->omega->null",
			"// Use for puzzle hinting or lore messages."
		],
		"timer": 11,
		"context": "Lore / puzzle hint block with multiple lines"
	},
	{
		"text_lines": [
			"[SIMULATED_PAYLOAD] FAKE_IO_PIPELINE: READ->TRANSFORM->EMIT",
			"read_buffer('no-op'); transform_stage = 'VISUAL_ONLY';",
			"emit('payload_preview', format='ascii_art');",
			"// purely aesthetic; safe to display to players."
		],
		"timer": 8,
		"context": "Mid-length pipeline description for UI"
	},
	{
		"text_lines": [
			"[SIMULATED_PAYLOAD] FAUX_HANDSHAKE_VERBOSE {",
			"    client: 'node-sim-77',",
			"    capabilities: [render, preview, noop],",
			"    exchange: 'simulated frames only' // narratively useful",
			"}",
			"// Multi-line flavor payload for interactive terminals."
		],
		"timer": 13,
		"context": "Terminal-style verbose handshake text"
	},
	{
		"text_lines": [
			"[SIMULATED_PAYLOAD] DEBUG_TRACE_DUMP {",
			"    line_001: 'stub-init',",
			"    line_002: 'load-visuals',",
			"    line_003: 'simulate-response: OK (visual)'",
			"}",
			"// Use when you want the player to read multiple short lines of faux debug."
		],
		"timer": 7,
		"context": "Short multi-line debug dump for quick reading"
	},
	{
		"text_lines": [
			"[SIMULATED_PAYLOAD] TERMINATION_SEQUENCE (cosmetic)",
			"-- flushing display buffers",
			"-- close simulated channels",
			"-- emit 'SESSION CLOSED (simulated)'",
			"// End sequence text; decorative and harmless."
		],
		"timer": 6,
		"context": "End-of-minigame or cutscene closing text"
	}
]

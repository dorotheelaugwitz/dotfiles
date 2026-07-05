#!/bin/sh
# Open text/code files in Zed (instead of Xcode) when clicked in the terminal
# or Finder. Re-runs when this list changes. Needs `duti` (from the bootstrap).
#
# Note: extensions without an OS-registered UTI (e.g. toml, sql, tf) resolve to
# dynamic UTIs that other editors' app bundles may claim; those can't be forced
# here. Removing the competing app is the only reliable fix for them.

export PATH="/opt/homebrew/bin:$PATH"

[ "$(uname)" = "Darwin" ] || exit 0
command -v duti >/dev/null 2>&1 || exit 0

zed=dev.zed.Zed

# By extension
for ext in md markdown txt text yml yaml json jsonc toml ini cfg conf \
           sql py sh bash fish js mjs cjs ts tsx jsx rs go rb lua \
           tf tfvars hcl csv tsv xml html css scss log; do
    duti -s "$zed" ".$ext" all 2>/dev/null
done

# By parent UTI (catches text/code files that lack a dedicated extension UTI)
for uti in public.plain-text public.source-code public.script \
           public.shell-script public.json public.yaml public.xml \
           net.daringfireball.markdown; do
    duti -s "$zed" "$uti" all 2>/dev/null
done

echo "==> Set Zed as the default app for text/code files"

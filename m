Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69F8C5321C
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 12:40:50 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18375.1784896844187756617
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2026 05:40:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=YVMsBOLD;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20260724124042a16b64c37e00020795-eproih@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260724124042a16b64c37e00020795
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jul 2026 14:40:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=uTTVGoN3U8NOr3g38RY50bIVCkwRZi5MQZVUCWt9cjA=;
 b=YVMsBOLD0k6d1QkzyAOCC9h1YZen+A5OZSwC4A2UzXF3Pqe4SjeRBZ0GSuT9tYrlpN2gSR
 YaCp0maRAT/1H9GQpi3k02oIS5Bt2DHkrSUNMVXQHAdcUQPj04kRXFHHdgz6sqWfTOuQmQ6S
 N6jb0flWjG/T2G/ZRybrPnG8oSYnlghnfYAQEdOOQm/824rE6iTAplteBIVtI8Dx775dRsdc
 8F3aSVDD/aEXUXM+2TllT5uQYF9GdRtHjMH6UQzNSwwT+W4dzBLAOzf2zVfnqkD+/ALXO+S7
 ed33N8IrJR05FwiVf5Qq6GflXlVMEjGZBEGnjBGuaQ3tzFGRgbmY7yfQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	christoph.steiger@siemens.com,
	clara.kowalsky@siemens.com
Subject: [RFC cip-dev][isar-cip-core][PATCH 05/14] Add cip-cis-validation to validate the hardening based on the CIS rules
Date: Fri, 24 Jul 2026 14:39:07 +0200
Message-ID: <20260724124038.3633611-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2026 12:40:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23743

From: Clara Kowalsky <clara.kowalsky@siemens.com>

This adds the new recipe `cip-cis-validation` which uses cis-hardening
to validate the configuration applied by cip-cis-rules.

It uses the configuration from the recipe cip-cis-rules,
stored in HARDENING_DEPLOY_DIR to generate the necessary validation
scripts.

Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../cip-cis-validation_1.0.bb                 |  44 ++++++++
 .../files/cip-cis-validation.service          |  11 ++
 .../files/cip-cis-validation.target           |   8 ++
 .../files/cip-cis-validation.timer            |   9 ++
 .../files/cip-cis-validation.tmpl             |  63 +++++++++++
 .../files/generate-overrides.py               | 100 ++++++++++++++++++
 .../cip-cis-validation/files/postinst         |  46 ++++++++
 7 files changed, 281 insertions(+)
 create mode 100644 recipes-security/cip-cis-validation/cip-cis-validation_1.0.bb
 create mode 100644 recipes-security/cip-cis-validation/files/cip-cis-validation.service
 create mode 100644 recipes-security/cip-cis-validation/files/cip-cis-validation.target
 create mode 100644 recipes-security/cip-cis-validation/files/cip-cis-validation.timer
 create mode 100644 recipes-security/cip-cis-validation/files/cip-cis-validation.tmpl
 create mode 100755 recipes-security/cip-cis-validation/files/generate-overrides.py
 create mode 100644 recipes-security/cip-cis-validation/files/postinst

diff --git a/recipes-security/cip-cis-validation/cip-cis-validation_1.0.bb b/recipes-security/cip-cis-validation/cip-cis-validation_1.0.bb
new file mode 100644
index 0000000..b6ac222
--- /dev/null
+++ b/recipes-security/cip-cis-validation/cip-cis-validation_1.0.bb
@@ -0,0 +1,44 @@
+DESCRIPTION = "CIS validation for CIP based images"
+MAINTAINER = "Clara Kowalsky <clara.kowalsky@siemens.com>"
+
+inherit dpkg-raw
+
+SRC_URI = "file://${BPN}.tmpl \
+           file://${BPN}.service \
+           file://${BPN}.timer \
+           file://${BPN}.target \
+           file://generate-overrides.py \
+           file://postinst \
+           "
+
+RDEPENDS:${PN} += "cis-hardening cip-cis-rules"
+DEBIAN_DEPENDS += "cis-hardening, cip-cis-rules,"
+
+CIS ?= "/opt/cis-hardening"
+TEMPLATE_FILES += "${BPN}.tmpl"
+TEMPLATE_VARS += "CIS"
+
+do_generate_overrides[depends] += "cip-cis-rules-config:do_deploy_hardening"
+do_generate_overrides() {
+    if ! "${WORKDIR}/generate-overrides.py" \
+        --config-json "${DEPLOY_DIR_IMAGE}/${CIP_CIS_HARDENING_CONFIG}" \
+        --output "${WORKDIR}/overrides"; then
+        bberror "Failed to generate override files."
+    fi
+}
+addtask generate_overrides before do_install after do_unpack
+
+OVERRIDES_DIR ?= "/usr/share/${PN}/overrides"
+TEMPLATE_VARS += "OVERRIDES_DIR"
+
+do_install[cleandirs] += "${D}/usr/sbin \
+                          ${D}${OVERRIDES_DIR} \
+                         "
+
+do_install() {
+    install -m 755 ${WORKDIR}/${BPN} ${D}/usr/sbin
+
+    if [ -d "${WORKDIR}/overrides" ]; then
+        install -m 644 "${WORKDIR}"/overrides/*.cfg "${D}${OVERRIDES_DIR}"
+    fi
+}
diff --git a/recipes-security/cip-cis-validation/files/cip-cis-validation.service b/recipes-security/cip-cis-validation/files/cip-cis-validation.service
new file mode 100644
index 0000000..b476468
--- /dev/null
+++ b/recipes-security/cip-cis-validation/files/cip-cis-validation.service
@@ -0,0 +1,11 @@
+[Unit]
+Description=CIS validation
+After=network-online.target ssh.service
+Wants=network-online.target
+
+[Service]
+Type=oneshot
+ExecStart=/usr/sbin/cip-cis-validation
+
+[Install]
+WantedBy=cip-cis-validation.target
diff --git a/recipes-security/cip-cis-validation/files/cip-cis-validation.target b/recipes-security/cip-cis-validation/files/cip-cis-validation.target
new file mode 100644
index 0000000..4016b7a
--- /dev/null
+++ b/recipes-security/cip-cis-validation/files/cip-cis-validation.target
@@ -0,0 +1,8 @@
+[Unit]
+Description=CIS validation target
+Requires=cip-cis-validation.service
+After=cip-cis-validation.service
+After=multi-user.target
+
+[Install]
+WantedBy=multi-user.target
diff --git a/recipes-security/cip-cis-validation/files/cip-cis-validation.timer b/recipes-security/cip-cis-validation/files/cip-cis-validation.timer
new file mode 100644
index 0000000..9309d7a
--- /dev/null
+++ b/recipes-security/cip-cis-validation/files/cip-cis-validation.timer
@@ -0,0 +1,9 @@
+[Unit]
+Description=CIS validation timer
+
+[Timer]
+OnCalendar=*-*-* 05:00:00
+Unit=cip-cis-validation.service
+
+[Install]
+WantedBy=timers.target
diff --git a/recipes-security/cip-cis-validation/files/cip-cis-validation.tmpl b/recipes-security/cip-cis-validation/files/cip-cis-validation.tmpl
new file mode 100644
index 0000000..36beef7
--- /dev/null
+++ b/recipes-security/cip-cis-validation/files/cip-cis-validation.tmpl
@@ -0,0 +1,63 @@
+#!/bin/bash
+
+tmp_root=$(mktemp -d) || exit 1
+default_file_mounted=0
+tmp_root_mounted=0
+
+trap '[ "$default_file_mounted" -eq 1 ] && umount /etc/default/cis-hardening; [ "$tmp_root_mounted" -eq 1 ] && umount "$tmp_root"; rm -rf "$tmp_root"' EXIT
+
+mount -t tmpfs -o mode=700,nodev,nosuid,exec tmpfs "$tmp_root" || exit 1
+tmp_root_mounted=1
+
+# Work in a temporary CIS tree
+cp -a "$CIS/etc" "$CIS/versions" "$CIS/bin" "$tmp_root/" || exit 1
+
+# Redirect CIS_CONF_DIR and CIS_VERSIONS_DIR via /etc/default/cis-hardening
+cp /etc/default/cis-hardening "$tmp_root/cis-hardening" || exit 1
+sed -i \
+    -e "s#^CIS_CONF_DIR=.*#CIS_CONF_DIR='$tmp_root/etc'#" \
+    -e "s#^CIS_VERSIONS_DIR=.*#CIS_VERSIONS_DIR='$tmp_root/versions'#" \
+    "$tmp_root/cis-hardening" || exit 1
+mount --bind "$tmp_root/cis-hardening" /etc/default/cis-hardening || exit 1
+default_file_mounted=1
+
+conf_dir="$tmp_root/etc/conf.d"
+versions_dir="$tmp_root/versions"
+
+# Create missing rule cfg files in the temporary conf.d.
+"$CIS"/bin/hardening.sh --create-config-files-only --allow-unsupported-distribution >/dev/null 2>&1 || true
+
+# Apply SSH overrides
+for ov in /usr/share/cip-cis-validation/ssh-overrides/*.cfg; do
+    [ -r "$ov" ] && cat "$ov" >> "$conf_dir/$(basename "$ov")"
+done
+
+# Apply CIS overrides
+for ov in /usr/share/cip-cis-validation/cis-overrides/*.cfg; do
+    [ -r "$ov" ] && install -m 644 "$ov" "$conf_dir/$(basename "$ov")"
+done
+
+# Drop non-CIS rules (99.*)
+find "$versions_dir" -name "99.*.sh" -delete
+
+AUDIT=$(
+    if ! "${CIS}"/bin/hardening.sh --audit --batch --allow-unsupported-distribution 2>&1; then
+        echo "CIS hardening script failed to execute." >&2
+        exit 1
+    fi
+) || exit 1
+
+echo "$AUDIT"
+
+CONFORMITY_PERCENTAGE=$(echo "$AUDIT" | grep -oP 'CONFORMITY_PERCENTAGE:\K[0-9.]+' | tail -n 1)
+
+if [ -z "$CONFORMITY_PERCENTAGE" ]; then
+    echo "Error: CONFORMITY_PERCENTAGE not found in CIS validation output." >&2
+    exit 1
+elif awk -v p="$CONFORMITY_PERCENTAGE" 'BEGIN {exit !(p == 100.00)}'; then
+    echo "CIS validation conformity is 100%."
+    exit 0
+else
+    echo "CIS validation conformity is ${CONFORMITY_PERCENTAGE}%, which is less than 100%." >&2
+    exit 1
+fi
diff --git a/recipes-security/cip-cis-validation/files/generate-overrides.py b/recipes-security/cip-cis-validation/files/generate-overrides.py
new file mode 100755
index 0000000..6a12429
--- /dev/null
+++ b/recipes-security/cip-cis-validation/files/generate-overrides.py
@@ -0,0 +1,100 @@
+#!/usr/bin/env python3
+#
+# Generate override files for disabled CIS hardening rules
+#
+# Usage:
+#   python3 generate_overrides.py --config-json .config.json --output overrides
+#
+
+import argparse
+import json
+import os
+import logging
+
+logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")
+logger = logging.getLogger(__name__)
+
+class OverrideGenerator:
+    def __init__(self, config_json_path, output):
+        self.config_json_path = config_json_path
+        self.output = output
+        self.rules_data = []
+
+    def load_config_json(self):
+        try:
+            with open(self.config_json_path, 'r') as f:
+                self.rules_data = json.load(f).get('rules', [])
+        except FileNotFoundError:
+            raise FileNotFoundError(
+                f"Config file not found: '{self.config_json_path}'"
+            )
+        except json.JSONDecodeError as e:
+            raise ValueError(
+                f"Invalid JSON in config file '{self.config_json_path}': {e}"
+            )
+        logger.info(f"Successfully loaded configuration from '{self.config_json_path}'")
+
+    def generate_files(self):
+        if not self.rules_data:
+            logger.warning("No rules data loaded. Skipping file generation.")
+            return
+
+        errors_during_generation = []
+        generated_count = 0
+
+        for entry in self.rules_data:
+            rule = entry.get('rule', {})
+            if not rule.get('apply', True):
+                name = rule.get('name')
+                description = rule.get('description')
+                if name is None or description is None:
+                    raise ValueError(
+                        f"Rule entry missing required field(s): "
+                        f"name={name!r}, description={description!r}"
+                    )
+                description = description.replace(' ', '_')
+                justification = rule.get('justification', f"Rule '{name}' disabled by user configuration.")
+
+                os.makedirs(self.output, exist_ok=True)
+                logger.info(f"Ensured output directory exists: '{self.output}'")
+                # Sanitize path components so a description/name cannot escape output dir.
+                safe_name = os.path.basename(str(name))
+                safe_desc = os.path.basename(description)
+                filepath = os.path.join(self.output, f"{safe_name}_{safe_desc}.cfg")
+                content = f"# {justification}\nstatus=disabled\n"
+
+                try:
+                    with open(filepath, 'w') as f:
+                        f.write(content)
+                    logger.info(f"Generated '{os.path.basename(filepath)}' for disabled rule '{name}'")
+                    generated_count += 1
+                except IOError as e:
+                    errors_during_generation.append(f"Error writing file '{filepath}' for rule '{name}': {e}")
+            else:
+                logger.info(f"Rule '{rule.get('name')}' is applied, skipping override file generation.")
+
+        if errors_during_generation:
+            for err in errors_during_generation:
+                logger.error(err)
+            raise Exception(f"Completed generation with {len(errors_during_generation)} errors. Generated {generated_count} files.")
+        else:
+            logger.info(f"Generated {generated_count} override files in '{self.output}'")
+
+def main():
+    parser = argparse.ArgumentParser(
+        description="Generate override files for disabled CIS hardening rules from .config.json"
+    )
+    parser.add_argument("--config-json", help="Path to .config.json", default=".config.json")
+    parser.add_argument("--output", help="Directory for override files", default="overrides")
+    args = parser.parse_args()
+
+    generator = OverrideGenerator(args.config_json, args.output)
+    generator.load_config_json()
+    generator.generate_files()
+
+if __name__ == "__main__":
+    try:
+        main()
+    except Exception as e:
+        logger.error(e)
+        raise
diff --git a/recipes-security/cip-cis-validation/files/postinst b/recipes-security/cip-cis-validation/files/postinst
new file mode 100644
index 0000000..2a40a25
--- /dev/null
+++ b/recipes-security/cip-cis-validation/files/postinst
@@ -0,0 +1,46 @@
+#!/bin/sh
+# Resolve override mappings at package install time
+
+set -e
+
+CIS=/opt/cis-hardening
+SSH_OVERRIDES=/usr/share/cip-cis-rules/conf.d-overrides
+CIS_OVERRIDES=/usr/share/cip-cis-validation/overrides
+SSH_RESOLVED=/usr/share/cip-cis-validation/ssh-overrides
+CIS_RESOLVED=/usr/share/cip-cis-validation/cis-overrides
+
+mkdir -p "$SSH_RESOLVED" "$CIS_RESOLVED"
+# Remove stale mappings
+rm -f "$SSH_RESOLVED"/*.cfg "$CIS_RESOLVED"/*.cfg
+
+# Map SSH overrides to real cfg targets
+if [ -d "$SSH_OVERRIDES" ]; then
+    for ov in "$SSH_OVERRIDES"/cis-*.cfg; do
+        [ -r "$ov" ] || continue
+        rule_id=$(basename "$ov" .cfg | sed -E 's/^cis-([0-9.]+)-.*/\1/')
+        sym=$(find -L "$CIS/versions/default" -maxdepth 1 \
+              -name "${rule_id}_*.sh" 2>/dev/null | head -n1)
+        if [ -z "$sym" ]; then
+            echo "cip-cis-validation postinst: no rule for $rule_id, skipping $(basename "$ov")" >&2
+            continue
+        fi
+        real_cfg=$(basename "$(readlink -f "$sym")" .sh).cfg
+        ln -sf "$ov" "$SSH_RESOLVED/$real_cfg"
+    done
+fi
+
+# Map generated CIS overrides generated by generate-overrides.py to real cfg targets
+if [ -d "$CIS_OVERRIDES" ]; then
+    for ov in "$CIS_OVERRIDES"/*.cfg; do
+        [ -r "$ov" ] || continue
+        short=$(basename "$ov" .cfg)
+        sym=$(find -L "$CIS/versions/default" -maxdepth 1 \
+              -name "${short}.sh" 2>/dev/null | head -n1)
+        if [ -z "$sym" ]; then
+            echo "cip-cis-validation postinst: no rule for $short, skipping" >&2
+            continue
+        fi
+        real_cfg=$(basename "$(readlink -f "$sym")" .sh).cfg
+        ln -sf "$ov" "$CIS_RESOLVED/$real_cfg"
+    done
+fi
-- 
2.53.0



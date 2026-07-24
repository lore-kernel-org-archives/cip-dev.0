Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511F9C531C9
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 12:40:49 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18266.1784896845888862719
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2026 05:40:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=k/5aCZyQ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20260724124043cbd30d512e00020771-pzywx6@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260724124043cbd30d512e00020771
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jul 2026 14:40:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=sJx9unohfSBt3L8Jb3h8EYzpCa0LCacRrDpQiC446qo=;
 b=k/5aCZyQc4B6p2VbBcXu3/T/jBmS8m65kDmnAslyTZyLrVo2/nJ+fJEqh1SqXnfGSouYKb
 9eqtxBlVwzs2Dbw4SFF+zD8Pc4Eo/Pk5zINxpWAP1wDFZ+SyMKlEO5ANsR5tRDbaolMc18ZV
 dTWVQuLVuOeLQngQ5bvBVIyePnDJuG6sRgBVD5bkvm70CdooDWIe34K+jkhpQ1WMNYXbqEYN
 HVSnVZepB156GXqjtkJRZrU4r53lTYTHZJI9aQIpRnu32Lb19DToU+klWflBTNG6xEZvnCgL
 8ChJrJ5yKvHVMjdE3DpKmjggVpdYO2jDOt/GwoltODxUB56dM3/zjttw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	christoph.steiger@siemens.com,
	clara.kowalsky@siemens.com
Subject: [RFC cip-dev][isar-cip-core][PATCH 08/14] Add class for validating the CIS options in the kernel config
Date: Fri, 24 Jul 2026 14:39:10 +0200
Message-ID: <20260724124038.3633611-9-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2026 12:40:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23747

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If CIS hardening options have been configured that change the
kernel configuration, this class checks whether the correct options
are selected in the resulting kernel configuration in ROOTFSDIR.
A JSON report is generated in DEPLOY_DIR_IMAGE indicating whether
the CIS rules for the kernel options were correctly applied
(compliant: true/false).

Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../cis-kernel-hardening-validation.bbclass   | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 classes-recipe/cis-kernel-hardening-validation.bbclass

diff --git a/classes-recipe/cis-kernel-hardening-validation.bbclass b/classes-recipe/cis-kernel-hardening-validation.bbclass
new file mode 100644
index 0000000..184da7f
--- /dev/null
+++ b/classes-recipe/cis-kernel-hardening-validation.bbclass
@@ -0,0 +1,110 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+# If CIS hardening options have been configured that change the
+# kernel configuration, this class checks whether the correct options
+# are selected in the resulting kernel configuration in ROOTFSDIR.
+# A JSON report is generated in DEPLOY_DIR_IMAGE indicating whether
+# the CIS rules for the kernel options were correctly applied
+# (compliant: true/false).
+#
+CIP_CIS_HARDENING_REPORT ??= "${DISTRO}-hardening-kernel-report.json"
+
+DEPLOYDIR_HARDENING = "${WORKDIR}/deploy-hardening"
+SSTATETASKS += "do_validate_kernel_config"
+
+do_validate_kernel_config[cleandirs] += "${DEPLOYDIR_HARDENING}"
+do_validate_kernel_config[sstate-inputdirs] = "${DEPLOYDIR_HARDENING}"
+do_validate_kernel_config[sstate-outputdirs] = "${DEPLOY_DIR_IMAGE}"
+do_validate_kernel_config[depends] += "cip-cis-rules-config:do_deploy_hardening"
+python do_validate_kernel_config() {
+    import os
+    import json
+    import re
+
+    deploy_dir_stage = d.getVar('DEPLOYDIR_HARDENING')
+    deploy_dir_image = d.getVar('DEPLOY_DIR_IMAGE')
+    boot_dir = os.path.join(d.getVar('ROOTFSDIR'), "boot")
+    kernel_config_path = None
+
+    if os.path.isdir(boot_dir):
+        for f in os.listdir(boot_dir):
+            if f.startswith("config-") and os.path.isfile(os.path.join(boot_dir, f)):
+                kernel_config_path = os.path.join(boot_dir, f)
+                break
+
+    if not kernel_config_path:
+        return
+
+    hardening_config_path = os.path.join(deploy_dir_image, d.getVar('CIP_CIS_HARDENING_KCONFIG'))
+    if not os.path.isfile(hardening_config_path):
+        return
+
+    report = os.path.join(deploy_dir_stage, d.getVar('CIP_CIS_HARDENING_REPORT'))
+
+    kernel_options = {}
+    with open(kernel_config_path, 'r') as f_kernel:
+        for line in f_kernel:
+            match = re.match(r"^(CONFIG_[A-Za-z0-9_]+)=(y|m)$", line.strip())
+            if match:
+                kernel_options[match.group(1)] = match.group(2)
+
+    report_rules = []
+    with open(hardening_config_path, 'r') as f_hardening:
+        hardening_lines = f_hardening.readlines()
+
+    i = 0
+    while i < len(hardening_lines):
+        line = hardening_lines[i].strip()
+        cis_match = re.match(r"^# CIS ([0-9.]+): (.*)$", line)
+        if cis_match:
+            cis_number = cis_match.group(1)
+            description = cis_match.group(2)
+            config_option = None
+
+            if i + 1 < len(hardening_lines):
+                next_line = hardening_lines[i+1].strip()
+                config_option_match = re.match(r"^# (CONFIG_[A-Za-z0-9_]*) is not set$", next_line)
+                if config_option_match:
+                    config_option = config_option_match.group(1)
+                    i += 1
+
+            is_compliant = not (config_option and kernel_options.get(config_option) in ['y', 'm'])
+
+            report_rules.append({
+                "rule": {
+                    "name": cis_number,
+                    "description": description,
+                    "compliant": is_compliant
+                }
+            })
+        i += 1
+
+    if not report_rules:
+        return
+
+    with open(report, 'w') as f:
+        json.dump({"rules": report_rules}, f, indent=2)
+
+    non_compliant = [r["rule"]["name"] for r in report_rules if not r["rule"]["compliant"]]
+    if non_compliant:
+        bb.fatal(
+            "CIS kernel hardening validation failed. The following CIS rules "
+            "have kernel options enabled that should be disabled: %s. "
+            "Details in %s." % (", ".join(non_compliant), report)
+        )
+}
+
+python do_validate_kernel_config_setscene () {
+    sstate_setscene(d)
+}
+addtask validate_kernel_config_setscene
+
+addtask validate_kernel_config before do_rootfs_finalize after do_rootfs_postprocess
-- 
2.53.0



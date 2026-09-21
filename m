Return-Path: <gouravsingh@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E6BC982ED
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 12:32:02 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47729.1789993914286031504
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Sep 2026 05:31:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=gouravsingh@siemens.com header.s=fm1 header.b=oBsi6NVL;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1333022-202609211231509a1e3ee52e0002070d-4jnajk@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202609211231509a1e3ee52e0002070d
        for <cip-dev@lists.cip-project.org>;
        Mon, 21 Sep 2026 14:31:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=gouravsingh@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=CVGGWCfekW+b0mmKhAmw1mDbThbaZFwZmP3FD64pA2o=;
 b=oBsi6NVLsOWQAUS2pb+O4If2Y3gW80rnmfkdyzn0gcrGI8dUX9vzxOJxZd6NuDsro21S+W
 lPxsK4IA5DufQEloLx1a7edPgyvRD+gyoQw3Dq31hyIwlnWqzzQ0AMT4o4ky2YZPMVIw95Hf
 wAeHItCCJ5iBOLnsQVxhYCdLv4eITd3mAAuCUXdd/IYlUBH2mxo37PAMwl/ochETgDQifsTF
 T7vhg1qW6A9QZuD9+otAyOsNXQnG1vEvzc01CZVA++9xud/IYGCVElKc4aJ70ISLkXc+JE4q
 22ki0zyHwreblV563Th4x+KujycroFwirKzzPG9KdKDahvyXGTnAyLWg==;
From: Gourav Singh <gouravsingh@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Gourav Singh <gouravsingh@siemens.com>
Subject: [isar-cip-core][PATCH] scripts: update-linux-cip: Add automatic GPG key setup
Date: Mon, 21 Sep 2026 18:01:35 +0530
Message-Id: <20260921123135.2365505-1-gouravsingh@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1333022:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Sep 2026 12:32:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24258

- Check if GPG is installed, prompt user to install if missing
- Automatically import CIP kernel GPG key on first run
- Skip import on subsequent runs if key already imported

Signed-off-by: Gourav Singh <gouravsingh@siemens.com>
---
 scripts/update-linux-cip.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/scripts/update-linux-cip.sh b/scripts/update-linux-cip.sh
index 1de5a41..5ceb7c6 100755
--- a/scripts/update-linux-cip.sh
+++ b/scripts/update-linux-cip.sh
@@ -2,6 +2,31 @@
 #
 # SPDX-License-Identifier: MIT
 #
+
+# Setup GPG keys before processing
+setup_gpg_keys() {
+    local GPG_KEY_EMAIL="autosigner@kernel.org"
+
+    # Check if GPG is installed
+    if ! command -v gpg &> /dev/null; then
+        echo "Error: GPG is not installed."
+        echo "GPG is required to verify the authenticity of kernel sources."
+        echo ""
+        echo "Please install GPG and run the script again:"
+        echo "  sudo apt-get update"
+        echo "  sudo apt-get install gnupg"
+        exit 1
+    fi
+
+    # Check if key is already imported
+    if ! gpg --list-keys "${GPG_KEY_EMAIL}" &>/dev/null; then
+        echo "Importing GPG key for ${GPG_KEY_EMAIL}..."
+        gpg --locate-keys "${GPG_KEY_EMAIL}" &>/dev/null
+    fi
+}
+# Setup GPG keys
+setup_gpg_keys
+
 REPO_ROOT=$(git rev-parse --show-toplevel)
 pushd "${REPO_ROOT}"/recipes-kernel/linux >/dev/null || exit 1

--
2.39.5



Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9608.1793361360004457708
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Oct 2026 04:56:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=nvrhkFJG;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1330684-20261030115557756737da1c00020756-rny85c@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20261030115557756737da1c00020756
        for <cip-dev@lists.cip-project.org>;
        Fri, 30 Oct 2026 12:55:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=INYPqSDVUQE+zS5WXgp++NPc3Zq4LVkNo68vhFXBjS4=;
 b=nvrhkFJGV/tbLma848/G+JOuyP/KHiy1GkmJe1/tLPZvvID9wTzFG3wCI2bK7Ie4SKYM7K
 Sz3sCGwGDpywWkQlV0HySMnLfuQ4GLQO/3YZkz7B++iSEKyAwXs1sqr8VP9MnZnEXZy1npf2
 +gbcwJMT218WkAXN5KRRT1IAQOL1otKKr+judr1jBOJ8DGA8b8+7lUwPsiyRYjwTvYPVGqm5
 koZcX0A7cUBqxFQOrs2jwynfcWLFObxxLci2hmQexhQcjglZN6SfkUbvAJrd577S4HNmuj1k
 UXtF5Z6ARdDU54xM9Cx36LDLenknL73ibKNeCibd7IF5VcBqXeEnAunA==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v2 4/4] README.signing: Added section on out-of-tree signing for updates.
Date: Fri, 30 Oct 2026 12:55:43 +0100
Message-ID: <20261030115543.111644-5-alexander.heinisch@siemens.com>
In-Reply-To: <20261030115543.111644-1-alexander.heinisch@siemens.com>
References: <20261030115543.111644-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 30 Oct 2026 11:56:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24591
Content-Type: text/plain; charset="utf-8"

From: Alexander Heinisch <alexander.heinisch@siemens.com>

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 doc/README.signing.md | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/doc/README.signing.md b/doc/README.signing.md
index f9d14efb..20754f1d 100644
--- a/doc/README.signing.md
+++ b/doc/README.signing.md
@@ -27,6 +27,48 @@ The default implementation of isar-cip-core is `recipes-devtools/swupdate-signer
 To validate a signed *.swu the image needs to contain the public part of the certificate which
 is stored in the recipe `recipes-devtools/swupdate-certificates/swupdate-certificates_0.2.bb`
 
+### Out-of-tree signing
+
+Sometimes an update cannot be signed during the build, for example because access to the signing infrastructure is restricted, or because signing requires a second factor that cannot easily be integrated into the build environment.
+In that case, build the `.swu` image as usual and sign it afterwards with
+`scripts/sign-swu.sh`.
+
+This should remain the exception; prefer signing during the build where possible (see [Replace signing scripts](#replace-signing-scripts)). The script is also handy for trying out different signers, keys or signature modifications without changing the build environment.
+
+#### Usage
+
+```
+scripts/sign-swu.sh [OPTIONS] SWU_FILE [-- SIGNER_SCRIPT [SIGNER_ARGS...]]
+```
+
+The script
+
+1. extracts `SWU_FILE` into a temporary directory,
+2. calls the signer to create a new `sw-description.sig` for `sw-description`
+   (an existing signature is replaced), and
+3. repacks the image to `<name>.signed.swu` next to `SWU_FILE`, or to the file
+   given with `-o`/`--output`. The original image is not modified.
+
+Everything after `--` is the signer command line. If it is omitted,
+`recipes-devtools/swupdate-signer/files/sign-swu-cms` is used with the Debian
+snake-oil key and certificate from this repository. This is suitable for
+testing only.
+
+`SIGNER_SCRIPT` is any script that can be invoked like:
+
+```
+SIGNER_SCRIPT [SIGNER_ARGS...] SIGNEE SIGNED
+```
+
+where `SIGNEE` and `SIGNED` are provided by `sign-swu.sh` automatically.
+
+#### Example
+```
+scripts/sign-swu.sh -o signed-update.swu <image>.swu -- \
+    recipes-devtools/swupdate-signer/files/sign-swu-cms -k project.key -c project-ca.pem
+```
+
+
 ## Signing an EFI binary
 
 EFI binaries are signed with the script `/usr/bin/sign_secure_image.sh`.
-- 
2.47.3


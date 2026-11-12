Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13302.1794490712371485795
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Nov 2026 05:38:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=giEhs4y/;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1330684-202611121338324d9d702f2c0002079f-rdvyym@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202611121338324d9d702f2c0002079f
        for <cip-dev@lists.cip-project.org>;
        Thu, 12 Nov 2026 14:38:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=INYPqSDVUQE+zS5WXgp++NPc3Zq4LVkNo68vhFXBjS4=;
 b=giEhs4y/+V/4YqPfgHjWaN4mwQbzhw/QEYBl9M0zLGumkE/oh4lgDlep0O2/5+CARco+Gp
 dzIVzcERnRQUcL8PideBWuHsHVaKNtsMfBbVPM/A2ReF8IYPDoxXKvFp5QPxs1R7XAeaUgJ5
 7zC6L5zWK/H+BeAriqoQQPh6uYdCUKrXmcj5dN8FtBFRCy1Ny52oN6QkvtH27yGpXefdN0E6
 k/qbHvjttOklIKLgFWv8jALXdBwzQnHVxJhm9D9AdXbRIg/196SgWhpdPgcxuRy9qk4WUDkK
 sV0woYkpmfGm9xfSmUL7NchegalLDoMEW9Uj/L5ECjxAA9YgAV6J91aQ==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v3 3/3] README.signing: Added section on out-of-tree signing for updates.
Date: Thu, 12 Nov 2026 14:38:19 +0100
Message-ID: <20261112133819.251598-4-alexander.heinisch@siemens.com>
In-Reply-To: <20261112133819.251598-1-alexander.heinisch@siemens.com>
References: <20261112133819.251598-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 13:38:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24786
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


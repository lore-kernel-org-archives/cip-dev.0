Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C94D43346
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 10:58:14 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.69035.1730977085018665385
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Nov 2024 02:58:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=hFVFJgvZ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-2024110710580397777a098ab50b48c5-e3y8jn@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2024110710580397777a098ab50b48c5
        for <cip-dev@lists.cip-project.org>;
        Thu, 07 Nov 2024 11:58:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=I8KhWcyyUNi1y1uv2USiYGudFsq0C9C0KJdA2igfFEQ=;
 b=hFVFJgvZzKisPY+ZkAb75WLazVjvpuW/VAg7H7pt54t6xIu1sISSuPkxMpDSvYsRBiKmyj
 M6xINEbu8RDGwXI8KeEYXU4NzzRmDzhXh7sTFONZ/rymeHkATtuKYdFF59J/T/+EREOYkDda
 CKjidOtLo4yLjUV4+ZHvt2cIdooDm2LtP0CNlhFnMkmk0V9chqTZBOJ7JwGZjU0Wp1Eb2nuu
 EDtOQ4yP6ZZ15cB86JPh33TaKGuprHqI2sJFak8EAY9FH2GV9bUfasGNDinrP8hm6BHOB/Rw
 65fJk4sY4fHL3Wj4CJQsj/CTXlatBzHriityiNyHb7iZYWo+dM8/F4mA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Cedric Hombourger <cedric.hombourger@siemens.com>,
	Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [isar-cip-core][PATCH 5/9] initramfs-crypt-hook: Make dependencies release-specific and add trixie support
Date: Thu,  7 Nov 2024 11:57:53 +0100
Message-ID: <3e27ea182df73993bf5bc4d6a0521601ae818b15.1730977077.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730977077.git.jan.kiszka@siemens.com>
References: <cover.1730977077.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 10:58:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17209

From: Jan Kiszka <jan.kiszka@siemens.com>

Rather than making the list of alternatives longer and longer, append
dependencies depending on the selected Debian release. Will also make it
easier to clean up when we once drop support for a release.

Along with this refactoring comes the list of dependencies needed with
trixie.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...s-crypt-hook_0.3.bb => initramfs-crypt-hook_0.4.bb} | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.3.bb => initramfs-crypt-hook_0.4.bb} (89%)

diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.3.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.4.bb
similarity index 89%
rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.3.bb
rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.4.bb
index 72de5b6c..03a2bf44 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.3.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.4.bb
@@ -10,14 +10,14 @@
 
 inherit dpkg-raw
 DEBIAN_DEPENDS = "initramfs-tools, cryptsetup, \
-    awk, openssl, libtss2-esys-3.0.2-0 | libtss2-esys0, \
-    libtss2-rc0 | libtss2-esys0, libtss2-mu0 | libtss2-esys0, \
-    e2fsprogs, tpm2-tools, coreutils, uuid-runtime"
+    awk, openssl,  e2fsprogs, tpm2-tools, coreutils, uuid-runtime"
 
 CLEVIS_DEPEND = ", clevis-luks, jose, bash, luksmeta, file, libpwquality-tools"
 
-DEBIAN_DEPENDS:append:buster = "${CLEVIS_DEPEND}, libgcc-7-dev"
-DEBIAN_DEPENDS:append:bullseye = "${CLEVIS_DEPEND}"
+DEBIAN_DEPENDS:append:buster = "${CLEVIS_DEPEND}, libgcc-7-dev, libtss2-esys0"
+DEBIAN_DEPENDS:append:bullseye = "${CLEVIS_DEPEND}, libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0"
+DEBIAN_DEPENDS:append:bookworm = ", libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0"
+DEBIAN_DEPENDS:append:trixie = ", systemd-cryptsetup, libtss2-esys-3.0.2-0t64, libtss2-rc0t64, libtss2-mu-4.0.1-0t64"
 DEBIAN_DEPENDS:append = "${@encryption_dependency(d)}"
 
 def encryption_dependency(d):
-- 
2.43.0



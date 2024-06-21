Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D24AC2BD09
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 10:52:29 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.70161.1718967139026423166
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Jun 2024 03:52:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=f4ychl0s;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20240621105216e1e4e0c7b425b82bf6-etz5fa@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240621105216e1e4e0c7b425b82bf6
        for <cip-dev@lists.cip-project.org>;
        Fri, 21 Jun 2024 12:52:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ZjdepYMROu+i3zRUVIPWq5IWI5dR92DMqn4i48xYn3g=;
 b=f4ychl0s4eZybIDVX70przrJ7wKeZDct8bYPcT4VCMaMsB4lmXiCUZOtVpivdTEIi6UOhP
 ZpsFkZcT9zGaxlEk0Ttsi//wsaaRGYLyEVKCaNMgmN4o1bO5ToeGrzhiF0hG2FtEUsLvhPKk
 1D0EQGbQeWwJ2efDbmmRdtpqXCdrA=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 1/2] doc: Add section howto generate the a efi auth file from snakeoil certs
Date: Fri, 21 Jun 2024 12:12:28 +0200
Message-ID: <20240621105215.2233044-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240621105215.2233044-1-Quirin.Gylstorff@siemens.com>
References: <20240621105215.2233044-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Jun 2024 10:52:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16313

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to test a physical target with the snakeoil keys.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.secureboot.md | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 509de97..c5371ea 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -47,8 +47,7 @@ Supply the script name and path to wic by adding
 
 #### secure-boot-snakeoil
 
-This package uses the snakeoil key and certificate from the ovmf package(0.0~20200229-2)
-backported from Debian bullseye for signing the image.
+This package uses the snakeoil key and certificate from the ovmf packagefrom Debian bullseye or later for signing the image.
 
 #### secure-boot-key
 
@@ -284,7 +283,7 @@ sda              8:0    0     6G  0 disk
 ├─sda1           8:1    0  16.1M  0 part
 ├─sda2           8:2    0    32M  0 part
 ├─sda3           8:3    0    32M  0 part
-├─sda4           8:4    0     1G  0 part
+├─sda4           8:4    0     1G  0 party
 ├─sda5           8:5    0     1G  0 part
 │ └─verityroot 252:0    0 110.9M  1 crypt /
 ├─sda6           8:6    0   1.3G  0 part  /home
@@ -295,6 +294,18 @@ sda              8:0    0     6G  0 disk
 
 Secureboot for a generic UEFI x86 target works similar to the QEMU target,
 except the enrollment of the secure boot keys.
+### Generate keys from Debian snakeoil keys
+
+For testing the snakeoil keys from OVMF package can be used to convert the certitificate
+into a efi authority file use the following commands:
+```bash
+cert-to-efi-sig-list recipes-devtools/secure-boot-secrets/files/bookworm/PkKek-1-snakeoil.pem PK.esl
+sign-efi-sig-list -k recipes-devtools/secure-boot-secrets/files/bookworm/PkKek-1-snakeoil.key -c recipes-devtools/secure-boot-secrets/files/bookworm/PkKek-1-snakeoil.pem PK PK.esl PK.auth
+```
+
+#### Prerequisites
+ The package `efitools` needs to be installed.
+
 
 ### Secure boot key enrollment
 
@@ -316,6 +327,9 @@ Use the recipes [secure-boot-key](###secure-boot-key) to provided the keys
 to the signing script contained in
 [ebg-secure-boot-signer](###ebg-secure-boot-signer).
 
+
+
+
 ### [ebg-secure-boot-signer](./recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb)
 
 During building a efibootguard based wic image the scripts contained in
-- 
2.43.0



Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.696.1792731670629272362
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Oct 2026 22:01:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=shivanand.kunijadar.v45@mail.toshiba header.s=key2.smx header.b=RPJrRvyH;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: shivanand.kunijadar.v45@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;i=
	shivanand.kunijadar.v45@mail.toshiba;s=key2.smx;t=1792731668;x=1793941268;bh=
	Kcs20EnfSsmREzUXAQR7NfTJMZDUb2l9+Vj7At2xR7o=;b=RPJrRvyHFncgpgeM0rELLs0L/a+eo5
	JxfmG3yaTCpn/TCG4DhLVcxbjE7Ks8X9DvSQN7GaB2Gq2UpQ4GouMyX3PT1BxOnIU7v+i3iu6eKg0
	He7XRhVyCO/dyWSKucSDiNGzEvOzxgXiRo1a5SJCld1L7gcJQWxXesoww/FP2FsaT7ZI+egqJNhDt
	EAarcKI7WrFz8xXUhptGOF5vmE8tT3WEhzsP0ApTh57ohmRyBajmk4+aq1xJkmHODIJOszM87ksaQ
	bTnmh5tbAherG64vKjj+gFJXmG6TVu+RbtDmix2wfxYcDKUh4M1pOr2hrLLFHc1FnR8RR9NIJc+fN
	AFWA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 69N518ww3740750; Fri, 23 Oct 2026 14:01:08 +0900
X-Iguazu-Qid: 2yAaXyEeTZFp4GgwuO
X-Iguazu-QSIG: v=2; s=1; t=1792731668; q=2yAaXyEeTZFp4GgwuO; m=L9qwmEI3/Nzc87DVb4GACAbVb6lnkIuozRQ3HPcKYao=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4j9rT00Kdzz1xnq; Fri, 23 Oct 2026 14:01:07 +0900 (JST)
From: shivanand.kunijadar.v45@mail.toshiba
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <shivanand.kunijadar.v45@mail.toshiba>,
        kumar.dinesh.h95@mail.toshiba, kazuhiro.hayashi.f74@mail.toshiba
Subject: [isar-cip-core][PATCH] README.tpm2.encryption.md: Add additional information for SWUpdate case
Date: Fri, 23 Oct 2026 10:16:23 +0530
X-TSB-HOP2: ON
Message-Id: <20261023044623.3269357-1-shivanand.kunijadar.v45@mail.toshiba>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Oct 2026 05:01:05.0538 (UTC) FILETIME=[82439620:01DD62AB]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 23 Oct 2026 05:01:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24518
Content-Type: text/plain; charset="utf-8"

From: Shivanand Kunijadar <shivanand.kunijadar.v45@mail.toshiba>

This adds the additional information with diagram which shows how to
apply the SWUpdate safely for a system already running without encryption
support.

Closes https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/161

Signed-off-by: Shivanand Kunijadar <shivanand.kunijadar.v45@mail.toshiba>
---
Refer the rendered mermaid diagram in the update here https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/161#note_3928442286

 doc/README.tpm2.encryption.md | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
index 6ae2c89..209b750 100644
--- a/doc/README.tpm2.encryption.md
+++ b/doc/README.tpm2.encryption.md
@@ -88,6 +88,34 @@ The data partition in the fallback system will have the `noencrypt` flag set, wh
 - Update fails at a later point and is not blessed; system reboots into the fallback system on slot A.
 - Fallback system now needs to be able to use the shared data partition.
 
+Example:
+
+```mermaid
+flowchart LR
+
+    S1["Step 1: Field State (v1)<br/>Slot A: Active<br/>Flag: none<br/>Slot B: Inactive<br/>Flag: none<br/>Shared Data: Unencrypted"]
+
+    S2["Step 2: Apply SWUpdate (v2 with noencrypt)<br/>Slot A: Inactive<br/>Flag: none<br/>Slot B: Active<br/>Flag: noencrypt<br/>Shared Data: Unencrypted"]
+
+    S3["Step 3: Apply SWUpdate (v3 with reencrypt)<br/>Slot A: Inactive<br/>Flag: reencrypt<br/>Slot B: Active<br/>Flag: noencrypt<br/>Shared Data: Unencrypted"]
+
+    SUCCESSFUL["Case 1: Applied successfully <br/> <br/>Slot A: Active<br/>Flag: reencrypt<br/>Slot B: Inactive<br/>Flag: noencrypt<br/>Shared Data: Encrypted"]
+
+    UNSUCCESSFUL["Case 2: Failure after encrypting shared partitions <br/> <br/> Rollback to Slot B<br/>Slot A: Inactive<br/>Flag: reencrypt<br/>Slot B: Active<br/>Flag: noencrypt<br/>Shared Data: Encrypted"]
+
+    OK["noencrypt flag prevents re-encryption<br/>  <br/> Encrypted data remains<br/>accessible"]
+
+    S1 --> S2
+    S2 --> S3
+    S3 --> SUCCESSFUL
+    S3 --> UNSUCCESSFUL
+    UNSUCCESSFUL --> OK
+```
+
+* v1 (field state): cannot decrypt
+* v2 (intermediate update): could decrypt, but must not encrypt so that rollback to v1 still work
+* v3 (final update): can decrypt, thus encrypts, and rollback to v2 would still be possible
+
 In this case, where encryption is added via an update, the `format-if-empty` option is also useful. The system with encryption enabled has the `format-if-empty` option set for the partition(s) in the inactive update slot. This will cause both sets of partitions in both slots to be encrypted after the first boot on a fresh factory flashed system, but will not disturb existing data of any fallback system if booted after an update.
 
 ### CRYPT_CREATE_FILE_SYSTEM_CMD
-- 
2.39.5



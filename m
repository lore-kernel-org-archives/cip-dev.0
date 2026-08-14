Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81056C5CFDB
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 13:01:47 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12361.1786712503353958154
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Aug 2026 06:01:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=gilMkqDy;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-294854-202608141301400f7926df8b00020710-vdzx5q@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202608141301400f7926df8b00020710
        for <cip-dev@lists.cip-project.org>;
        Fri, 14 Aug 2026 15:01:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ugF8KbMdqNE8RCh09uPeuUslOP9ZmRDgKnl+ZllY6fk=;
 b=gilMkqDyCqouqAO2JQ1crmUtnkHciYJf5WzkFmP8GusPL2GlnPKm1OuVTCWZNqCRuFciLJ
 OBdAai6/27I6ndbpaSKyJA7e7JmK6H3vLQngn5a/dc1wQaO/CDI1SG80PxxxWKCO3bo74VlN
 roj/eaFqd4cLiz0Ga5lxwUdZ8IyFoCxhVRyvmPr8/O32bUJrmbWapZ9/f1eKxBAWbYlPERG6
 Yo3/Y1CPOUJeCIV13E+ZX+uvAvDz9slfyF1o2nkAu5O4iAYweJFTBewS/ndlbrtVM7DtsL2Q
 RmdsI4gnuZGpgLd2yaSk6ouQxVgalsBCIBL2RYk86QssIYjhCTyN9wog==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Sven Bauer <svenbauer@siemens.com>,
	Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
Subject: [isar-cip-core][PATCH 4/4] optee-ftpm: Apply security fixes for V184
Date: Fri, 14 Aug 2026 15:01:39 +0200
Message-ID: <a8dd70a204be4e6e130ff817636ab4b771702aa4.1786712498.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1786712498.git.jan.kiszka@siemens.com>
References: <cover.1786712498.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Aug 2026 13:01:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23938

From: Jan Kiszka <jan.kiszka@siemens.com>

Apply the nicely PDF-formatted code fixes for the two recently published
CVE-2026-6726 and CVE-2026-6727 of the TPM reference implementation.
They affect any currently released version - there is no release of the
code for V185 yet.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...1-Address-improper-object-slot-reuse.patch | 95 +++++++++++++++++++
 ...EP-timing-side-channel-vulnerability.patch | 46 +++++++++
 .../optee-ftpm/optee-ftpm_4.10+V184.inc       |  2 +
 3 files changed, 143 insertions(+)
 create mode 100644 recipes-bsp/optee-ftpm/files/0001-Address-improper-object-slot-reuse.patch
 create mode 100644 recipes-bsp/optee-ftpm/files/0002-Address-RSA-OAEP-timing-side-channel-vulnerability.patch

diff --git a/recipes-bsp/optee-ftpm/files/0001-Address-improper-object-slot-reuse.patch b/recipes-bsp/optee-ftpm/files/0001-Address-improper-object-slot-reuse.patch
new file mode 100644
index 00000000..d6d24ac0
--- /dev/null
+++ b/recipes-bsp/optee-ftpm/files/0001-Address-improper-object-slot-reuse.patch
@@ -0,0 +1,95 @@
+From 968681772a0ea23f9eb19369b429c680c00c3289 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Thu, 13 Aug 2026 14:35:55 +0200
+Subject: [PATCH 1/2] Address improper object slot reuse
+
+See [1] and [2].
+
+[1] https://trustedcomputinggroup.org/wp-content/uploads/VRT0010-Advisory_Final-1.pdf
+[2] https://trustedcomputinggroup.org/wp-content/uploads/TPM2.0-Library-Spec-184-Errata-1-PUBLISH.pdf
+
+Fixes: CVE-2026-6726
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ TPMCmd/tpm/src/command/AttachedComponent/AC_Send.c   | 4 ++++
+ TPMCmd/tpm/src/command/Attestation/Certify.c         | 4 ++++
+ TPMCmd/tpm/src/command/Attestation/CertifyCreation.c | 4 ++++
+ TPMCmd/tpm/src/command/Object/ActivateCredential.c   | 4 ++++
+ TPMCmd/tpm/src/subsystem/Object.c                    | 1 +
+ 5 files changed, 17 insertions(+)
+
+diff --git a/TPMCmd/tpm/src/command/AttachedComponent/AC_Send.c b/TPMCmd/tpm/src/command/AttachedComponent/AC_Send.c
+index ed1b6ac..6903530 100644
+--- a/TPMCmd/tpm/src/command/AttachedComponent/AC_Send.c
++++ b/TPMCmd/tpm/src/command/AttachedComponent/AC_Send.c
+@@ -52,6 +52,10 @@ TPM2_AC_Send(AC_Send_In*  in,  // IN: input parameter list
+     // permanent handle.
+     else if(HandleGetType(in->authHandle) != TPM_HT_PERMANENT)
+         return TPM_RCS_HANDLE + RC_AC_Send_authHandle;
++
++    // Cannot send a sequence object to an attached component
++    if(ObjectIsSequence(object))
++        return TPM_RCS_TYPE + RC_AC_Send_sendObject;
+     // Make sure that the object to be duplicated has the right attributes
+     if(IS_ATTRIBUTE(
+            object->publicArea.objectAttributes, TPMA_OBJECT, encryptedDuplication)
+diff --git a/TPMCmd/tpm/src/command/Attestation/Certify.c b/TPMCmd/tpm/src/command/Attestation/Certify.c
+index f879ade..32b91c8 100644
+--- a/TPMCmd/tpm/src/command/Attestation/Certify.c
++++ b/TPMCmd/tpm/src/command/Attestation/Certify.c
+@@ -28,6 +28,10 @@ TPM2_Certify(Certify_In*  in,  // IN: input parameter list
+     if(!CryptSelectSignScheme(signObject, &in->inScheme))
+         return TPM_RCS_SCHEME + RC_Certify_inScheme;
+ 
++    // Cannot certify a sequence object
++    if(ObjectIsSequence(certifiedObject))
++        return TPM_RCS_TYPE + RC_Certify_objectHandle;
++
+     // Command Output
+     // Filling in attest information
+     // Common fields
+diff --git a/TPMCmd/tpm/src/command/Attestation/CertifyCreation.c b/TPMCmd/tpm/src/command/Attestation/CertifyCreation.c
+index d44975f..8d2a8cb 100644
+--- a/TPMCmd/tpm/src/command/Attestation/CertifyCreation.c
++++ b/TPMCmd/tpm/src/command/Attestation/CertifyCreation.c
+@@ -26,6 +26,10 @@ TPM2_CertifyCreation(CertifyCreation_In*  in,  // IN: input parameter list
+     OBJECT*          certified  = HandleToObject(in->objectHandle);
+     OBJECT*          signObject = HandleToObject(in->signHandle);
+     // Input Validation
++    // Cannot certify creation of a sequence object
++    if(ObjectIsSequence(certified))
++        return TPM_RCS_TYPE + RC_CertifyCreation_objectHandle;
++
+     if(!IsSigningObject(signObject))
+         return TPM_RCS_KEY + RC_CertifyCreation_signHandle;
+     if(!CryptSelectSignScheme(signObject, &in->inScheme))
+diff --git a/TPMCmd/tpm/src/command/Object/ActivateCredential.c b/TPMCmd/tpm/src/command/Object/ActivateCredential.c
+index a46b234..d0a05ad 100644
+--- a/TPMCmd/tpm/src/command/Object/ActivateCredential.c
++++ b/TPMCmd/tpm/src/command/Object/ActivateCredential.c
+@@ -43,6 +43,10 @@ TPM2_ActivateCredential(ActivateCredential_In*  in,  // IN: input parameter list
+        || !IS_ATTRIBUTE(object->publicArea.objectAttributes, TPMA_OBJECT, restricted))
+         return TPM_RCS_TYPE + RC_ActivateCredential_keyHandle;
+ 
++    // Cannot activate credential of sequence object
++    if(ObjectIsSequence(activateObject))
++        return TPM_RCS_TYPE + RC_ActivateCredential_activateHandle;
++
+     // Command output
+ 
+     // Decrypt input credential data via asymmetric decryption.  A
+diff --git a/TPMCmd/tpm/src/subsystem/Object.c b/TPMCmd/tpm/src/subsystem/Object.c
+index 171d02d..b55cf26 100644
+--- a/TPMCmd/tpm/src/subsystem/Object.c
++++ b/TPMCmd/tpm/src/subsystem/Object.c
+@@ -16,6 +16,7 @@
+ // Note: This could be converted to a macro.
+ void ObjectFlush(OBJECT* object)
+ {
++    MemorySet(object, 0, sizeof(*object));
+     object->attributes.occupied = CLEAR;
+ }
+ 
+-- 
+2.47.3
+
diff --git a/recipes-bsp/optee-ftpm/files/0002-Address-RSA-OAEP-timing-side-channel-vulnerability.patch b/recipes-bsp/optee-ftpm/files/0002-Address-RSA-OAEP-timing-side-channel-vulnerability.patch
new file mode 100644
index 00000000..11c7cd48
--- /dev/null
+++ b/recipes-bsp/optee-ftpm/files/0002-Address-RSA-OAEP-timing-side-channel-vulnerability.patch
@@ -0,0 +1,46 @@
+From 48aca7aa16490013933472d8d32f355209ea0fb8 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Thu, 13 Aug 2026 14:49:16 +0200
+Subject: [PATCH 2/2] Address RSA OAEP timing side-channel vulnerability
+
+See [1] and [2].
+
+[1] https://trustedcomputinggroup.org/wp-content/uploads/VRT0011-Advisory_Final-1.pdf
+[2] https://trustedcomputinggroup.org/wp-content/uploads/TPM2.0-Library-Spec-184-Errata-1-PUBLISH.pdf
+
+Fixes: CVE-2026-6727
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ TPMCmd/tpm/src/crypt/CryptRsa.c | 9 ++++++---
+ 1 file changed, 6 insertions(+), 3 deletions(-)
+
+diff --git a/TPMCmd/tpm/src/crypt/CryptRsa.c b/TPMCmd/tpm/src/crypt/CryptRsa.c
+index fdbdeda..19b8b2c 100644
+--- a/TPMCmd/tpm/src/crypt/CryptRsa.c
++++ b/TPMCmd/tpm/src/crypt/CryptRsa.c
+@@ -381,8 +381,7 @@ static TPM_RC OaepDecode(
+     TPM_RC retVal = TPM_RC_SUCCESS;
+ 
+     // Strange size (anything smaller can't be an OAEP padded block)
+-    // Also check for no leading 0
+-    if((padded->size < (unsigned)((2 * hLen) + 2)) || (padded->buffer[0] != 0))
++    if(padded->size < (unsigned)((2 * hLen) + 2))
+         ERROR_EXIT(TPM_RC_VALUE);
+     // Use the hash size to determine what to put through MGF1 in order
+     // to recover the seedMask
+@@ -414,7 +413,11 @@ static TPM_RC OaepDecode(
+     if((CryptHashBlock(hashAlg, label->size, (BYTE*)label->buffer, hLen, seedMask))
+        != hLen)
+         FAIL(FATAL_ERROR_INTERNAL);
+-    if(memcmp(seedMask, mask, hLen) != 0)
++    if(!MemoryEqual(seedMask, mask, hLen))
++        ERROR_EXIT(TPM_RC_VALUE);
++
++    // Check for the leading 0x00 byte.
++    if(padded->buffer[0] != 0)
+         ERROR_EXIT(TPM_RC_VALUE);
+ 
+     // find the start of the data
+-- 
+2.47.3
+
diff --git a/recipes-bsp/optee-ftpm/optee-ftpm_4.10+V184.inc b/recipes-bsp/optee-ftpm/optee-ftpm_4.10+V184.inc
index 802ce54f..e11d33df 100644
--- a/recipes-bsp/optee-ftpm/optee-ftpm_4.10+V184.inc
+++ b/recipes-bsp/optee-ftpm/optee-ftpm_4.10+V184.inc
@@ -18,6 +18,8 @@ SRC_URI += " \
     file://0001-Update-to-TPM-2.0-Reference-Implementation-v184.patch \
     file://0002-Disable-command-TPM2_CertifyX509.patch \
     https://github.com/TrustedComputingGroup/TPM/archive/${SRCREV_tpm}.tar.gz;name=tpm;downloadfilename=tpm-${SRCREV_tpm}.tar.gz \
+    file://0001-Address-improper-object-slot-reuse.patch;patchdir=${WORKDIR}/${MS_TPM_20_REF_DIR} \
+    file://0002-Address-RSA-OAEP-timing-side-channel-vulnerability.patch;patchdir=${WORKDIR}/${MS_TPM_20_REF_DIR} \
     "
 SRCREV = "a09269b15de635e1816fe832e26adfbfb44c5455"
 SRCREV_tpm = "bc29a21d44b01396223c152a4834e52318591770"
-- 
2.47.3



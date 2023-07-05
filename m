Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AE2C001B3
	for <webhook@archiver.kernel.org>; Wed,  5 Jul 2023 07:34:14 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.11641.1688542447511975572
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jul 2023 00:34:08 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 3657Y5n62817823; Wed, 5 Jul 2023 16:34:06 +0900
X-Iguazu-Qid: 2yAb9zVTfChbqmwuJM
X-Iguazu-QSIG: v=2; s=0; t=1688542445; q=2yAb9zVTfChbqmwuJM; m=zNGvfubHzivCDiHGB7raNlg5peTrqawNM/LxTW47f8U=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 3657Y4ha1447077
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 5 Jul 2023 16:34:05 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 2/2] cip-core-image-security.bb : Add pam-passwdqc package for bookworm
Date: Wed,  5 Jul 2023 13:03:58 +0530
X-TSB-HOP2: ON
Message-Id: <20230705073358.16663-3-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230705073358.16663-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20230705073358.16663-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Jul 2023 07:34:00.0720 (UTC) FILETIME=[10EAC100:01D9AF13]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Jul 2023 07:34:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12227

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

libpam-cracklib is deprecated in Debian 12, so libpam-passwdqc package is used
instead when bookworm is selected with security extensions.

The configuration in the postinst file is also handled with a condition based
on the respective "pam_(passwdqc | cracklib).so" file.

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 recipes-core/images/cip-core-image-security.bb  |  9 ++++++---
 .../security-customizations/files/postinst      | 17 ++++++++++++++---
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
index 563de89..3421ce5 100644
--- a/recipes-core/images/cip-core-image-security.bb
+++ b/recipes-core/images/cip-core-image-security.bb
@@ -27,7 +27,6 @@ IMAGE_PREINSTALL += " \
 	chrony \
 	tpm2-tools \
 	tpm2-abrmd \
-	libpam-cracklib \
 	acl \
 	audispd-plugins auditd \
 	uuid-runtime \
@@ -41,8 +40,12 @@ IMAGE_PREINSTALL += " \
 "
 
 # Package names based on the distro version
-IMAGE_PREINSTALL:append:buster = " libtss2-esys0"
-IMAGE_PREINSTALL:append:bullseye = " libtss2-esys-3.0.2-0"
+IMAGE_PREINSTALL:append:buster = " libtss2-esys0 \
+                                   libpam-cracklib"
+IMAGE_PREINSTALL:append:bullseye = " libtss2-esys-3.0.2-0 \
+                                     libpam-cracklib"
+IMAGE_PREINSTALL:append:bookworm = " libtss2-esys-3.0.2-0 \
+                                     libpam-passwdqc"
 
 CIP_IMAGE_OPTIONS ?= ""
 require ${CIP_IMAGE_OPTIONS}
diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
index f7dd18c..5245592 100644
--- a/recipes-core/security-customizations/files/postinst
+++ b/recipes-core/security-customizations/files/postinst
@@ -15,11 +15,22 @@ echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
 # CR1.7: Strength of password-based authentication
 # Pam configuration to  enforce password strength
 PAM_PWD_FILE="/etc/pam.d/common-password"
-pam_cracklib_config="password  requisite    pam_cracklib.so retry=3 minlen=8 maxrepeat=3 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1  difok=3 gecoscheck=1 reject_username  enforce_for_root"
-if grep -c "pam_cracklib.so" "${PAM_PWD_FILE}";then
+if grep -c "pam_passwdqc.so" "${PAM_PWD_FILE}";then
+	# Password strength is defined as it should have atleast 8 characters length and with 4 character classes (uppercase, lowercase, digit and other characters)
+	# Same is set in passwdqc configuration with `min=N0,N1,N2,N3,N4`
+	# N0, N1, N3  are disabled, to not to accept password with only one, two or three character classes
+	# N2 is disabled for passphrases since we have no restriction for the minimum length of passphrase.
+	# N4 is set to 8 to accept the passowrd length atleast 8 characters and with four character class combinations.
+        pam_passwdqc_config="password    requisite    pam_passwdqc.so min=disabled,disabled,disabled,disabled,8 similar=deny random=0 enforce=everyone retry=3"
+        sed -i '/pam_passwdqc.so/ s/^#*/#/'  "${PAM_PWD_FILE}"
+        sed -i "0,/^password.*/s/^password.*/${pam_passwdqc_config}\n&/" "${PAM_PWD_FILE}"
+elif grep -c "pam_cracklib.so" "${PAM_PWD_FILE}";then
+        pam_cracklib_config="password  requisite    pam_cracklib.so retry=3 minlen=8 maxrepeat=3 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1  difok=3 gecoscheck=1 reject_username  enforce_for_root"
         sed -i '/pam_cracklib.so/ s/^#*/#/'  "${PAM_PWD_FILE}"
+        sed -i "0,/^password.*/s/^password.*/${pam_cracklib_config}\n&/" "${PAM_PWD_FILE}"
+else
+        echo "No suitable pam module found to enforce password strength"
 fi
-sed -i "0,/^password.*/s/^password.*/${pam_cracklib_config}\n&/" "${PAM_PWD_FILE}"
 
 # CR1.11: Unsuccessful login attempts
 # Lock user account after unsuccessful login attempts
-- 
2.20.1




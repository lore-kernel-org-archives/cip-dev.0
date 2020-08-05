Return-Path: <SRS0=S5eb=BP=lists.cip-project.org=bounce+64572+5101+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4501C433E0
	for <cip-dev@archiver.kernel.org>; Wed,  5 Aug 2020 13:03:21 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C22722D00
	for <cip-dev@archiver.kernel.org>; Wed,  5 Aug 2020 13:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="rstFS+ZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C22722D00
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5101+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id mR2MYY4521723xEMNxmUiwCa; Wed, 05 Aug 2020 06:03:21 -0700
X-Received: from peak.toshiba-tesi.com (peak.toshiba-tesi.com [202.56.254.199])
 by mx.groups.io with SMTP id smtpd.web11.6626.1596632599684555108
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Aug 2020 06:03:20 -0700
IronPort-SDR: WMrmSDunjMRip9fOwH6JsoecQrOsh0BUXQBIEDDlmEBtX/+wHKvnyWoJMnHwbpiGFLw3CliZBY
 oJPh83CgyKUQ==
X-IronPort-AV: E=Sophos;i="5.75,436,1589221800"; 
   d="scan'208";a="5375237"
X-Received: from unknown (HELO TOSBLRMBX0519.TOSHIBA-TSIP.COM) ([10.116.85.29])
  by peak.toshiba-tesi.com with ESMTP; 05 Aug 2020 19:08:54 +0530
X-Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) by
 TOSBLRMBX0519.TOSHIBA-TSIP.COM (10.116.85.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 5 Aug 2020 18:33:12 +0530
X-Received: from pvenkat.TOSHIBA-TSIP.COM (172.28.80.121) by
 TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) with Microsoft SMTP Server id
 15.1.1847.3 via Frontend Transport; Wed, 5 Aug 2020 18:33:11 +0530
From: "Venkata Pyla" <venkata.pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>
CC: venkata pyla <venkata.pyla@toshiba-tsip.com>,
	<cip-dev@lists.cip-project.org>, <cip-security@lists.cip-project.org>
Subject: [cip-dev] [isar-cip-core] security-customizations: Recipe to apply security configurations
Date: Wed, 5 Aug 2020 18:34:11 +0530
Message-ID: <20200805130412.1427-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: LghY0RSPeYEoDIIeXaZz7TdVx4520388AA=
Content-Type: multipart/mixed; boundary="Gv03mUbiIpyldXB5nnDK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596632601;
 bh=13NdlaU7CUsNTVk32xOlm2/2w5vtILFCkg4K++e4DgY=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=rstFS+ZRwkthl4xdZMZDHoPtFic/ntHfcxEWr2+zPxOl3eZ6T7cf6Hs4adgmdMIPLSR
 MRZHite65gj5a09qtjzCpY4cFFEc7PWanDVgsfa81BILxMCCwsobegZmT+Q9XfcGN796m
 HRkAA2fI3yuJqqJCoXjo4z6+3nRPxTJU3DE=

--Gv03mUbiIpyldXB5nnDK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

This recipe will apply security policies* to the reference image
that will be used for IEC62443-4-2 Evaluation

*Security policies:
 1. Enforcing strong password to user accounts
 2. Lock user accounts for failed login attempts
 3. Terminate remote session for inactive time period
 4. Limit the concurrent login sessions
 5. Warn audit stroage failure

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .../images/cip-core-image-security.bb         |  2 +-
 .../security-customizations/files/postinst    | 51 +++++++++++++++++++
 .../security-customizations.bb                | 18 +++++++
 3 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 recipes-core/security-customizations/files/postinst
 create mode 100644 recipes-core/security-customizations/security-customizations.bb

diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
index a17c522..61ddc39 100644
--- a/recipes-core/images/cip-core-image-security.bb
+++ b/recipes-core/images/cip-core-image-security.bb
@@ -13,7 +13,7 @@ inherit image
 
 DESCRIPTION = "CIP Core image including security packages"
 
-IMAGE_INSTALL += "customizations"
+IMAGE_INSTALL += "security-customizations"
 
 # Debian packages that provide security features
 IMAGE_PREINSTALL += " \
diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
new file mode 100644
index 0000000..3699ba2
--- /dev/null
+++ b/recipes-core/security-customizations/files/postinst
@@ -0,0 +1,51 @@
+#!/bin/sh
+#
+# CIP Security, generic profile
+# Security Package configurations
+#
+
+echo "CIP Core Security Image (login: root/root)" > /etc/issue
+
+HOSTNAME=demo
+echo "$HOSTNAME" > /etc/hostname
+echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
+
+# CR1.7: Strength of password-based authentication
+# Pam configuration to  enforce password strength
+PAM_PWD_FILE="/etc/pam.d/common-password"
+pam_cracklib_config="password  requisite    pam_cracklib.so retry=3 minlen=8 maxrepeat=3 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1  difok=3 gecoscheck=1 reject_username  enforce_for_root"
+if grep -c "pam_cracklib.so" "${PAM_PWD_FILE}";then
+        sed -i '/pam_cracklib.so/ s/^#*/#/'  "${PAM_PWD_FILE}"
+fi
+sed -i "0,/^password.*/s/^password.*/${pam_cracklib_config}\n&/" "${PAM_PWD_FILE}"
+
+# CR1.11: Unsuccessful login attempts
+# Lock user account after unsuccessful login attempts
+PAM_AUTH_FILE="/etc/pam.d/common-auth"
+pam_tally="auth   required  pam_tally2.so  deny=3 even_deny_root unlock_time=60 root_unlock_time=60"
+if grep -c "pam_tally2.so" "${PAM_AUTH_FILE}";then
+        sed -i '/pam_tally2/ s/^#*/#/'  "${PAM_AUTH_FILE}"
+fi
+sed -i "0,/^auth.*/s/^auth.*/${pam_tally}\n&/" "${PAM_AUTH_FILE}"
+
+# CR2.6: Remote session termination
+# Terminate remote session after inactive time period
+SSHD_CONFIG="/etc/ssh/sshd_config"
+alive_interval=$(sed -n '/ClientAliveInterval/p' "${SSHD_CONFIG}")
+alive_countmax=$(sed -n '/ClientAliveCountMax/p' "${SSHD_CONFIG}")
+sed -i "/${alive_interval}/c ClientAliveInterval 120"  "${SSHD_CONFIG}"
+sed -i "/${alive_countmax}/c ClientAliveCountMax 0" "${SSHD_CONFIG}"
+
+# CR2.7: Concurrent session control
+# Limit the concurrent login sessions
+LIMITS_CONFIG="/etc/security/limits.conf"
+echo "* hard maxlogins 2" >> ${LIMITS_CONFIG}
+
+# CR2.9: Audit storage capacity
+# CR2.9 RE-1: Warn when audit record storage capacity threshold reached
+AUDIT_CONF_FILE="/etc/audit/auditd.conf"
+sed -i 's/space_left_action = .*/space_left_action = SYSLOG/'  $AUDIT_CONF_FILE
+sed -i 's/admin_space_left_action = .*/admin_space_left_action = SYSLOG/' $AUDIT_CONF_FILE
+
+# CR2.10: Response to audit processing failures
+sed -i 's/disk_error_action = .*/disk_error_action = SYSLOG/' $AUDIT_CONF_FILE
diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-core/security-customizations/security-customizations.bb
new file mode 100644
index 0000000..dbb06d9
--- /dev/null
+++ b/recipes-core/security-customizations/security-customizations.bb
@@ -0,0 +1,18 @@
+#
+# CIP Security, generic profile
+#
+# Copyright (c) Toshiba Corporation, 2020
+#
+# Authors:
+#  Venkata Pyla <venkata.pyla@toshiba-tsip.com>#
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg-raw
+
+DESCRIPTION = "CIP Security image for IEC62443-4-2 evaluation"
+
+SRC_URI = " file://postinst"
+
+DEBIAN_DEPENDS = "sshd-regen-keys"
-- 
2.20.1

The information contained in this e-mail message and in any
attachments/annexure/appendices is confidential to the 
recipient and may contain privileged information. 
If you are not the intended recipient, please notify the
sender and delete the message along with any 
attachments/annexure/appendices. You should not disclose,
copy or otherwise use the information contained in the
message or any annexure. Any views expressed in this e-mail 
are those of the individual sender except where the sender 
specifically states them to be the views of 
Toshiba Software India Pvt. Ltd. (TSIP),Bangalore.

Although this transmission and any attachments are believed to be
free of any virus or other defect that might affect any computer 
system into which it is received and opened, it is the responsibility
of the recipient to ensure that it is virus free and no responsibility 
is accepted by Toshiba Embedded Software India Pvt. Ltd, for any loss or
damage arising in any way from its use.


--Gv03mUbiIpyldXB5nnDK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5101): https://lists.cip-project.org/g/cip-dev/message=
/5101
Mute This Topic: https://lists.cip-project.org/mt/76006733/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Gv03mUbiIpyldXB5nnDK--

Return-Path: <SRS0=lUNe=CY=lists.cip-project.org=bounce+64572+5454+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530E5C433E2
	for <cip-dev@archiver.kernel.org>; Tue, 15 Sep 2020 14:22:59 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF8422269
	for <cip-dev@archiver.kernel.org>; Tue, 15 Sep 2020 14:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="dat89d1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF8422269
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5454+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id F8kDYY4521723xxuroImmli5; Tue, 15 Sep 2020 07:22:58 -0700
X-Received: from peak.toshiba-tesi.com (peak.toshiba-tesi.com [])
 by mx.groups.io with SMTP id smtpd.web10.14564.1600179768333343159
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Sep 2020 07:22:57 -0700
IronPort-SDR: nCC+nmFIAPTI74eUzZl3Cq0RY5drO12Gi+KbK/VYDcFndmX/Zpzs7wXzJw6KWcJHvEL9gvqy7c
 5WW2h03CMqsg==
X-IronPort-AV: E=Sophos;i="5.76,430,1592850600"; 
   d="scan'208";a="6248128"
X-Received: from unknown (HELO TOSBLRMBX0119.TOSHIBA-TSIP.COM) ([172.28.80.118])
  by peak.toshiba-tesi.com with ESMTP; 15 Sep 2020 20:33:47 +0530
X-Received: from TOSBLRMBX0319.TOSHIBA-TSIP.COM (172.28.80.120) by
 TOSBLRMBX0119.TOSHIBA-TSIP.COM (172.28.80.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 15 Sep 2020 19:52:54 +0530
X-Received: from pvenkat.TOSHIBA-TSIP.COM (172.28.80.121) by
 TOSBLRMBX0319.TOSHIBA-TSIP.COM (172.28.80.120) with Microsoft SMTP Server id
 15.1.1847.3 via Frontend Transport; Tue, 15 Sep 2020 19:52:51 +0530
From: "Venkata Pyla" <venkata.pyla@toshiba-tsip.com>
To: <daniel.sangorrin@toshiba.co.jp>
CC: venkata pyla <venkata.pyla@toshiba-tsip.com>,
	<cip-dev@lists.cip-project.org>
Subject: [cip-dev] [cip-core:deby 2/3] security-configuration: apply security polcies using package bbappend
Date: Tue, 15 Sep 2020 19:53:43 +0530
Message-ID: <20200915142345.179-3-venkata.pyla@toshiba-tsip.com>
In-Reply-To: <20200915142345.179-1-venkata.pyla@toshiba-tsip.com>
References: <20200915142345.179-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: gfNWrdHzgvvojqh903DP0mnYx4520388AA=
Content-Type: multipart/mixed; boundary="k016xP0hsogVbBEQ6cN2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1600179778;
 bh=bk7Bhn7iGhJy0O7hrfDhbrlN8zZXfZyMmA6ZvA/mwCM=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=dat89d1usQYvmQ7ZaKk2s2zq0sipewcn0z7WG3Bmwx+e7P62XYiPCS5AgHR02o8K31t
 4Z2mQNSUsg7rbZcN/Ti1tGXrJwMfq4cL4f7iskwRyMbHXGe4pg7kk4wmTJ4T1tMRFPxgT
 A9QYNaQ4x/oeqKMhK438JJw6iPuaRkBId/8=

--k016xP0hsogVbBEQ6cN2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

add package bbappaned files in the security layer that will apply
the security configurations like
    e.g: Set password strength in pam configurations
         Set audit failure actions in audit package configurations
         etc.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .../audit/audit_debian.bbappend               | 20 ++++++++++
 .../base-files/base-files_debian.bbappend     |  3 ++
 .../openssh/openssh_debian.bbappend           | 19 +++++++++
 .../recipes-debian/pam/libpam_debian.bbappend | 39 +++++++++++++++++++
 4 files changed, 81 insertions(+)
 create mode 100644 meta-cip-security/recipes-debian/audit/audit_debian.bbappend
 create mode 100644 meta-cip-security/recipes-debian/base-files/base-files_debian.bbappend
 create mode 100644 meta-cip-security/recipes-debian/openssh/openssh_debian.bbappend
 create mode 100644 meta-cip-security/recipes-debian/pam/libpam_debian.bbappend

diff --git a/meta-cip-security/recipes-debian/audit/audit_debian.bbappend b/meta-cip-security/recipes-debian/audit/audit_debian.bbappend
new file mode 100644
index 0000000..c148f27
--- /dev/null
+++ b/meta-cip-security/recipes-debian/audit/audit_debian.bbappend
@@ -0,0 +1,20 @@
+#
+# CIP Security, tiny profile
+#
+# Copyright (c) Toshiba Corporation, 2020
+#
+# SPDX-License-Identifier: MIT
+#
+
+DESCRIPTION = "CIP Security customizations"
+
+pkg_postinst_audit_append() {
+	# CR2.9: Audit storage capacity
+	# CR2.9 RE-1: Warn when audit record storage capacity threshold reached
+	AUDIT_CONF_FILE="$D${sysconfdir}/audit/auditd.conf"
+	sed -i 's/space_left_action = .*/space_left_action = SYSLOG/'  $AUDIT_CONF_FILE
+	sed -i 's/admin_space_left_action = .*/admin_space_left_action = SYSLOG/' $AUDIT_CONF_FILE
+
+	# CR2.10: Response to audit processing failures
+	sed -i 's/disk_error_action = .*/disk_error_action = SYSLOG/' $AUDIT_CONF_FILE
+}
diff --git a/meta-cip-security/recipes-debian/base-files/base-files_debian.bbappend b/meta-cip-security/recipes-debian/base-files/base-files_debian.bbappend
new file mode 100644
index 0000000..895dc9f
--- /dev/null
+++ b/meta-cip-security/recipes-debian/base-files/base-files_debian.bbappend
@@ -0,0 +1,3 @@
+do_install_append() {
+	echo "${MACHINE}" > ${D}${sysconfdir}/hostname
+}
diff --git a/meta-cip-security/recipes-debian/openssh/openssh_debian.bbappend b/meta-cip-security/recipes-debian/openssh/openssh_debian.bbappend
new file mode 100644
index 0000000..ddd2bfc
--- /dev/null
+++ b/meta-cip-security/recipes-debian/openssh/openssh_debian.bbappend
@@ -0,0 +1,19 @@
+#
+# CIP Security, tiny profile
+#
+# Copyright (c) Toshiba Corporation, 2020
+#
+# SPDX-License-Identifier: MIT
+#
+
+DESCRIPTION = "CIP Security customizations"
+
+pkg_postinst_${PN}_append() {
+	# CR2.6: Remote session termination
+	# Terminate remote session after inactive time period
+	SSHD_CONFIG="$D${sysconfdir}/ssh/sshd_config"
+	alive_interval=$(sed -n '/ClientAliveInterval/p' "${SSHD_CONFIG}")
+	alive_countmax=$(sed -n '/ClientAliveCountMax/p' "${SSHD_CONFIG}")
+	sed -i "/${alive_interval}/c ClientAliveInterval 120"  "${SSHD_CONFIG}"
+	sed -i "/${alive_countmax}/c ClientAliveCountMax 0" "${SSHD_CONFIG}"
+}
diff --git a/meta-cip-security/recipes-debian/pam/libpam_debian.bbappend b/meta-cip-security/recipes-debian/pam/libpam_debian.bbappend
new file mode 100644
index 0000000..c9c1605
--- /dev/null
+++ b/meta-cip-security/recipes-debian/pam/libpam_debian.bbappend
@@ -0,0 +1,39 @@
+#
+# CIP Security, tiny profile
+#
+# Copyright (c) Toshiba Corporation, 2020
+#
+# SPDX-License-Identifier: MIT
+#
+
+DESCRIPTION = "CIP Security customizations"
+
+pkg_postinst_pam-plugin-cracklib_append() {
+	# CR1.7: Strength of password-based authentication
+	# Pam configuration to  enforce password strength
+	PAM_PWD_FILE="$D${sysconfdir}/pam.d/common-password"
+	CRACKLIB_CONFIG="password  requisite    pam_cracklib.so retry=3 minlen=8 maxrepeat=3 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1 difok=3 gecoscheck=1 reject_username enforce_for_root"
+	if grep -c "pam_cracklib.so" "${PAM_PWD_FILE}";then
+		sed -i '/pam_cracklib.so/ s/^#*/#/'  "${PAM_PWD_FILE}"
+	fi
+	sed -i "0,/^password.*/s/^password.*/${CRACKLIB_CONFIG}\n&/" "${PAM_PWD_FILE}"
+}
+
+pkg_postinst_pam-plugin-tally2_append() {
+	# CR1.11: Unsuccessful login attempts
+	# Lock user account after unsuccessful login attempts
+	PAM_AUTH_FILE="$D${sysconfdir}/pam.d/common-auth"
+	pam_tally="auth   required  pam_tally2.so  deny=3 even_deny_root unlock_time=60 root_unlock_time=60"
+	if grep -c "pam_tally2.so" "${PAM_AUTH_FILE}";then
+        	sed -i '/pam_tally2/ s/^#*/#/'  "${PAM_AUTH_FILE}"
+	fi
+	sed -i "0,/^auth.*/s/^auth.*/${pam_tally}\n&/" "${PAM_AUTH_FILE}"
+}
+
+
+pkg_postinst_libpam_append() {
+	# CR2.7: Concurrent session control
+	# Limit the concurrent login sessions
+	LIMITS_CONFIG="$D${sysconfdir}/security/limits.conf"
+	echo "* hard maxlogins 2" >> ${LIMITS_CONFIG}
+}
-- 
2.27.0.windows.1

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


--k016xP0hsogVbBEQ6cN2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5454): https://lists.cip-project.org/g/cip-dev/message=
/5454
Mute This Topic: https://lists.cip-project.org/mt/76865928/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--k016xP0hsogVbBEQ6cN2--

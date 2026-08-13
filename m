Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E2BC5DF68
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 10:39:38 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.36])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16258.1786617575466080224
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2026 03:39:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=wyhwuunm;
 spf=pass (domain: siemens.com, ip: 52.101.83.36, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChKbFl7zmttou9d6l7nmLETjiYR/nQcVHSwm6+utqLJ9jAnsAjDsFX7ZUGJGR+ZUu2ldrfncgoPeDQJWbKJtRlF4XWiEcxIwjlQpBlaqAVMgrEqhNiNSUr4Smo7FHOxS94hg8wrNYL2xJitwF/vRx387ymlNCz7tLYBNT4SJ9Yc0i0LOYKaosGOcgcnXqhacrD9688jAk4rgjCoKg/PsNOG8VIJrZimpnECG0wxtGfsK53q9WNaqFqudP8ilbx/G+Sq5b+PkGvz+c8WeP+8imvKmdrTCrml/TY/izF2+hmkmceevP4wZG6qnyfgdkX4Qvdek5uE5hu72dB5pYus5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVtU0H75/7+9udEDPJbtCnAG8r9FOVsoi8fPr2VS0+A=;
 b=h7iDjF/7MBhXw6CuHP3RPtor5ctZWWrbJRmGKrMC3FseHeEg0573h+VsBVDx4MZM43c/Cv5bFC7W2DiObwhWISsgm2CiphfJGsD0BEIu49L972UeIHkQG5ufhWBJvOKPPj/xsyr03YsWaloD6s6LuTsHbfUa2i7+QbyPBJH9+u7NIyENzfQQNwcff9PNhBDHy8SkhTjYj6u/XmoTyQ2OLhWF4Sa4ByFGbEw8Gv/+QEGjakyLn3VElUmd2MUphhfvM2hzx8z2OyOKNFHoSBVb59D+8acfa2bsna1fIa7Y5skiJ3URW9+y0cBlhRqNyUPhChwONz1z5JhlqAYhKsGZFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVtU0H75/7+9udEDPJbtCnAG8r9FOVsoi8fPr2VS0+A=;
 b=wyhwuunm2SnKkgpkloAjAvGrlHhXPeKFx1NHdfjfCXJWzdrWWMVaZIkF4y0pgIofw0nTpDRSlw6nWplPS/Q1kR53U2VkrqU8JlADMLXbmcCBz0S+Cq+vmNr/YL2xHw/Ck+Fw+u93zpFc3cqhAQha6mQL/ODkdxDRR+LuZBKMgqj3IKcJfqC4+JsWvHRadHH+vvl0mw+heQ08nAK+mtvkQeueHrKfaR9APY0nhr8+gdc7YzZ6lDnO/PBda5jtQKUafFCH29B5SH08OG9oS+U9vs/8Kzqn9dVl043KPBTtovLBipQOH6Ze33bMUWutDscHrO0GLOcJxlZUn1+zyU3WlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by VI0PR10MB8693.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:23a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 10:39:30 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 10:39:30 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	dinesh.kumar@toshiba-tsip.com
Subject: [cip-dev][isar-cip-core][PATCH v2 05/12] Add cis-validation to validate the hardening based on the CIS rules
Date: Thu, 13 Aug 2026 12:38:55 +0200
Message-ID: <20260813103919.184402-6-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813103919.184402-1-quirin.gylstorff@siemens.com>
References: <20260813103919.184402-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|VI0PR10MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 6534840c-9b7f-458b-5fbf-08def92727f1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|22082099003|18002099003|55112099003|56012099006|11063799006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: 
	C9frAHSUpresoW/UqTj7Jh7SYTdDaeJOTAlKWL3sY0kO/vQbAjaCc+JzQG9t1jxCDUe8TzivcLLJ4aqv941ReIgdRb3HMbFvJerpS6SeAnwqT0xtPwNSiWrWXLxQrtE1XuRv3W837eP9CwG9fQ/tW7A0q3iOhG/cner9XAOWIF3SwX6Nrm635m9ifBGbxMK0NCbF2osOoIZwyluozGeF4uid9Vry5q7zTwVdgOeT8t87yfwGSSbzpuIOxy4SVZ3s+4rINL35hoDs/fnqWdcuFbHXa3SMI/ekHwAEtFLLmXGEIppnX0GKL00Re79xb8oC8drGOlTuB5d83pLKs9YUrLLetPIUyIObxyDrq8ieLpm6rDSYfO+r/5OuPccPpndfJuQvAUkvvqtZO/OyybhZh9DDNQvYtfxfmEzdidEza1Qu1FCiRWopyE+N5M76K9OT+rPdwEFbdL7UM4FMDW1qG+osdNb9N2uy1aDRpUvnha7/7YTAmjKc/ln9Xo5ANd47g7yfkgp9noQFYdVPv82holtn5syP+hAlyMFHa+Wzq1xgDxqQi9EpkGApp4qIATb0TExCyyHCpi9xI/YVJsaFZEVLT7ffKQCfc3zxvzRre48fIB0Tl3zFXFH1XpzjZR8Tfc5tv1Tn2T0lo5c/ieQP+dEopcBBhWpFvhq4uC4Dv2U=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(55112099003)(56012099006)(11063799006)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iQzgfp4wmMbZm45sEU1Ipky2xJCLzkuxfPcEv9w0Em5dew+buMheW65XhK11?=
 =?us-ascii?Q?KvXRfLQ5oSlcDZ9uXqqwwE1yFpQeLWAzvfrQYenyrI7eWtoYG8W1+3g4GpWc?=
 =?us-ascii?Q?UFoTqj389fNKO40ZBvkgtdhlLjhaA2tPVr7vlW+aaCfvw1+ChUicHHH46D0v?=
 =?us-ascii?Q?y0tX0dxIsrh+kmkeJyiXYw3ygGzoZ3+RBkfVdv+lcQcO6iKLoRegeAcMeVzS?=
 =?us-ascii?Q?q8O5CCJPPGxD0vynyO5Jbe+C84dp9S7vpThD7oLMtibUpoCrChYHhy5mGTef?=
 =?us-ascii?Q?Cx8ttyeWGn2hZUuTM5yAdwx6KRhI034CCVHVdl4UXbjUidVH+c/UPuPcqqcM?=
 =?us-ascii?Q?g+/dO3+gyPiDvvII8YNXO6Ru1LFhLXCB2at2/RHBJbGhfMyVTGVijDQyA386?=
 =?us-ascii?Q?RlNW0vdgI0bIkfc4DudkWf2gYqDgFMNLLa0amVr/AqBRDKMeu/lNXzEIAU5i?=
 =?us-ascii?Q?reXAl8UMgUa6g0qx7V1dKqcEU094EVQOKt7td2xPxH5XeYl9c9C06BRoG9Zq?=
 =?us-ascii?Q?tMRto4syA2Yw6/BF8rAQtZiWAI6DKAVdn2XR0ynIxcIOEjKYDUrZjuAfdDZr?=
 =?us-ascii?Q?RWvko0HjpPDfrGgVjXi/4NxZm1ObW2W2TbxezhsRnwpcAGmKSRcK1o07VIJs?=
 =?us-ascii?Q?fm89U+zb6SlvzfP1O59p32a5LESD0f2uRx4FTJo/DUFQ9DPd4cZ+8A5iLtlX?=
 =?us-ascii?Q?DfilaSRmZHQrBAVje/MTqJExlHfsd6v0SKD55365zMsbbzhh9KWKeRUUrxfR?=
 =?us-ascii?Q?bIESIRrfuI7DYehBqu19/MB8DCPZawffxUILngzlGnwQxJe2vEezdamVoZPP?=
 =?us-ascii?Q?0jV67t/r5giVAqrL54gl2hKMrkBNVhCutOghDZC4fZu35JrP793fAXR7kCrc?=
 =?us-ascii?Q?cWTmhNH5eBL6+sRVbdxvsb1He3Us329X542m5mciZW7bp8P7yUbskBC/fjMV?=
 =?us-ascii?Q?mqB6Wj91pHq3coarJb41eUr6rCt7eWeGsEdyyPKBYYLTc9eCquLELyjhw3CD?=
 =?us-ascii?Q?mQGX+03fPEQ6fmXoidNVOUIjz5UrzjTMGm4RDgGxxvADtpqsP2sU5yrAwLMS?=
 =?us-ascii?Q?x2cntLtDOPxlVVyrnYFi3cE32OoQv4JmhNH/rNrr9Ns0HtKnYyNTqhX3Yu5m?=
 =?us-ascii?Q?dqdfngxc9+FmCcFUqL2ZNjb7dRmyFsTg1XCy8mIDKGoHMKjJULQMbczBVEF8?=
 =?us-ascii?Q?ahFiaJT+QxTneWFcsFvtR2z9T1AgxSwNj3a7tzpFwSPUpilj88+0hyPWrN/7?=
 =?us-ascii?Q?wQqtvh+fBmGYr/X9TUtgDA7jZJoQxEMEAul3xveN/LJ0JzNJ/NxgsVmIioXA?=
 =?us-ascii?Q?J27NoI2EY5t2nOPTa24Y8/FfH1Ptr2mrvCvOaGMI0CX9yGqe+b7JYZ43HxHp?=
 =?us-ascii?Q?p/9K9oqKmc4MRvpRYSU/CqlanD60tdYBg9l0eKYmrdF8yIC02Ivh99qQCWX7?=
 =?us-ascii?Q?FdClyh3YtGlgR39yYhPPEcRMfqrPya0sXBP3BaT7mweZEfMpRe6hnf3678SW?=
 =?us-ascii?Q?9jWrtGtYWEVg7vqS8+XoNDPRheeCkdfhqHfiHpkIkuJ5l7o43mgiN0pKC6Hm?=
 =?us-ascii?Q?deybwDlKaogkDDKEcZ+0I81D1NsHX/AilAl0NhAK+IXjysHe7+n3T8VB6+Tj?=
 =?us-ascii?Q?HGmFpFv9sQHW4M4q7KbkjAq/Vr1IwhXSgmGrMmWN1GqYqAl8JmFlkdZr/DGI?=
 =?us-ascii?Q?14DkPIx5ZngYWg46k38uxBTVvzY9KVgtTQ1c214JbpnEBn+cBX7d0AU8Zwwt?=
 =?us-ascii?Q?QLJD6tPPKFqq34yTGXDDTg2mERxQpCA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6534840c-9b7f-458b-5fbf-08def92727f1
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:39:30.4523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9Ux77l0CW75dFWSPY2X7P72Ug1P9s0TyUCLPTQKm3Xy42iDjNzWDM/qfl99cKOgofhUiRgbw0tuZ3r9BxHvJKVIYlwfaAV6zVJ6ORMFka8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8693
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Aug 2026 10:39:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23920

From: Clara Kowalsky <clara.kowalsky@siemens.com>

This adds the new recipe `cis-validation` which uses cis-hardening
to validate the configuration applied by cip-cis-rules.

It uses the configuration from the recipe cip-cis-rules,
stored in HARDENING_DEPLOY_DIR to generate the necessary validation
scripts.

Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../cis-validation/cis-validation_1.0.bb      |  51 +++++++++
 .../files/cis-validation.service              |  13 +++
 .../cis-validation/files/cis-validation.tmpl  |  65 +++++++++++
 .../files/generate-overrides.py               | 103 ++++++++++++++++++
 .../cis-validation/files/postinst             |  52 +++++++++
 5 files changed, 284 insertions(+)
 create mode 100644 recipes-security/cis-validation/cis-validation_1.0.bb
 create mode 100644 recipes-security/cis-validation/files/cis-validation.se=
rvice
 create mode 100644 recipes-security/cis-validation/files/cis-validation.tm=
pl
 create mode 100755 recipes-security/cis-validation/files/generate-override=
s.py
 create mode 100644 recipes-security/cis-validation/files/postinst

diff --git a/recipes-security/cis-validation/cis-validation_1.0.bb b/recipe=
s-security/cis-validation/cis-validation_1.0.bb
new file mode 100644
index 00000000..1cff3485
--- /dev/null
+++ b/recipes-security/cis-validation/cis-validation_1.0.bb
@@ -0,0 +1,51 @@
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+DESCRIPTION =3D "CIS validation for CIP based images"
+MAINTAINER =3D "Clara Kowalsky <clara.kowalsky@siemens.com>"
+
+inherit dpkg-raw
+
+SRC_URI =3D "file://${BPN}.tmpl \
+           file://${BPN}.service \
+           file://generate-overrides.py \
+           file://postinst \
+           "
+
+RDEPENDS:${PN} +=3D "cis-hardening cip-cis-rules-config-${MACHINE}"
+DEBIAN_DEPENDS +=3D "cis-hardening, cip-cis-rules-config-${MACHINE},"
+
+CIS ?=3D "/opt/cis-hardening"
+TEMPLATE_FILES +=3D "${BPN}.tmpl"
+TEMPLATE_VARS +=3D "CIS"
+
+do_generate_overrides[depends] +=3D "cip-cis-rules-config:do_deploy_harden=
ing"
+do_generate_overrides() {
+    if ! "${WORKDIR}/generate-overrides.py" \
+        --config-json "${DEPLOY_DIR_IMAGE}/${CIP_CIS_HARDENING_CONFIG}" \
+        --output "${WORKDIR}/overrides"; then
+        bberror "Failed to generate override files."
+    fi
+}
+addtask generate_overrides before do_install after do_unpack
+
+OVERRIDES_DIR ?=3D "/usr/share/${PN}/overrides"
+TEMPLATE_VARS +=3D "OVERRIDES_DIR"
+
+do_install[cleandirs] +=3D "${D}/usr/bin \
+                          ${D}${OVERRIDES_DIR} \
+                         "
+
+do_install() {
+    install -m 755 ${WORKDIR}/${BPN} ${D}/usr/bin
+
+    if [ -d "${WORKDIR}/overrides" ]; then
+        install -m 644 "${WORKDIR}"/overrides/*.cfg "${D}${OVERRIDES_DIR}"
+    fi
+}
diff --git a/recipes-security/cis-validation/files/cis-validation.service b=
/recipes-security/cis-validation/files/cis-validation.service
new file mode 100644
index 00000000..21286be0
--- /dev/null
+++ b/recipes-security/cis-validation/files/cis-validation.service
@@ -0,0 +1,13 @@
+# Copyright (c) Siemens AG, 2026
+# SPDX-License-Identifier: MIT
+[Unit]
+Description=3DCIS validation
+After=3Dnetwork-online.target
+Wants=3Dnetwork-online.target
+
+[Service]
+Type=3Doneshot
+ExecStart=3D/usr/bin/cis-validation
+
+[Install]
+WantedBy=3Dmulti-user.target
diff --git a/recipes-security/cis-validation/files/cis-validation.tmpl b/re=
cipes-security/cis-validation/files/cis-validation.tmpl
new file mode 100644
index 00000000..e4efebb2
--- /dev/null
+++ b/recipes-security/cis-validation/files/cis-validation.tmpl
@@ -0,0 +1,65 @@
+#!/bin/bash
+# Copyright (c) Siemens AG, 2026
+# SPDX-License-Identifier: MIT
+
+tmp_root=3D$(mktemp -d) || exit 1
+default_file_mounted=3D0
+tmp_root_mounted=3D0
+
+trap '[ "$default_file_mounted" -eq 1 ] && umount /etc/default/cis-hardeni=
ng; [ "$tmp_root_mounted" -eq 1 ] && umount "$tmp_root"; rm -rf "$tmp_root"=
' EXIT
+
+mount -t tmpfs -o mode=3D700,nodev,nosuid,exec tmpfs "$tmp_root" || exit 1
+tmp_root_mounted=3D1
+
+# Work in a temporary CIS tree
+cp -a "$CIS/etc" "$CIS/versions" "$CIS/bin" "$tmp_root/" || exit 1
+
+# Redirect CIS_CONF_DIR and CIS_VERSIONS_DIR via /etc/default/cis-hardenin=
g
+cp /etc/default/cis-hardening "$tmp_root/cis-hardening" || exit 1
+sed -i \
+    -e "s#^CIS_CONF_DIR=3D.*#CIS_CONF_DIR=3D'$tmp_root/etc'#" \
+    -e "s#^CIS_VERSIONS_DIR=3D.*#CIS_VERSIONS_DIR=3D'$tmp_root/versions'#"=
 \
+    "$tmp_root/cis-hardening" || exit 1
+mount --bind "$tmp_root/cis-hardening" /etc/default/cis-hardening || exit =
1
+default_file_mounted=3D1
+
+conf_dir=3D"$tmp_root/etc/conf.d"
+versions_dir=3D"$tmp_root/versions"
+
+# Create missing rule cfg files in the temporary conf.d.
+"$CIS"/bin/hardening.sh --create-config-files-only --allow-unsupported-dis=
tribution >/dev/null 2>&1 || true
+
+# Apply SSH overrides
+for ov in /usr/share/cis-validation/ssh-overrides/*.cfg; do
+    [ -r "$ov" ] && cat "$ov" >> "$conf_dir/$(basename "$ov")"
+done
+
+# Apply CIS overrides
+for ov in /usr/share/cis-validation/cis-overrides/*.cfg; do
+    [ -r "$ov" ] && install -m 644 "$ov" "$conf_dir/$(basename "$ov")"
+done
+
+# Drop non-CIS rules (99.*)
+find "$versions_dir" -name "99.*.sh" -delete
+
+AUDIT=3D$(
+    if ! "${CIS}"/bin/hardening.sh --audit --batch --allow-unsupported-dis=
tribution 2>&1; then
+        echo "CIS hardening script failed to execute." >&2
+        exit 1
+    fi
+) || exit 1
+
+echo "$AUDIT"
+
+CONFORMITY_PERCENTAGE=3D$(echo "$AUDIT" | grep -oP 'CONFORMITY_PERCENTAGE:=
\K[0-9.]+' | tail -n 1)
+
+if [ -z "$CONFORMITY_PERCENTAGE" ]; then
+    echo "Error: CONFORMITY_PERCENTAGE not found in CIS validation output.=
" >&2
+    exit 1
+elif awk -v p=3D"$CONFORMITY_PERCENTAGE" 'BEGIN {exit !(p =3D=3D 100.00)}'=
; then
+    echo "CIS validation conformity is 100%."
+    exit 0
+else
+    echo "CIS validation conformity is ${CONFORMITY_PERCENTAGE}%, which is=
 less than 100%." >&2
+    exit 1
+fi
diff --git a/recipes-security/cis-validation/files/generate-overrides.py b/=
recipes-security/cis-validation/files/generate-overrides.py
new file mode 100755
index 00000000..e45e2151
--- /dev/null
+++ b/recipes-security/cis-validation/files/generate-overrides.py
@@ -0,0 +1,103 @@
+#!/usr/bin/env python3
+#
+# SPDX-FileCopyrightText: 2026 Siemens AG
+# SPDX-License-Identifier: MIT
+#
+# Generate override files for disabled CIS hardening rules
+#
+# Usage:
+#   python3 generate_overrides.py --config-json .config.json --output over=
rides
+#
+
+import argparse
+import json
+import os
+import logging
+
+logging.basicConfig(level=3Dlogging.INFO, format=3D"%(levelname)s: %(messa=
ge)s")
+logger =3D logging.getLogger(__name__)
+
+class OverrideGenerator:
+    def __init__(self, config_json_path, output):
+        self.config_json_path =3D config_json_path
+        self.output =3D output
+        self.rules_data =3D []
+
+    def load_config_json(self):
+        try:
+            with open(self.config_json_path, 'r') as f:
+                self.rules_data =3D json.load(f).get('rules', [])
+        except FileNotFoundError:
+            raise FileNotFoundError(
+                f"Config file not found: '{self.config_json_path}'"
+            )
+        except json.JSONDecodeError as e:
+            raise ValueError(
+                f"Invalid JSON in config file '{self.config_json_path}': {=
e}"
+            )
+        logger.info(f"Successfully loaded configuration from '{self.config=
_json_path}'")
+
+    def generate_files(self):
+        if not self.rules_data:
+            logger.warning("No rules data loaded. Skipping file generation=
.")
+            return
+
+        errors_during_generation =3D []
+        generated_count =3D 0
+
+        for entry in self.rules_data:
+            rule =3D entry.get('rule', {})
+            if not rule.get('apply', True):
+                name =3D rule.get('name')
+                description =3D rule.get('description')
+                if name is None or description is None:
+                    raise ValueError(
+                        f"Rule entry missing required field(s): "
+                        f"name=3D{name!r}, description=3D{description!r}"
+                    )
+                description =3D description.replace(' ', '_')
+                justification =3D rule.get('justification', f"Rule '{name}=
' disabled by user configuration.")
+
+                os.makedirs(self.output, exist_ok=3DTrue)
+                logger.info(f"Ensured output directory exists: '{self.outp=
ut}'")
+                # Sanitize path components so a description/name cannot es=
cape output dir.
+                safe_name =3D os.path.basename(str(name))
+                safe_desc =3D os.path.basename(description)
+                filepath =3D os.path.join(self.output, f"{safe_name}_{safe=
_desc}.cfg")
+                content =3D f"# {justification}\nstatus=3Ddisabled\n"
+
+                try:
+                    with open(filepath, 'w') as f:
+                        f.write(content)
+                    logger.info(f"Generated '{os.path.basename(filepath)}'=
 for disabled rule '{name}'")
+                    generated_count +=3D 1
+                except IOError as e:
+                    errors_during_generation.append(f"Error writing file '=
{filepath}' for rule '{name}': {e}")
+            else:
+                logger.info(f"Rule '{rule.get('name')}' is applied, skippi=
ng override file generation.")
+
+        if errors_during_generation:
+            for err in errors_during_generation:
+                logger.error(err)
+            raise Exception(f"Completed generation with {len(errors_during=
_generation)} errors. Generated {generated_count} files.")
+        else:
+            logger.info(f"Generated {generated_count} override files in '{=
self.output}'")
+
+def main():
+    parser =3D argparse.ArgumentParser(
+        description=3D"Generate override files for disabled CIS hardening =
rules from .config.json"
+    )
+    parser.add_argument("--config-json", help=3D"Path to .config.json", de=
fault=3D".config.json")
+    parser.add_argument("--output", help=3D"Directory for override files",=
 default=3D"overrides")
+    args =3D parser.parse_args()
+
+    generator =3D OverrideGenerator(args.config_json, args.output)
+    generator.load_config_json()
+    generator.generate_files()
+
+if __name__ =3D=3D "__main__":
+    try:
+        main()
+    except Exception as e:
+        logger.error(e)
+        raise
diff --git a/recipes-security/cis-validation/files/postinst b/recipes-secur=
ity/cis-validation/files/postinst
new file mode 100644
index 00000000..a9f706de
--- /dev/null
+++ b/recipes-security/cis-validation/files/postinst
@@ -0,0 +1,52 @@
+#!/bin/sh
+# Copyright (c) Siemens AG, 2026
+# SPDX-License-Identifier: MIT
+# Resolve override mappings at package install time
+
+set -e
+
+CIS=3D/opt/cis-hardening
+SSH_OVERRIDES=3D/usr/share/cip-cis-rules/conf.d-overrides
+CIS_OVERRIDES=3D/usr/share/cis-validation/overrides
+SSH_RESOLVED=3D/usr/share/cis-validation/ssh-overrides
+CIS_RESOLVED=3D/usr/share/cis-validation/cis-overrides
+
+mkdir -p "$SSH_RESOLVED" "$CIS_RESOLVED"
+# Remove stale mappings
+rm -f "$SSH_RESOLVED"/*.cfg "$CIS_RESOLVED"/*.cfg
+
+# Map SSH overrides to real cfg targets
+if [ -d "$SSH_OVERRIDES" ]; then
+    for ov in "$SSH_OVERRIDES"/cis-*.cfg; do
+        [ -r "$ov" ] || continue
+        rule_id=3D$(basename "$ov" .cfg | sed -E 's/^cis-([0-9.]+)-.*/\1/'=
)
+        sym=3D$(find -L "$CIS/versions/default" -maxdepth 1 \
+              -name "${rule_id}_*.sh" 2>/dev/null | head -n1)
+        if [ -z "$sym" ]; then
+            echo "cis-validation postinst: no rule for $rule_id, skipping =
$(basename "$ov")" >&2
+            continue
+        fi
+        real_cfg=3D$(basename "$(readlink -f "$sym")" .sh).cfg
+        ln -sf "$ov" "$SSH_RESOLVED/$real_cfg"
+    done
+fi
+
+# Map generated CIS overrides generated by generate-overrides.py to real c=
fg targets
+if [ -d "$CIS_OVERRIDES" ]; then
+    for ov in "$CIS_OVERRIDES"/*.cfg; do
+        [ -r "$ov" ] || continue
+        short=3D$(basename "$ov" .cfg)
+        sym=3D$(find -L "$CIS/versions/default" -maxdepth 1 \
+              -name "${short}.sh" 2>/dev/null | head -n1)
+        if [ -z "$sym" ]; then
+            echo "cis-validation postinst: no rule for $short, skipping" >=
&2
+            continue
+        fi
+        real_cfg=3D$(basename "$(readlink -f "$sym")" .sh).cfg
+        ln -sf "$ov" "$CIS_RESOLVED/$real_cfg"
+    done
+fi
+
+#DEBHELPER#
+
+exit 0
--=20
2.55.0



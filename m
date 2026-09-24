Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7E4C98310
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 08:12:51 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.69])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2973.1790237559227108906
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 01:12:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=dCTF4qza;
 spf=pass (domain: siemens.com, ip: 52.101.84.69, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNtoUHsgp/upHEvh/WNgh98KQq+MLfZ3590SLGQa4sR6k1tttpYs7p4Wotyv26eTaxTO7iA37x3l/p2pNsYLz5vHy7PQgm4+u/6iH+222NvR1eBgAoa4RPCd4vf3Rus/lkqcH2uh8LGtpKqiFaxP9NmJtxcYGMkbfBK179dSiBOStcJrYrFQtNLIa0rymOtqtnd/9Xgg9W+ocbT88jPboFkN/3urG/ulWWSNYpxt/CjGfqBIQlrMdneHWRQ7vEu59ry9kJ2yz0fEUcr6JFNdnt6jIaw9yJe9+5B1x/XtPQ6AF2Hgw8jfaFh+95/EE305UX4bT7Phm6yprweZBdRTJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UneE+Kn0LNmOxkfcU5TTYgIayauPNbcOb7TquJr+4vQ=;
 b=J9UaiIjVEC6s0RqlYzWeLd2o3EbCQtsWeBo/7+K1xLF9EXKxXniFOvXYeKQaU7L8LVJJEUoWxDQ6FizWXWrS4z4eeHKCdiK8NCPwccFK57CL+Jy+L0LnKIu91sfwrZB4/a9iZwOYghxjk3PfaABFYMFII75PIHpjGrqYM6gqaE8UWK9GM5NA89fY+bg/QE2LR3cYWWYVKEInNMJTGfEdz9J0koKY/aL8pIqpT+7OJFfaBAX2ptQyjJz10BexKW04JqrRRvbAI28zW0l+DUsOBh2IJ8J43mOCRbtE2ILbHZQHS7bYTxnASe6agpXxKP3gF3F4cw5DUj3ZGPAd1+51Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UneE+Kn0LNmOxkfcU5TTYgIayauPNbcOb7TquJr+4vQ=;
 b=dCTF4qzahQvb+i3rEJ2bsYCS1uVTbWyNaPcbSTkogtl5CJrDSAgGw36F2PfyUuHjTYbwwzUhtEUCdPNti+n6Ert7TTuyzzqNp+Wu943rgYkkiHNL+uz1NEOuydLiDkpfHsNd9VwyK02RmWGWuUOB0SrdeMmQvjP3MDHjcQ6m26A5uiAFHhCYynjAhbNwctQhdy0kWcfK726pE6t8mjYpwU+U3OlDjE3+luhiOGuGTVF1OAVD0+Z1oqwCs/0ADi6tX+zt4Q7+0aiHGXHyiHtyLXBn1cOufzLqE83A39WnabpJzG5sEb85xt41NSCRLSgf7rHLmEIW65mRsrUyQmsLjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by DU0PR10MB7922.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Thu, 24 Sep
 2026 08:12:41 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 08:12:41 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 07/14] Add cis-validation to validate the hardening based on the CIS rules
Date: Thu, 24 Sep 2026 10:12:16 +0200
Message-ID: <20260924081226.2844456-8-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924081226.2844456-1-quirin.gylstorff@siemens.com>
References: <20260924081226.2844456-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::22) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|DU0PR10MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: 470ae793-01cd-4658-87df-08df1a13999e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|3023799007|6133799003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	xcNO/mqe2LQk7YkwtkiY0sjxVujwaWeITOgnPoeZ/ph7xI02iZQ2V5MYeAaxeeB3FphEZM2gm9MJXVi5UmdujN0Roal7MJY022BgxIglUZ6DOsIEw/ALYmY9IDtVAf2kDtNY1hI0eb+RVwvx2r5yFtkFHbO6INUD64SgGIqn9XyXvsG7IP/CKM6yANBcQmqiozDPcpUWfyZQH6VGqUMP4GwHwth2iDCVMAvVcsGU0CP+wnI60SzeLr4URn4t64Y9NjJEYe3kEHTkKwMAjOlDmgNnKFnXcM2AKdfe2R7OPdclpkRiu3CIOMJ33WeEPCT3NBQszp2rl7zVAVa4ChLtJ0KXBuZfD2/q3P4cXCd2EeO2IdpdbwkEPCk5zpEStMh45yQtIT1aJH5hs4iGWhsLBljeYuJFEkoWL+WrQ9MhWzru8Of7XmI8ZJzRbspEMdQM5WEsjqqIGWJVSoEssvX83WO0UkKrOJLSeeph376xF4zRyAOnFCH3tWsOIazVDVznKcxWAWG3zWlDfhr1CNB70EmUQYVhTHrONOoc4gY/kAzjhaNpAHuP+BfJ7yj0vACOXsoqmjnVKeWQ3cNVBA2YspAiRU9em+KZ4nEjICOfp4pOnlczq4aw9wqTTllOvMBZeBQ25JxZqRCuI3xgVxx5Tn/ZRnABROUkrlobsU8PFMY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(3023799007)(6133799003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ikxoRVfoHisfVN7YRE6I2Mbc7RrxnMmaKfAf0NC6ZaBYM1LhZ0d/qSpgbfBr?=
 =?us-ascii?Q?v9XAhRZmrLVHSbHfi4ZluEfbfNM8jxnVs5OGjktOlaaSzkG+SQOhQ97dphdz?=
 =?us-ascii?Q?icPIEE/SCkteyjPn3ry201QAVV/3vmUEn5Y3wziA58/PGdDpA1iokDRtVR1B?=
 =?us-ascii?Q?01w72f8ygzgU+4aPgI7LRFarp+uee7rarDobyaodEJ9sE17e0N/10LUz2W0R?=
 =?us-ascii?Q?uD2P93tmWXfpHTU6tGRkLOQqo9DSiOFAJTP0k2+x5+I0mPfhm4AWbx2fMfhx?=
 =?us-ascii?Q?Ps/nuaCNF0l9bnbOJbJJdDiypgJGauOArVFNtdy60ljXFrn6m9nzXIIRQ9bQ?=
 =?us-ascii?Q?31BhV0GCKlmrqQKRtIquV6MA9q1//XsJkGiK8TN9KVCkZK9Y75S+IoMk6EIO?=
 =?us-ascii?Q?dgxNkIgr/CalTE8ah5RxhQhHPkj9tnUbI8Fr7/ydrav1WAa+XCoa+dMksfia?=
 =?us-ascii?Q?I46L64ZyPoJIAbQTe/rILQ0s+DN4YbqB4TKnsSXln4WZ22nlu3JFY3VTRKeI?=
 =?us-ascii?Q?gm33ehcAiVISdkisDXaSllYg4VTRZl5nxyB+RM0agtpPyvxnOG/kAwCjnznK?=
 =?us-ascii?Q?rkt+G2yiC0NQGVfc7hDRbwOXsvVuqdkPUXd+YsKrhU/J5Y74/o09QL0PtXx2?=
 =?us-ascii?Q?5ASnWcD6jTvwMv743hurZUKNHVXh3wFdrf5YgcszkA+K0QK/OwYOIteZdYnl?=
 =?us-ascii?Q?NBM8nd0CcmCV2WWJsqfWuFVjFTN/OkMyweC6LOAE1RTtYl9ywQUxLMCXBoVH?=
 =?us-ascii?Q?ObapwshkjT/gZ5hmerVNGuqsF34T9T5f1xcat9VyQuCvMqfG8JNrxjriWGVA?=
 =?us-ascii?Q?75PdO1C0HRt26B3GCENwjmwF1ChnDjr+FY5GbKpq88gpZ7BN/FMj96lfgVgV?=
 =?us-ascii?Q?oboirm/oDigx2zUS3cGi2lSxk/E1bRKUVH6xahhOvb/1cCjqVq0gRNtPwv0x?=
 =?us-ascii?Q?LGtu2OfVLJeDxFG/mgec226Y1PJfAOlLREsqlHUpW/x4mrcl3dSQsEU7CI2a?=
 =?us-ascii?Q?75lL0c2O5DOxL+iAHXV45ZVIQUVrZfqmzb3V0gdYxEcjwh7CHLugqwa42l98?=
 =?us-ascii?Q?1OIt9apGNvzC3aDOPzB77aTJ1VxxlOCyYE/OuvGddIzDTvJ8x9DMcWYz0EzV?=
 =?us-ascii?Q?s3aMjX8MKAxyjmC3EgMS9rb9W0ruQ5hjB54Qh5onIY8v8EpeNfQDQWI0grqV?=
 =?us-ascii?Q?y48EuNklI4iIoKIVuk18V4wpt4kKLclKxySj1bVDKwkOdrqvheg1ZLNRyMfp?=
 =?us-ascii?Q?K+MEoAZT/b2Ul4najQRrMwubYbF6TWoyiyPQRPOHCyVRaGSNOiHGtrHE68nx?=
 =?us-ascii?Q?cc7OkGvaPLFuzkqFV9uAIBBy35ryp29n2beFzkW2wF5GljlL9CF6zSxfKGNH?=
 =?us-ascii?Q?uuY1daRIsncXjM7ZvcwLL1Sqfdo4GkWEtDUUIJ5OtStJOBblgX0La9+X0jL7?=
 =?us-ascii?Q?s8FauOYetTwX9Q6EaUWv8DtXsozN3JjxNPBRn0VtuY9ulfjEMmG6C4BrUU+T?=
 =?us-ascii?Q?GoIL8MYovbQUUomUS0nvnaNDitBSQOBZll8NlhXuG+o8t46ONuDMS+laSZxS?=
 =?us-ascii?Q?JTXtPKmKUsp6RPO5WwLJlaYDjVX+9686vhXPNQI7PWyjXVjlKafRngQqAm2n?=
 =?us-ascii?Q?+ppS9N2v3xvxq7oDU/hF278Japb+P/iMnwvYeQUKsC6AuacVBarfBAmNZRK8?=
 =?us-ascii?Q?8uFeHjvlwuUDcuy3r2PQznigJOSIuM1EAr9VSLOLQ38dLZSoczCAmAGzVaAn?=
 =?us-ascii?Q?ogk6Pk2+IQAJjEEnFXZLnzBB3vZK0ZI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470ae793-01cd-4658-87df-08df1a13999e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:12:39.6025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1NEDh+4HVCNmwsHa8G00X97dQln1/yxU4NW5KH0BRp2N13p9En2a5UrwXkg7yNe6WO/EebHT5JMD7qCjhTBnyh1WXZ9/7iND5O+pCCJuv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7922
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 08:12:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24293

From: Clara Kowalsky <clara.kowalsky@siemens.com>

This adds the new recipe `cis-validation` which uses cis-hardening
to validate the configuration applied by cip-cis-rules.

It uses the hardening configuration deployed by cip-cis-rules-config
to `${DEPLOY_DIR_IMAGE}/${CIP_CIS_HARDENING_CONFIG}` to generate the
necessary validation overrides.

Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../cis-validation/cis-validation_1.0.bb      |  52 +++++++++
 .../files/cis-validation.service              |  11 ++
 .../cis-validation/files/cis-validation.tmpl  |  65 +++++++++++
 .../files/generate-overrides.py               | 103 ++++++++++++++++++
 .../cis-validation/files/postinst             |  52 +++++++++
 5 files changed, 283 insertions(+)
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
index 00000000..a7c3b845
--- /dev/null
+++ b/recipes-security/cis-validation/cis-validation_1.0.bb
@@ -0,0 +1,52 @@
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
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
+        bbfatal "Failed to generate override files."
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
+    for cfg in "${WORKDIR}"/overrides/*.cfg; do
+        [ -f "$cfg" ] || continue
+        install -m 644 "$cfg" "${D}${OVERRIDES_DIR}"
+    done
+}
diff --git a/recipes-security/cis-validation/files/cis-validation.service b=
/recipes-security/cis-validation/files/cis-validation.service
new file mode 100644
index 00000000..428fd928
--- /dev/null
+++ b/recipes-security/cis-validation/files/cis-validation.service
@@ -0,0 +1,11 @@
+# Copyright (c) Siemens AG, 2026
+# SPDX-License-Identifier: MIT
+[Unit]
+Description=3DCIS validation
+
+[Service]
+Type=3Dexec
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



Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42E6C9830B
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 11:32:28 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.30])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4859.1790163139819749837
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Sep 2026 04:32:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=hXTUusAU;
 spf=pass (domain: siemens.com, ip: 40.107.162.30, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLT+mwB7HG9qjKju+1Q1l24fLWhRV42UIAlO4ggQt2/awJZXdjdFj9jFN13mT4VLBv4qPndsvzSvnue1nbapv/66Lih+2G9p7oJ3FPtjFC8NaTrilhCJU326rE4KH+835mqf3bTo925OAxkLzTP+GYKE3TWXzokhADQtAheNc5S9j+QNI2vHB1xb/fkZXtIaoLYVkTjPLZ13Ty2ARpatghZMNzETe5T6M0EaLexNU6h6W0tqtk5EerETzVI0i+P4xRU4CZPa5XKxG6F0A5/QVoKkAVr83SupSM++UraRxvrHeyRhHPovBk1EXjcSAFcFoTli4u5FMJjMxhdvJ5KveQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aU/13xzYdtgWPcDo3lyFQcdQYmXA04W/e1PPFqeN3s=;
 b=JUJ5LX0CeXY5TYgbe/ztSYqTxE8p29U7rz5Zxa5//1VO3L3kWam06NumQthuD9yise6E0j6qZubh2sBnCfIG7ZBqCl3vMfCcB1H3zC/nap6nWt3lfqSTN+rF9uS6idVmR+pGNdk++xzWjJT/jIdLAuuU7ot3fUKYXWrw/BFlV3kw3u8GYGfAE6e4v8B0/Xh91ZK42GG2FrAWHXNJEx0d36XxCgTHgXNfOhAb3v2dZwAXt9SHON+FihJfbN4nubFmVCTJue4HR+Z0+ohvXMasvPixMTlWrj1xaVznJMfW1QBipS1ibauNAYxHIgoSRRdgfSZMaX0AP6tTGjC7eXJs3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aU/13xzYdtgWPcDo3lyFQcdQYmXA04W/e1PPFqeN3s=;
 b=hXTUusAUS0EjfWLDwP148usurezQENPYt6nau8PJUiCyk6l1ZQyosYD4ke3Uje0MWbNmnH+Iqr5PY9MNuc0UJ0YBKqcfwR8IONZUmavkdGzfWuKgnY8Ms5CHLkHmt23rXFcfCuL1rmTjOpKbpkPrUnK1A2cRT+SL3rAnNdbz24UOlOkOpQ2iq7QYHgWAjynwV5kTaEqzAo7zT4q8wJxJBSKeNZ+/I7HT8rcmT2WLAGkfJjqfsMR0C6FudU8Rln5hpGVOcu6i78mzI6sd7668IHQEOJqyCxDxWySXADwhlfUZlstsvczHd2yvrHcdsTYmuthVly/vvSzRLjRXqW8ucQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 11:32:11 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 11:32:11 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
CC: Shivanand.Kunijadar@toshiba-tsip.com,
	jan.kiszka@siemens.com,
	kazuhiro.hayashi.f74@mail.toshiba,
	kumar.dinesh.h95@mail.toshiba,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v3 1/2] introduce helper class to set secure boot timestamps
Date: Wed, 23 Sep 2026 13:30:01 +0200
Message-ID: <20260923113003.259191-1-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::13) To AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3956:EE_|AM7PR10MB3320:EE_
X-MS-Office365-Filtering-Correlation-Id: db3a5fc0-c198-4a26-3d6e-08df19664f0c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|55112099003|18002099003|3023799007|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	WMhZ+DnrdzdTaEYmWfcxo5wpZpdn3tcqwQp1qajzSJosEmstlhIA7smX9uWqOx8xUBoLZLt8JxmJEiHTNPSrzeB8Yb7E3S0AwshWADHIT1BDohZOV/EIZZi28as86cRaCDd5pRvy3kPXHrqj6ARJP/hCrOONCA8Bq3Z2JE66UCXYhtHMtQNiuxaw8JxPjVTjV/bKWhxCwEGaE8JlUWLxLsWB5lrjxFFFu3UzW5zCKzyceFMVt/iKm9piJ1imGzU5MyiHC3bRyEyk2qLKPoqYRsCbPhwnu1GUY4ZNw+4zBkc/KkVkJTUbslvOu4Uatu3OutxSOTQSNQe+Hx6NQj8EPYSytHMzyefLPHXh/QEf8McLy1kpf2I8d66MVqRJg+JBa/7gQW5dv5BHc85MAIAuX1GTuTE2T4BgbJpcfyutCHpgAhsC9WKHtYAQGeV3AxFv0WLEDEeA/UR/gHm5Dkvywno9stUmatSpqggnHy0Q9FzWVyO5cvQW+me6A9BQAhsMXcvFQouFKJjnU+rBsGfk+zhb5pcmIH8XC07VUJn3nQCR6NkzL+Qf4tpoELNQZWdrJA1HHoCrUoFl/WjftfCRD8CMnb5kvIs/2911fsozgIsMOy2427vzhE89s/88HIYEsECT4+1iv1vB2lJal666EZd/SNjGTPDkYBe/juxWFl0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(55112099003)(18002099003)(3023799007)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tM+5DOXJleNjKaWTjxPVEhndeTRtWpMAS9NG9NxLQgZyFCMuOIqw+SLltHpR?=
 =?us-ascii?Q?pNCyKy/gjiPY51esNXKdyDHAkU1H2bi0wGHnbB44Oyf+X8+SZ1NBdVe9I5Xn?=
 =?us-ascii?Q?eOz0/xBmUi7SjM2wd2sI6PJSvHURFM6j3mH20o+RN3JtXRFu054Di6zrzoJJ?=
 =?us-ascii?Q?ZtEScZhpAvB5YLIpRb8VVAFFWbCD/euvZW0rxb4VUAARu5HVu2Gr35dwyKFl?=
 =?us-ascii?Q?cCQqqDTc0EQ4VNalgxO35z7EazgGQ96sMYSkKgnaojWnYod2D2QLal/AuDYG?=
 =?us-ascii?Q?/Iq2/r5iz7/5d69HSsD7UsJSp67tlbu7iPgSkc1oESNqGL3pM9wxT3Ik+C1Z?=
 =?us-ascii?Q?qVRWshoCEhTzO0/7aglevIyNXKR2B0PTIvi6nVRFH4WPGUPll3hEtz5u2TAM?=
 =?us-ascii?Q?Ziqc05hA1EYOkTyjyxNttWKTkgJflDY0Oqyy8Np9UDUzrmhJTdgRM3axUELu?=
 =?us-ascii?Q?crBrXNKvon+UwccuTJhApZ1QHUFWZGj9PWWRRONdf1z+1MEBtayn0lpm/bC9?=
 =?us-ascii?Q?TKMI8VvMNOFrgces9VkvJ3xP7/oBrcb/MDV71jlOIPjbI3mJzJ6mSvXLMfKw?=
 =?us-ascii?Q?jQPdG8lNRCx0/l5ODfAHsEARuP+cnCCHB4Cr2Q7D1h9fnj3KPgS/6slkFwU+?=
 =?us-ascii?Q?8PGsb1V6xNXRcCd6piuT4xw07C4+dY7qpxtV1b/jb1v5P954b+Pk/0/RHP47?=
 =?us-ascii?Q?DrNnxWAxZuCdhw15se3KI/qD6cAEx5qvCyNoNFvYxHcGdt6vbCULBRuIAIz2?=
 =?us-ascii?Q?ekmusxYEWxVmuDMn3oysHmQ3QDvEA1q9WfAz1uIjRIC9yq25SoFFDRjffSA2?=
 =?us-ascii?Q?GA7z4v240GLhiVoRLUTXH1jPirx5zsnTomnV2UD09A+6RuE96KCYvJjuUcOx?=
 =?us-ascii?Q?GQXFJ7aSmY8C81X5H2qjzxKSITvTPM4nReCA51jTpUN80M4So1BWv5Hsz+9A?=
 =?us-ascii?Q?VyvuNhr7ZtXTrHm6G5Lhk01WjTQhDliP1MaaheOFDlNSO7txAWQr9PjPCZ5h?=
 =?us-ascii?Q?LGtzbnPfs3VDnSOpIJvp41WVgS+r8L4Iw9ltiNSfPvphKT0NMDNE8HMFmBD/?=
 =?us-ascii?Q?o+RWBNVX81oILLyQd2PLkNECnlrU6BEKrprdEXMlp9R8kTtaRsHO3PLeIk9U?=
 =?us-ascii?Q?9PWyQ55+EZMxkxtUUJxpUXTJeuB/3pVINS/eFn1MgKzQ9REntVKa0oeWjrQW?=
 =?us-ascii?Q?30xkgYurJTwcw0SmLFolM0VXJnYqtGP8Q+7zAw1xs7Gxp3THERp5rBtzAa9a?=
 =?us-ascii?Q?K9c+UHey9eGQrohn295rqa6PaPQT0/HftymSiFP0nsxNT+58bGWcgCZdmvEF?=
 =?us-ascii?Q?2YH6Wn0//PzbYOwtbM35utc3R9+Q5pW8roMP+7rOBbYaDYnazV27T/0UL7WG?=
 =?us-ascii?Q?4k39HJgbK0ycX0l7NYl2Ah5dPQXCUo4j6Bw2nntx87uFpUO6FDyO9WPyQKg0?=
 =?us-ascii?Q?DmXj6HSF9bH24yqsnLSusPiUj+0nKvQZIk3IGPlzJhpmzIo+PW3Q44ZVFODz?=
 =?us-ascii?Q?jTcsV7bjWxOIpuZnGhiGT7an2WMt6QKvKA1yROCWcLlJzSp2khSuJJZ1v1Cq?=
 =?us-ascii?Q?WUb3w4nqQzyZ1jxf8T2H0+AOKuVGn6gpqeMzdAW+2gsxUJjgLps+AzRR/Deh?=
 =?us-ascii?Q?fl5LahzSMU9w98ADuCoG/wUjAbW2ohiUfiIXbMfy+fzPUpNnXNQX6htfpKOa?=
 =?us-ascii?Q?8QVuOEP2i9qVQEM4Gg/mVR98+6vQ6srr0AfIFcAzyxA9qN97ULf9nQjF/bhW?=
 =?us-ascii?Q?celF6uHMjG4/2LEwb2ipt2VuwyAYjPA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3a5fc0-c198-4a26-3d6e-08df19664f0c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 11:32:11.4997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uuJPidQDkzO8qd4anRO9W/6+TLhwuTl7MWTkUlLLCm5Ep06meMAGx9f6c/WY8Jkez7INm6wDRuGu1Mkn4fyjZjq1b3Bt+iT6uoPRhKOF54U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3320
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Sep 2026 11:32:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24276

This class can be used to set the DEBIAN_CHANGELOG_TIMESTAMP according
to the SDE and also provide the timestamp that is usable by secure boot
tooling. As first user, we port over the ebg-secure-boot-signer recipe.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes-recipe/secure-boot-timestamp.bbclass  | 21 +++++++++++++++++++
 .../ebg-secure-boot-signer_0.2.bb             |  7 ++++++-
 ...ure_image.sh =3D> sign_secure_image.sh.tmpl} |  8 ++-----
 3 files changed, 29 insertions(+), 7 deletions(-)
 create mode 100644 classes-recipe/secure-boot-timestamp.bbclass
 rename recipes-devtools/ebg-secure-boot-signer/files/{sign_secure_image.sh=
 =3D> sign_secure_image.sh.tmpl} (66%)

diff --git a/classes-recipe/secure-boot-timestamp.bbclass b/classes-recipe/=
secure-boot-timestamp.bbclass
new file mode 100644
index 0000000..f51906e
--- /dev/null
+++ b/classes-recipe/secure-boot-timestamp.bbclass
@@ -0,0 +1,21 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Felix Moessbauer <felix.moessbauer@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+# Provide up-to-date timestamps for the cryptographic operations
+# of the secure boot tooling and reflect that in the Debian changelog.
+# When calling the SB tooling, ensure to use set TZ=3DUTC as well.
+
+DEBIAN_CHANGELOG_TIMESTAMP ?=3D "${SOURCE_DATE_EPOCH}"
+SECURE_BOOT_TIMESTAMP =3D "${@time.strftime('%Y-%m-%d %H:%M:%S', time.gmti=
me(int(d.getVar('DEBIAN_CHANGELOG_TIMESTAMP'))))}"
+
+issue_timestamp_note() {
+    bbnote "Use timestamp ${SECURE_BOOT_TIMESTAMP} UTC for signing"
+}
+do_prepare_build[prefuncs] +=3D "issue_timestamp_note"
diff --git a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer=
_0.2.bb b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.=
2.bb
index 6963d09..1fb9122 100644
--- a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
+++ b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
@@ -19,7 +19,12 @@ DESCRIPTION =3D "Signing script for EFI Boot Guard setup=
s"
 DEPENDS =3D "secure-boot-secrets"
 DEBIAN_DEPENDS =3D "sbsigntool, secure-boot-secrets, faketime"
=20
-SRC_URI =3D "file://sign_secure_image.sh"
+SRC_URI =3D "file://sign_secure_image.sh.tmpl"
+
+inherit secure-boot-timestamp
+
+TEMPLATE_FILES +=3D "sign_secure_image.sh.tmpl"
+TEMPLATE_VARS +=3D "SECURE_BOOT_TIMESTAMP"
=20
 do_install() {
     TARGET=3D${D}/usr/bin
diff --git a/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_imag=
e.sh b/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh.t=
mpl
similarity index 66%
rename from recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image=
.sh
rename to recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.s=
h.tmpl
index 213cf8a..29f22f4 100644
--- a/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
+++ b/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh.tm=
pl
@@ -30,9 +30,5 @@ fi
=20
 keydir=3D/usr/share/secure-boot-secrets
=20
-faketime_cmd=3D""
-if [ -n "$SOURCE_DATE_EPOCH" ]; then
-    faketime_cmd=3D"faketime -f \"$(TZ=3DUTC date -d @$SOURCE_DATE_EPOCH +=
'%Y-%m-%d %H:%M:%S')\""
-fi
-
-eval $faketime_cmd sbsign --key ${keydir}/secure-boot.key --cert ${keydir}=
/secure-boot.pem --output $signed $signee
+TZ=3DUTC faketime -f '${SECURE_BOOT_TIMESTAMP}' \
+    sbsign --key ${keydir}/secure-boot.key --cert ${keydir}/secure-boot.pe=
m --output $signed $signee
--=20
2.55.0



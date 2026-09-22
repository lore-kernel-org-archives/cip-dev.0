Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91180C982FA
	for <webhook@archiver.kernel.org>; Tue, 22 Sep 2026 14:50:40 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.23])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12115.1790088634978965011
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Sep 2026 07:50:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=WF8HBF5d;
 spf=pass (domain: siemens.com, ip: 40.107.130.23, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lx4R/Z6fimYEKjQCfDVEUa+Glvs2j9FgjC3EpbyEoOjsj3QnO7ZfuRgvd4lUQFEsdiWlCz8r/Ct4+VB++HrlFzxyzGuLZlt3v45QmTD+mssGEZe53CaQvrOm4YSBCtLma/wDbOtfDNrvDm2pGoGOZJwRlIyxvWykrhuRwfsxqoQdlYInxsZQlgBh9ziQXkOLZkrfFEoGRzgcaCD0gQR4vIfmIFgI8oRSUQwO/qYrHt9ZSGhY6jRaYC5+/1tql8tTYuhQjhds5IDTInC5u+e+XJezQIMTfuaL7kfo56tjtaD/XZGZg5WNSuUyxtpcAb7bH1SJuQt+qzWhjnHqqRP6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8xIHrHGodkWNtVo4tvFcSchzFK4GM5ZAMBUBtcBvjQ=;
 b=JzmPMZhsgyJ+G6bvFEHBNn+5XXlBx4JdMomFSjMP77V3EDpb35IxVG7UgUi8gIZ2+wYn9DwuMW7crDAs4ZZlfuLo2O9AFJlo4eAg9kUj5FG6a2JwdmFBduS25LDDFx3/f3c6gLyF75ebgB+eMs2++8xfl+aXwGJMkza4HF2SMtGNx0Pt7QIYympBu0tvR1sQI/Zsdp3TpioKXvbhUOWMReVs2coQliKwYaWkfyPU34v5iYNhSwssm5lvS7cHmv6+DONEm4cVFaVUnOAY6moylaVzEnUJeJzk+OtiKGtYaJOdGgnkgE/D1cXXrUQP5u1cuUE+xuaaf1giIywBjf1PPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8xIHrHGodkWNtVo4tvFcSchzFK4GM5ZAMBUBtcBvjQ=;
 b=WF8HBF5d7khpsyPBXFUJ0obS1QBBHzcXcUTooM9BrotJIVMO3/GmYXS4p4R4Hb+Tg6hkOnIsg4zQ0swrKPukjZ3e+yeulTJeMPPtiBggfhBAp+CNKG6NeaZwS316C+SwIpw88V4PYq5WAuBnAacoNMCW2FvnrGRmR0sLq5WtADYlDFbEFVk5AX9rA0nb6tzkNk9UfgBQ+Dpr5HWHtHEfZTeyU5ioRRhbPxaRacdMujGoQR7CMCIpIogG/e6LUFEU/FubTHmZ/y+Ch3703xpAeFAxpcsK1c2/myaX9u0pUj1vveymI4nLVjE6YQEso6wAkaMh4vnQVLVsyiKJ3dzROA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by DU0PR10MB5582.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 14:50:30 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 14:50:30 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
CC: Shivanand.Kunijadar@toshiba-tsip.com,
	jan.kiszka@siemens.com,
	kazuhiro.hayashi.f74@mail.toshiba,
	kumar.dinesh.h95@mail.toshiba,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v2.2 1/2] introduce helper class to set secure boot timestamps
Date: Tue, 22 Sep 2026 16:50:21 +0200
Message-ID: <20260922145022.167894-1-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::10) To AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3956:EE_|DU0PR10MB5582:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e89b418-7e61-4198-2082-08df18b8d8b8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|6133799003|3023799007|55112099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	Bfl77a9fGxCqj+STc4hmTu/RfWvm8+ZU5Kbu9O9tSNCxOCvX1iftLyhck2QSsbKwawG5juYbRCjMRbC4CYfCrSO6eSjgjcn6FFJw4ZAB7hshjaThQsRyV6iVUS8nAcop+3dxc2heJMDAD5G73splmcor9+Hgv1VteZtt5fMZtjdHMM899ZzV9lY4m2QFIX9Qm1dlXfu/d663ozGdcQ7N6F2avHxIedUkyfHwO+hbqW+ea5tjrSusvBIP0q6pK5sECb604hCxOMEjaqhI+rCeJFTzXxAxbg58KsYMwOVCMNQkPbr6CJNua3UqsT9eQwxn+pWitW6q/RQgeckV9E2a9LwgmANDVwCKzxXQ8UZObmUGRRpjLLdUOVLVQcw36KUQzPrc3qt75m6/6I+WziGvueJPtTVyHymMwvH+Cdi6qX3OApSJv8Ww0+mT3gTIbfb6NeLzWqgdWvO+V5yX2wdrmDHACn4gRz1AFjE+27BVw02L3MDobcRufhMLgbU7gF5nwWfge7jOfV9PM9m0xQnJ0LBIRnKd1Z4dHgwMyA/mRZ4VHTqlsYQ3tIWfSXzazFAVTAxTnKVdIbRlcLVLmHXKzspyB26D9PcBfslvkZDHv9jZxUFm2jvxyRVAh+2FhzYshVJP9hh+lb9RTnGYD9clWxlbZ9SLQd4JyyxpsAGf1X8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(6133799003)(3023799007)(55112099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?d9Xh+4k8y7WVpd6C0tdxMZvObdmo3tCPI+6510nwJ9YuobAyjMTHl4X6qaSN?=
 =?us-ascii?Q?UpLZlBGwIiI58zGYRfgcbARBfa9L33kQfT8vhf1V9MAF5qXJJo2VHTGbb3hP?=
 =?us-ascii?Q?VU3yJonqQmJ3qihqbl+WzhEX3Lgo+yw79kucs0OUYVZd8LnkP+9rQF1DmKXy?=
 =?us-ascii?Q?n2qbsbJZdagwx/zUptl1dQWqP0SAsoWTZ06grmw+imbZm4laxb3ahLslnJ1U?=
 =?us-ascii?Q?EtDnOFIQVLAc49JmXq/b47Vvou01liL2aGF/yBZ2RthRo8oGaY7EcTEJev+b?=
 =?us-ascii?Q?G7w3cWy/xGDXoz/LKvvtZlWri8bO8rgkZj0UqHxGYVivhvGETErwKgtwwHFR?=
 =?us-ascii?Q?c2sHFzuGWBsAXDy5JCgW7wcsw+PU8nmO9MzyefJrUsYwM76fsl7jzhRt+Ihg?=
 =?us-ascii?Q?nJzgoe6FK17WC3X2A4tziz3t3Xa3sCRseLyAOB1SAFqS4vFPiw1kuxceZ3ap?=
 =?us-ascii?Q?D69OM5tImIumLcrkuA7lViFqAPqd1FH+G66btdPmsl0HXx0r9UyoF5BNSNPS?=
 =?us-ascii?Q?aR8nkR1wwlSYKTwSiliqrHu7I2TS0oQxAufmKQnzGT4guEpTSxPE6KCu1S2n?=
 =?us-ascii?Q?bgPFdqXkrElhZiM6HQF0E1tFsJ75cCcJjBYq+zg5qyqb5YLDE0EuScT+SIJi?=
 =?us-ascii?Q?bmaGuNHkvlgsDadA7Ahftx7j+V9F1KLLKWyXXJ+TpSNLTjiKIynpQxj24pZF?=
 =?us-ascii?Q?WORCj4c+jq1njUDhg53BZ8dxyGJgQBUOuy47RPngYxKBz2V69AVmvTPKkPhV?=
 =?us-ascii?Q?WQs7xUQqWZ8UyZ62Ief1W0Tzma+wuYVyGcSewMPVtZbmzMVn6Sh7OrModA4P?=
 =?us-ascii?Q?lnkRjSrTZ2s0GM/2v1DpV4ueyzA1OkTbJoaNCj9Sm66w+tHkCr63/Q1CQMw0?=
 =?us-ascii?Q?ErFj1nrWypuOny8qcG/Ko0pcNFqQK2bx0mgbbDLwgB6U2MSyTk6rNzFQxaUN?=
 =?us-ascii?Q?OhO516mRvlfbQhVARHhu0HlbfK6AUh9xY5FetcBdJGD54R42jFeUIK6H4SHL?=
 =?us-ascii?Q?l2t6GYuPm+qlBVmwUwUmtOMUddAV0VqhEhJnynC1q+XYccJQgjdXn2cVHhRY?=
 =?us-ascii?Q?l7OybtL3FzOB9ac6BP6MZFoRj/GVY2xQUZuyo4HaQ53/zIVG9X7EB1pmXWIh?=
 =?us-ascii?Q?+KXUepAjZ3Kl9zeRI7+88GTAMAQhOItfSzrTdKz5NIQu8WyAqQNsOf0JgBKT?=
 =?us-ascii?Q?rnAtvCvAN3dekVfUsh4KiWe9MDPWd+/nTB+B6GcNnVW67tsPTSzEX7qVk0P/?=
 =?us-ascii?Q?jURMqOgN5AuiBosRrI7XXnA4MWWry9M2OUAK0HfJe25hPzNHkxZO/vnMFwlr?=
 =?us-ascii?Q?d0jAsOtl5kXeQBDswt3c3tDb5EvY4Jb1Ww8h7Eb2Wm71OU2IuVkwfv0Nt4e5?=
 =?us-ascii?Q?hAOF9aiMOQMrNg90VQv1dbfAPldAku8iDmCteQbRgz7OtASkbbDML/VVdtrI?=
 =?us-ascii?Q?/EB3qBroSrpDCJHpTzsV15ZO+hLROtXpBi3cMipMm7lo9xOQiDD1TmeJcAx+?=
 =?us-ascii?Q?miWDcZB03VfDwQeDjM5dL5oDtMN+4yvK7LCFllxhSbq/P4Y97/TNiGUK2gnS?=
 =?us-ascii?Q?ZrCOlDhw7l6z/mizTUR8O9kELz8mZhQy2RzUYxup0nS7+a/ndgSeFnWxWNbd?=
 =?us-ascii?Q?Ia+pRAyfIDJ1M/tn2J2NBBIXDq2zbnEj7q+oLHD4VRyqDnLe4SDqJDZTJFM3?=
 =?us-ascii?Q?hiAwwNrRafcbbkygv8s8/pR3QzQOjKms0AFut6Hx7RoHmLlvfub9HKm+Excl?=
 =?us-ascii?Q?RPZ4/lHQLaHhhfUQKMOpu1wACza+S7g=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e89b418-7e61-4198-2082-08df18b8d8b8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 14:50:30.1822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tiddQzM8Esn5ZUOGvQO/vZvaU3gHOZEjd2VP+skQTsPrHUTZSBtUnklJD+Sys7evLrRrLtRWeLwq62mFnFpfOSdUA9OiKWFhcKBe9aNPJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5582
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Sep 2026 14:50:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24264

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
index 6963d09..b522f6c 100644
--- a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
+++ b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
@@ -19,7 +19,12 @@ DESCRIPTION =3D "Signing script for EFI Boot Guard setup=
s"
 DEPENDS =3D "secure-boot-secrets"
 DEBIAN_DEPENDS =3D "sbsigntool, secure-boot-secrets, faketime"
=20
-SRC_URI =3D "file://sign_secure_image.sh"
+inherit secure-boot-timestamp
+
+TEMPLATE_FILES +=3D "sign_secure_image.sh.tmpl"
+TEMPLATE_VARS +=3D "SECURE_BOOT_TIMESTAMP"
+
+SRC_URI =3D "file://sign_secure_image.sh.tmpl"
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



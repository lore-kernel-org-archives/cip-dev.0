Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBF3CA5FE7
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 11:20:06 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9457.1790939991891002964
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Oct 2026 04:20:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=NpqKS5UA;
 spf=pass (domain: siemens.com, ip: 52.101.84.34, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umL1wIUr6Uli7K3+gj02AxZcChuMIbGvhhE6Gg4L3SMsgjInwIAmeviZUxz/oFI8fvWEXWHm2o3PO2UgstHECBz83RBiyBCA6PD32tQDPd7zYRxOk9oo0mxhV3i4UfR+MSBnOvou3/ysG9r4KaLpUPw7+b0MLMoZY4gSQb371qyNyN9laYA9PTOLR3Fq55qW0xbv7gbRW9MpSE51whC2R9OzZvjn1qzVtX8j5RPZybyiLtc4y/q3oUtZuN6GArh4JpyUuuRFdnbOLCCDj61rma/eSZn+hmbWuolm4qc7WBxRTfjv0496ljq7Ujzs2UAI7bXYLMDRopCRF3mboRUX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uq6suQrxpeFZSl19HN9ocRix1fIK+MbXr2b13cwFF4o=;
 b=e+TcSmMd6LNwptOcD0+tiqJXbPOPrphRCn6kw9i8nJ3aiSj6trhUhBJJM/GMICKz1J40VqRbP3GLsgOtBCytmQzwBlZVuRstTgulj5DCF1MaY8O4ymbbNUjUT54fF8ZSeG/r81TPvurX8SYP9OQDp2F+qGcDBsQVbcquA/nAMh7coHeca7t6KP81HB8FlM9fJYRLWZYlrSVxHac9sJgp1zaqOBGYS8TXUHHorUtBjhcivkNti8dpntAHssV6iv+iqKkYoc/GVW2BQQemJNONgpSQZaDOIgvpczJabx047hufo6xHCYCN/CySd1oRrLSdMgcsuB3CiKvkfStlZZeOYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uq6suQrxpeFZSl19HN9ocRix1fIK+MbXr2b13cwFF4o=;
 b=NpqKS5UAcPeK7MKXsOhbF7TwQak7T5VAN7x2GLa+GJdCJoHxjJ7RPsiUvQ23g6ZfHyMM5Z8tw7xpw5FNLwgpmtonyvlDE2BhtSFKPxzy+pmyxqOA7bJGfrtAiDqw7kGmOmUUlJmHu65Tz0eAbyc6NEiQ5evbQNdBxxyRoiPDX0w589aVH7Wc4bDVQ8b0AxiUWLGSp3Cihxb66ydbw72S5itC/fux3ApLC+rON0Id3JlTFZRaJkodw6uRfggc2iZx55aFx/UbPYGBHF0qTTvG1ZqZBizeN0y5xxK4sPGpPlNUEbAQST3mtGFXyW8IO4+A2wsgYL1snytDhtGdtYw8aA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA3PR10MB9311.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 11:19:50 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 11:19:49 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	cedric.hombourger@siemens.com
Subject: [isar-cip-core][RFC 05/11] embedded-dracut-modules: add recipe
Date: Fri,  2 Oct 2026 13:18:52 +0200
Message-ID: <20261002111938.3600786-6-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002111938.3600786-1-quirin.gylstorff@siemens.com>
References: <20261002111938.3600786-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::17) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PA3PR10MB9311:EE_
X-MS-Office365-Filtering-Correlation-Id: 86669844-6005-40d3-9fc8-08df20771238
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|3023799007|10067099003|11063799006|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	bRwUG7pGwKnZxPU3N3JKe0nGJpqn3BiLCz4++3JSeyYV4ms5qWr+wJDOSSQu2tvdKLxcdqpXeHYbmVt2tF8V5tz0Imi8eGo3hAj9jrkxBH7dvbC9eC+S3ZZVu5lqrP/fR+OhkUvJ/95sfgvcKwrkQBTwGyJhZMIQ3bqf6a/uStxjmeQeXmDk9hEC77SO+Nx3Jna6IzZbnopFZyXCqnQ6fFaQ9ybpWS43sZtr/75bb+6vu6p4reCrScHHSB2ZqmeSU+cNbzD/J13R3hwBlrUt1jOCrRkI5tlg2670hHKZxmK49fWmhf7DZvLVAiw0nEfGDJEbqYMhDUMMykctrVrhBRP2AIm+sYWeeeUtpGClBpuaVYSKkihU4IfUmTJxLHOWEos31c7i3HpIW5zOC4avdBr4LHALSTzs3/WoYW1gHTIcl9xujfcSE8Gzn0FYcr2paUQe8Q+zdDrLjK/YAsKKZPiJ4jBsjqtt8PF6zrcfWg9TARpKvldXXCaIJUbkMF9vq6DqI6joMEOwFRkplBghnwZ7TWMWmfN4Vt/IBZxRgnYV25LRpBZkvJCwwvq4Va65aU60NLwJ4QlMmq312Iz95th6dsyPvxTBL3yRA22wl95UNeuPY1xVklfnnnyHh9pQkH10RYlonR41s7ilSED+TDR+uIjlUuvLYfJ+Zu7zDOY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(3023799007)(10067099003)(11063799006)(56012099006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MDEeCWSzzJiN9SJo7d3sgi9WA+JnKTFU01vJoOc/nmBcs0oZ19z+6lNqTvrh?=
 =?us-ascii?Q?tGLaKdrMLKDaL8d0tfBS6P4RKqIWveUnTn3ioygL0TKVPNS2fpIOUfJKbSHi?=
 =?us-ascii?Q?bv+NXUmslX+I1g9ALidW+viqyZJbAMLZJmdbTn287O1XyKEHnvvYrCGli5Dt?=
 =?us-ascii?Q?vw5TYv4C9IKdZNHje2MaILUkOs3N6PrZDKNUSIpqAFrhY0H+jZ+Xr1/SQBUz?=
 =?us-ascii?Q?GuURP23kB2A3a46VgJo44XLy6rcQg2gF58RhhgZRk07zGcbwttvf9qI3F/Gb?=
 =?us-ascii?Q?1cEnPgQtpWkGjLZNloHOJqT/+/XiGRS4v5FRhMCYgqC512hKeyQEnOac9IT6?=
 =?us-ascii?Q?/xDkSRYjSGrzl3QIRIEZqeaeSrLORHshzKEvdh1SGMtStFl5VhSp3bf/Lb6V?=
 =?us-ascii?Q?vvIUAUFWlahrn3CeV+06dePeO7yHuVFMqRTKLiIYRL09Y+dnSfGMzVgHsY9e?=
 =?us-ascii?Q?3uxLps3rw0IFfDdS1X3zpQjHdtA+51CxU3xSNzLN6y7n6FEWJxH26yQUtS1W?=
 =?us-ascii?Q?Y29s4rCoD2AlhbF5AgAdbanlmYoQr00QNu8ga9zywaVwOLb9aI7hg0peIDPQ?=
 =?us-ascii?Q?KDQzjTO8inublrBgKl2g9RV83/8b8IOOcYR58ZRbB6zBoDf75GH8EpZr9TeU?=
 =?us-ascii?Q?8mCp7GJjyqjQdYhp3SMu3P8WlAXIQfj0HZAJxW16ef9xcG9j2W/m39DK9siI?=
 =?us-ascii?Q?TpvI88XIGdMriZImQgxdTk3xtgS1Id4l+/vQrFEZbGVcbWF8TVjApKamqlwV?=
 =?us-ascii?Q?bPlBGtH/0fiY5pb+VlmB+FkMfL4j3CFNWq2Tp+otV2gyHP1AXN0G9m7yZOqQ?=
 =?us-ascii?Q?ZVaHN8mMdQuTWFcvkiFI4dW7wQwJEFB0kcZqdFJ+YUKh/N0/+09yJEICX8o3?=
 =?us-ascii?Q?tm71Qfgy1jftA88FxSYI0gUq11yfczQi8YzrcoZkOaQgOHZIW1NmHmD2KQaj?=
 =?us-ascii?Q?XDz1ixr0tw9sQWd6lYAOKh+9zeMoAcjacoIVr9BkW5LHPWkEo4dazT2Ykqg8?=
 =?us-ascii?Q?SNI95IbIZUmAoFpW1h3qPbVUkkokdEy8+r3HeUCfEEky8yj3SVLwiX4vUd06?=
 =?us-ascii?Q?hjecEYFqnsZh3J7AfSB2+Y/c+6uqviPk0ayKxZykguiNd98kDGLOYPfKSl/V?=
 =?us-ascii?Q?Gp6M75h4i2hcNTzdkpt2Sxm66SBgjyyGEYGhlrAbKIkhAyB772p94wLzmQe1?=
 =?us-ascii?Q?TkwGi5KN6n7vB9GVd9uNXEbO67wbIC+jhfHIGGq+LgowyinkjjpJKjZAwTwj?=
 =?us-ascii?Q?tlzCJNIdZV/wK5zqJxgkj1HI30odvKi31dCrHaiB1DpJZYMXhNAFYo3lawsH?=
 =?us-ascii?Q?cm1xurh2//vfiNJFTs4HVjKMSCsGMiSa/LSlApxzrz+kU9WxUglYow77vK7X?=
 =?us-ascii?Q?nsYZ+iTxBqX5vk5vf+4l/lCPEu8ZIfzL8lTRtmcLNK7Re71AodzaEVvoomw3?=
 =?us-ascii?Q?qtCEOFjwHIWdMfKVwFLE2H4W1LREXdm6rxHfLAT3sNoNvaP6zEMi5JuDiZ+5?=
 =?us-ascii?Q?SKKquw9EyRDzZ8RBdIuUhyrTns2fPqB6q8AOHqQpprDJ5mTDB8uawMJP9Nn9?=
 =?us-ascii?Q?8qVkdkhnVpiBRF3v9Dqnk3wpB6PvSSr5x2AkWex7N8Inv9KySMG1+LUq7rAB?=
 =?us-ascii?Q?rjLITOPAQs+bbVNAfTB+ekjkKQfoCWiCwtz0aTlc8tGyO7W2Eqfq5ScVHCde?=
 =?us-ascii?Q?f0vgvTLWugczQluDhTgPdKyTTtT3JkFbQvQJ8LTiPwZVSyjaiBw1jrAkPl20?=
 =?us-ascii?Q?GlSpFpbkwcFM/SUWkcxyW3u+5+PPCFI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86669844-6005-40d3-9fc8-08df20771238
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:19:49.1045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rISexz/HsJwkjKofXYtna9THGXfIUx8lkBoYJsOSDtxABLHV2M1NE+797YehsAvyyQ7IcsRkGvy/9LDIZOZIdxlbYVhYH53AK/o2mYJl89o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9311
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 11:20:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24408

Builds the dracut modules cip-verity, cip-overlay, cip-crypt and
cip-factory-reset from the external cip-dracut-modules Debian source
package. The modules replace initramfs-verity-hook,
initramfs-overlay-hook, initramfs-crypt-hook (systemd backend) and
initramfs-factory-reset-hook (EFI variable) for dracut-based initrds.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../embedded-dracut-modules_0.1.bb            | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 recipes-initramfs/embedded-dracut-modules/embedded-drac=
ut-modules_0.1.bb

diff --git a/recipes-initramfs/embedded-dracut-modules/embedded-dracut-modu=
les_0.1.bb b/recipes-initramfs/embedded-dracut-modules/embedded-dracut-modu=
les_0.1.bb
new file mode 100644
index 00000000..5e7cbc6d
--- /dev/null
+++ b/recipes-initramfs/embedded-dracut-modules/embedded-dracut-modules_0.1=
.bb
@@ -0,0 +1,21 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg
+
+DESCRIPTION =3D "CIP dracut modules: cip-verity, cip-overlay, cip-crypt, c=
ip-factory-reset"
+MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+
+SRC_URI =3D "git://gitlab.com/cip-playground/embedded-dracut-modules.git;p=
rotocol=3Dhttps;branch=3Drfc;destsuffix=3D${P}"
+SRCREV =3D "5fe822b058bcc9e035da4ac5056b7219b8c3d9ba"
+
+PROVIDES +=3D " \
+    dracut-cip-verity \
+    dracut-cip-overlay \
+    dracut-cip-crypt \
+    dracut-cip-factory-reset \
+    dracut-cip-watchdog"
--=20
2.55.0



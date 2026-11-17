Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.8])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15713.1794915001116929499
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:30:01 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=fqH32jUs;
 spf=pass (domain: siemens.com, ip: 52.101.83.8, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msk1RYFvE/vcSNLEuf4d1R6AHCGJchGm1nkGGOvH+dCm3NyGz6krco+K3f1pxpq7ow6UI27HMfp1+jBq0XsZDacHsaeCYP3dT/UP+VCG7HN2TEmWvC+7Ls/asqJ3yh3Gw0RGdnK7FxPOvPRvtmYB0M8ug4w3ZfwNwJYpSt2uRIiMpvy1i9dscf3DoNQ8xhGu/1GRCkZf9mnGHP9FP8u68bfVQipgTVYGck8Jt6nemuZGEBkMmuJN7JMsDla76+wUrD5Ivbxjw73OIKnJy9fo4g2mOx1KVL/HGH5WuVRGVYrGOvjBvrB9qSGZwWAfbcFNkbPu5wbqz2F+WRTA1OjPOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRANpsHTbZBMzsIHeTRY+QUofQgH8PsfnC+neM6hc4I=;
 b=DQU0zqbcpkNQWTY5qb4rSMD4ODAn1jQpyAd/EmCF68NREq4zEDwfoQTXGCqRs8SKSmS5GdZpBx9ZFUZuY9uGBEGybzuqRpWHKRx7KurlcIm9/KEFSuMYER8ZkMc6OINi6j3ERlWn0nQdN1tPAdoQRXcPIDgTPgXopGrla7QU4zq8SA1AkYaSs5e2mKfnfxFF3iuvGRQ6BOMH9PtxFOS/B8bDQyVI6kX84TScfhHwk5UXBEX6pnLfQYwyXPJuwBoySdcxe/AP41VeM0oZzvGvZFRqUh190Sk9lrTHn3a932SQMWzdwvLiOycy5YBvXK9YiftK2YVdpjqt4foHTMxbLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRANpsHTbZBMzsIHeTRY+QUofQgH8PsfnC+neM6hc4I=;
 b=fqH32jUs4nSCFlhEMbnpjyK6m2Rqr2Zqp1IiobCGEHxlu2STOZQi/rjHxIF65pVz78IFC4leu9lziZroQE1gp6dv0wWNHceHOVZ1CIIYgVVgsHo+S+P2zhPo+0iu27A+Fm3GGG9Z8Eiw5F3CIk6Z1mdy7XPtksbf/ZzK/TuOja2S+h6ikyNE98kpZvyg4skI/nX+PnPR8PlQ4bk0n+f7r3bIstH2zQ0+PzoyMdDMjGEWiYm1Nvd8MQJhdMYlRpehRc3mJVDc0b6oSPVffJJEhP5Pn1WUjx9AhOTK2j4XqFZYMvAazrMH5ndg6sG1S9wnLJUdoPkj3AdSL+mMOAySpQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS2PR10MB6615.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Tue, 17 Nov
 2026 11:29:55 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0639.005; Tue, 17 Nov 2026
 11:29:55 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v3 17/19] Add ci build for dracut
Date: Tue, 17 Nov 2026 12:28:31 +0100
Message-ID: <20261117112833.316234-18-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
References: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0396.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::10) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS2PR10MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e23a2c-6b51-40a0-801b-08df449e1a82
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|11063799006|261021121427099003|261102123227099003|261009223027099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9I4oFmacGbuuV5/qVbypNTAZQmC3cARilXbh3eY4FftHMQh8ZUwLANKyetwKJyACqI3mM55DHUkYdxSYMEAfCUTeIjQRpfGQS/ymh1i7IQLJMM3zVJGRAQTOBNczHBu20UDcUB4143dqwspXQ9SIMO0d9My8vnBYCOVNWTU0rwkO7c/CfpRJiEvxwflkp96waALvtiT13IbxBRh+SOxrALH4YDHuNGwpF4HPSgv1KYLrfL0UM0SqFfDaQziJs23CO8nQhoVu8LJwboqXkLPFI1Z3Iz/FdU5L+xC/uQ4WpoQFifDM7qaheKvToUSDvalz+SwdHMPfMtPmy33wpkqqpKHoQTJvIVPb9XE0/KVZ34/tcoem2nfGmlpPeSxo2goolTfiuXAYqw/k35pn1QLdPXNMV34sAkbXEsAp7TJrx2481QXKEV6I4Rw6DivnDs48tJnuHA71ZP29kn4ezo0F/4NZ7ku+oeYz9V8ZDnuZ/ApQc4z+S2v/J3YHW05mChI4VaJBW4di/Il9UrD5TJBuKYIdS1U9y7g5nAUnj13b6Ou8EUrAma8vcg646m/1PHUMWD8F0+K2IRk2j8jDxM+zdaD0plZj2rLjcD7kZRJa807DvBZOMKNefurLv2FzZ7VAPoFnz+pZGNK1NlbipDmPZvcYxu1ITQdvgzcHW35N2eU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(261021121427099003)(261102123227099003)(261009223027099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7cZnlumNwzMX+0w0ieLabHKj8lusSlt1PtrjCQZ8LfbQlMAMLdCYy+Ei1kxR?=
 =?us-ascii?Q?BnM+U1qm6+/aLO0eAVKrzwovVnVioPxdoyz13HD67xqXdAsn+zrTysDRAoGt?=
 =?us-ascii?Q?7jrX/Sk3p4+3EbCvq0foJ+fcPwj9bEh++TXR/XQY2iChWOI1SfcZSl0T71lT?=
 =?us-ascii?Q?veibR9xDJpOmw9DBZ6txUjRemwwvjSLSVlkcfaPs1LCWzyVphLS5oubku8Ge?=
 =?us-ascii?Q?s3H/7SSRFCxexiuEKavcJDsysX57WRjoJXZVhXB0oDzmcpEhKfr+VTXY9+2t?=
 =?us-ascii?Q?oEGhS2bnUFG43owRtky6D2uzGZj6e5hrBwZ6mmt8VB87JLhwQJkaa7vMFZon?=
 =?us-ascii?Q?vViWGu4CaZ98/5TWPkHwmh34Rllu6ZnBXAuCJ26KYo5EAmfd1Yf5zyPWpXSI?=
 =?us-ascii?Q?CJnyLRU0LO0o/A0Y+PxMRFUHm+bwlERj61mZqRWB5uz3G71iOpejUCGVhGJ3?=
 =?us-ascii?Q?BPUOIZwagpiiXvyMqKUp+lT2HOL4sNz22agdQ66Vob54m2wAMuQaSuIzMVXr?=
 =?us-ascii?Q?Wzi+OrnGGj40UpZiu1/me3MuTAUMPc1w//VeolfJL/7k86BmjjB0UK1KYqBC?=
 =?us-ascii?Q?+vfsBkaCajt7Zx7V4rXcqyRKd87RYTncMcWvkKH8s36N8NT49gKcISYqYwMB?=
 =?us-ascii?Q?j4hieF7wfdSKViNCGWn+2bY6PTAJ8nmDY1E3JqLRGbRMfSuY80mTRNpS63Sb?=
 =?us-ascii?Q?lm7vZybrI7AbIeuww5E5RzOfQVZTEAYeB+/rZ/8U2k3Bh2BwlGjQh3h8cWIa?=
 =?us-ascii?Q?xTaCfWNq9C+D1j2DW9lx1jpnLfwDG9hVhax9jWlaRMPn/2dWBc9tOLrxzgAL?=
 =?us-ascii?Q?2CK7wRSy3TdAo3iYb6FToghkYt9N6bPpxqsUAIsy16WRF2YxtvrenInX114s?=
 =?us-ascii?Q?eg56ctZcX2iO30arHbzd8YrdVbF8QmlgpLoqzUXQMBSQld62Nku5vC+uJojG?=
 =?us-ascii?Q?bQxpNI1JzlfKlsj0GYErOvDW3Hz66Zox6UPt15vsBwcgRSX049D60Ai1i8ru?=
 =?us-ascii?Q?7W8IGlq15XzYNp8DWw9mMnZWqbLPTk9/DB1suLB3CK/XoeJM9rA6qiuTMT6y?=
 =?us-ascii?Q?S2KJLzH1EgUqPxiQxqZFdzDO5p45u55P0OP7dIEQQRAbeGUmSK4zZjNqQ0XN?=
 =?us-ascii?Q?1Lc5TPI29X8QSR6Xe16VVNdXlFRZQNUcbKKB6+sycJYQDEmnn1LhN0TEyYBP?=
 =?us-ascii?Q?Pnt+ucyiAXZO8t/6Dim4KeUd7mp0uDwtpOfDsfec9cYh92QbqBbHYsNBie7g?=
 =?us-ascii?Q?CGQ1pXiYeMV2ZaLigYvabxh0gWcPYgS9D7KjkSxCfCu+/JjxE8vLkL8a8weP?=
 =?us-ascii?Q?4g/uPmwDsh3MCeJHa4ClkCsRXQeTtfv9jtUeUVt5xFgzv5SZvn3kS3nOyoNo?=
 =?us-ascii?Q?SYCdg1n7aZ9FZoVo7mIHN41YoqiQx/C8gZ05Asp+J5H5IqnlQ7uVBbu5D72T?=
 =?us-ascii?Q?q0SCyDttAtKLNnEtIw8Dg1SK53B7tA5tjDnX00dWLSOIk83SSoPD84T0M4uF?=
 =?us-ascii?Q?Ng68UtZba/6Sy+tQLNb8G9kXiHuzOEpeNWvbgEk0xtMMiUl95AiW96Uz4OH/?=
 =?us-ascii?Q?TuCnDKpEfuo6np/qlay+sAJh+6TKV0ioa/OtSaUknsJ+Fw6NiPL+QfWAroz4?=
 =?us-ascii?Q?IST8KWDVf4RswxmxXdUbJBcMyuKcVaENZ9tJJCJkubmBIplOznA1stcUEKTV?=
 =?us-ascii?Q?aGzHUWHKdNnG3AA4TY1qPos0YkZM1N0bKsEb5rG1YbN4+hd3y594IPSxb/Ao?=
 =?us-ascii?Q?2hzdsckME7cq6wVNPjWdXM4FrdjkUd0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e23a2c-6b51-40a0-801b-08df449e1a82
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:29:55.6709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YeEillvnSYpglzRO+MKUQevXPpvbs1MBlAtfq6ncRc0IBszNqfuRVnt4WOLocOj/s6UVapzRrHcJh5LnFZeWJ8G8lPVKuwWW7cOXwT2sH4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6615
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:30:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24838
Content-Type: text/plain; charset="utf-8"

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index bf21e744..daf0fc9e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -271,6 +271,16 @@ build:qemu-amd64-swupdate:
     use_rt: disable
     factory_reset: enable
=20
+build:qemu-arm64-dracut:
+  extends:
+    - .build_base
+  variables:
+    base_yaml: "kas-cip.yml:kas/board/${target}.yml:kas/opt/security.yml:k=
as/opt/dracut.yml"
+    target: qemu-arm64
+    use_rt: disable
+    separate_home_partition: enable
+    factory_reset: enable
+
 build:ti-am62px-sk-secure-boot:
   extends:
     - .build_base
--=20
2.47.3


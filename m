Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02AEC54F4C
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 13:14:32 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30484.1785158065588134612
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 06:14:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=GGlWpMKP;
 spf=pass (domain: siemens.com, ip: 40.107.162.57, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/RN4NH32zJbAC/ENWVbtNyGiEuO5cxboxmYQJL8Zlll1dI4cCA8RPOkfdXo5H9sM4zgCFzVTXpCBimZG4OtpxlX5Vcts7+w7Ajrs/OOoJr64QUFSjFiwVJKv2EpxFrcZiyGcebOlZlPV7b1QNCDh8wmDKYkZ2rnexkCZjYhqQ1aYa34XR8bMhL69D7wx63di/PBeXzcZtixZIA33xNShNxd0OKTeVY94o0sSkueikuVrKKLQfyYASRznRrA5FktRKooc/ruCsohBGxL7T1JEYLRj0xwUqxdKg+6L610Nxaog3J1En0mSl5EO6IhfwY1IRiXeRTQDHQPTgmB7g1a0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiZdU8koexy8qerNLWJ6AxAKkLeQHf+NOfpis6QdcFA=;
 b=SKHU0XVMNyOpXAmWGxJ8a0jDolSu9IE9ZmddkA6CnJsPfot5F3lQAXDSzhnCysejxaC42DC4haILUZ9XKwO91aS5gcOp98cKgdUQpGfy9p14wLK30xAvizqjgnwQ7p8n279TlkIVe4Mrv6Xc1WvLkBcCfjoaMQHC3XzHy0AjCDYG0m+EzXjLDwpKkKUY7zm+ISKIteNvq30Bea1PW0S1UjJHluGSj118ana2KOPVDr7hN3T7yuXNKCkKB9P97k2HxmzPCANmNxRykQETp1kcLuWMPxn6lD+jhgjLndWcr0bv4aRrt9ttubENkf8ito0lB3tT314OWXNDzKlxXcrFEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiZdU8koexy8qerNLWJ6AxAKkLeQHf+NOfpis6QdcFA=;
 b=GGlWpMKPvafgUnGTBjzvPQ6SPF1PE+7r8650a+/oLApTJg1oZtaFaDF1LXHr7u8eomHk0SHiOZC6vQOnHxcBV5u0Erh3wtGQ976SMpZOqj2jQ5mgF0bYf1+Ha5eQAVbP5vVrdjytH28b6z3BmHXR0RucxYj1gXcq35ojvO7UtwQZLeGoM917gDk/nbVdU+XIJ87zDsVyts8mcvhdvXluwQ1QB7z5Gl1PShQfiRpGfqB7Tr613yB0FylMGNGK+35vMgdzAS9MSQyWKBRkA9N9Jh7HNltmnQ3hFvsWuL6cjak1UEYw+eJwd5BTfTINypxOZD7S3+CZXWwtBj1nZr6cEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by VI0PR10MB9835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:326::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:14:21 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 13:14:21 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	christoph.steiger@siemens.com,
	clara.kowalsky@siemens.com
Subject: [RFC cip-dev][isar-cip-core][PATCH 10/14] Integrate cis-hardening into cip-core-image
Date: Mon, 27 Jul 2026 15:13:04 +0200
Message-ID: <20260727131414.76760-1-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0088.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::14) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|VI0PR10MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: 389a9458-7a96-4db1-054d-08deebe0f88e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|55112099003|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	ptGcTohaMrnX8/ui/Y9vUVG/TahMC3pevrxB8oxcfuIjqavjQNHqyoBnHwb2XJ/GoquMKLUD7RRscyETV/DEN2SOXyCn+ZpL0ZuBjc7/1bU+lSPrC1VY/5djRVgfLL45CaNHi0QTMP28E6hZp8ulPbtRu4MKBiI0QOHkLACtuJLU8Hrf2mIF0THNlu3YqE/m63Wo4/N4oRU84duJ655ah/40YIzSqdk9wynLSQpliysmsYedx4BM7NOqjtgV9kEiepD1OkYQJJw41DSC/Gw7M5ewutHF1VswjDoxo7EcKZPGjcUZQKfeWgplF/adaKP8TDf/GwADfSZGSpeKLFmS9YvlqqbG4VngHrMIyynqaJA4o2v0gBpr+zU00uusdBb4VHWSQTFjMnkFSop/vT4O69KVXQZiO5AUoEiWd41lCTDXc3hXrcralXGcjmTINM4RHIqs9KPLlXEF3SZyhoOFpGfEMd6uSdkjqr9Y4aG1UTqBS6091z6Pc1416mMGFg3Qd1z7TtSrey3cFS0ynn9HMzce5p2VHf3tOU+F3ldw4Xr0uS7K6h5QiBn57MqLpRQGK9p8M1rVHwj7L1JZ4LBvWRrYU4Xg43y95gpK6/uHlVSARlyw1HB0FImgqnAb4w0JPpOhUK4//ooiyZuQh1olZwmDftmSv772R2S4i1Ttn90=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(55112099003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZRuZ5R+ddmCfgltSKugdIpNLJxh2KsTNQhkOcZPvCP8xRmeYJFIaraMxHsXi?=
 =?us-ascii?Q?V+efgxboJrt5yomwvpQwG8gfs2VKdY+mO1cj1g81m+aD3hyIGMiS4Hkwrby0?=
 =?us-ascii?Q?AnR0PJ4ZDhtNEGMVaiDMkoxUAMvuKK6WToCvrSR3jEZvb7BJQb7hLG/V+dDC?=
 =?us-ascii?Q?5DMF11ZUUJob4lAOVNZlqKuTxFwAL9PiCIE297PM14HevBbSCNhO/WHYLeB1?=
 =?us-ascii?Q?70cXjf4Qmv3+WI438Hv7VHWCYQ3KNuikMNtvUcE3hZ8RSHfbr3kanSErMT3u?=
 =?us-ascii?Q?M+QN6XRNKjloqopDwLLJ6zvmdzH8X2DdO4eLbHP3+bZlej7gO4Vetfxe+LJ/?=
 =?us-ascii?Q?M72irJV3YF6469PKWN2yt8KjIZuhuJfKHxFWBJUTVCbc12dY2kjbcPJShSfJ?=
 =?us-ascii?Q?TLGHqHJo7xZrWfNH8GSFS1yo+DwcDCbemVnekKJzk4OJzTjJcyd9GlL7o/ga?=
 =?us-ascii?Q?RE2Rv+TroAoF9/3yduNY0pUHN9YswhWj/4KNaBEuaNfsANH/rFVrDcWmnV9i?=
 =?us-ascii?Q?0e/ls3yY+wRxJFbrJbjQhfO+ABoCX3GTh+upSWboGQbMqh1xi4QsQU1Ivzab?=
 =?us-ascii?Q?AcWBbbBbcw2CqkG2rpS4oLSz+4hTVmmoBtlIbz2g3QR3SRjAxGtxtr3NH8xD?=
 =?us-ascii?Q?iczUB4KtebP0bFN+OZTmAQgF2ZR9bptdP+zS3X5yhF7WmdS6nQneNqsIf4+s?=
 =?us-ascii?Q?TtNH9AhPhYrd7i2i8P45ohfNBk061zPq85RjccYtMFXCl/OtF2DcD62wuOqs?=
 =?us-ascii?Q?SBQ1utWHH6GhouLsEqnw/KwouNONIziq+aw4RXjrQqAQL5HX0JeL8inptNfp?=
 =?us-ascii?Q?2Ot8zGjh/taIgxUDfXyVXD8tFI2+zKJbmpSDsiwFFMrC05lRN5Kj43Z4X593?=
 =?us-ascii?Q?IdiWggo3JIY93Q3CVJ1dHUrxUSv7M0uEKKan8Udm497dOHS5c+gRKT5EkEuI?=
 =?us-ascii?Q?DSNi35g9ZgcP3ahFwtez3iczNp69QkZK98bFFjgPCR7wlmvvwWKeyVLOGibG?=
 =?us-ascii?Q?Rpn2D2c8HX04o2otHr36Bvb/Vg+GCU8W18XIx0H7/iJnD2KScjc/1OEJ9wW9?=
 =?us-ascii?Q?YE1d8GownA9CoEq7jjbcli5+unnmbiMp2D9uZuql1TYKCdGlaoYd+CygMa0+?=
 =?us-ascii?Q?EE1Em0Bd6Y/thIIpJTqyblBNSjUb8mb988mMORM5Ol5qjgXUfMMIZmSQlglH?=
 =?us-ascii?Q?twpV2WLQnnB2OchGMXB89Wc7YJ4gpJVH49wrLJst4Mofz8VrGBgVWVRcanPd?=
 =?us-ascii?Q?TxCrSgzqX6fn1n2mED++7240gAdoOSpVwmUCCMey0LUVp1GIaKFPqFMbnBV6?=
 =?us-ascii?Q?4vNUrkti9lhwBh/utW6PTvfm5e/rkQ9P8MyNJh/nzTz2azhel/ptPqJCESmO?=
 =?us-ascii?Q?OIHcRBYFZzgd04I1XVAyvi6BiHQEvSBV4hITp0USxL15lWClUxthkM/vsNv/?=
 =?us-ascii?Q?Qwyq9i5bm3QXnJgL4O3qIXQiUBg5DH8o6GOQs4IjYEGD1cx6QMhUiV06TWvL?=
 =?us-ascii?Q?a5ydDqxX32ZcF4eJSFLKKAjMMHCwobKVkZYmJDuVYK53z/IQEgqnFbZ7klpc?=
 =?us-ascii?Q?8osCLpqpqMujD87JoYvGaH5AhUpJYjGyAOzbbM/rJdFv+ZmEZp3vnQQt1E8D?=
 =?us-ascii?Q?fGVGNmzTmqmmZfLEFy7+j4yIaIH5OD1bYLfl7Hs0c5XO1Nl2WdOK/+bqCMMG?=
 =?us-ascii?Q?D6MC6AvqAGqrb+KdvPHYiGErOUK2fntF21TXKSec6VObSdTE6b/xxa8iGAq8?=
 =?us-ascii?Q?xcyCWA9zxUxSQhfvSfXV/64GJ0nzV6I=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389a9458-7a96-4db1-054d-08deebe0f88e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:14:20.9857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLDkWnHICFSkBcjDd0ZHuUjRKK07auX66mMRDA2FYhgM/gpRf5DbC5TTRv+naJCftHHGFYXgineMn2l4WoMGab6LJ9ql6qR47WUFPPmlFM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9835
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 13:14:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23762

Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/images/cip-core-image.inc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-core/images/cip-core-image.inc b/recipes-core/images/c=
ip-core-image.inc
index f6162cd..859aee6 100644
--- a/recipes-core/images/cip-core-image.inc
+++ b/recipes-core/images/cip-core-image.inc
@@ -10,7 +10,11 @@
 #
=20
 inherit image
+inherit_defer ${@'cis-hardening' if bb.utils.to_boolean(d.getVar('CIP_CIS_=
HARDENING')) else ''}
+inherit_defer ${@'cis-kernel-hardening-validation' if bb.utils.to_boolean(=
d.getVar('CIP_CIS_HARDENING_VALIDATION')) else ''}
=20
 IMAGE_INSTALL:append:factory-reset =3D "factory-reset-helper"
+IMAGE_INSTALL:append =3D "${@' cip-cis-rules' if bb.utils.to_boolean(d.get=
Var('CIP_CIS_HARDENING')) else ''}"
+IMAGE_INSTALL:append =3D "${@' cip-cis-validation' if bb.utils.to_boolean(=
d.getVar('CIP_CIS_HARDENING_VALIDATION')) else ''}"
=20
 ISAR_RELEASE_CMD =3D "git -C ${LAYERDIR_cip-core} describe --tags --dirty =
--always --match 'v[0-9].[0-9]*'"
--=20
2.53.0



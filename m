Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F963C98335
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 18:09:12 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4498.1790359747804930283
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 11:09:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=qpelSQy/;
 spf=pass (domain: siemens.com, ip: 52.101.72.22, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KehSVaH+opbKV7RfAgHUum1iycv7hkK4WtJdTkiy7zLP6TaQ2Or1Dheg6alU0/cg7PYAZWT6du3m1t+RoqA12+RN05BVj+CsqwgNJHM+KgznsuoVfViVKDX3jVnY8qFlp6uM8zM+A06fiyg4MkGtJ7KxvEXgB9dicPOvIW9B0/YPz0oA38emnXm8d6aNbhlYztwYdWi6ybiqjJth7wejkautZCUIqFunySCwsP0O8XLmA1Jeu90vUqAJYbRo2wV7E0L0nRN9id3sWP6ZR34q5NXtN2x7sj2dh52isJsUMKZAme/uEJf6YNlw8pbHuqurO5zHzVMMBOha1PNyGWkofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeMZWOZR6QhMXh2wStE3MXAoTAZQy3C6mGHRMdII5Sg=;
 b=YPe4HKhwFLuXG0YQwGI+Bmt7BCtXxRQ/puQltKPMEjeMXluTF+l5cbTuEx/eYBUxMdpR7aFVFXdAsMnqkIjA+5ij8sQuirXFhy5hgzRSiUHNIU5hWjmURUXKVqLYzIgblWOCDInNQfc0xisSmp25UVufxEKKoEiejLMiUVLaGFojpaDlkoboLuApyOtACXMGB4/bUq+Am8BZK47jc5oe2XUIe3Rm3XwKagPfgBCMlNtpKu+Gq7QULxd6X35TUIci1RuxyIf7sTNDnRtpHvd2P4XBPgFMV7jqdTUyl7U63qS4pjEkXnigPL5shB+r579aMGPUjoVLcP8/1PoVDCY3wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeMZWOZR6QhMXh2wStE3MXAoTAZQy3C6mGHRMdII5Sg=;
 b=qpelSQy/8rX8pKkUaO2N0sjB1P2zKamcEQeoHx6ihN36bIyRmWPjvXvFxLFiUcFDtlUbywAPVvveQsDQObwtsRqE4gQnBdqY1FH8dVaMsIfPNM+7QaoNbpT5PGL8yQa0OkdxlgV+BL3lmrqFB0KrO2xbhVcx6PDVRLcT9fA92gl3Zz0AZtvfdSbig4v/ydvb/6vuyxeX79XfZiYFko9KVI101bd0pgCGHvHi3g8OhDKYwg2V8gTQCG53IIkpdhEbe9vaQzYK4v0fu9ec6IQaoOuw8Lx/R8g85rYM09R+jAQFkR9b7zfcTY0/RVLdcix4tJgdtKGfLN/bbptLcfxf7g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB9PR10MB6378.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 18:09:03 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 18:09:03 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	hirotaka.motai@miraclelinux.com,
	dinesh.kumar@toshiba-tsip.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v6 10/14] Integrate cis-hardening into cip-core-image
Date: Fri, 25 Sep 2026 20:08:36 +0200
Message-ID: <20260925180847.622090-11-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925180847.622090-1-quirin.gylstorff@siemens.com>
References: <20260925180847.622090-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DB9PR10MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: ea9f70a6-661d-4139-3f04-08df1b3014b3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|6133799003|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	lxSKCmTRfX7o4S+W82rSWN1eMY4WIKzAr1E1hZRhOPoBDg/xrtEXV8YiOnycVBcoiaSG3EmOvARYSXdaaKw9yXC3a8aS0+M+cusTYVof25QSF5u/fOzAWdNIjvApmdVnMn7+ZKtOLtc/FGUMt0UI0Hp/zXhKFFmAzMgz1BDbjWZi0J4qpJ+DM98OJ78PcFgGvUHFe3AkxEPEqWz/r83PLs3Hsrr/1hNxQAUkoWi8eUwDfZIbtfi72qoJ6ORctLmORixwpRBg3xvKR5l4HXzPSb0oxFLN45/+N2A2+TgY7/kPmJ/cNzgrL0y04uqn2vasUynpsRw159KXp0wb4B8Er9RiD5KFYaDbqRSQ2vzhIrYc9DfK8p4aU1UZTyVlvLaW3T1vf1YD4LaxlJcSpYheMARSVNLZrFO5bNbtRDvRLC67DyAQeXyH0TN2zRynhhYIFcwPSFooXpPABcncTjDdhX9lbVMy5/f8/XMHnEyaaNBGmkP2MboGW8lPRKHWAM4kTzlLbd2oyKyxd5u0rXfm9UTsdRJ8EWfglXmM25Is5htF7CZuJJVaSlxpi5DcQjAvxaJ5XLxeQBvLnYOpNnRgdcuBOjRxQAjS+QCbbWdWeg5WYuy+leusMSi6t6ik+ThnxmK24YjfMSp6T9Ydn/wFuJ61LsikY4NBy/8eG0hXRmc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1FkuDlst0z/z/pkevDho/fUaEmtPLkx9z+yTusVrliTBBt/oFn2QruRegi9t?=
 =?us-ascii?Q?6ymlTBTKUFVY3kVASzimjNxsA8aLfVcTaLuIqK7SzClVBZjKXzsZUkIajbkW?=
 =?us-ascii?Q?R4jurgjhlTDqPcF/ssvDETl9Gj36S8LN/2y5DFvfNrpuop0jwVa4kgCpc+90?=
 =?us-ascii?Q?HLiVNQ4LHgHL4pdaIVq4BziHWCfNNRKz+rLReps+fNmF1lXtuLV+kmm1KbSO?=
 =?us-ascii?Q?kCxsPt49ef6VHQpPbjpZ9X8wb8KtjDxEBdepqdTgCOQGOhQKWRxfw7/zgUag?=
 =?us-ascii?Q?objOBF7xAmQudsmip9jO9yHhIJShGuwwE8J3UL8Cj7v0m4meiNk4gv/TF8Rb?=
 =?us-ascii?Q?Lfxx69j9EHzQWKM7TPSHMdHNZ6owY9pxEyd5JuI7gaNs/EoEQNx2Kmwy88W4?=
 =?us-ascii?Q?PgHdhZxqd7nH2bg0IvX3xA8CDsQKnsbL1HJ3tdELqjFdsZkoJQMXiS5yleAw?=
 =?us-ascii?Q?oDZzdgQFzrXf06j6+PqK46fFeFKgLrBcaUxZPutj8rosXGpFZr2L/ozy83mV?=
 =?us-ascii?Q?QpEti35JIUDJm8qUOwaerLFsXC0TVO61q8RhHXrCWlTcg0KZm9Yg/jL/Yq5c?=
 =?us-ascii?Q?L+FyMhmr4omJ5avFkZ887nncYCGGkEke2DQtjDqDMAoWpGa99eOL236ExaIt?=
 =?us-ascii?Q?duiF5Cua3/osErf8vPlNAh0DKcfQsWA3UTHr4F7c54ZT7hJJ8Dsrr/hNnzHq?=
 =?us-ascii?Q?nK9GNSe4//Ihdp+X7y+YaRGU8NXa+m6l1F2jSoK2ulrW3JouM0JIspeY+e9f?=
 =?us-ascii?Q?2iB90fh/jl/HfAmWubDCbG2ul1XrvRBTe0BzGTf2LNGRq2XIYys6dyn0TJTo?=
 =?us-ascii?Q?8xcm54EMw9DMc1hb3xxGqQrQHPdVUqP1an6UiqYLwbO0ycr2WLWU2RJC4XJg?=
 =?us-ascii?Q?MhmDMzLv89LjrCJHbQTvEc/wMBCK3XxnDL/4OQb9/Vy6q1v7hE7FuofMii74?=
 =?us-ascii?Q?QTHDKxQJ57AakxGWIq6J2AaqE1GvWkeNmI/OsPKK6vYgVrbj/wcbkHuuD70X?=
 =?us-ascii?Q?uXuRi/rQsUz73xq6bHD1QRacAwsyrL7MCECWkMogpgo0i5SJEVSBfMG7GLIu?=
 =?us-ascii?Q?uIdbNslSmsUMUhxvL4YJ6/h4MuyrcPQyVYxUPed8SG7mwTKrbSk9yJpMMmfQ?=
 =?us-ascii?Q?vYRPFx36fhZC5Z8z7S6lLRgWe7IQjeE7v/FQBBe3d9FM6J6Y5VC7evqK/oyx?=
 =?us-ascii?Q?v/v5SJtHgRHzTIMcICCeAnfHTA59ekWEVGT1PAg1PmCDtkM2xiJ35kzfWWW9?=
 =?us-ascii?Q?Cw/b1jLj0ugntfFCbtzHRr6bDu2bvQM7u7v3ndpOCgxYKiXEzhVpqCn5RJPX?=
 =?us-ascii?Q?T9s5Gsrtc7Y2TN34plJeuaQQkQSBLxvPc1XeAOsw0VkVAiCVYgN60Qkb41gQ?=
 =?us-ascii?Q?8AKoYqI+YAMu8pp4KlNQvQ0eARGCHDtYVLreIvA/pnLJ16BNr+adbxn452n2?=
 =?us-ascii?Q?c7dCxBTpyfKUQRMPtd18E+DeK2Pen0GK4AHI9XwDxwgY45EZUuSJDu96zLR6?=
 =?us-ascii?Q?Q51GzP+sbtP0a7zISv9jml6ccayAT00nGC6dYKhotBDh1IdnT+msDJQ0y3qj?=
 =?us-ascii?Q?MW1XiMbbswCA/Mi/9XLs7x1tR+HFTFni8feokaJS2mTosuIFBjdlt8SWMkR6?=
 =?us-ascii?Q?d+s4nfVuzNSfZu/bbqFz41/lN8dJ1XaOy1Larr4b0fqpy0mF21VOZ6ebuAd1?=
 =?us-ascii?Q?u++wL9Bs6PC17iWe/7C4lbdOTWWeEpmvCdJOsQrzsylZi0CNMfl9JWeuoNQX?=
 =?us-ascii?Q?AcaLHUZKBKJwLvBs5e4uuSclCpCrwNk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9f70a6-661d-4139-3f04-08df1b3014b3
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 18:09:03.3563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyRhys3QCkn1IuJhBnCu+6069s9nl/DnoZzt05uJVEzX3jHRe/q41lsvf71jXxU+iBJkJ7ciepsVpDy98qK9qqupskVvl2CS19ODNIJMEto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6378
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 18:09:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24361

If CIP_CIS_HARDENING is set, inherit the cis-hardening class, install
the hardening configuration and apply the kernel hardening to linux-cip.
If CIP_CIS_HARDENING_VALIDATION is set, additionally install the
runtime validation.

Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/images/cip-core-image.inc    | 3 +++
 recipes-kernel/linux/linux-cip-common.inc | 1 +
 2 files changed, 4 insertions(+)

diff --git a/recipes-core/images/cip-core-image.inc b/recipes-core/images/c=
ip-core-image.inc
index f6162cd7..de4c5ac6 100644
--- a/recipes-core/images/cip-core-image.inc
+++ b/recipes-core/images/cip-core-image.inc
@@ -10,7 +10,10 @@
 #
=20
 inherit image
+inherit_defer ${@'cis-hardening' if bb.utils.to_boolean(d.getVar('CIP_CIS_=
HARDENING')) else ''}
=20
 IMAGE_INSTALL:append:factory-reset =3D "factory-reset-helper"
+IMAGE_INSTALL:append =3D "${@' cip-cis-rules-config-${MACHINE}' if bb.util=
s.to_boolean(d.getVar('CIP_CIS_HARDENING')) else ''}"
+IMAGE_INSTALL:append =3D "${@' cis-validation' if bb.utils.to_boolean(d.ge=
tVar('CIP_CIS_HARDENING_VALIDATION')) else ''}"
=20
 ISAR_RELEASE_CMD =3D "git -C ${LAYERDIR_cip-core} describe --tags --dirty =
--always --match 'v[0-9].[0-9]*'"
diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/lin=
ux/linux-cip-common.inc
index 65335238..25197910 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -16,6 +16,7 @@ inherit linux-kernel
 MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
=20
 require recipes-kernel/linux/cip-kernel-config.inc
+require recipes-kernel/linux/kernel-hardening.inc
=20
 KERNEL_CONFIG_FRAGMENTS:append =3D "${@(' ' + d.getVar('RT_FRAGMENT')) if =
d.getVar('KERNEL_NAME') =3D=3D 'cip-rt' else ''}"
=20
--=20
2.55.0



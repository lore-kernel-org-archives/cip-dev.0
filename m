Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39848C9833A
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 18:09:13 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4498.1790359747804930283
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 11:09:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=NAFCAL7u;
 spf=pass (domain: siemens.com, ip: 52.101.72.22, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TE3Vs8BbOxw/jA2j6RoOAl1/WeC0GfUYTbVOdzT79pt6+5PEac0r5PFv7J6r8yMSAdOLbB0tDQqKaWiItjVdXfSHxewyukGHgFrVEgz9bUimwBfJmATkEPdWy9yZxzjGBjk58VIdcmwjZFJWrApz6CVSAC7lf2dHDs+t4aLwgTKiIbnfGZjD43q7AEE4DfJJkTWrDVPeZDN3nrqm0nAmvgxvayMuCsUwrwfSh42Sg+qi8CKDi1vJJSp8tkIdYauc3dfAoxg19yolXIGYvNZ/sWjFw4MBToIrMhvvoXT6EyHSU4qZkf0mSSXfDPW5npzBDSUE4X8SsBisFnOvEPtE3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+olIPPeuv1gGYwKHAAEq4zX+rGVxYfP9+SJ/39ejY/U=;
 b=EZ34JtJS1GTqdZ9lv1FkJunlEYO1Q7CiQAYFCvY7nvXPPhgxXRxxNk2l2pi4wzlGWjmUAEiYrO6Mvo67hw3t3rjK6QbT+PdaXXqsBF6CWfNqZoa6xfRvvl+UiJAMyZnOgIzScOzcrkqTh0lT3d173EJ6aogpgXhVJhakqlkfcCdnAMDS14KovQbEtigC2bueiZpQ73VO5CFlBTLwOeBX9je4uAc9RAGoyKft6R7ftpXyRAR79lQh50cQk1/usaWoGsrNScqbfglF7SEMcoiCFN5XGqEUD7ewUDLIElPfCGDIHR0V0sTJss8Y+uDFTZWAGt0nC0z5nOn4WpBOzhdL2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+olIPPeuv1gGYwKHAAEq4zX+rGVxYfP9+SJ/39ejY/U=;
 b=NAFCAL7upzUotBQAmo/hi9J8zfM/rahED7Mc4QxE16wAYcSE9GusG4tNzyN4xDnVBWEPjjujdJsMQvGjIY0m1ifm6KU2FxdM2qKq9qwCfAuCXivXp6pn87YFZIwGHGo5xsU3FBabFSBkyu/7ElKR+EJgj2ElMYQN2ET0FZEF9IjxSFPEQ7Ksi/+AON1YFQyzXaVRnUGSHQTTL3bMYhsRv6XRHnxH7Hm9fQ+Q4ofRVH3BBZJB5Bm/By6uz2asFrqClhAm+009zXzObgrDFiMMWB0gFDw2+WLAWVBKfXi8vGHW2PC7BN18ItGjzbUjdqf968A2O5U+yo6kUrIetxhOaA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB9PR10MB6378.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 18:09:04 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 18:09:04 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	hirotaka.motai@miraclelinux.com,
	dinesh.kumar@toshiba-tsip.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v6 11/14] Integrate kernel validation into linux-cip
Date: Fri, 25 Sep 2026 20:08:37 +0200
Message-ID: <20260925180847.622090-12-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 28ab38e9-17f0-4d88-c961-08df1b30154d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	rwrz+rBwOWUELZI0gg7eI37prV2cUh4SvPTaiD5GlrvnLCq49qYk5oMdZYv6vD/FnqOhhxHjoBx32HhOryaVAgsP+t1bsoyeUT+GTG8SD8GQsg2Q9IStApxP45p3RiBLrCfiQyVFCCSlDQiTsR37HlXueQKCv5X/yNK2ZjLgKm7QS364qNQ64E7NWg2gcVM7HOpH+EYUGJBebH//RsR7mVEooGEyXFsHo3Zdu0WLkhq0RbwmYMdDDp9LpUdHdudLgADSd1e3mY3rUGeosu6x/F7Sq9lmB6ObZ2WklyuKFtaUvu61DZQbLbr0AKnkIf2uJY90FfYmalgILA1u2u110psMKB0zYBvRB7uXPgTwxKpg2ErJHtsJcF4XXujGJkpVI38kkqYgTEublJm1GTnrXLS7UeJycpofoK4w9QFZMbsFm7YpmV8vH0zKniwZD222IxacLjfTCdQ9NY3YyM4+qYyCjiF3+U8vWCCEyKPHiMYXNhalwCdakuIt1oN5BKjlN58jxdsiLRcoF4lAu7+Uj+0Qlj+U2DWvGm9dNBwgUjUcTfDztVwXKUVa2yNhrCeytUoXjvLDssO72qrPE4oavJLANxhuj3/pi8zUskSpi3BnpGPPJA7ZuX0FJm5HXZM2rej6jWq3ClcrV7abN0wkLT3ZSTlS1vjDxPFJIJoxutY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mPjtb29Dk8ItuqxlvpAHTwvJ6zcRrLc2Xw1wD2VXiFwBsj/kOiZNOyoq12Lr?=
 =?us-ascii?Q?1WgRBDgsQEKh4kszFhb1qVJZXqmtyItLVhrRlk2t/w191iuGQGJA3ZN/712U?=
 =?us-ascii?Q?+W2HxOPrQFvOxucuFezjBeCwyuARC1C0C30sxkBnKkX7yS7aDYnKetxSiRKH?=
 =?us-ascii?Q?y/6Yfcum3ha9umSQlam2mMsKqKEf4IB/xbMA+A2w/txrSw6tCsEyWH//LBiv?=
 =?us-ascii?Q?OiYRbLI7ofFoqWuLkOAO/qYu8pcFu5/NCxk+/ddj6Cv88RIHDiuc046UYlKQ?=
 =?us-ascii?Q?kasDjPwFY+LSytUcvCXjYOZh8uNrWEl9mmoIe7zHpX4ah8R+Q3/90SAX07fD?=
 =?us-ascii?Q?turcFTTTWFj158qv69hHoboxVuvMy+IMK42a1ihs4rzw3WHJPZ4uqvJ7s08u?=
 =?us-ascii?Q?UtWYt0sSXJLE+bs6PZlZ8kW2dBgQ6PxdVktbsF55Hehb0sBUMoF4/i2mAZwg?=
 =?us-ascii?Q?bN6O7mLuU2ORPtQaHYHt1j/M/VZmLRmPTRjwJLzmKm3RLprWSnUsmmHctIQm?=
 =?us-ascii?Q?wn5lhKTMsmvGUOi69aLFYE61qVk3QbIoWYaQIwuF5F0ZwPVSIeGwch6r0llJ?=
 =?us-ascii?Q?Nuil6KltHDnpAjIfyDp3jrSCModj7lm7fa/ZzNyeAtvogcKeDKJtvS72keik?=
 =?us-ascii?Q?0rWC5kQcT8z0+wrRx5/0DNSIcud4HvaWZZj6jc1Pyk6peCG/BvJ8fmO+BtpD?=
 =?us-ascii?Q?Lj1JPNf25YZgGzumAypTST0/wHTMkVH7FS6A3eT6cmKKNNHNHNPtoX970t6/?=
 =?us-ascii?Q?7H/8GXl3+77LoTOIkXb/4+ZOLgMOKNc9Ik54IzQVWQwgggI4uZHjWd3gK1sO?=
 =?us-ascii?Q?k7hnqF80j+zfMdGvKelAgXYBOiVQjYzjeB/thDZqCIslFLOaH1Ec89Iae3SO?=
 =?us-ascii?Q?jT2rt6KmWCLojS3C/KYZ8n96dO+b6cQE66hbVOSczK7UhyMn20841X4rl/IC?=
 =?us-ascii?Q?ZvwG933+5pbDoxvytXQQrxj0AfBxu/1B+pFnrxaaEY/YlSUkS6QGgtPWrBHt?=
 =?us-ascii?Q?3yQiqm3vmeQO/4imXXXUtkuB89LaQcuvVHb9UBCW6FHxhBne+CuOQ1lTorL0?=
 =?us-ascii?Q?k+XKgWTmnIMNlTXAYYgITB2CwAYYz8m9PYQ2LtxPYPqPvptrarAiqe/l99zd?=
 =?us-ascii?Q?bemtU4kEWYuRpYe/shBAOxsjaQK+Fl9oF3HhMzN/S7P2a5QJbRtKREYvnOMd?=
 =?us-ascii?Q?yBVAvpHvImwb11Jf8/a5ZIBBR7E66s/xSYcctg/k0Wvd+GF+1xV0AAhRXi3H?=
 =?us-ascii?Q?ps+6DryGWjmBS4ANKLbWeSuN4OqRUtvjKLWUBnqp6fxLPqExVXLRObOHz2+3?=
 =?us-ascii?Q?rbSONLxS14belk/XuS4gk/UOuMS6N044TVZAHNoaLstbtgwfwFhoO3z68cF4?=
 =?us-ascii?Q?UNYiwJFxLT3Zfb8hzWnHJafqiALDkb3jikxBg25Cf0y4D/QDItAvorr+oiTd?=
 =?us-ascii?Q?5Dq0xh+iTnkOyblgCTjo7mjjX/C5SowUX/CkMojaMt+dWTBQAWfWGLasvKwJ?=
 =?us-ascii?Q?sKJtG9jnqQ4d0pJowB89cxCUvYsr2XxCLJtWkjX4Lt/fFjm4ddUzeIuFw/BE?=
 =?us-ascii?Q?UNqGnW/aAE4vVod9ypPs+rKcd2Gdek7bS326zYEVa06q3VpQ7iA8nDRBoV8I?=
 =?us-ascii?Q?Zk7sPW6xSGOmDz61A183OXNguv2qxm8A+cyoey3EjMY2w+1jA+O82NMT/H/e?=
 =?us-ascii?Q?NOEDPvSEm7bjZ3JfPFNCz42/4hyVRwAtaOB0N0o5ximUze0nyJ6OecwunJ/I?=
 =?us-ascii?Q?UDvRo8TLUhxlZ6/nfiTuNcWNTdDYu4Y=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ab38e9-17f0-4d88-c961-08df1b30154d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 18:09:04.1900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdsWObkzvE9f7/QiJp08q2+6Q/h+bgUuHUgbo6nvQd74AMrhtGTfzAKPXSnYhj4pJWQoXz+RGWJFkn7lA1N0fBjpSOB+vg7+dG903sDreRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6378
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 18:09:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24363

Inherit cis-kernel-hardening-validation for kernels built from this
layer if both CIP_CIS_HARDENING and CIP_CIS_HARDENING_VALIDATION are
set.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/kernel-hardening.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-kernel/linux/kernel-hardening.inc b/recipes-kernel/lin=
ux/kernel-hardening.inc
index 9ad8f080..027598a2 100644
--- a/recipes-kernel/linux/kernel-hardening.inc
+++ b/recipes-kernel/linux/kernel-hardening.inc
@@ -14,3 +14,5 @@ do_dpkg_source[depends] +=3D "${@'cip-cis-rules-config:do=
_deploy_hardening' if bb.
 do_dpkg_source:prepend:kernel-hardening() {
     cp ${DEPLOY_DIR_IMAGE}/${CIP_CIS_HARDENING_KCONFIG} ${WORKDIR}/hardeni=
ng.kernel.cfg
 }
+
+inherit_defer ${@'cis-kernel-hardening-validation' if bb.utils.to_boolean(=
d.getVar('CIP_CIS_HARDENING')) and bb.utils.to_boolean(d.getVar('CIP_CIS_HA=
RDENING_VALIDATION')) else ''}
--=20
2.55.0



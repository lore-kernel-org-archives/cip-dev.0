Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9044EC98319
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 08:12:51 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.37])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2975.1790237567831070922
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 01:12:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=otSO3YAG;
 spf=pass (domain: siemens.com, ip: 52.101.65.37, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5nWEjoaSPDTCXSlzO9HQULKBx+zug9+u2HgGnthHENVGHZctmiBBP1g+PUxTKHONPhZuwYllLYhe2LJy4MwL10vTaPbwTv8hjU75Z4zcapZhNR/XBU4Rw4vrLaLdAOUuuc0v1FmUsNrZSxW/bzFAqJUL3owSdRd8yBZ2WWfHhLl9hZ/zsvgzqgcd93wv0hfzDEcQsEzxgkGaIL5E7ast7Ppx1/gB8y9TPPGPr2WdY2sT08AvXY/pnnDrw0xLD4P3BP3Qt2fL6vszT9bhvAZGt4s/kDPWtZX4cbJCMNcDN3OvLmbSsnsT9Y59mkMihEO6OHNLepVXiwWuALkpH4xeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeMZWOZR6QhMXh2wStE3MXAoTAZQy3C6mGHRMdII5Sg=;
 b=SaCyX4JcOh4x9ly5ePeVBcx94LZC6fWlFCzN0XrVB9SLOnQZVwTK03rn8AgpzQIPtUqea+zFO6rmYEGv+LQ8c85Ucdf3YdhtAiDPi2Mo6GtYa3CcXB9TQHjYI0Wf5DkdIZcl7wNhK0Q/KHDJEmnY7pM5BUT5dA5HLDJsetDw8KKzd7KunzNotfiShoZkYmnX8XRweeumvNjO7v4YZdFvjpWmAwb+ObUweR+cYmWxq/4loQiWk+ZLwszH2JctDkZUnD6sSl5Zpwi5iSxIlJF5139XjYKPX8t+5sgm1fjZuYGDwGapLWb9PYhapGsi6KCvn1rdPph7WCItZhZeRieRBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeMZWOZR6QhMXh2wStE3MXAoTAZQy3C6mGHRMdII5Sg=;
 b=otSO3YAGPshxYVxXkqNUJZQgdQAVYnYCH5ir7nBbd9CUbxMUGaSWi8BkwDqVmaOlZMoO90lot+dLjgxjctD60T+UranjTrRnx8DYjZO/xfrwoCzVybrRPF/4Q1ONzEmzcmW3YpKzwCDC2JDRtpZY3laPzviSbDcqcEZ1XikP27rWVfVUoEHoxH6JQ1EQ+1ZFN1yZoMrTQNMjYexP+DMBf3fgwOCtYmZv1jW9kzZRSlyS9AFL6X/ACQ3/R+CRJm6Ckaco4nPwNMGcu4buyTqWcK6YCX3d5C2qtWnB1pDifRLwrAiiyqV38ceYK02GOZZYK6eGmXO+wRl+XtjA06y+cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by AS5PR10MB8055.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:650::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 08:12:44 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 08:12:44 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 11/14] Integrate cis-hardening into cip-core-image
Date: Thu, 24 Sep 2026 10:12:20 +0200
Message-ID: <20260924081226.2844456-12-quirin.gylstorff@siemens.com>
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
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|AS5PR10MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: dd74f4d0-266f-4799-f065-08df1a139bca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|6133799003|11063799006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	xxQXXMQPILuzGZqp/cKPSnXmB3eVZUM8mmN7QagB8bcRJjZPMKUydHQsnMvaZ7oRWdiL17V461X5DVj/DGV/PNCFDtDg8PnQi7kjJf/0qGj8Qlu9mwgne0iz+cp+D4+ilaOav24EOxMVqKsf08+USf7hePJHuYDldVbXzxG5BrUHyeu4SAAiuOxI4vgy11xa1ZPBTyZ0yHqr6eBY4y+UBUIpMcKV/T8mrAzzGscrXDgUXBKzOGwXW3+0N8QijXVxzOoq4/S+Ksdxr39VcILaFcuZ5GYnYuXv7TCEoiNZ3+GPz+9Mg9tCFQBKfQrSQvJtwT+TIhVYh396BbsGv+kAG6NYkjmMQdurnyqDIE8b+yRrI9ApzLPOyZ5yzw1YBW04itsUNBrtGDWR6nDT07sTJL+a7fith6a6QtXR2JLacNQMS6OtHV06DWyOPoTff51WYOMpUl+G8owYSl0wsgJrHipg5FzTjsf3fb8RdlWf6TfnzqxWJ4EswqSI5+ru37xeW/dRO1iQ58hs/bqJBmca1dcfLi6+Ugu+dEZUFxli/J1c51lMzz8GCWBJMjbK65ey3Yip408vEhyEKHh/xWkkEaZu3Tuug0CWtzNMiS9ZXTAsCN8rOOJjhJOXscd5U9HoLzFEzMhiTbChDOsK8fGOc+KRy38uzvjyEOpBdzR3BU8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fofSBgVOMhAqCDfHxSKpAAEAE0y36WrIhpCVUYMAlKzvUT+LPJ9spxdnrsL8?=
 =?us-ascii?Q?pmTqJ6u8Md11Gh5yJgXx2euh1YMRmMh2s32wN/eoP1l+ge4gquZxI7pOXhvj?=
 =?us-ascii?Q?BgrstHTIfZI0N8gKy2GqAAI+QRnb9aaV8iZIxAUuWz6ANZwSs30WaPH5GQk1?=
 =?us-ascii?Q?V2cRBJbfryii5z+WoQpJWlfzJ81ljnGROefKRCfIk9XpSyE18GkXo/0BWsed?=
 =?us-ascii?Q?wU1LW5WvCoO3hYGrr/AvvSwXD9RMFw0vhw36YLSOjpnCx7gzHGC2d0LHjYrA?=
 =?us-ascii?Q?CHndhzZhrmn/zrm+0gKKfLcBtOHvgp1wLdinv4HyuQju0uHR6V2u9reOHOuE?=
 =?us-ascii?Q?hQDuE9san/Skce2HgeDI7BfgwuU1xuSo2l0Rsnv+3kUfC028hw4XuvXsLRCb?=
 =?us-ascii?Q?63mI5JBL0UpYJcnH3HJzlETTrLPUYM0hjup6UpP6F9JFUf+UzurJ+or3TBIZ?=
 =?us-ascii?Q?fYl4154pCJdlhtV+si9vMHWh4M50x4JMBC9GDuCQWIe9RrXmFi7qnIm2HzcP?=
 =?us-ascii?Q?0ZJCe7gK1tLk+lNMRHzbqNL3Y+9FyyIsIa6B5pqee331mWEaZe0C/tsyGeHu?=
 =?us-ascii?Q?7TBWXQT8ZhKtVxQoRa2AD6TMzv4pYFajUTOjvAOBk9TNQ4OTKBYB2IdrcGlB?=
 =?us-ascii?Q?ZDL2hUmBgA3QLTCQhUgzNzjcsJcwnAHVKRYw76qawKs0oIDCRwP6L6l5vYti?=
 =?us-ascii?Q?pzN04EDod6QJqGKY9HniuyDcV5zla400j/qfQ+HX+3fZD5HR+CDDCWNPx7EH?=
 =?us-ascii?Q?Tm6B1a1v0a/xd+51FfFsPYxvl2vQGlOIOfVBny7QNZO59uY+5bOzFp5KDk9b?=
 =?us-ascii?Q?cRKK5ZoPWphkp0L0SzsDScEyW8RfvhKMypuEnrgu3Z7McbqSpfu8pqfMOYiz?=
 =?us-ascii?Q?5n6h7vsCGYfY9ELf1GwlQCD2whXJc9qDfV2px2CUY9TATHPB7og8sZ5qcjq8?=
 =?us-ascii?Q?K2BVBlKNbvKa8b8okhYwZzp98a7DLdKgRL+QxBGG+gDsffG8FDjzWRA84YmQ?=
 =?us-ascii?Q?eYUEw4lVCBIaoqsCARD/mnu23CvZlLwFmi64eoyVTRTHVYUnsp6jgY8rc2Dk?=
 =?us-ascii?Q?zeyeiYyckeCxFcdlxam5YhLeWONk6J1UUdVBfeBCuIrmr+mnwNdeqcZdfxz4?=
 =?us-ascii?Q?rF712Dg5+uIfJiIP22ibk3NFEfEQLTZ5JbpE8vmnj0pbnOm+Erf8CQgMvguF?=
 =?us-ascii?Q?QNCBJSknCNaEj6JwgkOG7/n+v2I4W/VwNVcZB7a8mMyu+zS9kO9NS5vhRqFK?=
 =?us-ascii?Q?WBCem68bQO5ClpTowBmDnh8HySt90eqpvhVFKhUb6L0jjQgrzMAt+CBlMygU?=
 =?us-ascii?Q?EX2CIOaxYNjqymHvihB5SypUpNiQddVDx1AupIwacaOdIlLWFkJWyYiTQPZc?=
 =?us-ascii?Q?bn3TORXkhizR1w3wDVWnYdxNjgjgS+MRNq6i4N6/ct5RQDXyFbZwZqs3S0NY?=
 =?us-ascii?Q?JRv/LDHGxWrGc7e5RIwailGpVhQwGo8vGk+mLr5Mi1sIce8Q7uR8sI/UI3e/?=
 =?us-ascii?Q?VfdJ9yy7WJ8CdmwCz0PjgkoObCRPYVwkIW2K9rvAottROR7E6tnivFkarObg?=
 =?us-ascii?Q?czcwNvBEHxDTmhaRyftFnbtZFtmrFDX13n8u0deVg27TGSdplb/6mDK93V9Y?=
 =?us-ascii?Q?hbp0bhWdrWksbanvMHHD5oT3uBiMBM2bchVWxuIihV4wCOnAt6vLoIoPe0kf?=
 =?us-ascii?Q?LQCvj+fWDa/+VYbpX42zHzi/6JtOLr721AjP0aTB3kGYe/ZKRPJfbIN7Rvlh?=
 =?us-ascii?Q?qu401hhB0f/GjvaCkVgx2LrJ0LE+Fmc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd74f4d0-266f-4799-f065-08df1a139bca
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:12:43.2569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkqn0iQaWKKPOtYL0Zx+q5MpHIlKPYzyCMpZ03AUITqf8zoMWiz3f8c6I3dJsDJllOnMFT5YKNoNidR4QSz/Q3GhvI17cOzjAtiDlp7k2Jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8055
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 08:12:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24296

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



Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B972C88E64
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 08:03:28 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.33])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15352.1789373006517069034
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Sep 2026 01:03:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=WlPtQh5U;
 spf=pass (domain: siemens.com, ip: 40.107.159.33, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q58dLFsg4K1FFCpg3AzcMfichGvTEiBE7vwtl5B+OqzzeYYv9xWBPoiW2QPk26+6kxY6dZByBYRsvYgD/kB3B9Jw+hKMlqJc6ebYXl5MePl5vPilFQ3uKFylkd67xuNYE7ioUORITq/KLGAUaMcMaOl152b569BMV58BjybS4iVAoZSIPqAT/EScRRFifCXbySQdPLe23wQkETELcg/kPL5FiuZgGslBscpaFsL/gbVjvIgAkG0Uihiyf7628bWXmX+FU801lmbNTP4Jbkqzs+G/iejIiLcoS1/GpRWs/C06rtqsbrquefoUc0nhGuo/VkbCqle4JITHvCJvO98Sjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXiWWovUrLgWeVCeemT1abMpVfZN+oaZfbdjHrRgNOA=;
 b=qeZ+RkeLKVeEwV16Hcv/zW8eUILzyNlabNvzFaMVdouhKnQCvmZvuUHS3xWOeLdRlY9AIznHr0xvbqJu4vev+LFnDzugJ+3HuE2gAmVWNaQI1Q9wgRvv8GBU6HNSr6tGlhNepMhSNGcE2rA/FIG6KbkVRLn0gsu9VJPhPSJDOcH5GmFP7l/4G/x1z8s+u7mMD396JjnbE1YbyZW3fKIRSVBtu0LEqEyfPGVLp1zzfqkBe/g06QKOXwgztG6s1xKm+Y48MD7VQxMOHZ3yUnjCfWJnbPzRfaAVffAm7kP2eaY31G7oLtkPKn3JXjFe1jE96KkMmHiTiwO36Yrk2gNhLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXiWWovUrLgWeVCeemT1abMpVfZN+oaZfbdjHrRgNOA=;
 b=WlPtQh5UEVgYgwAxPHAGfFDZuCS6e2gGfH0C++wR4aa8UVfWf2VhfhdZkOjEDrurVE3e8lpqoJdGLRbGalYx7kg56/JGKZglsnpSoMAeHvjM7IA8Nd7JQqNeCNv3BI0aSTbD+vwrsE5tZOAlZp5vAzQIYeyBHJeAmT71HZEWMzXSENc7mBrcfJLXMMAnL2yJRCUSWEw4zjlTDSIR6i2iWJm6ZDim2NC59YcqUzGBLq2vfJIIKmd/NQL/sxpXr1IHGu7AWrNph6+U0RzRsU3QLVZIMzjtS4iGQ4YvbwP2uQxPbOmh+pu8wGrlw5sJNqHzfKGhF/vToeeIa4fobtfl9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6641.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 08:03:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 08:03:21 +0000
Message-ID: <7c5a1901-7536-435c-aecb-bfdf3a8a9d6f@siemens.com>
Date: Mon, 14 Sep 2026 10:03:18 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Add SECURITY.md
Content-Language: en-US
CC: Hirotaka Motai <hirotaka.motai@miraclelinux.com>,
 Dinesh Kumar <kumar.dinesh.h95@mail.toshiba>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 28db354b-8ec1-4469-4c3f-08df1236a49c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|55112099003|18002099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	jOvqO+5OaJyoS8Vp4ygk5WlO6YDriq0dXjbDn4K/DgMxvpCr/tpcurMZOk1oGaknd3fk3gYyNAK3pAyyrd5HxnEUdeVTqGtUUz1lx9ImIxwZlQTOGRw/TgC8/6QSt6OSjOefaw++mpxhKGgS5pJyynA24FZH2TBmeulWxZ5Tkr0uucFNCja43K9vgEh/eVBr41J67Ep4Npnr3W5WHpLgfEfgvtLCCtJ7IW1PfqnxMtC9qcH6PL4I/X8LQL1CRvkyIt3euPx0ygVvz9uwlizS6VKsmIn/VfrYrZ3JUIM2JEUwuMp1qlc4xRQpGzCoJoaxSHEb65GDxC1n8XJg2Rxu2ZJqcIEtijVr+wdSbQwEW6+MBi6hpNPSqj/+PMZ/N6iyzlqMIexV9B/m2jSPaS3pvfBATK6kZqfPe4oRDTMhK+8ZtxIr1ba6I0heHCyr9V286YR66rUH15uy0yLGF+EEwQmJ0A5agHz8giL9TKoNDHvR/sCJBTXKZZp8AKuOhtj3APi8lWsWCP+esflK72+6ivhUXHYx7/8oYvqheQ4DNElNL1b6wNMZjZ3iwYQ2+N9u6iD5e3RJHqZddCZhojEGfjk0BNduZZ48G70ngxDFE/MbW/K2AdotsbVtnbWvMA/zqI0FQkZEtIqGzkKVwshPi0iSo31W/3gj5WaFmHWdP2A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(55112099003)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?u7mJJ42uBBUADQQvzJljKb8unCEPQMANKQWh9fMqGWz2rHQ/z54mypvRfENo?=
 =?us-ascii?Q?X/Nf5z19y5ZdW3+YDOKPCi3U9TqjFk39B/fYU1RRTh/lvztIsXVAgU3drpSf?=
 =?us-ascii?Q?N1XehQDSCzrfrcmeEBIy5/iLKbCAvcNEh1pLYaVRD6gzbsX7Zd4XU7R+NwiV?=
 =?us-ascii?Q?w37R4r9R1U6XdxtWJi3IXuL2rBiSRVbJlMRc/v29xfChwKyaps/NL/SeUBwW?=
 =?us-ascii?Q?aO4jUyuHzvPezGn1aK4P5nuUBrFU/3HkashYMuympW1NfuPVbVY57Y8PFP1t?=
 =?us-ascii?Q?DKYCeTmho27T424tjEajI2ezcOSEnXKEQAdbeY2y0K4ts9gIAtEJIRQTpuVs?=
 =?us-ascii?Q?pb5DMFgOTsw9nEzD++2CnmzwAyxgARig4FpO1KhVYAXi9a+NZjC9RwU/35uM?=
 =?us-ascii?Q?SlAGeyS1aPNawVWQ1X/53D2EWxpabBrSm10R7g2Fp8lXmQ07PMOR1L0NObYd?=
 =?us-ascii?Q?6kahbmrg+3aw/5vvfCxqARUfTmTHr4kWaGDyQfTqEUm2Lc/kVuRt64wdSPNt?=
 =?us-ascii?Q?B5lp8kXtxjRZapL3ndZWuW63h/3G8bQ1gKKBO9mrzjQa4VzAytycISMn/pE3?=
 =?us-ascii?Q?NBBuOQchQkxq4BDZ1YwUhBbDX4QTqx9aFN2NOKBAPWSu20ZSqY1aI0YDDYmj?=
 =?us-ascii?Q?dlac1HLK/8BBdvsoxixyX/ECXhpLKXecgezz0vghbQUTtRQbixYD+/HmPM6Z?=
 =?us-ascii?Q?K3Kqius4gjXbWdAqNSyH7WAhsemAypsjzVXBUaMaSQdGJ+gNIOv15T84PUAk?=
 =?us-ascii?Q?hAf7PDe3GvNdKIVnhM5RKfr0f97+s8yuojk4XpE8r/7DBRyYsPODCE28mDyQ?=
 =?us-ascii?Q?DShdMqGvNM6jMpR69EdtgqzgWTnq0K8zULBwemxPmG3xD4KFdVyMA9iTZvoc?=
 =?us-ascii?Q?xWdm3THFq6oGDfF1ZFitCb5be0nney0RPQYb3lRiwOzOgJfAj8Ev9E6xut8+?=
 =?us-ascii?Q?gV6KjPbqQXK0yZZ1Xt2JyXwttAEudQc5XCdEE4w7ditca8N4Ck1s1pR4V/zD?=
 =?us-ascii?Q?cKZQK3vtC8n18JieSiTTt97tFARdics0Giy8OX8hCKYKfcuLi90+YLLG+Oqt?=
 =?us-ascii?Q?zmAR87e7UxSoRTYxT4t6SEzA9ZyWj3Jbn/6/c9QDIcAvEj07agTK4lRgrsM8?=
 =?us-ascii?Q?nHH9WF2KKh37mI8RK/Y8qB8spAe29fDXjWxwf3pBlRCaIRug2+D4ynOVuZQv?=
 =?us-ascii?Q?THdz/YA+qE0c6y7g29mAynFXY7d58i4KjCx+ZZ1EV6Qoixsw0ZoByRbr9YOx?=
 =?us-ascii?Q?D9k4pW6t0nrcQ61/5vR0Aj6/yjS5aPgOnJ3+3PuO5MSAgSepw0kDEB2Nv/uM?=
 =?us-ascii?Q?i9Rh7SoZIkwQVUj6SAy56MGahltlhHc+PstwyWKfa9l9PccIBwgHGsF+dA0G?=
 =?us-ascii?Q?kyvjkPlkNLfIFfSeqL4xZL18OJRJo+o4339X6GeHoAKlk5Ub7mnIeY7To2Rj?=
 =?us-ascii?Q?UKDmqhQ2FB4NepCiQhPc7VXu5tyHrgj57k7i95+BhaUNtV4PMwgS3d7I0zKa?=
 =?us-ascii?Q?8ts37rPiW77CWW1gRULQLzEwt2z/VtoG9I1hRHmWXHrLFPlXe1AQlaLETJOP?=
 =?us-ascii?Q?b21UjhIXfS9joiLROoqRYZmloWzlD08SFpxn2iETV7o/bKNwVqmBOqgbPPIH?=
 =?us-ascii?Q?1OF6ofGHaVYIY8Rty3cAvHcj2YvY8wC5tIU8nlgSRnhrI8hMzWUgzKaLytAt?=
 =?us-ascii?Q?evFSxMnAlJl1AeXkxbQk5IUSzCZ6BCJqWdNLk5YeZYfhyiHY0aaK1rV5D5PU?=
 =?us-ascii?Q?dnkHt0Ktpg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28db354b-8ec1-4469-4c3f-08df1236a49c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:03:21.0906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkJFXYeKlD+KRV+xSyLatt/SSdycn9ZzNUF5wvONo1zuFlbbkDXMySPO9PqNKiW6vPL32nYnEIlkbjKR4uyY/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6641
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Sep 2026 08:03:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24170

From: Jan Kiszka <jan.kiszka@siemens.com>

This documents that isar-cip-core falls under the LF CRA stewardship
framework, describes what we consider in scope for vulnerability reports
and defines the reporting channel via the CIP security mailing list.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

We will need something for the kernel as well, and also for other CIP=20
components. This is just a start and, if it makes sense for all, can act=20
as a template.

 SECURITY.md | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 SECURITY.md

diff --git a/SECURITY.md b/SECURITY.md
new file mode 100644
index 00000000..664a303f
--- /dev/null
+++ b/SECURITY.md
@@ -0,0 +1,37 @@
+# Security Policy
+
+This project is supported under the Linux Foundation CRA stewardship frame=
work,
+as described at https://www.linuxfoundation.org/security. Security
+vulnerabilities should be reported through the mechanisms described below,
+which we will coordinate with our CRA steward. For actively exploited
+vulnerabilities and severe incidents that may require CRA escalation, plea=
se
+use the project=E2=80=99s emergency security reporting mechanisms as appro=
priate.
+
+## Security Context
+
+Open source software can be used in various contexts that may go far beyon=
d
+what it was originally designed and also secured for. Therefore, we descri=
be
+here how isar-cip-core is expected to be used in security-sensitive scenar=
ios.
+
+This project provides building blocks and reference configurations to crea=
te
+secured systems that support secure updates. Demonstration images that can=
 be
+created from it may use publicly known keys or contain debugging features =
not
+intended for production use. It is the responsibility of the final integra=
tor
+of this project to use appropriate keys and harden the system integration.=
 This
+includes the choice of secured Debian package versions.
+
+In scope for vulnerability reports against this project are flaws in new o=
r
+customized packages provided here which contribute to the security of a fi=
nal
+system. Furthermore in scope are noteworthy documentation deficits regardi=
ng
+how to achieve secure usage of these packages.
+
+## Reporting a Vulnerability
+
+Please DO NOT report any potential security vulnerability via a public cha=
nnel
+(mailing list, gitlab issue etc.). Instead, contact the CIP security team =
via
+security@cip-project.org via email. Please provide a detailed description =
of
+the issue, the steps to reproduce it, the affected versions and, if alread=
y
+available, a proposal for a fix. You should receive a response within 5 wo=
rking
+days. If the issue is confirmed as a vulnerability by us, we will request =
a
+CVE, publish the fix and give credits for your report if desired. This pro=
ject
+follows a 90 day disclosure timeline.
--=20
2.47.3


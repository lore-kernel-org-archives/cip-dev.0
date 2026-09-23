Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951B9C9830B
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 19:51:54 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.26])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3943.1790193104125571409
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Sep 2026 12:51:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wb3PxbSN;
 spf=pass (domain: siemens.com, ip: 40.107.162.26, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KElCseUFBy4FqU/JfsxiI6Xvo+dgSEkJpHdAGyyB539Axe8JNWHebTxiifC4RSgX6YrW0vMiBqta7Mwe57YtBPoXuIb5KSbjaEkVi5MKZ8Mek9uF3iCF2Mdwa3uD1/T7o34JXSy49DFJzeJvQxbU6r9Tu9sbor8GJF+xFIpESZ7z4ZFVi9dtiHMVixgJ6TSfAvH3Tz0fEbX9YwHAzI9cj4nLtxGf1aUrAhIHod8pDkfkSdlMIKz/73MVV99hUi6XdZ1zl52JO3y2yLOKEGqYRg/GMymFMlxso3+iY1x3JsT+xizVEU2P9w+fOdwZ3WdrIzENe+8Pmcl+3w4prGD+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lx1s6ixOnS5KrNEix7/zz6xiVQv5FcJmuls9bbIbkfY=;
 b=vEOxmLZlh8geudyaGph2bLk1H7RJ2g7ZHe/pAD8xFid1OfYe1zpeLO1pAJUg9Jr8LkpmbKJ6cmYNkT5r4lINp6z4fj+bKLKI1NMfG25VTwq61T1xoxle2KEPucLjQdKWsCqhm8i5mos9muL/k8WGbuGyXSwRbkID2RceUEVq/euxPjF7GMXlHpltbaVbbqOpBDDjfmQ2HwRIw1sCNH8Qa7eUOvjF6vmgUHHbQt284j1OSC/0C3hlaA13oOH3lBjM+oZhhIR6f7plw0E1MH/YrGDecWnJJA+7+k3MMRet13rrg0GDQgF5aSnLqyhfR1Ig36atdV2oymW186KMN9Yn2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx1s6ixOnS5KrNEix7/zz6xiVQv5FcJmuls9bbIbkfY=;
 b=wb3PxbSNqoVw1GinjNNmRurZSeF20+9CJXB38lUbEIJzVPAaEeifixJRtN3q3JA4Bxwu1Fgidh/I4ihCG3G/OU7ColVsSye7bdz+0xzML7x2y1UhdIjoDpPm7Cdq8nKDF+SLBqXRngI2Dhs7z31ZaG31ORWb/gL8D5ZdOlBVpQqq48vo25kPI4K4JgejdkG1lUYyWrBwkAwe4+IdqaqTgODMfr32nvP/u05GflRkQ/cDpUw8CXPk6NOVXwmMrcWCM8Fq43ibLSqZ/IGvbJmezGySfoKCYmC5iPRm1tsbrSXC7/8oU4agqX6x4Rt2CUMiSCvHJcIKFclvrwDTk7Si6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3624.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 19:51:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 19:51:40 +0000
Message-ID: <2fc086fd-ef95-4144-93a2-89814d58bdfa@siemens.com>
Date: Wed, 23 Sep 2026 21:51:39 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] initramfs-crypt-hook: Add forky support
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3624:EE_
X-MS-Office365-Filtering-Correlation-Id: b3928c96-3ed7-4ec1-57c0-08df19ac15cf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|6133799003|10067099003|11063799006|56012099006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	MuB/yS0EEHDmKCeW6l8ZzNDLwBYK/uLroBZ81/FT8Cdvqg+yEa1joCIGctpCbecdLVF+0CVIgimg5dF0nAlMSUYhV5TxSPGT+Bquj91RCTkzbUm+F5ovd9UXnFMefY3fqW29g4K+0XCLPmQhXXIqBn9T4/cq77eUu+dJTU3vx3kqvNFLdOnMUHgPXhTZHh5CiVPk9nK3nTp+kNws0gT0cEHATrqNc3QnN/Zkt3Cg6rfqEFlQfZzNx9m7BfQTr8fdHRZ98wMfxgECG3GmhGdBmchvm+hBF9DYBeOV9v6J/p88oOvj/wTxJp55FGbpNyazaLZZuexugftFkbU7qpNBgCsnAgQ3dI70DUpL/tAiFrces4NXhJoHzmuQyTRD6PF/2yE+CwWt/H53o1pDEEynncQsI43QcirKTsgqILbs6WSjiy7/j1JX5eqfg8xwjbDSeUWrZhgpqBYfJIsyqRkuEbKaYpKLEp5cblfyhtlXeT9VgLGuEZbzRpxmZhI+31GafUs1HpG7IrW7FONwCjXOFhXZ9UhLpjT0TcIN7J447jf+OVfWvQaL20oFGYPK8MEAcCNZEV4HP6xF0mHZbMCeG0mw5xiS4stAlDv5ELND6CPiwG+EvaJO5K4Hj5+CeJiRxW0zO+2yPxtENTa4IutgB2BNTAMALOjpwas77wCIpeE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(10067099003)(11063799006)(56012099006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?em5iS0hDLythZzJOYjljYkRncFlxd0dkZkpvMDQ0dk4vclhnb0pVRURIcDBT?=
 =?utf-8?B?OTNxeDB6VHdlQk1xMTZkV09DSkx0ZGJFays5VzIxdFJWbzU5ZmdkblBkNXJq?=
 =?utf-8?B?SDFWL0xrTkVNVzdycFhOUzNQc0RLN0E1aWxNS1NZS2J2NTR4VTZuSVdFYkJm?=
 =?utf-8?B?bkRkYTJ2TEVGU3pYM01YbmVxRHpvTkRMbVJZNTVjWjFYb1FBR0FPa01qNTRU?=
 =?utf-8?B?U05FbGpOUEhYaUVkUkd5VHNoVWE4aWtxS3lLcEErYVhGUW1Pa1RiTWZWSDJa?=
 =?utf-8?B?eXp6cm8wUWUvRUltOU0raXkwbmZ3VlJ5KzdMNmt1Tjh6ZmVKQVhNRXVvWGFR?=
 =?utf-8?B?WFJxY1FrRyt6VDB0SjV0M3A2Z29kcEdxWG54elY3UHgzY1UyZWMxQ2YwT2kz?=
 =?utf-8?B?SlBmS2ltbDkyMWJxd3FKdDQ3cHVUZzV4bmRNd3lOQVFZWURDM0Z6UWFHSU03?=
 =?utf-8?B?NTltYlFIaGF1WWRhdTc4eDJvZWw2ZGtHUCtmTm1qRUx2MWNvdFdvVEJFRnlt?=
 =?utf-8?B?WE5mMzNZRGpld3NCTmc4UVZDV0xER3d6amFNbFJXMlNzZVJzUmh5RUpRUnRK?=
 =?utf-8?B?T0trQmVVa1VVYTdsYkpaRWJ3d0xuWFgrSWVlOTJrQ2xRS0JnMUx4dU5IaERF?=
 =?utf-8?B?WmVIRUVTZHp2MzAzOFFkcmh4b0lxb21Qd1NIWmN6Mzc4Q1VLYjdKMmsxZ2Q3?=
 =?utf-8?B?KzRaeVJyQW4vWG90UXlzbGpSeUNKU29EdmdqUlJqYWFleEdSNDlEeVJCVEw5?=
 =?utf-8?B?YlhGdHpacjNlY3pwcmhDbWVZUFdVYkI1ak4yeE9EUXFqRTdwYzZHNC9OT3JB?=
 =?utf-8?B?VHVlTGZxNUl4c0pKM3lkUXArcjJtMFltdXJWYktSdkVQbDhFSzgxSlM5MDVX?=
 =?utf-8?B?cjVBa2xvY09wSTY0Vy80eTRrWDlyM0FFdk5ndU1sc0hnUkkvdlBDd3lpbzI0?=
 =?utf-8?B?YTNKaDE3LzZ4aVdweXlNbjFrTmg1bVpnWFN4cVhWT2Voc1VxY2RCSlAvQkNW?=
 =?utf-8?B?c2pNWDc1bnovb050dVVSVDdFVnM4M3J0YVZVcVNjWVE0aWZGMmdXK2JQNnJ2?=
 =?utf-8?B?MFAvdHhQWGlUZ0pGWFdvZ1VVVlZRTm0zYmZvSy9OZkU4eEZpV0NUUTZHbUxp?=
 =?utf-8?B?R1lLQm5zZjZndkFZZDlreDlBamVNUFRNQUtaaE0yMll5ZHYxbFFpb3FmVlRX?=
 =?utf-8?B?UVc2ekpIZzZqNDMrSWw2NkcwSTlIZVhzMVRRQXpkL1V1ektSdEl2UGd3YnJ2?=
 =?utf-8?B?aVE0TWMrRXgwcDk3blJGeUovNlc5S21JZElVVUQzVS9rTStpOVB5cHM1TGtB?=
 =?utf-8?B?NDB6ZWhjMHFxdDhMM0VwL3l2cmhXWUZ0dlZDZllpR0VjaDJvRzlkS096YzFV?=
 =?utf-8?B?RUcwTUVRODBHSjlmN0NER1JLWWFOYmFTU2NBU2dWWFdHRkxCSitUaGxLbWR0?=
 =?utf-8?B?cndPcWlUNW85MFZOcmlIUUNMM1lFQzRwNTdDMWZZNG5KT2xFT0p1Lys2VkpE?=
 =?utf-8?B?dHpEd0ZCVDRoMHJNQW1nVWFhSWtsdXlDeDUrbDNZWWJxSWs4akhGT1NUTGJ6?=
 =?utf-8?B?NlFQU3N5UGYrQ2Z6NGNiTHV4TkJuRjFOK1d0T0czNDEveTdRYmY0UFpqbmlF?=
 =?utf-8?B?SFNGb3A4RWE4aFg4SklBSzNocHlhWUVCYVdSWnJrK2U1bVJmRnFEZlFmSzFB?=
 =?utf-8?B?OHFobTY5eG53N1ROZ1l4ZEVndFlOTHdwSXZXZHJIQzlJcTluMndzdjNxaHB3?=
 =?utf-8?B?ekV0MENCWE80WnV5Mjc0T0NKRzRsd3Y4UytaVXBWSVphUSsvUkRSZjlLQ2E0?=
 =?utf-8?B?Tjhrak5JRzBGRXl6NUxrVzhRQXViTzlrZG96L0loaEFIaUJWZmFwSEVJQzA3?=
 =?utf-8?B?dEN0RWZ5VnVFN3F5Sy90bTlUa0dIL2lkTmRmTDVQWDROb2lxM2xjT0Z5bTZM?=
 =?utf-8?B?NDZqR09EaWdnY2lTajJzbHU3VTd1Q0RzM0NTb1pJTzYzTDZtSkw0Q3hIWE54?=
 =?utf-8?B?R21iY1hVbUNJQ1RNek9qdU9iQTJIOG9ZVDVDWXRaQmJaVTM4WGV5SlZ3d01J?=
 =?utf-8?B?QzBGZTFmcGQ5TEhiUUdTanhsM3NQa1k4bFVNZm1vdENOT1NSZ0pMZ1c0YW1r?=
 =?utf-8?B?MUZNa2ZNNUYrMkJWejZrNWNudVhiWFlvcXMwRUVzanRFUlZQQ25zY0NYbk1x?=
 =?utf-8?B?Qkdxbk1ZZUJxN3VsbGVmZDFNVUJUcDhQeisvV1dzM3JVVTBPd0VheGd0Y2tz?=
 =?utf-8?B?YisxdEJLcDczVjVqWEE4M0hpWU5KL2tDNnlIeUUrWTd6dzdra3p4YXlueXRk?=
 =?utf-8?B?dUpTbWl6V1RLZlREZ3JsaWxLSnZmNVQvT1hCUTJpbmlnQVFHK3l2dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3928c96-3ed7-4ec1-57c0-08df19ac15cf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:51:40.2946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7aaHV6Cc7dILQ/ynTtXf40P6f7BkvPE1Um4EomiR1DG0X+794cHKesybZA76eeLYQIsdoZQCZH9HeRrgd+Tlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3624
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Sep 2026 19:51:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24281

From: Jan Kiszka <jan.kiszka@siemens.com>

Just carry-overs from sid so far.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb           | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
index 7d198582..b2c48639 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
@@ -39,10 +39,12 @@ DEBIAN_DEPENDS:append:buster = ", libgcc-7-dev, libtss2-esys0"
 DEBIAN_DEPENDS:append:bullseye = ", libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0"
 DEBIAN_DEPENDS:append:bookworm = ", libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0"
 DEBIAN_DEPENDS:append:trixie = ", libtss2-esys-3.0.2-0t64, libtss2-rc0t64, libtss2-mu-4.0.1-0t64"
+DEBIAN_DEPENDS:append:forky  = ", libtss2-esys-3.0.2-0t64, libtss2-rc0t64, libtss2-mu-4.0.1-0t64"
 DEBIAN_DEPENDS:append:sid    = ", libtss2-esys-3.0.2-0t64, libtss2-rc0t64, libtss2-mu-4.0.1-0t64"
 
 DEBIAN_DEPENDS:append:clevis = ", clevis-luks, jose, bash, luksmeta, file, libpwquality-tools, clevis-tpm2"
 DEBIAN_DEPENDS:append:systemd:trixie = ", systemd-cryptsetup"
+DEBIAN_DEPENDS:append:systemd:forky  = ", systemd-cryptsetup"
 DEBIAN_DEPENDS:append:systemd:sid    = ", systemd-cryptsetup"
 DEBIAN_DEPENDS:append:systemd = ", systemd (>= 251)"
 
-- 
2.47.3


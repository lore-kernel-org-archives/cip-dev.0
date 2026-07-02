Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2142C43458
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 05:53:43 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.63433.1782971622099646535
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Jul 2026 22:53:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=O/aGjPEC;
 spf=pass (domain: siemens.com, ip: 40.107.159.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNaCnnX4oTDbPcOMzA4JkFYQAYO2sF9tytaHJ5PzdHJl8ExfMhHKGly/dmJMjBMZCAOt5+RkiO3vX8uv6V64ha9FQ6Ul3SnuhZgee/r7+bLLe5YfmHpHDBUzst3r/UdIa6Nc+/7KDqD07U/XYsUC2HyNcUMHHhn4h6S4S/JU8KlY5SHZKB4PoNA6Sy1UfciOC7g56yM6gZd6q++e/3eogFxMSAovdNaSmdbBM2xxzVUoFWaMumXT9yRKInzwqyPmvJ01kuy3gcmvyBzp1/G8tmVcRsse4mSDjqfjSEL9JiA2Gm5jx+q0KTp+bAPiYMGkjhIrskW0+0xoFgF0GgQW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVAc6yOjtcQ4+rf0adsM2/g2G0WW5Ggf05gZ2uQF5HA=;
 b=LblS1iybP1QXkbJAeVPGDnEZ87K+68jE0M2lavtR3SpGgCIlcvcdscg8NTYLjra0P6mMlt7M3pD5ETHQlb/S1W0xLmpjnxTVjbFaGaVJoJ1IubiLp1ExEdpT7kj0vxaN0rHA58MVhCYtG74GjJnacb8+O9urhoWxfzGZhf2XIDePrXlewb1x5zNctbLC5yN05+16jmGLhzd2QYut7/PK9+nZslsFaxpZABf/f8nlp+DCY/fKvgS/I4+7f11pX9Z2itdDi9CEfYisYXBXaVETZ/LI4ScPeMD1g72ZjoxKi2zx6x07qeMtoc8qsW/e1XTnuwdLtvkAG14h9sOKAr6UYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVAc6yOjtcQ4+rf0adsM2/g2G0WW5Ggf05gZ2uQF5HA=;
 b=O/aGjPECqvImf1t8aAcaFrAFy6Uc2lGAtGAWIvYQkBngQY5QlyvbnqxhWqeOLMrUyk6zgCIFk1r94FHiZFS/XV26Jha7WRbO0ctIpLbycoQ/PQ8WHnPUmciQ+TUMGPNREztOmR4BnD0BC9QlG5Fki7umrjeeNez732Cy9ZtyBWhGrOiixFP6OIgKyb6n87ExgzQ2saiRW5Q/7UVlk/nbCf6RT7H4LwvRPoWGUoF2tG7CAqHcH9wPjWNWJa6Sewl8T9R/BQH2JlWAy69hHTgJzKHi0p1Nhb46TK4uqZCWwtf8BBB+DW0sjJwYIk6BQ44KFtsyBFwBpfGccpOqMM84jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7125.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Thu, 2 Jul
 2026 05:53:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 05:53:37 +0000
Message-ID: <6310a8ef-6f66-4dca-8873-52b2dc088d15@siemens.com>
Date: Thu, 2 Jul 2026 07:53:36 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.12
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0418.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd79373-8cc5-4ac7-d7cd-08ded7fe4283
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|6133799003|3023799007|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	zr8dw4NMjtmc7y9Aa4lSaDLTWS/V+Ol4PV8QhWPAa9dlBzG87OPiT/TIs7eMsuHcLkOZ7dmUWqkdKCtlrZNZX7IE9XEPspioSzrCMjtm4EJM5c0xSF7I6vgGmn0PVyoIibLUjrjvH8zxFeKKymXXImpzubRNSbRmD1ntC9rQA8lUqengyWi3+W00ktO+LqUPCnLBjE2D5K9ztvCVU/5ezN3Ps3jrDRAri6/HSJC2WN7+hWdC+InsFX8c2ssujOy9gBhddz87XWSZ/d4NGrr/OkXbm0S+chzY2m767RJ+L7cafb40cday21x4+GAwaPtH6IKI12YcNXIO45kC7gVrQGGvLZUlOKiHjkfX2lBrUlDOZerO1CJPgNS0KM6alA7NuvUCgEPyFqx1RAZzz00UlCnBvHFIUMPFclofYhXpFIgdPiJ2qeVqaO7N5UlwuYEkUZUZ5RajKaXmWCwHXd3qXPaCqDv/vMfIkSD4HqVr8hwefejE29bXHtjWGEJXGNaZton3QbM92SnpThS0XOufm3Y9g1dvb5PTINuoY6IjjfPtTJea63qDLlTJOu45n+ikijpV1hhdpPOGMJYR4hTSHPvxh5hot6UtBUlsUyNcQ3M7idz+oMoXtN9whg6986+qDmq2MhQYJNKwsJhaJ53GHR7TX4k28jkAti2y5B0QgOA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(6133799003)(3023799007)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z0d3dTliR2NUaTVvL0MxTVZmejN5UGJXeVBvQS9ucXdleUszRkNkQVA2c2g0?=
 =?utf-8?B?c3ZhcFhrbmkyUXdHMy9XakdxYmpndkpoY1ZVdEhKbURVL0I1NXdoa0o1dUxo?=
 =?utf-8?B?dlBubUUxNGRvcGUrU0Z3N0YvNjNZbXozbUNPQ3JZZjJaVFR5YzNlekF6UE16?=
 =?utf-8?B?NHRhUkIyRHBoRVJwTFI0VUthVGowWWNrd0JkamFSeS8xbTMwdklxL0UrdW4w?=
 =?utf-8?B?QTdvVnIyVzFjejMwZDVFQjlyeHBxMStocFNTd1NGekNnc1M3SC8zN0lSMDNS?=
 =?utf-8?B?OTNWOWJxT0swajJYdzdaa2tqSUNNcXpkM3owWVRKL2grd3JROXFnUzBqbzQz?=
 =?utf-8?B?VUhxRUNMNUx5UVErRUs1Tk5VRHVqVHNJNWhXbldZN1pROXVRNzgxeGVBL2hx?=
 =?utf-8?B?TFl1MWU3bHZWVkg1bDdaNG5iSGhDTGtINVFjY0xSYnl0aUw1NmkrbGdCdGZq?=
 =?utf-8?B?dnkyUDVKVTQyQlE1WDM0cGNER2dkUHRYVytXNFl6QUkvbks2a05aK0ttYzMx?=
 =?utf-8?B?a2NXdjJGWnBwRGloK0NMK0pld3p1Qm5hK2FVNU10UG5sYS9QQVlxWWdqZWVV?=
 =?utf-8?B?ckFFb1RqM3BBSVIrMjVPV0xLeHdndGV1MlZPdk1JbVlnNzFxak4xZEpVV1FL?=
 =?utf-8?B?SkVLd3NVWHY0b2hzUHhTVkNyczMzL2pFanhGUTlud1RWanl1eWVwUTlIV3p0?=
 =?utf-8?B?Ylg4enpic0RYOUtuZGsvTlpTUDc5dGxlNnRvdjZPV0dQaEViUDFxd1dUcHls?=
 =?utf-8?B?TTFQVnpIWmdQNXhnRVRPamxiT3c0ZGh2TE95ZjFnWnU4YW0xU0JHNzBCekJE?=
 =?utf-8?B?cllpQm40UUdrd3J2QjRCWTAvaWFiUWd1UXYvNS96dFlHZjVUdDZRclZrb0Ja?=
 =?utf-8?B?K0owNEdxbytETHVIT29zT1NwQ0VybHI1L0gyd2gwckJnL29pR1VZN3dReGRR?=
 =?utf-8?B?KzFYaEI5S0s4SCtPVVdRcmZOKzN2NDk4RFg3U2dXbjU2bmNMZXgvRHRUck54?=
 =?utf-8?B?ZjM1cnJqcm5QSlM0VlFsN0t5cHVSSlRNaDRLbEovNzBXYjNsS1JBOWt2aHYv?=
 =?utf-8?B?aXdsZnFYNFM4UGdHUnNKWHdCMXRNb01xSjlnS3pDcnRidFRDRm03blc4c0Zm?=
 =?utf-8?B?YlRjWWwrcVRXM1A1YllWdEZLZU5XR2pYdG8yckcwdDJFaFZzaXNHRG1DcDRm?=
 =?utf-8?B?eHJsa1czMXF4U1JMSkp3K3RONWtucWJEaFVDSi8ySHBtV1B5WU5WckpJVW4v?=
 =?utf-8?B?QzFWa0NsTjJrUHZiVy9sNnJ4Q3VlcjExU2ZhbngrL29lOE1nUkpBN2JINDFp?=
 =?utf-8?B?bjY2blYrRE1LTVg5Y3NWM3NKNHNTVWp6SFJ5c2t6aDdBMHh3djdpZ1NZRzhz?=
 =?utf-8?B?bXZJemV5azFmYUJvNFhLcDJiQzVzWU1Fd0pGem1ybVlXaDZCbmJTRHVSdWI1?=
 =?utf-8?B?V1NlNzRCblRyT1RnWWsxUUN4SDM0QzhQaHpkZmVOYjhlbDFWczdxeDhnR2Ny?=
 =?utf-8?B?OG1DNm1reldVM1RVRFI2a2JGODdWV3BCeFd2cEhidzVsWmNwZXdVQ0paQ1BL?=
 =?utf-8?B?RUtxazRtQTVzV0F3WmdXTjcwOGdlcUlyYWZFVDVFSVRSN2NGT1l0ZkVDeEVi?=
 =?utf-8?B?VTZGMlVwemh0M2lOb2Q2dTJ0YVNIbjFKVWl5bUtiNUttTnJEaGhLamFPdi9s?=
 =?utf-8?B?dUN3RWczdVhwTGxwQ3VIa1NvWTdxUE9FRFFJbXpxTWRXZFR1cVZZVmFFaHVa?=
 =?utf-8?B?TGVzWEtvTzd3QlNyRFdrck1GOHNKNklFMm9MU2phRWkvbEExR1pVa1prZnJr?=
 =?utf-8?B?RXEwbFRpTkgvdk9Fb203Nnozc2FPckFNYmdUL2ZXT1hsc2dNc2VhWkRJQTUx?=
 =?utf-8?B?bzdnRHQ1NW56OWRjNEZRL3kxQThLdS8ydmRpRkdSMHB3empGTVlGUmg1S3Y0?=
 =?utf-8?B?bUtkcWtLTUJ0SCsySEtaRGpZWVl6ZGxQcENLNHQyRlJ3K2M4Mi9YU0RYVkhj?=
 =?utf-8?B?OVcrL3RJYW1BZ3lYK0NZQkNOWkUvNHhvSVJQbnlEMUZmdTFwc0M1RmFoSUU1?=
 =?utf-8?B?WHNSYUFjU0laZElobUg2Q2t3NnErVnlRZ0JPbzhjZytnUUZpZjJGNlhMb2hV?=
 =?utf-8?B?NDFmY1c2RDdjMTNxeHZRVklCVkw3U1BPenl4OWt4Ry9zZy8zdDhkWnUyZWpx?=
 =?utf-8?B?SlRtYjlkejN3eXNYUFBpTlpSYXdJQmVnZXBOeStaOXJFcXJNeklMS2hoWStG?=
 =?utf-8?B?Nm1NQUlEdkN0WEt5S1V5ZlNzdUIwZ2FEUWU1bVc5aDJyTStPSnY1KzNoekg5?=
 =?utf-8?B?ZzlxbzFJQnBwbWJ2czZXOVYvSUFaRnpWMXdnRUVDVEZXZnh6TjB0UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd79373-8cc5-4ac7-d7cd-08ded7fe4283
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 05:53:37.4611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYT3uu9bMFudkCHedEqaCJ5c7LBq+U5SzTSvQ7p2RLWxLslINmgyZnfzUbLz3GOmF+Y8heEbs6UwNqAP6hJ3Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7125
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Jul 2026 05:53:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23373

This is the hot summer release of isar-cip-core. We have 36 changesets, 
10 contributors, 66 files changed, 355 insertions(+), 255 deletions(-). 
That's a bit less than for the last release.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/v1.12?ref_type=tags

The lower activity likely correlates with no major feature addition or 
rework in this release. However, we have quite some useful fixes and 
improvements in the details like more robust TPM enrollment during first 
boot, configurable device identity for the wfx binding, or custom mount 
options for encrypted filesystems. Dependencies were updated as well, of 
course, including support for EFI Boot Guard 0.22 and well as latest 
Isar. First steps have been taken to enable continuous testing of Debian 
sid, though this is going to be fully established only after this 
release. Check out the git history for more details.

Thanks a lot to all the contributors!

Jan


Adithya Balakumar (2):
      security-customizations: Hardening ssh configuration
      doc/README.factory-reset.md: Minor updates related to use cases and relevance to IEC 62443-4-2

Alperen Erdogan (2):
      swupdate-config-wfx: make device identity configurable
      doc: update wfx documentation for configurable device identity

Badrikesh Prusty (1):
      linux-cip: Update to 5.10.254-cip72, 6.1.170-cip55, 6.12.85-cip22

Felix Moessbauer (2):
      chore(factory-reset): make btrfs support optional
      add descriptions for dpkg-raw and initramfs-hook recipes

Gourav Singh (3):
      initramfs-crypt-hook: add configurable mount options for encrypted partitions
      tests: remount /var with exec after login for LAVA test jobs
      linux-cip: Update to 5.10.256-cip73, 6.1.173-cip56, 6.12.88-cip23, 4.19.325-cip130-rt47

Jan Kiszka (13):
      Update to kas 5.2
      linux-cip: Update to 4.19.325-cip131, 4.19.325-cip130-rt47, 5.10.252-cip71, 6.1.167-cip53[-rt29], 6.12.80-cip20
      efibootguard: Update to v0.22
      linux-cip: Update to 4.4.302-cip110, 6.1.169-cip54, 6.12.83-cip21
      Update Isar to 1.1-rc2
      linux-cip: Update cip-kernel-config revision
      linux-cip: Switch to out-of-tree PREEMPT-RT config fragment
      ci: Remove SQUAD support
      linux-cip: Update to 4.19.325-cip132 and 5.10.254-cip72-rt32
      linux-cip: Update to 4.4.302-cip111[-rt61] and 6.12.90-cip24
      linux-cip: Update to 4.4.302-cip112, 4.19.325-cip133, 6.12.92-cip25
      linux-cip: Update to 5.10.258-cip74 and 6.1.175-cip57[-rt30]
      linux-cip: Update to 4.19.325-cip134 and 6.12.94-cip26

Quirin Gylstorff (5):
      swupdate: Remove Debian build profile cross
      Use pipeline id instead of CI_COMMIT_REF_SLUG
      crypt-hook: Check if WATCHDOG_DEV is set and available
      scripts/submit_lava.sh: Add an timeout of 10 seconds to the SQUAD call
      Add missing MACHINE to install swupdate-config*

Sercan Sari (2):
      encrypt_partition: evict stale TPM2 SRK handle before enrollment
      tpm2_functions: verify PCR bank output instead of relying on quiet mode

Shivanand Kunijadar (4):
      Add the default kernel verions in cip-core-common.inc with extra weak
      Enable Debian Sid support
      Enable CI image build and test support for Sid
      Revise README files to reflect the latest changes

srinuvasan (2):
      shtab: mark package as arch-all
      Update Isar revision


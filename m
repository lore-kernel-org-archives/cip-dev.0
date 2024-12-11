Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9A0E77180
	for <webhook@archiver.kernel.org>; Wed, 11 Dec 2024 10:45:24 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.49])
 by mx.groups.io with SMTP id smtpd.web11.7999.1733913918052840056
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Dec 2024 02:45:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Y1iA+pr7;
 spf=pass (domain: siemens.com, ip: 40.107.20.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkG+5MkfwF+zvMXwWvlse7MV4bNN29vaz1CWNkFlyba2hUxWLejfrxlNNWHnZOMUBK14bfPNMx4AQqmKEGe9mKDA7eU8NqXXukltIYgxCupCksAL2yHiYgEUKtDmn3Z/4v2vaCE3P82aRMXO3Ws0HmzLsDPSEb1OTS/vPYkK22GcIXxVCgebDlZ4x+BI/XL2OdEkj/TQNFJ386gV1sGrAiV7PFPXvVx03/XhalNsZpRcOpn6hBa4rxUJIOMr8k/BkMn3FRZIab9NfwIJ4mAgtWS6Z0km51ic6R77WLcSnF509EUnWtPFRy2Hr5jw7cX26a0Ct/lNpLBlMhSoMRV1sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvTFtSqzpVAxb9TT8iLGQcGrQ9NBr++wcCWr0shoFnM=;
 b=wHKw6mZFoG9iQsk9/D8Id7m6EcIqqewTmkgj1b6+1LHLWQzDg1qzCSH6rWppnKxT8miWR3nvuZw0QiCcIOPY5YaULNNfzwWm2FiGQsJixfKwgdvI9VDqjHdM0twdiZ9tTeI65vIQ4BHgXGW3ke4SejEHxpxChcOF38mfAYsJXyt4ugJaUHqiiotWpD52sxZtELK7NBszPl9J1csXFn97fchbxGbybsYFLoyyM0cMseL5zH2uTMsJ16xoIN7xuBp//ZxNNdEjrbS/sKxRtyKrr/wjCP128BBKHt20dOKZqgysEq32IWsWZzu/Hr7dd8hEreVuU5s4zjTEBnJz1S3SkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvTFtSqzpVAxb9TT8iLGQcGrQ9NBr++wcCWr0shoFnM=;
 b=Y1iA+pr7flHOZUsVJUpDCvXPxD/uOljzZRGnJIBJGRVhiCRgNR5Plif7vLAanEWwauloo+vI1upRsNMQBWdm8jt9TXomuiloeHmVyXspICqIunpYzZ7mNvpor1pUu4ol0og9LA9/mawFZW+5KdEVWb1AVhWjR2UJw/XAWJ1jHhwxk/VMV4dt/xZaaVo2bHDAd1q3XyKYYKnn30u+1mgn/D30zbf2HyROKxHW7jTRHEe/glKUxmeewHmBN2LstPSUJAUZG1ZxHFclGiiKlF0V0LpyGCIv4dO2YkI9gnoXYgZpw6Sci7gSIMS0HaQP4Y61PSTsBuPlI+pkfD7Spdq6Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6870.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Wed, 11 Dec
 2024 10:45:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8251.011; Wed, 11 Dec 2024
 10:45:14 +0000
Message-ID: <f288734d-b198-4b2d-8b60-92924eda838d@siemens.com>
Date: Wed, 11 Dec 2024 11:45:13 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] qemu-arm: Roll back to qemu_arm_defconfig
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c69da5-751e-49ea-978e-08dd19d0e50d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QlNUSmtEY2RTU2drWUJrNVQ4ZmtFRGowN2o1SGZadVVMU1FTdk9neExTQjRF?=
 =?utf-8?B?MUpWZnNZenJ1dTA5NjFzTVY1NzZTMC9XbWhuRUhYeDh5cXFmT2t1M2N3dW83?=
 =?utf-8?B?WSt4aGdHSHhDUTdlMk9FTVNhdmtFV1ljSWdSZUpyUlh2RXlrR0l0VDFoUHpU?=
 =?utf-8?B?NFBCTVdmSGRpZ1VhVW9UNURxdGcrTUtqU0VlcXVsR3lwN1gzaE5JRnZ5L0JP?=
 =?utf-8?B?K0NUVEZLY1hrQjA0MUx1WklsK3lxdDJTc1BETlM5Y0JnaXlZeVNhOXcxeUly?=
 =?utf-8?B?cStpbk5JK3pRY3JSa0s5eXZXaHlPZUsvbnZwbkRxVVdieUpJY1JyRHcwYkZM?=
 =?utf-8?B?aitoVGtSRVkxYmhldlpKS0JVT21zZVUvVkE4YjJidnJEZHhjRXpyd082RzhQ?=
 =?utf-8?B?Y1F0K3lTK2hnRWVaUnI2aUFtZkxWTUNqU2pNRHdMN2NabytZNVZVbHVITmY3?=
 =?utf-8?B?QWlsbXV5SU1mTHhIVy82cWd6ckpON20rUW5IQmx4aE5rcFcvZWZZa1doeFNV?=
 =?utf-8?B?UnNGM2k1VU9jS3VaaFRIZGRoQXQxemhGWDl0emVEbk5NRGZ1NG9GbVJ0YTAw?=
 =?utf-8?B?dzJzNWdTQXBWUG9WVyt6SlNBN2MwdmpyNnd1WDFBeFNIdE1ZNUFFN1JxYW9T?=
 =?utf-8?B?eTNNUDVwT3dPeUZUR09hVjIwZGlJZUZJL05VMjRrSnk0THYvVE5rR3UwRkN3?=
 =?utf-8?B?U1JvRUU3SkJBN0E5bWt6Y0hNaEFCL045RlFEbXJNcUd0K2YxaUkwc0V0MnZ5?=
 =?utf-8?B?MFV5MnpaNTJJUDlVYi96TkRsdHQ5WWFZWUtXT08zazVxVmNPZ3llbnNiNEZQ?=
 =?utf-8?B?Unh0RUhHVFd5Z0YvOVJaRS9JeTBldEtETlhlekJEZmQyd2JyQ3o0STNkNnVr?=
 =?utf-8?B?ei9iM0E5NkJOSWtlcjZHd21NNHZuRVJZN1huR2tubkJMUVBWTXFIVlhXZDFX?=
 =?utf-8?B?WUp3VEpjMUVvWUxySENiY1haOVlROHFxUkhIT2k1QmpyMEozQTJNU1djVW9N?=
 =?utf-8?B?enRSZlM4OEZKSmsyT08yTzNxRTh0eDY2MU5JeUNqTncrTWtUcU1Eb2hMWGQ1?=
 =?utf-8?B?L3Q5Y2hlelFmZ2tweG1sODZLYUJ5V201eUtPTWNidjlnWEJocWhkam5tMEE2?=
 =?utf-8?B?MXJNWkpEMXNDeUFPdzhmNU1UdkZXa1dLVVRPR2tNSFAzUlZFZ2x4TCthZzB0?=
 =?utf-8?B?STNNRzdWSS9sT0gyQVFQRWhaRHZDNTBVSTlxanRlRURycGd4a3JGL1RUUFNS?=
 =?utf-8?B?ZGhKeXVsSTZtRlVXRXErNnZHb1pocWwrTU1Mb3ZpVXhoL2syUzJJM3QybTBk?=
 =?utf-8?B?Q0orUnhUeldqakZmR2p6TkpEay91MzJLVlArZ2hOYk0waVhKcFhESnEyZFdX?=
 =?utf-8?B?Ylh2ZGZnU1o5d1ZaekZFOUltMk1McDNMa0NKZTdwWHlzdUNkVkdEZXJTQnQ3?=
 =?utf-8?B?RWNHRHR2TmtXY1BYWDBCRDlTTzJnUVVHWVNqVXJ3a3hDd1I1dGdNSTRZUlE3?=
 =?utf-8?B?cHU4QUc2NjZIUzBKN3hJWGJWQkZQK1Z1clpEUWhTeUtUTlhJM3YvL2VrdklQ?=
 =?utf-8?B?RkRzbjhwYmtEZ2NSR2JoUm1FSlBmTUxLMWZveWllNWNsV3d6M2pFZjVZb2kw?=
 =?utf-8?B?aWMzWEdiTVdXNzRrM2cvMFlMRzhodDZ3R2JSeWUwRG84QlhrSWZtcCthZmpo?=
 =?utf-8?B?a282ZFEwY05wVUx6NXpRaTVjeVVCKzFKN2xOVFR2SG9idm9KZmdXM3NSNXg2?=
 =?utf-8?B?YjNqS1RJeE53RjJzbVlGSXJPaWR4SUVlb2JZZWIzMzMyOUpEQUUxZzRMZk00?=
 =?utf-8?Q?AI7bYk+kiobzpcxPsuO3VwDEm109ZU1wrnUFw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cjZYTE93czZveER6SGxxRWNXMEFabUl4Z2RFanlqYXBDamtZM3o0bXNRNitS?=
 =?utf-8?B?TXV4VWM0M0ZoMDJscjg2NitkSnhzd3U0d3oyaERlZVFRS04zUlNQU3dwN3FW?=
 =?utf-8?B?SnJyeFA0bmFzc2VFeDVHd29lMkUvUWlJTXdxa2pqZzFrUnRGNi9ZVHV6TDFO?=
 =?utf-8?B?cWltVFUxM09iMGRQcFFyNDEwajRPQVNHMkRpTDdkUCtSakUxN2J6VFFNcHpx?=
 =?utf-8?B?bERIRDdIbk9wMW81SERQeXhTbUNqM1BROUhQSStiYUplS3krVVVUK0dSSTNI?=
 =?utf-8?B?cjU2eE4yNnp3MGdGbmxWdHo0VzlmQkx4K3BpZXgrd04xcWhrcFNud2IxN3NF?=
 =?utf-8?B?VEU0dUtwckxhOE1CWmlLZTRZRTdWc1FWbmpCOTJTQXdmSk9UQnFOS1RENkVl?=
 =?utf-8?B?VVhjU2JBYVNvcVFwRW9md1NjRFNYSndnSmhidHRIMG80VDVzRUNFYzJWRFBq?=
 =?utf-8?B?QnhCSlJReXRtcTZrRDNKem1oWU5qWFdTVk5DOEFuSlNLNFh6VlFnOTJZazhF?=
 =?utf-8?B?ZjJSdk8yWU00eTlCei9SV1NZVmhaaUszVXV0c1pEYS83MVpjTzFaUGdIUC9k?=
 =?utf-8?B?YVErQ1dna1c5d0xBVVhFU1FGV3E2WDVZaVhCcGhiMUUwajhQVkRKSGFCSmxw?=
 =?utf-8?B?RjZBZzJOU1k3QTh2RXA1OGlGRUx3MzJyVzFBWWNFTTlZTjBhMTFjaTVLamxx?=
 =?utf-8?B?RGdmT0hCSC9tTmNmdDlaY0J5b2VQZE1hWDhlNXlGOTYxTnFWSnR2TkpGN3M2?=
 =?utf-8?B?OXVlRFhJNXVOVFZ1Vk5aV2JEYzc3N2x5dGNJTzZjRGpTUEdUMTFTN3BZZGI5?=
 =?utf-8?B?VGd5Z1RZcWRMYUxPcVhXOTRPU0E4R01WbDRvZHpTREVSWUlYcllYNm5HWTdz?=
 =?utf-8?B?OURkOGl6R3lCQnNEMEMyN2tHOHp4dlBXYjZZL3VIZ2h6NWtadEJLRGpDdjdu?=
 =?utf-8?B?RlFMZ0ZmTW1LdVlJVkVpUGNLVjRZTzdmb0d1LzNRTWh0OE5oQ3VKdlJjaGtW?=
 =?utf-8?B?cVMyWkVTZUUxNE9kT3pNaEZaaCtZZ3NucmxUWVhWeHU0clN1aTQ1cythNEFH?=
 =?utf-8?B?OG5aNHBzSERjWitoOVZmTjhPYjhrcTk2M2JBbnVYRkNVS3c3dVpjeHVxU0dw?=
 =?utf-8?B?ZTZOQVdYeUhBaWUwZE8wazZyRWpSRlZHNmcrRGxTMXUvdklTU0piSUlacTRs?=
 =?utf-8?B?STdLVkl3T0FuV0VWTTd5c2l1S1dBQ0t1cVR6bFBWY3NEb0ZVTkYzWlF5MTB6?=
 =?utf-8?B?enVjaDhsejhKMzdnVjBzSVY4UUVvSWVQSGU3T2t0VVNDdFlPZGplNzdxa2s0?=
 =?utf-8?B?T2hXNjNVZmNKbUptQ09wTEJMTnNwSFNZYW15bFlJeVZOVjhrVjBwd2M3T1Jn?=
 =?utf-8?B?SXdzTlZWaGhISGJTSkVXby9sakRqQlR5TndLaTVhZlZSWWl5RTFjSlhJQWZt?=
 =?utf-8?B?SG5pZlRiRXNoMmRITk41djBsUGJsaXBxT2twejhuS1pFbTRrL1d5U2tQa1hI?=
 =?utf-8?B?cTRlTXhZSjNyR3FWaFBKTUtxQWoreUM4Rk5ObUlDM1VQTmR0eFZlSDJ4VTNa?=
 =?utf-8?B?MXcrekNoeHlGZk54aGRmMlgxUEpZMC9vNGtidWFXUThWRTdhQUFpcTlxRHF3?=
 =?utf-8?B?cmZzSW9BRFNrKzNYZmxSZmpWeDI0ZHFRRTNwTEovNzNvbi9jVUVnVHRHQ1BU?=
 =?utf-8?B?a3laMEZjYjNqVm9nQ3VCbys4N3huamJwK2FFZjR6YUNXb2Rqa1VUVjB0a1ZU?=
 =?utf-8?B?VDlrdEEraGtzZy9iSDBCU0NhYm5qSUFUYW5hb3NKcVBWMlFDN3dFRmgzZjE3?=
 =?utf-8?B?RWtGNlR0a3FyM2hhcE5FVE5nSTY4N0dtQzl4dFJ1Nm1oaDFBbmlGbWNpb3Vm?=
 =?utf-8?B?OW1WQ0dyM1hsT2xtVXl3Mjh1aUpqM0hNamZFVnZTenpsSjNxVU0vbWc3Sjht?=
 =?utf-8?B?NXE4azQvTy81ei9weGVtWm9hdkFXaFZOZWRheExOc2pEd09sWStsVEw0Zlp6?=
 =?utf-8?B?c245U2xsR3dNU0NjU2NqRXJpREk1dmplcEkybkVTWXZ1M08zcEQvdW03aEwr?=
 =?utf-8?B?V3Z3a3ljaWlFS1o2cHkvazJCNlZGTDUvN2h6Q3c1Y3FsZ2tPN3BOSWczMjdM?=
 =?utf-8?B?WmlnQzVNS0kwNU9ESWtDYjRrdmNncEZNUXhOeUZlWFVsMGdodFROWXpLdUdP?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c69da5-751e-49ea-978e-08dd19d0e50d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 10:45:14.4178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: deTO0gloaYkH7wXi6srMb4pt8CG7H77gcDEW6mdrrDNZGYIYSlmWz1+w1UygZep7rVQtud9Y2d78z1hpgMkjNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6870
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Dec 2024 10:45:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17403

From: Jan Kiszka <jan.kiszka@siemens.com>

As long as the root cause of losing CONFIG_AUDIT while generating the
merged defconfig is not fully understood and resolved, move back to the
known-to-work qemu-specific config. That unbreaks our IEC test case [2].

There was a second issue, affecting the qemu_arm_defconfig directly. To
fix that, we also need to update the cip-kernel-config revision along
this.

[1] https://lore.kernel.org/cip-dev/5ed0fb0d-b505-4155-b330-069881cd9072@siemens.com/
[2] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/8580918327

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/machine/qemu-arm.conf                 | 2 +-
 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
index 17c08832..d2dd81f4 100644
--- a/conf/machine/qemu-arm.conf
+++ b/conf/machine/qemu-arm.conf
@@ -11,7 +11,7 @@ DISTRO_ARCH = "armhf"
 
 IMAGE_FSTYPES ?= "ext4"
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_merged_defconfig"
+KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/qemu_arm_defconfig"
 
 # watchdog is not yet supported in our QEMU executor for this platform, disable it
 WDOG_TIMEOUT = "0"
diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index cbc7e3e3..d26ff3fb 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -14,7 +14,7 @@ SRC_URI:append = " ${@ \
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "bb2485db01c5ce14ec571b9fb9e03f90c686a69f"
+SRCREV_cip-kernel-config ?= "b14ada5877ab5280188f3549c21891b7a830896c"
 
 do_fetch[vardeps] += "SRCREV_cip-kernel-config"
 
-- 
2.43.0


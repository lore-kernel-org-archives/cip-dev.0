Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5D9C3600B
	for <webhook@archiver.kernel.org>; Thu, 27 Mar 2025 19:41:58 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.43])
 by mx.groups.io with SMTP id smtpd.web11.5404.1743104517616572289
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Mar 2025 12:41:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=f0fmCjcX;
 spf=pass (domain: siemens.com, ip: 40.107.249.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4vcKxYLXRl4ZsQlwTSPwrp94AqdQ1/WCCAKYu/Gv84HVpVJe3yAs8/hxUsJ8Z6U7KgNmnYPtKo4bNeRcdxMb5YGs5Y+oBpffQ9flVwa6AhY8X429gkDAjIHucNfFC2vRhhNKvxxMOG86HG6B57bP0sdOsKUjpqwNtblbOWt8Gcd1wGWLEWdEwkAaFdXej5S0bbtxuFk9/7UwCiBLN19lomIYtfEr6qZDuPLpJR+NrhpPp2Wuqm2GetNp1EH5QRCX0QsuAIg7mwMRFg1xbn31szClHonhzFDjV42wsSq+CGXIpOYippIxsN5eNyJLZv04bZLcMsf0K+6nGBOAm1QcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avgbVHY8k4HPXRE3wSSd8LnHvtwM7mU1zqVSoEJVMPk=;
 b=EzTSBAbBccaX7h3or9uMv1V3ydVelwWtXSeyqSIebcLo1FEGbfCDlG8Sizfd1LQRwv5k1bKexH5gkxC02+uRGveDZ2kCDExBq9FG93qK9RRJbozD62IQ1Zkiw4UQEhtfyJDVrSktfRkvzAjQLfVw3qNGgJkyOEurAR6oIxVNi9KeaNh5EVGDrB0MaoyYfug64QTEisQRrRCJkfrr62D0GZNHNGwAzXweGVL3CClcS2gFzjeSwOFkBwOkr/49gC4IUdewaBbM0IGvZjhr8Fv8Zy1t19Nah6Kz2h+nA22AEzHsXAZF4lKG2mk5CJGM4WTZ7dF4UFUtNGFBddPRLkNWWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avgbVHY8k4HPXRE3wSSd8LnHvtwM7mU1zqVSoEJVMPk=;
 b=f0fmCjcX+FFc3kT6DQC2mfE27hWU1CqcOQn8I7AEa7wIr8Awkuv5gOn4xBOti4sftxP2wtsRjgh34D3MZYdCEXp1BUaGYPO+qsbuL8iSGM8z60G9hXh1KBsWdaYtJ23VEW/fcoIMedrIQ5z9Zf0RpQ//sVFn86bJXG9M0c1KByRBD5BDhDMlA03g1CA0PQMLr7PIdK3UJr1znBFEcxWZnTyKNEtAp7XFtCQ1jifxL1N+2kP5NuyX4sn6GBjvkg4XYJcPlF+kgUtUsnTRODR5wiMsqNV/iSRQ8GnJqThkCjweZD/Z2T2ZRYS0RvoCxoys0b7eFrjef+UDu/z4/2o3lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB9PR10MB6643.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 19:41:54 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 19:41:54 +0000
Message-ID: <6266bded-096e-411c-91f4-a505c05ee06a@siemens.com>
Date: Thu, 27 Mar 2025 20:41:52 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.7
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::17) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB9PR10MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3ae85e-f7cf-443b-778c-08dd6d676d08
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TXBDVTRtc3h6WWpTVXZJaFA4WmtidGVQOVZRYmU3YThadkw1dSs0SnE3NlRi?=
 =?utf-8?B?ZnhhbG1zbU1TcUU0WGF3MUF2QmJtbzQ5Mm9ZaE5NVHhFV0lZdHBka1NXdjZp?=
 =?utf-8?B?b1pKcEZ0L3ZlTXNrTzUvYTluN3ZWZlhuVHdDeGpibUF6SFBxYXZHMThsNmk2?=
 =?utf-8?B?REMxTzVFVlFCTzNMRWsycG03L3plMGRidGlMenJBKzFFamZlL3NYa3JVb2Za?=
 =?utf-8?B?QnJQKzIyS1hRcHRscjk3ckYxN3lHaEZEZW1WcXFlY2FPMlBLNk9LdnZMVFBR?=
 =?utf-8?B?Q1ZBSDNsY0NEb2l6S1pQQ3hPc25nVGpGVXVFU3ZSMHlKTVJTc2MzZHlCUDh1?=
 =?utf-8?B?aXRhMXlZZFpUU1JCaWhoTXZGdFdpblV6SFVUUGpOWUpyd1dkZHI4TXc0TW41?=
 =?utf-8?B?MGRNWjhVN3FndStWYzk1clVkM1ZVUm12WHVLeUxRYzVuRUkrNTJONTJNNmJY?=
 =?utf-8?B?TUxpNWJubUlBV0djN0h5MzA3SEFTWEQ1Q1p3Q0JRL2FNVGRBL0lGQmFBYXNa?=
 =?utf-8?B?aktrZXN2NWhHMlJhRXZ1T0JLNU1BMlRmRUNUdTNSWU9HeEN5QytGV0ZXK0pY?=
 =?utf-8?B?QitIdE91R29tN1hTcDRFM2cvRXhjYy81M3ZibDJ3WWxFaTJqMGhFOWVHdnRv?=
 =?utf-8?B?K0I3dTVqUlpyNXlhSzhNOEJja1FhM1h5eTBIOFZOdG9xM0RRS081UEpmUlRZ?=
 =?utf-8?B?OEphVlo3aFk2dFJIMzNMZ2J6dFoyYjlrMjExMGsxQmZsZEN6TkxNMnhYbHVY?=
 =?utf-8?B?TmNVS01WalN2NWMreGMyaTc5RUN3YURxa3hvVTlWRFRsdDF6VEZtVFJ5Wm84?=
 =?utf-8?B?cmdCeVF3MEYvV3hUbkpxZXVraHBWV1BGRXlpM2psMUplTWR1ZktkcVY1cUNr?=
 =?utf-8?B?WkRsRTBkN2hMMGF4NC9xTGF5VE9iUTJvN1BZdEZmYW1XUVRZQ3JZcEZPTTR5?=
 =?utf-8?B?TkJhZVY1cWI2aHAwdk9pKzl5cGhueTdFZnpCRnBPVi9vM3J4YndrbWV5YUJs?=
 =?utf-8?B?bWkxNzZsZEhFUzJod2ZlemNVZ0cxa0R1NGZRTVFFVDNhSjFXM1FIem12MnAy?=
 =?utf-8?B?RDZDb1R4UU15Yk0xY29TK1lHQlRUaEV4QVNPTjNRNFZINkJ5aXJpaThKZk5r?=
 =?utf-8?B?TE5UWWRkOWlxcFIrdDQ1WFlPd3d2MzhldVBwTGxiM3pTRTFCZXAyc1RBZE92?=
 =?utf-8?B?L3dhVTRVelFjall3NFVxVUhDZTJncjJrdWVlcG1xdW9rdkN2ZFN6VmQwQ2Zl?=
 =?utf-8?B?Rkh6VWRqNFJMeXhva1FwdWNtTm1CcGJvdVI3TG9QLytqNGs1NFV3bS8rMlFh?=
 =?utf-8?B?U1ZZeTR1VHI0S0ZMZ2hjME5FRUJLTjNnNzRGY3l2dnJJQnhjcnE4b0ZvclZ5?=
 =?utf-8?B?QnBGRFBLZWN6dVlGb2hKbTRyTnhodWMzVW1mb3NGcDRxa1REK3hicDA5by9I?=
 =?utf-8?B?ZEFqOXFuVC9vcVc5UHZmL1JQZFlxaWlnY0d4bVlOYVE2US8zcGg4alc4dUw5?=
 =?utf-8?B?V1hLcWZqb0ViRnpNMWhrSXU2S0t4Zmh5Yzczc1F3K1JvL3ZWaFNBUXlaUVdY?=
 =?utf-8?B?WEk5eU1TQS9oR1g5Z29mOGpnR05UeUtEVHlFYllsdWI1UzZKQmsxNFlzTGZ4?=
 =?utf-8?B?UUlTeER1azdSeFpTT1o4aGhtMmtuTWlSazljZ1hrQzlCTTdYSjVwcVdJR0t3?=
 =?utf-8?B?aDNKM29GT0RSK3h6dXdaSzk5eHYzSnVzcmVWL0lTbHhKenl5Q1VlMnJuU28v?=
 =?utf-8?B?TG1PbXZMcnM1cW13M1U3eU1NUWp3TW1vMHRBSkxIcndhbmFNU2tuVXJ1WUYw?=
 =?utf-8?B?V25pcnVpWjRhMDFqUDVkeks2end1eFJFSGNiSHVjQ0JxUUoyOEE2eHo3L04v?=
 =?utf-8?Q?bZS5DhXwKU0Ab?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b3hZbU5yNHgxR0FhdUxzcjZoR2VZTWp4aEVCZU5uNVRNMVdhbWU5R3FVa0U4?=
 =?utf-8?B?Q1B6OGRsNllpWkJDTDBSNkxmeXJUUUdaTkVyejVtSlhHakZneUFuUTA1WDJP?=
 =?utf-8?B?cDBpYUdaTVRheHFrbEhNUHB2RHZrUjZPODV2UnVHbFRTQzlKdStoa2l6TUxW?=
 =?utf-8?B?UVRDY1dOa1p3dVkveXgrMVMrdlZZTUlIYnZ2cTlkeDR0SDhYTkozSWlJQU1X?=
 =?utf-8?B?SVluM2VLMk9leTJabkVpcE9SZUlMeTAzeHRnSWF2WUljUzQzZXZtWVVGemJj?=
 =?utf-8?B?Y2ppa0lMT1dtU1AwZW1yaGJiKzJLWlRreHpMbnJPdWZ2Mjdsa2o2WVFabTFw?=
 =?utf-8?B?aTVPK0FqOXg3NnBmTUNnb3VlQzFsZ3lNTXR2MXdXT1k5R3FqUk9ncjJ3U2dT?=
 =?utf-8?B?N3Y2Nmp6am9vWEZHUHI1SVdvMDNwYTQ5dEtSamFRNFQ3MUozeE5vUUFUU1pW?=
 =?utf-8?B?UXplUzUwa29lcVBwZmJzaGNJU2NnT3BvZFBPRkhURFNpL0lkdWJab1N3K0Yr?=
 =?utf-8?B?cmlweGQyeDZrN21SbGt2VXA3dEhyQk40VUpIcCtkK2xEalBPZ2ViQm1TR0ls?=
 =?utf-8?B?SjVrbHhlV29BTDZQUGVCUVB5OWsxR3ZVUmRjR3c5YWNyVksxellPcy8vQm44?=
 =?utf-8?B?NFBKbFJvWUhhZVo3VmV2NVBEa2Fqc2FLUkhYQlNNa0QzR0FkUE1GeGFpYmlP?=
 =?utf-8?B?WmloV1VueVI4N2ZzbXRzSDFMR0JiZkdQTUNHellUWDVGTkJLZ1ROb09vTWFs?=
 =?utf-8?B?cEFnWG5KbkVXMldVcHlpRHdjYnRaOWZqVmU1bTc1WG8xUXV6YnAzYnRtTktl?=
 =?utf-8?B?bFJ2a2xrb213VzdzblE2OTc5SERHRXp5TE5ya1RKT1hTYXBHUGJZajBycUM0?=
 =?utf-8?B?OTdESUE1UVMzL1ZiL040NU5wQndqeS92STRWY24wSkFrbE5NWjFpRy9WOVgv?=
 =?utf-8?B?dmZpWEFqWXltN0lpNGFaYnNuU0YyWXVlNEdUVFdSSy8vdFgrS2Jtc3JtbURR?=
 =?utf-8?B?RW1nZjNKbjFJWDZvUW9JYjl5a2NwdS9odkhUd2RDZU45ZVp4ZmtlTi9rM1Z3?=
 =?utf-8?B?bi90Wkx0M2lvNVJGK3ZGYzNBekIzZ3FKTmt0R1U0dTRVVlAvMTM5aWZxRXFP?=
 =?utf-8?B?aHZ3bW9NSDA2Z3hkRWtpV2IzRlpWNTVlVEdFS1M2dmphUVRscGZtU0w4aXV3?=
 =?utf-8?B?Q3Rxa2lRREs0Q2ZaWk1QempVaURJSkJrdHN6UW81UTFPNy8vY1REUlV1cDk3?=
 =?utf-8?B?cXdSeHJXRWxnSURGdlhTbk40VnhRVkFWLzJoN09GSXVtL0wzaXlDTW90dWR1?=
 =?utf-8?B?Q2ZLU2c2R3FSREUyZngyeDM3UUxHNkhLWUNWdGYyNGVDRUhoR3FQWW04cjg4?=
 =?utf-8?B?RG93ZFIwSGlYWVdBS2x0WXBrOVQrd2gyQVBSSWFOcThaZ3kwMGtNZUNucWFO?=
 =?utf-8?B?ZEJVQ251SFRoazhra05XaDZsTHAvSzIvQXBGeHdnd21EYXUzMENvZzg2MFI4?=
 =?utf-8?B?TGt0VzNhNWQvNnI4eUlJSm1FYjZFZlE0ejcvUmlyQ3VPLzgxQ2UxL1ZadXJU?=
 =?utf-8?B?STFxbjd6QW1SL2prZUtHNnFHajRKMkMzQ2hBV1NhYnF1ditQNnNETjNYOE03?=
 =?utf-8?B?YWtWL1REaXlVcjhBM3dNYlArVER0cUJ3RGJEUW5UaEQ2K0NVTitZMWJzNklk?=
 =?utf-8?B?VndqYzlSSktQNEdyNzVHWEd1WUthSkNUQjJMNFVGVmhhRGZ5am9IZlB2alUr?=
 =?utf-8?B?ampINEliOUNoRW56N2tYbGF0YVFoays5UGNEL3ZGK01McUQ1RzV4ajNseG53?=
 =?utf-8?B?SHhoRGJZYTljeG1yazRyaGtqY1BoTXcvMkt6RmFQUHRxbHQ2TjBXL3dxdmRr?=
 =?utf-8?B?Nm1wQi9zZzFZN3VlcVk4aC8yODZsWWJuMEswQUpkRnFQZjQwUzVUV212cytW?=
 =?utf-8?B?VUJnUklualFEZ2lCdUdTKzRLa2R4ZzZWK2FYS0loVDBMSXRaVG5JSERyS2x3?=
 =?utf-8?B?dDZVNkZoNk1mb0RkQzBhdUNjeWppRVNvNVUyeENOdXRxaWJ3WjFiV2x2YzhL?=
 =?utf-8?B?WGlGM3p6V3VkYUw1WlFUUlZrRWx0eFczZU1HZ00zTkF1Q0gxNEdrWlNSeE45?=
 =?utf-8?Q?M48bUTm2VIubZC1jfAvbkXZNZ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3ae85e-f7cf-443b-778c-08dd6d676d08
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 19:41:53.9502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNzDDm0O20EYyf3DVYLBXvVDKZ4lIWSdeJck0k2ez1j3PekjTvH8mlKlnKPqNedJrQwYAcP91AMEZUSf1J/hbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6643
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Mar 2025 19:41:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18383

A new release of isar-cip-core is available.

72 changeset, 13 contributors, 66 files changed, 986 insertions(+), 305 
deletions(-), these are the stats for v1.7. While we had a rather small 
crew on v1.6, this release was plugged together a nicely large group, 
include 4 (if I counted correctly) first-time contributors!

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/v1.7?ref_type=tags

The highlights this time are unified home and var partition (opt-out to 
have separate ones again), several improvements of our automated testing 
to ensure IEC 62443 compliance, faster disk encryption on first boot, 
some hook ordering fixes for the initramfs and once again many version 
updates, including EFI Boot Guard 0.19.

Thanks a lot to all the contributors!

Jan


Adithya Balakumar (4):
      wic: Set partition UUID for reproducibility
      .reproducible-check-ci.yml: Upload wic files for reproducibility test
      scripts/repro-tests.sh: Update script to check wic file reproducibility
      .reproducible-check-ci.yml: Add x86-uefi target for reproducibility test

Alexander Heinisch (3):
      Removed "ro" option from read-only-rootfs's fstab.
      Fix return value handling on filesystem check
      initramfs-crypt-hook: Optimize disk encryption in combination with expansion of last partition

Badrikesh Prusty (2):
      efibootguard: update to 0.19
      linux-cip: Update cip-kernel-config to latest revision

Cedric Hombourger (1):
      swupdate-config: suffix package with -${MACHINE}

Claudius Heine (3):
      initramfs-crypt-hook: fix inconsistent whitespace
      initramfs-crypt-hook: use real device path in luksFormat case
      initramfs-crypt-hook: make sure that mount path exists

Gokhan Cetin (1):
      initramfs-squashfs-hook: drop unused hook file

Jan Kiszka (23):
      initramfs-crypt-hook: Fix ordering with abroofs hook
      ci: Disable currently broken deployment to KernelCI
      ci: Drop redundant deploy_kernelci disabling
      linux-cip: Update to 4.4.302-cip95, 4.19.325-cip116[-rt40], 5.10.233-cip56[-rt24], 6.1.127-cip36[-rt19]
      initramfs-crypt-hook: Add support for btrfs
      initramfs-crypt-hook: Bump revision
      initramfs-overlay-hook: Optimize variable initialization
      initramfs-overlay-hook: Tune the parameter documentation
      initramfs-overlay-hook: Bump revision
      linux-cip: Update to 4.4.302-cip96, 4.19.325-cip117, 5.10.234-cip57, 6.1.128-cip37
      Update isar revision
      linux-cip: Update to 4.4.302-cip96-rt53 and 6.1.128-cip37-rt20
      Revert "Removed "ro" option from read-only-rootfs's fstab."
      Add isar patch to fix riscv64 builds
      swupdate: Avoid generating useless ext4 images in qemu configurations
      initramfs-abrootfs/crypt-hook: Ensure that cryptroot is always last in local-top
      linux-cip: Update to 6.1.129-cip38
      submit_lava: Address shellcheck findings
      linux-cip: Update to 4.19.325-cip118
      Update isar revision
      trixie: Use a working snapshot for now
      Drop unused preferences.bbb.conf
      linux-cip: Update to 4.4.302-cip97, 4.19.325-cip118-rt41, 5.10.234-cip57-rt25, 6.1.131-cip39

Ludwig Nussel (1):
      u-boot-common.inc: fix FILESPATH

Michael Adler (2):
      cip-kernel-config: Update to latest version
      Update kas from 4.5 o 4.7

Nobuhiro Iwamatsu (2):
      recipes-core: ltp: Update to 20250130
      scripts: Add automated recipe updates for LTP

Quirin Gylstorff (16):
      initramfs-overlay: fix missing scriptpreq
      initramfs-crypt-hook: clarify resize error
      swupdate.bbclass: Add check if a swu file is greater than 4GB
      initramfs-crypt-hook: allow to run before mounting all overlays
      read-only-rootfs.bbclass: Exclude boot,home and var from the erofs and squashfs
      .gitlab-ci.yml: Remove unused build jobs
      build x86-uefi with secure boot
      x86-uefi: disable watchdog for testing on mcom
      kas/opt: add new option for security testing
      crypt: remove e2fsck.config option system_broken_clock
      read-only-rootfs: Make IMMUTABLE_DATA_DIR configurable
      read-only-rootfs: add home partition with a variable
      add move-homedir-var package
      Move content of home to IMMUTABLE_DATA_DIR
      Add Kconfig option for separate home partition
      add ci variable for separate home partition

Shivanand Kunijadar (5):
      Set fixed UUID for EROFS
      Add additional test cases for swupdate and secure boot in LAVA
      Update script to generate additional LAVA job defintion
      .gitlab-ci.yml: Update CI to add additional jobs
      .gitlab-ci.yml: Enable security_test option for base images

sai ashrith sathujoda (9):
      README.security-testing.md: Update steps to verify IEC layer on security image
      swupdate_template.yml: Give different names to test actions
      tests/templates: Add template files required to generate M-COM job defintions
      submit_lava.sh: Include functionality to prepare M-COM job defintions
      .gitlab-ci.yml: Enable building v2 x86-uefi target to deploy its swupdate artifact
      .gitlab-ci.yml: Add test targets for M-COM x86
      tests/templates: Reconfigure the usage of -smp options
      .gitlab-ci.yml: Deploy seperate home partition for qemu security targets
      IEC_template.yml: Update IEC tests to latest revision


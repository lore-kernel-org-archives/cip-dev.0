Return-Path: <christoph.steiger@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F9FE7717F
	for <webhook@archiver.kernel.org>; Thu, 12 Dec 2024 11:20:30 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.10])
 by mx.groups.io with SMTP id smtpd.web10.17603.1734002424655877041
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Dec 2024 03:20:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qIW6cqc5;
 spf=pass (domain: siemens.com, ip: 52.101.65.10, mailfrom: christoph.steiger@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFSBvmmDa8dSlBrm82kVaSdVznaiJvpXojWejcJAgDaxMBdILVJKw22udiu0xCc5+BUCkQRHfysWV/AK4Lg6O1kTK2M0vKGB8gyODRusJDD17o32Fna4O4KG6WiOCsRzkhqv5fuv6PccdxcS1b6sc/BHyDvnY/jySK1bXeP5H+qk+o16tX6c6LfFy3b3X6/1O0d5S7Taw5AjQQZscnSohX2TGXaiZz/dt8uGcr2EVAn8oK2I94ijeo5mJi739VA+c497H+7xTIh8FCphg+p2J+kWbxLpRI9C2m8FSEq5IIfcpFdmUEl5Clh+fJriMxG9DmDKYS+Vs6/zlIO53bbixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54jLH9F2cZy5uDlscC1aI37uVQ5n+/HW1RdFOmUcMU8=;
 b=FVpRdCC2kbskLvtA9PEcDro5j8t525c+CzDAQmIJ0Ram+5/KNrQc7yFOZkcvLFFoNKIkA9F5/Ei9LjsBYDv4ZF07vp+VyQZIhf6WltNMZ0cJz3HhAlNP1wfQ12Pi3o5fi3lPEwqmi6PlrwTY+B+kO//PAsE00vSvw2tLCAI2kzcX7t+B0GgMAPl2CJs7JE6wZWtm/WNmM8ZPCymR9/RokmDDB/WsF+qHC8UPNb+ZSEDn/47C86zW6FarqvDhfGYs36qHxEQV092+tkBoksKEcEp4eFyX6Kw4EIx+/KHrHQgOPF/pSi4ykDd5YBb/kytNosCsW7ZGckKNnd+YrqH7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54jLH9F2cZy5uDlscC1aI37uVQ5n+/HW1RdFOmUcMU8=;
 b=qIW6cqc5aJC9YzyKS+HMF5j/IMONwjGOBhw86iZvX2ElvK03AMHUCjoy4PVqmh0U4VRHA+Fr94Vn2PsAG01IxWa6+qIhzk7GWRK8LG17ijDcYQkI7IAStaHXa7BON2PPGALVdbIamHQmPyhij5nbvzcf79NvuAXzy9xCiDquN8Z55VS8Ql8awJeE88a7V/4Aw99o3hVTO7K9CVChvE8Dot975UUgL/j/3Kn5w/UGe1bwhRs7t58qvUgzGTA2GejKBeOIVDLfUDkybFUHo6b/po9nW7AeC+Zw3W5uXiz0cSW+xacpO54khCh2tOjk/3bEO6HG52at3EkuLJGDP1SEsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61c::5)
 by DB4PR10MB6045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:37b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.5; Thu, 12 Dec
 2024 11:20:21 +0000
Received: from AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fb1c:78f4:4286:6306]) by AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fb1c:78f4:4286:6306%3]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 11:20:21 +0000
Message-ID: <176f5e25-b400-4621-a174-f69e292be7ba@siemens.com>
Date: Thu, 12 Dec 2024 12:20:20 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: cip-dev@lists.cip-project.org
From: Christoph Steiger <christoph.steiger@siemens.com>
Subject: [kernel-cve-triage] Weekly Triage Report
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::20) To AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:61c::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB7136:EE_|DB4PR10MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c33578d-197a-4944-a2b7-08dd1a9ef752
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y3RjUUJpcG50aSsvQUFYZEJ5Vnc1VzNpY2dHUERMd29yaTkvNXJpb3dTOUNF?=
 =?utf-8?B?M0gzTHRvRGpWaXFiMDlaZmIrMWo0dXcxY3prRzB5RXlQT2wxaXpGc3NwdDFl?=
 =?utf-8?B?TmtLZWxsTmJyT3lmN09SV2YvU3RldjlyUTdjeDFHblFLWjljSmxMU3VkTkxx?=
 =?utf-8?B?TkRUU284cWMxUlN5S3JDQVQ4REZJQTY5akVmUHg5dDBFN0pQeGo3d1Q4VU1P?=
 =?utf-8?B?blNJa1IxRkhhbENuTmVxRzRPUjFjbUwwa1gyeVUzcGZPL2VveEpqWGF4S3Ix?=
 =?utf-8?B?SHJFR3duTUF6eE44Vmt6czBsWVRoU2tPaVQ3S3NOb1BFeXFIVlZaR1g3THZk?=
 =?utf-8?B?YzNNSzNnLzhTaGdOTVNTQmwrQms5U09jWU5YQi9hckdCb0VibXc3STJzaGFM?=
 =?utf-8?B?TUZhQVJ4T2ZMbXpQWUhIZ1JoZEpqeWZlNHFBb1NsY3NUaThEYTVDanVkVHZo?=
 =?utf-8?B?VnJUZG1FS0FTSjcxa29JamVkc0lwamozQWZRRFFxdGgvWkxnVUUvVXJhVzBX?=
 =?utf-8?B?V2MwNTIzLzN5ZjVlR3VFSzNveS84UEhNQVRkdXUwRm9qbGt1K1lsNi9RdjYx?=
 =?utf-8?B?NUswYUN1UUVDZnA5UzBOd0kvbTFWcjFXV2JhbGZaR3k0VUNuaG1KdkJ5N2tq?=
 =?utf-8?B?UURhMDU3amYxU3JCSUdTMnFwQUxsbTMzdkh6anVTTi9BcXh3ZHVOOVBZY3dv?=
 =?utf-8?B?UkgvOG1waWNTRWJLYmx0WDVpeDBNemFkdHRYNUNBUlpDMnowUUswWUg2YUda?=
 =?utf-8?B?bHBYc0IrS1I4RUM2Zldibnk0VTZwa05ubkltU1k2VUREQTVDTG02YXhBYi9F?=
 =?utf-8?B?WGx6akw3WGpLMW5pRGltM3NubXI0RjhydGxFWExUbUFiYkJ1QWQwMm5BVEFN?=
 =?utf-8?B?WUhrTHlsbFJVeEpnZnVQcmNzOVFHTVB0TE5QYVJZSlVLZFhMcElCMzF3ZHcw?=
 =?utf-8?B?cEhxWkZMREE4eGRxRGNkYUdoMWxFZmYzY25WWHphVkRVTTl4RHpuU3gxalZw?=
 =?utf-8?B?QkFWVHVEYTBUT3JLcGdLbW40akcvSzBjZVA1QXZYUllZSTBWRi9rdFkvWEU1?=
 =?utf-8?B?a2JMMUpaRGIyaFFmUGNTWDk5cjQ1SHIzQUtZRWh0anJMVVdvMGVMUnZoYk84?=
 =?utf-8?B?TG9PMmxiV1ZrNTllaEprSjlDZFdvOTRXL24yTkRDVG9DY1A3UE44SGZOZTdz?=
 =?utf-8?B?K0lHUEtrbWZkS0FvR2JTZ2pid3RVVUFkemtWR3ZKZnd0UVVJYmFtcUNSR3NE?=
 =?utf-8?B?aklLS0EvdDlISndEajJsNVpaTjl2NlpRTExvQThvSzFidGNjQmxGYzlVNkM3?=
 =?utf-8?B?NmgyZWZEbnYwVTZydmhtd0c4STl2VzBwR3p3cnltMlppN1gzelNZbEJTVkZX?=
 =?utf-8?B?ZUErWXpSSUpMY0xEaUx6a1U3VXIrUkxwRm9SRjQ2akZ4R1NORDJ1NU9FaW8y?=
 =?utf-8?B?SDdIMmxiNkFVRFlRVUFhWEhYODdNNHM4Y0lmdVVOQkZqbVBhRWdVb095eEho?=
 =?utf-8?B?TG84VW5FYXk3NmZxTWNUdHNJOVhGVnEraEtNWTd2eXp1Q0JxTWVoenpnMkU1?=
 =?utf-8?B?bFU3Z0I3aDZtOTcwU0ZqNVhyN3R1Vllvd0VSSGxMbi9tWGQ2Z29icUovaUo3?=
 =?utf-8?B?YUgrVzByMTg3T1JkZnNwRXpHRW1MS2U1U3RXa3ArOGFoS0JmV2J0dFU4ODVS?=
 =?utf-8?B?UFh5OC9PQXB0aDg1bTVCVVlaNWJNcGJ1VzNkclE0WUxhSm5STGJ0S3grV3VG?=
 =?utf-8?B?OWRNMXhZK0NMWVFEK01kbVYrdkxlU1RaN2M2cm1HcGNBdEVUbmdjNU1Gc3Bz?=
 =?utf-8?Q?bVBH596J9Q8j+MuO9RGQNUH4lSXqZgEfPYiNM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NHhhS3hWZXE3OFlNMEJCOVM1Q3FIL2J3dVNhNldxR05TeWJyZDJBQ3pOcTU0?=
 =?utf-8?B?Y3BQeDFNRUVnTEJsbEJRVTc0Mm1wclRveEg2NkVIZjJyWi9qRCtlbHhlRUI2?=
 =?utf-8?B?ZTdJaFYzZ3hUWFpCVTRoRlNIL1FCL3V3ZWtYcHE1ZS9RSllTWW1ndHptRmNJ?=
 =?utf-8?B?ZTdVd1dRMmZzMzMwYy9CQlhNbnpFaldyRjVja2RJOWtrY2VheWszWjN1UWtD?=
 =?utf-8?B?amhPSGpDY1RQSWhlS2Q2aXdKUmNCVmJWd3crVjhHOENscENRemErQktjdG9V?=
 =?utf-8?B?dURPS2RKby8rYlR3SGVjd09EYTRTZElPZGcwV1MrcW5vWkdneGVFcmFlVXFL?=
 =?utf-8?B?b2xJTjV2b09TekNRWk5meUg2K1Z1ay9YamtyM00zeXl6U1loM2ZBaWVMTWQw?=
 =?utf-8?B?dzY2bVJmUzBvZ0Q5bHhWelQvbjJlcWxUNUdqK0V6dWVjcENpNlN5WjJMZFps?=
 =?utf-8?B?NVB5YlVLWVJ5YlFFSXV6Y0VtaG5TQXk5azRxTDhpSk12dDU5cUxwb3I2Y20r?=
 =?utf-8?B?dHN2UjArVHNTRGNJdTc5THB0UEpYMVVoMklsQ0FaQWVOL1A3cjF5cWFYc1Jl?=
 =?utf-8?B?andxK3p0dkxtTU5RR3E1TmJ5SjZIY3ZBV3F1clJ0QThubU1QRkpNVXpIM2o2?=
 =?utf-8?B?MERSZ2pVWkJMNkllRUpKWnlianEzMXBGT211ZWVzcWJTOXl3Q2ljYU5XZkpu?=
 =?utf-8?B?NkNQNHFxSkNpUW4vMytTR2ZpYW5IOXBZUXZmUHlGaEo3QnA3SGtuNEYrWEJi?=
 =?utf-8?B?djBPVHhsbXpNQ1l2QlpqQ1pOeFFFL1c4b05IeWFoRjJ0VjMweHB6cm1wTlA2?=
 =?utf-8?B?dThnSXNqU1N4TS9KaWtKaFNRRHVYYVlTaXNwSDZrZjdBc2IrQmtxdWpwNXBt?=
 =?utf-8?B?T0t5eGVtbGlBd1Z6elVUSlR0VWY0bzNLSlBzNWU2ekxETi9CSTAweXFVTHdM?=
 =?utf-8?B?UmNyTER0enhGL1lYRVZUV0twZHZxOG0xZnhGZE5nS05VVCtRMU5PM1dPVHVy?=
 =?utf-8?B?VmhDd3JLT29wZWNsa0ZpVEdjaitpNDcvZS9FSjBpeTNDVFFObDFEZUt4bkdq?=
 =?utf-8?B?YVkzUVh6NTlMcG1lU3RiOTZObnQ5VkpSdHVLWFlDd1ZUZjBWcFg5ZUEzSGdu?=
 =?utf-8?B?SGFBNFZnSkNxNEs3KzlLTlNjUTYyaXdxRG1CdXNUV0NMRWIvUmpJeGwvR2lP?=
 =?utf-8?B?bHVrUXh5QTI4UzNSUC8yelpqeVJpZDZVcHBmUCtPZWwrM2dDeHJxM3c2dVdy?=
 =?utf-8?B?R1lUODk3bU9xaDRmRGl0eE45UE9kaEk4QVcxcGZrdWxnRWZHTUNUSnBZT0Iw?=
 =?utf-8?B?ZlBFb3JJTUxXV3lmVXE3Wmc5RDZhMlhkMlNMcVBYNnFOVngvaDV5bFJlWTZ2?=
 =?utf-8?B?YnBNQzdoVHJTR1NaOUtRenpDY0xDczMyd1UyUjJua1UvL1l0bVJ4NHpkZi9t?=
 =?utf-8?B?Nlp3T1NkeWkvL1ZMZnIrWGVJS3pDOUlBaHdiWEM0L0szNzdCYzdZOEo3SWNp?=
 =?utf-8?B?aHpHUnpNWEg4cGFGdnBDWDR0UzE2M2kvNExtUUJSNWNFTVNzVzFjanlKSitQ?=
 =?utf-8?B?TjRKYlFuQ2YwYkFUbHRYMGFYbHFlVm55ekNUeVJDaVRveS9xbllNQkRvb1pu?=
 =?utf-8?B?MEJSUXRwOWZiRWNWRGtydm1NY2VPVFV1eVc4QjJZUEgwcEswSGh3aWpjL3d5?=
 =?utf-8?B?NGhwcUkwRG04cUp1UEhoMTVDUnVGaUdDd1dsRGNUU1RuZDhmRkxzcWtERGRq?=
 =?utf-8?B?RCtROTlEMVg1OVhwOGpZNEc3aktPNkpWckVjSkc2NlJuVHgvblZXSWxzQ0xB?=
 =?utf-8?B?V0lKNFVHZHN6eVFwUDRzeGhUakRzbGhEb2pCeE5wbitHNDArQllxb043eDd2?=
 =?utf-8?B?WEFHQmJ1ajk3RUZ2TEdqbHBVd3RtcC9Hb0hpc0dyQWRMVEhwK0plN0dkRUFB?=
 =?utf-8?B?MVJTTndsS2t0WFhITHNWUTREU3lhYVk0amR1ZG9uUTlRZnl2cytxRWM4U0J4?=
 =?utf-8?B?a2tVY1NodE9ZcGFiZ2trMHVVUXJIVk84emdjdm5oWkRtM085MDdPRy9hQWVQ?=
 =?utf-8?B?VHhOWk1nVTlOc3IrWit5U0xVQ3BNVEpsS2tKNHlzWWhkNTN0Q0JpT01yUmpl?=
 =?utf-8?B?alhuTUFIdDlTQlVZYzVYeis0NXFVU0lVRFpyak5HMko4Y0VzUXU5UUVOVEc4?=
 =?utf-8?Q?bzLqCD7nxrrCJ+aRCz36W/o=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c33578d-197a-4944-a2b7-08dd1a9ef752
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 11:20:21.4294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: az/odDLYraNtWFWXjYyTDa6N9aWXm+hqmHQ739w2pr66WLhQAtgMgKcRR7/DXEscXDC6vGSf3i2JtJv0FB1sdV/1zIH0SotCjVXg8KjohaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6045
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Dec 2024 11:20:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17414

Hi everyone!

Here are the weekly CVE triage results.
There were 480 new or updated CVEs. 116 out of 480 CVEs need further 
manual review:

CVE-2021-47469: spi: Fix deadlock when adding SPI controllers on SPI buses
affected versions: v4.4.302-cip94 v4.19.324-cip115

CVE-2022-24448: An issue was discovered in fs/nfs/dir.c in the Linux 
kernel before 5.16.5.
If an application sets the O_DIRECTORY flag, and tries to open a regular
file, nfs_atomic_open() performs a regular lookup. If a regular file is
found, ENOTDIR should occur, but the server instead returns uninitialized
data in the file descriptor.
affected versions: v4.4.302-cip94

CVE-2022-48733: btrfs: fix use-after-free after failure to create a snapshot
affected versions: v4.19.324-cip115

CVE-2022-48893: drm/i915/gt: Cleanup partial engine discovery failures
affected versions: v5.10.230-cip55

CVE-2022-48901: btrfs: do not start relocation until in progress drops 
are done
affected versions: v4.19.324-cip115 v5.10.230-cip55

CVE-2022-48943: KVM: x86/mmu: make apf token non-zero to fix bug
affected versions: v4.4.302-cip94 v4.19.324-cip115

CVE-2023-52531: wifi: iwlwifi: mvm: Fix a memory corruption issue
affected versions: v4.4.302-cip94

CVE-2023-52614: PM / devfreq: Fix buffer overflow in trans_stat_show
affected versions: v4.4.302-cip94 v4.19.324-cip115

CVE-2023-52920: bpf: support non-r10 register spill/fill to/from stack 
in precision tracking
affected versions: v4.4.302-cip94 v4.19.324-cip115 v5.10.230-cip55 
v6.1.119-cip33

CVE-2024-26661: drm/amd/display: Add NULL test for 'timing generator' in 
'dcn21_set_pipe()'
affected versions: v5.10.230-cip55 v6.1.119-cip33

CVE-2024-26668: netfilter: nft_limit: reject configurations that cause 
integer overflow
affected versions: v4.19.324-cip115 v5.10.230-cip55

CVE-2024-26669: net/sched: flower: Fix chain template offload
affected versions: v5.10.230-cip55 v6.1.119-cip33

CVE-2024-26686: fs/proc: do_task_stat: use sig->stats_lock to gather the 
threads/children stats
affected versions: v4.4.302-cip94 v4.19.324-cip115 v5.10.230-cip55

CVE-2024-26929: scsi: qla2xxx: Fix double free of fcport
affected versions: v4.19.324-cip115

CVE-2024-36478: null_blk: fix null-ptr-dereference while configuring 
'power' and 'submit_queues'
affected versions: v5.10.230-cip55

CVE-2024-36915: nfc: llcp: fix nfc_llcp_setsockopt() unsafe copies
affected versions: v5.10.230-cip55

CVE-2024-36923: fs/9p: fix uninitialized values during inode evict
affected versions: v4.4.302-cip94 v4.19.324-cip115 v5.10.230-cip55

CVE-2024-38538: net: bridge: xmit: make sure we have at least eth header 
len bytes
affected versions: v4.4.302-cip94

CVE-2024-39472: xfs: fix log recovery buffer allocation for the legacy 
h_size fixup
affected versions: v5.10.230-cip55

CVE-2024-40915: riscv: rewrite __kernel_map_pages() to fix sleeping in 
invalid context
affected versions: v5.10.230-cip55

CVE-2024-41014: xfs: add bounds checking to xlog_recover_process_data
affected versions: v4.4.302-cip94 v4.19.324-cip115 v5.10.230-cip55 
v6.1.119-cip33

CVE-2024-41042: netfilter: nf_tables: prefer nft_chain_validate
affected versions: v4.4.302-cip94 v5.10.230-cip55

CVE-2024-41071: wifi: mac80211: Avoid address calculations via out of 
bounds array indexing
affected versions: v4.4.302-cip94 v4.19.324-cip115 v5.10.230-cip55

CVE-2024-41073: nvme: avoid double free special payload
affected versions: v4.19.324-cip115 v5.10.230-cip55

CVE-2024-41077: null_blk: fix validation of block size
affected versions: v4.19.324-cip115

CVE-2024-41078: btrfs: qgroup: fix quota root leak after quota disable 
failure
affected versions: v4.19.324-cip115

CVE-2024-41081: ila: block BH in ila_output()
affected versions: v4.4.302-cip94

CVE-2024-41098: ata: libata-core: Fix null pointer dereference on error
affected versions: v4.4.302-cip94

CVE-2024-42114: wifi: cfg80211: restrict NL80211_ATTR_TXQ_QUANTUM values
affected versions: v4.19.324-cip115

CVE-2024-42122: drm/amd/display: Add NULL pointer check for kzalloc
affected versions: v4.4.302-cip94 v4.19.324-cip115 v5.10.230-cip55 
v6.1.119-cip33

CVE-2024-42244: USB: serial: mos7840: fix crash on resume
affected versions: v4.4.302-cip94 v4.19.324-cip115

CVE-2024-42252: closures: Change BUG_ON() to WARN_ON()
affected versions: v4.4.302-cip94 v4.19.324-cip115 v5.10.230-cip55 
v6.1.119-cip33

CVE-2024-42267: riscv/mm: Add handling for VM_FAULT_SIGSEGV in 
mm_fault_error()
affected versions: v4.19.324-cip115

CVE-2024-42281: bpf: Fix a segment issue when downgrading gso_size
affected versions: v4.19.324-cip115

CVE-2024-42301: dev/parport: fix the array out-of-bounds risk
affected versions: v4.4.302-cip94

CVE-2024-42306: udf: Avoid using corrupted block bitmap buffer
affected versions: v4.4.302-cip94 v4.19.324-cip115

CVE-2024-42312: sysctl: always initialize i_uid/i_gid
affected versions: v4.19.324-cip115

CVE-2024-42322: ipvs: properly dereference pe in ip_vs_add_service
affected versions: v4.19.324-cip115 v5.10.230-cip55

CVE-2024-43817: net: missing check virtio
affected versions: v4.19.324-cip115 v5.10.230-cip55

CVE-2024-43856: dma: fix call order in dmam_free_coherent
affected versions: v4.4.302-cip94

CVE-2024-43892: memcg: protect concurrent access to mem_cgroup_idr
affected versions: v4.4.302-cip94 v4.19.324-cip115

CVE-2024-43902: drm/amd/display: Add null checker before passing variables
affected versions: v5.10.230-cip55

CVE-2024-43905: drm/amd/pm: Fix the null pointer dereference for 
vega10_hwmgr
affected versions: v4.19.324-cip115

CVE-2024-43907: drm/amdgpu/pm: Fix the null pointer dereference in 
apply_state_adjust_rules
affected versions: v4.19.324-cip115

CVE-2024-43909: drm/amdgpu/pm: Fix the null pointer dereference for smu7
affected versions: v4.19.324-cip115 v5.10.230-cip55

CVE-2024-44939: jfs: fix null ptr deref in dtInsertEntry
affected versions: v4.4.302-cip94 v4.19.324-cip115 v5.10.230-cip55

CVE-2024-44942: f2fs: fix to do sanity check on F2FS_INLINE_DATA flag in 
inode during GC
affected versions: v4.4.302-cip94 v4.19.324-cip115 v5.10.230-cip55 
v6.1.119-cip33

CVE-2024-44958: sched/smt: Fix unbalance sched_smt_present dec/inc
affected versions: v4.19.324-cip115 v5.10.230-cip55

CVE-2024-44960: usb: gadget: core: Check for unset descriptor
affected versions: v4.4.302-cip94

CVE-2024-44963: btrfs: do not BUG_ON() when freeing tree block after error
affected versions: v4.4.302-cip94 v4.19.324-cip115 v5.10.230-cip55 
v6.1.119-cip33

CVE-2024-44982: drm/msm/dpu: cleanup FB if dpu_format_populate_layout fails
affected versions: v4.19.324-cip115 v5.10.230-cip55

CVE-2024-44986: ipv6: fix possible UAF in ip6_finish_output2()
affected versions: v5.10.230-cip55

CVE-2024-45003: vfs: Don't evict inode under the inode lru traversing 
context
affected versions: v4.19.324-cip115

CVE-2024-45025: fix bitmap corruption on close_range() with 
CLOSE_RANGE_UNSHARE
affected versions: v4.4.302-cip94

CVE-2024-46675: usb: dwc3: core: Prevent USB core invalid event buffer 
address access
affected versions: v4.4.302-cip94

CVE-2024-46676: nfc: pn533: Add poll mod list filling check
affected versions: v4.4.302-cip94

CVE-2024-46679: ethtool: check device is present when getting link settings
affected versions: v4.4.302-cip94 v4.19.324-cip115

CVE-2024-46702: thunderbolt: Mark XDomain as unplugged when router is 
removed
affected versions: v4.19.324-cip115

CVE-2024-46707: KVM: arm64: Make ICC_*SGI*_EL1 undef in the absence of a 
vGICv3
affected versions: v4.4.302-cip94 v4.19.324-cip115

CVE-2024-46713: perf/aux: Fix AUX buffer serialization
affected versions: v4.4.302-cip94 v4.19.324-cip115

CVE-2024-46731: drm/amd/pm: fix the Out-of-bounds read warning
affected versions: v4.19.324-cip115

CVE-2024-46732: drm/amd/display: Assign linear_pitch_alignment even for VM
affected versions: v5.10.230-cip55

CVE-2024-46742: smb/server: fix potential null-ptr-deref of 
lease_ctx_info in smb2_open()
affected versions: v6.1.119-cip33

CVE-2024-46745: Input: uinput - reject requests with unreasonable number 
of slots
affected versions: v4.4.302-cip94

CVE-2024-46752: btrfs: replace BUG_ON() with error handling at 
update_ref_for_cow()
affected versions: v4.4.302-cip94 v4.19.324-cip115 v5.10.230-cip55

CVE-2024-46763: fou: Fix null-ptr-deref in GRO.
affected versions: v4.19.324-cip115

CVE-2024-46783: tcp_bpf: fix return value of tcp_bpf_sendmsg()
affected versions: v4.19.324-cip115

CVE-2024-46818: drm/amd/display: Check gpio_id before used as array index
affected versions: v4.19.324-cip115

CVE-2024-46822: arm64: acpi: Harden get_cpu_for_acpi_id() against 
missing CPU entry
affected versions: v4.19.324-cip115

CVE-2024-46841: btrfs: don't BUG_ON on ENOMEM from 
btrfs_lookup_extent_info() in walk_down_proc()
affected versions: v4.19.324-cip115 v5.10.230-cip55 v6.1.119-cip33

CVE-2024-47660: fsnotify: clear PARENT_WATCHED flags lazily
affected versions: v4.4.302-cip94 v4.19.324-cip115

CVE-2024-47667: PCI: keystone: Add workaround for Errata #i2037 (AM65x 
SR 1.0)
affected versions: v4.4.302-cip94 v4.19.324-cip115

CVE-2024-47668: lib/generic-radix-tree.c: Fix rare race in 
__genradix_ptr_alloc()
affected versions: v4.4.302-cip94 v4.19.324-cip115

CVE-2024-47672: wifi: iwlwifi: mvm: don't wait for tx queues if firmware 
is dead
affected versions: v4.4.302-cip94

CVE-2024-47713: wifi: mac80211: use two-phase skb reclamation in 
ieee80211_do_stop()
affected versions: v4.4.302-cip94

CVE-2024-47742: firmware_loader: Block path traversal
affected versions: v4.4.302-cip94

CVE-2024-49891: scsi: lpfc: Validate hdwq pointers before dereferencing 
in reset/errata paths
affected versions: v4.4.302-cip94 v4.19.324-cip115 v5.10.230-cip55 
v6.1.119-cip33

CVE-2024-49896: drm/amd/display: Check stream before comparing them
affected versions: v4.4.302-cip94

CVE-2024-49897: drm/amd/display: Check phantom_stream before it is used
affected versions: v6.1.119-cip33

CVE-2024-49898: drm/amd/display: Check null-initialized variables
affected versions: v6.1.119-cip33

CVE-2024-49899: drm/amd/display: Initialize denominators' default to 1
affected versions: v4.19.324-cip115 v5.10.230-cip55 v6.1.119-cip33

CVE-2024-49906: drm/amd/display: Check null pointer before try to access it
affected versions: v4.4.302-cip94 v4.19.324-cip115 v5.10.230-cip55 
v6.1.119-cip33

CVE-2024-49909: drm/amd/display: Add NULL check for function pointer in 
dcn32_set_output_transfer_func
affected versions: v6.1.119-cip33

CVE-2024-49911: drm/amd/display: Add NULL check for function pointer in 
dcn20_set_output_transfer_func
affected versions: v5.10.230-cip55 v6.1.119-cip33

CVE-2024-49914: drm/amd/display: Add null check for 
pipe_ctx->plane_state in dcn20_program_pipe
affected versions: v5.10.230-cip55 v6.1.119-cip33

CVE-2024-49915: drm/amd/display: Add NULL check for clk_mgr in dcn32_init_hw
affected versions: v6.1.119-cip33

CVE-2024-49917: drm/amd/display: Add NULL check for clk_mgr and 
clk_mgr->funcs in dcn30_init_hw
affected versions: v5.10.230-cip55 v6.1.119-cip33

CVE-2024-49928: wifi: rtw89: avoid reading out of bounds when loading TX 
power FW elements
affected versions: v6.1.119-cip33

CVE-2024-49934: fs/inode: Prevent dump_mapping() accessing invalid 
dentry.d_name.name
affected versions: v6.1.119-cip33

CVE-2024-49938: wifi: ath9k_htc: Use __skb_set_length() for resetting 
urb before resubmit
affected versions: v4.4.302-cip94

CVE-2024-49939: wifi: rtw89: avoid to add interface to list twice when SER
affected versions: v6.1.119-cip33

CVE-2024-49974: NFSD: Limit the number of concurrent async COPY operations
affected versions: v4.4.302-cip94 v4.19.324-cip115 v5.10.230-cip55

CVE-2024-49988: ksmbd: add refcnt to ksmbd_conn struct
affected versions: v6.1.119-cip33

CVE-2024-50036: net: do not delay dst_entries_add() in dst_release()
affected versions: v4.4.302-cip94 v4.19.324-cip115

CVE-2024-50143: udf: fix uninit-value use in udf_get_fileshortad
affected versions: v5.10.230-cip55

CVE-2024-50210: posix-clock: posix-clock: Fix unbalanced locking in 
pc_clock_settime()
affected versions: v4.19.324-cip115 v5.10.230-cip55 v6.1.119-cip33

CVE-2024-50228: mm: shmem: fix data-race in shmem_getattr()
affected versions: v4.4.302-cip94

CVE-2024-50229: nilfs2: fix potential deadlock with newly created symlinks
affected versions: v4.4.302-cip94

CVE-2024-50246: fs/ntfs3: Add rough attr alloc_size check
affected versions: v6.1.119-cip33

CVE-2024-50248: ntfs3: Add bounds checking to mi_enum_attr()
affected versions: v6.1.119-cip33

CVE-2024-50285: ksmbd: check outstanding simultaneous SMB operations
affected versions: v6.1.119-cip33

CVE-2024-53063: media: dvbdev: prevent the risk of out of memory access
affected versions: v4.4.302-cip94

CVE-2024-53085: tpm: Lock TPM chip in tpm_pm_suspend() first
affected versions: v6.1.119-cip33

CVE-2024-53096: mm: resolve faulty mmap_region() error path behaviour
affected versions: v5.10.230-cip55

CVE-2024-53119: virtio/vsock: Fix accept_queue memory leak
affected versions: v5.10.230-cip55

CVE-2024-53122: mptcp: cope racing subflow creation in 
mptcp_rcv_space_adjust
affected versions: v5.10.230-cip55

CVE-2024-53125: bpf: sync_linked_regs() must preserve subreg_def
affected versions: v5.10.230-cip55 v6.1.119-cip33

CVE-2024-53128: sched/task_stack: fix object_is_on_stack() for KASAN 
tagged pointers
affected versions: v5.10.230-cip55 v6.1.119-cip33

CVE-2024-53130: nilfs2: fix null-ptr-deref in block_dirty_buffer tracepoint
affected versions: v4.4.302-cip94 v4.19.324-cip115 v5.10.230-cip55

CVE-2024-53131: nilfs2: fix null-ptr-deref in block_touch_buffer tracepoint
affected versions: v4.4.302-cip94 v4.19.324-cip115 v5.10.230-cip55

CVE-2024-53133: drm/amd/display: Handle dml allocation failure to avoid 
crash
affected versions: v4.4.302-cip94 v4.19.324-cip115 v5.10.230-cip55 
v6.1.119-cip33

CVE-2024-53135: KVM: VMX: Bury Intel PT virtualization (guest/host mode) 
behind CONFIG_BROKEN
affected versions: v5.10.230-cip55

CVE-2024-53136: mm: revert "mm: shmem: fix data-race in shmem_getattr()"
affected versions: v4.19.324-cip115 v5.10.230-cip55

CVE-2024-53140: netlink: terminate outstanding dump on socket close
affected versions: v4.4.302-cip94 v4.19.324-cip115 v5.10.230-cip55

CVE-2024-53141: netfilter: ipset: add missing range check in bitmap_ip_uadt
affected versions: v4.19.324-cip115 v5.10.230-cip55 v6.1.119-cip33

CVE-2024-53142: initramfs: avoid filename buffer overrun
affected versions: v4.4.302-cip94 v4.19.324-cip115 v5.10.230-cip55 
v6.1.119-cip33


You can also view the reports here [1] for more information.

[1] 
https://gitlab.com/cip-project/cip-kernel/kernel-cve-triage/-/jobs/8621150254/artifacts/browse

Kind regards
-- 
Christoph Steiger
Siemens AG, Foundational Technologies
Linux Expert Center



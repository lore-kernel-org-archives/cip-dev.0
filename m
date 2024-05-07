Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB25C10F1A
	for <webhook@archiver.kernel.org>; Tue,  7 May 2024 07:00:03 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.44])
 by mx.groups.io with SMTP id smtpd.web10.5575.1715065190862822093
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 May 2024 23:59:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dBAXWYo7;
 spf=pass (domain: siemens.com, ip: 40.107.14.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3QzTvP+3xc5XACfHUsHybJNHol3AmXeUvtDN+fkO3jZQ9K9s01lHUQe4iaEWYnbligoDnqA5MoFRMflbkVeuSDaytBHsRb1LPILzddrvE19U0QTjkrmnf4WK7fnuGuO5IA7Q6Hly/ypgSgcLMxRziyxANNCRjN19erSrpSL5IxvzWdVesHUUltFA0uMQiLANFo9XQ0z6tsIN5bj9FODwoqjCQeSZKHgB1DWz4u5aWPbKlftw7+M9L995hdJU4B/82YzXNissOrzob0KlVJUue8zHJ6059t806dXIkcEypXA7CeiMofPoXBwj0YqI043kiHx+K9lUJMspugDqx7Uyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsySsQPmxLcGfrHn5HGsqRqMVgbRnRQnAa4mrzGgNSI=;
 b=Osl1ISXIUD8eGCtb8fFcludf+hZOhcOghUK+VMZ8Onr511IrGRzyBBH4j3PGJ006qw4cHoEyZBnKMpxSjAvFIEyxKKmr9iCQSzIO9O4TzyuRS03idgz4o29p3fA24fj7xALzKPah9Dk9XW+Cmz+Ks/Z4CUSdBYVVfEOcMT7hrcWilUESSjPGhk3C+JdkRVNEq0ZOELL2fVq8toK7hipNCx3unJ2AuFv8RxcvANppKZuCmpPsnGBLadgvE1XpT0mu62Hly3y6Cevo6QDmPYVxGvreJe6iAs5bY60lczMV/C3JMRASnAew8pn6082RsrDrKowW4oFFkLSIrWKDpuLrOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsySsQPmxLcGfrHn5HGsqRqMVgbRnRQnAa4mrzGgNSI=;
 b=dBAXWYo73drW4sQcGI0PyvEuuJ2UcMLdU2ZFr2bpRNvwInvklc0YjrcH2X+uVc45nBTrcvrXuE3M+VOpxNcjRBmjDWAYzgf+voJDkMRMZmyuQQ8GOcXhatXiUAC2pScWjA7L0Xpk2j1rWWikUpxAUh9jwGhDfdN5OYEUNUUoeAXpcQSzi1Vv5cn3H4Q1Mrvx5iSEht+6Tekp/i1R6vca4KXpkWJ+4nYkTBFYa0eOplb721B2j7zARqXJSnMy2nm1iiB8CV9Xbnldc5n4T4QhjSNR1nPmxKdNcsT/yNmRzGM1M2NKhGgNnscAlpVP4UD7Wc/n+BOTkH6s3xO2QYl1mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3761.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:175::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 06:59:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 06:59:47 +0000
Message-ID: <e0209629-9d0b-4721-993c-b7f0a52079a8@siemens.com>
Date: Tue, 7 May 2024 08:59:44 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: Heading for isar-cip-core 1.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3761:EE_
X-MS-Office365-Filtering-Correlation-Id: 905869de-6e98-4dc0-c26e-08dc6e634889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WUQ4RTYzZDl1bmlDNXVnYW5HcWxMWWp5d0MxRWpvNndKeXBUVzk5WGF4bEZi?=
 =?utf-8?B?QUg0Q0ZrYjdVMk9td0FPQlorM1BqNmc1bHRtTlZ6dm1PVDNqRzUrV3N0UzJi?=
 =?utf-8?B?bDNrUzJXdU5xRittcno3UXJTb25SVURjZUxXNndnUk0ycFdlbGpLallXTEdG?=
 =?utf-8?B?Qk1qUGZsL0VmVkhITXYrOTNyR3E2a09jRDd6aFVkaEJXNGpMcDBabzErQTZK?=
 =?utf-8?B?Q1dlWHJSOE9pU3ZYT0Rra241Q2tLSjZ4T3ZyVjJUeTdKay9NU0YyYnE2QnFP?=
 =?utf-8?B?MFJNdGh2cEdRM2M3UkpsL2JKK0x4bDlWZEN0MHkzeHFXYkZtUFNRd1MyYTdS?=
 =?utf-8?B?ZUYxY0NpQ1RhVnlKS05wdEF1NDN4OFVmazdHc3JJYk5lWVpuYXFnMXNoczRq?=
 =?utf-8?B?WVB3WGM2ZUhEdll2MU5RSFdPcDU4Wm5ubjBYaFp2d0hQRnVKSVhwcnZ4Q01R?=
 =?utf-8?B?ekMrM3dQL2p2bzFaK0RMR1lBbWpSSC9mZ29uYVE2UlZoazRrRUczK3lrMWZz?=
 =?utf-8?B?VEcwMk5JbDdLS1FsalB3amlnc0hsSlRQREdqOWFSc2s5Q3pnZkFuTVo0UnVC?=
 =?utf-8?B?QXk1MVpZRGtnWFZvU1BPblNNUURqVFZxTHVBcitJOWp2U1E4cU1hODFTbWg4?=
 =?utf-8?B?cTFTQnFRMDFta3haMC9ZNWd5ZDJLaFFhRmhsRnoxNEhIT2gvS2NsZVZYRldN?=
 =?utf-8?B?WXJYdFlCb3RGYS91VktmNUNRdnNzUU85UHBsVzkyQTVja2V6cEpjVCtUUXdC?=
 =?utf-8?B?Ri9Id2M2UjBWdXZTd29iQS9yYmdXc1BDR1ZRQjVMVndXRE5LZlgvY1ErcGRo?=
 =?utf-8?B?THFSMWlhZ0RTWWN5SnovVjUycWtIWTRyZW1ZbGk1QVlYQWYvVW5lSldtaWMv?=
 =?utf-8?B?WEtONndSQkkxWm1STG45RDQxS1dmNTRYL0NwSjZhTVFDQ2pueUFQYVdZV09U?=
 =?utf-8?B?N3Rob3A3a2ZBMURrYkJBQ0VWWGR3cGxPcW84ZlBNSTlrTi9oU2FnT3dOOGhr?=
 =?utf-8?B?MlU2bEZEdlJFT09IbldKdzNNNDNHbUZteDNPMmRwMjJsNS84VEl0N2YzTGFu?=
 =?utf-8?B?QWN0bHdQVWl4dDVhZkhUUDBCWFR6dExzVHRlTEhVV09OUThJaFFwZ3FsRVVT?=
 =?utf-8?B?cXdWMGZCQkU2bjdqK3pmM3NPb3dlSnZoaER4SzUrYVNqVjJ5VkhHV2hTL0NL?=
 =?utf-8?B?U3dvYWF4KzRaQXFCM0R6d2hCS0Jxb3JNLzJJNXZyWlhXdnJqZk1BYlRzM0xa?=
 =?utf-8?B?NE5aWUhMY1dTWGE1Slo1QUk0Q1lrbXhGYnB2NDlqdDRaa29waXRlMVJGcVVq?=
 =?utf-8?B?U2s0WEduaVJwT2NTanNJV1RySFltRXc4c0NadFhHejZmbFoxN2dJU001bEpw?=
 =?utf-8?B?UC9BVUhvK3FoNkI4T0svZndtSDJ0VStxUmQ5WEtIejUyeDE5d2E2TVF1QUg0?=
 =?utf-8?B?bDduRVF6MGZUNzBFVDlqOGoxVjNWaVI0YStXSitFaDRzUkdyZXZoK1lNbDda?=
 =?utf-8?B?N3VoR2ZJSVNyUlJjM01ZOVJnbHJvb3ZkVXFtZFFpNjd1c0NlZUJxMWFnNTZt?=
 =?utf-8?B?ZDg4enluTk1sNTFCcmtFWlZpWktWaENUMG1MU2NqRG5Sd1ZEaFozV3Jnb2JB?=
 =?utf-8?B?S3FIV0xDMTA4aXJYVkdCY1BwSDh5ay95dTYrZ0xnVTA4ekxZUGRMRXIrZ092?=
 =?utf-8?B?M2ZRcmlENWtydnJJekdZdFlNT1Y1TlFKMzd5cFo2MFgweUhuNnEvbWNBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NUxYVllUOTM3S3ZBL2pPd1VVb013RXhEa09XNWRseW9FaDlYdW8ybGdBNit4?=
 =?utf-8?B?VXdpY0ROOGhrMWVlL2pBVjY3NUxCS3lRY01UMGsvbzJ6b1l1MFNwWU9od1M4?=
 =?utf-8?B?cFJHelhneDJCN01VdDV6TDJac0V5dWQ1RFFxci9ENWp5Y1U1b2Y5TkVkMmxa?=
 =?utf-8?B?R0pWSlZ0VWFqUVFXODk3S1RCWmQyVGtEVmx3WEFkZlRtQ21FanJNK29HZ2dP?=
 =?utf-8?B?NmtleFlrUmpZU29mWjdSMHY1SVh0SXJnTHVhSmZ1UUZPUkJoUjVCaEdVWk54?=
 =?utf-8?B?TXp5UVBaZTJVR0g0UVY0dG9YTzNTNWx2aThHTHEzcXloU2x5U2thYUJycGhU?=
 =?utf-8?B?QmREUk04V0F5UEVpTVdoNFZwc1pid1VrazdlTUgvRzdHVG9iL09uZjBIbTBD?=
 =?utf-8?B?Qnl1VkVpeXVnTFlOU1Q2S01NYTIxSkVPaXRhSHl5L3JreGo0dVlsdGpPSUFD?=
 =?utf-8?B?RGpCKzhOMDFVNklXcU52Z05KS2hFaTREbGRqRzAzUG94bk5LQ3VhZGZiUlBk?=
 =?utf-8?B?bjI4STF2dWhmWkkyUHVURVk5NFJJa2JyWUNkT1ZwUHhlT09OZE1UZXlXSG16?=
 =?utf-8?B?ZjVoMm5xYkNUUWl4cnFUeEZWQ3IxZ0Z0eXF2ZWd1WTZBZXBUNXlLU1pVSCtl?=
 =?utf-8?B?Y2JleVhNaWlnNHAxMzFUMUFQUXZCa0t1dXI5K2dxTm1kbFY4MFNubThNcTJm?=
 =?utf-8?B?b2lMb1lsa013cTkxbGVoSWxGeUNMM0NVTjRWZ3NkMk8rVmxnSkEyWTN3c2Vk?=
 =?utf-8?B?RjBheDExZmVNME5zaVhlNCtmMEZOZFd1SG1SbWxZMUIvN3lwWFludXBmSVNp?=
 =?utf-8?B?MWEvY1FaRjk4Yyt0blB2ekJ3bFc3dWJ3K2NhRWd3bFk2QkZqMFd6Z2xldUJJ?=
 =?utf-8?B?c25hUHlHaitKakVucVkxM080S1RTdHk5YTRXTFdzMDRZdk5EeS9vUFgvcUxP?=
 =?utf-8?B?MjRHekMycnJuZjZadWs5OS9wWFQvL0s2QjdPYi9udEg3SWVVaUxJajlycTZE?=
 =?utf-8?B?NzBkdFpJR2ZBTXB5NzY3cHptMzY0TERTMy9lYkc1SjhWTVd3REpEOFpobDl1?=
 =?utf-8?B?bXBQWmwwVHBGK1VoS296YTJhMllKUW5OUUlPaXRsUnduUHJXeEJOeU1zUWtv?=
 =?utf-8?B?RGk2N3ZkUjNpVThHTm1TVXlpVFFhT29Sa2JyZEoxM0tUQnREYlhFbXdranBt?=
 =?utf-8?B?emZmT1Rrc2RvSlFGZVN4WjIydXNYU3ZSMVFCczdTVGxlTVNmVkRTVWJBQzgr?=
 =?utf-8?B?aHVicEdZM1hhUW9sbzk3UWxrQkpNaUQvOFNBaXB3R0Z4Y1I5VDhQYXJscWQ4?=
 =?utf-8?B?NVRMcDlVb0VqMkp4cVlPUDFkcm16aHNSTVNzNmtLSzNHMDVFamF3Um83aXBa?=
 =?utf-8?B?bWliNU1NK25EZ1NGWVJrZm5JTEhhOUlqcmFzbnJFb3NDSy84NmhTb2xjMFA2?=
 =?utf-8?B?SDBlRWZoSHUyVWNLWFBqczZEdEVDZTJzODNaVVFkQ3puNXdkU0p1QnlwWmFL?=
 =?utf-8?B?ejRlT3VxZ2VvOHp4OEwwZ2JNajJNTkd4UTZyMEI4akIwTk1ZcVE3UXI0YUIv?=
 =?utf-8?B?dEJFaFhBaEZ0ZEQ4U2p2eHJucHdiV1NKMVZPWDZ5dG5welNLRnc2ak5MK3c0?=
 =?utf-8?B?K000cm9uWEpCV05DR1V4QmFtdm84NVFBMGVCT0N2emw0YVZWZmZMS05pR2Rl?=
 =?utf-8?B?VStXUUhleDhqbDNzd3dIdjhhZTIreHh0dzFFTEFWZktvaWxvMFRZeThGbjNq?=
 =?utf-8?B?eTVMNnMvVzk2dEFXUlR6SmhESzVsUi9YZmVSNWZzcGluS3JrdUhWY2NWWGpS?=
 =?utf-8?B?cERkaDl2Y09uYmdOd0hteTlDRG9HcEpWRU5qckZHTXB3Qm9lYTZuQVdiUUlY?=
 =?utf-8?B?VG5KcFphRFYxY2RYcVpFSjduSTRobXdiRVBnOHlmeFdJNXoyaWsrTEwyUDQ4?=
 =?utf-8?B?RGV6cTc5cVdJYzd1Uk50YjFYeDNkbGlSbFMvSkxDcmprbDFPM0Zwc3AwRDVr?=
 =?utf-8?B?dytLeE9xdHM3SmZ1YkhDMS91cDFhQkNBZUNkVlZhRXp0NWEwTFpBaHZmUU1w?=
 =?utf-8?B?S3NOKzBzOTd1czE5LzM3R1piTmVnKzR3eXlJdkFWRFlIdm9nTDAxampiQUZo?=
 =?utf-8?B?NUJLQ0tUcklTRkVmclc3cVpIK0NMNW9Dd2ROYkdTZjRZY2xuTThKRGZGS20v?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905869de-6e98-4dc0-c26e-08dc6e634889
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 06:59:47.8635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0gjkhlq2Z1AxjZyONIFjd5jHzu/SEtqsHBDm7nPwcdFXOmocKTiMTqDQTzLeFhpFTQ9YEtFVIJIzifPVJ46pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3761
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 May 2024 07:00:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15849

Hi,

1.3 was already a bit late, and now 1.4 will be as well, considering our
quarterly release goal. There are two major series pending (delta update
and rootfs encryption) which I think we can finalize this week. Then I
will tag 1.4-rc1. If you have further things pending, please speak up now.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


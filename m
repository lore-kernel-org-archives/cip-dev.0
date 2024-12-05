Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC563E77171
	for <webhook@archiver.kernel.org>; Thu,  5 Dec 2024 07:48:51 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.42])
 by mx.groups.io with SMTP id smtpd.web11.5525.1733384922472673984
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Dec 2024 23:48:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ljkg3sCc;
 spf=pass (domain: siemens.com, ip: 40.107.22.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfdeXndK2wJR6MYb7w4sKZ7BL/DJPubaBZuffHtqIQxToqoEm6sDdHhT5VcVJCqiLG8ya+4BwbwY49AFpcu8zvj7cefmFSxD4ICKcyTxCyWiXwSKf0eJATm6YQMBpBObE5E4RsTbJv0xSPWjyTcoM7Rl+S9IUbC6Z0rLS77JlQoUOQ5DVonLSaKKvI96irDa9iP9ggSsp2nOMICZvPlswQkgMHsUx4znNBELYLLYc9MgC3f6LbdDmPCPBQYLqNrNiq+ibqd48QdjzHHWKxMRV5W512+bxXW1/5Do8O8W00QO8adyaSOEsju4N5nDwFgUvNfxMGZLJ1+fTLjg14LuIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjmZ0XJxBmT+s5IWCWyPPE1hZUevUBWmD1HHvguQwk0=;
 b=BDLv1n+lquFsfkehc/EjgzZ00337P/MaTMV8M7jIDxO6P3UDPNKJyM95csRQLDfjhoBtkMeFOp6Rd29FgXOxrg5dHcHBra0Qv/4BzBRaKjKKgvS9p2cyuGrgwXUhNZlMgeGuqS/wtM6sAxXiTdLrnEmXbyH95lC1glaCHnEpZJkYrg6TjW2SOwGLky4u/xQI/9dbrhWH4Dn9pX4CQOeJ59qa4t6sIQJVGO11oGRRgim+rXo3m3os6WLxz25EaQAJAlWww/NIaiZyGKp62YhjCsDRuWq+Uqk+UHYCRSwf7r2ffFTz5C52jmVSQw5H+PQTEO8l+f/G8FUkqeVqN+KVQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjmZ0XJxBmT+s5IWCWyPPE1hZUevUBWmD1HHvguQwk0=;
 b=Ljkg3sCccatBJRk95r7uTfn0fjCTEfHpZ7qnas9hfAdY0JA5k2OCxYqCeH8s4uxETTZooINuINv45TFV1SJioHC268hhE6dYON20r4NEVrOmetPcI+aX4BeKDUdSAscjIBMfZMTw6CV/Cw+LYX3Q3zzRAKywD0ZOcXWFwta2VFBRcCSHn//IV7kJLkqQrj3psxMRxvcVGsaJFzjEJUdH1a7v9y7zLVBln3DVmRdiCu7ftmGZkGywaTUnW5ZuF4rZ4lMvH5VEGLo9O0G0QLG2ECOkDQwupoxwfdnOLDegGH21VuU3sc7Qg1t020UPMeziFtY3wLYVNAHehvPw0ovqlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8728.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.8; Thu, 5 Dec
 2024 07:48:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 07:48:36 +0000
Message-ID: <d5866dea-e857-4c0c-a290-7373570fc78b@siemens.com>
Date: Thu, 5 Dec 2024 08:48:35 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0224.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: 2995bec0-bd97-40d0-226d-08dd150139c0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U3Jqa0JiRjUvc090TDZmTXZEMDJtZ09ZMnVickhiWXlZeFJIcjdYTHIrWmZx?=
 =?utf-8?B?MHdOMHcvcWFTMGVLZEpxbEo5S0gwekQxZkxLeEVENDRHK0RkS1Y4RS93aGpG?=
 =?utf-8?B?ejNWbTFIdlVSZGFYRXhzeElJampDWUxsNmlRM0FpRjI5L0g0dHUwVzlmZWFO?=
 =?utf-8?B?WHB5akUwMDhtY3UvRlRYbGZDNlNRTEQwTXA2N3BnUU5sNXN0Znd0cm03bFgx?=
 =?utf-8?B?NmRONVQzSlVDYXpkWEVhQ3NUZWo2V1laV1lUVVBmOTJCZXJJbE1GaVdHNlFx?=
 =?utf-8?B?RE5WWEtScEJmVmJmbzlpRldrMjIwcXBKQWJZV0N1ZDdDak5lUnF5RWZFekpU?=
 =?utf-8?B?TUdaeFFlMWthSGFhRWg5UXd6NitNcXNQamJUUnNocFppb0FrNEVRdVhkZWIv?=
 =?utf-8?B?bFp0cnlmdWRMWU1oV1c3TWpvYjVIRWozaGNuekg5VDNRelVKeDZJdHNId3JB?=
 =?utf-8?B?L1N1VmRtQ0tEUkJwYWswaW5iSlA1b2VmTGxhR0JtbjdURW9ueCtVZk9Bakdm?=
 =?utf-8?B?WUVIb09Bb0tBYW1abVFjQmVNU3VFdnV5SWlQOUZqaFFIZWhaKzRSKzloZlY5?=
 =?utf-8?B?a2lmUitRbWFqa3VYcWV3Y1g2TXAyb3dLZkdNd2dDWGtab3ZWdWN6T2ZyUDFn?=
 =?utf-8?B?cCtERm1tZzhvcFIrVXBaZm4wWElJWjlYekRYL3RaZWRvaEllQkRYZnU5T3Bl?=
 =?utf-8?B?MWdjMVFjSm5DMmlORFVvZUh5U1BTTXRiU2EvZHNzTlZWWWpVZjBFM01SMEJs?=
 =?utf-8?B?VHZOTEZMazlhVTllUWZ6TDZlTldlTE9RRFhERWpmemxoOUZSNzJyVFhUOVhE?=
 =?utf-8?B?Y0E4K3ExbExRNTZ1K0dJdlBTdGtWZjNHMVYwS01IMTgyWFdJMGVvTkl4bWYy?=
 =?utf-8?B?VmFpcEhKeEhlK0pGbDU4cys3TGpMRlhpdjRIdFVkUnZPZGtVL1VSOGR2dzY2?=
 =?utf-8?B?NHc3aGdKdDRXbzFpZkhQdlc3THdmZmx4bXZkY3dzWnlkZ1Y0MmVSUEwzNTFR?=
 =?utf-8?B?U015RVNNWmQ4ZGgwZHczLzY5aVlsTDdFWUJDeFZwSzNCKzJzTFRxeCtjQ1dE?=
 =?utf-8?B?WGFEK2FCVU5TajNYdDFYbWhJckpHU1kvMUtVOUlmSjNCOFlhY092a3haTldB?=
 =?utf-8?B?THdZT3puTGV5NXd6YU9waEdQdnI0dktxcmt0K3B5b09EM3V2MEtTUy9naFl5?=
 =?utf-8?B?ZVdaSHF1VlVYWUtRQ3dtYmlhb2hCekRXWUJNemlUajBuZzg4SGp0dDFNN0dR?=
 =?utf-8?B?WE1BcFhnU0lGdDlZbVFMQUpITndaQkRUcU1SZk9vUklUN09BVnJkOGY2Tksw?=
 =?utf-8?B?ck5mUlVrVUlBQUJWRHkvZGpTdWVHamJYREREbUF2V0pTWm1yUkpIby96Nk1N?=
 =?utf-8?B?bFF2S2ZtYWFFTjUxSzlIaXdPa29qNENSOXNPL0JXdU9Fb1hVcVd5ems4TWpF?=
 =?utf-8?B?K3krMFlRWURPSDJPMllobC9yOUR3blZVbmwrMDF0MmZJdUpGZFZ5ZVc0N05t?=
 =?utf-8?B?RS9HOU0zOW9WQmt0RHpYRkhTd2xKMFlpdWxOQXJSb1MvbU5DSFlqRVdXb3c1?=
 =?utf-8?B?OUFRc1VLNkNVUXNGWE93OFpQMWdPL0N2SHhjRk9PanZRYVZzYkcyb3ltN3lq?=
 =?utf-8?B?Y0dQdXRROUhnZTRBQlJ6SHJvNGhkbVphLy8rdEJnZ01CK3pZcTJrYXpqMWEz?=
 =?utf-8?B?OGl0a0hJZWNJaVFGaEpqaXpWSjhDN3BQS2h1Tm93bmt4U21jSFBYalVaOVhF?=
 =?utf-8?Q?rClTziSFDuHRrAsApw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MlJZdEJxOUFlMXY1V2FQWVBKZ3k3WmFXZ21rd291U3M5Qmc2djMyaURyL05o?=
 =?utf-8?B?MU9ZY3ZRd25DM3FVV2JhcERBYVlud2F2b3MzL1oxdUwzbjY3aWxtKyswYm9L?=
 =?utf-8?B?M2tPd2k4RHlBOXZmK3lpeWVRaFE1clArMkVCeXdMQUd1Q3hTSHM1YUFSMnFp?=
 =?utf-8?B?cG9DWXBtT3Ruc3plMjk5QUo1Ni95c1R1M2dVaWJnTzNSd0JEa0pXazZ4cGoz?=
 =?utf-8?B?bVFnK2JSNTJmYTJsSHhVZmNldHY3N2N4Y3gxcGpKeDlWZHFtSzlEZkpPWm1W?=
 =?utf-8?B?amtGSWVaWngxWFNlb3grOHNNUUZoWGdWZ1FDeWZyVGluM0JlZW90cnZEeC9J?=
 =?utf-8?B?dUdxbmtmaWt5RGdpTjdRMjhsMXFKS1cyOU5Wc2lnOHdwL0hQOFJQQytoL056?=
 =?utf-8?B?cDRDZVc2eTdwQlkzdXFwTUE1Y1RCRk5CcDRyZjVlWUZBMkdkVnJNYVhqeDlO?=
 =?utf-8?B?ckUxbUdlL2ZqdE9zNjBOdEoxT0c0NFp6aSs2anR3SXZnZ0VlTHcyODU2S0dn?=
 =?utf-8?B?OUlpK2UwVVB5ajF5QmxYQ09ILzU4M2JBeFZvUkVxNlpERm1QL1lpMUo3Ylhi?=
 =?utf-8?B?U2RDYlRLZW1XdDJFeURURk54Sk1JMHltemlnc1cxTE9KWElOSk5VbEh5bFVn?=
 =?utf-8?B?MmVxVXROQmUwVUJnS3ZuaEJlSnRCa0J0SlJKSEV0cWU1S3d5WWJwS0ZTc3lq?=
 =?utf-8?B?STlmTmtmQTBsdVpwWGEwUXROYUw4WVFpRnlKVGs4Z1V4aXhpYUxqblgrR0Mz?=
 =?utf-8?B?ZHllWm9UNm80aFhDV1JWSnJ0SE1DdngwYkxhbnJ5clVYTytXcmQ2eEdJclhu?=
 =?utf-8?B?VUZkcDRlWHV0MTlqdC80UHdqYjQrTVdYMkJuUFBBQkIxa1Q4bWRXYTJnRFAz?=
 =?utf-8?B?eSs0M0E2bDlsaGNGY3M3cUFzSSthSGlmMjgrRG52cjZXajlHSDJIaXI5N3V6?=
 =?utf-8?B?MEl1MWU5UHZsU2FRL2JCWTBnS1lQZjNwT2o3RW40TGllOUs3YzRZa2FXcW11?=
 =?utf-8?B?dit0ODQ4RndoajFqdCtZaWdDQ1dLZnNSNkNEbGE0cUx0YzRDYWNEc0JMQVh1?=
 =?utf-8?B?b3poVGl5UXd3N3NYaUlNRW5BNDRIM3hoUHlpbU45ZHVJcnhyR1FhT0x3Rlp6?=
 =?utf-8?B?aW5JWDlKSnVWRVBjaDlWOUFJU0c1bFNZS3paMGVaSVZDT05WWWx6ZEFTY1R4?=
 =?utf-8?B?ZFZGZXZVNlR6OGN3S240UjVxK2llRjJIclV3RDJZZ2ZBOFZrWGs5b3NUa3pG?=
 =?utf-8?B?bkR3NXM0cyt3WUdlMnR3NnBXQWpadHo2M0JiU29XeFdYWDJKY091WmVGNWpw?=
 =?utf-8?B?Y0FpTkJ4NHBZTlN0SzFPQzlWUFNSOVpVK2taaUg3SGdVSlB6eVZiMW5xd0pm?=
 =?utf-8?B?QWcwdHNXWno3Uk9XWHBkOWtoYVgwaklHVUFMb3drcVNuUkNtTHkyZmtXZkpw?=
 =?utf-8?B?S3NOTU9TL3dVS0VaWGFuL2RLZlQ5SmsrTm95MnN0cnVCdW9SNFVhV0ZaM2Qy?=
 =?utf-8?B?Tmd5MzJjVnY2MTFGd2k0elIyUlAzTTRpR2NFa042cFVyUFpZSGtzbmI0eUli?=
 =?utf-8?B?Um56Q2M0SnZxR0thQ3J3a1VYNzFVc3R0NTN5OUxGQmZZWUpBZzB4b1FhVVlJ?=
 =?utf-8?B?UVE5Yks4aTVXcXIycEZJWk1WczNmbDZ0Z1pOTDZUZHF0RTllZ3E4bkhjWjFL?=
 =?utf-8?B?cEw4UXhWZExIaXVyTHJrR29pWStvOHVVWnZZOFJhY2wvOFovRy9yN2xPdlg3?=
 =?utf-8?B?ZFZrQ2pHZ2R4SVNGNnh5MjhXTUlBTGVwS2trN0pWUDRFTHZvY0hkNnRYNC9C?=
 =?utf-8?B?RUxSN01sZGFvY1dDeVcxS2c1dXBNbVJrTFExeHhLU3VpM05qOXI4d0g5ZFdW?=
 =?utf-8?B?djBici8wQk96WHdIVTRtMkl2QXN2WDZEYVVyamxFU0Z0L1NVcVRQMjgrUXVF?=
 =?utf-8?B?YUthYUFmb3I3Tk1jUUtvaXovQmwzK0VHZEo2VmNkU21jdXUycU9lZ2dOMTB2?=
 =?utf-8?B?VkI0K1VlSVAvY1EvRWxkZTNrTjl4YXRNaDFObEpSKy9IdTBEc2ZINHM1d0tl?=
 =?utf-8?B?bkRhMnZWUFdDOGJGQkNnSUhxZlNkRUExZ3U2K2ZoWGFrZG0rTFhtN0lkTGFa?=
 =?utf-8?B?QVBVbElKcFpuc2g1MXlJS0hMZHl4L1U2azZsVi9Wc0I5VFRGcG9vT0krcUgr?=
 =?utf-8?Q?XGDrXn+aFTbbLcvwS5FDclcayl4cOp98YFxl3Y1eoJiK?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2995bec0-bd97-40d0-226d-08dd150139c0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 07:48:36.5528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrz1CDSjl2Mn+2oFhL3euatfNLGrzUd5jiKrvzujntVCqb5nBisFc+AP8Xo68b6P5vxzdgMrW9HrMeNutSJ6kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8728
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Dec 2024 07:48:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17330

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=12&day=5&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/11/cip.2024-11-28-13.01.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Thu Dec  5 05:21:08 AM UTC 2024
  limit date: Sat Jan  4 05:21:08 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon Sep 30 09:48:28 AM UTC 2024
  limit date: Fri Nov 29 09:48:28 AM UTC 2024
  Status: *Late*
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Nov 11 07:08:57 AM UTC 2024
  limit date: Wed Dec 11 07:08:57 AM UTC 2024
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue Sep 24 10:34:04 AM UTC 2024
  limit date: Sat Nov 23 10:34:04 AM UTC 2024
  Status: *Late*
linux-5.10.y-cip: interval 30 day
  latest version release date: Mon Nov 11 07:28:28 AM UTC 2024
  limit date: Wed Dec 11 07:28:28 AM UTC 2024
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Tue Nov 26 03:12:05 PM UTC 2024
  limit date: Sat Jan 25 03:12:05 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Fri Nov 22 09:04:06 AM UTC 2024
  limit date: Sat Dec  7 09:04:06 AM UTC 2024
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Sun Nov 10 11:47:28 AM UTC 2024
  limit date: Tue Dec 10 11:47:28 AM UTC 2024
  Status: On track


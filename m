Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA19CFD2F6
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 07:34:45 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.70])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13562.1764228876838771087
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Nov 2025 23:34:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lPY8Fcyx;
 spf=pass (domain: siemens.com, ip: 40.107.159.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLa+qxBY6znDQtvZBqjcvmDP77QsdOzmySlAQCJncDB6QuccYMBUJ6RlyNnXGePqRjs3hFKZBIjFYKndQM1QbF1G3WDtths2t6cADjJQGaVXzY3AY3wYmTh5q/SxfeNfX76q+WeYZmodhApeamUAI7NVNxTbIF6x0g6aCjSUE8ehJ8DmwPR+Oy8IMoPTtSowDM97fSlsLj7396+/zuc3P46/dWUPY+lJwHCNXhuUHXUWjx3GKbhXoZHeDm7NYizsvgMrrN/6lHLocJuWWqpiUdAO/nhwEbkYiDIHS7SG/9iJaFI3oifpa8PZZO7CB4momHNSoTmMAffAGzsK4dZnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loxCAjgq1k1YSf2jTSIC7V8voZSLnXN9+Kep76d6cSs=;
 b=NlFGlmCu/u4kT3jFZMTIjwrQjwrtvNM66XvM8rzQ9K0w99mlzf34FF/jIIS8+OJPZVCUOf/OD1YBvcp03uEXRWrJPpiFCRYsyApIxtEzjY4TJj8BuaxCKeOpOzf34iJ/p88pqqZmfDeJca0NV6M2pCNOQSggdCwXi/AiNsKtxszxJ9nwKBd/ZZ2mkC2MweD/Mnjuvhl8EwOK/Ammhai3fmYsjjl6I/u17qEieuAh+K3IJGY05Ci+vc3v1RsGJZqYEhU2ksc5M6u+DShOnpiUirDGq84dq0dd4LWNCip0PlIvWSUiNXzlNao2b1CpqguP4IFXRGuhn2cwmYBobgtC1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loxCAjgq1k1YSf2jTSIC7V8voZSLnXN9+Kep76d6cSs=;
 b=lPY8FcyxdOPXRG190C51VMMthaaTnnVeLmMJHLrd+0qTTMIboSOskMOZkeVWYUvDUx8nEz78SxFWioiZ6X673k6RdQsUz/B875UzzaT+KLT/jTeiAzwYgBlkbJrIOvnzQysrk5Gda4Jyq+mpQ5me+Cd03uFOQbgm/vS4/vJJFgvWw+FWR3r5aCOLZrQGrjSehO8gvNpyFAiIMjD1YBWY1F4xdwg8bJWVQ7KWVV71+GNHORvR9d/6Ggo2so68OxoUWxBDUbXVW8kXKyjVnk3LZnLWmI5kNVk/gFuieuPEQ4U/mAE+tXCiy21yLuDb87RmqAWSIssyksQ5yTpjZH04gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6927.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:579::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 07:34:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 07:34:32 +0000
Message-ID: <3530c12f-3b5c-4b4a-8e5e-e8ed3c871a55@siemens.com>
Date: Thu, 27 Nov 2025 08:34:31 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 0768ca02-7d3e-4cf5-8cc3-08de2d87682d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cWtDWGU0UjVoZG9rR2RTZCtxb1p1Nmc3b3RJeXhvaGM2WWxwdUV4NExLc1ZD?=
 =?utf-8?B?NEhSNUsvNEhkcU1hMG8wallENGhpZE1DUWt2amY3RTAvZnQ0WjBvcU9aSjJU?=
 =?utf-8?B?SlcrOGNCYjB1NWRkT0NPeTQvZTV2clErd216alJ3cE1OdDBhNGtIRm9TZkp3?=
 =?utf-8?B?ZXVkN1hXTWx2RlhLSU5BSkpQZmxrRTJtYXRMd3BkQ3dFa1NxKy9HdGhMdGVs?=
 =?utf-8?B?MHRZN1kwWUpaem9PT0dSQlZ4dHd2WExkS3VxWWRIYnliRW5ZbW9sNmcrUTBn?=
 =?utf-8?B?U0V4M05ZOHl2NmtGVTVpbXZZTFFWcDRyUkdodTV0VzhiTTlMbXRCcjVvN3pI?=
 =?utf-8?B?SGQrYlFwRkJVdmk3QnNtSjdUN3FnOWhiMkJISDRsU0hGWWRMalJKSEVwdUFn?=
 =?utf-8?B?Vmc4Ris3MjBYZmFFUTY5anB4TjVlajJqaXlTS3h6SVc2Qis1b3BJelhSdnZa?=
 =?utf-8?B?UjZ2R1dwQzArUGZ6b0VGd3BtT0c1NzU1eVJudkhFZEh6bnU5bnpubkxrZVN2?=
 =?utf-8?B?dlhpNVhtMmRBMUp6ZEQyNTF3UUs5NGQxS1lVYXZiVHh4TDZacWsrVFYxL3Na?=
 =?utf-8?B?Qlpid2lqZ1FEWUJpdkdDVGJPdGQwZG1QQm9tU1pZdWVKak1NUDhHME5LUDBI?=
 =?utf-8?B?SEFDN1lCNWZ6SEx3cExwS21OajNwNUdOSzF5bjh6a2N5cWlWRHVJVWJPNU1Z?=
 =?utf-8?B?SXNWa1M4MEZ6SC80OVRMMEJGS2p1cldlUTBaaFI5WGltVjJORllFVG5UWGFy?=
 =?utf-8?B?WUVQMUVDVTZNa25wWHBXWUNHeERVeG1YYjNJRnJBVERZdlBDTXcyUjlmcjR0?=
 =?utf-8?B?ZDhkRFAvZEwvYWdoTVNEMkp5NkpxM0RrZXlld3l6bkdPb1FIQXBzOTBRcmE2?=
 =?utf-8?B?MXpUbkZCMEhLbEhHTTRhTTJBNUxhU2MrL3FHRUtySVhYQWJzVE9lWEt2NGNT?=
 =?utf-8?B?ZE9SUDRWM2RJMGh6bmRtYVg1RUt5SVVkMWdoOXFXZzVsMGNnTUdsVnRVVnM1?=
 =?utf-8?B?RVlnekcrK1Nwcis3eXk2RmwyMkJ0bnc5aVRzZlY4Q0ZoMjM4M0V3bzI4YVRu?=
 =?utf-8?B?SlJtaTFNcXBpVnBmMnVSTlNKZVNTVVRXUHU3SDBLZTNMbVhZQjJycGdjR1pX?=
 =?utf-8?B?eGE4bDJRS0I4NkFlN0Q2aXNiLzdMZUN0cTlPTjhTN3pkS1dkN0t3SGhpQi91?=
 =?utf-8?B?Qno3UTFDZlFJUGFMVlRmYTFIcnd0ZHVaZDB1bGhuR3c1T09sc0p4WGlweTRF?=
 =?utf-8?B?VVBmeThoQzhwZmxzVGVnZHlmaUVyenAxM1hJYnh6K0k4aDlOSVhvMm0rTnRY?=
 =?utf-8?B?cWFxUkltaFZZYmVTNVlSL1NPa0ZMRHhRRWYzWExDRzNweFRQc1V3TDM5UXNP?=
 =?utf-8?B?bktnSmJNcWpkQlo4SEVXWEYwYktiZlFLeUxtYURIV0pRam9qUW5CN3JyR0c1?=
 =?utf-8?B?UG1ZN0ovMWVQZFBhNXZtWmJWOVdSb3pTeWxMQ3pueVhuWTZkU2lueUhKMlBo?=
 =?utf-8?B?OTFMYkZ0cEl1YnJrb3pjMjVNRkJISnp5UUZhK2wvU0pQRGRGN0J1a3IwODdO?=
 =?utf-8?B?elJLMkdEaEMyMmVLb21WdDA3YWR0Q1pQM0UzZ3dzZ0N3d2lMa0xVRVZHbWJx?=
 =?utf-8?B?ZmpKMSt6a1NWL2dPMG1OcS82bW42bUVKRE9PUzZpNEoybDRRMXhKYWo4U0Jv?=
 =?utf-8?B?TzJYcDZlclpoMjJSRmUyVnk5alBSdXhwbUtPUmJhVlpzM1EvalpKYnVUM2Jo?=
 =?utf-8?B?cG9ZOG56SUtlVnptSXZla3dzUkM4Z1htcXhUQWVFVGRtZlc4STRxNlRmQkVY?=
 =?utf-8?B?em5HZnE1NittVCs1Yi9qc20xNE1GTXRyUDlYaDdWdmpsNVlWNG1HQ1Q5dEk1?=
 =?utf-8?B?NEtjQnh0ZGhYb0JObGFvU1VkUWFhZXJhNnh3S0UzTlFvOVE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eHJIdWtYTGZLdlRtdmt5ZlE4aTNCQmM4WGd3UVdaM3ZRcERGSWhiRGZnK0pZ?=
 =?utf-8?B?UjNGR24zTHNKbjBqeWNjNysybTNLeFNmSnBNNyttYmkzOE9SVWlDMXZLQnQx?=
 =?utf-8?B?cEY1cnZpUHNhTE9JblRkY2FiQjdMRDBWdklCcDR3THJsclZ1MmZ1RlhxVkQz?=
 =?utf-8?B?My9QVXpSMCtCdGNwMEgzRWFyb3NnaWRHdDl0TWwwdmZlSW5qM0dZM3cvcjdk?=
 =?utf-8?B?aWRCRVZPTG5rclFGdjJDZFd6TncyM21saFFWcDVKRzB6dll3VHBabEVSOUlT?=
 =?utf-8?B?S2RnWVRmTWFEM3g3K0t1UFRPMVNiZlB3Ry9OOXBZUUNoQjVIYldCTWR4Mitx?=
 =?utf-8?B?WmFabWNjbm5Xd085bDJYUWszSG1aZ2k4SzJLenFlR3BCVGNCenBtN21DODhh?=
 =?utf-8?B?OTVERTM4enJ3ZWNGcE9FdTVWN3lhSVJPNjlBSTZpOGhrY3ZQMjRIclFjUU1w?=
 =?utf-8?B?WmZBT2hkZW9ldUhhNExxNlhnakdyVmNZcVlEbEsyRjBFN0hyRzhzcDJhYjJj?=
 =?utf-8?B?aXR3WE5XWWxJRUlaOU8ydm1tbloyWmJyWldvdkJxbDM1eDR1ZnJkazJ1aE1R?=
 =?utf-8?B?UEkweHdpNlpDTENlelo2QUFXa0NLa1RUbE1mdGpkdXB0eVhrUDRvZEhiZGh4?=
 =?utf-8?B?TVIwZnJLUmR3ZzVZVTFRWTU2MHhkSFRMelVKbnBSOTUrT1hYZVJaN2h6WDlo?=
 =?utf-8?B?djhmR0dIdGovWjV5c0FBUVJxY21CaVUvem9vbFp3bDhKK3pKRy8rV0xuaWRn?=
 =?utf-8?B?WXp1WElGTG9MNFJzMXdrcmtUakZrWGF5ZGZGM1hoYjBLcnJSTEszMTVqb0N4?=
 =?utf-8?B?UnlNZWc1RzFWS1N6bXVVMEpxcWZtcGJIYkFYYjI4NGtOSHpCZUIrd1NGM0Qw?=
 =?utf-8?B?MUtIS2h1Q2RpdTQ5STVsdVRhaUJJZEt6UHVUdUFCOU9PNWJMSjBYRWdtbWdQ?=
 =?utf-8?B?N0gzQnJpZmNqTnlydHlFUVJ6R1dvbXEwOG1rM1AwU2wyRDFZZExwRnQ5azFQ?=
 =?utf-8?B?UVNWR0hickErdmRXMjZaRVZVdjdiejVsNDNYb0lGcmVkdDl1TEpzMzRJYXI3?=
 =?utf-8?B?YzZZTk55VVJBOHB4TEhTM2c3ZjlYTnBSTWc0L2RjNGVQSjBQQ25tWUg3R3JS?=
 =?utf-8?B?TlFPVVNyNGNKUldlTUk5dXh4NEE5M0FWbXI5RzgzYXNXMGpIVGhKSklJK3Qz?=
 =?utf-8?B?ajNKR2dxZmlJM0VNdjhmU0M3UjA1MEtSV0Q3VzNtWnJpSm9EQncrckVlcUwx?=
 =?utf-8?B?eCswZzVpRGRndThLc3RqMjh6eDBabWI1QzQwWGYwRENyRVNtWFY3ZnJjTmx5?=
 =?utf-8?B?QnBqZSs0Znp3U3ZRR0pnQ2ZUQ1crSUhRenF3L0luU0UvMGZHc1F0VzduQ0xO?=
 =?utf-8?B?S0JaYlFBUWx6M2JPU2g1dkVNNHZ1L0p2MjBjQ21GWGZHaTlrNlllSkR3K3RJ?=
 =?utf-8?B?WXRwbzBTK3QyelBkRjRGaE1CYnBnd29qU1JqczBJZnpYamtKVzI4YUhiN3Z1?=
 =?utf-8?B?MERtOFE4aVdzN0pwak5XUkkzUTMyZXhTMkFzL1pXdlU0N0RaR1QxcFdRc1My?=
 =?utf-8?B?WEJOdnRoaFFRejhPMzJiZHl4TlZaL25sSDgrQ3gvaEU5WGJ0SWVyeWV2SU9m?=
 =?utf-8?B?WVZEaUZBU29LdTRjOTIyRktwVk51d0l2WC9BcGdjRDVGWElXNUY3N1dycVRz?=
 =?utf-8?B?YjR4aEFKR1VQVlY4MzQ5akZOcVVLRnV3Q29pSEMyblRoRnZHdVZJQjFXeG9W?=
 =?utf-8?B?bDJuZzh1aldaZXVpU1ViYkJoMkNRZi9sb2p0cDdpQ1FHbFYxcGFReTZYZlFL?=
 =?utf-8?B?bXdhVklrRzY3dE5tRElLSWU0cS9PaVRTRDVTb0w4TU94YndjQkM0S0lZKzhM?=
 =?utf-8?B?RVhRaXBLY3dqZWtIUlFkdE85MndaWjVtTG1qOXhMd2lTZjZFb0s2MUh3ZHBq?=
 =?utf-8?B?STdCRHBLaHlsdy83STMvWG9PdW0rQmhrWHdja1Q1OTVrajU5eFp2UmNxSk83?=
 =?utf-8?B?cmZSS3NkcjQ3YWJ5dGowbDRNNlFYSmFzOUc2RFhHdHBNSTh0NTBCR2pUUkdX?=
 =?utf-8?B?MXdOZ0dka1VPUnFBNUU3dW8zQ2pvbHdLS01adDFCV2h6L2JQZk9nQmNPcFFF?=
 =?utf-8?B?MTZYRVJoVkRENms0WUErMHRqUlV3VDUzaVNqMjJOYTdHNUUwcWh1ckZEd0xZ?=
 =?utf-8?B?SFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0768ca02-7d3e-4cf5-8cc3-08de2d87682d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 07:34:32.6688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7hSBHlfJueGQXbXiIQ08ao+WgL4R3FUxJA6GnFRzt6YkrfjASe0TlIx1W7FBmL73GbVr4u6mOzpaMr8D8371g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6927
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Nov 2025 07:34:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20739

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=11&day=27&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
04:00     07:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/11/cip.2025-11-20-12.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Nov 27 07:33:58 AM UTC 2025
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Oct 29 02:00:44 PM UTC 2025
  limit date: Fri Nov 28 02:00:44 PM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Wed Nov  5 10:07:00 AM UTC 2025
  limit date: Sun Jan  4 10:07:00 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu Nov 20 10:20:08 AM UTC 2025
  limit date: Sat Dec 20 10:20:08 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue Sep 23 10:53:07 AM UTC 2025
  limit date: Sat Nov 22 10:53:07 AM UTC 2025
  Status: *Late*
linux-5.10.y-cip: interval 30 day
  latest version release date: Thu Nov  6 09:00:25 PM UTC 2025
  limit date: Sat Dec  6 09:00:25 PM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Fri Nov  7 09:45:57 AM UTC 2025
  limit date: Tue Jan  6 09:45:57 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Wed Nov  5 12:32:45 PM UTC 2025
  limit date: Fri Dec  5 12:32:45 PM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Wed Nov  5 06:50:13 PM UTC 2025
  limit date: Sun Jan  4 06:50:13 PM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Fri Nov 14 08:26:39 AM UTC 2025
  limit date: Sat Nov 29 08:26:39 AM UTC 2025
  Status: On track


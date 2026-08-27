Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53ACC5DF9D
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 06:18:35 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30094.1787811511284989265
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 23:18:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jQTfCK7N;
 spf=pass (domain: siemens.com, ip: 40.107.159.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPdSTFWYAdxyvE2n9OS2+6c9hLnznnQZDorcUqAHxYjgVlFtkRKWs2tqlW6dG3wLed6IfrgEBXhzzSfCW5wmVEX64uaViG+BBr/DrctARjx82fsPeB1ce0+WnjS7i4kxJOlPF99P7OH+75cYu4WyIQuADnY93rMpNibyhPuDyeLdB8xhFWIwAdLEKye6bjaTzFkYMcSRUC6QESlAlp6cLg/kDCEXLyT4LYZP/5/fayqXBubK+iRzvLQDlGDnVLcxPi+AyWF/qzG+Sgz5ffu9WH9nUPyha3f2d3nHCjdZG6eXvT1h/Sc9I4hGgW4UykaYokpkBtruSmlkanIiihREnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddFGcFI5fbd91vYW55HafmcSSqXIsR1ZcEGgAuIOvOA=;
 b=GFF+Mtb6BQL5j6QxK8KCKvvXI3CEX2han2qR4fa7gojmgQh2cYEUo7C5kGBYAu9rEY9ZzAtqDxocW8uU7xNXOMjZ1QfhCqxeOKpykCY/0vub2/6moUguJwlLfJBKJIjjl0Es8ujYfwLuvfLuJlaq9tlw8vTzg9Wcht0NoKidqysAVkIzfoDg2UMa9x6mBZykB/noVx/5rrHJomAECsb9TeMEXGhlMh+OoviFO3ZpXcZ1zvBtlM+ulGg4ApYF6rKbh+Y1ZOD81SugVCs/hgaKVbXQqrM7Jm0Vib1ATB4/5klBwJGAin4PbKtbwU99o8+gb6GSIHuDEYP0TEkKtXtiKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddFGcFI5fbd91vYW55HafmcSSqXIsR1ZcEGgAuIOvOA=;
 b=jQTfCK7NRsc7PmmNHiy0L3X+VPsLsfKpelL5Esc01F4tAFY+nltdFrxNI38xSOfG6xQWekadYduCEcVS5CB7ZfQsQ8PROsmrq2N1U13Ex+bYegm9PdSUNi9sOEYOj3cWNOCNDMZvfS5DXJCIRI0OdZNcrwRwjk2PX58fSj3ua0R8vOm6/5sphEfRjvkaUXWRmNScl1dkpWG2A+xMINxiqKRYjXnSQSPU2NGjxBdJDrnoEfEqZG7ZEEruhKI3a/6ek1Kx0PqJDteEaz7kyyTFBEyrQSa23C2ZtglMIElCBQ3BaHlGNjxdbKrKng4kmxH9Ohs4vA6NHUGavplVaXJsNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3496.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 06:18:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.006; Thu, 27 Aug 2026
 06:18:26 +0000
Message-ID: <8fa63a13-bf0f-4b3c-b575-347e3d537c6b@siemens.com>
Date: Thu, 27 Aug 2026 08:18:26 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3496:EE_
X-MS-Office365-Filtering-Correlation-Id: b788bd3a-eb5f-4ab1-a7d9-08df04030198
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	mxDv6ofBHtKKmPvU3WZUOJTWoILHWmcrxSbI2BzRWG5Ky8dShb4iJy+vj8rUOzX3R14vcOPB9tdManDrEvhvoymfxQ0Wv1j5XyNvr9MrsSU/7B9uyS/8wrElrg64ceCr4v0bpX6I/iTwmygp7KrseAPSwdSy3IzBc+p/XHcyJIPV4dd9qqmIWaIoKRtDtwaYtT+JjwPRwL7VAGokWZRooeo1n5UWST8ZljYVqSjnsLeedMJLta/lJYAL8crcDi3RS+6RZWVMPlDp2Ks8lRQJriQ2eINyozxkh2zMJeua3kLcEMuDFm7/U2BreWr20+hQi/wBMS6h3JDT0EC8Ld/c0yH/h4qjAZya2bVCRiSIBlb9CRL7wT7M3OMgKy5ZqA/xDChYha/jtEA6/2ZMEDB1iTnvXZA+lYN2nsvJlasiRbiMpRcX1ZwqQpfmMTMOF/VkQ0Kb7ivhpF7sf+fQJY1omBH3oQ8CmcqksfLNPYLZgDSKNdKfZOHxIg6Rv8LyNwK4MeR86OoQ11NWRexL9FTy5UqvcOtev6TEDEcf43Vo2+j/IQmpNg7SUHwREv+AUyy4TOm/H2bTL65IImsqbarOuOEAfpVQ1A3QeAnE58qkuOI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a3YrVjI5WlM5bTAzWU1Nbkw4U1ZYVjlhTGZCWE02eEhocDZtODVEcU1ZVDI1?=
 =?utf-8?B?S0dZcEZJbUp6T1EzRXo0dFgvazl1T0tqTnNMZWgwNHFqeGJYT3E1VkZEZVNI?=
 =?utf-8?B?NG9JQ0plb0RIcWNtWnA5Z0NCb0pPSFlHRmJ3QlBpVW8zVVFSZ3VQUDhIQWZZ?=
 =?utf-8?B?TWFGUkl5U2RQaWN0QnNicmMxa25OZXpQTlB2YzQvRHRIZEl4SDNRYUVxNkEw?=
 =?utf-8?B?aXBXRCtGMGVVRGFSK0V4TFAzTXJVMDFTbVZoVktsa2xwUkhKbnNsNnpKVG9P?=
 =?utf-8?B?dzNwSnEyeFpqWFVmQThqSGNDWUxoUmFZK1RpT0RqWmFDNURWdnN4WkVGYlVR?=
 =?utf-8?B?SGY3bDBQeGlUcFc2YWlvWk1WSDNGUXVEb01RQjFsRzVFTlVFMklQUFArbmg5?=
 =?utf-8?B?NTZUVStIWFhnbi9rMVJiSTRPcS9UYlRLMWRQcGw3Y1ZReUVlb0Y4Y0hJQTBL?=
 =?utf-8?B?eUoyQmZmbVQ2OXBabWZxZGltamp0c01CaEc0dzJUZjhnRFVaMVA0bFNmT1Ur?=
 =?utf-8?B?NC96c1EwNFMzUEcrem5WRFlxdEFYMmtvY3ltUGYxSTRNUTA1RFNLVzhDMlk5?=
 =?utf-8?B?Z2g2NlRzdzIyY2V0MzZWUHZXSGpqZC9Fcnk4Q0FaSzhTYlU2djFoWWRzanVQ?=
 =?utf-8?B?dThjYVUvWDB1MVhobEgveFZua2JCcEg4cTQ2YkE4SzdNUE1Ddy96bU5kV3gy?=
 =?utf-8?B?cVNyWDZCY1N5ekhTbHZZeTkwcjJZZm10U29KbFd3aHI3QVkzcUNHcXdmbnJr?=
 =?utf-8?B?WDg2KzdaVkVPQS9XVk5XdGhXc0FUcURDUWNhLy9kYnNuRndzTmtJTFhYcTVU?=
 =?utf-8?B?NzZwMGZOeWtiaXZUWFRZd0I3aHF0SHc5ZytEVzlOUEc1L2dNdGtiOTJTdGhw?=
 =?utf-8?B?bHMwMW5qM0U3VVJlb1VwMDMrZDZGcDQ1MjMyTlZEL0FPL0s1WjhMdnQwbEM0?=
 =?utf-8?B?eWkxY2s1TFJLV2Nxd3JQdEFXd1BibCtKaTd1K3p6eTZDL2FKYUxjTTFBYXVQ?=
 =?utf-8?B?TnFEYXpxemczM2hCTzh2S25ObDNiMU5mUURjTVN4d3A2ZUlTaUQ2M25DL3Zj?=
 =?utf-8?B?VmJwYnlsRVk0c3JxWm9ldWMvZ2FTNGxYK1lJN3dNZWJZdHRjZmxVY252SHUx?=
 =?utf-8?B?YkR0SENuUUNuTXFxRjc0NlZuTTB2T05aUzZXWVBZeGVabS9YdTNndkxzalFN?=
 =?utf-8?B?Y25ENURhd3RIWUVlUXp0Z3BYRmlqWjYyc1BQTWJxSzIxMWRsczdLa3RvY1cr?=
 =?utf-8?B?UEJJbUlYc1dsOG05aXBKSUZJMmxCS1ZYWm1ZZDd3ZjRta0ZZSHk1Yk1sU2g2?=
 =?utf-8?B?TmV0NGtKY3F5Rkk2bDVZVEk3OEQ0amMyR1cwQ1B0TVdrcGRsY2pXU2hJYmE3?=
 =?utf-8?B?d0tUUmVKRHBkMEx2YWlraTZyWWh6ZUlRbnB6bW5OZXNJQU9xN0ZTbEdqWUlo?=
 =?utf-8?B?ZTZ6cFB6TVZ0a252TThocVhrcVRrK0ZlNWhiVFFzNFpKQWJtU0JYZVZoZkYy?=
 =?utf-8?B?bFljdVlvbWRpK1ZtWFdJNU0xSi9kdTFWRk1xT0RDaWdBVHZqS01mcXU4WlZK?=
 =?utf-8?B?eHh6a21RbUFlVDJlWVpXWlE2NkU4MkhVenRXZ0lHcUsrYTdGMTlhT29YUWhh?=
 =?utf-8?B?TjRGVmZ5N1ZQWDNvYndReWxLb0NwY3UvbzlZWjh6MDF6djJyVlhBZGhvN0tn?=
 =?utf-8?B?UTVYTGtNYXdCdjUvcG1iOXpsN0xXNldJYW5uVDNrL1g5Vk8wSlg4cFFPNTZq?=
 =?utf-8?B?L09uR1JYa0xITUFCR2VKMkVqTUV1eE42UE0xV2dPbjBONXp1Q2tCaWQ3eGRn?=
 =?utf-8?B?SFcvek9JeXl5eVZ0eWVVZy9UZlRuVXN0d0s3ZGxYTVZCcUtYR1c3VFl5NkpQ?=
 =?utf-8?B?RW1sVllZbnY4bDNGZmxvYms0YVJDVG9pNU9qSXIyeEV1RmhucEgyU1VKY2M0?=
 =?utf-8?B?SlFNdnVUZk0yejN4czE1cFZXUEhFYmZIc2FselZDcjRpdWVPYnd6SVh4cEhF?=
 =?utf-8?B?dHFxTmJvQ3B3b0Nxd25wb0tWYVNMNW8zSWR2cG0vUnVIZUhFaE1VSlhCZGVU?=
 =?utf-8?B?YUwydWZHRnlqTTlJNDRNeXU1L254RFp4UmxRMGJUT0R0K0JjaWV1VzdlQlls?=
 =?utf-8?B?ME1BQjBLRm5iNEZqUHY5S3ZQN3dRR2ViWUpFTGpIRlkxejdGTHE3dTFCMGcx?=
 =?utf-8?B?bTRrOExpUCt0WUgwYlgxd1V5OVVQb2lXTW8yeE1KbVRXTDA0RFlWZjZhRGtz?=
 =?utf-8?B?VTNGekIzOGZqUXdtWGZ3UlVlcWRCRTJxSldidjZwNGhKRzArQmlJRmFJMjdz?=
 =?utf-8?B?S0JScnA2bEl6RmNFcXR5N2RQVE1QRnRPUkxGVFdXMTNDMEVTcWVLdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b788bd3a-eb5f-4ab1-a7d9-08df04030198
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 06:18:26.9423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FiorvgXikbnpwSHLQA9TSYt8Cucn2dxMAf4uyk+v/0hMvuq9HmD0AleNvuI1gRl90PgfNZwJ+c0uRkp/t0Im0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3496
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Aug 2026 06:18:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24032

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=8&day=27&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/08/cip.2026-08-20-12.00.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - LLM review tool: updates, feedback

Jan

[*]
Date the data is created: Thu Aug 27 06:18:13 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Aug 19 08:54:45 AM UTC 2026
  limit date: Fri Sep 18 08:54:45 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Thu Jul 30 09:07:13 AM UTC 2026
  limit date: Mon Sep 28 09:07:13 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Tue Aug  4 12:34:28 PM UTC 2026
  limit date: Thu Sep  3 12:34:28 PM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed Jul 22 07:47:57 PM UTC 2026
  limit date: Sun Sep 20 07:47:57 PM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Aug  7 04:22:30 AM UTC 2026
  limit date: Sun Sep  6 04:22:30 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon Jul 13 07:40:40 AM UTC 2026
  limit date: Fri Sep 11 07:40:40 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Fri Aug  7 08:15:19 AM UTC 2026
  limit date: Sun Sep  6 08:15:19 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Wed Aug 19 06:16:01 PM UTC 2026
  limit date: Sun Oct 18 06:16:01 PM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Fri Aug 21 08:39:20 AM UTC 2026
  limit date: Sat Sep  5 08:39:20 AM UTC 2026
  Status: On track


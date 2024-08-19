Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E9CC3DA4A
	for <webhook@archiver.kernel.org>; Mon, 19 Aug 2024 09:38:36 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.85])
 by mx.groups.io with SMTP id smtpd.web11.206820.1724060308817402545
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Aug 2024 02:38:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eqZPFG6o;
 spf=pass (domain: siemens.com, ip: 40.107.249.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJIquiCeBZ6sfMCCh9msaCC7ZA5edCvXKX2JwHkgj3Pg8gusyKlGnRoo/XNkU1zTpyL0TlKABzbczAWHysvHsKgQN7TbApELJmifJH7owHLPa4LgvG75JjZkKwMHoxbkgXZKTBVtBVug0537t/3Y6GVYSok/D0w+dEfgRoJZMPVkjP9l1c2OSvpT4PLI/7akyD8/o00ttqJIXWJWZa8P6/KdpZF4siN6d2s5TVJ7ZP1OMUcVF4HzjHorQDwCywNxvQ0nUqUZLMKEwOn+B8ndlkWrr4O3gOC+nXWwK3wE/gZg5hevaWmxcZycsOYxprwMJwj4tJDwGQ25YoqScCHp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zaW0Fu+JNPjd7DamIciNrgD1OJPhSQhtFum2dvCk1s=;
 b=F9DGea2FU5+kb8CdHaLTF2oeuUSA5AbHSlJ4Sv3Eicm2W/p+WIXNP43Uu2W3B2KaBDd7uZS4Da0WbqFa3A66Ws3v8SdMeIlckMHcOhC4RwtgDfgQ6SLy7/XEJCy2PZBaCDsZklY5/gZPEIHhiw0HnpYwzqOjz0x+d0RsWsvhr9vpUPKkoWM6KktbyVX/QFjsl1S3HJLvxVj5AGqu9+XEAv+MusS7qzOHFD7SJxUsdPl6lhJiSMhPbgwzLP5SVfE5OMiJzuyAqhQO4/kFAgxm1fJ+yqv6pHG6pgLYbxrlbeBWkgUjGtCa+Nbu5VvPNxsqwzAsCGawV5ugeKpyh7T5hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zaW0Fu+JNPjd7DamIciNrgD1OJPhSQhtFum2dvCk1s=;
 b=eqZPFG6onrv0RMtG8K7km44v4Sxy8UFsXyAayYCcMn8aJVOifA0oio4BBDnAusfamk7EKu2x0jiA9ftaN7UNDpDFvwB0uZroQJFHrav86YWpqXP/gyWf5VEugX1mgBffwkxJTJXhsjGMlfDNuovwvtQCcGZJE2/3shZe6NuFK0Ulj9mERUjuxXKV4z1Grf9bK4BFBT+vTkH1HHwd+UJSeUZrbxnt6u3kQ58Ksqfu4RjdOKGNnbtDfFJexWY0YWZ5Ao+zcHg93ckZ5l4Q6K643lZjrd6m3ZXbawj5M9X545nWLrv+sRlBETN90sEphd9teJSKEgAxlIT6Q1UWvXxP2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9125.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:23a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 09:38:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 09:38:25 +0000
Message-ID: <4554969f-4d97-4aed-b8b9-d78c2db6212f@siemens.com>
Date: Mon, 19 Aug 2024 11:38:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v6] initramfs-overlay-hook: Check
 file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, clara.kowalsky@siemens.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240805091905.1818691-1-clara.kowalsky@siemens.com>
 <OS3PR01MB6103795DE9A6A06EF71DB552C28C2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <OS3PR01MB6103795DE9A6A06EF71DB552C28C2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: b0968d38-563b-4aa9-a4e6-08dcc032ac96
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?M1Y3QUtXbFNjTTJ1NWJSbE5rZlFDWGIvaWpWSWNBQzhJbVhwRnFyTVNrRTZZ?=
 =?utf-8?B?eTVydkFWbjNERlVOL1hSQVp1UUlSQms1SjN5Q2lUallGTGNPdXBSeFdXclBI?=
 =?utf-8?B?cTdSS25TU0cxbHhGWFkzaGZwdTkrNlppTERMTktUVW1Tb1RHUEJsakNheVRx?=
 =?utf-8?B?UVJJZjB0Y0tVbkFiamc0S2JYUnk5elFmS0dVdHpWamkwTUNrYkdNNnZCbzht?=
 =?utf-8?B?VmZ1T1FrM3dwUllUTDNwMHlRS0J5Z2JoZlNLdjdFS2VwcUZKaTdvWXp6aCt4?=
 =?utf-8?B?TGRLb1lVWHUrOFAyb3NaWnl1NEdHS3lyZnJvS0Mvd3p0Zmd1N0N3czNQM0tu?=
 =?utf-8?B?cG9RMGw3VmhzbDNDRWFCeHZMRmM3dHNoY0JtRTIrZHNrVGNHSit3R1VmUmN4?=
 =?utf-8?B?VU1VUGpHZjNnbENERzVMd2JhWmZ2Y0dGbWdDdnlnZUN0N29vYkxieUZrVElI?=
 =?utf-8?B?bG52a3FoaS9xS2I0OVlHU0F3eXZXSFNFdmI1L282Z3lpQmlGbG5nbWFUUWxS?=
 =?utf-8?B?RlMxeU0wUGFaT01PdDdBcEIyMU9wQmJZKzAzZGNhZm9BUkpHdEhYZ3FlYnlB?=
 =?utf-8?B?bmJPM3ltdU9QWE5Vd1hhK1lzODlkR0RwcjdWYnZBZ3hzZG9PSUhBSHY2cFFO?=
 =?utf-8?B?WE4xbUVjREhFQTdBZmdRZ25xZlB6cWhPQlFBZ1ZvdXNMelBwZ01MUHVXb2F0?=
 =?utf-8?B?YStCOFN6a0g2SXBaVUVxeGJNeFNUVnFKbC9DTWdYOEZSbFFmYkdZbG5iRnFU?=
 =?utf-8?B?N1NUaS9qdFFSajg1RS9TcVF2eDRTWlcxczl6Z2NCaUZESDEvM1R2ZXNrWU5L?=
 =?utf-8?B?YmJHenk5K3o3VW5tWmtTakNrSm9mNVc3YnZHcXRKWVoxWXZabDQyMFZhQmVa?=
 =?utf-8?B?Wm43NGNweTBiV3JhcWV6aHpLTVhiM2paaUMySlRNdEYrVXh1NE9uV2RXRkxE?=
 =?utf-8?B?Y0I1RzBacUlaMTdQcTBPTmdaWWxJT0tEVVhTSlBEOUlzNHlzeUQwenhpalls?=
 =?utf-8?B?VGRuNUFUemRSQ0U1alZDQnFLejBzQyt1ODJieVhmandRZ3dDQXZSOUxWY1k2?=
 =?utf-8?B?Wm9rOFZqY1V2Q2VEZGVPWXMyK1JHNzhLUVVFK0dtODlNSytBNVNKZ1dKVzh0?=
 =?utf-8?B?YjZQUWQycjk4bjExMFkyNnlOUUM4ZzJva2FwK003azhyTzdhMCswTWRTNTRF?=
 =?utf-8?B?NzdKekkzUDBDN3RjOTQvRWVRV083RUl0VTV0TzQ2cHh4M1pCUHExWklUdGYy?=
 =?utf-8?B?TTVxeFk3Z0xGSTNKUjFQd3djcDhJeVc3c2pCRG5hSVA4cllMbEc3cC9GM2c5?=
 =?utf-8?B?NkNzWUhQMmkwNmdqWVE3UDVpZFNsbGhzTVdMVEJOQWdFZlRqV2FUMGZhYmRs?=
 =?utf-8?B?Nms4YUl4azdmdGg4Tzd1YWJIdURmZzJwc2FscUFSSTlOTGphRnVtOTZhY2Rs?=
 =?utf-8?B?ZUdxQ2R3RVhlekIxVDlJQmpOaVpKY2Rya29mUzRpU0hnU3hjZHlOZnUrVlR5?=
 =?utf-8?B?c2ROTnF3UnkyMnR0Y1lWdnhaMnYrcVNuUmViU2x0Ry9VaENKd0JVblg3WGV5?=
 =?utf-8?B?MnNGNnROMlErOVRkTHRrdzM4VjlrNThuVlhNckR4ZjV2Z083YWdPQXpKeTZK?=
 =?utf-8?B?VEM4Nk1nemVLZXk3N2F2SCtPWE0zQXVqMGpVbXkxa0tQN0ZiclNEVE9kblRo?=
 =?utf-8?B?R2s2NEpGZGpBa0cwWGJoM1pQRnEycGRXSlBuZFZlSU5TWmhjdFpQcVpWbVFy?=
 =?utf-8?Q?9u6lcJPo78cKx+Ho0s=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WTN0VXI0T3hjYXhkWU13K0NkeHVvUm5RNEJnUVdjS3NER050a3E2TzUydEZU?=
 =?utf-8?B?bWd3dWUxMmphdEJ4WENxeVVLVXBMajlEV3ZaRVdCZ1NveW9RRGo0OE1iOHdx?=
 =?utf-8?B?NGV4Wm0xTHlKT2NEam1jUng4OHZVV2RMQXJHNTFIaVUrUCsvOHdYdzg0Q0I4?=
 =?utf-8?B?TU4wYzR2aWtCN2wrcU5Ra1B5RHhHeFEzZHVSV3VKQTBmT2l4RURFSTRDbFFO?=
 =?utf-8?B?RW9NMHVjaHloSkhqT1kyaHQreXRkZ3h5Ujg1Y2pRaDdIdVhqb0pZKzIzaHow?=
 =?utf-8?B?UytqYXVZUVZwTDUzN0U1THIwNDJ2UlRMdk51dW04ZnhIQWZ0dDFpSkE3ZDg4?=
 =?utf-8?B?TjF6STVIdUdxTm1yVi94d0llQmluZkFuOWh1dUc2NXJtdTQ2ekFaWnQ1OWNI?=
 =?utf-8?B?SEY0amx2M0xNbHdDWTNJRkxGZGN1ckFZOWJGb1J5OG9SaUh4L0JhaVVVc2hi?=
 =?utf-8?B?ZmJOaEt0c3pXc0dNelBCNTcvSXF4aE5FWDhJZlZXMEpWQTlkUDR6Z0VQc1VR?=
 =?utf-8?B?N3BwN1B1Q2M3WitHa1ZXazJkVTZPREtQeWxjRmo4aUVyWWlWUkVzczgzeXl0?=
 =?utf-8?B?UUF4M05GeU0zYnNYUGQ3elBHd0o5UG15ZGhHZ25qRC9FTzJZOGMwSkJJUm9N?=
 =?utf-8?B?NWxzVCtiMFMrT2ViQWxySDZZK2NJNzJaaENqMlNzaEFtMjN0SVVHQ1UvL1h6?=
 =?utf-8?B?bnd1US90UU1CK1pmeWNONUVLY3p1bFo5cWdJVnJCODlKQVFwWjFMU3VCUS95?=
 =?utf-8?B?ZTlsM0VyR0pqbWZvUHNnUy9sb21QVkdjdDlBTTBHbWpiVlJTNUhYb29QVHNv?=
 =?utf-8?B?c05NUFZFSVI0S21OcUJJTkNrSUwydTRnTERVb0w0aU1QelNwb25sNzlvUWVt?=
 =?utf-8?B?eXc0V1EreVBua00rdU1RUE5PZjFpVzM0eUdoeDdsQTNRR0cwcE9DZyt6aGFu?=
 =?utf-8?B?K005OHVpUWRSVjl4VFZISW0razhqZXN6Q3FNS2JPWGFMekVpRi92anhHNDJu?=
 =?utf-8?B?VGRZQ2pYbXFwb2dCQUE0MnNFVVQ4Q0dHcWkrMVZqc0k2SDYvYUd1RE1Vdkcy?=
 =?utf-8?B?bXY0ZHZERlFFS0F5cHhUV0prY1lsRTRPcTlrNEdCejRJa1QwZFNMYUd4R3NY?=
 =?utf-8?B?c3pNblpaa3ZwMHZvMkxjeUxtK2N3bWk2OGZOQ0cyZWZ1b2NSVk9HTHorUkow?=
 =?utf-8?B?d2pMYkhxdno4cmQ5M3cwK1FIYm5WelVUdUtpQXF6WUxyOXdNalUxOFJsM2lh?=
 =?utf-8?B?TGE1TTk5TE54YThPSCtqWVlxMkVWdXpSYW5RcjVvZnI0MTJuTDlaYXM3YkRo?=
 =?utf-8?B?a0NNYmZwanpvMkNmTmQ4dEdtUm0wUWhLRk9Ed0NHQWlxRHdmUXpkM1lpMFBJ?=
 =?utf-8?B?Q3dLM3NQeUgrb2RZbjhNU3BMMWNrUWlqVlJvZE13cDVCVkJlZUlyL3FrNWlX?=
 =?utf-8?B?cFVKaVF2blh2ZkFiTStzUGh2dFNqWTNJSHl4RnJiUnlpWFlyZ2g1cXYrUGw0?=
 =?utf-8?B?cHZESDFjWklmMTd2ZjF0N044b2pxQU9xelBaaXpTeVRpNndHNGs4UmZwZDNa?=
 =?utf-8?B?RTlZZGpPalpITWJaMHNiZHk1dmJkdytQcVlxb2NpZVVRam9PRlRQYjBraXl1?=
 =?utf-8?B?cUxCNk0zVjN6bUYwbE9sZWFVZG40SjFmUDVQa3kwdE83SVdsbUQ2OE4rTFpl?=
 =?utf-8?B?bmx3V2JtZ2UyVm40R0NmQ0ZldzJmb2JrZEhRRTlSei9rM2FsQmt2aW90ck5I?=
 =?utf-8?B?OWZEeVBjelZsc0piU0swMWdKcURMaWNYT2V1TmxrOTYrTjJHMjN5NVhYYU5o?=
 =?utf-8?B?OTg1WUl3ZGFwZzhVY1Z0MFhQVEhtRjBkTTRwQzU2NnIyT3cwN0FuQ2w5RjA3?=
 =?utf-8?B?SFk3R3lOY0FZMGNMZE15QndWQ1E3cEZSTDlKd0RlSGlicXVEL2JXcWNNTURx?=
 =?utf-8?B?ak53dDVlT0hFT2hxQkNtWlVkdzYyMzh3L2lBOGNWcHVoWGVkSys2OVk1YnJz?=
 =?utf-8?B?dlJUVHFVRDlwRkhuRnhoUXllUVJ5VlRtV2pxaGtQdFVFc0pZU1R5QmtIbTc2?=
 =?utf-8?B?aEliWndQNGo4SUc4S1hrRHJhS3RpclZJUS8rRWVPUlVGUTlqNlhlK0ZnQ3ZC?=
 =?utf-8?Q?QlmMjlfyEgiYYAzc0Cd1oQKnk?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0968d38-563b-4aa9-a4e6-08dcc032ac96
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 09:38:25.7192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2pmdIPeCWpZYIDlb6DA0XNntOHh0KbV3Jw+vp9H26Np3LuKdFc7zYmzT7q66K/wyzubx+gcyoX4di59GtSzGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9125
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Aug 2024 09:38:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16795

On 19.08.24 11:34, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hello all,
> 
> File system errors are detected in `/dev/disk/by-label/var` which is triggering `mke2fs` to re-create the file system during reboot.
> 
> In LAVA jobs, mke2fs is asking for proceed prompt (y/n) because of which all software update jobs get stuck leading to a timeout error. -> https://lava.ciplatform.org/scheduler/job/1180009#L1213
> 
> Currently I am not sure why file system errors are detected in `/dev/disk/by-label/var` during reboot, but this needs to be handled in software update test automation may be using mke2fs -FF -t "$partition_fstype" "$ovl_partition_device".
> 
> I request everyone to provide their opinions.

So, we have two topics:

1. How to prevent getting stuck if /var is corrupt in way that it
   falls back to interactive mode (-FF?)?
2. What is causing this issue in our test case?

Before fixing 1. we should understand 2., I would say.

Jan

> 
> Thanks and regards,
> Sai Ashrith Sathujoda (T S I P)
> 
> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Behalf Of Clara Kowalsky via lists.cip-project.org
> Sent: Monday, August 5, 2024 2:49 PM
> To: jan.kiszka@siemens.com; cip-dev@lists.cip-project.org
> Cc: quirin.gylstorff@siemens.com; Clara Kowalsky <clara.kowalsky@siemens.com>
> Subject: [cip-dev] [isar-cip-core][PATCH v6] initramfs-overlay-hook: Check file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
> 
> In case of ext*, this detects and fixes file system errors in the partition device before doing the partition mount.
> If the partition turns out to be broken, the factory state is recovered.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  .../initramfs-overlay-hook/files/overlay.hook      | 11 +++++++++--
>  .../files/overlay.script.tmpl                      | 11 ++++++++++-
>  .../files/overlay_recovery_action.script           | 14 ++++++++++++++
>  .../initramfs-overlay-hook_0.1.bb                  |  8 +++++++-
>  4 files changed, 40 insertions(+), 4 deletions(-)  create mode 100644 recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
> 
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> index 8b00ecf..6f634c5 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> @@ -22,6 +22,13 @@ esac
>  
>  . /usr/share/initramfs-tools/hook-functions
>  
> +hook_error() {
> +    echo "(ERROR): $1" >&2
> +    exit 1
> +}
> +
>  manual_add_modules overlay
> -copy_exec /usr/bin/mountpoint
> -copy_exec /usr/bin/awk
> +copy_exec /usr/bin/mountpoint || hook_error "/usr/bin/mountpoint not found"
> +copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
> +copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
> +copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> index 42eb59c..c655a4f 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> @@ -31,12 +31,21 @@ ovl_partition_device="${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
>  ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
>  ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
>  ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTION}"
> +ovl_recovery_script="/scripts/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}"
>  
>  root_mount_storage=${rootmnt}${ovl_storage_path}
>  storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
> +partition_fstype=$(get_fstype "${ovl_partition_device}")
>  
>  if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
> -	if ! mount -t $(get_fstype ${ovl_partition_device}) \
> +	case $partition_fstype in
> +	ext*)
> +		if ! e2fsck -p -f "$ovl_partition_device" && [ -x "$ovl_recovery_script" ]; then
> +			"$ovl_recovery_script" "$partition_fstype" "$ovl_partition_device"
> +		fi
> +		;;
> +	esac
> +	if ! mount -t ${partition_fstype} \
>  		 -o ${ovl_mount_option} \
>  		 ${ovl_partition_device} \
>  		 ${rootmnt}${storage_mount_point}; then diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
> new file mode 100644
> index 0000000..d13111d
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_ac
> +++ tion.script
> @@ -0,0 +1,14 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Clara Kowalsky <clara.kowalsky@siemens.com> #
> +
> +partition_fstype="$1"
> +ovl_partition_device="$2"
> +
> +mke2fs -t "$partition_fstype" "$ovl_partition_device"
> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> index 955748f..7097130 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.
> +++ 1.bb
> @@ -12,9 +12,12 @@
>  
>  inherit dpkg-raw
>  
> +INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??= "overlay_recovery_action.script"
> +
>  SRC_URI += " \
>      file://overlay.hook \
>      file://overlay.script.tmpl \
> +    file://${INITRAMFS_OVERLAY_RECOVERY_SCRIPT} \
>      "
>  
>  # The variable INITRAMFS_OVERLAY_PATHS contains the directories which are @@ -35,7 +38,8 @@ TEMPLATE_FILES = "overlay.script.tmpl"
>  TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
>      INITRAMFS_OVERLAY_PATHS \
>      INITRAMFS_OVERLAY_STORAGE_DEVICE \
> -    INITRAMFS_OVERLAY_MOUNT_OPTION"
> +    INITRAMFS_OVERLAY_MOUNT_OPTION \
> +    INITRAMFS_OVERLAY_RECOVERY_SCRIPT"
>  
>  DEBIAN_DEPENDS = "initramfs-tools, awk, coreutils, util-linux"
>  
> @@ -48,4 +52,6 @@ do_install() {
>          "${D}/usr/share/initramfs-tools/hooks/overlay"
>      install -m 0755 "${WORKDIR}/overlay.script" \
>          "${D}/usr/share/initramfs-tools/scripts/local-bottom/overlay"
> +    install -m 0755 "${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" \
> +        "${D}/usr/share/initramfs-tools/scripts"
>  }
> --
> 2.46.0
> 
> 

-- 
Siemens AG, Technology
Linux Expert Center



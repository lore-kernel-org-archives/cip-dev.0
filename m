Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0FAC25B74
	for <webhook@archiver.kernel.org>; Thu, 16 May 2024 16:18:19 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.40])
 by mx.groups.io with SMTP id smtpd.web10.18344.1715876290123331941
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 May 2024 09:18:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zJjOQ85S;
 spf=pass (domain: siemens.com, ip: 40.107.14.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAkqyhmOeDOo+E/WDlY7fY46uTTtKD63JixM+7QEZ/Q6EGO5PFc7GN5FxjklmmFBDJP6c4SkPx/DXqBfJub21UxXIPL97ItF+rIW6jZHmk4nmeArlvi/LKq0kKD+IJCTNDPHrYI7TZugJmosmZT0pvbkziGOmn1ncOLjpoV7S12B1PqKWtAjL1biY7D11wc3UI3OrzYK4yTamswrjqOxWwHIvHxKc22PBHEd2aQg3SsN8k3BLs71PcdvRaOdsog9XuPOgfAXba5yfoKtSELUGNkp0xeptDieVgm9Nc5fBakaos1Imd4FqQZdRhgTHOo4ZSgwbk8eZPVK9/8rI0kKNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKDGXQDL9OsFxbg+RiTJTwD30WZ60Mn7U2pjOSjlFtA=;
 b=kMwthQYdBHkPdEdWWZYHA8fpnK9Y+uJOWC5bvbRXsSrfPAqPBbLftIyrUUhgmFYDXYIAFWNiELrloAtsnUbtAe6t0zerYSIcjMwCoj2Jp0fAIGmpohWCOhhKwUNagCGShGgn+W4XPTQey1QYfgI0tHVObDPi87augmHJ2urKyDOSetr9pZH5VmSH4e3MTVsDnIwLZaCZmIxFNshbKqDNUSOiK86rRAHTmZ8bBxa8Kc99YP/Lk07rgYdgD/+zw0BoCfzYhPBmjEMtaMHXh9S3zguwYWT9rOo/nGZ5JrO6GstAzu/6wiW++IDANNqBlPw6w3Q30wNo6YBKz8PS07ZU2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKDGXQDL9OsFxbg+RiTJTwD30WZ60Mn7U2pjOSjlFtA=;
 b=zJjOQ85SCpPwLsr9u7LjMjI6xM0ozKnws+VdPgO+wq8S5T8MxE5hptMk4tprMeOC064p7GyWagA2o6EDBb7hKzLR9kCDGca8E4yWhkXRGsOwgEJ9TeWLKdvZQQarbrzsrW1FR+TQgTyVDaPb3EdV2qTcZNylJXuFkC/9XNe4N+hMOAYL/vpvZTaQ+zMGG4pREBmu4gcZot5xYvBCimclwRPsL2gcW5YnvrogGZSHowflQy/KSwpkRIb19vEC4gMJA80gKr9wuL5yOlConv7mz4VGX5XF1hJYhqYjCt1sFP8ewzRDORIcjdxIPCeIQc9uKvZELOyNL3D4lu/j0Ov5Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6632.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:400::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 16:18:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.026; Thu, 16 May 2024
 16:18:06 +0000
Message-ID: <1d3cd14c-24a1-47cb-b48c-b9a711491702@siemens.com>
Date: Thu, 16 May 2024 18:18:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][isar-cip-core] kas/opt/expand-on-first-boot.yml: add an
 optional expand-on-first-boot
To: "Arjunan, Srinu (DI CTO FDS CES LX PBU 2)" <srinuvasan.a@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20240515075548.852777-1-srinuvasan.a@siemens.com>
 <035c94ac-4ad6-434b-9eb9-94fd92e80a07@siemens.com>
 <PUZPR06MB57479D4D64AADC96C2DF118388ED2@PUZPR06MB5747.apcprd06.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <PUZPR06MB57479D4D64AADC96C2DF118388ED2@PUZPR06MB5747.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e8ba36-1c87-46c8-85e5-08dc75c3c538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OHNKaWVnWmlHbmpkU2NlS0U5UEVPdE1rSmpIb2trSnZYYVVudDdvaXczdjdO?=
 =?utf-8?B?ZUh4djdDZlhPeEZFV1YwRVNZUWxpbXQxUlNOV2hucU9uWmZiMEdNeC9sTWJj?=
 =?utf-8?B?WXNLRkFxSkZSYUkyT1NNaFNnM0x2VEpaUnVUd2YwYnRNangzNWM4ZEp3alJr?=
 =?utf-8?B?TGNjY2EyNnR3NWQ5MGJsbWVIV0NtQk1GQUpqYmEvRUhTMGhYZkRFWW8wWDIr?=
 =?utf-8?B?UitWVlJmTWFZU2UvQWpuZHQ5VWd2NWpVa20yRzBIMHZHaE14RnA1WC9JWEpB?=
 =?utf-8?B?UVQ0TTdJQm52Q2NLMnJjR1Y0VHByMmxSQlBtK0JNREpoSXN0QytlZnNZcDV4?=
 =?utf-8?B?cXNZME54cW10M3ZPczZnN1A4L1U5VHQyM2orL0hkUkVxYjlKL3h3SUdMUmww?=
 =?utf-8?B?bmFIakNMOGFYUGJOZzQ0NzBNT01XdGx2elFOc1ErUTVzUXVIU3NKSmg3aXo0?=
 =?utf-8?B?Y0N1bEM4SEFKQ0wrTTQ5ZnBzWTdpYXVERkhIck5kcWY2eXlVNXpNT1l2MVg3?=
 =?utf-8?B?VHBnNzdKWDhrSnZTSVdBT1ROUGxja1RiejQ4bEd4K3NTanFjS0N3Ulk1YzMv?=
 =?utf-8?B?NjZHbE85S2FZMDJJYjBUcmJ1U3FBMkMvYll0TVlxSGNndGViU3N4UXR2Wjll?=
 =?utf-8?B?RnVydEVZVW10TjZ6bTErWlFqSGdOb1RXNXR2SmxaNEY5M0hVWjBTR2ozalVS?=
 =?utf-8?B?VGY0R3NMa1FiUU9TMlFZRCszYStOdWNYVWpGeitwK3RuRHBWVlZSZFAwaDF2?=
 =?utf-8?B?TUVtMTJseTFLakRuWGppa1g4VUdGaFppZE9RTGZVRnlxbi9DWmZsMG1SWVdv?=
 =?utf-8?B?c3NmcGo4ODhKV2N6cWZlUURYYmdkTDdLVHIrenZCdE40TmMzbUlpSUg5bHgx?=
 =?utf-8?B?M0oxcHR4bWt0N1I1VGxXNm5xR0paa1pIRHBBa3MxL1l0QmYwamNXcnRmNG9M?=
 =?utf-8?B?WE1WZ3FNNVRyNlBjc0QyUzdzRi9jNGNHZk1oZ05TTEtjNDNkV1gwb2VuU2ly?=
 =?utf-8?B?QlpUa2ZQUUp6bzB5QVMwQlo0dWtwbFVSZXpVTEVYZFFiWUF4Yjg3MmxtcDJF?=
 =?utf-8?B?K3RMaFpSTVdsbldKU0lzeHJGZEVYbWtmYjJnWFVkL2E3bGJybkNpWkV3YmRX?=
 =?utf-8?B?TmRtNmlaNDl4UzVvQ2cxUWxEMGw2SzFmdytnSGtKRUpIa3RRcGRWLzNpVFBL?=
 =?utf-8?B?dElzSkRCZ2JYMnRFZXhHWnZiek9OTEwrVit5MlNVK3F6YWpxWCtueVZoVC9K?=
 =?utf-8?B?NUxJTDJKSXd2d1RsMTgyNTBiMHMzeXl5TjUvTXJTNHRBdjhlV0o1czlTNUtr?=
 =?utf-8?B?TzBtU2dhUzM3Um1Pb0dYK3VrM3Z4T0xvZm1Pc2lqMXpYamhTQXdTY0hOdFJC?=
 =?utf-8?B?TkxHRXI3SjZseGt0MVhRM2owajM0b2VNN2UzZXR4N2RmWXVOVW9CVTNucHcz?=
 =?utf-8?B?b2ROaTJkUFZ4emVYTUZKSjcrNGlQT1pCaDlLRUY5cG1xUkxpTDNaczJVdm9V?=
 =?utf-8?B?U1Z4RVBYRlQxNnA3bGdlYzRMNFczVGxGbDQ4UnFjbHFBeGNQWS9SQ21KNFJw?=
 =?utf-8?B?UnkxSDNrc1BRQmd4ZHFRTlh5K1ZZWk8wdWRDWHJ0RXFrOTFzK3MzRkhxODZz?=
 =?utf-8?B?MjRIZ2hWTGRsSUU3R3QyMlBjeW9wVXhIYkgyK2hqU05LR0VhVlhDY3FzdU9n?=
 =?utf-8?B?Z2NTdEFUZTRZdW1wd3p6ZUJTRXVCbDdiV0VySUxQRGlkYWhSR1FTTWZnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NTlFM3NKSXlCWktlSlNqNU1vaTEzbGdmQUpLaDVtWTdZVGxCWVVNVW44a1NB?=
 =?utf-8?B?MFNJVmVsODZNTFlMSkxQWlBZTEJ4ZXlBNzdZK3V3cldaQmFnemNwSHZuY3By?=
 =?utf-8?B?bms1S2czaHM5cFFhak1nZVV3b0YvSmp4WnYrVGxHQmtIZ2RBTjhId3AzUHB4?=
 =?utf-8?B?cUFwbzNjSXFwVEFZbUhiOEt5dVdPODhuN2tpN1BnNkFFaWZrSTNSb2JnaVI2?=
 =?utf-8?B?bU1XR1FJblg0NmdrbkdWZ1g5Rk9xbXFlSGZPZlA1dnc1ejl1ejFxeUpyTjVO?=
 =?utf-8?B?SGloTDdJbXg4emxCNkk5MHFXMURab2ZDRDRsVEZYZEt5RHNsbmx3Qk5sN1Yr?=
 =?utf-8?B?aWtyWkozNHpmcTNPcnBTTld3alR4UTJmNVVDSlhyUXpyTXRqUG5zbHUzZHgz?=
 =?utf-8?B?cS9ONnpEZFpvaG80N1NDaTBXYWxRMllnK0lRa0FoTU92VkFtcHpZUk53dUJx?=
 =?utf-8?B?RWhFVUVjQUhqd1B2Vk95MDMzZlRZM0NMZGZWRVh5U2F0YkRGTnIyemc1dWI1?=
 =?utf-8?B?bzRTelBSbTE3OVFIdEFjSGd3MlBwVCtFcVk2RXBTY1pCRlRsY2pNMFJpMXdk?=
 =?utf-8?B?Rjk2djVpbkR3Q1ZhVGdpOXZCNytyV3hmQ0ZHUmRwZWoydXZRaFNEaWMvMmFT?=
 =?utf-8?B?b0d6VTdnc3NYWmh1bmNpbjNhMklHY254bC9saFc4cGMwSUxFTms4amxPR3I4?=
 =?utf-8?B?MXJYYVRmMFZQYUxubUxJOFBrSmkwNlBjMUgvenh0NzNmMmN3ZXQ1R1Vud3pt?=
 =?utf-8?B?amNvdktBeFBlcWx6ZzJaTmtLaEdOVW8vbmJZRkxKb2h1QTZwWEdWUVhaV3V5?=
 =?utf-8?B?L0NjVlB4NCtFQ0VhMTZsRXU0VXZ1SjFkZ043UGRMQzd6V25waExDcWM3Vkhk?=
 =?utf-8?B?Ly9YOXFYN1VjLzlReWJCc1QvbFJvcWFpckdNeFEzK2NrVTVXa1IxWlNtNTV6?=
 =?utf-8?B?d04rNHUyOVBzbW5FZm9pTzVabUxQaFhBbkdMRTg3MFRVOE5DMmR0ODdhSnhK?=
 =?utf-8?B?UVVJVXUraHdtdU5Zd2lxd3hwbWpKMHJPZzZyMTN6a1ZmQUFVN1NPbnBPQ0R4?=
 =?utf-8?B?WFZGNlNuWkFHWFhUSkxIK1d4T2R4NzRlOXlsMmxIelptTE05RDErU2tiLzRT?=
 =?utf-8?B?Nnhub0dVNEQwTlpDOFVsVk5kRTJKTkYvVnhDN3pMeHFUOU8zYkdsZ1lwWSt1?=
 =?utf-8?B?M1FyMW9jM2JzOURQVS8wd1hHbWJ5U3ZPckZSUmw1L1BpOUx1QTlkK2dBSk1n?=
 =?utf-8?B?Y2xOSEpXRVZ6Um9HT1B2VXVPV3o5QmsveUxPT2ozUnBXWlgwT0ZBSTJ6Nmox?=
 =?utf-8?B?QzJQVDFiMWJ3NXMycXVyQjQ4dkt0QVhkYjlkTnJHNWVJVzA0eXRJbERtR1Mx?=
 =?utf-8?B?Qi92VEtRWEI4MGxIR0FVWTZzc2NWUzkxblpFc0FkdzM1VVBRR3kxQ2k1U1hV?=
 =?utf-8?B?VzBKK1hkbGVPYm93SVdkaWswTWpWaFZYZkdKdW9xNzk5c3A2OTNTaTJJTm9a?=
 =?utf-8?B?NlIxd216K05yK1NHdWwxZGxTa3RBN1JBd1NBWktkNlppaDBQS2pXYXdTcXZW?=
 =?utf-8?B?ZU0yWmtEMUNHaWpkRFNHRXd1SDZkRGQrRWEvUHpCeHV1REpTek16cmxzYWF3?=
 =?utf-8?B?d2ZyU25kUTkra3hQUnZUakYzMEptRlJYMW9sU1RyMHcvT29YbExZaG9IR3hL?=
 =?utf-8?B?YnNGOFp0cWVmK1J4YU00Z25tQ3RwaDBYMVRYZkY1cHcvTWM5QXExbUpaNEJn?=
 =?utf-8?B?eWVkWnNlUllQZ0pIYzFpeFBqWXUyL1U0NFpZbnl3Q1p1K2hNKzBzclFCNkdL?=
 =?utf-8?B?Sm8yUDVmaHNjdDRnRFNRbEpnQTdJd0t0N0ltUzBPbmt0Vi9DYjJVN1pJMWRU?=
 =?utf-8?B?dDVZNVd1QllkSkxod1RtZWxidjBlN2xQZTVtQkFha1NFQ1M1bjhWdkpFQUFH?=
 =?utf-8?B?LzdITGV2S3Z2THpiT3JtZ29NZ2c2aElUYjZsREtZbk1ESEx4Z0EyT3Jqa1Q2?=
 =?utf-8?B?ZlozYWZkR2JGWEtaanU1bkNqMldMSDR2MThDS3N6NEc2ZDQ4TkV6aTBkVjEx?=
 =?utf-8?B?L2xIaFA4Wk1aRnZ1SVhqS295QTVLek9KbGloeUpBMmljaXFGejZUVWplYUo1?=
 =?utf-8?B?MnJ6QUpUNE8rOThPV0FwRXVsdzd1bERWUXNxWnFmUjBkZ3NJM3BULy91Z1c2?=
 =?utf-8?B?YlZkZ2VSVWd3aHVPOVVaZngvdzEvRTJiWW5kN29FQ2lONGlHcmIvUmJWTEpL?=
 =?utf-8?B?N3VsUzNKcXVQbDJtYXhHLzJzOE9BPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e8ba36-1c87-46c8-85e5-08dc75c3c538
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 16:18:06.8985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Va3FzGSnpfZ7TczebXnmrQZF4GWWpSI/6SH/6sgOgpyP/vZmM2yoqXx6ntIWDdC1QtfKGJ18tX0HyKhhKoveZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6632
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 May 2024 16:18:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15907

On 16.05.24 12:57, Arjunan, Srinu (DI CTO FDS CES LX PBU 2) wrote:
> Hi Jan,
> 
> Cip-core already has the encryption support, if anyone interested how expand-on-first boot works for encrypted partition, cip-core is the right place to do the analyse/fix, Purely this I brought for understanding purposes of how expand-on-first-boot works with the encrypted filesystem. 
> 

OK, I'm starting to understand a bit of your intention. But there are
still open questions:

- Why this should be implemented here permanently?
- If there is a reason beyond your experiment, then how should this be
  discovered by others (no kconfig menu entry)?
- And do we want to add this to CI?

You commit message should explain this and demonstrate that you thought
this through.

Jan

> 
> Many thanks,
> Srinu
> 
> -----Original Message-----
> From: Kiszka, Jan (T CED) <jan.kiszka@siemens.com> 
> Sent: 16 May 2024 00:03
> To: Arjunan, Srinu (DI CTO FDS CES LX PBU 2) <srinuvasan.a@siemens.com>; cip-dev@lists.cip-project.org
> Subject: Re: [PATCH][isar-cip-core] kas/opt/expand-on-first-boot.yml: add an optional expand-on-first-boot
> 
> On 15.05.24 09:55, srinuvasan.a@siemens.com wrote:
>> From: Srinuvasan A <srinuvasan.a@siemens.com>
>>
>> Add expand-on-first-boot package as an optional file, this systemd 
>> service expands the last partition on a the boot medium to the full 
>> size of that medium and then deactivates itself.
>>
> 
> So, what should this tell us? Given the complexity of the changes below, the text above does not add information. At the same time, it contains no information about WHY we want this change.
> 
> Jan
> 
>> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
>> ---
>>  kas/opt/expand-on-first-boot.yml | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>  create mode 100644 kas/opt/expand-on-first-boot.yml
>>
>> diff --git a/kas/opt/expand-on-first-boot.yml 
>> b/kas/opt/expand-on-first-boot.yml
>> new file mode 100644
>> index 0000000..03d666b
>> --- /dev/null
>> +++ b/kas/opt/expand-on-first-boot.yml
>> @@ -0,0 +1,17 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2024
>> +#
>> +# Authors:
>> +#  Srinuvasan Arjunan <srinuvasan.a@siemens.com> # # 
>> +SPDX-License-Identifier: MIT #
>> +
>> +header:
>> +  version: 14
>> +
>> +local_conf_header:
>> +  package-expand-on-first-boot: |
>> +    IMAGE_INSTALL:append = " expand-on-first-boot"
> 
> --
> Siemens AG, Technology
> Linux Expert Center
> 

-- 
Siemens AG, Technology
Linux Expert Center



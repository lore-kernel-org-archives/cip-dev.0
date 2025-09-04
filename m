Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C99ACA1012
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 06:16:48 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.46])
 by mx.groups.io with SMTP id smtpd.web11.32810.1756966604374136264
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Sep 2025 23:16:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yYpr8UTm;
 spf=pass (domain: siemens.com, ip: 52.101.83.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvjvM/OeNu/9WTx5lQdvekTwx455sMf5lHq3vWsCIy+65bJAlmTlO20YTQ2qyQM3mc5WEd5YW3yrMblgXVSBppeGgQoPDloJUncu91b0MBhDxkLwtA7vLRAeK78GUs3GS/ke8yvsDwvsKt3agCMJeV/Ex/M+CLyjneVoIIvDqLkj674eg/W6LtSZTFdMXcyMZrHyhTTjzaVExTV/re2hSXkSFEt4BLzLoXzt0Q6tyS050pF6Fn3Hp6+3hxuLyK6nC+5ExWGYz9HzB29AjjZ+5on+JX52NleAQ1TPgeAInRZDGMruFxhJMCM2G4Cb36oz9TEBq2RXaLw4CU63zhDG2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyeLImIyncLls7Lad0O5cEIlmVabFbDYQM1xQG5x51k=;
 b=DBmzfN9f+pwKF/FdMOfB5JdOrzia9vuYvZu0M8oiXnM9bEfcBqLMuA+LaVA6Yz/p0TAY63WW8vagB6WhneyW3iiJrsRpKmOObWTI0utN6+BnpDYoA8G1NaT2BDyKdfZKIVrB0IYl8emyZNZzZ6Gs8MjVjWSsy2lZjdzCKJqOF0KJns5Vw/Z2lFFIweeLfVzAuWEcUuxwRy+z0L+uc9G+MokRrcBmgzoBWJEARDkkWAw0kXJdcaO1QHKmZz1y9BCvONLhVL7S7wyoaOJfu9jRt2hQCeZP1L7uWfYvsSNM3e89ofUj+vDPxq/zcqXTELeCVJTu1W+HoOIJ3LtXKvtWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyeLImIyncLls7Lad0O5cEIlmVabFbDYQM1xQG5x51k=;
 b=yYpr8UTmLH7ON7echkm5NG6A4GstGPWDeUljp8FFOs/Hdx3jKK2mFJYcOhuOqZfejy2yd5cv9V4oyoQJd5WnWwk9Kb+wSOBvL/3La9zADpIaUbDTMoOepS3jS1YAn7Yn9Fa9+6YjmMa9XqgUjY3XFezNgJfauUDQl/U4/i6LCV/Ilcm9QO97Xbft//9wUPmJH01EuyT0pt88hnRZ1P8xqMR4gSQFTD6BMzodav8RbWe577qQMzhaowLCWejVn0H5dDf9enu9RdqkivLgfl21J8Jyxjwng3i+OSkaq0cXhAmZxpNOsmq8fZE9KRUhNgd23IKMZc1JPo5cvXy0rtHC3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 06:16:40 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 06:16:40 +0000
Message-ID: <20f07f98-2616-4353-9c5c-13ac7c5e9589@siemens.com>
Date: Thu, 4 Sep 2025 08:16:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: CIP IRC weekly meeting today on libera.chat
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <be1f56cb-eb04-4dd5-8566-eeb458b1b46c@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <be1f56cb-eb04-4dd5-8566-eeb458b1b46c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0421.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::6) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB8PR10MB3706:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c6c3fb-a83d-40bb-7e6d-08ddeb7a9c71
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SGhwU2J5S3VBRzVCQ3c0UXVDZTJvUUx4RVJ0TTVHeVlsb1Ztd3hKamJQTm1D?=
 =?utf-8?B?a3pId3BPeExtajhXYmNsTTUrT09QbU12d2J6OHpWc3JGSjArM282djVCTFJF?=
 =?utf-8?B?Z2RMTHJVaCtYeXViNm5vM2dRSFhRcm83b0Z2MkpSbXExR09XK1Q3QVM1Kzlw?=
 =?utf-8?B?VCt3Vm5nWXJ0d0pxdjIzdFBOWDRnblNuc2dkTlYvZ3paYThpeWRiR3ViUEdE?=
 =?utf-8?B?R3JndnViZWl3ZmdWbVpzQjhNUzI4M2p2OUxWdUtMc0xOcmt4WEEwMm00TmFU?=
 =?utf-8?B?aWlzNklORTFnVWtRVTFiUm5lanZJdzVQSWVpSGVnQ0NobVhqRzY1S0ZNRU9C?=
 =?utf-8?B?cVJGS3UvWDZ3WGl3ejlEZkNacWptVFlqMWVtbE5yWm9ncXhPME1GZ2prcFU4?=
 =?utf-8?B?MUltWVhzYSswbE1DbWNCYTR2cGJSYTFka28xWC8vNkxGL0Z6RDlOZjNsMFhr?=
 =?utf-8?B?c3d0cU9wZXdreUFWeXQ1Tmt1Yk5IRjVvcG85QVU0SFRBVlRJOFd1YUZSMFJh?=
 =?utf-8?B?eG9rcjlSbTJMUVIwRGtzSDRJOXAvN2djeUxVV1VobUtZUitQRDF3VGxjUUlY?=
 =?utf-8?B?LzBEL0ZEcWJIQVo4UkpOOWxkNzBkb0R3d29nTTFvaWJ5UzVtamlsSjg1ZlFI?=
 =?utf-8?B?ZllLV3JBQk5nMDNRZGtXelpKSnk4cDBSckx1bzBYb1dPdkZzRW91cW1HeUt4?=
 =?utf-8?B?MlZTNjZXcTlRTGVUVUJkZ1hNQmhScnBQZzRXMFV3Syt5REttTnQ1NnM3SlBE?=
 =?utf-8?B?UnVqeXZSOXRLL3l0Rkg5eDVZSEFTSU5EUHlNd0psdTI0ZWQ2SFBXaXdsY0NY?=
 =?utf-8?B?YTdITmNyOVUxTE9JMi94Y3lyRlE2WVBRNXY1dXBuSStBUUhxV0NtblRvZEkr?=
 =?utf-8?B?NXRxOEF2MmlrTTRqdWtrcnJlcE0rS0NaYndSYjRUamJHNHNxWE9JamxnTWgy?=
 =?utf-8?B?NUFQVytBMGNwSDBuWXE5TmJzd2NzS0x2aGZGODhkZkFoZzB1Q3d1YTdNeHFT?=
 =?utf-8?B?NjQrbGhtRXNvamtPRkFZM01LSnlONWZPajk1dFZXRkpMREtJdS9yZXBlOXMz?=
 =?utf-8?B?NjhQeVN1bHhxOFZSbzNMWUFJMnVVRlJvWXF0TnBHdkRwMUtlcDkrb2ZLeC9n?=
 =?utf-8?B?UmxRRENIOUlvMlFGRE5XTGZKMDRlT2s4VmpGazR6bW05N3RhcGFNR0w1dHZr?=
 =?utf-8?B?OXZFdGtQdHA0a21sT3RsVXBnR3ZDVEc5MUhXS2ZiZVM0Nzg4Rms3TkllMWw5?=
 =?utf-8?B?YkFOS0JxbDE2NlFtZFJsUWFYQlJvN0l6Qy9KNkFabzFKeHkxZTdZdU1RZzVv?=
 =?utf-8?B?TVd5aUJHeTdsZm1OSThLZnloL3IvNWozV3hlMGxRUjc0U2dCam5aYUdRQkFV?=
 =?utf-8?B?QjVmT00vNFZsUUExd3prQjFmT1E1ZjBEVFgxb2xRTHQ3bnVWMGtiM09mRENh?=
 =?utf-8?B?MWV0WjJTc1dSVVU4eWVLam8vWUhwckhMMTVSbG91QkJSTUFXTXd0TlNST0Jw?=
 =?utf-8?B?TDZ2bDJaUmRtYkFwY3o0K01mQVU5cWxCUUtaeFhqRnEza2RMVGpvek95Y01p?=
 =?utf-8?B?di9YQXJXaERvanhZM1FLZUcyampKdGdaRjVqK2JrVmlvWVJPajZHUE9aQ0hr?=
 =?utf-8?B?MUdUMGhnQUwzVVlyQ3RCRFdmMHZTemJtaVBNbVplT24wazFvb3NSdG51YnBm?=
 =?utf-8?B?dVdORng1TDZmOU5tbDEwQk1SQWw1ckUwOExJNE4xcVdDOFZUSEZ2Qk5SVG1k?=
 =?utf-8?B?Nzloc1IxM2g1SXg0SXN5SmRtMGVDTlVBYkx4R3cvS1kxaVMxMExCeFZIaGNP?=
 =?utf-8?Q?1/98jWiTdWZyzu+nvVgYdNNusRrKFORtmvyHo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N29wbVV0NzBVamJMZUs2eC9ScXV0c2wyNlNocXJQS3QxcTNydWRqeGZPSDgr?=
 =?utf-8?B?cEtFUHVGcmEvdG1wYVMrak03ZjBMVXlZY0tJVS9QYzRXc1FtMGJEcExHSG5t?=
 =?utf-8?B?RzU1QzB4K2dlSjFSK0xiTmgzTTdyZ2ZaeFJsM3c2amp3NU9DVFJsL2xGdHd6?=
 =?utf-8?B?eE0rbTZjTXB0VTRPQ3d5TzJya05ieGZBN2FCMDNPY1RzMzA3TjJYV1E2S0pK?=
 =?utf-8?B?bTFEck5OYjJzWDA3YVg3bU9yMGRqNUtKek1GaGJwc0ttSDdla2VxVjJGODFV?=
 =?utf-8?B?U0hldnZaSFovcFBnWW5CT2trbzFPS1FURzlBUStnQVhVOHF1SC9VM1lnZmVp?=
 =?utf-8?B?WHdiQUo4eWRJaXJqU3ZRSWdNazlsUHJJa2lGTjlDaUhPUnc5OUhNcjI1WnNG?=
 =?utf-8?B?UDJDeXdsY3B6TGM5L04zMGg5V2V2UkhMcWFnb0phOWtvSzlpdkNreEhuUnRH?=
 =?utf-8?B?MDFlN3BSUmxodS94VEhCYSt0TDV4MHkyeVlUdDRpc0J4Z3Nhdk9OTUFaeUVl?=
 =?utf-8?B?QjFWdE5wY0VDZlJFTGw1dERsOTFKaHlZaTRtUEUxR2dTdXZFN0dZRWlUdi9z?=
 =?utf-8?B?QU12QzNFcDJQQ2xsL1NEQ3JMQ1llRURxcUJZbUtOSTc5enhvVmVNdnZMNG1B?=
 =?utf-8?B?QUo5SlpkNmNrWGMzTWJubEovS1NYK01JSnFZamlheEFuR2IxY1EzYTFhMUJE?=
 =?utf-8?B?Z3lmNmMvU2x2K1BoLytQY2IvMHJZNHpJUStzZ2UwZXNFRCtqUklMYy95eWhP?=
 =?utf-8?B?a0ZxRWRFd1JzV1VoZW82elY1dDJScEIzZDloeGkzRUpZMUQya2FtWnRNUzRn?=
 =?utf-8?B?WVJER01jZlRGTEhYRUNUQVliaTZ3RExoTHBXby9Sd3Q3SE5xeHc4YjlBYlBP?=
 =?utf-8?B?aVl1TVh6aDZOYThyNysrNkU1aVQ4RWNSSE5JT2o3T0dYQVRvV2dOQldNRFB4?=
 =?utf-8?B?NmluaGR2Skpia2p0Vlo3WEIzTG0rdFhjSlVqWXp5WEp0Tmo5QUN0UWQ0bGpl?=
 =?utf-8?B?bXJNUmI1TTlheTRPOE5aK0Qwb3VjRnB3enR0NjlhTEpZRklYVGM5TDl6WnUv?=
 =?utf-8?B?L05YZFltMkZBRVlFdTNweXRvRWFsaldDSFBXWWlkOXBVSFVYWG5nQS9GdHJY?=
 =?utf-8?B?NXJOVytMR1N1UjNPR28waElOQmZoNXN1WThLc2Z6NlVURzR5K3RNN2oxbzNP?=
 =?utf-8?B?WDgvdGFUZHFCQ05adjdZMzFFQmpLakhUVWhZV0dVN3ZkMEZXYW5PTXg1UlZk?=
 =?utf-8?B?TGdUUlRuSi91YUdpVFUwWndQTHpVTUJMSzl3U3JDK1plWVdKYmxKVXlLTDJM?=
 =?utf-8?B?MG1CbmdwaXIzTXI0ZUdIakNZMDl4aGRCRjJkSUhuNVZ6N0hmbEVXQkFLSXFO?=
 =?utf-8?B?SDZ2UEh0Vnd4M1g1ejF3L2pENzVoUDJzUmZkZUhMWU45MmZ4V0c0dm1xd1hZ?=
 =?utf-8?B?V2lJM01aQ2t6TmsyeW1mY2sxdjFlK3FoNVRpdDRWUTI3TWdVVVhKdGVhYWRv?=
 =?utf-8?B?emRDRXpEcUdpOGQvT3B6a3V0VldRc1A1RTRlYzNiZDJIZTdpWllIVURLWUJP?=
 =?utf-8?B?ZStxRUNKeEd5d3NjcVBPQWVrYzBncU04UmhPbUZNUDBlNDFOVmlNVXUyY1BT?=
 =?utf-8?B?MjYyS1BPTklLV1ptUEhSTXVxbUJ6eUlNZVU3enVScGdlaStkcVFqREw4YXVU?=
 =?utf-8?B?V1dVbWU2alA1M2N2ZVFiMlhZOVVoMDUzZCsyVUV6cWNDVXZIV2RtWFVHa0dq?=
 =?utf-8?B?RGxmenRVc216Q2dNMTJpbXpGWENITlhzR2tDbmNlS1pxTDRzVFVQZEVxN2FD?=
 =?utf-8?B?Y0V1QjgzRmlHS0M3b1dPRXFJSU9RL200ZmxMazZSWkJ1d2xrTnpNbmk0R2Jp?=
 =?utf-8?B?ZFJYb040NHZtY3hQc3RhSTNqa3hZR1pjUGNTVGVvTHVLNnFGcUpsK0VVZEFZ?=
 =?utf-8?B?TnZLK2xmbGJIalhIamJ4blhOaXBYeG8xNGxzWGMxWSszWE5sNXNZL3h5dUs5?=
 =?utf-8?B?NTIrWHEvUStkZDF2WUExZzI3YjlHem9uQ1IyUWg1QTd5Yzgva2hhSDhMcUhq?=
 =?utf-8?B?Z1FlWThiczZVNUphMC9LeGRhZEwzaCtuRHc2aEF1bWlITHZDa3VXa1VoYXZr?=
 =?utf-8?Q?J96MIFaD5U6RKGt14OG7JSECd?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c6c3fb-a83d-40bb-7e6d-08ddeb7a9c71
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 06:16:40.1651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AWe1mcNuoN8t72FSWr5vCI9qX7TtrY1YtCfKMLkyRULoAZzXU+gYaevktMsv61/t7qZyAgUeAuLVBr/MrD42w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3706
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Sep 2025 06:16:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20006

On 04.09.25 08:15, Jan Kiszka wrote:
> Hi all,
> 
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
> 
>     irc:irc.libera.chat:6667/cip
> 
> The IRC meeting is scheduled to UTC (GMT) 13:00:
> 
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=9&day=4&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248
> 
> USWest    USEast    UK        DE        TW        JP
> 06:00     09:00     14:00     15:00     21:00     22:00
> 
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/08/cip.2025-08-14-13.01.log.html
> 

Sorry, forgot to update this:

https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/08/cip.2025-08-21-13.02.log.html

Jan

> * Action items
> * Kernel maintenance updates
> * Kernel release status [*]
> * Kernel testing
> * AOB
> 
> Jan
> 
> [*]
> Date the data is created: Thu Sep  4 06:15:03 AM UTC 2025
> linux-4.4.y-cip: interval 30 day
>   latest version release date: Mon Sep  1 01:59:32 PM UTC 2025
>   limit date: Wed Oct  1 01:59:32 PM UTC 2025
>   Status: On track
> linux-4.4.y-cip-rt: interval 60 day
>   latest version release date: Thu Jul  3 11:41:37 AM UTC 2025
>   limit date: Mon Sep  1 11:41:37 AM UTC 2025
>   Status: *Late*
> linux-4.19.y-cip: interval 30 day
>   latest version release date: Mon Aug 18 08:36:05 AM UTC 2025
>   limit date: Wed Sep 17 08:36:05 AM UTC 2025
>   Status: On track
> linux-4.19.y-cip-rt: interval 60 day
>   latest version release date: Mon Jul 28 11:47:40 AM UTC 2025
>   limit date: Fri Sep 26 11:47:40 AM UTC 2025
>   Status: On track
> linux-5.10.y-cip: interval 30 day
>   latest version release date: Wed Aug 20 09:54:43 PM UTC 2025
>   limit date: Fri Sep 19 09:54:43 PM UTC 2025
>   Status: On track
> linux-5.10.y-cip-rt: interval 60 day
>   latest version release date: Fri Jul 18 08:16:28 AM UTC 2025
>   limit date: Tue Sep 16 08:16:28 AM UTC 2025
>   Status: On track
> linux-6.1.y-cip: interval 30 day
>   latest version release date: Mon Aug 18 08:37:35 PM UTC 2025
>   limit date: Wed Sep 17 08:37:35 PM UTC 2025
>   Status: On track
> linux-6.1.y-cip-rt: interval 60 day
>   latest version release date: Thu Jul 10 07:45:38 PM UTC 2025
>   limit date: Mon Sep  8 07:45:38 PM UTC 2025
>   Status: On track
> linux-6.12.y-cip: interval 15 day
>   latest version release date: Tue Aug 26 02:50:14 AM UTC 2025
>   limit date: Wed Sep 10 02:50:14 AM UTC 2025
>   Status: On track



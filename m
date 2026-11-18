Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7007.1794982153672316862
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 22:09:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tPwGNDWK;
 spf=pass (domain: siemens.com, ip: 52.101.70.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tM4P3UNcd4gNOZrFwdS0lnDubOta63lqaMzQ0Wzx3+zKO31OSGCelw9QhRP3aauYBKNqhenC3X51mRf8izf/2q7WsQyzT7t7ZvEqgUMjR2cYX9lfAj7tIghDV3mjNimHiKzNhiIRO3qyaOVt6NrQzDI4e38DNEDG0tAJ/GHMYCuZz5ZAx6qsuedh47EMcSd03QgOJlMJo+bd3qc4LrGhVH7zYq66UlPKVTxWIWSiATTi5jOwmS4w6ONB4m4+r2qU6VHVGCU2m2JeoG22OXcdds+wrrs4gwnxRB9/ld2xzHQpHLYg9GsB55+QXxlS/95vxeOFd/6Q3k7Jhs7wilupnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BG9H+A6eQ0IkeX3AAmaizy/O/9JVJHcpkV9MQB9q5w=;
 b=TqqkcQPVdxPLmydyGuNN3HxIw+7wCxJsJ2GbOjuEZs0iGXGxzbU/t5MtkaFDmlQfNcgD81mQcoSLl+7XsGGyot0GS/WItOGQ25XM7b61TmwT3Qa4L2CwzIUttMHU8QPHLqLD41mR1LvJpjLbvLWD03QeZCLnJbi7Oo7NMsLCQMJqdFRW5g6hNd0oO0NVeSjpio8BbgrQVTIhyAsZHnNK0Ej9zJxgqnWw/TKwmwM23czhjCwscY+T8npVBtitg14nnIUKhJnF1BhUL1CttadEcczGqBUdIP0fl3d2Rvh+K+iRzsXUBAijMIC5dERh8CLFwuwazfD+1gP0cgI8gX4lzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BG9H+A6eQ0IkeX3AAmaizy/O/9JVJHcpkV9MQB9q5w=;
 b=tPwGNDWKkjJkERlsgtLt9miMPHUgfkvrScPhMtJiC1X8hn1ZwusnLL47/q6gac6/ut6bS6KeMl08rE8LNrLekaPhM9bEm/XnUOhIowabLcT2YtlXqYfgyNBWqSNrwMcw+2/fE2QbYv1fcANJg0edxsN8f/XkxXm7Nj+GwUhuZu4n1wwWlxkxxRGcIlwPGbI+Fvp4765BNirzZ6qxev8uXh92dieA3WHyJhAnqknZFHbO0Ub+4WpXry4NN0pqZMLDKNBzsojZPs3d+EAGERgoV65DGMBr1oDLiibb7fP88vzW1YvRO7B/94LEWhXCWp+430y0c4ISujQ0H1MaPmrWYw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AM7PR10MB3841.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Wed, 18 Nov
 2026 06:09:09 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Wed, 18 Nov 2026
 06:09:09 +0000
Message-ID: <63257a1a-dcbd-46ea-958d-fd4fc876cd2e@siemens.com>
Date: Wed, 18 Nov 2026 07:09:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2026-99288: Re: [kernel-cve-report] New CVE entries this week
To: Pavel Machek <pavel@nabladev.com>
Cc: Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
 cip-dev <cip-dev@lists.cip-project.org>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 Ulrich Hecht <uli@fpond.eu>
References: <CAODzB9rb+qvRFhe8UcFY2Pt-j82sqgpS=mfc4NbCrbdwww2Tpw@mail.gmail.com>
 <4b4745fa-2a9e-48ea-996f-fff98ffec832@siemens.com>
 <avzGdm2kkPzk8cLD@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <avzGdm2kkPzk8cLD@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AM7PR10MB3841:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd75635-0559-40ce-a788-08df453a7577
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|261028144727099003|261102123227099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003|261009223027099003|55112099003|6133799003;
X-Microsoft-Antispam-Message-Info: 8kAnGOQvPrUN30+PO1SX1N27MTjxXSbr4MFG8a/6+KS4mOKs2gC4rlKk2D1586kln5+V67HXIOwFTrN1IiEVTQtV1xFlg6uwsm3+VTZcUVkaczKizjfWApn0atdJc0ye0GxKuUMY58dZdalmz0G1skTY+MYtYJZoPzP/iNR4d+rK8HE5Jd4fGIRgLJAEpzEE2YZ12FTa7j+ffxr5CIwETqdu26NBmau/tc7TM5KaybEOdqIZ05dYuK7zlKZty43FKxDGFiQrV9rgrTUu1kTkoWOxNfptSpWz9zpIKzpQ8MGnIRaSWZC5bV1xV7+y/HnxA6NDm/HURAWGVq8x4PyWQ3DABhNT7xcim1mEZiIYjAI1lafm7lTHfr6riFtaBAL5TKkVu8DfZxF7brFZBZFGiIzNH/jjKxRGja86F4JfB5xFW91RjiAOz6rgppVo8brxPLVQZ3vD1QDmaBqwTIQw/4jY6Fi2KgmNZTPfDGEeKbEIl7bTlqyTWza7/sd8vBWs5jiVtCYHz9fRcQOtvr5AWDDQ5xKGcvbCYHgnUQk0rqIQtDyPwkiZeIv7yb94nY9AKeKu+pNRIVSylSju5tZRlDVXDGDN0hZT71nVf9A1G3rQoim5TaoNpz9HGE/sUDmbaeq1j68dUsq73AaKLJcb+5dBzTv4lnkqABOyD2KHKMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261028144727099003)(261102123227099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003)(55112099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b25oQndvREx6VWF6Tk14RE92QWZrc25HVGZ3UnJwS2YzSjJFbGlTbU1rbi9m?=
 =?utf-8?B?eUhqaTZOUW83TDdBQit4UStoQUkza2hmQ05VOXphVHVMZ2cwVXozNXlJYlo2?=
 =?utf-8?B?aTRFdFEzNitDMldPZWdDQnpqcTdrbW9LcVV3MDg1dEliREkyM0s2V3RlWEIv?=
 =?utf-8?B?WlZWQ251ck1WMDVNbnNqWWFsSjN4MGpGeFhpL0laOFdRcy9XWTJNWm0vVjBU?=
 =?utf-8?B?S01RLyttRFFmbUtWRE9VNmJZV3FSRkpzZ21pRG5BVkVScGt5eUtvbDlSVnBZ?=
 =?utf-8?B?YlI1RU1vZWZtWTVIK29DZmc0MFdoTVRZdCt6S3U2dHlSaDY5S2c0M2hOUTVC?=
 =?utf-8?B?T1EyQmwvRXZ6aEZmdHl3U3pwckV5cTAzekh4TUVWRWtGK3FjSU9mOFZ5RWNp?=
 =?utf-8?B?QXBnVm5ZZk1EWDM5K0hMdk5tSUlOWmtpd2RKNG9TTzZ2N1J2ZnJMTkpuaFdB?=
 =?utf-8?B?RW4yUFF6Q1ZIODl4ZG13cVd4ZzlLQUM2UGRXcmM4YzNLZzF4S0JqVCtKRjBt?=
 =?utf-8?B?YTBkUkRqcFBYVlhOdHBRb3o3MEt3Z0lNUEhVSDhqMHhoQUt1N0FWYThGSXRD?=
 =?utf-8?B?aDFsVXk2VGpJUlA0bVIydFZ5Y0JWVjcvOTB0MEk5N0Z4Y1Y0dFJlUEQ3aVlM?=
 =?utf-8?B?dERzdkg5bkVSYVVFREpRWU1ZUE5hUDZQRE5kaDloTFBET1hnSzlNRXZSRVlH?=
 =?utf-8?B?NmJscFgrU1BYWkJGWTJJWnY5V3QyTGRWRnUzMWxnUDFxRFl0dnBUTm9pbDhB?=
 =?utf-8?B?TDBPUENMQVkrZFIrYmxvaS9wT0FmSExqdEtxdkJMRUJGdzEwOVhscGsyeWdt?=
 =?utf-8?B?NzhvY3pIam9rdmt0L1dOaGkrZGl0UVN3eWh0K1Z1dEFSR0l5NUxkVlRiR2x6?=
 =?utf-8?B?Tmt4bWZFWk84RFFBMDg0alNzRU84cmZxTHVvVm9Pd2JuRVdrRGRaOWl0LzUy?=
 =?utf-8?B?aEJEWnBFK0RaUVAybk0zV2RodThPRlFnc29nM1dsdUhWL0lhOUp6SlBhRTF2?=
 =?utf-8?B?cHFkUzdPYk9KUG1RUm9MemJITWhNdDJKNGRLWmEyWkpjanV4NHh2dXJCd1oy?=
 =?utf-8?B?WC9BOUczYW51NFRRSGF5TEcvYVlrN2xwSTl2eGh3NVlBQlB3ODBqcUJEMUdU?=
 =?utf-8?B?QXZ2OXRoNm04WUx3WDE2N1FSMWdmVXJpUU41c0dUYllGV1BFaWQyWk5jc1k1?=
 =?utf-8?B?dEF4TE5OV1BBYVpZUld0ckg3VVFMaThpbDFqK3l6Y1BiQ0VyVXVLTXAvOVZr?=
 =?utf-8?B?YjBtanBXbVNwbXNhZWkra3pmbDBuVElnR2M1UWEvSnZsd05tUWZ3d2VMdWtS?=
 =?utf-8?B?SWlWSE1NSldoTjZVbHh1WmJucTRyMHM0UmprYlQrNzFqaXhKZEJFaG45QWh5?=
 =?utf-8?B?MG9ZV0hVQzgvbnk4d1QrQkR5MEdLaER3Y0h6MWkwQnhXS0pCL3I4aklJT0E0?=
 =?utf-8?B?YU5xQmpHeXF0dnJBZGhKZWpuRXdEK1BYMThVWjRHN2J1ckdzczIvMGN5TTFU?=
 =?utf-8?B?T1puWFJNc08yN0pBbEFRcnpScUFHNDlIb3RZVDE0K3FxWHF3b3BUYWI3UXE5?=
 =?utf-8?B?QkxlWndjQTJlS1Z2ZXpUL2lTdUYvYUxFcTQ4VGg5Mnc5RzZhNVZIbjZYOUYv?=
 =?utf-8?B?d0FVa0NFU1lIRldVejhXUmNseUo5YnVNV0ZlajVKeUFPVUxVWlZESWNWbmd0?=
 =?utf-8?B?N2tuc0VJeUtXTXFGM2NFM2pPNSt2WnkyczBsVzVGN0V2eDZqZ0hpQUFWb0dN?=
 =?utf-8?B?Zzc5YmZ2NlVYbmhsVnNlQVdQMThQU3RyOEduYS80ckYrbm1NQWVDbS81enRV?=
 =?utf-8?B?a09EdTRycTQvR0lJZWJKS01QQnkzM0N4UUVtTVdzeHJtMEVTQlJIbGVVRnhF?=
 =?utf-8?B?MHNuV0l3Vks0cWJ6dlJlT1E3T204SXBzL2FLUzNoTUJJS3dnZWFBUStQSjI3?=
 =?utf-8?B?RlhHYU5ISjVON0o3TkkzdGNCTzU0SHdtd3lnWUxzZEJHeUM3aThYVXU5eU9I?=
 =?utf-8?B?eUxEaWU4SXR6cUVLTkR4R0wzc0JNV2VJd0VWUEJEek4vMDFQRkhYaWw4WWc0?=
 =?utf-8?B?bFdHOENNbXpVYzFIcjdmRVdlRWh6QTNKam5VTk56TENmVzlHaitKNExpYlZN?=
 =?utf-8?B?aXZ4dDhkVjEvajQwWDIycFl1Mm5qQU1wWVMrQUs0RHFLNGNYdFl1aEtlUEtu?=
 =?utf-8?B?LzJxc1Mwc21vQkNxM0xYSm53dzlOdkxTSHBOelVEU1hhNm40RmZ6Vys1dHI1?=
 =?utf-8?B?by9yWWppVjBTczlPdVNmc1ZNTkZybHlDQklBVlVVbng0M3lNN3FHSGJ4T1l5?=
 =?utf-8?B?NmxnTENZN0hUOWNvMmE5VU1HUEtNbjZhTEZ3MDdpa1ltQm5ZTGNlQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd75635-0559-40ce-a788-08df453a7577
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 06:09:09.1864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I39qybFDgFL80ekoOJDpPmhPeFcoKwTBwHdvpX+B/mnr0+hWwveE2lK9r49+tx6Hy7hHyxCh736cf3RIbyeb1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3841
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 06:09:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24949

On 17.11.26 22:26, Pavel Machek wrote:
> Hi!
> 
>>> CVE-2026-99288: inet: reject unhashed sockets during established lookups
>>>
>>> Announce: https://www.cve.org/CVERecord?id=CVE-2026-99288
>>>
>>> Introduced commit is not determined.
>>> Introduced by 079096f ("tcp/dccp: install syn_recv requests into ehash
>>> table") in v4.4-rc1.
>>>
>>> Fixed status
>>> mainline: [4e2b3ef19e0e04adca38442f07dd6bc93c712bf1]
>>> stable/6.12: [d69100340b4cae08d40f898f1b601032403f6be6]
>>> stable/6.18: [8e5172cbd227fae32f3313cba1f3e1b9edb5c4fd]
>>> stable/7.3: [eb8a2d156f2c1d862fffdfd1b3432bfbcd939879]
>>>
>>
>> This one is gaining attention now ("NoisyTCP") because it allows remote
>> DoS in default configurations. Score: 7.5. Are handling this
>> specifically already?
> 
> I tried to do a quick research, and this seems to be more of server
> issue, and may be hard/impossible to exploit in embedded
> systems. Researcher's writeup seems to be at
> https://github.com/V4bel/NoisyTCP . Quoting "so it can be triggered
> against servers that have two or more RX queues, or where RPS
> distributes packets across multiple CPUs."

Just to be clear: We have server-like scenarios in scope as well.
"Embedded" does not imply a specific size of the system or performance.

> 
> sudo sysctl -w net.ipv4.tcp_syncookies=0 was cited as possible
> workaround.
> 
> If someone believes their machine are in danger, please let us know.
> 
> We could do 6.12-cip fairly easily, older would be more tricky as
> there was no suitable -stable release. But I don't think this is "as
> bad" as bugs we did extra releases for.

Can we support on this, or is this ongoing work already (<6.12)?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

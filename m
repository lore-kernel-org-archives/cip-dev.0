Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.28])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35287.1792985840908445311
 for <cip-dev@lists.cip-project.org>;
 Sun, 25 Oct 2026 20:37:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=h5ZPS6Le;
 spf=pass (domain: siemens.com, ip: 52.101.72.28, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThJmiTRSmMS/cxLCaOsWdxED5ADcVXeDRYm842/qRFFf4qJflGisF5V+PAZEajrO95zzhngBXaxfGA6WpRVTwwlK5Zn2u7XFRAX0UGKMkdat67V1mJPmnPPkkZ1wmGfkEeDP5ARrtOFi/DFfRWPBwCO6NDo+9yJPwAvmgvZKgkuT6CRC/5jhBPZQRZu2hlnrzdXlObUPUL2T742SFA3wjUwvNElvviyeOyQs4IGR39OcGodVaEOiEzb8xNpES9fx/KUBBhrjMoeHYyQwMoJ7RldkWxLhQ3zHT+wd51j0V0PTi6SQoZ1dUFiuAhnARx5tU/2emtxFxORSej/xJEtAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtUXfMdOagV7/P+rcIrtcXs+P3kcsMaf1AnMZLgDLRI=;
 b=X/RfdcwHpngmLRWmPRQbNKKSzrFYqVj2NkEmh8P8pcQCMEBed5dV7dvnQrRJZnk/igO1bxxqCifurafCTDN4t2rWqEUhs409N6pedlQkoRBPgM6CnP87FTH61bY9XFLqWzskMp0YCSyt2fvy863cDn/3HniqTczzJX5m21AXJ80r+9cIg2FRqab/bJt7MABkl7Qg704/u9I40rrufT42p4NoJaeHUJV5PaX6soAcW9oK5kIC6UCRgznRtPDzBySPLKoM52+NDRpFLmWgKNNtJw7ZZ3dYHWowupMLI9YSTd4IprX8sylgV7n1o2Tz4o/1Dz+PKX3fFr4M7uW9klIgCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtUXfMdOagV7/P+rcIrtcXs+P3kcsMaf1AnMZLgDLRI=;
 b=h5ZPS6Le3Pqqd4TWBlCds8ckd595g0FHSoDhQQ2B2smm8K+Mqb7hcBwgTXAxq9bme0AoDT1TU4EkOnMooxO4JC/OiMCk1fXA2Wk1jk+scTJNzU+F7xdtkqMVJ/85iY61ziF0GMyENTWJII+DxLm9H5kLiWLLTfvaW3KJNW0N9QGPxRgivXAxWUuJzycqD+Jhyh6K2UPpPl6HB3oU5y6df7mWos8eNPYE9IqoBzBq27Qg9Pg7dJwS2Ga+5NZ25Pv4lCnwVt2pDwR9Zd3Vu7RNNiUeyFdm2DG8KaudPvKr6w4ZIg4ZpqCdewTg7dI0kc7Ds+AL6VuldJzX3dYk04hc+g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AM0PR10MB071704.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:80a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.7; Mon, 26 Oct
 2026 03:37:16 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0569.006; Mon, 26 Oct 2026
 03:37:16 +0000
Message-ID: <432b267d-385a-439a-b8d4-ec421b7afd66@siemens.com>
Date: Mon, 26 Oct 2026 11:37:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH 0/2] Split swupdate signing and
 verification configuration
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
References: <20261020122932.470811-1-alexander.heinisch@siemens.com>
 <d7cfb3ba-635c-401d-9eed-bb2581c342aa@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <d7cfb3ba-635c-401d-9eed-bb2581c342aa@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::7) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AM0PR10MB071704:EE_
X-MS-Office365-Filtering-Correlation-Id: b0604215-5e9d-4b43-2fa5-08df33126e4e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|4143699003|11063799006|56012099006|261021121427099003|261022115727099003|261022105027099003|261022075727099003|10067099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 8WcTluJUeGjuvgRTCs05rtAXu9zSVkfguMZLdRBCV9O5csvpxeF159+S2Nlgn5rYjUnozMYewIYPSKb9cFgGaGdDznAguMThleRZhi4MwHw2omQtnfkBdNL2mCtLUYo+ZEe/jfFO9K5XSeKRpTyAyvnVzmhJQVsy7yM5O5PC3zxiQmXGGA6lmGaTVi8mWdQFm2oBtp2vH1523gd3fuMgpF29kWV1boI2myJzBKVgm6rAUkiKgEYQZjGjPlHhJOh5bnIwvSrBU6KM3thI0jF0BUFj5ZwN5azydNbJXqMYtSJBvP/Ou2XQmZr28EScG9iJ/LkeOrrbNOxotXpId0T/z94gCFX/h/8/Nno7pwB5TjAWO+i/0uT6LwE1NDDYSQvkCnyGnf63UtzhfZowIfZ6giS/OX1Wm2uecenKc4KtF9z42bNR1v42sp+3xpPB/sOiVIfARRwxrdz1nd9OEJKaAncwjLQNS9Vixj3auW+U7lpcjAyG3pARkgCg5qKCDwby/cPwIVPnRZlPDlR7LXO7X7OZpCV3KSaPuxiRIrTwXSbHnC8+VX47VRGJNhU0q/aqAVzI2A2GjO6Gg3vzr5U0Hg3A9JIzQtFBQUa2TFSQevhhQzZ+h7Yo0pLHs7AfgqJFKJ4z7njFR1nyANve2xahu7UCTj3lE1gda57VXSbcaYA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(261021121427099003)(261022115727099003)(261022105027099003)(261022075727099003)(10067099003)(55112099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDN3NVVoNjNlVjZ1M3hDdTcwNXNzb05ZVmxzMDI5U0I5SEtnRHdLNEltZ3VJ?=
 =?utf-8?B?TGdXRTNXZW5sMUlvMFc1NmYzdmFOeUdYTlRvYnl6NzQ0YTJnbjVtV3pyakNP?=
 =?utf-8?B?dWgzZjBxZzM0T3h5dHVZTXlrSjBWNjMyZWFUTGorNVRDQzQ0dXI0Nmt5bEwv?=
 =?utf-8?B?K28xODkxMEc4ZFVBRnJ1YmkyT2U3bWxweEhWNVRZWlF1OU13NkhIcnVKZFNX?=
 =?utf-8?B?RExNckcrckdLRFJ5N1ovL3NOVklvc241YTVtTlN2NEJTU09NRmwra0JXdEs0?=
 =?utf-8?B?QUhJQmt1MGJ5T0RtSkd3bzVWYXJlckRwMkNMYURPS0szYTRBNWNwdWNOc3dE?=
 =?utf-8?B?Q2lCL2ZwdklFTEZ0NG5qV1dXcW8xVUptRXNBd0FuVDk3YmRwc3pVMGVHT3gx?=
 =?utf-8?B?S25VOVBEVzJWZlBFNWRDcittNTFJTjJpZ3g0RlR4c1ViM1ZDR3VNd0NMUllp?=
 =?utf-8?B?ZXVRS2dvcmdLa2FyRG5VMythKzU2L1BCZHMwQUc0ODdteE5XL0IxTEFhOGF1?=
 =?utf-8?B?eGtML1NEQ2hsaFUwZXJNemFhSExHaDdFRlRJalVtYkllV2RkK0JmeEkxV3Vq?=
 =?utf-8?B?NnIyMDQ2dmdmckFWa2RRMFNvOWxlWW9kYXlvQXFrZWlQQ3ByZGd1NjRTd3lr?=
 =?utf-8?B?bER2aTFORGpvUHp6Q0hvOU9HdXRwWGljUkF6K0tDNkEzVVZlRTMzdFRFMGVD?=
 =?utf-8?B?cFVudW5tTEhZTDdXVnBsbU9WOVZydVRkZFJXcW5HNDQzYjRtbGxMNzR1c2ly?=
 =?utf-8?B?L3FEMzNwNTZrZnVGdDEzYzFMdDNZVlVyTy9qODdMQndBQW1UYTlSSW5LY1li?=
 =?utf-8?B?bUJMVzcwK3BVSngvV0JIMjhjTUZ4aGN5QnVwYkk4VkpDWlcvanJZT2JDQTM0?=
 =?utf-8?B?N1dCYkZmVGJveng3NUl3OVd4L0lYeEwrMk9WbmFCZjUxR2ZGZmlZaUdianp2?=
 =?utf-8?B?QVNQQnFxNjdZSGlJUWdNSmg0UlZRR3gzR1hXenN0T1pEa2pBZGRSTmhRNlR6?=
 =?utf-8?B?dWJLa2RuckNwUFFLRUUrcGc1aVNYdi9ycHpaL01zTEp2RE9IcFZqTTBaaWhY?=
 =?utf-8?B?TDlOMFc2REZlOW9LRmpwOXRESFIrbDBaM0pMenB2TmszcUFRYzRYR1huazFh?=
 =?utf-8?B?N3J6UWVkMG55b3JON25SYzYzdUlTUzZLcks1THhtaVhqeEhwekdENFNsNzMr?=
 =?utf-8?B?amFVOWJzTm9Pc3h1VGdlZ2YvYmlPR05hdzV5WUlQUmJ2TFAwenEwU1Y5enVq?=
 =?utf-8?B?VTRULzBhNVNSaFovaVdlcDM1NTJ1dnp5VTUwQ0cvdmt0VSsrUTJxZVBXQlF6?=
 =?utf-8?B?QlhkWk8wRzFyU0lHMElJN3c2VkY0Y1BHTWdibWUrSmxCcmVENytVYVVtcytR?=
 =?utf-8?B?N2FCTTNQcmx2RVE0VXpSQUtuQ3Rvd2lHaTdBdjFrSmZ5Vit6Vm1BdExuMTU2?=
 =?utf-8?B?RFg0c0FTUDErdGNwNUNoY2VuZGc0eC9hMjNmQXI3YmkreHJ2VDRpS25iMS9z?=
 =?utf-8?B?K0xrbW8zV2pBQjU1bWgzOU1XUmhiRFJMVDRwSytib3huQi9YU1c3WjIzU3VX?=
 =?utf-8?B?a0xIcDV5SnI0SjZ4aXdYVEFOL0h0ZFJBOXVHb3VpK050Tms5enVqakk4Y2Y0?=
 =?utf-8?B?RFVZczNxdy9WTE9HWGNHTDZyd3NsQ1FmUVpDYUliaWZEQUg2YUNjZkdwMFVR?=
 =?utf-8?B?UnB0dituMm1YQ2p5WDVpZ1J5cXZxWXo1RUdVblpLV044RlIvY011Vit4b3Ny?=
 =?utf-8?B?d09SQ3NWaWpLNmlGSVY5M3p2SW5pK09NRXdLWnp1WHJjZkpQYUFxYlhWQUZE?=
 =?utf-8?B?ejhBRUxxNzdhMWtsdDUxa0Q3R3BSd1YwWlROY0RPVllSd3ZyN2VUZ2pnT0RK?=
 =?utf-8?B?TU5wQmJDZiswK2R0T2J1V3l6ZUtrNHowWHk3dXVqVkIvSGdoQ1p6R3Z4NnRv?=
 =?utf-8?B?NTdUN2NIamFOWGRyaVNlOXhoWXNqV2VsczZkcFZ3Z3FEa3FjS0FMeFpiREJ2?=
 =?utf-8?B?bk1XOGRhS0NWck56YmJaenVqTFNOZlMxQ2lsaEswWm1SVEpTWHAyS1k3Vy9V?=
 =?utf-8?B?Qk1JVHZXejBKWmpDbG1PT0t6Sk92MWs1MEJRMGRlYnVQdW5WYlZiL09jMStz?=
 =?utf-8?B?eCttOE1nb0FCSHpwQWlKMU5HNk8vNjlLTEwxTUZJQ3NsTi8xT3VFSE43czFx?=
 =?utf-8?B?d0Zybzl0azMyZ3pBSHVmNDNYSW4zaFZtZ0gzMi9tVmdiY05FQXJFQVllNnY3?=
 =?utf-8?B?enhLcXdmUUNqSllLTzQ0MUZhZjB1QzlaVzFiYzBDalljd3VteGpNbHlxd2lZ?=
 =?utf-8?B?VG43ak5JR01MNGVRNW1zUTU1WkhyYkhiK3FJODlWMkpMTHpSQkNZQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0604215-5e9d-4b43-2fa5-08df33126e4e
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 03:37:16.5155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6MTK+qs7bOwG0a8EeWP5phby4NMaK08X3LCPkx6Mu49EuRjVEk1mlwyOJunF4UIud6G7fvyJcU+XHxSN4yl5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB071704
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 03:37:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24534

On 21.10.26 15:29, Quirin Gylstorff wrote:
> 
> 
> On 10/20/26 2:29 PM, Heinisch, Alexander via lists.cip-project.org wrote:
>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>
>> This allows downstreams to sign artifacts out of tree (excluding
>> signing done by swu-IMAGER) while still enforcing signature
>> verification at runtime.
>>
>> The patchset splits SWU_SIGNED into separate configuration switches
>> for signing and verification that allows for independent control of each,
>> while keeping the default behavior consistent with the previous
>> SWU_SIGNED
>> setting.
>>
> 
> Looks good to me.
> 

Thanks, both applied.

> The out of build signing sounds painful as you need to extract and
> rebuild the swu, but that is another discussion.
> 

Yeah, we could host scripts to do that if they can contribute something
reusable.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

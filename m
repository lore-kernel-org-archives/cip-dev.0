Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFC7FD8FC3
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 15:02:41 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.72033.1772118159232328301
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 07:02:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FHOL2x31;
 spf=pass (domain: siemens.com, ip: 40.107.159.47, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emrTEjpRELNapi5s4wqpv58eT4YUCjkEKtOra7mfQOW8Xi2ettfqCtmbQ5eXadTPXMKZmUSaVgE8MrQMvPqu4G8ktKsl+uvKT4uJjYSf7SNki5Bgw8h/j7oM6kcJEaNIOJkk8UkYWeh77v/GIgs0wc/cL83o+pQWHiKgfNoZB5jsXXkrjICGpnuAB4N8sIkvee/bUQWxyx2Fn8cQvU6f9eHQE8UzSm2T7gbBYmRisPhzJXE+nhtSh1Iy+CxG279fvkxeScuGQqRgMvL71EFnholg/NOtx4YCpjT5gVLd9jyjgvceq3thOjVu5VX84jnNPVpkOV0PJNzO++kFsZ4j0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GV8KsKg2sUfMTW25yzqvsx3hCzl/Vk53x8cMKpIEeFI=;
 b=GJlWBxSToSrR0Vt7hTEPSoq+0bY8uVUW0kAu9V7I7r2vrrOT49H+/nP86TsaMp4qnIrhxIr+HXIB/mRBhF30ZUgLiW2+criN3ApGRO80Eb4ecUvQkz5wDSJQWXkBHSG9Pn4VLuUbhUBEaku9iUQXJItNV3XZQV5UIrtWPU+Sa9jAJc4qyblV1EmjmB1o46W8K+0Gov3Zh33siMj09Gh0CqWK5DS8yWncpsH7xS5di8Agwu+kMCM9AP25J/INFaPdjoEgfM5gKU+0X5FdppyaTr0cK/PLe2OJ1YscSVLLVsB+Hr3HiVT2d97bi+jnlGTE86VLyzAcY7QhE1VdNUQF/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GV8KsKg2sUfMTW25yzqvsx3hCzl/Vk53x8cMKpIEeFI=;
 b=FHOL2x31TQDHVcCSB3qlInfFLDFYR7bbTf7t4arTM8mOUkHwAvdeMQcm7rSpuTPzquPQ6ckvPzCTS+4tXlKLP3pc8l2TIT2wp/rATwpjfjme8f9ZISglPeOQFJyXUvrBmHn7FQhsoeBK2mIbe8mYjaiohbVeRxlvXiq4dTLA1cEJITcTCgGhE8prmg2DSJlRCXjGGKvBoxf8KEz/mqx1srvjBXXxk+4aOSNkE5H+JYPQwr15TLcQOHLLr+gvAAPyQEBsyGTxdnWQKWHD/1g0j6bGZ4YRe9Kmbi93gZ/BgYETcyF4rdPmKWW7jIBoJjBrjVEVcwTNCcrHersJvspdpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::19)
 by PAWPR10MB7151.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 26 Feb
 2026 15:02:34 +0000
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b57f:1a19:e3c8:fbb6]) by VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b57f:1a19:e3c8:fbb6%6]) with mapi id 15.20.9632.010; Thu, 26 Feb 2026
 15:02:34 +0000
Message-ID: <abd469d4-e11f-49a6-a36f-af8b5e895a8a@siemens.com>
Date: Thu, 26 Feb 2026 16:02:32 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: Chris Paterson <chris.paterson2@renesas.com>,
 cip-dev <cip-dev@lists.cip-project.org>
Subject: LAVA Update
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0351.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::24) To VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:89::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2319:EE_|PAWPR10MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: 51bbb555-42f1-49f0-16e0-08de754812aa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	pPQt/FZHkJyJv2VycvX48toH7gfKIh2UvcK7TUda4iPMi3iNvJUvbqUNsbTkK/v/MqSG5qcI1RqumkKn3eG2TEL9KGP5PKh/q8uxEW8cEAcs6W0U0NsWZB7r7fC0TDBfMbabJJouEkK4DLmast4Yxef2gdqixH8XHZoJ59oFPBU7JoDqKXqGX03cCqLrUHwX+1UWoEXTD7jPV7oxah8cMLg8Fp3MvySob32+MCsV0f3KVo3ypFaHdC8SC7CNxhIO96OgZkCoTsUQJfY2Dop8CY2/4cwd97JUpJcaaCCEXk4/HzN2lXsrU/LWCdSG4NiyMLFemI8Z3yGAc47nBz4CQgmCpgdqMQKY3LpJB43gh+jSJcAkzKTIEqN1M9pLOW1g7cEz5TOXzUbqWLtkWqn0bNnNQWrZ4us1WgN4v0UE7Xm3SANQDbeEyrvovVP7G/X5feKLdLuKHqt1sLthPpWwDi8sAMnyD83juOW8jfQzXa7SZ+txve7fOXcPL+3n/bj7Ho3pOfujnrZUOLM1a8EM7Q5tEO20h0niRTJaddvSjWMvZzoobqMXMdkF9hHFFCQAApoUDjgJMT88wJJNL7QXr7+d3Xi49eeXnMhoozbd8UCrNDRUokaRXwhH7MIcBq4dyhF2+MlqDYZm3c2w6QjTXBin+MRCxgZgrRhJ9vluP+yIXt18qLewhE39siTGxPL0
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V2RnbW9ZNzJJalQrZStuK2FkVUl4a0ZCZi9IY2lpRURobnF3UW9GVXVNWkVq?=
 =?utf-8?B?WjZvYktzRWszTlBlYnA1Ym5KTktNakZpM1hRdGljS3cyaWZPeWFTRFVNajN6?=
 =?utf-8?B?bkdacndqdnNRR0NPRkRnR3FBSjlvQmlReTJmOGZHbDE2Wm5yVHNiNXpoTkZM?=
 =?utf-8?B?ckszcTRLMGQ3QmZFR1ZnajB6N3pWVndNM2tGN3ZRcm9lTDFRcUVKc2FmVHh6?=
 =?utf-8?B?OVFBa0lnT2FOVUY2NlN0ajAwcEFQZmRlRGZHOWhxdTNXVjdVNXdaYWtQVnJt?=
 =?utf-8?B?TlUrUy9ic3I1SUUvRk5FREtReFE5MUNtVjM5SVRMbHJVa0xzOFlXaWJsNTEy?=
 =?utf-8?B?QkV1eTd2dUdzV2NCeWgyRVhXOVBFdnQ5VXJ0YWcxa1F4UHo1WFZjM3ltWmYr?=
 =?utf-8?B?VzZBMDJmOS9WL2pBU1V1cFVhQzVkMFZSZTFCSkE2NDFlVFhnMXRLM0FvWGF4?=
 =?utf-8?B?bkJzem1PVnNBRDJXa0N1aXM4M0Z1WHZWdktSNUtBeDJkSW9Jdm1nelFXNWV0?=
 =?utf-8?B?cHdIc1l4NEZ3L2k1ZmN1MnBhZmJoYzRWRm01Ni9SWGxqOFF6VXQzQTRndllJ?=
 =?utf-8?B?U2dMWENCcVY1d2RXR1VsQitDY25GbzN1Z25wNWxhcnZubmxjeTRUdzJ1b2VF?=
 =?utf-8?B?dnlWc0lKNzVKN09nalVDak9rYlA5bHRwUzhaYVlNSFh1ckFvc3hxNGtybXox?=
 =?utf-8?B?OE9wWDdLTjE3UHNGbmNST3Bva25lQ2Q4ZXZ1REkzQ0pxSzc5KzdNTGs3bGxP?=
 =?utf-8?B?clJYWnRoaXJrQXBUaDJiNCtkYzk0T29Bd21QL2M1UzJZT2NEajc2UkU5WW13?=
 =?utf-8?B?ZlFlTjdYZmxTTG11QXFoVThmNVdpdzJOWFlyc3Q4bGtPQzNUelBhbFdKQkxJ?=
 =?utf-8?B?QVVTUFdzUkcwUDV0QVozT2lYTDNGc2h4SkZTMzlIeWhSYkthOVEvUDUzNXBz?=
 =?utf-8?B?Y3RYWDF2ald0L2p1YlFpbUxhZjRvb3ZtdHhvQ1ZEazJHamptZmVjeGpNbWtk?=
 =?utf-8?B?QjJDVXVWRmloT0gxYUdobjZlR1VCOURKNU41U2YwNXpyVCtaOElSMVN2UHpO?=
 =?utf-8?B?ektidUlRVEhvTHcwdEk1TnZkekhMakRqTy9JMDhJeXpkLytIdUZVaW4xWjFj?=
 =?utf-8?B?dkJ4MktNbEtSVU92Rjd5WEhwMlFOVkI3NkNKYjFNR1U5UlBxS24yNnZERVRw?=
 =?utf-8?B?a2EzL3Q4bXdBWGI4Q3F1Qi82YUQvTzJqakIvcWNXNWovZDBvZHkvUE5xbmN2?=
 =?utf-8?B?R0tpdi8zTGRidVhaSUdRckQyaFNkb2FNNEVCUVFZK2FyQ05WTzZWQ3I3cDBQ?=
 =?utf-8?B?cFdJMjd6R0U1VTBVOGxtK0xuTmVpTnRQeHF0YitLd2RtTTYzWkE5SkhwQUF4?=
 =?utf-8?B?WWJhdWN4WkpOU0haWEFBSXA1T004MGtiNEszcEUyU2g2VUgvRUovbHZiZ0h5?=
 =?utf-8?B?SXUzYlowQ2FRQllTdk5VWURVc1FtQm5Dc29WNmozMTRnMi9Lcy9GOWxzc1di?=
 =?utf-8?B?MXN6WWFvaGNSeWlMbWZvUXBZVjFyNjdOUjRkei9xcTh4cEgvME9PQnZTTDd6?=
 =?utf-8?B?RktDSDBrMmM4UUt4VE50QmdXdEVxOG1BYWJkdHptR3VyVDFRM0IyQ2lzWXJx?=
 =?utf-8?B?dDQ5MUxiSUE4OXlId2YvNXcra3RiQzlsdHpHNlptdlVvdXdKeDRIWnBMWjRs?=
 =?utf-8?B?ZVFmVTdCK1dxdURtY0RmQVlRRUVnQ00xSmdDdjdSKzhvYTBReUdoenFOT1o2?=
 =?utf-8?B?YVhERXlHYm1YdTRkS2NLNkNuL3EzV0hNbTY2ZkJEbVFhSG9CcytMZ21kNW10?=
 =?utf-8?B?a3lYcHF1V3lqbjdkaU10aFA5aGh2M0N4WTBzOWU3T3dWdi9PanJuMURvR0Jr?=
 =?utf-8?B?WitEOTNvVE9GUHJicktTUWxlSnRucnRuaWU2YzlKTUZET1FaTkwyOXdXZWNh?=
 =?utf-8?B?SEhMUE1Wb3Jsam5RTFZCSHRSMElhcFBaSktiRVdxWEZ4SThBMWw3WlJ6UkpN?=
 =?utf-8?B?YXFWSyswbWZVZThLSkpJQ3JkWFd0N1MrTjRKQkJuOHRRZEZjKythSFhhckV6?=
 =?utf-8?B?Q1pyQmdjN291SEpUaHFvUDJ5bElLd251aEk1d0cvK3RUYnNvQUZmdW9MZHh5?=
 =?utf-8?B?UCtweFZvZWxvNFRnMTRVK1NKTy94dTROdm1kWkJQK3p6VURYT250Z0kxN2Fm?=
 =?utf-8?B?S0xtZHVEdHkrQ09FOXdIZEhiVldWd3NmUFY5OHdENnJMTWcxc0RFNkJBVTh5?=
 =?utf-8?B?S21SUGJxdDcydEJLRFlJOXhCYTNtallobkZDRUVrdEtxZlpBQ3RyRGVIeTlL?=
 =?utf-8?B?TjZRRWNlUWtIWCt6S1dCSU1QWDFkL1E4SVh5em8yZEVoUk5YMWk2WTh3NTAx?=
 =?utf-8?Q?KpWVvMVSQRB+bUcs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51bbb555-42f1-49f0-16e0-08de754812aa
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:02:34.6516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJcWnaIy9pOh6e0AYAPk1G2wVYMRUzaSxiuS23mRnXos9ZJUB34V+jbaN1BxvcAw9kxLwcus3FHcf/3MvEUTPLkUIMmZPLtQ17I+QyfO2lY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7151
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 15:02:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21992

Hi Chris,

do you already plan the next LAVA update?

We could speed up the flasher jobs(e.g. 
https://lava.ciplatform.org/scheduler/job/1404609) with commit 
76a039fcca9d70a77ce840781fa93d01267d9fea (lava_dispatcher: allow flasher 
deploy method to pass uniquify parameter)

As this would allow to use the bmap files provided by ISAR.

Best regards

Quirin


Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A14C02198
	for <webhook@archiver.kernel.org>; Tue, 18 Feb 2025 13:46:31 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.63])
 by mx.groups.io with SMTP id smtpd.web11.19640.1739886387193885848
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Feb 2025 05:46:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qeahE26X;
 spf=pass (domain: siemens.com, ip: 40.107.21.63, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRVbTM1thQxE+xlf4EqxIswDHbJ7eqKbOZdEuv7EHMn2JZLljOMa8gws/F1Dm23c/4wREJkdPTYkN+B0jleCF7WTmAEJifLKlUyhrm7kLh/B8oxibdTRST6XQGrr8GgnFNVfPUW/Do8nsxm4uQcIkoOBiKic5vnj+COI/kKA85gv75kUDDMuTaNeF9aoVn0ggVaxnOemK8oLFG0UUDd0AsE8bidGBl5j/ra80iEuWgXO3JDSF+JgqhdowtmTciY3Vhxdsr+h5xM6144yL3LuIY9OS+HZkBFDUa1WyWP/iLIzlECG+bGHjqWtBUsXsKv5B6j/8CoWdnnE6z1xUOy5kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlmiravAyX9oIdLsjBF8F28hnBGtGnCAUYPiKPJDvRE=;
 b=KuGJhEp3g3wPOS5Vsxdr3CrCqWvwLKttWrFk1AVIaQH2C8A0HSwiuPX82H41t0iSA+bZgea/p+tBihfwa8JbO5bgWFSKzeWEDqki8DxkzPgQBMTFfqS03sgqM0VTnZttV/kOZLH3h70MNMfP+FT194SpOqHvO+Y2koZTvIEz/NlPrQG8UnWw3oXUUCl/aRsjrsqN5TwJ0JLuHQhac9ip6NaoDGLH/dheG+Z91qtAMzWAOOgYJBZ+j+7il6j/zgI5Dl0264VDtFW4deG5U5JTvBlSkeoS5zI1MitaOB8Ca/WfW6+HH0D46GmQ6o7EHRDCZDODR87NGqSTHg6ZNO3Bmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlmiravAyX9oIdLsjBF8F28hnBGtGnCAUYPiKPJDvRE=;
 b=qeahE26X6YxgkSUk0Cbz3LEiXe42NslY6DZRAc/vjaxEr4OjBMkS6rOQ47AKBfOU0yMRzsR1TeTJ3te0b0wWTy/e+1Q/bvV/E1N8pGafUxgA9OeiTkrl4e1cQuWB580tK37UTo6mg4xuc9ncojWBccJYgebqFCPh070vEo77U5XZBCp2UC4kGkkPutIMvEMNDqaajijngcm+VBHZSlvtYHJE/c2d//ZhgJ2Myx8bPz09kTteNzAa27zspZPkJkwKGs61LPOoOXjnYMt4k2Ur0Z/aCDMjSs3H/CcGuJ9XymJcMEhqJWXUmjoNoZ+poUo+qmWCsq7KDx7zN934BNHHNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by GV1PR10MB8025.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.12; Tue, 18 Feb
 2025 13:46:23 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8466.009; Tue, 18 Feb 2025
 13:46:23 +0000
Message-ID: <a1ac679e-0a3d-425a-b8c1-69fecdc33368@siemens.com>
Date: Tue, 18 Feb 2025 14:46:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] crypt: do not assume that all
 system clocks are broken
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20250214123930.701998-1-Quirin.Gylstorff@siemens.com>
 <6e5288b2-8c6b-4b87-ae50-2763e3146bb4@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <6e5288b2-8c6b-4b87-ae50-2763e3146bb4@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:610:e7::18) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|GV1PR10MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a0f099-ab8c-4df5-5f83-08dd5022a1ea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RHhnTDM5RmlqQWNWZVZrQ0kyZHFsSHRHdGhOb0VRVStsTGsveWR6QzlHV1p5?=
 =?utf-8?B?Y3htYTcvV3psYm9pT2M1NmJ2dHAyYWRyd3dkWDAxTS9QY0Z4cFJVU3M0NXdp?=
 =?utf-8?B?dEFjY3VTT0txRDlDSE43U2lXR1A5R1ZqS0NFRzJzcGNSRFRNTHVaN3hzVjRZ?=
 =?utf-8?B?M1hpSWtlTVhqNmg2Ny9rZEt3K3FRK1NNa2Zka3k4cG9yZVN4Wmt4VDByLzdN?=
 =?utf-8?B?T05SK0cwSENKUlVPU1A2a1I5SkJuUWRZUWdkZUQ3OU9LRVMvMkZVaHNrZG16?=
 =?utf-8?B?bnU0TURSdnI0KzAzS1E1MHBhMTBBQjhsSEEvdmxCeU9KNW5BcWEyT1EwMDE3?=
 =?utf-8?B?cXg4RHlBa3pUNXJ0ZUxrWXl0WEpYSHh5SnhoZjhNbUJEaE1CYndWNjQ4OUtt?=
 =?utf-8?B?L1pMZUhxZkhCQkl0SWxhZHR1MmloTU9Tb1QrRHdPRi83SHp0YkV6S01DSXla?=
 =?utf-8?B?eHY5bmlzZ2RTNlExZWU4eDE3ZWx4amhZb1BHT0RRRTlLYnF1UldHMzA2aXhN?=
 =?utf-8?B?WWlKTGhOM01nNlQvSXJPOEtNRzh2MUFhOEs5NkdkcDhQb1pNVUlEMlhzSjJG?=
 =?utf-8?B?YkdWTWpua3dKUDFWOVNoNEltalNhN2xqemNESVdLbGU3cVlIdWNiMlV2c25H?=
 =?utf-8?B?Z0xhckU2QjlWQ0hNSFRaelh2czlxak1PL0IyK1hpTURyU203aHo1VTA2Qlh1?=
 =?utf-8?B?RVVxelpPTFhYcjlneGJnVTNEdWZLSk5Ta080aS90K1h1Z0Y2N2pXNnYyNS9L?=
 =?utf-8?B?UDZRL0NBZzNjRU44d1hOL25pTmY2VVFUNlVINEtuK3lLUUdFNkZ2bUs3VDd4?=
 =?utf-8?B?NGNlMjlwN2YvMXQvK3JnZjVHRVJneUl4TkRzdi9iMlp5MjBTbVJyUDdxU0hh?=
 =?utf-8?B?bXVVblFLM1hRZlVOSE83SERZczFpbkFSTXJZcTQ2bkU3V1hxK0hyMGRCYjRt?=
 =?utf-8?B?M2FnbCtnSmR0Q0kyTDJlamhiT2FDRnVKUmVlVmw3eEpXWi9LbzRWbXllSzFM?=
 =?utf-8?B?WFNaNUVQOXpSZzZmOHJXVnk4cFJ5SGkyTnZnYWc0WExVeGlyTFlSSy9INWxK?=
 =?utf-8?B?T3dWM3NFMXhFN092dWlmV1FpU0w0NFAzQ1ZyS2NtQldYNmsvdU5aRkVPKy9v?=
 =?utf-8?B?bUY3V29tNHJGKzhheXIwMS9xSDNOaEFRallYVStRaUtLRGF6a0Q2cHEvLzYy?=
 =?utf-8?B?MHZoUW4wQk5HcFZMamZaTnNQTk96VVNzQ2F5Mmxqb0NpRXQvbG44Nk14UnYv?=
 =?utf-8?B?K2NQMVJjQkh2S3ZLM3B1ZmZpanZvV2ozQmVJdnIwOTMvN0JQeU10dGtDUXhK?=
 =?utf-8?B?Szg2aVdVRHZFRzdtY3RnMXdxUExqWGkxUEQ3UlphRHdUWWNTT2VHSTFHWVRI?=
 =?utf-8?B?SU4wUHh3WXRhK3NmbEQ4RlVZR3ZEbE5WOXB1bU5OUm9LWFg1ZHBsS3kxMjBU?=
 =?utf-8?B?VGlZMHhUWlMzcnczdXBkUC9mejhNVkRiQ2s4cnFxZ2ZJY21kSnFzbGVjbEww?=
 =?utf-8?B?THNNOXJVb3lQSXQyTFNMT1V4Sm5NcHFFbllkUVRCUmxoRFNRQ1BLdmdWc0Jn?=
 =?utf-8?B?OWpjR3RRVms0eFovZWRGZVVOQWhwN2JCYW91eFliaTE3OWtIME0vbXRkUmZZ?=
 =?utf-8?B?OFY1RnBxN0xZcDhnb1ZLbGNldy9aa2w1S0MyTnh1SCtRYmRFL2tQMmtQdEJD?=
 =?utf-8?B?amdQd3ZBTTdSMlFqR1Q0em9QaWJYdlpUWGlpQ3J1Z1gwTlJpOTlVcyt3QjRM?=
 =?utf-8?B?cTk3NnlLMTRiUFV6N1lvMExPcDZqNW5LbGhVM3BTbUJvQmV4TDVNdnl5U09P?=
 =?utf-8?B?YS9zY2dqdkFabTY1ZVlOZXlONXUrUWRiUkwvR0l6ZWRPOXg5TWF6VmNYTkwy?=
 =?utf-8?Q?EIbn3vBRprChj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TnVlQlhBU3BYV3pEYkloRlp4Z2xRQ2hyRWMySUtla3VVK2wrT0FjNzlaOVM1?=
 =?utf-8?B?Z2hLb0hYS2lwbnV3R1lGZXZ3RnRKOGV3Q0tKVk8zU0FUcTlZcTM2TlNJUG5o?=
 =?utf-8?B?bVVLdEdEVU4xcVFDVXpSYTBraG5tZk52V2Z4SU1aQXZPTC9pc3JRaEFVcXlt?=
 =?utf-8?B?cVBMRmJJN0xSWVN1dHpGN2pza2VKQXJuYVBqMnBBS1ZzNHpTM2xJaW5qVnpV?=
 =?utf-8?B?Y0FpdmNzUkM4MTZCcEYwVElxNGllNTMyeUtNMlM1VmVSbW1oTkZzTDRMdVhO?=
 =?utf-8?B?cFYxRmY0eStLTjc3ZUNJTjkreW1RMEE0S1RCWFR3Z3JWaHJReWw3aENMWDFo?=
 =?utf-8?B?UUl1L2dQZ0h5MjFjZUJGaCtMYWwxSWVzeFJudEZWb3NJZVhGWW1xTHB4TzJE?=
 =?utf-8?B?MXRSTEdhem5WOVF2NzByWDJYZFNkZDFGKzhjK2F3MjZvaWlWUEFEVE93STVR?=
 =?utf-8?B?UzJYb1NkcDJaaTd4QURGQXJvNlY5QWxBdll1OVNxYUMrVUhzd3NJL1g2a1Vy?=
 =?utf-8?B?T3BWZlV5Vm01K0NYWDdpYTkvN1l3a0xXQk9OZ0pqTk9mZ1ZmaXpCdDV4Mmh5?=
 =?utf-8?B?R2pLSGNlZFI2ZzM3TmV2WENhMmsyKzFwVERXeFphSURvL3hwaTNyckYxbUZ2?=
 =?utf-8?B?MHh6UnZMSFNjVFM1VGRyYVFuOE1ubDRXT1dpVzdsRnYva3hYVXRydi82aUtD?=
 =?utf-8?B?b3dQeXJHalZ4YVYrNEZrMVpKR3pGV3lmQnJrMHowdXM4WXN4UWk1WFlHcUYy?=
 =?utf-8?B?VTdKaUFrSTh3RTZQUFRjb3pBSThDc3F1WDV5c0t6RkY4NWhEekxYMlJVQzNp?=
 =?utf-8?B?UTl1OHk2dmlNZXlhOHdRMloxK1ZVWFlZK0ZiaGF0K3prdlVKSHlSbWVuUVo1?=
 =?utf-8?B?aE9WbWFvTDBGN1JtNmRLUVVnS3drKzdCbUhySlF6Y3puVHVrdTR3UURvbEFO?=
 =?utf-8?B?VXBVbG96ZkRkR3N5b0xXczdTcUV1ZWl6QmFNSEFOL3RQRHlyQllxMGFNRXMw?=
 =?utf-8?B?SXZwTDlkVERBYktHOFRxdUF3dzdHaWlZVldlTFF2aEZCMTdacDVoc25YMmE1?=
 =?utf-8?B?MmhJNTdMODB1Slg4WWZ1UGo1bmhUUGgyenJ1K1dtNHJ5ckd2Wm5kRlBTdnBs?=
 =?utf-8?B?cTJwSTJ6end5cTY2MHA5R3lwRkc1bU1pQVFTdW1CYW1CRmY0S3gwTm9QSjBY?=
 =?utf-8?B?NjFJcXVTbDNWTFI5RHlKa2dGTzMxTEl1c0ZzSzV0dTFrNm5pUFpNRTUwNlpR?=
 =?utf-8?B?TzVoSk5EcUNveDUxNUVqbGc5elQ3STNzZ1YwUXovL1dDUlNQL3FtazFPU3B3?=
 =?utf-8?B?cVdmempoM2ZtRjY4YldmM0xFZjRtUEtsSE9nTFgyM1R0Rk45ZDdZM0pob0l6?=
 =?utf-8?B?ai81NHVkQUprWWZpdEZ4YXJ2ZFliVThDOXNLbGJIeUtiZjhGSWZVZGM3VE1w?=
 =?utf-8?B?b3hkMXRRaVBRZGNNaCtnbngvaEZlRk9wRHRmYzV0bjNKL0hUbFZHcmFKQlZJ?=
 =?utf-8?B?ZllwK1pHSUwyRDFVTjA4NVF5ZTNqQmI0QkNOT0FkVzBrczlsNjhxNmlEWHFs?=
 =?utf-8?B?VDRNWXRBRlFyZXdBcVdKSlpqam9tV050M21oWFYwVmRQcEo2TFhLdHNldzU3?=
 =?utf-8?B?KzhKRnpSMkQrRElDUFdubU0vSHhYWjAwcU1vOHltaU1PUkRBZ0pLQkhRZVJh?=
 =?utf-8?B?MEg0Y1U1aW1va3JsNCtoTHE3WGJGMXBGMGxXcHFGQlI5NHcwaGwvdnpWZnA0?=
 =?utf-8?B?NGdCTHpwMkE4b1FTZjFod0d5QWptbElodWN2OVg0ekliOS8zOHhNaDRNd1dC?=
 =?utf-8?B?VElwbjUycHFLZmlsbTQ4U2VEUmM4dHNJWHUyVUd3R3I0N2RBOFZtZGN3L0xo?=
 =?utf-8?B?eGdsZENYWnB1WnJsVEdtS3VzSFJqVVV5aUM1dStQNGJMQWJERm4yMWszdGNC?=
 =?utf-8?B?QUxodDJXSEtqUjVJNXhRK3JZdG5najRnKzUxN2MwMm9mNnBrK2pJR0Vxa3ZZ?=
 =?utf-8?B?TFdXYi94RFJZdndvVmErdkF1TjRsZzk4K0JxNVdSMEwvcXNOS3QzblBDOHRS?=
 =?utf-8?B?ZWdOeThXTEFNNXdKVTNRcFhDZUR5QjVsK0dBeWVnZ29iSHVEYmJSQitiSWd5?=
 =?utf-8?B?OUlJR0s3VGx1aDNJb0hIK09nb2RiUzVyaVE3dTF2WXN6a3BhNTQ2LzRDM29F?=
 =?utf-8?Q?HoDL2tzc+a6MGSxOcIRHm2c=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a0f099-ab8c-4df5-5f83-08dd5022a1ea
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 13:46:23.4159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJP5oExzYLwCQ82iPC+nY77dDPMgUzH7b9Sptz2tjaZkBLlRSoaio1JTP3f8KB9R532ONGoWtS+H1wqQdJP61DPx7zPUY2lik1XbR0j3CWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8025
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Feb 2025 13:46:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17867



On 2/18/25 09:56, Jan Kiszka wrote:
> On 14.02.25 13:33, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> If a system has the following characteristics:
>> - An unbuffered system clock which starts in the
>> past (e.g. 01-01-2024)
>> - The last disk write/mount is after that date(e.g.
>> 01-01-2025)
>> - The option broken_system_clock is set for e2fsck
>>
>> A subsequent call of `resize2fs` will always fail
>> as resize2fs will check if the date of the last check
>> is after the date of the last mount.
>>
>> The e2fsck option `-p`(prune) fixes most of these time issues and the
>> broken_system_clock option is not necessary on most systems.
> 
> Ok, but now you are contradicting yourself from 045abe8527d6. Please
> sort out what we really want under which boundary conditions.

I re-analysed it and the issue occurs if we have a running system where 
disk encryption is activated afterwards and the mount occurs in the 
system when the clock is synchronized, e.g. with the recipe `home-fs`. 
The original solution works as during first boot the partition was never 
mounted and all  subsequent mounts are done with the old time.

 From my testing we should drop the setting the option 
`system_clock_broken`.

Quirin
> 
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> The alternative is to delete the setting of e2fsck option or use
>> `resizefs --force`. The latter fix has the issue that the force option will
>> also disable the disk size checks
>>
>>   .../initramfs-crypt-hook/files/encrypt_partition.env.tmpl   | 1 +
>>   .../initramfs-crypt-hook/files/local-top-complete           | 6 ++++--
>>   ...tramfs-crypt-hook_0.6.bb => initramfs-crypt-hook_0.7.bb} | 3 +++
>>   3 files changed, 8 insertions(+), 2 deletions(-)
>>   rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.6.bb => initramfs-crypt-hook_0.7.bb} (97%)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>> index bb93361..3c5c4c7 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>> @@ -5,3 +5,4 @@ WATCHDOG_DEV="${INITRAMFS_WATCHDOG_DEVICE}"
>>   HASH_TYPE="${CRYPT_HASH_TYPE}"
>>   KEY_ALGORITHM="${CRYPT_KEY_ALGORITHM}"
>>   ENCRYPTION_IS_OPTIONAL="${CRYPT_ENCRYPTION_OPTIONAL}"
>> +CRYPT_BROKEN_SYSTEM_CLOCK="${CRYPT_BROKEN_SYSTEM_CLOCK}"
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> index 54b8a6e..bb720c7 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> @@ -75,11 +75,13 @@ reencrypt_existing_partition() {
>>   	case $partition_fstype in
>>   	ext*)
>>   		# reduce the filesystem and partition by 32M to fit the LUKS header
>> -		export E2FSCK_CONFIG=/tmp/e2fsck.conf
>> -		cat > "$E2FSCK_CONFIG" << EOF
>> +		if [ "$CRYPT_BROKEN_SYSTEM_CLOCK" != "0" ]; then
>> +			export E2FSCK_CONFIG=/tmp/e2fsck.conf
>> +			cat > "$E2FSCK_CONFIG" << EOF
>>   [options]
>>   	broken_system_clock=true
>>   EOF
>> +		fi
>>   		e2fsck -p -f "$1"
>>   		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
>>   			panic "reencryption of partition $1 cannot continue - resizing of the partition failed!"
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
>> similarity index 97%
>> rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
>> rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
>> index df335c9..ec2d6bc 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
>> @@ -85,6 +85,9 @@ CRYPT_ENCRYPTION_OPTIONAL ??= "false"
>>   # add support for btrfs encryption
>>   CRYPT_BTRFS_SUPPORT ??= "0"
>>   
>> +## do assume the system clock is broken for partition check
> 
> "whether to assume..."
> 
>> +CRYPT_BROKEN_SYSTEM_CLOCK ??= "0"
>> +
>>   TEMPLATE_VARS += "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
>>       CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
>>       CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL"
> 
> Jan
> 



Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACADCA9ED5
	for <webhook@archiver.kernel.org>; Mon, 12 Oct 2026 06:05:09 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7588.1791785101186045524
 for <cip-dev@lists.cip-project.org>;
 Sun, 11 Oct 2026 23:05:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ff5t6Cyw;
 spf=pass (domain: siemens.com, ip: 52.101.84.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HlVCgDcdOTLasKKy4bfgLdiQGg9ED2DAwHcqNT+Nbgle3duJh+pZ6UnyWbgo1j5As5Mcp9soPXm86/pxRo7O0icJrHMUb52YN45aonWV+3e2qs+R3wY0ZhVyy4I3NZQwY+HcNcshVxFgiDSYrSIkmfNXWopLYCrGdQHDfTtmyoA1njIK6hOKvkxqa8UjPohYoL2T5ivBXk/GNLBo6PVjUeOiaksp04pWJJOhHd94C36CJ/H9CPid/G1uFhk6aZUNF4sfZJut4AAdFfUpWJFfTMEQnNLEXQ0ukX/WZSspL1cvJbg2a2luDUM/nP5LVFl/8z3JModP7nTSIPJ9jFeTTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhHQW0SIRoEQx43heg4qhQPhVygr7HE5ilxmPXvP61s=;
 b=iNQ47NroekFz6fWgQ8XD2hV0tOQ7Fw2tBuLSxv5j6qk7kXiBTu255Q3wrYnbMc/mRZLLDp1X0YHRJ2rqOUVKWgM2GXL9AW0JSCCI+QVsRC/7X2QHnvNc5DMhxdR2Q1e7BurZffvb7w0cFu4keUKOOAnv3BXz0+WnFR3RcWX6d+WQM2neyF+XKDlon7wx0mUHdzdqXInEmITOew68uxav3GvojKC8VqTH3rympELJ5pFUL9ty7klTxrH3PKckt7vw9yNobg3dK1b3GkFF1yybnxR/dCbvxNwAImDvBPP22PD/b27l+80jwH9CW2ExtWwF0AqsbUSUEOQsIbkTJNpNNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhHQW0SIRoEQx43heg4qhQPhVygr7HE5ilxmPXvP61s=;
 b=ff5t6CywPM8qF/8HFixxyrpsValY7Mx2dTCISxr+fNaQBGj7m+R7ldfYjIaPuvCAmgOeUW+9u+403NAQsiFcRxEw6uhJ7Gf+DoUdW3Z1m7bG9O0Ro8gjiQ26NHlf9VbRVx9ZiGTy9FPTqI8xbznoCizqA9382TsWb+qt9CBncEHiyWZ0peWNe8uzoCPnxCm/L7VrvQK2En/XbXJDkadciUneahz3xRF7H+J/qBy0jFkmqADsat0qn2WtiiMggNds9rBmoS2TzclGG8wpAodjMP1WGxuaEKaf/iS395yujcsvrk93hAH3UUtTQ5ju9aTGGxQgzarvHMxRx6jcpy1lSg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PAXPR10MB5181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:28a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 06:04:57 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 06:04:57 +0000
Message-ID: <dce79a41-9b82-446a-aad4-3cfced9a94ad@siemens.com>
Date: Mon, 12 Oct 2026 08:04:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] initramfs-crypt-hook: emit TPM DA lockout metric
To: Sercan Sari <sari.sercan@siemens.com>, cip-dev@lists.cip-project.org
References: <20260928133951.3500729-1-sari.sercan@siemens.com>
 <62c6208d-da8b-4069-b8ba-c272c9604b93@siemens.com>
 <20261007120129.Yv9HhVFB9UhVdvxgs8Y4ptKTKotAGBbNjlhj7yCHYaY@z>
 <c927508d-0448-45e4-ba11-fbd5d6a9db5f@siemens.com>
 <1614257.1791468591748965662@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1614257.1791468591748965662@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::20) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PAXPR10MB5181:EE_
X-MS-Office365-Filtering-Correlation-Id: 00450fe1-3bca-4d75-c584-08df2826bdea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|261009223027099003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|55112099003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	0Y0yTF293NL+M52rHSUy/fXkSO8yICtFfBOZAcCp+ENH8muHN/5TiywmumARwsP1vzD3KfB8Pr8GIQvezm9qyflaDQpwlGReaoWMFoBe4995qJ/PTCRhSAg+nudf4fKJ5T1JBr3PjrFRmyFJv3T8TnoaQxqpduKJRdq8aHgRHW6huFuu1HWuq3pNbHhzNIYywxwDsRVTkygN7VAPwDHYuH/xgOwi8sTC/ODuad0i+sZvE+/OCpNLBJC4I9c0yHHa0GHfOcjfNUwbYYvVS/zDY2CnjjPa4EEBrWJQ5eqSKMmIldHCNL+Ca/C8Bwy+KKSdI3n8p4KPK7CxpeZlbkDsT1Ns9kSgETP3nsr6sRvdrgDa0QEsv1HriWJ99bhJaB3xqAg6+cUosXDegR2XTp1iK4/JEjJymHFkTSIkBM/TT+AMr/kMxj18SfXo6a3yA706UunJJstniemLBAGZsJy1VLBZJwh3UpXo1+wxW69LpNLCwe0bRNeao52WfQO8kj0TkzISdUKycVp4EuOvr0FcWOJ9ywtJAygDTflt55zykgXygeGTiMxIGGHpwtQn2i0yOVCUPYMzPTeaNSonjmb0cgtPF3wtaiqCIRXo+WIYCcYZPseEnrq3C4YdLl6eyJWo
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261009223027099003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(55112099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WVlSN0Y3S3MraExZY1Z0ZHdPQmw5elhSUVFER0VWQmNNMUo0MXdvNWFWbzZ5?=
 =?utf-8?B?ZytMSHdCSDZRL0FCelZSY2RlVHE4U25ZbWpyOExrMXlKdVlQSDlUb1NJN1R3?=
 =?utf-8?B?ai8xMURna21vMzVUc0VmYmRQVndjVWNsRmEwdm5MRC91THZER3BTSnNJdDNR?=
 =?utf-8?B?MDNwZ1hxZG5jRHdaY2J2TUpPOGVnOEpJNFM1aXRKUVkycWdseHJxdDZ1UGVq?=
 =?utf-8?B?V3NxMWZSZ05IdFFRaFp2VFM5U2pkS3FFelBxZFU2U2gycTk1dVcvZHduMmdl?=
 =?utf-8?B?Und5UzdpV1NMaHNOSWhQZGFRdDA2a2orM0MrRXY3UW84QzhLeUNpSFVuN1dy?=
 =?utf-8?B?enlYYmdHWmtHMEJxdTltajFEL1NnSUFITWpMUEV2Z0ZQekV3eUpZUjd2eTEr?=
 =?utf-8?B?VlR6M1BNdUVNUnlybnk2ZjlWRjhqM3pQcW43SEFpVFl3cUJXc0dHK3IrVWhR?=
 =?utf-8?B?TjdlQTlxd0hBZFVPeEFtUU90RTFDdkVVKzdsZld2QWxQWVJhWkVMeGJPTm03?=
 =?utf-8?B?eDBDWEVFeFFSbUMvZnJMbWpSak1leENzbkpRTUVIaVMrZXJkekRNelJFWEJ0?=
 =?utf-8?B?Qlp6cjYrdzArbnQvYkhqOU1sclF0MG05MWNOckdNcks4ZnloaGllN3dFdFRM?=
 =?utf-8?B?R1RaWk8ydkluL3k0b3JabjVMeHhMVldWa2VmSk03aTJXUGQ4a2VPU3VXSHp0?=
 =?utf-8?B?bWFmNFRnUEdRWEtySjB0MXV4OWd3amY1NCs4eU5QamF2NWNvSWhjeXR6K1ZE?=
 =?utf-8?B?b1FIV2xMSWFrZVJ2NVNBN29xTmxCdnlLeE81TUtrTklZUzM5aitFWUZnUElU?=
 =?utf-8?B?cEtFMnczdGFFZ1hFZHZxcit2UStkL08zWTNSNXU1UjZEWlBsTXM0citOazJi?=
 =?utf-8?B?ekJpaUFSNmcwMjZmWUl6S2NiVDduN2xWSyt6K00xNmZZMmlFclZqMWFwczEv?=
 =?utf-8?B?M1BkMXdMdENrclZZeEJqclhsK1Q2cjg1QUFwdzkyeEVWM0tXMnhyMlQwY3d0?=
 =?utf-8?B?dWJYdTNYS0ZiMVJQakVOVEZORVh0U3F2RnVkOFptSnRsYUlHSTl1U2FDRGRV?=
 =?utf-8?B?WUZsZWhFMm80Zjl2cFJQTGRwOWE5Zkw4TkhMdEQzbjAvd2luTGlNVzRzNmZV?=
 =?utf-8?B?VUFuVitiOXJvV0V5UGhMTHdpNlE2L3FIb0JwQ0h3ckV5ZDlhdUN3RVBvQkZ5?=
 =?utf-8?B?YzdGMlI2VHRBSnZscXc4L3U1dVlpd2QzRzgzTUhSMFI5b0twTVVyRWRlM3kx?=
 =?utf-8?B?RkR0MG1lL2FFWjJDNHBidStZOFh2Q3BuZHZxbDRUY1psU2NYMzdqUVZwQnBo?=
 =?utf-8?B?NllLYlI0UTBqYUFVeXNMU2MyVGJpRHZpZjRhMHZ3aXhvS0s3SXB3RFpldXpu?=
 =?utf-8?B?Q2xQbmw1S0dVdWpVb0FWSzZmSWFubzIzUSt1MXN5VERHRndXRFpienlJc05a?=
 =?utf-8?B?N0ZwYXM2YXUwTFVOb01MNy9zb1BNNmYveWkrcHlvdnNYN3pPOFBBaFZhZGk2?=
 =?utf-8?B?aUhXWHVCYm5IbTRLS3o0bnljU0xyLzBNWXFwb3dQcTdnVjlqLzQ3cGlpMzl2?=
 =?utf-8?B?ZTN2VWxPaFhkVjVaY1hYNnZPd2FkWiszU2U3SURUd1kyK0lCVTlweVlWUVlY?=
 =?utf-8?B?U0JJcGxRblFIdjZhOGIzcDhacyt3bXVWcStudHNkdXFvYWVvZUxaOWtVVnlT?=
 =?utf-8?B?ak42T083bDlxb1pPRXRGc3ZmanFUZDA5RlJFSFluWThnWW1zcS96bmtUdS8y?=
 =?utf-8?B?dzUwYkFOL2VNZnJqS25xWHg3Z1p5YWJBNWZvS2t1Lzk0T3FzQlE2ZXR4OTVl?=
 =?utf-8?B?aEZZLzlyTmZkU1FMbFp4WVFtbDFZSmFuY05LL0pRTkR3U0ZRWkQ3TjVTWWM1?=
 =?utf-8?B?aXJNK3JKQlZlTGFudzM5cC9ZdmFlN2NQaERRYTh2SXFHbUpsL1g2bjE5bXBK?=
 =?utf-8?B?UzB3Qy9ZaU5JRy8wLzh2aWhwWXdYNE00NEdRMkhCRVNtRmZ3WnA3Mi84eVRL?=
 =?utf-8?B?MTZQdDNORXNleS9VS1JoTkRCR2lEelRqVy9SRlU1OEJidGpROUZxaTZWd2FI?=
 =?utf-8?B?QlpiUmRqQmhvQy9oaEx5SElOaEhLdnU4dm5EcEdZWkJ0UnFGZjlkanl2eHQ5?=
 =?utf-8?B?VW11ckd6QWZLWGo4eXVlUGtxM3ZGckd6bi9QZ1IzQWY1d3ozSE1VK2ZnTlRX?=
 =?utf-8?B?VVpuMnpuajk3ZHFjMUZ2OFVQUHRKVitYcGd6eTROcG03RkNhUlhLVER5UXdv?=
 =?utf-8?B?dkIxemRoVkdjbExDRFU0TW5jVS9LeWVhcTYwZXdrVGtLU0xyaExqZHJ3aEg2?=
 =?utf-8?B?UVJORVJjUkwraTJjYnROdXRKMWVXNHNzS1FDZVY4S2sxaHJ3bE4zdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00450fe1-3bca-4d75-c584-08df2826bdea
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 06:04:57.1324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJSNWS3SNLQefbCk6rd7mH5lbUGHJvslWbu0nLKOs+zxwO7rWMhxYiBF7jBFeCFIOoI82Sxa8PZbjAaJYe4RBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5181
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Oct 2026 06:05:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24444

On 08.10.26 16:09, Sercan Sari wrote:
> On Thu, Oct 8, 2026 at 03:16 PM, Jan Kiszka wrote:
> 
>     Hmm, but I'm not seeing it in my inbox or the public archive...
> 
>     Jan
> 
>     -- 
>     Siemens AG, Foundational Technologies
>     Linux Expert Center
> 
> Here is the link to v2:
> [PATCH v2] initramfs-crypt-hook: emit TPM DA lockout metric <https://
> lists.cip-project.org/g/cip-dev/message/24379>

Ah, sorry, missed it. As I'm about to tag 1.13, this will come right
after the release.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


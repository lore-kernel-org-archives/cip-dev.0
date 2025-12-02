Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C72ECFD2F6
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 09:48:09 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4255.1764668880910028638
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 01:48:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=twwRWy7q;
 spf=pass (domain: siemens.com, ip: 52.101.84.9, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUrutU6HrDRjsk+b/NB9MT0PVd0cNPg+VnNOXVPdTD12WDQv8GJIlSilT6cD6tEz6wpg39BoekqOPAKPAgm0S3An4cJA7kvJL3oi4ZWAkFRqg14Tx2+FiLVWmV1MxUT4u2YbBTTC7B1saOhCCbwJplKHLqvJZP3Nwe9Twzlep79JXUgji2fIhwyTra8uwGHSnv9IA35l4Xlwaxbu/v7AgVH0mX4T7qA4CpyaDwi1opCdnorajyEUkH3rkBYwfLkZPyPh03SsnsBxAOY9FwcROhTFT4g7FVa+7+8mstQ4WWu3zDMBijD2BGt9Vuvi5ohb9WeBCcALFRbEFQuRyTLh7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfTjnEZeY0sWY0BRCUjaeFxCMycwV1TtsegVSLUNjaE=;
 b=uUUkuz5sDOtDh2oGws6GPiMW6zDVpIXAMi/nVJbDC8bxbCy9vsy4FUuRAhEcVVhdnJ0CJAr+NtHOkB9XuS0F4o90GuI7VmII/k8X2Y0RkY76R4pW/970uQpjWGnh/VpfY4OXMydGo9fvedmqj2Z6C0cWF8PCjnB24+/5SC5E/OfciBvLNnAJKiT1UoH40xdm3JniadwQYjPseAf16FdEvZJRxvgIew3m2H/0sRANLsIG8FfU5XztiCS+BIJTwAy31iCBcCunnX7tjZnbersjZaqnMgpY40JxKypKpOJYsxujyAmWjePIzqwJ6uJl+cmoXOxE8RmfZK+ESAbGTT8I9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfTjnEZeY0sWY0BRCUjaeFxCMycwV1TtsegVSLUNjaE=;
 b=twwRWy7qRkI3+wTWtS2i7v9jLgcYV5ucHwgTUR0EodnieE2e6yrliz9JsRolb8WKGms/Zg6TmIL8FuyNnnW3KARxsp1GZe6oQd5/MDS8Zmp5qR69pQlNo4SXGTqucv2Jw/Sm4N2GMSFVitIj4eTP8h2dk3S6j5eAtRfcB99mM6UrCuzcAFkHW5dJT6WLQ3QGgVL4YLZs742PH12Umni+E28T4EB1Cfos9ugpSCw6IWSQmkTyzBhJ+UR+XwtAkefaxxVqUSjgbTuRZ+8W43qo7fT1WH4eeEg1y4bnNYy3Xv+9wg/ntQpHziOkKgTWBTZPdiNcGkl5BoEoLV7ljXfayQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7289.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 09:47:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 09:47:57 +0000
Message-ID: <0ec7ee93-bd2c-48c1-be9e-370222493d73@siemens.com>
Date: Tue, 2 Dec 2025 10:47:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Deployment of isar-cip-core images, lava images
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Arisu Tachibana <arisu.tachibana@miraclelinux.com>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <bbb91f28-1475-4b64-a2da-2883b784f1b4@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <bbb91f28-1475-4b64-a2da-2883b784f1b4@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca7b85d-d967-4789-cf88-08de3187df9a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|3122999012;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OUwzWU5XVTZBcUNOeUxRcEpBaTB1MTY5bWR5ZGp0bktNQlVhNkdxV3lrWFdl?=
 =?utf-8?B?N1FQakFzdEgzUVdvR0F2K0tZWUt4RzlaWlYrbnk3em9ETldJK012K1A2S0Fw?=
 =?utf-8?B?U0grL0V2UFJsMElvYlhONUJQM0NlR1dNcGNobms2WkpGMWNIZGpVTnJiMVEw?=
 =?utf-8?B?L2wxOTg1eXptY1MrZytONzErODF6c0Urck5xcXdVRWxNWmFod1ROTFBKNkdp?=
 =?utf-8?B?a1RaRVI3VlB2dk1XdkRWVko5MktIL0VmRUxWN0NnWmtieWxRKzNuU0lRSDky?=
 =?utf-8?B?WFRrL3p3aU9DTU9sVTFDSUpoNmJKTWs1elJ4eThYY2hHTm1iWEV0UDhmQXhs?=
 =?utf-8?B?eVNKYTlHMDFoWXBnZGdBOHZQMGdyRUljSXdvRTZQYWxBK2pzUGlBRHdTMm1J?=
 =?utf-8?B?MUpsZXVOemQ1djJTeWtCTk9zZGQ3Z2k4QlppSG5mZVVXRStHdW04Mk51anl6?=
 =?utf-8?B?cFdVVWEwSzlZRU9hNEJYam1TbXNmQVlIdEhZTy8yWUFXZTlSQ3VyQlRRWll6?=
 =?utf-8?B?WWlNYVVRRkZ2QXpFTVlrZFpQbndKSGZhTzlubjdkaUFkdC9CYm9XWU1qR092?=
 =?utf-8?B?cTZ5M0MzQ1psZWtUWlJQSFdKK2ZDOVpaTGdQcU1NSFFKcUtKY3gxSVFXRHQw?=
 =?utf-8?B?SXh6S2VJTTMvT2RkMllvMEhBRGp0RUFBYktsZ3FDeVU0aG9qL1ZFakgyeVVK?=
 =?utf-8?B?dWN6bTMraGM2ZUpaVTM1VVRJN1pqM05QVHFPMkdSaEN2NW5LZ0EzK09iYkhx?=
 =?utf-8?B?aENITUhZUWlVL1JoemNZTXdjQ09kKzlpcHNwV1RYcXlUdXp4SWJrNUJRQmo4?=
 =?utf-8?B?ZTRMdjVvMGk0ZDE3K0hqYUhTUUl2dnVxVTNKK2tDRnEzNWJLVnFzdk5ickRE?=
 =?utf-8?B?UlpBaXYrRWtlL2VoQ0RiTVdITEt6b2hvVEZOM3BpOE12REkrZ2I5OTloZkRr?=
 =?utf-8?B?ZWVMMmlHK1pDbXQ1ZUZ3OHo2WkE5K2x1N3VIVmpLbVl3WCtKL1ZQa3Fsdkx4?=
 =?utf-8?B?U2FWdzNnWnhEM1BHTjNFRHV6Vkp6RUlMaVA2Z2pVLy9zRG9vOHRnYlMxRlNL?=
 =?utf-8?B?Qnh6UTVNVW1YcHo0TjBwd1dRS2xUTUEzQWVyd3UyZldxRllkOXd3ZFRnZ2tM?=
 =?utf-8?B?VE8rTXV2Wnpwejk0WjFZUkRFZTh5YzF4dzdwcVRtTVF2NkpEdVBLYkFEeGE0?=
 =?utf-8?B?YXQ2M3NZZWJZSzY1TFBqRDBwY3M1eW82cVRNby9vbXcrU3N3K1FwK3ZyTDJo?=
 =?utf-8?B?Syt6ZjNWMHg1UVQyRC9tam5XVXM2QlVTeDZYQ0hhd1MrTGJUQUNkaXNVYXpI?=
 =?utf-8?B?OW95dlc2eTlxemRDcWRrSllZM3M3S0tadm5BRlpDNXVONXphNW1qQ0pWLzRp?=
 =?utf-8?B?SDUzL3JEQWJjS2gxOWkxTm80QzZzZElHSGtDcUNpUWJsb25oN2dkTkxGVVhk?=
 =?utf-8?B?Wk9RUm1PbzVBY1JHWHdyYzhrVFBVekVBVUFBcHM5Q01DUVBIcHM3OFNqWGs2?=
 =?utf-8?B?Mm1rRWV6aWxWMEg3UFBGaHRiNUlvZ3hWL1NmZWwvZDRqTlBvSEV5d0h0TjhN?=
 =?utf-8?B?bVdVT1ZVYjVQRjAyNk9oTVBTMTRmU01yOW5EV3dMdnhxSFJCUGJsT25TTklJ?=
 =?utf-8?B?TG1LeEplMkM4cmlkOC9NNkgyZDcvd000Uy9Hc1ZNNG45VUhqa0hZRnBCQjI4?=
 =?utf-8?B?VkNPQk0rK09CSzFFNXE4bC9JYUJUZXEvWjZTcnFnb2hUTTZDTXBwenkzcFBJ?=
 =?utf-8?B?eDd3cGtlMFpWOWxmOHdna1dyNnY2L1V4NHJNR1ltNlNSSkNNbGxmaGV5Szdh?=
 =?utf-8?B?Q096MjVhdDlJSWJZYnJoMEh3WU1mK3hWWk4yZWkrUGVmM0I4aU9qY0JVQTln?=
 =?utf-8?B?SVR3UnRjZDVwRE12UXZOa2JTd2tLS2U3di9HNWpaK1dVQ3FxdUhwRzRiT3Zs?=
 =?utf-8?B?MHUyQytCNG9OM29xd0pjZGhqOW1qSGFaS3h0Vy9uUVVzc2IwdWtSUzRCdEhq?=
 =?utf-8?B?WW16eTR4VE5nPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(3122999012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cGx1aitIL2tGMmlFRmtOM1RDaGcyUS9vcFp0UEtNcXlnN3k0ZjQrSzRFQ2t3?=
 =?utf-8?B?UUVVbk5yWUtDWU04NE5tc0txS0MxdElsYzM5cHY2TGZlMUFFdkJDRS9aMVk5?=
 =?utf-8?B?VGVxQ3R4R0t4L0JqaUtUMXovdkVDZVA4ZXpBU0grQitwSmNLTlJXWGs3NGpw?=
 =?utf-8?B?VE1vWGNzWWJGZU9sNE90ZTZyOHRpN2x5Wk5TZHdONHQyM1dncGlwQzJYRFFD?=
 =?utf-8?B?T21GOWhVTnJtMVY4YzFRaFVVRUR4bUhuOHFlRG80RzBXZFpEOXhzN0FIMTFk?=
 =?utf-8?B?elVUaGVuT05QN2M1YVZ6d3V2ZkoyNnNiUTFNYVJTTEdsUTVBb3pla2xrSXlM?=
 =?utf-8?B?NklZVXpUVWZINlZ6czhZenBuQWpJak5YTnN4YVhPNHpkV2NNSWJhV041THg5?=
 =?utf-8?B?aldwakEyeWJ1M0dNNUZZUGJyVHd3RlRnb01LSjZWR3pzSjZJSzBLR3E3M3Nu?=
 =?utf-8?B?ZnZXd2k5b1pCZnFEN3FwdXVkYlY4SUVXcXcrenBZKzRBbHVETnBZUEZWTEZx?=
 =?utf-8?B?RTE2VEFZZWVHNERiNXpNMzRiR2FoZXNHWEtDNEtnWWRERE5hNlRidUgwZW5x?=
 =?utf-8?B?bC9ESmgxMEZHdlN2T3NaNTltRUVCNjhTbDNoWWlONndBSVFLbmM2UUpjMWU4?=
 =?utf-8?B?T0NHV2VQQkxZanpBcUxtWi9vV09UWEVPd2RQNC9DYlI0S0crSTRiTjdGd20z?=
 =?utf-8?B?YmY5ZDRyZU5wSG1Yc2pBMEdEU042dURIU1BSSlozLzNPRGV5YzFPWllySVdh?=
 =?utf-8?B?U3lUUjlhTld4MTNSakw4U2hLMzZER0JCTURBcUtzU0Zoamc2WnZvSjdyT0FM?=
 =?utf-8?B?eWNwVnJwTHdYck9SbVFaTEpsdVNMbmVucWE3aU5vdVlyTWh2WDVMZEdGMzRG?=
 =?utf-8?B?NFAwNWZtMmRrVVA1NDBvd0xYdVZTR0JzOGEvVkVvLzAwU2lhalliNWdROHg1?=
 =?utf-8?B?MTd6MVUvV1BsVmlpbVFBbVJVZXhHLzhaMWNuN0hzQWs0bW5RMmp2aHc2Znc1?=
 =?utf-8?B?K01QTGcwdTZpK2szOWVudE95S1ZTNEhpZVNrMy9aQ2F0cHRWV0pCYTg0RmdT?=
 =?utf-8?B?MVpCakZqRDBudk1ibkszak9ERFJLaXFRUG9uVlFwZ1VYRk8rWm9QMnVMWHhh?=
 =?utf-8?B?RHhmVjE5VVRHNFZDRXgwcmdMMGt3bXlEZzV0eDJWZ3FpWGtQSmJ2VHNoaHBN?=
 =?utf-8?B?ZnNhT2xIYk0vNjlmVU8yL3hDbkYwSGMxb2NTVCttVkFTNWsyd1huZzFSZTdp?=
 =?utf-8?B?OWEvV09rN0FQQ2xNVlN0aUxkNUF0ZU95aVlsd3ZEVXNMYWxIQnBvWVBqQ2kx?=
 =?utf-8?B?WEN0Rmc0QVN4anNrMHF3aTRUd2EreFBPclZHKzdja1JhK05XOFNBMHc1TEFl?=
 =?utf-8?B?d2hheU42V3U4amlYTTc0RzNKV0lkQW9Hd0lreC94MlJUMnpreGZFTW1kMlF1?=
 =?utf-8?B?cU43VDY3dkZTUFBoVGJmcktjZi92cWtiSXhuTHgxc1I3aWFSUWh3MnBJV2o5?=
 =?utf-8?B?d1Y3L29obnVvU0hlOC9JSTFBZUpMeU5oQ3dDd2c3NlJKTGlXdHFZbmkrRVpN?=
 =?utf-8?B?RFNzYVJLV0FTWjdyYUppdWVIUm5CenIvcU9jaEMvRGJ4RnoxSWZVMnR5dTVS?=
 =?utf-8?B?VHhvUjk0M2ZySjI0bkZBUWl3R1RlZXBpM01CYjlISFJEMXZVZG10UCs4MVc4?=
 =?utf-8?B?MnJoVHludnZudEFwamI4bkVTeFNpQldVV0FmWkpSSThQdnVZWjU5bUdDVGNw?=
 =?utf-8?B?aHhiMzdwZWllMUVJV3BKUnYxZGR5UkdCazBBRHZKVUxOUVUwTnlIL1Q3ajh2?=
 =?utf-8?B?RVZjYlBOb2x5RXRXc0hBbm41UXRwYzBoUUV6ejFYbVJpQlg2d1JYdzRzMGN6?=
 =?utf-8?B?KzdBMFpLOHExcnVIaWV0V1ZZdDcrREt6bVZ3Y0E2c3JjQ0V3UEQyeURiL0hV?=
 =?utf-8?B?bXg2U2ZUZXIwNllzQWU4UExxMzBZV0JyNHV5cU41Y2tNK1pUWk40VmdoK2hs?=
 =?utf-8?B?aFAwR3VIVUduYlV5NEZtSGxzOFNOMXMxRlhJQ0Nob1ZFR290T2kwTU5rbDY2?=
 =?utf-8?B?UGhwNUxQT1pGQUsveVZGNXJTWUZ3VWFvTmllUFhyYzlUdFlpdS9mS1NHWnA5?=
 =?utf-8?B?cnhaWUc1NUoxbFczZ0tROXdOQUhtd1ZzVG1WZ21uaDdQTXRXSk9LamdoN0Jm?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca7b85d-d967-4789-cf88-08de3187df9a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 09:47:57.6489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jN12w4uIflPgmBRYdFi4ZP/5EcEcqlVzSUfctTLzmVC5wwajLNvn5klOj92Equg5b8dX4kzdDZIqinyqn4mA2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7289
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 09:48:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20804

On 01.12.25 09:31, Jan Kiszka wrote:
> Hi all,
> 
> while fixing our pipelines for trixie testing, I was also studying once
> more what all we are building right now and what we are deploying. Some
> questions arose from that:
> 
> First, I would propose to reducing what we deploy to S3 to only what we
> also test in the CI pipeline of isar-cip-core - or are there more use
> cases outside of that? Then let me know, and will keep them while
> switching from opt-out to opt-in deployment [1].
> 
> We once had deployment to kernelci as well. We disabled it after some
> API changes there [2] and didn't re-enabled it so far. Did the situation
> change by now, and would it make sense to look into that again?
> 
> Finally, we are building those kernelci images and also test images for
> hardware and no-kernel qemu images for our own lava lab, right? Do we
> need them all in the pipeline [3]? If we can't consolidate extension
> variants, do we need to build them for all archs? I'm just looking for
> ways to reduce our test matrix where possible. It's growing
> automatically, shrinking it again is the tricky thing :).
> 

Related patches now posted in
https://lore.kernel.org/cip-dev/cover.1764667279.git.jan.kiszka@siemens.com/T/#t
- sorry, didn't CC you on those.

Jan

> Jan
> 
> [1]
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/7b62ed2342a456fd821dafa631bbf96effa2d649
> [2]
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/9c2cd8d9bec20ce32eced54293da77b8c23fce27
> [3]
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/.gitlab-ci.yml?ref_type=heads,
> build:*-kernelci vs. build:*-test vs. build:*-test-nokernel
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


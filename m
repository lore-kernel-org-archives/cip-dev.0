Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0FAEC1EB2
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 12:58:51 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20028.1770296323826587585
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Feb 2026 04:58:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IwoXTyQD;
 spf=pass (domain: siemens.com, ip: 40.107.162.45, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1e0hMDG0glFEqpOlJr6V5OZDjGmy5XYLBm5oDgjrrTx6Tie1deHlTInxlqrGY/Vc37CJbqobyLwTPa+kKX47klGW/l1HtZlOrYVdI2MqanD+oqO+PdqPGgcQXY4bgPWCfmlHZBcnKnKe6HD5kryG+jwfRwApn9DDjCMsxtAMKO+zAfyWkOyaHnZPdvwX7gaS6HegVuHdRl4oJsLJ7YGatnfb5fIQijA6KThphoeMxD5e6jtYtC8iHtxtdA/QtyIpvTQb3xX7Al6tYBq/s+TqYFnlnsg9EXPcdhlN4bdU6Km+6Vh2jq8oiVp16XnnodusHWuK5LwaZUxcAljzDBW7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMFXt3Kjc1Jh5lNwQCpeIZ3/Nha6YplhEJgDrH9nroM=;
 b=DpN8/VlPA0Odx4elRb9/21kawwygthmrJVZygYBTGm5MYfFhPo8CHGs6hw/y398Au7W0GDK+nsi7tSFloSABzQhxslCCuz8PEDM3xUjLBjO9+jQ4moTcgMit94Cwcvr49VZD0k3IHbAs8mAJVTD8vgZXnwLe9RCYbosQnMHoEE2dv/zjeZ0S308z8sZ/FbY2ZcD0dqm5Ngb2eUK+19+xM8BFDXTSELY41zqrXrKCQ+7cez9LJcMj6mOiE7e5klzIK84eevgZDDsYnASjsu6KuDJvVlBhFMvYUFEulRfy4MgXhB+aRSsxqFdVje11wiEEDTWS1Uxn/a0yDJyIQRAaSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMFXt3Kjc1Jh5lNwQCpeIZ3/Nha6YplhEJgDrH9nroM=;
 b=IwoXTyQD9cNduWzrTW+fLl7siVbaCGkwRIfXKPcj/Ir9D5WH0LMi0WctjxQHP+c9U13SFVh86R1NbLMlpmNMfso1RseupymqCxik7qk+lrdNk5l1VPZo/Ojat9wdFtX1UOqLXe2Zz87UUnp/j3CgsPdscrK4C/5N1qumibU9UYKy7yCSk8Sfh4ovGdwqZRodOrYoMBabi+BykvDef0268fcqfKZJP/Adeb4lkOuvm2Hj3kAxDilcfsl7N0mAPhL4skA1P+smnfGa5zey5qrP5AGLQ/euRbP3HaQjy8VjYSQ8H15Tt60kou8RiERaNyVCBVd3UFWjDgo94D7AiLiciQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::19)
 by GVXPR10MB8454.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Thu, 5 Feb
 2026 12:58:39 +0000
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b57f:1a19:e3c8:fbb6]) by VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b57f:1a19:e3c8:fbb6%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 12:58:39 +0000
Message-ID: <41088701-8d41-46b7-8cfe-f59ecf155922@siemens.com>
Date: Thu, 5 Feb 2026 13:58:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1] doc/README.factory-reset.md: Minor
 corrections, verification steps and what to look for during factory reset
To: Jan Kiszka <jan.kiszka@siemens.com>, Adithya.Balakumar@toshiba-tsip.com,
 cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 koshiro.onuki.h55@mail.toshiba, kazuhiro.hayashi.f74@mail.toshiba
References: <20260205044638.14716-1-Adithya.Balakumar@toshiba-tsip.com>
 <a2cb468e-9aad-45ca-ae41-233c410f403f@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <a2cb468e-9aad-45ca-ae41-233c410f403f@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::17) To VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:89::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2319:EE_|GVXPR10MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 785163e7-2118-40d8-0ee7-08de64b6481f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N3NGTVBTb3VuNjdEVmYwd2dYaWRCMS92azI0ZFk4eVI0d1VCZGsvUTZtK2gw?=
 =?utf-8?B?VUpTOFQ1eldkT3ROdTg3V29QQ3BPaEQ0WDd1T2hpdW5ManVDaEo4MTRrZ2Ry?=
 =?utf-8?B?VlRKZjhISi9XU2xYME1zZyt1Q2RkbFZyb0l3ZTFGSE1STzRHU1QwMUo2c0Zo?=
 =?utf-8?B?enowSHNRTC9qUWt5R3c4WVI2aHRNU3JjRkRKOGE3MWY4Rkp2Q1lndHRQMHZJ?=
 =?utf-8?B?b1JjRlpraVVISTNuNTk1YWRUS2x3dnVSOGhPQm53dmswMXRCQ0pBSnphSFps?=
 =?utf-8?B?RHpSYlpuUll2SXJlMDhueHgrR2VMbzV2SFNrTVBvM0FTbGEzbnFHNVhabzl1?=
 =?utf-8?B?QmNYQmdvL2RDT2VYUk5GTlkyUmdGcVRsTjA1Qk1WazNiRnpKaU5raVJaRzFN?=
 =?utf-8?B?M0kwRW5SdHloOExaL2o1ck8wTk9RTDNNcDZNaFZETVBDa1YwUVpzbExNd3Za?=
 =?utf-8?B?QUt3c0l0Qzliak9vYjQ2aDJyY0N4VVo5WWU4V3BUbUJYSjNGdytiR1Iramox?=
 =?utf-8?B?UnpWNVlvMG5uTy9uRXo0MnNVTHBDaWhjZFdKS3VQREdPb29hK29WaldyVzU1?=
 =?utf-8?B?cWpyd0dicEJBTHNnSE1PU1R2aGROTGJ3cHpzQ0ZqVWRScU5LMVhNSkprLzhW?=
 =?utf-8?B?TFVKV3pQbHIyZGdkKzgyOXVJR0dNMUF4OHQra2d6Sks4RHY4WC9zNUh4SVZt?=
 =?utf-8?B?Q0xrMU5DWUNNN3dsVkJIdlVEYTliNVpqVEthSWdiNk5DS0lUd1lFVVBjYjVN?=
 =?utf-8?B?NldGWStueGt6NS9xcmliUjEvZGRSdDZlL3h1b0RQdStweVVGWCtCTlBBRWha?=
 =?utf-8?B?Tk5NaGd2dkVwTStWQTI1QnArbW80QmdVNWFZV0pMNXZRU3V2U1VhNmdpbU5a?=
 =?utf-8?B?RUhpNFBvUnk4SFNYa25uWWk4aUpQQ2dxZkxVbjcxTkNYckpYcWZOejF1Yjlv?=
 =?utf-8?B?VEQwOFBrZGdTQ0RvYTdacitFOEFtcUZ2bit2WlFpRWJWUXNsTFR2bkZ0ZnIx?=
 =?utf-8?B?MzhnZW0rVUZ5Z1hxT2d6QW5CaWs1Q0hwY3d6OGhrMGdqenNZNmwxMTlvQUNX?=
 =?utf-8?B?bnpPQTBTbk9tS2ZCOWdPN2ZOYmh1UThsR1ZhS0FOOWYreHFibEk3UHJFZWtD?=
 =?utf-8?B?ZHNFcW9lYUkwekFLTlVzcWU1V3VPQ1U4V294cXA2R2dMdkY2R0d5YTRmbXdM?=
 =?utf-8?B?dGV2SW54TFpPUkJlWmJlOExEUThFUmJ0SldUQVZRQnlsWlhJMkplZEN1NDJy?=
 =?utf-8?B?SGRvMzhoWWVqSmpTTlE4c21MZllXZnUyUlVCNE5YQVRlS0JjcC9VYXBpWTlj?=
 =?utf-8?B?K2hYV0hMZzBHZ2FONjAzM3FHOWV2NFZNOE1HTGRYMmZJYXRtYTF1SHBPMGxQ?=
 =?utf-8?B?VWhiVDZRNjBNWHJkUTlMeVZvUWR5ZzhOVkFrTzUvMWVzckxscDhjL3pTYWhw?=
 =?utf-8?B?Z1NKVlJaUmxIU09GT0daU2I1TlFWZ0dhdFh2ekFaQVEzRVdmRnpPVnRtc1BI?=
 =?utf-8?B?Q09SRkwvOTM2NzhiUStmWkFRSE1iZW90aXo3SDUwZmVIK29CTUg4VkE0aFIw?=
 =?utf-8?B?aXBsZy8zbzNCaGtCODlYVFplc1NlVEUvdUxCcDE2eGZYUjZtTHVQT2gxV04y?=
 =?utf-8?B?dUFKQXdsTG91YXhvczJ0TGR2eHdqQTV2ZTBsdFhoclJVZHkzK2thSzF6cDFt?=
 =?utf-8?B?RENYTXNKcUNYREVEazYwSjBHTTdydkE5L2VPUjVmM1ZnNkZUWm1lWmFMNDBP?=
 =?utf-8?B?ZWpOVE9XMjdGMlBzZ1dqT1hnRTVST2F5TnVpVFpKbUdjWHNZNjVwc3d0bWgx?=
 =?utf-8?B?MDVTeFI0RndiTE1ONmlJMWJvM2JaZjh1SEdlUzNSNHlmZVZiUXRVU2dvKzdU?=
 =?utf-8?B?M0xmQzhvVVh1eWllekZETHhpbGVuYnVxRkMrcWh4NVNIWEFoOEhtYU8yRlV4?=
 =?utf-8?B?aURBNXByL0hKRnkwZGl1SEhrbXB1cEc0WjQra01uWjlXRTJKei9YdXppWlFK?=
 =?utf-8?B?VnE5Q001aThndzhDTEZrZ0VsZFo3bjJOaVlpTVFkbDl4Sk9ES3RQTFB2eTNh?=
 =?utf-8?B?RXU3K2VsRHNLM3RyY0EyekJVL1VVOHpGcEJGVnlQdVo3UWVSUFRkZXJsTE02?=
 =?utf-8?Q?xOD8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T1E2K0YyZlNzaWZwekdtL2xXQkNwZFBLMUJvcUNJalUvb01IM1lwbWZiNm0z?=
 =?utf-8?B?NXFUVWFXYllNOUtGZk5JdEFJbjFXbU1yc2NrWUJNUFprNmswS3RVVGQxb1RR?=
 =?utf-8?B?aTBIaCtWeXJOSUVJbUtlNXlGZXNZTFN4RXBnQ3hzNTRrUk9VclNQT29ZT0VV?=
 =?utf-8?B?L2VUZ1IyTzdwWmgweXJvc1p0bW5meGh4V0dwaDhkbm52alNMOERwRTRLaUl0?=
 =?utf-8?B?N1QwcWhVM1RrdnZxQm5Ta013SG10T1NIMlRkT1ZFcHZmU2pBeU5WYTRkOFFD?=
 =?utf-8?B?OTk2c1BOa0t1QjBTMFJlcnFCOGg2ZXYzaXhFNm40aWNIZm1mdC95c1lpK2ha?=
 =?utf-8?B?Z01GOFpvTTBaOFlwRE82NjFhUVYxVkE1bVhSM3gra1AwdlZtWnpSQVI2U2lE?=
 =?utf-8?B?bXNGQWprQTJaNnNUMUg4RlEyVFNyMkE2cDVhdnpneGdDemdyNy9yU1d4QUU4?=
 =?utf-8?B?WUVIQ2R0NFU1Mzh6ekhYNjlWdXUrZVRSTzUrdTFYWTFCOEtsc0VBWUIweUxr?=
 =?utf-8?B?azFMMVBTaDhyc2Y5bkJVSEZzM1o4RkJnMnl1U0NDVWt4R0tmWUF4L1B2Yk5h?=
 =?utf-8?B?OVBwVDBUZzZpYVI4MjdPNWdsekFNdnVUOW1GR2hyUVZudDY0UjFKM1hVK3Rj?=
 =?utf-8?B?a1RZZXg0NXljMHBGQVpyYjRPTzZkMk1Gd3R4UExVY1pvQTJ2ckM5R2RnTFZY?=
 =?utf-8?B?WENXSzVlYWdWK1haOStuNVlaVGRNS0VoSGVGT2pHb2Y0d0Z6dDVoUVljaGFD?=
 =?utf-8?B?d0NHYmM3NWVFY0V6RVJzS2lKUmFEM2tZNFQ5VlBKcXF5MS9JNi8rU1RLZjZo?=
 =?utf-8?B?STUzcnNmY2F0Y09JSkg1OVliSHJ0NWVmNkt6UTE4amFoWm0vaW41MjRNVDAy?=
 =?utf-8?B?R3A2SnBxVUptTWxuVk85NlBVcUhITXpZV3B2MDE5eC9wMnVVN2dpdkIyNGdO?=
 =?utf-8?B?RFpRendPSDJjcU9PczZtdUs3NkZhdEZDOGFReWlGYTdFRFdVSE5rajZkZ256?=
 =?utf-8?B?MklyVDE3NzgrVVBQbWFyWmZuTVFkZndsVldEQ0ZaNmpmZ1MyMUdhemMrRmdo?=
 =?utf-8?B?SjEwbkYrYlNYaGdYUVRXWlZUc3pTWHhXVjFKQmpnWFNMWVExTlN4aXhnN0Ji?=
 =?utf-8?B?UXFqVGd6bzhxL3dhWUxaNUdweTNBQVVaaC9yRHpJMEZnZjNPWVdoclFDWHRW?=
 =?utf-8?B?K0xBUGFNUEVTUEQzQTdNc2c1elY5alFrZXVNVnRDVmdHczBLMGJsZUhwTm43?=
 =?utf-8?B?ZSttb3IyWEtrVWFsKzRNRHNOQ2luNXZnWG9kbTdqOE9EWmtKMVl4bG5tNFlo?=
 =?utf-8?B?bE1pdUhTL1R5WnFpcEVsRlBxUXdxUGM3M1BTc1VoZ251b3pwTWxvMEFLTXh5?=
 =?utf-8?B?dUp0cDZJZWNaOHBXeCtuWWR3alZaUm1BeVUvTFNDTStkb3VidU85ajBxTndp?=
 =?utf-8?B?aVppVXBPMzdjWXRhZENQWEc0NGVOS2cvS3FhZnJ3YXYwMDVhYTJzR20wb0Ru?=
 =?utf-8?B?TXVCZXZiQXFCVTZXNXAvY3A4R1hrY3M0eXM0d2R6S2s1b0R1NTNCZ1h3RmRJ?=
 =?utf-8?B?d3IwNUp3QTBnRjFxaGtIRHZoSHpucDkwUmpuWG1heEZBYVRsTUpNejZ1ODFz?=
 =?utf-8?B?ZXZLeU44cG96NTdoNHEvM2QwTWV3Q1d3SDNIb0RQRVRIUmp0UlRFbTh0aWlY?=
 =?utf-8?B?eEFCTERDQTRmSmZLc2t6U1lkdHVFTlgxNzdlUzJ5UlFmckZEWDVMVlhnVjFL?=
 =?utf-8?B?MXJicm1CdFNkaHBFc3p5RXRCOWlDd0dtM0VrZEY3blZGN01jUWo4SEU5ZlFN?=
 =?utf-8?B?REdCeEJYM09qalAzYUVQK3JPenhkeG9NaVNOMklPVkg0WDZ4b1NtbDVTR0dT?=
 =?utf-8?B?dE5OeitodjJ0ejFHVXdSSDh6aU1nUkxoUU9UZ1FkSlliRHFyTGFZa0FrQVVF?=
 =?utf-8?B?M0R4aGRxL3RvcTRhUDZ4aXFXUWJuN1R6UzNzd3JiV2Z4U2V4eFZpR084MEZu?=
 =?utf-8?B?SzVScHhrZktRUStSZ0NrcURrSm9xWUZYN05mK1pMOGxNRU5TcEtSaHB2elRk?=
 =?utf-8?B?Q1BIc3gvWnd1U0JINnN5aml1OFFHc3R0bTZ2NjNpYkN4QWVNQVpZNWhZQmtI?=
 =?utf-8?B?TXN3UWlBMGxlR0NrY29vWk9SMWZESmQ4dk5GUTZ2WkpEaVhIK2tqQXRkTTBh?=
 =?utf-8?B?Vi9HTFNnU2dSQ1BxK0g1czdHOEYwT3JvVE1mSTRaempVT29WbkE4NEVJNFRx?=
 =?utf-8?B?MU44UFVtZDJTdzRuV1AzQ0RYRFVpTUYzb1ZTdExvRjF6ekJmTGxUamZYR3Jx?=
 =?utf-8?B?NGV0dHN5dnhUNXh6ekRpRXh0NitzZEp6a0RjT3FMYUN5ZzhlY1RpL0lsWTlS?=
 =?utf-8?Q?50JaV46jaGNQ+VHY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785163e7-2118-40d8-0ee7-08de64b6481f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 12:58:39.2434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsGNi7076R1RcUDnOHK28kk3TAqeqcrvpGGmrg5mkYT2oqKB2FyWOTtWFNrjg6JDvWFDpxO2hPkhcS1NrdXgfUO5T9Omsy33tCT4c4QM6wY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8454
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Feb 2026 12:58:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21838

Hi,

On 2/5/26 7:46 AM, Jan Kiszka wrote:
> On 05.02.26 05:46, Adithya.Balakumar@toshiba-tsip.com wrote:
>> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>>
>> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>> ---
>>   doc/README.factory-reset.md | 44 ++++++++++++++++++++++++++++++++++---
>>   1 file changed, 41 insertions(+), 3 deletions(-)
>>
>> diff --git a/doc/README.factory-reset.md b/doc/README.factory-reset.md
>> index 729912b..ef35225 100644
>> --- a/doc/README.factory-reset.md
>> +++ b/doc/README.factory-reset.md
>> @@ -1,18 +1,18 @@
>>   # Enable Factory-reset
>>   
>>   To enable the factory-reset functionality the following two elements need to be installed:
>> - - initramfs-factory-reset-hook which executes the factory-reset
>> +  - initramfs-factory-reset-hook which executes the factory-reset
>>     ```
>>     INITRAMFS_INSTALL += "initramfs-factory-reset-hook"
>>     ```
>> -- factory-reset-helper which provides the helper scripts to set the factory-reset marker
>> +  - factory-reset-helper which provides the helper scripts to set the factory-reset marker
> 
> The indention of items were inconsistent, but do they have to be 2
> spaces? Below, you do not indent at all.
> 
>>     ```
>>     IMAGE_INSTALL += "factory-reset-helper"
>>     ```
>>   
>>   ## Technical details
>>   
>> -The by executing `set-factory-reset.sh --create` a marker is stored as a EFI variable or on disk (default `/dev/disk/by-partlabel/efi`).
>> +The by executing `set-factory-reset.sh --create` a marker is stored as a EFI variable or on disk (default `/dev/disk/by-partlabel/var`).
> 
> "The by..." still doesn't read smoothly.
> 
>>   The marker on disk is intended for devices which do not provide the facilities to set EFI variables.
>>   The initramfs reads this marker and formats the hard-drives provided by the variable `INITRAMFS_FACTORY_RESET_DEVICES`.
>>   The initramfs-hook will try to detect the previous used file system and will format the partition with the detected type.
>> @@ -27,3 +27,41 @@ The removal of the TPM keys can be deactivated by setting the variable `INITRAMF
>>   As the factory-reset is executed before the disks are unlocked in the initramfs, the file system type must be provided with the
>>   variable `INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE`. The factory-reset of encrypted partition is not supported with the file based
>>   marker.
>> +
>> +## Verification
>> +
>> +- Set the factory-reset marker with the below command:
>> +```
>> +root@demo:~# set-factory-reset.sh --create
>> +```
>> +
>> +- Trigger a reboot as factory-reset happens in the initramfs step:
>> +```
>> +root@demo:~# reboot
>> +```
>> +
>> +- Factory reset runs during the initramfs. The reset scripts format the target partition with the required filesystem. This can be observed in the boot logs similar to the example below:
>> +```
>> +.
>> +.
>> +Begin: Factory Reset ... Begin: Reset device: /dev/disk/by-partlabel/var ... [    5.834137] random: crng init done
>> +mke2fs 1.47.2 (1-Jan-2025)
>> +Discarding device blocks: done
>> +Creating filesystem with 131072 4k blocks and 32768 inodes
>> +Filesystem UUID: d4ec21bc-988b-41f8-8e71-4d2b24cb7074
>> +.
>> +.
>> +```
>> +
>> +- If disk encryption is enabled, apart from the formatting of the target partition as stated above, the initramfs scripts also encrypts the target partitions. This too can be observed in the boot logs similar to the example below:
>> +```
>> +.
>> +.
>> +Device /dev/sda6 is not a valid LUKS device.
>> +[    8.375556] tpm2_policypcr (224) used greatest stack depth: 11736 bytes left
>> +persistent-handle: 0x81080001
>> +action: persisted
>> +Begin: Encryption of /dev/sda6 ... var: 12/32768 files (0.0% non-contiguous), 6385/131072 blocks
>> +.
>> +.
>> +```
I would not add these outputs to the verification step as they can 
change between Debian/isar-cip-core versions. An better way would be to 
check if a file no longer exists after the factory-reset. I tested it 
for example with `/etc/to-be-deleted`.

Quirin
> 
> Adding Quirin to help with cross-checking.
> 
> Thanks,
> Jan
> 



Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839BACE8D72
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 18:20:26 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5024.1763144425118655238
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 10:20:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=t2Tg6DEg;
 spf=pass (domain: siemens.com, ip: 52.101.69.31, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ML+QMg2Yo2SaoYZG5aan6FgzvdNrQdKTGSfrseJTL/IoHL+McKeTG9oZu1YJDMxaEl2UdLYggCQgcDjLqyD7z1fj19bcYmA5yH+OZIDxCazdF6oI0fXQocfEX0U0Q5ftZlXFJa9qBcte6sBsTIiAovofic0d8fjl3moJRmM7r4AlAt8NxQ+8fFtw5vYoxY7FV9xxFBPsdoCQfC/4PBp4ylq/7t/c6uo1BsqXo+TaQPXj/hYpXixXlA3HCRtUyDeQYzYCasPyx/vd4aEEC07NAZJoV+PC84CBCl7/nLP0IKgJdEgCUsnHtF3+rsgjiyY9LfmayQjBVL2pqG/trlFQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6dzTlJJiz5YzTVD2k+E/5L0RYvd4i0EZR1uYSN7Y90=;
 b=TwWudOyXvy26oc9BLoHF0clVskpXdwVQCiYe+JvBn+VohvFyK8o8v9P0Ud6l2EVwUYB3QbJ7Cad8fIo70MBIfRQvAaoahPQ+t0Pvwt3qads1BjST+6fqMyMEBhMHhDaAjDsY6cKKlupFw5lF5W2UDnMkQTisHQGy5PbZXpBKdRUFVpUaQL5VytWn7qrQtGUX9zbLffBG0345MXsOXwBVJuTg/ZSzixK/+O22RJxGxOpBS3Y+IHpyCRtps5KjtSarxmdzHLeZh3+DqreTuck/OhJD5PnkJLpRIOCPwIX6FEqS722icdbfiSnQ91orC8KCq3opZdWOu5VTu+zu7Kgd2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6dzTlJJiz5YzTVD2k+E/5L0RYvd4i0EZR1uYSN7Y90=;
 b=t2Tg6DEgP5OvyzQW2HdSNm6cn8MxaI5m3a3qeTUEzk9xmvrPwe3+wUmXgEdzCj9CdAAn3UcR2+ILjGt1QWIVHWCgFu5LtP3XRgbx7yPor+zWv6qThR3y24I/+Uj+SUoZauJ7SnKqopW6kX1f7UXkbNjpKJ/eVBcpai51ZpjowZU1I882yAnJvSCzhWj3h3tKDPmCbZconvCJkDJjB+yjzu+cjIOqnHSlCx0Nw44gnkBYSEO8U1MsMkz7Egls/ubInX4oKp+sFgfkVwcl/1pFaielJfF/sNEe1gfujvy3+WYWVcLYEKO0Plhl2/JJiyNfjFCL3doInI6DNWZWGZ3QzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3472.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:136::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 18:20:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 18:20:21 +0000
Message-ID: <101c693b-3c28-453c-b585-948f0d036ca9@siemens.com>
Date: Fri, 14 Nov 2025 19:20:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 4/5] initramfs-factory-reset:
 de-duplicate code between local-top and local-bottom
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20251114111925.903740-1-Quirin.Gylstorff@siemens.com>
 <20251114111925.903740-5-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251114111925.903740-5-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3472:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d30479-698b-4b75-022c-08de23aa78bd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YVZYa2pOQUoyMFVwOENONUd2cW9EaGVKeWtqU0hLQ0ViaFRiRk9EenJNejdh?=
 =?utf-8?B?ZDlFM2ovQWd0Szk4R0VielV4aUpuWmtBVTdiaHZWeXFkQnBpRWU0Vi9Cdldy?=
 =?utf-8?B?WTNpc1NEdVFWdXFqYjlRbFVOcS9ieXkwaGJ1Yk9idU5DTDV4Z2EvTTRjbWhE?=
 =?utf-8?B?Q1JmZjg4cXkycmFsWWRXVG1EUkVGK095U2VHNS9oVHFNa0pLY0loR0JDV2xO?=
 =?utf-8?B?NUJFY2JydmlFbFpHczJ5QVlISE1VVlByVG1WNFFCQVFsakZnQTJ2c3Vwd3Vq?=
 =?utf-8?B?ZCtpMHVuNWgwVmluTC94aWlaTDEyOGp1bUxaWHFqZ041MkZ4TStPY2laSkNX?=
 =?utf-8?B?VkZFVitBL0Ftby9MckVRa2pWOG9kbjZPeVoveGlKUjdrbDMwL3pFVjNvTXJZ?=
 =?utf-8?B?UFdLL2UyNjV0cWRTcy9uVEx0cEFEbFlEMGcrOXdxc2JOQy9RYmVuZDhZS1d1?=
 =?utf-8?B?d2R0T1JUUGQ5c0xiTHN4SHh6dEkwZ3V0NVBCN2p0Y21YeS9CUlhKZHZQUXJ1?=
 =?utf-8?B?VUdvRGd1R3drcDh3V1V6eWRtdzc5V3hvSjZ0TUVaZWh5MUVibWV3T0RNVTF3?=
 =?utf-8?B?TkI2Y3FkREs3cUxhbzFKcVVCcFZNYVA1Z3RxWEhnbk5tRVJ5a2hDenk4SU45?=
 =?utf-8?B?cE5kdzJCdHp2djZhUWZ1U1prQy9PZ1FZOTEyNkYwYm9hMFBSNmpiMGEyTS9I?=
 =?utf-8?B?bzdvT1EzMFNUdDljMG14cXBZTWkwbHNnVVc1K01oOW5Sa3Q0ekFFQzdLNWN6?=
 =?utf-8?B?WnN4OVFKcy83dGNvL1V3THhvcjhYWGpDYjhZWGRhM29QcTdLdTJwdUZDT0Zp?=
 =?utf-8?B?NERKWXFMR0NyYWxtVjFCd1ZEdVJpQ0xtditNcGJNSCtQd0kzQTBObW9SRkdE?=
 =?utf-8?B?SE5hdm9oUTRiT2J6UWxPeTN1eDRyTXBRMS9LMEJWR1EzNkNlSTZBMmdoaGcr?=
 =?utf-8?B?NTdhaWpGaFhHWCtZZU1Eem1FOTVCNTRjWEZyUlFTL0ZCTXpqdXJlZjNqNmh0?=
 =?utf-8?B?WW9EOXNDdjVVMGcrWGdVNjJzMnVPbnNCcG4xLzNYNjJjQkRZR1h6VWRoR1pM?=
 =?utf-8?B?UDU4bGxMbVBDakhXdHhML0pQYWROUjVzNTZKK2VWWWdnN2dYQzc1YmlEMG02?=
 =?utf-8?B?U0xhbUtOb3VKdjZsS3NubFVLMWdOb2dyR3dJM2huVVNMejNtYTREVWJ1VXVN?=
 =?utf-8?B?YnE5a1VtbTFZYWxHb21LNzZUUGkyLy9nWnBBQVVvTSt2YVkwUU5uTmlROWlu?=
 =?utf-8?B?Q3h3YnNPcmdlK3J5czAzUjlJOTFQVkh4c1BuMGZFcEY0dzdYZE5va2E2NVA3?=
 =?utf-8?B?ZWJsOUZlWjhvZEdZcXI2K2FGeDNMOGZJK2gwTVpxdjJmQTNvckRrWFFjTC9y?=
 =?utf-8?B?N1dlY2JGbC94S1NZWldIOW81a2tXdWpVZUtDdFVaZW40VzV1Q2dhcHlDQ1FB?=
 =?utf-8?B?WFlqQkZIdHlyVHB1RWZINFV2NEVFUkRXSEs0WVA5b283NzNJMXAvQXpIdHl3?=
 =?utf-8?B?SFBZOXNlc2xLWXN2SXgrTkdXcFppNElrd2g2Sk4ySXM1ejlKaFZlMG5KNXRp?=
 =?utf-8?B?UDNhNVp6cWxscmw2dVJwOE5HSXUxWUxIazRPY1FEVjAyamFoU1pnOERORno5?=
 =?utf-8?B?eWd3L2FpVzRuc3BWT2VzQmpwS0l1NG9iSkV0Vlpnb1ErQk1sUmNEbDVGNUl5?=
 =?utf-8?B?ZjJsTXFBVkwrU1ZsVTdUZU9hbWdhVEFXZnFYeDhYSk1PK3l5SndTSnk5Ujh1?=
 =?utf-8?B?cmtvcEpMQjl1dUZPNUh2R0V6QWdqWUFpZncvY3dLeFlsOS9JQWJXNmc2U3Zw?=
 =?utf-8?B?Qk9JZEVpSWVWWTE2SG1TMzVLQVp4d3haKzkvYlY1WFZrMjl2L2lSbE50VWRo?=
 =?utf-8?B?RzRVOGdndFVJOW42K1drUCtQYkEzS09MSXAyQ0FnbDlCeUMvY0w5Vm1lTzNz?=
 =?utf-8?Q?C3arQOFu5e3mqGu6xk+azKC9RoDPngSO?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TTh3VFVTd0hlNEtKdExDSy9HbGJrZVFDeElBeHJWR29saGZGcnpTeHg4QUxs?=
 =?utf-8?B?eU95SUt1WGJpd2I3YzV4RENMKy9SMDZIZ3NJd0ZTNVEyQjVIblBhT0pudzhh?=
 =?utf-8?B?Ui9ZT21HaTdaazc0V1c2OGN0bkFVNzI2TGZlTUs0ZjlYc3R1OHc0RlFncU9S?=
 =?utf-8?B?YTYwaGVwc0hSakxVazIxK2xhajU2OExHMk1pdGtQdUdCbi9JR3U4YlZNSnJm?=
 =?utf-8?B?MHBkbnJzbm9MRHNaZUZwcldrQ3p4elpZemN0MlVlc2VneFpWZmJIUytCZHZk?=
 =?utf-8?B?T2ZtU3J3SW1JSmozbUE5Sk9kb3dHdXhNMk83bVBVR3JuZGFMempSY1NPVzhs?=
 =?utf-8?B?SXR5MFU5UHdaOVVvZDNlc2JFTGNnZkxnOU9wT29UdUZUbVlHa1VhRlhWakZp?=
 =?utf-8?B?ZC82VlJ3S3NUK3diRmtVY2dTNyswd0o0cWJGK05PSVQwTFFMUytITy9KVGxF?=
 =?utf-8?B?d0luVytoTE50WnhLdGt0Q2lTT1NKUCtBZVdsMWs1TS9ieFNoSG40Sk96aS9G?=
 =?utf-8?B?ajZjYy9scWY4TFBUeVB1eUxHZGxEcXRTcnR1ZlFsYUdqY1I4VTVvVkUxYnN6?=
 =?utf-8?B?Q2NudTg3SzhvZ21lNFdSdE9TOXVoNnVqVi9kN21oQ3Q1VkgxdFZGZTgyZ1Rn?=
 =?utf-8?B?NXJ2M3MwTHdaQlhaWmZ2TTB4VytwZ2FzWUdaY0JrTDNrbWdLSTVQMGhheXNN?=
 =?utf-8?B?a2VLUUJvaFZiWXp5NVdFZ0xKUUk3dXRCZTE3ZkV6NldUZS8zYjdRQjdrNDJ6?=
 =?utf-8?B?MkJYc0ZSOUxxZU0zRmd5Z2E0UGRpZndjSkVhYWJRNFpLZTBTWWI1REdyYm0v?=
 =?utf-8?B?Rm9VUmViOGtaS00vMkRPRk9aTllld3NtTUMycWVCelpBWmh4M0F6aVI0ZXEy?=
 =?utf-8?B?QW1QanlJVElGRVd2aUtDWExBQ2NqVVZGQzR4MitUb3JwWmU4dCt6K3FWRnpZ?=
 =?utf-8?B?N0QyeWJhTitiaVhxWTJCUlhSc24wSUZCbGNwcjFXTFFxazU2WURlWmhKVlYz?=
 =?utf-8?B?YW1UbUpDejhzazVNaHFsZmltTGdjcXN3Y2ZiTXM3bVREQ3AxV1c5OFdDb2hu?=
 =?utf-8?B?WGdXd25BZUZoQXkyazJkV0ZiMGc3YW9PeWZMNjMxZ2dqVnE3aWVzdXFxTXk3?=
 =?utf-8?B?b3loQ0xDZUNCZHZmSVYzTEhYcktUOTdNRktldDYyYkRwN0dOd1JyeitpZ2tX?=
 =?utf-8?B?enJCb2hpa2UwWGN4dEFKbmVUNERad1YxcW5CeUdYcmY1N1ljS0cvZEd0S0Zz?=
 =?utf-8?B?Yk0wcFVHYXRscHZ5YUQ1Vkk3N3RhN0tOa0JWc1VaNWo5dUxBdm5hY2pBek93?=
 =?utf-8?B?YTRCd2h6VGpNaEpiZ0pGVTdycXBZblR1ZXhTNWpoYzc1Q3R0ZTJQaDVPMnE4?=
 =?utf-8?B?cGg0T3hjb1pRNjFvTmZHK1FZUTJ4Ym56OEh0LzZESXJuTElDT2t4bzAzd0hx?=
 =?utf-8?B?Vnl2eHhXRWZ0SmErSFREZ09SQmNkaytyNTVHMlk2ZDVhcHlhSzJmTFB5R250?=
 =?utf-8?B?aGZQM1ZlNFk3VkttSHpZRjFheHVwTFlWN3Q5TGwzdnNQd2lZTlhwcHBNNm5k?=
 =?utf-8?B?MVhKMTY4aGJ5UVhPOFpGejVvc1pkUTY4OG9HV01CMHpOT29UUzhJbVRkYWpX?=
 =?utf-8?B?aUNiZTdJTGlnbTJzNkpqZzA1Y29MbFJvRS9udnZMZG8ra3hUaUxSKzdTWXhv?=
 =?utf-8?B?Z2lsTTVpRXJMaFZGOFZHNTVCZTdLNThjVitIWldBb0lVM3h3ZzZGUVpLM3VM?=
 =?utf-8?B?U2Z1QkYrK0ZkazFpMm9pTFNlZVdGNVZTQ1g4eHFUNkZZY2Y3bktmdG9uTXpS?=
 =?utf-8?B?OHZLWE0yQUxpVWNtSG5nUzNESTYzejhjTW80OExzbFVQUjU4OFlqaWJ1SFM0?=
 =?utf-8?B?VUNlU2tGK0ZRMnBOOWlxMHNqdTJIcWxISTJQS1ZoWjkzSkwyOWVFejBIOHBL?=
 =?utf-8?B?dUlwSkJ5MjduSFdJU25Jb2pzTTdSTVZ2Ly9TYW1HWlcxZzFnOXl3SlNmYnFF?=
 =?utf-8?B?RW9KK1pUaDMxbTRrb2lnRGQ0REE2eHc3VWRmYnd4MGpLNFVOZlhaUE9ZRndO?=
 =?utf-8?B?MGdJWTVzeUFHaTBKRXc0ZXpLZkQwOEk3OWVOSmNoNVRsTy9YQ29aKzlQYzha?=
 =?utf-8?B?NnVHNFFpVSsxYm9IV1Mxb0tyd1Z5dFFDZU5qVXU5Y01TOFY2RXBoTjM1TWNy?=
 =?utf-8?B?Rmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d30479-698b-4b75-022c-08de23aa78bd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 18:20:21.2014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUNvLEOfcRjHTNDkQQKOXkOCevT2yOds+xyYAUP82BcAYhJ2FENTwLos7z7Db65z8lDCiW+fKXv9T5OIN0cIxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3472
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 18:20:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20569

On 14.11.25 12:17, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The local-top and local-bottom functions are nearly identical. Use
> a template and change the name during prepare_build to the indented
> initramfs stage to maintain only one file.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../{local-top => factory-reset-script.tmpl}  | 18 ++++---
>  .../files/local-bottom                        | 48 -------------------
>  ...bb => initramfs-factory-reset-hook_0.2.bb} | 18 +++++--
>  3 files changed, 26 insertions(+), 58 deletions(-)
>  rename recipes-initramfs/initramfs-factory-reset-hook/files/{local-top => factory-reset-script.tmpl} (70%)
>  delete mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom
>  rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-reset-hook_0.1.bb => initramfs-factory-reset-hook_0.2.bb} (63%)
> 
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/local-top b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
> similarity index 70%
> rename from recipes-initramfs/initramfs-factory-reset-hook/files/local-top
> rename to recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
> index a1aaf26..a6c622f 100644
> --- a/recipes-initramfs/initramfs-factory-reset-hook/files/local-top
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
> @@ -28,12 +28,18 @@ if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-reset"; then
>                  ;;
>          esac
>          if [ "$fs_type" = "luks" ]; then
> -            # after this the data on the encrypted partition
> -            # is inaccessible
> -            tpm2_clear
> -            # with encryption the original fs_type is hidden
> -            # use a variable from the reset-env to set it
> -            fs_type="$INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE"
> +            if [ -n "${INITRAMFS_FACTORY_RESET_CLEAR_TPM}" ]; then
> +                # after this the data on the encrypted partition
> +                # is inaccessible
> +                tpm2_clear
> +                # with encryption the original fs_type is hidden
> +                # use a variable from the reset-env to set it
> +                fs_type="$INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE"
> +            else
> +                target=$(find /dev/mapper -iname "*$label")
> +                fs_type=$(get_fstype "${target}")
> +                echo "luks device detected use $target"
> +            fi
>          fi
>          case ${fs_type} in
>              ext*)
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom b/recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom
> deleted file mode 100644
> index 15d44c9..0000000
> --- a/recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -#!/bin/sh
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2025
> -#
> -# Authors:
> -#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> -#
> -. /usr/share/factory-reset/reset-env
> -target_devices="${INITRAMFS_FACTORY_RESET_DEVICES}"
> -
> -if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-reset"; then
> -    log_begin_msg "Factory Reset"
> -    for target in ${target_devices}; do
> -        log_begin_msg "Reset device: $target"
> -        fs_type=$(get_fstype "${target}")
> -        case "$target" in
> -            *by-partlabel*)
> -                label="$(basename "${target}" )"
> -                ;;
> -            *)
> -                label=$(blkid --match-tag LABEL "$target" | awk -F= '{gsub(/"/,"");print $2}' )
> -                if [ -z "${label}" ]; then
> -                    log_warning_msg "Could not find any label  for target '$target'"
> -                fi
> -                ;;
> -        esac
> -        if [ "$fs_type" = "luks" ]; then
> -            target=$(find /dev/mapper -iname "*$label")
> -            fs_type=$(get_fstype "${target}")
> -            echo "luks device detected use $target"
> -        fi
> -        case ${fs_type} in
> -            ext*)
> -                /sbin/mke2fs -L "${label}" -F -t ext4 "${target}"
> -                ;;
> -            btrfs)
> -                /sbin/mkfs.btrfs -L "${label}" --force "${target}"
> -                ;;
> -            *)
> -                log_warning_msg "Unrecognized filesystem type ${fs_type} - could not format"
> -                ;;
> -        esac
> -        log_end_msg "Reset device: $target"
> -    done
> -    log_end_msg "Factory Reset"
> -fi
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.2.bb
> similarity index 63%
> rename from recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb
> rename to recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.2.bb
> index 68dda34..28e1cf4 100644
> --- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.2.bb
> @@ -14,16 +14,20 @@ DESCRIPTION = "Delete the content of the given Devices"
>  # list of partitions by label
>  INITRAMFS_FACTORY_RESET_DEVICES ??= "/dev/disk/by-partlabel/var"
>  INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE ??= "ext4"
> -INITRAMFS_FACTORY_RESET_CLEAR_TPM ??= '1'
> +INITRAMFS_FACTORY_RESET_CLEAR_TPM ??= '0'
> +INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?= '1'
> +
>  SRC_URI += " \
> +    file://factory-reset-script.tmpl \
>      file://reset-env.tmpl \
>      file://hook"
>  
> -SRC_URI += "${@ 'file://local-top' if bb.utils.to_boolean(d.getVar('INITRAMFS_FACTORY_RESET_CLEAR_TPM')) else 'file://local-bottom'}"
> +FACTORY_RESET_HOOK_TARGET = "${@ 'local-top' if bb.utils.to_boolean(d.getVar('INITRAMFS_FACTORY_RESET_CLEAR_TPM')) else 'local-bottom'}"
>  
> -TEMPLATE_FILES += "reset-env.tmpl"
> +TEMPLATE_FILES += "reset-env.tmpl factory-reset-script.tmpl"
>  TEMPLATE_VARS += " INITRAMFS_FACTORY_RESET_DEVICES \
> -                   INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE"
> +                   INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE \
> +                   INITRAMFS_FACTORY_RESET_CLEAR_TPM"
>  
>  RDEPENDS = "factory-reset-helper"
>  DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, btrfs-progs, awk, factory-reset-helper, findutils"
> @@ -33,6 +37,12 @@ HOOK_COPY_EXECS = "mountpoint findmnt mktemp rmdir basename \
>                     chattr grep find"
>  HOOK_COPY_EXECS:append:encrypt-partitions = " tpm2_clear"
>  
> +# rename the script

"Provide the script under the required name" - you are not renaming,
your are copying.

> +do_prepare_build:append() {
> +    rm -f ${WORKDIR}/local-top ${WORKDIR}/local-bottom
> +    install ${WORKDIR}/factory-reset-script ${WORKDIR}/${FACTORY_RESET_HOOK_TARGET}

How about "ln -sf"? Or will only the link be copied in then?

> +}
> +
>  do_install[cleandirs] += "${D}/usr/share/factory-reset/"
>  do_install:prepend() {
>      install -m 0755 "${WORKDIR}/reset-env" \

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


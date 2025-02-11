Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A85AC0219E
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 18:56:57 +0000 (UTC)
Received: from AS8PR03CU001.outbound.protection.outlook.com (AS8PR03CU001.outbound.protection.outlook.com [52.101.71.32])
 by mx.groups.io with SMTP id smtpd.web10.1238.1739300211795224830
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Feb 2025 10:56:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ahCiM7uR;
 spf=pass (domain: siemens.com, ip: 52.101.71.32, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4RrbzE6vVlWNTIYgnsQ6FJAXYV41yQ2U2zfO1tNEVCZyRYkUyDzQfY0q/XvqArDwzDFiucPvmtbUi4Gm7rItNiKL5ciY/BTQYVWcJDKW35zx/BVoHaKv4wgPVEKdutP3PGcJlvn5FMcVKCvVtDqyStUq01qVWdLdUsvTo2JSzrFcPO6bquTswr36taghlq9Jh7cLmYFlbFvjFmYp1/doOO6mDT47ErZ8L2smhx7R1X4c8FGbgHwYq5Tyqm7AhhAT9zH7EF0RQ4fAGXf5xcNmdoLRelwO+w6w87HNHTXek5seIAK5vhHpMgR9lXPj9f6RnZHDoU3qkfVClthcnW2xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=safyMfxe2QHMeiFnw33LYHsFfhEeRf3AMX1iBaoBZ80=;
 b=KdmpyZW7aziTNZxFVMdpA0uwOLguC0PU6IP4teTHNfsg4Wr7DIbLn/booAMwcFSDicG+knWk8bykbFa83d/FSd3m7ZVHiwCJeYdWhO1tritnEt4q7ucKzK4iGDhNZfiYbP0it1T2OpNf5dKw4iH3R1VoY7/zjniLPVF/eOWvfWVoTgG0Ac9wZoeqe2JMJOBP83/hwgNz4OxNV1envav60bj7B0ebT5Dwbi7p9jDTHqnVIfkpy0k0VmM1AvRmSJ2cMTa13nRihlru/OeVhmWpUlIQ+TA5ihHZD8CVCWD3J/EEXP6qdlnOJcYbd56+YLWOhxIH4/QTfgkrutXv2cxBzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=safyMfxe2QHMeiFnw33LYHsFfhEeRf3AMX1iBaoBZ80=;
 b=ahCiM7uRAdJYd2q2jzByTJeT/Hutu6PV2r1sSxl9MP9wp+jk2ogPpjB9gWwKYa0jJe2Pdtd3tlt3sBCzfjOgdDVWaSdUeySkOn6GTKJY/CkB1iRjDfDykPJXROjEVr4/ynGNZDFyS0gCDkL9k+BmK5ajHkm0QHQOMNBWqfUofs+dW9IbqCeKVasbkoHYesYZwV+Y4gUhiajOPKrrKSnxJUcDU3skPXwA9fZoD9JwoPrAp6l8E+odRRtLbrLV0PF2hfmK32bIVgR2rvPj/MeUGpEPZuMAwwWPN0EvVjnJlbdsuA/4g9jMNg9vZvEqSCwA9RbTcI51DTV6HAOH+GJlXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB9151.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:443::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 18:56:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 18:56:48 +0000
Message-ID: <2ceea85f-73f4-48dd-be48-a5f927314a02@siemens.com>
Date: Tue, 11 Feb 2025 19:56:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] swupdate-config: suffix package with
 -${MACHINE}
To: Cedric Hombourger <cedric.hombourger@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20250211074636.348469-1-cedric.hombourger@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250211074636.348469-1-cedric.hombourger@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: ca02a703-0b8e-4332-f740-08dd4acdd690
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TEZjVG53VENCcU4ycGgxbm9zS2t0UXBEQUpEYURkWktNaUFPSFEvTnZnSzhj?=
 =?utf-8?B?aGtoSS9sQlkzbWZVZ3FST2xKcW9xY1BaK0hseHFtZm1XYXNqZFoxVDdTc3I0?=
 =?utf-8?B?d3d1ZkNXbW0yYU0xNzlzOUF1RUNERXFVOGQwemVKOVNCM3cyRFd6TTU2bHBn?=
 =?utf-8?B?RVpIMTREaEFzK3lJS2hoVXNtdHZxZ2xnclJ0ZnVhQlNuNXpPYXFFcTVBVTVu?=
 =?utf-8?B?Umk3dDVyMFZwSDJqdkdRVS9ta0JiMGFwVjJGeHFDNWJnSWtOVjE3SUFuWVRY?=
 =?utf-8?B?RWJmbmJ5OG51ZjMzSzVSWkxFTmZnQ0pKemNyWG4vZGFoLytYR1AvaDNtdnJC?=
 =?utf-8?B?TVJBa1pUSVFRc1BONGxQcUMvRWpGd29wcWpKVUhDUnBMZDA3RS9TZzBxVGVw?=
 =?utf-8?B?SnlpdSsrUnRiYytKd04zOVRKZU5XRnhGc1QrUWxBc1FCVTcyRG96bXZteDBI?=
 =?utf-8?B?VUhHUGhtcUtwZHZqVHNnS3hyUU0vaDFHZ2JENjJlYTJnOHZPd2lGVjVST1Rp?=
 =?utf-8?B?cCthaG9xemFlMkI1aUowVEdKaWlGQlIvNTRDTktmVUZmL2lzdjUyZW03TEhk?=
 =?utf-8?B?K1VRS3NWVUNWRUJCQ1lGZTVEVFgzN25KUTNIbXBEYXdydUdvZ29DcGVaWVR6?=
 =?utf-8?B?eEtydmEweWZxQS9IclFnbDBhSWxQSGl2czhnSWExZ1VINE84RGhrb2ZwQkl1?=
 =?utf-8?B?NGszU2N6VmV2VllHcHZ4VS9EOVpKUFJOQlBSaGhHK09SMG9VWkJGOGVhckRL?=
 =?utf-8?B?Wk5naTdRT1RUa2lBNDY5aTRuWjdMcnc4U2g5cVFCS2szRWdIekttWTJvMkZY?=
 =?utf-8?B?LzlsVjZnSkZZYnExTzVJQmhhdk1SQjRGejVNOW43QXBRN0xTQXZGbHJhUlhz?=
 =?utf-8?B?MDg5Q2JMMkdpQnVrb2g2dWpINitudktOaVNMcEM3cThIa3cxZWo4bTlHQy9s?=
 =?utf-8?B?U28yYktmalB3c2NIVythb1liaUI2YlVCMFhLbWxwdXFpOVpJR0I1cXNwc3NU?=
 =?utf-8?B?UWtGUktvcjFpYk10eS9PUEJhUmUyWnFzQWpBTmUvQm5iaW4rWnNVbUlwSEl0?=
 =?utf-8?B?eGl2ZllITXVEaTVRUVJjYXkzK29NVnhmaEdGdHBGNWoxWGlORFFvRVBlVis1?=
 =?utf-8?B?YXlqUlpuU2xCb0NIZ0s4Ny9IOXBkTm1xeVNONjNsY2ROZzhITzRFWWRjV0xJ?=
 =?utf-8?B?dkxYRlRPNVA1dXhtL1JNMHhTZWxNYkM5M2cxM0tLMmY0MS9rTWpPdzU1dWdF?=
 =?utf-8?B?NUEvcGVWYVNDN2pTRkVGWVBGMjkrTmdpUEdDSmk5UldJS0h5eFgydW10TEkv?=
 =?utf-8?B?K25HQ2tmcWVIUmtZcWRvaURoQXkzVXEwaWlHVjhhdnZRaW1TVDhCYysyQjh3?=
 =?utf-8?B?Mm4wVkZ0Nkc0akp6TVNDeVhBaFc4ZUpKZ1pJb2l5OWZrSTBqRDNrcWx6cHI0?=
 =?utf-8?B?MWF1RHlKc0dJLzJDUzJIMmo0TlAzdS84U3NVdVRPaDFTam5Gck5USGtHWDNZ?=
 =?utf-8?B?Z0twcGQ1Z3pJS0l4RDZITEJacWZDblR0QmZjS2tpbllsc2pxeTJXenhNNFFu?=
 =?utf-8?B?V3BtUFFTdzYxQ2h1MlRYV3FOdlR5VFFQK3ZlWTQzSk9scHNjTXhyY3lEeFZs?=
 =?utf-8?B?QmNLMkRWRWxKOUxlWHNGS0F4eWZIRkRIc3NXNi9EZ2lJMUJ5K1VVb2tjWEVT?=
 =?utf-8?B?ZlRKeHhtWXJDUXZNRW9Dc2hHb08zZnU1S2k0MVppYkt0MGJ2dndIMXcrNi9L?=
 =?utf-8?B?UjFGWmY1TEZ5ZjlHODFMWHNWdnp4TVJQbURhL01JVUJmbjBKckNDbDV4MEFY?=
 =?utf-8?B?MWpUa0g1ZjZsTnJMN0xUMkFaamM0czVob2EzZFJCc2dtektvSnpvRlZzWUd3?=
 =?utf-8?Q?Ywd+Nm8+i1abs?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Rm9rTTArTno1ZGVWZHpVYU5yRUJRU1laYjY0WUE3Y0I2SERWUThwK0E3RHI0?=
 =?utf-8?B?c3JjK0dpbCt6T3pYeFFBQUZkc3poOWdma3AvQURoRk00akpSQUNGeVVaR3Zm?=
 =?utf-8?B?ODNwZTJlOXZJOGFjaHQrRm54bXEzL2FkNnpZait5Q0ZtaFNKWWNUSVoyTCtr?=
 =?utf-8?B?WlNWSFBieFFhZGFMdXBmaUg2U3JiN1NOVWhmNk83STBFejdNT1d0Wkswc0tV?=
 =?utf-8?B?Rzk3WFJINWxBSVdEVWpBMGtDYTI3cXhtZmVYMTg0T08zeHJSS1MzZEZhNkpr?=
 =?utf-8?B?STVrZ0FISWtoLzJZV1ZabXVEUDI0Rm85Wi96cHh1WHM5NnBoR2VhR3BIZk1a?=
 =?utf-8?B?Z1lUK21IV3cxQjFZdW1Dc05GTjFKRVdpZHEzQVpHWHYyd29ZODVVRmtxd0dp?=
 =?utf-8?B?Si9RQVdZOFpnemtSNzd5SitRYldOVW5nR0J5L2YwQmV3ZUNmMUtCZ2p4T2ZX?=
 =?utf-8?B?OWMwNzJKKytWdnBzRVpFbkRuV2pyaFZRWWxhTlllM2hMRVVkd3RIYmg4UjVy?=
 =?utf-8?B?SWNRSW5DYURwaHZvcFFzclZ5T3RWTS9idHBmaENtUXhHSUlxN2VJaXF6UWVD?=
 =?utf-8?B?QWU4alhySDhNQmxEd211WnFOVGM2Vlo3ZmY2VlBVUXRiZU9tMFNub1FiNndi?=
 =?utf-8?B?N1pyeDNMQ0hGNmljRFpYNTEyMVZPNzdKNXgvUGhJS3ZBcHVVSXNIRWpRdGVn?=
 =?utf-8?B?VGQvSWtlZGFZSkRqay95M3hGbWZidDcrd09la1dyd3BHZFVjNUV4L2p1eklC?=
 =?utf-8?B?alBPMUt1WUVqTXFqSWN5RC9mTDVOek5mV3lkdzB3UWlEOHZUWGJsd1N5VG4r?=
 =?utf-8?B?S0RzcWdHTlZIUFVjSng0Vk9VQ2ZnM0VuVmlUdUo1RnBlUFBzakZSaEE2R096?=
 =?utf-8?B?bEY5d0gvaTB6NVJtaW51QjY1ZVFERTI4U0NYKzNKa290Ukx3WTVkS0RBYnVW?=
 =?utf-8?B?TllwUWRhRXpNblpuS0lhMzBxbHZoNUpnS3ZpN3RiTTV0azd5RDQvZk4xZFdr?=
 =?utf-8?B?OGJpd2xhN0M0RFZneW9vZkJZWnhLei9Hd21BeWdnWXZUMlJwbkllZEZtSVBF?=
 =?utf-8?B?Sm50NHl3aEZNR2hYd0RpL0lLM1VhL1pFS3hrQXBVOTdhNGMxNWpRQ1BsSWQz?=
 =?utf-8?B?dTJrYy9DNVBCc1ZjOHE3bFhEQzlwZVdqY0RoRmhVWGI5djdsSTBIWDI0QlBM?=
 =?utf-8?B?VE9pRGFmMkFvOFRHL0I5WWVzTmI2WUVKMXFjYncrYkw3aVhJc2x4UUZWSita?=
 =?utf-8?B?K042NVc4U290cUswYzFXeWJHLzVCSk90WWdGWVdBTEcwelcxQnlnVVIrOTBw?=
 =?utf-8?B?UXN0SGh6N1BNeUU3djVZend1c1h2b1FubDlhNzNDaytHbFdBempJN1hiYURB?=
 =?utf-8?B?ejE4d05aZHlRMXRyMFlWZW92MVE3QXlUZlRIcGdrKzAvZHk4QWpFS0lqT3lL?=
 =?utf-8?B?OXBGV3o3dFFtM21vNUE5T2NMSGNkNzlrUzYyaXZVYXQ2ZWFzcDNOWktmRzdM?=
 =?utf-8?B?dzA4d3Z5MnF5ZEFFZnI4cldoSjRVR1hJTWR2TjIvQnNaUXh6UXhidC9QL2o5?=
 =?utf-8?B?ZzNBb2VJbUVhd1pGZVErT1YxQTdJTjZEeUJMTU5FRlZJbjRld243SGdLNEhz?=
 =?utf-8?B?V0pXZG5oaWI2TW92NExZeUZ2SE53cTNmc1JIU24wbEhQazFiRjFFY1h0Q3VD?=
 =?utf-8?B?QzF1R01PWjMzbG9yUGVWeUpBZlRxM2NZRVpUNVZPWGI0d3BMUmFld2RQZW80?=
 =?utf-8?B?OFk2dWdCOExhRVBrYjhlcE9SbG1EL2Y3bmcweFdrY0FrbDY2WVVRTmNLbzR6?=
 =?utf-8?B?TG9HOXdoOTZhQ0V6RnFKTy9mQ3JjY2JvaElSbVlNeDVJS0NVSlJTcVUwazNz?=
 =?utf-8?B?czY1ajZ3NCs4RUpxWVp4Vjk3dEF0TGp5NzVaU2xJSloxUDBtZ2NRRlBGN1JG?=
 =?utf-8?B?N0ZzYWllZWRoZ2FEb3B6eUZJTFlTNTYxOHdHMHBLSkZleFcrd2FaUCtobmk5?=
 =?utf-8?B?VGlVdHdlTWQzNUM4K2hPR2JyUTNWTGErcGR0YlBhZ28zaGdyTXVLUHF0cmRK?=
 =?utf-8?B?dkVwVmlUNUJKRnpEeGZiekplTy9uZHlzdHlTL21WRkJvMkl1M2NxeUdjVTJ5?=
 =?utf-8?B?WG0zN3ZtYmNRWFNaeFczanEyWGZ5K2s5Ym1wV0VPY0FzTCtBQlJlcHJlcnJX?=
 =?utf-8?B?SFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca02a703-0b8e-4332-f740-08dd4acdd690
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 18:56:48.6501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPt2yFKYktGQeMYMh5PNd18NVrPFZzORBsgApqeYGRbKoKY2Viu7iKMgEE4LVbANng4WEaDmclF0s/66Nyf/Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9151
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Feb 2025 18:56:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17812

On 11.02.25 08:46, Cedric Hombourger wrote:
> swupdate-config generates ${MACHINE}-dependent code since it uses
> templates where ${MACHINE} is expanded for the configuration files
> it ships. This causes problems in multiconfig builds. Dynamically
> suffix the name of the recipe and package with -${MACHINE} to get
> a separate build for each ${MACHINE} selected in the multiconfig.
> 
> Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
> ---
>  .../{swupdate-config_0.1.bb => swupdate-config_0.2.bb}       | 5 +++++
>  1 file changed, 5 insertions(+)
>  rename recipes-core/swupdate-config/{swupdate-config_0.1.bb => swupdate-config_0.2.bb} (89%)
> 
> diff --git a/recipes-core/swupdate-config/swupdate-config_0.1.bb b/recipes-core/swupdate-config/swupdate-config_0.2.bb
> similarity index 89%
> rename from recipes-core/swupdate-config/swupdate-config_0.1.bb
> rename to recipes-core/swupdate-config/swupdate-config_0.2.bb
> index 3495285..63fa320 100644
> --- a/recipes-core/swupdate-config/swupdate-config_0.1.bb
> +++ b/recipes-core/swupdate-config/swupdate-config_0.2.bb
> @@ -11,6 +11,11 @@
>  
>  inherit dpkg-raw
>  
> +PROVIDES := "${PN}"
> +DEBIAN_PROVIDES := "${PN}"
> +
> +PN .= "-${MACHINE}"
> +
>  SRC_URI = "file://swupdate.cfg \
>             file://hwrevision.tmpl"
>  

Yeah, multiconfig is not that frequently used downstream. And if so,
then for composing complex images (installer with target image
included), not for building multiple target images at the same time.
Anyway, the change makes sense.

Applied, thanks.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


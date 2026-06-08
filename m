Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2606CD8C92
	for <webhook@archiver.kernel.org>; Mon,  8 Jun 2026 08:36:10 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.71])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50017.1780907769889210048
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2026 01:36:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fChxmZeh;
 spf=pass (domain: siemens.com, ip: 52.101.65.71, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZZErhfC3jiV3rFiTAx+YFahIE/ZN7lod2H4ZxHzex9mQDcz1VJQBv94vThyXFn+kKnawmYJ21hVOq5AH/XEOdOJNUCvv7d8Jmc6G/sWcNwg6HjQjZmSgPshP4w9KhWE+b0HpP958dtzAGpAu+nlqbg2IC3e/ijfnD5aT2gUDvMi1yuCIcA72tMPJdVWSFWbr2QL3tPRDtdI3JrqsKT15Fqsw0VtLS5qH4ndzlcZjRj2mJlRBNURorfcTm9NKkiBto8K7ryPoQeGwpsAcLP2aY8G4L4WdOxL/wh/YBKa9E210+DLGELu54k3c46QCgn8y64TtKtfXjFb79Tadb5c8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHJeSpAZWY0zwrSxTp2fYUSHeLzJ10IKoGwFp8Mmioo=;
 b=isOc99z7JPqaI70IOhpvhfDZzXuWkzm74NdP1RCBKhLxNyf9NpKAsQ436BQEC1R1QCUAspm1381KnqXC2Rp7g9m2hsmZD3cRmoOB9aw8E3IIhEIUTN6dgDxu1ML3VsGz4e2NwyNpZ1l9oh4Yt6JMMPQI7STxIOcNG43XJJhNDmEcAmXroFu8G/opIrdDfz4ba64F39U38WLVlsjkNKPhQrNlDg5JZnDgsuMdi9CnEGLEdI2gHwDOJ/GZMf6IrcR+dvpJQ/uFD2JOYBcnNN6ZLPFjsXuanE+6rZ6wGlEYY7GaAuZOfyvdXNo9h3VopJJ2dLlgKwzyZbSe2hnSSIYZJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHJeSpAZWY0zwrSxTp2fYUSHeLzJ10IKoGwFp8Mmioo=;
 b=fChxmZehfLRpcnDONuKV2dxj4Iu/v5Ing0jHmUVr0cYHYtiQTfEMK5CAK+nwrHP88jmw4gxpO05Swfts6Fmu8gU4AJgVUJ2ovjDhjcdd7u2cMoNL6gfWAgxKGdR5UJiEXPcphcuAcsaybnpbWaJLmbJFBsp0aV2EGtfvFdHgr1xbweip+0hfPXQTSVsabAIkL1+h0FbLiLAYttq1MFxVT2OEvP83bhKv4j/KhgvZRjiDFszxiENRoUtkTFaBhCeITCU1UpSmpLx8ceEt2H6/KUxpk0d1+uEgR8xtM/dseWyxZadxDYLQHijBnYTm1DlEC1AzHEHrgPUkfihJArDAcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by GVXPR10MB8616.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 08:36:05 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:36:05 +0000
Message-ID: <8942785c-f7de-4c3d-9dbe-b8cf290d591e@siemens.com>
Date: Mon, 8 Jun 2026 10:36:04 +0200
User-Agent: Mozilla Thunderbird
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v1] doc/README.factory-reset.md:
 Minor updates related to use cases and relevance to IEC 62443-4-2
To: cip-dev@lists.cip-project.org
References: <20260602060009.50354-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <20260602060009.50354-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0380.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::8) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|GVXPR10MB8616:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e38995-f3a6-41ac-0d8f-08dec538fb1c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|4022899009|376014|1800799024|55112099003|56012099006|3023799007|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	GkjIe9VthJeW9K2v60WwYh1mrHx0UODHwDoAGgEaSdWQTiO012kZkdsU+dmtNDLpcg/ZM5bRKw5MeIhRvQLt3TCZgjsRWEDdk3TzjtIKQ2xJ/VwnocvrjaMJqk/cTNWixeyYQrhkxr1DQJziil0XdUNHFVYXBgsa3pZyggPALc3tr0FBUI6iMajC83fb6+aZ+eGZIcIfMVLtnXwvNZTSQh1Ym6W0QPtoP1r4/HdP9Ie03F/N00I9ot+wma40LswZ7iyibTxMN6+BRRqSkeBH2E/EVHRHAyq1sUtx3o+eKiWjMD3vr6czzgRTL28dqklpmkOYbA7Psz2grD/JAWRm5jxURO3kRArlIyNgK8aSVOMFY7rESvou97UPYi6l5A1fdg0h4jMDqFxDx6UBXy0mtUmhe0N25D2cOSoy2bd7D6clKNXX0/ybaSozFssbysN99RrfM/R09ot+DCPYNCPcSfPq5deFfjBd0LRu/a7PUGZPDdv6nywrjlUiLJDMsE/pxFNUBFBgfM1QaN16p781unT+PzMpNSRIjkgNygRwf/XLg/tpGMHwSD0+mkImE+jgd2BEraWj+JfPevtmyI2HXxEPVQwiv16GJIyYz45KAie9vdbvn+L8k3ImyA+cK0CS/PWtxBoBw8WZzecEgirV++xcMYMu8GvTE07s52ZTx39E+20MMgaody/0rDnpFClk
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(4022899009)(376014)(1800799024)(55112099003)(56012099006)(3023799007)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?REJmcTJLZjZtc25SblZiRmNzNjhCMU9nOVNlWDZQQlE3RzRyZTJ2dEFmMkRu?=
 =?utf-8?B?TnpvbnBtRWdWVmJsQVRYMHY4eWF4NVNtejVPZGNiaUVubkNnLzJLTERkNzJp?=
 =?utf-8?B?NGVqMk13Y0hqTDRGaFpqZ3hYM2ZSeEFWUzA2RkxMMEZpYWI0T1ZSeFM5TXRM?=
 =?utf-8?B?WHZhVyt3MXhXRWFJK0NsVGhDK0gySmg4c25uZHVvalNhdVM3enJzTWFKUTN6?=
 =?utf-8?B?dnZ5Y2lDWUpVUW45RDRPcDl1SkJOMWVjNGc1NmhyUTZKVU84RDkvMndwSmNN?=
 =?utf-8?B?anc3MVNFcE1VU3o1NlR5cnF2RVRjektPSzlzdktTa3pUdnprWVRtaWEyY3Jr?=
 =?utf-8?B?UjZVbjBMdEdKSkUyT1RFV2VkMittdmVKOS81elkwR0lCWk8ya1pURGZndTRI?=
 =?utf-8?B?OERpbE5VWnAwRS9rM2kweEZYTDRzem9YbW1JbUtROUJEbHI2cm0zRWNXdmFV?=
 =?utf-8?B?Z3hidkxENi91NUxUTVduY1hTQS9CK2QzUVRVb2NkcEUzdDM1cjJFNzl5OTVQ?=
 =?utf-8?B?RGxKSllRc2JrejU5WHRsbytSN1VEQVNzbjJyWXZ6NXJYTkZsQjVRNVM1ZEJo?=
 =?utf-8?B?Q3BIN2NMWnZlb0l0THpZR0p1d3RrVWNFYng5aXdGM0JObTJiSzU2RzVSdVdz?=
 =?utf-8?B?OWxPcjArZ1RqRERsbHVIdUNRTUxudTBORThXVUh4RWwweVNxdHU1ZnR0cE03?=
 =?utf-8?B?dWpYcGRBYmNFS1FQNWZZbnV6Q1JJNUdZTk9QcU5jeWpUbFcrdVFhbzFoVHpn?=
 =?utf-8?B?VjMxMHJyQlJYNDNVS2NpTlpKeFNLQ1E3ei9zOGZ4MkUrWW05cTdKdVRaZ0hX?=
 =?utf-8?B?V1BFaVlYblFHSHROQXJiWExJTUNUWlpURUdyZDc4NEkwU0lHQ2RlRk5UdUZo?=
 =?utf-8?B?dzlHZ1AxUHNkK0JaRDR0SytReG9QdVNwelRrd1k1WVEzVklvRktEcjI4SVNP?=
 =?utf-8?B?dEtEWmlRL1FPTlg2UURlVXhmQUJPenZpWi8rb2piTmNhMkkvVWlzVEpsMVZM?=
 =?utf-8?B?bzVTQU5xUnJnTkNUeWJadFhVMXhhcDlRTlJYQ2d5Q2RvQnR6cDZRY29MUVdO?=
 =?utf-8?B?clFmM0twcXFrd0Q2RzdVK1hxUzVMYzcxQmZQM3U3eU0zeDJGUGYrT3EycDRY?=
 =?utf-8?B?UExnQzlmYlJCZmp1Rm9QQkJIdjhUa0FqSGRtUSt4cVNHMjY5UWMvb2RXdCtp?=
 =?utf-8?B?K3V4QW54eGh0amhRaXQ0SFVGUXlQQkdsSkJ6YjN2aDdWY0dpSjhCSnY1SmFv?=
 =?utf-8?B?Y1FwR2tGWWlFOUFDOEphL1FJL2NXWThlVEFaOFFzK1VlOHpuQWsxNVBCZ0pE?=
 =?utf-8?B?YmxFN2RpZ2d6WGlkaVJXcUFNazlOeGkzQlAyTTFnWmR4bm9BUDZuVFBKZm9u?=
 =?utf-8?B?QjdSMjJ5WVMrSmRYNHhvRnFJeUY0eFBMQ0JjUmRzeXdYbGV1VTVFQkZwcnF0?=
 =?utf-8?B?UlZhM2dEOXYwTHgvUXg1U2puWmtIVXdMNHZzSWU4R0VOcERzKzRHdWo4WmRX?=
 =?utf-8?B?ZDNJMEJlZ1R5RVlUWHFLR1dmRHVzWGhOMDdUMlB5M25ZQXc3VTQ1STNvMEJP?=
 =?utf-8?B?OFgyakdHdmFXdFhUand0S0VjbmlpcWpNNFZWQnJnQi9lTU5zNnVPR3VCTzhn?=
 =?utf-8?B?MTFOSDJtRUMxNll0VjNqM0NCSUNaVGZhVHJ6K1hMZkRBajZQekxscTNVUUtS?=
 =?utf-8?B?aWV5anJpLzBvODJkb05RNmlwblFGdVJncE9Ha2l4MlJyTERHeUU5Yjd2N3Qz?=
 =?utf-8?B?SlZZMnF5UndpbTBqamdlZGhncmQ5dEs5eEZuWGZhR1htWTBQeXEwSkxMS1hR?=
 =?utf-8?B?ZS9IV243R0hRTUx6T0IweHFQYmFadmFQUnhzRnNHdmg0VXJXbFN2TTg4UWp5?=
 =?utf-8?B?TjcyU0FIU09OVlRGUWhNWU5td0tVdGVnOUhEVHFWUlpvd0lYVjBKbWdqTEll?=
 =?utf-8?B?MTJWS054WjJubFRBQVFjVHBya2hVenJEWDlvalM3VlJZQldXR2RTNEYyazNE?=
 =?utf-8?B?ckFlMXNGekZNMkJ3SFdkTGtSWlAyRFVZVUYzZFVBaDR5NGFRb3l4aFpEdWlB?=
 =?utf-8?B?UEI5MnE2dnBHUHdhK3pQbkFIOUpQY0F3ZGNsUk1DQ1E5ckt5aUQvNmplV21s?=
 =?utf-8?B?WWgzbDIxNmJWZ0pFTUV3ZEhwTTZDUHBwQjA1OXpodWwzYjhxcnY3L0ZxNy94?=
 =?utf-8?B?ZzRWZW1lOXpEUnV2THN6bGhZeVVoRFVRYjM3SDhMTlRRdHlIR1VLdFFGWXhx?=
 =?utf-8?B?VkZGZWc1T1NBQlFUMVc4SU03VEhrZ3ZtZjQ2K2xhYlBuR292QVZEVm9GdVRX?=
 =?utf-8?B?dWZIZG9FaTM0ajIwVDN5N1BMdS9kZkl0cWh2ZUJsN2V1dHJxT1AvWGV4d3RG?=
 =?utf-8?Q?68M3GI1IeMyd9IMk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e38995-f3a6-41ac-0d8f-08dec538fb1c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 08:36:05.5808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kk6QSteEUOXszuDOTeYl4hhwSQbvEbANG7dq1Imh9qRWe7cVdKpna4+e9TGhaekzNZFZbdvoc2lIyZPhA0aNdnh7+W0quNmERJ2CiKbqgeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8616
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jun 2026 08:36:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23046

Hi,

On 6/2/26 7:42 AM, Adithya Balakumar wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>   doc/README.factory-reset.md | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/doc/README.factory-reset.md b/doc/README.factory-reset.md
> index aa8dd1c..419e32b 100644
> --- a/doc/README.factory-reset.md
> +++ b/doc/README.factory-reset.md
> @@ -51,3 +51,12 @@ root@demo:~# reboot
>   ```
>   root@demo:~# find /var -name "to-be-deleted"
>   ```
> +
> +## Use cases
> +
> +- The primary use case is resetting data partitions (e.g. `/home` and `/var`). This also resets any configuration changes made under `/etc`, since the read-write overlay for /etc is currently backed by /var.
> +- If the `/etc` RW overlay is backed by a dedicated partition (separate from `/home` or `/var`), that partition can be formatted independently to restore default configurations (included at build time).
> +
> +## Relevance to IEC 62443-4-2
> +
> +- Factory reset feature helps meet requirements under CR 4.2 Information Persistance. Refer [here](https://gitlab.com/cip-project/cip-documents/-/blob/master/iec-62443-assessment/iec-62443-4-2/iec-62443-4-2-fr-4-fr-5.rst?ref_type=heads#id12) for more details on how the requirement is met.

Should it not be Persistence?

Quirin
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#23038): https://lists.cip-project.org/g/cip-dev/message/23038
> Mute This Topic: https://lists.cip-project.org/mt/119607103/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 




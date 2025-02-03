Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE597C02192
	for <webhook@archiver.kernel.org>; Mon,  3 Feb 2025 17:06:51 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.40])
 by mx.groups.io with SMTP id smtpd.web11.93034.1738602405531107056
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Feb 2025 09:06:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=R7JxNN74;
 spf=pass (domain: siemens.com, ip: 52.101.69.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfmCHtGnKkIyg2tByD3wK1hJFuOe+v/P3uhBGOt9aQerT6CdP1XJ963oEEuGfFOLJfFJbwkHR3tEfwjq9GAKxYJlD+E/GegBc5bvOUUa+aB53eXMG5U2VHKoJAVtikN0WvbwDuHbMaG/+XBvd50LHVb1vepokVRL5XXugq96l6M2wGLXSzUUX/ZE0sDBfyqt0I8Q2qA+ZiOPTZt8Glb3Hnksj7biYcmFGI952vXR7eAoSCNVR+itaJTl5pAwMg7hjfSWFqI1rPfLmv1Oi0UIi8tWmonVfOi7REPU3MTcC9o3wvZ2Vd/tILQxceAYz1COWJzFpAabPCu41c1w0uz3Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clXeHHJFxmeTDIkcA+ubpZSV6eO9kI+FAOlrgKP+hTo=;
 b=xIExF2+aJeK+cqvsngn7kRjKZ+ICjcNOxh3IzmBW2Bfk+jmhm69DdSxzZlsP0X40A/8sbnjjoBxWQZOyYLpgpdypMlBkmzZwf8/J41lGhFSoIbFYPltnXzRxF4oLnI/gYlD0y3spxinapsn9f9vArXkCfZpDH0gUPCzJRKC20JkifJMOolEKZnvyrxLtiwB1CZM93ihzl95OdALEVWY6Mfk25Fo81mW0A1EIEcKSqHEBXlfGb0/s2W7MlwnvHKN6/GaSqdRztY1DGWRpSKNToDPiKOSPb3thLK3+5r/pBGBye1n0tk+zBvCVjYdGG6FnhzrCmLeb9BQobABlpZSOUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clXeHHJFxmeTDIkcA+ubpZSV6eO9kI+FAOlrgKP+hTo=;
 b=R7JxNN74DCWxpIIO0Vxl5VEQq3LWAMbxiRf71SIL+KMyUdWhRE95EQDKs/eaHEaPG/FfTf5b3gkMYGk+luwtss3EzXym0lI3Hj9GZPNfHVqxOx/yXsEXFG6X9NaUm8SlmAQc5eBbnJgMx8wfK/pESNkt2ChgyooPiXUkutpN3wwQFWEZH8wiU5+AjfzWChGoGAfC4WzTwSrwGOKFPfkC9ZmW7P+JEeO1Z+QO4G3l7gtoLujroT6k07/gXaZ5sYahR8AHdbe19sSevb1lfW82RNMtjGKPS/tXNZkAZwFDBIn6ZMfiSJtJoHubzD2K0OQVOtL+KeDZMGRY3wqnvAh1+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8373.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:44d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.8; Mon, 3 Feb
 2025 17:06:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.005; Mon, 3 Feb 2025
 17:06:42 +0000
Message-ID: <48173db0-c0b7-4393-9e83-bcd47b6140d4@siemens.com>
Date: Mon, 3 Feb 2025 18:06:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Update isar revision
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <16a8dfdd-802b-4ce2-98f7-f0bb235a9285@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <16a8dfdd-802b-4ce2-98f7-f0bb235a9285@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c39bfc-3236-44ec-5afd-08dd4475218a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?elpHUVNOaTN4V2NMbTc3YWxqRUkxVXFjZE9iTHNJZHRXNXRtdjYyYTJ1ZzBT?=
 =?utf-8?B?S1N3dmV3V1dxYmRiNityZnNRVVJ1UjZrVTRRVVp5SWNiYnZ0NVlieEY4b3Z2?=
 =?utf-8?B?eXFEWjQrVEJIWGVOWWNDcU5pZnFzNmhla1hJL1hPazNlbUZZLzJwa25KN0lZ?=
 =?utf-8?B?a1JNMld4T2t4RkFqaXJUMGQ1d1ZZM0h2cmMvUFZ4MW0ySTFvMEYyOU9vK2VE?=
 =?utf-8?B?L1N5bUsyODFid0lkNGJTVHdsYTFzZFhnSDI3RTNxcWpUREdIb2FEWGtXQWFk?=
 =?utf-8?B?UVpEQ3hRbzE1VEFadk9aUkN2UzB5ZHh0cjZwZUN2QzhYUDUzTU9aWnJzYlZ3?=
 =?utf-8?B?MEJUYVhMNEgrWGc5eC94aDhPZEFhWlhxTkxFQUdpYkFPa2pFd2ltZjQ5dVNw?=
 =?utf-8?B?YlpGYzJudDNpZWo1SXRBMHYxVXZoQkZLMU54NDlZS0tuRC9OYnpYaHRqWVBQ?=
 =?utf-8?B?c3c5d2RQRFFNNVV6OEE5NVduSFhXSFJyUkRja3l2MUdBRm96cy9XNm54S081?=
 =?utf-8?B?WHNyQXp4TU40cSttaTN4Nnl4eUpCdXIvc3kzMHQ3V21lbW9zMVpnSWg0QXZC?=
 =?utf-8?B?VXR2VHQvWHlLWDlYQ29ZQ1dUTkhXeVVIRERIV2ZGenhCS08vbTVYaE50Y1ZK?=
 =?utf-8?B?ZEczajlBVEpiQUZKRWQ3QnBDV2JRYVhuSSs1eHBVK2E3R2V6YUNvSlo0ZXlJ?=
 =?utf-8?B?d1U5aEs1dG85enFTL0lYYm0rUGk5QmJMTHBmVHdvWEc1Vkp0ZzJlRjF3YmNs?=
 =?utf-8?B?NDE3M3oyeFZIUW4xRzNiWjZHMFdzMFYyenJOeTkwQ3JVa3loWktQbGdIbVE2?=
 =?utf-8?B?am9FQW9mdG9zTkVLT3lVY1dscXFBbXJLUzlZR2Z5NHJMRjU2M1g2SEFoVVB1?=
 =?utf-8?B?TDVaVlJBbHZoNG1DdVRSNU45Qnhjb3pqQVRtaGkyWTl0d1VJZnNEcm11Mk1v?=
 =?utf-8?B?a3kyNkc4ZEFzbFk3MjV6WTBtUGl2TXMzV1FYUWgwRGlKaGNqVjZaTzhuS3BV?=
 =?utf-8?B?RVlBck10RE9PZDRUcXdIUy9JRkx0cFpnck8reGpyd2RzMVFOUDBWTGwzL1l6?=
 =?utf-8?B?WlBiYWo0ZzU4MFkwRFZqRlA4Mk84eVhwYVFsQjB6eW9HK1lKRk5rY0ZyUXFV?=
 =?utf-8?B?enNBdlA0aTduMGg5aXpXK0lkbno0VkJISlUzZ0lwWCt2dDNVdEF2VktvVVhS?=
 =?utf-8?B?MWlTbWc4bkRmVmpWVS9lN0xyWG44ZUgxYytRWUVRbzR6VEN2MEY3S3Vhdmpt?=
 =?utf-8?B?N2ZUTkFMTUVTRDdZMVM3NEpGc1pwc2VlSlE0cjZIYUxSZzRkZFQwSVlpSzV6?=
 =?utf-8?B?RStrbnphcks2WUVmTnZBRDczOENkUFQya0pzY28vbWtJTldCNDl5Z1hHNHRm?=
 =?utf-8?B?Y2Y0blV6ejIybFJzWjhCejVRM3pKNWlNbHQ0bXhOeTJ5RTR2VVk5NXBuVlVL?=
 =?utf-8?B?TnlQamhpM1N1Vkd3RFpDMGV2WWpIdm11MUhTNzh5VHZmYkN1TmZvLzkvYm5P?=
 =?utf-8?B?OFlDbkdQY3NhYkZlRzJKbW4wQU95bTZmMzdIVFEyVWUydHF5SmN1VkNBMDdP?=
 =?utf-8?B?Mk16U3dRekljdWlpOUMzV0tMV1J4RVRXTEk3UDVRdVAyeFdxSHFLNjdYV0lB?=
 =?utf-8?B?cHN6bmpoWmtTTElqeVEzT01BbXhsYW5NN2tmY1lreVJmMFdnVzdGVytMOVJr?=
 =?utf-8?B?ZFF1UU82bFdTb3U4YUVSWkNWb1kvV052dEtYeUNMcklOTG44WUdLRkhHSUd5?=
 =?utf-8?Q?Op2D0ONidnnyn5e65Vzc4TUqIf7FqHcdZay02vs?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dzFCRVU5SFZxNHQzRVpqU0ladHRzRjRsSnBaelBORElwVW5UeWdKT0p2eks0?=
 =?utf-8?B?RHdTQ3NwOEFmOUl3R1lzOFpOSHJuU0llcjNpS3lMYWxZVWZISTh1bGVSUXhx?=
 =?utf-8?B?RUc3cUNDcmtGK3gweXlNcFdrTFloMThXY0ZrOTJqcVpJMEdBUDlDeWxJRVdG?=
 =?utf-8?B?MnN1STA0dGVNT2M4MmplajEvb2pFM3lYOFRlMDVGazdmWW5PTlBpa2hPQWhk?=
 =?utf-8?B?akRuTkowV0NVcVZWSjRTTC9neDFsRnluaDVVaE9rSHJkdFY1UXkyZHBwRUhJ?=
 =?utf-8?B?WDZYN3NjZHptQ0N3QVVZS1pBWUg2R254YWowTThDL2xZcStBOURSWHhtc2Rl?=
 =?utf-8?B?TjBmMVBNMENOb2wzVlNKODRuelhlWmhacUo4OE5pR0lvMXUyWkpBcjFZUEZC?=
 =?utf-8?B?ektXR2VIK2lRcDdvNXdCRXVVVWdhR2IwRHN1VzZrUXkyWnJsUll5UW9ENVFK?=
 =?utf-8?B?SXhDaExmZ0tGaVNkRVpyUEFmekYvalQrbDVkTDg1bU1JTDh0ZlB2Si81RjFG?=
 =?utf-8?B?a3NuVU5mcFVnVVVYMUw4TXdUSGljRDA5ZTJoZGg5Ym9pKzVlV1l4TTcrc3Aw?=
 =?utf-8?B?dWxQWmpCRE5TUnpWY1Bwbm9jcGszRkZNUDZyZC85emx6ZHFnc0NkZTFaWHg2?=
 =?utf-8?B?ekxWVG45blRReHhLTGVGS0h3WXk2UnlUVlk1dllIUnl5dEIvZlEveGJwejBt?=
 =?utf-8?B?M0NoclV2Ym5ZK3pJcFFtdTVDWmMxVHlXb0ZvRUd2U21BTFdJamF1U01MRWZh?=
 =?utf-8?B?SCs2VEtMMjl5azZUSUZjcldsRHE1bnVZUHN0ZmJtTVErRUlWaHY2SU9BUXp4?=
 =?utf-8?B?ZGdFRGkyRjAzUHlFajJFSEg3cVRUUWk1WkVxeHh3R2RvZFkzRGFNWDdZREtz?=
 =?utf-8?B?QlpvR3JIdW56OXdJb2FETlVySU9SdVFGQUdZRitOVlZKS1VXTzRua3JnVHdB?=
 =?utf-8?B?dSswZGlGQWx1UzV0YnQzQ3FzZ2lnbi9oRGVvNkJnRTdhMTFmZUg2d3F0OWVU?=
 =?utf-8?B?V1VwaUZ6UVRIVk1WQk93MHlhYUVhdmxYOXFsdE1UTnB6em56U1dhTHRzUERT?=
 =?utf-8?B?cTJCNS9zUWVyUzZUTldwbXp0QzRLeVQwRUdhM3MwbXhXUk9EV21DVzVYb2p2?=
 =?utf-8?B?VGg3UE5IaXBIdXZwbDNRTkl4Z0FQbUFBMWI3OXMzandVUXJvQTVkZmdvcFd6?=
 =?utf-8?B?N1RXZkoyUEFCQlZzS2hCRHpuUjNlem9FZjhDQ3BNNFhkMEhqbDB5azFjbnRB?=
 =?utf-8?B?allpa1hzdGFmK0xjdEdORDBOeW0xTmJZKzdhSTMxaVJyOEx0TTV4c29sT3o0?=
 =?utf-8?B?eExmaHd4RVhtSENUUjFCOW9YVk5RbjB2Q28xeWNsbVllaUhDRXhtVkVRMHVx?=
 =?utf-8?B?QUhEbTdqcGgybnNSYmRmVWlQSVRVWS9nTnBvQ3hubWxrNWxPbDY3U1BoUlpS?=
 =?utf-8?B?M1dIVUoreFBlTEtGalN2emkzNWt3eTBIb09XNk45dXZraDNQUFU2eGU3UTFl?=
 =?utf-8?B?NXBSVm4rc3BKUzU4SWxvYjNQcm0rMXlWVUlXQUw2dEczMjhpTGdRbmxseDFz?=
 =?utf-8?B?RzdUUGxCZllMd0ZOZDJXNWhmSStaV0RESGtyL3RqTTRLVHJFODI3eGlJc01D?=
 =?utf-8?B?amhRV2JzZm9YVEg1bTJNQkhwdXFzTU02YVVNcWtISzNpTWt1ejlJMVh6SGlU?=
 =?utf-8?B?ckpiYTR5SE1jaXZQN2dFbmVSQ2Q5Ni9vWDdsRXZnbXNNU2lhTFltSXZteG5q?=
 =?utf-8?B?c3F4RE9ZZmhQcjFTVlFmMFZHdG01NmFyUjNYbDROVlJNZnE0QnkwTWVnNVJL?=
 =?utf-8?B?ZE1Rc2h1Vm9OdThTa0t1c3hZVUgxNkpLOFNRUytSWHQwUXdKaVdLUkhWK0dj?=
 =?utf-8?B?UDc3Ty9VNkt6R05YaVg5eGpIZzdBcUx6V2ZROU1wdUlKMVkrRk5abHlQNVQw?=
 =?utf-8?B?RWxTT2RyLzJnZkU0Mkk0OE1ic0w2WnZYcGZUTDFnakNiajVmWEIrOXFNb0w0?=
 =?utf-8?B?b1dZT3BPWCtWWjh3am0rUEQrdTRlWVRKSkEzYUJIN2gyNkpkSVppbHhFbzJY?=
 =?utf-8?B?TEpSQXJ2MDVacWsxSWxYVS85VFNoaUY1N1gwRUlOYVVraHZaRUwvS2lsSzU4?=
 =?utf-8?B?eitIQ05LRUZPSTRJaFdVeFBoNnFCMFhxNVVLQXNHeFhzUHlBSGh1ME04bjJ4?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c39bfc-3236-44ec-5afd-08dd4475218a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 17:06:42.3253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pm4rg4+rDrXy2MhwEuYe9aCLcUvvq9YzUnHjwqDXWUOO7cOmk7Mo4RjUBzkWdhT9pyzccnyA6x+gZDwq6SOR4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8373
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Feb 2025 17:06:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17732

On 30.01.25 14:17, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This specifically fixes riscv64 booting of swupdate images.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  kas-cip.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kas-cip.yml b/kas-cip.yml
> index 1c868afc..f653b9bb 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -22,7 +22,7 @@ repos:
>  
>    isar:
>      url: https://github.com/ilbers/isar.git
> -    commit: 37cb017a0e63f9cc26c5ff1805190a95cd0cfad9
> +    commit: 09305ffad6d86fc63ec7ccb4f1aefb4ea488e9c2
>      layers:
>        meta:
>  

This one needs
https://patchwork.isar-build.org/project/isar/patch/6c52b13f-0f6a-4749-8b4b-343b801bc431@siemens.com/
first. Rolling back for now, just be reminded that riscv64 remains
broken then.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


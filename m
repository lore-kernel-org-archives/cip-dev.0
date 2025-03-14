Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004ACC28B2F
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 06:22:42 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.30])
 by mx.groups.io with SMTP id smtpd.web11.7726.1741933354407977317
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Mar 2025 23:22:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HeOos4q9;
 spf=pass (domain: siemens.com, ip: 40.107.159.30, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoAgMudZR3Ma1oSNyN2fiE3NSwB1BUS8oFkhjQlgI5hxbYegXzIFBfZO97fnm+jWN8XtMOUjBlQWkEyNo9z7VROwq3ZxwR+N8eih+fu7TrvqKZadRs8aIUNZ2NegjxB3xbc2DPWOwYVVnr7gnPRj0wmrva9FbAkVnUVUBwxgzvMeNK5/sldlD9H+fc2mzWaNFQrcw04Q4LnjQ8vNyLtliR2oGxBCKOt9q1DUKBM+TCMe77VEOJInetY2jc63JgyBqSRatfgXcX251z/2+BYIKnLc4qX7GsKVJBM6+gDEK9Jq33k16m6K8mosgAbOKsWbX/BWizTUOLbLVyTQ2A8hrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coqzX962lIDdpm6GwBP2JJAF1BztEmE99N6oI4VHDF0=;
 b=uHOV2mHMZdO92dY8qpByKKmEfrS7OZElxavmMQtZ5UzIBGMDnfbOlZ7BZCVSrwvHl3buTddz6lhmFRD+01EjN6kne8J2O1ZfmewSeCpkWEoNs/5BruAIrlxHWn8eCBVQI5Q6XAcQ96WCTMWQuCVbZc9XyMhJoA9uW2ZXlMYBZn8xKGI8WT60kH9WvdQdiH4aPqLB6ixJnBXg21Gw75Af2ztG7s1QUqcZ7pRbjyKX+uvpj/cbIYxNEJOM26BEDIoDgn5OmFcBRrMjHJ5C8mnPvzbgEg9X6nnAuuZR2RqMv1g42bg5dNyakrpZfCimWmsv60CYJjoWv5dE5nZBIFgzJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coqzX962lIDdpm6GwBP2JJAF1BztEmE99N6oI4VHDF0=;
 b=HeOos4q9eTIFPrSVny7njDvQnCRZI0wAO0pRJMkCD2ifyOtyZld23EdPJ6ihN+kZ3QDC+Me+XJ81olOAF1V2YS6HSjcPe+5HAwAA9IL8j60hRdIh97h9aLhnmZvu2fHdE9Gyh1q1WatZJWgHTJNJ1ipOTiqNMvY7cPrHF2+Z5Yxipg9Dobd8apTx8oa24IyT7nB7jwNJqJtvuVywt9L5EYljomvgz2v5x/yKrFqcrMnXqc3+VixEyRG5tK+kciuvIm3pCOjy72Igpmb7DciWLllV8yqeW1V4aJUPE5HoEPx3Q2GY2f1JZVgUPrEmbEwpobbHyKfmYP9OpU7co19SXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3772.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 06:22:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 06:22:29 +0000
Message-ID: <e257c556-a123-4b71-a8f7-725581dda22e@siemens.com>
Date: Fri, 14 Mar 2025 07:22:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1] .reproducible-check-ci.yml: Add
 x86-uefi target for reproducibility test
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250314061421.2146773-1-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250314061421.2146773-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0426.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3772:EE_
X-MS-Office365-Filtering-Correlation-Id: 5120f251-6e35-4554-e109-08dd62c09891
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?R21QejJJaEJEWGNacWRsZFF6cEkrMHNyQ2UwYUt3WXhqMHBQNlZsTzlUd1Vn?=
 =?utf-8?B?T09PTmtUbzdXQzQ5MHpZcGVCa0RRM0thUG9vaWxmU2RuckZpY1l6ZlVWS2Nu?=
 =?utf-8?B?RWV5UjlnV1ZraHg5RTM2TDNmeXFUSHJFZG11c0NIU2VRTGczTE9NMlozL0tj?=
 =?utf-8?B?VWdtMElLaytJWnp3REEzdUlqb29vVkVxcngvZWNWVDBoT2ZxL1dCYlZpRVgy?=
 =?utf-8?B?dGZKandtMkZueG5OM3IwUmpYd0xyOEJTL2NGU0ZwaHRTbFZXVm5YOEV1VEtS?=
 =?utf-8?B?KzlFZEhnYXdmNzFRemRVMGdSSDRPeHViUTJrRk1uQjdKQXVUWVVmZEFzdEJH?=
 =?utf-8?B?MUQvaWJxbndlRmdPcGdvamx0aUxGOUFXRitTNmo0MGdJSDdsTGwySDlGV00w?=
 =?utf-8?B?UTA0U0l5K0tVbjRKaWp3S2puSHZGZlFVRUxTdGpjM0UyZWFQY3NzbWFuWmxC?=
 =?utf-8?B?V0RSMzZpaVIzbUVaalUrRVBYaEtwS2E2clA0NVRBZ2V2andQL2tkOHNYdU0w?=
 =?utf-8?B?OGl1WVNBQTV6eE94VGxXeDRqK21UYmxSazFDZ0J1QUg4bTlQMDNGclgzeTEz?=
 =?utf-8?B?a1BBMTZlRzFReUlmSlR2T2JXTnYvRVRFaU1HT2NTU2ZrS3B2NnRjQ2NVTjQ4?=
 =?utf-8?B?bFNtR0lBZFNNVTIweHZwbWMxOFB3aENPR294amZRMTRmakpIYkpEbW12MkRy?=
 =?utf-8?B?VzRBWkQ1eVBSL21vd2tPOTlOV1FsWUFRT3M5M2JQNmNwdVV3Rm05WmdqRUdq?=
 =?utf-8?B?RDhXRXRzS2NTc2c0bGNSb1FYbU0wN1dpazdQa04rd3lnRC8zVW40dERQQmJU?=
 =?utf-8?B?TEYrNTdxdTR6UmQ5amwyY2trNndzd2doUXQ4VktMQTgwdEMweEhzajU4bjNC?=
 =?utf-8?B?am9zZUl3eGd0amg2cllmYmtBdTQ4dGxWaCtTcVpVVm5XQWxDaFI0RkRTdEhT?=
 =?utf-8?B?TFhIcU0wK0doaEJwWFViaDVjT1BPeXpscG1tM2JJMXU2ZjU1VG9jUk5tVlJw?=
 =?utf-8?B?eUpVV3VGUkQ4eWhXRjJVRDU5blFpN1JiaHhLL05kWlQwMlpTdGt6Z1A5Rytw?=
 =?utf-8?B?YVB2QVNWV0RYNHBBR3plUmFwWjZRekd2T0hDSzJRUCs1RkYzcVBEUGQyMm9Q?=
 =?utf-8?B?cVp6WHNGMEg4bGpDYVZ4QVJUT1IwOENTVDZOOFpKblZRTy9LaXlMbkE2L0l2?=
 =?utf-8?B?ekFra2VZbEVnNk10LzNmSEFPSnJpeC9rbTgxc2p2OEc4M29FbGFZcXI2MnZC?=
 =?utf-8?B?OHQ2MmhEaHAwdmM1THl4Ny9zUWxEU2ZwckhvRjlBbDBnbW9hM2ljU0FUd3JE?=
 =?utf-8?B?OGtqMWFnSGY3N0xIZW03VlBjVkRITFVwOUl6cWUwU0JlOUNLYnZKVGszaFJl?=
 =?utf-8?B?aDV3YmJ1Z0FUZ2dWdEdrc2xod3o5M0F5L3ZmSlVhcERpSTJUYm9ZVGVJeUxt?=
 =?utf-8?B?NUN6NWhzUXcvZUVTVXQ3dGEwNjkwT2pXeklYTDBaZmt3NDU4OEwvclhqSUdZ?=
 =?utf-8?B?R2FwV0ludXY4WGJvQlN2TDVPb0M5NitEYXJmdXpEQjFJWEFKeXVnekJrenZs?=
 =?utf-8?B?OVNiV2x6RXlFNVlhcXVJOHg1YndMdmpENVcvUEh1S0Q5aTVpVHhFUlNTOXNU?=
 =?utf-8?B?K2ZMREVSTmRqclp0aDc1TVNZVlowajdMM0RiOUVaNlVRNVE5OUhuM08yUU1o?=
 =?utf-8?B?SExqTmtZU00yTGJkSzhhdFV5MVZXY29UbDY3OVFJeWQ0bGxDckNZdm9NUzBO?=
 =?utf-8?B?b0ZUaXNhWjJNSGlReTRzemR4bVFUa0JpU002NUxyajV0T3o3ZW9JQlQ3cWNK?=
 =?utf-8?B?dUd2djd3aFVnZ1gvZ2JhdXZqSkdubXRnSVBaNnFnbGVkSzI5dUtheUZMNmdJ?=
 =?utf-8?Q?3b/3P2Z4FcXJA?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Zi95eU5QbU16d2xZaWd1UXhnbW5Tdm9vd1BCU1laNVJqaXBkTjFPZU04NThi?=
 =?utf-8?B?Q2t6U21iajhINE5Ld25QcHVYaHd0NVBSRHJxeFhoM0I0K2VGbWxCQ2RQcHRB?=
 =?utf-8?B?U3ZOYVdNZ2pjNzhwUUJKQmJ6eStEK0pSZFFING5UN2xQbzFQYUU0eWc3aTIv?=
 =?utf-8?B?M1FNUWxaTVJRQWliaWtXak9zbjJ4bjdhSlA1S21rbW0zTDFDVWJSNTVhcXhw?=
 =?utf-8?B?ZUYxRnZ1cmlLNmdYTmUyTVUwVWxJU1ZIS3pLMUFTTnJOZGU3TGJ5NUx0eDhq?=
 =?utf-8?B?aTZVYWtad2Q5T2dTRmNpbWlMVGQ4OTkrWjRPcTdEZVFoL0Q3dWJoZUFqRWtG?=
 =?utf-8?B?cWgxT1FZNDlFZTNrZEhFQ0xVVkFhRmFKL3ErZTJUeUwzV3ArS1hPR2t4SWdO?=
 =?utf-8?B?UGJRbUpwY2Y4SUo2N0tydDJqSUptYTV1b0tNUW5PUjd5blkrSDVRWEt3R3lH?=
 =?utf-8?B?T0JGUk94UFcwaVBQbHFPWXQxWVd6MnFqeHgvd1VpSHYzcGVuVWw2SXhhZU5x?=
 =?utf-8?B?b1RzNjR3WXptckwrNDh2MkFKcVo3QW4wU2gveXREMXh6TWlWU0NEWFJtQ0g0?=
 =?utf-8?B?L3cxRFBSeXo5eTdZWllNNkYyNnlpNlgvejZET3NXM2RWTXZUSXM4S2l4OUly?=
 =?utf-8?B?N2RzRXdiQWpqOTdUNzlGS1NTOW04VUF5c2xuUTVFQmNrNnUvcjh3NTdZU24y?=
 =?utf-8?B?V0RFdjZwYmpYL2ZDbndPMk9NSEpzU0NKVjFaR3g1TURiNkNUTTlwdXBQM2NN?=
 =?utf-8?B?TGZUUUdSaU5CUnN1UFM5cGRJbHlqY3diZ3BYTUU1UVZzbjloTlRvWDdTOFZP?=
 =?utf-8?B?ci8yeXBnK29Hb3NyTFJ4cVNYa01ncW9CT3R0WnQyNlh2MjA5SFRWdHpKWkxw?=
 =?utf-8?B?dUhZb3J1cEhKWjlPYjZkWDFaM1hxTFRaSFpTcFgyNTJPRUo4cURUSzRMd1Q2?=
 =?utf-8?B?VzZuUFYreWFXSFp0dTZaWnd5eDFnaVlmbHBzVUg1WnRJeFNIcng2VkpzVHlN?=
 =?utf-8?B?bjdXZnRVYUxzQUhueDBzNEw4dm5hRFRaNGJZQmpsbUViOGlxaHBtOEhPODFS?=
 =?utf-8?B?YWhoRW9pSDNtRTdpU1NCc1RBM3ZRSldFTzhOeEsxSm5CKy84UGlCakN0QW9r?=
 =?utf-8?B?dlFqWHZzYThKSWVqeXhMd210cENKYWJ3eWY0ZE5mcVo2MExVRURkbUJvT1Nr?=
 =?utf-8?B?S1diWVQ4T0lYaER4UTJFTmJqZC82SlhDcnErWE9keDBCMkNuT29vRmcrVkVZ?=
 =?utf-8?B?ckpiNEY5ckdWS0R0MXdzWmdCTHRJOHpoeEJUVE1nUys4QU81RDc1ZTNQUXlU?=
 =?utf-8?B?SENlM2h0dDB3T3RYS3VtM0p0cDd6a1UxNVJEcm10YWZWMDNObHJXcm5jNjg0?=
 =?utf-8?B?Mk40S3phdlJyVi8rM3lvTnByVUVJWW5HazNwVUJia3VTVTIrSjRjcG9zRFIy?=
 =?utf-8?B?Uy9sSkQwUWJXcmRSTFgrRjd1TkZENW05K0p3WEJ1SmszcGtEdmo0UHo2L2VG?=
 =?utf-8?B?YlpxaWpNVkF5R01BU2svc3pFenZNbWdudWVWSFJ6NFZPTEJwVHhiY1dFbEg5?=
 =?utf-8?B?eEFHeENTNWNkMkNPUmNZYkFaaXd3eFh3UTBWUjlESStSK3NwODdudEpRQnd0?=
 =?utf-8?B?eVV5N1pVMG15ZE5xSG1JUEVXbldXTVdFV21Rb3pFY2xEUWZhS0NjbHNianhS?=
 =?utf-8?B?VW9NWmRnRWEycDJ5ejNWKzhyc2x5VnNwQng2K3M2WG50RXN2d1dFSnhIcEVY?=
 =?utf-8?B?cGZ5TTNjR0RPWTZ2aVNqaDJkaURBbGhUa0kyblN2L2FPVkJucnFvVFdtWk1y?=
 =?utf-8?B?aWF0RWNjb2thbUJkOFNNeE11aGsrZUhZd3JwNUpNVEhXeGVlOW1UNmZJbUtF?=
 =?utf-8?B?anA3cTlXQjJOTDlDZmdOdVJWQXZYaEVvd21FdW4rd1dXR2FtMW9XYnFiUXUr?=
 =?utf-8?B?dHNwUUhRY1Q3NTN0b1hBOHRjdk9sTzVvc0Y1TU5nTHVXdFZ0Zy9IVnBTazJx?=
 =?utf-8?B?Q1hoTWd0Tzc5Q1FHNVgwNk1RRE5IMWt5TTE5SE9zRlV1Qm1RbkZBRnl5YXZR?=
 =?utf-8?B?SzJ1OVZvRURPNEJxNjk3RUNMWWV1clNFdTZXQ2plMHlsby9yek15K0puVlZz?=
 =?utf-8?B?WTNQWjBCbW1Pc2NPSHcvMG1aWnRYK3QxMWxPS3ZrNVJaa1pVbmkybmJiTW5l?=
 =?utf-8?B?c1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5120f251-6e35-4554-e109-08dd62c09891
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 06:22:29.0646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjRL19WaEnif0+og25S7qMT5solgp0cbe3pHhrjjXtXp+gFNGsor87qNlZrGkLqJlUpNryIMSvw2KnGaUvWFvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3772
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Mar 2025 06:22:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18201

On 14.03.25 07:14, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> Current weekly reproducibility test has more virtual targets (QEMU) than
> physical targets (currently only BBB). Lets add x86-uefi as well since
> its supposed to be common target for all x86 based devices.
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  .reproducible-check-ci.yml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
> index 7bf1ac6..7dc4b60 100644
> --- a/.reproducible-check-ci.yml
> +++ b/.reproducible-check-ci.yml
> @@ -96,6 +96,12 @@ build:bbb-repro-build:
>      target: bbb
>      extension: "none"
>  
> +build:x86-uefi-repro-build:
> +  extends:
> +    - .repro-build
> +  variables:
> +    target: x86-uefi
> +
>  # repro build test
>  test:qemu-amd64-repro-test:
>    extends:
> @@ -129,3 +135,11 @@ test:bbb-repro-test:
>      extension: "none"
>    dependencies:
>      - build:bbb-repro-build
> +
> +test:x86-uefi-repro-test:
> +  extends:
> +    - .repro-test
> +  variables:
> +    target: x86-uefi
> +  dependencies:
> +    - build:x86-uefi-repro-build

Thanks, applied (assuming that this passes right now).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


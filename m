Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA26BD41D74
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 12:18:24 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.64])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.47048.1765801100794517263
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 04:18:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gi5+Rujo;
 spf=pass (domain: siemens.com, ip: 52.101.72.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3p45jcRa9yu4JN15QL83gZQHbrbTvgDSZS7KR63VQS63fPzncTx74iVnHNEZYpoaKuwXcrCLRc86552HnsgQhMB0fwxdty+kQOISf3zD7IM0YtdOvKuXdQVaNqUFc/+1LnXnoP0rYtwmgEzHCTSVK+iWKWkmTfpeh/7EBgspAE+N7Ub+ZAvCPUsS8XBsq3DTGULZ8vat7gWqF/bXXEJCSSEv+J2eNITyUmmNo6dR9HkoSJBUDQnyd67lWiHlriD/9t7Sc65AXfoiWxkBADqhIySFsTrCRNPiwfJOSFbY7qnb1U9m9DMq00D/MZZqp7vrTSAaJBzQ1hBK0Rt7enDlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsKOwvhxLcaipkh4g8gyfXAuRHCAbGCPIDnMB31fPdI=;
 b=APv1PjbfUr58ye6E0QiGdw72AzbzSZ4pHjofHvhqEGba52MpHg9lHZfKI0ez/Ja1qKQhiLqqK+vTLYVpLKKyJo9CjL3NBHGHpEZEbsEsdctgf2O3YrVZOEVFOL/Ic7CqYP7VvO6OpMxEHldktlVRnaA+T06HJ7Nh1qXr6YQ4RC/jxlGvFTXATlavg+WukQHFS9vLRjSPK6fMZKimLkdTogVPTFuBYiYoCfcovaT5m80q2JT9GObTumTIp1dXWW9S89KXYE2+lP3SO3zP388Hv9zJ2gpFrNocupJNV7DZwmQwKXZUgWzLwUliHf2TU+X5ko/6YZBH+KT863fYkhw+lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsKOwvhxLcaipkh4g8gyfXAuRHCAbGCPIDnMB31fPdI=;
 b=gi5+RujoWU++kTn2UI1I+6Z8TBqQbVlSLaqhXvb5uoDcXJuqHqOtWlzNTuFR9xIAUKHkqHMi2Q5Eycp8iC3hq3meqcs1mH1SNSsLEurGn4E1Hz20m2b6ogcFcAxD6kL9DxxpJKJSEGuobf+Dn9ACv4vguMGjfBNeW1fbFDHHEeVBcZHpWRckKe9Cu37MIFHZ8gRT2oA6esQjbi560/yxNSmKTc0+jsoC+Gfn53UDHC+zAoNedvuoask6BUfjLOKRl27hXKVpGWiRaY1dnux2W/BJ7y88EP8pocbIisuFXY0HEeuerNDe4dtP8b4j05zbBNXpECNPgkXTAG8U0QdpfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8322.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:566::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 12:18:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 12:18:17 +0000
Message-ID: <31048511-86da-4ac0-98c7-3148bae34143@siemens.com>
Date: Mon, 15 Dec 2025 13:18:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 0/3] Fixes for Factory-reset
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20251215093719.323668-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251215093719.323668-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8acbfc-e36e-4ef6-bb13-08de3bd406f7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SWpLVDU2eGJ0aGRhSWxWRUFNaGxxeXArSXhoYUpQQUZpSjZtTWZ4KzRTM1Zx?=
 =?utf-8?B?Z3BxV3VJZFc1V1QyQWpTUmIvZ3lzd3d4MXRxbURoTHM5Z1Z2MmpUbWlkYVNP?=
 =?utf-8?B?cE15L3UvbXZ0ckxTby9ONXYwRC8zZ0hwbGVrSWpUNy83dkl0WjRjSit3RjNk?=
 =?utf-8?B?d0ZXd3lUOGcyMTk3dDdIeklLc2svQXppQWx5K0VMaXRTOUxyQlRtbnIwVnUz?=
 =?utf-8?B?cERJdGw4QmEzNndhTHVrVWhrZmxvemZXaDA3VnRkSGVmWHEyT3JWZUlhQlEy?=
 =?utf-8?B?anVnM3hIK21yS1dEbXBWWjBMa1A3VVlxV3hFNFN1eVB1UFU3VHdPWGlsUCs4?=
 =?utf-8?B?d3dNeUJuOUpDZ1BBNGNDclRBbXo2N29NTzhOQ3M1aWdXYXpSdk02V0ZFZmp1?=
 =?utf-8?B?WlF4WnBtNUhVLy9hb3pITlphNEJId1BWS1hncVF3anhnUnQwdFJ1Q21ubEtk?=
 =?utf-8?B?bU92ZHYvOWJ0UjdUQXRkU3NNRUJCbEQxeWNOdTFuVngyK2xTeVRLZGxOVk5x?=
 =?utf-8?B?TGFRc052WVd4Y2ZmZjhDV1FWQmN6dmh2aU00ai9lbUVkY3l2L2lrdFo5Wlpp?=
 =?utf-8?B?Uzg2TjVnRGdLUjhMeWVnOGRXL2IzeWxEazM3RHdLT0w5VnQ3eFdyWTE5RVVE?=
 =?utf-8?B?bDlKMXhmRlpidWhoS1Vvc051WmxMd1NDc0UxanluWUpEbUYvMjJKNmc5KzBz?=
 =?utf-8?B?bkVIOWVla3pielBSU0hXYUUrd2pEN0lGc1kzNUlSQS9uS2FRT20rNEFBL0RB?=
 =?utf-8?B?dFJrMmV2R295VU1uSkJKaXVwUmJWOTVQM2Y5WVBneGNyaW9rY0lyMUx1OTRu?=
 =?utf-8?B?bXhYVUxBNlVUK0JKdUZMb1MwelV4NENzK2pPcXU0MHRvMnZqN3J1Vi9zQ0o3?=
 =?utf-8?B?c3l1MjJrM0l3TWJ2TUJFQUE4ZWlUYUNsaURJb245aTUxSDkwWnNzelN3eGtl?=
 =?utf-8?B?WUJBb3NZZGcvVGVQNFlhU2JNQS9UamNaT3BYeWRQUmJqaEtNTmZpR1RabVFK?=
 =?utf-8?B?OUFGVmVYRk9KalM4VUhDR1VmZmo5ZWpIaU5tQzdERHVZMmg3SFFNTzVGMEJE?=
 =?utf-8?B?UHhaT1k1aGoxeGxxc2tYR2NUem5Oalk3aEtwWlNFT3pBemdML0FxZDlWUEVR?=
 =?utf-8?B?VER1aFFpc0lyK3Z1TXVrZENEc3cxRWtRV2NFdGJiQVpSY0tGM2ZZaWNhL1VS?=
 =?utf-8?B?R1VjT2FlR1BkQTRBelVUTXFGYzhTMGl3TzhHU2l3TXRncmFmZDJUSzhvRHJY?=
 =?utf-8?B?QWhqQ1pEQlV4Q3NHR2NvOWI1Qjl6U05UaWI3NmNNZ1FpZ3JvemthRklpVk1B?=
 =?utf-8?B?Ny9PcU1Ccm10WEp0QjFyOWg3UVIzMEQvQkFPQjhUTWo2WEVleUxVUFp5cjlw?=
 =?utf-8?B?TmdLUjFLWVVjNlMwTGtiZGdCY0JYc053R0JnREJlOVlYM2RkTkRuenlBS1R2?=
 =?utf-8?B?SWZ5MVVDRWtBRFQrL1p2T1czVFowNmlXYTBIUjQ2ajYxUkFWWmVocGEzVmtX?=
 =?utf-8?B?dWZIWXNBcFZuZFVNbHlYaUozbGk1dFprK1FzcFVETm1QQnQ2cDNuSEpHNkZQ?=
 =?utf-8?B?ODNjTlVSK29WMFNPYUVHdnUyUjY2R0hvR2NFUzg0R1hURlBQdmxjYis3WFVP?=
 =?utf-8?B?b2ZzTE02TFpKc0I4SDEwV0Z2VjRSTEhnR0NMeVZGSGk3RVROSnNIdTZiN2Vq?=
 =?utf-8?B?MkhENFFFbWFkNFFhWDd4MmllS0RjcFk1NjlZMFQ3N1BhbGR1NTBUdnViZUhv?=
 =?utf-8?B?UlJGVFZTK0ErOWdTU3dUZTlINkc2ZGliOW84Qm5lQVFUb3EyQ0VZKytVNjgv?=
 =?utf-8?B?U2ZZaU5FUDFwcEFmNXVQZnhKKy9saG1wVnFPaHpEajRoajVRdXh0MUI0UUk4?=
 =?utf-8?B?OHNzZVgyS2ZEU3dhd0J2RU8vTUdFNlNDRGszU3NtaHVLOUVrT25HZk9iR3F0?=
 =?utf-8?B?NUlHZWxvblpJdUhnUnRlTmpZMC9KeGV0cEhrTnZEUFJzdE1mVE5EdXRhWWxr?=
 =?utf-8?B?Y3lyYUduUEtRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dGNhR0JiamxKK0szVm9EZ09RNk83NUFlNHZLRnBpSTNybXltYi9jYjRyQVdp?=
 =?utf-8?B?TzZ3aHlubUlNUDVlcTh0ek1LY29SY0JrSWIxaUZQdVB2d1NXOGtkdlBRaDNQ?=
 =?utf-8?B?Y0FyazZOcThuVnhDeGhwd3k1RVV2N2lXOHV2TmFUR29kbC9xa3VsdU1zL2Y0?=
 =?utf-8?B?NXBLTTlxKzNwY0dDQ1RDT2E2cnlYQ01Zd2pZQXR6NjF1WHo5Nlcxb3E4aUEv?=
 =?utf-8?B?WW0xdUloQ0IweVhrS1oxc2NJYkx5T05iNllhbndpUXpDdUFkQmdZMmhZK2RF?=
 =?utf-8?B?VENvV3ZUU25PSUFxd3dlWG5WS1lJQ2lDMlpLclVJZTd1bEJsS2pPRTdkOHlm?=
 =?utf-8?B?blZRMVFNM2p4YmNCdzdRSnYxK1JZdGpGaEVvU2taUEhnNlh3aVZaUUIvYkZs?=
 =?utf-8?B?b3lZN3BXaDhBK3hQU0xwQkUrR3ErczBocmg4Q0ZPcTFLTGs2aEg1QnpaRXA3?=
 =?utf-8?B?VllGNm5yYmx3M25JY29zMWZDZjNic1huM1ovS0NmRFEvZjhFSnl1WmxTckFz?=
 =?utf-8?B?WTkxSkd6akFRZERBS2ZiK2gzRy8yOGNqSzhxUWVPOEhNWlAvSExFZCtWaXlO?=
 =?utf-8?B?QWRJbDNCWE0vNVRyc0FyRDY4ZEsrVjNmQTEydWZxNXdqUFhTb0FGemZlRk1G?=
 =?utf-8?B?RUJxaGZVaXJpYzVUa21nVXZkNUZrYUpTMTByQmFXbUl1azBNTWhzd3l4Q3Jx?=
 =?utf-8?B?T2o2ZHpMbkZvREtIQW9YL1lnY3FoS2IxQlY0dWtjL0hKOEtPUU5LZk1xVEZz?=
 =?utf-8?B?Y1hQQ2MyTnhWM3gxSkNIeXl4MHRQVmNhdi84SDFBcGJRNWFJUXFvVFJIczlY?=
 =?utf-8?B?NWkyaHhxS0RlNm5LdFRkMDYwODduMTdnK2JWN1VueE5MMlBxSkU5OWVPdThW?=
 =?utf-8?B?STRjRTF2ak5qTDhUakdteXA2S24xMnhkRlEydGFnNzRTazIwYVdWYWQ2VTN4?=
 =?utf-8?B?eHVmMnRkMkJJQTdaWWxNZFY5cHQxcC9yNlNsOWlxRHBNWktRNmkzVUE4L1dW?=
 =?utf-8?B?d0VRM3EyN2dESmQxYmJSSG56akRFTnpKbVVuR2Z6V3J1ME9leTVkY0pMTWNR?=
 =?utf-8?B?TTA3N1Frc3hjRGVhWmg0YVIzV0JVR2xmMVpQMzlTQVM2Snd3bmIyclJiWmEr?=
 =?utf-8?B?MGNpRnhNR1BSRU9KWG1wZk1QQUZIdVk2RklqRWd4TTNSN0Z6ZFpucStsM0pD?=
 =?utf-8?B?aXFrVzUvVHoxNjM5SGx2dUowZkVFUWxnMXdRRDZWNlJ3ZnNzYnlQK3VNN2Ft?=
 =?utf-8?B?cENQOW5KR2NnR0RjWm9ISFBkYThqQ2F6Ui9lTnA3VEVYVzV3Z1Y4OEFJeGZO?=
 =?utf-8?B?aUd5K0pDQnJtV1B3K21KQldIME4wR2UwenF0bFhrdDNUYnZ2b2VtZW5GWDFo?=
 =?utf-8?B?eUJsR3ZocGZ4Ri9sOVAvUXk1ZStsRytVMUJsQlJ2dmIvZFZFVmZNUStxVkxa?=
 =?utf-8?B?M2lrdVZiWllheWRlaXNaS2c0WDBuY01OMVEyMWNzMk90MFc1OTBBMDhiazdx?=
 =?utf-8?B?ZnNrTTNTcDh2MkJvdUR3VW5oY240S3A2ZlV0akZhQVM2NGlTeUZuMDBCNGF4?=
 =?utf-8?B?SE93UUdQcU5oczVBcWd5aS8yUlYyajhEN2w4RkVFSmFFdWRqS2VtVG5IcFV4?=
 =?utf-8?B?VklSQ1pwZTFYc1E2aGxYYUhFK0M4QWo0WktBZktRSmpPVHVXRVovdjlaU3o3?=
 =?utf-8?B?T1lkVHBjWnBiamhPSTJBRjBHRWdDQ3dTUEg2MktKb1BIMVh6SDRSWkZFUGRP?=
 =?utf-8?B?T1Z1UlJqRUs2c0hwc0RXNVVFN1pwc3cyU3pPL0h6SjZBdmlacEpNYjYveWVX?=
 =?utf-8?B?cEtyYWNZZjIyL2l3SEJ3OVdjTFBOenFud0VDUENETUV1VWR5SU9DUjZVSi90?=
 =?utf-8?B?T0JvYUFVTXk5RkswOGdHbXpHY1JGUGhTbWo0T3RFZXFMeGIvdUR6OXYzcmVi?=
 =?utf-8?B?SmNkK3FRUE5NRmRTWTNIeGhFajl6bWUzYUhwVG05a2xISktTdklMbUpCVE1N?=
 =?utf-8?B?NEgrOStiMnhoK0pRcm9OcFk3US8xNDBsdkRTeElQQzhIN01kUXZrOHJhdFh1?=
 =?utf-8?B?eG5mRTJvUlFWNTZlbHZxVnNFQkhLcFlmWFBvZUZRWWtzc1NYRFNOYmhoVEh4?=
 =?utf-8?B?cDk0c3c2eVdWdEZTUlRoQ29JSElULzhzdFZoZC9QYU1vL0RFbDZGMkhUaFJw?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8acbfc-e36e-4ef6-bb13-08de3bd406f7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 12:18:17.0116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKPPxJlV0IX2PvkIdmbJajFH/byKlr2sAYj6eSlwbLnTqQHrsTPzK3kt8o4aIQH5j+zbBnoyA2ljpTNNE6AU2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8322
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 12:18:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21054

On 15.12.25 10:35, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This fixes the issue
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/145.
> 
> The following kernel config fix is necessary:
> https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_requests/152
> 

I don't think so. You are more likely missing a module dependency on
efivarfs in the efi-based reset hook.

Jan

> Quirin Gylstorff (3):
>   fix: initramfs-hook do_prepare_build is executed after do_install
>   fix: ensure that the partitions are available
>   fix: ensure separate root home dir is recreated after factory-reset
> 
>  .../change-root-homedir_0.1.bb                | 15 -----------
>  .../change-root-homedir_0.2.bb                | 25 +++++++++++++++++++
>  .../files/change-root-homedir.tmpfiles        |  0
>  .../files/factory-reset-script.tmpl           | 18 +++++++++++++
>  ...bb => initramfs-factory-reset-hook_0.3.bb} | 15 ++++++-----
>  5 files changed, 50 insertions(+), 23 deletions(-)
>  delete mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.1.bb
>  create mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.2.bb
>  create mode 100644 recipes-core/change-root-homedir/files/change-root-homedir.tmpfiles
>  rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-reset-hook_0.2.bb => initramfs-factory-reset-hook_0.3.bb} (91%)
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center


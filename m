Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDFCC28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 17:38:42 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.47])
 by mx.groups.io with SMTP id smtpd.web11.1026.1742492318253316249
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Mar 2025 10:38:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZyQSKdB4;
 spf=pass (domain: siemens.com, ip: 40.107.20.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AiHSKuVhsrxZt5dwliwN8Cl9gzhzcQzBHhaSV+vce1zI37M7zuP2AEVxor+1dgYtqQ2YVrkcMqL0UUOyEgsNG0AC5DlVS4AwAClF+BvdXaWX7lpg73jUhDroNtyZR5abuknerFMBtqY3hJ0R/3AKxBGoFNiwQM9xYYrl51JU9V7HSVvJGKmsRXueoYP6elZBhGRDr0ORoboNSeUVbGf9pfA9ADI5GkQ0BcjbEcoKeqqYCDbeAvClN5AbnAwixdoz4Usdz2N7kpgUN0tNJRtU4PT0MHO1Q+QgXRorLpl4ht88MGH1Qhp2uJ5cVNiNxQaEbS9SqHVryXdCtc261VelfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPJBjG8a7RqFSqbKgROtmtRRd8vq6u5+72pxGVCK1Aw=;
 b=UL/RJUMklSN20NDH+V9KDmaucBnPS870Bal3130mXXjL8zQoVA90+mQRc+gRHlFJsyD9AquJJ4z35Ed2MAIqSnJga1ZYSH4J8faocMMgqoYQVBkAqQVxgXucNCmPZ5FgiSO+WUIYSjjS9EBOG+renXE41lhdIY7VFPWQ8K7mqXBeHqWr0wfHCUW2Kt4Gw9jvpJtyc7urKT6Cu1H/69GekoQ5BNPojR3bRzqKXya9Rhor/aGduiPP0GjRXzIDI7B1Dh1HP6OthJjKQjNRtfcKb4YPHJmUpvWFG5oweB/nioE6ETuHvtDbeSXZl5pmU2MdrCd8wd/ZHBdJHgZJfubn5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPJBjG8a7RqFSqbKgROtmtRRd8vq6u5+72pxGVCK1Aw=;
 b=ZyQSKdB4Q7v/KeD2hIW4FqWDaxJfYiXKkDV3/aLvh20mBemZU695NdCpZF5BEU0/zkCLt2aPq25W+hNGy/dpuAL2U8KXS/33iIfz0/bOHOu5C0k+9xESdLlFb5Z1z7fBZqAQK454uiEdYGjFbzW2QcNVSG2oQP59eHBOTTmSy5QZsCt6IoTw0bZlHGQ+LY99qe8XphxDGfco2iFFOB/4w9ZqCITL3XpLCErPblUlIJFHCvdc21C25c7m8xcFXMWcxVoj6DujUe3QtACQ/GASnzR9SD9rBdur6m+XDM6oTgAqruTQX+5+aUP87yEGppSOyL55y8/C2c1gppPzKtHUNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3626.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Thu, 20 Mar
 2025 17:38:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 17:38:34 +0000
Message-ID: <4f11e7c8-7b34-4130-b048-c6bb6052e984@siemens.com>
Date: Thu, 20 Mar 2025 18:38:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v1] tests/templates: Reconfigure the usage of -smp
 options
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250320131429.2161150-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250320131429.2161150-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3626:EE_
X-MS-Office365-Filtering-Correlation-Id: 838b56d4-944f-4c5f-3191-08dd67d60a07
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MzB0ZWNnNEJWYjVRdHA2U1U5NFJBdFFDMzBSTHpNZzBWWmMxNFRoZjZSYVNz?=
 =?utf-8?B?Rm9yTlFiZXhnc1Bic25uUTJYckZEUkFWeU8xdldZWm9TeHNYZGtBNjJrR3BN?=
 =?utf-8?B?VnMvaldYM0RhK1J0RXZ4T2ViVjlJdzhFMmpnYlZsam9oOGxLMDJhS3JFTmxF?=
 =?utf-8?B?QTB4ZUxzREs0elcrdVFHUnhZSjBWa1h1MWNsNS80a3k0NzMramQyN2xoWHBG?=
 =?utf-8?B?dW1ybFptK3FOcnBZSGw3NngvaGtSdXBPM0RQanhJUEc2ZlgxR1JsZklmODRl?=
 =?utf-8?B?TFY2K1oreWpLRTBuY20yWDVYMG1paVVqdGJMTUFXYThXZEVpNGxmUUxIeEhK?=
 =?utf-8?B?eStpMXRtNGcyZ2pqUHpaRUc0dm5qamxVRndRcm1mNmJURTUxSnAxNVA2WUhz?=
 =?utf-8?B?bHdXS3lWdEZpZWYrOTFzbC8vSkdFRWNzaXExYTRjemlHK3hnNVYvSmpmSnBl?=
 =?utf-8?B?ZTQ0ZXBjL3RNL0xwM1lkcWdBOVZ6c1hRRHNRblFQbGd2OFhySWhiekVNTktE?=
 =?utf-8?B?bnZ3V3BOK2I3TDRLcEhoVEsrZGwzNm5XamtWUU9kNTdmQURpaHFEWDVETDVB?=
 =?utf-8?B?VHpPSmE1NlZQZmxrbG1LYmJPVVhoVlBtaDlTRENYMGgzeWk5eDUvYzU2SlQ3?=
 =?utf-8?B?SnNwRzgyME5EU0ZOeHNWcEJuNnZwMmx0YkJKUko2am5HKzJWVWYwU3Y1UkNV?=
 =?utf-8?B?UithWEZjOUpOeWw3WVBlSEhyQzhTWWFaUlZFbnNxcUNQdnF1eUNEV2tFWUx1?=
 =?utf-8?B?RlJCRVBHQkErZGNESG1EYVNXcjVFVHliQlIvaVFBMUR3a09xM0tscmp1Tnhl?=
 =?utf-8?B?TlZmVWF4UjBvRzhOMjEwdlZ0dkk2b2hoZzhMZ2F6VkgxWGVaL2Zvczkxb2Fn?=
 =?utf-8?B?a1V1YTRUMFNiQktRell3ejArRkhtaE5iQktyT0djbUpjMnhFZU1iR3l0ZTBu?=
 =?utf-8?B?c2xTeVZ1OWZmSllybm9uWHRaRytlNUNUYUQyU1ZWdGMwOGFLeTQrb3JnemdF?=
 =?utf-8?B?QUM0U3paT1h2ZFpsb3FPYUcwODVtTXZ0VTZONWRnZmIrc0M1UEQvYnNueFhR?=
 =?utf-8?B?QnEzb0JEMEhCR29tWVU2cWQ2Vk9CalpHRG1RVHNQTDI3MXF0UWVacjdBV3pI?=
 =?utf-8?B?VGZBdUZqYXVOeTN2RUZyNUpBUFdBSHhDMnArQjJJUzRmQittTXJ1ckwvTUdt?=
 =?utf-8?B?UTdxRFpoaC9TeHh5U3RzekUzVUppMm5TRngyMnB2aFJ4NHNrQUpIZVIxUVN1?=
 =?utf-8?B?SlUwNmNxdnhLLzRTcW5xMDA2NWlITy9jbEd2NFBqYS9BQWliWnFBZnlCNlN3?=
 =?utf-8?B?MkV4WWJMQVlFRmRhdkhIVHorWmdKekZ5clpBRDhCdkZDdWJHZExOVGszd2Rk?=
 =?utf-8?B?dVpldXRPcEp0NWV3VEdWWGhKZW1wMURQWnNGajFEbmd3Vk5mVllOejVGTFVQ?=
 =?utf-8?B?WHdVQkpMZTlRcHQwZW5IMVVuUllBaFZVcmJoa2Y0TmdHTnBvUkE3RDVjTGNG?=
 =?utf-8?B?KzhBeGpHZ1ZqRnMzbGlkRkRSelo0UHpvVG5sTk9FU0J4MTN5U3RrV1gwWitC?=
 =?utf-8?B?Wit3VDdDNklDMVBORUw2MHpSVyt0TXRwOWFUaWJHNXNWcXIxcjIxVXVwd2dG?=
 =?utf-8?B?cWhvUVlHNlNCMGdkQWVrd2VnaFJOTmVnQ0l1QngwbkQycUtBNVR3L0x2Vitl?=
 =?utf-8?B?UGdrWVYzYnZVclRDYlQzNkpBbVZBQS9vR3hFUlRNRFQrK0JlMWdQMDl3ekt0?=
 =?utf-8?B?cjVrRXVVSUxMTmE1S2I0V1dEeG82cC9kLzdoWjdOclRlS2JwN3hCV0NZQXJi?=
 =?utf-8?B?WHVPc2pQb1luVS83STdjRU1kMm5NL3NFeU5naSt1eFlaUXRwMWhSeFRzeXZ5?=
 =?utf-8?Q?U+yfoXrS9DVwT?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dG4vY04rSjZoSEpsYnM5RUMvbkpKSG1qRUxRL0pSbGRhOVIvcjdHREVhZmVV?=
 =?utf-8?B?c0trN3lBZ2xiV1ozWVhYVzlRTkJpcGo1Zy9ZN3dSQ1oweUplenlncmdpQS9T?=
 =?utf-8?B?V3grcnR2ZGpYdS83QVhVbkxtTmVDVURKSXlwdVkyL1pwV1htUEVQanJkNEVy?=
 =?utf-8?B?d0ZXL2xiN3laa2Q1eFBjMW5NRWF6TllXdGFYWW1icnNoZGxLMExTZVhyNDFI?=
 =?utf-8?B?NzNHRXFna201RFZXYjlHbFY4M2MyUHZqNXoxUkdhTmdTVmJFMWtsQjZCay83?=
 =?utf-8?B?OFpNZG1Nek44WlNpeUlveldON2hPSEQ3blBmUndzMnIrL3FwMkgwS003cWdm?=
 =?utf-8?B?VEZhaXNhVms2ejc0VmVhcDArZW00WmZRTjhuTUZZT3RnM2VvM1BiR1pMaE5K?=
 =?utf-8?B?QXprWEd1dGlQUHAvZjNFRHk5U3VlOHFQSlY5ZnpmVmpPY29mcmR3Uk1LR21J?=
 =?utf-8?B?dlhmS04yQkl5UEJIb2NPSTM1Z3hneGUvTjIzdGlPeXR2TGE2MDJPck5FdzIw?=
 =?utf-8?B?VnNQWlRsbll2S2E1blUwN2Q4aGdFZVhQbHhIRzN2T1pmaUI5T05uVVFSaXFj?=
 =?utf-8?B?U1N2V2VRNXFWcTloL1p2OW9EdTBnaDhNTXJuVlRxRklRekcvWGFQYVVkNWZR?=
 =?utf-8?B?UXEvdjZLUlFMaTV3WDB3TWtHVWtJUEFndHZZWEdqRXk2c2JDeVV5Uks5TkxG?=
 =?utf-8?B?YTQ4c1VLdXM0b0J1Nm5Qdk41dnkzQTNTNEtQZGgvVkt4dnpacEpjbjAvcU9Q?=
 =?utf-8?B?L05IWnFQRnQxZUFZNXhGNnBielRCQXQxczVMNnM5V0cxUnpuOE12cnBGQVNk?=
 =?utf-8?B?R0hHdFlhZzFzL01CenBMZ1JzUThwTnllcDAwcjV5UTQ1dG1XSlp3SXJUM3E0?=
 =?utf-8?B?WHlTQSsxaTNMS25OQTBMdHBweWZoOGlEdEJ2WUZVMFdFTFJqRnRabDZ0NTEy?=
 =?utf-8?B?T2d1d3pGOXpMWU41eHM2d1hVZUZ6NStML0dRbWFIUVVaZUh0ek1oTkV2Mjl3?=
 =?utf-8?B?Z2VkNGhRcEl4aVc2V3FwcTRkckQ0WklLcmZYUGFZOXZiRE1RUVlrTWdEcDZ6?=
 =?utf-8?B?QTkrc2ZJNy9CS3ZYVXlYK004WThTbTc0QnoxN0hmeDczVFdyb2NBdTNkTHJC?=
 =?utf-8?B?UUFZYmltWjVRd2FmVzNrSUVpSFhVUWJxRytQSzhRbzFacnBkU09HRW1sQ1Iy?=
 =?utf-8?B?Q2lRYkwya2FER3BwYk5McmVpY01kV1BsZmhMbmlDZjcycXBGeC9QdVRiYmN0?=
 =?utf-8?B?OXE3dGVHT25DODNkbnFlYW9Wa2I1UGtaUDRaVVZaM0ZtY3FqVUVxRGxrRlMy?=
 =?utf-8?B?OWZjTFpJY3htRDVkWTAzSVg3UFNkcE9yZUxhVnk3a1c2cVY2YzJmTkUrbG5o?=
 =?utf-8?B?MUk1VDdwWVJESXh2NXdQci84dWxQbnpNRnpHVjFtWG5QT1l3cVRzdXgyU2cw?=
 =?utf-8?B?TzA4ZG1WWUY5bGJWc3A5QVd2VFhhNmlZY1kxalM0VFBCSFptNkpFUkJyVFRQ?=
 =?utf-8?B?S2s5WFZhSlNQRnpPV2tNZmcvSXV0OVBpakJLMDh5ODJTNkRTZHhMNDA5WFhJ?=
 =?utf-8?B?aUFSRWh2Q0Q2OHpmRTRPNnpxdEgxRjN0UDVUVldkb0Z5TytvY3prSGNxbjBS?=
 =?utf-8?B?K0pXeWFOd0h5TnNkdGI0dDZ0ZUdkbnFmVldjenlrbXViRWxINE5pTTZKeEJt?=
 =?utf-8?B?Q1RiUjJsYUlEeWFiYWFhZ0xXWE5DZnByVENPb1daS3IxSjBieFgrZjVKSFh4?=
 =?utf-8?B?Q2xWbXVqYmdiT0xBRDRNb0NCczBzNGxJc2FrTWtyMlJTeHh6bnVDZWtRYUZn?=
 =?utf-8?B?Z0tRRTRZODYwZlV1TFBiSEpVWVZyK24rRWJta2RmRWNRa1NKbzNScWwyeTVR?=
 =?utf-8?B?UmtLL2tGNi9PN0xqZEIwZytVUllVK1hRZ3NQcWVGNTlGRVpVOC9RRVdBaGxo?=
 =?utf-8?B?TVljbW1iQVR3NXVUMW4wTTdMVjdvTmM0UnZVTExLK1BwZXJNL0hNWkxxRHUx?=
 =?utf-8?B?MzhNSGNwbGMwYmhFcTVlQkJxOGFOOXJ2Y2tLSWMyK25CWktoNlNDYm1sTllS?=
 =?utf-8?B?WFJqZnB3M2dwYTR3OVBmZ3dhOHY1ZEREbXFEeWZEd0FKTFpRZ2I2bUorQjJO?=
 =?utf-8?B?clR2VmVrQk9wRi9VMVZrVTRXSXhGWTBSVER1MWZnYllXcUFQRUxGQlZneHlt?=
 =?utf-8?B?ZWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838b56d4-944f-4c5f-3191-08dd67d60a07
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 17:38:34.7526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fk/bIZf+lcomS/VJNSnNKwz568leftfUaCKl2tdKMeXEZh5Q6oczTuANpRwZ/ZdFSu9A0bjL8d6OKhgMFy3zYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3626
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Mar 2025 17:38:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18300

On 20.03.25 14:14, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> Due to the following kernel warning message observed during boot
> time, the -smp option for arm is set to 2.
> 
> [ 0.000000] DT /cpu 3 nodes greater than max cores 2, capping them
> 
> The QEMU start arguments declared in the template files are common
> amongst x86, arm64 and arm. But now the value of smp declared for
> arm differs from x86 and arm64. So move the -smp option from the
> functionality template files to the job submit script where the
> respective architecture specific QEMU start arguments shall be
> used while preparing job definitions.
> 
> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  scripts/submit_lava.sh                       | 6 +++---
>  tests/templates/IEC_template.yml             | 2 +-
>  tests/templates/secureboot_negative_test.yml | 2 +-
>  tests/templates/secureboot_template.yml      | 2 +-
>  tests/templates/swupdate_negative_test.yml   | 2 +-
>  tests/templates/swupdate_template.yml        | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
> index a9bb011..9da083a 100755
> --- a/scripts/submit_lava.sh
> +++ b/scripts/submit_lava.sh
> @@ -29,9 +29,9 @@ if [ -z "$SUBMIT_ONLY" ]; then SUBMIT_ONLY=false; fi
>  
>  # Create a dictionary to handle image arguments based on architecture
>  declare -A image_args
> -image_args[qemu-amd64]="-cpu qemu64 -machine q35,accel=tcg  -global ICH9-LPC.noreboot=off -device ide-hd,drive=disk -drive if=pflash,format=raw,unit=0,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd -device virtio-net-pci,netdev=net -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_VARS_4M.snakeoil.fd  -global ICH9-LPC.disable_s3=1 -global isa-fdc.driveA= -device tpm-tis,tpmdev=tpm0"
> -image_args[qemu-arm64]="-cpu cortex-a57 -machine virt -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
> -image_args[qemu-arm]="-cpu cortex-a15 -machine virt -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
> +image_args[qemu-amd64]="-cpu qemu64 -machine q35,accel=tcg -smp 4 -global ICH9-LPC.noreboot=off -device ide-hd,drive=disk -drive if=pflash,format=raw,unit=0,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd -device virtio-net-pci,netdev=net -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_VARS_4M.snakeoil.fd  -global ICH9-LPC.disable_s3=1 -global isa-fdc.driveA= -device tpm-tis,tpmdev=tpm0"
> +image_args[qemu-arm64]="-cpu cortex-a57 -machine virt -smp 4 -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
> +image_args[qemu-arm]="-cpu cortex-a15 -machine virt -smp 2 -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
>  
>  set_up (){
>  	echo "Installing dependencies to run this script..."
> diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
> index a196bb5..3c33773 100644
> --- a/tests/templates/IEC_template.yml
> +++ b/tests/templates/IEC_template.yml
> @@ -34,7 +34,7 @@ actions:
>      to: tmpfs
>      images:
>        system:
> -        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
> +        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio
>                      -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
>                      -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
>          url: #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.wic.xz
> diff --git a/tests/templates/secureboot_negative_test.yml b/tests/templates/secureboot_negative_test.yml
> index 568b5b6..2fcdbfa 100644
> --- a/tests/templates/secureboot_negative_test.yml
> +++ b/tests/templates/secureboot_negative_test.yml
> @@ -51,7 +51,7 @@ actions:
>      to: tmpfs
>      images:
>        system:
> -        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
> +        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio
>                      -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
>                      -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
>          url: downloads://cip-core-image-security-cip-core-#distribution#-#architecture#.wic
> diff --git a/tests/templates/secureboot_template.yml b/tests/templates/secureboot_template.yml
> index 1b8e882..e29b64a 100644
> --- a/tests/templates/secureboot_template.yml
> +++ b/tests/templates/secureboot_template.yml
> @@ -34,7 +34,7 @@ actions:
>      to: tmpfs
>      images:
>        system:
> -        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
> +        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio
>                      -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
>                      -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
>          url: #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.wic.xz
> diff --git a/tests/templates/swupdate_negative_test.yml b/tests/templates/swupdate_negative_test.yml
> index 42297a8..bb79b07 100644
> --- a/tests/templates/swupdate_negative_test.yml
> +++ b/tests/templates/swupdate_negative_test.yml
> @@ -42,7 +42,7 @@ actions:
>      to: tmpfs
>      images:
>        system:
> -        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
> +        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio
>                      -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
>                      -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
>          url: #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.wic.xz
> diff --git a/tests/templates/swupdate_template.yml b/tests/templates/swupdate_template.yml
> index 67bee03..e1f71a9 100644
> --- a/tests/templates/swupdate_template.yml
> +++ b/tests/templates/swupdate_template.yml
> @@ -34,7 +34,7 @@ actions:
>      to: tmpfs
>      images:
>        system:
> -        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
> +        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio
>                      -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
>                      -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
>          url: #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.wic.xz

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


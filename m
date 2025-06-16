Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C04FC71155
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 12:11:35 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.48])
 by mx.groups.io with SMTP id smtpd.web10.28848.1750075893616308532
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Jun 2025 05:11:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bIVynki4;
 spf=pass (domain: siemens.com, ip: 52.101.66.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhODN1jH124K76qCMVmv5BFYpRArxlse0VWJga/jhHFKWVqWaLbChM8L02ZpWThaVfFk/X0pVoZ36efCCk77g0i5KTQoBm7msJJJwUjiACfPr7U8+Psf85wChTpyTwO2FQRslr3E92ptsJoikcFgo+lLb2tBws0lbGOXBcSLHrXeHnpTOSm5N4/f1hbldlAcWCmXGng39uZpn+kqubwtrKEhlG4ipEWudaCT0PxHGaKX5o8XQYPt/LU6ESzORa8qu8Jn45L+fUe2E0xr/zZJTrOV9jzZcv2O0kv1c6+yj9GobXWdlk4dyBkjnU8t02pjszmobt9o5I29yzuJ8m7Ysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYwBt0hcBxULakT/lMMGLQcoxISb21lsE1W2YDk/b8s=;
 b=bstBo2Bum+Ubn3Cx4pGIpcC49OkgkS35bYMVgXj7YiH830zqdcGbRfvjfER/+Ts8SaOFELbyt/MlJ4k+gPsQweV2v2e8rDErozCjJzwDleQKsVSIvsU53OpoXDseI6UAgBLaCMLVwGneNep5LWdBYL2Nqa/rLvlvZanDZZid81oeqn2zKgJJce5fUwKrDHJLUhvdIwtv5t34EcvW0GEhJv/XFrGqRH+K1yTXKwmYDwsMhly4HoiK5EU3CLALXcorCn7IHer17WNALHVIx/vkjbFU146oKD3YAXYvkUlJqhFV5mZ1hhIPo08DOdH9RKZQrdYjrB3vth2mghRRdCuNsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYwBt0hcBxULakT/lMMGLQcoxISb21lsE1W2YDk/b8s=;
 b=bIVynki4SjygZbJvSUMc37MvxgSHLCVEbG4w8RJliFskrLdP1c2HvsrKl5LkkkNQb9g91NZGyEXn6b4MDn02XUCHaCWajJznaXBdrVkFJZ0m3lAngzpm/1MQs5CQfTUq+ZxK9ar5B7vffnV2zIv47kT8AQhRdS2voEyTP0P9ckuM5q4vCBYVGSFxcs7IpuACfucKZhYz9+6RLPXz9U8nnFAZ5p/SgGfgElDeLnNa+YijciBAoZZqdDKYnedewR9h2MUqPAc/fENdNA5DMTAwOIo1v/+rrIlk5wMkoCGxEIHeGINB831J0koStSD1YsCSSC8XDfsKs5wAGOuUnO/jUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6541.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 12:11:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 12:11:30 +0000
Message-ID: <48d877d5-3ba4-4875-9104-32875a5935c6@siemens.com>
Date: Mon, 16 Jun 2025 14:11:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] fix: Shutdown the TPM after
 disk are decrypted
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250616104736.1839331-1-Quirin.Gylstorff@siemens.com>
 <6a3b4748-104c-4e21-9ec7-4f8ca7216f27@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6a3b4748-104c-4e21-9ec7-4f8ca7216f27@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c6c444-c392-4e55-f552-08ddacceed38
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MGtaaHdlS3Frd1E2V3h3Y3ltczBodHB5K3BPZnJkbUdKamx5MlowaCtUSFpt?=
 =?utf-8?B?WjFTT2d3dnp5WlhEeHNyblVuOEphV0R4cElKM052SHJ5NGpqd0lzUXBaRy9K?=
 =?utf-8?B?REkvUDRDNkdpVjRUeTZKRzFFWEp1U0dZblJwT0ZodVlOWUgwQlgvVWQ1OGFL?=
 =?utf-8?B?UFdrUGFrdDdhSnh3dXc5STIvblRod2RaaVJ5N3JYOWJHc0hVUWxhT3IvWE5S?=
 =?utf-8?B?S3hLcUY3UlczNU50MEhRVUtJNjFydlFzNEFFTWJYZUJFZytkVGw4SkV3YzRN?=
 =?utf-8?B?L3lRY3U5SGtxZitwU1hYTFBYZ2pQVGdlN1dRUWFUaUtEd2NGSytVdFFyck1h?=
 =?utf-8?B?TzRCUlkwbDlwOGh1WGtBNXJudDdiWE9tMXNaL0tRUklGZFhveFkrbk1hbCt1?=
 =?utf-8?B?QUFqZDZrWmZMaENFY2NFM0RCY2N4S0ZXenhpZWV1SG85b04vVjRHUVEzLzYx?=
 =?utf-8?B?R2Z6MTJaTDZnT05Cc3pYZG4vZU1YNVpld2REdFZVcFExRjdLeFB4bmcxa284?=
 =?utf-8?B?VTJiT2xxVEpKTjQ3MGI1cHl5NlU2a3Nab0VnUHJieWUrYS9pU0wrYytzSHVE?=
 =?utf-8?B?Tk03cXVwTUlNMHNiMzIrQStYbmR6bGUyYUxjMTBuRnhJZ0RCWlVWckEyTXUx?=
 =?utf-8?B?QWxuR1UxSW5FUFF5UlFQU1luWklqT0s4RGpFNGdBbEVnNGdBdHVUdWp0NFlB?=
 =?utf-8?B?dnA0R1E5NWlEVGJicVhnQU5jT0VFUHJ1VC9GelB1d1dRQ2pYYXVPMmhPeXV4?=
 =?utf-8?B?cDZkQjNZaWxQdXJjcEU1UVh3WTBKc2VXMVZNakJvTXBQd2F3cU5scFgweVlp?=
 =?utf-8?B?TnZVeHR6WCtmZ0dkeDVnaGZsZW93WGRudjZzNmpYNllzcTJtaGVabkcweFNZ?=
 =?utf-8?B?NHJ0UHNiYUxBN0szQlBaOXN6MVFkR2xmMys4RjlmKzZFTVlQMnNBWHAvejF5?=
 =?utf-8?B?azU1NFlvVEpiUlpia0dCYzVQSUsxNXdjd0xXZlU2WmFQVTBzN2dXTHF5L0I4?=
 =?utf-8?B?MmRSQVFHM3dHT1hkUFBnQzNxZ2lmQzd3aUhDdm9lRHRqZTNwKzJqc1JwUy91?=
 =?utf-8?B?V0V5WGpudm91QkFuTG0zdWtJc005c1hNT04zbmc3TnBiM0M1Q0RMZDh4K3Bl?=
 =?utf-8?B?ZWNlZkluc3B2eU80dFhDTlN0U01YSmtQN3pPZzY5bmZreEtHV2hyc0N6MTho?=
 =?utf-8?B?dEo1QmI5cEtBYWVLOUo3TWV5VDdOY1M3ZjNOSXZnSURPUytrMy8vSExodUtE?=
 =?utf-8?B?WXdBNTlSQkhYTGFyZFZscDl5WXlzaE5QRlpQTlJsU1Y3dzJBZ3l5aHZST2ZY?=
 =?utf-8?B?NXp1dnR6TWJTOVhSVUpQNmh3VlpMT2tRNjdESFUzdHJJVGExS29ST1B6K1lG?=
 =?utf-8?B?UHZ1UGhjUHloRzdLNFpQL0pWb2tETGcycTBlUzJMUXMxZ0QvWGkvT2dSMEls?=
 =?utf-8?B?TDdWUENMUEozRFN1alVjc3l4K0l0SFVzcEcvSS95N3dtaXJyc0pHNXpNQVFy?=
 =?utf-8?B?K1Faa05zaHFWeDlBdFRqSmpKZENRZTFWRUIzTHY3WVkzVGsrL3VNQWtkSllO?=
 =?utf-8?B?V0s0UjI4ZnZDSzRwR3VlMDdRd1ZiM3o2UjVhVjB6U2JIOUp5VjJDamNWKzJV?=
 =?utf-8?B?dWJOTjFTdDJ6V1NUaFFGcXYyWllWa2p1SzBwK0R3WFpVcE94ckl4amRNNlpK?=
 =?utf-8?B?S05XNWkyN0UxYklkY1Y1bWZrT0p6cE5PMWdpQWRVc0JveUJkUnZmNkhIaFky?=
 =?utf-8?B?aytaUVR3cUJCUkFxUUh2SzNoSmZJWHhRbXVqQThMcW1OaVptVDZpRjRFeGN6?=
 =?utf-8?B?bUhRMlNGVEk3Vlg3NnFaVStqVnVZZXYrajdkREJMRlRyZ2hFOUVha3JQK2pl?=
 =?utf-8?B?WXN3amJIdzlPZlVyL1RnbGxaYml2bURKSjMzam44UjlpdFFxNlJXMXBkdjRG?=
 =?utf-8?Q?x6H2EFv3834=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aFdLZGRISmpHVXJtbXRsbGFCOTE1eEdQZEJjWVVXa2xQcG5nRDVlM1oyaHFI?=
 =?utf-8?B?bVpNZUg0QnFKVEFHSWNIMHNDYWdXaXQxMkhrcHhMQ29rdnFtQ0dDbnFyWnpX?=
 =?utf-8?B?MVRGZ2dQQXhldzlXUEh0cXNSNGRKaWNBUDNQMGdtVVc5SStxdFg1RC9qYUZ1?=
 =?utf-8?B?eU1Ra0k5M05yR1NYRWdud0VLaGpYZ2JjSjQvUE9ESkNnTmU2Um5LZXo4SUFD?=
 =?utf-8?B?dDRFSU1DVDZjZVd0QlpyZUR2aXdqUXhpbTY2NW0vQmFqbnNucy9vdmFGSUsx?=
 =?utf-8?B?YkI3b3ZaT2dpNy8xdGdaSm0wVm1wSVNRMHZlSlU3MVVrTjRtcDRaTTdxNHFI?=
 =?utf-8?B?R28xbGs4OWpaeTlQVmtodjg1Qm9HNDFSNXo3OXQ3eG94cDR4RUVtL1U2Z3FL?=
 =?utf-8?B?VXJtbm5yZ3pERHRJbTFkc0FBOHlzZnUvV1YwQVZ6OGcvY0NVdk5hMTFldWdt?=
 =?utf-8?B?bDk3L3ArTzIwUFFjd2dPekxINkJBbDdFVUZmQkdWS1VLcXc4Tmp5MUhUZWZj?=
 =?utf-8?B?YnU5ZzNudmdVYWYxMVlwU1MwS2tVMlFORnl3RWhJblYwck53K05RS1FxT0I5?=
 =?utf-8?B?R1VJeFJuK1lxa281YXJvL2MzWFlhY1FVaGRVdFpiamlmanBTUjV2Rm1lVG5l?=
 =?utf-8?B?a3RLejJZZWxhVXpQZitET2FXVzNLN2NNaThTUENNZlFUSUNML2Y2anMvbXdT?=
 =?utf-8?B?UVF3azNCLzZUUVRDL3gvRTBGdStXY1dsUEhLTWZxZkl6NHJNWUNqOTgySUtU?=
 =?utf-8?B?azF2R255bzJTZ25Qck1RR2RWTDY4OHZTc3NaUFNzTzMzNENILzZCYXJrVWxT?=
 =?utf-8?B?bWlnUmdXdjZXM004Mk1wNkYzbVVCZG5TOTNDWXpsUmdKMHJMNjhuM0ZQeURW?=
 =?utf-8?B?YlVOMmMxU0lFaklEZmNBN1dKSk9TdEthRGc4OEIrdG5OTVp1UjNISFFXYmtS?=
 =?utf-8?B?cnRTZC9vcXk0empRWlVEVHB6TGlsa1B6NTFwSEliY0dPRG01eklTaldhQmha?=
 =?utf-8?B?VlcrYzd3QkhPSFhKbHUvYnVTR2RHMEZ0ZGlBSFd0ZW5ITy9jLzErTFd1TjM1?=
 =?utf-8?B?NzhNZHltTlNiREIzS0pDZ1RPOUlmL2owMVRucjNXNzNYTXFNOGN6bG5EaytX?=
 =?utf-8?B?VmpPTXlpZjVhOU5sSTQzL25zMWI4bFJmbEpxY0lZQWdYNnJvNk1aeFVrRW1M?=
 =?utf-8?B?RTBFYVBsRHdXZm5reEFmcWNxOXkvOGJidlZwVjdOZWdwVC9xRHJpQlRabDVV?=
 =?utf-8?B?c1FmM2x0UkwyMVJLM3d0Q0djR2tEMnF2UjNGMEp2WG1MUFJQODJZWEFIN1BV?=
 =?utf-8?B?VzFBTFJacmhlYUVLdHM0VFVoWWV2VnBzenEva2VETnh4Zk1lK0lPS1BFUkVR?=
 =?utf-8?B?eUVoZ1RnRW1HVUNwZUw3Y294Y3hJYjRNMmplS2UrSERpVlhWb05XMlRVTjN6?=
 =?utf-8?B?akJYWGt1ZjFkVWUyZzBJSTZ6UzRCdUlqVGl3RVZ3WDkveGswblhhU0VyelRP?=
 =?utf-8?B?bTVUNU1DRWJnbHVIamlINlY1Q1lJRDBxTlR6alVWZkd2ckl3RWM1UmN1ODF4?=
 =?utf-8?B?SEIyQklHNlptQU94bGE3S3IrNExXK1ZHdkxYZktKVkVoYjN2WEdmaGxNQ2Vn?=
 =?utf-8?B?Nm1qaVY2S2tqQ011emhsMHF6OUZZUlMwOFlMa1k1R0Y5b2lsMEhKcVFYeDBt?=
 =?utf-8?B?K1ZDYVlkaVlvL3BQY0Z4SkV5cSswSGQyeUdhTlJXMTFXYkVTSWpRSWxQZit1?=
 =?utf-8?B?T3V6L0sxVU1aNzZvVE84RVQ5S2FpS3BQL0dENjB5ODVRVXA5WVprcmxhR3Q4?=
 =?utf-8?B?TnVPU2xqeXdob0RUbVNFWjM2RUxDUkptbk1ONXZ3eTNTZ3AzNE5qazhxbldi?=
 =?utf-8?B?Mjk5V1Y2bmRLZWgzSDVHMWZWT0l2NHkrQTZ2RXVkbE85RUcrUnh0L2t2b09j?=
 =?utf-8?B?S3FCSWhtV2ZpVzN5QlZrUXN5RGRaenhiY0V3Z3IwN3k1TUVETkJHMCtTSDIx?=
 =?utf-8?B?M1Q0bHZGaTlFeWRCZDJGeVBzS1VzWnkrbVdTa1VlZGNnc253dDk5Z2ZiRTAz?=
 =?utf-8?B?WHVNbEJBaEk4TWQrbXpBTTkxTGFpdUxsZ3VEMnMwK0hUVW14ZkhRWWdVQ1dW?=
 =?utf-8?B?RzhEdTRZYUpJZVVFUzFsanJJRGRydENQQWdxTDJLV1lvOVAzV0c2djhzVSs4?=
 =?utf-8?B?MVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c6c444-c392-4e55-f552-08ddacceed38
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 12:11:30.1588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Vs/SNyZA8vtyQnrI/vjg0cFCW0KUs0PpdfApCc0keXDZJbfPOsIetSpdJXSkAdzRFnIqx/E3P75xxc79ShZ1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6541
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Jun 2025 12:11:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19109

On 16.06.25 13:07, Jan Kiszka wrote:
> On 16.06.25 12:47, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> If an power failure occurs and the TPM was open/in-use the DA lockout
>> counter will be increased. If enough shutdowns occur the device will go
>> into lock down mode.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> Changes v2:
>>  - use tpm2_shutdown direct instead the wrapper command tpm2 shutdown
>>
>>  recipes-initramfs/initramfs-crypt-hook/files/local-top-complete | 2 ++
>>  .../initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb            | 2 +-
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> index ae0dcef..009289b 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> @@ -293,6 +293,8 @@ for partition_set in $partition_sets; do
>>  	finalize_tpm2_encryption "$part_device"
>>  done
>>  
>> +# shutdown the TPM to avoid DA lockout due to powerfailure
>> +tpm2_shutdown
>>  if [ -n "$watchdog_pid" ]; then
>>  	kill "$watchdog_pid"
>>  fi
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
>> index 80a4755..41a3c83 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
>> @@ -42,7 +42,7 @@ HOOK_ADD_MODULES = " \
>>  HOOK_COPY_EXECS = " \
>>      openssl mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
>>      e2fsck resize2fs cryptsetup \
>> -    tpm2_pcrread tpm2_testparms tpm2_flushcontext \
>> +    tpm2_pcrread tpm2_testparms tpm2_flushcontext  tpm2_shutdown \
>>      /usr/lib/*/libgcc_s.so.1"
>>  
>>  HOOK_COPY_EXECS:append:clevis = " \
> 
> Thanks, applied, bumping the recipe version as well. Please do so in the
> future yourself.
> 

Breaks buster, unfortunately:
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/10360969597

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


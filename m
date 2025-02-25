Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF58C021B8
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 16:42:03 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.67])
 by mx.groups.io with SMTP id smtpd.web10.13228.1740501717539125436
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Feb 2025 08:41:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fV9Sc8Mi;
 spf=pass (domain: siemens.com, ip: 40.107.247.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyKUWiYNWajibw3D+5Z6KV9UQ0kbzTa+Yq4RbK3uj/ew7bjnFL8DWq0DG+940GeLESIJWG36DnA3Io/ej1+ZY17UN9lgpJBvX9uVU+w5Bnztak4DXz6tvzgYaBsnlnjGWMncWXgNV8p/fBuUaxheUQuBP0CGB7A3mVkvXjxITdTa6Q/9hhm2nARfzimVT3Ly0pA0Q/dKxqtnpq6as3g/r8AtDtYlnRBEuXhkHuZHExjWez4mCV1FD4B2aKstn698e7kF/P5puRES1YlIm6YX3kmSHXw303B8i5dKzoz+ILDpJopjkRr2Cv0pL/A7QQ7Oaamy1skm/Q9TL+2H/8vPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcI86NB4GNB7A6h2eEtCPnFG+2FM5cCGXm/exoh8rGI=;
 b=NX5EAEuz0f49+savh8fNxBzkp38Vc0Bx07RVw4j/DBresnCdaeDJe4Zy/Iu2/UZpg0NlbkS5lJ33ag1EUYY2mr2zYk2srqDnjfU9aFq0ANbwnMzrHzv+vUpGddg9nt2NtdmQBBWrO73c7NOynYyOuook1R7wlktiYi3Bz/oXiyQTfyhg+aywybk7tSdDEsawHr063Agf8T5QrnL9pNI2X7HnslVV8iwbQWKd/LsawtFxvqE60cQNnLmJrJOr+Sfg5+YVfxJorxXJA3IK9070K59ajPbuS1+hYbd3Tj1MdIJ3FuOBiIv3pEe9H/MF3tsGDP4rAj/pZw+GQrjL1mdCxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcI86NB4GNB7A6h2eEtCPnFG+2FM5cCGXm/exoh8rGI=;
 b=fV9Sc8MiQQiHyxHDN/QleYAwUMNbUAloYybxmJv/sk9D9ehpu/ZRqyp2yenoLZs3iX9nNs/AYielfHXNant34sAeMFbBu0bAQzMze8GepFd4ubhyTRpLuluHASlCZ5u2bv65uwkxt0r6dNdCy7B5ibMXZm2ReS1cyReKapuShW3AQyi5SvZ5zrRxU7Ws2BiUNCTJ9fLlHERlX3B4JzIF+PwDKz6939gGWAn1vUppOArpcgjQrT3Ng3O0Af2oc1wuna/rP9e4lzDornncT4jqtuQff/e9OW0/q6w68WudQfzNNEM3IHoCiE6OgFaa91F9xqu99Vy1cWua6a78eBsi8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB9174.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:420::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 16:41:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 16:41:54 +0000
Message-ID: <e7b3ee17-4f04-478d-9631-ba8c05a019f2@siemens.com>
Date: Tue, 25 Feb 2025 17:41:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1 2/2] scripts/repro-tests.sh: Update
 script to check wic file reproducibility
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250224090052.260495-1-Adithya.Balakumar@toshiba-tsip.com>
 <20250224090052.260495-3-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250224090052.260495-3-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB9174:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd01619-bbd0-47b6-b145-08dd55bb5010
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YXZRUmdZSnhIVjB4RkZMVXNDNjhmRXFKSnpwSk9hN25wR1dwVzZyaVdtbTlU?=
 =?utf-8?B?MjBKUWdHVUpIYUY5VjlFbTBsNVQvcGdnM1BsaEdnSW9qaVFNSXJoWXdkajhm?=
 =?utf-8?B?dEZ4Ym9POXlBN1lMNFFIUHdwNnVDQjJ1dW1iM0dKMXRDVnlzakJnbGJTbUtZ?=
 =?utf-8?B?VFArZExmYStuQ0w1RTF2OVFLV1l5NW5NNWNZaVlRdWdGR2RpalFPdytVcnZ2?=
 =?utf-8?B?dzBXSys2Q1lGYnhhK3VjTmsyNGxRVUhKU3NuS1pqZWZRUEhscmMyWGNSUmxq?=
 =?utf-8?B?M0orblFseUdINDIvRXdpQ0oxUGk1aGtVRElMbmI2NUtFa1ZRMnZRMVBwTWlS?=
 =?utf-8?B?bGQzSSttK2VBc2tpKzF3ckdDcnJtYnhCK3BjbGNNQklrY0ZBMURiZm1UNTdT?=
 =?utf-8?B?dVFoNElXWVk0M1RuRHJuVmY1b0VCc0crYTBhQTNwNml3eWRFRkFXWGg2T0tJ?=
 =?utf-8?B?RC9FZGpZTURMTkkydGExeDZveFhrbXdIa0JiaittVXkweDEzRFVLSU84akpB?=
 =?utf-8?B?VDl1UGk1aTREL0Z3MG1QVG1IUTRCV3FaNDFrSUt4ekxlMUNqVFBFOEFzSC9N?=
 =?utf-8?B?NTlyb1lKa1FiYU1LVE40SFBQNDdKbDUrVzBKTDJiL0F2Z0RHVG53UWRIbXJE?=
 =?utf-8?B?VndEWE93OXhOR2NKYXZTVkJxaXVQODdVQUMvQWtRQ0VoY3dYN0xkYmNBaHVM?=
 =?utf-8?B?MmJ3eG9xNC9QMG1SYWhEdE5WRllNdEM4d3h0L3cvbDQ4OEU2MlRYM0lVQXN3?=
 =?utf-8?B?TU11TVU3TENWTksxWXhZdGo2QUhNZmpWNlhaYkpSVXZReEtFazRheERoem5W?=
 =?utf-8?B?Vk5idEo1cXJVZlhSUVlVbkorM3V3ZEdXcG11bXRDdVl5ZkFDcFNhRHVQSG1E?=
 =?utf-8?B?VVk3N29hMDIzczZQNXJYcTZ0R3k5c0xtbjlPVmtnNlcrZ2ZsRVBSd0R1NHkv?=
 =?utf-8?B?TU9jcGo0WThFUHBVU2J0b1NESDI5bTlkWk1QN0dJRVRiTzlQRDl4aUdPV2gr?=
 =?utf-8?B?RHUraDJSTkxlODNTNEpVNTJxdUVQZkVXWFBUeHhvaVBLSXBnYW9XZitRTnBn?=
 =?utf-8?B?MTB0YnBhWTdKWDc1ZXJxdzU2dUxnKytRN28zZ3V4SWhNTDkycXlDV2RWWWtZ?=
 =?utf-8?B?T2xSdVJBWlpRd0tiVXgyVjFuT01PdkNvTWRuang1OTlmUVVackxHRm90ZWpp?=
 =?utf-8?B?MldDTEVRcU1VTFpsTEVMVmw5WjE3NkMvdVFSNmlrWlBaejZnSXpoVTVmY3k3?=
 =?utf-8?B?RGdLbVk0QUpLTUkvb1V6UGZYMFhmMzNSM3JPbzNJZlluWEp4VlRFbkZkKzU3?=
 =?utf-8?B?a0ZqeS8xbzFWVkxnbFA3WUVYL1VZbVdVV21DSU8rNmdPNnBVdXV3RjArOXcr?=
 =?utf-8?B?RmZhWllvS0lGem05ejR2VnNsaW51MFlDSGxqbUxLTGpOcWg5T2doRkQzT0VZ?=
 =?utf-8?B?RHRuM3Z1bVFaMm5GaUxwS1NsV2NnaXpqYnN2dzBKMXhpNGFqUVRkZFBxZkEr?=
 =?utf-8?B?RE9xWnVHYTNtbDMzaldNa0RtM3h3UzdhTzFCNEo4M1VURWZ4VHo4M09BaU5p?=
 =?utf-8?B?QUFVQUFHbC9sVUxESGtzMjVONHl0T3dwZVJVb2xidXRLR0lNbHh3dGRpTlZK?=
 =?utf-8?B?NjcyeFpHem5qNlUzVnRtWUlNZ3czaUlaWTQ2Um1CVU5BZHRDUG9Lbm1kS0pV?=
 =?utf-8?B?WEJSOFhKM2o2TVgvekwvOW1sckU2cENRRUZwZ250dWpyaU04d29NTkhaY0xt?=
 =?utf-8?B?aHRVSWt5VnptWXlRWjlvUytkYmgrQjgxQjZScTY4b1FwZlZCTkJkcjd5T0tt?=
 =?utf-8?B?T2U2STdpOEpEQjU5aHltZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RXBnT3lpbGdOaitSeDRLci9XQWh6dVRiY1ptbWsyN28renMzZmtlNnVEQlFX?=
 =?utf-8?B?VWFPYkwxelhwQjg4QW1udDg3VkFNbFNZRGVrMGMzd2wrVVUreXAxdy91bkZy?=
 =?utf-8?B?TGw5VlI2TENHcWVMSTJvbWNUdnBXMkZSMFlISDdDVmtFOXRDNXBnajMwM2g3?=
 =?utf-8?B?VW45aWVvRzNBR0FoNHZXL3daVHdFc2dyeG1hNVFMNFVmT0tET2YrVU56S0NI?=
 =?utf-8?B?ZkkvUUFYcUg2YTFON0djMTlaSlFTMzhhM2FpU3VYUkV4ejB2WWdIZDFZaUFT?=
 =?utf-8?B?bHMxa0t5UERFdVdqS1NzUHk0eUUweDJYcUV0Sm9IV0hDTHZYYlBQekthSVBF?=
 =?utf-8?B?cnIwY2VYdFRGSUdVMlAwOHJ1Y0dac0JCU0lIM0VXT3haTU5BQmFkeElrZnB5?=
 =?utf-8?B?UlpwNW1yOFV5REE2cW1JeGdYTUp3Y0szcmVOYmFqTlNyUkZ1SlV1VSszT3RL?=
 =?utf-8?B?R2VCNGM3TmtkcGhncWlra0NYRmFEclk4UDNONzBjckZrOFhZeHBieEIyRWV6?=
 =?utf-8?B?aW80dzdCTFZ6TC9sSzFpQ3BwMUwzc2N0Ni9YeEFpcHV3a0ZKL1M0elVMS1ZR?=
 =?utf-8?B?ZU5lekpBTlByT1J1TmFKUjFHUE1mZ0xCVUIyWXlZNHVVTllwM1RNWGJ5WXBP?=
 =?utf-8?B?dFBWejNyN0hwMWdqVm1ET28yQVNrWWxLc0hDN2RSTWppWDJFdVBJU3ZRTzVt?=
 =?utf-8?B?ODhCM1RSazN0NExHRERWaGJaTExuTmhVUXpqMnVkUHZLNW55bmY0Mkp5cXJk?=
 =?utf-8?B?b0NOZEhZekliYVFtak5oQjZYb1lmcklXV0swd3ZjanZGazlyNHNjV0w5MUl4?=
 =?utf-8?B?Zm8yYUl5QXlBbFNJN3VLQ2twdW54c0tTdnNSajgwL3ZzT0RUb05DcVB1WjBJ?=
 =?utf-8?B?UHpIV3F0b3BiQW9OMWZJU3hRVEtKT1Y5NnZ5YVJEWllKZHBNK0gxbGZVRE16?=
 =?utf-8?B?emsxV1RJZ1htQ04vbFhJQzVZUElybUlRNjI3d3FmcjZrZ1QyUnVqSXc4aTJx?=
 =?utf-8?B?SUE1UlB0SmZ2Y3lWRVY5clM3QU9ic1BxTGFaSmNtbTUxcllEWS84WVdlK2lp?=
 =?utf-8?B?anB2a0Q5cURweWVzTEREWmQyZUZoU2FCQjJTblFYbUt1bkVvd0xTOFFoUDhL?=
 =?utf-8?B?dHBwR0hFdkpZenRFZWJ3QWJJL2JwdDk3a1hYSzFoSU53RkN5Z1hPa1dES044?=
 =?utf-8?B?NVBKTUNVcmRIZlBLN1c4N3l6a3M1MnIvMzI1dHNldkcvbngra2N0d1dtVXBV?=
 =?utf-8?B?WUF5YTVSeTlma2lzd0JpNXNoZGp4bTZ5RUxaVldyY2FFbWNKeStHdzg1d05r?=
 =?utf-8?B?RTVkZjZsVG5HcGdUSDdySC82RGhEanNiUzFiRVhRUUY4bE92eHJjZWJvdk5x?=
 =?utf-8?B?Y3Z3bU5zamttcVowNFYvTWdRclY5NDJyS0JibjFaM2owaDRoUytIUTk0NzV0?=
 =?utf-8?B?UzUrQ0JJTTF5RlZvTFBtajBYWCtPaytwSWtpYmloWUlrVkpnVU9jTmJJOVVC?=
 =?utf-8?B?TlQzRnNxVWdqYVg4RFVEaWsxUUpvQmRlOHhBeDY1NXp4MDVnUE0zZ2ErazhD?=
 =?utf-8?B?UllMVkJLUC96SllUUmd5VmRwZFBJMmNtNFJDNTNLL1l1eWFWU2JkTkQwU1dO?=
 =?utf-8?B?M1Fldmo4UElJUWRpMjlPOHUzVitjdFNWbUtTM2pvek0yN3Z2NjQ0UkZBRjRD?=
 =?utf-8?B?TEtreVVVQXZSc1EreHIyK0d4UTVNUElSeUYyK3ZQbUpRdG9uTXBCWHk3QUxL?=
 =?utf-8?B?VFprOTFINnVWNkZNZ05tUlpCemxGU05jTXdQWE1nM1NPTVVGRTlOZ3VRVk1C?=
 =?utf-8?B?S1liMWxETXprZVEvSzg4a0Y3cUFIZW9ucEJzRFdQSUdCVEVFZjg4bXVSczRr?=
 =?utf-8?B?RHpyTmJsZitQZ0Q4LzhBNDFoc2FpSTNjdUxyNVgxVFkva0N2cnArbUR6RlJX?=
 =?utf-8?B?MEptcWtrYnB0RFh3ZWN2a01oZmdaYzFocE9jSllEYUVIUmVGRXM4Y25hNnNo?=
 =?utf-8?B?emM2OXdjZGRBUjBTNnl0bDdHTzFJQTd0YXhoa0d6eXcySFRTVWZLa0ZoZGpF?=
 =?utf-8?B?MjZVV2N3TXlUanFBb2ovQ3QwZmd5c05VRnQ5cnllOFkvaGljNGpuamRzWWQ3?=
 =?utf-8?B?NUZWN2liQVlPZlVkWXBNMFdubDlOL0JuSWhTT2R4Y3ExZS9WdjdzRElrVUZ0?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd01619-bbd0-47b6-b145-08dd55bb5010
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:41:54.8092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbZ7OtKKPG6/1y0mVodfzeKwK/L7liRC2n+nf5WBp5AVwx0ibWFLjbybKlW+wyc/K4ZdasCo3HxgVpGcczp+ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9174
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Feb 2025 16:42:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17910

On 24.02.25 10:00, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
> 
> Running diffoscope on the full wic image can be problematic as diffoscope
> has issues with high memory consumption and jobs could fail in the CI [1]
> 
> Instead check the hash values of the wic files and if found
> non-reproducible then run diffoscope on the individual partition images
> 
> [1] https://salsa.debian.org/reproducible-builds/diffoscope/-/issues/383
> 
> Signed-off-by: Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
> ---
>  scripts/repro-tests.sh | 92 +++++++++++++++++++++++++++---------------
>  1 file changed, 60 insertions(+), 32 deletions(-)
> 
> diff --git a/scripts/repro-tests.sh b/scripts/repro-tests.sh
> index 8bdb34b..7249204 100755
> --- a/scripts/repro-tests.sh
> +++ b/scripts/repro-tests.sh
> @@ -14,11 +14,12 @@ set -e
>  
>  usage()
>  {
> -	echo "usage: repro-tests.sh [--release RELEASE] [--target TARGET] artfacts1 artifacts2"
> +	echo "usage: repro-tests.sh [--release RELEASE] [--target TARGET] artifacts1 artifacts2"
>  	echo ""
>  	echo " Optional arguments:"
> -	echo "  --release RELEASE: debian distro releases e.g. buster, bullseye, etc. (default: buster)"
> +	echo "  --release RELEASE: debian distro releases e.g. buster, bullseye, etc. (default: bookworm)"
>  	echo "  --target TARGET: e.g. qemu-amd64, qemu-arm64, qemu-arm (default: qemu-amd64)"
> +	echo "  --extension EXTENSION: e.g. security (default: "")"
>  	echo ""
>  	echo " Mandatory arguments:"
>  	echo "  artifacts1 and artifacts2 paths to test the artifacts reproducibility"
> @@ -29,7 +30,7 @@ RED='\033[0;31m'
>  NC='\033[0m'
>  GREEN='\033[0;32m'
>  IMAGE_BASE="cip-core-image-cip-core"
> -RELEASE="bullseye"
> +RELEASE="bookworm"
>  TARGET="qemu-amd64"
>  EXTENSION=""
>  DIFFOSCOPE="diffoscope"
> @@ -72,35 +73,62 @@ if [ "${EXTENSION}" = "security" ]; then
>  	IMAGE_BASE="cip-core-image-security-cip-core"
>  fi
>  
> -# Define files in the artifacts for checking the reproducibility
> -set -- \
> -	"${IMAGE_BASE}-${RELEASE}-${TARGET}.swu" \
> -	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p0" \
> -	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p1" \
> -	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p2" \
> -	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p3" \
> -	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p4" \
> -	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p5" \
> -	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p6" \
> -	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p7"
> +run_diffoscope() {
> +    local file="$1"

In scripts/repro-tests.sh line 77:
    local file="$1"
    ^--------^ SC3043 (warning): In POSIX sh, 'local' is undefined.

There are also some more warnings (info/style), but those aren't new.
Still, bonus for addressing them in round 2 as well ;)

Jan

> +    local artifacts1="$2"
> +    local artifacts2="$3"
> +    local label=""
> +    local fstype=""
> +    local res=0
>  
> -# compare artifacts
> -res=0
> -for file in "$@"; do
> -	if [ -f "${artifacts1}/${file}" ] && [ -f "${artifacts2}/${file}" ]; then
> -		label=$(blkid -s LABEL -o value ${artifacts1}/${file} || true)
> -		fstype=$(blkid -s TYPE -o value ${artifacts1}/${file} || true)
> -		if $DIFFOSCOPE --text "${file}.diffoscope_output.txt" \
> -			--html-dir diffoscope_output \
> -			--html "${file}.diffoscope_output.html" \
> -			"${artifacts1}/${file}" \
> -			"${artifacts2}/${file}" > /dev/null 2>&1; then
> -			echo "${file}($label,$fstype): ${GREEN}Reproducible${NC}" | tee -a diffoscope_output.txt
> -		else
> -			echo "${file}($label,$fstype): ${RED}Not-Reproducible${NC}" | tee -a diffoscope_output.txt
> -			res=1
> -		fi
> +    # Get partition label and filesystem type
> +    label=$(blkid -s LABEL -o value ${artifacts1}/${file} || true)
> +    fstype=$(blkid -s TYPE -o value ${artifacts1}/${file} || true)
> +
> +    # Run diffoscope comparison
> +    if $DIFFOSCOPE --text "${file}.diffoscope_output.txt" \
> +        --html-dir diffoscope_output \
> +        --html "${file}.diffoscope_output.html" \
> +        "${artifacts1}/${file}" \
> +        "${artifacts2}/${file}" > /dev/null 2>&1; then
> +        echo "${file}($label,$fstype): ${GREEN}Reproducible${NC}" | tee -a diffoscope_output.txt
> +    else
> +        echo "${file}($label,$fstype): ${RED}Not-Reproducible${NC}" | tee -a diffoscope_output.txt
> +        res=1
> +    fi
> +
> +    return $res
> +}
> +
> +# compare swu file
> +res_swu=0
> +swu_file="${IMAGE_BASE}-${RELEASE}-${TARGET}.swu"
> +if [ -f "${artifacts1}/${swu_file}" ] && [ -f "${artifacts2}/${swu_file}" ]; then
> +	swu1_sha256sum=$(sha256sum "${artifacts1}/${IMAGE_BASE}-${RELEASE}-${TARGET}.swu" | awk '{ print $1 }')
> +	swu2_sha256sum=$(sha256sum "${artifacts2}/${IMAGE_BASE}-${RELEASE}-${TARGET}.swu" | awk '{ print $1 }')
> +	if [ "$swu1_sha256sum" != "$swu2_sha256sum" ]; then
> +		run_diffoscope "$swu_file" "$artifacts1" "$artifacts2"
> +		[ $? -ne 0 ] && res_swu=1
> +	else
> +		echo "${IMAGE_BASE}-${RELEASE}-${TARGET}.swu: ${GREEN}Reproducible${NC}" | tee -a diffoscope_output.txt
>  	fi
> -done
> +fi
>  
> -exit $res
> +# compare wic files
> +res_wic=0
> +image1_sha256sum=$(sha256sum "${artifacts1}/${IMAGE_BASE}-${RELEASE}-${TARGET}.wic" | awk '{ print $1 }')
> +image2_sha256sum=$(sha256sum "${artifacts2}/${IMAGE_BASE}-${RELEASE}-${TARGET}.wic" | awk '{ print $1 }')
> +if [ "$image1_sha256sum" != "$image2_sha256sum" ]; then
> +	echo "${IMAGE_BASE}-${RELEASE}-${TARGET}.wic: ${RED}Not-Reproducible${NC}"
> +	res_wic=1
> +	echo "Running diffoscope on individual partitions..."
> +	for part_num in $(seq 0 7); do
> +		file=${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p${part_num}
> +		if [ -f "${artifacts1}/${file}" ] && [ -f "${artifacts2}/${file}" ]; then
> +			run_diffoscope "$file" "$artifacts1" "$artifacts2"
> +		fi
> +	done
> +else
> +	echo "${IMAGE_BASE}-${RELEASE}-${TARGET}.wic: ${GREEN}Reproducible${NC}" | tee -a diffoscope_output.txt
> +fi
> +exit $(( res_swu || res_wic ))
> \ No newline at end of file


-- 
Siemens AG, Foundational Technologies
Linux Expert Center


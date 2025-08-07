Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED929C87FCF
	for <webhook@archiver.kernel.org>; Thu,  7 Aug 2025 18:19:32 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.56])
 by mx.groups.io with SMTP id smtpd.web11.3218.1754590770889261505
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Aug 2025 11:19:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jthoB0Ah;
 spf=pass (domain: siemens.com, ip: 52.101.66.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoeCuCRnWc6H1cqtqTI4ZsJBP44X2Naozy5mJWhkoIUpiayocSW8NzN+kRcu7PMw4SAMf87cok0pd265bjcwDDzzkSpVBe3IgIki2DvXvR5e4GecBGkHPqdTwOiUvzWfx+sUOVqEjRI3eMB/A8EWRfRiNlIDRK/XK+ny9zPvZkc9jZHEwP3vvZkEDFLzSsWCcgnBDRyf231IiUBUEH8CUVu8+KhARgW0IURG7p2PGsVljIkunAXdKsGeJ9grdyIXdEFhJizg/V9p6l3Uu7T0HrE8P++ZxuntdpSh6CeyvI/ixAO2ZX2Higsm8a6BOjJ5b/21Yc3nRxPMWNMSX/z93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yo8TyiUtIn42luSMWJCVBurcmExQ8ZFoAR/uj1M6YhI=;
 b=KaM2/m7DAwA/HNYLeAdsdA8sb2iY4nV1xPy9q+1rlDSjRjWSiyUi+9BHxp26Hsf5UBixb7t+Zi/9PEAetT0GW45Vi6l0M4/2zO0jhbIdPCimi78gjP3XHY3KfWVMS6BdAC5sFXgxTK/Jye1Xccg13PqSmciYJmGme496ihUJKvgi2bM70He3jCocW1JDUIgjgIok/pj4xNYlU3JpeTYT32buB1a/MKks6ZlGnvk+CVm4O1sbdCdrU4Uw1ZJYSA63oRfIQwObEPg2ZawiR6/lLcD8EVfKjGu2cVlF3v3pTM2mH0bUf1w5DaP/DtDYwTQzpJKJcsxNFZcSWSyKTbXx6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yo8TyiUtIn42luSMWJCVBurcmExQ8ZFoAR/uj1M6YhI=;
 b=jthoB0Ah+g1dXRraroE6es9xSZLAMLIUPqhBBijLqVOrBJs1EHOwsWgK/W37it5OJW0Km39zAOoPMvu8HiAa27bOCIujh8b/eltshVQM4zOpv+z/bjBgc7LOR9mVy7uPNrkaqstXUENm7qPOItd8LVNS+4X2/V0dsjWgp2qjxGv45dZyyl4omF3Nq8WE8fAWNIw1nuvZGM4P6Gw3hYO2Xr4uhkR8jKt32r88oxmYUjww3PBN3SRspDGPlFqMgUqikyX0gbQz3bLNdyvca3LHTOnN9IySZ0wtFBBwirEV1tZtDEy8IY13Gw3y86qIivM6/svpBTwIS5Mtd67/QJfYRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6039.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:576::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Thu, 7 Aug
 2025 18:19:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 18:19:27 +0000
Message-ID: <4c38a7a5-2497-4f52-9b65-95849385636b@siemens.com>
Date: Thu, 7 Aug 2025 20:19:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v5 1/3] kas/opt: Add option for not install
 kernel
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
References: <1754534749-19754-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1754534749-19754-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: 52772a92-3c44-4405-e93e-08ddd5def1a7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZEd2b1BrNUJ6ZXE3TzIvanBmZVFYVXpNTVhlcVpVNnBqamk1U2ZMajM4NlBG?=
 =?utf-8?B?aDRUQ0J1Z1VnK2tROUJZTkdmYmhsQXV5VUpHY3JKVTUyaU9DVlNEbnYwR0x3?=
 =?utf-8?B?VERTSjFWS0hMdDk3M1l5aWlwbS9TM0RaWm5iN0x6VzBwVlVyN216SGkzR3lO?=
 =?utf-8?B?bUNYUzBJcUhJYUNuM3FicFp2eHprZXpycjRnK05hMDM1MkwxQzZQYnMwM1Uv?=
 =?utf-8?B?T1JOcGg0V1loNkovZWtCTTJPa2FYTHpLRDEvcVZ0YTBySHdCSUx1MEw3Z1Js?=
 =?utf-8?B?VzZlQUh4MlZMb1B2OGE4ZkVCTnVxNWRad0FHZlh4K0RJWXdEQjh1Ny9mQ2dE?=
 =?utf-8?B?Vzd6RFpCWS9UbXl5eWVqSmZyeTF2V21SWlNIVlpyWjhtZ2xQS2FzV2FaVkFl?=
 =?utf-8?B?T2FFUXZCSEh3Q3JqcjhOTmVySDN4ZlZDaHMzK1dlYk5nUWoyb0FKYW9vZTJk?=
 =?utf-8?B?aDRzYllkU3pPc1lVQXFFQmd6blpUakJTc0RLSGcxY09hbnJiaXhOenZlUGFj?=
 =?utf-8?B?M1grYnZiL3JjeUY2ajNnWUdZK0pyRkN1YXQ3NmVVVVFsdmRMSjc1WVg4ZXdM?=
 =?utf-8?B?ZXllTy80WDFGU2lGTTViR1Axay9qT0Z4Vy94UWh3K3BURXdLUlkyUGtSNFZU?=
 =?utf-8?B?NTR2ZmR3WkpnQkZkV3VQY1FKQVg0TGZYY0dvR0hIblRQa0JzU1ZMWUJlck1B?=
 =?utf-8?B?cklRcSttMWRIcEZrdWVNeXB5UVVMSURLN1VHT0h4VHVWTXVsUUdWZEdrT2Jw?=
 =?utf-8?B?TFpRaGtEQzQzbGh5VFFDeXM5UExuVDRCUVF5SDFzVE52VGtpY2FwdCtDUUFQ?=
 =?utf-8?B?SXh2TkhTYWdFTm1saDRndGJtc3Nqc04xMC81QVBjbEhXdFNXRGxQNG1oQ0Yv?=
 =?utf-8?B?UkhnejdPWFR1b2tMSlpZcWxTdGNsUDd0Sml4QVZ1K3Zmb0xUZ2FacC9KQ2JQ?=
 =?utf-8?B?UFhSMldwSlpYUHNWUE0wV2pIbW9LQ2RoenhHWGFuK3pyZkQ2UmMrNWgwYU1I?=
 =?utf-8?B?K1UyTWZDYlMzR083VjljSFRqN2lUT0dIWmIyVldaQzh2Tk9WM3h6bWgzRHI3?=
 =?utf-8?B?QnV6czEvWnFqVmVJTUpHblVDK3Z2cnhFWFBSSndQbHQwZGhVbWo0czRIWU1k?=
 =?utf-8?B?UGpsRWRMRkVBNmNKenVNTXZqdDk2OWV3MjdrbjdESnNsUVZVQ2VNbkc4YXZi?=
 =?utf-8?B?UWJnaHh5T2JUTVpUeVYxZ01xZkZJSVRlMUZGazgwbWpvYUxIdmM3Y2hsa0d2?=
 =?utf-8?B?ZGhBUUx6b2tzVkpNTCtDRnZGb3MzR3F4N1g4NHQ1M0JQRHJzZkhuajdrbDVv?=
 =?utf-8?B?Q0VlVUp3OWM3MU03bG9NdEtMYm1WL2MvQWt2YXBNeG1SRTcza0ZNaitZQ2V5?=
 =?utf-8?B?Sm1OakQvbGE5M280WUtFVDlIUWdmNEY0cG1zRkRETHdNNldMRlZKNVVvMi9k?=
 =?utf-8?B?NnFRL3cySmtCK0p0cnQ3SWI0cEVjQWNselFmODBWYnpxSmlrQVR6WW1mVGFt?=
 =?utf-8?B?ZzZ6T0dTakxEQkxFczRMclVLNHdvMklYSm5XVXBVMHJ6bEFlK055RUNJWGh0?=
 =?utf-8?B?L3B4ektKMkIzMTRLbXhwbm1zQklnc1ROU1EwVFNiaVdFMnJGVGtUbU4xZ0lo?=
 =?utf-8?B?REZYQUYrem5TOVdkTGgvQ2FwOGJwSGRGZWRmTElqUEFPK3JheE9uUTR5U0Zu?=
 =?utf-8?B?T0h5RzFwUnhGMUcrSnJjc241SjRQRG8yNm9Fbmh5R1ppY0xLbDQ5NCtjREpz?=
 =?utf-8?B?QnBNZkVsZXdjUGYwbVJVTDhPdUV2UXEybExjcm42Skd0L2NqNjlmMW1JU0RU?=
 =?utf-8?B?Y3VhK01uK21qRm9ZS0ZseUQ5a2VYZnJrU29XNjgyTU5ZYnc1ckFIeVZHT0tM?=
 =?utf-8?B?T1Vqc1RGbFlMd3I3aU5VOW4wcHdSTW1JY1JJUzFiTnFmUGQ3VHlCYVMzalJE?=
 =?utf-8?Q?QbOE/g96l14=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aHFoWW5PcW4xM1YyTEg2bHkvT0tqaS81dXBXVjVvNGJCVnRmbVh2OTc2amdS?=
 =?utf-8?B?d2kvV05KTzRJbWpSaWF4MWdPN1d2b3Rsa0JwL1M1U1RVeFcvZk0venJlODMz?=
 =?utf-8?B?ZVkxNERoaHl5TVQ5WDQweGlyaHRnOEs0YzJhSjNCVjRpQmRaYWVQY0V5YXcx?=
 =?utf-8?B?TjNpNmpKUUlONHR2YVh2N2g3TXh3Q0JqcHkwa1lRSlVRRXl5UThYUlpvcURD?=
 =?utf-8?B?R01VNlpFRFI0TXZiWjBxeUJIU3dhcDl5NjdPcVRmT0J3QndoeC9EMWN0MzZs?=
 =?utf-8?B?UnJvNzV3N3JVVW10OG5CUUVVRU9ueVlwdzRMRlplSW5sa1RWWHc0Q2JMajBp?=
 =?utf-8?B?cEhGKzFTVTBnQkdON0w3MncrbVYySEFLVHBTaTg0T1ZSS3Y4RUZveXZ4NzZP?=
 =?utf-8?B?VGFXNFRDS05PZ3hIa01jcHJMYjZSc2IvQldlS2YyR3pPODJXMlYvQitQYnQy?=
 =?utf-8?B?dHUxVTMxd3R1RXpNMW9ucTRVVDBZZmlyZ1p5L0xOZ3haYUx2K2RMVXdwRzNz?=
 =?utf-8?B?V3ppZnZPYTd1b1QzZlNEa3J2ekd3bUVXQkFEWTRmNnA0dlg3YWFkN3FMc0Rz?=
 =?utf-8?B?UjlVTEhTOEpsZVl2MktsNkZndXlaN29zTWF3L2hoQ05iMG0wNWNuZXV2TUUx?=
 =?utf-8?B?dmovVHIrUzZEYVNVQ2gzc0Z6ajIybitsTHhRMkFFWDhhd0hEclExeGt4UUd3?=
 =?utf-8?B?TXV4NmR2TnR1YWE0T0NwSUh2V21GTHJEelNpVkxRZ0szZjJ3QUhGcFFjaytS?=
 =?utf-8?B?MFFUbXpERisrRGptZjVadks5QnIxRm1tWXJKOFphMmpRRUg4Y2M4N2lpUGJl?=
 =?utf-8?B?cjY5SjlYcEpia0x5dExpbEFXYkM4NlFWTGx2WXQvSmx4N2RWY1NVTDN1RFdO?=
 =?utf-8?B?Q2tHT0lpRmlzL2xFM25KTHhuaCt5UmdBdCt5bmJWbzNHT0o3dkNNSlljSTE5?=
 =?utf-8?B?WkxhZ1VnWDJROUpEdjJ2NjBqRnZsWWI0ZW1QRkVJY0xBanhpWGZyZWx3UFBn?=
 =?utf-8?B?SE1oK1NMR1lmLzFBaDk3aFVGMm5xWTFIYTZEQ1N3Z2pHUjFvdWRWTkNpU1dn?=
 =?utf-8?B?UmlZQnYweUdsZWxzQzNKbElUUVgrWjRheDdTa2tFZ1JWQk85c0xTZVBXKzJp?=
 =?utf-8?B?aitnWmlZK0V1K0l6MG9rUHoyRm02bXVmQStCSk1RYkFTd1BjSXpUTjJ4aCtN?=
 =?utf-8?B?d0JZZnVWaHN2U2VpeS9DSGtyUmVhZ0M3RGpzTFRNdlhQZkhJckczSEcxZHBa?=
 =?utf-8?B?US9Rd0J0Y2QybzZnUUt6RTVYbEtWNTdmNWJWQy83VG9CNjF1T2p1bU5CY29I?=
 =?utf-8?B?bzE5a2haa0hFOXF1Wmw4NjBTc2Fidmw5VVBFOE5LZHBuNVlFeGNGMCs4V1ZO?=
 =?utf-8?B?R1dkSDl1MzNRWUxPa0JOY0NNSHRNbjdqREJiV00yR2dCTHlwYnRIUzRrTGdU?=
 =?utf-8?B?YW56ZG93REQyWWxLWUI1OUgyUEJVT1dKTG1BK2IzckJ5SGxjbGFHYSs0TkZM?=
 =?utf-8?B?R1BDL3V1Qm5iRGZCR2V6RDE4ZFFpT2FuK2FqUXZqME9PdWxOT25rQ1g5QlhL?=
 =?utf-8?B?cHhqRnIyUDNSSEFQek9yMGE5VUljNXZzWndzcU1wSVVJa2lTeWdsZG5welhw?=
 =?utf-8?B?LzYxT2dOMUF1akxRYk90ZGo2SVNGUFViOGxZQ0NIWWRQOEhyd1UzUm1FKzhl?=
 =?utf-8?B?Ry9ROWozMVRHMVd5MXA1bkkzQ21kV0hXMkhjdldvLzFFeWlBV05CbkwwWXpC?=
 =?utf-8?B?QlV4QXZ4eUtJaGIzSXIvd3hoWXdTOHVOc2JDa1VjRzVnYXFJUERkbkZkYTJT?=
 =?utf-8?B?TVFhNHZWZVpsSjF1SHZRMnVaa2xyUG8vUlF2QXl0YXZvWU5zazFyZlR6V20v?=
 =?utf-8?B?V29EZThsVlJZTU9rbjNLNUdiUUsxampQV2tCSEJwNkt0a2NNWmUzcFNSZGNt?=
 =?utf-8?B?SFcwS0Rkc3ZoNDA5bUwvODlZWVg4UU43ejE2bzdrK3I4ck9JVkFadFNkQjhr?=
 =?utf-8?B?eFRKa1F4Z1YrcmttWWNKTjRTUEMyTFQ5aUlvY0NrK0h5NkM5OG9zd1U4K1VD?=
 =?utf-8?B?d1hqZ1RmUkYySjVQSlE1U2VNZzc3ZWpyNDBTdjNiRDZxcjRrcVovUHF5RVBY?=
 =?utf-8?B?RU1lTDM2TnNtc0FEbTBNbE9kSFRESVgwcmpmT0dOa1FuR0Rxby8rSjk5eGFX?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52772a92-3c44-4405-e93e-08ddd5def1a7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 18:19:27.2179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3wLqvcIEVtcxAi5pkRIzzkebsSggwU9Hlfoajm3rgg6N6wSUXaYqlLuqZLC7CGKakF3vHh2k4OxE/HfTz3qrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6039
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Aug 2025 18:19:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19709

On 07.08.25 04:45, Nobuhiro Iwamatsu wrote:
> This adds an option to create an image that does not contain the kernel.
> This is mainly intended to provide images for kernel testing.
> When testing the kernel, kernel image files that are not used for testing
> are not necessary in rootfs. Providing images with these files removed
> allows you to reduce the size of the rootfs image.
> 
> wo_kernel is false:
>   -rw-r--r-- 1 iwamatsu iwamatsu 351M Jul 25 17:31 cip-core-image-cip-core-bookworm-qemu-amd64.ext4
> 
> no_kernel is true:
>   -rw-r--r-- 1 iwamatsu iwamatsu 275M Jul 25 17:09 cip-core-image-cip-core-bookworm-qemu-amd64.ext4
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> [Jan: update all call sites of deploy-cip-core.sh]
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> ---
> 
> v5:
>   - Set 'use_rt: false'
>   - Set 'release: trixie' to build:qemu-riscv64-test-nokernel pipeline
> v4:
>   - Fix the NO_KERNEL check to 'enable' only.
> v3:
>   - Update commit message.
> v2:
>   - Use KERNEL_NAME instead of IMAGE_INSTALL:remove
>   - Add build:qemu-riscv64-test-nokerne; pipeline
> 
>  .gitlab-ci.yml             | 43 +++++++++++++++++++++++++++++++--
>  kas/opt/no_kernel.yml      | 17 +++++++++++++
>  scripts/deploy-cip-core.sh | 49 ++++++++++++++++++++++++++++----------
>  3 files changed, 94 insertions(+), 15 deletions(-)
>  create mode 100644 kas/opt/no_kernel.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 628e624..3a4ba73 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -28,6 +28,7 @@ variables:
>    swupdate_version: default
>    test_function: swupdate
>    separate_home_partition: disable
> +  no_kernel: disable
>  
>  stages:
>    - build
> @@ -69,9 +70,10 @@ default:
>      - if [ "${watchdog}" = "disable" ]; then base_yaml="${base_yaml}:kas/opt/disable-watchdog.yml"; fi
>      - if [ "${security_test}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/security_test.yml"; fi
>      - if [ "${swupdate_version}" = "2022.12" ]; then base_yaml="${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
> +    - if [ "${no_kernel}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/no_kernel.yml"; fi
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
> -    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
> +    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
>      - if [ "${build_swu_v2}" = "enable" ]; then
>            mkdir build/previous-image;
>            if [ "${extension}" = "security" ] || [ "${extension}" = "ebg-secure-boot-snakeoil" ]; then
> @@ -81,7 +83,7 @@ default:
>            fi;
>            echo "PV = \"2.0\"" >> recipes-core/images/cip-core-image-security.bb;
>            kas build ${base_yaml}:kas/opt/delta-update.yml;
> -          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} swu;
> +          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} swu;
>        fi
>      - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
>  
> @@ -229,6 +231,43 @@ build:qemu-arm-test:
>      target:  qemu-arm
>      extension: test
>  
> +build:qemu-amd64-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-amd64
> +    extension: test
> +    use_rt: disable
> +    no_kernel: enable
> +
> +build:qemu-arm64-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-arm64
> +    extension: test
> +    use_rt: disable
> +    no_kernel: enable
> +
> +build:qemu-arm-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-arm
> +    extension: test
> +    use_rt: disable
> +    no_kernel: enable
> +
> +build:qemu-riscv64-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-riscv64
> +    release: trixie
> +    extension: test
> +    use_rt: disable
> +    no_kernel: enable
> +
>  build:x86-uefi-secure-boot:
>    extends:
>      - .build_base
> diff --git a/kas/opt/no_kernel.yml b/kas/opt/no_kernel.yml
> new file mode 100644
> index 0000000..7bba6a5
> --- /dev/null
> +++ b/kas/opt/no_kernel.yml
> @@ -0,0 +1,17 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation 2025
> +#
> +# Authors:
> +#  Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +local_conf_header:
> +  kernel-version: |
> +    KERNEL_NAME = ""
> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
> index 6e4dfd7..5647381 100755
> --- a/scripts/deploy-cip-core.sh
> +++ b/scripts/deploy-cip-core.sh
> @@ -13,9 +13,10 @@ fi
>  RELEASE=$1
>  TARGET=$2
>  EXTENSION=$3
> -DTB=$4
> -REF=$5
> -DEPLOY=$6
> +NO_KERNEL=$4
> +DTB=$5
> +REF=$6
> +DEPLOY=$7
>  
>  BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET
>  if [ "${EXTENSION}" != "none" ]; then
> @@ -29,6 +30,23 @@ fi
>  BASE_PATH=build/tmp/deploy/images/$TARGET/$BASE_FILENAME
>  S3_TARGET=s3://download2.cip-project.org/cip-core/$REF/$TARGET/
>  
> +if [ "${NO_KERNEL}" = "enable" ]; then
> +	__BASE_PATH=${BASE_PATH}
> +	BASE_PATH="${BASE_PATH}-nokernel"
> +
> +	echo "Rename from ${BASE_FILENAME}.* to ${BASE_FILENAME}-nokernel.*"
> +
> +	if [ -f "${__BASE_PATH}.tar.gz" ]; then
> +		mv "${__BASE_PATH}.tar.gz" "${BASE_PATH}.tar.gz"
> +	fi
> +	if [ -f "${__BASE_PATH}.swu" ]; then
> +		mv "${__BASE_PATH}.swu" "${BASE_PATH}.swu"
> +	fi
> +	if [ -f "${__BASE_PATH}.wic" ]; then
> +		mv "${__BASE_PATH}.wic" "${BASE_PATH}.wic"
> +	fi
> +fi
> +
>  if [ -f "${BASE_PATH}.wic" ]; then
>  	echo "Uploading artifacts..."
>  	if [ "$DEPLOY" = "swu" ]; then
> @@ -48,17 +66,22 @@ else
>  		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.tar.gz" "${S3_TARGET}"
>  	fi
>  
> -	KERNEL_IMAGE="$BASE_PATH-vmlinu[xz]"
> -	# iwg20m workaround
> -	if [ -f "build/tmp/deploy/images/$TARGET/zImage" ]; then
> -		KERNEL_IMAGE=build/tmp/deploy/images/$TARGET/zImage
> -	fi
> -	# shellcheck disable=SC2086
> -	aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE "${S3_TARGET}"
> -	aws s3 cp --no-progress --acl public-read "${BASE_PATH}-initrd.img" "${S3_TARGET}"
> +	if [ "${NO_KERNEL}" = "enable" ]; then
> +		echo "The image does not include the linux kernel. Therefore, kernel related files will not be uploaded."
> +	else
> +		KERNEL_IMAGE="$BASE_PATH-vmlinu[xz]"
> +		# iwg20m workaround
> +		if [ -f "build/tmp/deploy/images/$TARGET/zImage" ]; then
> +			KERNEL_IMAGE=build/tmp/deploy/images/$TARGET/zImage
> +		fi
> +
> +		# shellcheck disable=SC2086
> +		aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE "${S3_TARGET}"
> +		aws s3 cp --no-progress --acl public-read "${BASE_PATH}-initrd.img" "${S3_TARGET}"
>  
> -	if [ "$DTB" != "none" ]; then
> -		aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/"$DTB" "${S3_TARGET}"
> +		if [ "$DTB" != "none" ]; then
> +			aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/"$DTB" "${S3_TARGET}"
> +		fi
>  	fi
>  fi
>  

Thanks, patches 1 & 2 replaced in next, patch 3 applied as well.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB054C02198
	for <webhook@archiver.kernel.org>; Tue, 18 Feb 2025 08:56:49 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.47])
 by mx.groups.io with SMTP id smtpd.web11.15501.1739869000518261719
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Feb 2025 00:56:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FJp39ZV7;
 spf=pass (domain: siemens.com, ip: 40.107.241.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwQJxlcHSznsXaBdlDsJaYiZUFZPkZtVBaOWZifI+OIqRJRG4IEgGkA7qM4bUVyh3zzzDaxGLj1mHk0RCLBW0ZvOliPd1JAlAIA5D5ZbYtOtPhFUwGh9o8l4q4vtITgNuc3Lei0P8wLfDoyIxyAk59mfmU3cQeJtOBgwiii/TLwzEGJx4NI7+KVWPrfxaocqbXePmzRFIAbmw4a8Nnh6VNVRJTBBaNIxoNVEQNPfic9iB7ejM9wNMx6WxApMsI3GJG+Gq+ILKx5NKQw3wtdDL/1RFXHs5EHbpPq32B6QsZQvoW3Dxms15NcWCb49U+cJagt3MReZKFooDNlMQn4WDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkQe03go4qg6EUewMtoxSEM3il+Fv6JYUZW/nPb9YSw=;
 b=IdeZXoqqx48Qz14b5WM1wnkKm4df+2WoKKcgkUpeNp+SNzA8bWaHylgUE6s2cxHaS3vBdH3dB0O9TbkXCpJZENpZ7xldkqaRfd3QRiiEmYmoI6ZBsU3xMwp0HnXzkSpoROdAs5lyuMHQM9kUnp3A6Nyqmp2p/SJ7UrH5IcuY+4MIEhv7EpJVa/w3QfTsZF3fl70dULaoNf42A5ijgUXp+qUylNs6kU2CMg9ONyPNSZjSJSFjg823hOSeuwUMuwQD0EYUJCbMJikhSnUQfqZyRj7F6Mer9KzYiUpTwdvivOHhv43K/kqk/bydkrvCaN5KC4Thgli5MabNx2PfLH20eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkQe03go4qg6EUewMtoxSEM3il+Fv6JYUZW/nPb9YSw=;
 b=FJp39ZV7eVfqU8aRSiw4JJH8Etx2z0GzWKC7vzB2NPSjRAfQNYhlig2C05IwI7vyZrVt9ez2w6pBTCgp81pboA5BYBTWMXU0ubUfHyhWPN/nPNnyMGkV8C94Xg4psNCf93YjSnHwpZTEcpo2lFfbJmZKd/mMfG03FHC0pX14/4JTIXBoArSYUpF7pkxq5S44ZT4iBcKaQl7grds/Q/q+c5kgf6+ARbYSCdABtdwTkLYExxhInd4vyDk0v5qpm3xyf6/at4O9wlnzRnHonTM3qhNN4LGcEfXz4YroTYKfEmFRBdso5snIApjG+u0HbUBbj5+zE16i3jsQbapsGAlgcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3700.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:156::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 08:56:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.009; Tue, 18 Feb 2025
 08:56:36 +0000
Message-ID: <6e5288b2-8c6b-4b87-ae50-2763e3146bb4@siemens.com>
Date: Tue, 18 Feb 2025 09:56:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] crypt: do not assume that all
 system clocks are broken
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250214123930.701998-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250214123930.701998-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3700:EE_
X-MS-Office365-Filtering-Correlation-Id: ac21b4b7-b3b4-44ec-3169-08dd4ffa2697
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TitZd3cxT08vc1NBQStZb2N6ak9WWUF6bFpCZjBManpjRVFMZzEwQlF6TXpm?=
 =?utf-8?B?SkJ4WnFNKzlsemp0bU9aLzVyWlFQODcvOGFiSFQveFVTb3VWVUtIQUZ1Uk4x?=
 =?utf-8?B?eEd1ZUluVUk0VFFkVk9tZFI4TUEwK3FlL0lSN09Tb1VWY05zQzFSRDNrNmpl?=
 =?utf-8?B?bTZCMWdwZXlIWmFFeTF5Zkhoc0RidS93WWtFellNRTBxdDE3YnVpOUUzWlhC?=
 =?utf-8?B?N2xlM0hzWndqaWVPcTZINytPSTNVUitoREJVSlE1RHRwWUYwYjdFWm9FMXNG?=
 =?utf-8?B?MjVKL2xOQ1I2dGhRdnJPNlI3RVBTcjFKd2RQejVzbXV1WEpaL2ZZNWZhY1JE?=
 =?utf-8?B?TjN0SHJZUnhBeUVPWG0vRTg3MkhBT3R1ZzNDOTBqMkFicnppMU5CTDZTTi94?=
 =?utf-8?B?aVRCYlN2aWU1NjZubm45VlJwU3BvMS9uMkdrTW51V3djYnNWZEMyTHJ6UGwv?=
 =?utf-8?B?MGZ6Ry9FOVJkZU1MSXhOZHdmb2UvYzNWQzdKdnFPdks1KzMzeCtWL0g3VXp0?=
 =?utf-8?B?ZVh0eE11QkdCSnFGZVozTVc4YmxyUWR6Vk90aUFQNFc5WXVkZnJ0UUt0RFpM?=
 =?utf-8?B?MEpRQklpc296Rm5qQnlNZDQzeVF4ZVpPZGsxeDJIaXdnNEY4c3ppbjIvWjJM?=
 =?utf-8?B?OE53WHpQMzcvejVGdWowY1pRNVVQc3k0dzA2aDJ4Sk80MmVyb1hQOC9MNE5Y?=
 =?utf-8?B?YTdBWE5IeW1DVk95YkFyZVF6OG9mTjRRUFRySGRuRVRDRVY3M29jdWdHVXYy?=
 =?utf-8?B?Wko4WnV1MVB3b1NDK0dpaCs5d0lodGV1TU1uOVo2T3BKc2grMkdKS0QxS1kr?=
 =?utf-8?B?VjB4Sk0raG9tcGxrNXNOUEdZMGNnUWl5NTRBRGJhbUM2b05WMHJyYTNZT3BQ?=
 =?utf-8?B?cHVWV2l2TnBOSHZOZ2N6L0JqMjlLUDgydjQybnF4V1EyZXdoUkUzc3pGTU9Q?=
 =?utf-8?B?ZXJFams2NHJ3Y2drMmhkeGFOdVA1VDdMMW9JZ0xCdHZSVVNnMzdDdit5MGVW?=
 =?utf-8?B?eG5hZ3RQbkU1RnNhWnFFTE5GVlV1TWRFV2tWN3RYZ0U5cWZJMjlpREs2Nm5k?=
 =?utf-8?B?MWJRS2lLVTUyQldQQWNrZDQ2aDljVGdkQlVNcHcxUDFIaEpWcEZkbmxCZUh2?=
 =?utf-8?B?Y3c2UVJjMldpbG5ITDNhQnhmdnVveW1LVVBEbkU0MEMweVBZM3E1azByaW12?=
 =?utf-8?B?dTVFMVRxZEZaVEIzRk5XcmQ4WE9zcDRBYUlreUg5ZzQyMjhYcmxYalNHa2hT?=
 =?utf-8?B?U1NpMkZsUVB0d3NDN3I4d0t2NG1DdmtRMHZiQzd0cmRubXRPaWtaZmFIUGRF?=
 =?utf-8?B?S1o2cnNxQXJMRnl4L2JJejFISFZSaXM0UDNsRHA2dGxUTEoxOFdWaUwyOHNC?=
 =?utf-8?B?cWNwUlVjNzVQdHR5SGVEUVhOSnJabHRpMTlBaEpGS0J5aEhQOFhqTkRiaytl?=
 =?utf-8?B?Um80dzAyQmJmNmQ4Yk9SaXFkcVBGbk5uZERtVXpNM21kS292a0tpVHhNK2l1?=
 =?utf-8?B?dUdPbjJRZ09aUUdJZWY5SkFhNEgxWThqdURZeGZua0kwK3RCc0VPdzhwK3U5?=
 =?utf-8?B?NlZJZ2ZPd0dkK1BtQnFYQk11U0Zzb3ZUSVppZFVrelF2Yk5mKytQMlRjalo4?=
 =?utf-8?B?TEd6VUtNSTRFK2QwTzZqdkJzWTdsbjNKWkZsRVdXZEpvZUtMRitwaVh0YnFT?=
 =?utf-8?B?YlpUUTQ3RC93TmZEeHp6ajY2UzlESytXem1BRnJOa0d0T3FBVEY2eTFWV0o4?=
 =?utf-8?B?RFZhZWFaaWxwbUtuZE1mcmp0cjdLUVpGV1psUk5hcWlyTjdsU1B1bTNYbWcr?=
 =?utf-8?B?TFJIL0Z4dSsxUFNVekEvQytJclNjZ0lCT2VBLzlSR3ZOVlo5TzAwQzdOZ21x?=
 =?utf-8?Q?vWbj3AdOJDV4P?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VlkrNFViU0U1ajd3Tll4TVhNd2pOTE5OV0E4a2tBTkFKZUMwZXZMYlh3SzBi?=
 =?utf-8?B?MXBZdWNRNGpWV0R6bzl4Q0NXUEFkNXNRZncySWZHZ0hOeFY5K2FpUWRLbjlU?=
 =?utf-8?B?TC9hc1ZrU0prZFhkODR5OUJFeTlwSDY4MGF0ZkhVRlcrck42QURZQjg1MUgz?=
 =?utf-8?B?N21kZG9DVkZabHNodFcreVplYmdCMk1BZHNxY21XYnFaOEhMbnZnNU01RDd2?=
 =?utf-8?B?OERHMUxyRm5FNTFZbEJEL0tUYzl0S3dXVXJ0T0V4VG5rYXQwekMwMUc0OUx1?=
 =?utf-8?B?b2pIdFN1MU1LclFzQlRMWW5TNmd1OVdvV3ZFTUliaVNYYjY2VmVoKzhZOFhs?=
 =?utf-8?B?L1RDdTE1WkhKc1g4OHFya00yK21PQzBSNEZqUlBLaWxlb2ZtMjRGRmNZY3FR?=
 =?utf-8?B?WXNwdTdpRWxCMGVFRzBHa2RKU21HT1B6S1d0dXB3N0VXdzRnVUtNSW5ld2VD?=
 =?utf-8?B?Q1hJZlp4dWxrNUlYaWZUbmQ1SHJuTHRBM1ZmNHhkOCsrcXRyekZ1d24vMXdr?=
 =?utf-8?B?dmw1SmIzdzdhZENJV0IwTDV1ejd1VlR5cXdtZ2I4aFExc0FZK3BFTDVPQlBu?=
 =?utf-8?B?RUIrN25lQ2lJUWZVb1RpaFNHdlAvN3A2Nm5ldDh1MkdpbXlxUklVVGsraVp3?=
 =?utf-8?B?SEZGSzJqUjdiWWhIQVE4c2dlVXdrMnYrdTUxT0N2TjhYTTJETTY3b2h1Z2xL?=
 =?utf-8?B?c2piY2s5VXlxN0hXNVBIcHA2SEZ2R3o0R083Z2F0UW5rSVFBWnlQOEd2U3BN?=
 =?utf-8?B?TDlkaFNvNjA1ZXdnUkl6MWJET1BNQTFqNm96WU9jOUIwdVM0K0kxY3RlUUh2?=
 =?utf-8?B?THFKSDZYSmdyc0I3TnVZdVpFam1vVVBzSktDaGNQVUhsMEkzc0d2VnZHdUpY?=
 =?utf-8?B?bFNvLzNoK0h4NitKaHdoLy96a1RMM1g2b29pVkdpRWpkZEx0YXNwUEM0NWJB?=
 =?utf-8?B?RDNadUw5QlMvSmppdCtCdzJIOHN6dW9lUjBCMWdZU25zTGtyNzYwZk5tNkEr?=
 =?utf-8?B?ZEpEaWFaVkZMSDJEQ0hnSXl0ZmdyM3NSa2hMNkwyUlBSR01SeEFLSWx5MUpm?=
 =?utf-8?B?dW1oTXVjTHZhQTVjVm5saU9pNEhHbmxWLzhOWDA2WWRGczBwQy9iMmsybFQ3?=
 =?utf-8?B?WHZiT1JsSk81NXlYUlYyVkRFem4vcWEyakd1K3c5biswMWZOdklEOW1RSjFF?=
 =?utf-8?B?cG1tVWFyb3E2aGZzVGpVZWhHcFNmWDUwYStWY1R4ZlpuR21YSkRNMUFqYldZ?=
 =?utf-8?B?M240QmpYLzVCcmM5aHhaQU1CUllVVEwwWE1hRkZpNnRGSGFEU1FzSVZ6S2Ny?=
 =?utf-8?B?RjVBTGxRc2F5RnNzemJQeTFDeFVzRUZ2M1FLcDV3WTRzaUpTb05DWUtrWXU2?=
 =?utf-8?B?WXgvc1QwTlR0ZEdRdWlXL1BaTDZvaHk5NElnODIxVU1mSEZCY3BYOWlhcG55?=
 =?utf-8?B?RE4xNHY3TDNIRFhra2JNNG4yYTh5RG14MWFXQzc5akgwS1Bqb3RYbGoyYnVj?=
 =?utf-8?B?WnplTTEwV3VDZllRWFBkamgyV3ZuWHZkalhpZmJaWDhtZ2I2VGtoOW5Pdjg5?=
 =?utf-8?B?MnJhOXM1eXB2THh1c1QrSXZqZ0NWUzFGSnJVWitGcm02dGhjOWVvaHc0L0NK?=
 =?utf-8?B?VXRNRG5EemRVWGxOUThrZEN6K2Q5a3EzOHNiUVRRVlZrUE8xOWhyMUwxRlpv?=
 =?utf-8?B?cGtnTmRCTU9RZ1grOS8zU1poUmlvQ1FxdGFzZEtBMWNQSEpVb3hJN0o2Zy9l?=
 =?utf-8?B?VEtObUFOdzlCRHN1ZnkvYWMxOEdQUyttZTVTbDFlVUhjSC9qdHEwbTc1SWR3?=
 =?utf-8?B?N1BLS3VnQW9TeGFMTGp1ejFGRDVENnJCR0F5NkNDTWNkaGxvN1VNL0xnVVdJ?=
 =?utf-8?B?QXBqWkFteHZoRi9SQVkzWTBLbXVtY2NLYVB6VnlaNlRFc3FRaCtBQmJUZEFx?=
 =?utf-8?B?cnh2YUJQZWVhVEEvb3NaeEh0OUFXUDlWMlZBZ1lkcjMvMmlpVitldC9PLzRV?=
 =?utf-8?B?bFVJZzNzSlBRbFMwY2xPMGt2ZE0wQUdmM0pYWE1Vb2dacEh3VjRpUG5UZVRy?=
 =?utf-8?B?elhZeUJSa25pL0VRbllTWUtuTlgyVHRrbWpKVU9QSXluNVR1WkZYWmg0T1kv?=
 =?utf-8?B?VSttclcveXR0bzhxOUM2anNwSkVGZWowQVVhRkxjVjlTbDRLcStrcEI1dGY0?=
 =?utf-8?B?SXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac21b4b7-b3b4-44ec-3169-08dd4ffa2697
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 08:56:36.6092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xpjY+ralpuEIHbNUOrOXxC7z8A2ZWbACE4+5VUsdYBaX0hl18HH615esr6srLsxBw8L60yBIQS2jmSFdZXJvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3700
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Feb 2025 08:56:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17861

On 14.02.25 13:33, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> If a system has the following characteristics:
> - An unbuffered system clock which starts in the
> past (e.g. 01-01-2024)
> - The last disk write/mount is after that date(e.g.
> 01-01-2025)
> - The option broken_system_clock is set for e2fsck
> 
> A subsequent call of `resize2fs` will always fail
> as resize2fs will check if the date of the last check
> is after the date of the last mount.
> 
> The e2fsck option `-p`(prune) fixes most of these time issues and the
> broken_system_clock option is not necessary on most systems.

Ok, but now you are contradicting yourself from 045abe8527d6. Please
sort out what we really want under which boundary conditions.

> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> The alternative is to delete the setting of e2fsck option or use
> `resizefs --force`. The latter fix has the issue that the force option will
> also disable the disk size checks
> 
>  .../initramfs-crypt-hook/files/encrypt_partition.env.tmpl   | 1 +
>  .../initramfs-crypt-hook/files/local-top-complete           | 6 ++++--
>  ...tramfs-crypt-hook_0.6.bb => initramfs-crypt-hook_0.7.bb} | 3 +++
>  3 files changed, 8 insertions(+), 2 deletions(-)
>  rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.6.bb => initramfs-crypt-hook_0.7.bb} (97%)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> index bb93361..3c5c4c7 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> @@ -5,3 +5,4 @@ WATCHDOG_DEV="${INITRAMFS_WATCHDOG_DEVICE}"
>  HASH_TYPE="${CRYPT_HASH_TYPE}"
>  KEY_ALGORITHM="${CRYPT_KEY_ALGORITHM}"
>  ENCRYPTION_IS_OPTIONAL="${CRYPT_ENCRYPTION_OPTIONAL}"
> +CRYPT_BROKEN_SYSTEM_CLOCK="${CRYPT_BROKEN_SYSTEM_CLOCK}"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 54b8a6e..bb720c7 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -75,11 +75,13 @@ reencrypt_existing_partition() {
>  	case $partition_fstype in
>  	ext*)
>  		# reduce the filesystem and partition by 32M to fit the LUKS header
> -		export E2FSCK_CONFIG=/tmp/e2fsck.conf
> -		cat > "$E2FSCK_CONFIG" << EOF
> +		if [ "$CRYPT_BROKEN_SYSTEM_CLOCK" != "0" ]; then
> +			export E2FSCK_CONFIG=/tmp/e2fsck.conf
> +			cat > "$E2FSCK_CONFIG" << EOF
>  [options]
>  	broken_system_clock=true
>  EOF
> +		fi
>  		e2fsck -p -f "$1"
>  		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
>  			panic "reencryption of partition $1 cannot continue - resizing of the partition failed!"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
> similarity index 97%
> rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
> rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
> index df335c9..ec2d6bc 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
> @@ -85,6 +85,9 @@ CRYPT_ENCRYPTION_OPTIONAL ??= "false"
>  # add support for btrfs encryption
>  CRYPT_BTRFS_SUPPORT ??= "0"
>  
> +## do assume the system clock is broken for partition check

"whether to assume..."

> +CRYPT_BROKEN_SYSTEM_CLOCK ??= "0"
> +
>  TEMPLATE_VARS += "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
>      CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
>      CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL"

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


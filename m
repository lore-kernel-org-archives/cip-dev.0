Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E06DC369C2
	for <webhook@archiver.kernel.org>; Wed, 16 Apr 2025 11:43:14 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.86])
 by mx.groups.io with SMTP id smtpd.web10.17125.1744803785269597456
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Apr 2025 04:43:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Wb3udACV;
 spf=pass (domain: siemens.com, ip: 40.107.247.86, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UG+26tarK5XXga5lv6aznHgewLnhX5nLLsEJqiGV1Gt++R0wjBU9cwY2814Vb8IKDIVlszw4jZOkHWENlJcRaTVWpyIusnvDkXB42py+zHmtGNvOo7iHxigMlUtxL+UHR2GcEq2hdZG5V/t67VjBDQtw49KAuFoiAY/ZxJlUwwd7Begtnbf2CtHvcgD/V4vmtf4mYT/qpSEjJDxfT1WtVt47SKfw1tiOplct6ffM2TW5K63yQ6ejzqRSDKBtvaEfqA590sQHkZ+xatgntpE3rL5NyT61KXhKVAm/wLcieJFUh1L7DO82QJAUBZWbeMK48gSpZ08B6vDXgjLetcq3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sTVH2PPvHRuS99Y0ek5fa66wse/sG5xbe0FSIfS2mU=;
 b=Qlnrpg4j0+5iAb8M6GZxsobLxOs8qr9k4lyhZ3JmD3S06GlVc69T0e126nLjWCnuihECEZpIBVkPfy9EqZHFMUPkuHF9MjoEhY36KKjsFP47ATNLKkBxreI23Af1eq1AX7yIe6ElT2dmUqY+mMUr5wPJMz+ISYMPK7gOFPi9G6ucluRz1rpQqOnhwnhRdauDanJIm9nMPNx8kPQuDm9k9gygFAbV5uJNu3ICu9yDO1teCRThMlbmrnprK2aaDocpIGl5PlmnBoSZGLqKnzlZRxqX1IMEIXMuwVkhLdcbUbt2Jl00V9y0kzepfdpFrXZPX6yKTNV+iMV7o+dKfss0qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sTVH2PPvHRuS99Y0ek5fa66wse/sG5xbe0FSIfS2mU=;
 b=Wb3udACV9jdM1O+9TQGo7OUGI08VK9XIqXNjTmsTNxyrTdhVsczx9lDWyCCHamvJhWRObJybxbcG0UokH4232AqvOhwv+bBTlXS1VFwRHKprNZNXmbiy/Fq9giza4sh6t48bLopnENByKSwL4DFCfjkTaHcNxFdBolMnSBqQSkOFpWYrl+x6ziuby3i5uNjtKxgPjC/1A5kWdX8ybU8/gwWo5Xb7/aZZ/ZUUmqZetJ7lg3ti+DJNriWhDFrkbtAN9xF1DjuoC0uvu9nwHGXMZWA/p4NzL3eywINVEg4gpi++AmmNICI8srpcRh0D4WIQYcC3q7z/1aYEa+jL5ASqEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6544.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 16 Apr
 2025 11:43:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 11:43:01 +0000
Message-ID: <8223985a-2d89-4ea1-8b95-e4d8f946fef0@siemens.com>
Date: Wed, 16 Apr 2025 13:43:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v2 1/2] .gitlab-ci.yml: Set timeout value to run
 IEC layer tests for different targets.
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250416105102.2657705-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
In-Reply-To: <20250416105102.2657705-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e352939-ac61-48f5-47d4-08dd7cdbd7c4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y2xzYXFQYUdLeUpXRTdhNzQ4Y1JsMTcrOXNZV0RsVmpLNlJYMDBIcUlYQWtK?=
 =?utf-8?B?Q1dONmM5NXJLZFBKWm5WQkpid2RsZTZxM2hBUXRkeTV5RFBDYk9sRmJUOHRC?=
 =?utf-8?B?Kzd4cHF1d0JLRjJ6ZVlMRjZOOWhXSUE4cjdZNDI2Mm1vY1FsY3pKS2NNVUVH?=
 =?utf-8?B?L0JDeElDN2xUbVp5NUVlS0xXcUhTTzMrNjRmV0cwY25tM2ZxaGlnTEkySlg1?=
 =?utf-8?B?ZU9ENG5qNFFrWU5yby9sWDRMcGZVSVlubTNUdldNMDY0TWdhN2luT21VK1ox?=
 =?utf-8?B?dFRJQzMzWjlqSUhnWEpRNCtMejQwYXhjMEZRd1l2MHUvbzdlTDdOd3VNdUlp?=
 =?utf-8?B?TXArYjRZQndsS25SUTVnNE9SSFJNNzhWaW12NGN4K1Zua0RvNHZGZi9xYkJr?=
 =?utf-8?B?Y08wekY0NXJHSXlWWUt6YU5ENm9GN0x0ZDJWRUNmV3N6NnkyT2l3WllLNkpj?=
 =?utf-8?B?NUlZY1NlZnlYS2sxQ1RpNWJjekxBTVBWeTYxaHk5UzlvbXB3MTBndzBUTnox?=
 =?utf-8?B?THJNeWFzS25QQkJUTmo2cmhkVm1SaFIzWW14dFhFUWtRcGlFbXpTRjRWbUU0?=
 =?utf-8?B?VzhqeFg3d0s4Y0dFMVFyYzJnYTZMWlRlaEFQWVcrRldxaE92SnpMUjd6b1pD?=
 =?utf-8?B?QWVKcGRLeUk2RkR5ZGsrSWRtSVQ5OHpFYWlDTkh2bW9WOGpES2pLZ0RxT2p0?=
 =?utf-8?B?RUJ0YWFFTGJEelJhYWdER1dNZTNmaUlWc09JZTBwbXZ1emd4MmVhTE9VQkVV?=
 =?utf-8?B?d25BOVFHYXRCbklReFVHdzhTeW1vSTRQZVVCeXdMTmJFTzNqZUVsU0xIamhJ?=
 =?utf-8?B?WE1xMVBOdy9WS1FUQVVmUnJrcUoyTDR0ME1CZFFCeG5MUlRHSjVXQk1MWENE?=
 =?utf-8?B?VzZuSUREcEdlQnVpTkh1R1ZZa2RaWGl2eFlib2d3V0VFM2FvVVFYbnpqNytK?=
 =?utf-8?B?cFNEVjl1cVN2akE1OE5QbFBEdFV3bEpCT3JVWXhYMkdDUDJYWVJsUVZicGNF?=
 =?utf-8?B?ejI5R2hjajNPWTUxaUYzK1lzRVEwRmp2aU13NFFoNTZTMXVYRHlRcDM1N3lq?=
 =?utf-8?B?UXBwQTcwSG9YRHZ0VWFuNUp2R0wzMTk4R3JRTTEwYWJwMXZtL0M0Qzc4M0JY?=
 =?utf-8?B?SUM5bmtmVW1FUURIL0lhMlh0KzF2d2JqclcyOWZXZER1YmxxMUtIcHcyTGFl?=
 =?utf-8?B?eVBFSWJwaGpaZEJBWXZHak43WHR0SXNsc1Bhb3QvZ2hqa0hlSWZJN1hNeG1M?=
 =?utf-8?B?VzlGTFNrYjlxeSt1QjNRMkpzdHoyd3QrUjZEU2RUOUJFVlR2L0t0MkhTcTJz?=
 =?utf-8?B?WlE2cHBuNlEvN3ZrNjFLQVd0cjhKSjdGbEJ5NSsrTzc1Q2c1bGF5ZlBuaERQ?=
 =?utf-8?B?bTJYTU9TTzgyQnNCMXVNYmVQNHFOekRnVERpSVZzQWhJUlE4Z2dSVkMrS0tZ?=
 =?utf-8?B?KzN3QXpWZkkxZTlvNFhXSmFkVUpNRTNjcCtDcEp0T1Zkc0dmang2eUFOamtF?=
 =?utf-8?B?aXdVSHpXSDVUYUl4OG5mU2lKMHpnR3RvWDJyaWV0ODA3TjdXK05ZalVaa0F1?=
 =?utf-8?B?VmwvNkswQWpmRDZDdzVXR0lKRnh4Mmx6NUFTNWpBbDNCYmIrSVRFcm8xam40?=
 =?utf-8?B?Q2VOdjloQXlXUkhEVlVlbkdyZ01vb3FSQ2ZrN2xXTXpwU28rOVdjcGZreWs2?=
 =?utf-8?B?MWpnUnZpZWxWMUQxQ3RSRmsrckk0UWlZY1dzbS9RcEhEdmhadHUzVnlxYlV5?=
 =?utf-8?B?eU5HKzJwYlF0UTRXSllEQ0p2RUZ4SWwzUitxTG5oLzNNWFBEdStZU2lzNlVT?=
 =?utf-8?B?bllUS0hndUlQeTgxUVNEOVlUK2Q3bWV3NlV1R0Q3ajhWaDBGU3ltM1VwVUE4?=
 =?utf-8?B?Z1gyQTRkOGt5aml3b1FQWTNQMEhqWFNUZHVIT1BTd0Z4WnlXTkZhMXJnbkor?=
 =?utf-8?Q?L0lrBEZwGMk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bkRPSVZiaWtNNnlyanE3NVphNUY1WkhUWWZqZEs5RnMxYW5Td09uV01Yc3pZ?=
 =?utf-8?B?ZktYZnl4ejVHL2FsOUhnV0MrWXFCdU1CUmhETTd3aFd4QTFyTjl4aWdHUUhR?=
 =?utf-8?B?dldYU3dDVDMwWlltOUczYUZrVFZMalMwdjRRNWlFd29WRmtUUE1XOVRqUDJF?=
 =?utf-8?B?eUVZUVJEWHJuaHJNVE5CUEc2WUQ4dG5kZlBPdEF5K01tODN3MXpaSXVBWkFZ?=
 =?utf-8?B?ekFldjQwL2srS3AxTTR5YkE0VVRxMWl1anFLVHk1b0V5bi9TZGZEVWhteC8x?=
 =?utf-8?B?a25ZYXl5YnVEMXdlSDVWOForbklTdDRtUjZmUVV3WVQrVFBucEo3WHhmVXRt?=
 =?utf-8?B?WVN2RlZYZHdHNEtnanlZRHpXMFFrM3NlU0x0bWpTM29ndTMxMWhxbDJScnNt?=
 =?utf-8?B?MGs3bmR2ZEdiRVQzc0MxZno2WUhwMkgvUWRRbDVlRWhPWWZubnRtTlNoc2ow?=
 =?utf-8?B?TmluaVVJVmU1Mld5WmhQY01paDgzWTZhRWtxOXpCRHdkTFRQdER6aFZnM1Az?=
 =?utf-8?B?TlZDZzNlWjMwSXR5R3NiYXhDUnJPajZScy9ZR2dDK2tqSWp1N0xmR3JDM3Jr?=
 =?utf-8?B?NWhXRlUxRUgxRFRLVzFJSTRhR1JKTHVreFFUd2JMbEJtNEhLUmV3Zmg3cHpl?=
 =?utf-8?B?OExoR2h6cnA4aElOVTZnOXBUam9NVUZoV3Uzdk55Zlh5VmtIOFZBRlpXZklh?=
 =?utf-8?B?WlQvakFFdmpoRGNZTVRKMHFZK3d4K2dIcmRUUVpZcGRWVmpUM0xkbWFVckg4?=
 =?utf-8?B?cjRNSnRsb05PMUg2WHBQak5vaGg5bjdiNjJ3UC9Cd0ZlZEg3UmFWWjFQNTBF?=
 =?utf-8?B?ZlpKb2NTSGRHM284MXNSaDlJME5iSDFiaGxEdEpnV3JyR3dKRWZVMEJJT2p4?=
 =?utf-8?B?UlJKWGk1cjRzWU9jbE56YVVXUHJubkdtdzEwNDJ4cGxhU0pFMU8xSFEvTDN2?=
 =?utf-8?B?WEE2dmMxTnpucVpycGUxTklhRDZPdkRHbFIvU2JTTmo1YTcvTCsxWU1LNjJI?=
 =?utf-8?B?WVdON1M0WU1iaERnYjBLelp2YnJ0ejZ6dFFQS1dESEZsZU84aVBRTjRQZWRl?=
 =?utf-8?B?Zk95RDR6VDRXZEpDWWxFeWVyalUxNjRPTTJ3Z0JlN1RHWUh5L1F3QkdVclNp?=
 =?utf-8?B?M1dwUm5WQ3VQTndveHlwM1VtSFFWMnAvVy9KZXplZGZnUTJ5NUdGT1Y3TWNW?=
 =?utf-8?B?VC9NK3MrY0VhKzcxRlB0ZlNrRFkreE1vYjMwMVZQRTZxR1puRkx0UDc0b3Bs?=
 =?utf-8?B?RVhhVVJlSHFTVnhZcENUb1RqTGxEc2N4QlhYc3k1VzRHSEkxYXRTNVg1Q1Nl?=
 =?utf-8?B?OTlUN1lnbTBTRHgzVkNKaE1MVzduUjhVWEJVZm81cjBMSGV3S1N6WVgwSkQw?=
 =?utf-8?B?SFhkblZ0YUxQekZpWWYxRXpINWk5TWdFQURCanJydWRoRjRBMzRTcUd3TXVt?=
 =?utf-8?B?T1U3SDh2Y0htL3p2dTBlaXdSRXNGQUZLRFFvZnFoekJvTnFSNXViTDdRcHZS?=
 =?utf-8?B?RkZUeGtvekxVZzRNL3dpQWhNYkVyZUhtM1Y4YlNLSWs2Y1dZcDdxMFBOYS9s?=
 =?utf-8?B?VklYTEd4YzRpbVBhVnFZbm0reUpIYjdwM0xISk8rZU9WdFJQbVRuU1laWW5i?=
 =?utf-8?B?VmNoUW9DZFFPVXdhT0k4N3JrSnZaT2xpNXpRT0VKV1JTUDJtMC90ZzVUSGZh?=
 =?utf-8?B?djNDbi94S3QwTExBdEgrSW1wdXk0UXlGdHVYa2VRdWdJcjUyUjhKLy8zVW15?=
 =?utf-8?B?bDJGcFBzeDhSWHRZV1lQdjBvQllrMmQrS0F4UVdrWUV6cUpZQlltU2lQS25X?=
 =?utf-8?B?QWUvRWVrVWhLSWsrN1VPOHh1WnVOc3pXdmJDWklyNDNLL0gvcGN2QmlBZkNz?=
 =?utf-8?B?KzVSazlIcW8rdi9ZWVJSYVlWaXA0ei9JRXViR1hkdWpkNGdQNElPQlJGcGl1?=
 =?utf-8?B?ZkprT1lVWVo5RVhvMzVQbHM4VUVTbUtSVmNrK3Y0dllKT0psY05yVDR4Tktn?=
 =?utf-8?B?UEJkL3RTYlQ2NkNDd0RLRnE3ODZOeS9IQzhvL1NnNm9TZUw0RVRhdDVOM1JH?=
 =?utf-8?B?aWJ1UGFHZytOWU1uSjArSEx6QU9wTVY0QTBRbGxXK0FjMW5SQzByYzNZdjBN?=
 =?utf-8?Q?NY3xgVkqLk1TNLda76wfJkrsJ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e352939-ac61-48f5-47d4-08dd7cdbd7c4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:43:01.7235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SB+Hb6PVZupNBXJSof6ib7/WGmakwMZDoWDplm/CHfJnwRVQSbSAgWsNeyjF2B6nMEbf/uSPcAtGZxmaxSRmYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6544
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Apr 2025 11:43:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18510

On 16.04.25 12:51, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  .gitlab-ci.yml                   | 6 +++++-
>  scripts/submit_lava.sh           | 3 +++
>  tests/templates/IEC_template.yml | 2 +-
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 146eb33..2c1deaa 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -334,7 +334,7 @@ build:qemu-riscv64:
>    tags:
>      - small
>    script:
> -    - scripts/submit_lava.sh ${test_function} ${target} ${CI_COMMIT_SHORT_SHA} ${release} ${CI_COMMIT_REF_SLUG}
> +    - scripts/submit_lava.sh ${test_function} ${target} ${CI_COMMIT_SHORT_SHA} ${release} ${CI_COMMIT_REF_SLUG} ${iec_test_timeout}
>    artifacts:
>      name: "$CI_JOB_NAME"
>      when: always
> @@ -431,6 +431,7 @@ test:qemu-amd64-IEC:
>    variables:
>      target: qemu-amd64
>      test_function: IEC
> +    iec_test_timeout: 40
>  
>  test:qemu-arm64-IEC:
>    extends:
> @@ -439,6 +440,7 @@ test:qemu-arm64-IEC:
>    variables:
>      target: qemu-arm64
>      test_function: IEC
> +    iec_test_timeout: 40
>  
>  test:qemu-arm-IEC:
>    extends:
> @@ -447,6 +449,7 @@ test:qemu-arm-IEC:
>    variables:
>      target: qemu-arm
>      test_function: IEC
> +    iec_test_timeout: 40
>  
>  test:x86-uefi-IEC:
>    extends:
> @@ -455,6 +458,7 @@ test:x86-uefi-IEC:
>    variables:
>      target: x86-uefi
>      test_function: IEC
> +    iec_test_timeout: 60
>  
>  test:qemu-amd64-secure-boot-unsigned-kernel:
>    extends:
> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
> index 9da083a..e531c55 100755
> --- a/scripts/submit_lava.sh
> +++ b/scripts/submit_lava.sh
> @@ -24,6 +24,7 @@ TARGET=$2
>  COMMIT_REF=$3
>  RELEASE=$4
>  COMMIT_BRANCH=$5
> +IEC_TEST_TIMEOUT=$6
>  
>  if [ -z "$SUBMIT_ONLY" ]; then SUBMIT_ONLY=false; fi
>  
> @@ -55,6 +56,7 @@ add_firmware_artifacts () {
>  create_job_qemu () {
>  	if [ "$1" = "IEC" ]; then
>  		cp $LAVA_TEMPLATES/IEC_template.yml "${job_dir}/${1}_${2}.yml"
> +		sed -i "s@#iec-tests-timeout#@"${IEC_TEST_TIMEOUT}"@g" "${job_dir}"/*.yml

You are still not using the environment for passing IEC_TEST_TIMEOUT -
why not?

Jan

>  
>  	elif [ "$1" = "swupdate" ]; then
>  		cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}/${1}_${2}.yml"
> @@ -163,6 +165,7 @@ create_job_mcom () {
>  	cp $LAVA_TEMPLATES/M-COM-x86.yml "${job_dir}/${1}_${2}.yml"
>  	if [ "$1" = "IEC" ]; then
>  		grep -A 9 "# TEST_BLOCK" "$LAVA_TEMPLATES/$1_template.yml" >> "${job_dir}/${1}_${2}.yml"
> +		sed -i "s@#iec-tests-timeout#@"${IEC_TEST_TIMEOUT}"@g" "${job_dir}"/*.yml
>  	elif [ "$1" = "secure-boot" ]; then
>  		grep -A 1 "parameters" "$LAVA_TEMPLATES/secureboot_template.yml" >> "${job_dir}/${1}_${2}.yml"
>  	else
> diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
> index 92944da..1c3eacf 100644
> --- a/tests/templates/IEC_template.yml
> +++ b/tests/templates/IEC_template.yml
> @@ -60,7 +60,7 @@ actions:
>  # TEST_BLOCK
>  - test:
>       timeout:
> -       minutes: 40
> +       minutes: #iec-tests-timeout#
>       definitions:
>       - repository: https://gitlab.com/cip-project/cip-testing/cip-security-tests.git
>         from: git


-- 
Siemens AG, Foundational Technologies
Linux Expert Center


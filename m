Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C503C87FCB
	for <webhook@archiver.kernel.org>; Tue,  5 Aug 2025 09:02:04 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.45])
 by mx.groups.io with SMTP id smtpd.web11.17270.1754384514109761179
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Aug 2025 02:01:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mPsM7qIl;
 spf=pass (domain: siemens.com, ip: 52.101.72.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNcQnuQ6EvvagEKMO/Op0VEM46Xr58B8Y+kwfDEiH50YXswg6jp2W0ibBTCFOJ7llztXzfFTnofz3+P2lqphSxkVAI7nTrkDXXGetfo7SmpZqGbSEtCya0UuixugwLaaptN2HUj3cOw4EZ3bYvzolvKL0nfD6OJB8TMmE2bC3anX4wQbqcSzHRY2Tx2DwbAjEJGvJxgkLWs9lrNPBRWgHlTCgKZd9+xkPZM5ZlrNj5yCKkviylwdGCX19Rrhc0Ff73s91Mut2o21zTywszxUE0O5tAYO0Ms1S20ba9VdJ3IDCzUJzHAmwJw6f4BiuHhKiBuJyxfTiaWCKZKgBXlXmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXiGp2jtl4xSJJardg2GFNSsp5EL5ZEFJ4anjGe5H4E=;
 b=VBWnWxvBR4/HPca/kn0Jv4+5AEunQObz2ZMZ3EkU7OEkhu1mFeHvJOZdlv/JoMNuPD254ktmftogTTO7nBwwatJW/fj1CP+GUaBSizsmOMmwUXPM3dDbCe705I3tsSmDQ3iRMnLUGtUkt7+YveT86D3K9YdKlk8YN5AyHTxIMioy141c6EwwLjZbnvIQj/gtNCK1ozfrcggs+KaiIJo1rHXbpzecW9l5/yTj2pGPiDbsYe/U7I0gsOi4GlPVf//r2sfWOqZ9vcr8ePvjtKq9SvVdwsAWGiUf9h3HdrMsilDZQS7RC/GiwiTSZTGBscNJ372H8BuZmwLfHnQ8zEAe3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXiGp2jtl4xSJJardg2GFNSsp5EL5ZEFJ4anjGe5H4E=;
 b=mPsM7qIlY0WqylIwtJ4qdAsoayaKZpQibizkgsfKtYDYB7CyClMoTO5ePdlyEkYqZY4hl2/x6LxdB0eJnHg+9sMCVmSlNv31162vYKEkL35ZYPGIR7tHICRtGt4exCZlfHy6pjgisBqpWWgpQyYCrLIVCv8oT/gWyL1/UIt9SAkXOanbxt0TWVS7CLG2Adm/TKmvzoJ3rEtG/ODV1FPBb+ACF+dwvQP+BdZMNEPyuPrnUekPQHNXC2AScudIVnHZweK5awD2+zDrODMe/T2RE0ELHm0UFTHyBPizK0TGxJeM/FDf3LkojJCLmzyqDAAhxLsdX5I0cvbx+nkaqsrdrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8694.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:214::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 09:01:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 09:01:50 +0000
Message-ID: <5e015ea3-6300-4a5b-9bba-b4fb5b52896f@siemens.com>
Date: Tue, 5 Aug 2025 11:01:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 5/5] zynqmp-zcu102: add
 README.zynqmp-zcu102
To: Hirotaka Motai <hirotaka.motai@miraclelinux.com>,
 cip-dev@lists.cip-project.org
References: <20250718100926.3151777-1-hirotaka.motai@miraclelinux.com>
 <20250718100926.3151777-6-hirotaka.motai@miraclelinux.com>
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
In-Reply-To: <20250718100926.3151777-6-hirotaka.motai@miraclelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: c8efaa94-8fc4-4f80-bbc7-08ddd3feb6e4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RHZGdlpxRG9ORXNEd3V5TTdQTTlCUXMzdWlaRURnZkw1T0tNV1EybEJzTGsx?=
 =?utf-8?B?VmRtL1Q5NE9kN0JwV2VYOWVyaGtMbXBmUDQ0TTFhQllSbEFwMmU5QjJiMXhC?=
 =?utf-8?B?UVZNb1pxVEI1aFFVbmJ5VVpBeUExZ1ErZ0RBVHdhN2JaeURqZllBU3R6NCtq?=
 =?utf-8?B?TVV6T21GR3FPTnJwNlRUc2p3TjlqVnI5bWJrTjhsUm1Wc3VIYjg5bTgyLzZy?=
 =?utf-8?B?Q2J0MDM5dWVKL3EvUHdNRCt4a21QVEhHOTN3SzRRSENVU2d2bnFlaUQ0K1lt?=
 =?utf-8?B?SS9IWU8xZm1rOUwzdUJpUmliSTh5WUhkRC9mejIzNW93c0hpWHhDMVBXME9U?=
 =?utf-8?B?NzdMNW00OGZ3SmVXT1A2SndTbElOY2tjZUtObURFQzVYclF6VHFJcWFRSUMy?=
 =?utf-8?B?dkFYTWVZVXZtTmg3VmdGK1djS1RjMWx1NTMrdnhWcUp3RFBBWGJ4Q0Izbnpr?=
 =?utf-8?B?RENGUjZmTVdPN3RQSkEyNUVjaEFreTVHcDF5bnZJY3g1UE40aVNMODd6aFdi?=
 =?utf-8?B?bGEwTTZ6TFV2d3RtazlRYmdEZThYdXIzbWJWZGVvSGpzOFRxampuak1lc2l5?=
 =?utf-8?B?UE1SYTZ6TTZPZFIzKy9OdnJqZkdvZmxHTGJ3cTVoRDJqOVV2ekp6WEcyRjJ3?=
 =?utf-8?B?SE5jU3pSb1JlNFQzeG9VTGJaMmoxdDNSa2UvbzRzaFp1Unc1cWdHd0tTNHRN?=
 =?utf-8?B?S2xGQ2tMZ3RGRUdTdW8xd2s5YVA1MlJiNmFWYm1qeEJDT3ZubFYyelFhYWZy?=
 =?utf-8?B?K3Vnek9xSDh1SzJpNkk2UkNVU3JJMGZnbk9PYW1adlJOZWF4UnExMXNQRU9w?=
 =?utf-8?B?S1dCY1VYaXNhdHp4MEZYZUJUT2tzNWRNTFlGcGdWN0FwTnc5TGt6VFM4UXpv?=
 =?utf-8?B?SUxXTy9uM3Y2aU9MNTVOY2R2d1M3MU9XTTBDZ1JvYWZ2YTFBSXREOGQ2WEhV?=
 =?utf-8?B?bVNFajFsV2Z4NW1yaHR4M1o1YTlMQUtPY3B2bmZaMngvWTNiMHpGeFcrTnV0?=
 =?utf-8?B?MWpVVEZVWjJqak4zS3BUTjN3M0NKK1dUNXRCK25rdncrQklReURFL2IyNE4x?=
 =?utf-8?B?T041eHYwRFFsZUlPZjJZZUVsZ3I0NzladWlzV3l0cHNyK0FpakpNZnJTRkZq?=
 =?utf-8?B?TGVIRWtpQXIycDhucW1oMURlSU1Jd251dGtMVGE5UlBtUUNIb1pVQW1kSlZU?=
 =?utf-8?B?enZRNkNtQWl4UWIyd3JVdjUyU3lQTDRLa0o1ZVY0RjBQY0lieG4vNHI0VXhn?=
 =?utf-8?B?TkZsTmQvQWJLWGJSM1ZPZVFlNnJRSnZaTzhQSlBTZHdlMlRxUW1FeTNNN2VP?=
 =?utf-8?B?UE9tWEpnMXUrdk9mUUJwRHBXajNHYlN1Q3A1QU5mYUZrRkdKazBDVlhQMkJz?=
 =?utf-8?B?ZERIQUp5aHhNNFBrTUJGZUJ3b0xnUWJaMXhFd21rQTRaK3huamJRa3BSMWNS?=
 =?utf-8?B?MlFvc3ZPWEtXN3oxbThhRGk4cDd0RlFvRGg0TmhlSHI2QzZPK1hWTTZ0U2Rv?=
 =?utf-8?B?ZEU4RTI3S0Nrb1VhcGZtUitLcEtKYnh5RENEZlY4U0diVCsxRndoSlIvN29J?=
 =?utf-8?B?bmpBZlhJMW5LQXF3bU12NVIzdzk2bkhRb2dlRFNUUzh2VVNKTDFDazdPUnRW?=
 =?utf-8?B?QVJxUHVRa1kycCtzZUwybVlmRUJuOXNhamZxckdKeUNZaGhCR1U5OXVIQ2Nh?=
 =?utf-8?B?ZER3N1NLbE1DaDBNeHJVNGRidno4UVIwd0R1eGMwN3RIKy9iTDBlNEpIN1hB?=
 =?utf-8?B?VVZLUndncXpjU1FvWXNCa09OK1J5ZU05ckw1RnJqK0VKeDkzNHUzWWNhR1FN?=
 =?utf-8?B?dG1Mc01OZEsxa3ZudlZkaVlzcXZncmhiNHBhM2I3eXBmWE9YdmI2T1IyS3ZM?=
 =?utf-8?B?eHlUSEo4OVhCY2ZKcHBPUWVkekdWQXAyOG1iU3ZucDVsNnBxajlqS0wycG9P?=
 =?utf-8?Q?hwiILGtjWUs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q0g0ZWhCWlJSKzlUaGlDZGdpTnliV2VjT25Cbm4zbi9rb1d3RnF2b0dLdlN1?=
 =?utf-8?B?UGFzUWo4U3pmd0pWSkVHZ3h4WHFFb2tSK054K3dHdHQzckd0KzVVNjZkMXhR?=
 =?utf-8?B?ZmxmWlpaTW5rWlNWMnlqemh0ZGdQdE1vTFdaSC9PalliRkFiUHljN0ZFelc1?=
 =?utf-8?B?eHB3cVVxdVZVOHRjcEd4WURUSXdJNUpvbUY5YUpJV0kxZHg0REpnYTFaZjI2?=
 =?utf-8?B?elJvNmtQQTFyejdBdTAwckU3OVpOTFROVU9FdWw3eVdySkRRYlA3UnVTRjcx?=
 =?utf-8?B?dS9IaXlob1hXWVhVYzBjNlZ5RU1FUEZnejZPYnpuUERnRFIyU0VleDJOQWcv?=
 =?utf-8?B?bnZ1VzMrZGFJZ3pDbXphazZoVm5xU3VaM1RGTEtHamJzMGhNeUkwZHNyakNM?=
 =?utf-8?B?c3NaS0hUOVJsRlNacWU3bnhMVTZ2UnlYWnNKUHFZY0RRSnpXOWxwdzJ3Q0xl?=
 =?utf-8?B?SThINWh3WHZuYjA3VUJRcFpPSERpK0F1WDZ2OExnbHIzTVhXcThrVWl2ejZp?=
 =?utf-8?B?NldCanhnOFNNN05XbGNqalp0cXFGSy9qaHlkenRYM2lyVFV4ZUpGZTlNNmw2?=
 =?utf-8?B?T1VZSmFIaEtnM2JIYVRFTXc2SVViQXhuSDRIUFd5SFlYeHZuWjUxanpIWEF0?=
 =?utf-8?B?UkUwQktENkNJZTJwejQyN1lERkhIZjBaSDJmaWxiSDZQeUphMDlkT1FMY2xz?=
 =?utf-8?B?aG1OQXh5VHZWNUhxR09odmVNMVF3ODVEUTQ3blk5a2RKTkV4L01va2VLU3hO?=
 =?utf-8?B?RHFyclR1RnlNaGFOdE9CY1Uzc0U4ZzBubThVOW15UkFOZUtCUWhGbEdRL3Fl?=
 =?utf-8?B?UjV4UnZxSCtRV1RNUFc3REs3OVIyYWxrK1JLUUZqTW1DUVpIc2Q5emxlcWkr?=
 =?utf-8?B?N0dKdVl3RlZ1NVhkczJaTWxxK2F2dTVaK2Uxd21LT0JqZHlUNUJlV0p0LzFk?=
 =?utf-8?B?L21rb3lGSjYwUlR2d0NIRkF2akhERE4xNTRNcFZUeTk4bEtxdXpCcDU4a1ZH?=
 =?utf-8?B?RFpjckhlVXM3UG1vNTBPL2dNN1BZYXVRdW1USjNrYnRnSnZkUlJLNVVxaFhL?=
 =?utf-8?B?OWV5YXBnbUtPcVgwckR6Y3hUODhXTlFoRnBLa01INlk1cGpMSFhyUmxnMEJp?=
 =?utf-8?B?YVk3aGd1ZjA2RE5nVGxxWjdzYTAveGdEYUVmc3BpQW1RNkd0VjlGeXdTNWZF?=
 =?utf-8?B?bHBibVhzU0oxNStCamEycGRUV3o0NEc4RUI3Ty8wemVxb2k1V0dLY0JXTmR2?=
 =?utf-8?B?TmpXc2VhTG42aEdvR01UcXBXYjJ3Y1hFYWthZkRDMmgyNzRHSG0rM0g3SHh6?=
 =?utf-8?B?dHpHbkRtSWpqMno2UDNiRzAwd0dobGFJdzRjVkx0MTVPbXRMU01LNm9VSTli?=
 =?utf-8?B?cjNSNUg3dFMyZ3JSczl1MEJRd04yWVJqZ3hBYW11VHFteXdGZ3JQbXY0d3Fv?=
 =?utf-8?B?NU9IZi9EblgrS3ZjOW1WU0o4SXlCeVp1VUpCZ3NDdjcwYms0bUN3MG1lQWU4?=
 =?utf-8?B?TmVPNzZrV1VVSmRZS2FzdFBFSkJhZENINm45OVpqS0srYUpucERiclR4ODJM?=
 =?utf-8?B?RGNXdEt4M1QxbkpKamljL24yWlprZkIwZU1jL2hkd25mWi9nUnFkemtIR3BZ?=
 =?utf-8?B?b1BiNEQzdHhzYmVkWnJ1UVJkbDFDNTZiWWtZSXdUUVpMcldBbEx2cWxzY2tr?=
 =?utf-8?B?R0lpWmF3YlFEcmgxODIzS2VlcXRMb0FFbGZTZkFmbzAyWUdkYmJzbWR3Z1Iw?=
 =?utf-8?B?anE2dGVnblpabVpwN09GZHVJWTN5T2N2L3hibU1vWTNUT0RHRVZKbzVBcTM2?=
 =?utf-8?B?bXBESXIyS2FVT29ibHNSQXViNnJzKzdBVWJXWjVmUGVXU3R2cHNHYzlWSFYw?=
 =?utf-8?B?bWlzMEh2RG1nZHRUVWg3ZEpFOCtuaXovV3NMcFF1U1N2anJkOXNOcVE3U2xG?=
 =?utf-8?B?Ym9oOC9NV1ZBemE5ZUJ1ekorTTB0eG4vRERINk4yM3laUDlzZmZNYThwNVg2?=
 =?utf-8?B?M2E0TCthWFJmTjVUanNrN0xDbEphc2pDc3FIZ2svMldTb1ZDR04zS0FJdHV1?=
 =?utf-8?B?WmM5Y3RBYWZyU09oajlkUG8zYnFrZ0FMWFE5Smw3TXVFaFJzdXVObVBHTzJO?=
 =?utf-8?B?M0JQZGdHZlJLWERtcTEzOTJMdDFvWDJBRi9CU3A5bnpRd0g0czJYQ0FWVk41?=
 =?utf-8?B?NGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8efaa94-8fc4-4f80-bbc7-08ddd3feb6e4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 09:01:50.1972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydEiMTv+S+rbULEBuVvTqMJrBdb9iVMnQ7E55Gx6XWE56gYVoHYuRzNJUPjyYhqTkIwNTlj7JdYCRJCaqWj/Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8694
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Aug 2025 09:02:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19665

On 18.07.25 12:09, Hirotaka Motai wrote:
> Signed-off-by: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
> ---
>  doc/boards/README.zynqmp-zcu102.md | 48 ++++++++++++++++++++++++++++++
>  wic/zynqmp-zcu102.wks.in           |  2 +-
>  2 files changed, 49 insertions(+), 1 deletion(-)
>  create mode 100644 doc/boards/README.zynqmp-zcu102.md
> 
> diff --git a/doc/boards/README.zynqmp-zcu102.md b/doc/boards/README.zynqmp-zcu102.md
> new file mode 100644
> index 000000000000..87566dbdad67
> --- /dev/null
> +++ b/doc/boards/README.zynqmp-zcu102.md
> @@ -0,0 +1,48 @@
> +# ISAR CIP Core: Instructions for the Zynq UltraScale+ MPSoC ZCU102 evaluation board
> +
> +## Build the CIP Core image
> +
> +Set up `kas-container` as described in the [top-level README](../../README.md).
> +Then build the base image,
> +
> +```
> +$ ./kas-container menu
> +```
> +
> +Select below options to create base image,
> +and click on Build to start the build.
> +
> +* Kernel 6.1.x-cip
> +* Bookworm (12)

Is this a recommendation or a requirement? I assume that 6.12 + trixie
will also work, won't it? What about older versions? Again, any
requirements should also be expressed in Kconfig.

> +
> +After the build is finished, insert a SDCard and flash the image.
> +
> +## Prepare to boot from QSPI
> +
> +The board must be prepared to boot from QSPI.
> +
> +Please refer to the official website of the board below:
> +- https://www.amd.com/en/products/adaptive-socs-and-fpgas/evaluation-boards/ek-u1-zcu102-g.html
> +
> +and configure the board.
> +
> +## U-boot settings
> +
> +In order to boot from the SDCard, we need to set some environment variable on u-boot.
> +Switch on the board and the u-boot intaractive command line to set the environment variables.
> +
> +```
> +u-boot > setenv cip_serverip '192.168.0.1'
> +u-boot > setenv cip_tftppath '/tftp'
> +u-boot > setenv cip_nfspath  '/nfsrootfs'
> +u-boot > setenv cip_kernel   'Image'
> +u-boot > setenv cip_fdt_file 'zynqmp-zcu102-rev1.0.dtb'
> +u-boot > setenv cip_bootargs 'setenv bootargs "console=ttyPS0,115200n8 root=/dev/nfs rw nfsroot=${cip_serverip}:${cip_nfspath},vers=4,tcp,hard ip=dhcp"'
> +u-boot > setenv cip_bootcmd 'setenv autoload no && setenv initrd_high 0xffffffff && setenv fdt_high 0xffffffff && dhcp && setenv serverip ${cip_serverip} && tftpboot ${kernel_addr_r} ${cip_tftppath}/${cip_kernel} && tftpboot ${fdt_addr_r} ${cip_tftppath}/${cip_fdt_file} && run cip_bootargs && booti ${kernel_addr_r} - ${fdt_addr_r}'
> +```

Does the original firmware for the ZCU102 lack distro boot support? If
not, you could use u-boot-script, and none of the above should be
needed. See also how I once enabled the Ultra96 boards in [1].

> +
> +you can boot from the Network via TFTP/NFS servers as follows:
> +
> +```
> +u-boot > run cip_bootcmd
> +```
> diff --git a/wic/zynqmp-zcu102.wks.in b/wic/zynqmp-zcu102.wks.in
> index a40d4bc9329c..0775db770717 100644
> --- a/wic/zynqmp-zcu102.wks.in
> +++ b/wic/zynqmp-zcu102.wks.in
> @@ -8,9 +8,9 @@
>  #
>  # SPDX-License-Identifier: MIT
>  #
>  # short-description: Create SD card image for ZynqMP ZCU102
> -# long-description: Creates a partitioned SD card image for Zynq UltraScale+ MPSoC ZCU102.
> +# long-description: Create a partitioned SD card image for Zynq UltraScale+ MPSoC ZCU102.

Please fold into patch 3.

>  #
>  
>  # SD card is partitioned as follows,
>  #  1st partition: fat32, 448MB, for kernel image and dtb

Jan

[1] https://github.com/siemens/jailhouse-images

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


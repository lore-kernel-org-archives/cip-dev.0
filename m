Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676B0C7EE2A
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 06:00:46 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.66])
 by mx.groups.io with SMTP id smtpd.web10.32701.1751263232651439678
 for <cip-dev@lists.cip-project.org>;
 Sun, 29 Jun 2025 23:00:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=T80HGyDj;
 spf=pass (domain: siemens.com, ip: 52.101.66.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swbAxUEbpjQZKGmBWYVZT/H2pLfYsYWhwWUotDkGX9eohl1BrNcLeeZ/zXHIxZ35D2JCEzGxkeMVtfCChjIT1AvivMKVCp6jIp8Zu09diUxHR4/cV+6uuyYFSpRjTYloYy2rvobH9PwlRIg264m0Hm/bA/ap9B8dMK3JZpm8jdPLN+3lvNSWv8MTqjCkGRhlbgQAKOdjaGakgxrMDS0pYnzm7mDf5s8mNfyR18JCT5RPtjzwzkM9Lif+wB6QzF0C2PBChRHPLd3dNV0QSDfeDOJXpQQWbSJSiXtLDHQvlIne2NYp9p847y8CUgLAKr8Yu6eT4DBZfqefyJYIz89lNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBeHQXDj0h8+g3ZCFu+wpd8aAqM16tQIJyZxT9ZoS0Y=;
 b=LY2ZR6r6sh1ok2tDEE/YNdzPFc6ePPqXZ09BmDrmFmlVjK8k/lmlqkiqvqe3WkUwZ5dtDFOd/zhWghRfxgQeloZ3rFqq/HYee4Nff/4oCdDdvttTQV6RBBXCGasGGctmSWJYWGy2K6OOlFR4/nfT4QQrg9LRoLqvqwnLoklan5hkjMaQUjPxfAc7KVbysk9Tv/62pN896Ds52WFtM/Ii5k7AGnUZLmko1q3BM4OHyK7mRwu2q5r97MUWuL0orGrymHxok5IA9QW3POiye7NVv6ljjfV9WScX7LpREmdFXktvKdGmHhcWTUu3ZZyMKSwUOtqmnb0dfM7BkeLIjm2fvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBeHQXDj0h8+g3ZCFu+wpd8aAqM16tQIJyZxT9ZoS0Y=;
 b=T80HGyDjgpHIvK9Om8Krgv+vd6TbiaW9hdSB+5EwREE4vRDBhKg/X1d4zDsMNXE0kAZlqyr9Zap+HbIOKpiVcmEnhxVbjeN2A3KBALpIxT6jWLVztOwdWeOdQjHS8PL2dxe93+MlWOXvX81ykgre9BIVnMtOKsuCMRvtyj7j2Y/aC0xB0qVREnILyHuH4DYwbOW48BlKZ0T063FuWq4MAvRkEFgMhP+wCHP6VNRpSxDcD6uPJrbH2tQIBBrsyxofNwKIrkEgszUkPk+XfauT+7dedJPMcYY1wViUOG4IJXF/aPUNA7A1pc8+p56w4FJLbuEwDEfhvHYkLCX6EQuSLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3305.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 06:00:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 06:00:29 +0000
Message-ID: <86f0f2e3-a316-42f4-8c1c-910b412a2c9d@siemens.com>
Date: Mon, 30 Jun 2025 08:00:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] gitignore: added .kas_shell_history
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
References: <20250627125348.895382-1-alexander.heinisch@siemens.com>
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
In-Reply-To: <20250627125348.895382-1-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3305:EE_
X-MS-Office365-Filtering-Correlation-Id: 0195d929-1dc4-42be-0b32-08ddb79b6a4e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Ri9yVDF1MWxKWVFDQUphTmtmdThWcGlGZmcwcGhvN0hhMTdXMG51NjVoYVp2?=
 =?utf-8?B?SitTZnpBZkI5ZnkrTHBjNU10NjRVeUdJTlUvRVpMb0tyUnFNMTh4aDdVdjhH?=
 =?utf-8?B?QUFBV0tycFE3emNtT0VQZFF6YzlhUnowRDg4SzE3Q1dWT2JXSjNicHc5SnVR?=
 =?utf-8?B?cDF4WHZmbS81QURqZlMxZVF3cVdTM3gwVVl1ZWVOQm80ODNvcERWbUUxNnpy?=
 =?utf-8?B?V2sxajY5VFJ3dzhSR01kb041d08vWGVBTmFrOUFKQjZwMC9TL3ZYcHg1MFdk?=
 =?utf-8?B?eU9paHY2Y1FnY3ZKYzFialk4cllJRjRrTXc4ZkJWMGh2dk10eVZyL1dETzJz?=
 =?utf-8?B?b0phV3piQVk2NWZiWU8xdkZ6dGwwZmtSaG13Vm9EalVUVnBWbVcyWE4rSDZE?=
 =?utf-8?B?WTBwQXdzVU1OSFVvM2lQMk1PQ3BUek5tVkFDNFFiaGhJRnR2QjhtdXJKYWVL?=
 =?utf-8?B?QU54RzRyNW8vZkx2WENCeHk4MTBJODFTV0ZDTndsWm5SaWw3UVhmU05QWTlS?=
 =?utf-8?B?Tk05WkJNL2VYRWxCVXByUlZuaGk4L0UwbFByejg4N2wwd1Q1aTBEL0QrTzBr?=
 =?utf-8?B?bGduS2ltVTdQS0diQUpkcEh1S3pQbUtnSi9aRGhBK0RKR1Foem9FVWMyb0V1?=
 =?utf-8?B?ZXNUTGVCeXlBZVF2b3U5eXAydG5zYjhPZlNYbHdYanhrMktkY2wzVmw5Q29U?=
 =?utf-8?B?MU14dHNZaVBJYXBVd2kybmk2UnZxdkkwZkxaZTh1NFRMNGVXMmdkRWgzKzVR?=
 =?utf-8?B?RDdwT3dIay9hd2x3NXo4NWVJUEEzVlFzazRzcng0cFJHMmVaWTBBT2xVZmh4?=
 =?utf-8?B?REc0VWY4QlVjQVpYa0RoVmcrNjNLVW95RUZUaVVwQytVZmVpTXVQYm5aUnBQ?=
 =?utf-8?B?WU9nR05zMlFMMXN5UXNFQW1ObVRCajZOTDZlbmY5RXRkeVpMM0VXT1JGdHNU?=
 =?utf-8?B?T0k0OVhlU1FjbjBwd2NoVk9OZlZRekNmaFovQVhuWU5MUVdNb0k4TklJejdu?=
 =?utf-8?B?YUJQeFJZa1dRNnVwQUNtNWppYmJLZzJTcjRQSWtxaVZ0UzNCaWp5TnNUMmp2?=
 =?utf-8?B?STZ5VHV3Sm5pM1kwTzVPODhIc3kxSFJKazVlZm1XNFFCZW13VWljd2oyU0hT?=
 =?utf-8?B?MVpnbmJwc0ZWS2F6SzBkMVRMeWYyZjZhaG5oTDFpWU5KenBUUU9IR09LTVVy?=
 =?utf-8?B?VTMxS1BzOXVJTXVWNS9PNmxZVVJKdVpVeDRvenhNLy9aT3g2aVZBeCtkcXNR?=
 =?utf-8?B?VUpsN1ZYQy9QcWVtL1cwNXNFRU91QU4wd0l1c2VWU1dyL3dOTFhEUXVieG93?=
 =?utf-8?B?ZTFOQkNoc09yR1dQKzJOYUFOTjlDK2grR0tkZnB4eFFDMWRxeG1BYVV6bmR1?=
 =?utf-8?B?WjlWSkdEemZnVEJmbVZscHhJaUJKRUFTblpBYzZPd2RYemEzZ1pSaUZremhx?=
 =?utf-8?B?ajBPdUJlZUJYUnN0bVNVVzNkUnQ2T1BiQjR3UWI4QTlyUEZxRkZBNFZtUXFu?=
 =?utf-8?B?REpraDI0VC8rZktFQ2VFNjAvYnVJZ0tlclg3TXpaTjBlT3RwbUNDZm9yUlpW?=
 =?utf-8?B?V3dFRlEweldkV2RxMHpIZTFhN2JzQXdvTDgvVjRSaWJjZ0s1ZktZYWZqQjBv?=
 =?utf-8?B?TnE1enZuL3YwRmhpSGQvSXcwRkR0YUpqS3h5RXRKTUxtQVhZRTFaL2RpNDlX?=
 =?utf-8?B?dTltWXUrejlWWnRlVGJybHFLYUdQWkRYcHRZZTczdDl5WnBTZmNHRFE4ZTNV?=
 =?utf-8?B?OFp4T0hJRUFlRzRrUGwvTEl4TndobFkrdXhNbGUxUGU2YnRrTlZDTlIxRnlX?=
 =?utf-8?B?ak9DVFo0ajBRVmZ2dTNsK0N1RWtKVmt1Y21MYlBOeVFMSWNqVTVXbjlqSmVu?=
 =?utf-8?B?WmhYYk53WkwrOTJTQ2xtUnREVzJjVGE0VHJFbjlvNEVGazU2YklzZXFmSGNS?=
 =?utf-8?Q?3h7DUV/YJT4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MEZOZWVJTWZpR3FNMmJVZUJhVHQwVndZT1pQZ01aRWVnSlVwUXBPZ3lqSTQ4?=
 =?utf-8?B?SDVpVEt4TlAxampwMmlBODE4TWlaUDBhdkF0S1lzVWFrRTc5QlNtNXFJai9Z?=
 =?utf-8?B?cThiNkM1MVFoK1R6ak5KejdvbEprb0ViRUpCK2xFM2VQbVEzOXprNTVEOGto?=
 =?utf-8?B?aGVkYnMwZTlGbjEzcWtvWDVpTnhsOTV0QlJBUk9YQVBrZkZrS05tUVR5RlNN?=
 =?utf-8?B?TVlJcUpCZEVWM2NsTW1nSHVkQ085OFh1aXdWZG00RTh5MkZqczFqUXdqUXQw?=
 =?utf-8?B?N2xRQ1g2THFGWlZuQkdZWkpwSzlXS1FYUVVxY1JhVjRrcnBlK1ZMZk1YenNk?=
 =?utf-8?B?d3VMYXZxL1NTeS9XR0hFRUxvVGc2NCt2enNNb0dqNE9pYW5NNzRYNFZRbEhX?=
 =?utf-8?B?R1E4ZlBSSXdMTjJBQWdZRW41aHRjM0VxYWc3WEdPenU2WVo5NktLcG1mTlpC?=
 =?utf-8?B?OTMrU0duQUwwbUtUR2FzdUZjNmJuM1crWDcvSGVCK1lTSTlpdTZ4N0JsQllF?=
 =?utf-8?B?bm1XbkRPbDV4cmNpaXpMRFUyblVwbVEwdHNNMGFwZjFDMTNqQ1JpNGo2UUdG?=
 =?utf-8?B?aE5uaHFUK3Z3Uk5KN0diNTkwV3hRcjB1RThDWGR1NVdhUExudDdwZTlDcWdJ?=
 =?utf-8?B?enRJM2dnU0pPTmJub1hyZXJ4T0ZoK3hsZnN4ZHdzeDRyUVlWZng1a09iM0NI?=
 =?utf-8?B?dURNd3Rzb1BhVVJDdTdSZTROMTZDMk50T1IzNnRkY2xPQU5yQzgxeEVRNXlJ?=
 =?utf-8?B?bVpjRmtTa0x0eEtOU2g4RUJUdm5qUndWVUJ3V1FDREx1eWNLSVo5cVZyajZj?=
 =?utf-8?B?eTduRDV2UUR4WktScmRVa3N6NmV0WnF0Tkh0RFVkSXBhK3R1bnBBRSsyeTgy?=
 =?utf-8?B?a1hVQXduZWJneDAyWmk3WTdsTlJOamdSMkpDYjNIZnNiUkFvd3RoUnEvUy9X?=
 =?utf-8?B?cXAvTXVrYWllQW9ZYlQ0V3ZrNmo1U3RlL1V2VkJrOEpSVm85c2syUWZkTjVO?=
 =?utf-8?B?L2dvVW9MdTRsY1lTSW1VOXF3U0NBa1RtazRqMjkzVEdTd2QxNERYME5NakZl?=
 =?utf-8?B?cC9NWExqNnBJYVpLbnEyMHlEeC9MZmNncXpHR25MMmd6dUdadDl6alVDV1di?=
 =?utf-8?B?WlBlVi9rMTZTM0NwWFZLOTlYdUZtQmZ6azlJTUE0dlRlZE04bit1K215cmVw?=
 =?utf-8?B?UWJNbk9kN3BSUTkzeVZYaDhNYk9zb1NIWFA4WjhWckFrYnV6NGh3VG51R3Ux?=
 =?utf-8?B?T0JTYlNJdFB3SlozYVpObENlNEZFcEFiWllQclgrT0FhY3M1bHFHZTlXK0tJ?=
 =?utf-8?B?YXZjcC94QWh1b0xQYllqd2d6WDQxa1NvV3htSnpISm1lU0JnY3FJdmtwM0JO?=
 =?utf-8?B?RHpBSU5qNFhRb3l0YkkyUUk5WkVNMlBKTjVFRy9WaytLRTBNWWZ2eWJreVBa?=
 =?utf-8?B?eEpVUzhYQ0hxTSttbSt2a3NuZ3AvS2kyQ003RTNpYW9HV2VYSU1vbW8xd2t5?=
 =?utf-8?B?cXM2RjdGY3lPc0lwY3ROeXVHYnA5aHFNSGx5ZjgvdGpoczl1M2dKZTVNcXcr?=
 =?utf-8?B?M3c1WEFaRWVTTjBubHRRRkUycUJkUHBPMFBMSEJsWWVsVC9jcTc0RWVidGVP?=
 =?utf-8?B?RTV0ZHpaeEkxd3BvVlZoS1c4U2xieFhZUXNUeXNFMXhUZDVmS1R4QTdDVm12?=
 =?utf-8?B?eU1XN2poREZTbDZYS3EzVlJVZjlRMGZKamFONTA5bm9MazJIZkFsSytybkNR?=
 =?utf-8?B?bHhrd3RtS0FCVHpLb1VaSXF6cEh3VjdWRmdha0oxQUFZVVFOTVVxdWZibmw4?=
 =?utf-8?B?QTUvOFF5MkV4SFlmVTUzMHh3a0NCSnY0L09nK1VERzJ3UWJUdTdmUXJMdHBw?=
 =?utf-8?B?blEyTnVLUEc0cFFwN2h2RWVCRi84dG9jd2FZR1Uvcm9JWElGTzRKSnlnbU8w?=
 =?utf-8?B?OUVRYWZYalRxYzZaNjFZM21GSG9qR0ovWHBxOXYxeFpoaXF5QjVnMlExZGhl?=
 =?utf-8?B?clpwRVFrY3FhN0JSRDRxRkI5T1lWTU43Zm9IOUlFQk96TjBDeEpHU3I3SkVo?=
 =?utf-8?B?cGFtTFBOR0lsK3EwdlpYUE5NK3ExS3lYTzdKM0JZbSs1dTByRE1JMUVGcnB2?=
 =?utf-8?Q?eSSiI4zHYaRbpmseQ07vtJxRc?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0195d929-1dc4-42be-0b32-08ddb79b6a4e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 06:00:29.0105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cush4qhh38O0CbZbjgAlZJEWqsQ4qm0W4IkBkHkqAmMrpdwLB8Qq7Bzxhw8G9dhJIjBqe9QRudi9Lud/NSW8xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3305
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jun 2025 06:00:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19251

On 27.06.25 14:53, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index c657e77..a825b8b 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -2,3 +2,4 @@ build/
>  isar/
>  __pycache__
>  .config.yaml*
> +.kas_shell_history

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


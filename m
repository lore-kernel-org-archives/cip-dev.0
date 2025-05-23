Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AF0C54ED0
	for <webhook@archiver.kernel.org>; Fri, 23 May 2025 14:02:30 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.61])
 by mx.groups.io with SMTP id smtpd.web10.48772.1748008946431524098
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 May 2025 07:02:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YxPFY1Wg;
 spf=pass (domain: siemens.com, ip: 40.107.249.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWnSyh8IZg6fe8JdjMiv2i1Q6NUwDpUKwk2RDfPA3Mb+qws1EiVcOMJ9OXkuGdjsGXc5A7zA1jT2bnBo6tO/MlUWsKTsbRycIpyD0e5p28g6sOx2zJ4XUvIp/DAa60GESG0w0TiITiWimj2Jo9IBVIz71bCL6fLmDIlJ8VJgxT44iWWSkuZYdPrPwST2A3bkRqu4lBAfKH+SMNuxTeum95NPwxnZWJS8rxB+/g7XHWg0oAtDfReiqyuv2Jq9htzzG3VSwrFeCKXAQdcas9BdNfBtfyyj9Gcbximq5MFk93bGoU/EC4mRasiHYDUbPfu3iafsB/xtzJ+f2a8a+e8+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+qcZwXmT2JjMIJUpNKneJWZLiuUYxgD/T8yUgHX+KE=;
 b=vayNS1jY9OZmtrnF9tEWeoYtJe8j86pTUz4I2OT1M22/yrPt6+IcG84MzFIZ/ACoSWTTlIHFNFadA7OXFFxu/tughG9TOpz+iTFjFb+kPd73bUd9mqEhNs0DgH5RKw1F+qzU5PB+lMccvEY7G77z8Qfq+og7BEAVKWPbSwkeLOIqLl2XE70AoR8VMzZYU1lWuA7BSm+3j14G7KUktzCD2g0RSIXF0TsqgD7sO/wa15VwpvOALneS2gQ7AN0+Uw7CVyASg3GS7wXYvwr38MUWapbP1LIiFOFaPPRrxqzWwUnT9NshuLEse2Qa7z7A2Jzz0YqiftBzfgaj1vSDVGszDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+qcZwXmT2JjMIJUpNKneJWZLiuUYxgD/T8yUgHX+KE=;
 b=YxPFY1Wgp8VZeSY/IsJVZ/fuXPmWZg6RYtXpbOKmdeT5UfEKtK+0+3XQ6DoOKPEPiKDREJhAdFKWKP6NvqYY6Am/uv4hEc+M02HFaZszpijYMV9f+oMMrugHGJ/aaERuRuDxTHP3kpyh0mX7pzzrKlz2oOsCwRWnVuA7pCEHxcboqw22ZXwoN9ixPqgCzzdbaeVjMALAT9Nz2JQsyX/JLiSaudfLMcD43JI2aY6dzqMYsQvnIno1g0KRGQ/I5KE5A+xUPRbM/lZyhdiFhXf7+X0KjcmUzzKIUoCLPm8/QNwkHBStO0wpKYAx3O0EoOjwF5AKbhXF5W8leMzZjYjtSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3966.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:163::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 23 May
 2025 14:02:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 14:02:21 +0000
Message-ID: <750fabc3-b8e5-482e-91fd-a82d629852c0@siemens.com>
Date: Fri, 23 May 2025 16:02:20 +0200
User-Agent: Mozilla Thunderbird
Subject: [isar-cip-core][PATCH v2 3/4] Add support for CIP kernel 6.12
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
References: <cover.1747745022.git.jan.kiszka@siemens.com>
 <39db6eaae60ba88a961e5a793db1f1bc77fd32a7.1747745022.git.jan.kiszka@siemens.com>
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
In-Reply-To: <39db6eaae60ba88a961e5a793db1f1bc77fd32a7.1747745022.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3966:EE_
X-MS-Office365-Filtering-Correlation-Id: f1eb91ac-1025-487d-2685-08dd9a026fc9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ai9wMVQ1bmZsNWxhdnE0UlJIU0pvSy82ZUlKN2JnZjF3K1liQWIvcmF0aEhr?=
 =?utf-8?B?U2ZINnFNQk9rZ2pFMFF0WUNhR1dSUUFBMTExTlJnazRHVDlidTJRcTljck82?=
 =?utf-8?B?TmpDWDhRdCtRZXpVdXdUME13WDJVUFVvYjBNdUhwVTY5Y2t2ZkZqMFBRWnIw?=
 =?utf-8?B?U01oVjR3V3Y5ckhlbi9MZW1mVXpZMEVaVU8zbWI4YXYzblFhMC8zVGlFcGp0?=
 =?utf-8?B?VDNCU0FnRERZTEJ2cUoybDNuNVUyaVBtbWdTZ3h2UVJGOHdYd3FYNVNzNmlL?=
 =?utf-8?B?WUxpN0VBekpLcGVueXl0ZzIzQW5UbVdtaHZPNzJVbTZ2azE4bCt6czhpNHBz?=
 =?utf-8?B?cSsrSDRzZUlFcmNmcExHcjRmNXlZVThyR2sxb3ZIaEFwUUpLcTE4R2gvcmtX?=
 =?utf-8?B?Qkh1MUo0SUVOYXFFMG1vZUl4aFBqNmVuQUxqT2lHKzRVa1JIYTV5dG9EVHRx?=
 =?utf-8?B?a2IvSEJVMGxQS3JjZFVUR1Z4OGx4Nlh5dUxTa2UvTDNBU0RvcHFXTE5yUG9Y?=
 =?utf-8?B?K1E4STlSZ25hdm41ZWcrZ0dXTS9BMVc2aXJkNGR0bjlzS1YxOUthZU9yVGJI?=
 =?utf-8?B?anI0dlVlaWtpUmJuY3JvZlZyUHpxS2VBVjcrdlBraXM3dGFHU3VBcm9ZV1li?=
 =?utf-8?B?S3FsNHk4TG5HZXBXdnBNeVhUZzBaRGFUTVU0TE9UL29BQ3lkNEVuVm01OWNi?=
 =?utf-8?B?Q2E1NmdJMXo1Zks2UFBqTDFNa21pay9hNEhqM2JsVWpjdEU2b0lMRjc2QVRv?=
 =?utf-8?B?a1hxcVozQ3RBclNWZlp5ZGsxWGpyeEZzeWozVE5jdFdNL0FkdjNyVi82eHV3?=
 =?utf-8?B?Snk5Vlk4d2xVTHk5c3RoN3J6ckk1Vk9Xbm9TQW5rMm1iTk9NRTVHc2g1UitT?=
 =?utf-8?B?a0JwTUNYclM0ZHM4bmtYN0pqVUViSnhVZk56MHRMSHBmR0RHSGRJWDNkQXlD?=
 =?utf-8?B?b0J6K2pEd3lrOENRSXl5Y0FNa1Z6MnBKL00vM0F1RjViZDBqc1pHeHkvN3JT?=
 =?utf-8?B?NFRjU0Y5REoyK3ZVRkI5NWRWSFBqbTNEcVQxZTc5aXFPZWRYcm9rZGg1U0ps?=
 =?utf-8?B?V3pqRjlYNmZ5aHFMM2VIVyttR2VIRWIwL0FaWWtIbjhUMXBETWN0TW96UzQ5?=
 =?utf-8?B?NlhkZVVFaUV0ekpaWkJDVVhsQlROSHorUWpZNk9kNmtwc3dFaS9ISEo0K0Yy?=
 =?utf-8?B?dFJySS9ielkyU09YQnMwYTg2SFlyWG8rTVI4K1diZ2FhMGNtaWdmTjlnN1Fr?=
 =?utf-8?B?Z2ovSVNpYlhJSzUyZks4NG45akF2eGFGWGFwbVZPZVdWTWo4WnYvMzYyMld6?=
 =?utf-8?B?MWhXY1BaYUgwQk1aYlhjTHJZclVpcWJhQ25OZEROWjJIQ1R0cytweFY5eEhL?=
 =?utf-8?B?SEE1cmQ2Mm44WnNrTmx0bkVQWW1HR1ZLMWVlOEFFa3FPZCtickdHVldhUk1J?=
 =?utf-8?B?ZGpGSENEV2VnQ1U3LzVISEVxMlRaTTNUeVJ5SXdQdHFzRGt4cmxpNXFBaGdV?=
 =?utf-8?B?Njd6WDJpMXpLZFVCV2xXWWkwT2NLbXdvNC9RUWlPUHB3MU1sMHZ5Mm5ZWElT?=
 =?utf-8?B?KzllRExMcEpLaDkvOUZVRysxRVk2ZE1OSDdvM05KNWhOMjBWQUd6Tk1GcHUw?=
 =?utf-8?B?YUUyTzYvNjI3VkpUTHpQanRvRTJJT0ZJelhBR2VMRUdlbWlTOGcrVks3OXE4?=
 =?utf-8?B?S2kwMHpHT2UrZi9xSmVxSDY1Nm1XYWREdDYxeVJyZ3lkTUc3cUpZK3BrOHJ3?=
 =?utf-8?B?eWo5SzZSWmU1N01LWWs0OG1uV25BampJbWRWT3gzODQ5bmtiTTN4TVV0SUMw?=
 =?utf-8?Q?cJAfWw2vWdo+5KOt+I1mf7NH+sI1eeRoGW7y8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MmNva1FWanlCUWVGdjZhMUx4Qmd3R3Fiakd3MUNXQWtQemlUOTM1YWRwSVNB?=
 =?utf-8?B?eUlkWHpwQW9OSXVEVFFwU1dmdmJiMjJScUZtM09HQzYyREdmVUxaVnJvbDh3?=
 =?utf-8?B?ejNVWERXN0JadUM1eVVyQWxnbVI1Sml4c2t6b3NTOVNZeGtwK1IwVnIrREFt?=
 =?utf-8?B?Z2FadS94MW5CSWlnV1VocWxpM2w1MTBjTjB5d0tGeS9rNmxINmY3Y1N1TW5O?=
 =?utf-8?B?d1NnaGpDN0t4UVVScll6Yk1sa1ZJalZwWnlTUHMwOVRoTkZWTWZtbUFwTXoy?=
 =?utf-8?B?Yi95VzdRbXZyVnBKRlNVTSswRXVsWVRRd0xkMTVac3FuRFdYYnhMVTNJMUQy?=
 =?utf-8?B?NlVnaEMxV1N6b0U3TmwzaEpGQ0t6SkFPT2YxNnJYSTVEY3ZwWWE4VUxBZklv?=
 =?utf-8?B?MWZZTENjWmdaZlZreFNsdjhaYU9MRjVPSHBLMS9KWXFENVQ5bGhGVWRvaUFU?=
 =?utf-8?B?a1NLZmZOajVydlhha1lpNGdLSXc3bjNCaTlydjMwTG10WjRUZFV1MVlMZkNj?=
 =?utf-8?B?LzVZcktIVDlJNERSQlpyYXhhbVQ0N3dKeEI1cWlRMFc0UmlvNU11YTZCSndw?=
 =?utf-8?B?dHNQdUsyL0FJTUw3Lyt4QnBuSE9BOFBOVDZYUk45WC96eXF5R0J2ZnZtak0z?=
 =?utf-8?B?Zzc1enR3MWErM2s2THV2R3JSVXR5c2FtRktRRjBxemFXbzNFeEdYTCtxODh3?=
 =?utf-8?B?d25CdUNhcTcrdFRxOUVlcERtcGQvZWNtVWpPSnp3RFl5d0ttWVpIcTJ0eVZp?=
 =?utf-8?B?d3E3QmlxTnNFSmFOdUtKVDRqTFBPQ2RaTTAvL3lSVGdZUlViT2N6SjMyQ3c3?=
 =?utf-8?B?aWhhTWRTWFp0a1F2a1FkdDl1RTErKzEySmNpZk42TFp3MUlVWko0eFFNWUdw?=
 =?utf-8?B?cHlEUmhVUmYySHpHRmhhTHlTRHRkWGZ1cW0yVGtJZmMzdUFlRTNEN1NyeWhj?=
 =?utf-8?B?ZUJhamk4Yyt2dWw3ek5xb2kvMjRtRG9Qa2x5RlZ3SmVnODNUcFBjUzV4Uklq?=
 =?utf-8?B?MlF3ZWEyd1JqRWdHeDUwQnJyMDNJOGhLektiS3dKdSs3UC9ETGJDMGxxWkhh?=
 =?utf-8?B?b1ZWOWdINUhEdW8yb3Y5OGJoVzlaZUhUMkY2bEZCTFVmNHZURjZUQU15VWpJ?=
 =?utf-8?B?ZndBMnRRRGpvZ0E0ZERoNmd4SG5Oc1NjVFNobHBFNTVZejF5OEdZZmIrNko5?=
 =?utf-8?B?YzcyYi9HSFZCN2tYbUl1cWpSbjU1UVBCKzl2ajF3MklUZG5CT085bDB3WE4z?=
 =?utf-8?B?TGZUdEduQkRWazdQM0tFbzBCZVh6d1BuVXd1WU54MVR6bTBnenkvdmNucXp5?=
 =?utf-8?B?WmhoNHJ2ZHUzbUF5MDFhcnVHZG44Y3hpYVdYVDAxMWVBYlZFY29YK3pWdGlX?=
 =?utf-8?B?ak1kM2RacnYwejdnMG13TU8xZzFROU1ld0JHMSs4RktkM29rb2R3cGRKODNx?=
 =?utf-8?B?UkVuREZKU2QyanpWamhnNnZJUTYrWDQ2VVpRSndYVkRFWjc0SU5IYWRyRC9L?=
 =?utf-8?B?NTAvSCttSUl5K1VYUnpCYWJzOG1aNGRZdUxjcDhFc2dSZlFiTlZlekxuZC9i?=
 =?utf-8?B?cUx5Z01Wam5Gc0ZycFJZaUU1UTZUYmpNbi9rRE5JTm5XYno4enUwLzVDYTJO?=
 =?utf-8?B?ajBJd0xjQWxSU3pGWlRzdk5CREJMaitXZitYWENHVG9uVmcrWVhncG4wVTZi?=
 =?utf-8?B?cDhINWFrZk5scWVjZXZLZk96RkhwZmVqdUpnbHBiRGxvNXVWMGVNVlNHV0lH?=
 =?utf-8?B?OXBsclhNNmZpVXBlOC82Smp4b29wRFlXMlgyTHpqWGdNTUtRek1rUGx1Slpo?=
 =?utf-8?B?U3hhcXNaNm1RTEI3TTNGVUpHUVk4aDNHUStHSUVpUm9ZVDdkbVBSNk5TM3g3?=
 =?utf-8?B?SzNrZ1JDODg5ZnRBU1ZrMkhjd0N2czZ2RUt0Q3NEaUw1eW55clpENWdWMEdq?=
 =?utf-8?B?Q2hteUhrdzBWa0d3RUdiM0FIQ0tWbzFWU1R6QmUvREswcE85aGdBSnVwbjdM?=
 =?utf-8?B?eE5oaFpZUWUveVFPdWhNUDBQbnBsVUhrNjhOM0FyeUlPRnVFRVFKVHlFSkxZ?=
 =?utf-8?B?UWlKcFNZU3FXaUZyWkFkNXFVMnVYTDZSdG5YeGJvK1pVTGsxNTJHeWFtRGRQ?=
 =?utf-8?B?dTlhOE1oSkpyR0pHcytMUyt0Y2VsTGIycFFEeE05Qk5LM0hoa1Q4WkllWnNM?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1eb91ac-1025-487d-2685-08dd9a026fc9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 14:02:21.4403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXWPAGqgiBItH1TVNJgKizAixEW5QLrnwcqoP5cu5xxUzlZ4cWL8XMzCF9Mezcv4Ib+533aBdLJNQwLfzhj2DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3966
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 May 2025 14:02:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18943

From: Jan Kiszka <jan.kiszka@siemens.com>

One difference with 6.12 is that there are no longer two different code
bases for vanilla and RT. Therefore, simply establish a link from the RT
recipe to the regular one so that we can continue to control the
activation of RT kernel config by setting the KERNEL_NAME to "cip-rt".

As trixie upstream is heading for 6.12, lift our default for CIP images
built for it accordingly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - improve update-linux-cip.sh to only update RT link on 6.12 changes
 - drop unrelated change from update-linux-cip.sh

 Kconfig                                       |  4 +++
 conf/distro/cip-core-trixie.conf              |  6 ++--
 kas/opt/6.12.yml                              | 18 ++++++++++++
 .../linux/linux-cip-rt_6.12.29-cip1.bb        |  1 +
 .../linux/linux-cip_6.12.29-cip1.bb           | 10 +++++++
 scripts/update-linux-cip.sh                   | 29 ++++++++++++-------
 6 files changed, 54 insertions(+), 14 deletions(-)
 create mode 100644 kas/opt/6.12.yml
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.29-cip1.bb
 create mode 100644 recipes-kernel/linux/linux-cip_6.12.29-cip1.bb

diff --git a/Kconfig b/Kconfig
index a726d262..f809f014 100644
--- a/Kconfig
+++ b/Kconfig
@@ -100,6 +100,9 @@ config KERNEL_5_10
 config KERNEL_6_1
 	bool "Kernel 6.1.x-cip"
 
+config KERNEL_6_12
+	bool "Kernel 6.12.x-cip"
+
 endchoice
 
 config KAS_INCLUDE_KERNEL
@@ -108,6 +111,7 @@ config KAS_INCLUDE_KERNEL
 	default "kas/opt/4.19.yml" if KERNEL_4_19
 	default "kas/opt/5.10.yml" if KERNEL_5_10
 	default "kas/opt/6.1.yml" if KERNEL_6_1
+	default "kas/opt/6.12.yml" if KERNEL_6_12
 
 config KERNEL_RT
 	bool "Real-time CIP kernel"
diff --git a/conf/distro/cip-core-trixie.conf b/conf/distro/cip-core-trixie.conf
index 723a3d70..e8eff746 100644
--- a/conf/distro/cip-core-trixie.conf
+++ b/conf/distro/cip-core-trixie.conf
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2024
+# Copyright (c) Siemens AG, 2024-2025
 #
 # Authors:
 #  Cedric Hombourger <cedric.hombourger@siemens.com>
@@ -12,8 +12,8 @@
 require conf/distro/debian-trixie.conf
 require cip-core-common.inc
 
-PREFERRED_VERSION_linux-cip ?= "6.1.%"
-PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
+PREFERRED_VERSION_linux-cip ?= "6.12.%"
+PREFERRED_VERSION_linux-cip-rt ?= "6.12.%"
 
 # cross build currently broken, use working snapshot
 ISAR_USE_APT_SNAPSHOT = "1"
diff --git a/kas/opt/6.12.yml b/kas/opt/6.12.yml
new file mode 100644
index 00000000..052b59cc
--- /dev/null
+++ b/kas/opt/6.12.yml
@@ -0,0 +1,18 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+local_conf_header:
+  kernel-version: |
+    PREFERRED_VERSION_linux-cip = "6.12.%"
+    PREFERRED_VERSION_linux-cip-rt = "6.12.%"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.29-cip1.bb b/recipes-kernel/linux/linux-cip-rt_6.12.29-cip1.bb
new file mode 120000
index 00000000..4986a547
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.29-cip1.bb
@@ -0,0 +1 @@
+linux-cip_6.12.29-cip1.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_6.12.29-cip1.bb b/recipes-kernel/linux/linux-cip_6.12.29-cip1.bb
new file mode 100644
index 00000000..5b8fbdbc
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip_6.12.29-cip1.bb
@@ -0,0 +1,10 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# SPDX-License-Identifier: MIT
+
+require linux-cip-common.inc
+
+SRC_URI[sha256sum] = "27bf5750e3ac4ed50b3cca0eb910e330eb3b24ec3d078af3d7d626123ba7b819"
diff --git a/scripts/update-linux-cip.sh b/scripts/update-linux-cip.sh
index e4e170f4..df70fe2c 100755
--- a/scripts/update-linux-cip.sh
+++ b/scripts/update-linux-cip.sh
@@ -2,7 +2,7 @@
 REPO_ROOT=$(git rev-parse --show-toplevel)
 pushd ${REPO_ROOT}/recipes-kernel/linux >/dev/null
 
-for MAJOR_VERSION in 4.4 4.19 5.10 6.1; do
+for MAJOR_VERSION in 4.4 4.19 5.10 6.1 6.12; do
 	rm -f sha256sums.asc
 	wget -q https://cdn.kernel.org/pub/linux/kernel/projects/cip/${MAJOR_VERSION}/sha256sums.asc
 	if ! gpg2 --verify sha256sums.asc 2>/dev/null; then
@@ -20,18 +20,25 @@ for MAJOR_VERSION in 4.4 4.19 5.10 6.1; do
 		SHASUM=${LAST_ENTRY/ */}
 		sed -i 's/\(SRC_URI\[sha256sum\] = "\).*/\1'${SHASUM}'"'/ ${RECIPE_FILE}
 		git add ${RECIPE_FILE}
+		if [ "${MAJOR_VERSION}" == "6.12" ]; then
+			git rm linux-cip-rt_${MAJOR_VERSION}*.bb
+			ln -s ${RECIPE_FILE} linux-cip-rt_${VERSION}.bb
+			git add linux-cip-rt_${VERSION}.bb
+		fi
 	fi
 
-	LAST_ENTRY=$(grep "rt[0-9]\+\.tar\.xz" sha256sums.asc | sort -t p -k 3n | tail -1)
-	VERSION=${LAST_ENTRY/*linux-cip-/}
-	VERSION=${VERSION/.tar.xz/}
-	RECIPE_FILE=linux-cip-rt_${VERSION}.bb
-	if [ ! -f ${RECIPE_FILE} ]; then
-		echo "Updating recipe to ${VERSION}"
-		git mv linux-cip-rt_${MAJOR_VERSION}*.bb ${RECIPE_FILE}
-		SHASUM=${LAST_ENTRY/ */}
-		sed -i 's/\(SRC_URI\[sha256sum\] = "\).*/\1'${SHASUM}'"'/ ${RECIPE_FILE}
-		git add ${RECIPE_FILE}
+	if [ "${MAJOR_VERSION}" != "6.12" ]; then
+		LAST_ENTRY=$(grep "rt[0-9]\+\.tar\.xz" sha256sums.asc | sort -t p -k 3n | tail -1)
+		VERSION=${LAST_ENTRY/*linux-cip-/}
+		VERSION=${VERSION/.tar.xz/}
+		RECIPE_FILE=linux-cip-rt_${VERSION}.bb
+		if [ ! -f "${RECIPE_FILE}" ]; then
+			echo "Updating recipe to ${VERSION}"
+			git mv linux-cip-rt_${MAJOR_VERSION}*.bb ${RECIPE_FILE}
+			SHASUM=${LAST_ENTRY/ */}
+			sed -i 's/\(SRC_URI\[sha256sum\] = "\).*/\1'${SHASUM}'"'/ ${RECIPE_FILE}
+			git add ${RECIPE_FILE}
+		fi
 	fi
 done
 
-- 
2.43.0



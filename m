Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00256CAC58E
	for <webhook@archiver.kernel.org>; Thu, 11 Sep 2025 16:23:02 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.36])
 by mx.groups.io with SMTP id smtpd.web11.1804.1757607776628673654
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Sep 2025 09:22:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Rq0OQSPo;
 spf=pass (domain: siemens.com, ip: 52.101.72.36, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNPs7AohzUAglsKodkqHdttwxpWBELXevS3UITD5pqvZwfnOV/f+C1tFMCXF1boQ4MMH9v2tGH8vCWEs/TkyNqmdvMp3wVEiREg2cKN43wmf4Mvw70YpoOLLoFr0AVghhNOLadgKrpbYEeWputlWfhADaa2zCCqcggOIRQkvEDt74zkCDnqHceu4Clt//OhGGQIg6TuzoLc5j1q/AujIAyDRXBIq9U+XJCnGChSQ8/IJmBRwReopQb5LGDSTq/If+ocu7FgCR6oAXggv/xx4GSy5s9wxZ+PLgMzG3ZOjazcufgjW+lpTR0BS4YycfjjJJNZMmbpFff8DOG6D+yQgTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVM94HCQtXHrtdjjg/u2kZItiaJx6ldCXTD+4v+dtoA=;
 b=PqS8SRvHygMN4s+ksaXuWkFmGCiqCf3se6vv/YveeDxnZ7CUZvoh7CSj7CzHuAN/j3WM6gDrMCJknGxCmLsRC7g5YYRHC2sGCMbwZ9J/Bs6POL4JfMfV98A1/GwA7VKZB5MQ/3kelwzZaSLnF/IlunuQLeL1KDHtIV5BWEFoh2/ISdu5JBbQAdekp2N7mpQfGGlwnZ1a7InNlhJZe0RR9hfsLBDjVvvXAnnK5rFcON/lmXoCDDCgKy9NoslupsFs+oiqSL+6NmTefAXolWmz8gU0EQzrCHyfj0EnuOWKtcbZwHoQps0uIn8z7uosuvjnIUBh2B4OloPDbTppo59nTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVM94HCQtXHrtdjjg/u2kZItiaJx6ldCXTD+4v+dtoA=;
 b=Rq0OQSPo9vOQqTPXYKZq1D4FQfkABEFHfN7DvjtIL9j4bTNuhxxw3yc+pinY/rDvrQlb/2lQBd1LOZt94D0KKd2S0wt9ANHQuS89PmoQfF53RBlLziPU19Y5MSohih+xMFcKdYS7+3EHXaUfKlO0O5iEVCgHo0Tv+A2dz9hEuEYw+M8zlTtkry7INYfbnrCnMdbq6QZQRREszTYwsOoL9NGP2yc9iFvk9eqCe9WrARQaorJ7jl19UEikh07URUEr14LVSTClC52cWFnl4rh7wRz/O1sj6ZdJMtgH0uGIQsH8un8V0f/VLgXXiNlq44MNkJlrFz351ouIL0NVK0PXhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6611.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 16:22:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 16:22:48 +0000
Message-ID: <f21857f5-b5ec-49de-b847-377403c7de94@siemens.com>
Date: Thu, 11 Sep 2025 18:22:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v5 4/7] Add factory-reset
 information to encrypt-data
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250904095231.2039819-1-Quirin.Gylstorff@siemens.com>
 <20250904095231.2039819-5-Quirin.Gylstorff@siemens.com>
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
In-Reply-To: <20250904095231.2039819-5-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: 777a1cb0-8b65-4988-3e50-08ddf14f7249
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WVZoTC93aUU0RGtBVVVUalBjL25pRlFWSDlEMGdLSHl1TDVxaEkwSjNaQk4r?=
 =?utf-8?B?UCsxYmJOM0MrWTJjdlV2ajJHS1Uzck56N2d2eGxSR0pmeFgxQUVsSHV3OWc4?=
 =?utf-8?B?cEV1bXE2VE8yd2ZMTk1ZSVJuMjUxTjl6K3k4MXJBWGpFZmhtM2pvYzBhTURZ?=
 =?utf-8?B?ejBjU2tQY3V2bmZ4OEFlQzVmQjZpQmtZL3NaT1BWcmhMQ3puZ3J4Rk9zQWd5?=
 =?utf-8?B?OXRhUXBMNmlwbElVU09DbU1uekttVkY5MnBkcC9raHk2N0FqUVI5eXNvQXVJ?=
 =?utf-8?B?dCtiVUdHYnU2YmhMcWFtTHhHMXVNakloMjhXL2JSdy9RclZSUlBUaXlHV2xE?=
 =?utf-8?B?bXJZcXIvNVE0cjNMd1pzbDJrZHFYY3R1NVJRZHZKMHdCVi9UbEU4aWRhc2ho?=
 =?utf-8?B?T01Jb1FmZDJ6RnBFWU5xODRZSWVhZVl1RWcrT2dJQ3lJUXpRblJOcDN5andC?=
 =?utf-8?B?TzNIMG1SYjlFTHYrejEvU0VTVHVIOENjTmRjeHEyWmp0ZmYwWHBiMHRac2NH?=
 =?utf-8?B?RnVPMTRXL1RHcVRmWGUyd1NJTDBaRm10MHJ6VWYzMGEwQzRJTGRJTHlRV2Qy?=
 =?utf-8?B?SzgvS09Wd1Q2bnZsd2czd3FLZVZBUFRKQ0VvQVVZQ2VNM2JQTTA0U3J0WjZk?=
 =?utf-8?B?Yk1MNkdWTWFhZDlPS0daTUF3bUdmaXdoQXIxMFMyVXZzUy8rTkw4MkVTRzlQ?=
 =?utf-8?B?NnEyZlFxakxacjQrWUUwMlYrVGtrQmtnT2dPUUtrcWhtMHVXV2o3ODJjZGdm?=
 =?utf-8?B?ZlFPMUFJOHRRbXMvS3dIYWR4ZGpTdzFpWlhhKytON3NZSkZVTUNlaVVJalA4?=
 =?utf-8?B?VjRxVm5WOUxRUEdnVHQxSENMcnVuV2lGa1M0S1U1N0hjdUVRYWxKR25kUitk?=
 =?utf-8?B?ZkVPVmVHbTB6emhBdkRYOW5PbWYwOTNHQW5uNU9tYjBGU283cWUvek00KzJV?=
 =?utf-8?B?NGJQOTF3N1FqbHFLQXUwWUx0VE0wV0R3cU9KU1ZZUXRENjZtc2RJT2RxK1lG?=
 =?utf-8?B?MENOSGdWd1B4bW5mYWZuL2FCYnh3OWx4NjlJb1p2NjBpMkpZNUM3elVEYUNu?=
 =?utf-8?B?Qjc0b2lBWlhIL2MxSFhOT0xzcXBTZ3hBY041K3BuRFNnWUVyRTF0d0EyMXVR?=
 =?utf-8?B?UVpmVmg2bjZKTkJkMVk5cExQNXQxQWIyamZjMVdtSGM2c1RmMjNrQTZ2N3Jw?=
 =?utf-8?B?VTRBWW5oQ0FENlpqbDh3L2hPN2h4T1lGa2VIRXBaMnNFZDBUNVBuSlczUUQz?=
 =?utf-8?B?Q0hqWFhuRy85ZklKY0Mzb0Z3TWVNUFFtSnRCWVZCWGpLcUJ5SHRnSVFCT3lK?=
 =?utf-8?B?TmJMbWZ0QndCa29ONXFVTlBIY0NyZnZuWmI1eTVlVVlZTXZ3OUZ4QWlUdFRs?=
 =?utf-8?B?MVlYV0t3OG9lbzZhNmxXODlUbGkraEo2eEpZeVFyV1BrajkwbC9HeFIwK2Nz?=
 =?utf-8?B?NCsrTFpIS0xuQzhHYUUwUWJoVHcyQUcrMytTVjVXa05TdThMRkJtb0ZZQlZq?=
 =?utf-8?B?OGIvc3dBMG1KYjQrSkNtVVZFQUE4alZIVmdFQkNuU1N6d2xwSjdlVGpiYmxx?=
 =?utf-8?B?eEUzUUM4UmhmM3djUk1HS01oU2hEYzFaZzRFS2doaXdOMWlUNjdsSGJpeWow?=
 =?utf-8?B?YmdCNERLOWlIeEowRjVGb1V3Y2tUM0YxSGVNTTdreG9sQS9Fcm9LSEdpTDY2?=
 =?utf-8?B?dUg5RXlSbGd3ZGpmdHE2cGxGUlpadm9JTmY3cjVEbUdsVnFpUDRIaXlCTlhR?=
 =?utf-8?B?R01IUzB3VFlIRVV5TzRKVDczYUxqT29rTTFRT0hDSFduUDM4MTlEd1J1OVpm?=
 =?utf-8?B?L1RFcnE1bmxMVXVVVHl5YlNHN1hsSHNTd2Z5K0Q3NFFTUS9keDFOa3A4bklP?=
 =?utf-8?B?SkFwSi9yOC9BSEE4RW5QNzBhT2NORGhQQ1lVMVRoNmtwTXhQdVQrbjJodURz?=
 =?utf-8?Q?Ea3GCPBcjYI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QlNjOVgxZUVyODhCNUlyZ3VyeDVjcHJ3b0NBdXFqUG92eWxrejFFMWw5azdU?=
 =?utf-8?B?dzJPWFNqN0NWUUNDZmdyUmdRMlJobzBTbis5Z3puZmtDSWc2TVc3VVltZDBv?=
 =?utf-8?B?bWk3M29GUjdTUHZsVDMwR0lmYXFNenk2ODJ6Q0hHVUcwZlV6aWtzRlBjbExD?=
 =?utf-8?B?a1crQzFkWlQ3dU1pcFk3T2VnbXdNNHZ5Q3NxeEVybDdqUXJERFVFSXBpbHpt?=
 =?utf-8?B?ZWdOSStTNkg5NzFrWS9aRklRQXhnbkRuWGNYVXcxNnljMFlBS1N5aVJRSC8z?=
 =?utf-8?B?d3JKaHRlK3pva2pHbzJUUU5NYXFySUhwNFNJWS9TZ0k5Q21WL1J5K0c5c1Nw?=
 =?utf-8?B?Y3A4S0dyQUVCZGY0eGUwWFJHM2ZZQVRaazdyZjRsOTlqWGpleHQrQU41MnVr?=
 =?utf-8?B?RnJOR1lPdWZXcmZwYmRvOUdXVkJBM3E0Vlc0RUZjSjJLVnVLZTRuczRheFNT?=
 =?utf-8?B?MXppa3Jpdjh2NnhzYmNpeTdSMFpOb1BmTE44dXA3bEhEN0t6UHRyQWN6aEps?=
 =?utf-8?B?S0hQeVI0V0FCR1hDL1YzSzJnTk1TQmEydmY0R2gwTTNSRmtSa1F3bWxzcis2?=
 =?utf-8?B?UVdJeFJNdWhJRVBTaXdkMWhCY0I0VUpsNk9EaGN3cTl6L3ZnejFEbWZzN0dM?=
 =?utf-8?B?T0hXMkkvV2ZzUGs1NnpvR2M1RldWRWtWVFdBZVNVaE0zRHRqK3BpbllpY3Rz?=
 =?utf-8?B?b1RCYzNPak0xZ0UweGZVTGt0bENNYXU0MnRZN0VUaTVxT0NhWTR6NVB1Q1pv?=
 =?utf-8?B?anFLdENQMnQrSENFY3ZLR0FnQm5Rb2I4MU5zVjg3TFRWTlNmRk1IS2xXdUR1?=
 =?utf-8?B?dUZYSWJDUVR3czJ1andITnhjLzdzYnlOMzNSeVQwaFNBcFhlaHl4ald0cHY3?=
 =?utf-8?B?ZjJFWXhKK21tK0dTd2hpRm95UHN5WER1NE1xbEMrYmt6UmlSZm1JVWVzVkZV?=
 =?utf-8?B?dWIxeU1oNDYwRkttMWZPUkJMZEh4bWlUdDZ0L0pEOWhIWHNjNHJRNHl1S2dm?=
 =?utf-8?B?bXE1aTI5YXdMNjYrSHBTbFJBdkxwUEwwb2NWWDhTcnNEbENvOHB6RjFteVBp?=
 =?utf-8?B?bjdLckZsRWVPU1FaVkYrYlhHQXZDdU5XWVowZjFzL2NSRGdpSmROV3VCTzY5?=
 =?utf-8?B?Y0pDUk0xQnpHYVY5ZWZDekIrNEFPL0xERGlMVXBLVVUyTjlOQ2ROQXgyZHhY?=
 =?utf-8?B?SWdMWTU2emJFSmUyTlY1Qm9yazVzdThCc0I1MUZjYVd3NGxmR3dGdTJ4SGVa?=
 =?utf-8?B?U040ZjdzdDFVYmtTelZpb056UjkxVTc2bis0TWRYb1I0NmR3UU90L3VLVENW?=
 =?utf-8?B?ZHpOeGc5ZXB0NlpjVzFZbnIwalBFNm5iNjc0V0EyREttdTNOWDBoRXp3Z3J1?=
 =?utf-8?B?LzA2M0I1RGV0dWkvWUU4eHhwZnZxMlVReXoxa3NzejZwaTZwT01vWGxqekIv?=
 =?utf-8?B?d3dLaTk3VG54TE9LcWJLVGVIc3pGUnQ5cG1xMGlsdUF3RWhCT2E1aDRoc29j?=
 =?utf-8?B?M1JHRnluU0ZlSjgxbUdBK1lpNDkyMTM1M0ZIK3JaRFVyNGZEZThtUEZmWmlZ?=
 =?utf-8?B?V29nQ0NETjdldk4yeTcvMU9ESWo1VE5YZGdlWkVHeU9nbzlNa1FwS3FIbVVR?=
 =?utf-8?B?bmxFaEFoNTBUaFRuMERZdExkRkQxTkRlWEZUK2ZYQ1ZOTW5YSU9FV1BBeHFP?=
 =?utf-8?B?WDJZc1E0bEo5UzZIK0ovc1pGdUxyeEd4MDU0N0RVTVJYNFdqTk9tamJxeE8w?=
 =?utf-8?B?a1N1Z2hXb1llbmtBclpOcllpTDBrZkxRY3NJeEJFemJsbmhkaXE3TUFLeUlH?=
 =?utf-8?B?QVF0L0pkN05UdUpjaTk2czc5RVp2ZWZmaGJBZGQ3dk9tOHRIOEZhMURWQ3ZQ?=
 =?utf-8?B?VmdiL05KUE92SENxbUNkR3JwQ1RjcUVOaFV2bnNDTVVRYWs1M3RwL2hVMTRQ?=
 =?utf-8?B?aW1zZklidTBZVkg3NHZGZzNtZ2d6S05aQ1l2dGcrS0RGZDNxeWpadjhzOGhX?=
 =?utf-8?B?dUt4c3N0dWZlUjYyaEJYZzdDN0gyYnBrcUZvSDZrR3krS3RZL09xTldxUWhK?=
 =?utf-8?B?Qm5XVkNTR0UzbWthYXlpUWJCMzRmcHlGZDZCVWRjMG0wamo0K1c4dDROUlVz?=
 =?utf-8?B?Q29oRVl5N1JYSlB1bVZnc2pUZmFRNGIyS2RIdG14ei9wb0xhRmcxWm16dW1a?=
 =?utf-8?B?Mmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777a1cb0-8b65-4988-3e50-08ddf14f7249
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 16:22:48.1799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cw6HfLJ/6p9NNaz5v2MZfQIbsYXE6V91j29aP0+V70LHYke92iziQ8No5/1dnQpcx1A/cloSjwDfecNa0rwfpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6611
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Sep 2025 16:23:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20043

On 04.09.25 11:39, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas/opt/encrypt-data.yml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kas/opt/encrypt-data.yml b/kas/opt/encrypt-data.yml
> index 3de76ab..4292d4c 100644
> --- a/kas/opt/encrypt-data.yml
> +++ b/kas/opt/encrypt-data.yml
> @@ -15,3 +15,6 @@ header:
>  local_conf_header:
>    initramfs-option-encrypt-partitions: |
>      OVERRIDES .= ":encrypt-partitions"
> +  initramfs-factory-reset: |
> +    INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE = "/dev/disk/by-partlabel/BOOT0"

Hmm, it should ideally be the currently inactive partition so that we
are never corrupting the branch we are sitting on...

> +

Extra newline.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


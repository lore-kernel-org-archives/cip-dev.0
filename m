Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEB3C41513
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 08:08:36 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.73])
 by mx.groups.io with SMTP id smtpd.web11.12891.1720166906670058621
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 01:08:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BjV5/tPO;
 spf=pass (domain: siemens.com, ip: 40.107.103.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RI/zHhoLQMnQqwkVDrc3Y+eNmHKuLljibjJJRUMLuiMwUIQEfbSsM70DHuHJY0DfTwSHvrbs8ysRJWEjAvqzfIrEIMqgR2+jH+8T517YNyVlkbTKnTd61q0xuHjjAwFoIr6N8Is7S5emPrKMSFzJ1x9dpywQoHM+v1LiG8wJgMtD+/VEgp4lwEXQI3mkmiw87TPM9RzFYFYO132Df+CWupA9BhLk89Z2jGzhY8lMbqPhOxUp+rnbnmMDUbbVaI7pIA8W0aa5z4UhKF26Rlwpwr+qXbXjTDOvLkDFo/UpwRuseH5Nejku18hkLGmRLPF0SuklUP8Ao3ogO0L6Q8bM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fE4A07W+RoPE8I5bR5vhpSMA3ulffLjoaN3e+ug2Zp0=;
 b=exEzUy7jI3t6p+x+ON9ockqLsX+oZGIYBVg5ZocgyaKTHiswKZPEeRVPbm5/OFLUqhKNKHOCezyXSgW96L0ptPbnYijwEazSAubv8YMt0mM/nqufRh2na1teGQf+z/BohXlobB17hAjyfpdcTgl/VTO/RD3wcYQU97kMekoobJ0JYD5fLyOZt4m/MybD6hVS6hRPWI47Fz2AMNNeIPS/xMpbr2DiHj7SihL5kuchXQK1EpKsJQC8qIMYqOvGMQEF49zF0x5/oSBbkOSVv0c5sbKvldumVb2bGFrJssK+7r9XKFNjIuTw8foywK+nLhU99gTwkIuSPQU7z1YuDc0lMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fE4A07W+RoPE8I5bR5vhpSMA3ulffLjoaN3e+ug2Zp0=;
 b=BjV5/tPO9QhSTrUkvAsmjariP4is/DRq82Ymc6WrjAlp2dwGTTw/BZucL1gCNuhhWRREigHZW75RGWHt9n0tOqbQwUFAm74mYWGUL2HWeJd5kRifd2UrnKa4YHGWp5+lz1U013/0RKCkR1HTKI7rqXN+1jjIQOChiv+ANQ5MXhKWmqfTZi8/Wz3UOtgGjuEC0E/j6wOAssLMLzlmEi/ltE/qfCLQCkYusKPmHevb7QpgCYSWdeFOrv6RdsqMX5c5smESMpLa4WT/26SXFRV5UdZUAmcUI/PhJVI0neCCy5ykfmbMZ5dujv9grpycNhj1mYB0pLq7JsEOIcNr7hi/jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7119.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:442::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Fri, 5 Jul
 2024 08:08:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 08:08:22 +0000
Message-ID: <8fc0b73c-5185-4bd0-952d-7f01aa2a1a2b@siemens.com>
Date: Fri, 5 Jul 2024 10:08:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] swupdate.bbclass: make swu_files entries unique
To: Claudius Heine <ch@denx.de>,
 "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 Christian Storm <christian.storm@siemens.com>
References: <20240703114242.1896508-1-ch@denx.de>
 <7a7ed1e59a5682144aaaad819fbbd1264f3ece34.camel@siemens.com>
 <204be939-3a9e-4210-9194-a70ac83640da@denx.de>
 <349d4345-dfa5-4925-b9da-8217b6caca64@siemens.com>
 <f8734192-f1f7-4cb1-bff8-edc950eb390e@denx.de>
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
In-Reply-To: <f8734192-f1f7-4cb1-bff8-edc950eb390e@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0259.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ee98a4-3924-48d0-f774-08dc9cc9a385
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?clVxNHZ6UTVpaDcyZzl2ajBDcCtjVGZKZTkwclFmOTl1M2UyTGNhMUw0Vmpa?=
 =?utf-8?B?ZkszcU5RWHNtZm96NTJwaHlqQ0FSWFlmL1VmWFZVcngvY2Q4QWR4REJ0ZW9M?=
 =?utf-8?B?QU5nOTluTFB4U3YzNjZyQUErTFVxWkdNaWFGRlVvVVRNdkJaWE4vRmpPVGt4?=
 =?utf-8?B?aE03dUp6bmUxZ2t1RFUzTThqU3dPb0NOQ3VweVJNMzdwbnlrcUNSbWswVU84?=
 =?utf-8?B?Y1p1N0lTL0tVSHJhSzBLYUY2Nm9PcVpqcjh0eERqa1QweU1ScGJQakg5SVF5?=
 =?utf-8?B?M3V1M2ZaWU0xU1dQTWN4TS8vdkNUL1krTE9jQTVHSjBPalQxN2lrNEd4Uy9X?=
 =?utf-8?B?ZW9keGtmU2Faczk2cGxxbVRxVmkrVnc2SGJGd2RBUnBxWHFUVllkampnRCtk?=
 =?utf-8?B?L2Y5aWNXZ1dXYkNuY2F1R0lhUlk1WS8xdlhic3J0ZERJUmtBREZ6N0FNVU1a?=
 =?utf-8?B?S0lxaGVpd1VWc1NHUmpXTHBrSjZUamExSElzRUcyU2FmQ1EyT3RVbVQ2QUtC?=
 =?utf-8?B?Qk9kVjRjRkJMc3hyQk1ZbnN0ZHVtb25lM2U4Mm1mWWZtUXNlUEpkNU9FcExu?=
 =?utf-8?B?c050U3dZbUxESDFsNS9xNm9xZHc1OHJKZDQ2TzIwb3FabGV1czhLMjhGdEUr?=
 =?utf-8?B?UUFzNmlhNnVSZElZbU55Yi9OdW54VGhCS29OTVVHbXlmakt2ODVnWGhjUWNa?=
 =?utf-8?B?cUdXemorZmJ5bEIrQ1FMczBRTno0NEZoVFp5ZGVENFVhMURESjJQakJYeGlX?=
 =?utf-8?B?MmFBYTRPMThlK2lIMDZVOTBMR0UyVFVBVVZHR0FCT1FMMEU5bGxyYmdLRGdG?=
 =?utf-8?B?clVma3RWOFFJM3p1eXZxd29LdHV5MW00ZGRQVVJnbmRvay9aM0JaWVZBNFFY?=
 =?utf-8?B?dFhXdVVRVGdzWWVsdFRBWXl5dHIvbTZRTmtTMG9scGI1SHRmQW5pRVQ3cWl6?=
 =?utf-8?B?V2l3ZUpvMEE4dzR0em9qYUNObU85RFBWbWZ0QUt4VWI2Q2hqcU5aNU9Rc2li?=
 =?utf-8?B?SzY5WGZRbkt5a3FoaG1NeWh1aVllV2czUmFnbWlmYjZnTnVadW1pN1JiOWFF?=
 =?utf-8?B?SnVRMzM0c2wxUmpocDE2bjU2bFIrYmwxZHFhczNObkhGTXJOWVFkRjlsUlFo?=
 =?utf-8?B?S3lXTDM3VVBqMVFBUUxSam9UZHl6dGlRNklFRW1SZGJrWlpUTUdUNGlja2Fi?=
 =?utf-8?B?bXBjVGhRSXNqSUh6akJta241dE1sTk1hZXE1YmpGNVVKQjZVZkcvdVIwRjUv?=
 =?utf-8?B?TTJhSW4wMFBxRjRLa3ljQXdWK0xoZ0tXN3k4SnN1Mlo0VVdQVWlpektHeEpH?=
 =?utf-8?B?Z0FCQUxkakQwMUE2T3IyajFyaGFmR0ZDS3kxZFJhTjFKTDFNMS8wU0pZb3Bu?=
 =?utf-8?B?MkFmT2xUNUJTbWlSQzlmbjRJK1R5UlcxczN3SHJYamxrbFJWanYzcDNPNmxQ?=
 =?utf-8?B?WjV4K3grN1ZhbFIvdmYyc2dNa29mbjVZWTJwT1JMMzY0SkZoZnRPOFJMN01U?=
 =?utf-8?B?OHZFSnVqSitXWXdzR1dFdG00RHhvdU9SYjBjNDNvWEkrMVJKOFU0RW5rUlJ1?=
 =?utf-8?B?U3VnT0NKREN4b0JWd1pMV3AxTk05cTN6THNvZ3JXWDlmdThpM0RVcWxROTFN?=
 =?utf-8?B?NFMvRm5OdEtHVmRaZ2IzKzk1dy85TE1zSzJLclpRdzNJSGZFU25sZmZEa3Nq?=
 =?utf-8?B?bjRlUFU5b20xUndaT043djlJbVVCZ0w3V1c1R0EzN0w0L0hEa0dHRS9ZSnN3?=
 =?utf-8?Q?3i/WXmMFhB/DhtTNn0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dFQwU1EvdzNZS2IzZTY2N0gvaTdEMDVlSmpNTDJKNS9BaDBpNk5jQ1pkeUxu?=
 =?utf-8?B?UXFrTml5ekNPd0MvMXVYN1NESUFGTGxYaFFjMFU2TytHQ0V5WDJQZnF1VFlV?=
 =?utf-8?B?d2NuVmtjUTAvMmpHc0c0MlhNdU1rM2hNZFlNUGl0eTVMaG5XU2wyZklzbmNn?=
 =?utf-8?B?OEJCdHRHWnhROWJCVkE0OHJZOEJ4WGt0dUJQMFkyT2JCaVlXM1NuZW9mRFlh?=
 =?utf-8?B?Wmd3VnVraXB1d0JpcTFVeDJJSno1cExzZlQvbkRncC83Q005L3VkbU53QXNs?=
 =?utf-8?B?azN0UUxNelM4UkNTbWdxbGRnTExaZXJGaE9uc09ua2pwNXhINU1YL0ZKM0lm?=
 =?utf-8?B?ckdWSVd3eWVkb2gwWTZhZWNtMVdXRktRSmd3UU00bnNhVUhmSUxqdlF1MnFW?=
 =?utf-8?B?anZHNEVWQUJoTWd0Yy9MN3JiLzhyNWtEQXE3cnB6empDMVk3QXhGdWVnNUNE?=
 =?utf-8?B?TWtaaDd4OTAvNkYwTEcxWGhBMGhkK1U1M0tuVDFVWVVCNDBUbS9JVUpJM0I4?=
 =?utf-8?B?TFZ0SE1NZWVRRkNRK2pZdi9jNEYwTGRCVHN5L2xWTW1vNlNhdnM3ZjdPZldx?=
 =?utf-8?B?VjROS0lSQzlIb3JUc0NjdGVaN292KzBSNUF4RTZHSFNSS3UxQ000RmEyWE5S?=
 =?utf-8?B?K0laM3EvRnRscG9qQWxxcHVvS1ljb3ZHQ2J5WHlNeFlxNWo0ajc0QWJ2bmM1?=
 =?utf-8?B?dFlhUmRKbEtWZkQxKytQalIxVU11QkFKNGhnMjN1U3ZVM0ZkcmNneEs1dHFV?=
 =?utf-8?B?dUlVcWc0UDkwQVZzcm4zMDhpRjlFQ1d6cmttVEpWaTB5OGNTYmpMWEo0emhY?=
 =?utf-8?B?bmVRQjlTK3NGWGJDbUxkZ01rNUxscGk3WUFVdWtQbWxDQUxhdi9NOWhKdGFL?=
 =?utf-8?B?aFphdmhEM2lqYWwrcDBEZitZcFNiZ1grU1FlQzd1MHFsNGdiQy9lOWswVzY3?=
 =?utf-8?B?NGQ3Z1ZqYjNKQ3FHdDh1MEpqZEF3aUlncitoZGJ5Y0JmR2N5K09haGZzbnll?=
 =?utf-8?B?amp6bkpyWFFrRHNYZDdqWnZINE5GYnl2K1VVWWZuSkxEQnFIaUd5aDU1SGk0?=
 =?utf-8?B?UEpBd05qYmpIakpka1hOdkZ4YStjMW5UU0FVN0F6VVcxZXVCcVJ3dkJsSDRl?=
 =?utf-8?B?b2V6T1cxeGMvTEpuV3lLTFkvQlFTcE5hN2hzdTEweWptVXdtODVkeXVmQ0dU?=
 =?utf-8?B?RUZ6UWgxYWFzSW9Bb0tNVTZyZThmNWlhMXFFTEhUOWlYV3pMQlNkOWRRbHFJ?=
 =?utf-8?B?dHdFaG9VY3l3SkJQTVhTVXF4eWlkaWxjWnAvQW9SVENjVmhPY3dlUm96S2dH?=
 =?utf-8?B?WXF5TXlQWG5NaEpiUDkybkhIK3RWVlhLRHpNWldOcDMySTBWN3ZTMHNvSURM?=
 =?utf-8?B?S1V4cGNRRXp4QUt4d3gxZ2JEYUpNMTdiVDhzMCtsK2FXOXJDNmp6REZvSVBB?=
 =?utf-8?B?SjBVOFYxbTgrdE0wZVFQaHBpUVV6TFBQQ0paeWNrM0lpMldhaDJoSjZ6Wmo3?=
 =?utf-8?B?eWJYNFgxeTJSMG9nTGVVWWc2akVXWXdFZmcxcXFOWm9veFMwMjUwVFMycjdX?=
 =?utf-8?B?YmZsUFNsSFk0aHIyb2d1eVRwRmpCNXdJVmozRGMyN3hlTDM5ZDE5dURYUEh3?=
 =?utf-8?B?NmdVdExtRWdCeEdZeEVobU9EenEwWlU4bFVpVjFsMDBNUWEraVZuUjJOWS9h?=
 =?utf-8?B?NXhzeGN6VWo3aW41c2kyRmh5WmdGbm9rQXovYVJ2SDUwVmtHM01Ja3UwNHU1?=
 =?utf-8?B?OVhBSXBPTDIvS09EQ3FqVENFYStmdlhicUhxWXovUHNUeElUWGNvZGxmdE5D?=
 =?utf-8?B?T0YweG0rbTN3K1p1Sm9jVVFTQVB6MktMM3FOSDZmdWdzaytEU2lJc2dUNVFR?=
 =?utf-8?B?aUg3TUl3cEJ1dS9kdzlSN2o1TWZLNHJ4cFBmWGV0ajhja0R3QzdWazR6M0Qy?=
 =?utf-8?B?WXQzN0IvSEo3UlhoVnlsMEY4TzFCa2gwTWdLcDBVaWdMazEvV1QweERDZ205?=
 =?utf-8?B?dGcwQmtRenk3V3ZjRUtsbHB2WGp5R01lQlhUZVhnVEpKZjZoRHU2VXRaejdP?=
 =?utf-8?B?aDRMNTNOK2VtSHJkeE5CRVNGTEFBemxUU2lQVWhyN0o3ZzlsM3ZzMThJV20w?=
 =?utf-8?B?ejZPVzhaVy84aTQ1ZS81WTUzZlRqc1dyZFA4dHZFY0o0TjZucUc1NTRaUVlC?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ee98a4-3924-48d0-f774-08dc9cc9a385
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 08:08:22.6562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYg3Uc8o7NvO19zttiPlQ1Q1qKfNvzpcJf/zE/QoA4utletRkqM/JQq01YampmQv7s+rTD7MfNWvrMkBgfj++A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7119
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 08:08:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16390

On 05.07.24 09:55, Claudius Heine wrote:
> Hi Jan,
> 
> On 2024-07-04 11:45 pm, Jan Kiszka wrote:
>> On 04.07.24 15:29, Claudius Heine wrote:
>>> Hi Felix,
>>>
>>> On 2024-07-04 2:15 pm, MOESSBAUER, Felix wrote:
>>>> On Wed, 2024-07-03 at 13:42 +0200, Claudius Heine wrote:
>>>>> In case a sw-description contains multiple entries of the same file,
>>>>> swu_files will contains multiples of the same file and thus later
>>>>> operations fail.
>>>>
>>>> Hi, I'm wondering how that can happen, but OK.
>>>
>>> How it happens that there are multiple mentions of the same file in a
>>> sw-description, or how it happens that it fails?
>>>
>>> Multiple instances of the same file happens when the swupdate software
>>> collections are used to implement A/B update:
>>> https://sbabic.github.io/swupdate/sw-description.html#software-collections
>>>
>>> There the same image can be flashed to different devices.
>>>
>>
>> That's a pattern we can avoid these days by using the roundrobin
>> handler, see recipes-core/images/swu/sw-description.tmpl. Doesn't make
>> the collection pattern wrong and this fix unneeded.
> 
> I'm not sure I fully understand your last sentence, but I know about the
> roundrobin handler and used it in other projects before, however AFAIK
> it is something specific to isar-cip-core. I haven't seen this used in
> other projects outside of that.

I mean I'm still happy to take your fix.

> 
> From what I experienced, outside of isar-cip-core, the software
> collection approach is much more common. There we have swupdate wrapper
> scripts, that figure out which software collection should be used, and
> call swupdate accordingly.

Right, and that additional, possibly ugly wrapping is what the pattern
in isar-cip-core avoids: You just call "swupdate -i my.swu" (or
equivalent triggers), and everything works as it should.

Christian, seems there is a gap in awareness for this option outside of
the isar-cip-core universe.

>>
>> Still, you may want to check if there is a real need to have an own
>> sw-description.tmpl downstream - or if there is anything missing in the
>> upstream template to make it even more useful.
> 
> The round-robin handler and the isar-cip-core specific
> sw-description.tmpl might work well enough for projects that start with
> isar-cip-core, but some projects might want to switch from something
> else to isar-cip-core gradually, while preserving update compatibility,
> or have project-specific use-cases and handlers where it doesn't make
> sense to pull in the complexity into isar-cip-core itself.
> 
> The platform I am working with, doesn't support EFI, has a two grub
> bootloaders with custom scripts that chainload another, has embedded lua
> scripts in the sw-description, wrapper scripts to implement platform
> specific ways to trigger different parts of the update process
> separately, very specific partition layout, and so on.

OK, that special one. Well, if you have to maintain special
swu-descriptions for other reasons, then it is hard to reuse things from
here, true.

> 
> Preventing alternative ways to implement the product-layer from a
> base-layer makes it difficult to adopt it.
> 
> IMO having a default isar-cip-core way, is great, but it should be
> possible to go a custom route as well, and to deactivate or change
> whatever is necessary. IMO, this is generally how bitbake meta-layers
> should work. Otherwise people will either require to carry downstream
> patches to layers, which should only be done in very specific
> circumstances, or have to copy & modify classes and files into their
> layers, which will also make development and maintenance more difficult.

Again, I'm fine with allowing software collections as well.

Jan

-- 
Siemens AG, Technology
Linux Expert Center



Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.1])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11899.1795006758136454910
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 04:59:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WIyZXeGS;
 spf=pass (domain: siemens.com, ip: 40.107.159.1, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ne87wQQqzYNZwzjCNABbX8ZzSG8ZlFZ63iDE11s+gY7oLxNpro/KV8QRwXVxHanUOJhS3mzWBgpgf1PHXS6J83L+YnND7Tn9s4ER18vC2VbWv5NiVqn2RGwVDI6BdpmB7nKaxEi5zQEhhUQ32MSWfWUtchGbzxxnAlYNQ+qnilMmVeYG7DziTTVsP7dymaxXI2FoTEaVsjnltCmDUd3ibgEjBpnRMdYEtNW/wFP1sfb9Fuj7CC1j+v9v0A8auHdpo5IZ6JkkGAKZokROSt4jhy+976SEW+WrJ2mmtjhmEMM0jo8ye2cLvDb14KVhJi9OvimoQD411SYFoJjr5/t6nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yo3UV2/ko9JzrW6qzo7nPRTuPN6GW9ZmPT8JxFxdc5k=;
 b=lzl0vNzhrvLkRcW5oBZqiN0AJqouIRcvWWhvbJCf8NYEfxGsFloEBH/R6mW8lK/tjaIY7lvxPi3+H4mlFl5tkFtuP2lNxYZCdlh2cCWQQKUyGZAsT6nxlkqW9xuhZgMQPQztsGuqlnlNKtJRIitEN+hqz6O6Hk/Qcm/4alC036Y2yvcqNhFEJf7+CqTjnrrYQfa2j7QkNgFXGai2pd6RsojxozgnTZkyU1nQvTYmRV3NPcnESQOVXXWp6sDlzJWu6122YJymIfBTkrnRzpBiLE1WdZmIC7QXlNVLXdwo/xaTrNCEpaM3oebAaAcn9GeyHB3rDq4Cugrb5zpm9polig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yo3UV2/ko9JzrW6qzo7nPRTuPN6GW9ZmPT8JxFxdc5k=;
 b=WIyZXeGS9O8gg00CqY/TcvTByLCIOeFmKIOJQ53a+K8AuXC26wxQRDKS+aknzx28VVKGV1yJqjIFl0xRjrVrKH9u2mE0SSaSTAAWCvlCxJVd+eBzRO209zjUJp8D+m8H33vKXoDRBBPq92F3QNog5XL+DIy+LivYjWiATV6b4mJkjSuQqGH4MBhCiwI5Xvq7yn3eWO2ZZzrx41lBJ0JxIZ3sSLd8PYJUfMlFM7xZbMiKLxEb6nB46ibPAyfsIIJtogvQ73M0gSu4YX8R6jxqf1/1QFGZvMgk+xBK8AOKfJCBzDj8H2Vf8An1pfy0gLzEczePFVqckaqN+QkfuvN6zQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AM8PR10MB4017.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1ef::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Wed, 18 Nov
 2026 12:59:13 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Wed, 18 Nov 2026
 12:59:13 +0000
Message-ID: <51eed7e1-c4a9-40eb-bf77-703df28a43d6@siemens.com>
Date: Wed, 18 Nov 2026 13:59:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC 1/1] convert wic plugins to
 execution-from-host model
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: clara.kowalsky@siemens.com
References: <20261118125412.2039363-1-felix.moessbauer@siemens.com>
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
In-Reply-To: <20261118125412.2039363-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0328.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::7) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AM8PR10MB4017:EE_
X-MS-Office365-Filtering-Correlation-Id: d320b172-d7de-49b1-c961-08df4573bedb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|6133799003|55112099003|11063799006|10067099003|261026121527099003|261021123027099003|261021121427099003|56012099006|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: 2HZ5dne2Wnp2YiZOomE4taDkaAXLi2FdjCBhpDJ3niPleIRwgH4C3GBe9AiYJnW+z4d4ID+90jB5G/owYzuDUmSl/1ztSeZjkTPxtagq5K/LbfUyQCwa3GR2ZT9gm3tWbj1Oj2eb2YHg4y3LcvFCKdd/tE2jP4iZK79X5zetLAxSYIxNKw3fqXvleL0PGPq1r0FOgilKWOz4t28ergTMRtSiPs6GWotV/z7f5xV93cQE+tEh6V6u8cLY1qb6qV4MrT2kar6bmwk96yt7n8WF2rmgtY6IpLvTs988vHabdFY7nNnehRwrVmUhy3vZ5qXkHc8jmq1bJaIih/hf3pucXozWzBekQTedqgdVHctOZLdslPSSN6nsh6oUq9PUFB8gBeSctG2+7P83dSKCVWbHb/ZUf7hAJSub7vVbINb2p/MfEUZ+/M5UMJfAljFJkW1YJg2c7Z1m8P4Y14rYDAuMNXMHIhgfUUe88RpUzpoD7BIkoInDSnfr0bIikipHeVgmS8iHAQSBWbqtVFrkeYRquiV6KHsRpSwbdsYjaWcB5kx5HtQIZpzg+CPwwyeFRi21+3HDp78kz4/otHNCthdj8jO7SXF99VZzIaQB9ivKUOo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(55112099003)(11063799006)(10067099003)(261026121527099003)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjJjSzB5MnlDTjJMMEkrQUs3dnJTYjE5K0hHcHVsSkkzblZNWk5ZN0ZjMGRS?=
 =?utf-8?B?Q25xaUhNUEpWYmRHK0Z3QXVqbTZETHErRmVmNWFndG9rbGRRbnJubFhTSGJM?=
 =?utf-8?B?NzN1TjEraVZQVVZYNTFvSmFVUzI0bkxqZ0hZL2ZzMkJIcHRlNE50b2dBV1Nm?=
 =?utf-8?B?Sllac3FBdVdsMVh0ZGROSEhOL0hzcnpqOXlBcC9vdFgwYjdZQnFTUDIyQ3ZI?=
 =?utf-8?B?R2hwL0ZWRS9ZVUJXU1NMOStYb2UrTEVBRWpEUWIxbTA5b0IvS01PRWxtdFY1?=
 =?utf-8?B?SE5hdFlFZWU0M1FNeEpCQ0ExdDFCckNqSE01RktKMUNjdjBrWk0zN3VHc0RD?=
 =?utf-8?B?OUYwMHZNaThIenVSTWJ1OEtJbkhOYXA1VVp1Q1NUYlAxaS9JWVJFVy8zMGNq?=
 =?utf-8?B?TWlGSW0zSHExQWZKaCt2Vm9DZ1IvcW1FZnYzUys0dUxPT1Vod0Y0bFcwdURw?=
 =?utf-8?B?WHhvQkNwZnhOZURDanZWL0hBbnNIYnM3RDJreVpmcHQ2TFlJdmdicXY2eXhE?=
 =?utf-8?B?NEd1RmRJLzZRR0tWempMbGsrd2lVeTBGNmRYL1F5MTZOZ0RHQUhEQ2IxR3pp?=
 =?utf-8?B?RUNVUTUzZldYdnozVHI2alVJaU5UbG9xUXNvWXdXd05hUWNqNE9XeVBLcWJJ?=
 =?utf-8?B?UDNCNFpKTWlFTmJDVG5iOUE4eGVNVHdSUGZiZFNiRWFYTW9HTUV4TEZUWnNr?=
 =?utf-8?B?OHpoanFSZXhibzA0d1c3SFExMytoUHBzcUVmcjFLWjJ4UlV3RzI4N1VPZlg4?=
 =?utf-8?B?dnh2VnVHN2hmdXhGcVZXTGVmNFRkcFc5L1dEMkc5VStFQldRS0RHaVVKTG5j?=
 =?utf-8?B?MHJ5THhCREx0Nk0rcTNBd3JPeGdRTHorYmw1QUNEQnRvWnZ2NllXK2NWbFhB?=
 =?utf-8?B?NDRySjhmRzh4VkJMZUlveFhOMkhYT1U1V3lETGVyUnNBMXREUmE0WUJCaHVr?=
 =?utf-8?B?MkFwVmZpWDJMeUdyS3YyYU1wSjVaUFliemIyeVVDMFVkMXA1VXhjWGIvazJP?=
 =?utf-8?B?bDFMWCtwRnM4Tmx4bUhhRmJZbTZBNEJ0YjNNYVJtUHIwaytBdTZRVWx5N1h1?=
 =?utf-8?B?RGsxbVNMYlhaK2JzRjlySEp6SHBQN2Nwc09USStQUXdXM3k2YzU0Ylk1eDRQ?=
 =?utf-8?B?Zk1icVAvU05FWG0zMWxaYjVTSHJ4S05qKzQrMHhGRzM3VmxhMk9NME9pbk9S?=
 =?utf-8?B?Z1pQdFFJc1RtZEJqdnU0VDBGM1Bwdm5yY1FBckgwNkZ5WWpPQUFKWm5zcGhT?=
 =?utf-8?B?eGhSUHdYZ1Vaa3dxQTN2MEZld3FDbzBQNVU3TGhxTGI0TENwR0ZwUW1CTVVx?=
 =?utf-8?B?RFdaL21yQ1Qrb3dBNGpJT29EMU5NTXY3Y0p3ZGJvRVB2SlFXWlBmVjFIWTRJ?=
 =?utf-8?B?TDJVRkszRnFIVyt6QU15NW9IdW9EcXBNcGNjMWd3OUoyRzZLZUFlTTlNVFQr?=
 =?utf-8?B?WGtOSVB0SjRGS1hxWG1YdnVpdGQ0NEN5QWpqNGw4ZEZ3dEgvZldPUTM5ckFk?=
 =?utf-8?B?bGMxRUMwUlRucmphL21vMjFDM05DUHZIQTd3eTZ4aGkvM0RpTkJPUk8zY0Z1?=
 =?utf-8?B?dThXV0ZYVXJCS0NHZ3F1ZFlDSUlZN1FzWVRGczRlUFp1WElvUTVOT1dDK2Ji?=
 =?utf-8?B?YVNFc3AxcG44aUZtQlNwai93SnpGSkJVNW80NUNNT3R0OVhOUjNHRE5SVDFu?=
 =?utf-8?B?V1hMTnBWdFFuVis0STdiR1ErY2I2Q29xR2d4UDVWYm1Lekx1RG9TdzVEb1ly?=
 =?utf-8?B?cnpYMHdrOXJGbmVLcTA3YXo2cStDbnozeUNYTFZHSEIvRGx2SGNPSk90dGM2?=
 =?utf-8?B?US8yeHJIRDdBc0NnWU41MGFQY0hmVUZTcDFHSGwvcnlORGV6WjkzQnRTcWkx?=
 =?utf-8?B?TXdobnlMZXl6U3NZaUZGelJ4WnhmOTdxMnkrOGRMZkFyQVhtR3EveWNPTjNa?=
 =?utf-8?B?Nmw0eE5EQml4UWVZK3RyRjNyekUwS1ZnR3paT2xQbkVEeFVvTW8vc3hsaGls?=
 =?utf-8?B?UmZwN3BFRUdkM0NhMXJXNHRMQWxJOHFOa3p2KzJRdTBqampmcjNiZnYzSFV6?=
 =?utf-8?B?OERMakFFMXV4MFVCdS80SFp3SEEzOGxzRkZ4TGRwWTN2U1hNbWRYVmVEcDdG?=
 =?utf-8?B?R3Y3L2ZScld5Y3p1d2F4UmI4eTVlV1JqOUg1UVlIWENyS2lYc2RuMVB4WjNn?=
 =?utf-8?B?L2k3UVBiU2RTMy91V29MY3FFNG9ZMHZVRUQ1RXBZUlpkNko2VzlKTXdSRCs4?=
 =?utf-8?B?RzkwbTV6U2N2RWp0SDlPcit0YThMQmtsY2VFeXlrVytwaytKYUdWdDJ3OUdh?=
 =?utf-8?B?TWhvbmt3WmNRRFNpU09Oa2w2RmxEZUZQUXNwclExR2h6RlNGQ2U1Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d320b172-d7de-49b1-c961-08df4573bedb
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 12:59:13.6313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXuFz8l6TzmfLVxjedFEjrW+YNO9zgRK5ulPEAt8ruS+5cRY/U44mVSZxsiniUdCNV+NW5i/IreUw6n5I/dIYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4017
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 12:59:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24956

On 18.11.26 13:54, Felix Moessbauer wrote:
> We convert the wic plugins so that they support being executed via a
> WIC_TOOL_RUNNER. This change has to happen in lockstep with the
> corresponding isar update, as it is incompatible with the previous
> execution model.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
> This patch has to be used on top of isar with
> "[PATCH v2 0/6] Update BitBake in Isar" [1].
> 
> The _tool_path_exists() method should be moved to wic.misc (in isar) so that
> it can be reused by all wic plugins.
> 
> [1] https://groups.google.com/g/isar-users/c/NYmzKbKTqH0/m/BTECiBRVAQAJ
> 

IOW, proper actual patch will once come with an Isar update and the
changes below.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

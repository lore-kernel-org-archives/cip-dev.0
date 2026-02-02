Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD33E73172
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 13:39:08 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.36])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.52285.1770039543424107359
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Feb 2026 05:39:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EeBQzvlE;
 spf=pass (domain: siemens.com, ip: 40.107.162.36, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tA4sSWB2yyYaYt5jxFG4bQTvmuF1oVRIqGYA6AzDzUjT2HnH1VkJMQxAfaL6D52U9rHWK8mX4EmQiGVSLlkbC8hTWzLMQGGtBFvvnPmKiTYs8g0+sHhFOzArzV4huSDsPmeCX4O6d2ul1gHv+imi/1lDVweZWMgDKEypgFIFtgWsBu8fPlbJhg9bFcXPdoj/WvuZGrTfksDyUb067dWdH5B6kt68j78iE1SWxJpygiZxmXukYma4QSObylkwBytYCHdGv1bX9ftq91sy/wpc+ZMw2FDjUd4WApcoXRAOK4/8DJq4GNo3aVC5iHVFJafCJZHeoMR6IMquae7oT+B7QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HClqy+w+CUENqqgiIlDZGJOplZRwISzooO2Q/9AHp/U=;
 b=o2VkdNmFHzjpbp1lt2VUZTEEdTYxojhpxiSa9N0t1wjbDSNqRVzZQCXQAVsV5FZGUs8TpIHSWKjAfU96Pvdu4za2hdn6PUd6XF0A+yjWMNVUtQYNkLKG9VWdkIzUOCL2Jix8fhC3ex8XEqRUTQsHpT2aZBGog7CWQh/84Bb0223qXKLIXgXd0SuevT1E/yXez6OyBsIHFBNQNJbAsoP6wevFydY4BbUSVf3CmougeHVb6q8SJLtv5TzsHs13P2cTYcYKyYRQirQwxySfvXnYXqjkWcLxWM7QhlK19EfrrTaH9ZmvuC6V+5Ti0nxRGhgAnocpHjEb1kaAM4Xn+lRQRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HClqy+w+CUENqqgiIlDZGJOplZRwISzooO2Q/9AHp/U=;
 b=EeBQzvlEjzEtNeH8QwA/FNYBlEAsYxglKJueSDpdirNGL/gapVV100/yUZbJw7tGXwQjLYpg27laP/8xKrbh6tgV918l+MHB7/t4OhPzwaBJkKSwGbvR2546at/yisXfTXKqZaK67N4Xtf3Ua4+P3f1pQnJklxAtQ+Ra6RlDLO+/dAHqzbtPH5elnGjpPTETcc5sASFs3wlhAKSdLWSQVSxSDfq+GzJmLfzh9OyNct/NK3TyaM7ascQH3pRvTvgiyNsaGwBsCr3UGjDlPltgeIRt7aPuhnLvWI+7VkhsPaMq5JVHyIdE05yRqqUIO84Gv3zTEVw8METTqfl8a24hWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7020.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 13:38:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9564.014; Mon, 2 Feb 2026
 13:38:58 +0000
Message-ID: <2317f5ce-c9b6-4177-af72-1cb0ac61cb01@siemens.com>
Date: Mon, 2 Feb 2026 14:38:56 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] optee-ftpm*: Switch to new class
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0a86ee-6dc9-440d-7da1-08de62606b24
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QkxHT0d6ZW85TkNkT0JaTHMzSHhyenNObXdBaDlpQk9KblhaY1ZocmxhM2Rh?=
 =?utf-8?B?a0hEYjlKSzJOMFdGeUJZWlFES016anpIaWY4QkNybHVmNUwzMG12azNqSVls?=
 =?utf-8?B?U2RLSlliRUh6RS95SGcxZ3pDekMwMlFveFpGaSsyWjZ4eURUVFF6amIxWGxq?=
 =?utf-8?B?TEJwZzRUN2JUaW54T1JFRmJSOWRneUU0d1FhSUpXYUhJUDdZcHBRK3FpaVhQ?=
 =?utf-8?B?L3EwWlF2aUJUWEZUamI2eHBDd3hJdnArNFNPeWpZUm5YSVl3ckM4NXh2WUhE?=
 =?utf-8?B?NVgzY1NWZk1vRnpYeGJTNTNrK0dXTHFhOFhWOVU4blNpLzdVaXpCK2ttOHEw?=
 =?utf-8?B?TzgrZURSM1U1cEo2Z2JtMHBQM0tFM2gzTW5DNlRJTVhNQlNMa2N1Zm52Mzh3?=
 =?utf-8?B?ODlTbk1teVBIOWlFMWNDMGtHaHl0NDdvWDd1S3NDL2FqbFlIUE92cHc1dXBD?=
 =?utf-8?B?QVZGVVlHL3lIa3lDSFA1MmxSOUVuUXE1U3BTQmVTRWlXZ0h6M1VQSFk5NURr?=
 =?utf-8?B?OS9zKzZma0RBM25jeDBWYkh6QUdrSzcrVWpLUFM5aXRUSFd0YytaTXdBS3cr?=
 =?utf-8?B?Z1lvVDg0UnM0RTh1ZFJEbDF3TjlNOXgrSHkzbS9uRTdTRDhKTkNzZERhOUhq?=
 =?utf-8?B?SnhvdWtCaWszcEJmVERBNTRQZ09OM0h3ZzFFQkl6aTkvZVdRVnNWbnBvRHJw?=
 =?utf-8?B?WmZxRTlCNGxManBpTFduQTdFTTlqVURkWXIwTGlmcXB2RFVxaU1SRFdacnRT?=
 =?utf-8?B?b1hzREdPeWpzWWRUMFE4NUdzNE10Rkw3bnp0cmpzNW53b2dORit4Q2pJakhp?=
 =?utf-8?B?UDBTcDN1d0d5cFVBNnJFTkJQK3pMTHVzYkEyVkJLcUZudWk2WVFidTV5emhJ?=
 =?utf-8?B?STFyVkkyWFFKaWtHN2ZLYk91UnNFT1J1RzdoY0tEWGx0cnYrQ0hGUVJ6VStQ?=
 =?utf-8?B?Z3BsUC9uMTY4bDhhN1hxVnR4ajJiSHlvRUFKNXUvajBXN2k2MEhyTFdLS3N0?=
 =?utf-8?B?WENaU0J3QU5tTFhJMWdhbmNzTVVRNzRNbDVzZlpuay8xYm81VEw4QXNkVkRn?=
 =?utf-8?B?V1prYlMwNXdBazlLQ3AxMGR2TFQyTFhhQ3ZJelI5cWxVN293SklVcUQwa1U3?=
 =?utf-8?B?bHAxeGFaNUpSdTFCUDdURDMzTWZMbkk3MFlKcEEvSEZNb3NRdU05bDRvMTIx?=
 =?utf-8?B?L3Y0UWd0QnR4bE5ubmY0TSt2YlZLSHRjVnZ5cldUSGpXbkdLcm00a29Qa1BM?=
 =?utf-8?B?WVdXNENoSTlCbmdhKzJEM3JySnNvNHVMcy80bEFQRERWQ2ExNnZIRnhSWFM3?=
 =?utf-8?B?UjBkdG02YTJ5VHNwSEErQmhDSVRjNlRnQlpXelI4WWtCcmMzQ21ySmpTaktm?=
 =?utf-8?B?VVNUNGFrTm1PYU94d3NrVU5yNnFRQUMxRmFua1A3YlFyNmZSQjE4RnFORzlD?=
 =?utf-8?B?anBvY3NCZ3ZKQ1J6ZmkvaHFxclZqS2dCeEdwMVU3b1IxQ1BnVnhMNFZyeWdq?=
 =?utf-8?B?ZFV2KzVjc2FwRUVRTEQ5ZEFvS1JyRXZISWJ1RXJMVkhZczR0cHFqVHNOOVdB?=
 =?utf-8?B?czVkS2h3REd4bjN3UkFlbGRLc09hcytLbEc4Wml2akdhTjI5Wk94bDlrUUkz?=
 =?utf-8?B?WUp1MHo2RGJ6U0V0dnUvdVMvZDFNdEl0d0cycWZxcUR3VXhoK2xNdlBUNVpO?=
 =?utf-8?B?Nlhkb1FhVVVqenJQbVZvQWtkU1VCN0F0MVB1ZEhma2dFOGw2Y2VVdjR1RkFi?=
 =?utf-8?B?M0N1RkN3UUdmczFtQmMrWmVNVHJmWGJZNFY5c3J1VWs0TWdHK3JpZ3hyODNM?=
 =?utf-8?B?aDNCVExIWTUxL2tRYXNWblMyOGRJd1lKY3BlallBQUJFWjNRWlpHRkN2czhH?=
 =?utf-8?B?OTY5Z2dhS1JCSjN2YU9Wa3V0UzhsYTRpb2VvSnRwczBjWURCelNQUEVYOU5u?=
 =?utf-8?B?VDJ0aGQvNWFLVkdpZ2RqQUI1Zllzc1AwcHVqNjd1Z3RwYnRYQ3oyMlQzTkVl?=
 =?utf-8?B?NDVXTWtLTTFWODlndlhXblh6M3pWRTZraU40QXN1M204MGJWUDFJcUVSdE5Y?=
 =?utf-8?B?bDFUbm5wc1F6bkF0LzQzem4vZExzWFpmWnN0YU0ySWVtaE5ENE5UM2F2ME9t?=
 =?utf-8?Q?vkiI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UWR4em1UNzNJcHpKVlJQQnhEeGkzOWJ4RVZRdGNwZ2RReE9jbzhjTDVmcDlz?=
 =?utf-8?B?QkR0MFFrYml3RWxFRVVjemI5NnUvN251WUhYUFlRbXB2dmZSSjhoRGJ4cFZW?=
 =?utf-8?B?OWFNRjcwdk9PNkI2VHBqd3dSWVRGWHFRSkVCSWJsVHk0UHhpTlRVTU1sbzJp?=
 =?utf-8?B?TDRFdGRHdWRPbGl0Q3J5T2xMU2dGQ1pYa1BpdGNLWnZBcEx5QlZ2ZlpUeDlN?=
 =?utf-8?B?UVpERE4zMTZWaG1STGFRenRtN2RoOW1NVmRGcGFVV1pPYzlQZ203dmUySkxs?=
 =?utf-8?B?anA3RUJYQVFGNGhGd0xab0FPdlpqVUtYWFpTMjB1VjdDTlc3TThNaVBkaG9W?=
 =?utf-8?B?ditNMDFJQ2VneGFvVEE2dGxGbU9FSGc4S1N4RWhHb2xoTTBGZVpBRHFHTWtE?=
 =?utf-8?B?Nm0yTDI3UjRtVHYvZlFvZ2JYcDNLUzFTT0VXN3JxazVJam11amsxZ0ZCWWYr?=
 =?utf-8?B?QmxGRTJYUHUwOEdFWm5vdjUvSk1DTVVhdUxZU3RXSG5oNVNRNDJYREp3TnVO?=
 =?utf-8?B?WDZrbVlHR2tZT0tNNFpDWnNWTmZoTXRZOU4yYXBNTlUyTG1aUHBiOU0ycjQ5?=
 =?utf-8?B?WEJqYkk4ZW5yUzg3c1BQL21SYjlRaEpHTDBqa1p2cXNzUk5kL25WZW5Wck5E?=
 =?utf-8?B?V0VMaG9uNTNwWFFpMFovTENkRmtlMzJhMWhiYkpjT0NydTVTN0NKbUdrY3dO?=
 =?utf-8?B?RUpEUERLUCtERng5c1BRUEZIZVBBWmRSSWhONXdSU1Nhb2J6QzV4SWxTSTA3?=
 =?utf-8?B?ZjM4RmVDYzRmWlhFU1p6Z2ZvQ2J5V3lQMUxYdGxyZW9PdGZxWDNPNEs0cTdU?=
 =?utf-8?B?STQ0SU9QNTUwMFNWdWFubk9jK21odzlNaHRlelJMRGpCb3dsOFBvcEVnMTYx?=
 =?utf-8?B?RWN2emFhK1VFbWIzbzVhcjdFcWd1SGVoL2VlSjFFVitzMnJHVXVqazhwZUpn?=
 =?utf-8?B?MVJQaUNUbG42L0ZYMEhuOWprUzgzZ0I4eS9DaU8va1pzS0Y0eXErZkQ4dXpD?=
 =?utf-8?B?Mi9XK1FQVWY3YzA2ZXhaNXNnTTU0bkJpYWdUUnFhUGtoUXVRamU5Q2xuU2Nl?=
 =?utf-8?B?NzlqL1YyUGVtckpXcVExMy8xa0JNRk9JZjdMSTdOUXVwSmN0RE0wcEd6aHNk?=
 =?utf-8?B?S3ZWZ2ZLZUwrSzByWFVLekovWlBoTmNLYmdSM3Y5L2hNK0tnVEFxZUNBV1Nz?=
 =?utf-8?B?dnFXZzZHeU9PWk9NZHZWd3B0cTZvTW1Ba0x1S2x6cWVMbSswY2xPK1lvWHhK?=
 =?utf-8?B?N3dQLzRhVzlsVU1PMzFXL1g3cHl0cWtjWXhHbFVtRzJ0NWl0ZnhsUGxMaWdT?=
 =?utf-8?B?SVVJVWUvNndiSHhCcnZ5Y045UUxWR2FPTHJLU2hOY2x0ZngyamxkS1JSU3Fj?=
 =?utf-8?B?TWk4UHBpRmpsSG1Oa201M1lUN24yVndOSk4xckk2VEtSTy9qNi9neU1nUzBO?=
 =?utf-8?B?Rm82MWxBalVzVlY4bWlqa3dXc3h3YklMbE9UaTFzaTBrTDcwcW1xYlprVFB1?=
 =?utf-8?B?WFhMV1FFVHQ0K1VVL0VzTUZCRWZMYVp2cERTQ0dvK2RYQ1prNG0ramd6REdh?=
 =?utf-8?B?SWgrV2lyWmlWS3QxZklzUEFCUjhCUHNGcDVWa1lDbzBUei9QNlpmbHg5NHV4?=
 =?utf-8?B?SEJwRHRDdjNpQitxS2tUMXAvOHRiUk9aY3VvNXNQQzRYam0vTHA4TFNydWp5?=
 =?utf-8?B?Z05JVFkxcU9jaU5kNCtvVDZRZGIvQlY2VUg3SkFRMHloaXVzczlRSGQvL0cy?=
 =?utf-8?B?R1N6TUVocEkvSUFVNUsrTG50VGpqR1hmeTlnM3VVRDhjRit4V2pacmo5NGlh?=
 =?utf-8?B?bzk5Ry9OMGdCRmxVaTlJaVVLc280MlpQTG5YM3BxTVQveUk2TmlCUXJXWHZN?=
 =?utf-8?B?eUgvNTRiT29keG1vekR5WXNIUVZ4M09Dd0NHOFNaYnR5d3pJWk5MRHFTckdj?=
 =?utf-8?B?RjF6ZnhDY0QvYVVhRjZnNzR5a3pibUVROHNrUmxLendSMGIvUlhJTzNKd2xi?=
 =?utf-8?B?dXNVeEsvaVNtclluZmFTWW4vdEtiVVBaNHVxMjZVK0xHYm5WajdHQkl6ZVVT?=
 =?utf-8?B?ZzMwdXBtUmFvNUIvbGJuYmRqT0RMZnZIdVVCZzRJR0g3WG5IckVjU2hwVFBP?=
 =?utf-8?B?R0RLclNEaS9nR0ZRTll6V2pOanRCaWJ3KzVxZjNjSlZ0L3lpNVE1UmRBLytB?=
 =?utf-8?B?S1ErZ3Y0N1p4L2RUYTlnTk1Nellhdy96K0xkOWlaNmxoajkyTFFNeE4vTXZ3?=
 =?utf-8?B?MGNCaDE5TllkMGJUY3NORGpteFBrNXN3bktpb3U3TjkrNWdxejhGRXpEV2hY?=
 =?utf-8?B?QVNXVXBrTFc0d2tvc0NjbEJ2d0R5T0J2aWJQTUNRRmk3SVZFU2pKQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0a86ee-6dc9-440d-7da1-08de62606b24
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 13:38:58.9067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXgpIdkUcL20BIlSjskjazr1F0YMvZ5k8EfOOYQ+ReSJL4R03DcHzwWsPQPsN4YG7VoMaCFkZ26pipRdSzbpUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7020
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Feb 2026 13:39:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21811

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb          | 4 ++--
 .../optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb b/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb
index 5c462c8e..7c66cdfa 100644
--- a/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb
+++ b/recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2025
+# Copyright (c) Siemens AG, 2025-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-bsp/optee-ftpm/optee-ftpm.inc
+inherit optee-ftpm
 
 SRC_URI += " \
     https://github.com/OP-TEE/optee_ftpm/archive/${SRCREV}.tar.gz;downloadfilename=optee_ftpm-${SRCREV}.tar.gz \
diff --git a/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb
index 2cfff212..38770b43 100644
--- a/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb
+++ b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb
@@ -7,7 +7,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-bsp/optee-ftpm/optee-ftpm.inc
+inherit optee-ftpm
 
 SRC_URI += " \
     https://github.com/OP-TEE/optee_ftpm/archive/${SRCREV}.tar.gz;downloadfilename=optee_ftpm-${SRCREV}.tar.gz \
-- 
2.51.0


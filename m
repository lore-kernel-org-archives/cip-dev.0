Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011F5C53209
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 13:43:33 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31186.1785159809549693677
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 06:43:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=B0dpmRrQ;
 spf=pass (domain: siemens.com, ip: 52.101.83.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOIjXR77UXuqE14GdQyu2qGvzmR6+VJYMD25u+iZrkW3s4XU/lbkqrth4Q7gsKQqNL8iHGUaSYRpM6FB3Y6r8rYIoJpvmu6reFZ9mhZ0kGDST2IV+H3JJADk+khKN57SVclKvqsRW2Yiq2SD1kSiy1peCms62ikmpcisKWQb2AcIRnyhx1P2/gX81sJ0T6ALiHqlLON1Jt48tUsGwnLdyWBAqrhUjrxtIZw8N6UVs5LgXGbTxKoE1b22lSVPwQIZzu9g6D3/3V7mRthwViATfqqvxjtyGsbe8t4vLthKS1k4xfisJhCEoi//uQ8zrturC6djFXhSZVcY7Xe7yungpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Urh970nyRVthiNoRSQD5MTiQOvWYHPLkp/tWBiDEd8Y=;
 b=Mb/nZyY7TwIky2wy7fdFXsrZnNnK1D6+kzZ9sQCJmsgH4RPT/kM2KMiW7eePRkyZmwAFgmDidC+Z6JcU0PGZOBaKqD28SkLcgNExixv1jKe9LCDd/6OJi+r/dKtbQBmj8/+Yi9Gvf99kY4kAp2yulvLPF2pphpBR+FdRUR4rIGaooB84AV7+xeQ7SR+jkyl89J8JMSmqAzfhDnfOSZ1t+oZjb8oAcjEvZETqdvw2gKXtVoQsNvXvfBK2hKjMXa0Nu7kk1b6o4iuOjS27Y+0dpiybDfCqgYG45ujw9N99v1LNwYWbGxM+GhSgYgcadmGiV7S0vcSlEAZyJSR8UodhEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Urh970nyRVthiNoRSQD5MTiQOvWYHPLkp/tWBiDEd8Y=;
 b=B0dpmRrQjfNguHQEfGUs3JK9lnO4th9lU1tRYFBVL/uf76VaUBo62UGRt+3yOYLF5qisZ4zQbETBvGPfJuJarSng8FgXCbdCqUwDxxejUbb6oh4XxAUEgsjpCbAAF3sYMOmospL4/AEsVlZle83/S5hLYySZnhk/aY4U/qscVkM66yl+TCMdq3yUAI8HAleSSbzunIEKnMmeQhqu0K9iZyV3fQQfLUs5BDkN4Og7iqtDkcyIrBHbUTBUzZ+q0FnyOXauSOh25buTjqzlT757J2z/0lVKRt4OpwVo8aHCk8GCJhShryhQ1oYAr41GGE/+L13A1wL2Ssc3s75pGLoMDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3138.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:43:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 13:43:23 +0000
Message-ID: <ba237049-0362-4513-b07a-fe61630f7444@siemens.com>
Date: Mon, 27 Jul 2026 15:43:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 02/14] Add
 cip-cis-rules-config to configure the hardening according to CIS
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 christoph.steiger@siemens.com, clara.kowalsky@siemens.com
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
 <20260724124038.3633611-3-Quirin.Gylstorff@siemens.com>
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
In-Reply-To: <20260724124038.3633611-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0222.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3138:EE_
X-MS-Office365-Filtering-Correlation-Id: b932f428-5899-42b7-a555-08deebe506e1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|18002099003|22082099003|55112099003|3023799007|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	Jfhloq1gkX5quVG2gcm53IyN9fbWAtxPQvoK+Pkw+2CCqn2VSIfV5y5Q8eHw0s8JsV4lEDK2z1Ss/HYUDwqZY3n/DpwRxzN57p28pK5b8DZbLJ8u2cfooSK3MpVOC+fUL+s8ffDkbiGSTONSeQ2TANoYw22B9L4jaentAt57NLe8qRKuCwS3V3p91eEhVYoNuo8eIGuv+09jADiWH7JOjtupclzA8NVfQUGYVpf0VggYo6cK9kGI9kZnL1H29Qkl+me8GPbCn2o9XE+uizFfahP2NCTmP9xo7mVb4e0fcTFKo7KKdtewj7e5YQmxzFaMTKUt/RaXTkrJS73nfc+xNf8YN+cKp12yAC1yOrFNQYZzo2SL0uhhWEipgoMmOgkoWoxRdPr0EgYDsV24603phIbMm1bMT7i5cJ5qALTeDtZJSCTExd1kPbsjUf/57uRy9QyZrJDYK9DcmOIQIxyB0FUCZpktyZyqN0RlQaRwMikwspqmtQEELuFoIlpCBQauY5ClSCChSPMq0kdgjtOTBbC87ljRZE5PYbndfWqiOIC0jzUq5fBBFPT8K5QQcBq62LptpgYL6E52bas9ikAWTJA22tZN3hUtihzz53BFyVwKuGY+QzRm20IekOWYkbaXGLb6LJ/LY0dGORpQyAF7QQq5Y23uZ6vdBTCnbOzcO9M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(55112099003)(3023799007)(4143699003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bUlpbm1Pd1RCWWNOU1NFQXNrbSs3MzRCOGx4SFNodVlPOGFpVmRxcXo2bk5U?=
 =?utf-8?B?SFBpdVdDcW9JMmNMTStUeXNkN1J5YlFxZDR0aW9adFhyaUF4UjFqQzBCeXdx?=
 =?utf-8?B?cm9Xek04OXRPa0ZDQjAxTEdsTU1yUlFrQnlWR2FrMUVhSzNhamxvcm1lSFE2?=
 =?utf-8?B?c0w4QmsvMVljaWF4WVBoZHZZdmV5bGZCMlUyZ2xOOURmWFc2eVJIakVFdy8y?=
 =?utf-8?B?WnJDdGJUTHlhR0k3NFdxSEFEMXpGbUpaNjJlcG1sWWtoRTcvYU5xTzVqZExi?=
 =?utf-8?B?bS9SOTJiSjNjY2sza3Q4S3Z0bEVNR29UNTdnaEEvK0t6ejBOc1h0RzF4MExH?=
 =?utf-8?B?YUhlT2xMaVZPRklzZk92THhMOURQOGNmUE0vdVpQbHZabkpGeDhCNzBzL2xQ?=
 =?utf-8?B?U2duSm5YYnpZMjVpcE03bzZPWEtOQjA1c2N5Y0tSN1g3TFdESTd3T3Bvd0Z4?=
 =?utf-8?B?NEFRS3ErTU1QUWxkRW9NaWoxK1JLM0VWb0hTZUs0TFhPVy9kbjJBNkw0N1FZ?=
 =?utf-8?B?b0JnRU1hRkd2ZkJLM3AwUGk3QVJKNyt2a05TTklSdHFyMHdjcGN1OUtNaDRo?=
 =?utf-8?B?eGF0NE40WFBNOWNRc3pTNjQvQTladDU2dWhWWWJOT3JpaUllbHRRUG41SmMv?=
 =?utf-8?B?VUtxQ21lKzFyL1Jack0rQTE5NkF2VjRLd1cxNC93OUNNT0V6cmRGVXJLWFZj?=
 =?utf-8?B?dnlJaGN6YU9FeWMyVXcyeHhwZ3UwUUY3TlpDRFRxbTluRGEzdVYyV1pmdUo5?=
 =?utf-8?B?Qi9MWGtTNzc5dmR4ZU9Za1JrdnM2WlRCN2crL2hubHc4SW1JN0pxdVZPMXF1?=
 =?utf-8?B?MVNGckpwdmRZVFdpMmwwQkljNU9vRjlGam9wNCt0cTNLczVKeHFwbzRvZmdD?=
 =?utf-8?B?T3ErZGJnbTJQalZRY2xqUUdmSDhsZ2hnVDJ0ZTgvNVVyRWpPTFpVVE1rRk9t?=
 =?utf-8?B?NGgxYmhHdjlkTU5scC93aHhVQTBWaXplSUdXT2dsTGpxc0pkeVQ1VGNaOUlj?=
 =?utf-8?B?L0tZeGhOK2NLMnBuanRWUE5nQmc3VDBGalc1MnBjMjJuN2NUenV0LytZZm8r?=
 =?utf-8?B?QnlCNVFSSytFOWNoMkRiWnpRWVNuaktseGVsbmZRSE9WdlpNTStSaVh3dSty?=
 =?utf-8?B?eHJlZEhrMFFUNWpVNmFpdXJwa1NuVkovaUxyUXVUVmN2UnpmSUw1eWxFVHBY?=
 =?utf-8?B?SDMyN0c0WDc3cTR0d0ltQXo3SURGSG5yUDBvSWdZc0d3ZmRUaXM0Y3lqV2Nh?=
 =?utf-8?B?UUp6NXY4enpkWUdXNlZac3R6dCs0NXZWVm5pZlpTdVJ2T0xlT0o2QTdIbE9q?=
 =?utf-8?B?UUxXL0lPdncrdmdLWm0rcDIwdjkvQWxzZkdWK0VjNFNOZkEyWkh3bUFVNEhV?=
 =?utf-8?B?MGd4dTRrZDI2aGdzK1N4cUZpTnlFRlhra3NhQW5NZDA1MktpMGhvZjBwYWw4?=
 =?utf-8?B?OG83L1JQenVzd2R1Q0QxSTA2amFYRWtjejFEZ01VaTNRd1RNU3lrSVo1aWpk?=
 =?utf-8?B?ZDRHeTIwKzZyaVlMaE5FVmwweW4xdVM2M0phcm9mZ2dJcndyai85M1E1UTc4?=
 =?utf-8?B?VlVOUFg0ODkyNHZhdG16NXhOU0I2MnlwM0ZYWkMwQ3BDSkY2OTdWTjIxMFpr?=
 =?utf-8?B?TTgrWkJWRDVHa0Z3TmhQVkJSVmsxbUM0Q0JHQmxucE5QU0p4KzVjWFhDYkJD?=
 =?utf-8?B?YXNGVnNGV2p4dUcwQlFKVFFyWkR3ZytkNVRNUVN5Ympnbkw0R0RERGdrVUd4?=
 =?utf-8?B?UDVNL1F0dnlFR0ZQQnZZZW1IemRWOEIzYjE5MnlxZitSL255RDdzRnhDRGR4?=
 =?utf-8?B?WkNzV25LVjZmRTRZWHhHSEFyQUx0MGdxMDRkb3F4TWZ2UkZXRXRkcnNxZzF5?=
 =?utf-8?B?ajVkUVZRbTZyLzJ3YnZIRFVwVUtGbFNKOVJibzhUajNrcDBpK3ppVjkwUUp4?=
 =?utf-8?B?TTF3ZmFsZ2svc05TdkRNZk1UUHNLSDZlcE5iVkRCR1V2Qm5vOUdUT2NkRjBY?=
 =?utf-8?B?L05YdjN1eTJWcmdpa3N0M3BtTjc4V0cyb3ZJSWZzOFo5eC8vZUVIUmQxVnVX?=
 =?utf-8?B?dm9TUzJJaHRFVTdxai8yOHNmZkpDQ1cvRDdRUjBmaXI0VmNxQlJKR2FLeXpv?=
 =?utf-8?B?SHpheGZIOVF2dVY5QTYzclRZZlZlbm9VV0xGS2ZKbDNNUmw3OWRCRWRjMyt6?=
 =?utf-8?B?a1ZIcVBzcUsvTUs2citrTkRMRmM1TlU0cUlvT1JBL0ZmMTNtV25ibEN5WjZx?=
 =?utf-8?B?bm0rcEFmenJIMlEwcmlBTXVWbTlYTy8zUjhWaXFrSnhKRkU0RFBqUWd2c1dI?=
 =?utf-8?B?ZjdGdWtHM05WY2FISjhqUzQzMEp1OXhLb21sSWtvVjhSR0l2aEJ1dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b932f428-5899-42b7-a555-08deebe506e1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:43:23.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqHsECcHBnQHn3vAUOuXCZJ5H01S9o8Fyw8Cm2x6TD9ITN2ZoyYHalffH0LLNcF7BTvuSWxk5Iy4LjfKI2BgtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3138
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 13:43:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23767

On 24.07.26 14:39, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The `cip-cis-rules-config` recipe allows to create a use-case specific
> hardening configuration based on the CIS hardening rules.
> 
> To tailor a hardening config the command `bitbake -c menuconfig cip-cis-rules`
> can be used to generate the hardening config interactively.
> 
> After the package build the generated config can be found at
> `${DEPLOYDIR_HARDENING}/${CIP_CIS_HARDENING_CONFIG}`.
> 
> The package also provides a kernel config snippet
> `${DEPLOYDIR_HARDENING}/${CIP_CIS_HARDENING_KCONFIG}`, which can be used

KCONFIG is not Kconfig in this context, is it? If it is rather some
"harden-me.cfg" for consumption by the kernel build, then maybe rather
CIP_CIS_HANDENING_KERNEL_CFG?

BTW, do we need/want to prefix all vars with "CIP_"? What makes them
CIP-specific?

> to apply kernel hardening during compile instead of a runtime
> configuration.
> 
> Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../cip-cis-rules-config.bb                   |   65 +
>  .../cip-cis-rules-config/files/.config.json   | 1759 ++++++++++
>  .../cip-cis-rules-config/files/Kconfig        | 2831 +++++++++++++++++
>  .../files/scripts/config.schema.json          |  124 +
>  .../files/scripts/gen-kernel-config.py        |  164 +
>  .../files/scripts/select-hardenings.py        |  618 ++++
>  .../cis-hardening/cis-hardening-to-kconfig.py |  348 ++
>  7 files changed, 5909 insertions(+)
>  create mode 100644 recipes-security/cip-cis-rules-config/cip-cis-rules-config.bb
>  create mode 100644 recipes-security/cip-cis-rules-config/files/.config.json

Is this a generic .config.json? It's leading "." suggests that it is
local file that should not be checked in.

>  create mode 100644 recipes-security/cip-cis-rules-config/files/Kconfig

Is this Kconfig...

>  create mode 100644 recipes-security/cip-cis-rules-config/files/scripts/config.schema.json
>  create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/gen-kernel-config.py
>  create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/select-hardenings.py
>  create mode 100755 scripts/cis-hardening/cis-hardening-to-kconfig.py

...from this script? If so, why do we need to check in that Kconfig file
above?

It feels like this series lacks a bit more architectural description.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


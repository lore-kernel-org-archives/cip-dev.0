Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008CDE63F11
	for <webhook@archiver.kernel.org>; Sun, 15 Feb 2026 19:59:26 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5433.1771185562596754260
 for <cip-dev@lists.cip-project.org>;
 Sun, 15 Feb 2026 11:59:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lgq8C3Iu;
 spf=pass (domain: siemens.com, ip: 52.101.72.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZUDuwZBFhKJQRO7Qne8GCJrkaVhT43xUoC1QlMvoa+NAnEkSFpsoJWXoHMWyuT52EfrCDHdSbb7hsTzW6UsucTj8j/C6VH+q+yb9D02UDtI/0SCExRDcoSUi4etsiA6hjfobvcgpC3VI1ERVpGLXRcBAa23RU+TLVBsAQL+5T3aD7StI7M/gJ6UGqrdm1wgpw5YiIZ5veECqNZxfozcxhy8S7jfujZkkFnRjUdUUuIp8JmzSEXXt+fxd8cSG3YbV5bR56ZrJRZf+falYXfWUSD4Th9VZYdTUGmqZvbv04J5hTcuVbHCIWi2UJ32F78H+y6Nb44qP5LLLNRGpcEO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UglHemx8CmqO66SEOkEDh+ygCh3/oY4byuZ/cC+ZVrU=;
 b=Y3RT9qy6Hlp5acy8oD4n9WOMYic9xutPKECxGG44PzmRLxagpAb/zkAqk6cBozV0PvgAJRvNqZFpXJb5AQRupzY/QQZsA2mQG9eucWaD8omhWjqzdq1dDNohYcVPLaLUZK7N2Pgh0SdpbQ6ZdoQPEIBOQACie0J1jnf3ML+5yUgFQmADE2Wj7LZkgTVhCupO/TfZzzuWd6af1PnFCDhGUGHJ1RBNVgp0Kq+c2NoGuX19M/J/gIGUmR4MLSZ1nHb1CsvnZvCMdo1fILU2HxAUSMQ7LENYZTHqch+VhhU+Pi5X8kDPpwdKzL+R/BS8Bgt2ODeppphrzO73gSv853ETsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UglHemx8CmqO66SEOkEDh+ygCh3/oY4byuZ/cC+ZVrU=;
 b=lgq8C3Iusz3M7q6u9j3nwAaYKTUhvwJ2CHiIY/hJmEOY9nJK4VWUXDD4dFg/t5Q5jwHxgMzmL6MH6w58xS3n24T5sfBqMPc1hUAo0rzOgpRGCkinGSMm4U8odVpv35lgyPYE1i93WOUhdK2UFup78nXeBL9bC0W+AM2BxuI36iOmWCnY4hQItCnvk88CMLCWm+AWlbY7pZKUY7QLUoTioIXsWuT6pDtlu9OSxz9w3luqeTr0CyZqAztPzc0MT8Tg/IaugQ2inIdWCXQRb9UM9ZSCPYYUmULBW8/5sj10DxOW9I5sC1Xss+zoBnIQocLTM33NGT5sy230azopgW15gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB9387.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Sun, 15 Feb
 2026 19:59:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 19:59:18 +0000
Message-ID: <3d468be9-526c-4f6e-a8a9-6f5d3d2adb87@siemens.com>
Date: Sun, 15 Feb 2026 20:59:16 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] scripts: Use plain gpg binary
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
X-ClientProxiedBy: FR0P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB9387:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a40705a-982a-4a34-43f7-08de6cccb3c1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VVNNNXpiQjVvTUo3eTUyQkc2UUREdTVERGFYSWhPUSszei80b29lWjBaUXpK?=
 =?utf-8?B?a0NKTFFQdFRzUG9CenJ4UFpmYklDSFF0VFpqYjBiTjc5d2g4SWJiY0RLZkNs?=
 =?utf-8?B?ejFjdm0wTm4yekswTEUyMDhPNFlSNnJOOExycGdoaHJiNmFIdkErdEJaL1hU?=
 =?utf-8?B?RVM3aDJLSDZKaVBkeFFNK05aZmNXcmZUSzgwM0RmLzBKZWV3aFpRclI4dzNv?=
 =?utf-8?B?ei9Pd0pveW1NbW1KV3lqTGk5ckdLbEh4UzZkSlYwR1g5RTlhMUtGMmxNTHVD?=
 =?utf-8?B?SEsxV29rU2hEdFdBcUlKczluQ0pielpwbUI0V0I4RDRwZXJrSnIvT2wwc3o5?=
 =?utf-8?B?ZkpweGd1RjV2eU9yWFc2NnZDZFo4a1hiUHBQZDQ2MjNNaWNDNUNNYmkvUmJr?=
 =?utf-8?B?cUxVL25UWVM5Nm03cWdpRXZoL2poeGZGMndia2RjbTc4Tko5d254aHJLNlNj?=
 =?utf-8?B?VnVQVWZMU05kOXV1NUxFNFg4RktUNENYcHlQU2VoL09HOWpJRWlCeldKZUJz?=
 =?utf-8?B?WVdTNW1nbWdYNGRWVHZtMlZpQWNFK2N3QngxU2pSVzBUeGkvcVJtWWZDWGZC?=
 =?utf-8?B?V3N5VnZ2WFVxbEFpbDNRaFp3bmNIcmVGZXF0azQ2SW5qRWFHV25hOS9IV1dV?=
 =?utf-8?B?Mys3MXZRVmFHcE9xZ1hJenRtVXVTT210U3Y0dnhjNTd6MlJIZG9ZT2c0N05Q?=
 =?utf-8?B?MXJ1cmwwNkVqc29JWHJRTkQrRSsxSVFUeVZCM3RtdHVZdjVoYnpjaGd6Y21n?=
 =?utf-8?B?MndTMUpDSWZCeWg5SVpGVjliVmNtdXIvcXhoblBFSk1FWDRzOEVjcVZwSll1?=
 =?utf-8?B?NjFZYXIwSFRQYjRlMkN3MWh6dFIrVk96K2h2MFdoTW5FekQyUFh5WGQ0UHZ0?=
 =?utf-8?B?YmlaKy9kWUZKemFwTkpRQmJvVzJSc1Y0VUM2c1BwZnBZM2FGMUg2VHhnWWNQ?=
 =?utf-8?B?Vm54c1pXYW1FcEkrY2p6NXlxY1lsTmFDRjVwSnRBNVBpUWZsVmRwbkpWVkNo?=
 =?utf-8?B?SXhzOTFrQUFRNzluVllOdjFaOHhyVTJ5L2syQjlBZ252bm9jUFF1YlBXdWlT?=
 =?utf-8?B?YmZqYUJHc0t3K3RDU2tjWkhMbFhuZ1ZBczlvQS9MUzgyZ2MzZVVKanRISG9o?=
 =?utf-8?B?WEIvbmZMRHQrYUo0WHp6TDRNSElYSFB6U2JSa1Axcm1xZE1xSkZ4MXhuM0JS?=
 =?utf-8?B?TzZxVFJtaHN4K3pNclh1VUhpSGl5RHlFRzVXazk3dzc0VkFTRlo0TUs1WFY4?=
 =?utf-8?B?ZTB5QXJCY0ltTDBweUtYNEpWM2Y1bjNlRUlqK0dIK05pb1ZhUDJqSVlhbS9t?=
 =?utf-8?B?Q09qOHlOWndkMGFpSmlXbTUwcHljY2dYcGhqby9KRUpNOTVWVXRuSHBFU3hi?=
 =?utf-8?B?WTVSWWxkbUtySjQ2eGk1ZTlZQkFRWGtqaFg0SThXRVYxY2kya043b1lMQkdq?=
 =?utf-8?B?TlJnTXduY1pDcW1DYlUyK2RIc2xBQlcrNGpaNFBXNGJvM2lic0hHd1BUL2M0?=
 =?utf-8?B?UkM2RmQ1bndUMFg2ajk1SWNGdWRNZ0lPcmcrckJ5ZTY1NzJjbU5ZR3J3NUcw?=
 =?utf-8?B?MzY2cnJhb09Kek96R3l3QkdTNzV6c3cybURvcTMzYVZ3am9wQkJBYWF5MTJH?=
 =?utf-8?B?Z2FxWXJJaGhOMlhtNG1mRGJlb3BManJEcG9kRGZia0pYeW9xVC9FK3Q4ekFi?=
 =?utf-8?B?Ty9BZmlsRWFKbmk0ZzdXNGI0S3JXMUgva09MbysyMldwcFFwZy9iYzQ5TDJZ?=
 =?utf-8?B?NllvZlNlWG1sUEU5WVlWaS9GU2V1d0k4eXo5QjdnRHBjZnhTeGNjZ01nUzUz?=
 =?utf-8?B?YTNFYTdYUkh5ekhXR3FBQTVRekdVem1zVEdZL01jNHE1WUN0V1BXeDNJd2ZW?=
 =?utf-8?B?dW9QcnJycXJoQk9pYWFaMjVKSGZtMHdLRTFqMVdsYlZaV2Rjbm5tUVB2NHRR?=
 =?utf-8?B?cng1bkRFUmV6K0MvaXZjVHZZcFB6T3BhRkRqbFVtYktqTFRUU2JrZ0tmVmZw?=
 =?utf-8?B?T3FLQVFPVUpWQ2o4aDBvT2pydXlFMnY2SXVickJ3WG4wWmE3MmxOSGR6eFU3?=
 =?utf-8?B?aTRBTDBuS1ZLVWpoVDdVK3N3VXNSYXNyZTEzZ2hKNzNqd3JTZXNvTWRHbUNP?=
 =?utf-8?Q?hFZ8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bHU1K0JzcU55YkJPN2lyRjhSdnNIQnpYbjd0aXN3dHgwaE5NVDV3VnFPUU5O?=
 =?utf-8?B?em9oTkpPWmJPYVlGdUJncDY2aDlVQWVrZUFqUG5QanRUWXc0MFlwSVVwRGp0?=
 =?utf-8?B?bkZnQStNNk1xcktLeXM1Y3hHb1ZOQkR2TmVwTVpkVHR0c0hnbzZTZGVMRlMx?=
 =?utf-8?B?OWU0T2R3MGFIWHg4bFBjcnkwNHFJVzVab04vUVp4Q2NDbUdndVNiTDNLT1ps?=
 =?utf-8?B?YUZTOWhnVHNoTkJnTzlFZ2VFQ2NCZmRWbUNyNm05R3l5c0tiVWpUYU9vdUVy?=
 =?utf-8?B?a2JnMWx3Wmd0bCtHOC8wT3g0NHpheG9mRlRxM3U0VVk1NjUyRG1HU0RTbzJK?=
 =?utf-8?B?Y09CWnp4OXI3SHZQNmhlUVJJb1VIMDV5dGRSS1B2R3F5U0d5L1lvdTNhb3hq?=
 =?utf-8?B?U0hvMS83eHFpb1VqQnF2K2JRcFhVZkozOU9mUWpOMm1yM29YQ3dXTjM4Rkhs?=
 =?utf-8?B?RjNRMTFtc1Q4dExKVnMwTy9ZVkxRYmMremp2WW1tRXQxNVpvMGN6QmY1U0Zs?=
 =?utf-8?B?ZEU1VWRQRkhCQXR1WCt3Nmx2WDJDbERxM2pNcmJabGRDcUxSa0ZNNzVoZGFM?=
 =?utf-8?B?TDdsSDZyUHlQYXowejRUQk5wTTRqQWNncktaTGU5NUVmcitla2FHV0xKcEly?=
 =?utf-8?B?ZzZjaG00T2FhRUprdG1lclAvQkJwa3FIaU45YkRlZnlvenB4YThlMDNQM2tZ?=
 =?utf-8?B?bStlK0pMTGt3MFAyL25FOHUyUEpGZEhFanBmcG16R2oxdGZ0bWFaTHE1TDNQ?=
 =?utf-8?B?SW5OWWs0RlBqL2ZDRi9EdTVidUloU0VnTUEwKzRBV0lqM3R6czdkekRIWXI3?=
 =?utf-8?B?V1ZjZWZEeDZ1cTErSmRuNDE4ZFQwekRiYStBa3pxQVU1dHdPbnFwcnhpU2Jr?=
 =?utf-8?B?cERrVkJPUFJBL3FCdHIvTVh6em8zaHN5U3VGZkxWYi82U0ZvQktGSGkwVVJF?=
 =?utf-8?B?UDlseG8wVlJ4dm9GaGM5b3NxelZodzVqVkQ5Tndhbmlzd1hLV1BDWi9RZHJj?=
 =?utf-8?B?WkQrNGdoeEd0UEZ3K2ZxMllOdFJEV1kxTUZRWklWUmp4NFdIMERRcjlNL1U1?=
 =?utf-8?B?RXlQYXBSbzBIOGZUSE03d2U0VWFwakY4eWNDekowdm1FTmRiaWt1L0g5RDRs?=
 =?utf-8?B?T1UzN3htaGJNNW1acndxSWVOaHNkYUljOWd6eW9BTmRvcWZmaysrVjdCdko1?=
 =?utf-8?B?T3paTXRqVEZvYXE4bFhvR3hpblplQlNhNUFTamhVOEFiWkZRUXozZkVUZ3Jw?=
 =?utf-8?B?Wm8rMndleHhRSFIrTC9CdUNWTWNVZzlpTDN3MW11Mk9YMzRzeklQdmRyWnBN?=
 =?utf-8?B?eFZoNW9WZE9wMWxRcUdFaU1HM2VZeFJKVnNxZFpjU2ZhaU1MM3ZxazFWOXZ4?=
 =?utf-8?B?RytFU1YxZnVzdk9IdytBSSt2UndkL08zWU5Sc0EyNXU5a3BVOHpEcmFVWTJ3?=
 =?utf-8?B?cHV5TitBcnZaTWtDd0VwVFpSamd3OVJFZHN0cFBZelVJeFhHN2NYUUNDajJz?=
 =?utf-8?B?SjVaMy9rbWFnYU8vUG1DTXNrL3dHdS9UMFA2V005VjdTQnpRckMxeUlMaHRP?=
 =?utf-8?B?WEFieENVRFAwZlZjS3FHbVQwOE1MK0Y4a2tSamp4b2dyTUhWczd6dUJlTGU3?=
 =?utf-8?B?Z216d0drWnF5ZEVkUWM0S21lOFpvOUN2YmhqOEV5M2kyYWFFVUxJZVAzVGw3?=
 =?utf-8?B?RExsV1FBcHh2aW9CWHB3b0I0blY5bWhBQVNSanVjSEVBZ1NpdldiKzMyRjFz?=
 =?utf-8?B?dTdnUDBvbm5KT2JxOWg0VW05ZldVdUpnRG03M3ExeFBpbmVuejhuUWJPMklw?=
 =?utf-8?B?T0N2MENURnFBcEo1Sk50QmJNemRFM1Q2QkZVTXh4TkNqTlMzaGxRRXZGYWZr?=
 =?utf-8?B?NUZwSWxTbnl1dGIrSG1seVRHQzVRSXRVMmN2Vkg5WVNVelR2RHRkMGx5Nkdv?=
 =?utf-8?B?ZVRoWnFqNTNBSGp6T1A3S21vcEJJTjhvVzNiblhneWJkNmpsSU9nWVBlaXU0?=
 =?utf-8?B?aHEzc09tYmlyM2o0akpvd3d3dzlIWU5RNEVDSUZteVhna1VxSlQvY3N0cXJy?=
 =?utf-8?B?Ym55M1g4S0pjTVNSd3Q2bFM1ODBZQXlmY04rZjRjSzRHTFpvOTVES2E0TjFM?=
 =?utf-8?B?NVNTakxQU2J6cm1hRVlsNTFFcCtHVmZ4R0d1cjVRUnRKbXNZRjYxWHZrc0RR?=
 =?utf-8?B?Qzhpb1BJY2VNSStBYThJQXlOSEFIbTFrZC8rNlZQcDl2YXlSeFFiTVpteS92?=
 =?utf-8?B?V1VycmJkVGpFRWZvZzJtYW5LMGxOZEFWbVhKR29iQXhUT3V2R0FERTJUYldv?=
 =?utf-8?B?QmYvbWtiY0c5V2NabkdzenFsM0hjejArTHp5U3IxUXlNemRndUhvQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a40705a-982a-4a34-43f7-08de6cccb3c1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 19:59:18.2311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ta2TF9tiVSaKab1RdYQyPehAsHuMXLC7AKROwW7kSe7awOmcFhaVgPc/Ne9SA/cPdglyeztb85c0LWx76hCefw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9387
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 15 Feb 2026 19:59:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21875

From: Jan Kiszka <jan.kiszka@siemens.com>

gpg2 was a transitional link.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/update-linux-cip.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-linux-cip.sh b/scripts/update-linux-cip.sh
index 6dead448..5fbfa578 100755
--- a/scripts/update-linux-cip.sh
+++ b/scripts/update-linux-cip.sh
@@ -5,7 +5,7 @@ pushd "${REPO_ROOT}"/recipes-kernel/linux >/dev/null || exit 1
 for MAJOR_VERSION in 4.4 4.19 5.10 6.1 6.12; do
 	rm -f sha256sums.asc
 	wget -q https://cdn.kernel.org/pub/linux/kernel/projects/cip/${MAJOR_VERSION}/sha256sums.asc
-	if ! gpg2 --verify sha256sums.asc 2>/dev/null; then
+	if ! gpg --verify sha256sums.asc 2>/dev/null; then
 		echo "sha256sums.asc for ${MAJOR_VERSION} invalid!"
 		exit 1
 	fi
-- 
2.47.3


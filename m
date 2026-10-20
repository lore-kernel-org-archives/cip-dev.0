Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6322.1792499537664690232
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2026 05:32:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QsBxK4zr;
 spf=pass (domain: siemens.com, ip: 52.101.65.35, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otyXjTPdxtLrBMzsHLbALeX5asijQ82lIniHs0C1ij/PgHU7J0BapGtIVJP1LGd1j1pcX1qjiU2SCyzCkauBvYTF3WxEgBhJxEHSyLbHpS7rq0h/B/0PuB0M2/ZkAdSNwWyBpyV6lNxipg7mmeck+ZjbR85GmhJ3xtKp/tqC940QLjHticZ2ilTLYQo0196zwMtmlKVvRYJu02dWvhfgwEnkWnFemxF9BXqC7v9lDp+bZEUAZSGX62UTKA83bdxb3SKHDswS0XBPqUQNNOocy69WG24agJ4vVgTz6FlZNE10kf5ssAFNDijEGQqrvtE8EGTUKF+qCahyIc9gT2eM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omKme3iF3mD+2MCa3/4b9XbIbta9n64OvNcsO0w3KqY=;
 b=C5l+K4gX6BGXdJWd38RO8o5XTOxJCycAFd+t+1FA8I4PeD669uiGV4vF2QuCfVGO/2HM5Jor8VIhynmqpjSKwNDWDCITIvJ3+dFByPC1KqTdzvMGy2R4aZvRzyPuKmFzouan4Zr9DXKh8Zr/K2z79Py8IizcPYYYRdzRhFO0qO+5XLjYM8lfvAbKmM1KyXWRetUtgeacr5mfF6uj04uFDsnnXE70xfqae5iwC3vs4SNB/Cf9XhTPWj0AXGzBaSVt+4HyCsxIrPMOthUX5QBtmJRQZhYZez4l9kWL8acSyHm9sgQfIfPjHpIT8HF4EUTdjqHPhesrCksyL6Hg1nbQWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omKme3iF3mD+2MCa3/4b9XbIbta9n64OvNcsO0w3KqY=;
 b=QsBxK4zrheieSKTG1ZQk9vd9h6k3XxzepI/tR6jgLM6EfoQBobikFgJKOz2JgESkThJudT/9dwffAw6zXEooUjGxj3Hk6rdy0/gbi/+zRPwkVDTZoZYpaiOfnXUgIB+DLWV9phF+LbI2BrsCK5ujusl/MaHZAe7u4XFGEx03dYRXwV8fdd5GBBr4PMV/Q08EgkrObXD58+9Uvjog9f/O3JQx2rS/9py1epkMkm+Hm9oBbcBekuLkYFpxtBWShpM996lqzcgRuWwKRg0pLzKIFB4YLa2cTXrie1PjwJh35N88m7jTQYwkDLsIWG/ZUhYVJNGWPW8tPd0Fl0qVWj+jew==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from MI9PR10MB992304.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:290:b8::17) by DBAPR10MB4044.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:1ce::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 12:32:12 +0000
Received: from MI9PR10MB992304.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7724:b942:fb9b:6063]) by MI9PR10MB992304.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7724:b942:fb9b:6063%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 12:32:12 +0000
Message-ID: <cd2780b2-66ac-4035-a0ce-5c62ac07faf0@siemens.com>
Date: Tue, 20 Oct 2026 14:32:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 0/2] Split swupdate signing and
 verification configuration
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20261020122932.470811-1-alexander.heinisch@siemens.com>
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
In-Reply-To: <20261020122932.470811-1-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::14) To MI9PR10MB992304.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:290:b8::17)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR10MB992304:EE_|DBAPR10MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ca9bdb-773f-40cd-8eb4-08df2ea62a6a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|11063799006|261009223027099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: PFM7DJ/frsfUWZItIWDTKyjAXVPctKddZidisuid4shAimCDIcOSjaZn4wombOFRod61gKXafd7dJx0eY4xHEYXz6bpt2xYBij48XUMKpTjn6NuGmlCDNXYZ3kY+fPGHIkAJG9Uj+RrnSpBt2MmuEkau+fU70xfKBUOpSB05eLjOUKUbS7VYgfPSN/OsehRmrgeFPmW2mZG6IK+gRWfPUoc8X5i3M6mOhdt+ElV4bw0CZ5of5HfxYi8THV66nZP2+xnAPSpmw4JFpaX2sMxJeK15cireaaK8vkQyh5yp5CPRXnMwvQcVnZsBWXpVtQYSCSbysveo1cY6Sm5qcmkT2laDpjjXJD5fC3rXxSaQE7NWXIZV5C6+4CyrwpOvpXLhAyO6nodMH9vOq/VqAOcNTu1+fcZftdivdQX24zayPwzqOvdXP5YFRujzWi/Xpt20IQQui/4viPEX9iouUSx/KaxlQeVAi9iyAafWf1jJ49oxllNJTinngNtS1Tzi6VLR9iyK9BGoqUy7thWDTrvzUGUOPtYrD9CY9soX8R5e+8Pn5IrTbv7CW+Ya6MbAA2C9OKIXencb6+hG0e5AfAOu67etQE1nMheTo4DEcbk0lE2q+QUqbcfY9hYSZdHxmaAQiVg9bJIEWgmmjPESj4WKu4oiUZeaeGrDb9Cc/2Wsc6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR10MB992304.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(261009223027099003)(55112099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czNWSEVBcExPalEwaVFrb0JNSTA2Yk5ZdUkwY1JCN0MrRnF3NkJYem1kbUJ5?=
 =?utf-8?B?OGp5QTNReXZzc2RmRXRoYTBCY1FTTjkxOCsraEVSQkxsNEo0UzZMcS8vMlRY?=
 =?utf-8?B?bnF2aU03NHBZVEFvR250SmhDWmx2UTB4YTZHN3V2S2h0Tis5MFZzRlRPQUZ6?=
 =?utf-8?B?czZ1OGJQYVJZTk9VMUpuUUVPenBjTDlzY0pYUHlaOEZVTTdXOWlhMjhsV2RO?=
 =?utf-8?B?cFNBZWxFdnlNelJMOUovVUI5RldtRjVBNWVTbW9ob0krcmF4QmJXVmpkcWlM?=
 =?utf-8?B?K0h6Vm9veFNqdGdKTms5eEx4T3BBbEVtdk95cFlJTWRmcFhKR3NHK2RPVWNi?=
 =?utf-8?B?WlNkSUJUd01UQzBUaHFMdHd0Z2RGVlFBdzd2SllaM3ZlYlJ0cmZWRlpjTUhU?=
 =?utf-8?B?YkNHWFRwakQyUEVqck84VU9KM2RYeFFHVzNtOTZxT21FejBReFdWME4reFh1?=
 =?utf-8?B?azBBcmtacEdyMWIvTWdjaUNENklLbmVteFRldmZQQWN5Yk41ZWFQQ2dzU0V0?=
 =?utf-8?B?Y1BCT1ZSZFdQYlBsN3ZndEZ6OWVlZmJYVk40SWE5dE8wdXg4eUJkNW9oRlY2?=
 =?utf-8?B?MTAzblFacDdVOERTZ2pGeGtGMVMrc3QwNEdPakFIZjdFTzJ1K0NPcEhjcm4v?=
 =?utf-8?B?M0Y5T25QeGI3VmY4eElzOTFTNTBVUEwwWVp5UUpXZ1JwbzZIV1UxcncwZmg0?=
 =?utf-8?B?Umx1UHNxUURYUm00WGNpbDN2cDEyVUJUQWhha0hBS3lXWlVZZHYxOFNUOHM1?=
 =?utf-8?B?RE1OZGMyd2I0YmRtTmRLNU9FQXJhRXpTNVlsVUFGTEY5UlZDZk1qMHowR29G?=
 =?utf-8?B?RWxid1FKcFJadlZreEhHdzB1ZmhaVGtIK09qTlZMMzlmZ21iWjMvNnlGT2Z3?=
 =?utf-8?B?eXQ4aWwyVGFLV3FSLzdOcnIrQkc4NUwyTDV6L3VNZVl4MFVicXBHemNuTDlI?=
 =?utf-8?B?bWtoaVVZYjN6NkR2cTIyVHAzazgrQzVZTVlwSW55d2N1YWxINGNuT3J6Qjdj?=
 =?utf-8?B?bVJWOXNyQWRyRkpSNm12K0FMQ3lLUGI1TlBNTTJGRXNJUk5uMXZvUzZnS0hG?=
 =?utf-8?B?OVNpTEJXMXFPbEp3N3Y5R2pyaTMyWkpOS2pQZXZJSWNXZkY2SjE0RUxBMnNt?=
 =?utf-8?B?bjdiNGpVbDVXdmRncFpOYnorMlpUQjR0Z0YzbXBXdEo3NlFCSUNkZWRyVFpI?=
 =?utf-8?B?NzdLa1V4bG8wRE4waUhXRFZDVUZTZWcwSUcyb0FJYm9oR0tHQ0ZBZ1RBQ1dE?=
 =?utf-8?B?bE1JSFV0K2JKVks5SUtrQ0ZZcEw0UlhCeXhkeHRTMDZhN2ZCRVlrWGVqRjRG?=
 =?utf-8?B?Y3UwYW9IVE44cTlYaWx5NnJZakRLQUNhMkR4cWtXbHY0R3AzdUFGSjk3RVcx?=
 =?utf-8?B?WElFbFkxOFBxWWJkV29VcVN6cFhwRGZBTGl4OC9MSU83RmRuR2RlWmJHOVZ4?=
 =?utf-8?B?QTFHZFhxR0pYVkNkMUhkZEZsUklmK1N0cnRrWFRzN0F3dTlWZDR4UmxUb1Ix?=
 =?utf-8?B?NUxyaFVVUkwxeEk3WXlrUkMxbE9VK0pFcjVOME80bkxCVlM2dW5kTmk1NjZk?=
 =?utf-8?B?V0lZUDRXS2pXc2xLbmhkVU5pR1NjZTNqazNENTdienlmS3N0cVZHUFdGWEVQ?=
 =?utf-8?B?SDJCUEx3Z1lGMVRQUm5Oamdqcm9reWRKckdVWVpyNW4rd3gzUTU1TGRTb2Qv?=
 =?utf-8?B?QjNBMzFBWDJ6N3pLZk4yZHp6WXFybXlBaWxnSE41OUIya3h3dkc5YW5Sa21u?=
 =?utf-8?B?akRrWUlHK3hjWVl6Vk9ER3piQzhTMlZvNG8vRHZvYkt1Z3pwRElsSHIxcEZy?=
 =?utf-8?B?aFhQZWVtWWdac25oMCszMi9zUWdzbVlZbmFXZ0JmbGpPakVvMEwvcEVubTZv?=
 =?utf-8?B?aVZxbG9pSlF4dCtaNU1YbmxseVBkMmd6QmxRZ3BYMDRMZm5YZ0NTTERCM0ps?=
 =?utf-8?B?WWpXTTB1MllDckhpMFdMdHZHbThSMjRvV0dDbTNQSUl4TXg2U1hXZkU2dzBR?=
 =?utf-8?B?Y25wazBxbzNTM0UxS01nOUJvYUJXaFBtakkvdnhBZWFuS3R4ZGZEMk5kLzVz?=
 =?utf-8?B?aitOdGx1dW5qYzBWQSs5UVYyWGlSZE5aczlEL1V5TWdwR2gwcVdkcWw1RUlV?=
 =?utf-8?B?NW05Zm96Z2ZoZ1E0NTdVaVZSMEoreUdIL3NKR3o0T2tpR0FFb2pzbFRYbXhD?=
 =?utf-8?B?S3dFdUxtajRlQ0FmTm1CK2RyVXpLWUFRczdJdEpIelNRcmRLeEVBTU5YSWp2?=
 =?utf-8?B?K3dwNmdvZnpGTjQybTdRU1JYcXhZdDliZ0xWNFNMLzNTVnNsRlZ6cldPeHFG?=
 =?utf-8?B?UjFtNk15R2tFYkM4RllObFRiZytBSkVKck9VbklwMzN4Z1BuN0JEdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ca9bdb-773f-40cd-8eb4-08df2ea62a6a
X-MS-Exchange-CrossTenant-AuthSource: MI9PR10MB992304.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 12:32:12.1893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNQP6bhpS9K4/fpxpHl2tKFExnSx0iqN9Tte6rj6A2ZqhyhVE9TqdWhuU3O/5hieOnloUi37UTZQ9ErmaJ0+Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4044
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 20 Oct 2026 12:32:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24501

On 20.10.26 14:29, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> This allows downstreams to sign artifacts out of tree (excluding
> signing done by swu-IMAGER) while still enforcing signature
> verification at runtime.
> 
> The patchset splits SWU_SIGNED into separate configuration switches
> for signing and verification that allows for independent control of each,
> while keeping the default behavior consistent with the previous SWU_SIGNED
> setting.
> 
> Alexander Heinisch (2):
>   swupdate: Separate config switches for swu signing and verifiction
>   docs: Removed obsolete IMAGE_INSTALL from README.swupdate.md
> 
>  classes-recipe/swupdate.bbclass    |  3 ++-
>  doc/README.swupdate.md             |  1 -
>  recipes-core/images/swupdate.inc   | 12 +++++++-----
>  recipes-core/swupdate/swupdate.inc |  3 ++-
>  4 files changed, 11 insertions(+), 8 deletions(-)
> 

Thanks - Quirin, please have a look as well.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

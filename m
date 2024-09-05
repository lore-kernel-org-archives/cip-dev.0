Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F512CD5BB7
	for <webhook@archiver.kernel.org>; Thu,  5 Sep 2024 12:10:47 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.64])
 by mx.groups.io with SMTP id smtpd.web11.7739.1725538245605312166
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Sep 2024 05:10:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bvryLWpR;
 spf=pass (domain: siemens.com, ip: 40.107.247.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0wsfTd2+JQefgag9KjsPvsZkILi69pBd3j7dKyCo0zqmV5qQVuYMh/R8werMaavJ+i05n/VyASm1Sb4utiKFQ+5cXmZEsGdN02jhSMbH7mHwX3KdBAX5UMMGJ+HJblkExVjSsFudQljiP052EeB2SQ55A6JTidXMRoy7a6WaY+EI4IATDRsdktG8Wu7NshlcIvPKSmiDtIOpNGDuL85BNNIv3SiKfKzerGN3K99wx4SPODVuWQPl5ZFkS7DPU/1ulemhM9Uj5P+BNbKeJw0PaPM3h4qg/aHpbSZfWfl434rIPCkumvzf7xmkWTC2fm7PhpxouZ7EjQL3kktxl0eOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDFcZIvhHupQ2JD99jEdb2IKAPhFWDnZC8t0pwvjZL4=;
 b=rRHXL/TWCUmMPF0nOIpLAAT5NNRDc4DCIBF+d1kXTwtCzU4XTnwjlYE4td4gFMF3Ne3kqDH0CXNq8++eQzxONIVG0QraX1cgB8QCkqv+7v/0mGm+RxPCZQOjZ12+HX5scTb7fr1scMV6HID5K8gTQ5epxqGVGQ6GB484XNBTxdPSZuG+/5TeYXgMUUFjnSx5w8NXecZ0vBc3q8X1G5FFdA+0blT6Tj6ATUtqvc/E92/aeCOectxPvqb0hwvwp1S+RbgbJ3d1/k6l5jU1YZYxNO0UKTQcWfuZ2JSghdRBNYsHjt3VSh/a8+s2SOD8Ed82QxhbBD4d3rbPa6SaDbLahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDFcZIvhHupQ2JD99jEdb2IKAPhFWDnZC8t0pwvjZL4=;
 b=bvryLWpRt/jZLVYnfNRGar3N9r6QleDJ0PEn/twkzUhwTZdWG7a20gUi6w86IomFYtjG/NwWl7fIRsthCIiHD74/zswmPikEdg8UPiCJrX59/MM8fsdw4UmRAiRAY7bogBg5hiq8LNoXCYCzkzxoOry8ZOzEVTWPHeMBGBY+/vGPUJ0tAARDJaJzIRQtPEJuM3eNzVigfnlAS4nirkFw3uQnxvu1WNroSAGMpKl0T542OuqKr6pnhsMLZzMbQIYHCltghx9L3JNsg41tYg1MeBQYcAwsfQhDMykdrTRQnho8mn49Far1L2+eP0+fWSpNJtw+0MmMuxzNwSGnpqIYIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5622.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 12:10:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 12:10:35 +0000
Message-ID: <8bcf265b-1567-4b93-883a-7090297fdaec@siemens.com>
Date: Thu, 5 Sep 2024 14:10:32 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
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
X-ClientProxiedBy: FR0P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: eab422dd-9765-49a2-3b22-08dccda3bf19
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MTBPeC9rWjBXVVI1bFdmdkhIdkZpNEw5ekE0OVJBaUR2U3RUWmlGLzJtNmYz?=
 =?utf-8?B?V2ZMYW5ZdUt2UUNHZHhSckxOSXo5U3V6cjdUL01OSWh6Z0Q3MFd1Mzh6M2l4?=
 =?utf-8?B?MTNaRWhPVWhPOWxzaEZOMmNFMWZnT0I0R2hlOFRyYkNIRGNzUTVqcVdOWkgz?=
 =?utf-8?B?aVpQVERDRjdLUGR3UFA2U0pYdWNiVFZ6OElGSzVvYU90LzVadVo2SFVZd1M4?=
 =?utf-8?B?dFM2SkJoNTltK2ZBakVkNEZIQk1kY2pwbllrRVQ0NE9hMHM2NGNMWEgzZXVs?=
 =?utf-8?B?RXJNemZDWTNwdTBPMEdzakdsY0o3c0ZIbnNTNFdRTjJHTVZyZ3E1ZjR0QWpl?=
 =?utf-8?B?Vi8xcFBqY1dlOEtoWjlDOGhuY2xUcFFMUWYwZXFBUTgxY0VmNjhZY05ES1lI?=
 =?utf-8?B?YUE2c3JZK283eDB5WHlGOURqNjRSUTh3VWdxdm85dVROZXY5Ry81VjY4Rlhs?=
 =?utf-8?B?dDZ3WDN2MG5lYWtPSElNZjZUOEpScTY3M3ZUUXRONnFIblp1Y2NOZFFMTDR0?=
 =?utf-8?B?Y01la2w4blY4bVdjdWh3NmlqblEzcHArUEUyWVlPbGdneWlKdUxPRnYyamxB?=
 =?utf-8?B?RFpIOWk5dTZLWHd0ZnB6UTFFVGd3a2pBaEFFRnk3M1p4UDI0MTU3TXU0YWgy?=
 =?utf-8?B?NWtPV3JJRncwTHZSaDJGamN3cmNyR1UrdEw1QjhONUR6cEhwRzJ6TVhIQjJT?=
 =?utf-8?B?dVh1OWNVTGpSM2RTWDlCZjM5YWoxbWFXdS9zVTBmMHkrM0pZd1dPaTRvcVRk?=
 =?utf-8?B?SjlKTWRnVCtaS0svTzRwa1hYYUtMaFY3aGZlcXo1cUZvUml5S2NlemhEU3VN?=
 =?utf-8?B?UXpIbHpSTzBYRG85YmM4SlBHV2pTa2VlMi9aUE5hNVE1NDhlYzZ2RkpsZHVS?=
 =?utf-8?B?QWNNWmpjTFh0bUNXbDA3Y1dxMExYMXMzYUNQV25LUTY3YzF1YzJ5a2JvQjJi?=
 =?utf-8?B?YWNMSHlWQ3BmcjRFeWlFYkZFNHNJYWNScWYyeW9MTUdEZG5WS3dBN1FMWXNt?=
 =?utf-8?B?Y3hoSXlLQWVsNEV4WWxuOEVUcUtrUzM4WlJ1OE9kcEx4ZmpWbWk5TmFQamw2?=
 =?utf-8?B?Sm5rTTJzcEJGQmRNWmR2Q0ZWeW5zUTRCRWpxSitseWYyUlpOcWJmRURhbWRj?=
 =?utf-8?B?VElTR3pUMGlFY0x1QmkzNy9VQUcyaCtCRDJOWjRjNDBMeGpoR2l3N0RWb250?=
 =?utf-8?B?aDNoeUxaT1RuNjJEWjZ0L3FJNEVDVVlZTWVDZkUxWk9Jbm02TzNUaHlLd2hX?=
 =?utf-8?B?Y1lXclhPWXZ4d201VVlwUkhUTWh2M0ZKalFvOXg3ZUtXZDJKN05kTFRIVTY0?=
 =?utf-8?B?KzNTbnQ2OHNORlV1eFhWZ1lxRmtiWUVGSWY5VVRqclBVdElZZFlLTlBuTVBn?=
 =?utf-8?B?Yk5hTEk2cnd0b2JKMVRnSlhCb1FRNE1oYnhsUXhCK0grUk5odWdjM2ppMjZ6?=
 =?utf-8?B?NDZUeUEraVpjaGJMMDk0c2VLRzFBVzU4THc0YVNHRDZKN3JjTjFkdzNXdTdl?=
 =?utf-8?B?amJORDZXUHlYdGZOeEhtbHpJa1BVTFo0cjBsYm5VWloyMFhkRlhxdjg2TkFR?=
 =?utf-8?B?OW9aWkNMK0NnWklGWUd2MGpnNGQ5ZmRuM3ZlaDVUeWVzdml1c1pzaFFwcXor?=
 =?utf-8?B?ZkJ3M2UwQ2hRL3Z0Q245UVJnZUhHalZ0djM3bXh5cHlFd0FaaTByalpYWXhX?=
 =?utf-8?B?cFBqakdCYmZxTXRnRlIwQi9Sa2JCclQ5TUNxTjA3VitvY2VITFhVVFNTN2h1?=
 =?utf-8?B?WE1SN3JxT3ZqNEtGb1FQcE1RM2xaalhRampKdFpNUUUreE5aWDlwaWU3ekhj?=
 =?utf-8?Q?h3lhxborr7TyN6KE+bHFhTsjZK5hXmV72or+Y=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QnJtUGFJV0NlK2d5VHZpUlpuUGJuWTFsRGxBa1hPcXJsWUJXSDlkamhEUm80?=
 =?utf-8?B?MHZRUHpuZ0FKVVFUMnZqN1dEM2hYSWRzZ0FYK29xcFp6aUR4dU81SDZMdVBa?=
 =?utf-8?B?UVZtcmx1OGkrYWoyN2p2S29yOFZiRmtFbWh2U0tUa0FhY2wyS1doY004NEZ1?=
 =?utf-8?B?K2h6UGF0Q0tIM0Y3TXkvL3MzNHBXZU55bU9PS3Nlc084alhZV3dZclllWGZ2?=
 =?utf-8?B?bWl3MWh0Y2VUYkFHNk9YQkJqRVRHYnQ3Umw0U1l5TTZzL1ZZRWp1cEdaQ2dn?=
 =?utf-8?B?Qmd2bmpTeVhNQWJ4WVNtMXl0aWtEbFRRR2l0MXVBd1VDV1p5aXpraTVjdVZH?=
 =?utf-8?B?c3FCSytYZy9sdUw2WG1Yc1FXV1lOUHhoa1hpNnZUUCs3M2xodFlXbmRkWFlW?=
 =?utf-8?B?TGtuWmtmeHlRcnpuUzBkUDBBRDhiZW9yRW5wbk9jKzNjNnhkZHFXS0Y2NHNt?=
 =?utf-8?B?ZjdaZkx1UElqQ1N6aGJaTy9QK0c2bUFoaEJrcVZtbmpNTmNUSDBwSVZlNDRy?=
 =?utf-8?B?anNxU1JseDZLQW1XMHY3WHlLbUFVRmF3SG10TWJYekoyU0pMMzUxRnpoajFS?=
 =?utf-8?B?elRxanJoK3ovellNbzZCU1YwSzNzM01Fb3lEMnRNV0FEY2x6TWFYajhoWjho?=
 =?utf-8?B?R2FxSWxycit3c09HUkRzOW1HRSttV3ZOUmhqanpDelltOXlwdkk2T0RxUFJu?=
 =?utf-8?B?eXRKOHUzMHZaOGh2RG5rR3VCaDczaDhxSVNJblBZOEUwcTc0WHZ1Y0E5WW9S?=
 =?utf-8?B?SGJ1cSsrdk9hM2g3c1pZK3lXeHNLMXg3SjBTcEZ0aTVFZ2EyYVptQ0dhSTVq?=
 =?utf-8?B?SGFzUVVQZmozNmo4eTVCekh5RExIVWFZNUJmZFZ4ZEpidmxFdHJIOXd5RXg0?=
 =?utf-8?B?Njh6OTNlVEJjc1o5NDB1RlEyUDV2SENRVjRxRUZpL3NoRFllcWxoU3owWldi?=
 =?utf-8?B?OUp2aXV2OU9iRDNGa2FtYWxuVDh1eUdQT2JZNG1KalozUko0dVdMUFp3YS9j?=
 =?utf-8?B?ditGQ251SVFFdGp5blNaMndxMkN2dmpoUVNRNlNTUUdYay9RcTdzZ0RZSERX?=
 =?utf-8?B?YXk4eEx4L3NqUXZSSTIzRHh5ZklnTkhnZmRDZXV1eTY4UG1rZjQyR0xiZEtj?=
 =?utf-8?B?ek9zUnJOcEp2aDZLTlNlK0VSSUVWMTJPRlI3bXpJYVUrdTBqcmQvYTN1eUpF?=
 =?utf-8?B?a1RyeTA2enI1TDFGUGZzai96WEpiTGYveUtDK0NxSngxYmZ2eC9wcnd3Wnky?=
 =?utf-8?B?eWVEK1lCV25TK0pIL0U5VjdMYzJJb09DWjJsN09UUitnU0RySkRPYkdOTGtv?=
 =?utf-8?B?d3oveHpvbTVKcDhLMnNqeTB2b0U3UGQ2VU51ZzlacldkZWNMQmRYdGg1MGZE?=
 =?utf-8?B?L0xxb01pcW00LzI1cVpkcm1MSVhBYlgvbjlGeVh6UEJJZEhza0tybkxJb09V?=
 =?utf-8?B?L2c4akNQVUMyaTVRVkdCb0lSR0VtOEVRM0JUY0o0cENkdUxwN0h5dVhVT3lq?=
 =?utf-8?B?UWl0eXFnT0lMR0lORHBJOEViODdDRm5aRStqWURyNlNVSXpCSlNEMjk4aGdl?=
 =?utf-8?B?RjJ2MlZyaVZqSm5zUWp1RXJzVWRrd0U2NWJPL0EybEFLN00wczRSYVBOSWFK?=
 =?utf-8?B?VGhKYjU0VVViTTdaMU16cmgyVk1uREpXamRIdW5mOG1iL1hVVWRUQVZ4MnFZ?=
 =?utf-8?B?L2J1bWFEYmMyOEtVUTlRS1ltTVVaZFVXR0tNcHFQemVRSlpUbmU5SlpybFMy?=
 =?utf-8?B?SDROTi9JbmYwdjBoQ1pLeFRjVVFubjNCQjlEeS9rUjVLUEp3NWFEMFZyNmNr?=
 =?utf-8?B?NFd1TWd1MUw3RzFncWt5NHdwa3o0L1EvcmFubzQ0cnlXRGRLdmRISGxLcHND?=
 =?utf-8?B?eklCbVMyMTF6NTAvNmhPVmN2V2lXZkVrODhQZUh1dXpiS1JIZVhTbTNQM0xQ?=
 =?utf-8?B?Ujc2QkYrZE9kdTNNem1UMlBRTjBHc1FjNFNqVHN3eU9HYmlzek1oWW5hZnRV?=
 =?utf-8?B?TEFyb2ppNUJjbXIwV29jRU9jSHdVbDcvZEtZRE9KYndSTXhWVDVFc3d0TTdM?=
 =?utf-8?B?alFHVHJYem1GUG94Ny9lUVlLMVlubU5oMmxxL3VtN0F1TFZIOHBmajlpUXRN?=
 =?utf-8?B?cHY3OUxpZUgrZWxMYW5yd0Z1bTdwQ09HbDhSWmxQbmtmL2xHY0x1Ri9Ga0dT?=
 =?utf-8?Q?d9F8nmIzQqoqw3CfCXndwZMEW1KE9e5wQ8niXzFNko1F?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab422dd-9765-49a2-3b22-08dccda3bf19
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 12:10:35.0105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMUltduOcRfNlQaxNRsIX/EE638ulWCAllZ2jgoSv7frkTqeuU++BBtR7BaNCojP5+L2Ji7DSPGrN7gVMtQwxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5622
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Sep 2024 12:10:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16852

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=9&day=5&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/08/cip.2024-08-29-13.03.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Sep  5 12:09:56 PM UTC 2024
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Aug  7 09:06:02 AM UTC 2024
  limit date: Fri Sep  6 09:06:02 AM UTC 2024
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Wed Jul 17 01:30:36 PM UTC 2024
  limit date: Sun Sep 15 01:30:36 PM UTC 2024
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Aug 19 09:14:08 AM UTC 2024
  limit date: Wed Sep 18 09:14:08 AM UTC 2024
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Fri Jul 12 03:18:17 PM UTC 2024
  limit date: Tue Sep 10 03:18:17 PM UTC 2024
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Aug  9 01:12:59 AM UTC 2024
  limit date: Sun Sep  8 01:12:59 AM UTC 2024
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Fri Aug  9 05:08:44 PM UTC 2024
  limit date: Tue Oct  8 05:08:44 PM UTC 2024
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Wed Aug 28 11:17:13 PM UTC 2024
  limit date: Thu Sep 12 11:17:13 PM UTC 2024
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Sun Aug 11 07:14:28 PM UTC 2024
  limit date: Tue Sep 10 07:14:28 PM UTC 2024
  Status: On track


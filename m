Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB96BC021B8
	for <webhook@archiver.kernel.org>; Tue,  4 Mar 2025 05:12:51 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.1])
 by mx.groups.io with SMTP id smtpd.web11.15708.1741065168193959200
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Mar 2025 21:12:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RN+DIE7U;
 spf=pass (domain: siemens.com, ip: 40.107.162.1, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFaqE0KM2vumy0zS2djioJLMpYGc/feurv3AupB7TOFjUM77C4X4L0xWAwOyGY9yWU9tV+urjoy7XvUsM8x2PDus/v3BFOtyqMjINSBb/eDwYixR9AHNVu/8dOb0JPlSInIEY76iMY4J5gEA27Jawcgam+8Qgms/f8mI8Zjyb+xSr1yyXmNvPnQqU1NgQl1AT/rnLsRtnwdznAHveedZ4Jr+WLZ1HyULdwB7rijQxf7b9++PwHkMDKlo1iNsgNfz2Tp+IQFR+FMTxS0x/9QiZNrOvc8uHHDfZE6WE27swb+xhCWR31zINU/+F3OJE9U2Wc/kAAF7FSetBNVYIYvJ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCFHf75hL0gFwBKdesmQy9EM1VahvfXKC+TMxtREsgg=;
 b=Nf1kdoyt1EWalXvJqRFu1X81ms/4i6EJolS6cxVQLYsPYJvQ1Tn7WDyMQJgLM6G06TfI3cZ3BsqBtsIyScc30KxugFy+vy/oSzdjJjsqGrU1fxgokbgr12JUiux86oSlNbkW8Bk3UaEW4vuzpbu55vRgreqGNHZTaPVha/gpGiezss/dNUW9bj0NWW/GbLqARGk1M9FnKt6Lp5zZv2U1pLpbMlhd+3w33SvssKKNQJET/CVsER40DuQZIDJz2cGFg6R+wwf34X6ksLwOwCRRwLSl4E1us9J0+JRebszetbnARy9TzVooPJfqnToSi98somqlWHKjYjWSf9GIEyZB5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCFHf75hL0gFwBKdesmQy9EM1VahvfXKC+TMxtREsgg=;
 b=RN+DIE7U7lq62hOHLhgXcPypwNuV9vr6RUnW75wGTEBXfxiH7UNGEp6ie4SIFwtT8353TG6MTFO2CjbI/4lFpWpCcz6ed/68tLxpTnsoXtgmieJ5SVR9oz63P3cOXq4iQDIVAthKe9INA9LqxNwPY8WQhl3Q9YcpFtPShAkCHgDCyYZ15a6yyPv9UZqCBMohzEFMqKHAlHZwePq7AOqP/XKJ8kXP585G5USSCr5dxLdeKsfMhAS0FVs/ZgXbfBt66EKaFMX+vtHm84o6OGKILSEN4jIqBzecELbfhFSfxlFjbnDD1HlzhHeFLcDE9ow8/AxBSid4qcP0proO7syhsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8560.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:560::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 05:12:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 05:12:45 +0000
Message-ID: <85910483-f772-4df0-8a40-88591af32a91@siemens.com>
Date: Tue, 4 Mar 2025 06:12:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1] Set fixed UUID for EROFS
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
 Adithya.Balakumar@toshiba-tsip.com, Sai.Sathujoda@toshiba-tsip.com
References: <20250303062220.4190969-1-Shivanand.Kunijadar@toshiba-tsip.com>
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
In-Reply-To: <20250303062220.4190969-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: e76b9e31-476b-4847-6a99-08dd5adb32b2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eGREYkVHRVJIdGd2cWpyVklRTmQ3S2pDTVVHNkU4dkU5QnVyZ1NiVWZqVkRa?=
 =?utf-8?B?ak4zdzRUc21ucXlQeVdWNEQ5VERHRndGbWxURnlUaFFwa1p2OVNVdVNOQTNh?=
 =?utf-8?B?ZlNISTlWL1NqalQwL0hvd2NlNTZJd0VNNVBNTnlSZFJHRkpCWTA1Rlp2VlZn?=
 =?utf-8?B?dVpyN0ZKeU9RZzM1VHBYa01KaVlXUmM0am9nOE9oVGNvdGNucHpGM2swUk9E?=
 =?utf-8?B?TXppZGlwZTF0by9pMDFvZlpJa01oUjFsVlA3aXBwL1NTaEd0ZElYck1jM2lx?=
 =?utf-8?B?RmUzTUZFZ2pMWldPV25hZlBrY1FjY05BeEk1ZXNiM2g5aEJFQTd0aFJuSy9z?=
 =?utf-8?B?QXhkNm82ZEhkQlY2UnZBenVMUHEyUlFEMk02N0Mxb2orT255eW1ETFE5UGpG?=
 =?utf-8?B?ZWlqRm9qd21GVGc3ai9TV01Fa2tiTjVLZWZWOFNCUEI1QnJ3VUVzWjVKY0RB?=
 =?utf-8?B?OGlFRzR6S0RsWWgrUkx4aTkwYnZ6elBPV2hybFUwbElKYkZ0QUIyNDRKWEpF?=
 =?utf-8?B?UGZqeWNlQ2t6VXBpRklyN0tHQ09wa0gzRkFVZmxLMVFJNXBRcHhpaGJlOUtI?=
 =?utf-8?B?UVZPa0F3QmtWN2JSNDQ5bWM1bU8rT1BFd3FlSC8vNzZsRU5Vd0RrOHRqQldR?=
 =?utf-8?B?Z0lOLzMrZ2RYSEUyYlgvcGRYY2lZaFE5TzIzeXZHK1RBSTBodm0vRHFNSVdN?=
 =?utf-8?B?bjBYL0VUdHE1ekdHbDhjZW53eEpsWXlCQ1FadkNXNHNYSjNPNXE3Ukc5cHNC?=
 =?utf-8?B?UjQ3SVVUeWZhMVJPZlhHMkhoSStPK3A4WDAwUnNMN2FnRFlxTVFDcjlNSTZ5?=
 =?utf-8?B?aEZpaVgra0RaeDVnaHlkY1dxZ0NTd2FyWkxzTDFIVEtvTDNkejhKQVBlVjIv?=
 =?utf-8?B?cEppZGJSTGYxMmgrWDRWeGliYWFWU0l1YVhVaE9KSk9FTzdTOEdQalFyUzlS?=
 =?utf-8?B?Skw2bVdkQjhJL0NRR3JiZU9mSGV3aUMxOGlYeDJlMlNtYXVvUHNoVjlXaXht?=
 =?utf-8?B?dWhwM2FoVGVZSFJkV3R2aDJ3K2RGa2Qvb3N5Vm5WakxEdDgzYVA4VTVjSWFV?=
 =?utf-8?B?cjdaV1pSVmxiY0QydzRaMkIrMXZxdC9QNHZhK1ZTRzhWb09FendMejRVME1k?=
 =?utf-8?B?bWNNY1ROMmN4eWgwNXo0dHRxU3NMUUlpUk44RWlJc2dsdlB1VE1zYkR5dHBp?=
 =?utf-8?B?K04vN3lGRjUzbWpMMjFVTnI2dWd3QWFLRTVRb1N3OUhCWllrN05qNlJMR3BU?=
 =?utf-8?B?OWRqblVIcEJ6NTNmZFFObURJVzdMeWEwL2RNbXB3MCtEYmcxdWZIck8ra3dm?=
 =?utf-8?B?ekVxTS9KUFNkdkd0N3gzUFI0VkNDTk80YkhRcGRBQytlYXArdXlqYit5UzJ6?=
 =?utf-8?B?L09ZaGJOamdUN0xGWlZVa3FHYXVuRXMwRFVDWWt5b3BLOWYrTWpneWVKSXhO?=
 =?utf-8?B?V3QrS2l6V0hib1VFUEtDR1V4NVFGWk1FTUVIc0E5Rnk4MVJXemdIVzNLWWF6?=
 =?utf-8?B?aXFwOW9jT0w5MWZ6S3FCYzlSN0tHVWppeE9XNllKWFliYzFlMjVBc1RyTWZm?=
 =?utf-8?B?UW5WcGN2V08vYWxoZVU2ZkZ3NmF0SWdQa2paOXB6R2R3NFE4V1dWOTJBK2xw?=
 =?utf-8?B?UTFQMnM0U1Q2RVBZMTBGM1o3S0FzOG1UUmg3bWxJTmFmc215VkI2d2xaVDk4?=
 =?utf-8?B?ZGlpYzdxUkVmMHowc1p6bGVqTVJxK2s3VzM5Z1JmZFdEZ2l5ZjI4ZWpuQkxR?=
 =?utf-8?B?NXg0Skl4L25kcVJHcDVkT3VWR0drcmRQaW8wajF4U1plQ2Vtdmo0V2xzb2xr?=
 =?utf-8?B?VGNSdXo4emdvMy9qK3JCemgrOUluYjlzbW1wUXdvUmY0ZWVsa1gxb0xIU0ZT?=
 =?utf-8?Q?TG1+UNMGdVjyY?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TEUrclkyN3N4Sy9NSUVqTE9qODBHUFFsL2lKcnhqMmpLRkUvU1RJNW5aVzV3?=
 =?utf-8?B?ZDJxS2NaYnlLaGpVRElSSFhuenZueEU5ejRrNVZmMHBWNlNkQnMxOGhkNlJJ?=
 =?utf-8?B?M3FBTzB4Nzk1T2d3c2NZZ01zeDJVSFlGYjNrN2x6OStWSkc3MWR0TStoOTFB?=
 =?utf-8?B?bUNXc3ZQMFVmWFFpYmNkRXZJVDNjVmg0dVlsbVhVMFFobWNnaFVPcDMzV2dx?=
 =?utf-8?B?ZzF4VnNrWS9iVVA5L09Dd1pjL2U1MGY4c2JoelFTZU5qZTlwU3EzbXpHeHA1?=
 =?utf-8?B?V3AzYW5ZMExFRkJuNFgxbEdzdWFtLzdIUGRobnF4c2c2eDl4cjBIYUYxbW8y?=
 =?utf-8?B?WlI5b3NuNTNKZHBxUTFSck5xSVZTUTdqRmh4SUV1ZmUvY1loRVNEdElDbUR6?=
 =?utf-8?B?SnJFMlRiRlB5VXN5eW9aWXVmZ2duK0ZkMVVOWEplcDBTdjhmVldIOWNVM3dw?=
 =?utf-8?B?eW8xQTNvbVZBVVVpclF5dVlqbU40TlQrUGhkRGtkcUxuZ09qTDV6VitQKzdz?=
 =?utf-8?B?dkZuVmg2YXBoaTIyVHpCYithR3lKRjRoanZOZW9NUDdITFZVeHFkZW5KTW1Y?=
 =?utf-8?B?T3IxVHJ4T1k4VU1vdlBWT2RnWWUyQTgvdFRhZEZTZldpdzREbFVyRkdMb2dK?=
 =?utf-8?B?dmg0eC8wUnhibUJLL0lpd2g4NFZHOEhiRHA0eUhHY21jRXB2Y2svdHZqcDE3?=
 =?utf-8?B?QTBFT0x5djVocUtia2NoNXJZTk16Ykw4MTY2UlV3RWtVZkhKMGJxMTB5UHov?=
 =?utf-8?B?RUpEekQ1RTNwZ0dwUjR2Q2QzQWNlOTNTWTdGdHJndU1VN3k5U2g4THB4RG45?=
 =?utf-8?B?NzRvbm9ieEN5UFJWUklsMlRXNDJ0bno0Mk5sN2VhL0YvTmlxMmtQM3FZVWU1?=
 =?utf-8?B?eG9XbzlUYTBON0ZyaEhtby9mejI0dXlhOER4MFVLcDlxQWgwZjlrTTZXalF0?=
 =?utf-8?B?Rlk2N3BsczlmSHBjY1NSSzc4NHJ6cjhMNWJDdWFWck5VRG9pQmgyajJBK0ww?=
 =?utf-8?B?RnpTalhSNVQ0TDIwRmgrOThLZXJnaGN5aEt0eDF6b004WDJISzdna29NKzNS?=
 =?utf-8?B?dVhycXN4S1NrZDQ1NVF6cElmbWptc0lrZkFoRE1iYTlNbzRHUDNRTE9nQkdG?=
 =?utf-8?B?N2tlMWNBOFFPTDBzaEFiamI1Q2l5SEE2ZVp0MDBMWG5WWU5zcDR2UFZNejl6?=
 =?utf-8?B?SXhxSjdrRFl3QjFxSG9Eakxiek9Welh3NjZmUDJWVU9hMDFEQTRiZnZFYmRV?=
 =?utf-8?B?cktyT3IwV1ROLzFDelNhSDZjaVl2aWRnTG9Xd21ESTgzRXoyVkdNSkIrTTd2?=
 =?utf-8?B?bEd0cEk1T3VVL240alpyTFJ5bTVwNXVVQ25RQnZNL0VralRWT0J4aGhQMzVw?=
 =?utf-8?B?bVZ5bnlVRnRVd3FDNFdxajlUWGVxRTJqV2ZRSE9jYVZkT2R3N2FHbllDeWxv?=
 =?utf-8?B?V01BM3IxYWNtd0Yrdk5MZmw1b2F4QlFlYW9BV29Ec084RGdQeFR1cHNtTkJa?=
 =?utf-8?B?UCtzcnFVOEorTzRyR2dXQXFYdXhJVXdOa3JveTQzb01wM3U1d1pVdTlXZW0v?=
 =?utf-8?B?OFJyZ0V0WW9yYk5rbmQ1aUp1WnJNMHpORHNBNGF5Q2JQbjBUeU1hdm5Hdlkz?=
 =?utf-8?B?bHVSM25HaTJZTEtmYzJlYVV1WXNVa3VRSm5xdFJRa0dFblBQRGtDWTJIWDVp?=
 =?utf-8?B?TGFWRnFoMWEwMkFxZ1lUU0ZmT3JuVC9tQW5PcUF2ZnNGV2xkekNINkhOYi93?=
 =?utf-8?B?TjJaeThBTFFxbUswU0NqN0JHNy84NGFoQTNkVXhnZVU4ekNOa0xaTE52b3pt?=
 =?utf-8?B?OGdqQTZqb2JOUDhaMnFHYjhYVVE2QlMrV3ZsZEJIOUVGNWN3Q2oxMndOdWRm?=
 =?utf-8?B?RldKL3g1VTNKVDRSQlpoNlZjemNLVVdzbVRLMkprUDlWSGNoWnZSK2MwbE9N?=
 =?utf-8?B?QnM2UTNha3RzTk1aTTRVOXFIVGRzVmZsekliK3ZXRUtWempOSjFQU3ZxUGF3?=
 =?utf-8?B?dlN4TzQ3NjI0U3ZoVU9NeWFEVDRCb0tTNkF4VWJoSkMyRFBiT1Z5ckEwdEM2?=
 =?utf-8?B?dHQvOEx6T2dLbFVONFlqcVZ4dDFMYXd2eVBRM3BoUTg3RVFVTDNBdlZGS2V5?=
 =?utf-8?B?NWtGTDFwQUJRczFESW5aN1dncHJIV3c0OUovcmZGNGtmNDMyZHFwdXJPZW1v?=
 =?utf-8?B?ZEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76b9e31-476b-4847-6a99-08dd5adb32b2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 05:12:45.2389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RGNV5seCqzX09R6hK6YDl0sN8Q57iz8tJggJV61lXAlnxkiSm9nN53dLq5fAWmsBUw4yc063nKghNklzBRtmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8560
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Mar 2025 05:12:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18006

On 03.03.25 07:22, Shivanand Kunijadar wrote:
> Pass fixed UUID based on the SOURCE_DATE_EPOCH variable to make the EROFS
> filesystem reproducible.
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  classes/erofs.bbclass | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/classes/erofs.bbclass b/classes/erofs.bbclass
> index 72458bb..2743bd1 100644
> --- a/classes/erofs.bbclass
> +++ b/classes/erofs.bbclass
> @@ -25,6 +25,14 @@ python __anonymous() {
>      for dir in exclude_directories:
>          args += " --exclude-regex '^{dir}/.*' ".format(dir=dir)
>      d.appendVar('EROFS_CREATION_ARGS', args)
> +
> +    import uuid
> +
> +    sde_time = int(d.getVar('SOURCE_DATE_EPOCH'))
> +    erofs_uuid = uuid.UUID(int=sde_time)
> +
> +    args = "-U " + str(erofs_uuid)
> +    d.appendVar('EROFS_CREATION_ARGS', args)
>  }
>  
>  IMAGE_CMD:erofs[depends] = "${PN}:do_transform_template"

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


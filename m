Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CD0C77B7C
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 12:17:36 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.50])
 by mx.groups.io with SMTP id smtpd.web10.21058.1751545051679996291
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Jul 2025 05:17:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sLBumxb+;
 spf=pass (domain: siemens.com, ip: 40.107.159.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlK/yy1nCo+hmOXrw2JJo8bxsJQo4rfO+ILvNvW7RVkNOIelsbvTeXsVaC1SzjTeLK+cxrMqgzILty7B9/HonVuVZTs9gqYFZtfMKlxYUIRjUQ3qYFPRs0if/SINTlzTY07+qoRepdLs8jPevB5Xllt4oReDwHapM6Mccm7gdIZwrExC+0eDhiFlKSzTjyeOXbOVgumc3sz6mntiCkefmjOheygGDKAmDwdu9+Mgei2oCBnxhFet5jizav51afr9BP1NM3mj11WuXbXAXdgp65maNJLNcRpXFRNGD0j3vz4ei3ytrGZ6FFIdN6TQ+1EZIw8ZL4fypPhEdx2zxgZ9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6TOcObN1JR4wYf0DLUBnTk+RerZofyE6QDSMs6p96o=;
 b=QSNrOA71PaDu+lSsrc5ZkNSb4e6uIfN5t3nW2usSdmR7VBcIku5zRfaKJkIjbMRzXIBhU2r1JnMflswnuA4Mcs7nhk07fhTO5WwBr8hPSekPUzgPpibAMuedzqy+gbfJYdWGEDxnMl8mCOduY9T8AHJSpTeBagTJh3p+uqFfUfEEP5TtlRy9MuS4P0nOEZxbFbKggtlcllgI/IsmOkgwah8yM0mDo8ChlT2Du/vdOtZ4M10m1/S3ww7WPQLuGHm4IfMG/j4pGilKCmKa05djcZYUSkrAMspmncot75hWO3bJr6Pp6BPKXvXomhFHySy3M0VeV41kkoJoKKISL+A1QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6TOcObN1JR4wYf0DLUBnTk+RerZofyE6QDSMs6p96o=;
 b=sLBumxb+VfwLJsGxGJKd3AWW6TA3DMqe1VWH8JjQtQZ6VNoTz5CttViwWAlRT3lw+7SURYitmTAAZYoQNFJUtGhp5HPMzBFikDYTyNdNUaUjb8nX5+GooYdUydLfXYVY5nfsFCYXjddwzfnV4wqprdkoogy4VjWaYiNOQfKp1pvvXq4hfopw6Kmv4qH8fUw0KnqPmIr++pTesCWmAqjreLgfPct7m/1t0gQTA/OKbApC6QoxE9h0Dcndrokc4fUy5PR30H3Go5wrqIS3BcTEV5wXKIdh0ijlVzS7civhOQw+6nCYcJTk4z16QH6UzPncRSIOzhu8pgps1OPQp9NPmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7479.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:591::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Thu, 3 Jul
 2025 12:17:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 12:17:28 +0000
Message-ID: <4b2c08ef-d6eb-495a-9482-890d1b3ae93b@siemens.com>
Date: Thu, 3 Jul 2025 14:17:27 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update cip-kernel-config revision
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
X-ClientProxiedBy: FR4P281CA0299.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cae402c-01f8-4aa1-f0bc-08ddba2b93c4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QWhxbTF5NEFpc0c1Sm9VV3ZDajcvMnU2S1hyK1h4SkNmK2VrWUV4WHIxRFBv?=
 =?utf-8?B?QkpDdTlDZGtFUW1rN3FtS2ZBcWxZcU0wb0UrMWhWUTBQNVJvV1g0TkZmUURt?=
 =?utf-8?B?V3B0M0VvdTdyUm92SWZ3SjNTNW12dEw2UW41TG1jMGRmU0R2TFg1ODdmSERU?=
 =?utf-8?B?YXIydGhIZE1seTc0Q3l4R3VJVmVtV3NNNCt3a3NNcHhNaDcvYmV1am1MLzdC?=
 =?utf-8?B?L3lxUHdEaVUzRjFFV2FuNXVxWk1BYTJUeW80RlcrTTBuK0MrcjdRWGV3Nnor?=
 =?utf-8?B?bHJvcVpBWVI5T013ejNjVnpveDdnSmhzTVI0cjhWcjM5ODl0MTFxU3FLbEQr?=
 =?utf-8?B?eTdkWDd0Z3dlL0NtZUhmUm5YYmpkYXJGSWQwYldyS2tDeHM4Vmg4RU1Tbk1j?=
 =?utf-8?B?VDFpdExpRGowaFUwbEd6TjhVNGwxSlFudTE5anplbGsvKyt1ZDBKUXdQQlEv?=
 =?utf-8?B?dUM0WFpXeEpiZUk3Z3Ivb0toWHY4MDhjOFdpYVVzenZ4SkZIU2JuRjRVV096?=
 =?utf-8?B?YVNQZU0xMXBXNkQvdm1PZzk5Rng5N0tHbDJpcVByY2plOTVyamxFL0FGU0o0?=
 =?utf-8?B?UzdkZ0o1Smk1Nlp2UmtOQ2xIMGo1ckIwNkJqdkMxUmo0NHpQSGFGengwRjky?=
 =?utf-8?B?bnBWbVMxNmNhWDFyQXdQNWNsT1lLcnFuSXZ2VFpqMWR2OU5pa1lrcDM5MEJw?=
 =?utf-8?B?WjFXalluVnRxT2NobkcrWlNML3hrTGplWjdaR2JTdzZSS0UzRG5GNnVyUU95?=
 =?utf-8?B?RENXNmNqUFZ6QVNkUVh2bWtoTkREVVYrVzhyVzI1WFAvQmtPWDJ1S1J5V3FZ?=
 =?utf-8?B?dG5NL1R0dis2UGpvNUUrbkd6eHYxalczcGtuckU3c1BpQnd6aVhNdHRBNEp0?=
 =?utf-8?B?ZWFPbmhLRTdDS2F0TCtwVFBuNDh1OFJUM0dFQ0I5anBVaTBydGtIMGN1U0Ja?=
 =?utf-8?B?WHphWXY5ZGkzczJjaGRNQm5sSFFxL3c2WXloNXVMSHpjK3ZqeDNKSmVvcFFV?=
 =?utf-8?B?SDJKY2V2QkRPMmFidlRMc1UyMG84MkRwMGEzc3VwbVQxcTB0Z3FvNWQ2N3Fh?=
 =?utf-8?B?OXVhbks3RUdTbDI3SHhLVVdFMUlvZUdEWHc4dFpzSEErbnAxdmFZbTFFOW5L?=
 =?utf-8?B?V1pOczVISlJBeTJ1dWY0RHpYZVhaSXQ5WHc1Y0hOeDlENy9Rb2VPejc1N2pa?=
 =?utf-8?B?V0srWmdMY1FUcVpMVk1UQ3hVY2ZPRURyWlNNS0ZvMVJqclgrMk1lSThwVC9a?=
 =?utf-8?B?VGhzeE1zTXh2UVdKL3BoWDlBQXhpSDBnTFk3SmVkWDI4bkl6anpId3NPVnJZ?=
 =?utf-8?B?QlpnbERvTUx1a1d4cElFTWtmU1JkcWZiUjR2R2dBZ1JJMm94ZEtwS3Y1QzBp?=
 =?utf-8?B?RVcvN0pwNGkvTTNpRnJmMFJpdkQ3VDFTWlRWc1podEZFVVJmSEhwUHBycGJw?=
 =?utf-8?B?bVNROUxSSmNoTnp3UGRJbjZTVkQ4cVd5TlVKQ2FzT3lReVFsNTluUTNUWFU5?=
 =?utf-8?B?cVVuWXlCbHNFTVVrV09HWlBhbTA4L1hlNmlsWXcvSXE4Y2pweXF3Kyt2aVA5?=
 =?utf-8?B?bGlqN1V3WW9KcVprcXBURDBHVE52SHVMT1g3bjNVZmoxbWcxOE8xb2RlaVpj?=
 =?utf-8?B?ZVl5bDlTU1VMZjU3eEgyVHVXMktkbXZVa1dMcXllZFZMMVhneXlJUVVPZlF5?=
 =?utf-8?B?SzNjc1B3ck80d2JvT2hkYVB5SGNWeGx6MExuTHlFVFkxVzBidTAwYmVtY3pi?=
 =?utf-8?B?UmJraEg2RTMrRmtVWDYxU21RT0ViU21DQnBnYThsS3pKN2U0czY2K1d6ejZj?=
 =?utf-8?B?bVRKTzFTS2h6eCswSkVDb3ZuK3BRMmpIekhGUXUwT3pNSUdDVysvenlQeTM2?=
 =?utf-8?B?S053K3JKeTZHNGpBaTVOeURQVm9UelBoSmRUWERLYUZsZDNOQkxnVGZjcW5j?=
 =?utf-8?Q?KQ7xxwAPqrk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TDF5L2lLakw2Z1JxczlZbnFqVi8vUy9LR1JITm1oUUdNM0NjZExPeTZMZDlN?=
 =?utf-8?B?YWZGR2dqY1lBenVieXZYS0lnVlNhNThFTzl2NjBoL2RaWG04ZXQ0dGYvRmlS?=
 =?utf-8?B?Vm5XUHlFVVNwZndPVWJCT3d0RnpTWU4wWGNua29aV1VCNnV0TWhYU21CNWI5?=
 =?utf-8?B?REJqYUVpV05sTkx1Uk5vTHgwTW1iaVJCSkJsR1NpcDg5RTZYWjN6c1M4QjVs?=
 =?utf-8?B?VVBldXlJZEV3em5OWGZqWHlIQzVtcVl0NGsxeWFvWTdLL2RUZDRaWFZVc04r?=
 =?utf-8?B?c2JJMlVkQytSTVlud0N3RDlyZExSTnZzSDFZMGlBNmZjRVRCTzZmak90d1o4?=
 =?utf-8?B?R2FLRjVQd1I1dG9oVEhwams5VDBaaUIrc0Q1RWhTQUV4RkV0aUF4Z2cwaExZ?=
 =?utf-8?B?ZURtNjAvenF4aDVLengxdVZoY3MxaU9IYjdJZm82QnFYSHZyQ2JaZGlzS1Bo?=
 =?utf-8?B?WDJ4bHd1aDVlNW43cTU0OFQyRXJhT2VwSHRRY05PYVkrWjc5VVZXeGFSM1FV?=
 =?utf-8?B?NjYxUkpESTlaNEdDTFNuRHMzc24vU1c1aU5kcFpLbTBmNEtFVE5EY2hLNk4v?=
 =?utf-8?B?SG1wdjBiRUx5Mmh2Yy9nUTlqbUt5aHJ5dGc3bXJESDhsSXhaSXNycWZFWm0v?=
 =?utf-8?B?SjZXcVl6Und6c2syR051d0dJQzl0M1Ayemx5L1hBSWk0eUJHOS9iamJDb2hJ?=
 =?utf-8?B?ZzBxK2dVSWV0OGdLcUpuRWp1TzI2NU9GZ0pQblRPdXd5SHFoTFlSREZIdU9y?=
 =?utf-8?B?bXBRaXh2N0hYT3A1R3puWXVlVWNyNzdTNGJ5Qi9YYzV4T05PWkZXeVRYVE1T?=
 =?utf-8?B?SHB3cmpXeFc0TUMzYWRlc0Z6bTlMRG9GYnJrc2VBYjg3WlZRSWtWckdmL2o0?=
 =?utf-8?B?MHJueG44V2FhREFHS3lMaW5Ha1V4WW93OFVjYkk2UkRRd2Fac3RaRStNdzly?=
 =?utf-8?B?QXNwdlNCL2kzandvNGEzQm5aOTlJMWQwYy9WdWhWRGtDNFFtVnlnZzNEM2la?=
 =?utf-8?B?Q2NuL09TZExRUWJENWYxYXVmcmJiRDB1ODJzN0VRMEFON2hZeWNWaVBiUCtE?=
 =?utf-8?B?cUExUjZjTlc0WFFkZWFrbElSNXRxSGhXWVdXcHg1aDlCMWRicjdNd2RIWEcr?=
 =?utf-8?B?L0toSHhDQ2ovY29idHNuZ254Q3ZpS0NMQ0dDSjB1dHFYM3FOVHI1OWQ1RlNW?=
 =?utf-8?B?WUhvazYwUDcvMXJBNDN2MmVQbHBoMGZOc05qYTE0K0E4MEVWSDNLQTJGTjBp?=
 =?utf-8?B?bmpBWkkzOVl6L2xCa2tyRmdYN2t3OXdvOVVmd1cvSk9raE9haVgrYVRFR2M4?=
 =?utf-8?B?VnYyK3V3UW50SzY1eXNTZktlTkxkb0VwOTdZYnBRTjVqUmpsWGZFS3lyTkV1?=
 =?utf-8?B?SGxlaG93eFhjRWJid2s5M0xua2FIb0YwSjFkbUZ0Y25xZjFlaVFkQ1ZZNnoy?=
 =?utf-8?B?cFpadEUxWUhzbkRTK3ZndEdvTEZpSUcwTGJ0U3Q5TzFPbktmcFZ6a3lHK1FV?=
 =?utf-8?B?cG4rQWpIQjdWVDNlV0tOdjBlMklxWGpNWFhXenREbVg2Z05sTGpsd1o5bW10?=
 =?utf-8?B?bkdINEJWRE5YZVhjczRXSEF3eXo3K0tJdnMwbW0vUXNKMlhuQ3V0R2d1SEQv?=
 =?utf-8?B?SnRaQkJQc0p4NE95UENPK3pJRkwzbXYrTXYvcW1zZXNFeS9LelhxVGllSXQv?=
 =?utf-8?B?YVgxMERicHBielVkUTRjQi9EaUpvWkloUll0bDNkZnd1Szlxb1B6TGpRSno4?=
 =?utf-8?B?ZzRxNEdnKzFoUy9SbnpOb2dyR0FQWXNuTXVMc1BTWjBYQXRKRi9IQ3c4UDRj?=
 =?utf-8?B?YmNDMjhpeGpHc0duckNsb0l6YUZkRjVsTEJvVm5yUUlxdUo3QWZveUhTV3Bt?=
 =?utf-8?B?UlNTa0VnY0VvRE42SFhkL3B1V0pVVTlSTVJwTFM4VVdYWjA5TVdQeC9DYzFt?=
 =?utf-8?B?NzJiR0UxRktWSmNoVGdTOVgvdVJvVFpKQlNOUzN0Nk9OYmljMG1mYXlNQnFV?=
 =?utf-8?B?ZU1COGdpTytNSUFpSDFBekdXMEpJaVdldHR3bEZFYXZoOTV0b0FlODlOVXJn?=
 =?utf-8?B?bEZ6UkFNOUZIaThGWFZyUjBtOXlia3BzYzZiMGdtUHBmQjA2RWJqcmlNRUth?=
 =?utf-8?B?QnFaMy9xcERpY1cyTVNNZjB5SSsveDlFbWw5K0JwY210UklBZ2Vwd25RRFZ5?=
 =?utf-8?B?OVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cae402c-01f8-4aa1-f0bc-08ddba2b93c4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 12:17:28.3745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4/wjoJfG7wjuVYoUxbi8vXtRczu2a3JWW/VTLKcmR5lgTg6ug+uRJQmNIJwhnrWYVqyJraaz6gQnT+NVE6eQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7479
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Jul 2025 12:17:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19324

From: Jan Kiszka <jan.kiszka@siemens.com>

Brings BBB support for 6.12-cip. And it enables EROFS for all targets
that already support SWUpdate. There is currently still some
instability with EROFS on the BeagleBone Black which may lead to
disabling this combination later on until that is fixed.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 0e44433a..e8eb4cc8 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -14,7 +14,7 @@ SRC_URI:append = " ${@ \
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "4bebf19735a238f9e46e653751e8d47fb22f8c07"
+SRCREV_cip-kernel-config ?= "29e3fbfb85303cc4dc9797740df5d54f77f43feb"
 
 do_fetch[vardeps] += "SRCREV_cip-kernel-config"
 
-- 
2.43.0


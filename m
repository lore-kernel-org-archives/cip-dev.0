Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753B1C282D1
	for <webhook@archiver.kernel.org>; Thu,  6 Mar 2025 11:48:12 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.50])
 by mx.groups.io with SMTP id smtpd.web11.11080.1741261683665936228
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Mar 2025 03:48:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=y1Up11y3;
 spf=pass (domain: siemens.com, ip: 40.107.20.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPvkwwTOEMsM9xJNTXOZOQEKhT6S4Qog02Kzu3QTbk3BmRsuS0KiZXDIDJ34ZPwAmfhi33Y3BC1Cs/SUKz85KaOAaNtAlQcEp7xBAywKb7U+kH75Ck7feziyhJHY43i5AXaASL9H5nJfMHNNd4GzZLhVh8ZXFhxDJQkLfgVWn9gXZFTi2O210N5IaPhCjGs0kL4zSB7wIZvx/TzBX3nZ3HkYZSWKAlk2XMDLxyFeve5C4Jxs2JRRsAZVBDrJRdGBnnHAbkichmsUelCdK7T4FygvPYCT/NQSFrXcF/BKDDVxdZp67z7V2IZGPzdAfPjvTQEBAZmmZLH8g0f0/t8HZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHyVUBJcTkbYugrSFuibav0KKtzkqcGZWjN00hsGk7g=;
 b=qrtZxWIWJk4Zw5AYP3o9B375+5yYal6e1AkZ3gavfwpCHWmkQlnkL7AdKQK7S2Yb4Ud/FYU+E4EGE6LZMnOWbzfycQYlv6RpBwQ5iDDFnFgmkrEbqT1mbppYslsu1x2dTGzpNQp5DNV1CMtkytxYygucKV9UG/swXMwIZuXHnnWShBXw4SFDAYipY0aGEO72FvqiMI1i8vsSNOQgXwRbn0/ZMC6q0QnLshfPCqpUZwjsJTKUW5GOiYGylf5ZZjtB0jYiCkkfU3oP0DfZ1DZPIrY1hG+wqMta7aIRBs8rD0UZ3ZsK0QBcgepd0IHtmN3WEMd3Xwk9YaTA0ZVmICkyXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHyVUBJcTkbYugrSFuibav0KKtzkqcGZWjN00hsGk7g=;
 b=y1Up11y3RntartPVX6gake6Hfg0Ox+rADFXS9oyxPAWfuXltm6E1AEIr3i+Qoxre/KHgBLNjFtOOlBFbzHYsLSbu61Hz7TDofHoXM1J5I1LLwemfqOr2R3XnQksyf9zAr1rdHPV5R59QaBtm3roGI3WqsIeHdbmOhrKdB/GUWNyKuzFBio4zNFU/6IV92TRZEfj7WSVY5htyO+gAv9hidb0yBNsKmI+7d06eFLggo2qTpmf8VUMxw250hwVthICVIpbcHFOYYpmomQgI5HTUW9JmlIkZZYT0Q+KXUUq+ZVLuoGDJEMNbvYeeQ+wp90yIPoEPtgApHXJ6uRIs4z0Hfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5165.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 11:48:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 11:48:01 +0000
Message-ID: <87b88c83-3fce-4038-b8b6-cfe83056fb9a@siemens.com>
Date: Thu, 6 Mar 2025 12:47:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to signer
 provider that hooks sign-secure-image
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Gokhan Cetin <gokhan.cetin@siemens.com>, cip-dev@lists.cip-project.org
References: <20250306093516.3232063-1-gokhan.cetin@siemens.com>
 <3f756d50-aa21-484e-aa52-f91531451dc0@siemens.com>
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
In-Reply-To: <3f756d50-aa21-484e-aa52-f91531451dc0@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0018.namprd16.prod.outlook.com
 (2603:10b6:610:50::28) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d67956b-61ac-41c8-4f38-08dd5ca4bf38
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?emZsbjNKZUtqcS80TXpJYlZjeVVtMTJzeVRrQkducmlOaTRSUzVud2I4Q1Yr?=
 =?utf-8?B?cmZzSVEyZHlBN0JYa0pDM0lLa1lUZStKWDYxT3dzMk5wVjV6cUNrdzJ1NnRy?=
 =?utf-8?B?cGRvS3gzV1EvNkJHN0NaZTFuQTh0ZlFWU2x6aUxnQm5zVnk2WUdsL3ljai9N?=
 =?utf-8?B?U21acHFOMWl2S3BnUXlueVNYQ0NvNC9LaUc4YWo4Uzk4SjdraTcyV3ZkalVz?=
 =?utf-8?B?OWV6c1dRQTNvR3cyb2NLVFhDSFpCZW5BbWNPMlQ3RE8zSktSWjVmR0FJbm8r?=
 =?utf-8?B?aVdtbzdSbWdxTG9ZS3UrTndQenBjM2Vpcjl1U1VQSmFHcmZNWGt6OWpBY2dm?=
 =?utf-8?B?bjdOWHYxUis2Wis4WFVVOWJSd0txcDJYK3UxRldEVUwrS0hxTy82OE5sanFK?=
 =?utf-8?B?RGxQeG5DbUJ6d2VWdm14bHZmUnRkNzFmRU9NRGxmRjM4V29IR2puY3NGNlpG?=
 =?utf-8?B?bGU3bTM3dHBoRExxRHFjSDhseEVsWTNpb1FsaWFLc2NjWnBjZ3dIWmxKQTBp?=
 =?utf-8?B?Z280bjkzbjNveWhtTDdOazYvSUxFa1dzMHJVUG9MbjczUkJBblVsclRBcUlJ?=
 =?utf-8?B?Q1Zab1ROS1VSUFc2THBPc2ZDVE1vVDg1dFVSdUFCWE5FdjZLY3d1cHZxcThW?=
 =?utf-8?B?UnA5STIvVU9jUVBmbkZvTWZkcE0xakF0QTIvNTVwYjdYYzJGR0FCbk81UEhy?=
 =?utf-8?B?U0tFM0E1d2h5KzZJQTZQelo2Wk1CSjcxeDRPaGtROXFjZ2lOUUtDRGdRakdv?=
 =?utf-8?B?cHhXWHZva3A4RFIvRTN1MTlTbExBVGpONU02YjE1NUlDeTFXbkNSN3JJQzdz?=
 =?utf-8?B?Z1NxUlcxN2NtZFlxZ3ZlNk1BaUxYVm1lN1BleUFMY2lpNGZjdS84dElSNzZC?=
 =?utf-8?B?a0hteDNrT3ZQUzhIaWFtVmNra1hTMzE0WC92WFhnd1JiUnlMaEl2SG00Uk1B?=
 =?utf-8?B?R2JxdytQSmlQVmg2QjJ0RVFtSXU2UDBKRjdaQjFaTGJpNE5kZGMxWEhOTGdN?=
 =?utf-8?B?eElUTjdBTWRXaXAwQ09RYzhaNmJBazR3ZG01bE1HTlhwdXdUcXJGUExXZy9v?=
 =?utf-8?B?SlVYRUhuUndOZ0NhaThaZ201RU1JbGpiNkhsKzdFMHhMWXBGNTlUYkNDMFVy?=
 =?utf-8?B?cjVWbFNWdGd4czQzdlpCb2ZOZE5neHZVMmZnNXRjenhhYjE2d3g1Q2g2SVNw?=
 =?utf-8?B?Q3MyU3FuY1NxLzdvQnYvaUlhTHpmbnBkMEJFN0t4SnBkaWVxUWpLZi81dlRT?=
 =?utf-8?B?a0VGQkFlTW11U2lYL1lKMUcxKzAya2tvM1FjTjlYKzl3aFJXMnVjaXRFSTRt?=
 =?utf-8?B?UkUwd0tXMjIzNTVhWHZTbG8zS3M1cFpzUVFJd2ltNGphQVRhOUJaNkQ1WWVZ?=
 =?utf-8?B?czg3ZmdQeFcreThRdmIwZzlZc3VWVGgxS0ZUbUxxSVRJRnhIVVFIR1hkaENw?=
 =?utf-8?B?Q1lBYWZqbEZraFpnQjgwWXg5emhYZWprVjIwTmYvWk1SWnV6YWo4c2l4NDlJ?=
 =?utf-8?B?K3U0NTRiVFRSOThOSzAxRnU4QkdCMGhGRVp3WWsrOHlHVkd6UlJyYlV4VjMw?=
 =?utf-8?B?bm1lY3BFMDFDR09pMkNhYkpUaWQzSWg4ZEVFVG1qL2tvWDZpMEZkTkZ1L3M3?=
 =?utf-8?B?bkVuelVUbEk5NUNOMjJ5R28rTnFNcU11cjhjUkIrNmp2V0YrOE42allZVm00?=
 =?utf-8?B?UUx1YVF0WkcwTUdSM2szcmJmYzEvV3lta0FGNnp3TDFzcmtXMUNaMUFzL2Y5?=
 =?utf-8?B?ZFJXYXIwdWNqUm12QWJjZnpqYmpBUWdSM1NIU3RIMDJGQW41TG9oeWFpMldG?=
 =?utf-8?B?V0Q2SEErb1loQmRsNkdEemxNWnlRUU1CVkxlUFY3M0orZzc5MFBQUWgzcWc0?=
 =?utf-8?Q?CYTJ/ugQC61LJ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eWhQb3JLeFRwM3RLY3ZkOGh3WU5Ya1o5VmVDVFpGbWh0enRJUFN3c2JUSHla?=
 =?utf-8?B?QytEZ3dobGNkRnUwbXl4N0wzaWhIelkwSncrRi91cGxwM093WWUzb2FzNWp0?=
 =?utf-8?B?K1NRV2piN0hxMWhnNXE1WjBuTHNibVZoSlpRRHc4OWI1V1dJb2NwZFBJcGQv?=
 =?utf-8?B?emhOVVpxQ1p4a3QvR3QwQjVjTUtUUk9aanpJUXozQ0pFdlAyQjlpRzBVK0tV?=
 =?utf-8?B?OU9PWlh0MmIzYnNGS0FpQ1lyRU9ZSXJlYTh1aGVCcGViNnR5aFlvWWtRNUpw?=
 =?utf-8?B?Zmt4ZzJtQ2pkR1dEWUk0ZEtmbko0ZWpjSVFTdnFXdExYejZDZWlFdjVIRWZv?=
 =?utf-8?B?bXl4eW1ycDh6WVJzd3B5bGhuVXQ3WDBKMEc3R1I5TkJCME1aOHZoYmxhK3JT?=
 =?utf-8?B?aXd3UGU1UXA3d3J2RHRiR0JNeGFhYTlXT3R1ZzFHV3NvMEkvcUZJQ0NaRWVX?=
 =?utf-8?B?eXdpamx1VU92d1FpSmtIMU55Nm1TYXpiWXUvR3RjOHdjb2x5bU1uUWlBM1l2?=
 =?utf-8?B?RlhsRFVSaWNlb0FndWYvMHVLbHZiaDBLMnozRUZTTmRTb1ljVVRiS3M5eGho?=
 =?utf-8?B?eEJTLzVPUndBVHFKTUxDeUN4bFJFTWI5L1QyV3BrUUduU3ZNc0xtQUZObFhS?=
 =?utf-8?B?ZU1kVjhENW1vSG40eG4vLzMwK3Y0Nnd2citFSk5qNTV0Q0FDVFdBZHZJMHJi?=
 =?utf-8?B?SjFzb3M2ZGlhenIra1BNYlRTeU5jdTR3TVZ6SzVCQ1B2Ym0rN244QVE5RVU2?=
 =?utf-8?B?ZUVFUlkzUzY2WkxLaVpkWUY0dGZCZHdpWDRRRmV1NWhJNTVkdXFYZUxEN1Zx?=
 =?utf-8?B?cXQxN054b2VaM1N4aHNCMUJlRStZTWJJcmF6UWthSHFiTStoRngzd043MXFy?=
 =?utf-8?B?SkNac1RWNGZPa08vLzloY1Y2RjZwM1NYVmd0REZNMGtCU25JVGhxbDhtdXRM?=
 =?utf-8?B?VkNJSkRNTXlzUUV6TkVGbTRCRnNsOTh4MkM5b3plWnd1bjRNSytzbGZ5VGZH?=
 =?utf-8?B?eTBEMGFlMXNERGRqV2pCMlppRlhZcHpFMXIybXk3c2JDbkxuVmU5RmR3cDV0?=
 =?utf-8?B?NlNrdnFZaThLZ0Z1OEl2SW92TERyOUNBVHFJdVRrT2FhMXRNbTdKbm1hL2E3?=
 =?utf-8?B?WDh3QXhTa2ZoYmJXZWVOTHg2K09SNW9sblAxRmdiajd3eXV5THp1UmR4dVhz?=
 =?utf-8?B?MGVlbnRPbDd0M2Rid283RkxiUHQyTGk0MmM2Y2xKb0F2bzN0akc1QmNnYXdv?=
 =?utf-8?B?WVFxNWsxb0V2ZWYzTHI0VmM3anRURmRCL0lPaU4vYUdJL2M4Y2dxVitVUVox?=
 =?utf-8?B?bDdpOFZ6V0hZdzF4WEgrUXV3M0JMVWN6WUwrSnZRdGJrbEJFSk1Ma1R4SlEz?=
 =?utf-8?B?WFhkWnJndHk2NDlLL3ZrVVh5bCs0RnJnQ0lNaEV6UWlVTmxYM0hLdHExM2Jy?=
 =?utf-8?B?QVlYR2w4QmtCclllMFVHTzJVZXZXSnJNcGZWdzc3SGoramkvRFVxaHV5MENN?=
 =?utf-8?B?UXEzRTRtK09JTUIwYTRybStjZmhQZDNhWFRrL3l5QWtRdGUrMks1RU5kYy9n?=
 =?utf-8?B?ZDR5V1d4OXMxZDdSUnlmS0xBbmZKMHlmTEFsQnhQL3Nzc1I5ZkNSakhqNkFZ?=
 =?utf-8?B?b3ZaT3AvbWxTZXF0STduNnliL21WN2VoOTBYNmNaSHVveHVIS1VlN0ZyV1B4?=
 =?utf-8?B?RktyZjl6dGt1TVlNaFV4a3oyT1ZNU3hnMWluY3M1V0N6VHZJNm0xajk3cXho?=
 =?utf-8?B?dGJuL2tsTEI0VTJ2OERsYWV0RGMwRkhNZm4zcDMvSTdlVjVCNWJDZ2dueUEz?=
 =?utf-8?B?eTVQMWt4YUhvL2lIdzBiYlZDWWNnWnZxMldEL2dMMDl1bnVkNGdURnp6UTRw?=
 =?utf-8?B?anRWUXk1UFJOTGJlOGNGZlpyZWZ6cUgvNUw5d0hWTXQxRTZrS2FUem5wbGFu?=
 =?utf-8?B?ZXVYOC85c0lrQXBSZkVqc0lUVFpLL2pTL1MvRW5mR2pWaUxEZDNDYU9Zcktn?=
 =?utf-8?B?cGdVTFdzdWpUSFd5OGYrRHVrN3JZa09wZUZYbm9LTW51K2MyUFFoQlNZbnJs?=
 =?utf-8?B?UEdMRWxhWFBac3U1dGxoMHduMjdPYzFXcVIvUWJqUkhqUjJycU82ckxtTnkr?=
 =?utf-8?B?QXUvaUE3eThLK3ViSld4RnBnWDY2UFh1blE3ZXVZaDl3djljcmY3ZFFOOWM5?=
 =?utf-8?B?YlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d67956b-61ac-41c8-4f38-08dd5ca4bf38
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 11:48:01.1076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Czkjh7S5haBKxNONG8ACufW6ZkyycnuQRVgsLRA6XfTZhOOJQ5SQkdrN4WN+keAmUzTIzNIePLBAqZNWK881Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5165
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Mar 2025 11:48:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18056

On 06.03.25 12:44, Quirin Gylstorff wrote:
> 
> 
> On 3/6/25 10:35, Gokhan Cetin wrote:
>> These changes split the signing process into two stages.
>> In the first stage, the `sign-secure-image` script called by the
>> efibootguard wic
>> plugin now uses a hook to create a detached signature.
>>
>> This allows downstream layers to provide their own signer scripts in a
>> similar manner
>> for the second stage, without having to overwrite signer script or
>> partition's source parameter.
>>
> 
> This patch does two steps at once:
> - switch to pesign
> - split the signing process
> 
> Please separate this steps into two patchsets. Also you need justify the
> switch to pesign.

We went for sbsign for very strong reasons like its broad usage in
distros and the support for OpenSSL which enables e.g. HSM-backed signing.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


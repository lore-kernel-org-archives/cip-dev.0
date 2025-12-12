Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B3FD59D7C
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 18:04:56 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.165.1765562688827924425
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 10:04:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=D7LdYprm;
 spf=pass (domain: siemens.com, ip: 52.101.72.4, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deJa1o1gfUMhwhc3hiUJ8m1vfIKBXCUgvkHNqOA3+P2rnIv3eBC9/fLAg3eqNYZ2W+q/DvGpEkV6NklLOx7INiji5dhoQhG8W1gXl7kxlvVA2ejnsyiZ0+K59cg059tDBHSAoXR7VnttimYyTyZIJDu24vW2BmpP96dCdxFan+6HZKaPaTRYzkxphUm6G0lxkheZ1w/sBhZN08VOsS3TcTWime6Zohlqd8IcxwMEAahZkEg8AuFhtanfoo8nMZF5N0zOmy19q3CgcuabcMhrERT+KNpQ/9TAExZ4bRvtt3p84POOOpH+YZPd7Wm0Asi37BfEo5G4WZ/hLe0uC3boMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dbn8xrft2dhxozL/AQgoEfIS75MU+0qB0a99Hv3R4i4=;
 b=jmQvdK8qUKawqhIafc7H0WCxja7S7aPc0kG8eP2xQvkDmdYXrTq2C6wr0CCHOSTAOMdNnFZUMKs9cKk8U8Z4wOMdMPICKJZHLhgydARKw/EqWKzu9DNpUduZsNQCPSSOGbzgDdZ84ptkUePrpka2M4tRi63qobqtGc1IL0f5lwQkha3MxtPnYOvPdDAdCIXLRvuKXPkkO9YR3i+LV1JIUcvtf8sp9IYKDUyCSkSEEK0gecsfr7npvoOkI73CUuxKcG/xOff1yv3hIOVh7XLej53yE1Rs9GK8mB2cUBDJKoPSbigcpZxhUYu4PN+Kntw7kGjfmDYWU0vISvhDJwA3tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dbn8xrft2dhxozL/AQgoEfIS75MU+0qB0a99Hv3R4i4=;
 b=D7LdYprmrVmkqE8PvSjxZk5BqXHw2oplEEMa6R2RcuVpseULFOna6PG6ViCq1UgpNoWOmse1XdV58Cdsuf+MC+bQ2lkmoIHdui9EndFCYT3RtY0+K6qnQFK+lF/mQ3QXewXiOEOZj4ncdnMWjgX05IcrRvOfkHkyLndWamhHT3SxH4qIKQjEXUGLDDKViOFmq+T9S8my58Rq7R6QkoupcmdMFYDWSHhajs8Xr+KtSlu7Wrb9oXiw77ZjsqTpuun9OP+YRwwlLGlI1GGobCXuJLuh81IIqSKZwbAD7Nh4ovYvn4A4tmjDyQ386InO0vMZbuiJ/u2jgkKImAEHSP5Ftw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5938.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 18:04:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 18:04:43 +0000
Message-ID: <20adfd82-de28-4adc-a89f-c11beaee77e8@siemens.com>
Date: Fri, 12 Dec 2025 19:04:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core v1 2/5] tests/templates: Add template
 files required to generate M-COM job defintions
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 dinesh.kumar@toshiba-tsip.com, kazuhiro.hayashi.f74@mail.toshiba
Cc: Chris Paterson <Chris.Paterson2@renesas.com>
References: <20250207150439.392479-1-Sai.Sathujoda@toshiba-tsip.com>
 <20250207150439.392479-3-Sai.Sathujoda@toshiba-tsip.com>
 <0ff460aa-35ad-46f4-b7f6-f643a89d7b78@siemens.com>
 <TY3PR01MB11075341DA1CE1C0E9A379919C7A0A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <b7adc39a-67b5-4189-a36d-cade887a6a02@siemens.com>
 <d78430a4-2d63-46aa-bf67-9f342a9bc068@siemens.com>
 <53becdef-fee2-455d-ad2a-d969d746db34@siemens.com>
 <a0fab0ee-5f94-4ff0-8628-03a04c6b5f5b@siemens.com>
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
In-Reply-To: <a0fab0ee-5f94-4ff0-8628-03a04c6b5f5b@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0320.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: 230b32ca-d74e-43b9-a426-08de39a8ed82
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dVMrRWE3SVNzM1pxWGF4UmJLWDNnMTFxUmMyMFhyVUdYN0ptYWV2ME1BQjlL?=
 =?utf-8?B?MU94RFRWTWJCQ0pPMlVDbFphSzRNckFoVVB6TGpvRkl3L0ZzbjArQVllNGUw?=
 =?utf-8?B?QmNUVkR4Zld5UnI3V3p6WE5xYWRGMmtoUktBS1MwUXRXc1NsQTVHK2l1WGE2?=
 =?utf-8?B?OExtSUJ1eGRvQ2pDZzJocG85MkcrZHZrenJ4WjVpS0VNTVUvcWM2cXY1MlFR?=
 =?utf-8?B?LzZGTHpSdDJiN2pFdHVzTTdaQlJKclNUS3pSbFFCY1RQWWUrS3ErOS9xNkVp?=
 =?utf-8?B?L3pLd0NjbWdQSVM5ZnFOa2ozQjlVaGlzL2VVcGRjODg2YU5Sdk83eEJXY0hF?=
 =?utf-8?B?RWpUb2Q1ci9WZjU0ZG9xeXhiei80MXhseDF5aVE4OEtLTFZEN0dtZ0xwYmlm?=
 =?utf-8?B?eU4wcVcrWm9FN0trZlU5cEhKZW41N1BIM2thVHhyRUlKd2RQUjgwQmxJRG5t?=
 =?utf-8?B?YUxETXJCRFZCMTFuTWQrQUQwcGJYeSswRC9ZRXpBWTF3d0kxUE9tUGcrUHlj?=
 =?utf-8?B?UnBqK3JpRmJQM2l3REQ1d3lSVThFV3hsY0tZNDduNG1rUnZaTUFhbGg4c0Ez?=
 =?utf-8?B?R2JFOGFxeGxoc1NBcUVjVDFqdDlyNWRKL2JuSlB6dERwYVMyWGR2cWlXNGUw?=
 =?utf-8?B?cWVYUlJacWw1N1JuNGE5dXBvcVhWTGZCWXFoK2o1c09neVBkelpOOFZTYTVl?=
 =?utf-8?B?WnQxdVJsQVF5Q1AvaHRTQ21XOWxQeFRNbzB2RWFERERWMUFpdnJFM3loTHlW?=
 =?utf-8?B?L0wxT0RHTCtJMTg0cDNXTEZWQkJrRGJBbi8rTUh0TkUrTmw2RVFLSlJZZUN5?=
 =?utf-8?B?YmlySXdTUlIxb3VoUlNpNUhXNS9aSi9DY3V1VHFoek1kN3FOVHp1eEZCdktG?=
 =?utf-8?B?UWl2c3ZZU1BYRk9BL0hXb3IvSGNnbEpNcTFUbEdlQWtJaU1vcHFOTHV0TVFI?=
 =?utf-8?B?SFdCWXhBTXRNRmFCT0gyS09DTkgzV0FnRHVjYVloOEpSQnpBOXp2bGlMalcx?=
 =?utf-8?B?YXc4Z3BUSmEzNi84aTRCNXh5dXAyaGpiUnlTMk0xeGZWcnhhemYvem9WVlN6?=
 =?utf-8?B?clVRMDRPVUt2RnBGR2I0VXBreERnZ1ZIcnFNUW9hQVR2SU9RcFFxNkkyYUd2?=
 =?utf-8?B?S2JSUS83N2JGR0dVbDdlQ2lsakR5alhUc1ZwWU5pMWlqZWFMa21mMXpJNFZS?=
 =?utf-8?B?NUovWCtRSEoxZGQ5RW5STjZub2x0YUtwc2YrdnlsakJYZGVyY3JFbnFyNzNn?=
 =?utf-8?B?aUtlM053OWQ4ZEZ4dkpyemhpa1l1MVNUM2wwdXpFYk1VeFVUQXlCMU9VNkVy?=
 =?utf-8?B?UkpJTitEZXZaQU5rNVp4RHJuVTRNa1F3Vk9iclgrRURGdllwN2tRUExjSTMy?=
 =?utf-8?B?dmtTUHliUnRnQ0p2ZmJwOXZoWkE3SU1Fd0taN1J4ZmpwNUgrK1NoOCtsMlFi?=
 =?utf-8?B?VVpLTlZqQnFXM0dOdzh4ZityVTVqalRudVJ6blNadU13eDBzZzg4VU8vbk5X?=
 =?utf-8?B?QURUMENPbFZUa013WU9HSmV2VW9SNU5mZEh5TXhla1RNeFcyeERJcUJCWHpa?=
 =?utf-8?B?RTNibVhadmY5eXViaHFWajJPeDRtSVM2dGtYc0IwekxIL2hGanlxVThmSHoz?=
 =?utf-8?B?NGpmUElMdjhsazVzZjBIVThiR2ZBSWZMWTFLdURoR2Z3b0pMN05vRFNMZEs4?=
 =?utf-8?B?dHN3b0ZNbmZoa1FQaFNUM1YwdWYra3RIWlo0VHJ4MlVYaEoxMndpclZsY1V4?=
 =?utf-8?B?UlZsUkErZStiN1Vjc3pzTVZvSWZLc3ZlMElWNDBNRE8wTEdXdStwbW9LdVd4?=
 =?utf-8?B?WmlnUTZnR21pZ0NPcjdJWTVNMTdTa09mQjlycmlnWmtPeTlFS01SZzAyT2hM?=
 =?utf-8?B?VlA1NCtHUU5YZzFqVjlXSTBIRDYzKzJEUDFPYVV3OWtkSUE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MFZuOHVFdkQ1WXJ5WmxVZjVlTzlkYWpQOTRORmRKSDRnRmRUNzAxcXQwSFJZ?=
 =?utf-8?B?RHh0M2NYRVd6WmtXY3RWKzFqQ3dkRythbUVQUTZzQy9GWWNEeFFjOTNncjlq?=
 =?utf-8?B?UGNoZmRxNVlIa3RvRHNMNDRFbGNHakVGRXA0VnptL1pQTUxYSHgxYUZVMmJZ?=
 =?utf-8?B?TTVIWElJbW1Nbm1FZlVkeGdrbFZkZXJzVTA3anNEb2g5L1crTTJHczZaQWdL?=
 =?utf-8?B?M1ozV2RjL2Q2VVczcEJFYTUxWXVlWHA0ZzNBZkxjUlpJOTR6bXFLQ1lXenZt?=
 =?utf-8?B?SkNFaXBFK1hSQ2thU2pOUkloMXp3VXRXb1lVNTk5Z3lBUVJ6YzJTZU90SXdl?=
 =?utf-8?B?eC9GNkVheTZFWUhvbUoxRVZNejZiRnp4ZTN0REtEd0tFQWYwRXpkQlVVTld5?=
 =?utf-8?B?MkhHNUlVaFN0YUtlQzhGdnFTclI5YjZweHY2Wm9PTHlETU1DMjhTdXNxMisr?=
 =?utf-8?B?ZTBUemxsU1BndnM3TXRtNndVV2lBK1RjN1pwc1RpYk5odEV0S3R4MFp4VXE1?=
 =?utf-8?B?R25UcWRZVlRDZWIyTDd0bVBhSEJGYXM4TDRMM3FkVzhrQzdNeVV2bk8vbmNQ?=
 =?utf-8?B?eVJUaGQ3MWU1c2RuTHB5eVdycVBkdjFaSDhpcGNNS3ZBSFpUYTNsUEVQdlZp?=
 =?utf-8?B?dXdZWVo3NmFPSnJaUks0VTRwNnNUVFdzNkF5NVpEc0xudTd5QzVBZGdHczhp?=
 =?utf-8?B?OCtHT0NGekFPbU8vaVNCVHJuZEtZT2dVNVZ2cmUycWc4VURzaEtReU82WnFk?=
 =?utf-8?B?K0d6L1AvcUwvZmNJd0xBaTFVSDhIc1FWM3NVcXgwUzNsZXovdm1ZL0IxTi81?=
 =?utf-8?B?Smg0ZGlrenVEOWdBUFl3MU9wNHBoVFlzQ0VkTHI0Vnl1UEhoaUhQNVNxVmk4?=
 =?utf-8?B?S0NuSzZjQUkxWTZjUTJNeWxNZ21RSXJ6aGwrU3l2V3BBUGE3ZkEzUTFuWlhW?=
 =?utf-8?B?R0prNm94dzVDVFFTQmFBMkpWTC96ZlZaVzQ3N01VVytZWnVSNzNmM2RsREtt?=
 =?utf-8?B?WW52eGI4bzUxS3VzeEVwV0w5MjZYUGNDbFByaWxmeGRDMWJUb0ViUThicndl?=
 =?utf-8?B?eFdjWUNvRndsNFZmeDZlaXFHSXZNV1RZUzdDWVhqWGhxUEJLMFJBVkwvNjMr?=
 =?utf-8?B?SmNLVHorb2lwcXhjbzRseUxOMnJBUEhtOHhFTElmVVk2Nzc1ZDB1ZzgxOGRQ?=
 =?utf-8?B?aHlDdXJqNzRjM3JLK1pvUXFNNWhtVys0dnNaMGpUam1haGRtd0YvSy9SdytX?=
 =?utf-8?B?dDdldTFuVDJrZEkzaGozZDJJVk8zN2VyNGt3NWhRS0tVUkFIWCtEZVJTdVpI?=
 =?utf-8?B?MXBKSjBHZjNLcnhlL3FaQnJUS2U3emMxdFBEdkRHdlZ4MWVxQm9oWDlmbFox?=
 =?utf-8?B?ekNaTzg3bm0rME9sU0cxOENxRmU3REh4NlBqdjNaMWF4K09yWVdNb2xmQk5H?=
 =?utf-8?B?Y3pEd0UzYWErenFLQnFMSit2b1JyM1RkN3JabHhUV2FXeXErQlF3YzVxalg3?=
 =?utf-8?B?MlZ5QThoc2VvRXVaNFFGVXE5ZlE0ajZCaXlDdENhV0toemFzOW5Gank5cTdr?=
 =?utf-8?B?dDkxOTZKZEJGditqaE9ZdHJKN3VOUkZzWUR5RWRBWVBMM1JoWEV2a05HOHRQ?=
 =?utf-8?B?cmhMelRYWGNpT2JLU0xKbWFPdDNOQ2dyL0w3Q0VCRFJCVXNiYWVQc3c1Q1Nk?=
 =?utf-8?B?eDFETFVaSzdRb0J6S2htbjA2aElhZERDclZqZUk4RC9XdzAyb25rQlRINDJm?=
 =?utf-8?B?elJZcTdwNTlxOEtUTzhOVmJmb0gzeXp3WjB4SDlEd0Q1YTlTNFFMZFBTc3BK?=
 =?utf-8?B?R0VKaVJ3VEltOG9xU3VGZDZjUURPTGI2VEwramdacFJyQnhvSkUxNUtvcXQr?=
 =?utf-8?B?UTV0V01DOXlvR2JKcFpIVlJFSWYyWThNeHZjOThib2ZtZW5GWVhEYlB0TlRW?=
 =?utf-8?B?U2p3bjVLRHNmOTVtbDJiaFdPYk1MVlU0R1JEdWVoYW1qNjJLWVcyRzZiYW1h?=
 =?utf-8?B?NmtCYXI3MmhxY0RLMnVCQWV3QmVJT0x3djIwUzNLeHNVQ1Z2UTh6eHRuNU15?=
 =?utf-8?B?U21HMVJna1ZBbndBM01TV0tlNFRmenpLQUhQZEdmSXEvNUNGSm4rWUdvdVVm?=
 =?utf-8?Q?tuadZnBSwMAuzhNUDzeFISgEz?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230b32ca-d74e-43b9-a426-08de39a8ed82
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 18:04:43.7637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrAx36mEQ+WwZ9NS4riwJ7mrFDquu/g7Iny+yFbJZdCdeQD8O+YU8LcbHptCQisZiKwJ2q/wTet7roCfh84jdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5938
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 18:04:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20988

On 10.12.25 14:36, Quirin Gylstorff wrote:
> 
> 
> On 12/10/25 13:46, Jan Kiszka wrote:
>> On 10.12.25 13:36, Quirin Gylstorff wrote:
>>>
>>>
>>> On 12/10/25 13:30, Jan Kiszka wrote:
>>>> On 10.12.25 11:25, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>>>>> Hi Quirin,
>>>>>
>>>>> if I remember correctly, the same license information was being used
>>>>> in the m-com health check jobs and even now also it is used[1].
>>>>> The m-com job template is derived from health check job definition,
>>>>> so the license information is inherited here.
>>>
>>> The health checks are mostly copied from lava it self and contain the
>>> AGPL information [qemu],[ipc227e].
>>>
>>> [qemu]: https://lava.ciplatform.org/scheduler/job/1345735/definition
>>
>> Copyright Renesas - maybe we can get this dual-licensed under MIT as
>> well? Then we could select MIT-only for isar-cip-core. Chris?
>>
>> Or was that template derived from yet another template in KernelCI
>> itself?
> As far as I see it:
> the template was derived from LAVA during the time LAVA was under AGPL
> (2019 - 2023).
> 

Link? I still cannot follow the path things might have been derived
from. Also, lot of the content of this file is now CIP-specific or is
just following the yaml structure of KernelCI.

Are there maybe files now in LAVA that look similar and are under a
different license now?

Otherwise, I'm inclined to drop this file from isar-cip-core, and we
will have to look into how or where to recreate the M-COM testing.

Unlike what the file incorrectly states, Siemens does not hold its
copyright, and we need help specifically from Toshiba, even more as Sai
is no longer working in CIP and could answer what he did.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


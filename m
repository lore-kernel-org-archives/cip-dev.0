Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C9CC021A1
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 13:09:30 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.28])
 by mx.groups.io with SMTP id smtpd.web10.11762.1739279361658666341
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Feb 2025 05:09:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Trl5aRnw;
 spf=pass (domain: siemens.com, ip: 52.101.65.28, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLRlv2IJrmwFsgGzI9EUy/t3H1XRZUGUSiu+KLoMk2I0LUJYjEwtdfWscTNWQZvC6cjyb71tGtxpI+jf07BJDJEde29bmyvF2eA5yKqvxRzaF0btvyQB3hOpwrfzx2omRvJIJnXrfMcL73XAYXFBwrtDgr6iTMclKMiNZMr123/9BnQmClgR7+zcKIJk4OBUJ5fxXSR9jscssQ2+rNVCBxdYYnuGD4O7f2qLNykR79hgu42c/Dy6fA8P5sNZwc/ft0WmlenjHnYb39NvapJbOBlCvUZCU6hJJuZF7WnZ3oijhn8cQ2OwJYigEZEuW9mvO8416+0txVdS7+Xt9P6BjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j08j1wSk2Vz/J+KDUVFtihHalle0KABkuIFKsbWksxU=;
 b=tGnUknDc5RSOXsgBFqBHDW7L3oAVc0aXvdxjUyM/mTZ49nFAKk3ke63Bv9FzhCkZMLhhI4PjjhBJ0lf0h+nkTwFpEYBbmAeC2+v0Uv3JjBI8h6quhb8Gzrmzoo7okIrDojhdh3jDDPLE7kup5COAtLxDGiptncXnG64rfhzkp4VAxXM1ovjkO60t3Euk1Wh9hjmvjpaOT9zuKxoSEl1C2zkcqlxhiKxAaKtmekz5sCWCjgMjNnF6PgNMKP8H57T+00bMicGyyUP6Gv/17kFaTItG0n7wh/CpRoUUbavyX3fP0KUbKSl9shogBT7NocZ0QY8SNyANwdeuUq0VEaKNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j08j1wSk2Vz/J+KDUVFtihHalle0KABkuIFKsbWksxU=;
 b=Trl5aRnwz2oKrxiLBAsCiH9RbUj5MUk35YEyp0KqUjVuFYyIsJq69ARTQiojsLOJFC2qy0CCEWkyMo4dhEUIecdUaocuf1IWDi5X0fHYCA9FUrLSyYaNI3Mr2UdUx//GjysrVZUSNAFTilhvdRqCTfhoM52xjhnA7vErpMJVdx6xkxFwDga2MTgJW86mQG3XjyDb9QD4Jyf/RP09W5inNgWQwT2L9Mo9MLxCmHp407+Tks/9HISIH6e8O9fUHQbc+rUMIcydy/a+Yk8ih1FmIJ3vl8mcSZXKMnRdZnKVvS25y33+85UDHcJ/3vKc5z2+Tmg78vjiAoMEgWnclnTfhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7258.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.10; Tue, 11 Feb
 2025 13:09:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 13:09:18 +0000
Message-ID: <a577514c-785a-4a25-9b7c-46e7f072dcfd@siemens.com>
Date: Tue, 11 Feb 2025 14:09:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 4/4] Move content of home to
 IMMUTABLE_DATA_DIR
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 ludwig.nussel@siemens.com
References: <20250211085125.22154-1-Quirin.Gylstorff@siemens.com>
 <20250211085125.22154-5-Quirin.Gylstorff@siemens.com>
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
In-Reply-To: <20250211085125.22154-5-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0228.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ec4ce7-4e9c-4bcf-de6c-08dd4a9d4ae6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q3c2ampqcS9ZMDcvaEVQcWxHdUJjVmpNTTJVSDN5OW5FLzd1RHJ2YUhBQVBX?=
 =?utf-8?B?eUFUbituMmtzdE5pMFhYQnVTNVhtYWQ1aTRvbHVKdkV4WVhnUld2R3VZU09Q?=
 =?utf-8?B?aUphVUVyWFpFMW1uUmMwQlVXSDhWZkdYN01sZEptS09jLzZOd1lEQkxqUDN6?=
 =?utf-8?B?TTBqaHJGVjEyUTVLTnBzb21CTTVMK00rRmhseUFUek5xUzdZdVdjVzEzcWlL?=
 =?utf-8?B?eHV0MVpwc1A0TFhXNGtMTDlLSUtuaTJrclFreWxCTDVhQ2I5OHYyaGtvQWlR?=
 =?utf-8?B?bmJKRml3V1lQSTBNSVI0bFV2TE55UnZWc3lLeXg5YlR2dVJMNXpuY3U2R1pV?=
 =?utf-8?B?Und0TzNEQlNDNC8zSmtVVXNaWnJrUGhJeXdCK3F2WldUczluQ3kyZnFmNUdu?=
 =?utf-8?B?eHVmMjczdGdVN1paNW1nMHQ4dXNPd01yME1oRjFBeU0vU1FhN0xKQXN5aUpB?=
 =?utf-8?B?THM3OUphaUVJY3hBZ0xPTHJ5RlZCRUlRQmpLQ0h4dlNPTWpxeWhNSWpXc0p5?=
 =?utf-8?B?SGZlUjNUbWJxY21CdklQUFRvOG96bTl1cldjbjAzNVFyOUtuaVNOWDFyK3VK?=
 =?utf-8?B?VFkyQlFjTTMzaXlkYTJMQ2JwZHVBWWRnSG9Rc1VtOENwaUdrRFZFbHpVM2Fh?=
 =?utf-8?B?b1hrR3dlU2dGV21IQkgvL0poSWt4LzF3cjIyWkRMVlIzU2JQRDFPc0ZjZTgz?=
 =?utf-8?B?VjBPeG12bmJ0THZvakVWRWxqcEdWSUl5dGY3Rm5RWi9kcnEzNXcrRnQ2Vnp1?=
 =?utf-8?B?Z2Vha2JyQStkdmRmUzNCQzRCckN5OGZ3Y3V1eHlBZ1Iyai9KdmNVMFBjL1VT?=
 =?utf-8?B?YXAwV1BPV1hsdzhJY2V1eTl3MWtrRHRyM29iY2F4V3lydGN1elJGNEpIWC9Z?=
 =?utf-8?B?RDgrQUNVdzlYQmdYUnQyZ291dktDODFlSkljQVJVcmN3ekpzWE10L1FxRlNk?=
 =?utf-8?B?NkxvSmc4TGh3emNnd3B4bG1vSVVuRWRhekN1ZktpMy9OekQ1QW1vb3BqMEZU?=
 =?utf-8?B?WHN3SklWL3VHSHdpSW5vYVlrMnJoWEFYaUUwTWFMZTBlclVtSFpUS2pYSjJ1?=
 =?utf-8?B?bHprK1VGRkRSTVVHWGhrMC92QXdHMStFQWtJaWd2alcyRmFEanZXWDVOQXpJ?=
 =?utf-8?B?aFBjd3JhdG92blVqaFpFd0JpWDg2ZGlnSFphVnBqakozTFZNd0Z3OE5IWGNF?=
 =?utf-8?B?QWJlTFlPcU5SRjdDU29sc2huYVpHNW52MWV1RkVaRDJuY3dJY0tlSHMvbCto?=
 =?utf-8?B?Y2xwejV6T21ocVZWd0l2WW4xaWV5M01tM3N3V2JZU0dldzM3QWtRZXhNZEY3?=
 =?utf-8?B?SGRtUjNGNm1MbmtMcmpuMTJMWE93VUprbldCVC8xQW9hSG5hQXI0ZDg0ZGx5?=
 =?utf-8?B?Yk1ua2JUMDU0Y002eERCV2x1cVRVTENQZ2ovcUl2SnVQa1cyMUROaFRuZ0E0?=
 =?utf-8?B?d0cwMWtPVTVYYVJGcWZrOEtGQjQ2U1J4MS9FQ2Iyc0RxN3NWR0tRbjVNWWYx?=
 =?utf-8?B?VHJSaEg3SGFiVjdCeitKQnhnbGJGNTduMU9qNzNpTEc5dk5JeVhYL1ByTnZ4?=
 =?utf-8?B?NWFob1ZUYkJHbFJaWXI4enkrN0ZYZ2Ezc0lHa2c2TVJEVStxSzIzaGRIZ1NF?=
 =?utf-8?B?LzdRRzR2cjMvQVE5MVBMdlRRYXMrMHlPeGphdlpFY2Zna3VBKzVrekE2bE5h?=
 =?utf-8?B?ai9ra1RVQWNSTUVOM1BRVjF5U0t6YUx6YnNKbmUxcEhDK0pTczNLL2ozbWg2?=
 =?utf-8?B?dHRXSDR6NzdVZVNIK05IMFdtWWhLQWcwN3pWME44OVFBOW9mS01OYWZPLzlC?=
 =?utf-8?B?S1ZhNmcxYUN2dllmWEFuamsyQnI0L2pMS2kwMTZlM1E2N1ZBbEhZWXZBQUZS?=
 =?utf-8?Q?inbgs8DCPaqCV?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VjlESGFyamhGWTFGRFh0Mmw0MkZkaEp3RjJKRjZ3NTBrNkZOSTU3MThYS3Y0?=
 =?utf-8?B?UVBlUk5YN1JZYVJwZWhmNTF3SEU0STFzQlVMVzl2WklWaGs2WmI3UU1QWmZn?=
 =?utf-8?B?LzVYNFM2TVQ0WHgxQ2I4TVcvNkRoemRiMWtRWmNqektIdzczVXNlcEl2Rmtv?=
 =?utf-8?B?dUt0clpUYnZ6Q01Hc2JyR0lzemZVa1FTVVJiS2RwVUxsN1l6TUptSVZDdU5w?=
 =?utf-8?B?c3R2QUxoelZSR0VXTkNqbkVtZVFrcUxaRlBGblRLOEdHeFVqVUxnaDhpWU9q?=
 =?utf-8?B?VmZxcFRJaTVrZzNxcVdQZjJyU3h3dGhReTVUNHU0WGJCRTV2UlQwMVBkekIy?=
 =?utf-8?B?b1AyMklMZlY4a2FxYjVRVVhGU1hMallHaVdQaHlaT05wQW5BVXEwT0VLcG5S?=
 =?utf-8?B?SXpLK0RTU1pBZVVzcThkMGMvcnpyZE5nKytmaGUxOENRT3pBY1pONFZEZ2N5?=
 =?utf-8?B?b3drQUVLTlFZd0FGeHhndzhkbUM2M2Iwa01pTmtTU2VyY29OWmI4S1BSZE1R?=
 =?utf-8?B?b0xBbjBvb2J1VDIxZHIvZlZrQnhOcXBtcm5SMXpPZXhkVjhDSUE1dG81MWMw?=
 =?utf-8?B?N2liQXJxT3dMeUJtbXovRmV1WUQ5MHFBajQ2aVlpSlJvdmFneE9XWjVwOW9q?=
 =?utf-8?B?S2tON05wSFJjV2VLbCtYVW9pcWFsdW4yVW9Xa1pYa3lrSXlsZWc1TThCUlhp?=
 =?utf-8?B?OVhhZFJseXQzL3JQSmpnOFZMK3ZHeEJpbnpCc0tZSktxR2h6ZmduTERqU3dp?=
 =?utf-8?B?ck5aY3VtSWExdEJESVU1RVo0UmxlRTNHd3NEUVY0TDhTMER3NGEyWFVjelIz?=
 =?utf-8?B?MUh6RlQvSFo0Z3J5b1NwbER3UjVUNzBCbnpKREVpZVNKNmtrMUpjdUoybXl2?=
 =?utf-8?B?VHN4ei9SSVNxU0pIYjZ5RXFFOGprYmpML2RsYmFJdmM3NzFGVnlvanhMZ2tV?=
 =?utf-8?B?a05vbVdrblRPTm9QMWpSWHdHWFd3OFoxTkZ2SDh6eWFBdVpuQkMrdW9QOXp1?=
 =?utf-8?B?MGtra0xYQi9mMXdWYjBjM0JLMHdSanlpdld1KytsK0NpNWNEWEJ0ZXU5MjB4?=
 =?utf-8?B?S2JnclR1QmFDMDFudGRXVmh4UWN6UlVSWjlVd1oxUXRGYmFzNmRUMEpMMGV2?=
 =?utf-8?B?R2QreThvVkhXNlRJNHVjLzQxWnJBV2JEcTRObzI2Q2I0RVFzcGgyWmFLbnVR?=
 =?utf-8?B?MkJkN0UwejlYZ1BCK1JDVndwTFF3dytYN09QM3RyYVFZelVPTDVPSEJJem1n?=
 =?utf-8?B?TStmSHZDMDg1UjB3MzBOZWtyV0ZPWmVJODJLOEdZNjA1SFZhK2t5K1NjUlJm?=
 =?utf-8?B?clRwakVrZDluYkFyQkxKVnNtaDBBZ2tzaEo4dFFMd1Z6Y0RITmRXRnNRZkxP?=
 =?utf-8?B?NFZDWHl0bG1US3UvUVF4RW12b1F5VkNuZnF3cXpFa0Q0cFFlTDlOZmhyN3NQ?=
 =?utf-8?B?c2F1VHlCcUMvYVBRcFpGcXpPZ3ozZnl3a1Rya3FJa0FISHc4eFcxbUwvTThm?=
 =?utf-8?B?cUNJNkpvVEtWRDRDRThTQUhxbTlDZ3UyN2hoVWNkOW4yZThWY2premVlNHRS?=
 =?utf-8?B?R2o3ekVLVy9XS2JOYlpWOXZTZVZCNVRsWWhUdjIzamRveCtIMnVyQ0Q2STdL?=
 =?utf-8?B?aHJ1UW5GVjdvb1lZa29SRnJyeU5pUnJ6RUp5UFZ4OWRkQ2dCR00wOUtqazdt?=
 =?utf-8?B?c0l4Q29hcnBpclpEV0QwbDc4dDh5Z1RxUUEzMmkyUWxENmxhU05YLzcwcjRG?=
 =?utf-8?B?UHY3UXVzdjBsMUd6RlVXeHZsRGV0T0hmaGVmcWNJdWp1bU1wbFVKajNVUTFz?=
 =?utf-8?B?Mkc1d3hSYm1mVkpEOTVtZzEzQnVtYjB2dWJaK0ZTN2tocUViYjE0QUZNdVJ4?=
 =?utf-8?B?TUdxMjdidU9GYlZFYVJSY0JoMFZpUWZpK1pKdlVkVHdUODd4cmF1M2lhbUIv?=
 =?utf-8?B?TFRHaUpMREJQK1hIWUlnSDBvRExoMUVPRGZmcTRNRnRvL3IxRy9NaWNHdHZk?=
 =?utf-8?B?K2hOR2xpOFJLRjZzS2VmVnNnR3lPaTFPNk5UM0xlTzMxU1RGUzhucmZIdXNN?=
 =?utf-8?B?QVV6R25iK1FrSnpIMFo2SzBETmdlem4yczBiZjVwOTVOM0VsaXFnWFBLTzc4?=
 =?utf-8?B?UnNPZXZ2WldMamVVeXN5T0tMR2VBS3BMT0dZdUdWRHo3ZU9kc2pFVHpEajB3?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ec4ce7-4e9c-4bcf-de6c-08dd4a9d4ae6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 13:09:18.5133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHZbu6FtPWebFr5/V1/rA1ZHyVXRDPO+USr+hdFgVPVeKVa/Gl2BrpCkW56dcz3sxoCHfLBrLiWKVRutAz2+Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7258
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Feb 2025 13:09:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17811

On 11.02.25 09:49, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This reduces the amount of necessary partitions. It also
> allows to use a A/B-update scheme for the var partition.
> 
> This fixes issue #123.
> 
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/123
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/read-only-rootfs.bbclass | 11 +++++++++++
>  kas/opt/home-to-var.yml          | 21 +++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>  create mode 100644 kas/opt/home-to-var.yml
> 
> diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
> index 99a2909..c809187 100644
> --- a/classes/read-only-rootfs.bbclass
> +++ b/classes/read-only-rootfs.bbclass
> @@ -17,6 +17,10 @@ do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
>  IMAGE_INSTALL += "home-fs"
>  HOME_PARTITION_CMD = "part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002"
>  
> +HOME_PARTITION_CMD:home-to-var = ""
> +IMAGE_INSTALL:remove:home-to-var = " home-fs"
> +IMAGE_INSTALL:append:home-to-var = " move-homedir-var"
> +
>  IMAGE_INSTALL:append:buster   = " tmp-fs"
>  IMAGE_INSTALL:append:bullseye = " tmp-fs"
>  IMAGE_INSTALL:append:bookworm = " tmp-fs"
> @@ -37,6 +41,13 @@ copy_dpkg_state() {
>      sudo cp -a ${ROOTFSDIR}/var/lib/dpkg "$IMMUTABLE_VAR_LIB/"
>  }
>  
> +ROOTFS_POSTPROCESS_COMMAND:append:home-to-var =" copy_home_to_immutable_data"
> +copy_home_to_immutable_data() {
> +    IMMUTABLE_HOME_DIR="${ROOTFSDIR}/${IMMUTABLE_DATA_DIR}/"
> +    sudo mkdir -p "$IMMUTABLE_HOME_DIR"
> +    sudo cp -a ${ROOTFSDIR}/var/home "$IMMUTABLE_HOME_DIR/"
> +}
> +
>  RO_ROOTFS_EXCLUDE_DIRS ??= ""
>  EROFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
>  SQUASHFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
> diff --git a/kas/opt/home-to-var.yml b/kas/opt/home-to-var.yml
> new file mode 100644
> index 0000000..c40b4cd
> --- /dev/null
> +++ b/kas/opt/home-to-var.yml
> @@ -0,0 +1,21 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +# This kas file adds swupdate and generates a ${IMAGE_NAME}.swu
> +# from the first wic partition
> +
> +header:
> +  version: 14
> +
> +local_conf_header:
> +  move-home-to-var: |
> +    OVERRIDES .= ":home-to-var"
> +  remove-home-from-crypt: |
> +    CRYPT_PARTITIONS:remove:home-to-var = "home:/home:reencrypt"

Once all the details are sorted out, I rather think we want to make this
pattern opt-out, at least when building new images with isar-cip-core.
Existing users should be able to keep the previous variant, but new ones
should get it automatically. That would also avoid having to provide a
kconfig menu entry (which you forgot).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


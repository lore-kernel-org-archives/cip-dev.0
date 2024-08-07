Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D4DC3DA7F
	for <webhook@archiver.kernel.org>; Wed,  7 Aug 2024 14:37:39 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.47])
 by mx.groups.io with SMTP id smtpd.web10.35131.1723041457359854868
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Aug 2024 07:37:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=r4pyyq2f;
 spf=pass (domain: siemens.com, ip: 40.107.103.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkjBAJqs0yUCTLCIwjg4+42FZSSm2DW0Gog8MEEg5x105Y+qhgYDBPjciR10KINK+O1lGAZsXLTotwbt4fgFaUg2LJ7w80PuEh5H4jnwb7+gUc+DKyDwr2G1a8i500YDC6xKjCwd7h7CIFKxkff+zmzNl82cwGyAt/5harfrg/O+ipGyFYhP9V6zJ30deQ6VQ5kc9W9d1mcVHIZsoOB5pZB/dqIvRiOUD3vU3mo3xVBZF57lbtG73X+nms3c8znJYhEppwiGp9okhCj7JaXutZinVfqX2I/qjhQegSd+lBe6N98FlZm7+uF6vEek/MU9RhDpkmXgRRSRUG5sDOSimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYJJ9U5QHmCoTcG+GplpWrQCWuYMeamw5ErCn95NN5w=;
 b=A87/pbTioGnE5oAk8hR/v72dQCeGWF4yxfr30y0N28BbeDsRvDEl+gZOXE/y7m0dKidVRlICizcZwCIVroAgpzgpyl0TZEjae7EjouMQIiD6RbIFMNJFTv/QFpPcavBBGl/ys1k65a+rRa5XrCO1hScz3qVsucckoZf9RSkobSufUpnpJn4tNadB7yum5GTvFRvO0P9rfVTyBKe2weqEf0PPDfaaKIfcNwOz7OEf0H3EQskdcpTGgBCw/97JqlgzshbWMxk+UfTEBwV7pdq+P87mI10hSrbLcEXSUjirphPQ+XxsQPXR/xTYrUVE2n0LELw+VjPH1osdLGZzsOT3+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYJJ9U5QHmCoTcG+GplpWrQCWuYMeamw5ErCn95NN5w=;
 b=r4pyyq2fY+oO0Fwfnbxpa98x1jJ1Mit1BJqsX9vxGP2ibphnsJ4QUFvun5gbJ+DU9zmjXUEjPrEdsPOz+DRmNTieQOSQUSEg0MlPwB11Z/y9cO4w7+AplL43DiqFR5KdN7lQ8kSf0Q+5TkqRuXT4OmnxESKvSd77icjKScrxIvnHjMKWN6QbPz9XdlCUCHwuK1iHeBa1L/ozxMQltIVUFZj92daqYgvRSawsiiZUT12ZRHxpDEDtnSV+2kPlL9xtiLtWyxvD9uAQeRIBJMirGInLlTnK5uK/D4k4pvvYnLRMP4AyAKgfzlFSGg32WiB7kg2KKSGep7kFuKgjEcM1JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8779.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:561::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 14:37:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 14:37:33 +0000
Message-ID: <18712f67-bd10-48bd-8d4c-be41661c3397@siemens.com>
Date: Wed, 7 Aug 2024 16:37:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] fix(PREEMPT_RT): disable
 CONFIG_RT_GROUP_SCHED
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Gylstorff, Quirin (T CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <20240805091722.6871-1-felix.moessbauer@siemens.com>
 <b3a26322-57b0-4ea5-86bd-2da1c772cedd@siemens.com>
 <507f6d620142517158eefe35c269c39786d65dcf.camel@siemens.com>
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
In-Reply-To: <507f6d620142517158eefe35c269c39786d65dcf.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: c4582dfa-0bca-463c-fb0a-08dcb6ee7969
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eDZwWEJmQ2R1UzY0TVhYeEdPSjlCQVRWekZQcHRTVG0rMWZZakI4bFg2MnVD?=
 =?utf-8?B?a0dIMk12bVZnTjNBWGZSNytDR1ZDTjVmQjZZdEp2Mmt6SGZ0SmpMMkV4SjFw?=
 =?utf-8?B?QTdvTndKV3pod282a0NBdFoxdEoyL3hHWHVvWHl6aTlreVRCWHk2S1JlTXIz?=
 =?utf-8?B?Tk14Ukt5WVNSNTlhSDdwVy8reTBKUEZTK0JHWXNNZDlSTmhZMlFXaUlQV0ww?=
 =?utf-8?B?QzdZUk5sNWJqb0MvckFDcWRXYkxDVzEvNU1RcVRNRzBGN2I3R1BHdUZEWG5u?=
 =?utf-8?B?SU1jcVJ2bklPZEtpYUc0MWFwMkpPMVhYVzczUlUwc0FDRUs3N3JZbE5GMnhM?=
 =?utf-8?B?NithcEZyYVhaMUJTK2t0MlJCeWUycTY4RE5OUGZtNzZubmFCcytEMEZlOGVt?=
 =?utf-8?B?WTJhT0hMRXZQT0kxL1VHY3JWR0kvbDM1NkR1aThMVnJsVFRKTm9TbmZFMEd3?=
 =?utf-8?B?QmtQSGhFMGpDQ21Takw1alU3TjdsQlJlZjl5cjlVMzM0czB3UCtFNGEvZWoy?=
 =?utf-8?B?Q2VqSWN6YURpZmswVG04VkFzOFI1MWtzRkZjSWxweWJnbU5ocVJEZDVaYlZW?=
 =?utf-8?B?Qk12NVZzNW5TS255NCsyclg1alB1RnI4VytkWDVSRjVHUE11Nm1kY0VZMnA5?=
 =?utf-8?B?U1VmSTNxRmsrL29hUVdhWjZqUkdKWThTbWZZVGV5VE1YUGJqQ0dTa3JFOFZU?=
 =?utf-8?B?MTk1Z2xtK0JaZlFwTysvUXc0K05HK3BKeTFlRlovRWFmUVVQak82bzNDS2da?=
 =?utf-8?B?T1NJZWplMXlrOUdaM25lVGFCZGVRV1I5VDVrYkdlR3VNeW9rYVE1eFhWcVVw?=
 =?utf-8?B?dnJzcFdxOUxEaXhxOXFGVTRpSEdXcDZCeFlTVTNiRW1TR2RYSlFyRzZUcGUv?=
 =?utf-8?B?ZUdITy81NDcxVE9NaC9EK2FBSDZ5d3YweGJOYm5COG5oUjFDdDJ2ZWNGb0wx?=
 =?utf-8?B?dzRRWm1MQWx2bTA3d3NDTms3R202bExGYUZlaFBWOGxYbWNobkFOZGFHUzVn?=
 =?utf-8?B?SGo1SUxPMEtJQ1BieCsvaTk0aFpDRUZYcmhrUWtFc2VockhCTEFKVkp2Y0JS?=
 =?utf-8?B?cnRMNG8zNnpDYzJZanlpNFFmbXMvSDNzUmxYbVZydGMya1lQMm94SmVsbjZS?=
 =?utf-8?B?a0MvZk9JNENjWitNVnFhZ1gzd3BlZDRHMnR4bm5XSThiRXV3empQRys0Mmgr?=
 =?utf-8?B?TDJKb1NKMGtJbXljbDJmNnFXdGk2Tk1VM1BTVWtVTGJWQXJ2cFhVb3Mwd0hQ?=
 =?utf-8?B?c1BwLzZsamp0Zi9qaHB6a2R2RU50MXE1Ujdqa1VCdzd6alF2MnZRNExSUDBV?=
 =?utf-8?B?U0p2Z3ZyTnc3TTliZUtmOGxhb1IvVmRiYUppUVpiSkJ3b0paZWQ3QitrSFJW?=
 =?utf-8?B?WGsrb0IyZDZMTlR1ckhLbXBFZjJ3SVE1YVpBUHc2MzNkZE5la2IrMEFCR2pn?=
 =?utf-8?B?L1FzcHpRNGVUVUF4UDVtSkZjaTJwdGQxRHZOQWxzdXBCa2Y5V1BtekhWZzIr?=
 =?utf-8?B?ZHZkUW90NHlubFFSa3VpdzI3eEdQRklCWGV2YVN4QTBMdHlWRTV3QTJZc2JH?=
 =?utf-8?B?S3FuN1hkL292ZU1CV2NrRXRkbjhlMUtFOFBGNVhYaGNGYVM3c0piS3FRd21x?=
 =?utf-8?B?LzA4WVV2cHVjeTZ3c2ZvcGFMdFdsQ09mdjdrYUpmTE5TWEp2ZGh2Y2dVamdh?=
 =?utf-8?B?WW9wMXI0M0xMY3pkSXU4eWZBczE1ZjdGdTgxa0VvdlBmd1dONE5GZkNscUd0?=
 =?utf-8?B?aGR1c3RydS9tUDhzcWpObEdUZXRDaHlNUHVLZ2dEb3EyUkl5S3RpL2dvblFw?=
 =?utf-8?B?SWRheGwySkp0YkZHZ2NsZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R3FSV2VVa1ZsRFY0WE9DZWxPVlQ3WU9xT1NXc2hUdklreXc1N1hYeVpJNnFO?=
 =?utf-8?B?ZW0yTHRkOFhobGljVnluR1dtdUl1cGQyV21MQUFuYnRwMkRhd2t3MVVxa3BN?=
 =?utf-8?B?ekNxYlJlcXBNbmdrUFJKdGlWVTJjeFBKVW50YVJSOFhoVEFuNU1xVmdtTmF1?=
 =?utf-8?B?TFVvbDVwSWZlYlIzeU9ZUVRYTmcxTXdJL3JzQ1Z1VGpVTzNMOFYxUEpVckN3?=
 =?utf-8?B?QzdVbEh4NmJ6KzBDalF2YkF5SUJvMUJxSXduRWNQajU5T2FjUldDUGRubzM2?=
 =?utf-8?B?ZDZndDFuTzR0aHJ2dDRxZW9vVnFxbUFGUWlMVFZFd2c1QUZIcDdHVXhXMHI3?=
 =?utf-8?B?M3JnaTdvTCswMlh3TXdMRTFjMUd1dnpwaS9XSm5LWWp4SHptbi93eldHYXlQ?=
 =?utf-8?B?SUNya2kwVDB5MHRHQkFaRTZRWWh6dGE2YTA0WUs0LzVCSFdBTlFJQnlkdVNX?=
 =?utf-8?B?QmRuOC9lZExxbGJzUDJ1c09Zc1ZTdW1qeWRPdEkxVysyY013THFYVGx5Vlla?=
 =?utf-8?B?NzZpSzBsTXN5NmE1VEJQRFJEcVlmU09DSjZPTjN1ZGFnUnNBS3gyWWVzaTNq?=
 =?utf-8?B?UzJSK25NaTBMaTFUbjRNb096K1JQWDJLY2ZHY1RDTmlMZkR0TEt6d0txSVND?=
 =?utf-8?B?TE0raUtQS0RSbE8rR3pmMmNVR2RWOTU3bEExckZwZDFTK3kvRk42aUg1bDFX?=
 =?utf-8?B?Q3YwUVpLWHBEeFNSQTBpcW5DY01VUEdscjQ1MGJreEkxMFZBZ1lUb28wc3h1?=
 =?utf-8?B?NHY1cklqaldrNVNqMGJXWjBlUDJYTEVFVHR6dG51N0tVSWMxS3YyUi9SK1N4?=
 =?utf-8?B?Q3c3a0l5SDlORCt6YWRVSW52L0VpeXhXTXU0d05OSzhYWXBJbGxUSjBmTjhI?=
 =?utf-8?B?RFQ5eFdteWdJT0tlZFl6VmhsQ1NrZUFBaGpVUWFvci92c29MYk1QZGRKRnc4?=
 =?utf-8?B?SUtXaGwyN3JXOHcrVEVhMVpSMDhkUFdVL05pNHRkZXY4YUdPbC84aDBkRm5Q?=
 =?utf-8?B?ck1qTUpqYmdCOWE3eVptMC9hcVhnbXJHd2I2dVM5ZVpwMGVrRE9hQ203blpr?=
 =?utf-8?B?M3BRM29pUEw5WHJ0c3l6OEpnajlZYUQrOWtDRXJWV2E3RHVtUmlMdFFwT1dB?=
 =?utf-8?B?WW9GR0p5dC85ZHRDWE9qdG5TV05ETU8rekVyeUNpaU0zYW1vdVM4a2E1MHVW?=
 =?utf-8?B?MTZwNzZpNkNmZmJqNXZlNFVNN3NBdmM5czZ0WFFsRVB1MUN0SlpoZ1EvMzh6?=
 =?utf-8?B?V1E4VHZMcDBjVUhBcDBnc1I1WjhTNHBobEFFYzNnZFlJWWt0L2dTNmNOUVBu?=
 =?utf-8?B?ejY5WjdoYlJnSHRhR01sb1lXUHdnVzV6K2p0aVAzTzdRZjhlK2RnTDdRNjhu?=
 =?utf-8?B?OGhSTjBQZ210NVpMdldvbDlaZUpQM29PeDJGK1VscElSblc5Y01HOWJIQnJk?=
 =?utf-8?B?dVRMbjZUTzczaXJpTjhrK0pIVGJ2WVdpQVZTM2dZaE5PdnJUa0NvZllDa1gr?=
 =?utf-8?B?SUJvSkt3UXhEenpWVU9hMG0reGNnbTFLUFJwdnRveUtTcDFlL0drY3YydUN6?=
 =?utf-8?B?YkplV3hIUkxNR2p5RGhkODdyRHRDSUFKbHRtMlc3SGtSd3ZpOFU5dER4czhF?=
 =?utf-8?B?cDJhd3RGRzY4UUJQUXhUS2IyS3VWUFBzQ2l1aG1ySEdtY05yWUUzTVNqWkMz?=
 =?utf-8?B?bTgrcmJhRmlWRWU0RjYxTm5jTzUvUkhKVXN6cllYZUh3Y0FZeUZoZ0NhWHJY?=
 =?utf-8?B?bUxUQU9VZlVaeWZrSkd1b2VvSTZvNEVEcE80bXBQNCsybEVrbEM1Nk44Mis2?=
 =?utf-8?B?RGlySW1vN3dLemtpMVhNTHFMNFE1T0Z0ekJ1YzBQd1ZtaUxyN1h4M2lYa3py?=
 =?utf-8?B?aDJCUmVlSGZWVXZmUm5lRWJneTVSZDcwNXdYcXdxSWk4YTJ1eU42Q1d4SlhS?=
 =?utf-8?B?ckt5bWRuNWh0cjBUUis0Mks2aDdmazNKYW8yLzZEdy9BaVkydzRsdkRnenRB?=
 =?utf-8?B?cUtxU0tGUVRVb0srMFNmOXV6aitRVCt5eEFzamFlWHBnNTJQRndRU3FuVE1o?=
 =?utf-8?B?WEhGNHlCcDdRUklVb3d6djBsR21sTVpIY1dCUGMzSW5leHpCcFo2NEdHRmlL?=
 =?utf-8?B?dDJlMUkrV3pFZVFpVEtjaVY5MlUyM2lhVHJZaDRRZFpyM3dwN2hMR2NDOTEv?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4582dfa-0bca-463c-fb0a-08dcb6ee7969
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:37:33.6648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WoJdRI2a0PgV11DomHf28ceINAuvaQZBMikJvtToWSse6ISc3p0IduIvwyBgetL3hr5k7qLeq4sTxW2kdH0NfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8779
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Aug 2024 14:37:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16759

On 07.08.24 15:57, Moessbauer, Felix (T CED OES-DE) wrote:
> On Mon, 2024-08-05 at 16:24 +0200, Jan Kiszka wrote:
>> On 05.08.24 11:17, Felix Moessbauer wrote:
>>> This feature is simply broken on RT kernels that use cgroup2, as
>>> the
>>> cpu controller features rt_period_us and rt_runtime_us are not
>>> exposed, which are needed to configure things in a way that allows
>>> to
>>> run tasks under RT/DL scheduling policies. It further seems to be
>>> incompatible with the nohz_full option.
>>>
>>> This patch just disables the feature, similar to upstream Debian.
>>>
>>
>> Makes sense. Didn't trigger yet with the standard RT test images
>> built
>> from isar-cip-core directly, but out config should think beyond.
>>
>>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>>> ---
>>> I'm wondering a bit how that was not discovered earlier in our RT
>>> tests.
>>> Maybe Quirin can have a look if the cyclictest also shows errors
>>> that
>>> the scheduling policy cannot be set. But maybe it simply did not
>>> show up
>>> there, as the setup was to simplistic and did not enable the
>>> cgroup2 cpu
>>> controller.
>>
>> The latter is what I assume as well. I tested it with a qemu-x86
>> bookworm 6.1-rt setup, and cyclictest happily worked.
> 
> I just noticed, that the CONFIG_CPU_ISOLATION is unset in the CIP RT
> kernel config. While this makes sense in pure cgroup2 deployments, I'm
> pretty sure many deployments still rely on the isolcpus= kernel
> parameter (which only works with CONFIG_CPU_ISOLATION=y).
> 
> This makes me wonder what exactly we are testing there.
> 

I suppose you are referring to cip-kernel-config, and there
x86/cip_merged_defconfig: We need input in form of project/device
configs in order to cover what people use, to maintain and test features
properly.

Jan

-- 
Siemens AG, Technology
Linux Expert Center



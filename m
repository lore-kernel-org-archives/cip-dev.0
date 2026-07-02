Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE09AC43458
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 10:13:19 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.66116.1782987189330707729
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jul 2026 03:13:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yQkWRAsp;
 spf=pass (domain: siemens.com, ip: 52.101.65.39, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3l1VFjGfTHqfwjdWVtqcRYA4BdGOKbXeI0GuctjcONS3ZjECc0JcNlbc74eYv1ZzR7ZCR6JTdlPrMq8evAdvAeS51nhbkIsOObvS6JrKUtUps+3H7AZVKOULtSq5KBGsux0b6HYylrj1A05MEOVOjNjg3N6iaj2NEIZbOJZebSQzslYytfqG0CVzmMHThAU2bLV+yFCh/hg7xQHpIeKpFEAbXtRCtLtX/JdlhvfpnZtqCPZgv+ayowe5r8mguXDQHMEXWDbynO/T5Hinwm7L4j1ZId9QdNIbwkyRScKI4P5B46+Pfy0vKVTZynUnv5PPDpg5nD58v2r8FAJk1D3jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlt7veNcFCtSJ8g9NAAa48lvcwfzC0vlwMbsXkLV05Y=;
 b=FDaHkJUKnM+jgHUZzztryIxoM4gV2/qdt1moTDayMuCXipUKms8bC90WSeGl3j917Hn7pRXotDXKrqmVSzHuOg8YWSDfKJijy6tJYr65cJV6k5jxf3EKGwSr2K5nURaspd/WZWGMN37xxoo1xmdnzleCsIEy5OGpKSLthI0yREGzPlh13OVovmhHaYNeob3aPMJStnukEqj/0pZ3tlM7tkHuvdJFGKOMf2mwCwuO65sV955hJnQ7Bzs47nB7AGTox5sa2AC8iRXRykZ0uhufd8ZbEbi6ZNg1KkrDxpV8JQ6YgKy7A5eon2imiQoFNIUOftSQCL/rQDea0E7M3M2siw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlt7veNcFCtSJ8g9NAAa48lvcwfzC0vlwMbsXkLV05Y=;
 b=yQkWRAspgXj3/sUlwId6iNK7g37UlzxoLcUP/Zv83/Ty9RquzkWx5cJNEnKVNOWfTh929bcftlTu/Q7dJKwFVbhdgzEjtrWge7k/EM6D44bJPJRGdYgDRdtfJF8pgLmWk1n4E6MC34rkHD8kx0a8QakNGk0u8XwiotSuQ/mQ6RIWNg048uQkmNw/CMZVbKB4iGcao9Wr2VLo0engMXW14D9bCs55njDNmcQQNBKkf5sxITmGBWRUX+y6nfBVi6aLXmyuQy6yEu92fFH0klf0nW4u/YXpUp2O/uen3fMDe4JHGf/YMZ+gIE1OjeU6W+/47wJvHVcB8fpbPzkpm/+r2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7257.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:310::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 10:13:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 10:13:05 +0000
Message-ID: <4cc426f3-79ba-4973-9874-fe5102551e5a@siemens.com>
Date: Thu, 2 Jul 2026 12:13:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: CIP downloads not available
To: Pavel Machek <pavel@nabladev.com>
Cc: Ulrich Hecht <uli@fpond.eu>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <cf44e61a-f46a-43c3-ad2e-10efe82f2bcd@siemens.com>
 <akYut-FQ0Ic8TE5I@duo.ucw.cz>
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
In-Reply-To: <akYut-FQ0Ic8TE5I@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 319b17a8-23d6-42d5-acee-08ded8228182
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|11063799006|56012099006|4143699003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	0mIUr+BmaiSTTZ/gHrIZPcqjS0b01UhAqogj4WypfirnIsyUksUBUGnW7OjH3O3j+qNdNdpSHiQ8OoSTlbRqrJnfeO5QPGC+fgo6VVl7RRlsEm4D2TbIhT3e9CxSL1Lk6s49c1ppO2ZcJN0wxifdZVijONKiIK8gYlRy4QayHnoldyj8Y73VngkVMlkf68MS1iyuWdxfDFLzAc5Fp7xdxt/YM5a1Je1pIZGLB+q9ESVnpIb+Be+uU/NcjNH2ulxJcKkLc/vmQV0QLxl6dmPzJlDbTfCHeOwPEDMyuZ4YX35DO4pl4gZNGkkNThHwkXHLD9ED2GOE3FGrTCIxRem9tNm4v6tsVJr9ghgLWUIMkAooIyPc6TjhAhUlVwiIvu4xkC4mgaTNJzoucbaD+znNHSEKJ0eEzobg60JBTgQE2VfFLmrVy/JkQ5IEznYORbP77ewRKX6pz8WdZ13xpjoSIk29ou1bjv9d3JZiohsz4ULY3pQcql46+a/STA0rh2eGqBSp2Bje57KL1fwviEqdPblnJ2LMHH4U65028POnM+sQ7sgmI6oM5ici2xEE1pEzhhbTRFbIvzFlrE/v6yYTIA9z8os680eV9OdzMrS6JZR7NVLj+OrzsQOH2juCstdxXyyiVyAvLl5IKrkb6CFnIA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TW92VHIrU1Q1OGRxZWozZ29VOUs1WFR3eXU0QldYVEZGQlk1Ly9sNEZYZzhK?=
 =?utf-8?B?dHBPS1l1L0lsUHJDdVN6a2JzK1JQV2wzbEFCeFhxeUdudm0ydkN4UWk2d284?=
 =?utf-8?B?M1AvT1QzVmlxVmEyQTNOS2VTK3oxZ3N4YmNWSTNYMm43NHVuUDFweE5taXUx?=
 =?utf-8?B?SkxudnV6ZDlENkdEWlV2WmtGOTIyY0I1ZjVmdTNUUFVrUnp4THJvQ3FKZnVr?=
 =?utf-8?B?b1p0NUFSMDVEYTgyYUtzTjhUdFluOUNYdjV0OGxCMzFNbmJ5NEUyM3MxbXpa?=
 =?utf-8?B?clRORlM3RUkyTDRCcGcrRy9NMHlnVnAybWF6Nmp4UWFNaGEzWlpiK1U4UllI?=
 =?utf-8?B?ZmF0RFZoWXVyNnNnczFmVzIvVU03dmNDL01kbjR3RWtrRS9DbnovWDg1T3NV?=
 =?utf-8?B?c1NsYnNQN1VYYU16blg5cFltSFI5U3pXcUE5VnhRTk5FUVRzdnFrbytnNGxK?=
 =?utf-8?B?S2V1cHR6bkE5L1JrZTZxZFkzbm5FVFU5RXNjYk1UMHd0RmJtSjlsOWdDaXFa?=
 =?utf-8?B?SWFGbFNNRHY3bnRSb0JRT1ZlUDN1N3ZqUjdjZnhnbHBwNUF4YWFHSUN6VU1P?=
 =?utf-8?B?RUM4MEVjZVhQb0RyRlBQdGZ2Skh4cGNqR0YramVtU2lReEovcUV4aG05aFhn?=
 =?utf-8?B?WU9YYk1QUmFtQ0wwcjVEbUhWbUJIcmU5SEJ1Q1h0MGcva2o3aFJJQ3ErNHdY?=
 =?utf-8?B?UXd5bzlTVnFaZzhCL0cvTzBiMG1YT050THpLVVhPc3diYjdVVXIrbFVOeGo1?=
 =?utf-8?B?WUkxODR3N3dnTzdFKytQS0lzcUZDSTA2S0laeFIyY3NZWER6SCthakJsR2RO?=
 =?utf-8?B?SnBuZmprdXgrMFRSUm92RHhINmVnK3VyVXRPSWxMU2o4MFZRdEVBcjJyQjVa?=
 =?utf-8?B?WnY3QlZqNGxBYmZrUVlOOWIzNjV0MGhVT0NlWkRScXNXNGRSa3c5M1pPdUpU?=
 =?utf-8?B?R0NjbFpLOFRpMWtlVkRVKzFjTHVjUGJLQnl6VGRtaFBUQmR4M0FOaVdldTlG?=
 =?utf-8?B?aGc0a1NiTmNDdTQzamhjeUtLWGpqdXU0bFVPeFFwS0tZc0N6d3IvNkdmUTd5?=
 =?utf-8?B?ZkFaOGozaHNBRnMyazRvNXRyNWQvV09HU1JYNzlwdGxwc05BTzVFbUE4Z2Vx?=
 =?utf-8?B?bk1VRlU1dFBxbFRoVW5qTTFZR1pRZmk2d3NUN3lGVzE2NDRwdmJiQWlBVm9V?=
 =?utf-8?B?T2FBMmsxeDJGTElmeFFGQ0MwNDZkY2JvcmFWUEttQURHMWc3MW9pS3U3a3k0?=
 =?utf-8?B?UTZ6VGRYZUZ2a0V4T1FNeGczTnMwY1pmcVFyZVZONHI4KzJuOHJVZ29WanhE?=
 =?utf-8?B?bHE4QjZncDdMY0p2TWtUV3FoVm5FbEtxU2oxMVRGb0s1eGkzVHV0L3hDN2NL?=
 =?utf-8?B?OGdIZFYrSEJmYlJiRndacXVGL01zZ25Eb2RseVZManc3bTlWSkFaODNLcGtp?=
 =?utf-8?B?Rk1LSGdpYmJLQlFQZm1vcGcyeTcyNUZCc0R1c3ZTanE5bS8xN29BM0lyMzRr?=
 =?utf-8?B?ZFlMWGw2NDFlTDNmdWdTM1dnd1g4dm9JazVHdnpiekx6bmQzaVg1MmNSQjFV?=
 =?utf-8?B?RXY0ZU5vbTNLWWozRFhhUEZ2b1FWSTFOaXFNODkvV0JETDBYdnBGdXR0RktF?=
 =?utf-8?B?VHFZV1ZBVk82dVBMWEUvN0I5MVBuUXFOU1NseWRFWE9WK0x1dzFndWQwL0xK?=
 =?utf-8?B?RDZ3OGdoTWFOZXZ4NUFaaHBTZmQvVDBrcDJqNVB5UThyaHpDK1NhbUhxT1FM?=
 =?utf-8?B?YUtwUUNNWFJ4NVZWYlRESGlQZmdiUHN1UXllZ3JmanYvNzlIQXdZZkJON1hL?=
 =?utf-8?B?ampaWHl4UUVIVDR1aW83cTRrbzU3dWlYL1ZOeGg4M2RQRjFNbTZEeTVLdE84?=
 =?utf-8?B?VnNSdUV4anUzVVFTSnRxNkQwcUNvc1BvTHlHUkJWbzRVanFybWZodURCYy95?=
 =?utf-8?B?eS8rUWhrRnZkd0FCamIvZHNETmlEOGgvVEZpd0NKZXYvUERZNnV2dE9IcStH?=
 =?utf-8?B?ZVI2T1cwbnYwZm5YMklMQWdJZ2Qrd0F1clVjRFNoTWJvcnJEYlRLSGJOdWps?=
 =?utf-8?B?TFdJL1NETzhCZDN3ZFYxZnNBdzVHUGwvUUZVekxsMUtWa3ZTQjluN3NrVGNW?=
 =?utf-8?B?RXd5ZDhOZkVXY0dPcEFuNWN6LzkwdEFtSWMzQTlwQ3BlZFdJakRtd0ZYNlhI?=
 =?utf-8?B?ZFdTc1BzY2FUbHVHdGptWEJORG51T1ZlcXFWVEZtRVpIQU5pTkpaelBFNGJn?=
 =?utf-8?B?Z25sMUZ5OW1PbGR2eTlhSXI5UzRIckN0THFwOXlkcHlXbVozemd6UkczK1Ex?=
 =?utf-8?B?emtBWWJKV3lzTWZXUGxLY0pZZncvWE1MZEFVa0x3cmwzZkZnQVNsQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319b17a8-23d6-42d5-acee-08ded8228182
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:13:05.0466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClAH3Dakr8JUd9TFXjzMfaRvLLoc3qHRss0R6aU3jMDnA3/aThkbMZPD3eATdHt0Ivv6SSI5xhC5qPximPS5EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7257
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Jul 2026 10:13:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23379

On 02.07.26 11:26, Pavel Machek wrote:
> Hi!
> 
>> https://cdn.kernel.org/pub/linux/kernel/projects/cip/ -> 404
>>
>> We are getting complaints that download links are not working, and it
>> seems that our as well as other's content is gone right now. Known
>> issue? Has anyone heard more about that?
> 
> Problem starts at "kernel" subdirectory -- it does not exist.
> 
> https://cdn.kernel.org/pub/linux/
> 
> Not sure how this is supposed to work. I guess we could talk to
> Konstantin Ryabitsev <konstantin@linuxfoundation.org> if we are sure
> it is not our problem.
> 

I've pinged him, you are on CC.

> Plus I'll ask you to update your addressbook to pavel@nabladev.com .
> 

Sorry, dropped that old entry now.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


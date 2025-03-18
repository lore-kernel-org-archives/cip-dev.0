Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC294C282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 21:58:07 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.54])
 by mx.groups.io with SMTP id smtpd.web11.7561.1742335083783390508
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Mar 2025 14:58:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=o+Qu625G;
 spf=pass (domain: siemens.com, ip: 52.101.66.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XP9I58sZnNNHjfMK0qjRSZ8EXEVd2rlUPp6udRVKsRpSyvEZUx3RIViPB+dsDnAIq/a22ZJ42+d6sXSaKqw4vr5ncAkhkYbgRVLplo5gKKZ6t3PcqEGQylzHK1sN6JnahSRp63xTX/5p8jx+Jr4N4SNcyBfqnFXAhoNSqcL20xeJGfk3aZI/T8zPnuSyjCtCK8U6isl6HCB0eXD6IcFvi6xg1NyWTQt0EmxIzUuH4mtIASsR2Fmngq5tdUW7pEBrjUxkJozNYh+w70y/K9EAqfKm6bQRm+M6AZxfk1ih5ofCqrIR22d5MPIaBGePs24aKXJ3lCAtvykHi7oEIshFgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymlpYMoMiLkO0JC9mI355so4zOfjYlhTFkeTQyelSoE=;
 b=MD3uATaq7Qf9hbBMs2n4k7bf9rgkDp6lqBw6eE7HoQ7yTiwDyaYl5gHMvT6xQoyxJXwj/EPz681d7yva5VVq2VR9mrABwsYqWx7STmvnYjGpnLnnv59EAMh6HROHXstflBgKQoDBlEbNp7chs/U+F+PP2pD/Tz3lhrwXiQU5AlJjauixbhFPppTOoM0Wl2lYu3ZnpjU8cIybr5uN4Wn2KdZ/K7u/0DYc/9JHJyQYcjL7yR40rwPQdOMJhHVPqHjJxjLE4oTURczw3Pb9NDUqa4HVg+NIujeI5AZ9+QTgGGGa5RLV9nNrVbXbhhc5jR9NI7d5UZKinZDNE+wPtyO6dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymlpYMoMiLkO0JC9mI355so4zOfjYlhTFkeTQyelSoE=;
 b=o+Qu625G0OSw+8othSvrRFgoSccYCM1UBatd91PVWJClzodGhmcagyH//eF48ZhM0+SVu+33UGS4FckEPq4OFg5Xw1dQ9OU08G1qv5JTB9G/xjQGDvZe8aTO84w4XAddyo+IFYqaNyu9nW0np+AvjOaWPx7NvOL2xTTpc7+2vk0tzFPM7pDiJ+kZ9d13BERmWtDUyXplAN0MbLoNjDFMPQ9e6zvzu9DH33Pm4PmEwmnlUZNdB14EiB1W6BFea0HGljryEi35ML8k4bnw3N1AvTLvULmzg6x1WA6XrjGSAhPX/9QZsHP7Ab2FK1bHK9bkO+oss8d1+Oxpxe9a577x7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6703.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:401::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 21:58:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 21:57:58 +0000
Message-ID: <685060dd-e168-44d2-85a2-105a86dc6820@siemens.com>
Date: Tue, 18 Mar 2025 22:57:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: v5.10.234-cip57-rt25 (rt127)
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com
References: <Z9kv4aijWXNBDCrj@duo.ucw.cz>
 <1998774e-bfde-42fd-a4b5-ccb3bdd668d4@siemens.com>
 <Z9nNzWKbo/8hY4p7@duo.ucw.cz>
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
In-Reply-To: <Z9nNzWKbo/8hY4p7@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: f5703f4b-2a84-41bd-d260-08dd6667f1eb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZjFVaUR3dkl5WERGYXg1MW5YN1hkcEplTklqS21XcWhkQ3dLZXEyVEhQUU9H?=
 =?utf-8?B?dVFPeDQxdUtXWTd0SnF3cGlLNUZkN3Zjdit6SndWY1Nrc0xOL0U2UFByaFhI?=
 =?utf-8?B?MTAwUytlSmlXeExmMXZFQVJ0cU9WTDl5aVdjZUQrRzcyYUsrSVMzMEppWEJC?=
 =?utf-8?B?S1NINzlsbUI0ejBBcm51YmtJWnFpNmZXQTJYZ0FhUjRqUlk2ZStjWitNY3kr?=
 =?utf-8?B?QzlOWE1icTFZT21QRERERjJ3bXNBWVpxRWNDM0t6RXplQzY3M2pFQjc1VGJl?=
 =?utf-8?B?SnJWYnNlZFphU3djbk8yaE9YZjd2Y0RRVWhKbUtRQXRIaldGOHY3aWk3dVdk?=
 =?utf-8?B?VitvOG9iMEZFM0RBU3JVczk1TGhWZU0xbW5GN0c4cG9GbXlndUt3K2dnRENs?=
 =?utf-8?B?NCtjSU1JdVZmTHpIVzJoYWpNOEV4K2lsSHZ1dlFROG82RHdEd01heWZYTFFE?=
 =?utf-8?B?MGNDc2FLVkh1ZUl0U29BSGFjWStzTlFvRm82MWl1VEtneGt1WWVlWjN2dzll?=
 =?utf-8?B?OG5QQ3NHYTNjcElvTXgwcU5GZUg2WXNmWEVOenVDanZsQ1MxaTNHV2FaQXRl?=
 =?utf-8?B?dTNuNFdUakVCLzU5TDZyWXhDU1k1cmpodGUvS3NUcjE1VnRDWC9FSERuKzdt?=
 =?utf-8?B?RUErV2U5azRMYlBVUGhXK0JacUhtNGtraHhDamN0TUFFb3BpZ2xUM3dja2Zz?=
 =?utf-8?B?cWZkVlRtdjYzYTZOV3VKemJMWXBiUDRVUUxIWSt6eUhmOFRGWlFDTzc4alB6?=
 =?utf-8?B?NEZyZEY2Skg2U3RnVWE3VUF5N3ZBZ09QZDJjYjRIR1FkeCtUeFFhcHFMSUI3?=
 =?utf-8?B?c3F1WnZCUHdmK3p2U3ByQ3ZmRlp2eDQwQndaRVlQQ2x1R3JYVGN0blY5M3JJ?=
 =?utf-8?B?Zksya25Uc3ZtYlZiQ2FyL3dKNFNpbWVrOE9FZjF3bUZrM1JsRzZWU3U1cVFT?=
 =?utf-8?B?NnpsZEU5MVVLL2dtWGlIWnhJVzVuUUk1Rlp4US9MRnNYWlRJc05id2F4bUE3?=
 =?utf-8?B?eFNjOFY3a3hZU1Y3dnNmVW52aG1nMGluM1F5VW45Zmw3TkFuTFF4ejNSMEIy?=
 =?utf-8?B?SzJmc0tkYWhheUxSNENVL052VUxQYmxmM1lPNnBNNHRtb3Rmd1ZXTVVvcEFW?=
 =?utf-8?B?Z3dvblBsUDFjWUgwdHFOa2NUWmV2MkdjRGJQTjUwUG9ScFhzOUZZaHNoZzYv?=
 =?utf-8?B?S1JmcVlLL0xGbnpUVHErM1lacjBPSk5telZUb1dHR0JmWmRaRzNMNStmTE1n?=
 =?utf-8?B?clJtb08xcEcwVkVjTFZqTmJNa0p5T3UzeDk3SzJWVzg4aHN5UWwwa010elli?=
 =?utf-8?B?VHg4OTRLY1Jza1dTV3ZrTnhkZFdBdlRTOGE5SE5hbUsxbWpsaFZoOWZOdk83?=
 =?utf-8?B?bG1VekxsN0dESnpWcy81bWx0VUZhSHpLUFdlNjE4bExGY1dZVFlNMWhFdS9F?=
 =?utf-8?B?dk15NHNEYVpZTXFreFRSL1pudW4zRDZuWEI4WVZuNlZFTzAvcitWY1NHRFgv?=
 =?utf-8?B?N29TaUU5WlhBTnZmbnJhZjdOK2Q1R1NjTHR3T3BVcG5INURod2FDYjFYUlZC?=
 =?utf-8?B?bU45a2JSQmV0c3B5QjJXWU0xM01nT1hQOTFqblhjL3M2U21SZUVzKzJnaVU2?=
 =?utf-8?B?c0MxejFQSDlraHkxc2lhZHJnaGFuSVNTWDhQMVN6YlEzM2hPaVVZRnUzaHVk?=
 =?utf-8?B?ZmlUQzkyRzViMkNiVlJzMmxLT3Mra0pPNzZSQXNMTHFLQ3FZTHNvNk1kOUJY?=
 =?utf-8?B?aTJYNURQWFN6Y0d2ZnFUczBqZkVFQkhGVVBEM1I4cG5OTlhJNU9QdERGSTA2?=
 =?utf-8?B?K1l1Z05KKzY3Wm0yZXZYdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bi91aDlyZTVGS2FleWZMaWFOOHZIOUNScDhPczhJM0pWK2FjaFVYTmR1M0RY?=
 =?utf-8?B?c2NYZ1ZzUUJhY1N0WlRWZkVRSFhKQ3BpUFpTUm0zQ0R3YkdiMDZoM2s2Y3ZE?=
 =?utf-8?B?WkRiM2lEWXoxL2JWc1c2eCtoNlE1WGtaOEJlVDRXYTcxMVNXdDdpTml1ZUJk?=
 =?utf-8?B?a3VUWlA2elNVOTRXeW5tTDRDQmN1aGJsYzhua3hQemp4WXRLcE12ZEEyNUF5?=
 =?utf-8?B?K0svUnh3VnJkMENxWkRyQmhhQUE3c0ZwaXREVndwRmhVWDZWVnlhZTJOUFgw?=
 =?utf-8?B?TUlEM0RVUXNwMjdySTRaTjZHN2RncllDSVkwNnZOZTJHNFdWNzlGNjRFbUtG?=
 =?utf-8?B?RENaTG53ekR2NXp3VEpneXhtaDJ6RVhJNkFIcWwwdkcreFM2ZjY2Rlc5TGp1?=
 =?utf-8?B?WnBoQUcyQ01sYzROMGdCdktWM2l2dkw1WU1Od3RvK09XTE9TMmRxZ09lK3pU?=
 =?utf-8?B?SDNYdkE1TnM0MlA3SWxwalR3d0NCOGdWdjBSOHFPSStNdzdmSXZ0MWpQd2No?=
 =?utf-8?B?blliS0dKS1k5S2pzRWhyeWl1b0JzNlJ6bURaaE5VZ2JEYTNXczdPZE1IamM0?=
 =?utf-8?B?SG0zUFZGSTB5bTZ3ZkQwQStFTTdZbmhYUnptL253bmxIamdSUERWQjl2Q3Fm?=
 =?utf-8?B?eU5SRlFSYWhJaGhRSVg1SE1YRkU4K0lTUVJHeDR2aFVZcEkrdWRtWmgwUlNI?=
 =?utf-8?B?eERKVDVWQmViNFJwQ0xNaTB5Q3F4dGM0UzA1Mi9SUTZnczhjSGppOE5LRjUw?=
 =?utf-8?B?dEZ0MkduMHlncStnZVUvaE9YNmtZTzd6a2pTenVkcGhVYW9CU0ZWbFdTbmNz?=
 =?utf-8?B?SmhZNVUvVG1YRDBOYS9JUFB5Wm50N3F4NExXZUtjSDFOTmhKL2QrT3F6RmRp?=
 =?utf-8?B?cG9EU3hVKzg5K1VVbXVZdHhQMjgwUE9HTFlzelkxVmpNcmZYSHZ3NVV3Zllm?=
 =?utf-8?B?c042VkdoVHk3L2RtTnNzV3pYSnFJdCt5LzR3MXJRcGJDMzdGWGFPNnl4Yi9D?=
 =?utf-8?B?SFhxVjUyZjFnR0VMdXdOYU5YeVdOQTFyNVFhSFF5a0RqMHhPazB5SFg0Z01J?=
 =?utf-8?B?d0dZTnkrU3E4Qjk1RVpkS0I5U3c4TVRQR3d5SEo3bG1DRUUwc3VrU2pramJl?=
 =?utf-8?B?Wk0rTVIrZU94cnU2bjFRNGJOSUc0RXI4dFN1N3l1bHVvNmxpMXRJanVibmtN?=
 =?utf-8?B?UWxXUmhIdWF6UWg4QWZBb1RyRlBMOFZVUUZuVWkvdFpDSE9iSFdVcU9nVktU?=
 =?utf-8?B?bzg3NVNLNFFERktxSTRZRysxK1Ura3M3UDg5UzVheW5zZ3ZES0FBSUpjN3NW?=
 =?utf-8?B?OHRiN3ZvZGl5dlZsNzFISlFHOEgzSnFBcTRiWEJPeDBBSFhkTUF0K3RxekNM?=
 =?utf-8?B?VHhOQVVmRFFXZGhTNGlXWkswdGNOWjZVU0RmekFVa3VCZVJ2NStlSEsxanR3?=
 =?utf-8?B?U0NVTG1MZlBzaWJhUmpLUndxdi9Ha0ZNa1A2bjR0N0xFSnRKY0d6dzU2eWFJ?=
 =?utf-8?B?ZWpMYUM1dWNsNENxWlJLKzhuK2RHK2grdGpnVktFaTRoaENyQ0FvTlNjWTVU?=
 =?utf-8?B?RG40dTFWZE9iQjZFc0c1Z0JkQXcvR3RXa21oMXUwQ0F6ZTFuRldnWVVDK1Zp?=
 =?utf-8?B?MmEvNW82eTBvamZheFZ1ZlVTWmIrM2Mxb3J0N2pPaTZTMDhYMGRaaS93dUxK?=
 =?utf-8?B?UzdIdEl6dk5yTFR6ZnEyMUNueTdCYXE0NjdVcXZQUW5rTEJ4N25IMllNckEy?=
 =?utf-8?B?bEk0U2pKTTNvTWFMME1qUHlKd2RsVkZEb2xyMVI1ZUsxb1NXTlpOSVpJaURv?=
 =?utf-8?B?SzUzQkxwL0dqWkdKa3RDTVJVbVlPVUpjUUdHSjFvdjd1eE1Na1lrQ0pzN2tr?=
 =?utf-8?B?YzRUbERGdlo5RWxoVUY0ZDZZNHVhdStrVFBSZVhxN2JqNFFxdWVtQzNWUUt0?=
 =?utf-8?B?T3hncURaYUt5c2h4a29zcWNrVWFxdDQ0cDJSTTVOUmJST201N2hqR0xTZ3dN?=
 =?utf-8?B?b3NIWUkrVnBGeTBRNWVuNHBYM2NxYytHelN4dm1KVTA5L2pydy9FWnczZUx0?=
 =?utf-8?B?S09WN1hkdjA5ZHBJekIvVDZ5a1FOTWlKSFJnemRIL3Z0clNCYjlRZlNNNGZS?=
 =?utf-8?B?aGlWUFlEN1VYdnBrZ1ByWU50bEJGUWxRQ3dEeTZ6Vm5ueEVjeEd5T3RXL1JX?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5703f4b-2a84-41bd-d260-08dd6667f1eb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 21:57:58.4177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRzmQBrA4eZR/6Ai/YXkByUsO14XpP9rdWdGCs50I5ygFtb+YEy/jJhPVt88WdtdvutZ4YkCHoK3btIPQDYEUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6703
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Mar 2025 21:58:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18243

On 18.03.25 20:47, Pavel Machek wrote:
> Hi!
> 
>>> New realtime trees should be available at kernel.org.
>>>
>>> Trees are available at
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-5.10.y-cip-rt
>>> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-5.10.y-cip-rt-rebase
>>>
>>> And their content should be identical. There are also tar archives, at:
>>>
>>> https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/
>>>
>>
>> "[ANNOUNCE]" tag missing - did you change your "scripting"? ;)
>>
>> Seriously, part of consolidating the release workflow is unifying the
>> announcement emails. These inconsistency force users into manual filter
>> modes.
> 
> Sorry about that. Mails are really difficult to scripts.

I politely disagree.

> 
> For tracking news, I find git quite good. Newest cip release can be
> queried using 
> 
> git remote update
> git log origin/linux-$BR.y-cip -- localversion-cip
> 
> Similar code works for -rt (and stable).

That is right - but no good excuse for NOT automating the generation of
an announcement emails. Even if your email client is limited here and
does not support [1], you can still push that in mbox format to a server
or some local folder, pick it up from there, edit and finally submit it
with your client. There are many ways to achieve that.

Jan

[1]
https://github.com/siemens/kas/blob/2694ad64bfa258e8fbdc984cde41ff37f35e9fd7/scripts/release.sh#L74


-- 
Siemens AG, Foundational Technologies
Linux Expert Center


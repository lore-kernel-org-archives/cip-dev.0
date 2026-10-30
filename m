Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.60])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3906.1793329593118660441
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Oct 2026 20:06:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=q4pt6jd6;
 spf=pass (domain: siemens.com, ip: 40.107.159.60, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYWmfDV7KDNScfV0rYqNutuGH5RpWCeZQN8r9lRv+RCJZpD4uTUzHwmFetOzGaKhON3kYA3KR7ND+CD7BhJ/GZR3mGJJZ/zfnfgn1L2LNqMbkIjt/GGRXNdeEa7kZVfVvJYAWsbnn9siiPm51ZRXwE0EY4OvjsFK/OfE7T4RFfccnmF4UqOia6iWMrP1W9LkO/pEktrUG6099wzBJGUgNqIpJxseDPNAB0g4xfE8faB7e+lzfxWZ1V2urZ5JvcmhAMSyiZQeiEBmiPu8yKqfg6KnuKkce38o1C7F+V8VcLwuNEf/ePpjfges5Cv5/rbY8O4KiS7WlWj0+p2ej5OPKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zj+IM5mPexa8yLbemVXRz+uZY1SrwKG8MsXpdc1KytU=;
 b=DVnzBh9oh5mK48cpPF00HDUcSUnAUJSL5FhydAmTKgJgl6i32mFrt9yFA0qgsdpuZ4aWfF2kli9Lh5YLJTwBuB1/13hMR7n0xaJ49moL55uayo2qTTF9AsIRZQvapvRqlhwx35oZX6ZM4DG6jg3uZfy/lVsaXjiofhXbf8HPfru2Mf3h07s0hhCcFiV6ueVWzrbLQ+MKWotYqvaLF907pKtghZ2eQG/DHDdwLKkmHy5p84CCKOTYhs04+kMBl9EPBjnIzcOPsxDBU3FhAPMiN/nk2dVnE/esBZa8UPQ9ZlJqA18y22WMOXGdmIx+aoDJxrlzRaJunk/oMj3t5C6ZQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zj+IM5mPexa8yLbemVXRz+uZY1SrwKG8MsXpdc1KytU=;
 b=q4pt6jd6QIGGhRu1LFU7upKvoQas4NwInFoL3+sggAcIaKtJb80vOFF7C1DtxSzJtNN5G3XX0/5D7h8tnOgoneIsshLEO7wDaVVk5RNgI3xJ+SV+WcpKjdn3Vgigi7TQ3fARi6IRiOD5IaWGhcr1ffkA4CzqZB9XkS/DEoQrk7BPyzeywTkMt5hWBlwmt338l6+J7zAn1cccRMI+b48zSvAPpGpyj3DmkzoMCS1wgjfgYD7tRQZKjuZ/bno1zU1vBq7RBA/Z+HjqLj+MfeRPRrSXlUY8kG3FD+o+xNRJzfuU+Iaxr/LecZzVFNh8J3eH8BGHTcaQzMlpEhrs+A7y0g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DU4PR10MB8951.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:56c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.4; Fri, 30 Oct
 2026 03:06:28 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0592.003; Fri, 30 Oct 2026
 03:06:28 +0000
Message-ID: <1a847237-068a-4ebd-95b3-0d7eebd4d9fd@siemens.com>
Date: Fri, 30 Oct 2026 11:06:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2026-98432: Remote code execution in Linux MPTCP feature
To: Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
 cip-dev <cip-dev@lists.cip-project.org>, Pavel Machek <pavel@nabladev.com>,
 Ulrich Hecht <uli@fpond.eu>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
References: <CAODzB9rMsTzkUBdus6m6u2Aa_5vu-7GUhjdKskk88akgo1JpUQ@mail.gmail.com>
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
In-Reply-To: <CAODzB9rMsTzkUBdus6m6u2Aa_5vu-7GUhjdKskk88akgo1JpUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::7) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DU4PR10MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f588e3-ea09-415e-cc7c-08df3632ca7f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|6133799003|3023799007|10067099003|55112099003|18002099003|22082099003|56012099006|11063799006|5023799004|261026140227099003|261022105027099003|261028144727099003|261021121427099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: KcGZ2JJc779PyeC9gzHe5jezbU/ZSaj7aBEUJFLZVM8jz7YE3wE4+ufuX7ovQBaZqFHuVQgP/9lOowapy6qa8mUv/Cq/RFskqfsWWAwr0gTyQpeeiPbdL0MJ3uAAjaYs+epW9s3T3XebnUTRiOtl42nQUbdQlS5ZBNs+Hgi4zAecPyMZ/bbXLIFqdeNf9fcuJby8Dy8DPoqTJDW4tc5w/B9G/7q+OMu0BHLFC3bYCF3Z+zt2sXcnaUMdjyPWL5mqDA5IkjFslE0FIb3mkRDChy/GKcCmuHzV5L2re9jCgCrcid014oaydvZ7cJjT1N8d5xDEIlnrDd5ArPsgWaTioJoQmFKymwi+iLbOCTZZLsfmJY7mxSQLg5llQohHlej1UkrN/15I9AgBTEwcFukVcyil3hqXmgzNQjFTO8aHJnm976mbTlJUTUHkX3o1dhwDXb4gaGzZ2ARNiZRCe65ASSv7dF4ENiz/Rc+wALt9nAP5IEBsg2qzPPql+KaP+dk/0MjqT2oV+IopHUtwRjZbjRfHBu8V8dZXbUug36SgMPsAyM+QIvrB4lowt+qhszI0OU1vfZMXy8oxz1RxAz7V9igoDD5DbSlDsClpx4SAjznm1A+GII5BLgHkIIRLMF40
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(3023799007)(10067099003)(55112099003)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(261026140227099003)(261022105027099003)(261028144727099003)(261021121427099003)(261022075727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0wrZS9DcGVEL2xBckpvU1J5YTZYL2ttSGFxbHdtQk91UUFyRVdWeU0xRVR0?=
 =?utf-8?B?LzNvVVI0S1MrK1NNOS9BQk56S05vZy9MRTVrUTVsYlhRR1BSUUlEa1F6bVV2?=
 =?utf-8?B?UmZvdmxLOUJWanVoUGpvZ2Q1LzNiS2lZS2wzMW9xYjN4cHpyakRURHpHaXIr?=
 =?utf-8?B?N28vS2RsN0k5YmtXRzF0ck9QbUwzRk85RVBnMEx2TUhYRUhuUWFUTXN0alZa?=
 =?utf-8?B?OEljeUFIVGJrWHJqQmtmU3F2a0tqQndmU3Z3cnVIN2o5M0dQZ1gwcWRNRnBU?=
 =?utf-8?B?TXRBNG9Pb3RLdUNpUi9hZzJnTTFMOFNwZGhRUzlnWGlBUlRzMXRYZWs2N0s4?=
 =?utf-8?B?S041TmlXWW1jL2w2enFEUmJWZE5pRUxEcHJidDE0Q2pBUzZLdWlrdXJSNHAv?=
 =?utf-8?B?dXA0UFdKd3JicmE4cEFvOUFFTmY4eEFmeHA2TCtjYmxMODFqdFVTREt3bmNa?=
 =?utf-8?B?aElRNUxUdGV6YW1QdjNNUmpBc2hCNVg0djQzRmpweldRVS9oRGMvYnMvd2Vz?=
 =?utf-8?B?Smp0ZTZBZGpyZ0pVdjNGT2ppK3JFRjJNU1ZGRytYcjhSMzkybDcwRUZKSThz?=
 =?utf-8?B?c2dwaEUvVVJ1UzN0SjBFamVXTlR1UDZOV091S3dxWENnRjZNK1pmS0RWQXRO?=
 =?utf-8?B?KzNjQlFBcVlBRGxVMENCR3JvSHVQbkFwVWErMERMd2hLWEZOR1pYYlZPOXg4?=
 =?utf-8?B?NG9xZ3gvSFlRb3BzYkFHOUxpdGl6R1VvVlJFbURrUlVkZDI0N0FKSnRIaUNn?=
 =?utf-8?B?Y2c1WVJpdU05NktPUGZidWVOZjc4N0NBNmRYZFQ1dGFlaDU1ck94dDNQNUZr?=
 =?utf-8?B?c2p5SjJ5aE8wVUxiVDJlK3hFYkk1WExZeForVEpkOTlVeFdsd2VkajhkUjdt?=
 =?utf-8?B?M1BXWW1tTXd0azViTHBtVXJ4ZlpRZktvVEJzRlZ3QjdFdDhnRlROZVpxU1VZ?=
 =?utf-8?B?aVZBUWp2dWhnSFE2bWRFYWE3RFpuYjU2VEVidzNCL1VVcFpDV1NqdXhicHdm?=
 =?utf-8?B?SlkxQUpQbURvNEI3Smw0d3RwTlU2c2pDc29GTVR4WmV2cUpXL0NkWWtqdFRI?=
 =?utf-8?B?VDZYdVNPSG45RXk4VlQ5VTAzZUNadHFQS0V1RlNJeWhWeUVRNzdOR0lPZ3RX?=
 =?utf-8?B?ODhWZ3J1NlozSGdJZlJQUGE0WlpPeC8rMGhZOWFhWGt3NjJadTd0SlhEdFdr?=
 =?utf-8?B?QktiejhLbEd2Y2JKWEl0WjJwRFJSbVBPbkIzajJxenZqcjVvcjUwMndncXRF?=
 =?utf-8?B?WklEU1hQTGJNN2tMTjV6dUhIS1RIbkQwR1RGWHBSYmc5YVlDa3dUYWZsSFd6?=
 =?utf-8?B?bFRmd0hCT0VVMEFuVThkMnF2bHBjdUM3SlJud3o0L0p1VXFxR3Z3SGpXb1cw?=
 =?utf-8?B?dSthdTE3N1dKV2RXMHZYSU1iSlJua3NYQzQya3F2cUd0MWhtWXRlb29rN09x?=
 =?utf-8?B?R3Y4T3RzenBRODlSSnFBYnMvTUMzYmpzSW5ZVDdtNUlHc1IzN0dWQUcrZy8x?=
 =?utf-8?B?d2VkamlScjhrM0U3U1JPTEhFREJpNGI4VzVCZ05oU3pDeTRoWUFtU1pldDgz?=
 =?utf-8?B?UFVMMVhRakdGeExtR01XVU9mbHN1dHZWcUczV1pNOXlrOWxQRmF3dzQvZlZR?=
 =?utf-8?B?bEhpTWVJKzhXdXZQKzNzbFRnbWJ2R29ZSWVaM0JCWXQvK2o3YWN3VUp5anRT?=
 =?utf-8?B?NERPeG5rWGlDZ0Q0NHFvK1dWL2dIenQ0QjJFRG1zcTBkdWcxN1hGZldVZkNN?=
 =?utf-8?B?SW5LeVA3c0NUclc0R1dEOFdnTXpDcmFHQUVaZmZRV3NlWURPUnhFQzI5Z0Rz?=
 =?utf-8?B?cVY2M01MQXBWNHRWSzR3SkdTeC9IaFhBRWFZcmN5S084dTVhU05aWDdWaWNM?=
 =?utf-8?B?VU14OFNvVnNqZEtjRmxSQUwyNkNsbUMzVlRGSnNaNUVMeXlpbHZacjh2YjFw?=
 =?utf-8?B?Mk9RUGtMWStDbkZBNll3QjJQaGJVVFpPbUMzNG9RL212UmF1NDJSTWV5Y1px?=
 =?utf-8?B?cTREMDhSWWpiaTdCRWtJTnl3Q0MrcDgwT3IrZFRRdjViWURwd1RFblFJV3Jl?=
 =?utf-8?B?a0xQQUY2SmZHcTF6eC9jVStQN1M5Y2xScE5uSVVKd0YxL05hZ2x4V243U2ZJ?=
 =?utf-8?B?QzQrenZJcFVkU2EyekFNUTNucGJlQzNWSHQrT2lpUnZWa0tyQVJYbXNXQWx4?=
 =?utf-8?B?Vy9VODhxcFFOT2lhU3JTMDRraldCaGF6Qk5CVUNPaldlQm4yVE1qQXR4cWtW?=
 =?utf-8?B?TFI1NjlQYjEzN0l0ZlV4RWJ4MUVTbU1ZWkZIZU16ZE9PV01CYzdTcms4VVRt?=
 =?utf-8?B?aDZWNFhIdXN5akVoZnJRVmRIQXhMUHdXZWNkQmwycmxYZUdvYmIvQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f588e3-ea09-415e-cc7c-08df3632ca7f
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 03:06:28.4573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4w2CsdBQU5URI9L38ymHtpmChs8q/+URF53eq8yaVi+ujpVb5bN4Td59/OYW8QkgHThBs0pbXscSQUhOEpsWEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8951
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 30 Oct 2026 03:06:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24579

On 30.10.26 07:24, Masami Ichikawa wrote:
> Hi,
> 
> Anthropic reported CVE-2026-98432 as remote code execution in Linux
> MPTCP feature[1].
> They said that "After initial prompting, Claude wrote an exploit that
> allows a remote attacker to send packets to Linux servers with a
> multipath TCP listener to run arbitrary commands as root, without any
> credentials or user interaction. The underlying vulnerability is a
> race condition-induced UAF bug in the kernel networking stack." so
> that an attacker can attack anywhere without any credentials.
> The CVSS is 9.8 by Linux CNA[2].
> It seems as if PoC has not been published yet.
> 
> This vulnerability is introduced in Linux 4.4.
> The mainline and stable trees are fixed by following commits.
> 
> mainline: e3f33b0a1d89d738e2b913dab519226eaf76e15b
> stable/5.10: b3b027ef0cd322bfa839b9aaf5b27551eea54cf6
> stable/5.15: 95a8c8fa9f27dce64c40c41c062de7728bf34ab5
> stable/6.1: 89b5b1eb7d633c33832b7ff2c02e19a144705036
> stable/6.12: 11a03ce3c4a62d84c10ccdfe47f8075006498568
> stable/6.18: a47406c769f72c070386985488f1c4d057df86b2
> stable/6.6: 742f73df544e03744f2981c467d6542fe8172a2a
> stable/7.2: 26d4c36d318cffbbd160884a0e4cec0da4da4936
> 
> For more information, you can read an article by thehackers.com[3].
> 
> [1]: https://www.anthropic.com/research/discovering-vulnerabilities-with-claude
> [2]: https://www.cve.org/CVERecord?id=CVE-2026-98432
> [3]: https://thehackernews.com/2026/10/linux-kernel-tcp-flaw-with-98-cvss.html
> 
> Regards,

Thanks for this overview - missed it before sending my own message.

I'm still under the impression that only 5.10+ is practically affected -
unless there is a chance to find some MPTCP-free exploit as well. If we
consider that risk too high, though, releases for all CIP kernels with
the appropriate ipv4 fix should be tested and rolled out rather sooner
than later.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

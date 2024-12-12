Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C763BE7717F
	for <webhook@archiver.kernel.org>; Thu, 12 Dec 2024 09:45:29 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.41])
 by mx.groups.io with SMTP id smtpd.web10.16124.1733996724063818941
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Dec 2024 01:45:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oQUo8AyH;
 spf=pass (domain: siemens.com, ip: 40.107.22.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJZAg/bilsM/kwBDQA8f1pehzwpLMB2DKZy2rUCH02KUWcD5EdyiakchHiw2BZQrxf+6VX7uPyqKDYULQmqX62qfFUN41hkEgW7pWbDtbhD7zETzkhitR985W5NYxUeoJ9PLd9dDA1AKzfSSWw7jivZNaI0F8lO7aBDr2i/aw0hp5zOWX7m6A97r3wWq4Pc7OqAgCl43n47dsxM340pGBVY/7zwCTcynTknZgf6okved6+WegFAJz+Qw/hsMPaKUSDkmTA9MZcmEGst2j1AJC+DUvC1L62uIiblJqZTqIMuH3ELPSz5FRCLnontt0hZUZzm4xkCLy+zg08MHIyJb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLSjkxVq0KNvoItF1STOychQ1iDFcvxON2ieIETcu9A=;
 b=ImzsIQnmIpNy0KGZvnH5Xc/f5b02XX50I6oGEypuG6G5Xy0/F/V4R6o0ArbNj987FX2JOrbh4N97Q7hNfMDQmbRyzFsBAaFZ1K3IDP/03na+VYsc2b8kUh4geVIJkeO98V6XN9o6SYT9CLK13yKKzhRDPPqP5Cs/bgRQeyaTBd9rcyIZPXccLf/hiu0illTG8peZ5Pp+5ZaIrQZ+GoIPu0ZVRcSwnjZajb46Ppzu5jg3tqgtB+Q+x7UT3+qMHovEcstas40ONFNewxtHk/ACS3QpOGJ8Jm3+H0oUPgeFPUNWLYh/wYqetizYjsHTopiFZ9geGGdyTIy42XGRXPVSwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLSjkxVq0KNvoItF1STOychQ1iDFcvxON2ieIETcu9A=;
 b=oQUo8AyH5PVUm09JggstA3D0rr69R1YIIB0LcD+uZpxJkOe8QcsOjdD/NjQEe3Mje8/NBQ+i7JYKNRABuqoa0Cc7HvebrXN/YZeRiHKw57lHBx0KAqc/urk8EavSBlym52lNPB20ItsrlNOE5j8SqTMku/pDGPPRz2imnWc6yCvC5Nswg6GMWgY0wpWqCElWGLlIae/nQdqHVGgI3dySeMFmrh1eG21Gg1LmAy/edR5H+GSOWirfsKqgVAIsJm3OXwuOdWhNkMmesDQAqURWXGkiaStvsWFLC2NlalhuJAiEjAWYFmtw/jQmu1jFpY03Q8C74BOjMalC4DSvIbvQ7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8834.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:232::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 09:45:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8272.000; Thu, 12 Dec 2024
 09:45:19 +0000
Message-ID: <edffb486-b2e4-4c59-af5c-942c7f558999@siemens.com>
Date: Thu, 12 Dec 2024 10:45:17 +0100
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
X-ClientProxiedBy: FR0P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 5018fb83-78bb-4d79-82fa-08dd1a91b057
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?angwWVBCVWNLSlFBTTJpOThqTEhqNU5KaWdQLzBjVXZWZEFWTmtUc2NzV2k3?=
 =?utf-8?B?S0tROEJQaHdzNUhuemVvSkJMRVNUYzVmbjJZUDlGME5zZVJwNlRTUkd3cWRW?=
 =?utf-8?B?Q2FRdjRySWxOZ2VYcEFNRXdGT2lKc3Z6RW1wTVVEbE5aK3lVWHdjV3dxVFhM?=
 =?utf-8?B?Mm51TGt6aCtsSVkvK0JFTGE3clppRndFRDJxWUxUWk1EcHdYMSs0WWFtbFVv?=
 =?utf-8?B?WHpBN2M3ZnY5YVpJZGdDcUpDSXp4dnBkMXdZTlV0SEZuVjdhSkRac1k0TGZH?=
 =?utf-8?B?aTNvU1dvb1pHaDFaL29JOE1QT0F4NmkyKzlmaWc0VVdpZWlmN3ZvLzZKVmNR?=
 =?utf-8?B?cE5KQmp1eVU4S3hSVlpRbEdBSjVzblZ4c3FmZ1h0MUlRY08yZ2hMZ1VIaytw?=
 =?utf-8?B?MWJzZVpPS2IwdmpFODMyYnNLL245SUZoNzdhNlcrVGdoeEpUMklUb29iS1dz?=
 =?utf-8?B?Snc4SHdkOXA0TlJ1Q3RKU3lNWU9NYnZMZGd6VzVoeGR2NWI5RG1RK052V252?=
 =?utf-8?B?RnlLT3NXZVIzcjk2NldzVXg3SCs4c0IwbWE4N1R3eDBiRGdCKzUvZUFmeHlV?=
 =?utf-8?B?aHM0aWRLejdySmVZeHFRSzBhTjFjWVVEV0s0ZGVQeDlVMVQxc0dVRFBnUUVm?=
 =?utf-8?B?ajEvYXdLaVU5TXJLNVM5RFFJREI4QnlrRW1ISzRFRlFENUhhVHZEbytUakhF?=
 =?utf-8?B?N3lYbU5UcVZpRE1VRDdEMDhEWERqOWZmWU8ySmNERVhGeGtBdUhxVklVWkpn?=
 =?utf-8?B?aEozTlJOYTgrODZ0TVl4aFhhblZKRUp0MS9KK1F4ZFJWZUZHaTAremVUU0VT?=
 =?utf-8?B?MFcwSmZZZE1kczB6NEFmVlNLc0RQTjE2dUFpM2c2UDVMbXJ2K0JLYTZxZXpK?=
 =?utf-8?B?V1dJR250UEprWkRnNCtVcUtQOThQdlhSTEhuZnF3YXhxY3FZODl2MFN0WDdG?=
 =?utf-8?B?Zmp3YzF0OHY5Z3ZQWnpHRXpvOGt0b2dGdFY1dUhUU3dsR1oxZWJHcTk2ckp5?=
 =?utf-8?B?NmJ3VzlyV3hjRFNBVElHM2dLaHQ5LzdCKzZSOTZIV3huUkx6d21LbFE0T051?=
 =?utf-8?B?YU1zdnRTL1dpOUVzTDB0b2sxVnVWcjNHQ0ZsWlhRREhUdUVIRDBXQmYvQ3k5?=
 =?utf-8?B?eTdhaDVZbE9VVmYwWWtodGJzUHkydmh3R200WUliUXFYVUloTVp4RjJlWHc1?=
 =?utf-8?B?NHMrT2orT2hqQVh0NWNWTEtFNjhKclBrR1FoSko1ZmpOTWhQbFlqN1dYd3JJ?=
 =?utf-8?B?bWJqdjkxSDJJOEdHQ3BRcWd5YzAxNzVLOVBMc1dpazBHUFAvYy9XRDVBa3k0?=
 =?utf-8?B?ZlB4WDF2T3cyRk5yT3pvUzc4UU1ZcnYyeVlqZDZETVhaUThad0JoSUczTmJT?=
 =?utf-8?B?Yy9WVlBQcFhmSGwyUGxTNDhmL0F4YlR5V3YyNUNaeEx0dkdCbGVGWldtajZG?=
 =?utf-8?B?aGhXUW50dXloVG9hd1JnQzhkUlVDNlQ5WlYwNmlVbURpaDFlVVMxVlVyK2VW?=
 =?utf-8?B?S0sxM2JWZ3pLRVBBRTdTa3hpcmd4Y2hqRnBOMHhSMlQ0cDZxMStXZnU3OE5I?=
 =?utf-8?B?d2dqZnpzSVdTOGtmSHNYVW1JeGlMN3dKUld5cUNYN3RMVkhEVXBuY0hJTStQ?=
 =?utf-8?B?NmxqZll4N0RNN0xCZUo4TWg3QVRCZUlHU1luVThkaVd0THkvOFdIOXZvaTgw?=
 =?utf-8?B?b2kxT3NNNHJsQ01oYnhycXZ5S3piQ2hUdlBtZVBKVnowU3ZQM282aThEOG8w?=
 =?utf-8?Q?dBNer2AChnm9DpwRQQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aTBZZE9oeGd2VnFBUUtpNkpxQWtaYTFhdTBxZnRIWXhDcGVFaldDYjlYdThR?=
 =?utf-8?B?NUdIVFhuS05RcE5vVmJSS0Q1aFI4V0p4S3NWM2VCZHhTeTltQWZLdnVWOXNs?=
 =?utf-8?B?N0xDSHBlSnJoNUhmQ1pnRHc0YnhsQnFTNFZPQ1Z5TW5jWnIzcyttcW9YWkx5?=
 =?utf-8?B?ZG56Z1NKVmxrS29LVjF5eXl2MHZPSVA0R2VBa2xvbUNPS1ZyeERmbEpBYUdY?=
 =?utf-8?B?QkRFL2ZTUVMvSW5nenhCK2NtRzh3dHZsYkJjb1pTNHNlTFhYUW92ZmtaUDcv?=
 =?utf-8?B?NzVxS2hnaHIva2JKOVNvMTZMOEIwaFdBbU1hWEwzYmxMUUdZa3hwUnpJVUVq?=
 =?utf-8?B?Tmw5RVBha2lnRnJUazBFUDlFRTlXUG4wU0N2OXEwVFZUMnFpdUI1bENQUkUz?=
 =?utf-8?B?YW9ZaTd2ci8rVWZnZUFib21DMDU3OXk3cExneU1CSE9jVGJwUm1SeTJIMjdW?=
 =?utf-8?B?U1p6L3kvVnVPTlFlMkJFazJVSmRVWjh5eCtqTjFFbisxbCt4QW1meFdRMHpC?=
 =?utf-8?B?OUt0YnhyS3JmcnpPdGsrbnVsd2E0UWd6aGowMzZQNmdRTm5TVFZScHBSdUhs?=
 =?utf-8?B?OUtTbUhxbzRNS0JiSU0vWmFyalo0aTRKa1FRRlg3S2gyZUF5aDdreHI1S3dZ?=
 =?utf-8?B?Ym9KY2JWTXJuRTFEMko1UG5DWEF5SHN3MGlQWDNDVDFDTnViVWRKSkxDNnVO?=
 =?utf-8?B?UDNMVGhKbEsycy83dWl0OVJ6UG9FbGkyc1QrM2NoeEw3c2U5NHVWSFhCNXA0?=
 =?utf-8?B?R2FEY0JhWHBIeWg4WTNqQ2w3c3hJU2pvZlZwckx5SmhzTm5YcVlPQXZlSG50?=
 =?utf-8?B?b2lVb1cyRjY0Y0F6QzJjdnJsYXFaMGZOaGFpMkMrWloybFhJZlBHTTcxdFBY?=
 =?utf-8?B?YjlWWHZWVU5OR3ZpeGhQQmtRZzcvemtQZVhJOVZVb0VjMU4yT2ZOVkp4WVNq?=
 =?utf-8?B?MU11dGlXMnFCbVNrVTVWeFVNT1pDdGNkREgzMEhobjY3bVc5V3czdXg3Y0RK?=
 =?utf-8?B?b1VHd2xyZTVhNVFsUFRHMUlGZWxIYjFCejBlcWFod1JuYWhrYlJFaURpRHVx?=
 =?utf-8?B?RndwZ29UQW1CNjBIU2pJTlRQUGlnNTdQdXFwa2xSNlVIdEd1NG1CeGNDWE1v?=
 =?utf-8?B?WTB4RkI1MnFzQ2tycmwzN0NFSm1JLzg0VTRsZ1NXalV4a3lZUGlJNUxWODBk?=
 =?utf-8?B?UWFLYWJtaHUxa0l5ZDh5dGdVcHFLeEtEdmNxREFiVlgwZDNFZWJzKzhGenkw?=
 =?utf-8?B?ekVFQWQ1d3VGNllobUhJSGRkRkR6NTZScStFOWZPWXZiaXkwdVJsS1UrSFp1?=
 =?utf-8?B?WlhleUpjT2tDQUlsQnBYdzdsRk9EeVJqdmZoNlBNWjZlbFNKcWVoUTRkS3RC?=
 =?utf-8?B?cC9iYTM2R2tucE42clJlTy9ZUGJkSnVDVXBPcW9HNHE3SzJHc2ZyaWRxMkhR?=
 =?utf-8?B?aUJJeDdPMW5haTczRk1WNTVjdVN0c0hMU1hIUkgyei9EV0djZTdDVUEzdDhi?=
 =?utf-8?B?T0hXSENxc052TkkwVWV3SjFuN3JPZEp0NDBnajF2K1phTUZxVm1qbzNKdUVL?=
 =?utf-8?B?UEpEN0cyNWNQR1hSV1YwUjlvOThBSTJoNEx1Zm5HOVNyU29mUEpVb2Vta21o?=
 =?utf-8?B?c2tvSUN1NWJhSGI1R1NQOERVZkxXZkRxWmsrOEtuZ0tPSmNSZWVPZjVVSUhw?=
 =?utf-8?B?NVFkUFdGQjl0cE13WTBNY1BNRWFDN1djZ3hsQmEvNXowWXV0dHBFaXhTTldJ?=
 =?utf-8?B?a2NjVmQxUExYR3Nxc0hHTGlHQmlpVmcwZGQ4OUQ3UXdNMC9WQ3ZYRUxZMzNy?=
 =?utf-8?B?V3JCRklOQXlMQmVVVy80SkdJSWRVQ1NPbUNxYU5LQW1xdSs2SXZDOHA0eDZO?=
 =?utf-8?B?dCtYMGpJaFM0VStXQ25VQlpadDVnYnhCVHpFWVJTc0NnUVhMUVY0SEQwV2tq?=
 =?utf-8?B?dWJoMFJQR3BSblMyVnlnUTl5NkdLQ1VXd04yZnM5cHdOMW9tVFZkd3I1bHdI?=
 =?utf-8?B?R21SSnNSYlh2Qmt6VkMrSUNqZWREV1IvNUVUQW11N2JGU1lsZTdSY2FHOGp1?=
 =?utf-8?B?c2g4RHppeGJzMGpieDB2ZW5waGhseG1RRHVUc3NzRGkyamR4MENwMm9WTDRW?=
 =?utf-8?B?Zm5zVSsvNW1ad3NVaDc0ekMrc1BEci82dmRGWlAzSVhkem8yOVRTSzdINEVu?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5018fb83-78bb-4d79-82fa-08dd1a91b057
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 09:45:18.9727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYLLKPuNXkFiZy4J4EmrwCkO2kLgeiK7LgYU2+ZZ6JW7yZrkkb8zhSLXvV5ghKQxeN976iOBYyYty+gB8j1i1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8834
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Dec 2024 09:45:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17412

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=12&day=12&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/12/cip.2024-12-05-13.01.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
  - release planning for holiday season
* Kernel testing
* AOB
  - meetings in the next 3 weeks

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Thu Dec  5 05:21:08 AM UTC 2024
  limit date: Sat Jan  4 05:21:08 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon Sep 30 09:48:28 AM UTC 2024
  limit date: Fri Nov 29 09:48:28 AM UTC 2024
  Status: *Late*
linux-4.19.y-cip: interval 30 day
  latest version release date: Sat Dec  7 07:05:01 PM UTC 2024
  limit date: Mon Jan  6 07:05:01 PM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Mon Dec  9 12:30:02 PM UTC 2024
  limit date: Fri Feb  7 12:30:02 PM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed Dec 11 05:28:57 AM UTC 2024
  limit date: Fri Jan 10 05:28:57 AM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Tue Nov 26 03:12:05 PM UTC 2024
  limit date: Sat Jan 25 03:12:05 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Wed Dec 11 01:47:08 AM UTC 2024
  limit date: Thu Dec 26 01:47:08 AM UTC 2024
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Sun Nov 10 11:47:28 AM UTC 2024
  limit date: Tue Dec 10 11:47:28 AM UTC 2024
  Status: *Late*


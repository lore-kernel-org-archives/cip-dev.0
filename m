Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A31C44536
	for <webhook@archiver.kernel.org>; Thu, 22 Jan 2026 10:29:58 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34176.1769077791845927961
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Jan 2026 02:29:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YybmNP3c;
 spf=pass (domain: siemens.com, ip: 40.107.130.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jo/1X1JsLHZM9jfZ38ikvmZibQH2/zllSWvWNzpkKbXbnXC2M+9V+FEGVGy5LUREfD3uU5NzIPKoMXESxQcOoQsbkrT/M6rdrqmjbcbQCbiGmrydd67TgnVo/h06QvKA8WyYXjv7BZzBWVFh6fj4A6dMOXZ3+RKyu4qrx5FLBCRHAVWdw7goCSoyP48cbF69kIRK2vjnaiMBsKrwM8Gt0z9S//iyLELjbB9s/1bKvQKtAu5Bm/TPFJZXTQZ1v/QUeHYlzzvvyb9BwytUhmFp7b9xpxHhXFeoqGf9oykoTO6GEkKmPkwYWLlGlACRQtX3tqBgHB+EsSaB/BxHKw00MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCBgZWiGLLBbVChz3uoCB1uMqCvI7H+CGLTza+adiw4=;
 b=N+lPuJzrVHA0gdXPjiQr6Xe0lSZmeKrJxn3mQlZUeBh8G8sFMZn0ga/qUQ93mqZU1ZYRXSxwDJoVuOUO8xZSADPU726gSCrJc9Kf9XMSw/m8Ozt8FRjgn07wk3Jb4BtWyUtfhtEuF/8eLLse5QkMnHdxAKuE3Bz5JYlWx9FdnjUL33Fc/BphiWC0hE7zEQCSWSEW1OWaYWRIPu0Fj07DRuOYmRUiwbaeLPVZZjVGaqRl7ocN1+gMt0OnhFQFFrCya8ccxk4KfTo1K4chIybHIgFWKQO7aOBi9s4yqm2Nt8YpSzRStjTaDwJEQzAKRZ0LaCtXfkypRkWiPqLi8jIipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCBgZWiGLLBbVChz3uoCB1uMqCvI7H+CGLTza+adiw4=;
 b=YybmNP3cdGHXLZ/W12AUb8+VLnO0lgB5t/fENE0wO5eTfKTE78zdzsz88MLlLqcCBHOzeFc1Oa2qxw5I2DqEMeMX6FHhZeu+VZ/qcrothu09NcY6i5o2UDXB3cqXphRJFfzRcdMcKoe/DgdP20zecLthYTKCXa12PK+Kb50cNrQidWm03nRFjWfpI0TkcdDps/papEzU28WSVRE5hBZ/PU2Irk+MYE88Ws9esmN3RJHkUmbeSDZz1rmMHJpBh6mbNKuo21ssIfxaOL/a7z8sCsS3CFUNleoQ0J6ogu3xWqSJfAjknSO7aP5prJJ9ucNy6QsLxbiHpcFO5o2F8MjunA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5909.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:29:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:29:43 +0000
Message-ID: <616ee39a-6f60-4b85-b15c-ba36eaab3bf1@siemens.com>
Date: Thu, 22 Jan 2026 11:29:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v5 4/4] doc/README.swupdate.md: Add section
 for software update with wfx
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 akunuri.sahithi@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
 michael.adler@siemens.com
References: <20260116120347.1733494-1-Adithya.Balakumar@toshiba-tsip.com>
 <20260116120347.1733494-5-Adithya.Balakumar@toshiba-tsip.com>
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
In-Reply-To: <20260116120347.1733494-5-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0039.eurprd03.prod.outlook.com
 (2603:10a6:803:118::28) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a2479f-4d6d-4bc7-db22-08de59a127f0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?azgyeC82Qm42MjhabVRPcTcydG9taTlOYTZTNHoySjBYR3VQMXhMWnFoZHBO?=
 =?utf-8?B?dTgwekRRV045T0dKekNjV3JBUXQ2SXpqMTBmc1pURkxleVA2aklweUh2bFlY?=
 =?utf-8?B?eFFSejgvdkVkejN1b0Z1ZUthOE1Rd214b3Q5a09qLzBuZVZRRG1ZRk1Fa1FR?=
 =?utf-8?B?L01oRnhrTERHVm9WS2hIUUtkMkpQWkdNc21UajYrRms4YXZGWFhiamFMU0g3?=
 =?utf-8?B?dndYc2VPSkVkd1ZlYkpUNGJpZlZEYmUrdWxRWkE4TkVYa0YzRFdqSHFXYmk2?=
 =?utf-8?B?USsxWDg3QlFqRm8rcThFVi91NHNEVE8veVBjNlZvV2duTllJNU5pbkNoYTBP?=
 =?utf-8?B?TTlDemZOalhuZXZxdUJiam1YRnlhNC9WcHJXaWRvam1xbEpBU2hWNEpjTHhk?=
 =?utf-8?B?bzRwcm9HRWx5Tk93bmlkdVNuTDR1cXlJdUdremVHbmFmM05LeVlGdDYyYjk5?=
 =?utf-8?B?V1U2aFR3Slp5RDNKTWhHUDhMTHdaRGhjY05lVFErdmVJZmpKdjFSd2FmQ21J?=
 =?utf-8?B?cU1lR3JySXViRVBQQzB0UmNNWmpOY3FLWEt3UHo3NFhqdU04enVXV1RGVWlm?=
 =?utf-8?B?S2pkbXRHVGNWVkQ1UVVFNjlXclFiSHErZjd3WEVNekhPdnZzazFZdW9weDRi?=
 =?utf-8?B?bEwzVFE5UERwdURqUVhRWmZUVUpUOEdqR1lvUzcrVno3V0ppWGIvQTFwV1c3?=
 =?utf-8?B?bUNTVkRzOXk1OXRNdHcxN2hKVEEzZnF3cGhSVXRla0JIM1F0K0h1MlQ1VEoz?=
 =?utf-8?B?aEp1VjYvNUpWME5nSjhwc3NjZ1V1UGRmTWM3Y2JGY0Ztb0hjUU9QbWEwYWs4?=
 =?utf-8?B?NTFtdExISE9aMm5sM0xNSktlaytucHpDUEFaODUzWFpKdDRYVTQ3enJXZEVj?=
 =?utf-8?B?WkcrL1FYTUtVemJ3bXFraldRUmRQTzI3Y2NXb0x4WlZ4dW1RZWFGdWFaRURK?=
 =?utf-8?B?L3FLSGc2QWhhUVpOZHdBVEJIckV0RTZlMTA1OVlDdlVuMyt4a0FUcFJFcWM0?=
 =?utf-8?B?bVVjb09PMTdKY2svZURJN2J6ckxhOTc3TnR0b284dXorTTlLVUpoTWhrVzRu?=
 =?utf-8?B?OHE2dkdWSTRIMHNmVVZNNFJtd0J4LytKUVBTV055bFhFUndaUnQ5eG1RUWZF?=
 =?utf-8?B?MWN5M0NNQTV6dEhzcFpFRTUycGJHdDc5L1k5RkQ5eFFxbHovRC9TcWIzeW8v?=
 =?utf-8?B?dUNzb202RzdLVk9kSW5vUG1BaUxNcEV1WUxRekxnTGozOTIvQm9KMEQxUXRq?=
 =?utf-8?B?Z0xlMU1SZ1FyYWhHQ01DQklaOTB5b1RDYk9DRmRWcE8zL1hCYjdNWGswa0s0?=
 =?utf-8?B?b2diYkpFSVQzWWFCa3hQS013RklSdEpyUGdLZ1RJSFM2amFXcVZUbVVOUy95?=
 =?utf-8?B?WEwrdzJXTGR5Rkx0M3oyRUhpcGM0bmxQK2szS3Vicm1ZZFZkYXE5Ri9KeGlw?=
 =?utf-8?B?ckkvenhtWHZURzIzRVFFb29yMGN0MjJoOGtIZndLNVNHTVRjSFRaSmRvbmYy?=
 =?utf-8?B?a3BTWFk2U3BDYzdYQUNXeCtubVRBQzBJQitZamxPVEk3cUo2NTA2Z0RyOWVT?=
 =?utf-8?B?TnV6U0xqeEVjdjMrNHVMK200alhlYlBJRjd4YmJIVElBNzRUWU4vUTVvaVVu?=
 =?utf-8?B?OHRUZkRqS2tzVDdsekp0TDVQMktabThQRjNwMGFJRjVBNlhDYjZDNGozaHJt?=
 =?utf-8?B?aDJxbHZuZUMwUlJLQmxsWExYZExCbCs3RHR1Q0h5M0x2b1poNll4RDIybU1i?=
 =?utf-8?B?d2cyWjUwTTNmMWVPcG93QTI3Tk02UGJNOFVicy9Kc3ZRdGE5empFZE5zY3hY?=
 =?utf-8?B?aVBNMGEycWtsRGFTNmpoQWhNQjVRVUx3ZkRmSkdyUThhc0NQM2plN3M1bVo0?=
 =?utf-8?B?Um42Z09mSHhTc0ZjVG4zR2hCYTRjTExRQ2pFR3ZUSUtUNVo4MTgyNy91UkVO?=
 =?utf-8?B?QmpZR29sSFFXOVpxTDZjTGphaFZzYURxYmoyWGVVY3pKNUY2TkRqTTd6aEJF?=
 =?utf-8?B?cjVVOW9nMzY2QkJmdGVoY1pDNDNSZXpMcHpoS1FlQUlRMVFNRGhZeFRSYnBp?=
 =?utf-8?Q?iJn+DT?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZDhTeit2K1dJRCtRMDVqeTRLalhsbThXVXRQQ1BPcVUrcFQwOStGVGQwa3BZ?=
 =?utf-8?B?VWJlNU5TRFRNUlhLU2FlUWlCUmI5ZWhmRGYrYkRYUUhobnUyRW1oODYwZUhP?=
 =?utf-8?B?Q0xNcURTbGszcUZHNXExUTNOcWh4a2hUUXJZaytnMmd6anBxUWNIaTRwa3Nt?=
 =?utf-8?B?aGNjZWEwYXUyRUxmQ09MMlNycEJjZUp5OC85aGYwV0ZzVnQvOFBjOXYyVklX?=
 =?utf-8?B?RUhIcUQ0aitabjdvWnljbVhCRGdXUHF2TVMvaUkwa0tGc25hbFVkYkhkcENP?=
 =?utf-8?B?Mm5jN1RReXNrNG9zRUtCQkhBL2Y0SWFZWWtjUjJWRnNGdk9tN3BjWkx1SnNi?=
 =?utf-8?B?eFRJV1NzcXR3bTFOcHFhZ3pnakhCVjNGR1ZWOTVZVnBXeGQ1cXlYSmd6ZG9m?=
 =?utf-8?B?U2lsVUlCL2NXYVpaWjZXZ3hPM1VEeWNRaGpCUURsaWZ2Zk0rVFRqNWxVSDQ0?=
 =?utf-8?B?MDdTdERUZ0t6dGJlZDBLamNHbzZpWFNoUEVlWTJ2ZWFMU3BwWVp4akwwdEp1?=
 =?utf-8?B?OWtVR0k0eXF4WkhaVmRKVHhUZDlTcHZCSUJsNUU4Z1VqQW41bHdWcVlVNlRl?=
 =?utf-8?B?ZGZqbGZ3VjRiNisxOE9CMzdTdzA2VGhWQjNML3QyOWw0NjFJVmJXOTlsR3Y4?=
 =?utf-8?B?VnZTdnM2NUdNeVorcWdnZ0xsd3JiK3Z1S3JJMGxhNWkzeEt5bnJTSG5Ucnow?=
 =?utf-8?B?b2lrV0tsUFYybnhiR3h0YitTeUY4U0hKZVVKdVE5OEZobmIwSDVvR3AwcU1u?=
 =?utf-8?B?WlZlNFhsaTJ5YzB6OWdMWjdzU04wbC9peFFTL2pFdnhtTU8xamVqZEFvTWJQ?=
 =?utf-8?B?V0tXRDBabVVBVmRrdzFhb3VYMmEyRGplencwTlo2L2s2Wm1GeC9paFV5cHRU?=
 =?utf-8?B?dzdhNzdPUWtGWisyYTFxSm4wbTdGamlCWGMySHhRTDg5ZGtoU1NNanRLWWFv?=
 =?utf-8?B?bmFFbTNOV3E4WUhyOGNudUZBNDZGclpvRmhBd0NkbTJsQWlpUU5BZ1c3TUl3?=
 =?utf-8?B?UndqRXV2QSsrdUh0TmIxT2QybWt3VWpaTVpSVnQ3YksxaUhXdVZFV2M5OUFh?=
 =?utf-8?B?Z1ExN0tPd1lpUmlUenBsdWdtZ0c3dC8vRnBIT0hYNkVUUFJxNUdkSURPcHNT?=
 =?utf-8?B?MkN5Sk9MKzFEMHhiU0RRTDJLRFJzbHlhSVRkUWhCeEVuNlo5TGgzQlNtRTB1?=
 =?utf-8?B?UDdFbTcvODhXRzM2MnZwcnRWZ0NwVjNiTFZxVG4wSHdpMVVxVjloY0Vva0dH?=
 =?utf-8?B?cjI5WHF5Rmo0cGVMSXE5WnJRT2ZxVVY2cE5FWUg4YjVEb0JIckFLZ1k1cFpI?=
 =?utf-8?B?N3k0bkxhdEJFOGRxYU9hSEJJZzl5NGVycEtINXRRaGJLRXJUVitENzU2Q0Ru?=
 =?utf-8?B?eHpvNlpkVzlLckE5RnczY0t4aUs5UzFHRjYzY05aNWVQdERBNW9NTEo1M0Jl?=
 =?utf-8?B?cXVsT1ZnYUg5WjRyOUpGdy9JUEFTZDY5emlyZGh3OGYzWjdHM2xPVHI2UGI1?=
 =?utf-8?B?TXFsWlFGb3hoSGZEeTgvUUNBRk9KSllia3JnQlYzbkhNTzFSRzF5K1A4U0ND?=
 =?utf-8?B?T0tMRzJuVU9zNW5Idmd4V3NUbzlGcytBb29OdHFKNGVmS3dkWk1VRXV6R3Uy?=
 =?utf-8?B?a3E2N25RN3VWU3B2ZzJhNUMwOHl3eDhBdWFUeDFkVkJQektSN2g3K28rTmNJ?=
 =?utf-8?B?aXZjdkg1a1p6cEtyRmtWVUczYnpkYUsvSG4rL0l4Q1M4akNNUW1QdExTK0po?=
 =?utf-8?B?WEgvYS9wSzd5K1l4WFVEMzZJT3pIc1JscUZ6MDlvcjVxL3hpbCt1SHRIaENM?=
 =?utf-8?B?NTF6ZVV4aEpWS0I1VVRkUDBNaVpzeTdNaVV5TGExSmtnR1VrbHczMDlIdjQx?=
 =?utf-8?B?WmcvRkVqY1g5dUtkTmkxdzQ4WC85dWpYVVFIYmphVzZ4UlpvekcvVzJOQWtL?=
 =?utf-8?B?dnhXWHY0Z29TcGIweW5LL2QvQ2lXWjZOMHVHeVRmeEhxakROWVRFQm9Hby8y?=
 =?utf-8?B?ZTRETG8xVk5Lek9pZUFsQ1lEQjI3RHdBdzBHcGtzMFVLbm1yWGdIZHJGdTUw?=
 =?utf-8?B?bG1Oc3lod1hEd1VoNHBGcU04QWJYZTlnMjZMUEhkL2RlWHBxYmZMWkRXRXdr?=
 =?utf-8?B?RnVLNEhZRUEvUmo2RTV5N1BHR2cvMFd6OFdhL1V1NXdWRFdyU1dmTVRaQXRD?=
 =?utf-8?B?WjBCdXB5clI4UFRsdlZxb2xNQWFnYXVpN1h2U29DdzdnSG80dlp3QVhwWDNP?=
 =?utf-8?B?ckpBdGp3bG9HTEVVZkx3VXNuVHppZ3dWU1M5RTY3SFhTZ0UzN0ZuNHlDR2N5?=
 =?utf-8?B?WEFocWsxem9majdHT1UwSnZzZGdyQi80enkwUzh1dHlMbmMzRG9EQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a2479f-4d6d-4bc7-db22-08de59a127f0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:29:42.9464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bY2E739kP9F5GbNZdgW2yZE6kBu4phaF6WJQ5vqZQFcs5MXH509F0HAFMFl/Ru2ZWJT6Uk7AUcRSpSs6iOp8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5909
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jan 2026 10:29:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21698

On 16.01.26 13:03, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  doc/README.swupdate.md | 113 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 113 insertions(+)
> 
> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
> index b68b5b7..8b756cd 100644
> --- a/doc/README.swupdate.md
> +++ b/doc/README.swupdate.md
> @@ -464,6 +464,119 @@ Any http server (service) can be used to host the .zck file as long as the http
>  
>  Follow the steps mentioned in the section [SWUpdate verification](#swupdate-verification) for verification.
>  
> +# Software update with wfx
> +
> +**NOTE**: In the following sections, `WFX_HOST` refers to the IP address or DNS-resolvable name of your `wfx` server. Please substitute `WFX_HOST` with the appropriate value wherever it appears.
> +
> +Set the `WFX_URL` to `http://WFX_HOST:8080/api/wfx/v1` via the `Kconfig` menu.
> +
> +Install `wfxctl` and `wfx` in the host:
> +The instructions below assume that `wfxctl` and `wfx` are running on a `x86-64` host. Binaries for other architectures are also available for [download](https://github.com/siemens/wfx/releases).
> +```
> +## Install wfxctl
> +host$ curl -LO https://github.com/siemens/wfx/releases/download/v0.4.1/wfxctl_0.4.1_linux_x86_64.deb
> +host$ dpkg -i wfxctl_0.4.1_linux-x86_64.deb
> +
> +## Install wfx
> +host$ curl -LO https://github.com/siemens/wfx/releases/download/v0.4.1/wfx_0.4.1_linux_x86_64.deb
> +host$ dpkg -i wfx_0.4.1_linux-x86_64.deb
> +```
> +
> +

Only one blank line needed here.

> +Build an image which will later serve as update package:
> +```
> +host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/trixie.yml
> +```
> +

Wait - how will that image get the WFX_URL? This can only be achieved
via menu-based configuration and build.

> +Save the generated swu build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-trixie-qemu-amd64.swu into a separate folder
> +
> +```
> +host$ mkdir -p /tmp/artifacts
> +host$ cp build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-trixie-qemu-amd64.swu /tmp/artifacts
> +```
> +
> +Next, rebuild the image, switching to the RT kernel as modification:
> +```
> +host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/rt.yml:kas/opt/trixie.yml
> +```
> +
> +Now start the image which will contain the RT kernel:
> +```
> +host$ SWUPDATE_BOOT=y ./start-qemu.sh amd64
> +```
> +
> +Check the machine-id in `/etc/machine-id`. SWUpdate is launched with this `id` as the `client-id` and is later used to create `wfx` job for the client:
> +```
> +root@demo cat /etc/machine-id
> +049adc79659044f8887c83b3203c84f1
> +```
> +
> +Start `wfx` server in the host:
> +```
> +host$ wfx --simple-fileserver /tmp/artifacts
> +```
> +Alternatively, `wfx` can also be run as a [docker container](https://github.com/siemens/wfx/blob/a6ecb60bb47eaf1f95a2b65b4190538a246d79d1/docs/installation.md#build-and-installation).
> +
> +Create `wfx.workflow.dau.direct` wofkflow:
> +```
> +host$ curl -L https://raw.githubusercontent.com/siemens/wfx/refs/heads/main/workflow/dau/wfx.workflow.dau.direct.yml | wfxctl workflow create -
> +```
> +
> +Create a wfx job that updates the device. Set `client-id` with the `id` from `/etc/machine-id` in qemu:
> +```
> +host$ cat <<EOF | envsubst | wfxctl job create --client-id '049adc79659044f8887c83b3203c84f1' --workflow wfx.workflow.dau.direct -
> +{
> +  "version": "1.0",
> +  "type": ["firmware"],
> +  "artifacts": [
> +    {
> +      "name": "Example Device Firmware Artifact",
> +      "version": "1.1",
> +      "uri": "http://${WFX_HOST}:8080/download/cip-core-image-cip-core-trixie-qemu-amd64.swu"
> +    }
> +  ]
> +}
> +EOF
> +```
> +
> +Wait for the next swupdate polling round (every 20 seconds) to see how swupdate downloads and applies the update.
> +```
> +root@demo journalctl -u swupdate -f
> +
> +// truncated output
> +swupdate.sh[432]: [TRACE] : SWUPDATE running :  [start_suricatta] : Suricatta awakened.
> +swupdate.sh[432]: [DEBUG] : SWUPDATE running :  [notify_helper] : Suricatta querying "http://WFX_HOST:8080/api/wfx/v1/jobs?clientId=049adc79659044f8887c83b3203c84f1&group=OPEN"
> +```
> +
> +Once the update is successfully installed, the device automatically reboots. After reboot, suricatta automatically updates the bootloader state.
> +```
> +root@demo bg_printenv
> +
> +----------------------------
> + Config Partition #0 Values:
> +in_progress:      no
> +revision:         2
> +kernel:           C:BOOT0:linux.efi
> +kernelargs:
> +watchdog timeout: 120 seconds
> +ustate:           0 (OK)
> +
> +user variables:
> +
> +
> +
> +----------------------------
> + Config Partition #1 Values:
> +in_progress:      no
> +revision:         3
> +kernel:           C:BOOT1:linux.efi
> +kernelargs:
> +watchdog timeout: 120 seconds
> +ustate:           0 (OK)
> +
> +user variables:
> +```
> +
>  # Building and testing the CIP Core image for BBB
>  
>  Follow the steps mentioned in the section [Building and testing the CIP Core image](README.swupdate.md#building-and-testing-the-cip-core-image) for creating images and .swu files.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0ACC021A4
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 12:30:39 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.65])
 by mx.groups.io with SMTP id smtpd.web10.20022.1739536235416880190
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Feb 2025 04:30:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kaGjGRtF;
 spf=pass (domain: siemens.com, ip: 52.101.66.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMGsUXo04xU5Oa51aNbXt9IJtVOj+R66Zxr81OTak5jCN4VVOBMhBwDymExZXDewQBq7z+lIaxR+SenXudpbdqD11BnWak1UNqhX+bGJRppmSSMchYDWQetSUnrv6295kIW2agql9nimyyX1ODJRyMQ6KwWVVX3fcAwacz20/AX8uQeNvvnYZs20JHHMQm2PedfDg+jCrBTzAIsG6CvHqnHnlp6hawYTAPZ4iBbXfW2lM7uh15pcXOkG7pf4Hy8GIOrsj79/u1wndV8CXwCARxEssaYb9Kk3l9tXkbMmjEKceH6erOnWwsdP1V8Qbl30E3vdZTJu3xJel1744kcXzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gH4CxNUVTRX8JhBkgCTy47F+gj/tBOOjJQ4Re7hJn5k=;
 b=fXqMQTSP/mqroUThUBoOPFK5iorqgpqSaHslern1xOQPtbatgc27mMGNvrWvNLkxVvFcN5dDAR2+hwRlM4/pjggUOi7RTbOzVLzm0rvOOnFnBpnceoStITmLTGnXbKudjHIhp3PodAjILZiueEV7WEHgHJvIFWNvTrmKL2nTUOSd5gmdavUhPvOwFj47vx7be9/Fbiw7rEvSL+0RPmri+90LmGRK8BXPGCAbLX3R1tiA/MWjrmC3/wuMnVfYfvMVD/zih2j6pBaHH73AxTKuvCUa+GSXU+HZA7gmt2qj3OM7XQAkj/fP7/cYF8Yp7IVXOlfCfNtDwLauOLps2Zc4sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gH4CxNUVTRX8JhBkgCTy47F+gj/tBOOjJQ4Re7hJn5k=;
 b=kaGjGRtFWKl0BCfrOzCwsJFL8ZOZvZnoUj9RvjE/F/BFqlTlQ7qJUoPIEjKc4I1iWgvxk0LifLWJ/LJTP69qkyvcRf6n5YMo32UxyM721mvNsqsd07ByHNVEiVCdIMm7KSOTuC7XuqA41hBAinvbXa1ICr6hlKHwVS/xIO110kC5AVGemw5KK/E7HEGvR171ky+WBBpg3N1PS1D937EMgpvm7vdFczpGnlSyIzeHWcFCc82K37N2iwwGFam16ejWAbJ6i9AH0fWy/j9uvI/GQ+Nywd+o7A0dNXnP1SDpz+x6fJBsah4GmXAi9WqgUSnD0pAuulnvTzZwybMnG3u0Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3814.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.8; Fri, 14 Feb
 2025 12:30:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 12:30:30 +0000
Message-ID: <e01b7d05-1be3-4189-a8d2-2efbc2733bf9@siemens.com>
Date: Fri, 14 Feb 2025 13:30:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC 1/2] wic(ebg): add support to add verity env
 to cmdline
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20250214122329.2766449-1-felix.moessbauer@siemens.com>
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
In-Reply-To: <20250214122329.2766449-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3814:EE_
X-MS-Office365-Filtering-Correlation-Id: 4100864a-574e-4df3-ddbe-08dd4cf35ea8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Mlp4a1lVNmZuQkExRUUxcDVKVVZRR0xkQWZuRUpCRXFITmZyQWhlcWdoUHRs?=
 =?utf-8?B?WFd2ZWpqQW5KVnpMZS9MMkdMVzdySFNJQUVVRFlVK1NFZTRNMkZlbnFhVFVV?=
 =?utf-8?B?WlUrQy80U3J4SVo1TEFYbmJpdmhXSk1Relg2M0dObWxWd3ZOZjBNOWhraUMz?=
 =?utf-8?B?aUVwVEFHL29ES1pvWHFwZWZaRXlERFY3YVkvSmV0ZXpyc1pvdGFqK1Vqc2lp?=
 =?utf-8?B?b0RLV2RYUU9SOXNxY05TSGltT3g0Ty9NaXhXZC84Lzh2SmIvbnAwczNMRWdW?=
 =?utf-8?B?WkVETzMxRGp6VlpiT09IODZpWTRHNkR6NU9xM0hZcGFRMlZ6TnlnaGpmbEh3?=
 =?utf-8?B?NGIrUk9RVG0xejJvNVYveTNZOWxqSkc3RS8wUUgxWDF2TTBiOEkzVnQxTlBE?=
 =?utf-8?B?cTI4S25lL3pwbEU3RzZYeW5BWmszTzV0Um96aVA2bWFPVS90Mi84RzJYSmJC?=
 =?utf-8?B?THFWWW8vcXFKWVVwS2pTTVp5VjhNNXJpSUpLcituSjVqTlBuc0VNcEdKWU5M?=
 =?utf-8?B?eW12UkFyZ0tMQlE3SS9SQm83ZE05OVpVZFpiNHdlS0UwZ0UyajlWQi9qbWlZ?=
 =?utf-8?B?WlRBMlhrdWJSNk9CTWsxZ25ETlY0RUhHZXNZWXRZaVlTSkM0cGtvV0VPQlR6?=
 =?utf-8?B?TW9BbHFNa0lzSjRycEhpS2VKNXEwWTM4dmFEV3ZKaVZMb01qQlV3MFhiTDA2?=
 =?utf-8?B?TzVaa2lzK1J3NzM3Z0t6YkJvYlI1TCtGWWNBNUhoSHQ4SEdoanZPdjZNU21n?=
 =?utf-8?B?ekVkaUd6YkFxRnVObllWTk9zN2xoYnlUdkMwL3ZFdURkek5sMXVsaWg2cmdh?=
 =?utf-8?B?RmlQb1Ard0l4YWc5NGtreUtudkdRMkFpWUtNMkhUcVozN1dlRnJnR1FGaVJv?=
 =?utf-8?B?T25iNzA4T3dFd1E3QUNLeUNpSFE4S0xEancyOHZFbHhpck5HVk1nV2YvL0hT?=
 =?utf-8?B?TGduVmM0TS9qRDJHdnNSVStYOVk5TGZZbEtmQ1MzWVRmQjYyVXN6ekc1Wmkz?=
 =?utf-8?B?WUhWUDVpTi9zUHVJRW5pT1E4T3NZT3dwMzBSd25OcCt0QzRsSFlIMjdyeXll?=
 =?utf-8?B?dzJHSVZQODhpSGVleWhpQTVrV0hNSmEzdUxlNWQ1RFRKeGQvWkg4MG5wODBz?=
 =?utf-8?B?ZmxNb2o1UlJQS2dEazBRRDIrdzRIV1Y2eUhNR25zNlpWMXJhaE0zNGp4T1NW?=
 =?utf-8?B?aDFLLzRLenlkU3ZhSzFvUk9pLzBQc2VFaDNZL0tDbC9oOVNRWGxtZ0srU0U2?=
 =?utf-8?B?MzczbSs0cjNNRXkraFgxS0FJSStvTzFoaW9wcWZyVGs5WDNYNnZBV2hmWGRB?=
 =?utf-8?B?dVRJQlN3VGlrQWkrZnNtejNVVko1T1A1YlJTMWVnaDlTVDdvVU40b01KMitQ?=
 =?utf-8?B?QVZLWllGVTQzZGFFUU03K0FPaVRldGR3ZzhhaTVpRXJLcjE2bGVFLzJ1UEdl?=
 =?utf-8?B?T3VpVyt5R3M1cm9UaEVjVmlIVnZ0cVVGVENlQzFIeGtTK3ZkcGVFNnZjWDF1?=
 =?utf-8?B?OXN5Q3lBVmc1SmZMMUtHZ1NyTmxCb1ZvUnljcmgrc1dVMlJucUlBLzh3ZXg2?=
 =?utf-8?B?TWpodS9pU3N2L09zTVFOYmlqSmNVRjFydUxmNEZWRFFpNlNEczBzcjE1U0xy?=
 =?utf-8?B?cm54SXY2YWxtYlZrUXl3NzludGRiMitKUkVsd2cvZ0ptUVQ2Sk1UaUxoUE5C?=
 =?utf-8?B?dEtqRVpVdVozSlh2SXZ0djlEV3N2dEY2TUp2YURwOFFPUjNjMzRLUzRXTExl?=
 =?utf-8?B?NWUvM0NxRG1CTjgxT2diK0Fza3NQNHVyWlB0MUgzcDAwV0I0eW1Mc2tJOEVI?=
 =?utf-8?B?NW92WkdvN0N1SUJHY01zVEx2WEdCTE1JUFk5R3AyZVZRd2FmU3pZVk9IRm43?=
 =?utf-8?Q?crEE5P8VJEJ4Z?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T09YdXRKUzluUm5ucFhBYmtOZDZvZGJjbHVxaU42Sy9RdUhOSTkyS3ppUlp0?=
 =?utf-8?B?NUsxSDBUYzg3OGdldm5uakQvOWxSVXFKZGd3bERBV1ZidnhnS3VBRURrOWU0?=
 =?utf-8?B?SmpUSW14OU16b2hLUmluYTNvZkF6UFF0OU53ZXBaUlJFNlczTndUQ1U2ZzZ6?=
 =?utf-8?B?MXpoTjNLN3Zhb2VOZlU5M3hiOHhxeUVoWFg2amdBZnhOMzJXV3N6TVk2OWpn?=
 =?utf-8?B?MFlQMmxpMzkzYVZ4MFM0UDVGbXFxR1hJelNpTElOZTA4ZTdlUlFHUVNQNGJZ?=
 =?utf-8?B?SEJVdFBKbWJsTklNTDBRS1lhaXIyTVE3eVZhNHAwZGRMNHBxdUN1SW5DZmt6?=
 =?utf-8?B?M3h4OTA4NnNkdExOZmQ1TzNQd2kxL0FQbkkrUkpyTmF5TStlZnkxbnJpZXF1?=
 =?utf-8?B?OVRNSkp4aUZtU0kvbHNCUWo4OXU3ekNRQ3JobytoZlhjN2FtZm5MNUZLUkhr?=
 =?utf-8?B?emNBRURhMXAySytubFdwK2puRm9kNVdUQm13ZWF1dzEyZXo5emtpUE9jK05t?=
 =?utf-8?B?WGdjK09HZHA2Z1RVenFUSXFOejVreEpuZzhjTFdPYkpvejFxMmVTajQ5Ymgx?=
 =?utf-8?B?NE1YMlE5ektaUVRxcTc4emVLL3lrVkdJTjJDUkFxRVExNHRhd3ptVVdTMjRJ?=
 =?utf-8?B?czJLdGtOM20yZkFONDhyUkk5MkdXUEhVbXBtd0hsUnVPbzZWVGpDTzZJdi93?=
 =?utf-8?B?VHBkYm5PT2xzKzViWHlLNVowZ0d5Wm1HQ3J1WUNnUEZta1RFY1BjbWJQWDcw?=
 =?utf-8?B?bkRSWnZyY0x6Q3Bzd1dJbGo3MS93RSs5NHlHSHhmYVZWWEEzVDJEVjhGMEV1?=
 =?utf-8?B?U0FKVmwrYTU5THRsY1lwcllic2UyeGwrbzNITmthSUg1Ums0VUI3SEw1Z09G?=
 =?utf-8?B?Z0pmN213ZmxYL3h5d3c5Z1g0czdJZ0xUWEw0TWhzeHl5TGU3ZVNCemM3Q2NE?=
 =?utf-8?B?NmVELytoYzVHeUJ4aGI1SW5mWTF1K21oaVZZZUZWT2w2Vkt0bkdQV1F2eWk5?=
 =?utf-8?B?K0ZrcnYwNGRsZ2JGTWYyQW01V3NzSWQwNUp3L2NJSHRoZzlyNDZ2M0lXNWlx?=
 =?utf-8?B?ZWQ5YTB2YTNhaFVJWjRTemlSV1pRR1grYzNwaW5majBITWk0b0EyaUZ6U0Yv?=
 =?utf-8?B?MVUvYnNPbVN0V1MyNkxFY1VyaTBFNFkxVnJTamdPWEJYNjFtZCtnTDN0Qita?=
 =?utf-8?B?aTVhYW1UV0hnSGNjUVJlOWpxYUdOeFZhdE9HMVBNcVV1TlIxYUc3RW5uMWVy?=
 =?utf-8?B?L0VwZ0xqWnNqUXU3Q0phcDlTMWpJT29HckowNkNoMUhtY3ZrVW83RU5XUXpo?=
 =?utf-8?B?eTBxdDVCb3haV2tEQ01KdTMyNDM2bUVQM0diRk5BdFRDVkRBYjFRUS80endJ?=
 =?utf-8?B?VUduOGFicE41amtkN09DY09HK2ZMbUk1UTdoUkU0THV6K1VsUThlNnY5VjdS?=
 =?utf-8?B?N1lZdVhiRjFWaVF1ZUV4V2o3R2RXb0pDZmVjM1R3S0xZdGpqRTFwRXo0d0du?=
 =?utf-8?B?R1hNVWprY1AwVU5WNEpFSnBNNitmaDROSVl2NWNjbU9rUUxCZU5EWE9sT0pm?=
 =?utf-8?B?N25yeFo4Q3FpRW9idU1SeEZsL3hiaFBDL2pwV2N3dThNSnVhK2RCV1dveStv?=
 =?utf-8?B?U1JYcFdmbnNhR1U5SUZSZTVkaVJNWkFtaHY0T2ttanNzLzFNUFhQTFMvVjdN?=
 =?utf-8?B?bmlBZm5zSzBnVVFNRUZjNnZTWDQ4MkNSakczZ2YzRTRVdXFHU3ZvUlBGMUlR?=
 =?utf-8?B?alhLQ0xaVU5HUVBKNDlQeDkwME51bzQ4cjBLc09NU1ljOXhlSHU1cy9rV1hK?=
 =?utf-8?B?aWdRR2NuMTBKd2NxTVRxQVlEWVFyZytRTkR6bEMva2xtbDdLbUtERjM0QUFk?=
 =?utf-8?B?K3I1bERRWUlIUVpmbnhhRjRnYTBYOU1raXRxVjdGYnB6Wll2enVLdWk2ZUx5?=
 =?utf-8?B?NU03MnBkUVZIV1Btc1VTTURFSHdFU010ZDgxK0dSaTFxbmducGFQbU1uU3Uv?=
 =?utf-8?B?NTlRVG55eTl6NjVMM0IzY2JPOHQrOGdRWTIrZ0F4OC9iSncydFdHLzhvRFM2?=
 =?utf-8?B?T0dVTVd2Q05MQWNqQjRraFdWbE5VdW14a2xlVHNqWkM4Q1ZxQ3hVN1MzSUlZ?=
 =?utf-8?B?SE5ZdjRxdDhGVWpPUUg3YWkrRW5jTTZHdjMvSFZxdW00VGtQbjNQcm9DRWRq?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4100864a-574e-4df3-ddbe-08dd4cf35ea8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 12:30:30.6755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbtuPZ9KZhSkJ2wRSuduQzfU1eC8jXAG62VHMfq1f4CZHl0mvb1TW9nI7pYdGNii6uNFkBlr/nrVJWgSJsNaDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3814
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Feb 2025 12:30:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17842

On 14.02.25 13:23, Felix Moessbauer wrote:
> Passing the verity data via the initrd has proven problematic, as this
> requires to rebuild the initrd on each (bitwise) change of the verity
> container. For use cases with not bit-by-bit reproducible rootfs this
> can lead to verity hash inconsistencies as the bitbake state diverges
> from the file state in case some task artifacts are taken from the
> SState cache. Further, the build time is prolonged as on every rootfs
> change also the initfs needs to be rebuild (also polluting the SState
> cache with not-reusable entries).

Then let's fix the reproducibility issues. This change here destroys a
pattern we are also using for abrootfs. I'm not a fan of doing things
differently only for verify.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E132E6C608
	for <webhook@archiver.kernel.org>; Tue,  3 Dec 2024 05:31:12 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.66])
 by mx.groups.io with SMTP id smtpd.web10.12695.1733203859815405948
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Dec 2024 21:31:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=PKo+CvTK;
 spf=pass (domain: siemens.com, ip: 40.107.241.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4xUgchthsgHmXizhqcknNQ131iGMdoCh5FXPIxAEN5ML+eZadUoY8XMJWj0Tum6tGs+13uIV2HN2Rl0yfbDuZiwSn/jPH4GeHWTn5cxoza7WYokUXm2WDpd55EHNLdMkW2WqunJKrXg2lQmIEuUwO7zdO5VFkeW3Gon8NryA/QtN8g6rzX6Jyu3PAU3cpm8lyowqRPvAIUD/+6lIttPzh7gvsdhM0/rXIfZQ7c3dZW8epzFbvrSgUZbjnBOJ2ypkP+TAa4L/Si17Z222RDcnZ7XcIUJLsnAzCl3rwbJZqSrx9NQhE9XFkqUs2a37olgJQOvUSPBpMSrjaUHTnJCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gR8HUERRAVmMqoyUbuQFVqK8mgm5TKiQfo/n+J6jD2o=;
 b=NVgHlnCI+ASwHiHBwtEqk6n7DANxfNgBOMWBB8o+vk2i4KpI7EwVfau00wVYiErIS6XA0OM4sLOakIKEyyA2xoc/mEyDt8r9PA0QN0NK7Nj1lylu0SlEeXkJJTAveUIs5Tjgsbap6m8Ls8eAino3exnzBJdURWUBj8LfTYTw/jWtj6f4spKe1yImFLHAvaFQDU2Hs9nNgK2ByiDydO71ALJLYo6mQ3EQjKk02fsEVRnjXGtHhWteji2k7gJOJZd7sON0kDnB/OGMHLPaHfnGvad2Lh8zSrTNU8WJuwkfcGEohEUWs/zcA0so5qaQJhWg8vmHtuOWpblyeoGM9ZMadg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gR8HUERRAVmMqoyUbuQFVqK8mgm5TKiQfo/n+J6jD2o=;
 b=PKo+CvTKulGGu1pI9fZHcLQtc6DiEiRoh/B7IeSCbZYKY3X6A5Q/x2aVegqNk9Kr3Gre8fm9X2HhLBfqb4rXvAcjBhljvpdWURd3IvNBe8GcH3c2uSl2lDiBtX01UiDXqiqjFr4dKxXiNyqvP2bpttZVhC8jl5AoHf5xweUVIisQs3y4IEIxSjDAHcc98j67OTn0TSOkYDxst47VeT+5DROX0mzktALOvhQMy/es55Kb6azuZl8vmMEFHENC2uWUum/QsYPP07I7REpNvvd2TzLtbSgxpPXpUHlPKo27Bi2uZ3mOj6ADVyOVM/wa8I/muFK1X4J3jn7ZE6OnjER9Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7072.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:594::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.8; Tue, 3 Dec
 2024 05:30:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8230.007; Tue, 3 Dec 2024
 05:30:56 +0000
Message-ID: <17961d68-ae42-4a3f-a0ed-d5c7507eaea0@siemens.com>
Date: Tue, 3 Dec 2024 06:30:54 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core] Closing for release v1.6
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
X-ClientProxiedBy: AM8P191CA0029.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::34) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 412f15e5-e5c8-4003-428c-08dd135ba95c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Um80VUkrN0ZHSFdEallOak84TEQxSURyUGN6KzJZQjd1Y2V1bTJ2K1hPMG5F?=
 =?utf-8?B?TmhDcXRnMnU2dVh3VURyZHNGYlNjWmtSejgwM0s4NVU2VlduWXUzN3I0bDlY?=
 =?utf-8?B?V3FQTDR0SGsybGlhTjdwc21JREpJUmh4RmFnQm8ycU1VN0Nod2F4eWtGWngz?=
 =?utf-8?B?bHNJa1RNYlljUkU4aXdOcUc0MDlwT29RUldYSVlXeDd1M2YxNEdUdmN3QVpt?=
 =?utf-8?B?cUc3MzZOaFhvM1RBclFCSURjVndWYjVEZGJ5eE5DdWF5bW1mc0FTaTVDZ2Fj?=
 =?utf-8?B?dmVmZmVCaWxzV2g5anFRYU9EK243RGlLMHg0V2FxVEZIbk01Ly92TU9TRXk3?=
 =?utf-8?B?bVV4bTZlU0pNQUFKdmJtVGYxNEk1elo0cS9oSUNPdVBxQ1ZTbm90V0dRZUFI?=
 =?utf-8?B?YnVuWVVsU3Y0SkJ6ZXhuckp5T2doZkV3eVJRdU1PZms2RTROZmZqd1JaRUZa?=
 =?utf-8?B?L003U2VZSlh3WG5NTCtNK2JNdVlWaEd0cmFBNFpqblZNVjh5Zno2b3ZjTUIy?=
 =?utf-8?B?WGhzZUxiUWdoNTY3SEloUXdkaU9nZFprZGpveGNscnR6Y2tXQWc5cEJUdVNE?=
 =?utf-8?B?dDAvTWZRcVlhbkVlSkdqbVc5VDg1T0psK2hMTU5rbkNVK3ExNmRXMUpiNlV0?=
 =?utf-8?B?ZlFHMFJVT0xFQ0pOQ0o0OGdiSGJHVUliYm9IOXF0VHFhZnhtMkJnVzFrcEVh?=
 =?utf-8?B?WU5zbjYvbG5ZeWs4cGZraW9nNG9uZWVKUFF5OHV1UGdaeW12aFUzS2JHMTJ6?=
 =?utf-8?B?QnBzMkxQOEtyeDM2cEFIa2N4eHkwdWRPSWxLUHJqRGh5R3ZKalcwS0FkS0xH?=
 =?utf-8?B?Qm9MeWo0N3VNOXRBeDRuZVA2UVcxK3VFZW55UG1lWmwwMElHdWNtdkdHaHEz?=
 =?utf-8?B?ODFIc2xQQ1ZvVlFTL09WNWNPZ3pHVGI5Z1FGeWRhSHhJYmI1M2xNeG1XVld5?=
 =?utf-8?B?aFZQVVVwVDl0RFM3SE1XbU1oN3BoNnJNaUp0WmFMNGUwVFFsRTlmQ09wYk5W?=
 =?utf-8?B?WE9UK2xhS2c2ZDNzM01sVEpmNVMxUmsxa1ZmalQ5M0RVQ2R3TDdWQkdjWmF2?=
 =?utf-8?B?VHowQmQvNDN0KzAxSysyOVFCR1UvQ3R3aVJmM3dRc0syM2IzUzkvek1Lc3Jy?=
 =?utf-8?B?SmNDVnNsSHR5NmZESytoWTNHZGw3Y2FMcDRvTUROaUtWeU5UUmpBVERONVRn?=
 =?utf-8?B?RnpmWlBEWjloZHJsZE1HN3pvamVGTkpHLytlVTJweDBYbVI1c1FxdyswaFlJ?=
 =?utf-8?B?S3JtMkJVT1JWckJRajEyVmFGaVRvNWloN05hQ1JjV2QvcHAvQ3NYc0FUazhy?=
 =?utf-8?B?WDhDT3BQd3VxemlEMkJrN2NJbDlwNVJSNng3NDlWOGtPUmNUWGdMZVdaK3pj?=
 =?utf-8?B?aDFFTGtiQmJic3RXenNTYmtqaHAwWWRGTzlJSHR0T2drRHlXRkpZRy9GM29j?=
 =?utf-8?B?aFJJZCtDZGZ1U1MrYXgvb2lPV3k3T2JXOUsyV1VyQUxiTkNIYmVFT1pjanR1?=
 =?utf-8?B?cndUcms3d3NLSDhzZ3BWbU1WanVIaWhoTlBtcldxNWh6V21LdXIwU1ZCZmRq?=
 =?utf-8?B?Qm1WdjJKM0h3ZGxtOFNmTWE3Z09DaytQYm8vUGlJV1NTVEZVY0tFeXplcTA5?=
 =?utf-8?B?VWdCTlQ2UU9HVWJRYWdNT3VGYkxJNldBYUZDNTBUUUtrR0dpdVZhQS9VZnh2?=
 =?utf-8?B?ZmdiQXYxdlRSY0JjNTZNTHc4ZGM4UnhjMVJLQXYza1JmSkxGWW1NRXN3SWsz?=
 =?utf-8?B?aHQ5SEQ0eXJuMUlxZ2tlYVpxR1hBVzVDZkNoVEhUOEszbFlySzVIdzJuQUo3?=
 =?utf-8?B?Uk4xdlRoOWtzYVVyRjNyQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UTlKcEYxNGtCQTg5SXdrT05tdVIzd0lLSGhXdURxalhjcUtmb1VWYTd0amFX?=
 =?utf-8?B?bGptY2NPUWYxblZVM0VNWVVzRHcyMVl2dkx0TTlscVIrSTFrVlNGVzNERlhI?=
 =?utf-8?B?RGU3YVp6SEFiUWN6YlIvK0pUYUlGQXV5SjRPSndYajRxdVhFY3dMRnBTSmtV?=
 =?utf-8?B?QytVMWVGVHREcTdPK0E0VzNQUDEzZnpPWktWb0ZIWVpiMldhSmVuMDRMTzFX?=
 =?utf-8?B?ZHIzUVNicDBMbm1SeDlDcEw3czdxSVpzYms5cjNmSytUMUhLanF3SEp0NGFS?=
 =?utf-8?B?NlZ4MnZxeFhlQkIvTFlNUnZ1K3hHYzFZbkVaNTN2TGdCa1Fla09tTDAzVk1B?=
 =?utf-8?B?Q1ZSbHp5bnVoYlM3Q3IrVDJlbkNJKzJwWE45WU9nemVaeUV3YzVvTDVoVXVV?=
 =?utf-8?B?M3ZublNsK0NxZzRTa2VIU0pYMU8wb201Q3o0SFdxMnkvVHdzNTNzVVJRVFlu?=
 =?utf-8?B?TVFPSkpXbExTTVl6elV0VU9OV0NPU3VXamtkSGJOY29sYjJFbzROcmlCN2xZ?=
 =?utf-8?B?SzRjeW9paUtWdFg1dk53QUoxV2l2UC9zMDAyZVJrUzRrbTdjcTNRbVg3VFpB?=
 =?utf-8?B?cGJXR3BJRHhuaFEyWGVBQnlFdWxJNGx0T212WkQrQUdTR28xcXEyc2p1dDg5?=
 =?utf-8?B?eVdGNHFZajlHeVJuUHpRWDl5eGpGdVlRS3VleUlrVWtSOXlOdUVHM0VFRFBp?=
 =?utf-8?B?dm0wTklQaXhnWmx1bFJPdzJyOENvbjdMWkhXRWR0OGR4Ri8xNktjazFGYzEz?=
 =?utf-8?B?M1RXZjExb2NBTVFYRWYvN2h1QWNWSE9LY0RRaWUvaG9QNVZzUiswZENOUW96?=
 =?utf-8?B?UlBvQkVNbzZCcTdlV29HcEpibUdKRVowSFFkSUxUSFMvM1ppRXU2QmlueEYw?=
 =?utf-8?B?S2dMdUprdUhyaDA2bFFVb0I1RE5lbFlXQjY4WFozTGh5Mm1QVnRjMGEzWFhn?=
 =?utf-8?B?bURnTFhGWkpoQjJhY3ZjNGphckxNRlk5am5HR3pXMXdsQllMZFAvN2RweFht?=
 =?utf-8?B?cWhmanRNMzNQS3Q3WTNTN3l6SXJYQzVTN0I4cThmUDh1VUk2MytoQkhaTWVR?=
 =?utf-8?B?OGdPSldxK3JVSitzcVZvemdMWEdBQzFYZjh6bEJBNldVTmxWaHBENkZ0Tzg4?=
 =?utf-8?B?QW1vQnc1VkxlSG1sQ0xhbUFTMWp1SFpVaDdBV1ZIOWtwRnNkRDdtOW5pbllt?=
 =?utf-8?B?aEtJUUVmSUZjN25IWjVrWkgxQyt5by9SQmJHcXloM2ExWGt1VTdtQnozV1N1?=
 =?utf-8?B?MG9Zc3ZFdUMyV0lBWEZ5V1pDSmpyS1JMTmFwK3RteXRoeUVSN2huU0RWZUhr?=
 =?utf-8?B?TmU2dXdmandLVFUyaitzcXN3SnhUNWxNRVVPK1lmbmFrVGNIWlArMWlYT0dE?=
 =?utf-8?B?ZWhYanArUzJHUTlpSXhPL3p1NytjMzZVcEE3QktPb20vM2wrSnN5MzhPMkkv?=
 =?utf-8?B?K0dmTFRUbm5FamZwQmdoVnNSSkhxN0VyMEw1TEpWU2ZWSXF5QXVNYTJVMHB3?=
 =?utf-8?B?b20yM0JMMkdNYVRVL0dTdGtxUFBpcEZVb1lkZVRkUTlEb1NVQW10Rk4yOVgr?=
 =?utf-8?B?bVd3YVhnc3VWVmErRTJnYURocHBRaGx1M0hneDhUdC9ZSW9Odmg5dUpRUHhp?=
 =?utf-8?B?UlR2cmJwYWJ5VjFxL3pwUElob3dBK3h3WjN4cTJPUmZCbjM3YkdzcStHd2U1?=
 =?utf-8?B?QkJ5NUhOQXJ5ZHU5MGphSDZVTUtOS1B2bDFpUERVYW5NLzFzZi84bnBhbFYz?=
 =?utf-8?B?VStaa2YxRzlsaUlQU09nZ0FaMFNPcXdjTHRlU21WcnVxSVdqVVdSZlNRM2hk?=
 =?utf-8?B?STN1UDY5NkNzaTUwNzMrdzcxWW5rR1hxK1VSYmlCMVk1SnpqMVpKeDFrU0hV?=
 =?utf-8?B?Y2w2dGdZSkVsQlFZL3RkNGtQdzV2T1lPSlEvV2VNRk1QRUJtUll2bnZNZnJu?=
 =?utf-8?B?TUFPRW5GcUhCZHhXVjd4cTRwMEIwd2pFSkE1MW83ZmZiRUx0bmFqSVhHd2Zh?=
 =?utf-8?B?d3V5YXZhSVNvbktqemdXQmtNbVhZSUU5b2NYbkZwVkZEbGhndGtub25Mcm1n?=
 =?utf-8?B?S2V3MHVma2xQMXBhREt3UGNEMmNxSkc3WHQzYmtUTHkwd2lpVFVhYjVxNml5?=
 =?utf-8?B?dXNXSFkvQ2hidGJhNnNwYmJ5TE1LY1lETFFIbk0zRE1iNEN2R1dnSjdhcXJ3?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412f15e5-e5c8-4003-428c-08dd135ba95c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 05:30:56.2020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0YZqQDbLqaN7LuDC/7/893vSq6fOCGsTexKk4QPg331O04Y2GECBCZo3YLQ6Gd09ndZKBB19QhOvgB+I189EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7072
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Dec 2024 05:31:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17320

Hi all,

quick note that I would close the merge window very soon (latest end of
the week) and tag an rc1 for the next release. If you have anything
pending please submit soon. If I missed some patch of yours, please
speak up.

Jan

-- 
Siemens AG, Technology
Linux Expert Center



Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012B1EB3627
	for <webhook@archiver.kernel.org>; Mon,  2 Mar 2026 17:39:17 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.67])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.166455.1772473151034984981
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Mar 2026 09:39:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=s8gwde4Y;
 spf=pass (domain: siemens.com, ip: 52.101.66.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgTeFZ831KSR4CLRIVYba06X6M+OlHKctiXna2TZ5G38rNAUAKu8MFEmaLIcVapZiyn5bWKPJ5G7LUe99Q4FzU1xjsbxePeDKL47ErTWQoAc+iRVaSFupDcyAe66Um6v16UAbN0DKstRfEq+8Bp3nJzrYazIYjCRf9ep7pt9p3lnMtbXwZvz14OavmU2XyVfpI2pXLi7dJV68OjVaTlHfL9iIei0C5CjMnPT4V/v0MR2KxEb7K1gH4Xax7Ylw0al/FVtCmeTj9TmPzdXXzF7L30TzJzyUKoaeSg2Mp6+a9P6vEKnHhtMnjpvV5IcKBlimTeEZLQNbCLHvFPoOtDM/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hs8BfdizIatKXN9AQNsR26V1u1RsyAus2WGc8rlSja4=;
 b=GI+3kXh76KbCsRreHLiztrBcZag5q3auM4KZg4ZTl1MHGWqDX9bpPVlVGdbfiIpWqOJTVsdvFTHCqrzCqE0Wry5t86uVc9DONFb77d5dIuqlLOcXk2LwW/NLrz3zZclixFIrfclv0yechuidFHVMgRRR2f6dgf4PLL0bO8+IGoify4QnyiMkMxWtLSyxFbYcrsCTQwl32+Uepocg1B8FVE1Ct4ZCOThRBD3uoamIn1zcEOBJhh1kY9Fs44D2DZoBL7sLBpt0cSJoyPa5f/u6RIi9CkgC4L+IsedlL6yGJuctaUyJ3TqmhQGYcy32t81ckhFMDP9dZhw5DKCyhCyhCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hs8BfdizIatKXN9AQNsR26V1u1RsyAus2WGc8rlSja4=;
 b=s8gwde4YrkVw6+uOGNsThalKadSlFmQoZ1FZzrkazDuyFD546i8Hapd+ILyaY5FSNVyLoRk5iCy4/qSMv3yBR6jlWCp+jmNozPT0EIC0gx2gHdXvEKdf5P/HPSwJ6W7IAtq9TKTcxSSi6RmevWoeUz5pmEAQtjLWaQSh2SYSYDt0Wi6yPSQ32Ztk1GAVzqXYIFdJseSS/J7lTFkSOKr/Lc3b3QbCI6XDizKHKJNEkpx42Gj8nrlYNta8dJ5+pq4F7mOO6SZyY14TqTxPQBrz5p9amZW6Xbk5A1aXLI0hdiuE6pzs6hRu82hchb7MqNr0ShAtCwjxDDJeM+sE3JDUug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9153.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:232::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 17:38:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 17:38:47 +0000
Message-ID: <4afa555e-adea-4dad-a3dc-18491313d1fc@siemens.com>
Date: Mon, 2 Mar 2026 18:38:45 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Kconfig: Do not try to build fTPM/StMM for
 non-update images
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
X-ClientProxiedBy: FR0P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e46ccd-0e4e-4c61-4779-08de78828ea8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	dhKCg92Dk9ZHxqs8CWZmow7VElJHIKL6HMmSiAiyjUiGIBKeMOXNHHadXJtfoY2R/W4qjOvxFXqNPnaZuyXMPHhnR8vRUhS5mRz3yTG+2yT5Crn7a7/NhXaZ5vGNywkh7KRINWmemq37QItn66ZT09b1w/yAIP0RE3jrNt/0OftgL0pz4cTV/ETjGkPfYi3oTlPP4s3YOQsnGEiGWGmSEZ35QhLh6LhWuWUgan1XfObPB/EIdgaAen9f7bl16MOfh7cYzGHr26v+Rgp0+ZaQf7Ae95BBnsTykbBnRabUyv5ED/KlMiis9iHiN4AgoA+wiV18d4Sp3mdKVFUMb+tr39TKGWqy4B9X+gvprn4hXmQEU8qh/GrfHqF72ZWaP2FvRNOVx+KeILGuNlyOQOWB682uptyXG7Y4UPxfV1l6ZMYuC51T1fG/YiVIexty57rGF+J9w2NFCMnNYUeDKPczD/undSw6PnIuozaiLxwixomY9K2UGzsPl32HrJjxrfC1KRnST297eDxvy5JBhH5y9fVi3PsdRLS4eByMn6t4De25lbScfQVzGaR2jEnLoo52ctxiv69s0JV1eoX1n0JA7Eu0EmfaaMsGrqfibqkycNMrlel/mJ9u0wsORMUlnTtDlnehZ7aim8hKvxA3IakHw00TyrbCkhpSx5yCkDzcBAzsiBMYh6Al4Oq9Z50+1nXKQgzuk9L4EzFVy2bkEIe3C1KdY6sS6uyWxOhfmICSHAo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bDJhMmVRVW9FV0ZaOUpGTFF3cnliVU5NakplUisxcmx1M3habS9ocVEySCsw?=
 =?utf-8?B?MjFGV1JGZFd6UWZKWi9VYW9TSk1Lc3NFekhGMkNFdU5jRCtuWElWalQvTGtP?=
 =?utf-8?B?SlNRQjdhK0pxU0dwRUlkaG0reGgwZkw2UHZrSWRiUVpjelE2SXNiSjFRekdn?=
 =?utf-8?B?TzRlOU1saDhuUW5MbHNQWkVTeFV3SEl4T2JKTU1KcEg2UmNudlpkcGg3UE9Q?=
 =?utf-8?B?WE5VQ1BNc29MOG8rZGZ1WVNLNk9UREh3RHludWJZZUhHS0p2RWo1N2IrSlgx?=
 =?utf-8?B?ZmIzUDB1S3lvRks1VHB6aFFNRmRwRThldTUxUFVGTlN1YUgyWHNXK0lJUHha?=
 =?utf-8?B?MGdyRjFwRW1RWUthaUtxNHpiU0RieVB1SUgxQk55TXlWTERMekhROTJqa2E3?=
 =?utf-8?B?Rm93L2FxWVRrU3l0Vm5vSkt1UitSVDZiakhaL1JDdHZxOFpHaDcraWl4U3Ro?=
 =?utf-8?B?dklYTnRwM2xucnRKdTg2RDRscjlYMk41SFhLR2hOenRHaFJ3aGxhUndJUlI0?=
 =?utf-8?B?dVdWQnFpQlk4cXl4dmY1TDgra0FsNzBLUWprSWZBZ2t1ZDhLa2ZQUFErL2Fw?=
 =?utf-8?B?SStpaHBHbHFuVTI1Y012V2lCY1N3aUU1SEFPNk9OWkhCU1pYVWlVZGRVNmZi?=
 =?utf-8?B?U1VGR21qMlZpOEp4Znc4VSt3dTVTSk43Y1NOZXd5bmIrNjhycXdtTElmZGJy?=
 =?utf-8?B?R08xeFBhL1lXOWlNZGxqYWxqUGhVRm9MUzBmenVmK3BtV2ViYVdVaVo4ZS9B?=
 =?utf-8?B?emNyMkNacjZaZHk1T3FVWENjOXdFS1Y5cVpoWFY5bzVveEM3L2dxcUR0TTYy?=
 =?utf-8?B?V0pnKzJYdnNmZTR0eDZCN3ZGZzFmV1FCNDdVVjI4eDVuUHEvNmF4SGZsZUFj?=
 =?utf-8?B?T2tEQk9SVk4xUWF1UzhLbFBaYnk0YURBcnR6emUzS2d0dHpibFNZMldEcGo0?=
 =?utf-8?B?VlZNS0Q4Vm82aDliYmo4eTc4a0FQNTZSakl5WWcvcCttc2YvY29kUzl3TStm?=
 =?utf-8?B?Z3hxWVJVeE9yR0RoNlZHNDhRMyttd3lvWjdiaENRcVNQR3pibHJEeU0yUE5z?=
 =?utf-8?B?TWExRDY0OCtPeGU0OFQ5dG05ZXpiSWtra2l5TWZGODBlWStRcVdXZU16bHZP?=
 =?utf-8?B?SXhoMS8xckU3Ry81WTJEdkErN243eURHVURpTWcwVVZnczRrbG9ET0IvdTI4?=
 =?utf-8?B?NFdmOElpTzJzdzRwSmVFOWczYXcwVEphOHdpSUhhNmNvaG44ZE1aK0VFRGlG?=
 =?utf-8?B?WGNwOThtV1ZHNS9rWUltazdJZXlmSjNlVXgyNXhPTnR5My9tZnRYWHFKSDBC?=
 =?utf-8?B?aFVyYU0rNlNJUkh1cllIWURoUm1iVkc0UG5nUTc0ZFZsZDlYalBuMkVvb3ZR?=
 =?utf-8?B?QVI2bTEyWEp5UG1wZkZWaGVtU1daOS9IaEM2TnN1dDBETDRlRnhNSS9STk12?=
 =?utf-8?B?Vzc1QmtvcmZuNEZ6L2pEQzFISm9JQXIvTEJpWmU4dVdOY0xRYXNrR1BxblRV?=
 =?utf-8?B?T01hZGdTOFVheWJZbTNZWDMrWHNXb3FFMDRCMFUvZE5YcTREd2FOeU95cjJ2?=
 =?utf-8?B?TytKVjUyTG52Z3k1cXB4Ym4yMDBIZWpBQ2VLeDIyRVQ1VXM5bUhVMFR6UW5n?=
 =?utf-8?B?d1NHeUdlamw3amkrSjJ5aW9FNzh2a24yQllISThteDRqVVBsVTZ3S1RnbFg0?=
 =?utf-8?B?MlgrWW1ENmdJeEJMcFV1K1htRW1WcEthODNCMnVZeVhObCtwdDQ3dzBUSHJ1?=
 =?utf-8?B?ZTZCUzRucGIyd2hjeGdQWVJML0tpVWc1Q3Jrd2VhLy9za3ViZkEyQ0d2YWRv?=
 =?utf-8?B?NnNIRDlNaDBrMm44RW1TRGFLUU9Td3BDOWw0R0x4Z3BXc2JiaVp3WHU3TUE3?=
 =?utf-8?B?TW1oaXBXZU9oN0grd25GMHdBTHRYUWQ1TWxJVFN4blowWXpscFE5SUVwRWRw?=
 =?utf-8?B?amVKRDVLUnJ6KzlWQTRpKzFSSHZOalFDK3B5VmkybzBSOGxlcXdCTnBpU1hT?=
 =?utf-8?B?WUJkUUpWTldXaGp6VE42MENTSEV1MzF0SmlpWEY3V1VER1FrNUJHUmlFd0tz?=
 =?utf-8?B?WWpid01rZmh1dmcvOXZhcUdZcGZnU0cwVEdkY3BiUkh0Zm10MlpHeWZ1Mlcy?=
 =?utf-8?B?VDcrajFhS3dRcGNNRnIwbUx3dUFHcXF5dzByWkZ1Tkg4NWVYZ3ZKOUVMckhh?=
 =?utf-8?B?aERnb3QrUDdwVUVqTTRqeS9pWE9QdkV0OGxQUml5M3ZXaWo4V2ova0tpcFFT?=
 =?utf-8?B?bEJMZWJMN1B3MzVlOVpEMjFKVXNaQUtRY0hWUzNjWkV1TGprSGhOSkZrT1Fm?=
 =?utf-8?B?bzVLWGtlbXNJclpJY2NFNTJ3ZTd5Mld3UzRiOHJtZ0hxVjFNVlYvdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e46ccd-0e4e-4c61-4779-08de78828ea8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 17:38:47.1170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fisEVkOEqU6YV9G5q/JpnROO4jbANKWV8cItgIiW1usKy45WlWrfWMmn2WqiBklsYtNWblJx+VT1TxFlORAz1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9153
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Mar 2026 17:39:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22037

From: Jan Kiszka <jan.kiszka@siemens.com>

We need a full eMMC emulation, and the plain images without SWUpdate do
not provide this. Enabling this feature will then only cause a build
error.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Kconfig b/Kconfig
index 772b8cda..bd2b7cec 100644
--- a/Kconfig
+++ b/Kconfig
@@ -208,6 +208,7 @@ comment "Firmware options"
 
 config FTPM_STMM
 	bool "Use Firmware TPM and rewritable UEFI key storage"
+	depends on IMAGE_SWUPDATE
 	depends on !DEBIAN_BUSTER
 
 config KAS_INCLUDE_FTPM_STMM
-- 
2.47.3


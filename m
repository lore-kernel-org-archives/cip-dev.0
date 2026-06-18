Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A24CD98ED
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 04:59:31 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12717.1781758761398654378
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 21:59:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ImhCClKj;
 spf=pass (domain: siemens.com, ip: 52.101.70.23, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+tPhg8o01N9DrJ1U/Fk4o+5ocyjotm6WeUBEhOdyLnKXu85C56aQ9eIvJY2OIX6FLm4/WeWOOKtZlGl6WnuR4Gi2Q3q/XdIFNPNsvUg2RK+yNJboJDfPd65C1rXt8BxiFqmkGDQJUmGONy5rkKGGU7EPalShftitNMeyUVwNCVv8EwNf7LEtcnhkF6VpZXheo6D/LKnVD7Py/+jG9Y8gbfYlS7s8wRKEMejduuken5wfOLJ238rFo5GRp96TIoEBbEH9c5x8jaHBwLzZzP+NHIx2z828C7TLby5iv5KU5tC5v4pSiG3cOYijBHTl4J2H94N8FCh8xrGmBNzsOapQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bk88GfGZPaqXwv36z+yqWILonwP/eHCwBUk5MRmY54A=;
 b=hGdhq27e9+QJ8FM3L71nrF2uCh/Y3MaGKlVsJArXjZjTQmb6B9ULXLzx/yaleEkMRWbxEGDCtML97GXFoh+K4vYhhX1N+hEG0DHTgVSpDaby61hOculmXzK5B4scSVUdyYwgJcjCb7R6wQWCd+QyaSC6oZ/O7UafWROWsGLK/gsXV0oyG2mbu7HSP7sSRn2lJCeBRKaFIFwGxDQUnp8/wv8F/cYxUVtUqXN3cvANqLJHaiTfgyK5P8ITc4k9RCbMCNjQpKvV0DQi4HofWhRKApzMgRH/kxksdo21sqA0b8jKNLASH5+tjY0uvD9uki9JuyfQ/MCtrZmYpJmHykaAdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bk88GfGZPaqXwv36z+yqWILonwP/eHCwBUk5MRmY54A=;
 b=ImhCClKj7GZ+9KkQB3+bHl1SiumoJR8XJdzMWGb0EordRmQl7lDaDry2F90UdgQ6QlG4zejzZYmM2aN7Iob+DSHI5TMFiGDntcK1MxuB1ozEv1VgjqjVQSLMCFkqNmvo339BWs0mCsAW/uUywrkm+tpGawUaAJgEZxrnmz060M7s8eYWi90SueYOrT1l8E1Kwa7eB+wfkZZNBL8V7vw2W6z0zqJKOef9cujuJBI9+iRKrsaKfS/98I5WTsYb2vn4/T0DZVZCAVnop50jJ4L5D7LZn5KlkCcqPxaAXFNpw0tMvR1XGNeurYXZT3nB/pOBIji2zCOInHD6LU8a5lBBOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8736.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 04:59:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 04:59:17 +0000
Message-ID: <67675b0b-394b-4409-8462-a3bfbca20e6d@siemens.com>
Date: Thu, 18 Jun 2026 06:59:16 +0200
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
X-ClientProxiedBy: FR2P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4f942b-17c0-4d94-f3d0-08deccf6596f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	3WtbPvkIXrWLiZC0ZrdilnoQBHdRxloYap1RWLFK48oidXGU9TgLCiR+I8fbb44ytLFX1w5RvvVX6MaRGhegzwC0Xu0gXwUwUWUl/YhwdYsb06kbCbEL5mBREQdeCxZ5nu1KFgAb4OvbvgrCZxz7xugQK5azaxdo6GyVebw3mBku/uhVCMvp2M3APK1Xnb816VioGzD6yE9MAePHUPAsr+gdYaFx4gmQK9LkC4AMBokaHo7XxMjf7xoYVq3z+zlHUgMKNJ5Nj9ZDX398hKMYR0NhJ90OVaD3OjMg7oL4sgn8/xUeZumzAD0544qdmv1/EQKiIRqsd/AEVg2vPMhFGhdkM7AXqS4Y1gsR9ABx+RibSyt9sZMaaWPPUAAAvLRBU4lNHpIfV/4zCowJ8ikXb7LtIfI6bslgybBOVCxOO6KHbHHvZyNqusJFFeBvNOdv2U7LzEhHneTLMKcovSWLQMdAFDxlktcCC4z8uogr1L9KUv3otEZjPPMQ20hX73BTyyzEfTWTeiFqwTYQxqeEuiVqoCT/vpanJHmI9C4cgoMxclJ7ij/6OC+Gh1/bVIU1nJpkoLHrf8IpC3bo76KN500pnksIWn1FyFrDx3FoK461dxI3PlTpqZ/u2pGgJBzTS/I9zl4svaaB8u2TFjzAaw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b2hqRlZ6MWJ4UTJhYVZYMUJRM2JkUVJJanI5czRzd0M2SFdldmlNcWZUYmhi?=
 =?utf-8?B?NXA5d3gwS3BhK3V4c0sra2h2NG1RbVI3OW5FcUl6Qm1vczU5eklRTFNBbTlX?=
 =?utf-8?B?d1RmK3llcTMxa1pNbzlYQndVUWo2VW41dG1rNVNkSDlQRmdFQTBZenQ4Uk9Z?=
 =?utf-8?B?Y2pjVDRVT3dMTWV3SXRXYm1xVS84aEFnb2ZOLzhVVXFzdzJtaHdrVUtjT3ZD?=
 =?utf-8?B?WmxnOU5iUWhJNHpkbnNlUHRYUTFkOVlTYTNlVmxSeTBGYTA5VzZ0dVBTcVRX?=
 =?utf-8?B?M2NmRTAzcmJYS2RvRWVlM0djbHFkdUxUejRWUTJmbGZ3Qktyb2Jmd093bzBp?=
 =?utf-8?B?cmtlRDI1MU5pZ2NjYldCSW11S3orU1c5NmNTUmJlRzdUT0RiSFBJS3Q1Z3pm?=
 =?utf-8?B?MmV0OEczcC9nSlU3ZW9ZRGxMU1JhbW9rZWliQ1RyNlVNM3p6QVZNZkg4MExu?=
 =?utf-8?B?ZVlZZUsrT3BoTlBBVDJoUSt4VVJKaVEraVU1RWdodXFkUFRqQ3B2eFpERC9t?=
 =?utf-8?B?M0hDL1lNK3cxdjFrMllRL0VkQXQ1d3Y4QnhZZG5tWWZUUW5pR0QwQldXNEUr?=
 =?utf-8?B?b1lpUlBicEozWmY5SzVieFBQMW96NnJxNXIrUnNMQ25RMjZBUG16WjNaNFpN?=
 =?utf-8?B?cURyQktmRFo5ZFFHeEpYOTNxaFJLdGFWQWgySkpCV3hIeFEvQnlTNXBpZGJ0?=
 =?utf-8?B?RG10V0hyL3VHL293YTJmQXpKZlRhSjdlQnloTVFubm4zWTl0UEx2QkszTXAz?=
 =?utf-8?B?WjVqUDV5VlZ0dVpJdFNudVJYb2YzSllQSmtOaFIxdklJSjl4THZrMXpjM01h?=
 =?utf-8?B?RHBNUHdpVmgrbG1rVVFYekd0L1JTaXc0ZGdtakFaT2pFcmJKaHpZc2pOdEhh?=
 =?utf-8?B?RW8vb0o1aWIvVms2RjU4Njgvek8rdE5KanlWWWc4VEJiNXNnYzlUMnpubUJn?=
 =?utf-8?B?RzFZanRNdWpsM3lMazlSQzd0eDRJRkRDZ3FoNVl4c3ZHaWNVZitxLzVSc05O?=
 =?utf-8?B?dFpaTmF5RzZvTFN0eWV4ZnpTSWgyZ2NMZ0N1cHJiditVMExSd0ZsYnhGaXdW?=
 =?utf-8?B?RXU0ZC9BRUJCWVBZVWpRdHYvM2psbWQzUXVqTDAySi8rVk4zVmJ2bXBaWmxS?=
 =?utf-8?B?Zis2bDVWcGl3Zzl5MFR1L2tCNTJaN2lKcFNhRE1YSGhDY1I4b1NMVWl2YTBv?=
 =?utf-8?B?eGxHbW95SXpiRlB0RnVDdnltVks3Z3I2cjYxTHpmWUFjRk5TRlVxOTg4NkNY?=
 =?utf-8?B?N3Q0eDFRWFRpd2lORWduTGphOGRKU0xxalBnTlNBdFVMUjdyVExGTm5PVzYr?=
 =?utf-8?B?S1hPY2YvbVZYcGlocmd2dmFMcTFUbGU2LzNpYVROempGRHlPa3p5b0d5a3p0?=
 =?utf-8?B?OGprVHFGYkZaclk5SFZab3U4QkZNUWkvWmt0YXlJQkQ4V1p2cTVqSDNmalZ2?=
 =?utf-8?B?WWFCWHZ5OW1za0tNSUFxNDNUVG9BQ1c4Zm5KeFpDU2F1dG9yeWt1MXdmUTZT?=
 =?utf-8?B?TitUMlNseEJYc2srRE0xcklKQVF0VmVGdTBSU0h4U1JQU1VyNzdkRmtRU0VV?=
 =?utf-8?B?RStzTTBQVFhTRDdOZVBBZzhEOVhJOTgrWEZ3VnBLWlBYTXBGUUlRMS9UYytZ?=
 =?utf-8?B?Szc4UTl0U010OUpIeXg3RHFHaW05dy9oaW5SRWlyUm5wVVlSQitqcXdXT1RN?=
 =?utf-8?B?a0c3MzdNa1ZnNU1ONGh6c2JyK1JJelkwN3liNGt5RzB1NExZL0dQNUhpcUlO?=
 =?utf-8?B?MGErTWhOS1Z4ckR3STZMaWRoVGdIdmk0QXgrU0ZldFd2VVZZUUxBZFpFc25u?=
 =?utf-8?B?M1h2ZFowaUlUeEFZelVWTGZGRENYc0hSd0xmT2pDeXAzZVFKSW9Gdjh0dzVG?=
 =?utf-8?B?cEZ3Q0tVNE91QU9tM1lRalF5WEp5Q0poWGFidFRPeHpUZ1Y2Tnc0Qy85Ni9D?=
 =?utf-8?B?THc0c29SK0hJblBaQVhGdDJINTM1SWVDMzJqSlp2cG83dXJqSW1tUzRwN2x0?=
 =?utf-8?B?MGIxaDEyYTdHejRjVEdKSzN1RUkxMjB1T1J6eUd4NzhUVFliUW5WajZQV2FR?=
 =?utf-8?B?NTBxOVhlTHp5TTZsM3l0RUZPM3pidFRzb3pTdjNLSGppNHBOQ0gwcjN1a3ln?=
 =?utf-8?B?UmNoaEQwKy9NQkFYenIzVDdhVDNlMlQ2UVUwR3Z6anRMTXZtTGxEcGU5eXZR?=
 =?utf-8?B?MFlaYTR6dmxlZFJNeFdPYms1VWRFNXRkWnFrdXFwQjFNWFBmc2d1TkFReWNF?=
 =?utf-8?B?MS9lcEU2SkUvWDV6djg5cHBINHVvbnRLeWgzbWFWQ2FGMEdNM3hLVkYxUlJ4?=
 =?utf-8?B?aWxXL0dOT01VZkQvZUJEYkJBTjZKMkxiUlFZMDUyaHlKYzVEQVpGdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4f942b-17c0-4d94-f3d0-08deccf6596f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 04:59:16.9689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2nfcEfpiUUOtsY8jbY9nwKV0lmyjjhAUmA73cIuSi9+VoCujVoUtsiybosPlvWc8PXTFtVVypj5ht31m5vcnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8736
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jun 2026 04:59:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23218

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=6&day=18&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/06/cip.2026-06-11-12.01.log.html

* Action items
   - request extra budget for AI-assisted review experiments
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Jun 18 04:59:00 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Thu Jun 11 08:34:12 AM UTC 2026
  limit date: Sat Jul 11 08:34:12 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon May 25 11:40:18 AM UTC 2026
  limit date: Fri Jul 24 11:40:18 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu May 28 07:36:48 AM UTC 2026
  limit date: Sat Jun 27 07:36:48 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue May 12 11:56:37 AM UTC 2026
  limit date: Sat Jul 11 11:56:37 AM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Tue Jun 16 12:38:40 PM UTC 2026
  limit date: Thu Jul 16 12:38:40 PM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon May  4 10:49:51 AM UTC 2026
  limit date: Fri Jul  3 10:49:51 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Tue Jun 16 08:11:47 AM UTC 2026
  limit date: Thu Jul 16 08:11:47 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Tue Jun 16 12:51:56 PM UTC 2026
  limit date: Sat Aug 15 12:51:56 PM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Tue Jun  9 12:04:00 AM UTC 2026
  limit date: Wed Jun 24 12:04:00 AM UTC 2026
  Status: On track


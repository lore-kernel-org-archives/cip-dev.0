Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B830C5CFDB
	for <webhook@archiver.kernel.org>; Wed, 12 Aug 2026 11:25:05 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5825.1786533901733060933
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Aug 2026 04:25:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Ciu8/O6r;
 spf=pass (domain: siemens.com, ip: 40.107.159.6, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSDAYezpUWgJHF3Ox8he9opIWnWdp2/LK9B1QC/dakLNMKu1SqkUVW8KUwI5L+TuyPDdirm5bWZmCxsc88hHO0Cds2qfDZj+Flavuxl8lqHZz2uwfKMyFHbQSlcw3nREBDaLvvlPA5rhm+3ce5aINqnD8UoFfbbvVUZuL2px/F/7xJcNpEa2y9u5P3cDh9nesvi3qR2VVp4YRCDqN+fSgaQTVijuh0D1MtGktZ3jWvVp+Pspz+iNxl4Vs3EAq24+AmhcVrdb4hvF4SNhSCD9TH4kSTmIrYg8mzzgFJd4obdGKsrMxtwHd+Gw6l1I+HjXSbm7gJ4TOa7lexqI8qr66w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7RSI0ENAyRx9Y3lLrWjV5LDoqCsBJr09KVaZPbTMs8=;
 b=nqXn4FDKStb4zTLi0oPtSACiOWrYVyxJ8U64uLE2tZVuvB11QjV67K5SZcJnXOC5wmlpr2L0vzMdQgnXQx2ojXrDlKqFtDKuUlGlMrWXlH1JECc6+lQBTcR3iqdiorTOd6dbPmo24NybzIqLdLExq06aCCxe8z/nqR892Sl+D2po0uuynebIzbaYU/cv8XkS86uMBLzX9M4+zX12CYcRxzLeSF17lbiHgKvsNFI/AZbeE4cEMawvwzOLMMhRtC67ksDSODeWlm4Xj57jSVRzQNCRC8FhjDC8ygtwZR1WC8cFmd+HoAxmhK2GlW0l8zAvRcRa7TaLT1hPtHJGDikTMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7RSI0ENAyRx9Y3lLrWjV5LDoqCsBJr09KVaZPbTMs8=;
 b=Ciu8/O6r2mNdFI2OqVob6EB9aQ/pb3kn27Jb+537OZVb8fA6hHwwkcH90BTxQjhOibxNEWRTUeCHvWucnYRF7BBhAXKcqXCCZfkVBLQdfD0YvSRle2g+e5BMlfDOso2e3H2EHPj9D3ALszOyxGbxVVVFhDoHGYYiyGc4UHtwusCooFv6UiQKXCu4WOaQQNYLoSy8E67Dot8WEegOmgorc6mUwvdp4Kr3nJQnHvEyh0qdtdcargzorEXnI01rXMkREfhtSkV2RLFWjVaFxY3m5u5dI52R3VI9jBUFFVIbp1C83MxoWwNxNp3FA/Y5n2IzXbo46JHrpLH74QnRtoOcKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8596.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:453::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 11:24:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 11:24:47 +0000
Message-ID: <73dc6b91-cef2-4e88-b5f4-c4435dc78b21@siemens.com>
Date: Wed, 12 Aug 2026 13:24:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 0/2] Remove unsupported combinations for
 factory-reset from Kconfig and document them explicitly
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <20260807154439.625212-1-alexander.heinisch@siemens.com>
 <31174e6a-78c9-4fce-8d1f-dff403e1f6aa@siemens.com>
 <b45b4dd0-03cc-4df8-94e5-ca3405e2732b@siemens.com>
 <4400621d4db82ea3313ff1907d4ef664ca0cdaab.camel@siemens.com>
 <5eedc605-7ae1-425d-876a-62c183e3a79e@siemens.com>
 <caf1c704548f130911b872587c82d15441ff88d0.camel@siemens.com>
 <5dd841d3-abe7-4167-866f-9f84bfc25758@siemens.com>
 <0b32da8016d7314c67aa5a5de4b57e112439880a.camel@siemens.com>
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
In-Reply-To: <0b32da8016d7314c67aa5a5de4b57e112439880a.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DUZPR01CA0099.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::24) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: f3524e6e-5677-4ebd-4382-08def86450e5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|5023799004|11063799006|10067099003|56012099006|4143699003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	3IruOVOEMNxFrpjReZFynUV+0pF+t9dfq4ilyz9y7SfkdpxjrtU2JtK6Gb9ADDmuOYUaSTcgqXbcrxlFoHh9uRdnXHBKTRJoo2ztrp17QqYmVhGztfGRQQ1adyqTIMhhsah9syfmfd3ctPLITrIXlgC/I7GkWYJSawhb01ZK0R+HR2kABIzfi2SMQMFdiUVSFEHuJYl3QUQUIXHTCU+UXaC5DVQMhaLpUk5AN9LeCmNdWKLm6AjITsMUBbo33uSMCZbCVZfaXaod9ptGQcwtgz0kuse07GE7NZRsV9lJMb8ZP9ioNpBMlvZZp0L9iCaF0f5uCwEE19xmSoIS7PoaAIOmxPeShP9wx8NTxrSCz1jQeDet2IB12kouKdNHDa1YTy21v02hsae7q0cUzAFm8MRbDgbgPIvxofsgP55Foz6UJYCpza7NgSoK4X0kDmcoHroR3v1MLOZ5zo138ZytTagG9s7bpRZ0te+u1plvDpOScgmsDf2FU4XfKvGCY/UqVLBq5Gpy6P0J49J3ppLhazRjFRBuKdRda7qbKqfXS923SxvLEBsAmfYSqrnsZvaUtoINRboq9NZQkMTZpyNQxQKUUhOqaLEyHZeXM5TU1TWFycytGX9ZDdy5wmPBPiQhVrGHd+MM7HzeiBBjKzrxtFXD1/6u2Ig9ZlZ9GvK8KFo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(5023799004)(11063799006)(10067099003)(56012099006)(4143699003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xNBZ87OciPdoD/agssOvXIV3m4VZMG9B7knIlglipCiwUNQFLXLLXrfy99zg?=
 =?us-ascii?Q?vfDxelYCQZTt/ceJgHvWMGMsLrTWhUh1Fz8mngeYmoWm7c3LTqs9lFJlLWSK?=
 =?us-ascii?Q?uGVNYYHpgeI0LDJL/9VlC9cTE1Ixia9v3KvJhGMz/c5JijCILul4VKeQJrh3?=
 =?us-ascii?Q?tRAQK1uHnkMMk1l8V/86k03P278hUz3cHFOp/kscx7eA5CjR6XBXAmDUaQmj?=
 =?us-ascii?Q?i/4rmRlExOQTijCcelWoTz1kGtUlKf6a/u6TVj5q2f+m1daIWiDlmOl480o7?=
 =?us-ascii?Q?9bX8Cfj2IagpIndKmhUB95+DsIC6dYA3vrZHkCoe535ePGPLi99DiQdVOMNE?=
 =?us-ascii?Q?tDzSJY1MCNX4UgEvFg/DBnzQDgsH2Qta6AvvDddXeBdurFHvjE33348sBL00?=
 =?us-ascii?Q?YtvM2a0bumLdWVbF33YiRC0apifd8ZJ07QM8JdizLsu4xi3GZ16BfkfFnPo1?=
 =?us-ascii?Q?H15wuBTHCHqQy3E2T9GY2mo/yL9TLsmu67Ev7IPhEAR09SCHcxljgFwzMatW?=
 =?us-ascii?Q?BkSir7x5NACsPPbpWHRa2B9e5IajH/UboI791Bq7hz/3ryPromotqwBfpB7s?=
 =?us-ascii?Q?JXvgOWUM7ALa01ME4kBEGFTx+xSGGF4o3mriUMqKmnawXaD8phlduhEadIOC?=
 =?us-ascii?Q?q0zlH0uxhNjYQt4bNE2f3tGrgjiCY+8jQw9NaPRGJY5hDcsVGggSP1yqFP6I?=
 =?us-ascii?Q?N5RomgHS5qYOlSYurtbF/V4QQTTAE4WBYz3kv1OOLI+tkmL/9ebOQscgw3Ls?=
 =?us-ascii?Q?5dTy3APlIOAWCGZp2tn19BXLKPCfyOpNNcgY+iBOwoj8Zl1C2LLrt+dpyWbF?=
 =?us-ascii?Q?g3/Yf/QQW3BQFGqlRjJLc2BJlSO94iZAQAr8o8rACLZcrdot/y4jVjfTRjAz?=
 =?us-ascii?Q?yIa+ghtxL9tRG9mP+3w67nEOTYqHoZbBGTA6/NF3RgHV1CUXYNh2JjyQ3O/r?=
 =?us-ascii?Q?N8HrvlzUC36aS41s0GAWLOo7KnNI7h0ResWE2Jp9GPqpM0tkdo3V4aqDxAxc?=
 =?us-ascii?Q?6Bou2WQqiRbTervlE4t1GdRqfsiv95yy/jGMLk9P1JLa7+LEoHdhpFak0uVT?=
 =?us-ascii?Q?M1dhD+9BnhTT/5qZEYK6MT0WM9LEIgFuFNl5CdyXAuQNzzQqWPIo6Gl8/zqF?=
 =?us-ascii?Q?mOW7BfLXaoO2cB7w2RMmKQoUdk51+pdYrtuvzZXeaFEorDZS1E9LDGifN8Wo?=
 =?us-ascii?Q?C3Lie0Wyl6xgk+ykPWnZsFytudSrEdYTWnzI3sOY/03pOPd4Del2ezYE7x0G?=
 =?us-ascii?Q?tLG3D2juchnewPt2K4u7SrqFoxnhsulOhsekvZa907gVI/n4yjBI+GW/wSCq?=
 =?us-ascii?Q?ri390ofWw9YSAFACM5enWwoq7aEdh8FLGttSAqmeKxlPi+iuN5fi91i2BZof?=
 =?us-ascii?Q?JCbZRl2uEgKYngZuQKJ2pE7tpNnz9cFQpg5M3Wixy8RJsF8Bjsogio4ooYE1?=
 =?us-ascii?Q?LU1xieePdy77froUEkc+NiGgFSaQQ7sHr30HLDEGyMq4bFRkAXDLXNr6z54Q?=
 =?us-ascii?Q?eduFPzUJXFobQLU59QIlXFvdXTLiySbBp6jbeLdAE4M5HGwl353SeFUzGOkS?=
 =?us-ascii?Q?qUkie1vBvK7DlH2jEqYlv+m5/QgDx2t4IXhNf/KoLBwvCHkSzjtNYo53NkMf?=
 =?us-ascii?Q?vb2vaq9FFFuaFp2nmogztc7FxdKQAYDgHIlfthUQzZRlB8Pa/nITI6J8uO81?=
 =?us-ascii?Q?ky29IfTinGCVzY2PaFT9n0x5XsPDjUfKi8mtm/VDZYDCYdvqWRAVczj25oLo?=
 =?us-ascii?Q?8ReToDabBA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3524e6e-5677-4ebd-4382-08def86450e5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 11:24:47.2384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8in8sgywNXy324uElHAEDgFlFIUq0qd9Lnehch4zVLWiVUNos3w+QgKAPH/OI9+96Q/HD8STW++foDxANGTDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8596
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Aug 2026 11:25:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23904

On 12.08.26 11:25, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
> On Tue, 2026-08-11 at 09:37 +0200, Jan Kiszka wrote:
>> On 11.08.26 08:58, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>> On Mon, 2026-08-10 at 15:06 +0200, Jan Kiszka wrote:
>>>> On 10.08.26 14:02, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>>>> On Mon, 2026-08-10 at 12:39 +0200, Jan Kiszka wrote:
>>>>>> On 10.08.26 08:55, Quirin Gylstorff wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 8/7/26 5:44 PM, alexander.heinisch@siemens.com=C2=A0wrote:
>>>>>>>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>>>>>>
>>>>>>>> By default factory reset clears the tpm. Therefore, keys
>>>>>>>> needed
>>>>>>>> to
>>>>>>>> decrypt the immutable A/B rootfs in full disk encryption
>>>>>>>> setups
>>>>>>>> cannot be retrieved anymore. Thus, the boot fails and the
>>>>>>>> device
>>>>>>>> cannot be recovered.
>>>>>>>>
>>>>>>>> This patch series removes such combination from the
>>>>>>>> kconfig
>>>>>>>> and
>>>>>>>> documents
>>>>>>>> the issue explicitly.
>>>>>>>
>>>>>>> This was never in scope of the factory reset. You could
>>>>>>> implement
>>>>>
>>>>> Probably, but it was part of the configuration options. Imo,
>>>>> those
>>>>> shall serve as a demo for isar-cip-core functionality, and only
>>>>> include
>>>>> valid/supported scenarios.
>>>>>
>>>>>>> it by
>>>>>>> moving the keys into the boot partition. But this move will
>>>>>>> create
>>>>>>> another can of worms.
>>>>>
>>>>> Temporarily moving the keys to boot partition, is not an
>>>>> option.
>>>>> How are they secured there?
>>>>>
>>>>> A reencrypt with new keys stored in TPM after TPM clearing of
>>>>> the
>>>>> partitions holding the rootfs after they got unsealed could be
>>>>> an
>>>>> option. But yes, that implies major rework of the factory-reset
>>>>> workflow in initramfs and potentially has side effects /
>>>>> dependencies
>>>>> on crypt hook local-top. And yes, there may be a small chance
>>>>> to
>>>>> brick
>>>>> the device when the device powercycles at the wrong time.
>>>>> Else, a more graceful removal of keys from TPM could also be an
>>>>> option.
>>>>>
>>>>> All things, we need to think about in much more detail, also
>>>>> considering the number of use cases for a true factory reset
>>>>> support
>>>>> with full disk encryption in place.
>>>>>
>>>>>>>
>>>>>>
>>>>>> We already have an option to skip TPM reset if not desired or
>>>>>> problematic. Why not use that, or build smarter on top of it?
>>>>>
>>>>> Yes,=C2=A0there is an option to bypass TPM clearing. That's also
>>>>> documented.
>>>>>
>>>>> The patchset is only about to document that the default
>>>>> factory-
>>>>> reset
>>>>> config does not support full disk encryption setups and not to
>>>>> offer a
>>>>> demo config option for this non-supported case.
>>>>>
>>>>>>
>>>>>> Factory reset has already way too many limitations. I would
>>>>>> rather
>>>>>> likto
>>>>>> work in more cases than in less.
>>>>>
>>>>> Without major rework, the only option is to disable TPM-
>>>>> clearing
>>>>> for
>>>>> factory-reset in FDE setups, but that hides the fact, that it
>>>>> is no
>>>>> complete factory reset. So either Kconfig shall be explicit
>>>>> about
>>>>> that,
>>>>> or not offer the option for FDE + factory-reset at all (what I
>>>>> did).
>>>>>
>>>>
>>>> Resetting the TPM is the poor-man's approach to factory reset
>>>> anyway.
>>> Yes, but without TPM reset current disk wiping strategy is to weak.
>>>
>>
>> One of the limitations of the current approach. Let's fix it so that
>> TPM-wiping-off will not cause too many surprises.
>>
>>>> It
>>>> is not needed to reset the disk encryption keys, also for the
>>>> data
>>>> partition, and we are so far too lazy to identify and delete
>>>> other
>>>> resources in the TPM in a more targeted manner. Or was there
>>>> anything
>>>> technically preventing an "all-objects-except-for" TPM reset?
>>>>
>>>
>>> Is it a reset so one can hand off the device to someone else? Is it
>>> a
>>> reset so same customer can start over again cleanly? Or is it a
>>> decommissioning without device reuse?
>>>
>>> Currently, the key exposure is not limited to the initramfs hook
>>> implementing the crypt setup. So depending on the system, users may
>>> retrieve the keys of their system. If such device is recycled and
>>> potentially shipped to another customer, either a key exchange for
>>> the
>>> disk encryption is needed or the key stored in TPM must be sealed
>>> so it
>>> cannot be used after the crypt setup.
>>>
>>> Not sure about the actual requirements that led to the factory-
>>> reset
>>> implementation. If keeping TPM keys for disk-encryption is ok, a
>>> clean
>>> wipe of the contents would simplify things.
>>> Do we even want to support FDE use cases for factory-reset? systemd
>>> (which served as a blueprint for the API afaik) does not.
>>>
>>
>> All valid questions...
>=20
> How to proceed with this patch set?
>=20
> Currently, FDE + factory-reset is broken =3D> shouldn't be included in
> Kconfig and should be documented until fixed.
>=20

...and I would like it to be fixed. At least factory-resetting without
TPM clearing should work, and then we could use that path for now. And
we would also fix the currently borken combination of data-encryption +
factory-reset + TPM-reset-off.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center


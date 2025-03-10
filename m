Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89925C28B2E
	for <webhook@archiver.kernel.org>; Mon, 10 Mar 2025 08:08:55 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.59])
 by mx.groups.io with SMTP id smtpd.web11.32369.1741594128076806512
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Mar 2025 01:08:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=zEg1ebIq;
 spf=pass (domain: siemens.com, ip: 52.101.67.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evYhYcpFbMbiDyfcAnJz2omTcJxVrrpQ1nhAxQqYyD5gfAR68ROD8yECG1WAuAwbUcNW8NIUpV5IURKMGiJe+KAcU9aV3MxRXFpoZ+Yg9ptIq25335N1lMDA5Ys+1DCz6VHWjJSuUXdCUolZqr/PHqcwLZon/5GEmTf51G9ak6pnBhAPG5LUuTvurKpWzkY0Bmro6AxjabeVf7PtZxs0qc9oG7gza+WZ5IggruM/PYwH+7YPoVTPl3nDr1C91qjSxNk4ZrUmIpmHrJntD/kqbP9oRQ18EtgsJYNUYSHqCXP3oY9mn5yYiy+xuoltLa36bDDx4jfpN1MlpuNfS6KKaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxqnHBSvyLaqyTCQDq+0+xXZR5rS19tocVuF7WhCE0U=;
 b=oU4qAsub9bStSGGrdo/jUg9mC7+AQT3YH0uXX5khIhfiyN3a1Y44EfiU9ehPaWev9NXi9J5mElY4f4md9aNFygb2HlJirL4EFEbkgUpGkrMKpXjhwduM1DY/MPuHqWKjtgEqLM6LFcQXFoayDunjSNu5C+zh0/aptoM0pswdFCFf9RIu9eK3t0508fmtedqu2miRU1Hhj2wQo+gSXiRBxPsO9/TUvzbb/IBxjwxk/giPcY2tD7/xShzy4KY7r8VavyJsN6yyk/fT1+FvESy8u01wHDPG3DWwtMKZDrOOGN2vmVptysLmhc7Lqx+AGSo1G6RM0L/RrLvH7lJ92qP2Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxqnHBSvyLaqyTCQDq+0+xXZR5rS19tocVuF7WhCE0U=;
 b=zEg1ebIquXtPDy/DvVEU7CWOg4sEHUr+N7uDI22XcfVonRiVZvzctCzCOlCIejRhDBE43cniTQ3isVDsiyWhDsH+b+EEdoMOPufN7LaX9Hmcukk26qmkMKBKE5aZBtKRfYu9Uaj2AJrMHCwdiEMcPECsBTd4Y6+ArxSWI/v6bxB8ZqaTUzFs53Iga3IE9a7iZ08ixE6lHjWGWwlUva2VuW3HmjHYmGBfqBeajnSUM4xyGK94zyEbNCtDr+G5Q08CmvZFKks+lr9dLemPYtYe9JRoXgo7puu4KMhnmUdD95xESUvjPuE9v91E89fW4IKVLOBtKBuEvSN1Zja0Cee++w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GV1PR10MB8967.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 08:08:44 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 08:08:44 +0000
Message-ID: <38368d3f-3c33-467a-8e0a-8fce11de6415@siemens.com>
Date: Mon, 10 Mar 2025 09:08:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to signer
 provider that hooks sign-secure-image
To: =?UTF-8?B?w4dldGluLCBHw7ZraGFuIChGVCBEIEVVIFRSIEMmRSk=?=
 <gokhan.cetin@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <20250306093516.3232063-1-gokhan.cetin@siemens.com>
 <3f756d50-aa21-484e-aa52-f91531451dc0@siemens.com>
 <87b88c83-3fce-4038-b8b6-cfe83056fb9a@siemens.com>
 <PRAPR10MB54225595622204A578B7E92880CA2@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
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
In-Reply-To: <PRAPR10MB54225595622204A578B7E92880CA2@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::15) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GV1PR10MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: c80dc062-ea3d-4138-6990-08dd5faac6b7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+NS0+3KjeYAYruAo5OWIfwkUWHdCGswFOvITCwZZr4HSfqhitJH63u4XXVKy?=
 =?us-ascii?Q?pPONARPTDQJdPdIMv/K4EGDyNBa/z6iBKRfcKNwTDXD1uf3byxpH8ZVSKyw9?=
 =?us-ascii?Q?BdWyZi9Le8OtE1jNO+H88c65Xg5RKWZblGkKK6QxC+TOCQou8YAZoc7xKPYn?=
 =?us-ascii?Q?ckwk7vRNHsusqVG+YHxS+1+CrLt8S06kCm+zgB2lorNMapPTmNKIWsBwTuSO?=
 =?us-ascii?Q?FDSYmtDGgO8FYlxEfQlwZr1c8LADOf0/EPw7FgkUMtK4Yri8hu5iW9Nv8AuI?=
 =?us-ascii?Q?VG+S9J0Jx9Wl10T7+cXoAer2fokyiKKyf63te5Mnnz5DIFYFqSu7e1h8d2fD?=
 =?us-ascii?Q?QMRl54OyywSaaLSk/sxmU+3FB9IHdii3umWSRCshoghYqL58YXrG+eva1APh?=
 =?us-ascii?Q?u7gnrMWkGxoTKF7873IuB3zt023tlYGm9JASUEwiXKS+Z6dvHbsQZDmG//k7?=
 =?us-ascii?Q?c/0805Yi5Ehkq9fnvVtcDVmq6Dpidbe1qOrp4czcJ4RCunrtZqNOYXcQEMKb?=
 =?us-ascii?Q?XigKbSm7o319gt55LX5NsZPXQ7TZmPfFZ4kbyli49Mdj2YrzwZa7K+h2wyhQ?=
 =?us-ascii?Q?Zm2QGAMdmoHTJrNhlddWOd5kzMhulADbLscYQLQ2Ep7f0ogl1cK/gjj48XdN?=
 =?us-ascii?Q?9EnHWjFRvEg+W/TI26vGrEGQNd+zscgA/TY3xPQ3X/Wz7axTG6BD2lQFlo3M?=
 =?us-ascii?Q?slsbipb6P6EnP3sZNLpsSI/ukYBvrbKhoYTHW8FehIOI/LbwsQiELcJcYqil?=
 =?us-ascii?Q?vZzRbJQu1c4ZpxfUGGDqXDyALtbCDKDFodq6OXsuGrf71lZPqN/SGg0HVYJf?=
 =?us-ascii?Q?WP28QQJwnvfbC8Lij6SxUzmNUHjCrv6HVk1FlBVMVQsFed3qoNdt0QSIJpLU?=
 =?us-ascii?Q?4kEHW7yggbGrJ9OXvzYxTKdhQn3cEGLJv/CLfxURED6dP1Rv/+paBTWHBG/Q?=
 =?us-ascii?Q?+ZlaiQLAPw877cYZ8fgmAd4qAPfm9MexmcNjWCKqfLbXZZeEhxWQYmhnIc6s?=
 =?us-ascii?Q?XQk7eIh4uZzKjCaxf7IxPJiYX5k5nPdbZwpqZmKTbSiD9YrN7U1SPtDjRHEu?=
 =?us-ascii?Q?kMrZ6JvXjeXXly4/4S47AgUzPgVGKzwA4cIQndRTpHfBYWapV6we0bCEzPG6?=
 =?us-ascii?Q?0muGi+FlbCFMaGjjBQfx8GVdmGzPPm7U1aI/RIi3kAUUAGdOTAB6Xexpbris?=
 =?us-ascii?Q?mrJtKSbZVMY9PC5auzTfUslCJnlYx5m8SjKnypumuedZFCAlnQpnFtbVGFlf?=
 =?us-ascii?Q?nVP+P65rBIiDLYl84sB+i7R43ph9uXcckIIzHYTAf9E4hH7H+DgeaSj3kBgl?=
 =?us-ascii?Q?dm1tYtVgejjUq9n+wg9ml5HSbTL6Qb4nV17S8sDLK0/eAMyc7pbiqS6+kIpM?=
 =?us-ascii?Q?O608Fht0cZBaqqqlWPUM/nZPZrA8?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kyNU4v+Q35juN+VO+l1W8ggn+Ls1LWfv43SQAO0cdzW6qWanF3ZukCQLj73a?=
 =?us-ascii?Q?JqgKv+V+hZA6cLPVMN62XjEj8kZWYhJK3zSPMmJVy8BTYZ73DohKI42nHHD+?=
 =?us-ascii?Q?52+wGF/f0GJn7VZjJJj6ATKmRDJJQTsuhZgMegp9nECy0U5rqzSpt35RESU4?=
 =?us-ascii?Q?8MevKOdu13zGDIzW43nMziAdqBhEDKEqd7uMqCvlXnR1sMRPxFn6/30l0/pP?=
 =?us-ascii?Q?P2gML2zLHToVCCXDQAiG2diTA/zWgCiXVOQtaU3b6eZxkZcD8QM5E6MexgGI?=
 =?us-ascii?Q?38CVmWeZSZmSn3L3++nhzzVLYZJjSCOPlV+DEjwES82KXscAu8bbmMRxDjVT?=
 =?us-ascii?Q?NyQ0fuhCl1MmvOkaWQPn+07hyTuIwOHzuccJu5q9djthgMaW48fyTww7Da1o?=
 =?us-ascii?Q?WadwwiPOs/Pggv/MMWTxPmMTiynues4WnvapiJezBUX2VQ9qWkZ7JOcGHjSL?=
 =?us-ascii?Q?lEcHJp3cBhV1rCGQSFYlmV1Py4Fb+6BGcLnhs1OqxkLSCvwKVoajouxaUnEz?=
 =?us-ascii?Q?wV70qizBWApwW2E3tnHg+pkkzFfDwxtMqfvXLmGfEkWNUNeyCxgS7hTqqr6U?=
 =?us-ascii?Q?ZnwKBacvwwdHardqev+Gtzk3m4zmL30nG36CPyYI6qAsQSn6pjbYVHnMNsll?=
 =?us-ascii?Q?EApJ2WI6ZhiuefZHX81hAQTpuzlj+KAcvCAxIprh93n5+GveBZwaFTaBKJHd?=
 =?us-ascii?Q?df0DpYGm6aTmk9qR7bXU1Bck0uKPvU5795gG8yrz81lrYT9nj6KDoaVTAHt2?=
 =?us-ascii?Q?bpcwj34kaUrSPMnQGmNRsGw0wd6c+VPWlLMUeDFS6QbE+yhYw/03Cvs6bVbJ?=
 =?us-ascii?Q?WKnd8zL+Goft8ugRSB65cc1Dco4eC+8fHShN14mf8clKZJrZVeBkXw9K0huy?=
 =?us-ascii?Q?/nEBMyuTc5JduBMQQbO+UMWIARfrxeRTn4XR5LXgU5H3o+Uvik82368OEQpM?=
 =?us-ascii?Q?I8w1SiM/GCXwcjdCl2ezLhDVox883yBSS4xR2hcStpjZ6oO/bVPMZGbM9lx2?=
 =?us-ascii?Q?CKiyT/otRk2pXitMl5ucsg1/13Uu8II57LiC8owRWwoknPQiP0ct7ueIIAYm?=
 =?us-ascii?Q?xwD1u3gi3/GokphPcRUfAORjokVfFOoor3AqqWmmZ22yCtxmZQXdJVjeFZsg?=
 =?us-ascii?Q?OFyKXviFlYrqSHEcIUkjK9dHXw5T7WaOvLS67NR3o+8w0pqXnNw1p03GsGye?=
 =?us-ascii?Q?Tij9v6whG6oFhZXAFP4hhTXfDwm/aopV7zmQtYLk53p67rLh58OLKTCVbuqa?=
 =?us-ascii?Q?UOLxhLap/XXHU26gOJFAl1AqkTPN3ixiydXvm6ZnWA0QV4tfNsLvYiZT/iHc?=
 =?us-ascii?Q?oADoL+bh+O9R+4L3kONCKf+h+CzAD4GMcDGZlz5X0gsZDbX93jomsEtxLPX7?=
 =?us-ascii?Q?YKUOsFeiRLFDQDgLc1koGWZYSD+UuLTFJZcKQrm8w1l6e5oC9CyHtGZiSQk8?=
 =?us-ascii?Q?fdhiLkHPFQ431X8vkKGmmH7J5Uye6EiUgTrDxdJIbBzqtSqEtMTuoUKbfP0w?=
 =?us-ascii?Q?rinHHGnjDPEEBfIBcRI1l1A1we6DU1CFpXuaqhgf0RtiDJaQoNIKLQ4DQEAn?=
 =?us-ascii?Q?77zXt9kzSKEI5Bcu2kKGTbBmGizwojblhiz9poQ/?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c80dc062-ea3d-4138-6990-08dd5faac6b7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 08:08:44.2007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akIss4vaKWVtOnLfrBUjg7wchLbSW0xgmg5YBnaB+nNGEPMl9ktq+EZ1pg33bHRAdRPn7+EiZ1gS7/05d5/MBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8967
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Mar 2025 08:08:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18073

On 06.03.25 14:46, =C3=87etin, G=C3=B6khan (FT D EU TR C&E) wrote:
> Hi Jan,
>=20
> I haven't had a chance to try it directly, but past complaints about usin=
g OpenSSL provider/engine together with sbsign's OpenSSL3 support have held=
 us back from maintaining/implementing an custom OpenSSL provider for serve=
r side signing.

Would be good to have that a bit more concrete. I suppose there is some
overlap with what was once done here:
https://github.com/phrack/sbsigntools

>=20
> In this scenario, pesign is used only for import/export of attributes/sig=
nature and this feature makes integration with other tools much easier.
>=20
> Since I observed similar signing patterns and toolsets being repeated in =
different projects, I thought we could upstream it. It is still possible ho=
ok different signer recipes/scripts in downstream layers by configuring it =
on partition's source parameters or installing a different signer recipe so=
 this is not blocker for us and could stay in downstream.

I'm not against making users' live easier if downstream has common
needs. But the way things were modeled here are not clean yet. And they
should not (yet) simply replace the existing sbsigntools path - we have
not enough experience with pesign in the field yet while it broke over
older versions of EBG.

Things I would change:
 - ebg-secure-boot-signer -> ebg-signer-pesign/sbsign,
   PREFERRED_PROVIDER to select, default on sbsign for now
 - secure-boot-secrets -> secure-boot-signature-provider
 - secure-boot-signature-provider should deliver all what is needed for
   both variants: certs, keys (where applicable), core signing script;
   for file-based keys, a standard core script should be provided to all
   implementers

Does that make sense? I may miss some details that you normally only
realize while trying to code things yourself.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center


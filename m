Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9981FC19F32
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 05:38:20 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.77])
 by mx.groups.io with SMTP id smtpd.web11.7062.1741153094273103325
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Mar 2025 21:38:14 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=hk/E3w7S;
 spf=pass (domain: siemens.com, ip: 40.107.20.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azw2+sU1vzhxN0i1EGiq0K9WEA1rhWNoJQwOQA6Irhm/PDI6Klymm5fKHu+MG/ZnO0FGlddBmAeEYh+0jGWAijRnwTTXWiKmm2EiO5nN51QCZzHnGaxyWYJOaaUx+4o1tpztege2gS84ou1X/AkV26aql1WOVy1Wqn4rCrIjiZ9jHwqJnXAIJe9Un1mX1K4SQsMxs/PoqkcMAFhkSefhQKWpWnnK0yzxXEvDlVBrGYgmQeOX3cEYVDs9BXF4NdNtY87JNWHcfhyS6Eqz9ijLHu7OIZp3kTkTBq5QfL0loe6l+Pi0I1hFHOW+ubkVBmNH8K+oj5WK38jpAec0Sswsqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHHMX1G82jck7gnPdmrelpf6UNsyooT/HohP14OOeGU=;
 b=urTbuYKmaS0ldprVljwxWz7BolvMYe5UmQrA+7Q4SIPyKMWjsCcvvT5pCCzQ0MUTmZNO15s1M1L86VVFW0hTJ5g0obrpkpzSO6rlHULKyl1nHvYb0hGwdsZCmy8pAklWGlLhnGniDSME/MzQPPI8OxHZTRLbQP26kLYuBz4OChkvk9YnFanSArDk6DoOlFgrofADlpK8jyr8zF5CXZJAjz8pvLJIB+nLEJWNa7cqNFyoByAlFsKerlE1wSyY0In3LVFjHP0SFWE0mJbmFj4uqOCo0MiNl1gDxnUvuA1qZFy40scBapLcfwFSIvUXrzgdrp9/XZrWIzKyzFw0Rl6NFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHHMX1G82jck7gnPdmrelpf6UNsyooT/HohP14OOeGU=;
 b=hk/E3w7SFxht/ga6fHpNVPmi1NLN9ba2m58nQijdbyze53eVRT9Wgf2r8EaQDKb6WQVpmbwBjThHU/EnI4RUq6RZfjX7vj9xokGrQDi5m/KadUqNjVF6j8cXg7UGLkbrJ1Jv8ORDVuZht7QBO3TjWHbpu3BkYQzYN7aNgOM3FsKHo5VR1zTJuHSuMyBOp2SVLBkJRDodrHHgHmoYJyfob/W0sxJERwgER0PJXGjizC9GqKhavkvWp2COCTL6WGTVXyMvb01bBzURpkobLmlZZS5VbvZjru2dYdtQKBP7ceMwr0GojZDbvk8D4G5qXQ4IrqZDMpC9fuAVkxCb2byZ2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 05:38:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 05:38:10 +0000
Message-ID: <143de2ca-60aa-472a-ac99-e10e24a7e882@siemens.com>
Date: Wed, 5 Mar 2025 06:38:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/2] kas/opt: Add option for not install
 kernel
To: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
References: <1740746806-6557-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <95dd9e49-59bf-44e4-bc62-6e0195d11300@siemens.com>
 <TY7PR01MB14818077A700A2DEE3DB42BDC92CB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
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
In-Reply-To: <TY7PR01MB14818077A700A2DEE3DB42BDC92CB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0296.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c78247-f0d4-4f95-35a5-08dd5ba7ea1d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?62hpF8lAExZ/OcfPyD4UAn0G+ZtEs8Kk4M5MpOb+cS8+2fbvSOC2eVK0ZOwD?=
 =?us-ascii?Q?r0ijZGkZ4+7HCvz5ebgVT+0UmRKKvm1JUjLteOVJU3aFZm4l2MgPB96ChwXI?=
 =?us-ascii?Q?L6pwUEDi63mYxVxCHKkzqZsFsQa8Kjt7MUVtk2wqaAk5PdKCc84C1gBHR/Qs?=
 =?us-ascii?Q?2gpWdST7bnx4ewugCZhSNyVzGyHUJLravx6+aTUQGx00YyM8PahCZ0RSBzY0?=
 =?us-ascii?Q?nVt1k8BQbwrXVgQIcJcQhvB3FvHU/Tvp17LWMOfq2WGnOn33DWfNTh2c70K0?=
 =?us-ascii?Q?BNEDCS8t1v+ZDmGBAerUjhCYryq/sUaLNELwTCzRfB7pGISB9zptFy5TDm2E?=
 =?us-ascii?Q?JUN9Ss/GW3QlIkztwJ9/vMiMm6Cc4B3R24bXFmVJEipoHNKxS5yQ4RbwZnxX?=
 =?us-ascii?Q?L+S7ak3eQQpKSlnHdhlYpwbMXBWgOmAF+gjhzlqbhuASJnGd7HC8zl+JQ+1+?=
 =?us-ascii?Q?1B7eWDU+IFRmaBQFXxbHexetyOiZj5Q/EjfPlwTfgzQerm+zTw0ef2JGnvZ7?=
 =?us-ascii?Q?dvk84h9jVFA3re7uPvjlGQikfuQ371fFBJ12VVBanG5U/PtTlk14C4LrIE8r?=
 =?us-ascii?Q?TgZ/G1n7Kyb7JaE0qsYV4a2+9FEkLI0NafyKG5cgGZh8AUxOdTjv/wUW7/ws?=
 =?us-ascii?Q?V3/KrLlhJKP/yOUmkl0kfPzUvNNFTiugyfaTOP6EjgWQzd9oGsAU0UX/XrI+?=
 =?us-ascii?Q?ZR4Z4+MZYL0xg1VAmuVSamOu5HHcBKJ8/tbk4MracbKD7/A4pahOUTwzNwrf?=
 =?us-ascii?Q?ADhyh5DBhB7dqMRJoE4C5x/a4UeX77LgtkeOShGRG8RnYu+Fjz+TemyTvUL1?=
 =?us-ascii?Q?HZXb9AX23qJNP40d36OLnLshkMLl/cML0ese2iYoSELaHJajWw8jv/3fCUPy?=
 =?us-ascii?Q?J82Ubgl7sGq2ZZVvws6GmCzjczJo+4GTAowWnV6qDbg+1Ez3xaCdYoEmbLbq?=
 =?us-ascii?Q?Mb9dKrMOyppLTKqvGatKDsmZbfV3RISYJFmKtwWe4TQpmCZTGBKQyGY8X/eR?=
 =?us-ascii?Q?f+MmAGZlhMLYzexOv8HZUc9z3ek8KQApO5jMIvk7E+L0OSa4yymVu9+noKGi?=
 =?us-ascii?Q?fpKNjfLavRS9G9/2TVxeEYir9EraoCaYMsSlNGAYrDdVONkwwiovX1mYkGuc?=
 =?us-ascii?Q?FB/1rI1XM9brqKaAiunQawHImUIJMz63/cSAfz6A8wc7tCGEnhHHGWJM2ULq?=
 =?us-ascii?Q?+KcDJwwyNI8Uq6rre8/r8zBKzDGc2W/MZ5gqnhQpjBQkmerCvvjVMxdipIBL?=
 =?us-ascii?Q?HXUFCXu1ge9qIwqedvjm9KuAXxXExJy6u61WY/v5Pm0FUefXXMiSqWNLDTbe?=
 =?us-ascii?Q?dYxw4fueHeMuwEE/ST5HgGxdscDG4n/o4cjWITBpQ7bl5FQnn7RdZzSzR50+?=
 =?us-ascii?Q?nZIZ2adpIQCYx+RKzzE5IoW3+cFb?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?e+Yowp9uAFPIA3k7MV/66HUsT3jzJuh6kkXxd0n084AfyAKWUo9FcdBRWfLd?=
 =?us-ascii?Q?B5Ma6RrOdV5VQwdvFbxnllYMZD9lh1MpivNorgYPHVRkXOD6GHnRfwOw5Fd6?=
 =?us-ascii?Q?rgkxDKiRQwzKSL+H5pUD7bk7cyMGzgDm0+KPKUpKHn98Z0bcMjhMx1p/7nlX?=
 =?us-ascii?Q?l9sURFnR/FcOXWcakdvLZ/DBSori+GFORdyRvO27qmy+qmdHP2T9IbC50m+O?=
 =?us-ascii?Q?/c+kNZ0vzArr4iZgOSLwz5gRL0hQb/qLYHtnqYRZ8wGuHdCx9az9r+NBYWb+?=
 =?us-ascii?Q?6jWqE//3DPVDbnoSgRBnyn2UfIPkeaRcJyC7EFlyv5fqSUtCF3zAv9ZJiWxm?=
 =?us-ascii?Q?gaQBK7elvkRWqA1KObIXH5HweP8KothgmrEdXvkFhy1LAI6mVcoC3hG99a49?=
 =?us-ascii?Q?YsPfaduM+Xg13FP/AUxxJYXYw4skHCXEuxnQPdi7zUF/gctd4d51anqMoMKQ?=
 =?us-ascii?Q?txYe5MEs05UjdQNNmQwsDnFbZXc4zZnAgPrc1C6txkyNuy/9ApmJbXg0wy/J?=
 =?us-ascii?Q?sJwcOY0qxKd0ShaGlJHvK5vtA6uWtaeRfbvqbaEe54VvdM5KMrbBeHxZkVxt?=
 =?us-ascii?Q?7ZoJ+PC53swkof1xhrRHsgox6zxRnIdNobpFhotigILR0rJJTKUASeyceKM8?=
 =?us-ascii?Q?YxpezcUlBFRowBs7boKK1AEs3BzpCqL372R59HsDY7n3As253BmI2I8WSKYp?=
 =?us-ascii?Q?t0bbGy65xseeczEjy3z33u/xvBwypkSKyIV3J/6yAub2Ea9keEOAIAgODe6u?=
 =?us-ascii?Q?lxAOgmRW4aODgifBjl6NVnw8rtXCaivYOVVc664OFEsUQnHWy3/A6jKhFSlE?=
 =?us-ascii?Q?OPBgPycNtxp20uhuTbmKa0TNLjV7PtyCMKjHAsBciqeJQ1qPz+8vCtX1/RVa?=
 =?us-ascii?Q?bl6ZAbMybdYlD9GhkAtZlDccPdiNbvfMtYNmBTXAItNBB4WZgZrf4MhMluJc?=
 =?us-ascii?Q?ofdy+mxRe8Zvc5YX7GyNDSUb+UnE6SYh2puEyyecWuwkkaCcwjA5Vol5VwTL?=
 =?us-ascii?Q?1jvtzmoIHzSEc2VLtJzOOK5grmynBA3EKLjsiY5mzJu7gt+evQRNXHxCvSMK?=
 =?us-ascii?Q?2VVESEE3lhuyAB/ZvQEnyh3exhD7Ppw9+TnH7kyHwWuRWO1IEyvR5YiphcdA?=
 =?us-ascii?Q?JgERDvKu6s4BrZw4U9Qd65suBK+hRU/Z7Bw2zQ/+XqDeHekc68zgQ9/oIUAf?=
 =?us-ascii?Q?gC/lh/bP1afd1c09tS4aAuKhyx2/yF2Bg0UlkrvKHnhqW+fYm6MdtgV9YDHQ?=
 =?us-ascii?Q?/k4bmjaBm1DCOCY8HO9c2YVeOxGn9qqoK0BW4YojEHQHhGVcieqni7MLohjZ?=
 =?us-ascii?Q?7ej45vcR1WJG6SbiB+LytI67n1RWiU+Pv9Tfg4wYX6aDAiy5PwYDV6vDknW7?=
 =?us-ascii?Q?8b0uqvwHeTvCZj0Z6FbxKUq9mXdGypAg4ltW+fJjpM288TtljtKn5nrDefFL?=
 =?us-ascii?Q?qNWEqZWQT9K0AfRCV55iSMXIPns61LcieI7Gj2/1BJHAlajxIwyHeC26xjze?=
 =?us-ascii?Q?u5FKs2r4iEHm/nc5fNA4IEOOzLBLq8F7hTmTHPWPRKawsGAyex0SCOMiE2lh?=
 =?us-ascii?Q?bxSttgMHl/zjxIiCzvCb9RpYTEC/dRb7mZbpJhVb?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c78247-f0d4-4f95-35a5-08dd5ba7ea1d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:38:10.3911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZolSL4YeSp2sJ/7HCrQJ3Xmzh9zKPo0iGe9KG+aGuwZ+5nI4LrehTZzo/aClMbTuUfchfcbabf2F0PqDLu5HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5837
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Mar 2025 05:38:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18029

On 05.03.25 05:45, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi Jan,
>=20
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Saturday, March 1, 2025 12:40 AM
>> To: iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE =E4=BF=A1=E6=B4=8B =E2=97=8B=EF=
=BC=A4=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=96=A1=EF=BC=A4=EF=BC=A9=EF=BC=B4=E2=97=
=8B=EF=BC=AF=EF=BC=B3=EF=BC=B4)
>> <nobuhiro1.iwamatsu@toshiba.co.jp>; cip-dev@lists.cip-project.org
>> Subject: Re: [isar-cip-core][PATCH 1/2] kas/opt: Add option for not inst=
all
>> kernel
>>
>> On 28.02.25 13:46, Nobuhiro Iwamatsu wrote:
>>> This adds an option to create an image that does not contain the kernel=
.
>>>
>>
>> What is the use case? How does this relate to kas/opt/kernelci.yml?
>>
>=20
> This is not related kas/opt/kernelci.yml. This will be used to create roo=
tfs for CIP/LAVA testing.=20
> The current recipe creates an image containing the kernel binary. Kernel =
binaries are not needed in
> rootfs for kernel testing. Therefore, we have added an option to remove i=
t.
> This is also useful because some users may need rootfs without kernel bin=
aries.

For my understanding: When is kernelci.yml used, when the kernel-free
image? For kernelci, we also deploy (not right now as upstream's API is
changing), but that was always with the kernel - why there?

>=20
>>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>>> ---
>>>  .gitlab-ci.yml             | 28 ++++++++++++++++++++++-
>>>  kas/opt/no_kernel.yml      | 17 ++++++++++++++
>>>  scripts/deploy-cip-core.sh | 47
>>> +++++++++++++++++++++++++++-----------
>>>  3 files changed, 78 insertions(+), 14 deletions(-)  create mode
>>> 100644 kas/opt/no_kernel.yml
>>>
>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml index 4df521b..a09eedd
>>> 100644
>>> --- a/.gitlab-ci.yml
>>> +++ b/.gitlab-ci.yml
>>> @@ -27,6 +27,7 @@ variables:
>>>    build_swu_v2: disable
>>>    swupdate_version: default
>>>    test_function: swupdate
>>> +  no_kernel: disable
>>>
>>>  stages:
>>>    - build
>>> @@ -67,9 +68,10 @@ default:
>>>      - if [ "${watchdog}" =3D "disable" ]; then
>> base_yaml=3D"${base_yaml}:kas/opt/disable-watchdog.yml"; fi
>>>      - if [ "${security_test}" =3D "enable" ]; then
>> base_yaml=3D"${base_yaml}:kas/opt/security_test.yml"; fi
>>>      - if [ "${swupdate_version}" =3D "2022.12" ]; then
>>> base_yaml=3D"${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
>>> +    - if [ "${no_kernel}" =3D "enable" ]; then
>>> + base_yaml=3D"${base_yaml}:kas/opt/no_kernel.yml"; fi
>>>      - echo "Building ${base_yaml}"
>>>      - kas build ${base_yaml}
>>> -    - if [ "${deploy}" =3D "enable" ]; then scripts/deploy-cip-core.sh
>> ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
>>> +    - if [ "${deploy}" =3D "enable" ]; then scripts/deploy-cip-core.sh
>>> + ${release} ${target} ${extension} ${no_kernel} ${dtb}
>>> + ${CI_COMMIT_REF_SLUG} wic; fi
>>>      - if [ "${build_swu_v2}" =3D "enable" ]; then
>>>            mkdir build/previous-image;
>>>            if [ "${extension}" =3D "security" ] || [ "${extension}" =3D
>>> "ebg-secure-boot-snakeoil" ]; then @@ -221,6 +223,30 @@
>> build:qemu-arm-test:
>>>      target:  qemu-arm
>>>      extension: test
>>>
>>> +build:qemu-amd64-test-nokernel:
>>> +  extends:
>>> +    - .build_base
>>> +  variables:
>>> +    target:  qemu-amd64
>>> +    extension: test
>>> +    no_kernel: enable
>>> +
>>> +build:qemu-arm64-test-nokernel:
>>> +  extends:
>>> +    - .build_base
>>> +  variables:
>>> +    target:  qemu-arm64
>>> +    extension: test
>>> +    no_kernel: enable
>>> +
>>> +build:qemu-arm-test-nokernel:
>>> +  extends:
>>> +    - .build_base
>>> +  variables:
>>> +    target:  qemu-arm
>>> +    extension: test
>>> +    no_kernel: enable
>>> +
>>
>> Do we always need to build and deploy those extra images?
>=20
> It will not be necessary every time.
> It will need to be built when LTP is updated or when a point release is h=
ad in Debian.
> The current gitlab pipeline is not that well thought out and I think it n=
eeds to be considered.
>=20

If we do not pick up the artifacts automatically from a pipeline build,
we can make these variants also manually triggered. But I still need to
understand the apparent overlap with the kernelci builds (which happen
unconditionally so far).

BTW, where is the riscv64 variant?

>>
>>>  build:x86-uefi-secure-boot:
>>>    extends:
>>>      - .build_base
>>> diff --git a/kas/opt/no_kernel.yml b/kas/opt/no_kernel.yml new file
>>> mode 100644 index 0000000..2338177
>>> --- /dev/null
>>> +++ b/kas/opt/no_kernel.yml
>>> @@ -0,0 +1,17 @@
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) Toshiba Corporation 2025 # # Authors:
>>> +#  Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +header:
>>> +  version: 14
>>> +
>>> +local_conf_header:
>>> +  kernel-version: |
>>> +    IMAGE_INSTALL:remove =3D "linux-image-cip linux-image-cip-rt"
>>
>> KERNEL_NAME =3D "", that will also disable the now pointless build of th=
e
>> kernel.
>=20
> Thank you.
> This is simpler and better.
>=20
> Best regards,
>   Nobuhiro


--=20
Siemens AG, Foundational Technologies
Linux Expert Center


Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13B6C3ABB2
	for <webhook@archiver.kernel.org>; Mon, 16 Sep 2024 08:42:42 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.57])
 by mx.groups.io with SMTP id smtpd.web10.4181.1726476160920781554
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Sep 2024 01:42:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=dcAXgvpy;
 spf=pass (domain: siemens.com, ip: 40.107.21.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4dDFvqkR1j271Is9p4FgslgpakGHlCPZgZKHkmzsSelvPQ6ikKiIUS+ujOE+OpHT4J8TkE86jcCUUpg9ZjeuMWFMdzkpMVDFP0pyzdoITz1Xbb5iqHJilJXA5d26Zf7bg3dwZeXkAI2rYei42DwM0n30NDy7ygpe+qaPeGVSEuW7hNIm/Tr/T90pqufAAYbPaA7JcvtdS7Mktc94gh5sm6XcAlm+K9ZgkcSFufIj7L6XgZU18LqAaGT1aZy7pftijVhBbIuD/zdsmtNkZydrEVA71Bo3T1qjuyte/QYMxWcRQn18CuG9hZXre4z2PJr1qs3/uTpmBkdSPr/zmwujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fx46ofqQmrq7ussg2Gq2l3yH74yNpD+gx9RkafbqefQ=;
 b=O6HhIoDvxMB2OslmLORr6gvRsfHPlz5fOa2h7UCBHbCeNMW/u+rX2B1uSKWzNpweVg6kgDqKOyFnzpY25ROhRq/ftVeVnDuPYbt+vtrDaCMLlYH3inim28VxvMA/liLMLIz2UkUUTFzxt7z0UpL2qDx2x5KFBXwwJiFevPZZ88DWZJkiuoLaDgTEmPPKxcX5lrshRqZM6RfQmtONL3EomyHK3tX5eH1Nv6hi266tRSUwrcEkTsnstxiPFlZh1uqeVq+DN8YRV+OpRs0sXBiDVG2Zc+E6r4tTtRhg9+B5ndydfcUKxgCxq1S6ZBcl1vQoB2+o+6EmyftPjax2TbwgEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fx46ofqQmrq7ussg2Gq2l3yH74yNpD+gx9RkafbqefQ=;
 b=dcAXgvpyVDValODraes9mZ+1cr70WSkAlNgEGJh+J+WWKw67BUaYcN7x2drv7S5j8lfNR2SEI7mNPV2RIX927HLCLB6NUlJt8C5aQ3dSRhlqv5gvz67IGFTFXq8k1W5+3MpFYf9jCtMhJOsrsFVOJCOd9m7mvMcxKekRSAVr0yDLew0wN0vVnW3TTzdO4dvz0fitYequuFlUORWPPpsuBNKp/7zGsiccXBFTCveKh2oD2r0pgZBhnROvMRmdNBRDz7fZLIO0YPF5jCCi2q/kbBmFujZ5vJzHuJAewaxRyg3PDhgSzxRofO7rqUtoQ08S2z3Etwed0htPuDBFbtWxlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:216::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 08:42:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 08:42:36 +0000
Message-ID: <d6d03dc6-832f-4441-81dd-eae58c6d1eb5@siemens.com>
Date: Mon, 16 Sep 2024 10:42:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 3/3] Update README for swupdate
 signing
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20240912100710.3183806-1-Quirin.Gylstorff@siemens.com>
 <20240912100710.3183806-4-Quirin.Gylstorff@siemens.com>
 <536b5af253b015771a620fccec26def972331e5d.camel@siemens.com>
 <731e67f7-d18b-4e97-9f87-509fdbbde06d@siemens.com>
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
In-Reply-To: <731e67f7-d18b-4e97-9f87-509fdbbde06d@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: b8dae60d-cfd0-4228-b1de-08dcd62b83f7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TcmKrAPO1PDHGfXlbC+53Fj8G4nOgXov0p5excndCp70cSJVmc5eDE/7mH7Q?=
 =?us-ascii?Q?DxqYuui1CHILRiUqkzqDLwOTUxq+LONIGX8/zq2ZXg5wyL51eocfgyUshAz3?=
 =?us-ascii?Q?NCtxwkCmIJeIDQRFqthfRhWsjm9eC3MISb+o426iwPXOuKZryqRXobAjyXzL?=
 =?us-ascii?Q?/5hceiEeqwm0ea8e59P3xmYLKsneEmvPVJfHrIKec+Q2tW6ipZby8q299v2h?=
 =?us-ascii?Q?C/XTGUaBdc0qpV7tCY+9J9TOUdnLYSBu7IV3ljC9asWadPeYlRPZ40u6UZpz?=
 =?us-ascii?Q?GxwVFbmb3HQQPLIzfA9O2bu9TX8QaLbAP1FpFzWy1QngNqf8tTp4R7MkxW+k?=
 =?us-ascii?Q?XWpN33OmRSP2wVQuGLUvX0C1mjw1f8Su0NIhOIFbT/wfS1VBUb3BqiwAd70M?=
 =?us-ascii?Q?tYoOVoUaogfxFCOi3kTXKyzkJHneoS1XZdsdSie2rY5DssFsH/xDyYQjH7Im?=
 =?us-ascii?Q?QRa+lFdgXl/BxPauYA6d9QspI+6I7CmD1S1GVVWCTwqUjZYNz30ppUhGE40Y?=
 =?us-ascii?Q?4c+gkG45QFPOn3HZ6GtDA7QD1TWk/nTVYYugK01CNxEgzVCoY/8aPYnTDCnx?=
 =?us-ascii?Q?XgRt+E/SFbHoPoitiJ11E9uED2lcfGqbA10NIYUvM0w0RY87AC0dEbBf5eyU?=
 =?us-ascii?Q?akIUP3fPKbYkK0ibTTbhmU9hVWQ2Eg0KWKVYHP3t1fa9iFv25OEinkqRleoF?=
 =?us-ascii?Q?jFKBZIQQx+++Qnoiu57wXuntszIXt2U+dd2U9g1Sx5lj40VbrCYIP5/Msu89?=
 =?us-ascii?Q?bW0AoqJFYOGVrN2irGHZT7d4JwknkFlHF+1N/Asb8wBobFdNdxTwZHe2f2yo?=
 =?us-ascii?Q?xAVz+JnfJJF+o3Zi+LfvUE27BAxbUtWN/VKaA03FFpyX63SXRcMCN/WdE30Y?=
 =?us-ascii?Q?ChH8c0FcZW+sAYkSW4eDraWt4Tk6PpdlVkmviFArqGTQI4h4gE4usF5HCRLC?=
 =?us-ascii?Q?WpFW5rrFQr1udCwXjAm+TJAnsR2XmXf9DSi9MWkwqlCfsBJw91JkyEZkUnyA?=
 =?us-ascii?Q?PFA3akWatENOcLOtkUpL4jLf69ciBeOmHuqP27D0rUbL1K6HaIU5lLSf48dI?=
 =?us-ascii?Q?sUVM4ht3ye2rgmnNs/fygHwCHjO3CsCH8kOGE6Chnhf8FwpgJOlbks8w1hnp?=
 =?us-ascii?Q?djsJ4j06CkANaGnV35SZJbsS+AtGl85ymNSuvh6PXRIwFYmzPIE0qEWuFBEJ?=
 =?us-ascii?Q?+wIbIu1lD/BwJQrenyK+LUzsWSHYhoivnxW403qOE+mG4EWxW2eV2nGB2i0v?=
 =?us-ascii?Q?f8k3UP9YHOFeSGhoMMvnGC4A3P9idz5FW8aTEIVkttI1L5PB8Yqk5+/BEhHX?=
 =?us-ascii?Q?RGIUPsmfKjIk7FSHZ120whR5SnEurZLeYk+g4AQfVAIakw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5z496VpsmZf228+tafExB0u6bV7kQmryli+/9wITGqB8zpbVtjgLC120NYsc?=
 =?us-ascii?Q?xPNqRFt5Os5WEQlOeLBCIrY0QecZxfw3lv0b6SD3OHz05F8e+yPPVg4PU9c8?=
 =?us-ascii?Q?KXcSuM6RcY4MWU4ek7/6tnTYg0kEI5Kjv+alM51prmv58vGdd+xUKg4/ezZG?=
 =?us-ascii?Q?l0e0IVbX/BzBSMcUcJ02/9xkiwDv+bvmD8b4B7A/8+woLOcndSddamBVULAF?=
 =?us-ascii?Q?4loH8vcvabRkw0y6jsguUc8U5DJoW8GxXU3kiDV3I62oomWOkWjXDs17su63?=
 =?us-ascii?Q?XeSY48PcbrjHXNqGYoM4Jh8RBDEeIlqsY9IVYvDc7TbL6OuZErCHiPHdqZP1?=
 =?us-ascii?Q?9IlRrUL+CpzrN2QYGM2MDZciuqay2w/2V8t8y8ZJasQOOdavqw4Jb585uGgN?=
 =?us-ascii?Q?L8uOlTlpz6TBIIP1xi8sErp1zBIx5HVElEDOOSkHtoLWy2nhermzYVkuCSMh?=
 =?us-ascii?Q?jC6q+2ArNIGjYSTFx8PoOgE2zzpsTcoLPv+WcXYliC9O3czO9rxQ0C3mwQfJ?=
 =?us-ascii?Q?Ag1j3MoebiN1jTNahyuS873Qlw1bHWI72YW3jMfavcX/oekv/Y9j5yddm8FA?=
 =?us-ascii?Q?KXEOSEEdv929ZT/tIpYp5lFKXKmpgTPblB/A3N8A/zHbCMGGqw0A5tc6uw5e?=
 =?us-ascii?Q?PW5mJiSQkqNLiJVGSWJRdTTvKJUcvCAB7tFhjiNJxqim8rPVDWtxVLkTBvgd?=
 =?us-ascii?Q?fWXkP0KHoW/CptgITiGCGhZyUL8ej9zNL4MOMDqeQDhyGAyuuL87OVWLmghn?=
 =?us-ascii?Q?vJZileTHPyVGnjCwiBqxrJmJflCuqFLwP0rd9+E5txa/iWMVT3xywUmxzeoz?=
 =?us-ascii?Q?vZD/q8KTASk4ODsJDw1HJ5S8XCnTdS2KPiCt2aRG8utA35XtXvinEOINQV0J?=
 =?us-ascii?Q?0Kl1pNvrikN3wndU6bcF9ER8Y0fF6uN9F9VdUE+IR7z0oiPeNlQfJgA3A2I3?=
 =?us-ascii?Q?ngPdY0XV76Q7dXghWab84eVu2NTvZ8eh+rbWPXc4U3gSh+aZR/4+MJJYP6YP?=
 =?us-ascii?Q?HgdG2udM6rstR+kvX+9voEvL87tHoJ5NiOQ0ArnWDhakawUW0JTCqYM3lUQN?=
 =?us-ascii?Q?PwHmHiKnbkQRZXwYr+edniyQhoW3C1vQDUGXxnR1zgEq6Kr9ei2Hc6dTnXJv?=
 =?us-ascii?Q?KhMDmzem7zJgyIDnAD1zTg0iCYCe1Q1uJmb8ZVIi7Oeer0UkVGEd8G1o8j37?=
 =?us-ascii?Q?R16+WXCa9OlJzOhfNNHIK7hKXPJbU/6OQFnzXhvjAmZq9J81ZnQ4pMGLrT9O?=
 =?us-ascii?Q?kyHP4+vyjIxQJagIggABS2YGXE0Y8nnVrciBkudYXp16k3X86UAAhSTXd8+P?=
 =?us-ascii?Q?ZDyX+TVbzEEmhON5Y+/9vGuP5gTomNE+V51WnY9GqvxGJWzRBLuBHS0n1/eW?=
 =?us-ascii?Q?/OQJpuKXL0LRR93wDQiNmkdf9vqM+mqEyIY6BOT06Z7xTOV28X3WfkO67u8D?=
 =?us-ascii?Q?HA2X8Gpoob/ZtpsscffvtVL/8GJfc66P4bOefLgZ5dcmygf1K6EGhd3vl213?=
 =?us-ascii?Q?0W2Uv1UmZvj8OOOBCNsFNrJswphor9bAESiV9TMe5qNgP28hNKrJaWuF0dIn?=
 =?us-ascii?Q?2D4ZJttu5XNkwgMVuUUU1uhb5SUic1vz79pk0ojW?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8dae60d-cfd0-4228-b1de-08dcd62b83f7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 08:42:36.7047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3wzosJLPm12HNFo1SWW3xPmESVKaLwtszLgtsUfT7hvm0VrfABeFFtcVprXm1v2VhLSUScIoxJdKsFGY+I0kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8953
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Sep 2024 08:42:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16900

On 13.09.24 09:55, Gylstorff Quirin wrote:
>=20
>=20
> On 9/12/24 4:08 PM, Moessbauer, Felix (T CED OES-DE) wrote:
>> On Thu, 2024-09-12 at 12:06 +0200, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0=C2=A0doc/README.swupdate.md | 13 ++++++++++---
>>> =C2=A0=C2=A01 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
>>> index a5fbab9..d4d0851 100644
>>> --- a/doc/README.swupdate.md
>>> +++ b/doc/README.swupdate.md
>>> @@ -136,8 +136,8 @@ To use other key and certificate the following
>>> variables must be set:
>>> =C2=A0=C2=A0```
>>> =C2=A0=C2=A0PREFERRED_PROVIDER_swupdate-certificates-key =3D "swupdate-
>>> certificates-key"
>>> =C2=A0=C2=A0PREFERRED_PROVIDER_swupdate-certificates =3D "swupdate-cert=
ificates"
>>> -SWU_SIGN_CERT =3D "<sigining certificate file name>"
>>> =C2=A0=C2=A0SWU_SIGN_KEY=C2=A0 =3D "<siging key file name>"
>>> +IMAGE_INSTALL +=3D "${@'swupdate-certificates' if
>>> bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>> =C2=A0=C2=A0```
>>> =C2=A0 =C2=A0=C2=A0The files `<sigining certificate file name>` and `<s=
iging key file
>>> name>` need to be stored
>>> @@ -145,8 +145,15 @@ in `recipes-devtools/swupdate-
>>> certificates/files/` or in a path defined by an bb
>>> =C2=A0 =C2=A0=C2=A0### signing script
>>> =C2=A0 -The provided [cms signing script](./recipes-devtools/swupdate-
>>> certificates/files/sign-swu-cms)
>>> -can be replaced by setting the variable `SWU_SIGN_SCRIPT`.
>>> +The package [swupdate-signer-snakeoil](recipes-devtools/swupdate-
>>> signer/) provides a [cms signing script](./recipes-devtools/swupdate-
>>> certificates/files/sign-swu-cms).
>>> +When signing requires a project specific signing script,
>>> +e.g. for using a hardware security module(HSM), an own package can
>>> be added.
>>> +The package can replace the default package by adding the following
>>> line:
>>> +```
>>> +PREFERRED_PROVIDER_swupdate-signer =3D "<own signing package>"
>>
>> If you just specify this, bitbake complains about not providing the
>> keys package:
>>
>> Consider defining a PREFERRED_PROVIDER entry to match swupdate-
>> certificates-key
> In the section above this own
> PREFERRED_PROVIDER_swupdate-certificates-key is already set.
>=20
> This should only happen if you set PREFERRED_PROVIDER_swupdate-signer =3D
> "swupdate-signer-snakeoil". I can add a code section where all the
> variables are collected for a snakeoil signing.
>=20

So, there will be v3 coming?

Jan

--=20
Siemens AG, Technology
Linux Expert Center



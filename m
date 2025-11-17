Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90DBCEBF61
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 13:46:53 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9690.1763387199090043927
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 05:46:49 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=QRsD7Lqt;
 spf=temperror, err=temporary DNS error (domain: siemens.com, ip: 40.107.159.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yp1nHmw4IYKjp/Bt1lEpcN33LSxCBCrN708E7i2PJKVnnjg8BGAgqsLchoVUQxAisvmDOCgJDlHVTzqsEk+N9clLStvsgvqFh9Lt+kihbdP+dquRoyBj1fs0AuOcOyWpcy3N5phYJB+h2KRpQSVd6wZDyFRLM2GXueP7dj8J2J2qA6k48Itu8UJW2iMLrGJ3nnfeFJW1etxhFPxkatuVvDkbeyplVGwXYRoRWx1hfu/6TOZsyiq7idZSCeVaMXZONBChQ6OMzR/A7upad5IIX28QdDlyUjFcLxgcDrphWbLZ8sU+eKTsIciP63gbg18/ol+85/Ds9/3O57I0Yv/Quw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/TG2KSKsaktP3Dv5EnRc9t+3YnzhmB9LGXIySOVd/0=;
 b=Dtbp9z2urIVHrbWEXNVktCltdHzZj+whq2htHAiGp1LKyWHnMzXsVvgnZQwHJjdjt7iYBzqKPehSnhRewgbdjTmpo4RZHNZmwo1wajTlxRsA7+kCLvgLPjGOKvJyaY1XcZeca5yzrYmhWl/vYfa1mBq5N3wC81iXdbLGfRPgnzDTyacIjp7GkBJR7yxSJLD79/SEj5liuK/uHWFqAhWwgHCOaZEzmHRqOZ/HrVYzsPUHsXFW/V2oAw6iH3pRFsA1QCtKHPD6QtH/ydfieWvrVFP8MKKhKmnnb035qvFBJIa5j4NwXA5hpnzcKl518SriTmOwptfCHIib8d2ZGaqfDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/TG2KSKsaktP3Dv5EnRc9t+3YnzhmB9LGXIySOVd/0=;
 b=QRsD7Lqt6dG7xRgvxee1wAwqeo59ifNy2Xt6BJxHc8L7islGB6BvoJCyiELdPfJajT6zdbD94qH33a7xInpFVSRCF5AC6fH+nxjBIzc90GoeVVYkHolf8SWhuIMEKyy4wYGTaTvdK8r1InGh04CdBwWSouTpqZd5t9n9Ug9+M3Ohw1nNoySWHGy4PB4V6g3nhCr93gaefcoluAenFouZvCGgs3cIdzBSBIYND+TUQFnW2lV55Jd5dm7k3m+aQiS9NKIvfIf2UL3Kz/spkr1SlxE7wi8OdIHWF3UeuPibpDOcQsJ+1G6HUQosrHzagxrwG2Qeo710lKPxnhjxuXizfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5720.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Mon, 17 Nov
 2025 13:46:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 13:46:22 +0000
Message-ID: <3c30e594-f15d-4ffe-9bfd-dd3106eadccf@siemens.com>
Date: Mon, 17 Nov 2025 14:46:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Testing on hihope-rzg2m
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <a0f4d994-2f70-4bad-b823-b3bf1a373fce@siemens.com>
 <5cd84b25-4709-4813-9d38-2652810874bf@siemens.com>
 <TY3PR01MB11346468D1012CFB886455D8286CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <52e217f0-5cbb-451d-ad56-4c30927b99f3@siemens.com>
 <TY3PR01MB11346CDEF02F029DD1B64560786CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <70790d7a-1ac9-4c7b-acc6-2ee4edc4a472@siemens.com>
 <1877EA27D24C204E.1114802@lists.cip-project.org>
 <TY3PR01MB1134685CE8A4BD38F73A0C1D386CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <80ecb9cb-2b48-46ec-b92d-090898097f5b@siemens.com>
 <cbf91714-ab26-410f-befc-f43ae2840b56@siemens.com>
 <TY3PR01MB113465454940A82FAC538AA8A86C9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5d00d5d6-5b13-4ecb-bb9f-e3724d96e6da@siemens.com>
 <6917d2e7-3445-46f8-b2f5-16e2054f232c@siemens.com>
 <TY3PR01MB113469798E540974DD8DB122286C9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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
In-Reply-To: <TY3PR01MB113469798E540974DD8DB122286C9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: f35fdf1a-cfac-4a95-3b6d-08de25dfb16c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?SFwzLkApb5sF9CCEk2H0RNMMnuwzZOvuMbBeR9W/Vf2yWfNfoJhPZS5z5W0H?=
 =?us-ascii?Q?AFpCx0JkeYhbU0VUPuPup7WeuBThTAUYcHU7fb4T4ZjMdZg1iQ4AJ5v4wZ16?=
 =?us-ascii?Q?52Yr2/LalsqY1HopDbzbs3+eY9NIDDDcX1m+LItKWWMFz0e2ccfw1ZPsp6gv?=
 =?us-ascii?Q?senCikZMAXq+uO53tc6eDrrvRLCQisr3+I0JKFwhX59xpaLL4sT8iFfYiMtM?=
 =?us-ascii?Q?Lr16pb1dcJtx7bsZ5TPaeJgbfMXABKSFzf2x2hsEHrTCziCLSkcNUlo1rOkC?=
 =?us-ascii?Q?dykfm/2oO3OUv8tJqdHXPfyQN5mTJNYcAEa/DMxcCanc9S8oIbCW5QR3y2sg?=
 =?us-ascii?Q?JIXRndESp+U0NXhQQPhcH93/vZUYAkbAuNJHJGWWTfvCLVWRp23oyCVO6Vos?=
 =?us-ascii?Q?E67PZT7gWYLp6B/Z2NMF7y7XIKiWO+n7L1ep3mpgcjDvGGsHZE0spggA68Wb?=
 =?us-ascii?Q?G186j+IWQhe27XX8fINDx+90YqmXlAjjy4EV3HrMAAygDukee6Co/KWuDpAE?=
 =?us-ascii?Q?23fmZiEtHWVAjT3UGXosthwuQ8nGTL4lvgm84kBxedqx3upq4ahnCpR2TgRh?=
 =?us-ascii?Q?BdMw8EU+6kBerXGtLliexR+ISJw73RMgh9ucfMhJ1dyNzqPj+iVfnoZ3Iznn?=
 =?us-ascii?Q?mMKfZOnOZtOwLBJbLYUzr4ntbid4zD+p60Xm6UvSte1DFmNiidUy33CiNK6A?=
 =?us-ascii?Q?fCZlT9tkL19il5dQxNGuNO8yHHIfj+3WOP1CddWmjcMG8mVSMi9joR/2vLZe?=
 =?us-ascii?Q?9uLO7APvJcT/BGpchYGCA3vcaq9L9dgzOpdX26QKpE3rO12KI+Uh9FzqL1yr?=
 =?us-ascii?Q?JronN0i7ZPbHEqhFIGwbivXCSIWBYqSQy5KXlB5/DRQHIrH8hIAGjr4dc045?=
 =?us-ascii?Q?DWDwVzaWy5DDVcDvqQ1eo/AsCJ9IhuB+RamexyBcQXYWO9YbV+85H8JHn7tB?=
 =?us-ascii?Q?rW5xtdlJW+RH9LBYT8pX20vF08dLyQrwlhDvsYFZaWTK8OWqjl13HkVxmwP5?=
 =?us-ascii?Q?m7qinbtFQ1SP3P1inU2RfQuLQdq3/wub/1zfk/X8LbaKZx4BPU+m8qIh9m8Z?=
 =?us-ascii?Q?Tr0POYsSGFsM84b0ZBBgvRk/PiXHaFxf+DQhLj1+lpiqO5Q2arRDSeEG9DiH?=
 =?us-ascii?Q?WYzceX2vFmAAtWjy5FbmDM62FDkHxNMTbDeQDVRgnCUHgq+EmCk79vmYgGvF?=
 =?us-ascii?Q?qiHhckAmbIaZbPbp2GHKqDC44CEDClKw0xfrB4T3Sznx36mYruf25NyNE3XA?=
 =?us-ascii?Q?RGSSPvnsDBWT5MyMJFWK6ky9Fbpm2BC3b95DhIxqPiVHFCdIFO/4BjwX8qvJ?=
 =?us-ascii?Q?gzLcfovPK79+v8MNWpf4esK3ujn6dNgB6P/WdZ2bPxuoS6tJjLa3CnCcSEV1?=
 =?us-ascii?Q?jY0Q439J9OuX1lGZVJFa5BszdBeG+1O2o17WPBvmUHD9npj0ElOqQSQUAezJ?=
 =?us-ascii?Q?+yJ7eCEcIF9UbyOn/vH0VE7d8tEamwE1?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DSHwAgrpUEf4mefo4qsWrDYctXeLmpLr6inmYc8svAZdzjrK23KJL8jsZHsk?=
 =?us-ascii?Q?zNLCBwR6ZOjOfLRbS1PnGKPs8j922yMfNHSerxvzlDvPZVRv50tIyjFMr+0K?=
 =?us-ascii?Q?dkesJAVNOKUivtUXcgmmnWQlgn+8keaom/ppyDa7QtoZKdWHIEuBanI4CprL?=
 =?us-ascii?Q?UzuEtwE+cU5/gEcr8ZD+k7HUhZxM+CwWrDl9m3Gi3f22tOspoQvA7/s4Q+UX?=
 =?us-ascii?Q?9DMNsM92jqDN0GRDrGCFBOQ3e6YXmC12ivpctFsydlRmAFz2wQmktaOUYlNr?=
 =?us-ascii?Q?teAKombgkidccWB+1Cltyy3zOggR4hPmuirHg04Mr4RV61SErrhwMh3pQK7k?=
 =?us-ascii?Q?0Gcheam28lz9xP//uKUEc1kotIS73D7p8NG42vIbnnDUU+skmxjnmfohe96e?=
 =?us-ascii?Q?J3SD9W0ydaUhptGFXgc7NfDdF1iKZdOKpTUaMao9RYSgdPWDLm4Q5HV23EI5?=
 =?us-ascii?Q?uVn/PZ4Q0ukwRmNpttPyZ7VJH9MG1AHyAF+47npMia8cqIEXIJgHXRNFUERy?=
 =?us-ascii?Q?Bl8VnafBrLXEaDxmu/7Ef5lT/g7gS79+pbmrEw/0bCh0MKV2GYTdhom+yA35?=
 =?us-ascii?Q?SN3Gjo+ogFuw92VYMLYJwVo5eTpVKqvWG/hcQzpWSMmodY2W54nWyRoZhvL+?=
 =?us-ascii?Q?yTLVTC0i1iK9aeJjrhLyYGPoXCztXsF66t0bFyevKz7P7H7lUr7v1nV6NXII?=
 =?us-ascii?Q?JiUGdYN5Ws/q4AHUlbUg7JKxcjbx/yhzMu1craOhCY/4+3UsMKA0huZi1F4h?=
 =?us-ascii?Q?jE24kVbauIS3989vciskoHQgi7WlX9fI2hYY5mSuom4Hwz2enO6CyK+IcvVA?=
 =?us-ascii?Q?2DtDe84i8uDzCM9tVtBoNuOAwQbNXXyNSg+mlt5SBz/csHbInzjdNbDjQ7QJ?=
 =?us-ascii?Q?iBUJVea9BitXtyrgitt6/ZaJ1T4kead7wvT1OZZbdJ9jF2Njhm5pj8HubWnZ?=
 =?us-ascii?Q?fvINxvX/mskyZYit8peqUa1R2jQnNPudPQoPEG353u6i48XNL6ntReOymxYg?=
 =?us-ascii?Q?/CWHG4ZZpoIx2rMfvWjubNpy+Wcdh3qErxCgHcAXM7EfEJG2o1vFsBATwMMq?=
 =?us-ascii?Q?N12aqlceCNbl6u4mYnvPfVhRqocOfm8ZK+LDw4s6TNscSrZwuWmBFdiWWf04?=
 =?us-ascii?Q?5QhhKwIpviPY5sk7w78Yq+y7MlvRGJDWONqTQxCfqtudRGznAhj0CE86w39S?=
 =?us-ascii?Q?UZssUM50Lid8CR8K5Q9GAH3s3LcaoTJ2f7k6C8LQr+unXYtiETJJUO6TBxa7?=
 =?us-ascii?Q?89Z7DTfvB/WIyjzh4uRVY+d1Qoa5Dgdo79RnU4MSaBXiEoFiTlWf33zE1s31?=
 =?us-ascii?Q?BPNlMhYX3V2T6zvWGBlxe520FBU//Y3HGu9VWaUzrb7NX0Rg/bKZSF4DHCor?=
 =?us-ascii?Q?kl+aGjeT+vOGISdVyhnXm2qH5G4/LT5IuHtXKqEIg59dgQ+tWDp1XG0uV/eD?=
 =?us-ascii?Q?zS4h9q49vYQYDUhhbgjFHSFkICHUTq38SCBTW+jABhVHK/acXT/jeveMeW0Z?=
 =?us-ascii?Q?ExGfovg74KkSGIIsVUE7UVVyRwIYhOuMxp/MbsSJ9DBmPol32srRWdXCJTQn?=
 =?us-ascii?Q?ck78klMJeJ8lDhsoiCjVoUeT7idsE25Fb31na7T28Eu1V72PetsZFsi3Ckpi?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f35fdf1a-cfac-4a95-3b6d-08de25dfb16c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 13:46:21.9565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UlAlVYREnPuP7ShOTUK4FFsaVUKbOc5FTNBVqpp6F6QfIBaXe7/gaUzK4cX3Nn+mjwCV8IgRuCWAwqLNJAnFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5720
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Nov 2025 13:46:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20585

On 17.11.25 14:42, Biju Das wrote:
>=20
>=20
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 17 November 2025 13:17
>> To: Biju Das <biju.das.jz@bp.renesas.com>; Chris Paterson <Chris.Paterso=
n2@renesas.com>; cip-dev <cip-
>> dev@lists.cip-project.org>
>> Subject: Testing on hihope-rzg2m (was: Re: [cip-dev] Testing isar-cip-co=
re on the iwg20d)
>>
>> On 17.11.25 13:22, Jan Kiszka wrote:
>>> Now I have a somewhat similar issue on the HiHope V4 RZ/G2M I unpacked:
>>>
>>> U-Boot 2020.10
>>>
>>> Wanted to enable EFI booting, but U-Boot is likely too old for that.
>>> If you happen to have an image for that thing as well, that would be gr=
eat.
>>>
>>
>> As that u-boot lacks distro-boot support (sigh), I had to emulate that m=
anually. But then I got things
>> booting on 6.12-cip (cip_merged_defconfig), though with quite a few warn=
ings and delays:
>>
>> Starting kernel ...
>>
>> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x411fd073]
>> [    0.000000] Linux version 6.12.57-cip12 (isar-users@googlegroups.com)=
 (aarch64-linux-gnu-gcc
>> (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #1 SMP=
 PREEMPT Thu, 01 Jan 1970
>> 02:00:00 +0100
>>
>=20
> Old log from 6.1.y-cip:
>=20
>=20
> NOTICE:  BL2: RZ/G2 Initial Program Loader(CA57) Rev.2.0.6
> NOTICE:  BL2: PRR is RZ/G2M Ver.1.3
> NOTICE:  BL2: Board is HiHope RZ/G2M Rev.4.0
> NOTICE:  BL2: Boot device is QSPI Flash(40MHz)
> NOTICE:  BL2: DDR3200(rev.0.40)
> NOTICE:  BL2: [COLD_BOOT]
> NOTICE:  BL2: DRAM Split is 2ch
> NOTICE:  BL2: QoS is default setting(rev.0.19)
> NOTICE:  BL2: DRAM refresh interval 1.95 usec
> NOTICE:  BL2: Periodic Write DQ Training
> NOTICE:  BL2: CH0: 400000000 - 47fffffff, 2 GiB
> NOTICE:  BL2: CH2: 600000000 - 67fffffff, 2 GiB
> NOTICE:  BL2: Lossy Decomp areas
> NOTICE:       Entry 0: DCMPAREACRAx:0x80000540 DCMPAREACRBx:0x570
> NOTICE:       Entry 1: DCMPAREACRAx:0x40000000 DCMPAREACRBx:0x0
> NOTICE:       Entry 2: DCMPAREACRAx:0x20000000 DCMPAREACRBx:0x0
> NOTICE:  BL2: FDT at 0xe631d8b0
> NOTICE:  BL2: v2.4(release):v2.4-234-gf9bbb5d7b
> NOTICE:  BL2: Built : 13:21:17, Jan 18 2021
> NOTICE:  BL2: Normal boot
> NOTICE:  BL2: dst=3D0xe631d000 src=3D0x8180000 len=3D512(0x200)
> NOTICE:  BL2: dst=3D0x43f00000 src=3D0x8180400 len=3D6144(0x1800)
> NOTICE:  rcar_file_len: len: 0x0003e000
> NOTICE:  BL2: dst=3D0x44000000 src=3D0x81c0000 len=3D253952(0x3e000)
> NOTICE:  rcar_file_len: len: 0x00100000
> NOTICE:  BL2: dst=3D0x44100000 src=3D0x8200000 len=3D1048576(0x100000)
> NOTICE:  rcar_file_len: len: 0x00100000
> NOTICE:  BL2: dst=3D0x50000000 src=3D0x8300000 len=3D1048576(0x100000)
> NOTICE:  BL2: Booting BL31
>=20
>=20
> U-Boot 2021.07-rc5-00010-gb7ad721c83 (Jun 30 2021 - 20:43:24 +0100)
>=20
> CPU: Renesas Electronics R8A774A1 rev 1.3
> Model: HopeRun HiHope RZ/G2M with sub board
> DRAM:  3.9 GiB
> MMC:   mmc@ee100000: 0, mmc@ee160000: 1
> Loading Environment from MMC... OK
> In:    serial@e6e88000
> Out:   serial@e6e88000
> Err:   serial@e6e88000
> Net:   eth0: ethernet@e6800000
> Hit any key to stop autoboot:  0
> ethernet@e6800000 Waiting for PHY auto negotiation to complete...... done
> Using ethernet@e6800000 device
> TFTP from server 192.168.10.1; our IP address is 192.168.10.5
> Filename 'RZ-G2M/boot/Image'.
> Load address: 0x48080000
> Loading: ################################################################=
#
>          382.8 KiB/s
> done
> Bytes transferred =3D 37292544 (2390a00 hex)
> Using ethernet@e6800000 device
> TFTP from server 192.168.10.1; our IP address is 192.168.10.5
> Filename 'RZ-G2M/boot/dtb'.
> Load address: 0x48000000
> Loading: ############
>          381.8 KiB/s
> done
> Bytes transferred =3D 57904 (e230 hex)
> Moving Image from 0x48080000 to 0x48200000, end=3D4a630000
> ## Flattened Device Tree blob at 48000000
>    Booting using the fdt blob at 0x48000000
>    Using Device Tree in place at 0000000048000000, end 000000004801122f
> Overlap found: 0x600000000..0x67fffffff / 0x600000000..0x67fffffff
>=20
> Starting kernel ...
>=20
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x411fd073]
> [    0.000000] Linux version 6.1.31-01333-g486caac40d06 (biju@biju-Virtua=
lBox) (aarch64-none-linux-gnu-gcc (GNU Toolchain for the A-profile Architec=
ture 10.3-2021.07 (arm-10.29)) 10.3.1 20210621, GNU ld (GNU Toolchain for t=
he A-profile Architecture 10.3-2021.07 (arm-10.29)) 2.36.1.20210621) #41 SM=
P PREEMPT Thu Jun 15 10:35:42 BST 2023
> [    0.000000] Machine model: HopeRun HiHope RZ/G2M with sub board
> [    0.000000] printk: debug: ignoring loglevel setting.
> [    0.000000] efi: UEFI not found.
> [    0.000000] NUMA: No NUMA configuration found
> [    0.000000] NUMA: Faking a node at [mem 0x0000000048000000-0x000000067=
fffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x67f7eba00-0x67f7edfff]
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000048000000-0x00000000ffffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   [mem 0x0000000100000000-0x000000067fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000048000000-0x00000000bfffffff]
> [    0.000000]   node   0: [mem 0x0000000600000000-0x000000067fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000048000000-0x000000067ff=
fffff]
> [    0.000000] cma: Reserved 32 MiB at 0x00000000be000000
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: PSCIv1.1 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: Trusted OS migration not required
> [    0.000000] psci: SMC Calling Convention v1.2
> [    0.000000] percpu: Embedded 20 pages/cpu s44840 r8192 d28888 u81920
> [    0.000000] pcpu-alloc: s44840 r8192 d28888 u81920 alloc=3D20*4096
> [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5
> [    0.000000] Detected PIPT I-cache on CPU0
> [    0.000000] CPU features: detected: Spectre-v2
> [    0.000000] CPU features: detected: Spectre-v3a
> [    0.000000] CPU features: detected: Spectre-BHB
> [    0.000000] CPU features: detected: ARM erratum 1742098
> [    0.000000] CPU features: detected: ARM errata 1165522, 1319367, or 15=
30923
> [    0.000000] alternatives: applying boot alternatives
> [    0.000000] Fallback order for Node 0: 0
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 999=
936
> [    0.000000] Policy zone: Normal
> [    0.000000] Kernel command line: ignore_loglevel nfsrootdebug root=3D/=
dev/nfs rw nfsroot=3D192.168.10.1:/tftpboot/RZ-G2M,nfsvers=3D3 ip=3D192.168=
.10.5
> [    0.000000] Unknown kernel command line parameters "nfsrootdebug", wil=
l be passed to user space.
> [    0.000000] Dentry cache hash table entries: 524288 (order: 10, 419430=
4 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 =
bytes, linear)
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] software IO TLB: area num 8.
> [    0.000000] software IO TLB: mapped [mem 0x00000000ba000000-0x00000000=
be000000] (64MB)
> [    0.000000] Memory: 3848660K/4063232K available (16128K kernel code, 3=
714K rwdata, 8856K rodata, 7552K init, 609K bss, 181804K reserved, 32768K c=
ma-reserved)
> [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D6,=
 Nodes=3D1
> [    0.000000] rcu: Preemptible hierarchical RCU implementation.
> [    0.000000] rcu:     RCU event tracing is enabled.
> [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D256 to nr_cpu=
_ids=3D6.
> [    0.000000]  Trampoline variant of Tasks RCU enabled.
> [    0.000000]  Tracing variant of Tasks RCU enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is=
 25 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D6
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] Root IRQ handler: gic_handle_irq
> [    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on content=
ion.
> [    0.000000] arch_timer: cp15 timer(s) running at 8.33MHz (virt).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_=
cycles: 0x1ec02923e, max_idle_ns: 440795202125 ns
> [    0.000000] sched_clock: 56 bits at 8MHz, resolution 120ns, wraps ever=
y 2199023255496ns
> [    0.000175] Console: colour dummy device 80x25
> [    0.000383] printk: console [tty0] enabled
> [    0.000455] Calibrating delay loop (skipped), value calculated using t=
imer frequency.. 16.66 BogoMIPS (lpj=3D33333)
> [    0.000471] pid_max: default: 32768 minimum: 301
> [    0.000521] LSM: Security Framework initializing
> [    0.000612] Mount-cache hash table entries: 8192 (order: 4, 65536 byte=
s, linear)
> [    0.000638] Mountpoint-cache hash table entries: 8192 (order: 4, 65536=
 bytes, linear)
> [    0.002022] cblist_init_generic: Setting adjustable number of callback=
 queues.
> [    0.002053] cblist_init_generic: Setting shift to 3 and lim to 1.
> [    0.002122] cblist_init_generic: Setting shift to 3 and lim to 1.
> [    0.002271] rcu: Hierarchical SRCU implementation.
> [    0.002281] rcu:     Max phase no-delay instances is 1000.
> [    0.003558] Detected Renesas RZ/G2 r8a774a1 ES1.3
> [    0.004756] EFI services will not be available.
> [    0.005069] smp: Bringing up secondary CPUs ...
> [    0.005550] Detected PIPT I-cache on CPU1
> [    0.005668] CPU1: Booted secondary processor 0x0000000001 [0x411fd073]
> [    0.006207] CPU features: detected: ARM erratum 845719
> [    0.006223] Detected VIPT I-cache on CPU2
> [    0.006358] CPU2: Booted secondary processor 0x0000000100 [0x410fd034]
> [    0.006814] Detected VIPT I-cache on CPU3
> [    0.006881] CPU3: Booted secondary processor 0x0000000101 [0x410fd034]
> [    0.007310] Detected VIPT I-cache on CPU4
> [    0.007387] CPU4: Booted secondary processor 0x0000000102 [0x410fd034]
> [    0.007841] Detected VIPT I-cache on CPU5
> [    0.007922] CPU5: Booted secondary processor 0x0000000103 [0x410fd034]
> [    0.007998] smp: Brought up 1 node, 6 CPUs
> [    0.008054] SMP: Total of 6 processors activated.
> [    0.008061] CPU features: detected: 32-bit EL0 Support
> [    0.008066] CPU features: detected: 32-bit EL1 Support
> [    0.008073] CPU features: detected: CRC32 instructions
> [    0.008140] CPU: All CPU(s) started at EL1
> [    0.008165] alternatives: applying system-wide alternatives
> [    0.009890] devtmpfs: initialized
> [    0.015549] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 7645041785100000 ns
> [    0.015583] futex hash table entries: 2048 (order: 5, 131072 bytes, li=
near)
> [    0.016468] pinctrl core: initialized pinctrl subsystem
> [    0.018065] DMI not present or invalid.
> [    0.018538] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.019270] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic alloc=
ations
> [    0.019514] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for atom=
ic allocations
> [    0.019670] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for at=
omic allocations
> [    0.019731] audit: initializing netlink subsys (disabled)
> [    0.019855] audit: type=3D2000 audit(0.016:1): state=3Dinitialized aud=
it_enabled=3D0 res=3D1
> [    0.020894] thermal_sys: Registered thermal governor 'step_wise'
> [    0.020900] thermal_sys: Registered thermal governor 'power_allocator'
> [    0.020956] cpuidle: using governor menu
> [    0.021094] hw-breakpoint: found 6 breakpoint and 4 watchpoint registe=
rs.
> [    0.021200] ASID allocator initialised with 65536 entries
> [    0.022440] Serial: AMBA PL011 UART driver
> [    0.029355] sh-pfc e6060000.pinctrl: r8a774a1_pfc support registered
> [    0.034772] platform ec500000.sound: Fixed dependency cycle(s) with /s=
oc/hdmi@fead0000
> [    0.040013] platform fead0000.hdmi: Fixed dependency cycle(s) with /so=
c/display@feb00000
> [    0.040784] platform fead0000.hdmi: Fixed dependency cycle(s) with /hd=
mi0-out
> [    0.042535] KASLR disabled due to lack of seed
> [    0.047435] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pa=
ges
> [    0.047449] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
> [    0.047457] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pa=
ges
> [    0.047464] HugeTLB: 0 KiB vmemmap can be freed for a 32.0 MiB page
> [    0.047470] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pa=
ges
> [    0.047476] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
> [    0.047484] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pa=
ges
> [    0.047489] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
> [    0.048889] ACPI: Interpreter disabled.
> [    0.052814] iommu: Default domain type: Translated
> [    0.052828] iommu: DMA domain TLB invalidation policy: strict mode
> [    0.053008] SCSI subsystem initialized
> [    0.053139] libata version 3.00 loaded.
> [    0.053303] usbcore: registered new interface driver usbfs
> [    0.053330] usbcore: registered new interface driver hub
> [    0.053354] usbcore: registered new device driver usb
> [    0.054245] pps_core: LinuxPPS API ver. 1 registered
> [    0.054255] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolf=
o Giometti <giometti@linux.it>
> [    0.054269] PTP clock support registered
> [    0.054373] EDAC MC: Ver: 3.0.0
> [    0.055956] FPGA manager framework
> [    0.056014] Advanced Linux Sound Architecture Driver Initialized.
> [    0.056752] vgaarb: loaded
> [    0.057006] clocksource: Switched to clocksource arch_sys_counter
> [    0.057167] VFS: Disk quotas dquot_6.6.0
> [    0.057201] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 by=
tes)
> [    0.057333] pnp: PnP ACPI: disabled
> [    0.061785] NET: Registered PF_INET protocol family
> [    0.061987] IP idents hash table entries: 65536 (order: 7, 524288 byte=
s, linear)
> [    0.063912] tcp_listen_portaddr_hash hash table entries: 2048 (order: =
3, 32768 bytes, linear)
> [    0.063955] Table-perturb hash table entries: 65536 (order: 6, 262144 =
bytes, linear)
> [    0.063974] TCP established hash table entries: 32768 (order: 6, 26214=
4 bytes, linear)
> [    0.064125] TCP bind hash table entries: 32768 (order: 8, 1048576 byte=
s, linear)
> [    0.064688] TCP: Hash tables configured (established 32768 bind 32768)
> [    0.064792] UDP hash table entries: 2048 (order: 4, 65536 bytes, linea=
r)
> [    0.064862] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, =
linear)
> [    0.065059] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    0.065342] RPC: Registered named UNIX socket transport module.
> [    0.065355] RPC: Registered udp transport module.
> [    0.065360] RPC: Registered tcp transport module.
> [    0.065365] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.065377] PCI: CLS 0 bytes, default 64
> [    0.066217] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7=
 counters available
> [    0.066500] hw perfevents: enabled with armv8_cortex_a57 PMU driver, 7=
 counters available
> [    0.066917] kvm [1]: HYP mode not available
> [    0.067702] Initialise system trusted keyrings
> [    0.067851] workingset: timestamp_bits=3D42 max_order=3D20 bucket_orde=
r=3D0
> [    0.071358] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    0.071764] NFS: Registering the id_resolver key type
> [    0.071797] Key type id_resolver registered
> [    0.071803] Key type id_legacy registered
> [    0.071869] nfs4filelayout_init: NFSv4 File Layout Driver Registering.=
..
> [    0.071880] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Regi=
stering...
> [    0.071997] 9p: Installing v9fs 9p2000 file system support
> [    0.097939] Key type asymmetric registered
> [    0.097955] Asymmetric key parser 'x509' registered
> [    0.098005] Block layer SCSI generic (bsg) driver version 0.4 loaded (=
major 245)
> [    0.098017] io scheduler mq-deadline registered
> [    0.098024] io scheduler kyber registered
> [    0.107668] gpio_rcar e6050000.gpio: driving 16 GPIOs
> [    0.107979] gpio_rcar e6051000.gpio: driving 29 GPIOs
> [    0.108212] gpio_rcar e6052000.gpio: driving 15 GPIOs
> [    0.108440] gpio_rcar e6053000.gpio: driving 16 GPIOs
> [    0.108665] gpio_rcar e6054000.gpio: driving 18 GPIOs
> [    0.108888] gpio_rcar e6055000.gpio: driving 26 GPIOs
> [    0.109048] gpio-1906 (usb1-reset): hogged as output/low
> [    0.109171] gpio_rcar e6055400.gpio: driving 32 GPIOs
> [    0.109412] gpio_rcar e6055800.gpio: driving 4 GPIOs
> [    0.110999] rcar-pcie fe000000.pcie: host bridge /soc/pcie@fe000000 ra=
nges:
> [    0.111044] rcar-pcie fe000000.pcie:       IO 0x00fe100000..0x00fe1fff=
ff -> 0x0000000000
> [    0.111068] rcar-pcie fe000000.pcie:      MEM 0x00fe200000..0x00fe3fff=
ff -> 0x00fe200000
> [    0.111086] rcar-pcie fe000000.pcie:      MEM 0x0030000000..0x0037ffff=
ff -> 0x0030000000
> [    0.111103] rcar-pcie fe000000.pcie:      MEM 0x0038000000..0x003fffff=
ff -> 0x0038000000
> [    0.111120] rcar-pcie fe000000.pcie:   IB MEM 0x0040000000..0x00bfffff=
ff -> 0x0040000000
> [    0.180633] rcar-pcie fe000000.pcie: PCIe link down
> [    0.180793] rcar-pcie ee800000.pcie: host bridge /soc/pcie@ee800000 ra=
nges:
> [    0.180824] rcar-pcie ee800000.pcie:       IO 0x00ee900000..0x00ee9fff=
ff -> 0x0000000000
> [    0.180843] rcar-pcie ee800000.pcie:      MEM 0x00eea00000..0x00eebfff=
ff -> 0x00eea00000
> [    0.180860] rcar-pcie ee800000.pcie:      MEM 0x00c0000000..0x00c7ffff=
ff -> 0x00c0000000
> [    0.180873] rcar-pcie ee800000.pcie:      MEM 0x00c8000000..0x00cfffff=
ff -> 0x00c8000000
> [    0.180889] rcar-pcie ee800000.pcie:   IB MEM 0x0040000000..0x00bfffff=
ff -> 0x0040000000
> [    0.248601] rcar-pcie ee800000.pcie: PCIe link down
> [    0.250286] EINJ: ACPI disabled.
> [    0.267824] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    0.270221] SuperH (H)SCI(F) driver initialized
> [    0.270645] e6540000.serial: ttySC1 at MMIO 0xe6540000 (irq =3D 28, ba=
se_baud =3D 0) is a hscif
> [    0.270841] serial serial0: tty port ttySC1 registered
> [    0.271322] e6e88000.serial: ttySC0 at MMIO 0xe6e88000 (irq =3D 29, ba=
se_baud =3D 0) is a scif
> [    1.473185] printk: console [ttySC0] enabled
> [    1.478260] msm_serial: driver initialized
> [    1.488277] loop: module loaded
> [    1.492487] megasas: 07.719.03.00-rc1
> [    1.500948] tun: Universal TUN/TAP device driver, 1.6
> [    1.506792] thunder_xcv, ver 1.0
> [    1.510065] thunder_bgx, ver 1.0
> [    1.513315] nicpf, ver 1.0
> [    1.517043] hns3: Hisilicon Ethernet Network Driver for Hip08 Family -=
 version
> [    1.524274] hns3: Copyright (c) 2017 Huawei Corporation.
> [    1.529634] hclge is initializing
> [    1.532961] e1000: Intel(R) PRO/1000 Network Driver
> [    1.537842] e1000: Copyright (c) 1999-2006 Intel Corporation.
> [    1.543609] e1000e: Intel(R) PRO/1000 Network Driver
> [    1.548574] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    1.554519] igb: Intel(R) Gigabit Ethernet Network Driver
> [    1.559920] igb: Copyright (c) 2007-2014 Intel Corporation.
> [    1.565510] igbvf: Intel(R) Gigabit Virtual Function Network Driver
> [    1.571779] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
> [    1.577998] sky2: driver version 1.30
> [    1.583033] VFIO - User Level meta-driver version: 0.3
> [    1.590446] ehci-platform ee0a0100.usb: EHCI Host Controller
> [    1.590607] ohci-platform ee0a0000.usb: Generic Platform OHCI controll=
er
> [    1.590985] xhci-renesas-hcd ee000000.usb: xHCI Host Controller
> [    1.591000] xhci-renesas-hcd ee000000.usb: new USB bus registered, ass=
igned bus number 1
> [    1.591240] xhci-renesas-hcd ee000000.usb: Direct firmware load for r8=
a779x_usb3_v3.dlmem failed with error -2
> [    1.591249] xhci-renesas-hcd ee000000.usb: can't setup: -2
> [    1.591256] xhci-renesas-hcd ee000000.usb: USB bus 1 deregistered
> [    1.591297] xhci-renesas-hcd: probe of ee000000.usb failed with error =
-2
> [    1.591740] usbcore: registered new interface driver usb-storage
> [    1.593945] i2c_dev: i2c /dev entries driver
> [    1.595936] cs2000-cp 2-004f: operating in static mode
> [    1.596155] ehci-platform ee0a0100.usb: new USB bus registered, assign=
ed bus number 1
> [    1.602853] ohci-platform ee0a0000.usb: new USB bus registered, assign=
ed bus number 2
> [    1.604384] cs2000-cp 2-004f: revision - C1
> [    1.604453] i2c-rcar e6510000.i2c: probed
> [    1.608397] i2c-rcar e66d8000.i2c: probed
> [    1.608922] ehci-platform ee0a0100.usb: irq 30, io mem 0xee0a0100
> [    1.614877] rcar_gen3_thermal e6198000.thermal: Sensor 0: Loaded 1 tri=
p points
> [    1.616968] ohci-platform ee0a0000.usb: irq 30, io mem 0xee0a0000
> [    1.619042] rcar_gen3_thermal e6198000.thermal: Sensor 1: Loaded 1 tri=
p points
> [    1.623039] rcar_gen3_thermal e6198000.thermal: Sensor 2: Loaded 2 tri=
p points
> [    1.625993] cpufreq: cpufreq_online: CPU0: Running at unlisted initial=
 frequency: 1499999 KHz, changing to: 1500000 KHz
> [    1.626092] cpu cpu0: EM: created perf domain
> [    1.627347] cpufreq: cpufreq_online: CPU2: Running at unlisted initial=
 frequency: 1199999 KHz, changing to: 1200000 KHz
> [    1.641018] ehci-platform ee0a0100.usb: USB 2.0 started, EHCI 1.10
> [    1.645298] cpu cpu2: EM: created perf domain
> [    1.651771] hub 1-0:1.0: USB hub found
> [    1.657822] sdhci: Secure Digital Host Controller Interface driver
> [    1.660611] hub 1-0:1.0: 1 port detected
> [    1.668416] sdhci: Copyright(c) Pierre Ossman
> [    1.724974] hub 2-0:1.0: USB hub found
> [    1.733929] Synopsys Designware Multimedia Card Interface Driver
> [    1.737451] hub 2-0:1.0: 1 port detected
> [    1.749018] sdhci-pltfm: SDHCI platform and OF driver helper
> [    1.783950] renesas_sdhi_internal_dmac ee160000.mmc: mmc0 base at 0x00=
000000ee160000, max clock rate 200 MHz
> [    1.806425] ledtrig-cpu: registered to indicate activity on CPUs
> [    1.814031] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
> [    1.821194] usbcore: registered new interface driver usbhid
> [    1.826778] usbhid: USB HID core driver
> [    1.833900] optee: probing for conduit method.
> [    1.838373] optee: revision 3.11 (d541c4fa)
> [    1.838642] optee: dynamic shared memory is enabled
> [    1.848005] optee: initialized driver
> [    1.854491] NET: Registered PF_PACKET protocol family
> [    1.859675] 9pnet: Installing 9P2000 support
> [    1.863997] Key type dns_resolver registered
> [    1.868561] registered taskstats version 1
> [    1.872694] Loading compiled-in X.509 certificates
> [    1.884540] mmc0: new HS200 MMC card at address 0001
> [    1.890297] renesas_irqc e61c0000.interrupt-controller: driving 6 irqs
> [    1.890323] mmcblk0: mmc0:0001 S0J57X 29.6 GiB
> [    1.903540]  mmcblk0: p1
> [    1.906931] mmcblk0boot0: mmc0:0001 S0J57X 31.5 MiB
> [    1.913486] mmcblk0boot1: mmc0:0001 S0J57X 31.5 MiB
> [    1.919903] mmcblk0rpmb: mmc0:0001 S0J57X 4.00 MiB, chardev (234:0)
> [    1.922951] renesas_sdhi_internal_dmac ee100000.mmc: Got CD GPIO
> [    1.933030] usb 1-1: new high-speed USB device number 2 using ehci-pla=
tform
> [    1.941041] ehci-platform ee080100.usb: EHCI Host Controller
> [    1.946727] ehci-platform ee080100.usb: new USB bus registered, assign=
ed bus number 3
> [    1.949037] ohci-platform ee080000.usb: Generic Platform OHCI controll=
er
> [    1.954690] ehci-platform ee080100.usb: irq 43, io mem 0xee080100
> [    1.961448] ohci-platform ee080000.usb: new USB bus registered, assign=
ed bus number 4
> [    1.975374] ohci-platform ee080000.usb: irq 43, io mem 0xee080000
> [    2.007516] renesas_sdhi_internal_dmac ee100000.mmc: mmc1 base at 0x00=
000000ee100000, max clock rate 200 MHz
> [    2.050955] renesas_sdhi_internal_dmac ee140000.mmc: mmc2 base at 0x00=
000000ee140000, max clock rate 200 MHz
> [    2.071178] renesas_sdhi_internal_dmac ee140000.mmc: card claims to su=
pport voltages below defined range
> [    2.071755] hub 4-0:1.0: USB hub found
> [    2.081017] ehci-platform ee080100.usb: USB 2.0 started, EHCI 1.10
> [    2.084450] hub 4-0:1.0: 1 port detected
> [    2.094394] hub 1-1:1.0: USB hub found
> [    2.095297] hub 3-0:1.0: USB hub found
> [    2.098474] hub 1-1:1.0: 2 ports detected
> [    2.102043] hub 3-0:1.0: 1 port detected
> [    2.107346] mmc2: new high speed SDIO card at address 0001
> [    2.114978] Trying to probe devices needed for running init ...
> [    2.693038] usb 4-1: new full-speed USB device number 2 using ohci-pla=
tform
> [    2.893034] usb 4-1: device descriptor read/64, error -62
> [    3.201035] usb 4-1: device descriptor read/64, error -62
> [    3.501034] usb 4-1: new full-speed USB device number 3 using ohci-pla=
tform
> [    3.701038] usb 4-1: device descriptor read/64, error -62
> [    4.005035] usb 4-1: device descriptor read/64, error -62
> [    4.117056] usb usb4-port1: attempt power cycle
> [    4.693037] usb 4-1: new full-speed USB device number 4 using ohci-pla=
tform
> [    5.117033] usb 4-1: device not accepting address 4, error -62
> [    5.309031] usb 4-1: new full-speed USB device number 5 using ohci-pla=
tform
> [    5.733033] usb 4-1: device not accepting address 5, error -62
> [    5.738944] usb usb4-port1: unable to enumerate USB device
> [   11.999825] ravb e6800000.ethernet: deferred probe timeout, ignoring d=
ependency
> [   12.010590] ravb e6800000.ethernet eth0: Base address at 0xe6800000, 0=
0:11:22:33:44:66, IRQ 47.
> [   12.020946] rcar-dmac e6700000.dma-controller: deferred probe timeout,=
 ignoring dependency
> [   12.034282] rcar-dmac e7300000.dma-controller: deferred probe timeout,=
 ignoring dependency
> [   12.048278] rcar-dmac e7310000.dma-controller: deferred probe timeout,=
 ignoring dependency
> [   12.061724] rcar-dmac ec700000.dma-controller: deferred probe timeout,=
 ignoring dependency
> [   12.075487] rcar-dmac ec720000.dma-controller: deferred probe timeout,=
 ignoring dependency
> [   12.358479] RTL8211E Gigabit Ethernet e6800000.ethernet-ffffffff:00: a=
ttached PHY driver (mii_bus:phy_addr=3De6800000.ethernet-ffffffff:00, irq=
=3D53)
> [   15.033078] ravb e6800000.ethernet eth0: Link is Up - 1Gbps/Full - flo=
w control off
> [   15.057032] IP-Config: Guessing netmask 255.255.255.0
> [   15.062103] IP-Config: Complete:
> [   15.065344]      device=3Deth0, hwaddr=3D00:11:22:33:44:66, ipaddr=3D1=
92.168.10.5, mask=3D255.255.255.0, gw=3D255.255.255.255
> [   15.075808]      host=3D192.168.10.5, domain=3D, nis-domain=3D(none)
> [   15.081658]      bootserver=3D255.255.255.255, rootserver=3D192.168.10=
.1, rootpath=3D
> [   15.082230] ALSA device list:
> [   15.092536]   No soundcards found.
> [   16.157094] VFS: Mounted root (nfs filesystem) on device 0:20.
> [   16.164899] devtmpfs: mounted
> [   16.170876] Freeing unused kernel memory: 7552K
> [   16.185088] Run /sbin/init as init process
> [   16.189210]   with arguments:
> [   16.192180]     /sbin/init
> [   16.194899]     nfsrootdebug
> [   16.197791]   with environment:
> [   16.200932]     HOME=3D/
> [   16.203302]     TERM=3Dlinux
> [   16.561527] systemd[1]: System time before build time, advancing clock=
.
> [   16.720037] NET: Registered PF_INET6 protocol family
> [   16.726453] Segment Routing with IPv6
> [   16.730209] In-situ OAM (IOAM) with IPv6
> [   16.822556] systemd[1]: systemd 244.5+ running in system mode. (+PAM -=
AUDIT -SELINUX +IMA -APPARMOR -SMACK +SYSVINIT +UTMP -LIBCRYPTSETUP -GCRYPT=
 -GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID -ELFUTILS +KMOD -IDN2 -IDN -PCRE2 de=
fault-hierarchy=3Dhybrid)
> [   16.844941] systemd[1]: Detected architecture arm64.
>=20
> Welcome to Poky (Yocto Project Reference Distro) 3.1.14 (dunfell)!
>=20
> [   16.943204] systemd[1]: Set hostname to <rzg2m>.
> [   20.981008] random: crng init done
> [   20.986592] systemd[1]: Created slice system-getty.slice.
> [  OK  ] Created slice system-getty.slice.
> [   21.010009] systemd[1]: Created slice system-serial\x2dgetty.slice.
> [  OK  ] Created slice system-serial\x2dgetty.slice.
> [   21.033760] systemd[1]: Created slice User and Session Slice.
> [  OK  ] Created slice User and Session Slice.
> [   21.053378] systemd[1]: Started Dispatch Password Requests to Console =
Directory Watch.
> [  OK  ] Started Dispatch Password =C3=A2=E2=82=AC=C2=A6ts to Console Dir=
ectory Watch.
> [   21.077282] systemd[1]: Started Forward Password Requests to Wall Dire=
ctory Watch.
> [  OK  ] Started Forward Password R=C3=A2=E2=82=AC=C2=A6uests to Wall Dir=
ectory Watch.
> [   21.101190] systemd[1]: Reached target Paths.
> [  OK  ] Reached target Paths.
> [   21.121213] systemd[1]: Reached target Remote File Systems.
> [  OK  ] Reached target Remote File Systems.
> [   21.141115] systemd[1]: Reached target Slices.
> [  OK  ] Reached target Slices.
> [   21.161143] systemd[1]: Reached target Swap.
> [  OK  ] Reached target Swap.
> [   21.184024] systemd[1]: Listening on Syslog Socket.
> [  OK  ] Listening on Syslog Socket.
> [   21.205508] systemd[1]: Listening on initctl Compatibility Named Pipe.
> [  OK  ] Listening on initctl Compatibility Named Pipe.
> [   21.231678] systemd[1]: Listening on Journal Audit Socket.
> [  OK  ] Listening on Journal Audit Socket.
> [   21.253634] systemd[1]: Listening on Journal Socket (/dev/log).
> [  OK  ] Listening on Journal Socket (/dev/log).
> [   21.277653] systemd[1]: Listening on Journal Socket.
> [  OK  ] Listening on Journal Socket.
> [   21.299810] systemd[1]: Listening on Network Service Netlink Socket.
> [  OK  ] Listening on Network Service Netlink Socket.
> [   21.325055] systemd[1]: Listening on udev Control Socket.
> [  OK  ] Listening on udev Control Socket.
> [   21.345582] systemd[1]: Listening on udev Kernel Socket.
> [  OK  ] Listening on udev Kernel Socket.
> [   21.389594] systemd[1]: Mounting Huge Pages File System...
>          Mounting Huge Pages File System...
> [   21.415019] systemd[1]: Mounting POSIX Message Queue File System...
>          Mounting POSIX Message Queue File System...
> [   21.442597] systemd[1]: Mounting Kernel Debug File System...
>          Mounting Kernel Debug File System...
> [   21.473538] systemd[1]: Mounting Temporary Directory (/tmp)...
>          Mounting Temporary Directory (/tmp)...
> [   21.500835] systemd[1]: Starting Create list of static device nodes fo=
r the current kernel...
>          Starting Create list of st=C3=A2=E2=82=AC=C2=A6odes for the curr=
ent kernel...
> [   21.527211] systemd[1]: Condition check resulted in File System Check =
on Root Device being skipped.
> [   21.558000] systemd[1]: Starting Journal Service...
>          Starting Journal Service...
> [   21.592092] systemd[1]: Starting Load Kernel Modules...
>          Starting Load Kernel Modules...
> [   21.642177] systemd[1]: Starting Remount Root and Kernel File Systems.=
..
>          Starting Remount Root and Kernel File Systems...
> [   21.672022] systemd[1]: Starting udev Coldplug all Devices...
>          Starting udev Coldplug all Devices...
> [   21.698059] systemd[1]: Mounted Huge Pages File System.
> [  OK  ] Mounted Huge Pages File System.
> [   21.720907] systemd[1]: Mounted POSIX Message Queue File System.
> [  OK  ] Mounted POSIX Message Queue File System.
> [   21.748815] systemd[1]: Started Journal Service.
> [  OK  ] Started Journal Service.
> [  OK  ] Mounted Kernel Debug File System.
> [  OK  ] Mounted Temporary Directory (/tmp).
> [  OK  ] Started Create list of sta=C3=A2=E2=82=AC=C2=A6 nodes for the cu=
rrent kernel.
> [  OK  ] Started Load Kernel Modules.
> [  OK  ] Started Remount Root and Kernel File Systems.
>          Mounting Kernel Configuration File System...
>          Starting Flush Journal to Persistent Storage...
>          Starting Apply Kernel Variables...
>          Starting Create Static Device Nodes in /dev...
> [  OK  ] Mounted Kernel Configuration File System.
> [   22.023001] systemd-journald[246]: Received client request to flush ru=
ntime journal.
> [  OK  ] Started Flush Journal to Persistent Storage.
> [  OK  ] Started Apply Kernel Variables.
> [  OK  ] Started Create Static Device Nodes in /dev.
> [  OK  ] Reached target Local File Systems (Pre).
>          Mounting /var/volatile...
> [   22.251839] audit: type=3D1334 audit(1600598643.683:2): prog-id=3D5 op=
=3DLOAD
> [   22.258575] audit: type=3D1334 audit(1600598643.691:3): prog-id=3D6 op=
=3DLOAD
>          Starting udev Kernel Device Manager...
> [  OK  ] Started udev Coldplug all Devices.
> [  OK  ] Mounted /var/volatile.
>          Starting udev Wait for Complete Device Initialization...
>          Starting Load/Save Random Seed...
> [  OK  ] Reached target Local File Systems.
>          Starting Create Volatile Files and Directories...
> [  OK  ] Started Load/Save Random Seed.
> [  OK  ] Started udev Kernel Device Manager.
>          Starting Network Service...
> [  OK  ] Started Network Service.
> [   22.929588] CAN device driver interface
> [   22.991089] renesas_usbhs e6590000.usb: host probed
> [   22.996295] renesas_usbhs e6590000.usb: no transceiver found
> [   23.010888] rcar_can e6c30000.can: device registered (IRQ137)
> [  OK  ] Started Create Volatile Files and Directories.
> [   23.053276] renesas_usbhs e6590000.usb: gadget probed
> [   23.058902] renesas_usbhs e6590000.usb: probed
> [   23.097761] rcar_can e6c38000.can: device registered (IRQ138)
>          Starting Network Name Resolution...
> [   23.197705] rcar-fcp fea27000.fcp: deferred probe timeout, ignoring de=
pendency
> [   23.207835] rcar-fcp fea2f000.fcp: deferred probe timeout, ignoring de=
pendency
> [   23.216663] rcar-fcp fea37000.fcp: deferred probe timeout, ignoring de=
pendency
> [   23.216944] Bluetooth: Core ver 2.22
> [   23.227933] NET: Registered PF_BLUETOOTH protocol family
> [   23.233527] Bluetooth: HCI device and connection manager initialized
>          Startin[   23.240056] Bluetooth: HCI socket layer initialized
> g Netwo[   23.246378] Bluetooth: L2CAP socket layer initialized
> rk Time Synchron[   23.246876] mc: Linux media interface: v0.10
> ization...
> [   23.252689] Bluetooth: SCO socket layer initialized
> [   23.258027] rcar-fcp fe9af000.fcp: deferred probe timeout, ignoring de=
pendency
> [   23.307555] rcar_sound ec500000.sound: probed
>          Starting Update UTMP about System Boot/Shutdown...
> [   23.322917] videodev: Linux video capture interface: v2.00
> [   23.338165] renesas_usb3 ee020000.usb: probed with phy
> [  OK  ] Started Update UTMP about System Boot/Shutdown.
> [   23.436454] Bluetooth: HCI UART driver ver 2.3
> [   23.443307] Bluetooth: HCI UART protocol H4 registered
> [   23.450195] Bluetooth: HCI UART protocol LL registered
> [   23.485848] Bluetooth: HCI UART protocol Broadcom registered
> [   23.495308] Bluetooth: HCI UART protocol QCA registered
> [   23.503486] rcar_fdp1 fe940000.fdp1: Device registered as /dev/video0
> [   23.507358] rcar-dw-hdmi fead0000.hdmi: Detected HDMI TX controller v2=
.01a with HDCP (DWC HDMI 2.0 TX PHY)
> [   23.512057] Bluetooth: HCI UART protocol Marvell registered
> [   23.524699] rcar-dw-hdmi fead0000.hdmi: registered DesignWare HDMI I2C=
 bus driver
> [   23.617637] hci-ti serial0-0: Direct firmware load for ti-connectivity=
/TIInit_11.8.32.bts failed with error -2
> [   23.627741] Bluetooth: hci0: request_firmware failed(errno -2) for ti-=
connectivity/TIInit_11.8.32.bts
> [   23.637067] Bluetooth: hci0: download firmware failed, retrying...
> [  OK  ] Started Network Time Synchronization.
> [  OK  ] Started Network Name Resolution.
> [  OK  ] Reached target Bluetooth.
> [  OK  ] Reached target Network.
> [   23.777554] [drm] Initialized rcar-du 1.0.0 20130110 for feb00000.disp=
lay on minor 0
> [  OK  ] Reached target Host and Network Name Lookups.
> [   23.792569] [drm] Device feb00000.display probed
> [   23.797897] rcar-du feb00000.display: [drm] Cannot find any crtc or si=
zes
> [  OK  ] Reached target Syst[   23.808607] hci-ti serial0-0: Direct firmw=
are load for ti-connectivity/TIInit_11.8.32.bts failed with error -2
> em Time Set.[   23.820293] Bluetooth: hci0: request_firmware failed(errno=
 -2) for ti-connectivity/TIInit_11.8.32.bts
>=20
> [   23.830790] Bluetooth: hci0: download firmware failed, retrying...
> [  OK  ] Reached target System Time Synchronized.
> [  OK  ] Reached target Hardware act[   23.857243] cfg80211: Loading comp=
iled-in X.509 certificates for regulatory database
> ivated USB gadget.
> [  OK  ] Listening on Load/Save RF =C3=A2=E2=82=AC=C2=A6itch Status /dev/=
rfkill Watch.
> [   23.908591] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [   23.915404] platform regulatory.0: Direct firmware load for regulatory=
.db failed with error -2
> [   23.924155] cfg80211: failed to load regulatory.db
>          Starting Load/Save RF Kill Switch Status...
> [   24.000118] hci-ti serial0-0: Direct firmware load for ti-connectivity=
/TIInit_11.8.32.bts failed with error -2
> [   24.010227] Bluetooth: hci0: request_firmware failed(errno -2) for ti-=
connectivity/TIInit_11.8.32.bts
> [   24.019498] Bluetooth: hci0: download firmware failed, retrying...
> [  OK  ] Started Load/Save RF Kill Switch Status.
> [   24.188198] hci-ti serial0-0: Direct firmware load for ti-connectivity=
/TIInit_11.8.32.bts failed with error -2
> [   24.198252] Bluetooth: hci0: request_firmware failed(errno -2) for ti-=
connectivity/TIInit_11.8.32.bts
> [   24.207498] Bluetooth: hci0: download firmware failed, retrying...
> [   24.209068] wl18xx_driver wl18xx.3.auto: Direct firmware load for ti-c=
onnectivity/wl1271-nvs.bin failed with error -2
> [   24.225615] wl18xx_driver wl18xx.3.auto: Direct firmware load for ti-c=
onnectivity/wl18xx-conf.bin failed with error -2
> [   24.236423] wlcore: ERROR could not get configuration binary ti-connec=
tivity/wl18xx-conf.bin: -2
> [   24.245293] wlcore: WARNING falling back to default config
> [  OK  ] Started udev Wait for Complete Device Initialization.
> [  OK  ] Started Hardware RNG Entropy Gatherer Daemon.
> [  OK  ] Reached target System Initialization.
> [  OK  ] Started Daily Cleanup of Temporary Directories.
> [  OK  ] Reached target Timers.
> [  OK  ] Listening on D-Bus System Message Bus Socket.
>          Starting sshd.socket.
> [  OK  ] Listening on sshd.socket.
> [  OK  ] Reached target Sockets.
> [  OK  ] Reached target Basic System.
>          Starting Save/Restore Sound Card State...
> [  OK  ] Started Kernel Logging Service.
> [  OK  ] Started System Logging Service.
> [  OK  ] Started D-Bus System Message Bus.
>          Starting rng-tools.service...
> [   24.724566] audit: type=3D1334 audit(1675175570.446:4): prog-id=3D7 op=
=3DLOAD
> [   24.731577] audit: type=3D1334 audit(1675175570.454:5): prog-id=3D8 op=
=3DLOAD
>          Starting Login Service...
>          Starting Permit User Sessions...
> [   24.774068] wlcore: wl18xx HW: 183x or 180x, PG 2.2 (ROM 0x11)
> [  OK  ] Started VIN initializing setting.
> [   24.790478] wlcore: loaded
> [  OK  ] Started Save/Restore Sound Card State.
> [  OK  ] Started rng-tools.service.
> [  OK  ] Started Permit User Sessions.
> [  OK  ] Reached target Sound Card.
> [  OK  ] Started Getty on tty1.
> [  OK  ] Started Serial Getty on ttySC0.
> [  OK  ] Reached target Login Prompts.
> [  OK  ] Started Login Service.
> [  OK  ] Reached target Multi-User System.
>          Starting Update UTMP about System Runlevel Changes...
> [  OK  ] Started Update UTMP about System Runlevel Changes.
>=20
> Poky (Yocto Project Reference Distro) 3.1.14 rzg2m ttySC0
>=20
> BSP: RZG2M
> LSI: RZG2M
> rzg2m login: root
> root@rzg2m:~#
> root@rzg2m:~#
> root@rzg2m:~#

I can try 6.1-cip as well - but does it mean that support for this
target is limited to up to 6.1? We declared it supported here:
https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/cip=
referencehardware

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center


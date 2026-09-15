Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D279C88E53
	for <webhook@archiver.kernel.org>; Tue, 15 Sep 2026 08:36:53 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18697.1789461409004151507
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Sep 2026 01:36:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=bHv7vxD8;
 spf=pass (domain: siemens.com, ip: 52.101.66.21, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oim1J2upv0qRiVAYKOJAJn3yoxPJARmr8KmKsTtWE5p0XbfkXxOguVwPROE/8UMWsImTYfU7+bNfyjv8lKoCzN5zqpRGN46c951Ub5ERiwdOjQ8roZcDxvuzsBDNjO/bIs7HmN9ujEsM2fIaNqcMRR16ypph8FkhgjR57JMooxQYgwGqDawLh8xF3ScIekDuFqwoyT2tp8vlJH6RF0HaliTJJkKti0frjkc7BJ15HR5q1IbcXI+Ui9//IytBndDTWAS7MBd7LF+3qLvuiMsuFZiPqaFZuGQyclOGAFoaVNKryPVG1LIAE0btW4NVnXj8GZ2F3hyh8fIBkct7D3LOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLr3+D9zzfAgciu+sycrmErz1I6zQg/SMcdE3N/asRE=;
 b=ITVBL1H4XMuV6y+vBtIedYbLi2/bAxwCE5+CQh6OEyJ8uLsdS0bDrEYiEAFJJWDB9cfAJx+Z0tBs/gMwOm+NHrliZi8Hi9d99+IJgqkPKeV09+z94sufBovKiEQJLKEKa5hbxKgjT/5BCiCv/+uTOPzXr7eqq5SEZvdtdZC3zzxFqRG1Mei7bz+1eRmaXYtnm1wV1Ou+UuKSP3wYwFKcAlHCYGNfSLil5xHUniP0V/K+4GKOc7up5uDvCGxkPACOMDdIyA36oSJI6TWOmi2IEBBqhRkkMjlkQrH5AwvS9DkD/S0sNWHFzgWxDqRvMfXklQkwTKognvVXMbIOeMMNrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLr3+D9zzfAgciu+sycrmErz1I6zQg/SMcdE3N/asRE=;
 b=bHv7vxD8cqZ2NJqwBc0iMyRX3FwTKnkycRtM10LpeahMfzq0tUno4NA/lvAOyZL54Zt09DNkX10SBYd22eRjFIg/O0ooEICXmIXmx8O51nzbKkvea5lDsaLalc8g6kZusPm9UAbJIliMhkY9D7YqrHIGBErVcGi6QXO+36wb8vFrfYDroi4WL4BK5FEGmPG71np3PNa5oK6zDA3Kd8w0bvTh8SH4sx3tgd9zyvdD8FmZjRQ2NJ28h8t9mohJeXTu0cf/+7EydQ5i8s5ANW7PcoxMi3px1TXXt3h2v2e4natX3xbO1GMH6Xls9cJLeQXZQmofJ22IQKO0PJnQ2n4clw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5275.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:295::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 08:36:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 08:36:41 +0000
Message-ID: <edf7e34e-a584-49a0-9b09-0bffeb2a494e@siemens.com>
Date: Tue, 15 Sep 2026 10:36:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add SECURITY.md for the CIP kernel
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ulrich Hecht <uli@fpond.eu>, Pavel Machek <pavel@nabladev.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <a1cfc8d4-5fb7-4f75-9600-92ebd7dbbeda@siemens.com>
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
In-Reply-To: <a1cfc8d4-5fb7-4f75-9600-92ebd7dbbeda@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: 2128be39-b8a2-42ab-d892-08df13047755
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|6133799003|55112099003|18002099003|22082099003|3023799007|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	X6xCuDU0w2YrAy44NJwsv3q757g9I68K/6ECGJIaP6vR0f5Erwx6tzNq3EVNGHd/or3zKHB6Z4Vxvd31zWecvPK8pTfl1RaaERPvyl9F95YpLfDCHKoWbsPuFEYonsMBzlE8LCROyJsIRTTMbakSQInNAzj4DogLxGpnB35M7aQw9tNRfuijFtASedHWt15vNIDMDwvgkbUYB2+BedtsdRQTkvjpnAae32kectubOWAGiYRqa9nfFMZ70OEZTdJ0kMI3z4BuB5ZLzX9BeyKC9wzwKA4rDsIaXTYxuAnH/LZvg6IjBad4cRdcuLj8m0zoh41Wd9IsqokhhQxtJG2oII8IebUgNNJcWcGyab8UzSrXGMvDPEjz8dboigEbwrJwqRjTFVXlYWOaWD2EbNYpcYV2X+gJykPe24//J5vRQzcg/a1upt3FyPWrf80ofWJg9adJTjS8nWVXBnYbgC0YRTmm4BkcENtj/Dkg7oJk2nyN5sR6llFMhIVaOJ//rUuBMgonW9Xdtqgg/DSlNnHfCzqa42gz98ezhHaEbr/F+NLc2wAqkcgpQe7HliLAvAU0+HlfNWHeg3+RuLzLbxPuygp4iKHfQ/rWiUPYczHC7OkzkRJwEDDYG+wueB4XKpM611uVO/XR/m8cNwkaCD3BmUD0b7Dl2zU13ipT6ljjYjA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(55112099003)(18002099003)(22082099003)(3023799007)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GWk2imW0WZ2sQ3rhPhy/ay9JYcZF4BUU37dPpI7RjlOQtuPD8Fxdp/mVQCpp?=
 =?us-ascii?Q?bkvD7ThhFK1e1GcC5NvwdvBcqv6Xsyt/tviUHDblXLogmnjWWcvMkDn0Tt6B?=
 =?us-ascii?Q?2uA37Nm87AFItUx371lEfWtZxb9axF0R3GBC4TrLdUtfY422bYVpQmKiuQdT?=
 =?us-ascii?Q?csSTJLoXd90FNY06NF9Jehh/9ONCniUS76fBHOL3z1GTUGaKttoynPy6VkQY?=
 =?us-ascii?Q?+iXBAh+MLTEoaJ7q4oiv4Zify0ERPPuWIZddxPZuxWtI0NXsMnXwIvqsueKo?=
 =?us-ascii?Q?hs16j1P4kc2hRoRz2Ar1Z6joOEWMBo5YhgCk6ggCuK8a2tODMFaO0EfrJd7n?=
 =?us-ascii?Q?z7Ts/LJ9JNNFGilwKNpSylA0M+8tqO3vKhHn5nG5dEd+kMhqGAC025rv0/AB?=
 =?us-ascii?Q?WljGctgP5Hw5Za7ESXJ8syEN92/jphtqdf+qHd2S5tysV3nFv/Ah1/+ghpBP?=
 =?us-ascii?Q?Re1hY2+QEZwy2o/xndKLPEGumUUTYH5+d5pFNk9au8eTLLmsSl7K+H6Iq1+h?=
 =?us-ascii?Q?JcObilfTh1YB/qR5Ol51TL5x//VztKT1esuE7Hp7Ud5weSCsLCjxJmNI2Pmy?=
 =?us-ascii?Q?Fu31n+X0HD/9Qew8bXZSv6d1Y1l+Cd6oAYZ5QlYQ/0FwuSHPAkFL+Rmr+dHs?=
 =?us-ascii?Q?wtiXbk0vsGNlxv96CjsbzGF6fzmyM1ROP+gnc3EoFqR19i/qhTYp513EmDDq?=
 =?us-ascii?Q?42t3Spw3yYN0NrdMmEq/gYuZtahoHH16Nhk4AC/TtHO43XohKGbbl/nt+Unb?=
 =?us-ascii?Q?cCA3Ykx5kiAMZoLBWm5w5Y/qMaxQU8tfujWnYCK1sC4cobylqmW2fG3nj95/?=
 =?us-ascii?Q?txFMb3cwqaWElpVr6NyFucIpVFh73E3Ws1gF44dkao4bkxZHcb1u0PIwqpci?=
 =?us-ascii?Q?fepA5t3mh6g14XjIBCHsd/DdSLvfl1uWDaUiWK3GVYohbTi7DQMxh6B2kOAO?=
 =?us-ascii?Q?TGD9vA2v09S8y5p9f/5/6dALzv2AlAFpTXdmkZUdUMw/1PJ71o+Jy8jWDa0k?=
 =?us-ascii?Q?e0aR9eayrKpgme1dF9XuhuYVUdT/Wxdg17lwuipKVDZ44Peh26SJVm9nMDK3?=
 =?us-ascii?Q?Yur2DyEyH8sCbrJ4//MCRw8ureRhDm7LvWtt9fLDvQEa0ntwVWkXIHpRJcyz?=
 =?us-ascii?Q?3JdbTo9I9Vhkw8BOTJx65UCEyOJDckJVUxEqUzR5x7sjGEboejJVbyqdNWfq?=
 =?us-ascii?Q?tkOX73SB5TVNY9XEEcSp8R+AT88CUGCBT91VB9IhLvR+7r+MZ9QL7ncx0q0B?=
 =?us-ascii?Q?h8vj4u/e3riZGgrykna4jHm8Lp66DZGahGO4zn+L1UOiJrTUhW2jTSWoPKVk?=
 =?us-ascii?Q?Qrd3fhVvfRWR9kpK0N+TtNc0za/tKtG/rBl76X72C6UEPqkRFKu8Wlo+qh40?=
 =?us-ascii?Q?t/R9WSdscbj68rsN34r6kQc3JFTyadXhW0v3VhTwZmbxkSnsWrOWRyzuRHkp?=
 =?us-ascii?Q?dRQLPrVNdV27lYcRgjoU2jhWVzTiz1DufkMN5EPUohuulItshrNtnx12ZSQT?=
 =?us-ascii?Q?8+le7371Q38pC4sDf/PFdzTQfujuqOwpuKiQBMXpEztayq1FqybMh5FOo79D?=
 =?us-ascii?Q?UJxhyMnpY+CQ1nMf5zXoA2tIzy22TCJ2eR25Mdx1zuhhJf+VbuGl+8fD3q6R?=
 =?us-ascii?Q?MS9XjTqP0E6PrZAJa2b01gxPqU+x3pUxnQ7b7Cs8g2k0RILDc8pIVfFtDOO8?=
 =?us-ascii?Q?VDznjr4goEYfJCY40lNZ2KepQ6eTksasCbFzgY3TjTUnEf/lPp6KOz5OBpnZ?=
 =?us-ascii?Q?LWvqG04yMw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2128be39-b8a2-42ab-d892-08df13047755
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 08:36:41.4150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sPIxBgUORrKVn9KeOS0871xfQvnoiOs8ft4i9zV+105WELbPtuW2rnZ5VfLABYFOYdCtIhKWhM2i/Qo4LuER6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5275
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Sep 2026 08:36:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24181

Sorry for double-posting - connectivity issues suggested it wasn't sent.

Jan

On 15.09.26 10:34, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> This describes at which time which ares of the CIP kernel are handled by
> the CIP security team and how to report vulnerabilities to it. It
> furthermore state the this projects falls under the LF stewardship
> framework.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>=20
> First proposal. Please review and provide feedback. If we all agree,=20
> this should be merged into all CIP kernel branches.
>=20
>  SECURITY.md | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 SECURITY.md
>=20
> diff --git a/SECURITY.md b/SECURITY.md
> new file mode 100644
> index 0000000000000..f39a0178338ee
> --- /dev/null
> +++ b/SECURITY.md
> @@ -0,0 +1,37 @@
> +# Security Policy
> +
> +This project is supported under the Linux Foundation CRA stewardship fra=
mework,
> +as described at https://www.linuxfoundation.org/security. Security
> +vulnerabilities should be reported through the mechanisms described belo=
w,
> +which we will coordinate with our CRA steward. For actively exploited
> +vulnerabilities and severe incidents that may require CRA escalation, pl=
ease
> +use the project=E2=80=99s emergency security reporting mechanisms as app=
ropriate.
> +
> +## Security Context
> +
> +Open source software can be used in various contexts that may go far bey=
ond
> +what it was originally designed and also secured for. Therefore, we desc=
ribe
> +here what the CIP kernel maintenance is particularly covering and what i=
s out
> +of scope.
> +
> +Unlike the upstream kernel, the CIP kernel is maintained with the focus =
on
> +architectures and configurations defined by the CIP project members, see
> +https://gitlab.com/cip-project/cip-kernel/cip-kernel-config. Vulnerabili=
ties
> +found in code paths not covered this way are considered out of scope.
> +Furthermore, vulnerabilities that are affecting the upstream Linux kerne=
l as
> +well are in the responsibility of the kernel security team, see
> +https://www.kernel.org/doc/html/latest/process/security-bugs.html. In sc=
ope for
> +the CIP kernel are issues caused by patches not found in the correspondi=
ng
> +stable kernel (linux-6.12.y-cip vs. linux-6.12.y) or that are related to
> +missing backports after the corresponding stable kernel went end-of-life=
.
> +
> +## Reporting a Vulnerability
> +
> +Please DO NOT report any potential security vulnerability via a public c=
hannel
> +(mailing list, gitlab issue etc.). Instead, contact the CIP security tea=
m via
> +security@cip-project.org via email. Please provide a detailed descriptio=
n of
> +the issue, the steps to reproduce it, the affected versions and, if alre=
ady
> +available, a proposal for a fix. You should receive a response within 5 =
working
> +days. If the issue is confirmed as a vulnerability by us, we will reques=
t a
> +CVE, publish the fix and give credits for your report if desired. This p=
roject
> +follows a 90 day disclosure timeline.

--=20
Siemens AG, Foundational Technologies
Linux Expert Center


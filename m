Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BB9C3601E
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 12:37:01 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.61])
 by mx.groups.io with SMTP id smtpd.web10.46296.1744029416456781596
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Apr 2025 05:36:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=qN1cTl3g;
 spf=pass (domain: siemens.com, ip: 52.101.67.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGv4rvURYYo8Ar8eM1/HN3wKqrdWY3/Z/3ffRwWdOUEf6siR5FjbkLECoXbvv8DYHzwhQZeU1OrTTViVrOU20E386zM4mHPcQ6Jvsdr3Sab4UYSCUzDnT6H9ceTmePsR7P+/Goe8eQ/bQrh5Kj9rSbk+leSxLxcepNyMbwcSjRSWO+jxURrdArSmJ/3/xEFWu6Im1PDw9I8HUimtawPJHrubV+TjTjKg9NB8GwvTamv4ie6nX5XppLv3lEXz+RNJaHobMEaQTpvbkMoXJvk20uRpF+86Amw9eLZNjKWJFF3KS4qL8JLa++V/ZUfLfZEdobKMbEcQt5yO94vcR4nv1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjvsEUh2RAPIFgjRK0Q1JW9vuqSefc4dOYfz1z0V598=;
 b=jHFDsP5qKj+THcMG5m6sVKah5DKsK4lVMq2IdoqWbUmAFbCBmsUyOfQL3Mlmfh1IHQxOzJNBvrpS3ljl9f94FTfSOU647tOa0Zmm4AylDXO8xCFFj9wzzMEPelfC0F79BNU4ak3+BQ9S/sX4AyX7BIXzdrYu1aRf2/XzYZN2sway1LjELkg4o16a+aKY+FWs5zwE5AQdULPUqdfhHTWl54Vm8q6nIDXtEnhTTGTCd9+oq0F+vPjLnViJNNV5sqdpbJVZxATIDs5g//qXj798ZiBgXR6bm1zxJUwxCVNlcA6737pVNBoDIoJwNxITUoSDdS+ZVuHDyYWCeXi/ymUfuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjvsEUh2RAPIFgjRK0Q1JW9vuqSefc4dOYfz1z0V598=;
 b=qN1cTl3gGpvj7ixIL9HUQpG2pF203fJbp2O9Y1E3tf4TaBkFULON42iMncur70o4hq5U4Jwxp8B1nOlQ3POLZt+InXgh/vw008rNHd1I24kKpNgWZlCO+NZb15DOAa+TvtJ2vZcXDijMDLb2IuOpu6SiRzneIXu5WYL4uY529sz/OoYVWlA8UQPa/RQ44JhVbUYzrOTLzERVhntKzfBxGYs6YynuDTsIlnbXBz0EoJ4olYVaNhnRXAZGE0bWj+Ize06nCHio8MZle03xq5EwSDHj0EYh/eiPISGqxowarIEToyEAa/BO7KsiPM3CF7Yf4vNZ4vaumEww+y2sYHqs5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3682.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 12:36:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 12:36:53 +0000
Message-ID: <7456a693-f2da-4dd3-80c6-cb802c33a57a@siemens.com>
Date: Mon, 7 Apr 2025 14:36:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] ebg-efi: add support to deploy
 additional files on boot partition
To: "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>,
 "Hombourger, Cedric (FT FDS CES LX)" <cedric.hombourger@siemens.com>
References: <20250324125942.3548370-1-felix.moessbauer@siemens.com>
 <767a6356-b234-45cb-b2ae-9aa88acd5c2c@siemens.com>
 <854adadc34ff58166ddcd7ddd752b9ed469ae491.camel@siemens.com>
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
In-Reply-To: <854adadc34ff58166ddcd7ddd752b9ed469ae491.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3682:EE_
X-MS-Office365-Filtering-Correlation-Id: 8134e67d-5a90-4e67-80a2-08dd75d0e03c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gzKPr9urwk3S4aMcSStHdCQm7mwhBiltHiHCGdGeJC2FKzqZAakZtvTZdmLV?=
 =?us-ascii?Q?6ZS4jrs8Ux59avIQg53yHti1rVHbfui9XNj3b6UCDF+qQQBFPLKsKbyxlm5Y?=
 =?us-ascii?Q?55ei8vau1kSBRBuSgfYkytelyqhm/oQtU4UdsoITd4Lt7GuvkNw5IayiRvC7?=
 =?us-ascii?Q?xIus8Gq55SIUcMOPQikV99QxjW+Fc9W4GqO3FEnzpHbBLrz+XG45eM+8KVBg?=
 =?us-ascii?Q?6p50XDHq8gQsoKXYpI5CprJ3cMFby+V6ITHjNuS3KHs2LGRqF7G0k0ZOspDH?=
 =?us-ascii?Q?wU3ZOW51DZY+QN+JYZWcCccdyoITAZzgM4zS907yMSdEZYWTOqD0GAlvo2ME?=
 =?us-ascii?Q?FBOpXmNDP/JWCnRA3BwjuDoFxEwSGBCln3CdBzBAOvTVSxN2xkNxIzrKKVWk?=
 =?us-ascii?Q?B6U/Ad83Z0H10YWWVzoPokijO926jEGhaDp5UwVMqEGyIDoGp404c168FTwu?=
 =?us-ascii?Q?jn5jPluFz4WecGmIjbyi+EXk9aomAjZD8ue4mFr5pkUxKoHxCccYd+4HutV+?=
 =?us-ascii?Q?VDIfKMtITJ1bFunsADuy1gK3Xs/lqH/J3U169vucRgWk4UzEoylFxv/1bIHZ?=
 =?us-ascii?Q?ZZf++VF2j79efWCt/+R/O6O2Pn9e+1keRRFjkpxP4kgyoSKBxvcXJA2mt0qk?=
 =?us-ascii?Q?gDCXsJ0e8Jb/5GYt0q0ULS6BSXNo3mMbW4vREmQanFgU8pkju639tta6VQKN?=
 =?us-ascii?Q?CKqWV5vNun1ROtPYM+hkSwJyQ+b0m53psAqZXND/F55Qm5BiSkI3G3JBn1Jk?=
 =?us-ascii?Q?KGPHqPHO67KPxtTONwKUoTRf+2u6r0e+lE/V4b1E/qtSU6I72MwkzthX+jzu?=
 =?us-ascii?Q?/nmH2Nt8LwKYungLmJG6u0s/B+OQfa2FGMGbF+xrD8k4U3acGNXMELkCYoeU?=
 =?us-ascii?Q?iCN1drhX7JEjFNEwLqFVV5B/7yb3bEzPY2x8rqGfIbbX+0O48XhY+RDGx4ek?=
 =?us-ascii?Q?Fw9B9WNQdzD/l8zj98zLstUDjhl7g28UebxEeCGH2t48efRERFSpv74KGOM5?=
 =?us-ascii?Q?Z39dfSVNaSt5+jd2LxkFyPYLPT3dzKhMhcLvUYNr5IfFsE1SHBzbSdrvuZm+?=
 =?us-ascii?Q?VjF+GrxcBB+drq3CHsz46O6sq4Vf/YcQ7pU4iNZcKqGl2dFgGoS9UeroVEal?=
 =?us-ascii?Q?YdxDV1n5qltE5GzgDawxvl/JtNuF37wI0cloMxjHWxostET9rT4a2v3/SNyl?=
 =?us-ascii?Q?FScnV4sClgWmkllpqN3RZFGEHaFVjiZM5WSRwtT3EBbvH+X+Ur2XRWIUNlPc?=
 =?us-ascii?Q?B/xpOJ3ry6oT/IOugy4fKp1i/Su+qxzYVl2oEl4xWHElzqiAMxvHCM8YSXzm?=
 =?us-ascii?Q?20fkduSsBHFBG7vIaoCW6ooqaly4lZ5GPp2MxECaap4bI2pE/XgrVnsTwfrQ?=
 =?us-ascii?Q?wA9unIbXzMGgEBCeMqqFq77YURmg?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Opm154rVZP4rrbstLKjPjLh5s5iCYZD2d+iH7MmQ+5+F+iAgn2mz62G1VzKv?=
 =?us-ascii?Q?ngl0lpD5VHrtagqh6MFGEE4ATe2pSsaaGsPYwEHjGL+Gi31TJbGwHq15w1jW?=
 =?us-ascii?Q?Co1SKgcIsMWNsADCzz5rHKZhTDCc5Ry6tdi4W2GCjz6GD52C6FGKe5aNYZW7?=
 =?us-ascii?Q?71MtiZTy0N9/R44MFmXxUnbVMXzw7L34a8dmJ7MxgtSbDNWKu/Qxj/nJbAzq?=
 =?us-ascii?Q?D4jxfHZYOJSGpHL3SJ+TdRcLQ/FJCZIvUJU4MFBeaeuV3YWBm21s+oesVgqt?=
 =?us-ascii?Q?S51mGgbieGOhqSC3+TTFL3kztbjaGu9ofL4fciIrZzJJ3Qr3pcKoaXf3MyIi?=
 =?us-ascii?Q?F6Fd0A0vK4VLLm+8LmcfLquGA4eUL0Wn1B9bf3HJhlcss7c8Rz3C22CrkMrz?=
 =?us-ascii?Q?YMQkUzR7p2uTkV87VPlXp7kQ6dn8FEU04gyIDiYw1ZMBsdoBFPONHVlxBa3Q?=
 =?us-ascii?Q?FRZwTSDf7au5+b3PmJ9ZKoE2w2gI74EaIf5ySP0JpYge9okg4H87QeaFB4oa?=
 =?us-ascii?Q?3hCymgCly6/L3HI4S4/7vV6k1eCt00CDjxvomlnt3wpu76FJxYH7avIfqy07?=
 =?us-ascii?Q?AjCrJIGairxS0dvtegof6QaxooIYOkZmlz8ixJSC6+fy36y8xxcq3xnKk+Mi?=
 =?us-ascii?Q?kQi2hDyLrXgf5CC4SUp85v1QNmx0qIpm9iLFdjCuXhjwfUuSqyd9YlTlphky?=
 =?us-ascii?Q?7WKAxgy7Dcwh7b4bCndctKrJcgSzZwB5+FAX7fZAzIN4093CbZS/CjTxwGdi?=
 =?us-ascii?Q?aHTQ8WAxO7JgkLNHnS2kj2tO/HDkglCwK7NTfGo1FmyqSijZH7SvDA/NQZIm?=
 =?us-ascii?Q?17Mi6cnZXOP8IFUR9eLl5Dy/6co50w/Jcz/bHaAM2/5uq8DNPUWLGME3i2i5?=
 =?us-ascii?Q?zxdPGO4jc1veoIZUJ6eNAMCWyE5JFv6Rt5n/1FCVM9g+TSzLfrfZCMd9qer6?=
 =?us-ascii?Q?cR5DTML3eE6XslC9SaupEfY+anwsGzubnG5CgY88QSCjDA/dpkQv8SqdgZeM?=
 =?us-ascii?Q?hgwhDtoguFTRvcLrh8QR1GS86xLOwwEY2xR/a1f5KbJtHtxyVhfZyypqaENK?=
 =?us-ascii?Q?mL5QfF3CvAu/rswfAbTJMh/Z1vIW/jI/lK4hcFG/KKoXIDZWK0o13DVzOKv6?=
 =?us-ascii?Q?BaMofOvxdLH3lTlseQEhYF36RtgQvQ1vfH14GpFbvveaRgmbz1F1jGYojyby?=
 =?us-ascii?Q?Op9J9rZ2nEr7kh945Kz8vHsLR896kf4hDOh6MNmlTLi2PPMhMlzVW0bLWOtO?=
 =?us-ascii?Q?/daH452xY6E96yWNMwV6wgDb998m/dEoEclVuA8Cb/XNg8PMIFhspqHS+7Yd?=
 =?us-ascii?Q?IaTc8djXZWOK6aqx5pNPp5GYnejUAK3L6z9cbZgNrsZRk+G45Xun50xYoqqe?=
 =?us-ascii?Q?qTJ5YIOoT/qelPM0rpmLYt54aP7eNyBK6qaQqKBfOFt/hj2d2ECr3fYg9nc+?=
 =?us-ascii?Q?XtHVR1ydvlpKN/zp8Vt8C6k11qeTNZTiKXIsPhKul5KNW71pwpX3yxGB1IRF?=
 =?us-ascii?Q?G5444tl8X1LNOB4tu6ilXqD++Yi0p5uXOrJ5CKFBuQQcuysEkHaMuo72r/yX?=
 =?us-ascii?Q?PZJfgzJj/dtRgtl0bLDg2uFlQaFIuHuBseK4KzJQXiUXEj3T9DUEe20xvXoI?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8134e67d-5a90-4e67-80a2-08dd75d0e03c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 12:36:53.3603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1kyCvDRzN1WH6mAfItbySyyE9pS80nkYzgrbwCBOBBHdrgWXmmeQg4GxBjG3DLEz98GiqdnToTFjdISsUb8iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3682
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Apr 2025 12:37:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18488

On 07.04.25 13:39, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
> On Mon, 2025-04-07 at 13:28 +0200, Jan Kiszka wrote:
>> On 24.03.25 13:59, Felix Moessbauer wrote:
>>> Some embedded systems (like the RPi 4b) cannot directly boot EFI.
>>> Instead, they use a staged approach where a first stage loader then
>>> loads the EFI provider, which then boots the efi target. For that,
>>> both
>>> the first-stage loader, as well as additional config files need to
>>> be
>>> added to the initial boot partition.
>>>
>>> The bootimg-efi-isar already supports this for both grub and
>>> systemd-boot by adding files to the IMAGE_EFI_BOOT_FILES bitbake
>>> variable. We now add the same support to the EBG wic plugin, by
>>> copying
>>> the code 1:1 to efibootguard-efi.py.
>>>
>>> Note, that by design these files are only copied to the ebg boot
>>> partition, but not to the A/B kernel partitions. While we are not
>>> yet
>>> EFI bootet, only a single partition is scanned by the firmware
>>> loader.
>>> Once we bootet EFI, there is no need for the additional files
>>> anymore.
>>>
>>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>>> ---
>>> Hi, this only adds the infrastructure, but unfortunately we don't
>>> have
>>> any in-tree user yet. I'm hesitant to add one, as these targets are
>>> not
>>> official CIP targets. The code has been tested locally and is
>>> really just a 1:1 copy. If you have ideas how to test it in CIP,
>>> please
>>> let me know.
>>>
>>> Best regards,
>>> Felix Moessbauer
>>> Siemens AG
>>>
>>> =C2=A0.../wic/plugins/source/efibootguard-efi.py=C2=A0=C2=A0=C2=A0 | 52
>>> +++++++++++++++++++
>>> =C2=A01 file changed, 52 insertions(+)
>>>
>>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>> b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>> index 48f7523..cce948e 100644
>>> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>> @@ -29,9 +29,12 @@
>>> =C2=A0
>>> =C2=A0import logging
>>> =C2=A0import os
>>> +import re
>>> +from glob import glob
>>> =C2=A0
>>> =C2=A0msger =3D logging.getLogger('wic')
>>> =C2=A0
>>> +from wic import WicError
>>> =C2=A0from wic.pluginbase import SourcePlugin
>>> =C2=A0from wic.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPAC=
E
>>> =C2=A0
>>> @@ -42,6 +45,51 @@ class EfibootguardEFIPlugin(SourcePlugin):
>>> =C2=A0
>>> =C2=A0=C2=A0=C2=A0=C2=A0 name =3D 'efibootguard-efi'
>>> =C2=A0
>>> +=C2=A0=C2=A0=C2=A0 @classmethod
>>> +=C2=A0=C2=A0=C2=A0 def _deploy_additional_boot_files(cls, boot_files, =
kernel_dir,
>>> part_rootfs_dir):
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # based on bootimg-efi-isar=
.py to get consistent behavior
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # list of tuples (src_name,=
 dst_name)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deploy_files =3D []
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for src_entry in re.findall=
(r'[\w;\-\./\*]+', boot_files):
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
';' in src_entry:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 dst_entry =3D tuple(src_entry.split(';'))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if not dst_entry[0] or not dst_entry[1]:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise WicError('Malformed boo=
t file entry: %s'
>>> % src_entry)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 els=
e:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 dst_entry =3D (src_entry, src_entry)
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg=
er.debug('Destination entry: %r', dst_entry)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dep=
loy_files.append(dst_entry)
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ins=
tall_task =3D []
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for=
 deploy_entry in deploy_files:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 src, dst =3D deploy_entry
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if '*' in src:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # by default install files un=
der their
>>> basename
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry_name_fn =3D os.path.bas=
ename
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if dst !=3D src:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # unl=
ess a target name was given, then
>>> treat name
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # as =
a directory and append a basename
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry=
_name_fn =3D lambda name: \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 os.path.join(dst,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0
>>> os.path.basename(name))
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 srcs =3D glob(os.path.join(ke=
rnel_dir, src))
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msger.debug('Globbed sources:=
 %s', ',
>>> '.join(srcs))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for entry in srcs:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 src =
=3D os.path.relpath(entry, kernel_dir)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry=
_dst_name =3D entry_name_fn(entry)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 insta=
ll_task.append((src, entry_dst_name))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 else:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 install_task.append((src, dst=
))
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for=
 src_path, dst_path in install_task:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 install_cmd =3D "install -m 0644 -D %s %s" \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 % (os.path.join(kernel_dir,
>>> src_path),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.path.join(part_rootfs_d=
ir,
>>> dst_path))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 exec_cmd(install_cmd)
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0 @classmethod
>>> =C2=A0=C2=A0=C2=A0=C2=A0 def do_prepare_partition(cls, part, source_par=
ams, creator,
>>> cr_workdir,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 oe_builddir, deploy_dir, kernel_dir,
>>> @@ -100,6 +148,10 @@ class EfibootguardEFIPlugin(SourcePlugin):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exec_cmd(cp_to_deploy_=
cmd, True)
>>> =C2=A0
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 boot_files =3D get_bitbake_=
var("IMAGE_EFI_BOOT_FILES")
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if boot_files:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cls=
._deploy_additional_boot_files(boot_files,
>>> kernel_dir, part_rootfs_dir)
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efi_part_image =3D "%s=
/%s.%s.img" % (cr_workdir, part.label,
>>> part.lineno)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 part.prepare_rootfs_ms=
dos(efi_part_image, cr_workdir,
>>> oe_builddir,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 part_rootfs_di=
r, native_sysroot,
>>> None)
>>
>> The upstream plugin also has support for IMAGE_EFI_BOOT_FILES_uuid-
>> XXX
>> and IMAGE_EFI_BOOT_FILES_label-YYY, apparently to target specific
>> partitions. Left out intentionally here?
>=20
> Yes, that's intentional. While these variables exist in the plugin
> itself, neither ISAR nor Yocto auto-forwards them. They are also
> nowhere documented.
>=20
> As our wic plugins are as similar as possible to the upstream ones, I
> kept them in (in bootimg-efi-isar), but also did not expose them.

Fine with me, just a sentence in the commit message would be nice.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center


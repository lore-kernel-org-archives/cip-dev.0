Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2A61094480
	for <webhook@archiver.kernel.org>; Sat, 21 Mar 2026 14:45:27 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.37])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12152.1774104322224096077
 for <cip-dev@lists.cip-project.org>;
 Sat, 21 Mar 2026 07:45:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DC1RqKE2;
 spf=pass (domain: siemens.com, ip: 52.101.69.37, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKDESRD/ny3+fdbIRfEBnTMIbc7nDj4VZ6vfndNULsx6xp0o/JhrGbFLyVBoRgWksTYrAYuylKnL+QTFjtpZgptQW/42XqvgZDOly9B7f//BnyKXufmJKyMUJdvoDYFy3bRlNXIPDjIeiN/iO5oKjneWozSG2da2ByrZvgSQu4LDVK1LA56U8R8wYbbkW+9/YXCDL8I2FXDWgVw4Izvir5U6GzlII9NBMjDYY0t1SBi4f6zZa70F7X9KuDJkyc8ocxHBiqBxoteTV4n36Rhd3j6e5UZXoOd60yhsTVw3NLe/JElHrsWaufCOxu5xEkiZ2lMOZ/VFy+jxklB0m3Eq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBrtvi+sZ0L4JyTet1IykE5qZNktUVs5225K/qfUZI0=;
 b=DuEuGjBOErAYt3P+WI5oILtCN7MsiXcSTYvBuu15B+GVcfK8smLk2lTjuBP5klKnIXVz2ByiJ/cVDbxsVH23dEhdGHWzjL6xaT7cBVUaTHjvNeh8UWBg3Ts+mnloe/CQmjvsS/SRQHfYcLEMId0R7QamT18EeLz7CqR4T7HUvPYNjVBIyd9uJAHq1CvOvkJozT8SZzSUNM3OB9ESaUop9CiQ0nUkEzzj5Tr/NGaml2c1yA0Ppf3ZNJlcW/uby1IMDgDof95jihdyBuA1ByhmnqwXKmMDOdonNv3aUnOzyKnEc5HJ6v+bEh9wt9plumYciTBjc4PIQaLIsWgzjzDIZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBrtvi+sZ0L4JyTet1IykE5qZNktUVs5225K/qfUZI0=;
 b=DC1RqKE2bl8Lsrj4c0Rt5olZlRq7XlR4aba2dal3rH1DuuXhMEAp0lFwRjQ+Frj95JWr8yDyVfzlGW0e0xyk7oR/bT5a9fXW/zXwuT3hvd6vWMh5l9ffCGf22c+xhkWZJFIh+4N7tguJf1gyiZR9NCneAavzKp7Qicsc4DykOq0gdZwOehLXn9sNPdyKqYwtd8TFPOm8CDqV6kJuNdNYhpgMU70Mn+gsG+f/HZzDhYnduc3/O4eIMM6M7tsZof23H8r0+wyfacasNrMyiB8cak3+m0BTlH0I8deya6RKFwnxKP2QrTVHhauYbLDTY2EX3QY8rqq3APTgc1x8RWepYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8503.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:442::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Sat, 21 Mar
 2026 14:45:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9723.019; Sat, 21 Mar 2026
 14:45:18 +0000
Message-ID: <2c7654bc-48db-4da9-b194-e8cfdb85df98@siemens.com>
Date: Sat, 21 Mar 2026 15:45:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC v1 4/7] SWUpdate: Use the
 backported package for trixie
To: "Berge, Matthijs ten" <M.tenBerge@awl.nl>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20260310044554.990348-1-Adithya.Balakumar@toshiba-tsip.com>
 <20260310044554.990348-5-Adithya.Balakumar@toshiba-tsip.com>
 <DU2PR01MB8493F2CB94CB39B9C3737676E74CA@DU2PR01MB8493.eurprd01.prod.exchangelabs.com>
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
In-Reply-To: <DU2PR01MB8493F2CB94CB39B9C3737676E74CA@DU2PR01MB8493.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0337.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d4d0380-5c83-4875-3b3f-08de87587876
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	J78CSHloLIKKkErpkt1NqdeoXuOQ5wjL5KgJunfBbeMN4oMWSR5DlQE4DO/uP0NmqjVJiC9V/cB2KzWwwoId18MFPH/LZ3go+sG3kaIoX8tEAGQzkwg1wFKlMXle+3EghmPfIL0qTZ/kMqTIEJG3yoGdD5K0tiGEb0j7xs/SMom65A3zyB+0m3F4SMjiTE5z+ybGDfl4Zb4I28mpPTnVh2M93NriqYmf4aEHGxtquLEPT1D9O6Q9bl8j8WQ56JQ3qI4e66bRazhw93qXpitwcdLiYwHFZ7pklqngwzAQ3pZaKlet1V0MKUmJf0fDHdNspshr1vKybR05zS9Umc8+FVg3fiK6/gFFVCV96nFVPcINjHxcLr0QRgWU+aqGpH+4V6zg/mz6nBBCYQ8gOVH6/SQUs8MDl3c+OqntsQ031k48vfOimbFmh+xzfrOy/XL6cPLjaGxTbefSzLWCJiT/DKF6WooottwgTCmD7E4kDiBhrN4DuGN42wwhp4qBdF3eFFEn+UGzVyIQixmeH7Zik+HRZJZIwx82VBnOm94MlDVZChrYNxntmhKDbgatMchYYpx+4G3Vn6JPsn1cW2FIA+Pn0vKicxI0omuy6L1eiKq8nLrvOZkdag4vbBkH4qlhHWJe4IVNrevH8RpLPQkffR8JMFB8jurC7An0BbKnaHn0gqnVu+WzQTTEGqHTf/J/Iu9pGbQhUxkv8UDDOUyiQN1UsT2+DWzn2I5C4Ke4UcI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VzF6U3ZLYThLRnp2dzBkTktkeXhJTDNQWmE2bExnVWxUb0Jwbk5pY3JCTmpD?=
 =?utf-8?B?UzVSeWp4Ym9lYitOSzZTV2xUNmRvZCtkQ001VHFycVhxcFJVN1BnUEdQMzd1?=
 =?utf-8?B?UXdCVU5UNWJuTldYTFd6SzN5Z090SGFJdzd4U2ZNb0g3Qy9Ga09pSkthMFlk?=
 =?utf-8?B?aWVYR09tbWwzVm1JQkNrRjFFRzA4dGlCUTRFLzNnSnhSV0RaNjN5N2JNeFFN?=
 =?utf-8?B?dmVXTWlTRnUvZzBOT1NFdGVlT2hjZnlNV00vQTAyd0FYZzZNMFp0QWpQMWJn?=
 =?utf-8?B?QmV3aER4UzRQakEzcWs1OFYvcVFRZ0FSeDl1d2doMW9LeU9Rdk5kNmFoYlh3?=
 =?utf-8?B?VUNQa0N2VENraVZKRFJxS01PQnhKY3daZVI1L3lBMmlaYVNwUFJWZldueWJI?=
 =?utf-8?B?OWU5K2s2M3M5cndna0xtLzB4SzBmNTUzRDN5VWxPc3Nlbi9wL21VdWFWbWR2?=
 =?utf-8?B?UWw2Q1FFelJ5bzZLK3NEL0JrUUJ1OW90cmFGdFZPU3l5anVSOWQyV241WWFq?=
 =?utf-8?B?TERYUXZNbjFWV2N1UmtFQUxRK0R2Sld1NmJiNUNVVWpGUnN3eUpmTEd4V2s2?=
 =?utf-8?B?d0cvSDJUZzMvYXh1SkdKQ0hEREFXUWdwOGsxU1hsZWZvdkREUGdFTk9XNUVZ?=
 =?utf-8?B?Y2VDQzQ1ckltbDZkME1ZZUlFb0xITmlteHprc1FvSjE2ckYyUWFIYUNGY25z?=
 =?utf-8?B?WG4yTWloZjl0VFFkcHY2UEJ5cnRsc2xCRi9WMWk0MG03cW56TWlxQW9TLzl3?=
 =?utf-8?B?eDFqdCtlSXUyVys3T0o1cGd0WGRuQjk0V1B4RGtCU1E2Nzcwekt2Mk5iMlV0?=
 =?utf-8?B?VG4yTDZlRW85Qk9QUHJKUy9hekgwM0JSOWhiZklsSmVsRFlFRmRPWkpLek1X?=
 =?utf-8?B?dnErUHBJM2lweE9MU0J2angwdHRRRVpLMnkybzhhamFOak9DbFkxTlU2eTNQ?=
 =?utf-8?B?a00rNms5b0JuYUoyVUhEVmJwNjhZVUpUUFA2NmRvSnJoN3BpdkZ1NU15dUpo?=
 =?utf-8?B?Y0dlQmZOSjJ6SnEvM1JrQVBDNitQcysyVTNzU3RPdGNRckI5RDBOR1BXY25F?=
 =?utf-8?B?TjlvMW40dnpBQmFDODhGeWl4UjdVTXFqQ0VKS2FtOU81ZUIxc25NWFRjMnp5?=
 =?utf-8?B?RHdjQk5XMUVkOVdkSSs2RU1URFFrSFkvL01aT3VtMmlmUzJzTG5Sd1A1cFA4?=
 =?utf-8?B?UEp1MHNTL0pDQlVra1F4MVhSUFBQR0tnb2FTNlM0eDRLYjBTeldYTC83Y2pL?=
 =?utf-8?B?WXZsNzQwV243dHNmMzdBakt3TG5nai81T05CMC9OWFl5U2srRU5JSzlDQVFK?=
 =?utf-8?B?RHQrVG85MDl6MzlsdjVYUXhRUUZpZnhaaEl6NFlaQlFZTGEzRjdyanpneUR0?=
 =?utf-8?B?aDl6cG9ObzQrZCsxY1JKRVlMd05uT3ZDWDk0d1oyd0FpTnZLTzlUNmFrbkJW?=
 =?utf-8?B?T0xCS0VjdjNDa3k1MUVvZ2xtbFlpZ1hLL3kvRVBJMkNEUmtrSGU3UFhxYmUz?=
 =?utf-8?B?WWxkTGtlVEw5SGpncXBBSUNmRUZFR1lhK3ZVc0JjdHBnZDRWWGlTU01UeXBY?=
 =?utf-8?B?SGZJamFrRmlyTHlDSWhDK3pPM0swYVNlSHFDclJadkhKTTVxVFphU2U4aW9R?=
 =?utf-8?B?UEw5YnhOS3hoVENjMVRtMk1DZHNjNG04V1RHRW1VaDFPL3g5SzR6M2t1dVZP?=
 =?utf-8?B?Q0ZZSlFQanFYNzFWMUx0QWR1dTZGMXl3Vk5vWmkvbUhpVjFIS3NVL2JTQ1FW?=
 =?utf-8?B?SVZqcHRJK2dOSU56WDVFVlVNWTZvanhGSmVDNjFFMWVNWktPMU5uSXhFdk1k?=
 =?utf-8?B?SkRjWXBmb3dyL01kbmgyTW9MOU9LMERmRmMvNDc3clN6TjVaTzQ3M2RXTzBp?=
 =?utf-8?B?c2s4RmcxaDVpcGVDT2JIdEh3RHBmd05EQ09LZGYrZmh5alI4L0YzNGllTTJq?=
 =?utf-8?B?cTY1L1RYTzUwaWNYMlByeUxSb3RYSDZYQmpGZ2E2QUdSejc5TnJrQzNtMlVj?=
 =?utf-8?B?a2pneHdYTnVMMnUwMFBpVktKTG5ET3oxSjJMTkxwbVA1SnpVWWdFZjQzT3BZ?=
 =?utf-8?B?SGRQMHhoaXE1S1VLbjBnOUE5RGlZVDZ5cEE2aGlSRDJBWHlFdUhLb1B1UjIv?=
 =?utf-8?B?bGg1VWtHNkdCT053L1pBdlpSN3pXa1lZa2xpalFRNzJZZm5uZWRhd0F2YVpR?=
 =?utf-8?B?RjFheVoydkVWbGVBNVhBT1hJaUxHb0I4SGRoSFpoM0tyOG9sMHpLdkRnclBu?=
 =?utf-8?B?cFFhM2lnK3BZUUJ3SzcwUk91RUtLNkhHTmFVZ3Evb1Z2RU83S1dUWXBZT1h5?=
 =?utf-8?B?S2dSOVlRTis5UStvTUhjTG5DSXVEVzg3Y3JSYmVEMThOM2N5S016Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4d0380-5c83-4875-3b3f-08de87587876
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 14:45:18.2858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtdD3qT/WfBUxz+V752r9J9kxChGNLhTBTN+y/W0XpqdDjmUxn/56aWL8n/ttZ4sms4zCJzMLYMzdEkBxaq29g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8503
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 21 Mar 2026 14:45:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22520

On 20.03.26 15:18, Berge, Matthijs ten wrote:
> Just a heads-up about this new version:
> Our tests with this new swupdate version from Trixie-backports failed at first. This is unrelated to the onboarding functionality mentioned in the patch below.
> 
> Building succeeded, but at runtime, an update via the command line failed with:
> Unable to load key - Crypto cannot be initialized
> 
> The solution was to explicitly state the correct crypto provider for the validation of the swu signature:
> swupdate -v -i updatefile.swu --digest-provider opensslCMS
> 
> Apparently, the new version contains multiple crypto providers/engines, and the default choice is not compatible with the signature type used by the swupdate recipes in isar-cip-core.
> 

Thanks for the heads-up. We will have to take this into account when
moving forward, latest when going to forky - unless this is a suboptimal
default of the upstream packages and should be changed there.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


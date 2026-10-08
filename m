Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D1FCA6007
	for <webhook@archiver.kernel.org>; Thu,  8 Oct 2026 09:23:34 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.37])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11391.1791451403411106816
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Oct 2026 02:23:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hUw5I0OQ;
 spf=pass (domain: siemens.com, ip: 40.107.162.37, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUyMW+6eYf6N5yp/a30Vv3FMsPJEriu3DJlYvNfyVY4zNr8hhWNvh2BZ0MAraOiaxHOSEuaqB4t51lXO3iobinHW6DjpIrr4X8G9WHrYgOjsc7lad6VblUMd4Jj/ESkbhJiQnLLTpaWZCdHEB8eDK+DST3HaVRCDPRNYhqwgbkf87M4jkWIC/WtARDGTCYbaOmjPjaFlpYaqts9QkG60S+O52rHRYJRmyLJSU4nt4ZZbaKV4ezXkgpVmKS9fHu8TkQuB8xxezinEcwtOcHzbp2fwYjAVHnguinsEXf0MLNGNFjq3W55jXsEQqpmEE86cv3nq+R8VdQWw9bct6SzH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13lJ/xrMG6P4jcLFfhLSvGSBYmr8T7oCE2gVEFYeEnI=;
 b=J7y+m/cvm3dfVjGnbTN/AQWLs3mHhU9rG87ZxeGZjxKV6R65vm7dkImWRKhUQsgi/U05jXCYLZ4lxKSVR//jtdfY0wqCbvu/vRmz7Q5MamhHKx4nKUZfzwhr9BR0l2FXjWtUShnXhfRRf3BKbrq6VZXOl795nLUcl+aKwqz/KfWQHCfgECU3KaNPtsEdXA1l5xiZicl1BSB+eHO5MaPl0RhgYj4u/WKADYUfEYEo/j8LWvZEGc63FVUKafNagbqiOyOzs+zuLaEamYPxUg8+P262BmZCds77CfSnTLRva6+5bq+HAKbzF4Mji0MkH1+mzS1jYVqXxqcZxQKmPuF93w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13lJ/xrMG6P4jcLFfhLSvGSBYmr8T7oCE2gVEFYeEnI=;
 b=hUw5I0OQ1UvKgflL8DrWeV53eENIN+1isK98S9lRJcbR/ajPcyyKwuqu1gTEpzRtKtefrdPi/e2BvCfbFkLtyGL+3PaUbA500rO8iIfISH1/c1D+vr3IvbeAhBbjJZYumjz5GCwGoR21YpqFvfuiptGYMTcMCYjSUbMAFGDohmjPh9p/mETDE+/MnZ3+YqfWOi4W3vVoIa2jaOgFE4CMja+hFHwDtifZMPDMstMySitaP1QbaYt/tWESS0M8cPFaMPVOagnQgjHZBKbs3FofkoatVzTUWPO2qZqCQy145r8OsU8S5SJ40xHkrN4fiIAIcb4RxdicrJwVjb1vgBjgLw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by GVXPR10MB5792.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:6e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 09:23:18 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 09:23:18 +0000
Message-ID: <a473fa93-b5d3-49a9-98b8-f1cdf6a86ee5@siemens.com>
Date: Thu, 8 Oct 2026 11:23:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: CIP kernel lunch
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 Pavel Machek <pavel@nabladev.com>, Ulrich Hecht <uli@fpond.eu>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Arisu Tachibana <arisu.tachibana@miraclelinux.com>,
 Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>
References: <06640825-6f58-484e-b9e5-5e5349938fd0@siemens.com>
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
In-Reply-To: <06640825-6f58-484e-b9e5-5e5349938fd0@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::14) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|GVXPR10MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 39759dd2-2158-438a-697f-08df251dc9c2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|55112099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	EUIbTY1WHBIydu2bFjCwVmdRdSVl2C1D1PK1T1wK5UWy0F4FKX8KoN6BE678cR/aFm+8/0UnlVxtpI0eQMS/kbYI3aokbsEJWngVqf/RdXyzPQ9CeJrdKY0BCq694mqKOBJPJ3cSQUcm7gMQ4p0gpHEsGst3I6A/yY/dHQiKhftpgPMFa6nROuo05YsRzcrc5b4xAnxgFVQXnWY77+B3a0IUYJ1Q/nlBNlqwc3mA/srZ3SH6MSqX776DN2bMincaZ9f+ieRVUTlBYrv453/oIsrZEU6Y8PBLY7VzPuJTeTNwWcqOeDYV3pC9CidnWf1mst+Mg8J5UsR7EDXv7FgHC+fnm9kV08e43H2w0onk9CI1ZIT2LjxcuNESjdTjPa9kyg2fUN3EYESJBpu9O3T2cexyMyNNopbh2/kmVUhusGE4/S7sS4h4vnvQzoZyMB19DXUjeNoiO3GONarhsceDjyiK6nYLtekDZ3yr1fmJJ5EmVQM+LhxLm0f33Jozl8aRpwauRibo6fqjevc3QaPulliRnBanc56+B2xocRhYXW6nD4JcgsISoQdVVTpwYI5iytJO3I9pR3ssD/NniCzOC+EqtM4TM11pGZTwlbpGhlwGy0ibw675ztbi8ZTb5PprNsiiioilCX3Mau5ObaEyhwyq7fRfQXP41CJHbpeSCDk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(55112099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aWtBUHBDb1B4ajB1ZWhRVGJKS3FYRkdRbkVqbm9NbHhCMTlteWJHYm1jMTV0?=
 =?utf-8?B?VjlDYkEwZUszZC91RytMOWVta3ROVTc4aTBPTkRFL25Mc3NWblZKck1CcUFY?=
 =?utf-8?B?ei84S0NNdU1LT3VpbGZkeXBFZFZRR1BOVDhmeUNrTG8rdlh2WGs1cG84OWJS?=
 =?utf-8?B?c1VmNXNUWXMrU3NycWZiOWJISDBSTG1tbE02TDZxT2lDbXRFN2haN2NXQXZk?=
 =?utf-8?B?bndLZGFrMXVaYWdERlNZWG9BcjE2MVA0SVhva1RQcTA2cmt6MnQ4c2l5Sysz?=
 =?utf-8?B?Ukg0U2dVNm94c0M0QVkxRFlRTWpMNFFIaXg4bGgxSTg3WkVJNEUrc3lobXFE?=
 =?utf-8?B?SWJ1T3RHVXpCQUVGN0pCQWJxcUM3dXRMR2lPek9aYW9xME1XY2xqaFR2SEx2?=
 =?utf-8?B?YnR6OU1lb052VE03dkFObUtHdHEwY1BDNEZ0bUZGUUttVHVmUUdBRE1lQUtQ?=
 =?utf-8?B?ZnJKVmpvR0FHcnBrM0hSSlJYdmg0b2hQa0dzQkdnZ3ViMmNDVG02UWE5TkVh?=
 =?utf-8?B?em5OZ05vcStaU08yY014d3Y3dktiRy9TVkMyYjRvM0VjMEZqZldHcUxjejZs?=
 =?utf-8?B?bDd2Qlo5Y3hpRWZnUnV3T0J1c0MweEJwaWFxeHZRekUzWmNQaW5TbGVvSURB?=
 =?utf-8?B?dDQ4SlNzN1NPTnFvdFJEK1dkYjREK3JkYldaVEVZelRoOXFxdDZCb1E3OVNv?=
 =?utf-8?B?SlVFbGwzZDNuRTluT2FINnd3TnNINGMxUFZBQlQvZWh0b05jazQzOVd1UVFM?=
 =?utf-8?B?UDdsWDd4RkoxYXY2cERrVDA2S0xNNGxpdFQvMmFSUG9pNDlUSGJBTWdhUTcz?=
 =?utf-8?B?QXM5bmc2Rkcya0xIT1k0T3I4dGVsYnBXMjJxRE1VM1ZFK2VSN0p1d3JXVnZ1?=
 =?utf-8?B?WDdVSUI0N0lmcHM0ZWFOUDlJVDhTRWdaVzRUL0liQ1BERkpHSUY4WkxBTUZj?=
 =?utf-8?B?b29aaGdvMHMrbFVHWU8rZllCcmR6c1c4TmloS1dkME5ORjRqS1dEQjE3NDds?=
 =?utf-8?B?UkRaRmlJNzh3bTZhS00rd3NnZUN0MlVFM1BZRkRpVE84MXlHa1NseStKaTBj?=
 =?utf-8?B?OVNQdnpwU1NPNHdISmM2UUNuSlBvVHVpOS9oc1YyUXdmQ2p4TXBJTmRBeXc5?=
 =?utf-8?B?WHZmWHd6ZkVOc0FJQTF4SVkvd1kvMUw1ZEU4N0xpeUM1dUVhU2g1Rm1Kakdi?=
 =?utf-8?B?NEdmZU9xeUhSQXlsL3VwR1pCU2dPNkpXVE5pb3pQNlVZdTRyeThlWi8ydnB3?=
 =?utf-8?B?YnA1Z3ZUeUN3VjQvakxKN2QwVkkwQWhhTjhMVHhOYmJYNDJZaWdNSkg0UWU4?=
 =?utf-8?B?SExaeGhHTmVlTENlc3dNSk1WT2xWZDA1Z1ZqTitYZThoVkNkQW92c1VkYXFV?=
 =?utf-8?B?c21MeVZyUWg4Mm5WNGFrQ0ExMzFvUWtrV2NQT0JrTURuU3hjTDN6djlsY0NZ?=
 =?utf-8?B?dnZ3K1o4STVIcVYwbXVwNUlQR2NyZjI5RGxBckhUTktXQWNHMWZyUVQ0Qzhl?=
 =?utf-8?B?eHNxRGw2REpDWHRyN3EzODhaT3dpL1BXOC9LWDhEUjBKNG1VLzk5aGJSNXVs?=
 =?utf-8?B?c3dLeG5RSmNHMUFTVllOVTA3ZS9IMEh4NDI3RFBuc2s4S0dPd2lLZE5wK3Y3?=
 =?utf-8?B?QU5QN3VjMlczSE8rL0dsV3FKN1BJNy9OeUduL2pZb2F5S2xsSy85ZmxJUytE?=
 =?utf-8?B?V2RrNm8zR2sxMkZ2RWRPM2cwWmtuRm1kMGFIS2RLWFZvNS9Nc2hoWXhCSUFJ?=
 =?utf-8?B?TEMra09MZXlEbHl2S3dPTjh0T3M4MWIxRHgzVjltbVFMa3ZpbVpGcE5Bdk1q?=
 =?utf-8?B?TW5reUMyenErWFJweGJEVnJJN1UvQlB3OVFZQi9KL2tNdGNQOWRDZU9aVmdN?=
 =?utf-8?B?QU9tK2t0SkcrM0I4OUFNeTRTOWtwbm9XVmFteUpCa2lORTAzL1ZvQTlpVSs2?=
 =?utf-8?B?WUx0UXUxV0lFSmRuNFhVSzBtRGxia0ZVZ3pnQ3JPejhOM2tyTFdIdUtYYitM?=
 =?utf-8?B?bWwwcnI1UnRMZm9Ha3dQUFN1YmUwZWRuaklGZ3ZMYk9XaEMwclB4OWlTcm12?=
 =?utf-8?B?TzNxclorZG1xSytZeDBiWkxLMmJkMEU0SkJ1VkdCZnZ5aXprUG50c3RxR0Fm?=
 =?utf-8?B?cmlMay8wYlFTQnpKek1Ec1hhRm5OSjM2K0ZCN3VVUXkzRDF3cFJEUkpoV0po?=
 =?utf-8?B?V3U0K1pjWWIzbERkMmp2Z0dPMExvMUs2aXlhVHRmdkdUSjVnWUxHdVhZc1k3?=
 =?utf-8?B?SFk5bU5vbXdqNnFrSkwxSjM5Z1JYRXhpSittajlxTHhqOWVsN2lTMmFZTmZ3?=
 =?utf-8?B?Ry9FQWl3RXl2YUZrMFRlVkQ5REpMbnlCbWhzejhaZEU5WXB2YW1SZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39759dd2-2158-438a-697f-08df251dc9c2
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:23:18.0160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ekZ5aTzqfqLgZcuUkYDAfq5PuFjAhxYavLYS8YP9BZXaasHBQtA1+alfxM2rwMApNUFaX0K1RN9UIVlbcoTI1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5792
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Oct 2026 09:23:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24437

On 29.09.26 13:53, Jan Kiszka wrote:
> Hi all, CIP kernel WG members and beyond,
> 
> if your are attending OSS Prague: How about having lunch together on
> Thursday (Oct 8, 12:20) and chatting about CIP kernel topics a this chance?
> 

Just a reminder that we are meeting today for lunch.

At the same time a clarification that there won't be an IRC meeting
today. We will be back to regular schedule next week again.

See you,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


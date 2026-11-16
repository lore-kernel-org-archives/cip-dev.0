Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.11])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.895.1794856648805013261
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Nov 2026 11:17:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BjoCidUZ;
 spf=pass (domain: siemens.com, ip: 40.107.130.11, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9BnX3OLVrcM2RCAiKGeg6seEmd5S7r3TNthlpYuKMjx8RlaY6hw96T07oVgfYsbGBSdH8Fs8/3qsVi7RVv5TLU9XFNkxfRWe/cPlLNl+QFi9bNnQT/FO3Zt8CPQ7vsz7L7xCSL+w1uDYmtg9gP4lsaNX2t9t6P39VxSqbHPguiMpHrSpTB9j39AQI6i+CuT6oi6AAq+hTuTvGCCA8GUHjC1+X6Mj9LrXsaTVPq0Ttwk2PDs5arNRGheO25SP3a1kxkHAB38uVy9gznHTzaRwP0ksPLrKEhIlw1xiNYuNS4Mgy7Cxmhy90mp2ru8TsZeg8rPNKqo5z582P3JBO8uxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hX92yDmBbHU3vr4UVQk+TppJTKwruEa2PTQcNa3oNWg=;
 b=i0wWwLQD94/K1jF5ge1nHAezMnjviWmD6f1G9oX+5DuX63yxIQt+PfQj1GQ/uh7axgJKaP4Ur/poQukt2EHV4rgX5fmhDpi3qJZr/k4FNgvGAmT5SJjRNcKQ1QEDeEYRipEvskHQM7EDkzHMbmHLp7i+3ptIOOWCp9fLuApufuCp3WFHadunlG7TI4l4sjSKyKPWPl1AeQ4HZuOzjYP7Szh3Kl27GAC5nZEmwMpgqCFET4xJUQ9hR70UDFOKWy0+9VIIWzDtUkk5ld2It2M+T7ZukoLhoxpvZ5wxRGa5plFImU2n4aC0Fdbx31Ct1AoFZlOhGiybB2D6ciyz4JgdBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hX92yDmBbHU3vr4UVQk+TppJTKwruEa2PTQcNa3oNWg=;
 b=BjoCidUZLOEw4f9CgYVDBiFpVeDSpKtDpKampvm3WKTeTU9pap+WB8+Vl6VpXBzI/p757KombxulrV/TycGWtOyElcnl9+lO/NAHq4bfNblx2tq5XNRPHlR1v/rpnTxRWilzPHkpmoX48grHxLEGKIC1t/e+g2wAe40uudAGWGBKKY4hkhLMPgmi3Ej8+r7BTlS3cyZYFSmh72aCtpzfLUndGzDiqDQlgw2vOqyRwAm/GqxcTKWCcQxJzUFSDOTKte9kUOmAY4IvGAwRpApl4s0sT5/S84dDljoBxQ0sf3ySd+RNjHGwQjchDcu2PiDN/OBnA4+/rMIg7InLuMywJQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AM8PR10MB4116.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1e8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 19:17:25 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Mon, 16 Nov 2026
 19:17:25 +0000
Message-ID: <4b4745fa-2a9e-48ea-996f-fff98ffec832@siemens.com>
Date: Mon, 16 Nov 2026 20:17:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [kernel-cve-report] New CVE entries this week
To: Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
 cip-dev <cip-dev@lists.cip-project.org>, Pavel Machek <pavel@nabladev.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 Ulrich Hecht <uli@fpond.eu>
References: <CAODzB9rb+qvRFhe8UcFY2Pt-j82sqgpS=mfc4NbCrbdwww2Tpw@mail.gmail.com>
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
In-Reply-To: <CAODzB9rb+qvRFhe8UcFY2Pt-j82sqgpS=mfc4NbCrbdwww2Tpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::17) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AM8PR10MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: 72dcf645-6dbd-4bf0-6b0c-08df44163f39
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|22082099003|261009223027099003|55112099003|56012099006|11063799006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: irYwZs7LR2KBsKmPlLZSUEGYmYnnJsREqdEXzud7rJCT0sYoRiMJULVjeH2qz1i5k9wDXe7zRKXCnRoEIMoooDefGRa2bmbkuu5IwFix6PACKGSM+K1BJMvMy6zM3oc4m0AF7tiAyJRgQKsBEQ3flwmU0Uf5Xl0QB4yA3CQEwPYkaZ/DdRkcPVMPa27vjsNs5GoX369y6iSsaG67kZXbCwvpeZTa483zsXrNwPbEUcMpb4TJtwJp/NImFMXlt6B3NKaYpZkrnv/DE8N/Yy8PZlIwNnqTeWGMcwxW/9AmEdI7UFdt5bsJTGeN5oOGBaMqftMBxKpOOQgIsJ6wOFqgFwoS2mnk9OmcXG2QRaOQYMs6MTUsbUfupcUj2wIMTMN/fLlkITQDdzOgXoeTc7BhXbWN3Yt++7zm949/g0eb6MwKjEVQp6Kgvgv+bGACM3Q+0Urj4IiJaZ4FFp1Y0Nn2ykbWtBUFcTVvXxhTN9BuojcKrvOuCNxX2MPns+O942r+0S/wfGaC8S4x6TaUaYlht9I+YxLh38yFe2sZMTby6/AivJt4T5HDJucwts4JJHbmypBTXim3FSKLVlKo01FDD/9Op1V+SMOsiJHN5qjHZpbXfXnSpDB4k9Pwx4HrfwVeG5tcIYaI/1KEqNQZmVhe5tnmYf4z9B9t3XTxskH8rxA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(261009223027099003)(55112099003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzZSU0gwbW5VbTJZSWNUTXlSWThJVHBtMElVNVFVOWlpTTJRTTgxUjMzVFZM?=
 =?utf-8?B?c2tBcXVPZ1kyVTZWazE3bFJybU8wN3lTekcvcnFIUDdrTk9WVkF4dVliUEIr?=
 =?utf-8?B?YjJpcFE3RExOd1ZwdmVwV1M5dGJzKzNCeUFka0wzQlk1K296RVlZQzBZWVZZ?=
 =?utf-8?B?YllSd3A3NmxPSGtXeCs4R2t0Z29mR0FnMTJ0Z1dxb0VCM1g3dE1EYzNaVzlE?=
 =?utf-8?B?L2tuSkVjM3Vqa2pGeDQvcWRpU3BVa2NyM1RCQlRSRlVlY2k3eXR1akRBSGRn?=
 =?utf-8?B?TlFDTk9scWxEeUtGRlBya0FXc1plbFkzcFI2b1BqQm1WTFVxVWN4NitxZGxp?=
 =?utf-8?B?bDVYNmh6ODNTTnM5aENackt3SUp4TFRUQUNGNEpyNy8xWU1wN1NIS1J4ZFQ4?=
 =?utf-8?B?cnVQTGxWaStabkIyTHltSVdXQXZBSXNkaWF2QmllZkFQWnlDZGJ5UmlzLzRP?=
 =?utf-8?B?QnNoLzJJcEJXMHkzT2N3OThVMnpLUUYrWlhTU0RLQUxRRTNuZUZLSUluaVBk?=
 =?utf-8?B?OTlLdjJTMGVBUU9Gak9rdW92YU4wZFBVMmFpUGd0K293dDlkQTB2RVV0NWZk?=
 =?utf-8?B?WXZyZ0JiQjloTHhETjU2UGRxWUdJMzNUK1RUeTJmQzA4NlFvTjFWRzJoVDlv?=
 =?utf-8?B?WG5vbWVEMmpPYWE0QnNKc2dUMFJhbUZMTnlNbDIzNXFNNERBeXB6Z3RUNk85?=
 =?utf-8?B?dmw0WUppZW1zUHRPNE1Kc3p1ekt1T1dIMnVGMnozSFduZXNHUDRUWWtnZWJG?=
 =?utf-8?B?V1VEWExLblBPTkNxbzgzR25lMmV2NFkxWWZxUEdDTlMrMjhkbDBWeHhJa29z?=
 =?utf-8?B?WklTS29CWEJzViswc29vak1XU1RKeVBZeC9ORnowSDJ0NmZ6UjFVMWtHQUtt?=
 =?utf-8?B?TXRnck1oOTBEWGVZZStnMmsrK0s3c1BlUzQ4QjRtSndLR2tRUlFjRVNjK1RP?=
 =?utf-8?B?d1FPUkZPeXB6Q3JZS1JpVzh0Q0w1Uk9sUEdBVTNPQkRzRUI4ZCtkSHQzeDh2?=
 =?utf-8?B?L21MSHlORitiMzBYN1Y2Rm1rc3Q3a3dma0JXSlpzeEp6a3lubnNmQnRZdTdB?=
 =?utf-8?B?enY1ZERKWVRVYnREOVdIbjVaSmN3Nkdnc255OERnODZLY2plSVlWelhXTFg4?=
 =?utf-8?B?TGVDS1ZNSEU3MlpoMWVwNkpQeTV1TDZhTjBwRkpFU2sxUjZnSEhWbmVPRmo1?=
 =?utf-8?B?bWxUdTBBSkE5KzdXL1JZZ1hFTnFBcGZDTUZ4cWZ1TlVOSVhvZGt4SzNPcUFN?=
 =?utf-8?B?OERtRXVhK0RVbGo1eTRreGV4L0srSlN4VHFRUXRuMGNsWmcvOXQwZHRHZytV?=
 =?utf-8?B?RHVPVlpFMllnd0hIcW13SVVrZDVVN2ZmN0xCQVcyRDJBeUpuTEdHMmswZ2ZP?=
 =?utf-8?B?RkxiOTI2ZG9TVEpTa2VSNFIwR1gyT2pRZEdwaDk3N00vQXA4eTdpdHdJRXgr?=
 =?utf-8?B?OE93WTJ1K3k3Vko0cGk1OEZVcWdJMzJwNDIxbU54RnFob2t4cXhDeFZYVkdW?=
 =?utf-8?B?cG12UHZOZFYwajNkeGk3aW1ZR2cyM283ZGNmR29OTUZORUQ1b3B2OEpaV0o1?=
 =?utf-8?B?d1B4ZTZlcjUyUGdhb0hqL3NsK3VqUzhBeTlaN2VEc1lzU0tkbTZTY2pLWHQz?=
 =?utf-8?B?K093Wk4rSHN6MkRCcDZ6ZnZVWmFaY0FUdXJZMEEzakcxcTFObUl5SjRRUm1O?=
 =?utf-8?B?cDlOMHNxd3liVVRDV29SOU8zQzAzUlFsTWdseGpxc05qZCs3TnNicE1oSFNS?=
 =?utf-8?B?VTNQMXJieWpTalRsYTJDM1IyTEdzbUFEZWNDbUlyUUJoM2VoWXhNNlMrMmRY?=
 =?utf-8?B?L2hwTXROOXE2MGFCeUEvTHlsd08zMFlsSVBUZCt0Vno5SksyT3pJRXN6c2FM?=
 =?utf-8?B?WnZsdkp3VXcvVzNzMG9GWjhSQWFWeFcvYWtFRWoyclp4dGFYNWtGelQ4TytV?=
 =?utf-8?B?SFVDRmZLZ0V4Z1gwcitsUXJuQkl2aHJhS2J3eFNBQjRwVmRHbVNheFZTY0Yy?=
 =?utf-8?B?T1duc3hjYVZrRUdCbGRuNlM2RnBCQVFpakkyZUw1d2ZrOG9EZG9IZ3pZandH?=
 =?utf-8?B?RGUrQUUwZk8zbkh1TStVNVdCU2NsUWJQdTlSR1JZVHlHalZZcWEzdEFKRVgr?=
 =?utf-8?B?dnZoblVKaTRHOXpjWUdMMU5rUWlaM1dDWjlWd3dKNWo0SGNiQWtVWGc0YSt5?=
 =?utf-8?B?NTFncHRkMlBJakxMN3RQak81cFNDcU41NGxaR1NsMDZyMkQ3aDNoN1dTRnlH?=
 =?utf-8?B?U2EwRWZSUWExREppdjM4aXR1RjBTNVpIaWFFWDBtczNKYUlOU3UrN2F3Q205?=
 =?utf-8?B?TEx4WFlkcXQvaWQrNkd3NjhCNVFpREt2UXVFZDV6aHhSZTRhNEVZZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72dcf645-6dbd-4bf0-6b0c-08df44163f39
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 19:17:25.1775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxbZPGbUSh1za+HtKbwWr8J7KGgBEQj/P9YA5cIcBDw3JUcCOCuG0EvhVrogdtACLC9Z7JKG2HVdwAkHS8UjfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 16 Nov 2026 19:17:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24809

On 12.11.26 00:56, Masami Ichikawa wrote:
> Hi!
> 
> It's this week's CVE report.
> 
> This week reported 21 new CVEs and 50 updated CVEs.
> 
> * New CVEs

[...]

> CVE-2026-99288: inet: reject unhashed sockets during established lookups
> 
> Announce: https://www.cve.org/CVERecord?id=CVE-2026-99288
> 
> Introduced commit is not determined.
> Introduced by 079096f ("tcp/dccp: install syn_recv requests into ehash
> table") in v4.4-rc1.
> 
> Fixed status
> mainline: [4e2b3ef19e0e04adca38442f07dd6bc93c712bf1]
> stable/6.12: [d69100340b4cae08d40f898f1b601032403f6be6]
> stable/6.18: [8e5172cbd227fae32f3313cba1f3e1b9edb5c4fd]
> stable/7.3: [eb8a2d156f2c1d862fffdfd1b3432bfbcd939879]
> 

This one is gaining attention now ("NoisyTCP") because it allows remote
DoS in default configurations. Score: 7.5. Are handling this
specifically already?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

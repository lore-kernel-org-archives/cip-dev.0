Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2698CCFA13
	for <webhook@archiver.kernel.org>; Thu, 30 Apr 2026 08:47:38 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15819.1777538855003152661
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Apr 2026 01:47:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=PYIoBw02;
 spf=pass (domain: siemens.com, ip: 40.107.130.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahyNcyeQAsJgGn+Tm5EJ87XAYXMw8WHO3s20nbTufLSvWYSQltluqZUg3Fy+Y1bWFHV07kfQ41VWPvbwN6NXUjW9Fc56PYkubrPjzlQyKpwsHPGUqGALC3YuG3GD0DEMBkXSQ/Tt3IUWb89XSATTX/fTqkvIKKg6l3No6A6KJdhFXrgZlCY+Z4Nn9v7qId8qsfLbTurPT1/CIfqXwD7AULD11aAz43d/QfjDxBpP4W7tfIiHNJBOFYicTeLJ1fUEPwACrMNIuOTrCu9rKMuj/jbyhQExjem9vc9S84dOHurOFj0VC+eL8RwwkL8/gtJ78gIcKNTi9KEduLFLlBYlcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVFOmiFwXF89WfS1dC43Zc8yXp3F/pUAM5EUrUFezfw=;
 b=m0GfOgb9lIenmeqnxlhMMe6ayJOSoI5DrOf4Mysvm9UW0L6y2rKLjLEKP/w4b9zCskrDXZQWO5cnesa4mmO1dqkkcSbf7aV88Z8o6qAhpn0sLcKNCJDbBXLqlFAsu5ycMj0OnbmCeAaQs2lTbhFLucaG5N7tfSo8r/5MEjXcXiSVxgndyBVjdA8gMFYUqwhNrETY5TSusqqy5otkkASXs9VK4xqBCaeVXq6lUbvV46TczhdsJsEREV6tjs9lQYP4QQnWQg5w5iTbpeDosNAUq7BuFHderbE/wJWuvHDzbZbQolnqRz2UlZCnXNk8U2l35Yc6s11O8yG/t1O9dU3wYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVFOmiFwXF89WfS1dC43Zc8yXp3F/pUAM5EUrUFezfw=;
 b=PYIoBw023rG1UdFt3TDn8m7dzZDtaZfwHlXjGkeDv2gEK0cPpi0NCEvzIzPKdvVT1u6ryjd0sLJ+YLFcBDuS+mAYfTsUkaaqY+YSlfDT9YP1UE+8hkikQVG+8XWZItO4w+GXxPVHXjC8gIwmerA1w+IWgxaUGuZ3WNhwlLWWqlmEVOsrysDclEvyaIA40BQFwx36o/THMeA6OvusUX3HXAWvyDOSmdYG0BaLN4tczlYQq0htHlF6sIUkbdlvv+6B+h2G/+9j7NkpQKqpGNEG0TSMdLMnO9mTXh5CXTqu94yzHN7JMnYpiFOfgrW1MQw7WrVV2SFTEkGmuoqmGWDlwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7744.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:491::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 08:47:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 08:47:26 +0000
Message-ID: <2baf5fad-2784-444a-8413-e2b6156e2ab2@siemens.com>
Date: Thu, 30 Apr 2026 10:47:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: "Copy fail" -- Fun CVE -- CVE-2026-31431, likely should do
 out-of-schedule releases
To: Pavel Machek <pavel@nabladev.com>
Cc: masami.ichikawa@miraclelinux.com, cip-dev <cip-dev@lists.cip-project.org>
References: <CAODzB9pBqBOhOpu=H4RyON1VaLGJSP4jsFrLmGVdACU73DXyxw@mail.gmail.com>
 <18AB121F2F67B74D.2435051@lists.cip-project.org>
 <afMOaPbHBf806Ypb@duo.ucw.cz>
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
In-Reply-To: <afMOaPbHBf806Ypb@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e3875c-1db8-41a8-fde2-08dea6951a90
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	8cWbF8O5D8soejtc/OMJa0vZxT5CcDE/zy4DXKc0c1Y+LAdmRhDci0fSbMhAYXb2CJvbBOk4BiKHHTAqZUl7B2R5v8Pt29J7M+mcdR6OefD0Y+uQp7N68aaj4914EmaaD3zHAJjM0a3w1oZBVzKsyI3RGzGKDavbI0rZpjqIDlUHkN6C/cllaV/+Hq8KyJ+y7Cgy8hiNMIERuQjorEE96ZkHnI7RChep8+8C8gI632JC7So1DtDoUcAPRJUiuKc7VeZ10A78cs87Wi61PqbVb3yiI3fLfpbiojcxSHbvWpXmfELJsyQCLWeBgfEHC1D/hJziDPiK9gZz9w7SKH1yZ1WQQe82k6nddtPHNCQQl1dVw7Db50QqZ1V+U64oZaVDyXTjso9M7aq7bYH+rbXaxGDe7HB2QEQMKPj9pNDc5kIsDHReFffHW2GMdDcpSCxVrNEEu3MvmqZCA8+HIlMmQPAh5O5in1UQaPQnWcxYvYWggOMT/TNj4Asc1T7jSow6SVXkgC6G6Q0jEEFK6LQdxIF6OG3B0nGKNzbTO16ojSSb3igKR4SFOQwn6tKchrCxqgefWIwfyAIBm+so45CbS1ceGx1u7GJTSO6gXLbTlQaDVx7oqq8HEDWgReuiXjjJbivj0GNk0b42Uwals93iySCJP+CtQ2Co/im8D+EZA54C8MJ88yqfhh4IiXVUX/l6
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Yk1UWDdzeHRHQWc0c28vMzZCZ2NGZlh6aEFENlV5NGpaM21pcE5ndE9lSFVR?=
 =?utf-8?B?dUtiV0drM1MwYlZtcGEzYnhHTHFJQ1N2RjhEdjU1QVBqOFc1dyttNjNFY1Rx?=
 =?utf-8?B?NTdUVythZlduNmpZZk4xYXdkU3J0UFRBM1huaU5idUE2dVdhWjJrTzhTSkg1?=
 =?utf-8?B?eTJ0dkZqNGxHNm5DOERjeW93cUlUbXpPODZYRnRWMVI4L1ZzQ2xmK2lmT3hn?=
 =?utf-8?B?UVc3Q1NEaENQM3pwbXJRUy9JY2lrYXJ1N3NzZ3NOU0UzUzVtMkMzWE1Vd1BK?=
 =?utf-8?B?UHI2ZlVxb1dyemFKL3c3eXRUYnFqdnAwNGttUm94alByQnJjQlRUT3pCUDZk?=
 =?utf-8?B?SWpjcTN6K25KV0dyUFFnMjl4VTY5aUNZZzF1QTFzMTJDYjdFLzF0QlE0SU1y?=
 =?utf-8?B?d2E4c2M2UDJsZzhXQkR0QkhRL0Vrd21zNDFBU1IyKzhCRytCa3JyV2RyUElh?=
 =?utf-8?B?WHdDVHczcXhjMmpDMkZyd0xzSHNYejU5aWdIczZoRi9LL3pnMUtYQTBpRDMw?=
 =?utf-8?B?ZGF6MGRyY1ZvNXVtTTZoVmZ5bFVaV0lPTU9KSmIzQ1JtaEMzb3FPWDhnRGNq?=
 =?utf-8?B?SUlwZVFGUjdYckF3Y3NZN2IrNzYyUkhpTElnYjRTUFNEQzRKOHU0QllLQksv?=
 =?utf-8?B?ZEhRVEJHbk9NOENmU1RwbUFtc0RNR3NWcGFCS2JJYytnOHdPcU9QcnhkcktG?=
 =?utf-8?B?NUhZR25jTDg3WVR5ZDMvRTJ6aTFoQWpjN2V3ZEZ2UDJyVWtwSVNjSDJQd1Qx?=
 =?utf-8?B?SFJqNEdBTXFsc212OWZ0d1kwVUhRYlVUUStYTjI1WE9wQjhlR200cWNVS2Zv?=
 =?utf-8?B?NlVnTm4rOFR1UmVlZFNwWEJMQnM4UWZ4NnFOTjlLN2t2UTdBYXlaM3dVd3VQ?=
 =?utf-8?B?WCt4NG9NaG16c2cyV1JSaGt3c0E5QnpabWJmVmZ6cXIxamlFeEg0bmNqQ0xw?=
 =?utf-8?B?UlYvL0hZTFZNV1kxWHlVNUt2dEtnL2FOaEVSWlQwRkt2K1dLVG5hOXVtdWYv?=
 =?utf-8?B?YWhPb0pRUCtkSXlLOEs1OC95TE5meWNpc0FNallGb0dYUXl1RTRWc3lEMW04?=
 =?utf-8?B?eGtoMEtZKyswNnZVYzNtdEJhcGQrKzlJYkZ6RU9TM09KUnRwZmtDRk9xWnB0?=
 =?utf-8?B?WTRPdW9zR1BpVDYzT1A4Q3ZjRDV4eDc3eGNCbVdKcHFPY2srb3BJZmhTcUtt?=
 =?utf-8?B?Z3lseXJqQjdEckx5QlBoV1hsUk9pQURLcDgvZEl6ek55R3ZkYmdQbmdMU29J?=
 =?utf-8?B?dUVDNkxsbFhuYmxpYjh0eE9hR2xOSG5vaDN3U3VQZTg0OWlhVFVRTzQ0cC84?=
 =?utf-8?B?Zk5majlKQWw3aE1aNW5zUGlIWk9SRHpkYnZsbDFSNXc5RVFaWVJWU2tjNjky?=
 =?utf-8?B?OXVsMHcrY0lJbllNUTJNOU5HdmdjQVpFOXRrRUFocFN4OW1OMjlRbHNVU2sx?=
 =?utf-8?B?d2loL0xrempEMm1HeS9rKzhuakcyVnpKZU9lUGtHOStYcTlGdjV2cTJLN2FV?=
 =?utf-8?B?QUxPSUlic3k0c1psMjV4WVVPY0o3L2habWlsNUk1VS8yTFNsRmdJUlVzUTg4?=
 =?utf-8?B?WXR5aC85eHdnUis1Z0x3dExRei9IK0ViUGFTajVrUnJqOWtWMDZ0S2wyTVhE?=
 =?utf-8?B?ZGd3d0FrSEN2SEU0U25qRlR0NlVIR1h0elhZTnFDZnVXcTRnVnc3VkFRRTNj?=
 =?utf-8?B?WUN0RGFiZDY2R3VEMGJ0OFduN05sVmtsWjBtSGl0YVVOOUxPbzBkUGo4WGR5?=
 =?utf-8?B?eWNYSzN2cjFVTlJSUzhlNzhlTEQ3U2VCd1RrNit5TXYvZktMOVVzK2ZZYVNo?=
 =?utf-8?B?OGlkdGhVM3hJWURxbE1WUjRkT3huSmg5STdxWGErZzF2cGdaWW4yeExUVDdU?=
 =?utf-8?B?ZkxPc3VLSTFzKzBKcHZUbWxZSkV5UGZEVkZOc3I0bk5vUVBYMkJFeWh3czJm?=
 =?utf-8?B?cTZYYUN6S1lvN2J0K0JHOUEyczNuNXdKSm4rOVQrWGUvaC8vUDdZbUVxMGwr?=
 =?utf-8?B?ZkxGZDFHU05oVXppV1IwU0IxamdTWnpHb1dJMUFJNWZvZUROMzVEanBobzYw?=
 =?utf-8?B?dUpoYngwMmRzdnRSK1pqTzdlcWFrcnZ4Nyt5SWt0dFM2dXlZdjBCZW0rMVda?=
 =?utf-8?B?QWo4bkd1UVVteWtjU0J0TTZVTW4wZnVnSU5rU0xxUCtobzFzcEs4eFhuNEpD?=
 =?utf-8?B?d0I5OW5iMWRqdWpWTUp6WTNxWG1SQ2VBM1FBY3NIeDhWOHRnTUZ5N056VEZU?=
 =?utf-8?B?SS9uSjJlandzVXphRDJ0TklzcnJzRWFLRUFvbDV4SmZoc3BwZCtrRktJaTB6?=
 =?utf-8?B?L0hTYUN4Mis3c08xRGdpSUZZayt6M1pXamMwczJpdXRYbDlpNmFQUlY0b2pv?=
 =?utf-8?Q?+HScOPbgkKTydoFY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e3875c-1db8-41a8-fde2-08dea6951a90
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 08:47:26.2416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WIEumulJYYUlJt/RekElDlsTmdA53WQZd+fTNhcK7mloqgywSiF/VYLVcOzUWbp36ki5f1xyzcO5Q9j/V06eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Apr 2026 08:47:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22828

On 30.04.26 10:10, Pavel Machek wrote:
> Hi!
> 
>> Apparently there's new CVE with a name, and when a CVE has a name,
>> that's not good news.
>>
>> https://nvd.nist.gov/vuln/detail/CVE-2026-31431
>> https://xint.io/blog/copy-fail-linux-distributions
> 
> I assume it is real.
> 
> 72548b093ee3 -- place where this was introduced
> 
> a664bf3d603d -- is the fix
> 
> This is another remainder that running untrusted code on your machine
> is a bad idea.
> 
> 6.12.84-rc1 -- has a bug
> 6.1.170-rc1 -- has a bug
> 5.10.254-rc1 -- has a bug
> 4.19.325 -- has a bug
> 4.4.302 -- likely too old to be affected

Yes, the referenced commit that introduced it came in via v4.14.

> 
> Fix does not look too bad, and I believe this is significant enough to
> warrant out-of-schedule releases with a664bf3d603d included.

Let us discuss later today if we need to act quicker on this one or keep
the planned update pace (at least I have no opinion yet).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


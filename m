Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77168CD98F2
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 11:56:30 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.0])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40649.1781870181675260526
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Jun 2026 04:56:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YYMdIoLy;
 spf=pass (domain: siemens.com, ip: 52.101.70.0, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvn1BriBl478nnqSMTSEGeucWyB5fAA4RcKHtNdbihTZofcIWQK4orZums21DGt9d9ZWO/nXbVN5r8GVsiyLzYHrzIdOnaXbRlbNiQHRuqfIIGos09HteNCiVJ8gKTBJqNPg/zDTyeoOXLoMDZpiwU3LRy331lyXbW3d7TAPWOvQ2heOFY4zCL43Dk/0b0yPx+OP+XvTJfXoXHirkbtLewudf+oU7sApo5hds7SAs/cwcG7tAj/IZndkUssadUvXMMxZz2OuaT+lNbw1WccHLn36gLE4K86yHC6KEBa7xVEIn1BKwVWbEMBR+NoVl8FF7A9O+gjtWGzY+E8vtL8Uig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pw/hVSO7GubyK/8Y1I/sQw2XeZcHmMYWaHzUy4q/f1Q=;
 b=fWb8Br6+IdOL1tVL4LAPoTPFn9O9SllkNjN+a8c2is2m+GvRQcyxeSMAbN7n8baNVK2likb5mD4Gl0On5xGgYRaAYh8flawdvmmHf8CRIziac9RZUGEw7PYSjxWx0tUGLcmXSQuzrOXKfsn9YzB9aqowM8QD3d0gXh9Y0TCZ8lP3OxGQtFMfSICHNFflqb+QlZQupjwbx/S+9qhI7D81JzlDrayYvEu+JTNbrlUJ633x5MTieliwPC6VViYDyCm9L0hKOqdjWCQS8eRDFLBlIdGSmw3elwmm5W553el8kDEvGnR5qUFJnoXu5yDxbJu6U4FU0GyqfGID1O+agSvSng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pw/hVSO7GubyK/8Y1I/sQw2XeZcHmMYWaHzUy4q/f1Q=;
 b=YYMdIoLygFEpQ+0sN52DNgk/6VNeRvdLWEMzjAgvPGnUOEmqE/XVaI/Mn7188fZh6dTKl8nqawCC1VvWvv7SgD8V/joizCSbzdckjzitSbh/JMYgC7Diyas9V7oZovTthHbVRZg+3Lp83Zaw+y0lB2BSXbFNxsQeUmLdrSabxChiTAg+8sdNdvxHCyVadT08nqnYD7/mISvNWiRx+DHXln3v/O2tDp5MjmPAbI0mTekhq9O1NHK+clM4uIMlPNv6lTzJMkis+8o6m4fhpdkAPKHFS76haklbXENuRFsg/bB0llOgh7nvcz7nQBpVtsw9NK2AiatRsa0Sn58jvGHznA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5376.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:27b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 11:56:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 11:56:16 +0000
Message-ID: <c113bc29-5c1f-48af-b781-2909438bd84d@siemens.com>
Date: Fri, 19 Jun 2026 13:56:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] switch user in swupdate suricatta daemon
To: "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Storm, Christian (FT RPD CED)" <christian.storm@siemens.com>,
 "Kowalsky, Clara (FT RPD CED OES-DE)" <clara.kowalsky@siemens.com>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <dc698ef3e64c793fdf42c79d41cf5e8b215ddd91.camel@siemens.com>
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
In-Reply-To: <dc698ef3e64c793fdf42c79d41cf5e8b215ddd91.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5376:EE_
X-MS-Office365-Filtering-Correlation-Id: d310710d-3d74-4d3b-c0b5-08decdf9c493
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|11063799006|56012099006|6133799003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	2082umBdaFJ98vPbFK8eXhOUaCV3GGqviLZI9mqLcnf6Pbbhu96S+QrKklXxvB82xv8ZjOhwkeJ00DUlqn2vhDHQE0Lddml/rp9k2kz7mPCjn9ZAwyuEt6DFH5HKp2laA0WNa8+5RCyZ3cjsKPbZ6qr3dZy62HYEgfZ3R4icdCPxhnQkxgd2FDZbbtPMzwwW3ewxovhY08mSEq6NUnXAjeflBEeNlAk+W6J4gr572sq93PCIcLc28rkXORKrSCqBdd5MTVAzChW4KBHtJczy+iVEuJ2662cKRcZModaBkkw/Hzdwcj4SDx1LgoTrlj/9KVRn4cIeeeQiZExlk5zAvoTw9gC9YhmiNi+RgbG3wlSwfHE7F+LFMwm2dxJvCX0hR69pJ5OLK72UuAAtv+HphPuFl7CflSMahgOLTsO9CPF+8SznHvPeLSbmDRyWo9c4H/ro/cK+xU3oN6FroxKiVEhVAZTtPczndMQHmP0M9bQoXJTNnr4XzvLSwEv0IIVsXTob6dHm+iygPcGp1oy+0S1zNflzmx359a46OXrzzp2VuoI3c8u5Debt7ESEUh+YiiMkJxBnLbTMvoEmMfsSXVb196jSNd8tMIxFUlSyxMX5y8rD94Dbuzew4GIBiHtD
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NndDbjMyM0xUTXd6MDBuMGM3MFVRdk5sWis4ZFFSbW5BdzNhRXRsNTdON1ZT?=
 =?utf-8?B?RlZjREFkYzJ6NEFOZlE2Um5zcFFTOHJUMVFFdEZhRXVGSk4yOEJhaXQ1bnox?=
 =?utf-8?B?bXlBSFdndjVpWmhzQ0JsbURKQVE1V0l4NmlQR29yQ0Q0SVlpY0owVFgrVzVF?=
 =?utf-8?B?MHRjbTRkQzVPKzk2cG5HS25LZjExN1dqL3lkNVNyRGlqbGxSdFptcTFPZ3VL?=
 =?utf-8?B?a1FZazRjWDdZc1J4TTZualNwZzhobVdXc2duMktJS0RlT0NzUFBCdGlnazBa?=
 =?utf-8?B?VER6d0xDRzJISmlvZjdxMlB0WDVIR0s0UVdsSXVBSHZYeWJRQ3JWNFlwaGho?=
 =?utf-8?B?M09lNFZpR1Q2SXJhVE9lNDlPbkt5eGRISEFDSVIyQmdNNER1eUZyMDVrUU10?=
 =?utf-8?B?ZGxaVjdNWkJiUzVhRENWSXh6NzlNUjUyWjBVQ3I1NGdXOVpDWkJqeU9vS3hG?=
 =?utf-8?B?UjBNQzhUQW9KeS9IWTV4MzVWWUplbjRTZU1IY2VOUFkxQ2luR2tva1p1b0tF?=
 =?utf-8?B?VUs2dUw1OWg1Nm5Gek9JREZ5VEZWVkhoeTZKQ1VOV093WlFvRm9rakJWcjVk?=
 =?utf-8?B?RWtRQ09OTGtpdVZ0SmpSQ0tVRU5LSWdna2NRUWNhcW9kL1NxWStLRzRCY0I0?=
 =?utf-8?B?cGNUcUJxdXdpSXZyblZYYVZLeTQrMjZHQ09RWDVpWWtXS0srNmVBU2ZtOXp6?=
 =?utf-8?B?aHBXa0JJOSt3a2dGV1B0YkxZNmFKSDNybFAvL2EwcHpYM0U1aE5jR2FmL2pM?=
 =?utf-8?B?OGxjYzFpSWFVUHRrNVNUcFNxcUQ2cm9SWUVwSmdJY1pCVzMrVnMxNy9GSmw3?=
 =?utf-8?B?bnVzYjJGSnhDNnVnTFJRRlVQWDY3ek1DK3o0OFRHc1d1bTdkMVU5RnBqNGxY?=
 =?utf-8?B?YkhYMkUva0cyTW9qOXFGRzErRUZMbk94akVxcUJWVEtmeE1LZjB0WW1LaGQz?=
 =?utf-8?B?VzRMOVdXaXFweGtUSlFBbFJxUy9VUTJ4SkYyN3dqRnR1VStjb1hqK1hwTThP?=
 =?utf-8?B?S0ZHL0FoQk5UdHlNQ0M3c2VhMC9JTW9vSlF5OVYwZjBkRDN2UjlWVFdQZkNi?=
 =?utf-8?B?VlIrWWhWREI1ellEVnczNjRUcjJkZHBoQnkwV2xYYnc2bXVqdkVudGRlN1I2?=
 =?utf-8?B?ZENxWHJtZ3RZVmd0ZXB2c1BRdlJTTU1GWWZHaXd3aVFmTmhFeVBKK3M0S3RV?=
 =?utf-8?B?cnpjTGdOWXhpblIwR1pTQzlGWi9JejJWdUZvL293TzREMHNnbW5Ec3lLek9K?=
 =?utf-8?B?blAyMU54Z3ZTWkJrR2tyZ0tndTQ2b09LZUFkeFpkd1VTY0NIMjFnR2x6eE5Y?=
 =?utf-8?B?bks4VWZGNEhkRU1KNVNpM0xHVzM3UnZiakZqTG1rcDY1Z1hjQ1Y3VU95NGc4?=
 =?utf-8?B?dG5jNTNvY1RsVnU0NnJ2NjVxSUlhUFRQeXVSamN2N2VZdkI5QTdmNUJQNS83?=
 =?utf-8?B?TUpmcGxYazhKMkRPeGVBbWNQdUNqeFpxMGlTRXhyV1o0ZE9FeTFhR3hrKzF3?=
 =?utf-8?B?WXczZk1jTXQwbmVWTE4xRXlON0t3U3p1Q3NVWFFCWGF6U3EveXcyVmNGdG1S?=
 =?utf-8?B?Q3cwVzdPMEZTdGFQWjNURXdMNG1Db1BMMWNHaG9IWXlxOEdVZnh3ZDNFWnZ2?=
 =?utf-8?B?WEJ1QWtCK0pqK2daT3hCb3pLemZYZ3JtR05tMnoxdFhYUkNkQkFJd0c5SE16?=
 =?utf-8?B?VENocnBnUVNqa3l6MExGYnRYbXJ3MHJzRXRpdE5uS1U3b3N6S3lrZXZ6OG53?=
 =?utf-8?B?RmVlNjYvdm1POGNYZG1mRG1ITG1PVGtLR2JLQTk1ZW55SW8rVmNHNTRibUNW?=
 =?utf-8?B?V25HTTNsQ3ZESlJ3SXRqN0sxVGRocTlJZlhxUXhjZ01zZzhYMHg2U1gvU3lK?=
 =?utf-8?B?cEhpMkxzZGpqMUk0TnNkK1AyZUhXRGVHSmZ5aklteWNKcVJwYkVZcVdLTkRs?=
 =?utf-8?B?TWFPSm1RZ0U3ZVlXVmZiYklRVmtOc0p6QzNUcDZqL0c5ZVFiUzE2QU5GdUsv?=
 =?utf-8?B?OFU5TzlpZ2N6TXhVTWo4dE5xekxZT0xCRDdNV0Q5RG00eGwzL0VXVFgyRnJ0?=
 =?utf-8?B?OHJoK2J5SUdkMS93VmJ4bVNzMFUwRmluNmcxcWxOU1oyQlp5SUJHb2lPZUc1?=
 =?utf-8?B?UUhReldaajcyZ3J0MXR3aW95ZjkzNjVJbmVWMUtRUE9JODI3R3JWZ2tzS0cr?=
 =?utf-8?B?VVdkVVlWVXoxMFJUcG90ZHA1VXJ3NG0vR1BuaWt1RkM3Mno0dEtDVWxYWTZZ?=
 =?utf-8?B?ZHlKYnlaUG1uWUk5ZnRPQitWVk9xTlNlMHZ0b21rMGpVQXFFdVVlQ3FPeVpO?=
 =?utf-8?B?eTRIZS90Y1JSemt2U2dDVXQvM0RnTVBYL0pvMGpaQ3QrcHlHQWhkZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d310710d-3d74-4d3b-c0b5-08decdf9c493
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 11:56:16.2987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QmiOh3u6fewWm81GaDYjvGzZvEl4ngjg7bhX8udpT2o3Vu54z6VnYA1Q2HlBGlld+8nYzUdGQZcZgVWbkpjXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5376
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jun 2026 11:56:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23233

On 19.06.26 13:38, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
> Dear cip-users,
> 
> as part of efforts to provide a hardened base image, I noticed that the
> swupdate suricatta module is running as root. Hence, communication with
> external parties (like the artifact download) and storing of the .swu
> file are performed as root as well. This significantly increases the
> attack surface, and makes us vulnerable to path traversal bugs, like
> fixed in [1].
> 
> swupdate already supports to switch the user of the suricatta dameon,
> however this must be done via the single global config file (there are
> no CLI options):
> 
> 
> suricatta :
> {
>     userid = 65534;   /* "nobody"   */
>     groupid = <??>;    /* "swupdate" */
> };
> 
> While this works, it is tricky to impossible to integrate in CIP, as we
> have to know the gid of the swupdate group upfront - which we neither
> know for existing deployments, nor do we set it in new ones. If the
> group is created by systemd at service invocation time, we have no
> chance to know it at all.
> 
> We could use a generator to create a derived config file that is passed
> to swupdate, but even that would not help in the systemd-creates-group
> case.

Referencing only by ID seems like an SWUpdate upstream limitation worth
resolving there.

But we could also fill that ID during postinst, enforcing group creation
at that point.

> 
> How are others doing this? Do I miss something here? If not, I'm
> planning to send a patch to swupdate to allow passing the ids either
> via CLI (where we can use $(id -g swupdate) during invocation), or add
> an option to to allow setting the user / group by name.
> 
> [1] https://groups.google.com/g/swupdate/c/nMEBRKjsoVE/m/Nem4oYYfBwAJ
> 
> Best regards,
> Felix Moessbauer
> 

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


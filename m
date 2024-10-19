Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D14D3E1BD
	for <webhook@archiver.kernel.org>; Sat, 19 Oct 2024 07:44:51 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.83])
 by mx.groups.io with SMTP id smtpd.web10.2391.1729323881418973260
 for <cip-dev@lists.cip-project.org>;
 Sat, 19 Oct 2024 00:44:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TsXSZUfc;
 spf=pass (domain: siemens.com, ip: 40.107.241.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJTg45NZ+eth8HfqVPIo1msQoGHK95hz//RZUE1gSPnJ25gKpAGWB8X964ISr/rH4K5hbiAuovh4t/r/qKMHkIEgdcKkvAClH295OfEy425WUD3IEM/tX9ODUwg0ybYiALh1jtJkpHy1xSQ02iE8hvZvTgDFy0ts2kmNHJcHnc/RWy3vAXi6URg+S2TuVJLSp4PURaUZ5P/5nYXJN1NPOjJVCwytwJh45TIr837T78rTkb9l476Od2EV+uglIJQMGHbLUTcA7Y8AOw8VhBb69v4b1bje2QBdPR4SKUXFH6zJ+SWpdQxqMJ7js40c1GlQ9RVtgU0Bab6D9moq/G3P5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NL8ec2oCdtFolAEfMjwHqqu6bUL3jhHC7PZZ4rnLJuc=;
 b=iKJxmFUCD3hJ4dwQ8VIUpmMFrg0wgRVTBFy4+Z6KEdSuIuJeTxPjlfNQDGYqNV9TP9vZnsv2IGx6kCtaPrmPjE0HXf5rO2pE3uq5Ug75+vZC82QRp9vcowM+aOv9YXy++yqVACUO7xB5M1FFxzkMP7yTZfJZpB9lwz5RSBQsulf3U6alzQfvf3wXgm3V3NSaMYrwz40N7QA4aERkqrZxHHAY+u4N74Ym+VJHIuV6JUz/033YxIg+tubiMklojpxEy/KwU61H+sM1zoJAy3jhFuY4aWk+JlVO9+5nTyWhOj2TUa2+yNampWCkn4u+MiM8vZz/flgodaspURUfWh+c+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NL8ec2oCdtFolAEfMjwHqqu6bUL3jhHC7PZZ4rnLJuc=;
 b=TsXSZUfcQTeckrz918ZfII2RP9ZaiW7MJCOAFA/3qUdRygYctvdvNtktI3rCp5QtN7IkADJOe0aX5NjWddutXCNGrSQfhgKfoYTX1CGrsBP75e55S4U3bACJVt04gykKXvjKEfcpPrUnVS+cLY/GpU7AWuU0bLpuKlvHoNY2oQxxia8JefdNp51gihOOOCbY/3gHhCDTFwlTTwtoEsPx+qgZSTj+MCEpTn6JKWrgMCOYs0esjFjJYAJ3OntMrueHYzXvz7mMRBufj+3qK6h1BkT2ZNSy5uvvcalPb0IFod8zVwxFlJnBz508Uo5XD4wUC6OAo8QL892K5cYBXClhOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8327.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.13; Sat, 19 Oct
 2024 07:44:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.011; Sat, 19 Oct 2024
 07:44:35 +0000
Message-ID: <88ea7ac6-a855-4b2e-92ae-0698a91928d1@siemens.com>
Date: Sat, 19 Oct 2024 09:44:34 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 cip-dev <cip-dev@lists.cip-project.org>,
 Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
Subject: cip-core: Something fishy with qemu devices?
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f5f9ae-ca11-4e19-be64-08dcf011e08b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q3FGalhOZlk5S3lYcG8rdTVRbVFNSmZ0RHJYSlJiaTBDdlVXQ3pmc25kTGxj?=
 =?utf-8?B?ZUpkbGUrM0s1QUlHcnhrb2NRWGE1RE9VTjd4ZkhrdzNDNDVmTCtzb09yMUZk?=
 =?utf-8?B?dHFUZjZhUDBERVhJMU4vc1VIZy9VejNzSFI5aXJReTlwQkZkMCtyUy9UbVV0?=
 =?utf-8?B?TzBrakZDMDdsUktreHJUTWJzTnBIbHd2d3lhSXZrbjlOZ3RIMFBIemR4SUtk?=
 =?utf-8?B?YUhlTWJiZDFzQjVXVmRvUzZDOHB4VGk5eTFDVE9aUUlZUWp3bHZVeFloVFdu?=
 =?utf-8?B?cC9HM3p0T0JuLzFoMnBzQ00raGttSDEyVkU5cnNRWDVna0lwaFZPQ2lmWmJw?=
 =?utf-8?B?UTErWGt5VkpzV1AvZzk2T2tQYmlrYUdQL2tTTWZtTGJmdW5JRGY5MmJZVHpk?=
 =?utf-8?B?TjFYNjg5TEY1V1hmZGFBTWErQUxGbVR2dmpqVnlPRWR6NVNjd0w1djBDdER5?=
 =?utf-8?B?V1NvYjhFcW1LeVBuZmpWVFlabkI4OTVQR2ZvTEhJUERrZlovZnJaYXdtc1lR?=
 =?utf-8?B?QnEzNWp5Q3QxeFA0S2gyd1Jub2R6M3pHT2RxZXl0VFlVamQzSTJ2bUxJcFNV?=
 =?utf-8?B?OWJRZTZHVWdOMWNkbmh4RzAvQWphT3dRc3FmZ0w4cVFFcXhKOGJXOEp2MXhJ?=
 =?utf-8?B?UTg4SkhieFp0M3dQK05UOXV0UzRqakQrc0RuZEF6cDgzQ2xBK0IvbWhmcFZ3?=
 =?utf-8?B?K2dmbVpneGJVeG1JTDRNcEFxVDAxZ00wUDhVdGRJcC92VHNiWlNDOFFxejdZ?=
 =?utf-8?B?OE9oMVBHd1lNMFk5VERoK01aRVR5SDgwRWFqKy9pNzVDWklHODQxUkhQZG5h?=
 =?utf-8?B?Q2ErbnpXcTduekJXazI5dTVGNUE1NUtpSUZjWi9kcDhSaFhXbUVscmFnOEVk?=
 =?utf-8?B?REExemF4R1MxSUxkUFFHUDk4WkRPSXZiZFpzckdrU3kvVTAyMWxjSFZkOFZ4?=
 =?utf-8?B?ZHhBWG8wemthSnJ6RFlRWG83VGdzdmxGcUxKY2hsUTRtMTJUeW5qYVJySUFa?=
 =?utf-8?B?ZHR5NHpZZUM4OGM3cUtIYUtqZWtNNEpEQkIvcE0wN0ttcFpnci9tVng3V3d0?=
 =?utf-8?B?ZmFmb2JrbGtQTmY0ZjZ5THFQSnlranlhMngxOGZDa1lDSGcrQU1GbXlwS2RU?=
 =?utf-8?B?TlVEWWY2UTdrdmFyOTNTNlpUZXJqUC9lUnBYejEvcGY0OVc5ZGIyYXhBRm05?=
 =?utf-8?B?V3FzdmlaK0RlV2pqTTZJL2xsMDdneGR2RmtxU0xYTHBmSWJZdjlUY1BTaktZ?=
 =?utf-8?B?b0crbkkwZU1TeDhXRmhGMFdUcEx0UGh2L2tKaWp3WDMyU0xJZ1pPcERWd1pr?=
 =?utf-8?B?SlpVbS9haUFWRUpFTGcwMDBOUXA5NzdoMEFlMTlLRlBwMjJqQUc4THZ2ay9p?=
 =?utf-8?B?dnZlV1g5VkVjOWxKNWNYSWp1SkNFR1FBbkZSaHp0TFJaMEhkczhjVDBRS3o5?=
 =?utf-8?B?OEM0N2hpK2hIa3o3WUhrRkZDU1dzeXJsK0x4dU0vZlVGU1dYd2gwQmJmOWh3?=
 =?utf-8?B?NzV1T2xLdUhWRm43K2RJWGl5RHp5dTU3Vk1BZWM2QmxWbHdZZHlVZ012TWlq?=
 =?utf-8?B?anFyNHR6cnR0a1V2LzBhWElCb2xvbmFBTFQvNDNjUW5wbEFIZnIwNUhoNWhq?=
 =?utf-8?B?VTd4SEEwalcyYWNFNXFWTEpOZFhmWk5rbmJxSzBPb1NIMGhST2FWTzZEUHk0?=
 =?utf-8?B?RURpZXFDQVVrdEJMdHVuYW9yTmYweTU4MWkrNWdvUHFOWmVuUnd4U3BTaGxa?=
 =?utf-8?Q?klQ379E1N5M04P63e24Hmx1Jbz8O1zR32q2hUSM?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cXB4ZUE2WjNjQlBhUndYclVkM3c5SHBMSmRwZzVOeGphanRGdEErS0RVV1lS?=
 =?utf-8?B?eVN6WDZaRE9TNHBwckNYZHpiOC9uU28yZ0dFUXh6Zm9tb3pLUGs5UDFXdFBV?=
 =?utf-8?B?RERZbFVHY1VLNGszLytucGgzbmJSMFoyQUdsN2NIVXc1c2RWRFkxK2lUODFH?=
 =?utf-8?B?c01ZeDZyU0xodjY2OC9FK1ZBeW9tY2U2MUtVRGN2L1c2ZnZkZW1aVGJMSmRE?=
 =?utf-8?B?WGNxcUdZUGxRVWJTaXdrckJ3b3RpdFVTa1MzQk55R3RsejkvQWN0OS9WRzdY?=
 =?utf-8?B?ZS9YNFRhUWo2NnladnRSUzZOR2UyTUlyeEViQnVMbStoL1RnOVJmRFBZaFVJ?=
 =?utf-8?B?Y09OQS9mR3NTbGt0UjZCdjROWlpEWE5ZWi92cXk0SkdXVklhZjRLUEhMQzBa?=
 =?utf-8?B?cnM0bzF5OW1RZFFpb3IwekNwaFZiU2Y0VUEvcUtQdDlqdmJHaDVFMVY3ZFRm?=
 =?utf-8?B?NlhxSG85NVBpcWxLNVIrQ2VHMmhvQ0NOSnVzUFRMVzZKUzBCdkoyZU5FWDVv?=
 =?utf-8?B?WktTWVR4aHdHR01Xb0l0dXJ4UmovdDV6cDFBS0Q5bjRzRUgyZTk3alZETHUz?=
 =?utf-8?B?d3pCckNZdHRGclBYSzJENWQ4TGFvZDlxS2h1b0VkV3pXRmwwYk1wVGhEU0Zi?=
 =?utf-8?B?N3NMU3Nyb1ZScW5NNDRNRisreVJBRVovaXJPVUJyYjZyTjJlWHpzN1RiOGJ6?=
 =?utf-8?B?bXNqZklmZlBGa2gxdlN4dU42aUs1cklMQWhoRGpsUHNpUFBQWDZaZDViTTRv?=
 =?utf-8?B?WEpUZTdYY2d2TmNMMzFvbVpteGNRYU1WNHFWa2pHYTA3Y2JySm52UEJzMHhQ?=
 =?utf-8?B?M2xZZWV6MFlhbit2NVIxN1h1VE9LbFcxNWw5bnlrbk8wME5iTjdTa0FaTm9K?=
 =?utf-8?B?RHQweFJYWlRjTWw1Q3ZDL08zKzdkU0VIU1VJRDRZcFNMb01MdmVPVG51bmJq?=
 =?utf-8?B?d0NESDJzT3NYRkxOT2o2cHBVMnM0UkttOFVvV3F2aVl0c1ROWGJad0hFeitn?=
 =?utf-8?B?dTNubzB2UHR3RzhjWGpyWktpaW0yTEVHUmRPM0dTb2xaQ0FLSmxhTExsblhp?=
 =?utf-8?B?cTY5eGNPVDR6bUl6a1RTRDhMd0NwNyt2Vy9CS3BwS1A4NWRuZ1BRY2VVenFy?=
 =?utf-8?B?MmVtYUppYTVQYVMrNW9tM1owbmpHMVJ6cVNkSmNLL3RyZFNhVnlhek0wRjk2?=
 =?utf-8?B?alZOZDBlUE5iS1Bsb25JcFMyczFyNmNhOGhBKzBjVlh0ZUxqSnAyNWpLSmtT?=
 =?utf-8?B?UjI0bXh3N1VIRUY0NWwyQTJuTlY5MkplczBCMXVDRzg3bDJYZkNYMlFJbDVP?=
 =?utf-8?B?MDErV25yQTRYbCs1dUpTaEhhRmlzcjArdnJaS3RCb1B5S2JlYU0xbVd2bWdq?=
 =?utf-8?B?bDJTbzMzMjJlUGxrbzZobTVCVHh1R1RTSHhwbjhIak5MWXg0SUZUSlJsQVQz?=
 =?utf-8?B?YXBCbmdVam9LQkZBVFo5RHBxMWdyaHc3S3hjQkxlNXRaTHpnOXlzWlBQUkRK?=
 =?utf-8?B?YmoyL0p6VGR2MWU1Tk9UVDdjSXBWMkwxVEk5Y1U1K09mWW5BUlRqOWFjazhj?=
 =?utf-8?B?RkFJcWYvNzI2bWtCTjdkZHdNZVdrdU9UbWUxdGF4ZzdJRExtaElYZG5iUG91?=
 =?utf-8?B?ZnZOSWF2RHk4aEs2TDlUMHJidGJWVTVnSHlMWWtzZFNUeFB4aElJOVNtZHVu?=
 =?utf-8?B?UVAxektmQ0VzTm1ZbklVc2x5bloyd3VQR21VT1pYVnh4Vm1vNEMvVk1hbnpl?=
 =?utf-8?B?bkcrbE12QTdBODRQRThVb0dEc3Z5dVpQd2VnZm0zVDlqbGZoS0RBY1JEMkJN?=
 =?utf-8?B?d1MwMGhIMkNuZ0hubE9WaVVFUThIVXk0d1dNOWsxd011NlNvN0RZMWNrNWY5?=
 =?utf-8?B?R01yeGV3SmI1UHMyVVNyNm1Ram5VWDZ5VEp3dUpCQTJ1bUZFcDMrOGpKU3dn?=
 =?utf-8?B?TklzdytYT1RUZGpydVhiMnhsQnRjTlZ2T2FBdnpTVjlaN0lvb0s4K3V0VTlq?=
 =?utf-8?B?a3MrdDN2SW1pZGJHZkZmbjlZRnNBZEhyQWN0WURjWkdBc1U0VlcxZUxRc05j?=
 =?utf-8?B?VG5EUzFhV0ZnVkVKZ0VCV3hPdXNOMUZxMDFINi9IczQ0STUyY0Nkc3Q4LzhO?=
 =?utf-8?Q?mIoKKQoAP0UkS258Zw8f51wgt?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f5f9ae-ca11-4e19-be64-08dcf011e08b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2024 07:44:35.2802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYa1uBEQ+huZb8E2AuDXfrcAsAd4am0ZXg7EOBUnTA7ajRHQSzsz/Qg5uKLdFHWqXsn5Jp2Q7bFfnZ7AgJVAbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8327
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 19 Oct 2024 07:44:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17054

Hi all,

I had countless errors with qemu targets while trying to test the latest
cip-core image, see e.g.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/8129814767
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/8129786943
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/8129777118

After hitting retry often enough, this pipeline now seems to pass.

Any ideas what is going on there?

Jan

-- 
Siemens AG, Technology
Linux Expert Center



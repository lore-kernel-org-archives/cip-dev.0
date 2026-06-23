Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91237CDB470
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 20:16:36 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.26])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30678.1782245790445873545
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jun 2026 13:16:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ihagry2s;
 spf=pass (domain: siemens.com, ip: 52.101.83.26, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n29bZaJuioRngNrMMwp1FKd8Bxsdk3j5h/WLQPQJjh8RG0Gu9XaJWN0M13eqewHBvmX/gbqyIKhuPJC9dBh0V3KIL7sgwkV9Ru6P1E3Z+jc9WuV9MSBDIpXqlS/9LYsl6JyUEdbTgAer/ZetMen6NYGVHahaJ+Bp3PHSEncuKJDsPx03eobFe5+oZjO3OBI92Cbu51Er76pn8SqkodqLBJV9zt72XLf4tgJUsZwFe16ULn1L2+qEqhy54rUVQ0e7kGJXMQeU8k7M8kyrb1tDH7Z/P/k6eya5+iBuwNxTP5Pk0G4LyFtMSNA3qBlkdSDLVLyUXkOKTAMMppVy95UXVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x05ZFGNyAyj983sA0KmCPjUJtErTI51v8SDN5tfC2ko=;
 b=RuuI4cYAUtd1LfmRdV9EACMcUpFo5E3rrWdg1LZlE3StJEw8rpcbgQ0G7MU/JiQSSe5+e8msrvEhEV6SqJJA9KusaKmJtvI37u+DO9sku9MVnEOIt8USNh7Q0FNubkNk1pISkaV3DDAqP8ulJZ9zN47Xi1PeRQ+92/ta2uF0gR9gPFBb5BoJoV6sejLIRQ+guH9isVupgUITUS14oPTllchYzREeEOdme1o3vrP6NWTx5xyOw7kLFJVAE9rR36hU8n9CYTq1A0w0b0zdEsULU+CYB4lrnz/SrJzVPm8VYta6WDRN1BnXR/ciyZNZfCKTvV7bLx4QEH6vV280glRHhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x05ZFGNyAyj983sA0KmCPjUJtErTI51v8SDN5tfC2ko=;
 b=Ihagry2satLyx6xTif+qhLRdYWK24B4rSn6blE9o0HWg6ZNZryle3fxuSvKWWNhCor3MAsFI9DidReW8+Ms3GoQzUBZkcgjt3rpRX2LK4rvngotKLULdgHYyXFHUp5CyRmbmw03Bz/LSi14FTqGeSovj1ZzMNq/f27M6IUyg7Q9IlKwKm4/ZzKv4HJOoe6yu2qDfnz+ferkGvWhHh4WJSj0gknHxiRrtx5norqu2u8aLxeCsOr1k6VHy0xeJBNIj46KXIDDoZ9pnB9+d5mU3HKucWNWYim+DuAB+IAR1hDS0g8PM0qKU89KdfhWhGOGgjElEXndngihDYFBd/aH13A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5748.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 20:16:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 20:16:25 +0000
Message-ID: <29837d2e-3205-4d02-9b02-f26d86bfc198@siemens.com>
Date: Tue, 23 Jun 2026 22:16:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v4 0/3] Enable Debian Sid support
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: Adithya.Balakumar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro.hayashi.f74@mail.toshiba
References: <20260623105234.972121-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <fd407f79-72ca-4da1-8937-9ab989c3a1cd@siemens.com>
 <TY3PR01MB11075746DDA24B486D0D524BBC7EE2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
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
In-Reply-To: <TY3PR01MB11075746DDA24B486D0D524BBC7EE2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0410.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: a6db326e-7136-4c38-30cd-08ded1644cd5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|6133799003|18002099003|22082099003|55112099003|56012099006|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info: 
	3DbQgz6jqlRYGDcPobLj3D/0tbE3UWBnc90FYDLtOh2QIPv95wByGVCEJ+g3RqWRK3jEZvK4GR+K5tTUO867wseNt5CPwmW/daiQlilFzbRHtr8mxsQrYmXa8UFW3S92l1XL1x0JVbIYOCnpMLQYfoszFdW01QurvbUv6A+8MNtL+H6b3kcsZDZlboIfmFsPFHlSlu77keaFOctHP2swd2zjTT0zY1H9FgWOtYxZRlJlzHcAntc/jUhpvnWHchL3V2eVyrvgjsIsq7Pnj3qV8I/d5ld8sQWoZCz9Nav2Qh3D+g8wbZeASJAmSaPTIo/GbWE4OoajOhBj03Hj3hvBZo285vtd5trSdoNcH9UQW262GRETJQaWKBjDvqH0rRLOHdPT8BEfDw7eIzXdsHBxpkKu5BzJ1XYX3N+BLLX95WCGvuJ7XNsveGofODFpc6rVDL5V9OSz6ircJntO5yO8y18BVxU7t/Lf8Qhj9ejebbEK7f2Aj6ng8i0cH13a66x3i/jz3ouknmj7cvFJBXbO3aVTQeeKOSCtT7XEZej4jtTvlqs/lWixF5gvR7/0mHpSCBigR08DrH4d0TjgRct6+OyvRK0G7+VbsZzI9+kBDg3wd77Z/B7S4xaAhu5ndqHJHhr7QKk51/zeYK7VgtiyBD7jpw3KnsNAkhjH5ZsZ9QM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(18002099003)(22082099003)(55112099003)(56012099006)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dmpPVzd0MFd3bEgrM3VoTHBpZERiVVRRWFp6M0JWcHVMdmJDbmNNTjNqMWY2?=
 =?utf-8?B?bGJ5MGZIR3k0Qk95TFhTTHNGYS9lbVI5WHQ0VkhkUnd6ZUxpOXVLTGNGd3pv?=
 =?utf-8?B?ZlBxQ2lqRjQrSE9MOHRBWG54NEhYNGQzcmZVN1FITytyWWNIeFdGM1dYbVox?=
 =?utf-8?B?Z3NYS1FIRnNwdDVObmNXdiswMk13L0ZzNHBqWVUxeGhxOTg2ZTYyRGtSTmdM?=
 =?utf-8?B?Nm5pcXhkK2pCY2VQTzROc3hIWTlZYmd6UGtya3RQTUR3MDZ5eTNZWXNlRDR3?=
 =?utf-8?B?T0J1YlhDTDl1SWZ0N0w3R0JTTU04eUpvaGNXT1BsZlVuMTRxcW5vRkhNMmtl?=
 =?utf-8?B?OHRRanZGMUk3Y0N2MTdlc2ZHejlmTnMrM2JPcmp4WWtwOWJRNmpVajFJL0dx?=
 =?utf-8?B?cExaNm9YaXJwZnJDZldFRm9sd3ZMZnIwczBJRGhwMVJBNU1Xc1FvNzlIa29y?=
 =?utf-8?B?NWR0cG0zajVGK3VIV2tlbC9ydS9CY0UvZ2c4c293SHZlYURvSUFiTmdGV2dp?=
 =?utf-8?B?WHQ4QXZQYzhIeVY2VUVORUY5d0s0WVhMSWxYZmNSNlRMTFQ5WDU0Q0IwY25N?=
 =?utf-8?B?QS9JUkQyYWZCSmlqaFRWWHNMQ0N6VWt1bVRFMFF1WmFxVGhTeTl1bGs3bzF5?=
 =?utf-8?B?aU1iSks3dWFDdVBaMHYxTjVKbE1yNUF1clVuQ2FYa0tnbEk5OSsySzZkbXpi?=
 =?utf-8?B?bVZHSFBBM0ozSDdIcUNpQ1R1UXUzRG94MFNxUjVMNkFodlRqYU1YYnhGd0Vm?=
 =?utf-8?B?d2VYZDI2ejNoOVNsQW5mTGszUThpTnF5dXJQQk5QREgyc0MydkY5NGtnQ2Zr?=
 =?utf-8?B?Q2psM2xVMzZGVTFSM1RpbHcxbDkyU0tDZkdmTDQ4b1RONmExL3d4ZjFzV3VF?=
 =?utf-8?B?WGEzcWZSUThYRlluTXdLOWIvNEg4TElNbHJQKzBwZzNiaU0vcnhmM0ZSNlB6?=
 =?utf-8?B?SjZIR1EzaW5VdmZ4WHF5aE1iYnRieG9YTmQwdjdTdmxtd2JaY3p2RisrVnlL?=
 =?utf-8?B?anQ4VExaYTVCSERmN2E2Y1NDV2ZvQVJjcnd0S21DN3lJZHJSdncrdlc4eENs?=
 =?utf-8?B?M3VsRUdGdGQ2UUNvTk5XOWRJajhWbnM4RW1jUkxXR29tOWtnK0x2NVhqWmtD?=
 =?utf-8?B?ZktDNzEySDREVEtJTnEzVWRCWlYzWlkrL1JzeTZaRXZZeURPc205SFcwMWFZ?=
 =?utf-8?B?VnN6aVNKb3ltaGFPcFVFSytlK3gydHhpTEhadkd4eUs2VFUrQ1FTeFliaG9q?=
 =?utf-8?B?Z1MxbG9KdVlRTW83bnZlb0xTcDZLaFhSRmkvMlRlTHFwOWEveFhidVNtQXoz?=
 =?utf-8?B?M3dyNHN4MzJhNmtLYlZkbW9RSGV4TG1jdXFGZHVDdElqOEZ5enJLNkwwMlcv?=
 =?utf-8?B?Q0I1djZGdkxNTzdWYUNRMmROcUVzdk1HaldldUI0NjdnQklDZXBWYnlPNTR5?=
 =?utf-8?B?YXRuV0xpZkIySUpueU5tUVplbnZLNzRhZ08xaEtYZW1NMCsraG9wSjFDcjRk?=
 =?utf-8?B?amFWOTRwRGk4cmN5R3RYQkdiWC9CL1V2bVN6VytjZ3d1UHZ1aG1WYWdkYWZP?=
 =?utf-8?B?V3RVaGhDNUlwRlFVTDMvSVRhTDF2RWNZWmQ5Q0liajFsQ2E0c2JwcTZ1TXU4?=
 =?utf-8?B?M2hrZjRjS1RPT0RnRFF1dC93VlF6TXhKLzZId1l1WkxNam5TelVUcjlHQjdB?=
 =?utf-8?B?STlsaFFFanJMZWd5NWlpTmI4Rk1hU0FnTlZoajhRVEdoaDQ5azFwYm1sVmI0?=
 =?utf-8?B?NUgxSWIxVWorMjAzQ1hkQldFblptNUtvTDZKZVY1SFFxbVhReHcxU0VQcSty?=
 =?utf-8?B?YWpoQVlSeXBzZ21jN3hJdXU3MDV5VFNxcTF3QTcwN3VYSnNTQVhraGk4N3J4?=
 =?utf-8?B?eTJLYXp5OWcxdFV2UGhFQlhuNTBxelIvZXZGRTdwNGNJTEc0Mm9vMWFDSi81?=
 =?utf-8?B?VlVJQjBnMUJ5enVPRlZoU3hDTktQdi8xayt4VVBiNVpKaGpUOTNCanVsQmpW?=
 =?utf-8?B?SmY5djAvRzlTOEZ4cC9XRFU3ZUQ1YUVKaCtUOFo1VkQrZzBZZUg3MTZZSEtQ?=
 =?utf-8?B?UWNhMXZsV0NWZGZ4Qlg4T2x0QXNBa3Y1K1ViM3V0YldQK2dDMVlUMFNCcUFD?=
 =?utf-8?B?c2w2ckIvWklOeGk2SWVMN291cUM3Rm1OWkRkSGUxcUhBWCs2NWQ2RU9yazVB?=
 =?utf-8?B?akxSYUQzVWlETENMWGovUUJ5R09LNEVzRXgzZklQZlNUQlREbWovb0QrdElm?=
 =?utf-8?B?Z1kzb3Y0Yy9PYm00Ujh1NjF5K3pHMTUzR1ZxOFNKc1YxRElrSzlSc2RvRkZK?=
 =?utf-8?B?L28zK0h5ZjgyTzVYZ3VhYk1HZGhjVlM5SU5QelBUYXlzYlRPaXdsZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6db326e-7136-4c38-30cd-08ded1644cd5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 20:16:25.0865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82q+eTo5b6fV44zcTC7w2+51egHDvSUweya3PT3qXE3y9rWOIA2syjdHE+wKBlWgyOWY+SZVRqfP0Y2MTaPcQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5748
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jun 2026 20:16:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23274

On 23.06.26 15:01, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan, 
> 
> Thank you for the minor changes. 
> 
> I have one request, the scheduled pipeline "Weekly Debian Sid build & tests" here https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipeline_schedules was used for testing, but I'm unable to change the branch to "next" due to the below error. 
> 
> "The current user is not authorized to update the pipeline schedule" 
> 
> Could you please create new scheduled pipeline using "next" branch with same options (if interval & time zone are fine)? 
> Make sure to define CI variable "CI_RUN_UNSTABLE_SID" in this pipeline. 
> 

I've taken ownership of your schedule and was able to point it to the
next branch - it is a protected one, and that likely prevented that you
could define this

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C199C369C2
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 06:12:52 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.62])
 by mx.groups.io with SMTP id smtpd.web10.33804.1745302368819551634
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Apr 2025 23:12:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RmU8V4pa;
 spf=pass (domain: siemens.com, ip: 40.107.241.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhGm7bwBkhtkBkkjE2EyW97iZXyYxtlQN73Q3ad7GD11dVGXJ4tk4wGNAVruk/1bUF3VHVipWxqn/u+BKHZS9ZAxuD/0Y6JrdpKJlJqSoa7Rj3RkK0wRy+8TDz9+OCoCE1XmKwSwdEeP86dvecF32EZbzVcd9tCShGFClGwwTnKARJ9LOC+6iKkUU3dGs7mNess5/4XUoXWyLArqyk0qNRYeloo7gvMulPEvgiKRd7yXWUraJqztYL+Hothr27PP/Tg7pz2VT5deF2XcaTbCWUMm8d/2vze2W7Omp+yXqK+YGfbC+M/3Q7MFkOxpk8vIigpSx8BxSOxqk6LbsxjfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuaOo5g7J6/Z1HgBzmpGuJs7fJArFHL4+qS2m+HNnAg=;
 b=CjUvQkZOtBm634UmqCDNj0cl8S3n8BM/mXhPGC59fOaalcaWMGiTyrKnq7AGxuQtdd/wjfoR4W03kYRcSDZQBL1SAo4RiQ3Odw5kbUrotCHYL23QwRl0au21B2LUZ8lvmTYf9pVWM990P0EXQNL0vOJl7fEewOIdEY1WMp8Osp97gQPzW0Dy5e/TuzppqoQf/0RfFcwU31AmF9JYDBoXXwNCP4TJvRwlI2VPt9tpNItIPZKsTjmcuW37WixFQQUdcXM1dLk1rLjnviwGUF80VXtJADAkn/oOZAV1Fd9eYwpUnZ3AlOoyc0iIeVlo6AY/acpQJ0/3Qd0w8gAqltKYZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuaOo5g7J6/Z1HgBzmpGuJs7fJArFHL4+qS2m+HNnAg=;
 b=RmU8V4parxrmYLbSzvElLaVNePxd7tSnNWgNFqmduHzDLD7vvn23AcBYp6yiryfBbiMWI2O9Dmot9VcPJ+8R9XnauhEcLqe4KIEU+J8CC9z3gW2gt4z3syaKAT0BTSla6SainMcweTLOI5+CjsbCgB7yuJWs5TUokauYp0y5A5+2Oqd5C68hO3ayO8jMjEaOcgOqPpIBpm3dYESNzTwlwz4KhYkDyHT8+5/40YKlksWRtHmpYB5D1mTyKszHwhNcTyrpQBC0AfBEC8EoqjmuVtYeWXvHyZwYEtR7bGBG5dNFmllbXg45wE6/41ZFbNGYrABwM5sVwjybjOFl3lGmdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB4PR10MB6119.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Tue, 22 Apr
 2025 06:12:44 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 06:12:43 +0000
Message-ID: <0db1aab1-18ea-4bea-97a9-b85159487a1b@siemens.com>
Date: Tue, 22 Apr 2025 08:12:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core v4 2/2] IEC_template.yml: Update IEC
 layer tests revision
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250417072708.2757909-1-Sai.Sathujoda@toshiba-tsip.com>
 <20250417072708.2757909-2-Sai.Sathujoda@toshiba-tsip.com>
 <7fb7d0ce-f588-4d85-a01d-ea8678588aa3@siemens.com>
 <825618d2-d3f6-44f3-b1f0-625f7256dd38@siemens.com>
 <OSCPR01MB14838EF80E946D2BCB02E8208C2BF2@OSCPR01MB14838.jpnprd01.prod.outlook.com>
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
In-Reply-To: <OSCPR01MB14838EF80E946D2BCB02E8208C2BF2@OSCPR01MB14838.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::18) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB4PR10MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 87650497-5dc6-4797-1c92-08dd8164b1c3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZkFRY3UvTDgyQ25CdkF2N2hDeUZBVUhEV2UvcFNQVzNzbFU2QWc1ZCtuY1Ay?=
 =?utf-8?B?cnFPMFc3eVdYVXNCcSs1dXJtTDkrM0ZYT3VHZkE2ZEdya3JiS08wNjFnUmln?=
 =?utf-8?B?Ym9iV2tPVEVCMDNrek5hY0d4c25MdUZ1OHBQaS9PaWNtcjNzb1FVRVdJdGM5?=
 =?utf-8?B?RnNNQ2tGVW9HeWEydGlGS2E1SjY3aittUnR2dmllRWFldmE0d0tCS2xMVmpo?=
 =?utf-8?B?TmwzSXZrRE1wVmE5b3lhcURyQTdaQVY2NnNWOTdaK1Q2SjJEUVVuQWJadkdj?=
 =?utf-8?B?d0x2RGFaTkM2bjBmSWxSNlZWWVp3RVE5UnNkUXpScU1xOE9Xb3QzQWl0eXZX?=
 =?utf-8?B?Tk9BSmVET1Y1cU5EYkVCbzhXVGVGM3RDZlJsbzBHSUNsejdGV211UFd2YklQ?=
 =?utf-8?B?UGlQTWN1WXdyVzMyZWVKd1dCVldEQlRhZ3dLTFAremxTZ0VaYjZYbk5ZcHpR?=
 =?utf-8?B?WkNpY2YwU05EM3lieFF6aWJINlhBcDZNajVzQXlSd29idGF5SCtreEFYeTl0?=
 =?utf-8?B?SFIrTndBOVRXTm1SUmRjbTFKMDlZZHdBQUxHeHRkOU9CVnc0L0JYSGU0bjJ4?=
 =?utf-8?B?eW1tQTFvSTRVQkJ0cnBRVUhjbEYwLzBQZmZQbThHdXM3WTMzbWJORERDakFx?=
 =?utf-8?B?VHYwcDJtRG1JY2tMc2FtV0huSkt2WDA2TTBmK0p6ZnlycFVQRUZ3dkt6MVJ0?=
 =?utf-8?B?R3QxRFlDdzBZVDUwZVRVR3Z0a3QzOTkwTWprUER2Yk1YMVdoN1prT3lvemxM?=
 =?utf-8?B?OW1BVXk0eSs3QUo5c1hQSmdOZnlmclA2WW5pMjRJeTZIa0NxTmNmNGUzYmFi?=
 =?utf-8?B?QTVydTFHQU5rU0tacE4vUXh0djZiSVZybG5FNW9LSGxzMXlYRnVFZk9xUi9D?=
 =?utf-8?B?SU1Dd2F6SitucDJadW5ZNHl5RXZqdGMxWE02VDRhSjV1RGtPeUVXdkF2Zk52?=
 =?utf-8?B?RC9WNEpMWkQrdFB1aVo1S1FGSFF5TWtWaXRCSzErMFFzeW0raUU2MUdWdEFL?=
 =?utf-8?B?MGJoTEowVVhIVnBtaGt3WlJhM3UwUW5BYlNnOHgyNUV4cmgvTXYveDg5NU5j?=
 =?utf-8?B?WkMwdzIyMXJHakJaRElZS1VUUG1DK09PMUFkSlpPbC92dEJSU2JPRzAyenlM?=
 =?utf-8?B?L09mK0RMdk8wdnZlYWRvbUJvY2UvWnFpV1lNNW55L0hnZEEzUHpKOExnK2NQ?=
 =?utf-8?B?SWpDeUhHOHhwSmtSYlBJMmFsbWxlUXZTaVJscUFBejBDWW1WV0k3TXNqYVE2?=
 =?utf-8?B?UDd6aHBjZzhDenV2SmJXUkticE9YRkdIMEorYmt0OU9FL3J2aVlHcU1ER1Zo?=
 =?utf-8?B?amN0a0dEWjNPTmM5K0pUZXJmaUUxSThFNjBtajBndVBVSzZ0b3BEOXJxV0l4?=
 =?utf-8?B?aTdPOS91MlFXZVZVdnBkdk9LNFJFbU02VDFlWFIwTzBZeGJESjl0SXdHY3Nj?=
 =?utf-8?B?ampxMDVjbHppd3N2Ykt5N2Zaa2RXNWhGTGRBRWhub29CeStKMm9naFdWOWgv?=
 =?utf-8?B?WVhrZ1R0RXpLQm9jN3NSRE5aZlRLZU1XZG4zaTlyQkpWWXJVSk90eWoyRXFI?=
 =?utf-8?B?M2x3NUdGQ3k4aGUzR1JFNHFjOFpOaXlCUXNSVUtWWDNYclJHbm12QWU5WjBI?=
 =?utf-8?B?dk1qdGY4N0EyMG9uaUV4aFVheXY0UU5vLzNWYkQ3S2lhOEdMTVJzMVV2R2Fu?=
 =?utf-8?B?UnNoV3BYOU11MXVDL281UGNBUGF5RW0xTHVkalgrL0tDYTBGQktqQXYyTDFv?=
 =?utf-8?B?WEhJb3JJeFBGWGJkcjR4Vm1Kbm1rckpGTVZnVlRxaVQxVVZTMVRUL1FSSDZC?=
 =?utf-8?Q?8DJUIFvJg22BvNw5mPa4TYMIoR2urDqmvKPFw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T3ZvNjdhdTdSOHNYRjdGcXJCd3ZwaUlGb0YrSXhxYUZWN2JDd3l1ZWFncWNN?=
 =?utf-8?B?M2hHaU9pVHYrTk5BZDdncEcyQ29HanFKR0FZcERJbzJmMHpsVEVwUWpSaUhq?=
 =?utf-8?B?TU15UjViYkNmS2ZxRG1XUnZSWnFxY0hRb3ZNU01iTjhDVTQ1OFIzQU5BbEMv?=
 =?utf-8?B?bFFESndhb0FwTXZNSWNOQUdBUFcyYkZYWW94NFBzRUVhdUpoN3pPSGM5UkFt?=
 =?utf-8?B?WnhCZnNnTU1ZeHN0Q3lQU0grTnNYbEZsOWhHTDRKbzdqaDB0RGUySS9HSlZL?=
 =?utf-8?B?YjRDM280ZFIvcndMRnhBUk5RYjZoUjNFeEJwbDZwOXc5ci9FMytNQmJ4bFY4?=
 =?utf-8?B?SVdYeHpUejFaS0V1cGYyd1d2TzBnSGpORm01aW9YU0VWSThHMXBuN1g3MW14?=
 =?utf-8?B?TFdJcENZd25BbUw2VEp5WjZuVVNPZldON1BhWEZvRU51bWJzVlVjYnZKTHo1?=
 =?utf-8?B?blo3RWdvUFVvWXpWczdhTVZvVW9nanpCd3U2OFZPcVluN1VNeHpha3ZVakRk?=
 =?utf-8?B?czlLVy9Gc2tSM2MwTkl6blpMcnhPV0JUNER3b1Z0L25mbkpUT3ZETUlNYzFB?=
 =?utf-8?B?K2R2WDE3VThXWncveGtjeVBFRUI0SjYyNzhlWkYvQVJGT1hheWhPYmZjZ2dM?=
 =?utf-8?B?T252K2MrRTVnNE85RWhFL2ltYTR0NzYzOGh2bXlSYWJjeSsvYUF1RDVXWmZP?=
 =?utf-8?B?SUNsRzVYSjNpWUtIcGRsYjJ2djlLTzV6QWJ1WmZqUzFXWFRRYUpmVW9SSEdi?=
 =?utf-8?B?alFmRlA1WjdhU0k4VHN0VDd3UHVUQUZGelBqa0k1cDR6ZkF0TlpBR3pNaS9K?=
 =?utf-8?B?L25LSFh1NFhSaGo1NFdhV21ka1ozZVlUZUdOWVN0T0pXSTBOaE4xRzRNQUsv?=
 =?utf-8?B?TjlyM1NlcEhicC9Gb2hDV21jczdRZ0gyOEd0VUQ5citzN0hhRjA5VUxKYkI4?=
 =?utf-8?B?NXd6RU9DeUJpTlZCU3ZSWE5vM094LzRCOGZxM01BMWs1MW95TE8reW5lZC9J?=
 =?utf-8?B?VmMwN3VMMURjTzN3VW04SGE4ZWtUR3RjVC84c252YUhHQUdLbXVVZ2VGZFcx?=
 =?utf-8?B?dEZ6MzQzV0ZjdW1ldTY3eWh2Tmg0bUM2OU1xNGtZOWFRdGptWXNZUGdDQjdw?=
 =?utf-8?B?NHRUcGdiUG03YWxqdVh5ZitsU2hlaUxMSXkzTEVpQ1k4NVo0NDMzclROTHJn?=
 =?utf-8?B?dWIrcUM2cnJVbVpDWXROdUE1TEsvYUExM0Z5dDg1ay9sTnpQcGxZazk5NHNt?=
 =?utf-8?B?VFdKZWFqc3hUK2pNYldUWjgrSlIrS29aZUNEV2ZXc2Z0cmJQRm96V1BZM1Bz?=
 =?utf-8?B?MW42amI2dUtGT3ljQksramtEWHpxRU5kenoxdWcvQUNiQmgyNXd0aTNqYU9F?=
 =?utf-8?B?QVVYb0xVQ0JiL3crZVpPaFVGUlREalNXNGk3UGFaY3NXaExQZWVNZWZlZnFy?=
 =?utf-8?B?WUFhS3A5YW1CSVRaRDVJODZTbDhBME9mYjRTSnRmb2NZRitBZ3p4cjY5NENo?=
 =?utf-8?B?MlhHdy91SnJSL1F2RTE3eVVBRXc4cHNGb2lQQldFU0l5T1J0YXEvN29VY2pS?=
 =?utf-8?B?UVZxMlNSQWRkV3cxdnVvRzhreVdGcnRyR2haZ3M1eHN3UHA4TWVLdDNmbldy?=
 =?utf-8?B?RzFMWVQzb3JHWmJSUDh4RlVSUDhaUDE0VnNkZkhjcTM1NGhoVmx3ektCUHZa?=
 =?utf-8?B?K2dIejBWdVRuTEQzM1hacjZ4M0txOCtKWUlOWkpXdXk3T2kwSE9rZnNWVGRo?=
 =?utf-8?B?Q0h4WVVyYlg5M2FpdGVrMlZYdDlBVUQ4YURabklGTkJkanRTdGVGVTQxbTlP?=
 =?utf-8?B?NWhCMm5XRUk3S0lqbG1hd3llbUtTY00wM0hSYURPeCtMS3IwOEx1ZkwyZHY2?=
 =?utf-8?B?aTdPM0wyS2xXYkE5U1lmWnRUZVorSnRka2hhL21kYkVWZ1JUTDRxN09ETGli?=
 =?utf-8?B?ZEFZWGZYMUxEQnVzVGtMWXlpc3F0RXFkNmsyVzNSbEhYeHhhcWw2bkFTcE4w?=
 =?utf-8?B?WXRNVEJIbE5jNVNSbHhRN3pGeVFTeHllUjZEUi8rSmZ5cm1YbHI0bVc1YVJQ?=
 =?utf-8?B?NWRFTmkzd29welJBYjRtUjdxLy9YS0tqeUgycVcwaEc2QnNEbkdobFhwUGVN?=
 =?utf-8?Q?Rr6ONUE/TLVbwRNljmnPSeQ2R?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87650497-5dc6-4797-1c92-08dd8164b1c3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 06:12:43.8226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAUAHjPMhikhpnzLc1MBrk7y6wIvDgljmRx+Bsp+r4veTgDODYw85R1SZlphIPWzdf1Zcn+233RMCf2Nnk4Kxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6119
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Apr 2025 06:12:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18540

On 18.04.25 07:20, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hi Jan,
> 
> envsubst tool is replacing the value with null in case if it is not
> finding the exported variable in that template file. That is why it was
> unable to pull the swupdate file from the dispatcher because
> lava_dispatcher_id and lava_job_id are replaced with null. https://
> lava.ciplatform.org/scheduler/job/1264806/definition#defline74 <https://
> lava.ciplatform.org/scheduler/job/1264806/definition#defline74>
> 
> So I made the following change to the envsubst command to handle this,
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/
> fb13471312e6909483addb78e0c7644997383e66#a2c400ca9e562e29e60bd9b5edf0e3aa068ce6dc_337_342 <https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/fb13471312e6909483addb78e0c7644997383e66#a2c400ca9e562e29e60bd9b5edf0e3aa068ce6dc_337_342>
> 
> Now I can see those two variables are not replaced in the job
> definition, and I am sure the x86-uefi swupdate job will not fail now.

Just send a v5 of the patch series once you have a fix, and I will
replace v4 with it in next.

> But just now noticed that there was problem with flashing the device
> https://lava.ciplatform.org/scheduler/job/1265073#L236 <https://
> lava.ciplatform.org/scheduler/job/1265073#L236>. Can you please look
> into this issue ? Once it has been resolved I will send patch to update
> the envsubst command.


Is that flashing problem still present?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


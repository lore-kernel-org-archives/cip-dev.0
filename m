Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DCECCD192
	for <webhook@archiver.kernel.org>; Tue, 14 Oct 2025 13:54:30 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.13])
 by mx.groups.io with SMTP id smtpd.web11.17115.1760450059797553311
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Oct 2025 06:54:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cRtT/E+w;
 spf=pass (domain: siemens.com, ip: 52.101.84.13, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJnTqOkbJybOUCtsmKSNj0xicELGVox4I3TVhPlhbHgEvQNTlA+DtZyc7CLpiZM/Fud1DSJI77iiv2mn5jTIcfzxS14JNMTg0AJRxI1g7bex31yd/S2HjOzrEEm/7m3JO+AcbJV/OWbbhj7tvHm7QQ++0OZugkSymGuAdiifK2g+OdqpRRXy9nG32ru30xDA//yfotK/3/H1hUNghSNcK93jb218pni4vG7N9lA9fJNo56P7erFJHIR0zsAnAZKmzKSU6ho7JFlDdAbS6+oo9SBLGwruRHfE6dhsNJogl7BLdjHb/lEMNXBbsdJ2n9+ClnjySdLAZWqAcqXnrU0YVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F11qob6UJKIOkoetwZKBP/NnZd4CqL8FZdDC1V33NsY=;
 b=jIQiwPUvJx+VABnjCD0FGzctfi6sCjvbbOUWEOmwccbkK+Qxkz9a1qVq+xQqrXnaSo6tDnbzjj8lfqhvVC9otVThYLiS6mNEYOHZdclJrh0BMrB3vcznseWrhbn7wBG6tn/qjEhJdwFC9CXHZ11hFl8NaSsr5+ns8kdouhJPXmIGJ7pX9/yb2jazxCvNSYqu8AuXuoTf25c05zPcAvbp0CSNKMzrwbkFTsfuY6buwbc+2rQluUTrrN6UJIVD1NwtR3RZqWhwO8lGlGLlh1NLYkWOIFN6qTuT+hcpBkqiZEij/4DTv4AZ6Nq3CT7fp/uvaXN4TVMVXvtnNy9K4/cDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F11qob6UJKIOkoetwZKBP/NnZd4CqL8FZdDC1V33NsY=;
 b=cRtT/E+wwkczhP+1R0wBmHlsgdjg35rmbLAdLmBM71UtjLZRM43rEXtoSCf6zEPknswWTg7OfLSBl+9ZQr1DZobj8gSqFI/DGXlE9gkFboKR1aarfigoiXiK5E0jYNwFHP0+qnO6PGFe30NM0pkk/yg5fm+9Pkx44u97QBOTmzDYOk9DVXd/VOU3H54ZZoGCxdF6Eu3/oIWLgkuQ0qELWfbHfWSrcyLuOBRU5nXp7xZ7DI7ptoyQhf6HQ56e4uuNs5qrcNn7K2LYOCae7cLdwd/Uf1FyZdpNFNVtFDZqzbJG4bgDYoBjYXPNeJMT6vPnxwZrNr9teIMiIn4r0bvVDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Tue, 14 Oct
 2025 13:54:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.005; Tue, 14 Oct 2025
 13:54:15 +0000
Message-ID: <6fc52da1-ce17-412a-85b0-8e36187ed56e@siemens.com>
Date: Tue, 14 Oct 2025 15:54:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] isar-cip-core: on-device tests failing
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Shivanand.Kunijadar@toshiba-tsip.com, quirin.gylstorff@siemens.com,
 cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com,
 dinesh.kumar@toshiba-tsip.com
References: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
 <TY3PR01MB11075F7F38A4345A60D5FF028C71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <3643259b-7e4d-4e38-9d53-b0e2227f9931@siemens.com>
 <TY3PR01MB11075A9F4E791BBC04C5EE28DC71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <c8e57ef0-6f4f-481a-9e36-214f44fffb5f@siemens.com>
 <d196dbf9-7c3f-421b-a80c-2d39cfb6e27c@siemens.com>
 <TY3PR01MB110754E7268909F7468881081C71BA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <638abd24-8fc6-4fee-9bf4-679b51c936a3@siemens.com>
 <dcc32fbe-2b53-40de-aca3-0bb0e9bdf481@siemens.com>
 <232ddcae-a297-4e7d-9898-f34edd3671f1@siemens.com>
 <TYWPR01MB110639A5228DE9FB8CAC93E4EC7EBA@TYWPR01MB11063.jpnprd01.prod.outlook.com>
 <0f2a5909-4746-452a-8f39-187eaa9e3cd1@siemens.com>
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
In-Reply-To: <0f2a5909-4746-452a-8f39-187eaa9e3cd1@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: df57b057-61cc-46de-8102-08de0b2929dc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U1FFeTJIY1J6VkFxT2VxcnBOMGVPWHd5OEZOSnAwR2FXZ0ZIUVM2TWp2NGcx?=
 =?utf-8?B?ZllqKzFobmUrZnhKQjFVV2VZUUxpZzIvWkRRWS9DOGZhQ0o2UWZuaEwxMEV4?=
 =?utf-8?B?SFZuRDJhRXNTc3k1VjJWazBoQ2tFZnJrUHcySjhjcWxmaTFRa01QU0xFNEdi?=
 =?utf-8?B?QWRNNzNCcGZ5SkhMVEVFUTNuTnlJbDJkNDhBNlVmdVFyZi8zNzBWQU1LZTFw?=
 =?utf-8?B?eXpFNk5XemVGMU1kanVOczJTZ1UrakwySk5zR1JHdDJtZU9Ga1EvUXh3c2xi?=
 =?utf-8?B?SWFJTnpEQ2FFbFlJR3FnNDBmL2FpVml6SE1UKzRZNG9zL2RmdnR3RGpaWVpt?=
 =?utf-8?B?ZWhmT0pTY3FhY2pyYkNadElVcndGMW9XcWdib2FhaWUyVHh0OE1YTGo1dHhj?=
 =?utf-8?B?bWFtQVpPTG96RkJHdS96YlBKWE42TFZobG1jaGtYeUx1RnErQWhYSSt0R2pH?=
 =?utf-8?B?RVp1USs0encvT1hOUGVrYVl1NG5WbFMzS1p2V2lWSTYrZTd0aitIaVRhQlFP?=
 =?utf-8?B?cTFXcUoxRDBta0Y3Ym1iM09jRGNVeEx0cXZKYXpkeDlxalhPbWZNenZaZ3RJ?=
 =?utf-8?B?ZGg2RTlyYXI0cVFrZHNCYW5NS1pzdlA5S2lwcXBxSHUvZ3RzZWJTdWMwZmRJ?=
 =?utf-8?B?bDlPQWJVV1JqbnNYNmdRSVcwS0M2TnBPSDU3cjMwVVRoKzVlb0FMTVFZVGtT?=
 =?utf-8?B?UEwzNFpaeEpLWHNndWJrOEtFY0lRTHlUZ3RoRHRzSitCTlVqQ3B2c00zQklU?=
 =?utf-8?B?MjRwN3NGbmd2eXY2d2N6NjJRV3ZyaHY4MUJFeGZCUlpXMFZ4ampxbVMzNHZI?=
 =?utf-8?B?TXRsVUxhWGhhSkhDU3krenE0ZkgveG1TMXpzRW5Ma0Ntb0x6WVV0Ynk2TzJY?=
 =?utf-8?B?VFVKY1Y1MWlFNElCUXlyeXhLb3FOOXJ4VDVDRzhJK3p0OVdvcVlqZjFXcjJl?=
 =?utf-8?B?cU10WnA4cGFZUlZRQmp0MlR3N1phTnB2K3FSVmRZOGJlaVhUakc2QlFwMnVq?=
 =?utf-8?B?d2JJNFVTcy93aTdyUXRHeW5sbnpDelprRzU5dWJySFVTU3dia3dpZ1M0a1ov?=
 =?utf-8?B?VEtZbTVZK0pJdWRMK3YzWTI0bGJCVUF0dzdaYkhFdG5pNUZQTmRqZE9hSFBX?=
 =?utf-8?B?L2FmbkZOSmlyNXRlYXdQQk1JODlUYm83MVFSRGNHdkcyVlZsdVJ3NlVOM0lB?=
 =?utf-8?B?a3NrZDA3UFRvZHp4ZEFaeURHcVQ5VmIyUUlpa1FtNy9ydm5hdEpEalRwaVlW?=
 =?utf-8?B?WEpUNHgxaDZvSnNSMjZxemQ3UFh6aXd6Qi9IcjFmS2RPdzZRYlUyYjNpUTJM?=
 =?utf-8?B?ZDdLdXlFdzd5bjdMSVdaNG5OQ2M2U2w0bWIwZTJRTERPeEZ5ZXUwamsweTF5?=
 =?utf-8?B?STFSUTFvL2lnb0R3aUlrRTQxZ3dxZ2VaVytFcE5yVTNQQ1V2Z3RsZG95c1Ur?=
 =?utf-8?B?YlpnbVpGdlh2SGVCV2pVOXpSZGNqUWs0TXlGSVo0Y2JjZFNJNXVnUys3TjJa?=
 =?utf-8?B?T3pYejV6Qm4xMWppS3k5Y29oejBBYjUvYVdBOW9PRmE4UDEyUWlJUGhRMzJ0?=
 =?utf-8?B?QUVPczZKLzZhZ1g5aXZDZmF4KzA5aW5TdnpnL0JWdEwwY0ZxR2Nud016NUhq?=
 =?utf-8?B?MXVJM0drSjBMRG1BVU8vWXkyMHEvd2tPc2pnUVJja0ZkS2ZlVkFMRWF6UjBL?=
 =?utf-8?B?OUZFeXJBeVdCZ2NNM3RYeWVGTDYwR1M1L3Z4RnNXV0tCY1lhQ3ZaOWRaeTg4?=
 =?utf-8?B?Z0JmRXpkZ24yL3RFbVdlL1FXQ0UxemRFcmhHWEJOc1ZIU0k2UUJ3T2hwdmlu?=
 =?utf-8?B?dWo3TXBlZDEzTmxqOTE4b0tmelUxZ3dEa0tOZ0pjblc2c3lPUmg2R1g4UnZU?=
 =?utf-8?B?REdrTGQydTFqa1pRT21tVHhJMENWb1p5UlcwMU5TZUF2V3h4K2VhUVZJaHN2?=
 =?utf-8?B?WmhCUFJUT3ZHbUY3a0dzSE4yVVRocmdMVnBhcWtScncxNnJ1SmxHSnA1d0VO?=
 =?utf-8?B?dlRRRU1qNFp3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WDM2Yi9ON0ZUR043SXVQNTlwNmpqdlVWV0pKdlpjbVlPKzgrSmRUUHpPMXpL?=
 =?utf-8?B?S21SY05UTmE0ZVRhVUMvUStIbitUU3hZV01oUUY3UVpBM0xlSFVkalBYR0JE?=
 =?utf-8?B?SzVkV1pQaDBNY0Y5dVI5MXpia3FtdkpYSWVTUDhLQ1NEd3kxVmlpZEhCQSs2?=
 =?utf-8?B?NnVxczBlb05WUVd3WjdwaHZTQkRKbjdONUxhWjZiZEtqNHVmTjBNdWJGYlBl?=
 =?utf-8?B?ZUZMUnJuREtoT3pMaWVEYzVqMGlCNSt6RXpYQW0wc0Q4VmdRY1czREJGZFFz?=
 =?utf-8?B?MDJPeEg4ayszZFlqTVgrWWM2V2xjVTRTREs0cGRXMTJLa1RqcTdRYndrb21J?=
 =?utf-8?B?NGFIamd3T1pobjVnb3NMU0E5UjhsWXI2YXZmTGxKeXZhWTdScFltSWpuODAy?=
 =?utf-8?B?a21zN0pRMGIwMTVCNWxiM1lOYnY3R0o5TUJpUW1pTDIvOEU1a2Q2SDJNR2ZY?=
 =?utf-8?B?dTAwUTZzQUx0eGhESFZLOGVUN05mTEpOQWN1Y3M2R0VGVGg2UnF0VlROa3ZO?=
 =?utf-8?B?TSt2UThkcld5cThERVYzMG5rbWk2OFZZcTBtNU5rNGhiWHR0UjRLMmNuMEZz?=
 =?utf-8?B?ZURSUjVWcnY4R0J4OStFaVBxcnUyRktldWhTQ21MbmVvZC9qUWlxeHlnd3h1?=
 =?utf-8?B?UGhPZll0RXpwRzBEMFlrL21VZXRMZ1QzbHpZVXBUWU5QdU8wUStvUFBXcVNj?=
 =?utf-8?B?dXBmQVZHd0JlcmRERE5ZOGo0Y1h1d0tUNmkxQWRzQTdkZlN6aXh5N1d2cmt0?=
 =?utf-8?B?VXdsZXp6ajdKZE5vQkRGZ1ZsY3ltZXNEYmhVSmJaRnlQbHRvQzhlTU1uZVVt?=
 =?utf-8?B?Mk8rcElzR1NhN2M0MEZ1bnA3T3FTa0VIbDNINjNCYTZVOERwS1JwRk9iUTl0?=
 =?utf-8?B?cVhuVlNqL1hKeUUzQnVYMlhEQkg4ZFJ3TFFDMmZRVXpNTUVxY0hxNy8xY0xq?=
 =?utf-8?B?KzNTaHNnQjVDT2k1ek1IKzN2V3Byc2s5aFFhd3VXZWUvNzhvdXNmMnJ6RFdH?=
 =?utf-8?B?TmtZczdKY3pkdjZHY2dYU08yMzlRVnRDTVJrRDVWNTE4YjZ6TWo3bmE0TSsr?=
 =?utf-8?B?OXJib293WmlGZUM4QzZRWGk0b3lyUWJqbFNrRmp3cFNRSUh6S3RKSUZ3V0VR?=
 =?utf-8?B?VExqUjd2UjVOWU1zUXkxODhoUnMveWNUbkJtVEk1bVJvamliR1ptSGVZeXJa?=
 =?utf-8?B?dzFIcUovdDJSTllVRHFBNWx3YldIZkM5TTJZVTg1VWl6NGdrT2RITkZwSnNC?=
 =?utf-8?B?aE10bURhbWc2MU9vd3ZkTGVMSzlNdnl4MW96MTYxMzB4ZEExc1E5czF4Vlcr?=
 =?utf-8?B?NWZzYjhwMHVGeUZpcnRDWXNONXRsNFZndjZRRlNreHdQTFZZSlBGMUtwK1o2?=
 =?utf-8?B?dU1oQmU5dkFvRUlaWld5NUJuYmZWMFBqd2Uwc0ZTWDVXU3ZPZExWYUtSaGpq?=
 =?utf-8?B?K0ZDaXpoMkF0eWFGcExGSkw0clVMc2h1Rys4NGZ3WUZFdWkvQ0Y2N0FWVVVJ?=
 =?utf-8?B?SUJFZlBGenNEbndFd3lMZ25CakpSbDVoY0UrTVpZMUdsdXdOWkdGcUgydkli?=
 =?utf-8?B?QVBkdzBZUktYaDY5YjU0eFhDell5OXJXQml0VkY1ekN2aGhLaXVvcnBqbWJ3?=
 =?utf-8?B?UW5NcGpmZ2dUUEVqenpmbzJMNzhqYys0b1JPdU1KdkFjcVZwdzNQNHFnTTdY?=
 =?utf-8?B?cWxKZUErYVFVOFhmMFY5ekYyaVByeERqYXJqc3lyZTBCUVJwZFBKcXpocTBt?=
 =?utf-8?B?aUg3a0RzQWd0R2wvY3RVa01rYm5td1B2QWJPRktyc3Q0ZDhyY0lwaHFDRE1r?=
 =?utf-8?B?VkQ5L1B1M1llZlhZZmppZTFWdmM0TzcwZnhXaTc2czhuY1ZPVzNVeGEzNmRy?=
 =?utf-8?B?WHBYVzZzcWxzS2pNZWVJcVQ0OXdjMzg2VWx6VnlJL3JCVmJGSndYUG9rOG0z?=
 =?utf-8?B?bWtQOTFVNE1ZRmVmTDBCcmRqZ2lHVkZKRzd6bmFYbStFTkR0aUkycE50aytw?=
 =?utf-8?B?K1B1Z3JHME9CSzg2enoxRng0Y2dNQ3hYaTVCQmkxRlRidjdMb1BpSVNmUUR1?=
 =?utf-8?B?Vkl6LzNTa0hJRkoyVXhYdWJ0MnhGQ3NHdFlBVDl0cWtJWW5Vd2xqV0pvd0c3?=
 =?utf-8?Q?Tn8VHDnM4VAPDeKkZNE2uKADi?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df57b057-61cc-46de-8102-08de0b2929dc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 13:54:15.9023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhBodobkT7LCV3LYEYoU8bT9sTi4e4aS7FdPjGnNy5nS+3q/Z27gF+y+D70YoW/Hrkt0pSYy926LGxzQkiVSCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6563
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Oct 2025 13:54:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20174

On 14.10.25 15:18, Jan Kiszka wrote:
> On 14.10.25 12:45, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>> Hi Quirin & Jan, 
>>
>>> So, this is apparently no longer an infrastructure topic, it's a test case thing. Next question would be if anything related changed recently, possibly in the shadow of our general lava issues?
>>
>> We checked the LAVA lab for M-COM IEC test execution details. Last time, the test case completed (without timeout issue) successfully on Sept 22nd [1] after that all IEC tests which are submitted on M-COM are incomplete (timeout issue).  
>> There is no test code change after May 27th[2] so I am wondering what is the cause of the issue. 
>>
> 
> We updated the kernel afterwards e.g. Also some Debian package update
> could have brought a relevant change.
> 
>> Additionally, today we tried running IEC tests on local M-COM device (booted from eMMC) and found that all the IEC tests are pass, taking around 79 mins and 99 mins to complete (for 2 iterations). 
> 
> Ok, but that was the eMMC, not the USB-attached emulated disk.
> 
>> As pointed out by Quirin, we checked the CR1.9 tests and observed that the CR1.9 related tests are taking more time compared to other tests, 
>>
>> TC_CR1.9_1+pass+758
>> TC_CR1.9_2+pass+554
>> TC_CR1.9_3+pass+391
>> TC_CR1.9_4+pass+642
>> TC_CR1.9_5+pass+712
>> TC_CR1.9_6+pass+1
>>
>> +758 --> This is the time taken to execute the test in seconds. If we combine these values the CR1.9 itself taking around 50mins. 
> 
> So, the other tests, which are slower because of the emulated disk, plus
> the very slow CR1.9 tests kick us over the edge.
> 
>>  On the other hand, QEMU amd64 completes the same tests in less than 2mins, 
>>
>> TC_CR1.9_1+pass+19
>> TC_CR1.9_2+pass+31
>> TC_CR1.9_3+pass+17
>> TC_CR1.9_4+pass+9
>> TC_CR1.9_5+pass+24
>> TC_CR1.9_6+pass+1
>>
>> The CR1.9 is requirement to verify "Strength of public key-based authentication". As part of these tests it generates the CA keys, User keys and certificates using ssh-keygen command. we think that this command might be taking more time on M-COM, need to check more details on this part.  
> 
> This is indeed strange. We should be running the same kernel, so should
> have access to the very same set of accelerator drivers - if they play a
> role here.
> 
> But maybe you could try out if a stock Debian kernel performs better
> here when using the otherwise identical image.
> 

FWIW:
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/2098796623

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756C0C531D0
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 14:43:43 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.13])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32910.1785163421590387951
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 07:43:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AkZvP3zu;
 spf=pass (domain: siemens.com, ip: 40.107.162.13, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/LbJZBF3DG/Ia/GhNlbMXCqXpJuNbnNvwvTbVacVSccleH06vqmcpFqYlUVQ0rLLjNir0s43EHOGdXRKzjsg7gRV9ktWeDNZiBSByL0q6tA54nOPq0TeZG0Mtz60L5V24GjsQK9hU1Tgrg0MbAItkTPLEE5+0e4QMORpNPFOMnneG0qVZMmssK5uO38rNWSxDih+dYkKqqdn7NBpRraOx8fMjv4Z5jD4VctozbKouHJ8v/dyLIlTS2T1h2vkSYDIyUBB+kZyIc24wJh63MmA04v/UWMHkQPcyxiYeAP4LsTblJn0leT13Pr3cR0EJb9Bib7sS/hxr+1G58mCt8oTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yyz+pVLTkrb6G9m7b6ipdINzilt8rEF8OQBMc36F3fk=;
 b=LViSNw85ubuveZ5+7OzieXxZb0RgKQUiVa9nFJSWDO+XRZlJroZvDQEEXg3eNDwElHKUDWlJneFc4v85yKiopMkLtRfU+8/iQn2o8iqYof3H5NbtrQdq7zzeFB3D40ds/qUHQm7S7O9LkUIFG/eAlDoZpqEC3n1Jdq1oIQ/s6b52S5poXn8wnxEpc8H1hN3Txia3v5NE8Gi7DD86t/qHY7s0e6WjPnyqXLh6FBt6CfrRvY8DfcjShQpe/0WUsSz9TpMCFDbODeERROYTivGZQPMDxoWG89IdBVCt4a9/B5Tb0NegIprRh7LITtLM9odD+cqL9IvfG0raMhk5DFpg1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yyz+pVLTkrb6G9m7b6ipdINzilt8rEF8OQBMc36F3fk=;
 b=AkZvP3zue4JK2Be7p6bBuIl7K2oP0JpkUGAEISxw9CdfXHpI1PF40tU6/obhNO8fOC0+rZsFCDJ7LJ8BxBDrTxWY5BeIoQj7bKPW5r/u9vMXnnNXXgp5IkDCfScGDJPphR0QvOcWiFnw5RIjaBwV+v663LyMBClBxHU4eIPcvWv5vY9iml9Bk5G3cwpGmHoNsvNWkBpnbPH/1vOr+J/LGUPr16OWfanl928kgV4Kx30zQfzzfDgFD5cvLwWEHzKn0wi68PqApUHLKP7RwtlZLF5mWbpmuQV/P0Oq2E1aCt8BOLxWNY5eJ++egbnyyBiiLNSTTphN4RIUah4NImgt2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9144.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 14:43:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 14:43:36 +0000
Message-ID: <9412e3a7-1969-41db-9ccf-703d79b259c6@siemens.com>
Date: Mon, 27 Jul 2026 16:43:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 11/14] layer.conf: use
 variables to control path of hardening config
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 christoph.steiger@siemens.com, clara.kowalsky@siemens.com
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
 <20260724124945.3636668-1-Quirin.Gylstorff@siemens.com>
 <20260724124945.3636668-2-Quirin.Gylstorff@siemens.com>
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
In-Reply-To: <20260724124945.3636668-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e23a8de-9ba6-4aac-6cd6-08deebed70bd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|4143699003|10067099003|11063799006|6133799003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	i7YHDSkfCo32jL+8v0ex2YHKNPU70z4IkTdUVRz+lAHPgQQkFVcVVWo3cFZNsmbZLcsu1RnrFcyhwX+mFtTiUNScduJ2zdobTDPoa6njQTNPkpF2IYuF/oc4X8lYrxlbqL6XL68XTLEWFB2fuDrp2FSElB002ISSAyQaPJVBtnNu41GO33r3fNumKYRjbS4CX6ZVWTE8MfCl/l2DSq7YZBatUK/YED9UmqfUlw6QJrTKYv0Nl2zN3DtaJk22LShVxRARp/N9Pl0ShMjejqETtGST/S3fR/OKgn2Yu/qvWLuoQ75h8+MFpnSpcttSDc7JiD9ZSiVR4gsnFvhpavqZkNQns/SEXAuSiVdjIkaqvxA6M9AMxgSs6vXWt8JqpY/ZPNg/gAwnyMQXeG2cz4dNIPLh+1vHRi30yXwak0eFM/p2sQKQh97k3yQQ04gw7PnyfLLFEu3v6euH72VfgzuOecmAaX4YYqj76y/p9ucai1+Yae4bHemxFYXteAOWQeu1i46q+gF/7GXRsdEmhHZLAIK8V1OQc2222G8LYrUgFBzLVv+XHXU1G57Qo25i+gzH1Xrwz9XvpES5OMKy6H57lx8niih5hIwgjfDnYc6whDkjFO5+GLiSXeN23hCzxIjmUAKQb2TRlKE8Rcum+t8vJ6tWhvw7qCDaEOmogGAyZU4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(10067099003)(11063799006)(6133799003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YTU1MUFUbHpNZ2Jmc3B3Wm9ZT2k4WEdwL20renBTblBkTUV6c212TThzVGJR?=
 =?utf-8?B?Q1BCNjFEUGl4WWV6MGNNK0p6TEQ1bU1MalpyblpZc0krbThxVm1DNVI4Y1Jv?=
 =?utf-8?B?WHVGV3QyckVhSzRVY3dnQ2I3LzQzS1dBR0xoVHNJNndlcGNlQmhuN0tWaXgw?=
 =?utf-8?B?VXNSSytUN204WTB4WXpaMU9XU2Vsc0xaZ3ZubFFNbVJySVFFRkNvRjFJWjBq?=
 =?utf-8?B?bmYyenVLaGJGaWJKMnNTSXlsYUsvZ29HSitCNmdkeUpuZE94czNHbWVPWHc4?=
 =?utf-8?B?dVJJc21QcEJ5anV1TEZtZ3NuWW1HS2JnejFkMERJNUlBUkMzWTR6akppakxE?=
 =?utf-8?B?emJabXZCd1hwMkFzWTQwVTVoVEl4VWlNeEM0ZCtPWS8xVkt0ZmlscDAxNmdY?=
 =?utf-8?B?aFNPeVlZY0krbjN0NXRTRk5vZWdJQXMyZkxxZlZWdWgrTi9pbGRMN2s3UzY2?=
 =?utf-8?B?RjVORTFIWVl3MkVIK0ZlaUlFNmRhRm9STFVUa3U1NUhkSFlTWlRzTU5vN1VB?=
 =?utf-8?B?YWFPeWJubjErVjlEc293d3dKbG8rTWpjRjc3R3hGd215b211T2RwK21CWG9F?=
 =?utf-8?B?T3diSVFISTUzRnJUUWFiL25YaFRQWnZ6YW9PMnNJZGw0SEdvSGp4THg0RzFt?=
 =?utf-8?B?bXJIYUlRYm0xOEdNaittUmNSYjAvc2pMbGJuOUV1LzdydTh1cTl1YnJ0TVhC?=
 =?utf-8?B?ODdXbkNyS2pqd2N0a28vQzNSS2RBN2ZuUjFmSXhyTnh1NVBDYmw4V0M5TjJ4?=
 =?utf-8?B?bFNidjJGUTdaSUNiT2pPakhKcjFIWVZlaGcyWmlLb3haZGlwK2J6UTZ1d1lw?=
 =?utf-8?B?YUUwYzUyeE14NHdXWnFsNmptRTJGOEpSQXYrMTl4NVhuaHVIc1pDUmppSzRw?=
 =?utf-8?B?UTdaQ0F2VXFXSmZ5ZzVzUFlHd0l5VUpJYkFlYXJZdEtYN09sMDhzeGlYdits?=
 =?utf-8?B?aXNTRDRMY0hXNGZJRFZ2Skt1UUhzMU1NYnBiREJMRVFUSjBKWVVxcHo4OEtL?=
 =?utf-8?B?ekhBWWVITVo3S243MGdDN0xLaXhHbTFzVUVFWlVEMUVMV2tBSVE4a0JnVGpR?=
 =?utf-8?B?WTYrQVdRTzNyZWEyWEVKS3AvM2RPSVVrVXFETG5HWnFwMklLdWtWSVVRalp4?=
 =?utf-8?B?SkNpZVZ6VE9hd3Z1K1lqOUZ1WS9zaTNGdWMvVnVwZU5TRU1xSm1oNVI3cll4?=
 =?utf-8?B?bmpab1hPYnFrOFpiaW5xS21ZNWIzSW1aN3RId2tYd0NidE9vMllXV0UvS0p5?=
 =?utf-8?B?N2d2Y05mNjVEMHBTSmFJUWMxdWMySU5TZWpIYWtJQ1V4cmEybXN2dFgwS2ZL?=
 =?utf-8?B?RlEyeURDUnZhT2dYeGdUMHZEVGFGK1YzbklSdHhQeXo2ZWYvMWZ0c285Ym1Z?=
 =?utf-8?B?bTIwckdkTjJDMElUNHRyMWprS0tEVWJZaEF0N0VZTW1NdXNDeXN0a0ErZnFl?=
 =?utf-8?B?TTRXY3VXZkVOM3AxeVZ0MlVXUDIwb2RuSEFCUkpOQzR1eDhZSE9VUC9TTFFE?=
 =?utf-8?B?VWtrb2hSaTlCZjdDUFg5aHpnSkplQkE3U1AvdTlGVThmblpReE9QMHo0VnBI?=
 =?utf-8?B?R2VSUHdSZTJPNEFWb3BMbk55V3lkZmltV1BSdUV1WVkybCt4VkZtaHFGWTBj?=
 =?utf-8?B?UXBZSVRSeVNGcjBCemZEZ2xjVXJBSXI3c2NxY2RWTmppMkdCcDFNUVpHRnQ0?=
 =?utf-8?B?MjlZdmIyRlUxVXRDZEtUeDUzN2hiWjMyaUlwSlh1MHJUclh5MEZCRWdLZUc3?=
 =?utf-8?B?T3pxTXJ2STFaelNYYUF5SVhIa2NVVExZcDRxV3N2aWM4RWtCSk9WODZBbTBj?=
 =?utf-8?B?UEpyV1RML0crS3MxSk10bEpQakxJaEQ5cUpZUHJsdUp0NFB6Y0Vidmlud09m?=
 =?utf-8?B?SldOZmd3VkFZdzBVdVR4aVQ1aHVTelhzS1k1ZnZ0OUVsYmhaMmVDMi96aVhF?=
 =?utf-8?B?QndwY3lQalBiWk9BOS9kT2MrOURkRGx0MDZ5NlRhRkU0SU1ldVNjcFFmQjlE?=
 =?utf-8?B?VXY0SjNGdWEwRWpzeWsxVmxRdUY4SFFoeVQreWNVazkzNlVySzFUY2FQeW8y?=
 =?utf-8?B?NW8xaS9Ualh4MnhtMWlwUWtWclNDV1hNWWV6Wlg4SXFkckJnbzJsa2RUSDda?=
 =?utf-8?B?dnFxTnQ2dE9WSThyRjZJRnpTbDVqSmluM05GeFdvKzJvU2VEZmRNeFp4OENq?=
 =?utf-8?B?WVB3YmFLN2h5b3RYUkhmTERIVVBiSEhDbjQ5TklobEZ4aWZOc2xUU01DUjlF?=
 =?utf-8?B?TExtbGtMRHJsSEtkOSsyamQ3M1RXYTU2MkFNNEU4dzFuRVYwVjFKcExOR3FU?=
 =?utf-8?B?ODgrcnMxaHg0Vi95TE1JaEpBaGlOV0Z6NjEvWGZ5NXFqV2JTdkFRdjJnQ2x2?=
 =?utf-8?Q?9YOcW1HsXugbPQCs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e23a8de-9ba6-4aac-6cd6-08deebed70bd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 14:43:36.5881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+GSuOmikPy8NL5R78e3azI5QUZxHhmrUrFO6BLyOFMDXeHpwj3lGVCTEZgqMUffxAWDVDiD8mXJv+eIQr3Fxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9144
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 14:43:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23779

On 24.07.26 14:47, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  conf/layer.conf | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/conf/layer.conf b/conf/layer.conf
> index c51c3af..61e25b2 100644
> --- a/conf/layer.conf
> +++ b/conf/layer.conf
> @@ -23,4 +23,7 @@ LAYERSERIES_COMPAT_cip-core = "next"
>  LAYERDIR_cip-core = "${LAYERDIR}"
>  LAYERDIR_cip-core[vardepvalue] = "isar-cip-core"
>  
> +CIP_CIS_HARDENING_CONFIG ??= "${DISTRO}-hardening.config.json"
> +CIP_CIS_HARDENING_KCONFIG ??= "${DISTRO}-hardening.kernel.cfg"
> +
>  IMAGE_CLASSES += "squashfs erofs verity swupdate delta-update qemu-emmc"

...but that such essential defauls should be set first, before allowing
to enabling things in patch 10 already.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


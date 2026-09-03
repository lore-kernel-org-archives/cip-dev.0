Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4E3C624D4
	for <webhook@archiver.kernel.org>; Thu,  3 Sep 2026 07:36:18 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.62])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2364.1788420971077055800
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2026 00:36:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mzkK6qaK;
 spf=pass (domain: siemens.com, ip: 40.107.162.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhI76X+DcivqYE2p8z6+m2osk56XD4y9Mgd59JilvvQmg4XKKGua8nQt4MlkJNGOW9VXlc3dQgGUCKPBYZ8zY/2c4pRF+9leGuhls/iXM1c49bGYT0vNYBYFXKUEmlQmz1xgzCkJykGWHFk2Uqr8LIEnY7N99HDN9VP8ZChlptJ2o17lq1XxP95t0YM/GgiI4rUb3CQlCHaSlzW47v8wqulCuHo+aaptCUMuG7tN+ya/eKNfGqowaRQ/qBsEKxTvLT92EXYtqoVpBrgWzbScIlvOmTT5JRHG07L7GTve46Ycx4uT6KufFDGWqftxc+mLg3403rAuS21OdSrG8zwXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkGLQtja4pAn/qmWZxaDv3uWqDLme+UiNXKht4Aznx4=;
 b=csAb0LbKxrGkp89YYSvLkHWNDnJohf+rfyBs1beXonTJYwAkABoPGcz54YxlwUitGwnX+FQLvxk9FQrs86Ni2EvC6Wc4cHUzsUJXuKAnGdW1BbkD7MnOuhbwe+zJ9g5hFy/V9yzGiIHWrfiXqpMdNNI9WL5W1f2DEYKwdOpyTrBEnWA5Du/dmEGIoK46lf2C47wUQwZut5Bqw2UgaY/Dltu2EwzlQvsagAikNuhkpxmVLTmIb/IPvsorqD5hgqe81di81RdBbBTfblrtFsQgM+mEb1hOHnNWgjVbnYY1zE8AQ8lY4P6VvYqaaahoQCtKRF3GxrGo7BThX0WWjiGszQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkGLQtja4pAn/qmWZxaDv3uWqDLme+UiNXKht4Aznx4=;
 b=mzkK6qaK79/U0QPdY/3H7ViO9NoxilTGLaLgXNS8eY5Wip6ItUTWyTTzRLomeOqbEL7TjMoQtrdzThNTxMdtKbe19avjSVMGjdKwEsr/Nh4Xqa6g82yUujUE7lyHnpapYDvW5NqT3Vi41ianJpJwej9Gj2vxDTCb/YFH04KpjkwDaOp+ht/dtbIKs7F6DmmZxyB7So9XemaXrl0B9t3Yb8zQUdxqaEVAzYmyq6vVLXC01t/x1uAVVXPYv/ARPDgOZT+zYccn559CnhcdiwwHyIk08x4s81H2cEYUCBZ2q03Z2ouRxP5nURGADS7jbbjok8ZrANgVWQBF3OYsbL+30g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6269.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 07:36:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 07:36:06 +0000
Message-ID: <85ce52ff-95db-4a55-a8aa-487a30348833@siemens.com>
Date: Thu, 3 Sep 2026 09:36:04 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: fd16ef2c-45c5-401e-1b6a-08df098e03a7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|55112099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	U6lzl9EK9lIkhJK0Ip5dpP2OBnOlIIACloFA6kHIOqxzsY4hfI/+dAqfkrSOy0smI9FoAJFOdLi1Iws+f16hFQhZ9pfpjPV6uEouEM+7Gn3O2tLgL3ELYYoDCHGhvvrx1BYYbwpWqXVYUpAT8rvU+gg0+tA/yxTHjzQZBaD5RswOmSxhB3ESq9AOA5QLX46Bfgc5fJ2tJ3c+G2CzBAcLwIGH8yDkylwnHZI7OF9YL0I58DeBNUjBY8zPyx7naBxk5BwujuyN89wWUFQ2M1Qlm7EIMWPlqRBs8IjqfJbWdYGSjGlrGL0FZJTdrnXr5JKPT1QHNedQpwxqrB1ybyAYTCfkBbSTSutSaJmJY5LmjCd+LlRBpQP7oO7Lm7F7Y3VLIHiFp8Y/4Q07KftzZUTWF7lNOusyZheWmOHS7r3kXVZak3R8++0/I8K0poFOy8uy/hnJCSevjh2GxHir4hWlTHNDE0EP4ltFEoBaF1hvAs/Bz2ck1WT6Hxoiavo0rU+fYPiWmrohYDXml29AxmLC3oJS6ZL02RgXHCoKhc1QHpwNbNrvnQ93Ajs7OvPeydak/iZ3Adevku3iB3KDvDTfd8K8zq8Gvlxk6wPvEMqw0H8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(55112099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cTV3V1MrZHk3YVlQeDRFc2hGcXVHTG1uSFVzYWtzdnFJV2RmeDZrTGFOeTA1?=
 =?utf-8?B?NkNzVDF2ZHdSeUppNVhyVm1wdmlyeFJJWHU3eCtNbkZad2szdkJRZUZVQnNj?=
 =?utf-8?B?eXlRcDNBNmNwNDBZL3k4bHFaRFJYNVBwcUc5cXBLZjdnRjFLUEMyTFhYTjhx?=
 =?utf-8?B?QlNza2VrQkEralUrR2ErSFBoclJZL3ptUDJ3bElJdWhuakxqV2VTcEVzeURE?=
 =?utf-8?B?V3BjTTAyZFFTZ0dYYSs5aGpQdWVzV1ZqV2N3eHk0OGQyUEE5MEwyQ3FkRUJ5?=
 =?utf-8?B?L3dlSFdVc3ZpckthdVd0a3UrczNCSWM3YlpvVzBkTW5jSWZxZXZ1Ync0SjFZ?=
 =?utf-8?B?MFlQdWhoRjMremlxbFh4eHd1eE9oeVZrVXVaU3VtQkV5V0lMRWkvNnNCRzFG?=
 =?utf-8?B?NElnS0FqQ2dnSTB5K3VQSmNQYmw4bzg3Tkora3FzNi8zazVHNnZodFB5cUlJ?=
 =?utf-8?B?R2p0U2JHL0JkbVNsU1ZtamJBamkrbGVxOWs1ZHhWR0ZmUDBXSm5IZTAzMG5R?=
 =?utf-8?B?Qmw1aEZLMVVHd2NyRUJLZGxHWnR2NUxWNWdIRk83SjVwM3NyQ3RFWlY1dVNo?=
 =?utf-8?B?RmZKM2tGYnJPOWlRRktvMzF5OFBQTUU2YlRVOWErNnBBejY2U2owMi9laDY4?=
 =?utf-8?B?ZWoxckk0bHYrUU8rRG83TGZ6QWszcktkVW5JWmNOOWJYMmt3RUx1WXI3QWNv?=
 =?utf-8?B?T3BQbWQ4aFpLYVhjcmRyZW9JdUZmTGx6TGp5bTJ5Mm1aVmdFZk5KU2R3OURD?=
 =?utf-8?B?UG1PZ1pJbFprS1NEeUlBbjQ0SUxWK2JVOUxZTW10dWhLdlk0cHVPaUFZK2p4?=
 =?utf-8?B?dGpQMHRNbEs3WkovT0tma1l6YTZxMVpWVGRlWFZId292anJaOFVxQ3RVQUlO?=
 =?utf-8?B?UUxVVDYydVF1cGVjL2pWYjIrU2xnQnRwRDQrZHE0bXpoaUZMcHNyQmdsSTA5?=
 =?utf-8?B?KzFuS2ZPMUdZOTlLc0t0WUhWaU1yRHlDaGtZeE01Smw1MkxLc0FEeEljTlFU?=
 =?utf-8?B?UXNka1U0V0xtTk9KNE4zSiswaU9Sdjh0OFVaRHlZK0d4R3Y4NXo5NnRtTDJz?=
 =?utf-8?B?OEI4ZmwwekVjaitlN2dnN2EvNGFUOHg1RFppVTRaMHVaM0hnYlh4blFOekFk?=
 =?utf-8?B?R1dmYmgwaWJpUHBDd3ZMcGFuNmpLc09SUXhCUVZzTEFETDFveDJYRTdrVWJ4?=
 =?utf-8?B?Z1dob2JXL0RORzRKVUhSeTVKRnZMVHhUejhVTWNSaEZ0c1dPS1RFR1IvY2tz?=
 =?utf-8?B?S0wvYXdQdlVjQmNRVVRkWkdCUXFYZ01iZnUvM1JsNG0yVkttSXUyMCt1eEhD?=
 =?utf-8?B?V0UyT2xpamR1M3pURktwWERmN1JxZFhnYlVCYzBQakVoK09hMVdiYXVSRkZs?=
 =?utf-8?B?eTdsSW5lQnl1QVhsNFNhMit0bUxNY1NnUUdiZWtsa3Q2RWkzUEN3eTN1eTdG?=
 =?utf-8?B?ZjJwT0FMMy9uREN2UDViUTVyNllubnV4TVdFYzR5YWtPNERlbUJsWHo3YzhV?=
 =?utf-8?B?ZnhzL1R3bXhlR1lBNlNmbGE1dk1aMGpYMVk5SktyMXhXdnVSUnVoQ2p1aVVl?=
 =?utf-8?B?OEc3NWNjMzFEbTh4WEhhNWJPdnpOUzhCc1ZwZm9mRFk2TlpaaGY2NHFYMXUr?=
 =?utf-8?B?eWhqZUNUU01JYkpqWGprT3Q5bzRBME85UGtPeE5aT3NtNUZyc3lubGJyU1N1?=
 =?utf-8?B?aTlSQlV4VVBoYm5mbkJBKy9PajVrQllGNHpZaExXWisrcEYzYktHN1B6RUg3?=
 =?utf-8?B?eXZVbUt4U2premY3cmJINlZRMVUrRGs3Rk5zb29RS1pkMGMveTZQZk9ITFhS?=
 =?utf-8?B?bjRkRGdsNnYzM0RTdUpHWm9EdU8zRjBLc3RHdWc2WlZ3ZkU2SXdKZUd3dHk1?=
 =?utf-8?B?RUFkNVBwZldJL2J2QVIwaU1KRDNDc2xwcUdBNEpDNHpENThCaFhHZVBiSkhN?=
 =?utf-8?B?Q0h2RlVhUFRMVHZSM2Z6VTZwOGFSNzlUd3Z0OVJjdjEyK2VzRWU2eWdpYzVj?=
 =?utf-8?B?d1MycXlrb291Q1lHbEY4MXVVdUVBNVZPaDNUU3g3QTkwdUg1ejd6OS9PQmk1?=
 =?utf-8?B?eEQvQWpaQzdHa0FFNDJ3S2VSaDNNeHdRU01yeGNwdUFwRjJaMU9lZTZQb0Vl?=
 =?utf-8?B?R1IvYWFGYVNaZnk4KzhCdExBU2ZZc3JTZHV4S09FYTBpZkdyQ0VGSDhUVDdy?=
 =?utf-8?B?NU9rNE5wVThGOTV5NGdEUXJMd2E4QVBmdmJNaWJ6YlpkUlEzaWFFcCttK0ZN?=
 =?utf-8?B?eTVUWm5oRnFGQjFIRnpxRmVyTFVtelJqemNlQzNleGhuWUpIbnhEYUJiQnVT?=
 =?utf-8?B?TTNLVGJIZTZmbklPZFN1YS9RTlduQUdBS1JZTnU1SlV4dGJtVjZWZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd16ef2c-45c5-401e-1b6a-08df098e03a7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 07:36:06.6315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvSbClgudG/A5bR4Uc6tLmoMKJPWf29xif5aoHI4Mx7hzyKZt83Tx4JGNW0P8/6oqTZZ77vRtBPbX6YT2PMzag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6269
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Sep 2026 07:36:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24085

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=9&day=3&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/08/cip.2026-08-27-12.00.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - LLM review tool: updates, feedback

Jan

[*]
Date the data is created: Thu Sep  3 07:03:00 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version: v4.4.302-cip114
  latest version release date: Wed Aug 19 08:54:45 AM UTC 2026
  limit date: Fri Sep 18 08:54:45 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version: v4.4.302-cip113-rt62
  latest version release date: Thu Jul 30 09:07:13 AM UTC 2026
  limit date: Mon Sep 28 09:07:13 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version: v4.19.325-cip135
  latest version release date: Tue Aug  4 12:34:28 PM UTC 2026
  limit date: Thu Sep  3 12:34:28 PM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version: v4.19.325-cip134-rt49
  latest version release date: Wed Jul 22 07:47:57 PM UTC 2026
  limit date: Sun Sep 20 07:47:57 PM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version: v5.10.263-cip76
  latest version release date: Fri Aug  7 04:22:30 AM UTC 2026
  limit date: Sun Sep  6 04:22:30 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version: v5.10.260-cip75-rt33
  latest version release date: Mon Jul 13 07:40:40 AM UTC 2026
  limit date: Fri Sep 11 07:40:40 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version: v6.1.182-cip59
  latest version release date: Fri Aug  7 08:15:19 AM UTC 2026
  limit date: Sun Sep  6 08:15:19 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version: v6.1.182-cip59-rt31
  latest version release date: Wed Aug 19 06:16:01 PM UTC 2026
  limit date: Sun Oct 18 06:16:01 PM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version: v6.12.104-cip30
  latest version release date: Fri Aug 21 08:39:20 AM UTC 2026
  limit date: Sat Sep  5 08:39:20 AM UTC 2026
  Status: On track


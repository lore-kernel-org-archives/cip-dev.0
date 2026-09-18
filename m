Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B17C982D6
	for <webhook@archiver.kernel.org>; Fri, 18 Sep 2026 11:01:17 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.7])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8516.1789729273213367449
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Sep 2026 04:01:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tSLuc1O5;
 spf=pass (domain: siemens.com, ip: 40.107.130.7, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoHzn3cdLQSbqRrjAOGgEw0MBPIRZMAUjNLv6YhCmSspJWffEm6mXsZfqo/sdkKBsB6xVXtT7oA/KDgrasZni3YHb7oK8n3cLWn/5aNktKvm/0rpIf2x8OJ+2iV4WWHNbFN2NcWDnDX87j+sK+phhD2ZT5uc14ZOdunXR8LjFqXd5O+wBg/0Jek5u8w1PpEd4jXkKpklVFV1zWjSKxh3HNUrdfX/Hzk1peSlXQmpglh8hSybh5Ht3SlM9QEJqvEjt3X6swJql+lgdsBt6Z0yZ2dQXGP/q+0CexrfqvodqKLIeNNgSHLsMa7ICOKEda0WdelFT+g9jcOVxfxyJhwwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdIoD7J247j0mQijfu8/2IJayoIA4OUEvZYuzLRNWPg=;
 b=k3oN/fQmHh7Lw2Fw5hkIS2ymxof6Uf5fw1NxJ5fz0rzHl5ggQ907MGRZJAN5tg3cEpgbvQHETPoWY/XjVNk8gw/fqoHWrXOYJPtQEDCeZE5o/mf8bN2/G05Ic/na+dx6d5ERwMEPBVUlVvCFaqiL5wC2AGQJVJTIKBwk/c0xXCG88s8Cpm9eK89oUDFnCLb7C5BGbI5zX8RssHFz2FRkfolUGI130B0hIr3IHjqj0GT8y3jPoOztm7/vZupxahTIMuWpdpLFjQRo7TLl77dBoiAdqx2QIUJPBx6J0eZqAG7xKcyborV3bIcM/9+wsh0qHt/g93SVhd/jg2LISD4qtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdIoD7J247j0mQijfu8/2IJayoIA4OUEvZYuzLRNWPg=;
 b=tSLuc1O51HHjb/FQe16kMfQS/mC8AUGOjXvyAGu8WSa8rrToUpLF6TjT/+SSSPy3OmtaKkJNpthZuYpWc+t4sch9N0djrjfbxagZ0ahsgcVpQy0o4U0cdPW1RrjTep+Y6IkEj54CynO5MyCVPE5ggc1jEv9+mO5/a/0BXAiY5XqYwD1lElMebyrg2F2GA3ielFg0sien7gpmbNRYNs+dhaTvaA2NIQ2UYx2AxLB0QeSZFA3glHfyu3VPLLpeAWQB28T/gBgUDJe/vvfJZ6gYpvYeejGb8ClnQryjVI2S6qHRdGPcMyAbA3vLGYqrucl4j/6vx+dcmIcAzdw+S4qjcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6112.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:584::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 11:01:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 11:01:08 +0000
Message-ID: <868cc7cb-d990-42a9-a759-05f7cfc22e36@siemens.com>
Date: Fri, 18 Sep 2026 13:01:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH] Fix file timestamps are not
 reproducible for EFI certificates
To: "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 Kunijadar Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "kazuhiro.hayashi.f74@mail.toshiba" <kazuhiro.hayashi.f74@mail.toshiba>,
 "kumar.dinesh.h95@mail.toshiba" <kumar.dinesh.h95@mail.toshiba>
References: <20260918085031.2464429-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <88b6f524427c6415422dc6dba589b4cafb4cd439.camel@siemens.com>
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
In-Reply-To: <88b6f524427c6415422dc6dba589b4cafb4cd439.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: 0163701a-f40b-4632-ab17-08df15742483
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|4143699003|6133799003|11063799006|56012099006|22082099003|55112099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	ua5tIWLc+SWXzyhwrfIW7DsD0G1x55Se/oSRidysjIjOs1vr+wV6f9J1l8Fn6r/SYaNw9YIb1jmaE77E//6PC7j6MYtwwnfyuGYml/ot8xmFUuGPhGVejnk4CVAO8SJik9xKkZ+nHHDszamTex9MVeRL1n74jF7b/B4lmWsOzUnFfZiczbRY0gjFX0lG/B0ajCZ8kYTFUctnZIrNdpKmeYNm+nhylD6PhrX6qMoQA63qul+cd1uW+ccIEbGrDd1+WAErBQxZOVZDkP5cgl3p1uvvur06mbI3gf/LbvcNMNcUbzcgjyCd6W8FUqGLhlCjAevoOagWlpouId1jK3mLyFJc4+6HoNzHmrQYpZIVC1O0tKxO8geA2QxQdP6Mfwrhc/M/4Pcl6HTrtPt07Y6bHRFWTn229oMPWaGMzP+RVooUhQyt+NEsdNro7VoDJdDFx8/122yDn20eKjiPpWeB8H3Phr5RFpaHAtUf/dHS2sOHyXUZTpV5llks+7vEY46pbY8VUDe2TOjeMjDi2UpQTS7vvN5t2ejH7Kt6PWKsO5Lub7m41Y+tN1v0kVHUIzuDsNXqSYhoixDzL7eVmiLs03uVsP9QPqLlBqYQhhyWmO0UkWTgY9T1yV5fTOSkTjWHCZucRjbxHDdsz1YbBjrgPLAFhW8BtprH3Vvr/ylZySQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(6133799003)(11063799006)(56012099006)(22082099003)(55112099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RmRQRVF5S1YwTTg4N0t6OXhzbkN5U3JSbUxJMHR4aG8zMGt6a05vSHljMlE4?=
 =?utf-8?B?dmc4RFB1TEoyd3hwbGNXak12ZVFURW42OGdwRyswVUdhMVlvcExEeDhoSFg4?=
 =?utf-8?B?NkZhWWYxK0xUN0ZLNVRPSU1LZk9IdWpjMmZtSnppeFVyVndDUWFLejJHRHc0?=
 =?utf-8?B?NUpGRWUzQ1JtWU5YQlVTTzQrQUQ5aTZLYUV4V3RCS05ISjlLY0pEWnNVaVB1?=
 =?utf-8?B?c0U5U09uN21XYUtFT2Y1eHFzMm9nSEZSYzgwTFpNTGpzWm1lOS9rSWQ2dTNt?=
 =?utf-8?B?djF0SUZSblIxaTBvU3JMbmVjM1hVWlV1NXNubHh3UnpCRXhNMUhaZllBcUtT?=
 =?utf-8?B?MWN2eFVsaU9jL0FaZVNaOVc5TGxmQWxjN3JURGY4Z2xmVjlmVVp1NjRXMVhM?=
 =?utf-8?B?eG9iQUNUU1k0M2xtdkR4NVc4VGxua3NlUzRQZXFheXVwODkrOUF1ODEvSkxT?=
 =?utf-8?B?bFVuNzRIcUgrMzJ1ZC9wT1pLQkpDVzhOa0djYmcySjNIbzZoU2lRV0w2V2Y0?=
 =?utf-8?B?c0l1T0ZCbWxUWjRaVG1qaitrYW5BK0d6V0ExQ2tDL214bGdxa3F5UXgxS1hn?=
 =?utf-8?B?Nm1nRklpVUhkVWhLakdZV1I2TlhUUHV6RWJFWUI3VjBJVy92RENwMEpRV1Bs?=
 =?utf-8?B?VEUxcTdrdC9hWkpBaE5CcG5nL3RMalRmaUN3REFYM0NIdFpOUkJwaE1WR3h3?=
 =?utf-8?B?Mi9PVnJFYUovcWpkemZHOFZlV3BqenlwOElPRDF6aTR1MmpqRzNkWlN2WWcz?=
 =?utf-8?B?UnZpK0pkdjFBMlhsZGxUa2twaUV3Q2FPeFRmdjdwcWxZUjNpa0phaHVuOGpw?=
 =?utf-8?B?a1djWWUvY3VoVENNMW0wYjhROVBhcnRmMjdmSW5LWE5BNnljNWJRa1hXR1p0?=
 =?utf-8?B?aHVET3JPU3BvVjZRQkV4aUM4VjEzY0k3V3RxN1BpbmJmY0hDQ1VOak9hOXA0?=
 =?utf-8?B?elhpWFEvOWd5bFdiVDJSUmgrN3duSjVuMHk4aFhzdit1YkdhQU94c0xOamdU?=
 =?utf-8?B?UWpGalUyb3o4bklHTXB6UVJ0dnhlSnkvemRUdjhjL1hoQ2xuMW1YaVJOdkFT?=
 =?utf-8?B?SlB4WWdNa1h0U2t1MTYvTDFibGdpL2Vwd0ZRTmxHZmRSVlZUZ3BnaTl4Y1FE?=
 =?utf-8?B?QytOdXgzL1VXZ0FLeGVrOVVsK1dUOWovSGhVM0JEQU5aWVNNUmtEdjhPZkJy?=
 =?utf-8?B?TENUOWx0YjMzQkYzQ0tqVXBIYlUycHAreWlZN1VwSmpya3pnLzJWUUNoekdr?=
 =?utf-8?B?dlViUUQ4bjhTanZESjV1TXJkNm9Db1BTU1ZMSzNHSnZFRFY0a2FqMkJOM3g1?=
 =?utf-8?B?MDhHZE9wZXQ5cDZHRnZ3UTlacXlPSUNkRk1XcjV6dUR5VFJpOHFjaUFDSjMz?=
 =?utf-8?B?eHFhaXVPUzJxMEtYeUFVclV5QW96M0UrN0hRc2tsdWE4a21SV0ZESGoyYkhE?=
 =?utf-8?B?ajZQOGJ3N2JrazNaNklML1V0c3p6WEwybHJpT3psaDk0bXN3Slo1NGhhZkd6?=
 =?utf-8?B?SlY3dVQrNFFDZS9jeWE5SklXSzNaempYdVM1SnpWNVFLb1htUDlOQVpBYUY0?=
 =?utf-8?B?eVdaR2xGNUZBdjY0RkpNUVA0NGtnTGt2ZDEvcVB3SUtOL2lkemRsanh2SElI?=
 =?utf-8?B?YWJJZzg0LzI1RFROaWUvNEMzL2lYdjhpZXpLSDdXNkNHeVNmaHYzSTU4cG5q?=
 =?utf-8?B?MjVZOTcvcWE1V1VLZjQ2WERnNkpONEJtMk1VUk9oNjBUUng4Z0ZJTW13NG1H?=
 =?utf-8?B?QWxBNlpHOWFSQndsc0lBNGJhdDhZVWxuSGpxejYwSFJOeGdIKy9DZ3BzL1Zu?=
 =?utf-8?B?aXJZMXdSbUt4WE9tTlViYVJDWjVhdFQrb1N2ZU5VSXdQa2pIaVhabXJVcnJW?=
 =?utf-8?B?V1lTUkI3VnNwNEM4ajBqZHBRMVZmWWhvQmsvMTllc3BDOFp3bnhOdytVQjcr?=
 =?utf-8?B?VkhmaG15aUhDdGs2UU9rTGRyR1BMMXh6d21TVmN2RnlHZ2VPcWlOMDNzTkk5?=
 =?utf-8?B?aFJyNFpJUm5VSWRsYUY2TnJOajE2TFJXRWFQd3YrM1E4anI5RVhTMWRXUCtC?=
 =?utf-8?B?bVR0b09KMkd0ZVl0UDNnNGhTVmR1TmcvbmJPMkZGZi9yY2N2ekM4VTV4MTRG?=
 =?utf-8?B?U1ZOSmoydFgyNGNDanE1VU9JQjR4bzVXU2ZnUlowWGxqTUxzU0M5UmhvRlE5?=
 =?utf-8?B?RFlZWHlWSnprZU8wNW9uZnVpVExjMVZ3b2RVMWxQUGNJZ3R2eXN1cWQvaXds?=
 =?utf-8?B?YUVJMHNlTXdyOUZIN0FjTTM3Q0dMbHh6czRZa1FraVNDMEczeGluQkZYdE42?=
 =?utf-8?B?cHU0aG5oOUZRTlc1MkNzMHpqbExWU2FYa2d0ZDIvMStjZm43NUtudz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0163701a-f40b-4632-ab17-08df15742483
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 11:01:08.4099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLMyGvferOnNy0kh0p5PVbkb5E56d+hpuez8y6gGGAoGBiCjQSD32skdY/9LM6HxFmRdKWo4SRJuwWyziiJuWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6112
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Sep 2026 11:01:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24242

On 18.09.26 12:54, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
> On Fri, 2026-09-18 at 14:20 +0530, Kunijadar Shivanand wrote:
>> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>>
>> Closes https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/162
>>
>> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>> ---
>>  .../secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb  | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
>> index 263f794..6a5357d 100644
>> --- a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
>> +++ b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
>> @@ -24,6 +24,12 @@ DPKG_ARCH = "all"
>>  
>>  do_prepare_build() {
>>      deb_debianize
>> +    if [ -n "${SOURCE_DATE_EPOCH}" ]; then
> 
> Good catch! Thanks for debugging this. Please just use
> DEBIAN_CHANGELOG_TIMESTAMP instead of the SDE. This variable is always
> available and aligns the timestamp of SB parts with the one from the
> changelog.
> 

And simpler code - even better.

Thanks for debugging my bug! :)

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


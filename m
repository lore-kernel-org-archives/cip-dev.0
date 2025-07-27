Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9559AC87FCE
	for <webhook@archiver.kernel.org>; Sun, 27 Jul 2025 07:31:08 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.59])
 by mx.groups.io with SMTP id smtpd.web11.56266.1753601466682903017
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Jul 2025 00:31:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pjk3GUeb;
 spf=pass (domain: siemens.com, ip: 52.101.65.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W37vdVlUBPEeCAdImj0al425qyy6VE2ifMUlWWyJm9XFKL3A68u4IA8GL7zkyUu5FZCtGs2MRguiRp2U6x9D1JAIlfNlNlLlLGSFjD/221hsD8Bgm8b2CbiFB7NqKKjNEv2FbQ2LwXv/RoNDT3PzTaECEwVpnSlCcDsa3b2Qf4gmqc6+k7Kbc7Fylqrb2Sr/9zmJrC2HrPWd1WxHA5Ea2gqHDBWQLrH9xdK7yWNRTDbXaQdLILcjUahyBXkTk8/YRg2oildCKU2peqs03Xw7AmLmx9Bm6oJxjcWtwBHuTg2H8103C25QLz9iFjkHqdyeY4I+Ytg7JFv2KM0dlR5chg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51sh6j+mwlZ4+++l+LjpGCJUs/BRV+TpUaJZ5RA2Ee8=;
 b=G3Bl1SXNH0RY/S8XrPkpMcdhVp+X0imDaPR5+3qrak66O+v0KS/n0IFYWRIIJN4ZJHqQSI3/G9jEvTALVRoBBUdI10mDf9D/wRwxJjeXicL2RT5FVla1SuR+dC168OiLOX2xwWKJSIgvFg8mR9cmG3XkwIJPEGg7VRVKTBSTEDGB6QBz/t7t+YX9sqhiODzufAhkL2LmCyteHM4GbOimwlhJv7bNPCsK+Rci46qe4tBD7kBEP6iBK+R7HLhbLnqpdIHMiEwMFrEKyJCC/vngXxaPztx77Us+uyXLbuhHVxu58fYIc4KGoazCdr6VAsXCmqwFX/wEW2wlBhXO/um7cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51sh6j+mwlZ4+++l+LjpGCJUs/BRV+TpUaJZ5RA2Ee8=;
 b=pjk3GUeb6iAaZus8hExKSCS62XO814g9Vh0L60+8ixAtuC+r1Ecxm3QAgiMy9dMuwB144U0mh50llfZpHKx+Mas6HYy3z6ZAHzznNNhWFNDqStw4tNDsIrEkz3NpsaZpk/hQPuF5dofV/jlhihvju7Beahp9au2smvFIC8B/glET9a5IdQS1Sg23CM8UXtke6DLE8g/BAwx8zNIY24UvkFsDGN+De068zveBRobsYHqYi0d/4u7NMG9JI3DGJWYNCwEuX0D5IvArmLTg/VGbp/KKg1mL5KjWnaXsF0lzU5/eC1QziBy3h29Yyg36m7VKKBpxN/j3fZHvjLBtHUqw7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7635.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Sun, 27 Jul
 2025 07:31:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8964.024; Sun, 27 Jul 2025
 07:31:02 +0000
Message-ID: <9a6548f0-6148-4e6b-8c7d-4d6b79891dc1@siemens.com>
Date: Sun, 27 Jul 2025 09:30:59 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 6.12.39-cip5
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
X-ClientProxiedBy: FR4P281CA0351.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 450fcae8-efd7-497d-4d8b-08ddccdf88fd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dlJtRVUycDRvcFlUcmtqQmNzNDVpUGpVNURiTi8vc2VqY2QzRVpNNlV4SlBM?=
 =?utf-8?B?RHh0SVRTQWhlMjZSdTVlaDEvNXBVQ0VuOFJXTkhCQThBUW5aOXRXN2dwTnpC?=
 =?utf-8?B?L3lOdzA3R2dXSUZjWTBjRzZ0NlFpMHg0cEtIdmJCSWFISGZkemw2TjRMTTBo?=
 =?utf-8?B?cUljcTJDU05weDhKSzdWT3lYcFY4SDZ5UWwwcUdjU2EwcEtUNDU4M1BnUHZp?=
 =?utf-8?B?VGEzYTFUS3N4bzB2dXI1MTNya2lYc1E2aGk2ZjZYcGJqRFZtVGdKdEY0VkFq?=
 =?utf-8?B?QnpUdjFLVlBmY1pXWk9zL2MrWGNXTnRwTWxrMTI0b3FRUTZFWm1adllFRStM?=
 =?utf-8?B?L042SGVjNDJ1LzdHMHhmVEtWWURqd1VzMkJTdHk3dDU2U25HUVVUaS9rcUc1?=
 =?utf-8?B?V2pUdHp0OERId3UzcWRDMlVDektVbTR3SmgwTWp3Q1JIbjJ5Q29MdGMzNmFr?=
 =?utf-8?B?SENyQWFLdTM3SkpkZ2FGVXpDNFJGNjVLTWUzajVBRmdJUlViQU1zRkZKUTAz?=
 =?utf-8?B?SkVGdGR6NEprQVpyOXd2Z0lUbStFN0tYcFJXbHc1UEh1cGdGMFJKbFdVMmt3?=
 =?utf-8?B?RXRwTzBySnF0YWkyNjhISUQxSElsZ0xJcElMbmQvM2tLZk5kZGlYNFYxS3I4?=
 =?utf-8?B?Y2VTRGtsbHQ4NEh3Y1pxdis1WXViaFNqaHJzeVJCZXRTcmVCNklOQzR1c2ov?=
 =?utf-8?B?bE5uOW5BZ2lsRnMydzRxblRpZE93bTh0WlNyYmsxTmJZYlhuakZ1VHBuVzdJ?=
 =?utf-8?B?SE1YTmQ1YjdEMWJObUo3SnBHbUsvNnJZR09nSlRXOXhZcG9pS3NSVDgwNUJk?=
 =?utf-8?B?emNZdTNpeFJ6SHJKaDFsaXN1SmNETHBpQ0gxMDVRdlhIUS9OV1RUSzU2a3Bi?=
 =?utf-8?B?ZnNXTU0rK2FGNWkrcTFLamVLcktTUkl1OGk3U2Y3Y2I4RjNLSUhVeGZQWHZQ?=
 =?utf-8?B?dng3TUxNTStNQnNJcnVVNldqTU9QWXhYUVAzUUozcXh4LzdVcWZ1Q0xJZjc2?=
 =?utf-8?B?VDROY0hUK050Vm9qWGtnb3RFb21oMjl4NHJZL0QxTndSd3phZ0txWWxCU1A4?=
 =?utf-8?B?ZmNjRXR0SG44alVJejdHcXJwV2w3NkhrTXkyczlKdWRQVVhNbG56VVMvVU9I?=
 =?utf-8?B?Rkh6bjdCbmdvdFdwZFErTGZ2bDF1aXV2ODI3S2JaZVU2QkhJWjVsTzBPQ2hT?=
 =?utf-8?B?bWlqWlJNc0YvaHJyTjhCRWZMYXROV2llb3FUelc4WWo2OW9WQ2IyemdFK0Nv?=
 =?utf-8?B?c055enIrSGxQY0lsQm5mRytDK3JCWlo4TFErMTVpbmZGb2tEZ2Q1RmZPZUdl?=
 =?utf-8?B?QzhYWHlwSFZyZmNoMzNScGIwSU8vekJyd2xxSmIzYUdzOERYNjdpUXZHZWJM?=
 =?utf-8?B?WS82QWpXaldKTDRKTUkreVZqQlc1ZlNyUzlxM1BPS2NNYlNIZ3BWSjRCNkJl?=
 =?utf-8?B?YzlYY0ZSM3I1enZPRStlVkc3R3NYTnhFMU5JNHJmYXVURnpQVWpyY05Rc0h4?=
 =?utf-8?B?d242UnE0UU1KaVVTM0E4anFtLzlDUUE5UXBERW1KSWFiNmRNV2VvT2FteWdG?=
 =?utf-8?B?V1crVzN1c2pOSGRkMm9UN0dyMlhPb002VzhVRG51N2tBbUZvcmdZcStCMWpw?=
 =?utf-8?B?d3ZvRmZZbWlKZitLNmV2cTdGcEZUVGtSd3ZUZFZSOUZJTGp2ZlRocDBoUksr?=
 =?utf-8?B?NzR4QVJLN0hNajRsSUNROVliMksvNGdSZEtnTnRqWGxyT0JpY3haVHYrby9k?=
 =?utf-8?B?bjB4MUxzeitTNktPY1g3OVBxRDFpelVzanRuZkhCNiszSE9UMTJGY3h0TFBU?=
 =?utf-8?B?RFZXUytaQ3RkTkw5U2lON0dTUWRJcmJwNC9nWjZPYnQrSXJmaFA3d3NXUGgr?=
 =?utf-8?B?TGZ5MVRTQjUzWWViSStxUmxGZHVLQXcyS0N2N0VCbUE4MWxNVW5pUHB3aUFY?=
 =?utf-8?Q?AX9EkgN46tI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aytQSEpFNUhQYWJXVThoT2Y1UDc1Wk5VQmVvRUxienpYQ3U4eUtWTHU2Vkl4?=
 =?utf-8?B?NFdQeEVPRFByWHhHV1dPQ2syQkVzWlRyMm5ZRHNoUGFxb0lHSkpnUTkxOVdp?=
 =?utf-8?B?ajBRZkVaRm01aGVuTUZqRHBkdUVseXErY0VYK1hsSFE5OHVMaDRSTTZjSmZX?=
 =?utf-8?B?b0lhbmdXYTBmVCtrRjlEcUZKSUQ5cGlZTGFYaldvSDI4cll0Yk13cDFWMTUw?=
 =?utf-8?B?cHR6ZnpOUFovVUYwWHVUYmVUK0I4L2RvUWttODhxSXE5NGNxOWZvUXhZZ3FV?=
 =?utf-8?B?VEVCQ1BoU3d2OG5pS3d6eVRQTDNpc2J0Q3NleGRqKzM0ZlJpejNvU2ZOMG9P?=
 =?utf-8?B?NXFVZU5WN0dYUlNSYXpIOEJKRGtVRHVxd1U2VXBrRUVRb2F2OGlvTWk2cTZY?=
 =?utf-8?B?ZjdzUTNwMGZ3dE1UYzg0MmFaLzFQVU1aSkhaWngvVjdteTBGVkMyQzFKMS9z?=
 =?utf-8?B?b01HMER3MWF6Q1ptbUg5elM0T3pLdGZvdU5wNHpXcjRJYlRaYW01djVFakNI?=
 =?utf-8?B?MFdDdllvV2ltRzR1NTVWWVpWQllhbFUyb2NyaloraVBBT2hwWjNkVDlqUWlv?=
 =?utf-8?B?L21BaU0zTm5XQ3dzRVh6VXVHbFFFQmJVbmJ2RnNLMEVGSGpMVHk3aFZUU25V?=
 =?utf-8?B?NGVlTmwxRmhYUGdrUXZyQTlqWWxJazE4eTNqS3gyQ1JwQmtRRTZ0OXpLcWs5?=
 =?utf-8?B?TmdqWTVmNit1WnkvbW9yUlBJZ291V04yZ1BXbzRaMUYxTmZscVNrOTdxM3d4?=
 =?utf-8?B?T1dYUVRQUUtvVlZUZUUwZVpLUEpnbjg5NUVOQnBnMjdvQzJJSVZEOWJSaFI3?=
 =?utf-8?B?SXFsTnVSZjBnMTdsRk5iODIrOTNFNzNON1VTRWFPWXliSjBoZUlhRE16WGRD?=
 =?utf-8?B?TEhsN0t4ZGdhS1JpNkszd2plQkhtV29RRzh4WHFnVCs1VE4wN2VXS2dEaFkz?=
 =?utf-8?B?TWpWeG9iTitIa3FoTGVXQmRpOVAwbjl3TGpETHhHc0crenhBZ2lIaXV2cy81?=
 =?utf-8?B?aG43RjNHL3RIMFVxWGtFckdjbXNEcjZieUV2eUZhS3Y1UW13bEpvUFNJZVlx?=
 =?utf-8?B?RWFNRlBpYTJ6eXhTR3locWt4a2h6SDFrNjNTUWNQbDdVYmJnQ3ZVTGFONnpP?=
 =?utf-8?B?Ry9EaVcrcy9leFJ2eEpNMmdHdk9DdW9oU1RqcHNFdVQ4NXdzOU1DaXNqOVVJ?=
 =?utf-8?B?UUtYb1NvZkhpNVVNV2I1V1pZdzdVT0YwdUpMZU5YZUkyZHJmNUExVTNjRlhQ?=
 =?utf-8?B?RVV6RUJLeWxCVStYcUtOMm9sRUE0SHhsWnFQM1pxcnBzRzBjTWFPUm9PWmFW?=
 =?utf-8?B?TlF4ZlJyUGljbXdhUFVISFlYcm1CT1E2dXJxQmZSOXFmOGMxcHRwVnZqRS9O?=
 =?utf-8?B?Y2xRWjNNcm91c0wxTWhsSmVBcGNYZzA4OG5HWE5vak5SUXhmKzFLcGRhUWpz?=
 =?utf-8?B?ODRNdkI5VUcybWljb05sRU1QNHVQU3RsRWl0ZlpLdE9iNWk3OU9HQk80NnZK?=
 =?utf-8?B?OFRyQjEzZnpXZlg5b3V1L0VPRzBZQ0w0ZzRab3BBcU5PRWN6KzRocjJOMFVF?=
 =?utf-8?B?VU92dm55d2t2aHNpZHFBbWJmZjJrQjF1V1hUZG1kdkdzNkZYcXVYY0Z0QlRB?=
 =?utf-8?B?L1ZPM0lxNUpOTEJJMEw3aHJVZ3c2ZHZUM1VyQmFwVys5OC8yaHVSZHd6OTVt?=
 =?utf-8?B?ZC9QSUR3WlVDT1lBN2dYT1NQMW9VNHhYSXJyeWR2djYzOVlKM2Y0R0lZb1Bp?=
 =?utf-8?B?YUF5S3huOE5hd2JwN1dZaGE1WnhraDgxOWVpbStCQWQyR3pkM2ptTk5odjRR?=
 =?utf-8?B?VFVieWx2WHFqZlJxVUFPUkFDdnFnaHZlQmxvRGh2SytWbTN5UDlaTEd4UEQ5?=
 =?utf-8?B?K2Uvdy96VzNrSk02ZmVjZlhqUC9SWUhseGJUSlh4eVhRNS9HK1FmWjBKRkdZ?=
 =?utf-8?B?TngydHNlVGlGemYvY2NQaGVGSTdwTlZkUzhuQlVPZE4xdS83bXBOZi9YR3Ux?=
 =?utf-8?B?Wm9lNzhxb0VKeldYc1pGcVZ4WGY2eHNrbkordGgzTUFVZWF2Z0NDZmxuWWxM?=
 =?utf-8?B?WVFwSWRBN0VWMGVXUG9TZVl3VmJSaFNPQi93NzVZYzF2b3VnYUNIc21ZeE5p?=
 =?utf-8?Q?qD8ABfTVPu6H1dRICsw/5cLSz?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450fcae8-efd7-497d-4d8b-08ddccdf88fd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2025 07:31:01.9597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1yyndwB3iUgLislE2WuVoD//YdZKLpAvfjXkeBjkFKpPVeOf7H7a28Fq0E0xw3/omg5WbPLScjJHHh5x0B1pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7635
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 27 Jul 2025 07:31:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19596

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-rt_6.12.36-cip4.bb               | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.39-cip5.bb               | 1 +
 .../{linux-cip_6.12.36-cip4.bb => linux-cip_6.12.39-cip5.bb}    | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.36-cip4.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.39-cip5.bb
 rename recipes-kernel/linux/{linux-cip_6.12.36-cip4.bb => linux-cip_6.12.39-cip5.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.36-cip4.bb b/recipes-kernel/linux/linux-cip-rt_6.12.36-cip4.bb
deleted file mode 120000
index 95381382..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.36-cip4.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.36-cip4.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.39-cip5.bb b/recipes-kernel/linux/linux-cip-rt_6.12.39-cip5.bb
new file mode 120000
index 00000000..26a42aa2
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.39-cip5.bb
@@ -0,0 +1 @@
+linux-cip_6.12.39-cip5.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_6.12.36-cip4.bb b/recipes-kernel/linux/linux-cip_6.12.39-cip5.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.36-cip4.bb
rename to recipes-kernel/linux/linux-cip_6.12.39-cip5.bb
index 387994a2..9b5dd9c1 100644
--- a/recipes-kernel/linux/linux-cip_6.12.36-cip4.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.39-cip5.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "1959ac4de3f63bed87332dad655b8b76be0a8295e8a3c04216ae8f4562fd0bb6"
+SRC_URI[sha256sum] = "be863adb5fef55c4698a358e2be78dc16f567f394cfa1f56b4837b49dc1b3f0b"
-- 
2.43.0


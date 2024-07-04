Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA3FC3065C
	for <webhook@archiver.kernel.org>; Thu,  4 Jul 2024 10:10:55 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.50])
 by mx.groups.io with SMTP id smtpd.web11.7022.1720087852969280141
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Jul 2024 03:10:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sx8ceEZp;
 spf=pass (domain: siemens.com, ip: 40.107.247.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6m6wBC3hh54oTWTga1UDu3vwSCOXULoG+FZbxu8+idDYBireY/bRpeP2hZDYUTPlwa47p9+DqKRW/YqkCM4ekF05fQBF3eza8Xs+SDbIExXTn17mN4gNMIwizHUYFshMBBtoh1nrkAxiPeD6IkLI+C0FOVMmrry06B2wBqnkaxrEpNm2uSpEI06JRT39lCKGiL2uuaa6GygdUgwxx8+JUsJ5tp8L/+vKzg7OcLnhP9eWMxORNUlWlTTTTQNGjJ6s5f/p/2WYuz4ikvXKfQa27rgkJsjJMsLoOvwtcAFfN97dpHBGNwknyzdTRcxhsA5Ze5ixJZCJ7FcqoYK5LtTOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fd/6XiEE4a8D+SXdGFg3yZveR+HFkWzL2AoKx5GCljw=;
 b=IWRUfPdRbSVtE5QfnQvNK+wj/wHiy4LCBC7AZx8UUCuiBjdMBzvJmxU43zbynMlZp/OcP2gkRFp54AHbVYdV+aYFT6IFClLzLmuWLdZM22iemyq9odzNgIFl0T7dS+ODiDogiKk8IDtRAiL7BKdhO8MKfqp97oKoydfBmIOzY6TX89YT6WLcWH0oG1FcmHm+HGLCrQ3yySAon71Y5Wgzgd9z1obZ2vpkrACMOQAd/u9S6ra6TVIgTtzVsIEab7bdRZg0tOmrDegqDmqHmD1+1VyYmyQwp9TCs+B8+mwmC4QB6yMKmVRL0H7vpcpFJVdqDQCMExpYL2AoaYZWyR4xtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd/6XiEE4a8D+SXdGFg3yZveR+HFkWzL2AoKx5GCljw=;
 b=sx8ceEZp+t96dUkGXBb+4ESks9qvWkdzT0/2UOaw6vCaopdcNuPaIRUYBbwYyjLwPY/6cMqwai0MyfxH8BLum9/p+HHP+mvjH1PgGO0VQowVMECCRa+uyl5V5e5M96eJIHtkajpftP2pW6z2VSa5bdAh7szYmimeTwbA1LiA2zBZ6SSuuEt3pqpmGrZVQuooAA59AizBPh9Mm0WgUUK1dMUXLBqJR4TzU3MxXmXq/Khc5h7nQMk7gxCV0jb47mmVbmd9keBXEluGWJ8JVCXTsB8ASG2LWufpZXT/7xCw8Wz1ML8W9aG9pTiW0ymOoxrMykGHhHmJ9A3QH83vVCoiQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7159.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 10:10:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 10:10:47 +0000
Message-ID: <e07e5bcf-b48c-402f-9dba-aada30bf1be9@siemens.com>
Date: Thu, 4 Jul 2024 12:10:42 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Cc: "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
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
X-ClientProxiedBy: CH5PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf351a1-96cd-4e97-e13f-08dc9c1192b3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QURSKzQ4QVA2TCs5ZlhUbUZUZkV6MmxsZjRFMGcyYWNZdFcveFpDendTL1RF?=
 =?utf-8?B?bW94MVlFQkRQZmxBN0tsTGVhQzQ2RW1rNHBpNy9xcXM5N2RqVXdBOFY3V2d3?=
 =?utf-8?B?L0t5TXR4ODBzd3N2OHZyR0l4V3VyUXlpb0NKbStVSGNwL0pYY2pxQll4cDFR?=
 =?utf-8?B?U0JsNlJ1RVkrdytQNWdhbGhKcW9wMmpGS0dmWDhyQWE3Mm03czAvMFNOc2tr?=
 =?utf-8?B?Z3Y5a1FnaXNJMWlweGhXN1JOV2s0N1RrM2N3YzVxRGQ0Zkhwc3g2cGZheGZH?=
 =?utf-8?B?TVdUbkI2QkRoQjRQRGJEcnNDZzMvQ0NsNEtFWjZrMEVSL3h0OGcvUWJsTEly?=
 =?utf-8?B?M3JkNDJWb0JmT3JHbndacmRBdUUydTBnQVlNeTR1TWtqNUUxVSs0RHlXZXk5?=
 =?utf-8?B?Qzh3VEc0Z0grd3FUdnpOYTZ2VTFDZUFES3R1cGFhN09kb25FV2dGa0llcjNl?=
 =?utf-8?B?ZDNtOVB5eEVJMVBwUUlFdDNISHNMUWlhT0JFTXlCYWVOUUM4Q2lyaERVOVBt?=
 =?utf-8?B?QTJxNXhFaXRtc1dKTlg5aTY4dTZCQlBmUXVKNUEzNlRRSDZTcGU0d2VMd3kw?=
 =?utf-8?B?WmpydFpUa0EzTjNtSFhUNkNzemh4V2xrdWhqaE4zQ3RBTENVMGpiZnVsYmJB?=
 =?utf-8?B?clZCb0tyNWpuMkJFL1o3aU9IMkhxaFMxd0hVM2JOcVdQTUxTSHdtRThqUjFI?=
 =?utf-8?B?VXplMXhYbjZjMDVDZnB5enkxRGQyK0djOFBJM01seGMzWlQyRkpHYWtFMGJn?=
 =?utf-8?B?TFdpSXk2MnovbyszK1V1cTlpTjRtOFZGM3FjejZod1dkdzBiajFpSWppelhM?=
 =?utf-8?B?RWg4QTAwV3pseHVDSHFUM3N3SWtwM0tXQ3RWN0FWbW1Mc2lQeVA0ZDlDWGdX?=
 =?utf-8?B?ZndvVE1uRGc1QXlOVlVxR081cmE4Nk1iOXRGZFEweVBxVWlTajJ2ZHR0VWR3?=
 =?utf-8?B?RnlVV3htaFE3UWZ6TWkrNzFmc3l5UzY5NERMVkRkTjdieWhGa2t0eTdEaGRI?=
 =?utf-8?B?OVZMRVpWSDdPRkZtc3dJQU00MWd5UVNwTVU0OFFTZGYxQ1VNemhRcnBKR1FZ?=
 =?utf-8?B?WjFJbkdURHl3M0daUFJxZlJ4QTdyd0FkRzBaME1QYUczT04zbVZKMHFRbGFN?=
 =?utf-8?B?QTVIOWVsOTlkV2xMWVVTTTJnbWFEek5wQzhOYUh2N2o2eGNBSlhncm5RNDJs?=
 =?utf-8?B?TnBWU0pCTVpaTlpUMnROcUxLYUNRUytISnpyY2k1SjZIOVB6Qmc0dFJWOHJo?=
 =?utf-8?B?ci9IK2hJd3NZQytUSWJ5SGhrajQ4SEozZ1BsWVlWN0dQYURTMTZJcktBQjQz?=
 =?utf-8?B?eStTT0ViTXpLMzhCM0tvSDE4UElBZFNvTUhpaEhYdmdWWEoyYkREM24vOTB2?=
 =?utf-8?B?ZW40MEJNbEs5OU1pUnRndDExeGRvU3BRRjlPdG44Qi8rNVpEWk5xeERFTy96?=
 =?utf-8?B?OUpvRVN2Rnl0VlBZL0xZenI0eWQxVGxEVHAyVUtCQVEzSEN1eWcxVW9LYy95?=
 =?utf-8?B?eVBRTnBqY2pFR3NJb0xQS2JwQ1dYZEZ5WlRYV1VQbjZvcDl0Z01KSm1veXBZ?=
 =?utf-8?B?RzRnUWhZSEZ6djhmK1E4NkV4MFJwb0g2WHE0bnRlS0E2QklBUzlSS2tmY0JC?=
 =?utf-8?B?TlFqbHZobEV0dFVsaitqejlRWFVDS0s4ekFxZ2lGNFlTTStuT2VZYmM0dUJR?=
 =?utf-8?B?M1BjZkdQTGNuM09TQ0t1dUF2aU1Fc2ZRbmJTUjFCRE5ySlMzdlBSKzErUVJU?=
 =?utf-8?Q?pxJxCsRi4MyG9+WD0Q=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Wkw2MHZWRStvQ1BSdGJtcGRBMVNZUmNhOG5TZ0FYV01FRmJFOHhWaTVQVHBl?=
 =?utf-8?B?QUF4UVBWNUM0Ui95Z0ZaNVZiT2UvM3lSWnNySlFiMUxCdzlEY3hQVCt0b0wr?=
 =?utf-8?B?U0kvdU1zeUh6Q2lldEc1Z3RabnlIeHRaMWRsdVJIQXVmQnJqTW9mdWF0bFI3?=
 =?utf-8?B?V2NQWWhDdVBYZHN4MStycWd1bUYvQUZjVk83T09jeWlYYld2SjREQVJDbDhU?=
 =?utf-8?B?T1NVNG9PZUw0K0VlZVpzZExmRVI2cDJVN1Z0L29tWFJRLzVMakZMTHg4ZUgy?=
 =?utf-8?B?NkthaUlLUjl3Z05ET0ZmUFNwdVdubm41M3hPY1hOUmJ6dUdRZm0vQ05jdy9R?=
 =?utf-8?B?VE5iZTVnWkt6by84a3RQV1k3V2UwWmZrb2J6Zm0vUkZ5YjlWS0NtV0hYZm05?=
 =?utf-8?B?RmZwTHZqdk1XK1F2ZDl5eng3WTBQL0Fva1RuTXA2ZmxSTWZvNXNoeExPZzB2?=
 =?utf-8?B?NXZTcXJsRXNnMVY4VDIvcmZMdVlYbzdsYkdOUEhnNExMNkIvQ2JqVmtob2ZB?=
 =?utf-8?B?OEE3WU1IdDR2MEFHRmU0b3FaUEFYYjlCQjhaL0cvbzU1YWdSY1dQODQ3LzI2?=
 =?utf-8?B?UWdJRUJ4WUsvTHRoSFhCRHhTaU1tbFRKTXNlQVpudFpRcUlEWjluNTUzZCs0?=
 =?utf-8?B?bUV6NGFob3hTdTFtYjVZQkJoRWJSN015dUg1RTJtVFMzVHRXM09EM1ZrbXd4?=
 =?utf-8?B?ZEVpR3pKcmlLSitNZGV2cTE2MFA1aUw3VGdaUGxzMjlmcEd6Tk1SOWRWTDZR?=
 =?utf-8?B?cXQ3cDRyVUxkak9RQU1SckxQZ0djdGVQOWFCZ1l5cDR3MWkvL0V2dU5XUVl0?=
 =?utf-8?B?WExMRlZwR1lMYWgzTkFQb2tUWEo4WXYzb1ArdjR5WW5BdXVwcE9Kakg4SW94?=
 =?utf-8?B?Tm8xbllRUGRHekloZm1rWmxrT2twTDNWeEt6cllCNjU3RmhsN1l4MXh6M1dY?=
 =?utf-8?B?dm1tMVVDMEVHV2FrS054SFBOMUNWZWd4SEsrTzZ4U1Vha3FiekRoN0paeDJl?=
 =?utf-8?B?NFpxNWRwTHVuTkZzWVg3OGFtRWZ1RFlRLy93VUIrOTJPMGliS1lyRS84dVgz?=
 =?utf-8?B?eWZieWNBN0tsajJ2WDdNN2xuaE8yVFVET3BFUTRlUmkwRFdPWDBlRHBUNlNR?=
 =?utf-8?B?MEZ6NUxMZmkrTExzMEJsVzhGZVpqV3JQVlEzUzhLdWE0TWJNVkkvY2gyUFJu?=
 =?utf-8?B?Y3hjeHlnZld6ZldtZlVuMHhPYXNhWDFWRnA1b000dVJFT1FZMm9zSTY0ZUVX?=
 =?utf-8?B?VEdwNHFSVzdKYVdCck13dWFLY0dGYS9LblIvRHZ2UTZCU0FndlpQUFN6bUJX?=
 =?utf-8?B?Z05lMmtidlpoeU5ZQXA4RDdJOWxYYTlKT21rc0Z2TVQ1Qk1oS2JLaXFObkV1?=
 =?utf-8?B?UXR4TWplZHVENzFxNDR0Rk91ZitOZWlKQkNtS0N6UXFXSE1vS1hpVkxUWkE5?=
 =?utf-8?B?ZUhwRmhpUGo2SkNKVitBSUtTV0dyUVhqcll6dzNocm5SNExUTWVuTXpxNUNO?=
 =?utf-8?B?MmZWTDZuOTIxRGEwVGZ5S29wdGVCb2U0WnZITlhCS1RXZnRLTzVGa3Nzdm9k?=
 =?utf-8?B?RzA1ZFhzendKbFFZOGZhYllBL2ZXQVRMb20wN2hpT0NvK3grY0pCSU1DZ3Y3?=
 =?utf-8?B?U0ZUaXJqNjZiaEMxN1dBbWdQUnFkdVlYekpxallhYUJKTmZhS2U1YnhsSmk2?=
 =?utf-8?B?cG1SMTdYZkJiK0VMS0xKVGVIVTliZ29yYTF6bDNlZkpsSnloYk9EQm43bGNy?=
 =?utf-8?B?a1MvZ05oK2hET0dTMzFuWk9yMzlKZFB4MzROWjRKbC9vNFRGaVlNUStNTVRx?=
 =?utf-8?B?UzlVeXRvTXR0WVJ1bkdZemdHbzQ2MUluZjlnYmNvWTdxTDkwVThkWG5tQUVx?=
 =?utf-8?B?N053dUVXdnhzSHI4OE53M1hXcFpaU2F6VGJDZXBvY0dxMUFieW1WaDJsRGZK?=
 =?utf-8?B?elNuY3Z3YWJXdE4xVm9CM0JyRDlYaU1UUW9hU0MySkZia3d6VUNnY1pNdHR5?=
 =?utf-8?B?TFg5UXEwU2N3S3haWmhTQzBRRndSa1ZOWEJxd2NKWTJQWmt0eHd2cWJ2WWNm?=
 =?utf-8?B?NURaR0o3c2VWUTg2TCt3ODJuM1c2UmlrYXBiZENuQ3ZUNHlDSFYzV3pJanBO?=
 =?utf-8?B?VUxxNW9BSzlsQVlUL0dZWnpJSjBlTW05RlB6Yk1YaDVyQmRjMm84L05yS0lv?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf351a1-96cd-4e97-e13f-08dc9c1192b3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 10:10:47.0431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hj3IOZT3lQdWRs5Ohz21k/NbeStSkOeR4awBXJTAIyvCiqmilkHY2KCj9xv2PMcMCVhXuFjA6lpFl+aeSO85Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7159
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Jul 2024 10:10:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16372

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=7&day=4&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/06/cip.2024-06-27-13.02.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - Feedback from BV on CVE handling documentation [dinesh]

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Mon Jun 17 08:01:45 AM UTC 2024
  limit date: Wed Jul 17 08:01:45 AM UTC 2024
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon May 13 07:50:32 AM UTC 2024
  limit date: Fri Jul 12 07:50:32 AM UTC 2024
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu Jun  6 12:19:51 PM UTC 2024
  limit date: Sat Jul  6 12:19:51 PM UTC 2024
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Thu May 23 09:06:28 AM UTC 2024
  limit date: Mon Jul 22 09:06:28 AM UTC 2024
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed Jun  5 08:14:01 PM UTC 2024
  limit date: Fri Jul  5 08:14:01 PM UTC 2024
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Thu Jun  6 09:43:37 AM UTC 2024
  limit date: Mon Aug  5 09:43:37 AM UTC 2024
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Thu Jun 20 07:33:33 AM UTC 2024
  limit date: Fri Jul  5 07:33:33 AM UTC 2024
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Tue Jun  4 09:25:36 PM UTC 2024
  limit date: Thu Jul  4 09:25:36 PM UTC 2024
  Status: On track


Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B037CCD19A
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 05:45:47 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6062.1763444729292128033
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 21:45:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JV+wXgPE;
 spf=temperror, err=temporary DNS error (domain: siemens.com, ip: 52.101.66.4, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1aJCb3V9X8uLMmsUi2b/a5e1mGzD+ANjIjL3M2lA8CilUYHAeuzuOgUR/NMNzpLb4v+ub57df92cov0rqBe7o6yQws9c97e2kFt/z+0Ixjd67pXPeovoNruElaMdYw2Rv6VM+dIEw2wVg/fbO+oETJuP7+GeocpAZn72CD3Yfd11u0rr8V/ImXC+uYCv8uK3AI7eIj645TV8VOmKWOWImjdFbZoLXCcAjLJ5MDOjgkSjKAwgRzd75aPNgS6RZDNCCWwYa/PzwhMYHph2thXhnH2fuRd5MAqDzn7j9s3IR9n5EO8+C4AIqdkPVYViflP3c6WKRdtT+zXtO/ZyQwFQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXpRf6K+yitT20EJPJVROX3goNyRWHCk6FRU6v3s4Bw=;
 b=Tv7EhmTDfjMBjHL/t3OeR7xKkHAKlp6mEXROheBNFVnNrIRfTLTrpXTjtV0P2QYJ05/fs+7mObD2ougI+ICCQAJKcczPSZvnG/cpfis67JAZFbDM7y3NMHXRq2rhRAXjT4F9mJb+F1qVJjZf+Zm1agFqaH/O8KFZZfexAMXejkB6ONcUC8RO0yJrWJ9OXXPefx818YCALiE7slIFPRi7QNrG6PpxdizeK3L0N3KgpqaMTJVLgSeBM4IdbRqh86IpbZsBkkNM9hGe88HUBVDFp+tTCMLKbtD48zjN+JU7TCe3x64ejrtlsf5qUcG5mOrKFwA0qB2ypfJJ/2bXWL06Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXpRf6K+yitT20EJPJVROX3goNyRWHCk6FRU6v3s4Bw=;
 b=JV+wXgPEXH6Z/GDxwUXm4bfx7jfbO5DjxgaVzDqVJzHB6FXxaXP4FjikV009xkpk5DWCkIkUUs/oxqZuOir5rJsehFPktImpKRC+Yz1DtjRoM/2kC2+Dq/dNvFaBo5wO0+wyCLzyp6UNPtEFk1rwouk7UalHV8SX8n+3NUQb70zaJvf/ifKQcqAy2KIFuteMgW2hx7WNM0RHjC0UatDmz031ISXSWcz0Hs0kjyP3At5PdRq19Pm3dU84KTIQNa5RLmsBQDOHKVDCm5UcFW1bDWEL+4ylgJUqv5Dlu/srzGIpSq/l6XkpAUyJpFXKQw4GfZApzcWC+DRDqVzB8BrHfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5701.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:319::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 05:45:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.018; Tue, 18 Nov 2025
 05:45:25 +0000
Message-ID: <7f09f540-8d58-49bb-83f3-811eacc77a20@siemens.com>
Date: Tue, 18 Nov 2025 06:45:24 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Pavel Machek <pavel@denx.de>, Chris Paterson
 <Chris.Paterson2@renesas.com>, cip-dev <cip-dev@lists.cip-project.org>,
 Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Subject: 6.12-cip RT testing
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
X-ClientProxiedBy: FR3P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5701:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a409e1-96fa-43af-245e-08de2665ac10
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UzRCb2pmNkdoUVlIbHZtanQ3YnVZTjNQeHZZZkRoVGp3WVlYSGtsQWZEZENQ?=
 =?utf-8?B?RnJWVW5jOW1zMlhLS1c4UFRnck5rM0FobUZuM1djUWZCNWlIdk9aRGJ1MHJ5?=
 =?utf-8?B?N0M2R09BV2FaUXpXa3NEeHVGbGVLQlRldS96cGVxNWx5MElxdkM1KzhkYjQ3?=
 =?utf-8?B?WE81TXIxZ0Q3WkU4WlJ3eVBzalRxdzlLN1g1UEpLRG5Sb2F2eDlJQkpOVVV4?=
 =?utf-8?B?M1hVdzhCM2htSVhEMkFoMThBT2w5Q2VyaDA3ekNLVXBPZFpaQUlUVm5LeTgz?=
 =?utf-8?B?MEd3L2xIbTFPb2dTVG45Z0g4R1B0Y24xOGtjdDU3SExnRnRRWllzVkJNRFdC?=
 =?utf-8?B?ckw4anFvQTNpbkt6VTFtaHI0L1NXaW9ucVVVUFRVMXgydENBREJlNUx5SENp?=
 =?utf-8?B?cFdXWmdKVXE1SlNiQm40RDJxeHZTSzRySFJzTEg0dml1MHdmK0ZSV2J6a1lL?=
 =?utf-8?B?TnllWGd4SGJoUlpZU2hCSXlUa0NORXhYQWo0SFFlZllKS2JkMWkwYnZWNWxU?=
 =?utf-8?B?NDdQMXJxOXY3b1BEMTZlbHpJRjRURjRZd2lrQXZzUTh0V0hqWjBNeVN0YzNC?=
 =?utf-8?B?RzZQNjJManNvRmI5QlJ3M2tFUU8xU1F1QzJJbVFGYnVwSDZubDZpTXNQK0Rn?=
 =?utf-8?B?NjIvRHJ2aGY3S3JpeGN2bEVra21sZDgxMWcwdVhwZEVjS21ZTnZ1SEhVR0N4?=
 =?utf-8?B?bVRGdFBiV1RNKzZRSmNab054Z3NBZXVhY1YzRXFTY2ozWmNkZ3VWVWxyZlBm?=
 =?utf-8?B?eUJBc2dBZXZ0ajRuWmpMMDlabGQyZnhUbFVDUURmMjBqa014YnRjT3BHcHFU?=
 =?utf-8?B?dzZtNHg1Z0Z3VkRVa3B0ejRER20waGNqQmRFS0ZCclkramR4ZkpaN1k1eUtB?=
 =?utf-8?B?NW1McVEvUDNjRU9DbGplM01zWHF5a3QxSXhSMUx4TVQwM0xtd05aQmd3Z3ps?=
 =?utf-8?B?L2VYWHd6ZHhGYlZ6WGQvMjJqTG1IaXFOaU9XMFBXcHdDL1cwZ0IvU0pNOVZE?=
 =?utf-8?B?TEtIMFFCVWFXbUJRa0h4RFJXcER2QzJaS1lDZnc5NGp5Wi9WWjRuSk8vcUZk?=
 =?utf-8?B?bklFMUM0N2dUWG9lQ0lIVG16bzlOTnFMRnNBay9yeFI2ZUVOMFdxSk9DVUt5?=
 =?utf-8?B?emQ5QTlOVEN3Wm4zcUR5VjdzdlNKYi9WN1FNM2RHcWZLa0NGaGxaRldSNEdh?=
 =?utf-8?B?VU91Ykg1YVJRaWpRelRIdTRqWE5BbnZqWnl4Q2VOTHhJM1RlazcwMjlIQXV4?=
 =?utf-8?B?bU5jYmJRdThXa0c3M2RLK2k3dWhiYUZ4cVY0R0JaVTliTUVibjBPMWZaZ0o0?=
 =?utf-8?B?SmZFaHprV3hYVHZLdTgxZG9UMHZpTThkN3JJQ0JYRjRFWGVmVmhsbE54L2tC?=
 =?utf-8?B?Z0JKQXNiVVZTNE42MUcza0dQSXhMVWVkMThTZk5YTnlUdWh2TngvQ2I4WkNU?=
 =?utf-8?B?UkpmUUEwelRFTHVweU1vVThKMEgzcmtlUmpMSjByN3ZOazRQOUgxQjJac21p?=
 =?utf-8?B?eE9laU04cjh1WEsvcTR1Um1jZU1jMUZZc3hGZUJ5L2lZNy91NzlyME9KY1ZI?=
 =?utf-8?B?V0tHRnZMSlF0ajMzSCtYYVFPS2RLQVlrLzE3ek9aRTR5TnU1TFNrTDRYN2F0?=
 =?utf-8?B?ckZ1N2Nzc1d0UG80cWQ0dUdNdGN5K1U0WStDSGdtWW5rY1Z4L2RWai90Q2E2?=
 =?utf-8?B?eUYyVXc0MmlUUk1GRGZYeDBkWnROZTRNelo3OVg2RC9LdzhDTzVCK3kwalFu?=
 =?utf-8?B?N0VuZkZwOWVEb0RIOWNuTlVWbGtrYkxReWxPTzB1RXdNRlFLeXNsTks5OXF2?=
 =?utf-8?B?Q3JMa3hGTFFHZE9uOGVYcld4WldSM2NSYkFxSmRjUWs3eXZvM0xmTG1oVGVC?=
 =?utf-8?B?VDdDYkZQK1g3YUZjZ1NDMnQzMS85NUxxTjYzR0pobWdzYW4vN1gzZzRVS2Ju?=
 =?utf-8?Q?sc+YaK69zFYIl16wIMRAnUGHJflj+cdF?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZUdyeHB0UnBUaDFGNmthSFF5QWUxWGNReGN6czIrZzlGeUJ1ZG02eGk3WVVT?=
 =?utf-8?B?bUcxSytCSEV0dCtXdkNta0hDb1BVVXZQbGhGdHB4akNxMnNwQ2xUcmFiRUVm?=
 =?utf-8?B?WFF2NGJZKytQTnZvSWJHbS9XdFk1ayt1S3piNzVRelo4WFF2ODdyUVVERDBQ?=
 =?utf-8?B?TGlPMml4S0trZU1sKzVvRXZMOEFlbnFzbG1KQ3F3YjZibVBKMkJaSzdJNS9V?=
 =?utf-8?B?MkNSa1d3ZHR1Y3RIbWFLd1NSY2JuY1RkRDN5cllrTDFpTy9qd2d4Z290UStI?=
 =?utf-8?B?TEl5ZHhQTmRMT2FXR2Y3cHQ0OGpaSU5qa254aUwyTi9vNmlsSWhEL01FK28z?=
 =?utf-8?B?NlVTcnNPYnFZYU9EQTh6eTd4aEwzRHVEVmxDOXBUNkNLUDl0ZlVaZWFXMEFa?=
 =?utf-8?B?Q0FMVjFuRjdvazZobDc5MDVHd0dFSmZvUlpXYXYrYXlwd05DWHFkUGQvTklX?=
 =?utf-8?B?b29EVFo1NFdjZWhkYWhzMUJyQnBPcmR4Y05GUmxJRU10NEJpN2VURElvYWFs?=
 =?utf-8?B?eisxRXdwOWpUNFBtZEdhR3dtVW1sVlVNb0J2TTZKaFBpVlQ2R2d0RFRZeU90?=
 =?utf-8?B?RUpsUnlXV3hPbURteENTTVhxL3RjRERqY1VmUHNqS1BKaEp6ZlNaaEpSeHEw?=
 =?utf-8?B?YWhwTnVTY2pRcm1KU3hjbW1Sa3BuVEd2OG5Pb0g3aUFWSGhHdlVlS3NIVnl5?=
 =?utf-8?B?bEg0bmMwYWRQVEIxQnRFWkRCUkJyTzIxVTQxNXdvR3lPVFVoaFgyNnpvOVFj?=
 =?utf-8?B?aE1HSWN6eXk5U09QVjlDSUp6VDQwNzhOVFJTeHlZdkVpYUQ1OUl4SzROT2Vr?=
 =?utf-8?B?bFJOdXhWdlNKcEdrSnQ2bE5HN1VDMTZMZTF1TVoxRk0yUzROZ2NydmRmNExr?=
 =?utf-8?B?MVVWM0o1bU95SWp2ckdhUnJuL2JQeXIzeWpKZTRrWHRvbGs5Q0c0amxRdldS?=
 =?utf-8?B?SlVhdHA3SWNtNDFaekJVUHpmMS9FSUttYkpwMkhZVEEzaDRnRzZPZkZxRnpp?=
 =?utf-8?B?REh1LzdEOEx2NmVWVHh2MnM5SU0zQ0sydjBhSytHSFN4eE5CSFdLcUxEVlFH?=
 =?utf-8?B?ZEFYUzNjZGlNT2p6YzlVUldITnl5RW9TUVlJQmpReW81TG44dmxiMkgxUTZD?=
 =?utf-8?B?ejZMUUJ1T2RyV2dxR25GQVB4RmtFdkovaXNuUExrYUEzOGxqMzF5b1hybmhB?=
 =?utf-8?B?N01DbzZDNGtFWis1UE1Sa1MwWVJ3NWhORlhjMVlyRDdwTUVhZ3RpMHBEdFdQ?=
 =?utf-8?B?QmxFZUhmWTBRREdoVHlsREtpOGtsMW5wYmJCazhqazBJK3o3U01xQVpaQ3Mz?=
 =?utf-8?B?V2Z1c0ZkSEd2TnVpbDNHSTIrcGZlbWFuSVp6SnhiT0c0SVVCdU9pYnVrQVZ6?=
 =?utf-8?B?bDFIQWFNYkFDSmdoaFlUNUJtcEJYTUZUblh6Snl6QTY1bmhQY2tZb3IvbFJD?=
 =?utf-8?B?Ui9wWDAvLzFLVG5JbElyRU9FeFZDQWpMbHBGL3pxQ0UxbHFVUCtUY0FSZDZk?=
 =?utf-8?B?LzV4MVB0Wko5ZHdQb0dWV0ZJd2k2SVZyNk9kNzB1aTJRRnoycEEyUmJiUEh1?=
 =?utf-8?B?SGFDeFV2YzlrSkR6bDE3Ry9iQTJDRjhiN01kTEw0em5NR2x2UGdxSnVaMUNi?=
 =?utf-8?B?c3lhaldBNExnL05NcllWYis0aE1BenJETy9hOTl6c0NZQTBINnIwNmtMalpW?=
 =?utf-8?B?eDBRQ0lLOTMwMEJQa0lDUndXZ3FwdHR4MG45S1VhQUEyNzNiUjdEcFpua3d3?=
 =?utf-8?B?Mmw2b29tVHoxOFcxWXlLdVZ1aU1qajFCS2FGM1FOaElEbUk2UGVkRkV1U3BK?=
 =?utf-8?B?eGNmUTFDbEJNRjVaNHdMcUN6aEpOMFN4YXI4TXA1cDUyVnFTYXZQZnF2L3R1?=
 =?utf-8?B?bDltdnNwNTc4SWI3ak1qRFdycmxOVFloT0doeldKdW02TS9uQUZ2a2tZaUZu?=
 =?utf-8?B?WTROaDl5SlRpL3JYaCswaGlKbDdOWkE0alJzVktFRTdWVStya0ZaZExwaCtK?=
 =?utf-8?B?bHpBSG52Q1VYcjllK0h6UUNmeVI5b0pab2Rtc09YVThBL21WOHA5LzlFVmRF?=
 =?utf-8?B?TUtmdzR2U3AxNnc0Q1VvWWxhNjlaRWdIOVUvOWU4U2FXQnhGcGpuRXRFcjRj?=
 =?utf-8?B?LzBBdHE3eEMrS3JJVzRld3VtZFdzWVZMZm9rU3FINHorcCtlRG96b1VnR2Rm?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a409e1-96fa-43af-245e-08de2665ac10
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 05:45:25.5175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sjKl+c9eVpIy110bbm+qR/S2AzPR8Q6wzU7EX95nxzZVP18XDRUFb7VqPpdl0LT+qoRKLT0IK/GAvlZUdYyag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5701
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Nov 2025 05:45:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20604

Hi all,

lost track about this topic: Are we testing by now a kernel
configuration with PREEMPT_RT enabled on 6.12-cip? Initially, we didn't
IIRC.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center



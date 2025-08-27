Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7618CA0EFF
	for <webhook@archiver.kernel.org>; Wed, 27 Aug 2025 05:55:39 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.53])
 by mx.groups.io with SMTP id smtpd.web11.8338.1756274131906457676
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Aug 2025 22:55:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=L70aDnBp;
 spf=pass (domain: siemens.com, ip: 40.107.130.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D80/7LLOjShIxDpXlxzUk7YYxojzJx3OitQDOc79kU9SOK1SVDZFnEnAI7ND47yReDqK6gMpl7vmmBjYsCT2QqtSJQuReYExMAPDngtWcv+6vpx8pYc9ASFJVFFBTUaBdQUajjZBQnVwh2F2xj/pnGbRXfBYYUU7q28wJeHChYT2+RA7hhlzf/QctZVHveDZ4ie7YY7OrIwCiSfXAWb4pJvak3XQnbE8k+C9qpO31jBKwNtCG0S0QiXvxHVFLE5ivr0NqOAAiecIA8krbaDqx8zSMxOkL/TwBg5y1Nvzu62s4flrahDKQT3dIxMUfRYDwoSXmqb2jA7HbWlqqDlw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVGAFBOXSxUv0Nvmvw3+C41K53xMXFMOZl43jQYAUto=;
 b=tD5jvNzWUTBUH3UHlelHo3AN111kkfcKViiTcGoles3eS4GsfYuSkgx1R1YWc68+qh805Hq8jRXw1bc3z2iqRcy8rtYUkAuP12GLFZFnCouIm4lHicl6Mf8EqCNpETrCW/P8WfF0DeoBXC8K3xoOBxRVneU1SzkHoYtQVZFN6eXmiw5HzNeJStDka4p1KAETj8CSZ2vyyf3HmSoHnlGRB4PrcDo0eXO4sVTKhxzdLey6viNVeyvQ0/vAMIL+G4lhbsA7qp1kgua4hvko7fXEPqBAIniJXXbdPCTTXfS87Up68OxDC60k7VirIos5Urm0csQte/5OdwJKjq56pKqpxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVGAFBOXSxUv0Nvmvw3+C41K53xMXFMOZl43jQYAUto=;
 b=L70aDnBpAHDUg8azkVk6RI9l4Pdii9UMQeRl7PmrwRpAfANylkBclH/X5cf91j4N2J6zHV4y+2c9e1CEYtjVVRtf6PieCwZO8ElbLQbHcrB9fGurlR0spYYDX/P5CTLHdI6M3fjYgYdyBRlHmsQtCUIbKqx2LkYaWpGo9L2xUYLIQPX795jgiixbIxFatUQL5avmcM9VNdJh70L4y1puD2QVaOuCw18u88kGC/MwtQwq1foi9wlRU/8yPkf8kqfGg8xiqJGFSRFstDbrvarjq89R0oXv8pHCb+83XlTo76cvqQfMAk/oJycxCZ+L6OFkMSTm3ocxADFGhkljxyZe0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8500.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:231::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 05:55:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 05:55:28 +0000
Message-ID: <d9939ae1-b511-494c-8382-fe6b36af6744@siemens.com>
Date: Wed, 27 Aug 2025 07:55:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] sd: Add RPMB emulation to eMMC model
To: Sumit Garg <sumit.garg@kernel.org>
Cc: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <cover.1756019920.git.jan.kiszka@siemens.com>
 <43295d5c-c939-42a9-a684-b7d7f3eed4cd@siemens.com>
 <aK2TBkzW7nDobJ5O@sumit-X1>
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
In-Reply-To: <aK2TBkzW7nDobJ5O@sumit-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0127.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::24) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e6674d6-b334-4dcf-3992-08dde52e5317
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YzkvUDFSVUsxTkVWaFlWQmFtTXBTdGZWUk1yeTlyQ2p6RGVpU25ENWZXTWow?=
 =?utf-8?B?Q3B5a1ZuU0w5bnByNUtDWnE0YTdLTWZWdE9YTEYxMklvNkdxL0FOcjRjcWcr?=
 =?utf-8?B?TVA1NjFWSDFDRGRIYkF0aEdmVW9rbXptMjFZK0pKRUJFVVpjN3FNblVsaTBE?=
 =?utf-8?B?UmFLVTBXYXNNM2xRNW9QdlcyWGlqT3lOamtDSHVVMDVWWitLRmhZV0dhUFZC?=
 =?utf-8?B?ZmdZcUwwK0FEcVM0TGVWazRiZzZCbzBMcndSRHNtZklRTzJzbFZMa1hGYklJ?=
 =?utf-8?B?UDZGRHlMbW92ZXdvdjd0WUY1UWlNTzJnV3BNc1NwaFdTdjM0YmdsdGRETDhJ?=
 =?utf-8?B?bm1GejM4Qlh6MzRESTk4YWFRaElFVDNnM3NIREdidTcwaUR3eFVwMmdVblVD?=
 =?utf-8?B?aXVlc1lLSmx4aFVhbWVMUmhTSXJReDY0KzlQMlBvNWNhekxWeXlyQWpxVFpz?=
 =?utf-8?B?dXQ4MTVqUVJwcVJ1V2VkbHhHOWFWN21zVEtCNmtySFE2RitaZEdyMlE4WWxl?=
 =?utf-8?B?OUgvSkplTWV2MFBaYjhxY3J3UytGOGsxcXNZQStmTFpCeld0a2xyeUVpdUcz?=
 =?utf-8?B?QVlNbzMwSDQ5QnRNL3NYWkVRYUtORjNoL2JEQUZRNVhjNzJzcy81VmZNV016?=
 =?utf-8?B?ZmJQSktUc1lCMDNQT25ncmVoOFIrMnlnbVpNWTRaMndRN3IzcXVDLytrdXJ5?=
 =?utf-8?B?SkYzTXgyaW15UkFxS3Y2MUQyRXJjaG5QYzJEckt0bjJ4SS80NE5UL1FSZUZq?=
 =?utf-8?B?dzdhN1p4amZsdGJONWN3VHpQZDl5SWpSaGsvenFiOENnOHNET0VMR040c1N2?=
 =?utf-8?B?Q3lOQ1loeEFXalRGZ0dtYkdXK2Rod0xRZkFHZ3lOcUZ4L0dKeTBuZHZJUTl6?=
 =?utf-8?B?MkJDalF6a2dSb0JVU0Q4K3lheldqRmw1Mlp0NVhkOWw4Ty9OUy82R25QOVZs?=
 =?utf-8?B?OWRFejlDdHJ6ODdyTWUyOHZXVW92NEUrYnJKRmgwVURkR0t3a1B1dzdHcXZs?=
 =?utf-8?B?Wk9kMS9JdHZvV1BYeTZJV01NT2xvbWV3WDhCNC9PbzdYMUFVTkdFZzljRFRw?=
 =?utf-8?B?SVdPd1dEWkpWWGVaMTVxSUZibzMxMExmdHQwQlp3LzQyeHFURitiSmxiSTdh?=
 =?utf-8?B?UFJwSUw2aWRWMGVpd3hra2EyOExHaFNjSUR1emtZWTFGSGZIdnI2MU5iclNv?=
 =?utf-8?B?NThXMDI4eitDTXozanB4MDhIamJKd3QycmtjVjZVY2pDOE1VeG4rbHlGVFRX?=
 =?utf-8?B?OEsyNEh1MEdJaXlxNUZjNkVTY3JVbEdNODJtYUpVNXIzZVk4SWZFZ3B1bGhj?=
 =?utf-8?B?dnRqMjdvS1BIKzFuWURJNHdBdTJQZkY0T2hneVR2cjhmZEN2enRsYmZxNFpj?=
 =?utf-8?B?eUthME1INlAxYUR6R3l5U0tkVGZmNnlXQ2dLYUtBT2pTaTlxelRqWDUyZWZM?=
 =?utf-8?B?eDc2SlhJOUt3K0VpcWZPNEY2cW01ekNlYnRVeUJrVEZkTTMvTkFldlpTY0lK?=
 =?utf-8?B?SzhDSkM1TFNNSlZWOWphOUVNNWltdDB1d1ZHSWFndUdjRmQwcDNqVEwvZFha?=
 =?utf-8?B?c2dkOGU3RkI2U2VVT3BIUFp5ZzZtQ0k3czl0SEh6bGF4YnNPMVZ4dUN2WEdH?=
 =?utf-8?B?L1dEdVUvTEFYOUdNWTRBR2Y1WFNyVWpEM2JjcXpUbHBvKzA3QjZDYWVkZEUz?=
 =?utf-8?B?aEhlRWtTbkZ5c2hOcXp4ejNLNXltYkprRzlZMTgvYStZY1VGRjFuTFdzS2VT?=
 =?utf-8?B?ZTVFVGxjQmdPd1FrWGx3N1BJOWczNyt5TjBFT3VEVVVFU2l2S29WRVkwZXdh?=
 =?utf-8?B?aVRHaElhZ2M5OC9FQVdPOWllcFhkRFh0cGE2ZklKUmFlU1pldTVDVjFrMmpW?=
 =?utf-8?B?RElSUlFzSTdJWmhRa0toVnBXTkZERS9qZTFlY2phWEY0Ukhwdjhab2dCMTdh?=
 =?utf-8?Q?PQPAKnSwgtU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eWs3VzViZmxBZ0czaVZuY2pZSFJxV3NrZXVtb1dTTk1zQWw2Qk55Q3ZpU3dH?=
 =?utf-8?B?TW1Yam9ib0VKNEJNbk1EczhRdFljUDNDaElIcEF2QkRIKzFsdUxpWWcvT0lN?=
 =?utf-8?B?eGN6SGpQOFZCZ2RkL3lxUDNEVlUrN1hXWkpRcTRqZHFGby9TVmFTandPWVdn?=
 =?utf-8?B?Mzk5VFdLU0FDb0ZvZG1Uc1Q3WmZOODNaeXlwMkwzcGNSS2t5VWt5NzJaQzVi?=
 =?utf-8?B?Q0xxZWdwc0RnSjhEYXBMY0FNalZnbThrK3lqUmU0cHNNNFhUZHlFc292SlJS?=
 =?utf-8?B?U0hCWS9ZbFJCTWw3Mzl0bDNBTEZrcHhVWkdsb0ZyVWI2S0NPaVI1ZmVudEl2?=
 =?utf-8?B?cmFVcTBWWmdBbzk1Z01Lc0dBR1pkN3dnd0RCaklPTkxZRThWVWRtTDN0dWxq?=
 =?utf-8?B?NUVXN3VGMko2d2Jtdk5hZlRILzQvWmNEdW92RmtQVFhxNmNSUFkrbC8vMmxP?=
 =?utf-8?B?dlltSFJHWmpZaEZreU9nb3NaY2xWTDBhbkNEY2s2cjJaY09Gamwwb05IeGJZ?=
 =?utf-8?B?SXA1SUR2bCtYQURzb09rZXZ3ZW1jZ1VnUDBlUEpvL2xKL0JzQzFQUmFrZWxp?=
 =?utf-8?B?MlRFMm9MZXJIeE1icjRnYmVrQ1ZLdEROQVlSdG1IODd2Zm40RGpwb2pMbDYy?=
 =?utf-8?B?bklrd0creVpvZnRMQitsVzk5RDZEd2prejhQZzllQzdVM244Q2ZKMjVxRG9G?=
 =?utf-8?B?NlkwUjhjY0dpS0pFSVJkdTVNL1l2WDJPMGswb3VNRzRZSXYzT3BIU01hT2tz?=
 =?utf-8?B?eEc4WFc2aXJIclZ3OXEydWh4ZU9lLzgwbjhFZVJCTHdNRFRxMitrcG5SaTl6?=
 =?utf-8?B?T09ENG02Nm04OHNPV0ZJN1MyKzVEY05VcTJ3UkV5QTVqb1EvSkFqUHlYQlZh?=
 =?utf-8?B?K2lrOHQrMUlqOHBXQXg1ZXhTYTJSeG52NGoxem5VQWJvT2JMenVnaVh6SlE0?=
 =?utf-8?B?YXpZTldQdWs3Um5kL2VrU1NhS1pCdFM3TGE2WGRQckNDTTU1Wk5pTFNYYjlG?=
 =?utf-8?B?d21SN0lwMjNEcmV5M1YvRlorWlY2TGdzUnAyNmxHKzFzbml1YXAxUkdvYUlW?=
 =?utf-8?B?YzVBcXR0anQyY3FOUjU2OGV4Uk84V3E3dlBqWTdNT1ZHUUd6aTdjcFg5ZTN6?=
 =?utf-8?B?Wk5zRDZnMHQvWlVweVd0SFlicitUMG11UjduZlphUlBjeFhTelRDSUdIdW8y?=
 =?utf-8?B?a054OXdYSGtEQkt5TFo3eE5yQ2Z5VFZ2eUgvQjQ4N05wNXlkUS94M0tQa1VV?=
 =?utf-8?B?UmNJSytMMnlQNmZiaUVoZFBXc1NoSHlGd1FHRXBUUWFwdjQrMk1pczR0cmZ3?=
 =?utf-8?B?Um9hWU1kYjFxZ1VGbDRZdWhlSytkZ3hjU1MwVnkxWkpIMFVvWmwwejdmOVpS?=
 =?utf-8?B?RmR6TEZTYzlQVTFSQjAxYzUvTG53Y1ZOb2djYU0rRllCMHhMQ1N2SDgzMjVa?=
 =?utf-8?B?anhiODJBdmMwU3RoQjRkbDJrWFJ4SnhKTlhRNURwU0Y0VVlabFJCK1A1eTZE?=
 =?utf-8?B?S0FuQXU3c25HTXBFRTFSeTVObS9qUFBzY09abmVFOCtYYzlkWW9VRGVJRXk4?=
 =?utf-8?B?b00wRGE0Z054SmFPd3M3YjRnUWtyOGZacEJhbDEzcGpZYVI1cUtBT2MzRXQ1?=
 =?utf-8?B?bVlMOUoyOWtNS09ScEZsZkhLTHQ1T3RiQ0lJTWY5Y2dtTEV0dVRZSGd5Q1pS?=
 =?utf-8?B?NHl1am1iUWFxMW9XNWcrVXVKOGZSdDB0WEJwV1drc3VEL1FMRkZhTEYwdVFM?=
 =?utf-8?B?S0hyQlhnak15UXlZbTMrTDNYbDh3dGVhQ0Z6WUxiYkhXN09Bb1VaL0o2Tk1r?=
 =?utf-8?B?L2luVERrZWVGR2p2NU85QXh5dTNOb0xsZ0djeUF4UWhJZG5PSFV0TXVkUDQ3?=
 =?utf-8?B?RUtqUXFUdEE4Vk5GZ1NOYmJiQ0xIM1lJWnhHMzVYeUUwa3RxUERKc2dUeFRP?=
 =?utf-8?B?L1Zpai9GNFFuYTF0VHk1SUZNbnhmQzJpZ1pzN0dENDJjVWM3VGVmZkhLOGlY?=
 =?utf-8?B?eExVUGJNUnJ3aEcza1RjT0R5THo1clkzQ0lzZnJaNE9CSytqemZVWWdpZ0Z1?=
 =?utf-8?B?TGhNVTNrWWU3VXBWWllMaDNZa0xRZEhFc1E3YkFlWlZ6UVJiUm8yN04rOSs4?=
 =?utf-8?B?WjRHQnZvVUNqWFZzQnQxZkR1VHMrQ1pLSlUxM0xTT09WNUpGL1NvNTloYzZM?=
 =?utf-8?B?VkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6674d6-b334-4dcf-3992-08dde52e5317
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 05:55:28.3740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzwu0CCGWU/erD7ENI8r2CgXDbUpcRRqitxsfsAxGQaPaYT+y/iAoHJycM9X/hHg0VS51Y1UbPgM/YRXt2dC7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8500
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Aug 2025 05:55:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19970

On 26.08.25 12:57, Sumit Garg wrote:
> On Sun, Aug 24, 2025 at 09:41:06AM +0200, Jan Kiszka via OP-TEE wrote:
>> FYI: QEMU model is working fine, upstreaming started, feedback welcome.
> 
> Thanks Jan for sharing, it really enhances the testing capability around
> RPMB based secure storage.
> 
>>
>> Jan
>>
>> On 24.08.25 09:18, Jan Kiszka wrote:
>>> This closes an old gap in system integration testing for the very
>>> complex ARM firmware stacks by adding fairly advanced Replay Protected
>>> Memory Block (RPMB) emulation to the eMMC device model. Key programming
>>> and message authentication are working, so is the write counter. Known
>>> users are happy with the result. What is missing, but not only for RPMB-
>>> related registers, is state persistence across QEMU restarts. This is OK
>>> at this stage for most test scenarios, though, and could still be added
>>> later on.
>>>
>>> What can already be done with it is demonstrated in the WIP branch of
>>> isar-cip-core at [1]: TF-A + OP-TEE + StandaloneMM TA + fTPM TA, used by
>>> U-Boot and Linux for UEFI variable storage and TPM scenarios. If you
>>> want to try: build qemu-arm64 target for trixie with 6.12-cip *head*
>>> kernel, enable secure boot and disk encryption, then run
>>>
>>> $ QEMU_PATH=/path/to/qemu-build/ ./start-qemu.sh
>>>
>>> Deploy snakeoil keys into PK, KEK and db after first boot to enable
>>> secure booting:
>>>
>>> root@demo:~# cert-to-efi-sig-list PkKek-1-snakeoil.pem PK.esl
>>> root@demo:~# sign-efi-sig-list -k PkKek-1-snakeoil.key -c PkKek-1-snakeoil.pem PK PK.esl PK.auth
>>> root@demo:~# efi-updatevar -f PK.auth db
>>> root@demo:~# efi-updatevar -f PK.auth KEK
>>> root@demo:~# efi-updatevar -f PK.auth PK
>>>
>>> Note that emulation is a bit slow in general, and specifically the
>>> partition encryption on first boot is taking 20 min. - we should
>>> probably reduce its size or understand if there is still something to
>>> optimize.
> 
> Can you try with KVM enabled? I suppose that should allow you to use
> Armv8 CPU Crypto Extensions.

Worth a try - will pull out some raspi or so and let you know.

> However, do you host a Qemu branch with
> these patches applied? I think that would enable folks to use that in
> OP-TEE build setup.

https://github.com/siemens/qemu/commits/queues/emmc/

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


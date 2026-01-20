Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8524D2ECF7
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 13:46:06 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6643.1768916760169516772
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Jan 2026 05:46:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wUODCD31;
 spf=pass (domain: siemens.com, ip: 52.101.72.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g758Us6QRZwjJrvDa1Wr1cEFdJK9a3MIr/c/+rxnlnSeUkiu6x+A2m82IfEUyFF1pTaY6EFS3wOSsvy5J5b1HxxP1Pz1eWtCxrAabDSOwnZH4Ffd0vJ39LpGHLzvB8VBR1QbUhnynVVKOuqqg8Ces2xjMAagtiJwh0RmNOpCK7XsVWRnrQrM4ru/kU+MXZ0TmfNTWOoiDJ4IFCdZwXnL4v57IkP6rCRsDOWVLlHQGEvMf8yu//269EfyPiVDVnBXR0+eV35aG1oU6x2bmzXwV3xJRkRKjOHLY/KjzvYzlcN9HZM1GSEjjnptMsVL3T6j2YB+m+zD480uOtMvAHU1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uM/LlY6h2oqkQATRPEDQSb9EbbLrx64gkSnY7M/6xo=;
 b=DudjeFdKaxwFRb8dOXWgzc9Y7VzQEzffyMNjro7Rudxk+Xp873qJV9jBwu64EdCSp/R566Zwc5EOj//KTUFvZwjIrIryAGhING9JWfvxjXVQ+zZ6tvwXxP4Pm3Qo5nG/Tk/QlQbWXJBIcPQiDi3ApIjrcYgbUETFiUBvW/nOtLzzoGjkwpspkVhSk5VXVBAugNChs5BMkIp8fxb+4wnK2l/zPTKFW3QBqQhAB0GUklfDlKtzHFrcPLCuTQyVP5ql2bShiUjMBBm7Y61Pr9k75TffEsdjTNhbuOzTsDi9o1sA8U0dAbihAuTrooaFutwdpPrJcIOo7PezV1sXzRwBfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uM/LlY6h2oqkQATRPEDQSb9EbbLrx64gkSnY7M/6xo=;
 b=wUODCD31TlT0aRuV3bn8gmnlp+yRMcKcnPsn9U1drXnyPoYSpGTQFmI/XvbF8GaOPPl7lCfG1trKb3tDGbu3t+QvyJyh6DouZMluHxAWL+76IDNpUrRMZjvifsSD8LeHDaU7/2vfCksYYvHZV9wBU0keOYSR06kX6jvi3vbI5aB/90nQybKP97ryHyI7gxzOeQGUB5AMHlsWAz4OP9Gt79PwU0/QYgY79oC4sSHVd2CO3XKYI1h3S1DqS4+APk51itJN1vpt+UWnWFMnKwO31ikxMtAXYTVxW8cItv8M2XPD9c4uYjoolrKCLb6BjQ19nn+VRH3CTxM+Mw2+KqTLkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6673.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:565::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 13:45:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 13:45:56 +0000
Message-ID: <ae813b2d-de39-4510-a296-526f53394dba@siemens.com>
Date: Tue, 20 Jan 2026 14:45:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] fix(swupdate): register vardep to
 DELTA_ZCK_URL
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: Adithya.Balakumar@toshiba-tsip.com, michael.adler@siemens.com
References: <20260120090944.1461382-1-felix.moessbauer@siemens.com>
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
In-Reply-To: <20260120090944.1461382-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0026.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: f110faa3-392c-4a15-8e60-08de582a3cb5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VHYwWHI5WXVydFBSN1dqWTRGMVZ5emdMZExjYmZkYUtFUzUzNXB0NUJvZUlt?=
 =?utf-8?B?dVBGc2NvcExzVzA0dDZ6NlgvUlY4OW1pb0J0SjZKY3hXaVE2Q2pqemp6TDFl?=
 =?utf-8?B?MHI3ZGdPOGlKUmNBcEpCZDhSSnRvdGlPU01vWEE4RnhHQlBrbWlDWExaaFhC?=
 =?utf-8?B?Z1hvVyt5eC9JelUyRmI4aWQ4bFRaTFBkdDBXUFNGNlF0QWZNVkpkKys4a29D?=
 =?utf-8?B?OWpvbXlocEl2NjZ0WW5Bd3hXWWtCRXJ0VFVPZVV2WTYrQ2hHR2o4czFnemJD?=
 =?utf-8?B?TkJaZDhUaE92RnlkU1BRWU0vT00wbXViaFZzMUtmR096VW5JWnlxc1FTWUph?=
 =?utf-8?B?cHJrWEoycDRiYXA3Mk9tazREaFR0akViMWlHQ3hJb1h4NlJsam53VVJzQXo1?=
 =?utf-8?B?S00ybnduQysvbWcxVE1NNWhNWllPWkZnTk9DVjFuNjQ1djRnNEJuZEZINEdQ?=
 =?utf-8?B?a1lEVGVZK2QxNFdIbWFzZjV4bkZNY29YQnJWdnRnUXBXVEc1ZGdLaUtrU2Jw?=
 =?utf-8?B?dCtaNnFtUk8yMURBaWNyaEhoZnZncVQ2a1BTbkhCRHQ2YjV0TGwxNzJtZWRp?=
 =?utf-8?B?RzZHQzhpR3UwYTBqZlpLY2JTTmF2b1J4SXNSSklXdU4zUWN4cFlRc1ZTdjJR?=
 =?utf-8?B?MEFZZ2IwSXlpL0lyUGVITTd1TGVEb0lkK3lINElBUkRveG1BTjF3c3NZZWt5?=
 =?utf-8?B?eXlLTnU5MHdYRFhPTEVpMG9sTExXdGdEQjZWeDVTblRwenJiYVNjSUdmSnNU?=
 =?utf-8?B?SEE4TlFjSXFlbUExVzFia2d0ZTkyS09GdXFOVXh6V0hrTXNsZWVUNkt3Q3pU?=
 =?utf-8?B?K0RoL3NMc1dMb09LcE9xZVBzMHk0MStIYWpZTzNXWk9nTVhneWRQdUNpWnFi?=
 =?utf-8?B?dzhwQ3hpb25LYjVwTVJZZVdnOENTUUIzVmNyWmhrMUVhR3pSN3NVUm94cnlk?=
 =?utf-8?B?L1FNOVY3eit2cmJQVndxUnlPdEVhbmkxYzNHQWJKWjlMR0RKZENjaWFuOElq?=
 =?utf-8?B?TEk4cmYwTENGblh6OGVzZlBQNlVmaEljWGFqZENaMXQ1SWdaVVFEM0Nvd1o5?=
 =?utf-8?B?bTdtVTNmUkJJWi94VUhGK1VzbTNEcENUQ05XdytCTzllUlYrV3NNbit5bXpS?=
 =?utf-8?B?aGdoRUVENVdiNjd0WHhtQkc2ZEpoNm9jbExvTDNncVQ2anlpQjhoN2hvSGdo?=
 =?utf-8?B?cktRK1h5OEgrKzc0a3FIY0lzNHo4Wk14SVdpMXZUYWxmdy9Eay9HZHVSRThX?=
 =?utf-8?B?d093RmZPRTFaamYvNlRmYzlKbEdVYmF0eG1Tb0RwNlFCdXNvZGora0xqRFRR?=
 =?utf-8?B?d0QrNDIrQnZJbmQ3aGc3RFhaeEsyQXk2ZldkYjV1T3hsTjZkRU1SMytKbWRQ?=
 =?utf-8?B?Q0QzV1dLSnU5aWsxU2M4Um5nSlk3K3NFbGc5bWFqb0cySmZRSmZEVzFKSCtF?=
 =?utf-8?B?TE9MZndEL3NDUURaRjdsTHpOZFZpbEswOEZ6bnM5S00rS3RvOXhPeDBpSExx?=
 =?utf-8?B?eVpTMS9CNTBzcGhsTFRrSlRJd1ZEQlBVakEwRW5YT1N1NE4vVFJ3SE1PcXlT?=
 =?utf-8?B?eUtvVUs5c1diK0N0WUExaWQ3Wk5vN0RQTzRTcEd2Yi9hdVNxOUJYRjFmTkZi?=
 =?utf-8?B?WVFBZER3aDVjQ3VRM0lUK0RoTTR4bUJEZzJ0Q3JSRElQUWdQVFFJVHNjRW5T?=
 =?utf-8?B?Y0ljWkVXTjZGcXExVG5MKzlHZTJzcTljMnBROGxNT3dLRjV0S1lFdUZwbnox?=
 =?utf-8?B?aEU0aWV3ZitHc1dURDk2UFV4UWtEMGR1bitkRWJGWVhkN2syMEZZTVFiazlp?=
 =?utf-8?B?a1pZb1g3WDJEUlpZQVlQa1kyQm1lKzFDMmMrczA3a2VzT1NsdmkwK3lZWHFN?=
 =?utf-8?B?d2J4ejlDaXgvdk9wYjJKSE16a0E5U1cySUFRVVdGbDgyS2RFdjFkSDhJT2sz?=
 =?utf-8?B?eHV0QnJtWkkwMHRJazVCeU5BZVB4SURPM3BaSDVaTUhKcnNuQUUwR1NYb2Nq?=
 =?utf-8?B?K3U1dk5ibm9mL2gySndiRHRySXVDcjhSNVZKR053U2pkcmNWUFAzMWhubEkx?=
 =?utf-8?B?WkN2cGJBMGJMZ0dUdVU1WTU4cGJ6R0xocTFSQUYxekdBa2JXRnpYcExXOW5l?=
 =?utf-8?Q?2qzU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ekJaS3E0STdvNEthYmtyS1dpdk1EOTNhaVB0SzVPS250UkZWTHVWWkJVRGZV?=
 =?utf-8?B?Y0tUTHUwcHBwSW5xSEx5RDMwUk9KMXV3T01Na1hINHBQQzhhTVJYRHpodGZG?=
 =?utf-8?B?MGg4cDJQaExLUHhzOWc5ZFZVeitGbFp1bzIydW9RdHl5a3g1N2U4dkQ1MENM?=
 =?utf-8?B?d29XRkhiUlcvUHo4alFKSGVTWUFLaEM2a1BFMjFrdVVHd09TcnhiL0xZdytL?=
 =?utf-8?B?MWdZenNsZFBMZFR5SzlSZ29BRVBuOUtUSGlEUERCa3U1Wm9zaTIwUUNZZWsr?=
 =?utf-8?B?cGRKVUdLSVg3dzZhaEJXZFJFamZnWVh1OCtOc2FXUlhCdTNvYkhMNUVlQkxz?=
 =?utf-8?B?elIwemlXZmdDS3dlaWsxM0cxSUExcjlEZzFQN1V6L3l5L1FGVDVKaGVIT2Rn?=
 =?utf-8?B?UC9BcXROYkEzSnZhZmZ5ZFpSeHZsRFhtYUVjN0hMZ1Blbkxncko0Qy9BRlBt?=
 =?utf-8?B?czRrS3IrazloL29yZVZKdmZWMmEvNDJURVB5ZzFZeXpiNzZ1WVRlRVdHUXpa?=
 =?utf-8?B?MW9VaU5wMGhZbjhzYnFEejNOdjdoL2N5VWU1aGxMSHU0dzF0RGdzYUppNndj?=
 =?utf-8?B?SkRjTGZOV09QSnp2cEwxb1FIcGlnNUsxQmxPKzZTd1E2TzR1RFBVOXIrQWZ1?=
 =?utf-8?B?YURiSTlDZDV6QWtRUVdRMm9pWnEvRk9ISmt4djdySTF1WjRyblorZHh3T3J2?=
 =?utf-8?B?TlJBUForblplOWljV2YzcW12M09aQVlxRlhlK2Zuc3I5aXdJR1FtV1lDUmNr?=
 =?utf-8?B?ejVoZ3ljbW44cGp2R254OXZwVkhVd3ZtcUczbjRQbmtBdmk4eHQralgwckg3?=
 =?utf-8?B?SEd2cHpKRWE5TmQrSk9WMG1kN3Nhdk14UmpFaE4vS0pMSDBiODdUcS9rNkJ6?=
 =?utf-8?B?bEVDbVZLUWgxUUI5VUlHVHNETGhHeElSSEd6WW5JendoaWwxZFpoTW1HdW5n?=
 =?utf-8?B?UHFhL2hkSVNjb2FhSmpGSUV3VW1LK0hjSkZHN2tGL3UzWVZhMzgyeTBCdjlr?=
 =?utf-8?B?QWViVm5tdlRINktvNitrbUovQlFxeU0vditRL2s0NlgxV0FZMm1sTldkQlFY?=
 =?utf-8?B?Mmk1L2pUN2lPVmlzVFpEbm1vVCtvakIxbkZTTlJjK0ltS0NqQzNBOHNjYU4y?=
 =?utf-8?B?U0N4TkovRTcrK0ZoMWYyQ1JiMFJBQllhR2hTTTBiVVY5YmVkajY3S0FnU3lS?=
 =?utf-8?B?UnpocG9yMlkzOGRONk9TMGtqRTBzN0RTV2VZZE5sZk11UlI2UGVjdnh1TDRN?=
 =?utf-8?B?OWlySzRtU1A3dDgzRFo3KzJQT0dmZWdtRm90ekhKdW1WT096RnNXMEM2VDFV?=
 =?utf-8?B?RG9KV25ETlRXVXRZWFkrTlZJajBnMzdOMFZYQzU3d3o4cXYxcU9oTGtHS0Vr?=
 =?utf-8?B?RHhKSTNaMDgrcERjL1JRVmplcEVhTUVYaVFMczIyWUk0K3didGZ4SVUzVklk?=
 =?utf-8?B?SENDM2JsSGN2dnVxbHUwcXRBVDFlVzM0di9ENmp3aEZmamkrUDQvb1RUZVNM?=
 =?utf-8?B?dUNBTWNRbXdyMUNQK1B6d1I2Z3I2TldvVGpEMEVqOGNMOUdkY0NPNG5BTEhJ?=
 =?utf-8?B?NStDbVBMdk1ORzRUSTF3ZWNlRUM2RGUvQUZsZVY1Q1ZzeWpiZC94ckpoc3VB?=
 =?utf-8?B?NDhGNGJvYllRcTRqTWVKUUViN3I5TmVmbGxiUnVJaWxwanRMVmx3bGtNSjYy?=
 =?utf-8?B?a1NKTGdRM2pTOG03SFpQYlc3bE14TCthZ3d5WWpNaGxNWVZxalRFOGxrZkZm?=
 =?utf-8?B?Ump3L3R6N1FqQ0tNUmRmbHJ3cHRXVjJHVi9qb3JnOHN3d3huZHArWHR6UUx4?=
 =?utf-8?B?NnpLeEJrSjJNc1ZBSGVVY0YrQTJBUVpSYUc0cWFzVWQrTDdNVFJVcjNTL05H?=
 =?utf-8?B?eEVkT0VSRXFXdDBKRnQwTGN0VjZwbDJDckZiM2tMcER3dk4xdDlnTk1CV3h2?=
 =?utf-8?B?aG1ud2E5RGt3RGxCNWxTekRiQ3FQNUlpVkZzbklYdmxHNHd6bXBBZjByUmc1?=
 =?utf-8?B?L0N1WlJ3Unh6SWYwZ21jckFpRTBIYlY1dHB3UVNVbVdoN01Hbm84bkZZdCtv?=
 =?utf-8?B?YUIvOHBTRFYxOFJqOWtyMnI3T0xiNmJ6VjMvVXVIWHlGZGx4MDBWcjFEcVZF?=
 =?utf-8?B?UEJpUjVLNFlxUjZQVkxDTitKajhnTzgyNEwzRGk1WkluY1VXcUl2cUpmWXgx?=
 =?utf-8?B?MWx4MThody93Zy80eUhscSt2a3Rneis1ZndxR1FSdk9VUkljSUp1K21MSG4x?=
 =?utf-8?B?RUwrb1JwcG5XWXh3azZoOFFyN2lZY1hYdU84TTg1TTZHMTI1NVRCcDJpeHpG?=
 =?utf-8?B?eDhNc254UEN3N1RVY1dUZDdxSjM1SnJVcFhOY0lmQmo3SWdOR2xtdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f110faa3-392c-4a15-8e60-08de582a3cb5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 13:45:56.6335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUL7Zke5MFXKdUcWtEgz+LOxprzrwpIPREwBK2AbjtyDJEO3AQqsMWyjPkkTF2w7VlTOY7EUeZiFZhodrWHT5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6673
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Jan 2026 13:46:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21686

On 20.01.26 10:09, Felix Moessbauer wrote:
> Changes in the DELTA_ZCK_URL were previously not detected, as this
> variable is evaluated in a python function. By explicitly registering
> the vardep, we ensure changes are detected.
> 
> Fixes: 599d36b ("swupdate.bbclass: Generate swu for delta updates")
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  classes-recipe/swupdate.bbclass | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/classes-recipe/swupdate.bbclass b/classes-recipe/swupdate.bbclass
> index 21d881d..59dab9f 100644
> --- a/classes-recipe/swupdate.bbclass
> +++ b/classes-recipe/swupdate.bbclass
> @@ -80,7 +80,10 @@ IMAGE_TEMPLATE_VARS:swu = " \
>  # TARGET_IMAGE_UUID needs to be generated before completing the template
>  addtask transform_template after do_generate_image_uuid
>  
> -do_extend_sw_description[vardeps] += "SWU_HW_COMPAT"
> +do_extend_sw_description[vardeps] += " \
> +    SWU_HW_COMPAT \
> +    DELTA_ZCK_URL \
> +"
>  python do_extend_sw_description() {
>      cmds = d.getVar("SWU_EXTEND_SW_DESCRIPTION")
>      if cmds is None or not cmds.strip():

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


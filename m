Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1544BD7879F
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 16:46:21 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.2])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21075.1766162771920535362
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Dec 2025 08:46:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KLk/JQk0;
 spf=pass (domain: siemens.com, ip: 52.101.72.2, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggSKQ9hZHfijj9OeoQv8xr3WWl/1+PhV6WoreR9bKD7K2C0IFfvS+vat6ysIx6wAAGlNF2h9BOjN0NPtrrN/cCVJ5T+Ky1kZ2zMmPA3TztnRfARfTm4Dxkds6mOl4iXaKG/7GxUmALbh55mecGiy4vOChMbMOsu4NqrmhRhlI3f1RH6H2DSqb6b8632rnyfqpAl3vhIRafnEk2v3tjlXrFnRIh1ADyrL9xv0ybriob9jg5C+QTrJoJu8hKDyiqHkVSqDezGwsG58CdT3hDBK9/y5sckL6GVartW13zGm4KQ99PCJYrBlsBQmiO40KNu8bC3m7A32AifcDFVVmPmWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGLfFkhZF0NsPw5+BhnhGlLgKwLvNn5yMn42xFs2jNc=;
 b=ipVj/XmiIC8NAQtAw+uY4j2DwkyGGOMEcMlB3Pxhd4XcG9KbY4JDoJQBP3Xo7KDsjcFZpYR5QqfrzAWK6Log+BYkaoPwhfDkhnE9nIcGEoMlDUxEcSTlfyvfujsz5GRt+0rIvpRh1cFa5GGPg4rfSRpK4H4pKJ5LDvK3cUlaTIlCTJvtUirqPfV+glsp2V8brez6Ex71KWoflUNV/+n1tpfgrEPGdemZKDpgeCzwdxQRS5eGHH/NhYxP3FUyQfO/YN633k7tk9mXWmJFSuYwa9J3SMc5zWGZ6jQxgpiek4cSzGq6M/EOR7UQJB1jkubaQkAprjLD7odDT+FY+vQnNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGLfFkhZF0NsPw5+BhnhGlLgKwLvNn5yMn42xFs2jNc=;
 b=KLk/JQk0BrlT1M/4mj2AD1QwSqs6L8ucG7vPsKqh1CxuHO54duaEkHAoP7XNcIIfdjvT3k4rLkLyvn4CUQqvbm0HdMIuXbJiXpI1egsvu3/3uMAwbJq5cAgrdEvvm8yQc3xIGkKHPWK9ICeS3L5us4JBi+4jINHXmqQGyQiAGh2lsK96paBaRNTEvXz9w2PZQl+uqxa13bgt5XOR6egvuZGSE2VXqhDNXfFfWRE4IDIY1EfR7RnmsjnGnkIrzpJfMbCJ+n76+uQCs3Kl9xzWAZ7832QtjGr5B5fy0gvi+v05V2PFnumSiCLpyFODp1T2hWiaMGY2+Rno24m0ACtNGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Fri, 19 Dec
 2025 16:46:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 16:46:08 +0000
Message-ID: <87391c27-4287-44e0-9f0b-c846fee9f97c@siemens.com>
Date: Fri, 19 Dec 2025 17:46:07 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.10
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: d86a42aa-2f87-40db-fd1b-08de3f1e1bc3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UlVXTFVOSXQ1LzF1NmVQVjl5ZDZIS05QOWxwUU5RUlRFdjdyRk9rREphRXJ5?=
 =?utf-8?B?TXRJSUthb1hUcHhuWmcvYjNTZlF2VlpodFhPM21HcWpsNFdYTTVkSGpvaWNI?=
 =?utf-8?B?YzRYK1NHazFLTzEyTlllY2hlQUFLSlM4d2ZKWndpNmV3Q2ZTR0xrNDVkT0Vw?=
 =?utf-8?B?YVFUc0MrUzhjcGg1VWpqdTBsTU92ektJcVB2TVdtQit5dVpaVGVxYmZBQkFC?=
 =?utf-8?B?TVY0aGszVDdxd3czTlppcmhKRTMvcDVubkFtU3Nza1dHL0VGaDA2TkNaSjVl?=
 =?utf-8?B?L1Nyc1Zvd1M0aHVicFVOMG13eW91NzUwM0ZlaVJHbko1TFBNTCswRHhLaG9X?=
 =?utf-8?B?Wk55TVdCMllCWUo1bW9EZ0lyQU1XZTJJb0hVUE82ZmEyRC9tdzBFcmhUWlB6?=
 =?utf-8?B?NjgxdXFzbnkvQjhMbExSK2dLQzJFcU1yR1YwcXFtYU1wRjNQb2VrNVdtRWxt?=
 =?utf-8?B?Z0xnbUlMY1V0YjRGMXFNakN5by9DNzhpblBId21tYVEvMG1CVHdyd1pOMlNI?=
 =?utf-8?B?blNqYlluKzh6WU5kUUhPcU5LczZrbWQzRWF0UW41T2dBb0dlR3huRkc5TS9V?=
 =?utf-8?B?Ui9BYUhWdGQ5TGJaVlI5dzZiUWhIRDViSkhZNGszeGdndEtrbENVNXNOazlr?=
 =?utf-8?B?REFEOEw0T01ESHU5VjQvU0xJbWJNdmd6NDhCY0NLOU92YmhZSVVGWktWRDFO?=
 =?utf-8?B?WUVlUTg0TlRnbUdsZ1RTcmFua240YVU3MUQyRDA4eTl4WWVGZXYzWHFHQXhQ?=
 =?utf-8?B?MGV0bi9CYVZCYnY3SEdvWWhyNXNxcldkdFE1RVVmQ2pXVGYvaUorN0ZmYmlS?=
 =?utf-8?B?dER1TXFMM0QwMUlpVUFPc2JQaUYxU0M4cUFuUFZueHBIenZxdWNBYlVZRE5N?=
 =?utf-8?B?Z20zcEdJYTRXZVNKUldSeFZZaTVTMVpzUFRhWC9DL1VXU2htL01VNzBmdjQ2?=
 =?utf-8?B?NVFhWGk4ZXV2THQzNWhFaTZIN2FsSHVLQjh5aVNQK1lxNmVaUXA0NHFOengx?=
 =?utf-8?B?R0lhUjVsa3ZZU1RzU3lPbS9HRGtrWE45TEd1WTB4UTdMQ01JYVRySlhaa1BN?=
 =?utf-8?B?QWh6NXNmdWNITURxRjZUejJ6VXkwUjNKSXllNEVjMkJ1UVdjanRweFNYV05J?=
 =?utf-8?B?aXl1bndCMzVjZ0hFS3JQTVZTTE9xclpIblBYMjh2WU9TUXczRTN5NHFmYncz?=
 =?utf-8?B?NW5NOGRnZ3hFNVBrckprMlgrZ1lEcXZHaFZDRlFHd3BDRllUTFhzN3lROWNy?=
 =?utf-8?B?azJGTnVSdFU3NDBBQm5HRVZadUdYbDROSGQ2ZVNPY2pRV3NJNHgzU2VhS0pt?=
 =?utf-8?B?Y0lLeTZWUlE0cVZsV2RZbmhxQTBuZ2c0ZFFZbExYVG5LREtLYkRvZzVtakJn?=
 =?utf-8?B?Q29KajBJQ3lta28wNFJ1NW1WYVpXMThJRVhnZEU4N2dUY3R2WjZnMDBjRnJD?=
 =?utf-8?B?QU1iLzJ4M3F2RDQzWThDMkk1NzdGOS9VRFJvUlRweEx4WDJqbzhsSGNObUVL?=
 =?utf-8?B?WEFzMGVJZzVTdFNHc3JKamJPN2NKSGdOSk05N0RoYUZ3QVhCM1NkVXdBU2cr?=
 =?utf-8?B?VHdnYlNuWjU4cWIvd1d2clA1YVhWVlF6VzNCTlVDMkJMcENoM0QwSlJOUkJj?=
 =?utf-8?B?Y3o4T3RlWGloakRjc0R3WE8xSjkvWHJBZ1hyM1FOa1FCYVRQTTVVT2laVmxE?=
 =?utf-8?B?aXRGUklUb2tXcjExM0JoRTVTZENOb3B3b0VCNWZsWGdqczlLWHdrejIxN1VM?=
 =?utf-8?B?eE1zZVErM0JKOGJvdmpycjlKYkI5Nlg4UzhjME5NNFpML1pneVFKRTNLc1Zy?=
 =?utf-8?B?aTRIRUg1VG44SHhZWnpkTFFlU1FQRWJPbXNCM3FtWDZ1MVhHWGkwM2V6RXZK?=
 =?utf-8?B?VmplRm9WbWI5aE41U1dKcXNsNCtBaGFWQzNjaCt3Nzcxb25JcHA0alJtUG4y?=
 =?utf-8?B?bWozbHIxbVJjZ1Q3cW1hRTRtdEUwZWF3WWRiSlRuZEVHV3FHWmhScFJXbU41?=
 =?utf-8?B?dVpEUXhqQjV3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TlNYMmo5RzlDZFpNd0lkanliYXFNaUpOVzJaOS93V01NcUFpMGJhMUpxQXox?=
 =?utf-8?B?U1ZibEh0bkNSWWdMZHpNR0UxSUZGNXB0Q3BHcTVTa0svWXNwUjB2UG5vSlR2?=
 =?utf-8?B?NXV2bERaQXpVTzRkem1USFBXaGpkMk82bnNybE10V0tNQmNJNGZGU1dpdEUz?=
 =?utf-8?B?Ti96NDQ0WjQ3QXpVYUNGc2szMnF3Yk9CS3hBRGpPODZiTkV6YzUzcWFZOEwx?=
 =?utf-8?B?WUZyLzBqUDNBa2ZxbXp4d0lQS1E4ZGRtWDU5cGhTcHpMcDdTcTJMZ2FPWnNu?=
 =?utf-8?B?L1Y5Z05yM2hBOXZaQlp6Y09QT1d5T0E3MzB4OGZxQWNac2FVUVF0TXBlM0Na?=
 =?utf-8?B?TVJ2RWE3V2xpdHI1N0VQUmxnTVZlbkI4Q3kvMFFMSHhzM1QxZk9Fa1dZTnp4?=
 =?utf-8?B?eDl6MTVTbGFVUHJvanhscm16VU1RaXdXZGZBNlh3UFBQYS81a1VMR0J5ZzNs?=
 =?utf-8?B?Yi9IaGpsRVpjdkNQdzg1a28waW1jMXNKZW0rMWdNRFpNTlBqaC8zLzdVV0Ju?=
 =?utf-8?B?UmtTVzFyMXRDaDJrTVVEUUxTdGFOZEthS1B6UjgwM3RjSU5oVHMzcElPaGVK?=
 =?utf-8?B?L2tMU2RhTXhJd2hiMXVScjN6aXFMbWhjVkR6cUU0U2FwelVEWnNYWVFybWlp?=
 =?utf-8?B?dG1xZzRjRWlUeE5CRDFCZmpuWktnMjNwVityaVk5WmZ1RThYbTJMQ21Kbldv?=
 =?utf-8?B?eFEyMW5oUkduTFRkR3lvdm91Z1lLelVzQlc5WU41d2ErVW4xOEplN3RYd3Ex?=
 =?utf-8?B?L0RXeS90UzRLbUhoUy8xQmJOOWpVZ3J3R2hudmZJQ0pDUEdENGZjeUg0bHNy?=
 =?utf-8?B?N2Q4ak43aFlqN3UxbHI2SU8xSW81QkFWamhhS1ZRUlpFL09qaHJmTDhsdFRI?=
 =?utf-8?B?YkxJeFEwWkhCVDFBZ0NmcUY2ZjI3YUE2ckM3K2pJSkJIVzlobkVxQjl3TjNT?=
 =?utf-8?B?dXVJcHlpS0M1OTU4bGE1emhhQm55VEF3WUdseFE1bGtVRFJMSEh6aS9oUGFW?=
 =?utf-8?B?SGNpZFVPdWMxUjlLMnJyNnRGOGhNR0F5dWsxb0JKKy84WXJuemY3aEZyemRD?=
 =?utf-8?B?QWdMSFo5cU9lR0JTdXg1ZUE4UVJZNTdpakxCQlgzR2poeW5vSFBranJxTTkx?=
 =?utf-8?B?QW4yY3hHUjk5N3dRWkpXRS82OUJvNTBSRUpVb1NlVU83aTZHckhERkc2aFQr?=
 =?utf-8?B?cDQ0SjVOUnZUSUNrQ0dRN3pndDl5MjNEN0syQm4zejBNUXBxWmpVTkRsTmVF?=
 =?utf-8?B?VGlzOFYwWE5vV3JJcVhJZkFxUVBDdit3aTNZZWgxb1F5Y1ZyM0xOMEpDWm5G?=
 =?utf-8?B?ZHprc1hleEpoc20rWHRLTG1yYlBGUVhyMWUvbkVjOTJMZk9zbFlzS1VLekt3?=
 =?utf-8?B?MW5DdXhubVI4Z3NWZU1FbndkeHU3MGxBRGZzTi81MExwTE51dGVTOXU1UDBU?=
 =?utf-8?B?Y0hhbVY0ZVMrL1ltRXVndi96a1hrNk5kNHBZbzFPQ0VTdDQwTXJTaDluN0Vv?=
 =?utf-8?B?RnQ3QWt4NEg5OEFSV0ovd2gzTGRJRUZlQTVYVW5mRE9tZERrZG5pZ0lXVmFu?=
 =?utf-8?B?R0dySWt4SFpTWFZUeEtVcXdwdExkZytpK1drV055MnJ4bGlQNzZab1dvZWJD?=
 =?utf-8?B?MzlGOHNraHdHVGJDZDlQK3JiQjdzeE1JWUFhZEt0MU94REY2Y3BzK0NJUC92?=
 =?utf-8?B?SWxKTC8yM2t1b3BPT3hLVGgreW1DQVZVSG03SVd1WWVvRWpRUkhlcEFGaW1T?=
 =?utf-8?B?NksvN3liSjFyeGF6QnRPOHA3UUtKaVNsNW05dWZWZmFySHVwYngwZXBvTSth?=
 =?utf-8?B?QW1DaEJJSVVaVzlaWVhWM0dwVnJ2dWU0ek9iZzRCNnhkbm9SNVpnbjBNY1lk?=
 =?utf-8?B?TDVPdncrdnpwNEFGZUJNcnpHZDV4U3FLcFRsM2Fsd1FoUlcydG5EKzc4M0FW?=
 =?utf-8?B?VGFQK3FiZk5HNFNuMnUzSnlFMmF6dE5TWHJ3VHl1clN1bEMwdGNOZnpYWXo5?=
 =?utf-8?B?YjFsRGpGZEExZ1RDR3V0THBadXh2OExvczhFc0tTNFFPclk4MVpiYjZqbEIr?=
 =?utf-8?B?ZGo1YXE0UWM2OFJiU2NrcGJ4amxWQ1hqYjQ2Rjd3Y2lvdGFmNmZjSjlPd29w?=
 =?utf-8?B?UDVWK3U4eExhdmRTUDY0aVFOVVhoa2I4WjYzdUpRczRYOXJ4eWIzRkRvWHZs?=
 =?utf-8?B?UUk3U3BZVDAzQm1ETDU3cXRpM2xQU3JxeTBKQUVLdG8wQkY3c0lEOGxtbzE5?=
 =?utf-8?B?bUpkejR1WVYwTlcrNm92TXJYUm51c2lBY2YwclV5Vi9kS0pKK25FWVloNkVV?=
 =?utf-8?B?TERJVlZ5U0xORS9aTG9zRU1UU0FSREs3aWN3L25kQ2JWSFZoSjlrUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86a42aa-2f87-40db-fd1b-08de3f1e1bc3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 16:46:08.4173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfvrPiY7w0/y8rfAYxcggjLF+O8ylL723WiPwQ7zmqv2cqMMK09AFXdgOWSEyba79lb+MhJY5/v+jaFO55ugVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7828
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 16:46:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21182

Hohoho, a new release of isar-cip-core is available. A bit earlier than 
usual, but no one should interrupt the upcoming holidays for it. 106 
changesets, 7 contributors, 142 files changed, 2213 insertions(+), 719 
deletions(-), these are stats for v1.10.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/v1.10?ref_type=tags

This release is primarily about fixes, and you likely want to check the 
list below for valuable improvements. Some features contributions are 
included as well, e.g. support for the TI AM62Px SK and the DE0 Nano SoC 
platforms. We are now also able to run a complete ARM64 TF-A/OP-TEE/
fTPM/StMM firmware stack in upcoming QEMU 10.2.0 which permits to 
perform more QA on UEFI-base secure boot and full disk encryption on 
non-x86. And then quite some effort went into lifting our CI pipelines 
to Debian trixie which was mostly about infrastructure issues, not 
really incompatibilities of the core layer with trixie.

Thanks a lot to all the contributors and all the best for 2026 already!

Jan


Adithya Balakumar (9):
      scripts/deploy-cip-core.sh: Support deploying artifacts for RB tests
      .reproducible-check-ci.yml: Use S3 instead of the gitlab artifact storage
      IEC_template.yml: Update IEC layer tests revision
      Add factory-reset-helper to all images
      .reproducible-check-ci.yml: Align with recent changes in deploy-cip-core.sh
      scripts/deploy-cip-core.sh: Check for the existence of the broken swu file before uploading
      scripts/repro-tests.sh: Remove return value from run_diffoscope function
      .gitlab-ci.yml: Enable deployment for qemu-amd64-bookworm
      start-qemu.sh: Check FTPM_STMM instead of TPM2_DEVICE before setting RPMB options for arm64

Alexander Heinisch (1):
      initramfs-verity-hook: Fixing log when verityroot device was not found initially.

Gourav Singh (3):
      fix(security): syntax error breaking build on Buster and Bullseye
      fix(security): add libpam-passwdqc for debian trixie
      fix(security): add libpam-systemd in Debian trixie

Jan Kiszka (78):
      linux-cip: Update to 4.19.325-cip125 and 6.1.155-cip47[-rt25]
      kas: Update to 5.0
      read-only-rootfs: Fix rebuild from sstate cache
      read-only-rootfs: Use single sudo session for multiple commands
      linux-cip: Update cip-kernel-config revision
      Update isar revision
      qemu-arm64: Add recipe for optee-ftpm
      qemu-arm64: Add optee-os 4.8.0
      qemu-arm64: Add recipe for TF-A
      u-boot: Add patch to fix sporadic build failures
      u-boot: Relocate or drop secure boot unrelated config switches
      u-boot-qemu: Add patches and config switch needed for eMMC boot
      u-boot: Prepare for different build dependency without built-in UEFI keys
      u-boot: Add optional support for fTPM/StMM
      cip-core-initramfs: Add initramfs-tee-ftpm-hook when needed
      Add class to generate eMMC image for QEMU
      qemu-arm64: Switch firmware provider to TF-A in fTPM/StMM mode
      customizations: Install efitools in secure boot mode
      kas: Add option for fTPM/StMM firmware mode
      start-qemu: Indention fixes
      start-qemu: Factor out -drive parameter in UEFI boot mode
      start-qemu: Add support for qemu-arm64 fTPM/StMM mode
      linux-cip: Disable CONFIG_HW_RANDOM_TPM in QEMU
      start-qemu: Detect unknown Debian releases or architectures
      Switch defaults to Debian trixie and CIP kernel 6.12
      ltp: Unbreak arm64 cross-build on trixie
      ltp: Update to 20250930 release
      u-boot: Set COMPATIBLE_MACHINE to drop PREFERRED_PROVIDER_u-boot-*
      u-boot: Add U_BOOT_EXTRA_BUILDARGS to rules.tmpl
      opensbi: Refactor opensbi.inc
      Update isar revision
      opensbi-qemu-riscv64: Use the new class
      linux-cip: Update to 4.4.302-cip104[-rt58], 5.10.246-cip66-[rt29], 6.1.157-cip48[-rt26] and 6.12.57-cip12
      initramfs-overlay-hook: Rename INITRAMFS_OVERLAY_MOUNT_OPTION variable to plural
      initramfs-overlay-hook: Address shellcheck findings
      ci: Add TI AM62Px SK
      Set default provider of factory-reset-helper
      Kconfig: Disable kernel 4.4 with trixie
      u-boot: Avoid broken DEPENDS when appending STATIC_KEYS_DEPENDS
      linux-cip: Add lz4 as build dependency when using cip-kernel-config
      linux-cip: Update kernel config revision
      Update isar revision
      arm: Switch to cip_merged_defconfig
      arm64: Switch to cip_merged_defconfig
      linux-cip: Refactor KERNEL_DEFCONFIG initialization
      u-boot-ti-am62px-sk: Drop redundant or unused DEBIAN_BUILD_DEPENDS
      ti-am62px-sk: Switch wks files to gpt-hybrid
      u-boot: Add recipe for DE0-Nano-SoC
      Add DE0-Nano-SoC machine
      kas: Hook up DE0-Nano-SoC board
      ci: Add DE0-Nano-SoC board
      initramfs-cip-functions: Use time_elapsed function
      Drop redundant DPKG_ARCH statements for dpkg-raw recipes
      tests: Avoid hard-coding distribution in M-COM test
      ci: Prepare for running non-bookworm secure boot tests
      ci: Select qemu-amd64 OVMF according to target release
      ci: Raise qemu x86 CPU model
      qemu-amd64: Raise boot watchdog timeout to 120 seconds
      ci: Inject image version into common cip-core-image.inc
      ci: Clean up no-kernel deployment
      Kconfig: Do not offer swupdate or security options without a kernel
      kas: Auto-enable targz format for kernelci images
      ci: Combine targz with no_kernel option
      ci: Make deployment opt-in
      ci: submit_lava.sh: Reduce number of sed calls
      ci: Build and deploy kernel-panic update artifact
      ci: Switch to trixie based builds and tests
      linux-cip: Update to 4.4.302-cip105, 4.19.325-cip126 and 6.12.59-cip14
      Use exact matches for COMPATIBLE_MACHINE
      Remove support for building KernelCI images
      linux-cip: Update to 5.10.247-cip67 and 6.1.159-cip49
      swupdate: Drop redundant template class inheritance
      Update isar revision
      Migrate all classes to classes-recipe
      linux-cip: Disable module signing when performing reproduciblity test
      Update isar revision
      kas: Update to 5.1
      linux-cip: Update to 4.19.325-cip126-rt45

Quirin Gylstorff (9):
      Add cip-functions to initramfs
      initramfs-abrootfs-hook: Use initramfs-cip-functions
      initramfs-verity-hook: Use initramfs-cip-functions
      initramfs-factory-reset: de-duplicate code between local-top and local-bottom
      initramfs-crypt-hook: Scan if all request partitions are available
      fix: Add missing efivarfs hook
      fix: initramfs-hook do_prepare_build is executed after do_install
      fix: ensure that the partitions are available
      fix: ensure separate root home dir is recreated after factory-reset

Sai Sree Kartheek Adivi (5):
      Add support for TI AM62Px SK platform
      ti-am62px-sk: Enable SWUpdate support
      Kconfig: Improve modeling of Security features availability
      ti-am62px-sk: Add support for secureboot & data encryption
      u-boot-ti-am62px-sk: ti-extra.cfg: Remove redundant configs

srinuvasan (1):
      recipes-core/ltp: dynamically set Standards-Version for Debian suites


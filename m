Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55585C531D0
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 14:18:23 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.58])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32314.1785161892728417325
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 07:18:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mIzhmBEe;
 spf=pass (domain: siemens.com, ip: 52.101.84.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkaduZo6zz6CaFsmFkQldsXrVxApRkASzh+3fAR4p/X7ww/GcPODB+l7PyLN4jnBBCBcsJ25IWR04w29HtggbAJRa4q6IOeh/XbukwGXoF+TSiqyNqT0nWxpYXy9CVVnPHcHUtWdjlnkcUf+urvs69AXoGUYcRiLubKc69GIzIsHJxOlo/Bhx1kBUjjJrKKQZAWXN9dT2MLd+u7MjL6uEyM+g28tva42no1DE6wVzGghK32cuIqGYfxyHzIPgWRBZCaUjeptFLrNqqCkzLl4P2ft/b/1kycXjJNfJdosbS8/yUKG2ey22M99pzwIHgh7m82hhSu3CYx9vmRICOHVig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCPjj9Wcmt5xEhhdiK8GRmUG4JZbZ+iET6Aji6FfYjA=;
 b=Er3QxJqzvbr5xZKw/ZUcg9fWndU4EN1OlYpGwCwp79qN68K6BDGiUHvTCQo/zuc7oRk5jPZvflpb4DSsJinOMlxYbylaMDNbDyKvMGnxiQY6sUfl3RXzkQxPFt9GR/vFmTEja+DXqe9RAl5anvrKMXKpbew8jkv0Vlqe/DR4i3lsw4bgbsWyNOeXgU2GzIdTemRehxDC6QYMUb8ans202HeysAEhFGJ/gdR42gDBN+/W/mpsNPaH9mbgHPhoFY9YmLjlomiWR1CuNj2doXeOXhu7DaxMFSFsTmamYoFI5bWK7tDBqpdx+UAlNjkT+p2EMgqnb3f4l2KyVapkAyYEUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCPjj9Wcmt5xEhhdiK8GRmUG4JZbZ+iET6Aji6FfYjA=;
 b=mIzhmBEeiHWabNt0wpaTFIeaR2zDBVsvVz2ILCq1vvn2hb8zgtaBX6Ae826ajMFly4NSZ9W/thfNud6B3Cz03vdVAy2ZCeW/Fn35IdjxmK01Yvhc9p5FA1ETlic3ckekicFzUzb7gD9tLbiB+zxzp7bNDrTOoLfBYpcAl1xRmZ1z6CwONespab/Djbg7ILeahWmKZeGzZr1aZ2imJCVd6MXnzRufvqoXxD+4T/RPPOrrDR7FLAZ0F+wDrDJCA3FAmuVYsI3og0fdRnIQbRr4WUdA51HEhM/Ic1reSCfHwVklxpJ+kfnBEV+T63tGoiW8/p3AYb3o9a+f47MlsbeTEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 14:18:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 14:18:08 +0000
Message-ID: <7d16f97e-046a-4f13-ac0b-7113e49e223e@siemens.com>
Date: Mon, 27 Jul 2026 16:18:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 00/14] Add recipes for image
 hardening
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 christoph.steiger@siemens.com, clara.kowalsky@siemens.com
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0279.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: f359847d-9303-4995-4457-08deebe9e1c8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|11063799006|56012099006|5023799004|10067099003|6133799003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	m8LvtdKpy6piBgVtezrjqyTx1jF8gsSgxtdSPpJo+Z1OP1LTeRotxL4n6IAM8qqjdTb1qJblCVDIMavs/JLYJXMupiToTn3A1NeqaqFRmOIWykk3MrZXQKm56p/4a9kC4PU2FXwxcW5UohKyfJDgCaN9/rrkffLyUuFQ2oX09NWi+OO2q253xDFUmF249a0twD5ZUQzI0ZKFcOH5rE+cGaLqtKvdYUf0hn79Bqiu+Lqevg6EfGOlOFWF8iVVTLR/9oJAhln6mdekTROKq0NIqtg2UzUq6oe2ISQfn3wTfate1//uFkr7Zpm3MosLCXWuUXuJtIy9RjtOHTWg6hknHeADc3Vg++GkE+wEAGMJO2SiuqqJkaUpYZd9tTyKDY1fL4l1AGg3LAOClfx6MoPKsJiaRqKDl98+B1KgXtldQ3zwJxiDRQgwZFeqnb3MytQlc6eByqBLV6zdqsXOEcjOaPyc9pOE2NXE9QG7yDcfWIb7tI6AVvw86/ev8PyLNXjVT3Dv/eIfkJC/CRQgqrhbzrHghPBNu1Auu+HeHHJSvFocwji449gyNdV5ugm+6qhfUwO9GUCyBqHgJfpb5AZKt9g9Gd1Pfo471XsLZluqGbqEzG2BMQljVKXW3p5vy7lsyq6kSK9AardMKtSXyHqHEz78L77CNRrsP4VbGYqsaNE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(11063799006)(56012099006)(5023799004)(10067099003)(6133799003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dG5HTHd5ZXk4NUFvbTFuTTV1dDc3M1RWUzVTSCtyRndCOUdwNU1odjEydTcy?=
 =?utf-8?B?U3lxaW1najB5M0N2Z2JLTXhUQW9EL1FwQk11Zzl0elBNcFB4V0xGR01OaU8z?=
 =?utf-8?B?Y0tBWlZiV0tjaVN4akd2UVdkZHl1eDdGOEQ4RGpReWg2aytkQ1ZIaXB3UnQ5?=
 =?utf-8?B?empuS2t1Tll5aUIzamdKdDJsSmorTnZsejRnRlBCYVRUZ2pvSmhUQnlRWVNZ?=
 =?utf-8?B?WGZKcWlwNDhldWsxM3V0V0RQNi9FSEI2a09jaE5DVnRlZHZpRzlYemJFa1do?=
 =?utf-8?B?T091amV6WkQvV3Q0cnd4emsvUGFtNzU4QVorb0M5NU8yOUVJRW9MUEI0REls?=
 =?utf-8?B?c2o1am92SVhMbUlHQVdaSlFnK3Npc1VMRWlENTBvVzdidFFiQjNmaVpKK3dT?=
 =?utf-8?B?dXJzc1oycHhyL1ppbzdFWXNwZzM4U3d3Vmh6Y3dlV05KM1FZbXhaM1gwcTBp?=
 =?utf-8?B?OStBV2N0akNtckVtb05SZEZxVlhTM1Ntcmh0Z3R6bmJwVnN6NHVlaTZRZ3Rr?=
 =?utf-8?B?NU1LWGxKYUdJbHJWZmM4Z3kzT0NZVjQ5S1p1cXRBY3NMQW9aNityTSt1Y216?=
 =?utf-8?B?L1B4aks4cy9rV0RNUDd1N1VFakRsM0NVYzR4c29Bbzg5S1RlaFNld05YekZx?=
 =?utf-8?B?M09vZTd3WnRjTzMwR2dZVmtqdkIxQy9hTVprNnR3eEIyU0d2bmVOTDVtclg0?=
 =?utf-8?B?ZkJOclVuMll2N091N1FsTGNJMm9XNCtqMXdQbjdRRjJES2lWb2h3RFRaaUdL?=
 =?utf-8?B?UnBIYWpISnVtcHZuN0tGZWZVVDZHekJBM1c0NHQ2aG9vOWd3RkpQMlR1ODI1?=
 =?utf-8?B?N1lRL3lSSW1jWC91M2VxVEllL3RLQ2o1VmRFM29DRlVvZXRXSW1VdGgwYkZz?=
 =?utf-8?B?MjllN25jQnVUbWdlSGh3WWtDeWNPYWRKUnp1cW0wNVdnc1NHemx5N0E5akVz?=
 =?utf-8?B?UElkZENtWFdPa0E3T0hvRWZnSFp4V1lBNTk0UzN4RmtzSWpXMGlIbmhQNWQ5?=
 =?utf-8?B?UndVaCtRcWJmZ3Z3UjFKWG0rSm9CZ3B3T1ZKOWl0VDFRalZCbG83NjdBOWFR?=
 =?utf-8?B?MDFYQkhaTHV0dm11UGJPSCtGVksrMS9tMFBadWFtMkVkd1BIait5MmlKNmxM?=
 =?utf-8?B?LzVyNDhmTUl1Vk1GRXY3UHNxbFE3UmtyNEFHMXZCSkVQc0FkeHZDMERob1Zm?=
 =?utf-8?B?b1ZiZnBqM3ZxdWYzR3NhMWs5cElseEx1NmZPa1V3VVpBaVVNUjYxazI4WWJP?=
 =?utf-8?B?T0lmQlIxUnpNc3dhdXc2WE1yeVlSemU1dGI5VFVOa2Y1UHdDOENYc2xzM2dZ?=
 =?utf-8?B?aExBUER1SE92bC9HL2JBaFpxblFBR1RxcU1PQTlPVnM2aW1RZXJ3MTRRbStN?=
 =?utf-8?B?MzRqMkxlUzd4QmRiemdST3g3Si8rTXB3Unp5dmhBYU8ybDAyLzVySGdHNGVY?=
 =?utf-8?B?QUlodGdtYXF4MmpmcWUrNjM4OWp3bHhsUEFxWFpIbUtESUU4VTFTNCtXdm1l?=
 =?utf-8?B?TDhra1E4S0dHbmovdGx4L2lhVU5MWnZoVlBnMnAwcmptK3FRNFk5K01VRU54?=
 =?utf-8?B?cjlsc0FOQ3pZZXd1dzhLN2JieThJY1lCYVRIKzZkY3BwUDYzSTRxMHk0djdx?=
 =?utf-8?B?VURKU09STFJYbXQyWlFPSlB3WElyL1d1UG9leXAxTFZjWndwWVo4bnZXSDBC?=
 =?utf-8?B?ZE5wR3dLMThFRjhOY0VqZkp5ZWZOVEhJR293N1BhcjdWcXhhRk43cGc0V1RZ?=
 =?utf-8?B?QXBUTFhhWVVXOWxjam5EVnhnYnFEbVpYUlVYdkNDWWR4b0k2eXJ2UzZZVmpF?=
 =?utf-8?B?Sm1id2FrS2lXY0QrcTAzd3I1ZERXK01wL1E4V1g4cjZRUk1YSUNRSmEwU04w?=
 =?utf-8?B?RmpzMWErbnB5bThsTDhnbmRGclFIcTFyOWUwcFA3b29aeDhJZmVWdit2M0ZF?=
 =?utf-8?B?ay9mTlFwbEYvZmVydk1XUjNuTlhkbkdzbldIR2d1TElVYnEwb3I0MVhjaFla?=
 =?utf-8?B?SmIyV1phNzN3Um1iVHdVS2M4bkxmc0psbzN4NW13NGhFcGlCVlNqQ2xLU0Zh?=
 =?utf-8?B?S2ROR2pKaHVoV3J2RC9GbUx3cGZjOVhXRnIxQmkxVHlSVDhocmtlQnlOSWd6?=
 =?utf-8?B?ekowVkcrSEZTL3E4VDdiUTl5MUpPajEvcFlMRCthNEswbGF4Ylh2bjFieS9j?=
 =?utf-8?B?WDMybWJUUUZQVm81aWZkL01vZ1J4dWsxd1haa2xyQ0U3NVFiY01oeXhiYnkw?=
 =?utf-8?B?MzZDSlcvZmZpbFZDTER2SlN6OFZJTExOU0Vxc25mOGwwQ3FrNGVodkxNdFRq?=
 =?utf-8?B?b0pONGZQY3BOTWJoaHpqYTlMR2kxV2d4UXpvbjZZZGVNcGtRck1ncUJ0aTJo?=
 =?utf-8?Q?pGYgsYqR+oiol+T4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f359847d-9303-4995-4457-08deebe9e1c8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 14:18:08.2784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLpCcQnH47BTzRUF7n+lBrcjEFFr/foNl1LOCNMscgymPBG/+natvbmv3KtrEQSRJ2KnUDmrggcGXYS9qYQ5Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7019
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 14:18:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23769

On 24.07.26 14:39, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This patch series adds the option to harden the build image according to the guidelines published by CIS.
> The patch introduces the following packages:
> 
> cip-cis-rules-config: user-facing configuration, stored in .config.json and configurable interactively via Kconfig.
> cip-cis-rules: uses the configuration from cip-cis-rules-config to generate a custom Debian package containing the necessary hardening configuration.
> cip-cis-validation: an optional package to validate the hardening rules.
> 
> Additionally, the kernel configuration is checked against the hardening rules.
> This patch set is currently developed and tested for hardening level 2.
> 

Meta question: There are a lot of "cip" prefixes used across the code.
Is everything that is really prefixed like that CIP-specific or
CIP-augmented? Where not, I would suggest to stick with plain
"cis"/"CIS" as prefix.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


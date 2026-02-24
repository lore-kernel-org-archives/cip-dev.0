Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E11F3C9A8
	for <webhook@archiver.kernel.org>; Tue, 24 Feb 2026 15:57:34 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23639.1771948651883730552
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Feb 2026 07:57:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=PwtXRWmg;
 spf=pass (domain: siemens.com, ip: 52.101.83.12, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkeBQdOhR1+JMSdDeIVPv2FdGSdneUL7ScWIzRCrcmBVZ1nMxZH73IqJNxbj//HKTSBo29xynElhd4xz4Z+p/Rg34/d9mfAV/iyRmVmT/9gbeieWNGXRC0DGwNS+mxUi+UjCHgNUwaAcNlCsG2AQExgrolANZ6h5CIhLg6VbB8yqd5dbKi8CmwWPWmUJTAFIuu5cUpOPmrwA4/pGSQ3JWUGzb7VhJBlryoVG7gHwvRVYl3GJUt0K9pT2o1srNcVjueYXWM33Ax+zI/52qv5zaVtRPfaqr5PY+qcj/986xcJ4y1DbFDKYCmSECVF3HF7zTALXgpzM4YSMNNnQtDkl4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idQETiAOTh5dNRL2k2QwjoDikM5uD7w47XfuMhV6TH8=;
 b=QjbDSP1OCv3HIFz81g7ZX7INtxL3hmb87QH/KxeJdcH2iOyTqoyyzsVCwoj0P4xWKuV6+P9A1ejnuHz+SJ9zgCmTUQZ2NUTZwkn/G8lnWDnkHeYano3v+IuLo+Ji55Ho/9vN2Ll4nrkZ5bVATj6/LtjNTGTYCGoRPDE+ntnP79Rj6K8znd7bM1kX3a/+o6zCkvKGtxmdVJhXscmlfDbT1pwZXRewcrywyI/msSeQpvbW3HMzsbdNwqNQGxLWICeI5bnHGm/+PJYT0WTLMiQ9FKis4+WE2GHuld8402SAVQ9PB6lA56vVUcpeDa+GbSIc3Dp9QkZVwW2roN3Dd31Icg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idQETiAOTh5dNRL2k2QwjoDikM5uD7w47XfuMhV6TH8=;
 b=PwtXRWmggXnQD9gMG9/j+8mrDaE5gyVP5yR/r79OHU8+kzLffEkPRMoN4urtzUMs2zGMdWXe0YroMqMyrcUArI14lnULhRds4AeyKRWgzSTm/XvtoTVhBliCKEZQ2qReazc5+PTt+XWoflG1GLgYAHIN6TDS6ZLMbKxycLia/ZWa8QusbHLWfV0FlXncj73/oIr03U63LR3r5OhVZBSonFfs4SegKrlXjJ76FUEbTepyiRzJu+WiT7rtl0u7nEUtz6G381orRKaaMl0sdUcL7s0pTocyAkkV0xS+vWR8qkMSbvIfN8uN1L85QlYDKif5KlTWp6bwuuVzqA6T+QXbnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6642.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 15:57:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 15:57:27 +0000
Message-ID: <6ebd2507-5cd7-4633-a6ff-859e0982a907@siemens.com>
Date: Tue, 24 Feb 2026 16:57:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] Add bmap file to speed up mtda
 tests
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260224155620.1794845-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260224155620.1794845-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0188.namprd03.prod.outlook.com
 (2603:10b6:610:e4::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b9385d1-7454-43b1-fd81-08de73bd685d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NEl0a1E4dDBGYk9FR3pLSWhCNnNmVUxXeURLeDRXdWI0Y1lRcS95aGdFcUlU?=
 =?utf-8?B?cGZYUGRoT2VhR3NiMCtUL0diRllpRllOa1pnWTdYSitXYmJrQ2gvNW5VNVRZ?=
 =?utf-8?B?Qkg5N2FhcnpSbGtXOHNHOE9pMEFXWFlZL1RzcWdCUURvdEZldXFPWUVzMURQ?=
 =?utf-8?B?VHFsQ1g5c0dFWHlVSVFOWkdMKzRMSzRjSW9MOEpRUTQ1N2tjcCtUQ21yckp1?=
 =?utf-8?B?YXNRbUlXdll4WnlUS3JrdkorTGtqQ3lEM2dLSzV0NkRWSm5RbzkyaEJPM2R2?=
 =?utf-8?B?MjVpWHJaekF2Qlo3TW9RMUYrVUVGd0paaTZLNy9mZ2thUGdjRGdwZ3QvV0Nm?=
 =?utf-8?B?MFZieTZiQUNhaVhxVXJiYU4wUHFaTHp5RlVGenN4Y2lzbGh0WXVpemtZTE12?=
 =?utf-8?B?VlV6dG8zUWFtbStaaHREbnBESW50S0xCZENWdEhacTVPMHlsSkwvNHpTQlFK?=
 =?utf-8?B?ZUhueWtLM1NOekFaV0prRzJpb2dUSktNcGRkWWlQeFRtQ2RxTWVHVDNCSHlq?=
 =?utf-8?B?eDJ2Sm4yUnU0cDZVdTB1bTIyRWtEMXd0cmFqOEhIL1pkOE5UT29PU05Gd3dX?=
 =?utf-8?B?b1VxTkdrVktLdm8zT2RpdWdROWxZZHpUdldQS09Zdlp3TGEzbGNJWTRpR0VB?=
 =?utf-8?B?YjZ5Y3ZGbE5SWUZGQm80TjdWRUV2T2NCZGtJb0wvMkdsTUVPeFFkMzFra05Y?=
 =?utf-8?B?RVVsWnJ0ZGpMTkpJTk1GK1pQMVozMjZ0Qnl1U1NCYkt2MEg5RWlaSS9Kcm9q?=
 =?utf-8?B?bHNGN2VFVURsSmhHOVpZWVJ3OXBpd211aStRQ0QxL0FBTE5tYXcyTG9nYmt1?=
 =?utf-8?B?UGlFQWJ1bFZQSE9BT3Q0Ri9JUFBDMGcvcmIxbXJ2dzlkcG0wVmVJR1BhNy9N?=
 =?utf-8?B?RncyclJrQnUzcEh6NldFV0U5YkR2WkdsaFZpaGhESVB1eFdUR3VveGdRbHRP?=
 =?utf-8?B?Z2RWdWJQeWwxbWJFNmVMM1Uyd05GNlV4djJzNXNnOUhqc3ZiNG91OG9zZm5R?=
 =?utf-8?B?cE9nc3p6dE9md1lPVER2VWh0aHNRZE03cnM3NEFrWWJCZzZGamwzVDJMZEdi?=
 =?utf-8?B?ekovdVZWQzZDQzNvdEZ0VzFwdFpjNi9JSFlyaVRudVFmaGJSMFBTbUdJT0V3?=
 =?utf-8?B?ZTUwMFpaQlp1V0IzOXF4a0EzMGFEZHRkZUpxS215SmFEdlZ4TG5DT2VicUxs?=
 =?utf-8?B?eHA2UklHa0pJKzh2WXlhQ2pETzlScnB0WVA3QzJTTE9Rb2dLUmNYc2hSNTR4?=
 =?utf-8?B?eEFPa1EyMlJGNDRJUkJJSnBGUFlRSHk2UzV3MUhKUEFtcjZzeGkrWUtyNEFP?=
 =?utf-8?B?Yi8vZFBSaGFQNktMZXczejV3S3R0c1dVaVlhMnhQb3pHRWtTZGd0MzVIbUMy?=
 =?utf-8?B?UFg3TC9EL0YxQngyaWZvNldtdVdiZTBzTTV3NE5BMTVTM1AxYVVTb21ZaWJW?=
 =?utf-8?B?UERWdVEra3dKbzdhUW1VK214V3l5d2xJeDFNbHpNVkxJZHg5OTJMS2VjSFpE?=
 =?utf-8?B?b01ZWTJiRFZDZ3VYRWJrNGlVTFFCaWoxY1ZSREFFZHhiaGZDVkZBV1BvdWpY?=
 =?utf-8?B?Q1FlbnFrMkdKeXdkNWhJeEduOG4yNGVDUm9xa2paQ1hpaE5mekxGRkJsQ2E0?=
 =?utf-8?B?RXZjNFRINmlESnp1VDBrYXR5L0dRNDFJQVdNQ3laSVN0ZTJienpWbmZBMnZp?=
 =?utf-8?B?bWtIN1NBSmFhczVoWjQxVDljdmUwNithemZGV0h4Z0Y5dEJkY0wwMWpaUHJP?=
 =?utf-8?B?bnp2b0s0VTBqYkgwRFdUclNOcExrZ04rQUR2eDBsQ0ZBYlk2Y25RNGlVVVhk?=
 =?utf-8?B?NXBESVVIZHA1dzBZajBBTVdEQk1vVHJlajRROGZwZWUrT1ZtSk5BUzM5UUpl?=
 =?utf-8?B?NTBIRCtqMzFsQjZiTGpKamxVZ0djMWRyWWFkRVZCQ21xcUxiOXVieUEzQld3?=
 =?utf-8?B?dmdnV3l5R3J0enkwY2d0b3BuOGdqRi9nSVBZOEd2TVVDNE1lUTRTVWJJelB2?=
 =?utf-8?B?eGozaGUzTkxnVTFiTFpFQnZLaUM1OEl2ZTYvTVRxbDh0aTBDOGtIRWsrQmh2?=
 =?utf-8?B?WWxuZVpNQi9LNnRMTHFxdTRGUzd0MGJxRTBTeUYybGRpWHV6d1RsVFVrT1Br?=
 =?utf-8?Q?zZoU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TEg1V3pvZGN1WmM0V3dtNEVnd0lLVjRjTHlUdXNpWXRKOWFLNkIrRlVWVEx2?=
 =?utf-8?B?VGtvSVhoU2w4T0lXS2N6MXR4cEVxYnJuaFNFV1NiK2FQTTkzZzl2VFpBc28v?=
 =?utf-8?B?NE1BaXdFQ0FzRFZxeHRCaUM1Q0hvQlZmOE9TNmVLMDRzZlpDaUtvSU9SQjJ3?=
 =?utf-8?B?VERxTG9QWHZQejVQRnlZR1NOdWs5WUwyOWppSW9pQ0tNUVRwSFpKQ1Zid3pp?=
 =?utf-8?B?ZytFYzZBR1dINGw1R29Kd1lyN1MwK3piaElXUkx5Z0t2aWR1MlcrN0hQNGho?=
 =?utf-8?B?NzRrQXVlWEUySUdJb3hGTklQUThyYi9YNTgyK2JoSkdGMTNUQ3VoMWVqR0d0?=
 =?utf-8?B?WGZSNW9udDRIcVNDakZJMFl4NzdlcHVvQWhtSEhQM040d1ltcENBcVJ2c3lu?=
 =?utf-8?B?ejhLSFFiVUhRSnJUa3BMbHlacmpxQko5N0ZRWEFPK1J1RlYrc25xY01hOTkz?=
 =?utf-8?B?VjYrTGVmKzlEb296VDRWNWNsMDNiZmNjU2FkRmZSZ1k3MXJsMEZKYjA5L1NX?=
 =?utf-8?B?TUtiZm9vMUNlQVpJTEZ4L2VIY3BIeGVIdEtPN2loRmVaY1ppOUVZTjNOOGFi?=
 =?utf-8?B?NFNqRG5ZNXB3Ynh5cjdwREZ4OU9pdmpCUmhCRU5iUkE2cXM1R0daTmNBanUy?=
 =?utf-8?B?V0U5a1RxVVZGUzY4Q3krTjkwUVVjU2lMSTBvdVQrNUFzc0dGc0JuZTE2M2xV?=
 =?utf-8?B?T0VXTGVqS0M2TjdhV3c0Mi9WcXFLdGNLb3FXeHd4STJxV0Ewbm5BampGaDFN?=
 =?utf-8?B?RzhsUWJtZ0xKcDBmL1p4T0FXWXJnM3E0MkZ5UWY4WVk0Qm4wVFdmbHk3QVZs?=
 =?utf-8?B?Rkh6S0FMZFF2OE9EbWVYeHljSENsTGRCMDB6bTlwaUV5eW5GMkZmVmU2UGpx?=
 =?utf-8?B?QWcveHpKaTBvMXlwVGdkYjBwUXJJbHcyVHdmZ1pkQklmUjl4angvYmtybkVI?=
 =?utf-8?B?WHg0aGpSeTVWY01KUHBrYmJFc0Z6WmZDd3V2NFNza2dGMTJJeXN5SmJBcDlz?=
 =?utf-8?B?MFN6Qi9yZm15bytTRnlCODEvNVYzSTJrRW9WdFI4eWJETUVMcFlvOG14Y2J4?=
 =?utf-8?B?SWVVRnFCVXM5bDh6aE1TTkY1dTVhdGgzT1pTK3ZhdnBnN2wySWZWb1BqWmNQ?=
 =?utf-8?B?Vld1RWQyR3hpaUxtb2VPYUpYd1pndm8vZG1EWERKRFUrTVZQd2tRRlBNWlR5?=
 =?utf-8?B?bE9veTRWaFFiY3U5UWcyTGVkL0FLdmdML1hSVUZhWXZramxscTlVSm8vWnc1?=
 =?utf-8?B?WXd5blo0Y0pqNGZGaFlicEY2eGc4T0FPVWhScVJVQjQrTHBRR3lZSWZyN2ZX?=
 =?utf-8?B?WkhQWHorVDhnbmd5QkdaVE5DRU9UYTNvUWJxR285a2x2bUE0alA5SEhVeWdq?=
 =?utf-8?B?VjhuMWljMWtTY3hkU05scTlWK1BnQ25OZ2cybldMOUdMcFhURkFjOFhOQk51?=
 =?utf-8?B?RjhJRkV2bzZGaEF5NkM5am5DT1MrU29EZ0hCVTZMVWRUeFhRcWFGVzZhT3RW?=
 =?utf-8?B?WFJOZUFVVHBvNUQ0UU9zZG9Md3NHWlRZZVlmZVVJNWJIZzNnSDBZYU1ZSWdI?=
 =?utf-8?B?V0JqdlhDbHdNMEwvVXpEcSszL3dRTzF4YzdYZG5wSVA0eEdYcG0yOG80Rk1l?=
 =?utf-8?B?TnJSOEhNOGZlallQMDVRSkVTQWcwdk9Da2x0N1NiY05mSEErTDhVNDMvanp3?=
 =?utf-8?B?dlM2SGR1V2FxOXQrbXRFNjFFRFpFeGtVRXNtVVpqcG16V0lKMW4vVlY4a2Fy?=
 =?utf-8?B?VjRhSk0zMVBlejY5QldzNlE5c1lIZTlnc2poMnJOZW8rcWFXZzh0WXNNM1JS?=
 =?utf-8?B?VzZUTHg0NmxXSGVjbkFMeTk4ZHZTejVTRjdEcVI3Z2gySnZmQ0tFTHdmY25i?=
 =?utf-8?B?VGUxVUxzUkpUOE5CZUExd2VzVnRHVFZybUxFK2syWEVwWmx2cWk3YTRlM1JK?=
 =?utf-8?B?U0lTZ1pveG50TDB0M01pMlltMGVnbGZsc3R1QU4wUElXT2tqbXZsa1BkYTNG?=
 =?utf-8?B?OTIvUStLK2MxYkVUREhZNzlINnFqVnUyREpndkFzNjRTSnFKSkVZeEVjek03?=
 =?utf-8?B?Z2UzYjQrNndGcEVLVElRQWhvVy9qeUZDd1hZcUtlQVdFdUpYTkQyaENGZFg2?=
 =?utf-8?B?QXh1VjBWaWxmbThPeGFabzdtdzd3V0lCOFRraVNMRHhqbXJmdFNzNUFScDBm?=
 =?utf-8?B?L2p5NVNsamVVMWJoNzhVQTRSNDVsMk1IWmpybjVOeWhTekVCcEg3bHMvanU3?=
 =?utf-8?B?UmhhcWRLaXVDMVZxVFEyTXFxOVY2a1hhYzFCdVJ6Y2l6TG44ckNUeVBuYWVJ?=
 =?utf-8?B?SyttSXBjN3V2WEpjeUhpNmkxc0VoQStzRlBBOHhRMUx2YTVPSWRqZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9385d1-7454-43b1-fd81-08de73bd685d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 15:57:27.2285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MARJhVsWxFWg2WxHfKYxUgQppi8I2lru5/MaEqRbGTmXllWGh04VGPSjRyB2WakxHpzYizFwoD36unZaA4GqVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6642
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Feb 2026 15:57:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21925

On 24.02.26 16:55, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The mtda device can use the bmaptool to write the disk image under test.
> This allows to skip writing empty parts of the partition and increase
> the deployment speed.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  scripts/deploy-cip-core.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
> index 623c216..3ff6b70 100755
> --- a/scripts/deploy-cip-core.sh
> +++ b/scripts/deploy-cip-core.sh
> @@ -62,6 +62,7 @@ if [ -f "${BASE_PATH}.wic" ]; then
>  		echo "Compressing $BASE_FILENAME.wic..."
>  		xz -9 -k -T0 "${BASE_PATH}.wic"
>  		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.wic.xz" "${S3_TARGET}"
> +		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.wic.bmap" "${S3_TARGET}"
>  
>  		if [ -f "build/tmp/deploy/images/$TARGET/firmware.bin" ]; then
>  			aws s3 cp --no-progress --acl public-read "build/tmp/deploy/images/$TARGET/firmware.bin" "${S3_TARGET}"

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC0FCEB2C4
	for <webhook@archiver.kernel.org>; Sat, 15 Nov 2025 06:43:06 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4498.1763188983490913513
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 22:43:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=SSwWQJ1l;
 spf=pass (domain: siemens.com, ip: 52.101.83.39, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INb8nhEvTi6sUSkE1DAbQQ1L/BBXrDygznZHChsWPOuIITHsHvEhH9NP9EdCfmMc/GsLg4AVy4T3BY/FSacNoBWaWIYZo4QcV0fVF1NhwDyTI+DQXnHuVZ0Q+FT8hYOivOJ5tJLz98TWMP6m1Vw93V+1eZmjXJCjp7mAWjagXMdmoDpDo+cdGZwlXdVFkqJB33uSH4Pz44EZTQkvXU/VfdNCGv1Vr/NiKpaA1s2yoy7CXItLAao707qIPQqffWqwIE5JlvVmHgkE4UvG3GjQvk82t/eiQaHO3IsbJzcIFYUi6IlwmOixEhSf0IRxCEkmlyBijselzr6BPnC2OPI70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URsMttVW3zV7mWdFbj0JI49G29spJUo4rHaDwSEEc64=;
 b=N0fkhIH1ZYwg4dd57n4+5PWiUnf7il1GP/E4dFrr2Y4PBZp2MeJFI11qHNv5C2K/3/ywklDMGEI+iRszGqDsFEFn2I/eV6rerDIeYmreTEdb/gho1wdyQlD3dNAivUJ7hgVDfDOW/JuUAA4eIivBBakVPhjW5u8UUnJZpL2wVmEaikgDA973PoOFnzSboGvdD6aotbnkKjhNoLb3eerga0ZKCz17EgI5o195AI8COk2urOFc9Zz+d64Bn+0mBD4Aj2+O4uZ/RqpZeGLHpYNvvD5o1JkRyns2PBvINcgIksBgVy6oHg7ILSew4yb2YI9EIST1lOc9oHEW/vGm4PXzAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URsMttVW3zV7mWdFbj0JI49G29spJUo4rHaDwSEEc64=;
 b=SSwWQJ1lpr60lcGBTn9KeJVEU2zYqxdVWf2rXawBMveaUKDpVk5WYpsakW7QlRsTD3qVxuqFrkgmElMJZgTwpZTKmnhM2wN5bNlGMLxxMCOufl3xl0CKljGzDMNugKnQyyeMOsa3eCA8evy9qqfyAHRYLOP7MmmGeGFbJZ6RIf7Oe1W5mV4KW4kJsYPfkBkd8Qqx2j6Nf6kCrqjBibdERRtIfhM3q3MPszF4bfjMutH5AJjHsCsXgBqKg6XjfJf7lu6r1vriNbpPfl1tEcCO1Xnh84TvIV+hAiVeF3r35asJxQsVWiT0FgERDmzWHuAc6pTaDRLAdfwXqiaz4LFVkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5670.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Sat, 15 Nov
 2025 06:42:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Sat, 15 Nov 2025
 06:42:57 +0000
Message-ID: <12ab4d33-55e2-43e9-bc32-9d47d044bce1@siemens.com>
Date: Sat, 15 Nov 2025 07:42:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v5 4/4] ti-am62px-sk: Add support
 for secureboot & data encryption
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org,
 vigneshr@ti.com
References: <20251114090509.2935933-1-s-adivi@ti.com>
 <20251114090509.2935933-5-s-adivi@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251114090509.2935933-5-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0064.eurprd04.prod.outlook.com
 (2603:10a6:208:1::41) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: f9660f93-3fc6-4afa-ffcd-08de24123645
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cmxYVkZMNWRyeUEvYW51Z2szOC8wVTFabUdWMkNhQnNoYmRPTzRkejJ3bFNr?=
 =?utf-8?B?dU5ib0ZBY1pHS0ZobHNRUldCNU4zUUViYllEOU5mRU83anlRNWhvdld5OFdU?=
 =?utf-8?B?VS9kdXZucmR2WmtKN0F2ZXRFbkNTWHZPUk5Pd3V1UnQ5anNTYndwQ2p2eVl3?=
 =?utf-8?B?dERyanRvak00WG4weUVXOHdKK1cycXRmRUxRNnFseVlYNkErN3puN0daUVlD?=
 =?utf-8?B?a0pCRHlJdStrS1RiZEE2UUYxelhERzhkZlc0bXlORVpJRlBRNUNjNmdqaVhz?=
 =?utf-8?B?UC9YUFprWng4NUEzcHhTeFRpcVFEY0x5ekNYcnd0Y1ZBSC9EYTlmY3Vkd1NL?=
 =?utf-8?B?TzJqMDhGMGZKNUMvdll3S1VLcmRkVHE2R284VTJURTVLZ0I1V1p5ZTc0ZlZo?=
 =?utf-8?B?T1JCcWZsMFV1M1hqcUFtUWJBSTgvSlBvbFJHZGVWMUVEdldkVElKSi91K1Iv?=
 =?utf-8?B?UFhPVlBnN3JDMVhJTDg4VWFaRmRaVHN3WU82S2EvU202QU9wRGFoRGVITThx?=
 =?utf-8?B?ZHlNd25DUjFSbnJFRzJOTkF2VWRpN3VGWWMvYXcxSEFnbkVDWTIyTVVHa3Yz?=
 =?utf-8?B?UUVwcEV2VXMyaHc2OXJxK0I1MzRENTl3cml3WGtEdDJTcXlyVGM2bDJEb0tN?=
 =?utf-8?B?ekdkZXZES3AwTExOeFRFU2FkVW03dWZncTJLQ0JSMFp1UVFudzNVdVduNlBV?=
 =?utf-8?B?cFZsNDRVR3M1SlZFa0dmNlNqL3V2bVE3bWhRS0ErOVFvN0tWTmN0bDlsbzhl?=
 =?utf-8?B?Vk42SFp6OXFyZlg0eC9rVUM0QVZLN2REMFFlL1c5SFFmempzME9abzFpS2tn?=
 =?utf-8?B?ZzYwbGFtYmRHRFNoT0hralEwaW91dGlTZU95cE9XVkV5NmVTSHJMUER6OTBn?=
 =?utf-8?B?OTQ4cHBuYjYvdi92TElzK1FZNWI1R3d1VXBmYm5wZGJWMEFDQVNMMk1UbHNH?=
 =?utf-8?B?OVl5QVVxTW9hZ0N2QmpLekxkNFZNaE00UUZSdXlsQTZxeFQxNklYY1NYeWJw?=
 =?utf-8?B?VlJVNkk1eFI4TzA0Sm9mUjZBUGdYTjV5ejJ0dmpsbWh4NFdLMUtwU00xdXpU?=
 =?utf-8?B?WWF5emMzSDJhK0JvU1ZaVUR2QmhiTWVEbkVPYW45S3RXRE5CenBZckJWYWlT?=
 =?utf-8?B?blZsank3dXJlNzJIU1EwWjlyeHY5SVU1UDhUS3d1ajlRS2srV3NGYXRRZHFR?=
 =?utf-8?B?aU1LQ1lDd0kyc3duWFRveWdCbEVZQkhPTUFzRGYyTkZNaTdBUFpWNFlWcEd5?=
 =?utf-8?B?MVF0TmZqTDVwYW9NUzJPaDdoamNYaklzeHhrV0pQMU1hYVZJK05COS9LWWVM?=
 =?utf-8?B?REJIVlFBZlBxWnR2cVdrVUZhbVBPQWFVeUJTT2VsT1hDeHZPNG9acmRqQytZ?=
 =?utf-8?B?N0pVM3BOQyt3SU92aDEyL3RndE5pU21YdnZjMzM4SnRjUWd2b1g5VlpyR2l6?=
 =?utf-8?B?V2FUb211RWVGTjhNSm5QNFZ5RzVsckNVVjQ2cTdjUURjSzMvODl3allUSjd1?=
 =?utf-8?B?bTd1SGpVMm52RmdYOTArNG1SSHFINk1KeWNIMjd5cVNsYTFIYmtmRWUzNE56?=
 =?utf-8?B?UEl4c2xFYXFUMXVlVVB3TTNhdkVObGQydkNYRmZJUTBEQjBWQ2N5b010R2x2?=
 =?utf-8?B?RUhKejJveXZYdk9FOHJtamd5aUgwSTRtZkc2c0xYRzJSRnI0V1NIWFM0alpG?=
 =?utf-8?B?N0xUSjFHdElwUnBDbjRRdFFlaGpQRWowQkdGWmhucEJ3b1NaeCtJODVLWGNN?=
 =?utf-8?B?OTVHT2FKS29IeWNQTjhTVXgvckFmMXJqWnZmdmtONlVlTHBrcWNFc3dicDVK?=
 =?utf-8?B?Zm5XRGhzVmppUXJZWHdoSWFqN0dQOHo5cEg2R1FSclVqek9MbG9VRThtU3Ni?=
 =?utf-8?B?YkgzQmRQTldvalpVbEl4VVpaWm5ianBUYkl2TTR6QzBha0QzaTUzZ241OUM4?=
 =?utf-8?B?dVJ4OTlpem5iWWZTZ3R1am9NUkJyV3ZDYnlnaVpMbnZBeEhaenE0ZFVmbTAx?=
 =?utf-8?B?L0w4dHpDQ2NBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NVp2QjRqbTZVNG4xR3Fmc3FqdXRzb1lZQXd4WVFwYWtidU42WEx5a2xIb3FD?=
 =?utf-8?B?TDkxU1pSZVJiRitRcEVpdVMzbGlPR2JIWE43NVYvWlBTQmVsOVZMNVFESk5O?=
 =?utf-8?B?QWhZbnZoRlZ5MkhQRC9sSW1oT2ZSb2FHSENSS0h4VVZkeDYwK0ltazA5MElI?=
 =?utf-8?B?SDJqbVBZc3NYQmhZdlYwZ2ttOE5RcXBOZTEzL1htbnlGaVNZZXNKT29nVUN3?=
 =?utf-8?B?ZVVFUWlzSHhac0V0YlVOYVRjN0VDOWVuRDhGWU14c1JtaENvU2l4NU1BZFBK?=
 =?utf-8?B?ZEtoNUxwVUw5TDFacXl6K2ljT2VZK1FwWWxJa0ZZelk2ckNIcmVna0lGNjFO?=
 =?utf-8?B?aTQ3S2xXb0tsVzlvbEhMQ3h3OHZQSW9pNEh1cXZJSCthc0d0NGdYRDM5dzlX?=
 =?utf-8?B?aGIzbEVzYmc1aTdjS0Q3Sk5FaC9RZE56RDN6MUhnckNkQWJDYWZ3NVdDM3ZS?=
 =?utf-8?B?eUlTeEVyVTk2YUhOS0lwWDZFWjRaZ0xFNm01QXU4V1h5aWNhdmVQTERjTkE2?=
 =?utf-8?B?dVFBWmZvTVM1eExwbm1KZDdoeFhSaXcvS21BTUtGV2E2SmVvaHBCWW93Y3Nl?=
 =?utf-8?B?dEovcDQ2VDVrWDlaWjBNVEp6WmJmSzlEL3JoY0V0eUovT3lIQnQ1NUkvamxZ?=
 =?utf-8?B?aHh2SXd2dDR0V2M1em0yaURMaVE3VWJCcmVYM1AyVDVRUkgzV1NSMUJHTHRK?=
 =?utf-8?B?eUxRSitPMzlGYnl1QVp5NmRHdkZxVWMyNWJlU1BhYm1MeDZpZDY4WW8xZ3ZL?=
 =?utf-8?B?NSs2UGZma1hxOXp4b2daVmUxY0dYNDBGTDIrUGFqZHFtcnpZbFJMZ3VrWFBk?=
 =?utf-8?B?b0hnSWQxMW5yYnR3eWN0VHkxN1dMU2x4Z2hDaXRLVm4vQy8zK3JmRDV6QUR1?=
 =?utf-8?B?T3Z6Ym8xc0xiZkM4UEd3YmduazUxaVN2cWhmK1RMMVp2RWduM2FJTkhrWTBB?=
 =?utf-8?B?Uy8yS3cxZmZFQ0V1c2dmMUI1STY0emY5aS9YNVVmNmZKS2t3RGRMUVNtbksz?=
 =?utf-8?B?T2l0cDZwdWljMDBhV0I1bitvbVlyVlh3bnZ5bU9tVXlYN04wK1VsR3liMUZr?=
 =?utf-8?B?MkpWRTM4OEZLQ3VMMGdUdGRNelVJMm5XdFZReG5zVkY1bzN6UVNsMEtKSkcw?=
 =?utf-8?B?Tzk1S1M2Vi9jY21JT3Zla3Q1K3dDUlJTUXp4QUtaV2ZQMkIwc2k2dit5TElE?=
 =?utf-8?B?Q0M1T08xNkRmQ0NpbUh1Q1UxZFZ2cVRyKy9oRXVFSm92em9jaVpKWjkxaGtr?=
 =?utf-8?B?NUloVGZhd0N1UmtnbmoyNEYwRmtobTVrSzh3UndCVVBvYUhlUGpmZ2Eya3R3?=
 =?utf-8?B?N1JXZGFib0h0UUlBUWp2ZG8zTnovR2hSaTJzT1J0Z0xuTktmMGRYWjFjNzJ6?=
 =?utf-8?B?TmJKckZFbndBMlZ4UGlZcmRNenlCRTNRdVdJS2RzRGwxNklXcXdaMmRWTjBV?=
 =?utf-8?B?TDUraWpNWE1VUzhLdjJFWU10M1BqSTNiU2RpTXVTU1FPWTJFdXN6a0t2MjA3?=
 =?utf-8?B?a3g2bkdiTDlHaCtlMFRZeGRUNWNSNVVmVTFzVU8wZDhoVlVrQThleHpXNUxl?=
 =?utf-8?B?RUdFTklMdUJIWWxIcEoyb0J2aHIvU3JTUUJud043emRaTHQ4Yzh1Z05MVXZU?=
 =?utf-8?B?VlM1LzFsNjFwYzAxbWVVV3lGN0xKMDhZZms0ZFBMR0NqbVVHWDRGUHMzbjVz?=
 =?utf-8?B?ZHArcHZTck5uOXVPSnFiY1haWStXSjFGbFJURVpPaWozLy9XUlY4L3EwbUV6?=
 =?utf-8?B?OTUrTWR5blBkNk51N05OOVFKRGJNZ0habjdkN21JUlR2M0IzRDd4dEwvUXBr?=
 =?utf-8?B?TXFtaVoyWlNIK25Pekhab01ad2dJaGtkZ0E2dURlSTJOUlllQ0RSYmw2UXVh?=
 =?utf-8?B?YUVSdDFQK2tNNHRKV08yVmNOWFg5MnBHNUZMalM0N29TY0d1a05sYUtNdlNZ?=
 =?utf-8?B?L0hvRC92MEVmdWNOc0VkQ1kybTB5VU9PK3h0b1pxQ3BSOFlFSjBDWm8zaHFP?=
 =?utf-8?B?NkY5a3Nxd1pGVFdZbmZNZ0doL2V0RlNvN1BZdUs0NlNmRmdBU2NKMzVCNWo4?=
 =?utf-8?B?elhDemF6bHN6ZjJ5Q1d0VUI2QkFsV3RrNm5EaU9GbXlTRWhnOU4ranNLT2dw?=
 =?utf-8?Q?KwN6lhKlB1xBAKMOVrpcKxULF?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9660f93-3fc6-4afa-ffcd-08de24123645
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2025 06:42:57.3273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQMLxPmuJ7rExpUT4mQM37QEuhlswpFbeQYuVY9ETa5VF5qHwKeMBjBAcp3Tps1yyTntZuex4LNTYJu1HJydGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5670
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 15 Nov 2025 06:43:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20572

On 14.11.25 10:05, Sai Sree Kartheek Adivi wrote:
> - Add new recipe for optee-os-tadevkit, optee-ftpm
> - Integrate OPTEE-fTPM, StMM
> - Add ti-extra.cfg for enabling RPMB, FTPM and StMM related configs
> - Update Kconfig to enable secureboot
> - Add wks file for use with secureboot
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  Kconfig                                       |  4 +++
>  ...ptee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb | 28 +++++++++++++++++++
>  .../optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb | 13 +++++++++
>  recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb  | 16 +++++++++++
>  recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc |  5 +++-
>  recipes-bsp/u-boot/files/ti-extra.cfg         | 19 +++++++++++++
>  .../u-boot/u-boot-ti-am62px-sk_2025.07.bb     |  4 +++
>  ...i-am62px-sk-efibootguard-secureboot.wks.in | 23 +++++++++++++++
>  8 files changed, 111 insertions(+), 1 deletion(-)
>  create mode 100644 recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb
>  create mode 100644 recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb
>  create mode 100644 recipes-bsp/u-boot/files/ti-extra.cfg
>  create mode 100644 wic/ti-am62px-sk-efibootguard-secureboot.wks.in
> 
> diff --git a/Kconfig b/Kconfig
> index d322a94..536162d 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -104,6 +104,10 @@ config TARGET_TI_AM62PX_SK
>  	bool "Texas Instruments AM62Px SK"
>  	select ARCH_ARM64
>  	select HAS_SWUPDATE
> +	select HAS_SECURE_BOOT
> +	select HAS_DISK_ENCRYPTION
> +	select HAS_OPTEE
> +	select FTPM_STMM
>  
>  endchoice
>  
> diff --git a/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb
> new file mode 100644
> index 0000000..2cfff21
> --- /dev/null
> +++ b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb
> @@ -0,0 +1,28 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# Authors:
> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require recipes-bsp/optee-ftpm/optee-ftpm.inc
> +
> +SRC_URI += " \
> +    https://github.com/OP-TEE/optee_ftpm/archive/${SRCREV}.tar.gz;downloadfilename=optee_ftpm-${SRCREV}.tar.gz \
> +    https://github.com/microsoft/ms-tpm-20-ref/archive/${SRCREV_ms-tpm}.tar.gz;name=ms-tpm;downloadfilename=ms-tpm-20-ref-${SRCREV_ms-tpm}.tar.gz \
> +    "
> +SRCREV = "04cbc8a136e8fe6731a536f5fe145e2862feafd7"
> +SRCREV_ms-tpm = "e9fc7b89d865536c46deb63f9c7d0121a3ded49c"
> +
> +SRC_URI[sha256sum] = "7adfa71c4b49affef7d4db2436d8d6b93cdc3aaa9bdc9cf795c0bf7488a4cac6"
> +SRC_URI[ms-tpm.sha256sum] = "b77d092c0dde362adf6bc88a580ca7c8abe124d69bb734bf28f8904ae30494a4"
> +
> +S = "${WORKDIR}/optee_ftpm-${SRCREV}"
> +MS_TPM_20_REF_DIR = "ms-tpm-20-ref-${SRCREV_ms-tpm}"
> +
> +OPTEE_NAME = "ti-k3"
> +
> +TA_CPU = "cortex-a53"
> +TA_DEV_KIT_DIR = "/usr/lib/optee-os/${OPTEE_NAME}/export-ta_arm64"
> diff --git a/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb b/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb
> new file mode 100644
> index 0000000..6e396fa
> --- /dev/null
> +++ b/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb
> @@ -0,0 +1,13 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# Authors:
> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +OPTEE_ENABLE_APPS = "0"
> +
> +require recipes-bsp/optee-os/optee-os-tadevkit-custom.inc
> +require optee-os-ti-k3_${PV}.inc
> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
> index f8cd973..e73a7bf 100644
> --- a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
> @@ -9,3 +9,19 @@
>  
>  require recipes-bsp/optee-os/optee-os-custom.inc
>  require optee-os-ti-k3_${PV}.inc
> +
> +# StMM integration, required by UEFI auth variable management
> +DEPENDS:append:optee-with-apps = " edk2-standalonemm-rpmb"
> +DEBIAN_BUILD_DEPENDS:append:optee-with-apps = ", edk2-standalonemm-rpmb"
> +OPTEE_EXTRA_BUILDARGS:append:optee-with-apps = " \
> +	CFG_STMM_PATH=/usr/lib/edk2/BL32_AP_MM.fd \
> +	"
> +
> +# OP-TEE fTPM integration
> +DEPENDS:append:optee-with-apps = " optee-ftpm-${OPTEE_NAME}"
> +DEBIAN_BUILD_DEPENDS:append:optee-with-apps = ", optee-ftpm-${OPTEE_NAME}"
> +FTPM_UUID = "bc50d971-d4c9-42c4-82cb-343fb7f37896"
> +OPTEE_EXTRA_BUILDARGS:append:optee-with-apps = " \
> +	CFG_EARLY_TA=y \
> +	EARLY_TA_PATHS=/usr/lib/optee-os/${OPTEE_NAME}/ta/${FTPM_UUID}.stripped.elf \
> +	"
> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
> index 444f6b3..5ee5020 100644
> --- a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
> @@ -21,7 +21,10 @@ OPTEE_EXTRA_BUILDARGS += " \
>  	CFG_ARM64_core=y \
>  	CFG_USER_TA_TARGETS=ta_arm64 \
>  	TEE_IMPL_VERSION=${PV} \
> -	CFG_TEE_CORE_LOG_LEVEL=1 \
> +	CFG_TEE_CORE_LOG_LEVEL=1 CFG_TEE_TA_LOG_LEVEL=1 \
> +	CFG_CORE_DYN_SHM=y CFG_CORE_HEAP_SIZE=524288 \
> +	CFG_REE_FS=n CFG_RPMB_FS=y \
> +	CONFIG_INSECURE=y \
>  	"
>  
>  DEBIAN_BUILD_DEPENDS += ", device-tree-compiler, python3-cryptography:native"
> diff --git a/recipes-bsp/u-boot/files/ti-extra.cfg b/recipes-bsp/u-boot/files/ti-extra.cfg
> new file mode 100644
> index 0000000..faff390
> --- /dev/null
> +++ b/recipes-bsp/u-boot/files/ti-extra.cfg
> @@ -0,0 +1,19 @@
> +### FTPM + RPMB + StandaloneMM setup
> +CONFIG_TEE=y
> +CONFIG_OPTEE=y
> +CONFIG_OPTEE_SERVICE_DISCOVERY=y
> +CONFIG_TPM=y
> +CONFIG_TPM_V2=y
> +CONFIG_CMD_TPM=y
> +CONFIG_TPM2_FTPM_TEE=y
> +CONFIG_CMD_OPTEE_RPMB=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_EFI_MM_COMM_TEE=y
> +CONFIG_MEASURED_BOOT=y
> +CONFIG_CMD_NVEDIT_EFI=y
> +CONFIG_CMD_MMC_RPMB=y
> +CONFIG_EFI_TCG2_PROTOCOL=n
> +CONFIG_BOOTCOMMAND="setenv pair_rpmb_key 'setenv -e -nv -bs -rt pairing 1; setenv -e pairing'; run pair_rpmb_key; bootefi bootmgr"
> +
> +# workaround for v2025.07
> +CONFIG_USB_STORAGE=y
> diff --git a/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
> index 8fecee8..b97b70f 100644
> --- a/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
> +++ b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
> @@ -20,6 +20,7 @@ SRC_URI += " \
>  	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-sysfw/ti-fs-firmware-am62px-hs-enc.bin;downloadfilename=ti-fs-firmware-am62px-hs-enc.bin;name=am62p-sysfw-enc-hs \
>  	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f;downloadfilename=ipc_echo_testb_mcu1_0_release_strip.xer5f;name=am62p-dm \
>  	file://rules-${MACHINE} \
> +	file://ti-extra.cfg \
>  	file://0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch \
>  	"
>  
> @@ -56,4 +57,7 @@ do_prepare_build:append() {
>      cp ${WORKDIR}/ipc_echo_testb_mcu1_0_release_strip.xer5f ${TI_LINUX_FIRMWARE}/ti-dm/am62pxx
>  
>      cp ${WORKDIR}/rules-${MACHINE} ${S}/debian/rules
> +
> +    sed -ni '/### TI extra config/q;p' ${S}/configs/${U_BOOT_CONFIG}
> +    cat ${WORKDIR}/ti-extra.cfg >> ${S}/configs/${U_BOOT_CONFIG}
>  }

We need to set

OVERRIDES .= ":ftpm-stmm"

unconditionally in this recipe as it is the only supported mode now.
Folded it into next.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


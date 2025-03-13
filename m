Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040AAC282DE
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 08:05:49 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.47])
 by mx.groups.io with SMTP id smtpd.web11.9361.1741853145997656899
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Mar 2025 01:05:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JZcovwmr;
 spf=pass (domain: siemens.com, ip: 52.101.70.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTEhi3p2mun/33/2AncZkPlf3fUNnZ3P+pRDTvSShbHf7JrIKyUmNf6AaFTnphSof4fdh7DwOaWYRzwUfZCPy+atB7U1ZC0GDuvTyGFec2l2QXvuQYE6rpBEcuwrqk/8pPTTBBgN8ccnL/Awe+NZA2fIxRcb+6ztL0oYZDLv8mUv+nFgsIc/AB2xAR6OW4AQiUxkBrk4Cpqi/fU0/ljC2czTL+MdwKqHlWodx+0qXdN+bY/TH2Tpm3D+GHIvjYGxbmqu/QTDGyOp/UAfYKkFHyqS+w0/X8fmYHLKqATxf4r5q7Mj8DfdRrEAtW48tfxctPecVwe7G+sfgVEkf1XXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0AbvI7aXT3D3ZlpIVs53eoA7L2GjPnik+W9t4sR2v0=;
 b=w3uJFMYHys7HY/B7We9V0fV/jX8QYtBvOjrIgt43V83VvH/NRt/T8boKeTc77w0JB7WyGI3ITCR3bCyprSRQAcmSSAHO6Whcdkzyo4CasBEVtdNUjLMBYx1VxEtO3I1snjGf76ejSlZPiBHgJcevJMFWGVmV5dbgAkKRCghBpqTwswVBeCOP++ibD+3RfwUSAyUvMvqfXgNN5y5vkgR8Ibhq7MwS1e1TGbkM4J/5+pwWc6SkkFTPzX/CjtCYqqFSjpqgeAcjibXwK+b6qunbas3ynQPAs+Cf0bqtiE4Un25TLzzmYJmjLRMvGvfr0/Lr4ePJ1/ZQqk4WCusJ8shntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0AbvI7aXT3D3ZlpIVs53eoA7L2GjPnik+W9t4sR2v0=;
 b=JZcovwmrZ0T6Pu/v/QIzcBsk5p/SGSHF+tq7b/SqHjU9tCYZxCUplW4gtTbKSf0wVHUFfd6z87f+YNcEgjyED0ZC0Y/KGlVgszSHVgHwpPbln3Fgk2OBfCss+3TYyVsvws75PdonHLCFmN9Z9hWnbIBt7g95rPnplJI/Z3uOCdr0SbWAK4IaIKv+HDe9brppVAQMZhHX7Z/JETuwfnpY4vLnyOiyTkl8MVexntAL8yUx3DVJaoPrYeD+Ji0x2x645Vhp8FJa6ZI/1QlSkWBEzpk8B1EyRRxhnfGNZl8FY4CHmoHGNbaJZCxvfJFTKzHyfIhK1SUfo4fIsZOvIS6KJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8048.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 08:05:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 08:05:41 +0000
Message-ID: <bb8e5ed3-6309-4db3-9500-690901adbc09@siemens.com>
Date: Thu, 13 Mar 2025 09:05:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1 0/4] Add additional test cases
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250312131403.1360421-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250312131403.1360421-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd2ae30-1319-4bb7-4f52-08dd6205d914
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OXI0bnZpdEU5VS9OSEd2dUJKZjVBYlVuRDFzY3pLWWs3RHVHNzN6WHlDVVNw?=
 =?utf-8?B?cDN0MWJadDhhVW56a2V3RVltYXZ0bGluM2RpWEFZVzMwS0ZuZnRadWZtZmRB?=
 =?utf-8?B?RnRCOFJoaEdaYk4wSG50RW1PYkMrSEVqSVlUMnBnaTlWNm5NSE56U09mRjZu?=
 =?utf-8?B?NTJoUnRDOUhDTFF3SWU4bE85anVWY0lWb1gvMytKU1IwYzFIWXhRSHNFekN5?=
 =?utf-8?B?SWJFV2J3SENGMkYrc0VVak1xY1ZPcDlhVFB5d0syUzJLcXRwRHdnKzNKY2xN?=
 =?utf-8?B?TGxKRE84bWttdEJJSnY0U2JyUkZ5QzZqV0JBaGFreGNVZHRUOFE0SmZnWGhR?=
 =?utf-8?B?bkNWTTdockloUkFDU2U0Wm5EbmQwa1E0VmFnM3MyUHZOb3FRVXZQUUtHZGgv?=
 =?utf-8?B?SFlmSUEvL0VwMWV6TUg4NGNZY3ZUalB3Q3ZvR3dIWklIL3hCK1BYSUNid2xU?=
 =?utf-8?B?b2JzTGZXcUpZMCtvdUNha0xYczVMQ3dBazlyV1kxSUhLVkZnMEVFNE5PaWRL?=
 =?utf-8?B?MVRqSHhIMGRTMWFSK3JRS2RvNlJaNStBV0lLakZaL3p6RXU2U09mdnFkRk9i?=
 =?utf-8?B?ZFk5bzdRc1RqVnVKbUpNcHhkL1I5eGxuUldwOHQ0aUMzM1hvZTlPdEEvaUxE?=
 =?utf-8?B?czRVU3o1bXRFSkFsbW1XcThjZVBXNWVSOWd3b01NTXoya2lzdFZCaFNmdFdo?=
 =?utf-8?B?NCt5RE9oL0tBQmg5R0E4a0pZbFkyQnVsajAzRFZNbXZ1ci9vR2pzLzRWbmt5?=
 =?utf-8?B?aUZveWpJbkg0SUVCSnVxKzR3cTFtY3FEQnExbkRMamVoVXBtYkNDNWx3RWpZ?=
 =?utf-8?B?V3JBSzl6Y0MyY1UrTnFsWE5CaUx1NlVPSDA3ZURKd1RKZmlvU2dnSTI0YnZO?=
 =?utf-8?B?SGdScUI0N2xJaG5qRWhoU0tPSU9yTXlGZDdJZGFnSUZnL1E1Ry96ZUpEeFVW?=
 =?utf-8?B?TkJhc3dibzVrNTBMalYzVjIrdkM5NmNENkNubFFRQU5zL084OC9obnlPV0RJ?=
 =?utf-8?B?WHBUMUU4c0xoVUkxVDdBZDd2ZkhLRnZ1TWlzQTI4bmo5UHRCUHMzcCtRYkN1?=
 =?utf-8?B?NnNENmM4QkdVc1VscE1sTWQ5aktFK3djZFBJMWF1SGhHWE5uMFBtditwQi9Y?=
 =?utf-8?B?a2VxTWh3N0MvQldpZ1JoNnR2bjR0R1hRRG95RVJHVU42RHRQcDhIL0VXeFhy?=
 =?utf-8?B?YWF5bTB0b3J4SE9XR1RhS04xeXRnUGR1NXBESVhnSTV3SklwNUx3SUZNNnY4?=
 =?utf-8?B?bEYvbnNUTzZ5YzBBQkpuMFAxcklZU292aWtNaUh0SmRram5CdVJuNE1MWFpu?=
 =?utf-8?B?dVcxbUdNZms4dlVualN6SDdjRTc1d2RLRSs1U1M5b2U4RkF5THRDV09HN2Vz?=
 =?utf-8?B?aWtzU1o2aTFKTjhQbmY4Q0s4UVdsa1hIQTN4bG14QmYvUlhHaEwreG01QVZn?=
 =?utf-8?B?VE9QcThHbEZFbXo1WThneVA2ckVtSm5NaWxQZUJKZUVybTZpS0R6dU5WZm1h?=
 =?utf-8?B?Z1VvTmN3WjAxZEcyWkI1RGgybjRGckdZa1oraXhVRFg0SkI2WDNiKzFFTGlC?=
 =?utf-8?B?ZFVoZmV2dlgyNjNVdlQ0dlRqTHN0anlWRGYvQ3lvazQySGFMNGFmWi9EQTJr?=
 =?utf-8?B?UXNRZFhtTmZENlF6V0J3S2svWkVxMzRleXJTdHhzZEpzNGpoQkhsd1p5Y0o3?=
 =?utf-8?B?NERqYjNWWXZSMWFEbWlheWdoSHI3YzMySEp4dnlhUGYxNzJ5SlZrK0JySG5q?=
 =?utf-8?B?N0ErQ3NMMmdrblNOamFiSUErbnpIcyt3ak14TzgyZU9iVXk3cHNRV0RENG13?=
 =?utf-8?B?SElBcGZhb2dwMmpKbFhsYnhKcFp4clF5MWFPeW1aeVQ5WEtpNjQrbTdqNGIr?=
 =?utf-8?Q?XCYBokJh6VUn3?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MVNaUVJPc0dBTFFtTU9lNE9KT0JyOWpNdEx3OFA4NG80WCt6dTNZcUh1ckNz?=
 =?utf-8?B?MW00U0lTWVpoQUVPaUhzeEJwTGU3WFU5dDBXcTBFcC9qSzFJcm5HRmF2a0Y3?=
 =?utf-8?B?dGRDbG5nUVB5YlIxMS9pK1kzNGYzZmd2eEM4d2Y2MDBSQkZJMHJuczJrNVpu?=
 =?utf-8?B?T09QS1owRXBUZFo5MlovZCtITmxIWjlYalZWb3IxQ0Y1b0NBUFdHRCtLTDFQ?=
 =?utf-8?B?dllNMndEMFJoaWNvc2RRa3NLajlsb2JBTTFhN1QralFzNEo1Rm9sZVNQM2lK?=
 =?utf-8?B?UDVpY2xFTk9MQVdwQ2wwU3owOUFGTmEzeVE0VVFQc2lWTzR1K3oyTzUxYldE?=
 =?utf-8?B?V3RGUlRCd1g2Z1kwdUpudzFjNzl5TDlnUXNTdkpKSXgvb3lQSUVrRVhDZmJu?=
 =?utf-8?B?TkJVNkRSTnA3cEtKdjdsWFZPbTVtVUlEUnVQS1owMjVFZ2tPWGg4MElCUFJ0?=
 =?utf-8?B?MXFYaXR5Wis2dXNLalltQllscktGM1lUOE9xSGxlWHRMbVJoM2VhSXhDcEUz?=
 =?utf-8?B?LzZmaEMxSEpoK0xyZkthMm16QUsvdndxOCtVNTBpbGNzb1EyNUpDTnhHa1R0?=
 =?utf-8?B?SWR3RlRVRFRDSHk1bCsvSjI5eDV0aUVGbk9FT3FFRG0rWjNINEFJV3M2Z1Rz?=
 =?utf-8?B?NEZpdSt1VWFBMEZHSWtwbXdaUitkbU9vOVNJQzdmc1QvTVgwVkVvUlZvOUgv?=
 =?utf-8?B?bXBybTdMOE9EV2VzbC9mT0ZERE5WVEVOTGQ0UW45MUt5THJQK0N6RThXOEQ3?=
 =?utf-8?B?b09jWXdRZDg1Z3cvaG9Fa2l4SXhXMlJCcmUwUHhsMHk3bWlyVU1TWUV1dmJt?=
 =?utf-8?B?U1YwS1FESEp1bXFDL0srODBoajJuS2xpcWxCbTZCeC9scUlrNHZTcDQvdlhH?=
 =?utf-8?B?MVFDYVN4YkJXUjZuQ2M5TEZBZTRvZ3ZUNXZVTnFqZ1hJREdLTDJlYkQ0eXRv?=
 =?utf-8?B?OHpCTGdsWGgwUTZFTFRBOFVyRml0QVhjYWpGK3VNcXBGNlhEWnpxOXd0Z3dC?=
 =?utf-8?B?emNNWnprNHFwZW1yQ2xqUDk0aHBJdGw0aElNWGdSODYvbUtWZE9YT0FSN0lv?=
 =?utf-8?B?MnRnYUh3SnhWalpUbFAvQjhGNEV6L29SYVhESmpyYkhVZGN3M3oxSTh4Q0JM?=
 =?utf-8?B?UWExWjRETTlUdjRsTVhFaTc4eXNIeEttL0kyTi9tWUdWUjJaTmc1ZkhwYVp1?=
 =?utf-8?B?RHZzbkp3WUFmSWZ1SUdpeStQeXpYaVFRZWIrbVloQVRsV1Uxdk5nNVRLcHND?=
 =?utf-8?B?UlZHZVlmMjNGeXc2OWMvS0NkZFppMTlTNG1kTXNRcFFZUi8wMHIvQUF3a3dX?=
 =?utf-8?B?M1dUbTJadHlUUHZYUEtabzN5Sk9zRjE4K3FyelNRVmNzdHkrc1QxTG1vMUl3?=
 =?utf-8?B?WkdDeGVhUlErUWx6dW5NQ096ZmxYOVczdGJqQ3NyUFpXdDlxMk5iaVU4WGpT?=
 =?utf-8?B?QUtkREVGWGU5NStHSzkxcmtMRkgxZ0tLeTNiN3cxckdQY25YSmFpczYrL05X?=
 =?utf-8?B?UTdERkFtNWc5K29HWlhZdk40YWpIcnk1Z0UwUmowV25qYmFSK3RKZlZCN2JC?=
 =?utf-8?B?MlhCQ2VaaC9GVW1rbzR1ZEZ1N2I0SUsraCtCYkFvY2JaV3BWNUxZR3NuU0gy?=
 =?utf-8?B?ZUExcmw4QStTc3ZzT1kvT2tJVEhOS21BYUMyTWx3SjJZUXl1QW9BTGlBMmc0?=
 =?utf-8?B?UDA3NG04cnJjT1c0blh3NTR0SjdyemhZdU8vd295QW9lZnltY0szcnJzdll5?=
 =?utf-8?B?MkRtTnl5c25QdG5QYzFxa3g3UWZiV01DNTRPRUlBYzJDSVprblkySFRZN0dm?=
 =?utf-8?B?bkN5M1ZJTitHUlBmTTU0MkRpeUZmWndjNVJ1RGw5M1NoQTQxSDhBaFRBT2JE?=
 =?utf-8?B?elN3RW5SVzdUOFN6ZmRtdmNOOWg4RUx2dk5VQitGZi8rUlR1c2UwQkg4N2tz?=
 =?utf-8?B?YUo5ZlJscUZSd0dxTEFzWVUvSEdVTkNuN01YTDE3RGpHeThVeFBkdnRVaFJV?=
 =?utf-8?B?YzRTTWs3ck9uRllSMEtpRWpPekRjc3ZPVDkvbHlieENJQkdUeEk3bHYwdjR4?=
 =?utf-8?B?UmRpT204R0g4TjIwV1YwbFJFakhwcG9PZjhlTEo2SDM4N0x4TitRNHZ0S3dH?=
 =?utf-8?Q?q8vXoLkG6uhNNuuQTcduy5pWi?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd2ae30-1319-4bb7-4f52-08dd6205d914
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 08:05:41.4738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6Esb5JTFIfxZuqGu/kBaKwXFjSXQU8sPccbv6SvntQM1qxXg3wnthIjmVmvBQJn6z7GuOHSUokS6KBcwtpkZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8048
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 08:05:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18180

On 12.03.25 14:13, Shivanand Kunijadar wrote:
> Add the test cases to cover the different scenarios of SWUpdate and 
> secure boot features to improve the test coverage. The below test
> scenarios are implemented, 
> * Unauthorized kernel image
> * Unauthorized bootloader image
> * Corrupt .swu file
> * Apply the same image's .swu file(@config_check@)
> * Corrupt the artifact of .swu file
> * Reboot without confirming the successful update using "bg_setenv -c"
> 
> Shivanand Kunijadar (4):
>   Add additional test cases for swupdate and secure boot in LAVA
>   Update script to generate additional LAVA job defintion
>   .gitlab-ci.yml: Update CI to add additional jobs
>   .gitlab-ci.ymll: Enable security_test option for base images
> 
>  .gitlab-ci.yml                                | 147 ++++++++++++++++++
>  scripts/submit_lava.sh                        |  64 ++++++++
>  tests/templates/secureboot_negative_test.yml  |  81 ++++++++++
>  .../secureboot_unsigned_bootloader_steps.yml  |   7 +
>  .../secureboot_unsigned_kernel_steps.yml      |   7 +
>  .../swupdate_corrupt_swu_artifact_steps.yml   |   9 ++
>  .../templates/swupdate_corrupt_swu_steps.yml  |   6 +
>  tests/templates/swupdate_negative_test.yml    |  89 +++++++++++
>  .../swupdate_reboot_without_confirm.yml       |  43 +++++
>  tests/templates/swupdate_same_uuid_steps.yml  |   9 ++
>  tests/templates/swupdate_template.yml         |   2 +
>  11 files changed, 464 insertions(+)
>  create mode 100644 tests/templates/secureboot_negative_test.yml
>  create mode 100644 tests/templates/secureboot_unsigned_bootloader_steps.yml
>  create mode 100644 tests/templates/secureboot_unsigned_kernel_steps.yml
>  create mode 100644 tests/templates/swupdate_corrupt_swu_artifact_steps.yml
>  create mode 100644 tests/templates/swupdate_corrupt_swu_steps.yml
>  create mode 100644 tests/templates/swupdate_negative_test.yml
>  create mode 100644 tests/templates/swupdate_reboot_without_confirm.yml
>  create mode 100644 tests/templates/swupdate_same_uuid_steps.yml
> 

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


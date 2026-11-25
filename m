Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.63])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.38164.1795595343316526273
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Nov 2026 00:29:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oVCGpndg;
 spf=pass (domain: siemens.com, ip: 52.101.70.63, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMT2HzxcPClHA0p6hjio8BI94Gb8N13nk5Ql2F8c0cQUpb8P1edlyjgxgeiWT8mr8FeZym1UiQ6jtv9Z3U6W4rgEvu6loPKD6sX0kTLjkcMnx2CZRfpA0mKvG0/5NweeeqSxNjVP22bBny6r9GNQEHep6wBpmIlsNXM911h/g4jxTzyMVG+C/4eFwT3vtd2siReOEiWpYoQG1dFzumA7l/X80pVNd7gAwBvzL9ZpTs4aGnzzuxDT2d9dQapLOpkx692zv6kjvtmNLRxvGeqJ3cqrgoeaqcA9Pp6W9h389v4emhysufPwWl3B/H73d9ACfUGL1W6dQN0Ix4RX+YBhnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSpyOMW7IO/l24h6KZnYuNy3epWT4zktpC6L7DYpk40=;
 b=CSus+qNsTqAl1UrTLJpW6GcshKUxepQHjfWFw1F9ngYE5gn+sihBF1C75m6cdJgLEM2apHGPVklVdOhjO6/It5uM+NvDruN9+GTO2MLHy6/M7VPbmaffgaTHQzYiLsh/1nC8ivbZ2pWrky2HO/29PZh+QBhcTf6IRz4Psy6LHC7ydrozTfIbYdcTn6Ybk3rpxCNaFwztnIjt83WcN4h+8LehKz72AWilY2HH2aW9CT2nRpbnLFHmUQrEuBl4QQqqsUniAUziWlpHUJRY2AMPlWuWHdp6HL90CBrE9Dtr0+PzDzUoYlDFwUBLQH+53nZG9v965oXhie2rAMTi/nRlHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSpyOMW7IO/l24h6KZnYuNy3epWT4zktpC6L7DYpk40=;
 b=oVCGpndgF8rFXpW6eIKdO+53MRDQrU1kSdW2hnz44wKjH4dHFGTEyl9JiAhxr6aMhsaFNpIeGAIjwoxXabQVQmCMJBd/JOU7YzWJ2WXFBGfbZCOydR5nEVLNy5bQUEXTgFPsngw12VwPoW7djaUwzmyc/QliFTh58nIVToxh/DrFqwOEUVdaKlr0Cl6WEllckv86joC7ygQ3CgBfS17vkFAL3JVlE0czsSizaILaFZNRa9sJP3M4Y4hvv9bPyRomrUnWR+LKj3II9cqzGnjbITOmgiFbQYQMjHu0SbMXrvN9cBbLVO7bV8EjBx7KU6VWOerdBqW5V9oDQVPutyGM1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ed::14)
 by AM7PR10MB3907.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:178::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 08:28:59 +0000
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405]) by DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405%6]) with mapi id 15.21.0639.003; Wed, 25 Nov 2026
 08:28:59 +0000
Message-ID: <57d5b79d-4a72-49f4-aa00-703c750f4e43@siemens.com>
Date: Wed, 25 Nov 2026 09:28:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v3 0/3] Add out of tree signing
 for swu files
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com
References: <18E74FCA31FE6824.893556@lists.cip-project.org>
From: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>
In-Reply-To: <18E74FCA31FE6824.893556@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0105.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::20) To DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ed::14)
Return-Path: alexander.heinisch@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8045:EE_|AM7PR10MB3907:EE_
X-MS-Office365-Filtering-Correlation-Id: fd057a2d-722a-41b2-dcce-08df4ace26e7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|4022899009|10067099003|56012099006|11063799006|261021121427099003|261021123027099003|261026121527099003|261026140227099003|261022105027099003|261009223027099003|261028144727099003|261102123227099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: d4XDCIJE/K/fnX+bzKGDKsCfpduJcqm8hfVMk16RrearRzU0gwoCcnkkt9Z2nLrOpngsgVhv3ZKrCBEp/72MpE4vxdVrzZj6f5E9DPzNYtmEuF/wrLjCeHoCfx+w6ZdMlE61OL2fqjBBpqeGAArrjTc05369jkqGXFbvLNlLdp4mXJlWyZI62VuY0JcIt885B+pmlAW5uUaW116exgbT6RYGT6RbYSf8/lqvasFUsvWJoto6SoIJedau2P68d90SRSzPfZTm1w/coQ5bph2eC8P6vwwNGx2UcOmQBByZBJXvDQmyfE1VjUshbkrPZj0VBRVGHmrc5ghrdQLdzyAmIoN4SGhRBZR8xZmWTSpcCtDyauGhEfHPxPpYPlAxLo3zKFL/1LdBWiAG4aiPyT3pE2BIUI4UeGQZvIj5W2HU/t6HIR1gkJGMtbUTcoGKDm6MrKLWnC7uOYGPgNPZRnneAB8CYnfnBr6i3YmVnHIytHusam5tti/UsYr4aYh9r5D7QqRzWvn4sk9Xp2MpNfIe4ks0nelNrdh2lgnoe5jhiciJ6cUOT+UdO/yWooa0AQXDCoEPOyra7Yvcd8hVVZOsCQhEN8xXksD/7kLHYZNguex3KV/qg2l7IzqG5gzcEXrs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4022899009)(10067099003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022105027099003)(261009223027099003)(261028144727099003)(261102123227099003)(55112099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cy8wVUJRVFBDbjl5bzk2UFRlWnBtajdFK3NaSCt6T2NPcGY5WEoxVTJ4VXlC?=
 =?utf-8?B?alNqTHZsWFVhckVvcFh2OTU1NVJ0TEtJWWZYMkIwbkEwRklaSWp4a1dSdWhU?=
 =?utf-8?B?bzd4RTQyUXlqV3E1MUVsKzFrZHZGSEMzT2dqRXV4WHlocVF6N3llSjZLcXBa?=
 =?utf-8?B?RzBpOGNuekxXa1crbW9qczUwU0t0ejYwcnc4akJtSjAyRkFqQXFKeGZKdk5y?=
 =?utf-8?B?aWh4MGpZd05WY2k1b3VoN0h3YVRVUzF4Q1lWMW56MlBUN2FUYjRwbGQ3dHV2?=
 =?utf-8?B?VHN0MTlHMFFOL3p0L3JkaHdhMnlzbWR0WHgvaXR5cFE2V1ZsSnJyVlZLNGZ2?=
 =?utf-8?B?anA2TkVGVEQ0Lzl4ei9McXRPNFFyV1daR2ZlZkJNdE9jY2JPcnNlNENYQXh2?=
 =?utf-8?B?UVV4K0ZhclZveUxJZVUxNGpoWVJiNkJySUFpNEEvaVEvaEZRTU5OaUk1VGNC?=
 =?utf-8?B?Y2RVRnpGTlQ0dGQwWUgyOUFuQmNyUmtkRFEyU2VFWEppSzRFWlBsSmhJWTFw?=
 =?utf-8?B?QURGNkh3SVUvZUVJSWRPVFJ2UW1rU2duRE53WWdydHQ3WGc5VXpuMWZsYzdO?=
 =?utf-8?B?d05IdmxDVnNoVjNUcVFFR2FUU2FJYVhLZXFKMzNzelZucEFydmdnYlU4cWJv?=
 =?utf-8?B?cHgrT21PQ0R5dm1LSVA0dHNaV0gzUTlQcjZLYXI1djlnb1Jnc0U1ck1TOTJO?=
 =?utf-8?B?OEtsblpPaTFuV3I2eUthSGlNZzRwTnVJcXJsMVBGOWpRUCtTbElYbVo3cFM2?=
 =?utf-8?B?Y1pnM1B1Z3VQTXJ2MHRYcVY2N1RDZUk5WmlwMnV0RVFBNVRIT010enZHRCsy?=
 =?utf-8?B?NEFZRzN2Y2xaeXQvdG5ZallPZllSREhLVWFMTjBySFhtNFJGanR0Y3NucmJC?=
 =?utf-8?B?RXF4QmQ0bTJOMzFVNHVpRkp0eElQOU52QVlXbG4vYS8vYjZuUXMzWUZNNjBi?=
 =?utf-8?B?Yy9MT1JmMDRmVldNbkFON3N4TnEzYndDcm91UXV1dk1taExMVzVRQXBKdmpn?=
 =?utf-8?B?eXY2a0ZEZ2p2R0ZiWWkrVHA5aHYwMzJJV1JRakczQUlxVFg2eHVyaGdBM3BP?=
 =?utf-8?B?M1owd3J1TGFKaElPRlNQRDdHdXdRZFkvbUpGbVZWN3IvL1NuSWxVQnFnMkdx?=
 =?utf-8?B?QStqUU16MHZDam92ZHd3S1lvWnI1WTJFQ08yN1dBUThPQU96emIwNlhiQm12?=
 =?utf-8?B?b3RSYTBoTDJnQkpCVTE5NTR1QndveTBVSW9DbHIrM2Z4ZmxsUnE5ZmNETnU0?=
 =?utf-8?B?Y1F1NTlDM0RBM2ZRaGVTcENna2JMS2hFdkE2dTcxNE85MUZmMmtXQTFTUlJ1?=
 =?utf-8?B?bVhCOHQwYTBlY2RBVlc5Rktvdi9iNTFTV2JpemdXdE92NTBhREk2VExYZjBQ?=
 =?utf-8?B?eGhtQnp1dTJXVEF4S0F0NjJ4a015RXdaRjhDTi92dGN6SGVBOGx2dVNvNjFO?=
 =?utf-8?B?a3ExYkphZmtuejVmK3NhRlFIY3dpUnJvblJ4cGV1cWNQSXliRWlGdDYzZk9C?=
 =?utf-8?B?aHl5MmlvTzFjc25VYUhaQW9uOC9GOGZoUWpVSENUOWxFWjY5MC8rbGszdFpI?=
 =?utf-8?B?ZGRKTFRXVWdncWVIM3FPV3B1K1h5SDA1RUJvUXlzalZ1cUpXd3pqcDEwZEl6?=
 =?utf-8?B?c3RHNFBtVjhMcXgrOFE1WkdVNWlRV2tPK2NDc2hZMGFjRXZ3NVNyYk9UWmNX?=
 =?utf-8?B?cDVYcWtmK2FYUC9DMC8xbTF2ckFadjR3VGlKWFA0VGJncTYrNlhnbXB4WDBZ?=
 =?utf-8?B?MGJ2RkwxdGgyT2RWOGRMNWpBVXFFVk1qU0k5OEpzaWFOeVNBT1ZDR3pYNmMz?=
 =?utf-8?B?TEpONU5GZFRramEvWUNrNlRUUXpmRWFpMkZrekJFSStSUGFUcmxjT2VoSnFx?=
 =?utf-8?B?ajNoc1VSb1BvZkhpTCt0Q0Vad1dJdCt5OGtFVi80R2ZvOVdzOFkxTjZCSlFt?=
 =?utf-8?B?QUVOL2pVVmNMUXZTbDhaZExKbTI4MlJzbEhXUXJyUStBMFlaanRHbnNkVXZ2?=
 =?utf-8?B?c3ErdzUrcEYzNE5KWEt5a0lkOG9hbjNtK2IxNzBkZk1wY21oSnZLeU5lZGll?=
 =?utf-8?B?bS9ZQVVWU0JZNFJSWVo5d09Ha2RRT21PUW80UElFRFpwVkcvZmxWaU56dXRu?=
 =?utf-8?B?Y1VMVHdmVHNnRlovY1EyWnM0SmFFdmhuY2pxR09uUUV4QXNleFZwbHBkdGJv?=
 =?utf-8?B?cmY5MENoVjJPZjVkUzlnSXZ2MWZuUXlnbXIyOUZHMk96Z3VtTFRuVWwyWTd6?=
 =?utf-8?B?L2FGczgwVTZjYnlTYXI4bDgxeTBCUW5mejE5Ykp2T244aVNWQ2ZmK1poaW1L?=
 =?utf-8?B?dnM5Vk0xNjVrY3ZMbzhxVzdZV09aZVpjR2llVjB2QW9ESVU2UXdhMjdpWWVp?=
 =?utf-8?Q?JRtfp2daFldvjxZI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd057a2d-722a-41b2-dcce-08df4ace26e7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 08:28:58.8727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5RCVFaHR5qrj8ucREiw3Eb4ST1eEHueHAH0uRZ1RavFFUoQWdnysx2iCEK/HmtlHIq3YHEIG/JFC5/hvG52pyWanrLli2LzWC9RU1MWZaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3907
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 25 Nov 2026 08:29:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25071

Any comments on this patch series?

BR Alexander

Am 12.11.2026 um 14:38 schrieb Heinisch, Alexander via cip-dev:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
>    Following up a request from [1] I added scripts to sign existing SWU files out of tree.
>    A rework of the existing sign-swu-cms was needed to allow reuse in out of tree signing.
> 
>    The script interface is:
>        sign-swu.sh [OPTIONS] SWU_FILE [-- SIGNER_SCRIPT [SIGNER_ARGS...]]
> 
>    where the SIGNER_SCRIPT interface follows:
>        SIGNER_SCRIPT [SIGNER_ARGS...] SIGNEE SIGNED
> 
>    SIGNEE and SIGNED are provided by sign-swu.sh
> 
>    1: https://lists.cip-project.org/g/cip-dev/message/24534
> 
> Changes in V3:
>    - Made scripts posix compliant and changed shebang to /bin/sh
> 
> Changes in V2:
> 
>    - Fixed indentation to tab
>    - Fixed (single) trailing whitespace
>    - Added out-of-tree signing to README.signing.md
> 
> Alexander Heinisch (3):
>    sign-swu-cms: Refactor signing script to be reusable for out of build
>      signing.
>    swupdate: Add out of tree signing script for swu files.
>    README.signing: Added section on out-of-tree signing for updates.
> 
>   doc/README.signing.md                         |  42 ++++++
>   .../swupdate-signer/files/sign-swu-cms        |  84 +++++++++--
>   scripts/sign-swu.sh                           | 132 ++++++++++++++++++
>   3 files changed, 248 insertions(+), 10 deletions(-)
>   mode change 100644 => 100755 recipes-devtools/swupdate-signer/files/sign-swu-cms
>   create mode 100755 scripts/sign-swu.sh
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#24783): https://lists.cip-project.org/g/cip-dev/message/24783
> Mute This Topic: https://lists.cip-project.org/mt/122229754/8886423
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [alexander.heinisch@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-


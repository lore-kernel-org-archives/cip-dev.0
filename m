Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5675BCE8D64
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 17:37:26 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4062.1763141842109081415
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 09:37:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wZ1FXBs5;
 spf=pass (domain: siemens.com, ip: 52.101.65.31, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+qNAGhEUurvF7eHFlNERRKp9kDmoPR2luGmQZBiD9OgP+Lwg5PqB5OBX8aeUnh296x+4tB1prnSDOPnwszOgc5uEA2fh/iX4sjQP8K0qPiSZXrBPzJ055KkR8EXh56+o0BGfd0UXPzxxhbRL6hufls+M9iavrfYVC1Ul6Ir0WAilYp1/lkGC63fe/m+JxIZuufYHLvfTCat4SPLi9to/8Vw6Ep3/ky3UgD6JR94pTKrMkp0u/6JVahOVG2NxjDLdxjC6IofS/GKlV1S3jUMQ9NnPGAGZdN3y+nRsbXHWwYaf+X1GIyaMl0AI6EB+l3nTg10rQ3cb8QrddnSAWXlwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3gKsMCIDz9BQhl3RNNDc61kitfhsVFsKVdSgtBfRLA=;
 b=lgOQsBm5668UnD5fXJyFzs6keaq3U50YriZamIg0yyoD5o3WWEwCypRurZwDShX1rvo4TiW+0Sxv6iGwBWFhHr9jzAPadqSZ5bzwN1jPN4LMAfeizXhqLFpkuL4IXO+EXVVvWMsd5Z+d39UekzyEI5gIGre/TQqEOvGFS2hCiBPi9u3Uj2g1zyWFx/C2HZcC+z8LkhOYDqhmGQN6gUMaFdiXEERltBDomBk42QNEdVl389vZoIhgIJIQDFoiaAzjhU0J4HuBwPigHKUaKWp3m5g6zMm4LGXHYGRvAXl7vGY9nmtZNXuHqADXtet2xFE3dh+v61speKiGhBya8nyaVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3gKsMCIDz9BQhl3RNNDc61kitfhsVFsKVdSgtBfRLA=;
 b=wZ1FXBs5fe45GL/KcbiQiZQ92FhdrvY2Z1BWfJIOPtDCV6LMQOz8Cy2PQsv7JsUEJgIWxaPoD7IQWX1niUA3L62wNCMbN8AbRz1+5xm+Z+gBKiWZf5od7MAFvgFhPGQQnCRP2BL+Z9WbJ8bVWYAWNKiVfxfsD/ljl4WSjJzEDk0MdNuf+05MlVYRmn4je4HOgVpgRvOIgKS37Z7+evtDpQgwFsVVKC5dngcwrvs8Oc61yNFDevVA0WfpQY2IlmX+edhXkB2BKsVUldAAAvDju6X9K1U2mEXnfWE/dLhyk7tvFSnWKJv1egC7ZpZLhJRWXzl11BY4HhW4ziYTghbfXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6680.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:400::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 17:37:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 17:37:18 +0000
Message-ID: <07b0cdc9-6aa1-4ec5-b9cf-44fcd5a663f3@siemens.com>
Date: Fri, 14 Nov 2025 18:37:17 +0100
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
X-ClientProxiedBy: FR3P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 694756eb-a229-4a90-5802-08de23a47518
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RE5iSU9Dc3pYNlJKb2wvLzVrdjhRVFA1MU9rencrb1JGeWl3Mk5lTlFLT3FX?=
 =?utf-8?B?NmNQdCt4Z1djQWxvWDNXQUpNZ3lJVTBPVHQ1T2NMd0NMR3BsdjFyM0lPRGJC?=
 =?utf-8?B?VFdpOHJvQy9xV3B6UHdWKzhMV3FCUTNQYWFUcGtYWnZXU0VmSXBxcC9jL1RZ?=
 =?utf-8?B?ZTFIL21yYUZMN2wraHJvQ1hSL0dxSXdueU0vUlJZM09mZWFqZXRpMXY2cDEz?=
 =?utf-8?B?VHdScUJjRS9KNGZUdzNNV0doQ3RBS1I5YU9odWFxUjE5OHIvTDFYZlFicUZ0?=
 =?utf-8?B?eGRtWHhFV1N4RTc2aTI3djRvU1ZYYUlueC9wZEFsY0RPMVpjYjhHaFBtNWMw?=
 =?utf-8?B?dE9KQnY5RFljaEl3clY1RzlsZWRkZ2tjQXFJRXZKbWg2V1FDV1RYSVo5T3JT?=
 =?utf-8?B?T1lKbGUrTGtadEdvRTY3WnhGS3hOSG5mbnh4S29iTUhIajVOL3NUM3AwRFZM?=
 =?utf-8?B?SEQ2ZWNWV0FHMTRwNHE1a1EwQ0w0cWNWa1dCd2d6dXZicmloVWFDck9aWmtz?=
 =?utf-8?B?WDJxSWZQdFBWSktjSEYyQ2pDRVNrc09LZVMyM1RSV2hjZk5oVmhnOG8wZWxU?=
 =?utf-8?B?UVJmS0QwL2tJcVFUMTkxWHBKYVpjT1JncXMxWnczS2VZZkhmeXJMVjQvT2VS?=
 =?utf-8?B?NFhRWjRUOWZ6MHlUODIwSGpsNVJKVk9VZmorK09CTHlmZXdEcnc1ditNTzEv?=
 =?utf-8?B?bEswRlFnMmpPMTgrcVpjK1dCdzVwUE9MdHozVWN3UUM3K25GcW9GTFIwY29s?=
 =?utf-8?B?U3lXNmxPV0JNZWM4TEZ2aHgxZitYd1lIYmxJbHl4RkozcWVvSWMrVDNKMy9K?=
 =?utf-8?B?d3dxclZuYjlqNGRFTkxjeUVWQXVJVXJVS0tHaXhiOEZkVC8vdE1kTHd0Z0F5?=
 =?utf-8?B?aTJxUHpwcVNJZmNqemsxQ1M4Y1lqTUJWdDU4eVJ6SHZkZkhPOVZiZzBxM2or?=
 =?utf-8?B?OFhXZmUvb1NreWdBVGpEZm1mNk5WbFNpd2ZuamE3d3JQL0wwSnN0OVh5cHpG?=
 =?utf-8?B?L2lSQWhpVUJ3RDFSMWgwSkdMK2F6Y0txR2hzblBGeFlyWW9xOVFRQjk4VHdN?=
 =?utf-8?B?ZzZ0WElDU1F1MlgrWGxtYnZuV2RxY0FIQlF0WmVTMTM1eHhZUkd6ZTFYbHdI?=
 =?utf-8?B?WG1RMzVHRjc0RzZSa2k0WGpMRUNrcFhzNExybHNrUlR4SGlZRzhmSDl2cXZq?=
 =?utf-8?B?Zmh1WkhwOWNaSCtJeEw2LzNqZ0xyTEJOTXU4ODZUWkJwYWNxMmJrcVFMNXlt?=
 =?utf-8?B?ZEtKeHc0WWhuTkQxRHI3eXYyM1BMdWRRK0xCa1IzREk4Q3BUb0hJSWtTemhM?=
 =?utf-8?B?MjFGbGdWczNGTmw0ZTBqZUd6QSt1czR2Ymo5ZFlGSWdadjd1djdyaVV0QU5O?=
 =?utf-8?B?U3pGUlV4V0VMWk5CdmQrVGJTYW9wajlUU1dqRTNKSjl0QWNBWUpTTFZ1SFhx?=
 =?utf-8?B?Rmk3ckVwekRIV29IZkhyN0R4WUY0R3JxcHQ2Wkh2WnlxQ1d0dzZhV0ZEanhU?=
 =?utf-8?B?RGlocGVIS2hRY2Y3QUxQSlJFMHJqNHFQc01TSXVsbXNDSC9VOEVJRHQ2UnpJ?=
 =?utf-8?B?MTVIV3BUL1dDNE83N0FJVzJrZnVEV0daalFWNDQ4aDIyeitkeVF6SVZnRWcz?=
 =?utf-8?B?aUlBclo0SEJzMk1BMFp5NHdxTGFId3BUWkt5S09mbzdSdkxJR2RPSlE4V1pT?=
 =?utf-8?B?d0g0Zk93SHdlMklJcHhLTTh2VGVKd2VteVNLRmFmRzlzRUF4QTVWTlpadHJL?=
 =?utf-8?B?MXEyakpEYUpPcVVjV0Y5UE5VNzdDSHhIM1VCaXRVOWNDSDF3bjZPdXc2M0pL?=
 =?utf-8?B?LzVmQUowWUtJRDJxWG50b1ZJeDYvb05YWTVzZURmNkZJT0hIUEVraHBMQ3lY?=
 =?utf-8?B?MUs5Z2hmNGFOdmdGc2Fhako3ZDR6TzduMnp0WE1yelVBeW4yYkVibVdNUmZK?=
 =?utf-8?B?VmJ6NHQ1cVFuZy9SVU5aV3hFcmZGV25mNzR2RnRmMkpzRjNINFJvMEhIK20v?=
 =?utf-8?B?OWlPRTFJWENRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NDRhYkU1ZzJxRCtjMDhOZ3JJak8zVHVUZUFCb3l2WWl6amdMM0RuZmM1Q2M2?=
 =?utf-8?B?TkVhcjFDNlRhTjc0WVdCQ2ZwUUFFejFKdlB0bnlwdTJXRFFrZ05LTVZFOERK?=
 =?utf-8?B?MzROTVJsMHNCU2ZwL2hzVEtBd1dicHJqd2pXQU5tMkpzdUhqL25KRjRxUzFk?=
 =?utf-8?B?Z040V25aRE5jbG1ONHpxM25NSEZGdkhJWThHUHdDeHViTW95QmdWSTFMdngy?=
 =?utf-8?B?NFlIWHQvbjlnT1JNckxlOWJjWk1YZzVYc3NMbkd0UkxOOWxOdVZ0ZmJJVG1D?=
 =?utf-8?B?TG43VnFiMFl2bC9uM21ROHVSZTNjSXFZNmdvNkQvL205SG5xWnZLTzB3QTlO?=
 =?utf-8?B?TzNwN3dEaEdveFJWQW1nVXVvWFNqQjhVQU1OM2NuMjlmUFhRZmQzSWV2ZnhB?=
 =?utf-8?B?T2gxUTd1RmNjN2cvMUpxb3JwQWQ0WWgxNzBqUE5HWElFZVQyeGV4SEhndVRv?=
 =?utf-8?B?Yyt6LzM5ekloV2ZnZit2Y2FPQlkyMVJoeFFURzdFOUp2TUlZK0xteENyWjl3?=
 =?utf-8?B?UVUrQm0yVEZiYmFXb1pPV0lHMU85SDI0QzYvVVdxWkJyU0dJT0dLQkJ4NTlJ?=
 =?utf-8?B?a1lRVUg5ams3K2k5M0lNeTRoV0Flb2kyQ1lEZCtLNmtQYnM4SzBEUWxkVENp?=
 =?utf-8?B?dlNWbXFnSXJVQllnQlRrRElpQ2pHV3lLaE0xVWJ6N1RoR3YvRmxPUzJzVG9W?=
 =?utf-8?B?aXFPL0tRcHh4dmtOOU4zL25uaHExOVgzQzduUGJvN1R5bWU1WUVoa3dxYVVh?=
 =?utf-8?B?V25kVXRuZkJ6ZzI2aVU2ZisvREZRd0Ziek4wRUZoZDBPNFgwMEN4V05JUGtR?=
 =?utf-8?B?cTl3Y2w3WEpEUUdYL2h4RnVMSWFKV1V1YzFBQnFkckNzR3lJSjh0M1pwUk93?=
 =?utf-8?B?enhnR2dtbXQxdGREbFlsYlM4blZCT1JTQUFCRCt1Q2h3SktndzR4dm9LTG9w?=
 =?utf-8?B?T3NFbTRtU01Tb1NCRUdNVmFGUExsbTQ4NjUvbnJDSXJNWVNUNVdtZ1lrUDBu?=
 =?utf-8?B?RzQ2SmNlV2I3aTRDTEo0YWhtYk8vYWVRMjQ1U3ZscmRBRm5oSndMWTRtQUNh?=
 =?utf-8?B?dTkwdDN5UDk2SXFjdkZYcGMyVjM2bVFNKzlGNU5FWXJ5N0g1eThCaTJPZklN?=
 =?utf-8?B?VmFsZy9Pbkw1TkphOFJBNmE3T3lQMTVsWU0rQW96eDNwR29HbllSelhrM3BC?=
 =?utf-8?B?UHA0TmJDVnBDdUJGczk2dHVJTzZaZm9FY2IvZXFHMithRUQrVWhMQ1VWbFEy?=
 =?utf-8?B?WTBFWmdTUnpUNlBEME5BY2xXT3ZRSzhVK3dSdllENXZHQkNrdm1LU3YyNEVK?=
 =?utf-8?B?Mm5sOVlrMEg1T0xzYXpKMzhIWTZiZzJTbUw0RVdVT0FiNStCdGF2azVicU1u?=
 =?utf-8?B?TWJCUDNWSUJ6bjVMR0J6M05ZNnJjLzVmT2ZXTkx4UDdPem1RajNOTy9VME9Y?=
 =?utf-8?B?WnVjajg1K0tINHJFRFdmNGh0eVJnVzZVOERjS1dLWmpxWTRJNldmM2YvNlBk?=
 =?utf-8?B?TU5TaXgxdW9QTXd6U09UM1I3WjRHMll1Yi9YY2lOMmVDOFE1aENXdVhvajhV?=
 =?utf-8?B?MnV4SnNadWxib0JtWWRmSTFlUW4wbU9lWXZ5eTE0bWI3ZjNha1VRa1FMbnIv?=
 =?utf-8?B?UU1NYkxrWTlMa1ZEb3gyRUlKejI2WDZlNUxaMEUvOHdYMDk3WkpWL1pjVHhB?=
 =?utf-8?B?ZFdyY0xLSEUxanFUMGExNFlzR0xqeFhxejlOR1Y3OVYxTkVYSFhJVEgzVG5Z?=
 =?utf-8?B?dXJFSGRLTnFTOGxIcmYvcTEyUStFY3l5KzFlVmViMldRelJtOFI1S0RORXJX?=
 =?utf-8?B?WmVWMmd6YURyNU9qNzcvSjBlTDc0VFlVWmZHVE9qYkVZQVJDeGlmaW9WeVpF?=
 =?utf-8?B?dUwzZmlBMHJnMEhqUUplMmorMFppZHdiN0RESnpLK0pHR080ODZBR3A5blQ0?=
 =?utf-8?B?bkZBbklCckc5RWJDektidXBKeG9Ya0p3S2ZpZDZSemNGYmdrOVBFNDZnL0pr?=
 =?utf-8?B?SVcwQzY2NE01NGtNQXVRZkozL3p6TXdIR1M5ZmpKSHYweEsvNmJiaGN6QWFj?=
 =?utf-8?B?UzBSeksrNVU3WDNjbmkzdDZ5VXhnL0RnN2lNVzQ3dWpoaE5QSTN3cWwwZmFC?=
 =?utf-8?B?UTJxem01eGcydm5xeUgyTHFxenlHUXpDTXpZeVBlZVdsbGlSOHFCWE1rcG1K?=
 =?utf-8?B?a0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 694756eb-a229-4a90-5802-08de23a47518
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 17:37:18.0897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7FHIEiNnlcEbF5S24e4y02KR5PP6P6Zzd47KUSbjP7BcSikkCXdQgb8+gQWrcE7dvS1gkbhRsW+ajr8OTSklg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 17:37:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20563

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

Some of those are part of ftpm-stmm.cfg which you get anyway. Maybe you
can drop them in a follow-up patch.

Then you don't need TPM support in U-Boot for our integration - or do
you have scenario for that? Doesn't do any harm, just curious.

Did you already test if measured boot works for you?

> +CONFIG_BOOTCOMMAND="setenv pair_rpmb_key 'setenv -e -nv -bs -rt pairing 1; setenv -e pairing'; run pair_rpmb_key; bootefi bootmgr"

This looks suspicious on second glance: pairing with the RPMB should not
be done in production but via a special firmware. Critical here is
optee, but I see that you are not setting CFG_RPMB_WRITE_KEY=y (unlike
we do for testing of qemu-arm64). Still, do we want that code above in
the regular, secured, likely signed firmware, even though it should
never trigger there?

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
> diff --git a/wic/ti-am62px-sk-efibootguard-secureboot.wks.in b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
> new file mode 100644
> index 0000000..52fcb09
> --- /dev/null
> +++ b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
> @@ -0,0 +1,23 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# Authors:
> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +# Boot partition containing Bootloader binaries
> +part /boot/firmware --source bootimg-partition --fstype=vfat --label firmware --active --align 1024 --size 16M --overhead-factor 1 --extra-space 0 --use-uuid --part-type E3C9E316-0B5C-4DB8-817D-F92DF00215AE
> +
> +include ebg-signed-sysparts.inc
> +
> +# ABROOTFS partitions
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
> +
> +# var and optional home are extra partitions
> +part /var --fstype=ext4 --label var --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9
> +${WIC_HOME_PARTITION}
> +
> +bootloader --ptable gpt --source hybrid-boot --timeout=0 --append "rootwait rw console=ttyS2,115200n8"

My questions are comming late, so I'm taking this as is. Please try to
follow up on the points I made, patching on top where needed.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


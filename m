Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB631C8302F
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 12:09:19 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.46])
 by mx.groups.io with SMTP id smtpd.web11.38314.1751285357206765930
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jun 2025 05:09:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tiHp1dTU;
 spf=pass (domain: siemens.com, ip: 52.101.69.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjotsrxJ/tCg1b5XxzE6Q8xrJlEcbNDEXypwfPMcC+2Tbu7lPWb9lvelBqDfXFuAmA7bQiUFrTaBrEWwgCvFU8xNS6WWHKfGEokx+7frRgWrV92ZDUu1d80j+MKQatvhoELRqxh74ztDEZBOlr+7FobeW0/sHFBlO650uz5+nwjxYVjlPE4wvoxLLEGdBY5tNGjD+2tLzPjLeH2eCIP8RwxBoXUkr3flVbAtoANZZuwkEevsHO5Fs+1VlqInecavzUNszVvIdQy/0Xxh1DJwBzH8UcmhLayprEb3KUKcjzwCBEWbQmUFP6cK1lwA5wFyorHHcwQiWQh+bLjp5yM8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spknLgubrr6/IpEiSHNbRdzldv+At7zKm273GO0+tRs=;
 b=NCXHGDQCOyhkiizTLqA1ATQCnSw2aRAPnflrcrZzbVBO8MIv2jl92xowzZrZrn4kQ5uW8AI60QCUXwpIz9/gVk1f+DD8QteeUmRDrpHC5gSiGzIt9H/uibDwqmHK50JOypATx7+XuExJw6zsAtGt5NmNPS48+tdp9qHLQWg6Pj/O7Tz3o2pbIuLYAEPhrF536PBGqCoQRyecna1MFgRvmZ7lVZNVuTXRakfSEBlqn5/ApntuByNe2OPIgG8dXF2ZSwRIPVnavCHjmeOsb/CVU+Z8c5x0is+k/Ib6EIy2lCzHRVFJ73+r2FEfZ3gMseh27AchdIMAvnCuN0DC7p/WCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spknLgubrr6/IpEiSHNbRdzldv+At7zKm273GO0+tRs=;
 b=tiHp1dTUkcRzrHXHzM9tCnNs5w/pt5F3jq/jmYv6RYqJJh1YW2IFaOaHBfAkvuz5Yx2GBXqnQNV1Nryb5ybzEMlGuENlF6l0DX6O6L6Oja3gTlmpgX6tNKR6r5bH+hW2hpDbk+vCy0w0yliu1rD6YYakrIOQLn69pEnai4o4BsfJEvlql1a+E9C8sV89Bub/3lrx2DAGHL6+FWxFw/P1jY35jh8brmxvuImnBP8PieaYhlZmHhCegaq0NLqj87D5mPmEWRq2XzusXclTMhLxhb2SZ8o5eQeF5fJr8WPBDoKuFu8P5zaTGGzA+Lgr/oWkoSBdl6PBZ1z02CA/wZJMVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8833.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:232::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 12:09:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 12:09:09 +0000
Message-ID: <c0d77687-a1da-46d8-b8a5-e3361c38ac58@siemens.com>
Date: Mon, 30 Jun 2025 14:09:08 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: isar-cip-core 1.8-rc1 ahead
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0328.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: a170c44f-e485-4ad2-f9b0-08ddb7ceeb43
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UlkvbzV5bmRQL0dkOWl3MnBNK2o4dml3elpPNmsyQ2tYQ0FSL3NuUHp2djhW?=
 =?utf-8?B?WElUK1pLbGVRT0NUTWU2YlFXb1l6aDBqVW1MRFRQYTl6SGJES01PVm9tOXM5?=
 =?utf-8?B?cjdzODdvMWkzMDF1SGhnUjNEWHQ5Q05CQWlsYWFDUmpnSXJpeUJRUWZwZWxI?=
 =?utf-8?B?VTUvb25SWjFaMm12Z1VYNTNleURtTmVxMjd3NzN0eDdiUlZ2TGg2V0ZIbkhX?=
 =?utf-8?B?TEJoTjErSlczTGxuVDNNV29DMklxK1c0L0poajJJL1dkcXZaVzRjMU02VWdC?=
 =?utf-8?B?ZDJXaGRzT3ZrOWtHSjFWNjBXTFVtTnJSSDBLMWFHSEYzSGZqUUFzQmh4VCtX?=
 =?utf-8?B?NmIzQ0ZOYkUvU2tjQmtVSEV6WVJPSXQrcVRDOG8zUVpFK3RzM2EyM1A4WW1L?=
 =?utf-8?B?Yng2d1RRVlQyL2VOZGlseHdlZjA1Ni9TVW96QWxSNzhEeitFaXRnbjdFTDd1?=
 =?utf-8?B?V0FtbUdYOHROWGc5TXg3eEtoY2hUMGpzN2lYdndVaVNTS2RLR0NyUXFZOUlo?=
 =?utf-8?B?ait6ZmJmV0tnak0wOVNQeTVjbXlTcW11d2dDRDY1bDA1SjlSd3NURU5MK1hm?=
 =?utf-8?B?RncvUTQzVWt3aGNCaWR0d3BFM3dSZGZXNVZNcVM5ZzRtemxUMHNzN2JTZ1pV?=
 =?utf-8?B?UUpWaExGeHdFcGFIOHNoL2oxN1VoSHpnMWpsenRoQkZaTDVYTGxXVnhuS2RQ?=
 =?utf-8?B?M29PZGEzZ2xMOG8xbkZ2VTFNVm01WVp4YW1XNThuaFRoSmZsRGZ1MGQwQ1h0?=
 =?utf-8?B?RzlwYUJuSGhnSzZwOXEyRHRUVG5ZTWM0dnZuV1grWld4d2NJcFJOdmFVbHd2?=
 =?utf-8?B?MlJ2Y2wrQytuWUk3aTdha1lDL3ZhSEpFVWV4Qitna05kT0NEclU5eU5IRXJw?=
 =?utf-8?B?SDA2Nmd0LzFnTzlvcWlaNitmcmM2ck54eFdjZFlaeDJXalpGOHlnTUs0VTZx?=
 =?utf-8?B?VjdkaGFYdVZLSlJOcnFtRDJMOGxERmdEQU5yTGNGWXI4TXU1Y0cybEFEUkRH?=
 =?utf-8?B?YjJnZWN3Z25DUDd5d05IQWg5bXJjWTZ3YWk1RkNjT0RpbW1BOEk0UzAxQUQz?=
 =?utf-8?B?V0xnOWg5VGNHS1BIcUxMNzFmT2kvbmw1WXhYQUxDajhrU2FiSmdiaDgyOVlE?=
 =?utf-8?B?VTBPUUNucTZZM2lXMC9VUmhFb3hCbHVhaGVHTFZkZWFqd3M3STdqSmYwNFlv?=
 =?utf-8?B?QXY2WkJCR3daU1VabHJJNXJ2bFhzVTBkY2pJZlpaZjFGbWdUVE15STlLUmpQ?=
 =?utf-8?B?blhXbUYxRnBhNEVadVlFbko4VTBqZWRqcGc4bFlCN2owcWZxcXNrQVI1TStr?=
 =?utf-8?B?aHMzQ1B1czFTbkt3TUZrbVRDVmRQRHhXN0NScHBFRnpJMVhoQTlXUmE4RXVX?=
 =?utf-8?B?QjBrL2FLSlVuWDVrdVlZdk5rT3NqWjY0cGJBemhCTk1CL09MS0JWcm9td1RN?=
 =?utf-8?B?ZFFxaDBaTHloOFhoT3F5aW1CM2owaTV4TzMyOEM1eERTWXkzQ1l1QVVPTlZK?=
 =?utf-8?B?OVl3UXFNcG1VY053dlpqRExMbUNCbC9NTjAzbWhoNUxFQzZuZGZQVU43KzlD?=
 =?utf-8?B?WXJ6LzZ0aXBacTMvWVZGTEFBNnZHaXUveGN5ZkY5Q0xsbmhmOC8zSXUwM1Ez?=
 =?utf-8?B?VHZHOExIbW82dzJaZnFJUnhkbG8waWpUbXJoak1EQ2xCTHZWdjF4ZHRHeTF2?=
 =?utf-8?B?ekhCVkp3alZSVkU2K3BQUFY3MUwwNitVWnhFbWxpOHdjbWxYNENTcjhCYVBZ?=
 =?utf-8?B?NFUvWWdqempwb0Y3a2FKb3M3SzdQcG9vbG50Nzd4ZzFPQm1KeFQ0NzRzRFFx?=
 =?utf-8?B?b214aXhSV0tRTE9zTHByNVQvVUl0ZmI3ckwyS2tUTUlidk84cGx3TVkwRVBV?=
 =?utf-8?B?OXN1RVZ0R3l0RktXMU9JYlp6eXhWT3RROWFXN29QS3BmTFVwdVpsZFJsV2FD?=
 =?utf-8?Q?KkziiAvkCW4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OTc5MGU0cEVScmxFdGJGaldPVHZMZWNnZ2RSSUV6Ri9zT25CSnpiNkxZWkwx?=
 =?utf-8?B?NXJ5NVNNT1JERXdkVkVlc2R5Nk0vOWJ4MmsydWZRY3RvemN4VFl4MGZPUnNn?=
 =?utf-8?B?SzkzcGU5N3l3MDNGdkdjdjRMTGZmcUxqMTZzeUxZZVQ5eDI5M010ZEZvSDA1?=
 =?utf-8?B?QU1mcjBEKy9waGs5Z3pFR3FOaDlnVTlzQ1ErRVV3SUR6QWZKMmhOcFQ3TERk?=
 =?utf-8?B?T0ptZERhWHNOb3dyTmpRYVY4UU1BZUJSRWhncGxkK0xCNUJFdnlHNWV0aVhu?=
 =?utf-8?B?b0VNbUFKdk1iTlNJY3R2NXo3dnFYTExIVnVQZWloQ0pKaTMzcm1xRlBmVm41?=
 =?utf-8?B?ZHc0K0RzU3dmQmFJaDVzOXRQWWRkbTQ3QThkMXhXV0ZHYkVvWTc1aFJ2cUx1?=
 =?utf-8?B?dzJvZkwvRUljZnhzK3ZJSXk3b2EvSWtMT2JmNDBQazMyVUJqdWMyTVp2cnZ2?=
 =?utf-8?B?VU5IcnlXbGRFTUxDNlVWbWh6RWdPSTVCdThJR3htM0tIWFRDVko3ejROTU9v?=
 =?utf-8?B?YllDQXpsL1VOS0c2TTdZeFZkaDczMUFJL1h1cVhUUmZDRGJyMExNRitINkV3?=
 =?utf-8?B?RXhZbGVKZm1KVmYxbHdLWDV5c0ZlQmErYUl3OHJxb29WMDl3d3ZBNXlKNjlW?=
 =?utf-8?B?TVRJeEY2VFY4UXBuK3VibUEyNjkyOWs0OUtRR0dITkdWdVU5UHJ0aHBJNFVR?=
 =?utf-8?B?VDRIT2RnUDQyMjZsd21SWGppamdyV3IrMW1oTmV5c3ZncEZBUTFlNmV0cjhZ?=
 =?utf-8?B?eG1ZTkRGMGNORERxemRQWWlTUk9yU3ZHTi8rZ3U2Yi81MEJTZmZodEVrcDhC?=
 =?utf-8?B?Ny9LdElLWTU4VnRTdTVxUjRGR25Ic0RBWFNPWXNEbmN3elE0dlp0V01VZ1g0?=
 =?utf-8?B?MnBUdTBneEhhRm83bGVYUVZDTnpYcDA2VjdYUFVMYVBxcXFmUW5XcFNEVlFL?=
 =?utf-8?B?cWJvcWZ5TUFFZUZKZTZMcnZuQnBscW1TMy8yNDduOGhYajY4THBBY0lxVk9M?=
 =?utf-8?B?SEVtTW5ET2RHWDl4bWswb05ZWjlMRFlRSmM2U0ZsZ3Z2MmFFaDNGSy9NM0t2?=
 =?utf-8?B?VWUrcU9MTlppcndBVXhtY2p1dXgrbWVxeUEwWTUrR2JjenJpZGlVZDZEeWN5?=
 =?utf-8?B?WUVGMFRxRGxzdVFROUp0NUloZEVIS1NWOFN2MWtZQ0NFMUp4MFVUNkpZcUlS?=
 =?utf-8?B?TzAvWEw2akZyeGZWSjVoRThsMEFaZTVPYlhTUGJleFpBMVVGVm4vemh0QitP?=
 =?utf-8?B?emtzcDhNWm9udm9QWlQwUHcvRkQrQ3FHS0U3Tm5wRDlabmlESDVBaDVLMVR6?=
 =?utf-8?B?SVJSQ2NGTmlCdkx6TTFEM1BDYUdVNkE3M0NaaU9BK2V2dllBUWtGT3lQNVEw?=
 =?utf-8?B?SnZQNHRob3BKMHVJZWhKR1RkekZnWFpDeEFEd0o3WXZ3SmljVW5ucGZOWnJV?=
 =?utf-8?B?WE1pdzhubnJhOTBqMmtSNWxXT0p0T3ExRy8xbE9UY0xWdnZaeGxKZllDMTNZ?=
 =?utf-8?B?R0phbDhCdHVjZGxTaWc4WTFEOTBEb2dYS2VodXUxUmtXQmdCZ21iWjdrME9E?=
 =?utf-8?B?VzZxV1AxZXRPQTdoMllpTU5ZZS9QWWdaOEF6QVdwdFlCb0h5L3B2NEljMzdp?=
 =?utf-8?B?a0dwV2dHMnVEb3Fad3graTBIZ2F1bkxRLzQwQnYrNnV4WHhmTndhSjMwdndF?=
 =?utf-8?B?YzlzZ0FKQ2dYVWZtVzBvaFZtY2c4S1pwYWxSdkt1cGRsODFCZHdQS3huVWpo?=
 =?utf-8?B?NytSRFhvc0tDNlZEQ0lZc3YrRS95bFZmS1FSbkF0U20xSjhQSUx6OHcwLzl2?=
 =?utf-8?B?R1NWNm9xcFpRZGh3YnJnT05yS3Jnalk0N2pHVXhBTllZclhGUmRXUGpKWEFI?=
 =?utf-8?B?ZlZKMzhWdzFHcHMzWkJORXVCU25VdlhmSmF5UW0wMWQxK0tWbW9JM1ZabkZh?=
 =?utf-8?B?dzBxNWY2bmUyS2RsQ2Q2K3dhYjVZUmh6WGpxbGhueDJoZG4xdFBkWVNzYWRx?=
 =?utf-8?B?QVZTSXpnWFA0S1U0TVg2MDI1ODVXMGlJcUxpbklPYXlodGpVYVp0VFlkU1FZ?=
 =?utf-8?B?TGdaRHNGOWNvVWsveE80ZlJXd3JsWWk0cCsraElDMjEzemJWeXVlWXprUytB?=
 =?utf-8?B?Vys0WS9NUDJNT1BhMUN6U253eERMbmovL0pxajB2eGpvN0Z5VWpkM1B1VHhN?=
 =?utf-8?B?TUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a170c44f-e485-4ad2-f9b0-08ddb7ceeb43
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 12:09:09.6363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQIUvH9j7BK8EeM7Pp4vWsBQkV5DXeCWkIC1wIKtM4Qg9W7GjG7/o7i/1xH7jFyDnUvQtA+9nDG329f80K58YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8833
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jun 2025 12:09:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19256

Hi all,

in order to stay in our release cycle (more or less), I'm planning to
tag then next rc by the end of this week. If I missed some pending
patches or if you have something urgent in your queue, please speak up.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center



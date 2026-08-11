Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65EDC5B572
	for <webhook@archiver.kernel.org>; Tue, 11 Aug 2026 17:09:22 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.59216.1786468153512498243
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Aug 2026 10:09:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kRWqbPWv;
 spf=pass (domain: siemens.com, ip: 52.101.69.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHM+drhFwqtXst9/4VlHqMwAPVb5DKjR3k1AAOZPrIQ8Qd9g3PcrYIIWGiAXTYgZ7PrFSOJOjCXNDL4+3XS8e+MG4nA4nFVOwG2RQ952ZQbW4VoxThtKPtsqtLiheHqWGhNhvOQ3vqa+PBPjpodRLsBWIg7nllWvhr9cmBmLWYI5HlwxeO78EmWHKwonuCSTT5TisJtkj9a6o0kRn3IRg3o8PCPjZ16Y/vVaPDzppn5r+SozOcSnfWIOP/25kqIcaWDLr+TQDl6txURRxNYUeR2yM6igPjloaYQDexzOK3tuALaWQB8QKjwmSCjItWI8lME0jGeai6swDSCm7HoNEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keR2e2oYg0y1eQsenhuuR6vvxlUodv/Fi5xWxbwJ84c=;
 b=iGV+X+wVy7Tl6XANIDMK5/YlZx1rcIPgiDAPlHMltvodZESc9t1r/f3wZDTkD2jyo+pli4ZznERnloxwOL4LPVfzmvJ8IwNiUU4ggWQ9KFLh9EJfQbuHNWUhW0iE94cmpNfj8ADOAoFbAgxYHbqeEqZp7zMTxM/K2zfC4rkskTCyuJaF0nh8Shq5gQWb7N3DuoXmuKBm6NAh/JWmvouOX7DOmfcq/AqTweqjapiVhkA97tNYdw+Qd5ED3brc1iEddpBiJ55OtMppo78BMFPJK/Lb47YpWOP3F8OuZlPTFEHYW88nLxrZbnQ6uXwsQC8DyzUJXFhIhXiun8O99WpLxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keR2e2oYg0y1eQsenhuuR6vvxlUodv/Fi5xWxbwJ84c=;
 b=kRWqbPWv1XUnjACvs57jRgfw4c/Jf3PdqNpREhZT79pHM2hu1qFqcy54usqSrbz750oAM//G0teqtFBDHR+Ve73h1wDImGuZXc9WqwYxFY8oaRTY/8gKxj0J8rr5onYo7s9/mEUyexkxAI+ZrEEZTEWW4j2Cyp1h2PhrcTltN8RX97YqVB/OvRpSjR3PwGh5AbTVJyQN7SFSNvApdZnpxEcYIoqMC6LUkIBEOPL5zX8zJlb7EFWR4ubOc5r2am6KEl4D/sc6qB716IItxV/d6fNJcXoZuMXbWyXxHiuIRqpCFWQZKd38PIQWl/rPnh7Wz9ZNNdrsjLOxaP1NuKq1ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8948.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 17:09:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 17:09:09 +0000
Message-ID: <c8b01319-b1a0-4d43-9707-b12acb2ff19f@siemens.com>
Date: Tue, 11 Aug 2026 19:09:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v3 0/3] Enable debian forky build & test
 support
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: kumar.dinesh.h95@mail.toshiba, kazuhiro.hayashi.f74@mail.toshiba
References: <20260811090421.3547180-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260811090421.3547180-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0033.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8948:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f23801-5bd5-441a-9626-08def7cb40f5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|55112099003|6133799003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	lrDrYh4f3s4yhsF/Jcd6KURRFqma+nPN8ZX4sdAi/gB5YbLdQIJ3ZdfqF/5Jl2v7E2kz7B678dg/w4SRlFehYgCYkyTdlJiyeRiY5QsEtwQ7j3GC5pSc6mWxX3Pb9y+SxCEQxiv+yIcsHAUIQgpfnQ+1FI0sjeqIa/kYqQaUkv3c/BbonSaM8EeyLLSJTaRShbMcnNE8zzfwpAjF9HERFiUdRRJW/ZqocWGhJ9tgo0dqifaqXxJ8QJ6X9fAhErrNAQgg4XAsdaOHtxqIukaQIOPUXthMDqK6cBwf4lCRlFTvGdLQLh5mX3cZLJoCIkYzqIc6KQ6rk0xTGxj5WejeTIk055rvVotau8tIXI6XMW35pJ6PViur/eAb0vUHDzMx2Z861jnNJT17EMGMXC2uei1Hn3jAXhUqWGZawt4yUZbVTfd9rxZc4xU8gfBYoeM9NZGFITgDUd6n5l17124gBtbSrF9MCYnhZvVE6y6Xg+bLhvmrtmooD/oKcjUjUutST83j/bKzECHUBrBjBuyNzXzOFsZgzMREjYaUk5khy7ZCgw6PbKchNk98B0yafiI5V0FUL4TEteq1NvC758XGzC+jeEBL1qr8lJeGcXafwTAqaylufy+zelEB/gnmLIgip95oT/6Udl7uzY4kWkIVoFRnjhmIepWBJDgn+0eUfa8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(55112099003)(6133799003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MEQ1SVR2Zk1DUFJpdXREaGRzb2JqSzhheUZSYjhEMW1nVlF3TGlBeXdUaURG?=
 =?utf-8?B?QXZ3Y3d4VFd0M3RzelNDVy9hV0FFbldNTHpGSENma1VQdmlZQ2pESk5wLzVh?=
 =?utf-8?B?SHp6UGpORkpVeW0vMUsyNVRyWEszUXJFL1IrNHFoUlhLZ1ZFejhoUFpnMVB4?=
 =?utf-8?B?RmpBT3hiWWlvL3lvYzc3MjMwaWpIQXphNHB6b2tsSlpxSXNadGdGcEQ3MktG?=
 =?utf-8?B?Z3BjcG5Sd1RETmU5azZwMC82bDh5OXJOZ1lUeGYxb2kwck1nS0pFdEFDL2ln?=
 =?utf-8?B?a1krT3lGdTNMMVFVaVVEQnlHTDh5RzZVTEdTd0tXV1JKc2owL0NQUi9uQmM5?=
 =?utf-8?B?WFdxVlZMRXpvV2N4VVIvcW4zZmgyaDUrY1BMbXhEamRDNk8xMzB6QmlJQ2V6?=
 =?utf-8?B?VDNCZVlDTW1UOUdZc0V6UHZQT2FtOWxLZXFidEYxMmprVTlTK2RaZmJFMjBU?=
 =?utf-8?B?TlZQRTF0VUsrZUpnMDk0S3Y1MmJUMmU5SVpTQlZqRVBPUW5BUVJXV0JuaE5n?=
 =?utf-8?B?eTFoWDZ5cUhiOS8xeTU5QzNFQ0pNdDY1WEJvZnN1c3VpQkY2Y1pSVWhUOUdJ?=
 =?utf-8?B?S2I1MjFhOUJHK3ZXQTVLM0p0cUVCN0tXcDArMFQ3WDZ5WERIZDlZMC8yMXd6?=
 =?utf-8?B?N3FycFhwaC9hZ3dBbVc4U0hHdlhxUzJWNUMzS0x3OFJuMlVzYzdzZ2JpbWpY?=
 =?utf-8?B?bDdKckVvZnhtOTA2OE9RL1pMcjlDN1BZMEJsL04reFU2Zlhlam1TUDZxSG9Q?=
 =?utf-8?B?N0JOMnRsdDRwakhXMWd6R0pEay9tSWh1cGZlQXduNGhLdUxaRkgrNk5ZUEky?=
 =?utf-8?B?ZUdVSE0yOGlqeXZyVlZoUWYzVmJpMFhxcGNMQy9pWWsybDZjaFN4TUZSUEE1?=
 =?utf-8?B?cHl4V0t0M0tqWTdvcFRqdCt2c0pPd0tRMHNJTEpGNzkvMGxkbmdyeW1TeGQx?=
 =?utf-8?B?MmJoSFA4R1ZncmdaL0RXeTBTWVdlbHI4UkFBdnRtNGY1QlUyRW8rck5aSkkr?=
 =?utf-8?B?Rnh0cGtlYlBlL0huQkFVZ3FiSjVEZ1RiRC90TjBqQU5sVTlRQ0RQb3Z5RDVq?=
 =?utf-8?B?RDdPOVR6V213V0VwVDJ1SHk2MGdtQkpWVW5lZ3gyNDNKMWtqd2FzVzZJQnp6?=
 =?utf-8?B?di8xdG9WSkNOcFduSmU4bzJzbm5CNnhyeElCSzNiVW5WdWRTM0NrQTVHcFRw?=
 =?utf-8?B?MFBUMVEzUSt1Y0pUd1RzL3cwZzQybDA3VjJsSU1nZEZiMHhXdktvV0FSakVY?=
 =?utf-8?B?aUdWalQvK2kyck1UdEVFME1tVENiSk05NzVvVWZwMVpzZGVqU25WT0M1VFk4?=
 =?utf-8?B?aFNyYXJWV0N0dWRFd3F1aUsvZU1OOGVGdlEvUm42VDl0VGtUdDc0VnJLSXZx?=
 =?utf-8?B?YXNCNmt6bDVJUWd4NlQ5M1pCTmRrZlRIdkRTZ0gxTCtKSm5lb1phZ0xrdWUw?=
 =?utf-8?B?WkpRRjNJamdjbTBDMDR3NVFjdzJqUk1DOWY3UlA1em00OTF2V2FWQjNHY3pl?=
 =?utf-8?B?ekhlRWIxb1ZBVW1RdDZrTGY2bGJvZVR6YUdUZTgzWWI1YTlYSjlZWVdYenJV?=
 =?utf-8?B?SkNraCtwUXZ2RWpCdDBaZmNnWDVzNldDbzBBWTU1RlR3V0dhT1Y3QllTZnJM?=
 =?utf-8?B?UTYvemFEakFXT0FnVGI1RkJWYTZ1VHZWNEV2d1U2ZHhwUVZKNTdYUGk5RWVh?=
 =?utf-8?B?c2Z0SlRIbGhwRmVJa1B6ZjhrY3ZMOEVYUVlaTzRZK2dRa2R1TnJRTW9pNHl3?=
 =?utf-8?B?TnBrSndCUUJ4bEJ4bTFyMHVRbm5hbTJWNXQxVHpmUlFMNEdqZXA2RGFlSVBa?=
 =?utf-8?B?OU9HZ3lvd2c4RXhxSndoMytxZ0VubHBrSVk0ZHdncTMxSWpnUzhEYTZJWm5E?=
 =?utf-8?B?NTVJZFFwR2plOVNEa29kcDRMKyt6QzR5L3hjVVhIaFUvcWpQZ0VNQnR2Qk9l?=
 =?utf-8?B?QUthaE5PbHlKV0FtN3J6QW00Z0doRWd4Yitld1BjREhGb0xtYVBIanVNSVdH?=
 =?utf-8?B?c1p0WVZHcFFiSFZEaDJsNGIrWUtuS0V4OXRJbmd4WGRjRlU5MjQ0M212WXRB?=
 =?utf-8?B?Mll3akJ1eGdRRlozTHRQUk5aUjdPUTE4cWM3V2JybFUwQmxWenlHVGVqNDRq?=
 =?utf-8?B?ZzRsdXJyRWtFNVlUYS8yWUxNSlFFL1FYbVp3NDFRZHpBOVRpZ2RmYW9PMWk3?=
 =?utf-8?B?ejBRdXA5ZHBGSHlDMHQvOC9yMU1pMkY0UDEvNk8yYStrbU1xQmtickt4NGVo?=
 =?utf-8?B?WmpPNXNBNnNyYVFLd2pLNWxETS9yM0tiN2VBUTcwYVNiVml4QXBOWkVQQ3J0?=
 =?utf-8?B?SDJ6YUJpUTc0Q0d5UE1TMFdXMGI0RVBvemkzMW41ckdNSVloMTlxUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f23801-5bd5-441a-9626-08def7cb40f5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 17:09:09.0345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fQvTncu9033MjBU+HTeHvkagr2Q76VbwbUmNGpev3uq3hx2ztQRAyLXv8jljY+KrAggpLQN6gkZoMT3wYZbFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8948
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Aug 2026 17:09:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23901

On 11.08.26 11:04, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> This patch series adds the debian forky based image build & CI test support.
> 
> It enables SWUpdate, secure boot, security tests in LAVA and RB in gitlab CI.
> 
> NOTE:
> - The existing .reproducible-check-ci.yml is updated to support forky
>   images reproducibility check. No need to add the exta scheduled pipeline
>   for forky, the current scheduled pipeline covers both trixie and
>   forky. The forky builds and RB tests are kept with allowed failure
>   option as true.
> - Updated authors list for .gitlab-ci.yml & .reproducible-check-ci.yml
> 
> Shivanand Kunijadar (3):
>   .gitlab-cip.yml: Change CI variable to CI_RUN_UNSTABLE
>   Enable the support of Debian forky based builds
>   Enable CI image build and test support for forky
> 
>  .gitlab-ci.yml                                | 152 +++++++++++++++++-
>  .reproducible-check-ci.yml                    |  72 +++++++++
>  Kconfig                                       |   4 +
>  conf/distro/cip-core-forky.conf               |  13 ++
>  kas/opt/forky.yml                             |  15 ++
>  .../files/forky/PkKek-1-snakeoil.key          |  30 ++++
>  .../files/forky/PkKek-1-snakeoil.pem          |  23 +++
>  .../swupdate-certificates/files/forky         |   1 +
>  start-qemu.sh                                 |   2 +
>  9 files changed, 310 insertions(+), 2 deletions(-)
>  create mode 100644 conf/distro/cip-core-forky.conf
>  create mode 100644 kas/opt/forky.yml
>  create mode 100644 recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key
>  create mode 100644 recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.pem
>  create mode 120000 recipes-devtools/swupdate-certificates/files/forky
> 

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


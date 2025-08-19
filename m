Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A410CA0EE6
	for <webhook@archiver.kernel.org>; Tue, 19 Aug 2025 14:44:34 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.10])
 by mx.groups.io with SMTP id smtpd.web10.16215.1755614667339766350
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Aug 2025 07:44:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mxpWwuTn;
 spf=pass (domain: siemens.com, ip: 52.101.84.10, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSa0os9BWENhDaRy8x7QMWYFpZhM3Dd7WWGarulxcFMztU3P+RN/aWL/7iNx4/O8MkvGDUlLFNC7TORyQDR96QtSqORZk74CedmG9JLQ4M7aLjEsU62TXrPK2OKPKWV1qsMKx5oNoNYIeR1zt57O9RC80vwQ1XOUiz+wu1Hm2X/vV+lWrdfnBdQ832KvSPnhW/vs6oEleEWmJXzqnVdFGlKE3r2m0/YPaO17QFXz0KUtMKqIm7H2EKbjCf8T8qelSaQpQ71xkqyR31zTnrc5kd8WLy0hNnFelolS7MfH7a4dwIZspXp5Sn/wdCDUbPaUawwbd39aPDT4q2L8hpomaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHmiOmi9S0/gAe1NS5CnrBSB66AhM8UUw14IBEU/Yfw=;
 b=sbty0QE705MTSZIKIBW6Q/knx+wtBMNwTX2SRzQfKSYif5uCPHXWt/gpuO4GBPlc0lO5unp9C3Sb23h0XGUpJXy36HRP3LHse6yKp3hJsxKBE71YaZeMPEjKD7TzGhBcVrPxf+xuAxExFbshfr2BuntjbTZ/S1mvXQfcfmoFsQ6Uc6UAOC1r34ASsOfEs2JmEje8ABmOekJyH3dfUY6n3EWi83L/rSaTlg1BN15B8RN7bQLOsunGWVPcoe8uj+Wv//UoTGp9rxO0NLH6begABQqPOpSJJxfwNXW6v2XwDRSBB7bbAXO4rom7vSVCO4W5LyEpKfg5zZueBeq4obKmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHmiOmi9S0/gAe1NS5CnrBSB66AhM8UUw14IBEU/Yfw=;
 b=mxpWwuTn/sBXWUP6qypfFObRjzrRZVepi280sjwAK3qplWD6qdGm2qOf1h4IYRXqqamOr1touHwsAhiXYGTUPnliMP+/AItv1+vq1tJud56WU4fc/wHB1ngsnLz0KMgPXvbkIKB9Rgk9vgczSP37eI3uUO6hP0hqiPF1KfApzA8Q3K8GQNDtNjglo5GyI94rVxcdzcMTBz7SsnEjL+bgnLOCmWhEWWXNpy8zqyhk3mttXeqDjshz+lBQmZpi9hg5HF4z2HNo8RV/NsL6l0wXn+HETIhsbIQ978zExwlWAa1L7wCvfX8w+qvwPVLIAde7GCsZL99sUDeacaA262NQ+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4090.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 14:44:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.024; Tue, 19 Aug 2025
 14:44:23 +0000
Content-Type: multipart/alternative;
 boundary="------------sT6MdyrJ3XzJAmKxznSnLNSV"
Message-ID: <d57a510e-3048-43dd-8fbf-7e83ef0d4461@siemens.com>
Date: Tue, 19 Aug 2025 16:44:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Effective QEMU devices usage for testing in LAVA
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 "Shivanand.Kunijadar@toshiba-tsip.com"
 <Shivanand.Kunijadar@toshiba-tsip.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>,
 pasquale.nieddu@siemens.com
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>
References: <TY3PR01MB11075A93846FA70A1AEB01145C735A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <TYYPR01MB151321574499D48D7E7119A7AB730A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TYYPR01MB151321574499D48D7E7119A7AB730A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: SG2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:3:17::36) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4090:EE_
X-MS-Office365-Filtering-Correlation-Id: bf84b149-707a-4de0-4bef-08dddf2ee367
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|8096899003|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cEtCdHY2dTBHenRUTnRZWFg5QUNIM0xZK0NZSU94dTFTWXlGbnI2Q0xBWmFp?=
 =?utf-8?B?cm9HYnBWNHMvbXp2QkNBR3A1UEhSYWh5RWFPTnhNamt4QkFpVWhjeFBSOHFP?=
 =?utf-8?B?ZHhTRFRKKytFVk5MSjFHSWs2UklIM29LR2J2K0dSL3FPRTlsTUphNXJrT2wy?=
 =?utf-8?B?UWQ2N0tXM0wrV1BYNUYrV2NsclJtTnFUQnhtVU5NV1oybkNKY0xHcDNiYUM0?=
 =?utf-8?B?KzJSQzFQZzFabU5tZXpnU0FLTTdSUWN2a3ZtaXdzNmxDZ1RFdXRhbEpzbW56?=
 =?utf-8?B?S2Q2d2VwWVlVU0VTcHVTWFJVeDhYSktjK3JibkRranFBek00TzFieno1dE1F?=
 =?utf-8?B?aEVzSis0UHEwRFVCV0RMSC92eWgwcE5iZjEyWTZBck83S0x2RzVBcHFsZnZT?=
 =?utf-8?B?R2p5cFloek1ER1M5bVJDdWx1aWZOVFZ4anVSWVVVdkNGam1DUThwbU9iT0xT?=
 =?utf-8?B?VzNCdTRrRURCWEVGTE1YSG1CN2pMamgxMmpDay9XUDdHQitlMS85K0ZhOTZD?=
 =?utf-8?B?SmNPc1RpQlRqWTlZRTBlWExqbTZ2b2I1RHJZeUNnc0hCWkFNZDZyN1NXR0l4?=
 =?utf-8?B?KytaY2oxdkNoQi9FSWU0WUgxQzF0V0xVVk1kS2c2MGdMMGIvSmR0S2FkN0o1?=
 =?utf-8?B?Yk5hY3dCVmxOYWxjTzgzMXcwKzRKVEwvNkpXWHd6enFadU50TThmRUQ5V2Y2?=
 =?utf-8?B?MENybUpHVUJLR21iU2lkZUdUV1AwTGgwcWJtZjdvRjNCRWowN2tsNy9qQWsx?=
 =?utf-8?B?aFNBRmcwWVpKMmpyQm1zOFRsUHdvcGRaajJhc2ZiVU5BNjlwNERuUVpneFpN?=
 =?utf-8?B?MFFjVDZ6R051dUJkaUh5VHIrUG95SGlFNHhFUnFwZ2N5MTFleTMvS0VPTUlm?=
 =?utf-8?B?UitNd1pBOXIyeFNYS2JHZXZZTnZYN0lJM2xtcW5iMGw0NlhCQm5QVHhpempl?=
 =?utf-8?B?L3ZMR2xzYXdMaXhIS2ZCNG5ON2F2YlhGd0tQSTh5c3AwR2JMdURUOVMvU1Nz?=
 =?utf-8?B?QmV3TVM1MjErM3R4bkZneEVxRnFBN0xvOEpKS1RPNWhmVFRpNW54TGtsUGxQ?=
 =?utf-8?B?eDdoVzQxV2hUU3RKcXdJZElEMmFaTkUwU0VYaWtyejJoTVBZalBOTWtjRHpn?=
 =?utf-8?B?dGhnUHN0aENQMmZ2TXBOYXhIWHZMbVNMNm9QZ01uUjVNQUhycUhEaGNVSXVJ?=
 =?utf-8?B?WURDVFNwRGJGZTRwTnE3QkZkbENKNWZGQUxoMWR5TUhuN2d6bGxuUFNCTHNi?=
 =?utf-8?B?Sktod21MMDU2Lzc5RjcyZFNCYlBiOFJsWmlCSEFzbFZkRGNVMGluMTVsUVFW?=
 =?utf-8?B?MkJ1R0ZpZm5WZkYwcENmbkhqRGFkNDVBTmwwMWVwbTNXd2w3dHpvSDVYMUQ4?=
 =?utf-8?B?Ky9PQW1Wb1JlWFJKVDMxcFpYYW9LSGx3MUFzQ05peGNPNzRqcEhxSFBPYWlC?=
 =?utf-8?B?K2RwOG5lZ1k4WEJBZDBqZkdIWU80bXl1c2tYdndpc2daZjBmTkVjRTA1c0xJ?=
 =?utf-8?B?SldpU1N6NmZuaUhDR0VISXRSMFppcGlsZU1aWW1ZSVVJdlJRN2x2dytDc3R0?=
 =?utf-8?B?ZWhqSi96UlZHYnJBNWtvQ1ZRUFZOMnd5WmdZeGY5WTZ1Mzc2UnZxNy9manRt?=
 =?utf-8?B?WGwzZXFzekFnNlUyV2RvY0NQMWc3VWt0SEF2N3htY2dmSjlKbGNTRVNIZHBk?=
 =?utf-8?B?SkE5YTVZMHlMYzJRN1NMcGN3TnlENU8yY0J5L0hEOHA3dXk5emI4NnhOUVRG?=
 =?utf-8?B?Wm5sT0UyMkk5aFhsSFArRUpYTFR2M1BUNUYwcU1iRFdRZWVjK0hhbGdHVWRO?=
 =?utf-8?Q?B1WjNjX3lPoX9Lk1Mdg7zroR2nFEBtTxHfan8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(8096899003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?djJpSVlEbFk2NS82VUk1RU9malVSLzJTNHNPK29nQlpVN2JZN0ZJSUtWNlcr?=
 =?utf-8?B?OGIzQnV4UHNsczRGUE1kVk1QWDNzcTY2RTBpbzNOWVpSZXNpdm5QZ21tNXl0?=
 =?utf-8?B?UHIwVUF0RWNmQ0IwRFhBTGd0TUVpVENNUVV2YlR5NHI2WVM2eDR3L1o1MkZq?=
 =?utf-8?B?b0xQQkx6bXVQNDZXVUxLWWVXbXpIdnliRlpES3NmV3orc1pQZGxJaUtOazRU?=
 =?utf-8?B?cjRpMUtwMHBvZmpGSk9FRkVBVUhDOERpa3BxbWFNVmhsLzZwRXorQmRUN3Jh?=
 =?utf-8?B?QWFQbmtrYUZIWGtOdFZ3SmYxc2dYdjFjSHBCUHFEem9UMC94Tm9wRTZ6Z0VS?=
 =?utf-8?B?NzlXN0lPYmtLWmk2MzhId3h6R0VQbkpOWiswWklXSzdGcmZaY01NZFZxREFH?=
 =?utf-8?B?UG90V2lXdzR4VndlU1FicW9sQ0Rxc25JeUpZSktpZHBFYVZKMXBZbzVoNFNX?=
 =?utf-8?B?VmVTWXpZdkZ2QURIY3VmakRmV2ZTN3ZXbDhLZDhRVWExd1dXKzNwcUdFczlm?=
 =?utf-8?B?NE56VVpBa3JvanYxWlNMc0NkSHppcSsvNHlEYUZYYjZwS05sc2lWdHhNYTVh?=
 =?utf-8?B?VVVOaTRYRTdBREtLckZUelA3RUZ0dXVwV2hwM2pJcmxhRnp4dzZxT3IyTnVK?=
 =?utf-8?B?V1F1eTNMejN0S3FIS3QrcGtkb2tNUnlGK0t4MGJjOGo1UUtlNlNtWm9samNp?=
 =?utf-8?B?UWYrbXEvcjRyUjE0VkEzd29ZS0VBNlNKVEljbzFkM1NHNlpIZnAwV1JzS3Vq?=
 =?utf-8?B?LzFuLzFrQjBXdTQ5SDhYdXVlRHdxTU1RdVg2ajIwVC94bFBFV3ZVZEZyc2NS?=
 =?utf-8?B?dUt3TFlQb0J6SVIwT2Z6WFhVTG1yV25udHN0VlAwSHlQNmRKRFZGejdoTUIv?=
 =?utf-8?B?VE9tMm5CZ1dWSnd0UXJPTmpEMmdOSlhmNUQ5cHFjWGJnVUxkQVVrVHplcG1m?=
 =?utf-8?B?OEhGbnFmT2U2UTBmK3FJRU95VEIyR3J1Z2V5Rk1wTk94Zkl5ekdtaXBkMi9G?=
 =?utf-8?B?NHNXZU5wM08wM252NEI0ZzNaSGRpcEpzSkZaMGxXQ21yVmRWd1l5YWdZb2hT?=
 =?utf-8?B?Y2hWODhucGhNUGRwK0ExUGZnN2htNXE3LytwNmJDY1lObmRhRUVHWTZBWTZv?=
 =?utf-8?B?d243MWp4Q3lGMzB0VkJNbFVjbnJFU2FVTm1HUk42MjJnU1RsdzZ6ZlZQdDJL?=
 =?utf-8?B?ZGRsbmdMN2hrSHNSWXgwTjhQR1l2YUdVRldpTVloQnY2Qk1mMUFuSExVTkJU?=
 =?utf-8?B?emxORDNVTHdiK1B6bGFnaWQ3eWFtL2YwMWZxUCtTTWpYOXhWOFpZVi9wQ1g5?=
 =?utf-8?B?eHpDL3lPY2ZzRmoza0xQVU5LbVJvN2NDYmF4anQ1K3N6bnZ2VlB2elQwWVdG?=
 =?utf-8?B?K3YzTUxkdjUvMDJLcUZueHpoK1NLdGdYR0dVNE1lZ2xGb2paYnVPOUMvRmRn?=
 =?utf-8?B?NXFvV3MvcnlsODVOZnhVNjE0d25kVDFhMnUrWkRKRjhRWVV5WmtLUE5JOTJU?=
 =?utf-8?B?emx6ZkkwWVdlc0FXMmJQZUtPcjcxbW1CZ1ExUm95NmpxUzZDOHZ4blBETVZi?=
 =?utf-8?B?M1BXeW1EYkE5dFI0amZVeUJRZTQ2UmZxeXdBViszNVZ5a0laZmFqakhRb3pR?=
 =?utf-8?B?VFBDR3h5alc0VzcvQ2Y3Zi9OSW9zRlIrYUowZlppNHlhR3lCV0FhWkoxclNu?=
 =?utf-8?B?d09CSEF4eWFKNkJqZzVvQ0UydlV3UzB0RmJValowTWJZRUE1cUdOQ3g0bGha?=
 =?utf-8?B?UXduYmoreHlscjFrQy9nMGVrZndDUDZQTzU5ZmRpbTgrbkVyNnRoNk1hcVF5?=
 =?utf-8?B?RTYyL20yT0VsdzFCZUpORlNFM1gxbFpJL245RUgrYlFTTHF2TDBoRUhjYlBh?=
 =?utf-8?B?cHBzSXRrWkMxUW9zdjFCYUNkNWM5a2tTcUtvUFB3Mm1VdHRGK09WUHdyMHVw?=
 =?utf-8?B?cVZVNVh5RHVnMHJTSDlsUEpqL0didGNobERvOWNrbllWL01EdUdZM3Z3cldn?=
 =?utf-8?B?NVVrTXRFZXoxTmpzYnNSTDdFRlFkbHpmdnRFcEQyZCs0YTRhaUlzUHk0MWp2?=
 =?utf-8?B?bCtzcFRaRkdKUWJpR2RKYnVhMVdOVHc0M2hQYWlaOHJyK0FaVi9XL28vby9F?=
 =?utf-8?B?RXBDZ1lxYkxuSkJwejlrb2xyS25td1VSR2t6bW9LV09DVjlTeGE2dmRMSTV5?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf84b149-707a-4de0-4bef-08dddf2ee367
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 14:44:23.7499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZWK3tjISukK2fQOKQB+wPTzCMastNoFVzs2rraWvOoH5ngGn2DHdQ07nNEqEmCJkd4EnRDnJT7R26VNKKVdPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4090
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Aug 2025 14:44:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19765

--------------sT6MdyrJ3XzJAmKxznSnLNSV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19.08.25 15:09, Chris Paterson wrote:
>
> Hello Shivanand,
>
>  
>
> I’ve enabled these tags and the required user_commands for
> qemu-patersonc-02.
>
>  
>
> @Quirin Gylstorff <mailto:quirin.gylstorff@siemens.com>,
> @nobuhiro.iwamatsu.x90@mail.toshiba
> <mailto:nobuhiro.iwamatsu.x90@mail.toshiba> please could you do the
> same for lab-cip-siemens-prag, lab-cip-siemens-muc and lab-iwamatsu?
>
>  
>
> To do this, please update the qemu machines your boards.yaml with the
> following:
>
>    
> raw_custom_option:                                                                                                
>
>     - "{% set user_commands = {'start_tpm': {'do':'\"/usr/bin/sh
> /usr/local/bin/swtpm_start.sh\"','undo':'\"/usr/bin/sh
> /usr/local/bin/swtpm_finish.sh\"' },'manual_kill':
> {'do':'\"/usr/bin/pkill -15 
>

Chris, I assume you checked that not only those scripts are available on
your machine but also their dependencies. Quirin just told be that this
is not yet the case for our targets, thus we cannot easily set the tags.
We are clarifying what to exactly needs to be done. I warned you already :)

Jan

> swtpm\"'}} %}"                         
>
>     tags:                                                                                                             
>
>
>     -
> sw-update-testing                                                                                               
>
>     - swtpm-jobs
>
>  
>
>  
>
> Thanks, Chris
>
>  
>
> *From:*Shivanand.Kunijadar@toshiba-tsip.com
> <Shivanand.Kunijadar@toshiba-tsip.com>
> *Sent:* 14 August 2025 14:59
> *To:* Chris Paterson <Chris.Paterson2@renesas.com>
> *Cc:* cip-dev@lists.cip-project.org; kazuhiro3.hayashi@toshiba.co.jp;
> jan.kiszka@siemens.com
> *Subject:* Effective QEMU devices usage for testing in LAVA
>
>  
>
> Hello Chris,
>
>  
>
> Hope this message finds you well.
>
>  
>
> As you may know, the CIP security images uses swtpm package for
> booting the devices on QEMU.
>
> we have added a separate tags to devices like “*sw-update-testing,
> swtpm-jobs*”.
>
> This makes the LAVA job specified with these tags will run only on the
> devices which are assigned with these tags.
>
>  
>
> I had a look on the list of QEMU devices on the current LAVA lab, I
> observed there are many QEMU devices which are not assigned with these
> tags.
>
> Example:
>
> https://lava.ciplatform.org/scheduler/device/qemu-04
>
> https://lava.ciplatform.org/scheduler/device/qemu-board
>
> https://lava.ciplatform.org/scheduler/device/qemu-cip-siemens-muc
>
> https://lava.ciplatform.org/scheduler/device/qemu-iwamatsu-01
>
> https://lava.ciplatform.org/scheduler/device/qemu-patersonc-02
>
>  
>
> It restricts most of the CI jobs to use only the devices which are
> associated with these tags.
>
> So if we update the same tags for other QEMU devices which provides
> more number of devices to CI which will eventually *speeds up* CI
> pipeline execution.
>
>  
>
> At the moment, the pipeline is taking *183 minutes 54 seconds* to
> complete it [1]. So if there are no issues then we can consider to add
> the tags for above devices as well.
>
> This requires the update to each device dictionary[2] as well and also
> we might need to copy the scripts (swtpm_start.sh and swtpm_finish.sh)
> to each device.
>
> I’m not quite sure about how to do update device dictionaries/tags.
>
>  
>
> So, please have a look at this once and let us know if any help
> required on this.   
>
>  
>
> [1]
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/1978031660/
>
>
> [2] https://lava.ciplatform.org/scheduler/device/qemu-denx-01/devicedict
>
>  
>
> Thanks & Regards
>
> Shivanand K
>

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

--------------sT6MdyrJ3XzJAmKxznSnLNSV
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 19.08.25 15:09, Chris Paterson
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:TYYPR01MB151321574499D48D7E7119A7AB730A@TYYPR01MB15132.jpnprd01.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}@font-face
	{font-family:"\@MS PGothic";}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0cm;
	font-size:10.0pt;
	font-family:"Courier New";
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#7030A0;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Courier New";
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span style="font-family:&quot;Calibri&quot;,sans-serif;color:#7030A0">Hello
            Shivanand,<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-family:&quot;Calibri&quot;,sans-serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span style="font-family:&quot;Calibri&quot;,sans-serif;color:#7030A0">I’ve
            enabled these tags and the required user_commands for
            qemu-patersonc-02.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-family:&quot;Calibri&quot;,sans-serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span style="font-family:&quot;Calibri&quot;,sans-serif;color:#7030A0"><a id="OWAAM984D0041DC284583BCC533728E0042ED" href="mailto:quirin.gylstorff@siemens.com" moz-do-not-send="true"><span style="font-family:&quot;Calibri&quot;,sans-serif;text-decoration:none">@Quirin
                Gylstorff</span></a>,
            <a id="OWAAM8D6B8DD62AF84249A630F97E1DB8A220" href="mailto:nobuhiro.iwamatsu.x90@mail.toshiba" moz-do-not-send="true">
              <span style="font-family:&quot;Calibri&quot;,sans-serif;text-decoration:none">@nobuhiro.iwamatsu.x90@mail.toshiba</span></a>
            please could you do the same for lab-cip-siemens-prag,
            lab-cip-siemens-muc and lab-iwamatsu?<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-family:&quot;Calibri&quot;,sans-serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span style="font-family:&quot;Calibri&quot;,sans-serif;color:#7030A0">To do
            this, please update the qemu machines your boards.yaml with
            the following:<o:p></o:p></span></p>
        <p class="MsoPlainText">&nbsp;&nbsp;&nbsp;
raw_custom_option:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></p>
        <p class="MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;- &quot;{% set user_commands =
          {'start_tpm': {'do':'\&quot;/usr/bin/sh
          /usr/local/bin/swtpm_start.sh\&quot;','undo':'\&quot;/usr/bin/sh
          /usr/local/bin/swtpm_finish.sh\&quot;' },'manual_kill':
          {'do':'\&quot;/usr/bin/pkill -15&nbsp;</p>
      </div>
    </blockquote>
    <br>
    Chris, I assume you checked that not only those scripts are
    available on your machine but also their dependencies. Quirin just
    told be that this is not yet the case for our targets, thus we
    cannot easily set the tags. We are clarifying what to exactly needs
    to be done. I warned you already :)<br>
    <br>
    Jan<br>
    <br>
    <blockquote type="cite" cite="mid:TYYPR01MB151321574499D48D7E7119A7AB730A@TYYPR01MB15132.jpnprd01.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoPlainText">swtpm\&quot;'}} %}&quot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <o:p></o:p></p>
        <p class="MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;tags:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <o:p></o:p></p>
        <p class="MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;-
sw-update-testing&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></p>
        <p class="MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;- swtpm-jobs<o:p></o:p></p>
        <p class="MsoNormal"><span style="font-family:&quot;Calibri&quot;,sans-serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span style="font-family:&quot;Calibri&quot;,sans-serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
        <div>
          <p class="MsoNormal"><span style="color:#7030A0;mso-ligatures:none;mso-fareast-language:EN-GB">Thanks,
              Chris<o:p></o:p></span></p>
        </div>
        <p class="MsoNormal"><span style="font-family:&quot;Calibri&quot;,sans-serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
        <div style="border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm 4.0pt">
          <div>
            <div style="border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm 0cm 0cm">
              <p class="MsoNormal"><b><span lang="EN-US" style="font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">From:</span></b><span lang="EN-US" style="font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">
                  <a class="moz-txt-link-abbreviated" href="mailto:Shivanand.Kunijadar@toshiba-tsip.com">Shivanand.Kunijadar@toshiba-tsip.com</a>
                  <a class="moz-txt-link-rfc2396E" href="mailto:Shivanand.Kunijadar@toshiba-tsip.com">&lt;Shivanand.Kunijadar@toshiba-tsip.com&gt;</a> <br>
                  <b>Sent:</b> 14 August 2025 14:59<br>
                  <b>To:</b> Chris Paterson
                  <a class="moz-txt-link-rfc2396E" href="mailto:Chris.Paterson2@renesas.com">&lt;Chris.Paterson2@renesas.com&gt;</a><br>
                  <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.org</a>;
                  <a class="moz-txt-link-abbreviated" href="mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@toshiba.co.jp</a>;
                  <a class="moz-txt-link-abbreviated" href="mailto:jan.kiszka@siemens.com">jan.kiszka@siemens.com</a><br>
                  <b>Subject:</b> Effective QEMU devices usage for
                  testing in LAVA<o:p></o:p></span></p>
            </div>
          </div>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal"><span lang="EN-IN">Hello Chris, <o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN">Hope this message
              finds you well. <o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN">As you may know, the
              CIP security images uses swtpm package for booting the
              devices on QEMU.
              <o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN">we have added a
              separate tags to devices like “<b>sw-update-testing,
                swtpm-jobs</b>”.
              <o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN">This makes the LAVA
              job specified with these tags will run only on the devices
              which are assigned with these tags.
              <o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN">I had a look on the
              list of QEMU devices on the current LAVA lab, I observed
              there are many QEMU devices which are not assigned with
              these tags.<o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN">Example: <o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN"><a href="https://lava.ciplatform.org/scheduler/device/qemu-04" moz-do-not-send="true" class="moz-txt-link-freetext">https://lava.ciplatform.org/scheduler/device/qemu-04</a><o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN"><a href="https://lava.ciplatform.org/scheduler/device/qemu-board" moz-do-not-send="true" class="moz-txt-link-freetext">https://lava.ciplatform.org/scheduler/device/qemu-board</a><o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN"><a href="https://lava.ciplatform.org/scheduler/device/qemu-cip-siemens-muc" moz-do-not-send="true" class="moz-txt-link-freetext">https://lava.ciplatform.org/scheduler/device/qemu-cip-siemens-muc</a><o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN"><a href="https://lava.ciplatform.org/scheduler/device/qemu-iwamatsu-01" moz-do-not-send="true" class="moz-txt-link-freetext">https://lava.ciplatform.org/scheduler/device/qemu-iwamatsu-01</a><o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN"><a href="https://lava.ciplatform.org/scheduler/device/qemu-patersonc-02" moz-do-not-send="true" class="moz-txt-link-freetext">https://lava.ciplatform.org/scheduler/device/qemu-patersonc-02</a><o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN">It restricts most of
              the CI jobs to use only the devices which are associated
              with these tags.
              <o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN">So if we update the
              same tags for other QEMU devices which provides more
              number of devices to CI which will eventually
              <b>speeds up</b> CI pipeline execution.<o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN">&nbsp;<o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN">At the moment, the
              pipeline is taking <b>
                183 minutes 54 seconds</b> to complete it [1]. So if
              there are no issues then we can consider to add the tags
              for above devices as well.
              <o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN">This requires the
              update to each device dictionary[2] as well and also we
              might need to copy the scripts (swtpm_start.sh and
              swtpm_finish.sh) to each device.
              <o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN">I’m not quite sure
              about how to do update device dictionaries/tags.
              <o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN">So, please have a look
              at this once and let us know if any help required on this.
              &nbsp;&nbsp;<o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN">[1] <a href="https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/1978031660/" moz-do-not-send="true" class="moz-txt-link-freetext">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/1978031660/</a>
              <o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN">[2] <a href="https://lava.ciplatform.org/scheduler/device/qemu-denx-01/devicedict" moz-do-not-send="true" class="moz-txt-link-freetext">
https://lava.ciplatform.org/scheduler/device/qemu-denx-01/devicedict</a>
              <o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN">Thanks &amp; Regards<o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-IN">Shivanand K<o:p></o:p></span></p>
        </div>
      </div>
    </blockquote>
    <br>
    <pre class="moz-signature" cols="72">-- 
Siemens AG, Foundational Technologies
Linux Expert Center
</pre>
  </body>
</html>

--------------sT6MdyrJ3XzJAmKxznSnLNSV--


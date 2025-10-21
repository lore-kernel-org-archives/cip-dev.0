Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD237CCD1AA
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 13:14:24 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.21])
 by mx.groups.io with SMTP id smtpd.web11.11552.1761052462599093282
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Oct 2025 06:14:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=q+d3npGW;
 spf=pass (domain: siemens.com, ip: 52.101.69.21, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lr6JHImRvJZdBt9A2Efh6PqRMLihMZbk01rVvNr+ytrIARazvljrr0VHyht6Nxap08Ob12UlIFJTDlNgq4Rm7UlZ4Uwyyx8KJKdGnz7t3VtON0nctrtMP/vtfhIKer8lFs0UWEVrNFbdt+z1107QU6cwmfMeET9Ab4jpbsIgnjOiCFm+KBIdwUsHeeApLlr32jr+jUmCYl6MqCQ6ssIjJYV0YEmj3svYr3iF0veb/B4nyCnsjAIZAAA8XLudcQLKnMtuNcfN/4zSsT/CQE0a8fJWnk+VqsZD2JDzL8Rnp3L0++ea07R/Le6w83BuqFZ+VoCInTZeBhN4R58af1loRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dU4f0m68xHJA7Yl6DfmJPH8ClTkF90rr9pSLN9fFvWQ=;
 b=ofd1EURUdc/MxcPFJUv/X9w6OQLtdrmZzljK+G2BNEmoy2eJVwAFVJH5kFnH7eBnNc/AYGFbCxVd7Ge3YTDmiQmVtcKj4GbpKwX62+d1zTfV1/b5tVbs/XgaMVAafn2tGqxnKVuKJeX+FiB8X30Deqk7M7H6LKYz7II6q24E5sO7arW5kQspEjGBlbd5kZvkKEULF1TabY/PF14z3FbN0NZ1IMazlV+KFkJxG6OVfUwFvf8p04yjbnNEM/TDXIOV9zFEjbfp7XLwlKSVeBs2gEgtzSJxB/vR7NqcUog3Ulq6Wp6s/gVXSkkR+6IwqHYr0Fz68lSZAgiusVhPcmqtfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dU4f0m68xHJA7Yl6DfmJPH8ClTkF90rr9pSLN9fFvWQ=;
 b=q+d3npGWvV4GYfoYE7MHfWGIYQF8gpFpCCHjTS1pY/7mYPTYkaIqoB9BfU4ooc7T3DuE40mbwkj8NBJgJsD3UaRP79MeT16UWfmbFGFk9pFVSZ+Z5oVvs9OdnapMie55N4ZTkUFFwIzG0vHlO9JgbUYOthWGAgxklDIy2w8jVEBx/XkATkg0YrWB/Th/DToin1Izju2rRelj3vbayqfcIobaQOkwmgMAMsIqisMMc8r5svdkzvJfHKhnLoFuie3zr8YLjXAw3raL7cjFptbRXFtiRN8jVBiYnIpdVglFPKECy7DDACVUdbqpf64hJ0DwBxQ5noRLvC7tWQe2rj3DHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5628.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 13:14:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 13:14:18 +0000
Message-ID: <a525b452-76cb-40e3-a9aa-8f31c181ad39@siemens.com>
Date: Tue, 21 Oct 2025 15:14:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 0/4] Add support for TI AM62Px
 Platform
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org,
 vigneshr@ti.com
References: <20250722101551.1727649-1-s-adivi@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250722101551.1727649-1-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c1741d-0358-4f2a-aace-08de10a3bdde
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YmNqSldKTW5hNGRBeUg2K09JUDJBRm5nV1EyUVp5OUxXeUlJYzZSNmg5MU5E?=
 =?utf-8?B?UFdhaS9aMGpXRVRRaWtRMXlSbUVuL0tveTAxWWgrNk5xdlVaS2I2aE5Ibytn?=
 =?utf-8?B?ZHV4aytjNmtUUTh2T0NTdzk2ckhRU3RSNFNWQzRYaURQak5sSmtOdFQrSi9i?=
 =?utf-8?B?UUhmdjU0Mm9VWVpZQWRlMWhuTjdwWUYyVGt0RmJIM0xyem0xMFcrNUc5SWEx?=
 =?utf-8?B?WW5hNnRMdmRDekNVZDAxeFI1bENGemtrajFHZUVGY1RPbk9pcTAwckNFalhu?=
 =?utf-8?B?RFFRckhyTjR4dDFqMnl6Y0hhcTUxUjdHNUtUZ2lTdGVrZGE0MnZmT3BJSCt0?=
 =?utf-8?B?RktGVkxaOTBlK2dVVkJ0ZU9ZT3RDYWhrOGxCYU5FSmlENmVSd1p4alJncXJN?=
 =?utf-8?B?QTBXYURHUGJCSVR4T2l4a29JQm1sYUpUbUdXVUZSeHQvM3diZGVPbk5RQmk5?=
 =?utf-8?B?SUNEaDZKV2haUFJ3UWl3SVNvaHpiYThRd3gzZlE2UktRSmFHa3YvS2pOYy82?=
 =?utf-8?B?Z25uU0xvU1ByYlFob3ZuNUxOOFM0M2VVU3BUNkpTVTBoK0dqdjVpaGVxY0tF?=
 =?utf-8?B?TDRKRjcwYytqZkwwVjMraUw0STJaS05BQnhlS3lwT1NIZmtjMFQ3N29tdXFF?=
 =?utf-8?B?em5UMUtURTcvdjBUV0x5MFJ2dnZtZG9KUnE2T1RSaWxxQXR6cjBQb1g4cXBT?=
 =?utf-8?B?QXR5Q3ViaUVLVEFMSEZ4TnY4M1IwcTJBOHZKWGVUSnhQekZUWUpxdVhPNy82?=
 =?utf-8?B?cEc5N1FzL3dIZitKNUtkSXpjTGdabnNENGsvaHpzT1h4SnVvek0yTjJtQWs2?=
 =?utf-8?B?TFNteHNuV2N1T29kditOZjdXUkowTlBLbzNqNm51TzdZV09MUUhUdEJTdVp4?=
 =?utf-8?B?bWhGMGIwSXF0MzB1c0RXZGUraFRwakt3c0ViQWpYUVJpZnJKdlFnSEdkZzlp?=
 =?utf-8?B?YVIzbDdsZURQdVhMMldkRVMxMjFFbHpKcElseW95cVBrS29YTGhScXBVYURE?=
 =?utf-8?B?T1BWNFMzL0Z0SW1sUzVtdHQyZ0Rlbm5jZ1ZvM0E2WVhTZDd6b2xvOElKdkYr?=
 =?utf-8?B?WTRtL2VsOUdhVm1sWGQ3ZTNKSkxCdjZZczJKZlI4TWUxQlFGenlVU1NvMDh5?=
 =?utf-8?B?MG1MR2RKU01BcEtQMi9wSkNKQjVQdW1MV1VXeWlTSUNJTVNyVjRCZDZISyt2?=
 =?utf-8?B?Nk04Q1NmelAxdEtMSDdXK25SUW9WVUh6K0ltUU9YbFVrN0puWnNrN3ppL1ZJ?=
 =?utf-8?B?OHc5K1VLcWNnTE9VZEhBclJvWnJvQ1h0S2RBM0dxSDlreHRRcTVUMGlub2oz?=
 =?utf-8?B?cng5b1F5dU1ZLzlqMjZkMVh3dXJLdS9DTUZKMXJHUC9IWHRCWUhPNEhLSTRR?=
 =?utf-8?B?bkpuQ01udUlGVytnektvZ2tXVzJWdFh1RVBzakU4eFI2OEZHSFlFL3pHV2Zz?=
 =?utf-8?B?Uit0RStBN1ZtQzRLeWdpUEF3Z1ZrVVpFUm40UkxDUTlXbnNkYUhFU1B5T2pI?=
 =?utf-8?B?K2ZicHVoVWhoSEJvNVR0dWxGRzBoTC9pNzFIMk15UTBHd0V4bEp0bmdPbEor?=
 =?utf-8?B?dHBKQW9PTHpsMDk4VmtOMGFWbDFva2k2cUxtVnhIUFRHOTRXUUIvS1Z2dGlq?=
 =?utf-8?B?YnVDd1ZnV3dpb0lIWmZhUVhMeEUzak1vb1ZCL3RNYkRqYnZYaUNMSG9CWmFm?=
 =?utf-8?B?NXBpMi82RkdmMHZYNDZIV0h2R3FrY3Y5ckNBVzhHZTRvRVVickx3NGxzNzFQ?=
 =?utf-8?B?MEI1Q1hxelpETW1GNlRKV0FodnI2NkFOQm1waENrWE9OR0RGTzIzOVI0WnZl?=
 =?utf-8?B?bWwrMjU2L0tTUXBkNkhQTXZOZzhnVTVOZURCV1hlN0MzdkRJbzFoYUVYR0Nq?=
 =?utf-8?B?QXlvSld5MUhqS3NUc0VYUlZhMGZRRWVWcjVJdHBLNFVaNFE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dlBPeWw2YWk2Qm9rUzFwZGNRdER4Y0syL3FrZXVWSDJwa21TSHphZEVKYjFN?=
 =?utf-8?B?SlRVMzhvVERFdTVTNUlhQWI2Qks3amh5aFl1dGx1UHBjeUVhcjZwVUJOaTRI?=
 =?utf-8?B?U0hiVlhSTVlKZEZxUFFwa01Tb1BRNHlaUDAyUGgrM0VGSE9Jejd1K3JPOW4w?=
 =?utf-8?B?cyt6RDcxSHVuM2xQb05BaDNhbEplMzZzbS9OMCtUT3RqY0RIdXU2SWVLZlZH?=
 =?utf-8?B?QVRod08waUd0RWp0ZDB5QWljWG40L0VYN3FJRDlmSnNkSFM4V1hHRjRaOGRR?=
 =?utf-8?B?WU1mandnVmZaa05xVXRPSWhzVUxHdk96a0xZa2NRckhlSTl2Y1d5WVJJdzhk?=
 =?utf-8?B?dkdvR2RneFZsZTMyZUtNb1dJTit6N1I1bThWbXIydmVOYUhKc1FmaXc5T0NN?=
 =?utf-8?B?b3NId0VaMkFGZS9rbDJZcHVHRlB3cWpuN1ZEQ3RBWDlyNmVZZDNFY2hpV2lF?=
 =?utf-8?B?RjVQSzZMdVZybi9ZVWhodHRTU3VadWdDMktacE9saUVSYjIrMTN2c291SmRU?=
 =?utf-8?B?ajlRR29ubG1KZmZZNzdwWjR1WFFOQzJ0aVFlN1d3N2toSXpXQmhzTllLQXZY?=
 =?utf-8?B?dDBBNzZlMElvZmVnN05Zb0tCZmZaRkxoeTJhS1hZc3QwaStlQWVzVk43VFN6?=
 =?utf-8?B?NFBQeTE3K1FzVXFtdDRUNXNRM3U4bThNdkdQdjl5TlpVTDhWaTFlUVpJemlh?=
 =?utf-8?B?QlVPWDd6OFlETGMxVmlLcTFoOEswMU5oSVVaSmE5Nk94K05rTFFsMUJQWjJE?=
 =?utf-8?B?L2dqRUJBcjBjdmc3R2xicFdjTzVYQVY5bkVyL3F6VnpHcTRjM1VETkY5dGVL?=
 =?utf-8?B?T2djZ01zUlQvNEZMbHVrWUVzNU1lR0RmWENnbWsxb0JqRk5pVWFQaW1RWGc5?=
 =?utf-8?B?ck5NdjRMU0oySEhhYjhmZHJIdUNxL1Z1QlpIY2FtZGFXdFBOc3c2dmpQUE1i?=
 =?utf-8?B?SExVblVEQXpjYXFEelVNUFo4Nm9SSGZqK1d5WVJWQzJlR1h6Ri9sZ1o2SUt2?=
 =?utf-8?B?bHo5MDRza0lBOHpTdUh2UjM5SnB3cXNEVXFNemVtcG1ZQWErOXNFQkZrL215?=
 =?utf-8?B?dWhrVjhGRE4yZjFMZEVUQnJrUmhCSVRLbGtGQkFTdXRUME9paElmOFg1QjBn?=
 =?utf-8?B?cWJZaWp5b3Q2ZTFYY0tTZ1BBOXkvWWJxRXhSWnVBTlcydzVVOUJnQ21FVExK?=
 =?utf-8?B?WW5sbFAwWlNURmp4U1NoVHdmRVBqMlRLNnpMRlJOUldtT0trU2REdFJsc0h4?=
 =?utf-8?B?U1FYKyt2elY4YktJaHJ0TGQ4UEx3YzUybXc2bFAxTmlqUStvb3U1SW9nQ0Zu?=
 =?utf-8?B?UmN3eUpzdmp0Rk4xMGltV2NoM3llRGtJekJaT3drZ3lPV3RReUV6WGpoc29z?=
 =?utf-8?B?RkhxNytwU0hUQmJ6ZDYwQVZEMkoxZWVERWRrSzZZSkZGVFM3aWFQQm9hbStE?=
 =?utf-8?B?NXJJaGFtdzVyYkVmZmdWZ2gxWGF6cnRrbzZSbFY3ci9aM3Z6UGlKWG9KK0l5?=
 =?utf-8?B?SEEvUWtwM1JzVjNUeXJHMVp6OEtTci9IZDk4WU85S0dpQis2dVYrNXcxSGg0?=
 =?utf-8?B?Y3JqWlNXdDEzNTRDZG5WU0YzMlROaVF1N1NKV2toMmkrSDZlRlYxUCtaMlhn?=
 =?utf-8?B?WlZHMHJKeEcyZmZBazcvKzhYQk9TSEJTR25vRDhoLy9yY3pLcWMvc3hCSnp4?=
 =?utf-8?B?aC9NOE9tckVUR3hMeWZyblhOckpyU3FRUHhsckF0amxBSlZxWXdvUWM0NjM2?=
 =?utf-8?B?dEZxbys1ckJOV1ZuQmprWU5BWngwdE9IaFFNMWNBdnVtQW9KMGdNRzFCNmZk?=
 =?utf-8?B?ajdFUkE2QlgrWXZpd0hUMFF5Q0ZySGJlTFp3bTJqME8yVlJUbWQwYmtyQ2pk?=
 =?utf-8?B?YldxS0l4dGR3SlVSbmFyWU1FNjBod21WYlIyVnN1ellJZXYxUU4vSW5TN2dH?=
 =?utf-8?B?ZGZrV2MvUzE0cXVhYnZBSW84MnNxc2lOaEJMMDdSM3poVFRlS1ZENmZSdGJN?=
 =?utf-8?B?eDhLWFlxSEdocEhzTEZPOGkvUEZqd2M2T0xjdVdFbmI1WDMzMytRd1BjRHh3?=
 =?utf-8?B?K0g2cmIzWUZFVGRVckdORkw3VGMrTEJ6eGdUNzlnOFlOWDJnamxaNm80N2Ri?=
 =?utf-8?B?dHc1aHhOd2hMaDk4ai9vZzIxKy9XS0swWG02Z3pQdjdFUHpSVFRRU2p5V2Nt?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c1741d-0358-4f2a-aace-08de10a3bdde
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 13:14:18.7221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h66kVtMy6pEmZAMMeEBSUisf8PVVy9CbEHz6EJpoPc827CtPb6Hd8Y9GWiOLlxtewCEibMbXLHgcWIELUCf3Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5628
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Oct 2025 13:14:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20211

Hi Sai,

On 22.07.25 12:15, Sai Sree Kartheek Adivi wrote:
> This patch series enables support for TI AM62Px SK Platform.
> 
> This series depends on the following.
> 1. cip-kernel-config merge-reqest:
> https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_requests/134
> 2. kernel patch to add microsoft,ftpm node:
> https://lists.cip-project.org/g/cip-dev/message/19570
> 
> Sai Sree Kartheek Adivi (4):
>   Add support for TI AM62Px SK platform
>   ti-am62px-sk: Enable SWUpdate support
>   ti-am62px-sk: Add support for secureboot
>   ti-am62px-sk: enable data encryption
> 

What is the state of this series? Could you rebase over currrent head,
or do you need anything from my wip branch?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


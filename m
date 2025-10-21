Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F77CCD1AA
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 13:06:44 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.45])
 by mx.groups.io with SMTP id smtpd.web11.11368.1761051994344140531
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Oct 2025 06:06:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TFI7b/2F;
 spf=pass (domain: siemens.com, ip: 52.101.84.45, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4J3k5Xgu7G9N8DiyrqjxiLYX9vGkgh/8GzsJ4lNfjidZcnz9kRcWt0MEIh4Gc2i8y2fIA0DWZe9QS9mHBoVZN9QhIg2a6amhBnpzqEMBmHNqm6axGKcoKUJEPttk/4EOIdMcdlQp6zNTy+cBszULu3vjw1nYesTRg3mldvcyNN41rFM+0mccDcmFwGeu8fZ2a1Zg5gZ9VoIizwEy9I1OHoiorfuj/dMy9py4yz5ePM9VlCpMP3oRNTwDg+9xLcYpzT0HAOezKW9izz7kL1vVCjnR0E7EmqEMDSQYAZi8dCU1BPO5zbrussIKZN+V91mgTEoouv149wzZuB7D6Yxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MP8URJdo4Z+reW/DjaVpBy3rQHpq5fGh6H0EkTKJ/BE=;
 b=Uyy2ZEkIR/ejKCkWlHyH84ybm52/2OPdMWdOP/jcG0/tOuZsErI6x8CVClWI4/OdmNeSrao+dnQQgkkf3dk+vyXaSe6tJd4uKcTG79FqtNajOIDN4FT5lLm0OrjgeXFRdK1Cns3/QmpPultsSQKZ4ouBuCE0UGiBqIaZ4+tcn0F4zxTixnL99cEG9oMeQ1CkmcHGsQmuwf7XCg85bonYlHstpVGDL9W0tvuPpEZRiuR5YePyqNtJclkuXtDozHUIfD1xhurQHlGyjDJSRTP0r1SPe2bTce9CyqH8dM4zKPyLV8wJpndMljhjJ6lHNcgLYNLOCcc2MYzi0rUTpSEZPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MP8URJdo4Z+reW/DjaVpBy3rQHpq5fGh6H0EkTKJ/BE=;
 b=TFI7b/2FqrD3raNyV6xx2SDtLWPzllIXUzfGKWCbNHY+v/+ePPP1lxhsgRX9BpUCJVWsdFfGqGo+6PRawDiVXO0IYNKiVQ+O9ZVSPVtTnyZZv6Lwfs7ZDOOwiyNx3zQGAE9AUnHXvJ9+ec92HWOaV5wijn6rQYw25sKDOOVnT1HqhcuLYucZ+E9azzM2TYPBtwskhdoG2b8KrB8cE0sN1X26rsxu/qQ/4maxphs6urTdRlvLa5P+SZNSh9k5ghtFH9jzjapDZlzhVl/QwhOghuuFCETMI0126PBsYCjFL3428Egbhbh4jZigeCchSQn2hBcUu43k5PsxoIym2QTG5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1::16)
 by VI1PR10MB3743.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Tue, 21 Oct
 2025 13:06:30 +0000
Received: from GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8141:f914:455e:a790]) by GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8141:f914:455e:a790%3]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 13:06:30 +0000
Message-ID: <27543b5f-a05d-4d3f-9936-566de557a941@siemens.com>
Date: Tue, 21 Oct 2025 15:06:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC v1 3/5] wfx-customizations: Recipe
 to add wfx helper specific scripts into target
To: cip-dev@lists.cip-project.org
References: <20251021125233.1528087-1-Adithya.Balakumar@toshiba-tsip.com>
 <20251021125233.1528087-4-Adithya.Balakumar@toshiba-tsip.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 xsFNBGhxJPIBEADH6a6idt3FEJo4DFxeRRX2ZUHJjOSPTpBN4vK2FbvDJjBVLs1/xzNpOE/N
 CxDcH0nd4BApJeGzxjJpsHW9gm9w80oIG2HAZl4es79JdRt6H5GTdFaux1J8tLVTCS3bzeuu
 ydAUTesliWxSiEb4vqpmcduI42edmJF9E43jjLXDyJcXJa0qYXA0qvChJr7gbkGmWc7iR8A5
 ZX1CrJJbwUBtzXGGThDPycgPYB1eR9OcFWJ2E6dBcLQiNxyOvxfpTKf09eZi2hBrZESpjMKo
 U/t9LX9SbyRwzpIeXQe8LQgyhppENmGSjc+Lm0YIreIU4ODbt1takxHTIpin1Po7lFiDMQmW
 aZrfNFKNQoffVyHq1gpV5BGIbnm8yJixpEueL2oygnN/evyNPQV7NzSoQaJy2lJRGjo4YrQy
 dfpJyaajNeO1njSttdWC30q28ZUorPzBPfLwt7B/BXyiMiY6/SZunfKQDAY+g835YTjEhBgl
 KtXEamOfypEvYfvzQUpLrFgK55yrDSndtNm71APD4oVNeV1I0KqbuBQk4o3TkR6ZYb4RLp9O
 dKGEnKCBaBaWJgf/1v4BLJ/ge8k135R1JLiyK/FylJbnsABE9k7/lELFKrwW22qgspkQAf13
 h2+T65+637hkxhGRYnrtmxjOUk4EbYbAA+rtj0mpBxnziWojQQARAQABzS9RdWlyaW4gR3ls
 c3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPsLBkQQTAQoAOwIbAwULCQgH
 AgYVCgkICwIEFgIDAQIeAQIXgBYhBBvkezJSXuvL6yeVgtxQXbgz0zl1BQJocSb5AhkBAAoJ
 ENxQXbgz0zl1vv8QAMVze9Jevd0Qe9iYY64RX1rQfGv0xI094u9+4fOsIOXUjX70cbRgOZzk
 muPuEj96pBh77vGWb19dyWmzlRL0tTGg4ACcbHXgy93l6HaUTlVLUFpEKx1ufo2StSPPZ1i9
 4PBTfnyAhQqYH6dibaFpCHvhrNvLIidA/C3qBx2b5k7H9k/Hta/lhNPkJTSqLnUl2sU36ihb
 QFGvEOUnJjFVo7eUBDNjEDGXETfI2tfHuER7GxZZINFpzf1mnvgobaai0pt26XUrt0cdONGR
 slIv6hEQ4BcyuYEN5wZz68eMMQtaTXRoCGYPYpTEYu23BKYTPebIUAbM+CiEVHTkH2TSeDwM
 kc25z0ydFbA2D8I8J+atdBsmHlGCq1gMnSMZ/TtOrlL6OHFoVlaq95Z55a5cq72DF1BQBk1t
 jaPgiI3Frzn/ZLFfldakTbkd2vsZjBJEkcUtnc+Rm7x1Sn3X855zJmvYRzdLAPMsi/zVMsy6
 tvoIcJozan1CQE/vC1S5V8BXoE0PRointtfTxPDuX2//sSzlRgBVWIQJHuQ0asb+gzptVZT+
 naNdi+fexKfoSv6bxbsG2Bg7Pm3OZNASmaUodGNixZ3/y/VdzvvSaPPULYPuUCdZrTtX4wML
 ae1/UjUw7jUoEXOalGior+tSEUpvhfa9y8kzJswmtZW90lFYNuCtzsFNBGhxJPIBEACi38/X
 QWBviWYBLlk2czd15VQFpsfYFKzgO010e300DAL1D+CWatD7yiEK30m3vvHkOkyHaOz/DB18
 ksr1czcbQLYSpdC4JKlsUu75tf9EI32QBPRMms7mJ+qewti4xj1sjrBpuczzLC0CG+dkxTD2
 38AbgGW3m/o8zBsPGhVnJlRVGsYU/YiYxaE6MC/l5bzmb0ay58ySnSS32zALKBfXGpWmk1td
 KbcHNeEBuZu2W3ZYB5cTkDEE/3ycnWwqWh5u24SSLC/83rIeAjeyJ/wQ9+oSIHLlcl296sqM
 1wYKVCjwAXfA7vcEBsANUFL6NkdP+Y+HJPRT/EODKZsjqWjoi/5v5GKBLrScLxA9cpjTCYMj
 +1slg6T9FgUMQ+7GtbGI+/3WA/8ZE8emq4EweLzYT7I6hLB/dnoqRZFmRkLZ8q81r3Oc+xIc
 PJEnEpQIN/Ky0YelyPY4j+GH+NOlLvv9pH16I46O5PsTCkyhcfgfYUOJgP1BRQrnRmVn6586
 R86jfLLhtaagvg4Mb4NtR+ZAO8rF8xmrEv5q0YZBkRmMlRENwHWiCyvDzU7mTsyYvVweGgdL
 bak4VTz/Bm2kvnJyHAWOhWJk6BAgmQhM1c0eYG/vmyhS6O+omYIyDJFVp0ui71CazCFn7dDI
 +uzg6o6fHygmWDn43e4mu3WKEXCajwARAQABwsF8BBgBCgAmFiEEG+R7MlJe68vrJ5WC3FBd
 uDPTOXUFAmhxJPICGwwFCQPCZwAACgkQ3FBduDPTOXXrfw//Rc/CskZYHeM06zTK0NQKTt3+
 hgME6rUQh9y4iDF1KjEvmVDGyDma8AQ45WNP5EbWgMFWGtlTYwn3CbFuYlDLMtCYHkth1itN
 SoUdOttJkQ5ULq8DW+MFrP4xlG0zAx+CWeug6VhujVBro9xK57zgYs+LsCK3nlsYR91ZtZ8E
 73Bi58iGZL/DLRFws5ut9hGUE0HoxXAhUZ6de0QxXNmfApzK+rLUye+JYcEVWEfVCCofFy8X
 lk+r2OzCvMt43xu9OgV1Pg37ez4HVu+ZoPJ94NKteQr9QMR9PIOBXGlOuweKiR1IcYBjQHzL
 aptU47KTf+lJxZhy8H3l1ySuyQqxbFoPNUuAT9Fu2s7Mg7QzjLVkoIrkZ+YJ+CmgvZT4sPZe
 YAMMbi+ENwLUg7aYqCy1RHcit2jeoEMyJJ9PFcsbxcqIPaCG3xOurgMdwlGeGdaxSFvq1T4V
 Z50bOHQvqT4TbOxbxv8RLLtaNfIvudV3J+Xx3QyKY1sySFcCtCB/b4zoKqc73B5B0nXBw931
 qIxmFqiZiwfFB91OCCqRFtm2LcfwR1fLrUtSrhmENjdBhZljfJKjxAfFOWXngfT10Sin9h20
 4A7NrVMzatAJLl79L0PdJIVpGUDQHU9K7rIs2MoQKzmAvyUSJB4sAChft5wz7JbvFKqY2fW4
 Z2NBPBZUysw=
In-Reply-To: <20251021125233.1528087-4-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::9) To GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:1::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR10MB6005:EE_|VI1PR10MB3743:EE_
X-MS-Office365-Filtering-Correlation-Id: 830d36fc-0743-4af7-7dcb-08de10a2a6c8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|4022899009|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dFU5aWIxdGVLOWlpTVhJVVZOT2JIa2VQYlpqTk9yTkZEdEdmNDlncEZMV1JS?=
 =?utf-8?B?MWd0Ui9tTGRjUzJMU2RNaWk2aDVkazhvV0JhWVpDZXhkY2tMNkRxV2syVC9Y?=
 =?utf-8?B?V0JMYVRmUzJ5bkVnUW9WZms1ZWxFa09DZkpJbkJPM3RLSHRmcVF5YkUrdFpr?=
 =?utf-8?B?VDZzK0Y1eFBaUkY4RXpOc2RFTzVmTWptMWRFS2t6QUZpcW13RWtyTkd5bUsz?=
 =?utf-8?B?R05BSUpya2VXeGs3UHlHQmlIOGxJOGRBeHBCbERGS3JiK1JYVmJjRkVFWGZH?=
 =?utf-8?B?YTBKWllKeGlBZ3ROR3RVdk1SYXl6cVRzbTd0SFFScm9LVjZ3ZVNLSlBrTmlV?=
 =?utf-8?B?RVdHSGhxSFZiZy9mY000UlQrczhjRDRkQnNWaXBEUkQ4UGtuSWpsc3N5VkdL?=
 =?utf-8?B?Q1Z5QXNFcmp2R3VhV1ZuZmtlSTdpUGF4SzBHYWRXMmQyVi91R3cvOHdia1pR?=
 =?utf-8?B?TU92ZThlc0FubmM1QzVoWXRHNFF4U2QzbkhoWUVoN08vMERrdzM3T2J1Zlgv?=
 =?utf-8?B?cDFXRUFqTWI1dWFvajFsVHkxYTZRbDd1dnNHYWhBODRCbEdXR1hzVXQ2WS9i?=
 =?utf-8?B?WElZcC93RkJPdTg4MXcyZVRtMHVJbHJMUCtvOWo2dkJXcmJPNE5jVXI5V3Fh?=
 =?utf-8?B?YmIvUnpQNjVIeGhxdll5ZElmMnRWWm5UbjMrd3BxRUM4ckFjODVVY1dDT3NQ?=
 =?utf-8?B?SGptZU5kSkJnTmtzaWtjQzJ4ck9RaEoza3I2citpdVRZUHhsRTlxQ2g0a2ZQ?=
 =?utf-8?B?S084WG5ITXZwczVLZGIxZEdHQnJPdUxFV1kzckord053em0yVDViamNidTd3?=
 =?utf-8?B?NHNUMWdMZ2x6YjBGZWpwRmRUTXFDb3duSjE0UUR6Y1V6ZXNiVmhZUDMwSlcr?=
 =?utf-8?B?Z0pWN1FMc2E3dXBHVzBlOXk4RTJNMjZFREdiVGRNemp6WTkyWmVWVnZ2emxx?=
 =?utf-8?B?L2ZwR0krK3BNVWRuMFM0OVdyR2NLNE95TWwxMTJqUnFPZXpQTmNqNkxjaXFG?=
 =?utf-8?B?UW84cDRibXM5UVh5YStZTHZON2Q4Ty84V2J1L1ZISVo0aElBeHhTeVdwNVBM?=
 =?utf-8?B?RE9NNWxYM3c0MlU3OXI1ejE5Q3pZVmVFeFdUUmNjS0RDU0MvbVRvRlNNL3N3?=
 =?utf-8?B?ZjFuR05EckMyZ3pUWFcyc21rMVIzZDdKc1FCZUdNVVhNaE1KdzdPWTBGbVEr?=
 =?utf-8?B?Nk5uV0oyRnVOM2txb3RHZUsvblF1TVllVnh0anRpQzFINXRSZ1p5bGJTMk9G?=
 =?utf-8?B?Mkk1bDBUdmFndDZDeFkrcEJVUHg3Q0x5N2w0eTNya0Y3L21mTno3L05KVFow?=
 =?utf-8?B?R3RNZU1ST1hoTU1pbUxsWmFLV05Wdi8rOEFvZmMvRmEycjRmam0vdzVpdy9X?=
 =?utf-8?B?Ni9FK3gxOE1uUmdJYTE4dFA4OTJqNHBvZjJTOG5TWDFLRVk5OEVQdm4xdHcy?=
 =?utf-8?B?MXlCNEgrbVM3UmNQWTBhUFJnWDg3WmhnWkNPWHV1aVFoc01wUE1PKy9yRjRW?=
 =?utf-8?B?L05OTTg4d3M2Zm8zb2xaOVA2Rm5hMXF2SHlJclZtNmdOWjJEdGZWbFJ4SElT?=
 =?utf-8?B?cm9LeGRpVmUzaVppMU5BQk1PUllFc3c0TkJsa3kwaGluRy8wZXJMMURGSENu?=
 =?utf-8?B?eEx4UEVNcng4Y09aZXZQaWk5TERmMEIyT3VGS2VzRlRzTnRReHVWRlpxbUtH?=
 =?utf-8?B?dzhDVlpWK1d6a2lNa3hZZk5wQUp4K0tSbmxKbVlIWEs0Yzc1YWV1RDlSd0R1?=
 =?utf-8?B?eUJiSTY4L2NMdUFrR0JQL1VWL0lLRXFadFcweUtVSjlrbThFQ1pYdDJlS0RQ?=
 =?utf-8?B?Rms1L012WDE4dHNhNUpjUW1MOEJEUG5TMmtKcno3VUtYVGJaejlBb0NJQ0lm?=
 =?utf-8?B?REVUbDZZMEVvV2M3dUlaTFNVaitFcEh1d1JFZTVoZmt0RHc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(4022899009)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Nm9NNFVIb0dYWnVtTXRGR1MrN3NqOCtPeHlPQ2RwZlhRR0pWRmhXT3pYYk4v?=
 =?utf-8?B?RWlxRnV0SG1tWG1lSFFVTmxCb0IrRnVJZFNGenNha1UyeWtRS2RkZHRjcGp2?=
 =?utf-8?B?djkvSWh6V3VLVnJKNWJvaFoxZG40WlRGdHV2cmxTWWZCR2lNVFIzQ1UybXJu?=
 =?utf-8?B?V25VODdZS0dERWNocFNqQVJLVy8xR1ErZURuME9RakdqTFRESUQ3dmJ4NVBG?=
 =?utf-8?B?OXNzaThubUxkbWh6VDFkM3VzV2NCKzh2U0F2RnlQajY5bEI3bGdiUnBsTW1u?=
 =?utf-8?B?WFRJa2V6RUZzS3R5VjZINmVISWVtNlE1VWhZMU1jS1BGd3N3SlFjaGZtM1JU?=
 =?utf-8?B?VFRUWm9neW5vZ3V2S0R5dkpYZXJZSUg4bjFNQWY1aksvcElVT1NoVkgzZVBS?=
 =?utf-8?B?RHFUVWxsSzhOZit0VkY1aS9ZdFBLbWVLU0lWWTExKzhjc28vZ0JCaFN5OW56?=
 =?utf-8?B?TXppcGpCZTRUazNhTGNaMndoL096VkptNmlBSDh0bzR5R0VjYkpQZGZ5N2Vz?=
 =?utf-8?B?N2dSMGdDNjAyMDJzTUI1TlhGeURQb0R0YVJyTFcvRXhxU2kwVlU5dWZLNFFj?=
 =?utf-8?B?eXI2Y05YaEx0NUUzbk1UdWp1WjJyQy82d3E0VWNia2QybHd5SGdORTFRcHZX?=
 =?utf-8?B?WGV2OUpEM2FhcGlMUlFJRHE5U3RXZkQ0RjNoSWs2eXVQVXN6V05pU1NqT0pN?=
 =?utf-8?B?Y2VLdlhUZXU1MVdCRzZFQjR2bFh0Y0FqVjlXcSt5bzNDSElGSnROY0dEV1c4?=
 =?utf-8?B?bGZ5UStHTzZtQWVEZjR6cmVMb2tLK3NOY1NZaHZNRjFVR2pwcXZxd2NmZjdB?=
 =?utf-8?B?eVNGTk10RWZjWG9Mdm9QZHJ2eFE2K2hWMXRiU1Uvd3NTVlE0OVNhMlg0MnJm?=
 =?utf-8?B?bWx5ZU90aFBiT0RWZ0dvVTlFeHFYR3h3MTY4aGJCVjhYNjE0N3V1VmZFR2NU?=
 =?utf-8?B?Qis5WmN1Z0JaUVJQdjRjU2lBVWtaSFNqV3pxY3NvbGVhcGdMeldtdEpQRmRN?=
 =?utf-8?B?TncvSkpmaTZCOGFYejlEa0ZWNDhOemdpMDJZdFVUdEpMMUt6dytycTRRTDBn?=
 =?utf-8?B?UUpneVF3cU93T1JCRnovdDNSbWlCTDVUMUE2MnRrUFArQy9mWnYxa0diZHBX?=
 =?utf-8?B?dDkwM1ZTeGNxWmVORGZIaU9BUmpwalVQVWVseWZDTTJJSU42ZDUwUStXNDlE?=
 =?utf-8?B?YUlPRmVpOEZ3eVR4ZEF2NWltYm1ndFdvRTExc1lubitoM0YwenIrNkFwOTJC?=
 =?utf-8?B?enBwSWZMRDl5eVhPYmtYVFdJVzl2Kzc0ZWd0WVBTRzVxUEx5VG9ucUJuS3F2?=
 =?utf-8?B?MlZnVmUwWGxXa2tMTEZ6NVprNWI2RHM3SThMY1dFcVdxTTRyMUFuN2pxUlVn?=
 =?utf-8?B?V1Y0cmNZd1N6aElweFEvcUt4b1ZCUFZNc0liRGNDRVZGanJ0ZVhTaHFQeUZw?=
 =?utf-8?B?R1liVXdLOXY1MThTTEk0Ylp3MHhzVXB6MWtsZ2tkb010VEwvZDZmODJXK0k5?=
 =?utf-8?B?M1lGOW9xejIzUi9KODhSSkZiZ0crb0EzNXp2bkZTbDAvbUwvTU1LLysyQ3hI?=
 =?utf-8?B?MGdZY3lxTnN6WSs4aW1iQ3hRMWVESW9WWjl1QUxTb3hWdzc4VzJFSVgvaFBI?=
 =?utf-8?B?SjhTRWdHZlU3b2lvWm1OWUFVY2xVbGw3aFhSdEhFNm9JZGxPYVE1UnAxSVQ2?=
 =?utf-8?B?cjJBQVVHdlZhS1Y2L0ZDVWNhMUJqNVgyQStMMTFsaUc0TW1ibm83by93cHVN?=
 =?utf-8?B?K3RyYWpZR2JwWlUvbjVIWDdKSko3dnRaVzhnYVlKcS9wVFRzSzlON2pPUVEy?=
 =?utf-8?B?UUtZZGE5c3FNbk16dVo0eitLTHBobFRuMUJsTGJ5amFUdTFmVG8vdE1zRnh3?=
 =?utf-8?B?YlhKSy9lVlBHZDdLSEtMb1FGRUlNTWJmZGNST01JWlM0Mkh4SWtPU1hTSGN0?=
 =?utf-8?B?VkFYbVRBZEdQbzZKYXNUTXNQVTlUQjh5bThyaGJmTjVuYzlxc0pxTWFISXUr?=
 =?utf-8?B?V3cvUzI1M2F2NDJyV0MwdTAxT3JPL2ZseUJ3ZXhNMnljRVZhMjcvd2UzU1o1?=
 =?utf-8?B?YVF6ZXdVVFhOd2RsbzV0ZjRwbVBmSTM3SFZGZGNHb2VVeEdFOWhiMDRMd3Nw?=
 =?utf-8?B?cXpaSWhIWmVSaTRGRm1ldE5INXg2MTRndURUVFZFRHpDMkRzLzNKb1VqNUpR?=
 =?utf-8?Q?LJs9AHjcwQgNNfVYbMZJMHU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830d36fc-0743-4af7-7dcb-08de10a2a6c8
X-MS-Exchange-CrossTenant-AuthSource: GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 13:06:30.3593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sn+V7AgZosppFUpV/yBGwJpjMCqkKYX3GhiABiDeFoSF3952DBVvWEDyGfjK3c/ZsGY0JQI9Mc5MSE1FrTnSD2PwHyNuuGl9CrsZ5/1R9mA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3743
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Oct 2025 13:06:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20210



On 10/21/25 14:40, Adithya Balakumar wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> wfx requires a unique clientId for each client device for targeted jobs for
> each client. This includes a script that runs as ExecStartPre for SWUpdate
> that generates a clientId and sets the same in swupdate.cfg

Why generate a new id and not use /etc/machine-id?

Quirin>
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>   .../wfx-customizations/files/override.conf    |  6 ++++
>   .../files/wfx-generate-uuid.sh                | 22 +++++++++++++++
>   .../wfx-customizations_0.1.bb                 | 28 +++++++++++++++++++
>   3 files changed, 56 insertions(+)
>   create mode 100644 recipes-core/wfx-customizations/files/override.conf
>   create mode 100644 recipes-core/wfx-customizations/files/wfx-generate-uuid.sh
>   create mode 100644 recipes-core/wfx-customizations/wfx-customizations_0.1.bb
> 
> diff --git a/recipes-core/wfx-customizations/files/override.conf b/recipes-core/wfx-customizations/files/override.conf
> new file mode 100644
> index 0000000..4ad8551
> --- /dev/null
> +++ b/recipes-core/wfx-customizations/files/override.conf
> @@ -0,0 +1,6 @@
> +[Unit]
> +ConditionPathIsReadWrite=/etc
> +
> +[Service]
> +ExecStartPre=
> +ExecStartPre=/usr/lib/swupdate/wfx-generate-uuid.sh
> \ No newline at end of file
> diff --git a/recipes-core/wfx-customizations/files/wfx-generate-uuid.sh b/recipes-core/wfx-customizations/files/wfx-generate-uuid.sh
> new file mode 100644
> index 0000000..6ee2eba
> --- /dev/null
> +++ b/recipes-core/wfx-customizations/files/wfx-generate-uuid.sh
> @@ -0,0 +1,22 @@
> +#!/bin/sh -e
> +
> +# Generate a UUID from machine serial number using a SHA-256 hash
> +generate_uuid() {
> +  serial_no=$(cat /etc/machine-id)
> +
> +  # Generate a SHA-256 hash and extract the first 32 hex characters
> +  hash=$(echo -n "$serial_no" | sha256sum | awk '{print $1}' | cut -c1-32)
> +
> +  # Format the hash into a UUID format: 8-4-4-4-12
> +  uuid=$(echo "$hash" | sed -E 's/^(.{8})(.{4})(.{4})(.{4})(.{12}).*/\1-\2-\3-\4-\5/')
> +
> +  echo "$uuid"
> +}
> +
> +# Generate a UUID from the serial number
> +device_id=$(generate_uuid)
> +
> +# Replace the clientId in /etc/swupdate.cfg
> +cp /etc/swupdate.cfg /tmp/swupdate.cfg.backup
> +sed "s/__DEVICE_ID__/$device_id/" /etc/swupdate.cfg > /tmp/swupdate.cfg.backup
> +mv /tmp/swupdate.cfg.backup /etc/swupdate.cfg
> \ No newline at end of file
> diff --git a/recipes-core/wfx-customizations/wfx-customizations_0.1.bb b/recipes-core/wfx-customizations/wfx-customizations_0.1.bb
> new file mode 100644
> index 0000000..43fc2fd
> --- /dev/null
> +++ b/recipes-core/wfx-customizations/wfx-customizations_0.1.bb
> @@ -0,0 +1,28 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation 2025
> +#
> +# Authors:
> +#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg-raw
> +
> +PROVIDES := "${PN}"
> +DEBIAN_PROVIDES := "${PN}"
> +
> +SRC_URI = "file://override.conf \
> +           file://wfx-generate-uuid.sh"
> +
> +do_install[cleandirs] = "${D}/etc/"
> +do_install() {
> +
> +    install -d ${D}/etc/systemd/system/swupdate.service.d
> +    install -m 0644 ${WORKDIR}/override.conf ${D}/etc/systemd/system/swupdate.service.d
> +    install -d ${D}/usr/lib/swupdate
> +    install -m 0755 ${WORKDIR}/wfx-generate-uuid.sh ${D}/usr/lib/swupdate
> +
> +}
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#20205): https://lists.cip-project.org/g/cip-dev/message/20205
> Mute This Topic: https://lists.cip-project.org/mt/115872048/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 



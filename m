Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D32C3064D
	for <webhook@archiver.kernel.org>; Fri, 28 Jun 2024 11:58:26 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.88])
 by mx.groups.io with SMTP id smtpd.web11.15497.1719575900367077050
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Jun 2024 04:58:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sSih4Qcy;
 spf=pass (domain: siemens.com, ip: 40.107.20.88, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ex/cFbZgV7Kvnd/b8TodDNpdd0OXZuSyhlN1kZqwkzQiZhh0GBY125OnbixgItzRbEV5kXWIJMU6THOnl68vTPlsvuoTF1c4dttutzWMEMHTv4veGpIGvrjzMEPfOBi4HFHkyrhPYTmGtzWE3ggOzBY6wyLwsTvyXRDTZLMjBTmLOxNYa4Hquf8fd5nIJVHkMgSh6H1o5WB34gE4X5WegP66KiL4AKf07bxz6S+4lVvVu7+m/dG3RTSHG03OkOQoNnlI4os6Mo7sIH4fUCCpyNMiuWHpVn3QXS6yGbIVRSdpdR9wO5Nko/oUm6Vq5eH3uHi5p8oUHzehrW70+1bzHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRTynn2y8ALOLPwZdydHZ5rR6w6YRxR9AIUPYw+PXLc=;
 b=mYbkFjQ/UTKuOnUSOaPyvX/2G8lOJkbFt4UvDK5I8jP4S53oZJgrEeZU++DJyLmSur0zbtLC4cmGInSN/Ka9O9NTBakEs6G8Pd/sQ7/MZtm4QyoEvrsJLjhtXKAn7hOLV4OJPgmCx8xUYJxWT55h8yGFMUHxXgJAfBXo9UcREUnXT+1bxRbY7EME5UNzIkk80rFiiHtpmb/VqjHHWzJ0kj6JAM5/fK4LS4rCgWGAybiHx/kbtHCgdbzUvDA6YB1U2KVWmxu23dmE7W8Us3dVBgx6zVFVrAOGA/FSo/a39dbrOnXtuXoLjAwniqAAfgT8Yl32aVQH5TKourbEkRRFYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRTynn2y8ALOLPwZdydHZ5rR6w6YRxR9AIUPYw+PXLc=;
 b=sSih4QcyAxLYuozm7l//9rUYJikLa3ShJPHWfdb9tm33Ku+E3/BQoYGWQVnMrd9v/gWUWOXzuq/kSEBNVk7DYmSDxpXqEUqfNQ8q+Y2Evv+otjyXbm8Y9DyqUotMtrUCSZPWaH0MQkhI/rnecGb5fc1d8uzekUhuC29PS8O0NaEvfoUbJ7ImW/8NZ++OcGwISGkJrmJlX8jG7ZoYHfq4WPpaLFgDqLbbtDZ1LQo6w9Ob631gwebZVOJEbxORIDe/CVOiX1l2rr8dcz/RRAHHI6VCMuPWBiayNmDHGqCnyAt+5kjKy+rggAVqq/ZVeH6Kc7SnlodGIy97UCQqsTE5xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS8PR10MB7399.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:614::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 11:58:16 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 11:58:16 +0000
Message-ID: <e3bffb4a-0f87-4465-912b-f497a8cd6826@siemens.com>
Date: Fri, 28 Jun 2024 13:58:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 2/2] initramfs-overlay-hook:
 Check file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Clara Kowalsky <clara.kowalsky@siemens.com>, cip-dev@lists.cip-project.org
References: <20240626134141.74487-1-clara.kowalsky@siemens.com>
 <20240626134141.74487-2-clara.kowalsky@siemens.com>
 <0fc2eb61-c41e-4704-a329-a14b0529a1fd@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 xsDNBGE5tqgBDACpa0M7NVvWkE84XaWEmmQT0REu4Ad8DGRzxlQdLHn4PwakShu46Kl9Rrwm
 KZsIoQaLMM+e39xkl70bNFAKOodEgnkwzywjRkOXzf46AkBs3xThp/SMuZXIgdXDXhJupN1G
 1Zu0GbIx316GZaXf9lXuiAwwqJXKWsjRuFSNopQUMs4R4v7CRuwx/y2CPkAbq9rhph6njcaO
 4JTkkd8s0IA8Ec4otQ+YcUpRvrqHQAx3jFP3hDO93s1Ja8iLkDHxveD/5dnCoJ7wBxWQw1D+
 Qy/YsKzT9eBCo41aiP2sh6Xae7YAF/bZGXm5Nh/tIN6tM9O2ujsvICJMgaQ6KvLl7uLE12Ey
 3Tiatxuse0cRCVLU6dL/ljm7jY30gBpgP6UpMYANNKbjH1QHOkyM0725Wodh3s2kb+nMSgCr
 bx8kbD03tFAOFdmMANUmTI2XUcUUuEPHGWMViZlKi8GEIElXMXJi3WJSJBFaEYj/ns6lGKNk
 zE053GrLzJHh1wcZmPWHsZMAEQEAAc0vR3lsc3RvcmZmIFF1aXJpbiA8cXVpcmluLmd5bHN0
 b3JmZkBzaWVtZW5zLmNvbT7CwQkEEwEIADMWIQTY7GSkZ04ObjDZR5UG7p+HXEQunQUCZNTY
 OgIbAwULCQgHAgYVCAkKCwIFFgIDAQAACgkQBu6fh1xELp2ViQwAkSIZKvKai3o1yAsYQGYZ
 Pa9oIzM1+rqGPdBTqJ8LCIUM3kDz7kNo3nll2mnhtZOAeA/DpEc/pQGpIUUm2XQJEOCCv4Ze
 fO2tFuhACpU6Yz3XwQhr1SHy/KPsxUmiTgZUzfvlDxFzOuvKt4kg7/lC4/qm4i4ZRbohjggS
 XwLAawfULBSzoiTaMi6GtPm8e8oLoBwdo7UIwHHlN5s5UoEruntnc/Tx6+wWquHX/3/zVGUu
 OBqixq3uClkTNCY4itIix9yuMsUgWUgarN2BjcDxeNFIxlozGgcMmWyRobDOPfL7I0YHXm3/
 uB3wg4ei5dBCB12uYKr4CH/S3CRtYXUaIdyFoxYlvpEoUfuHthB2wcqQllVg3IEhGhkuvfTX
 snzeMFhg7wU7HlX/MDK5EnAGK9fHvZMnbb+H78bMNtoisBPY7XwuOAyUOtwMq0SR8G+9ZLnC
 ABeS6tyPB8UePy8MWdcTQRboXubmUkDAIwBuNI2xALMYZxyUZWEzD+M0euWLzsDNBGE5tqkB
 DAC6s08UAYSENgz33zbBZ+XWlo5A7muxzYjwN77DMgC5EcuqQJA2YnMO15mkB2YcTbP2Zf97
 ZhjTneRwe62xurjO2SOwPi0Sw3JN+VBQ1hpxMHJ2KjeAjJeQ4kINYgFFF5vNfgfGi7eI9qrL
 hViCf0Osulj7IGD7vDkib1WoO++SRO+9DShVD4sFIi0Gv9YSTalazpT9bgcAtnaDb/viLvaU
 qtK7S5rvFVPiuUD60yvmr3Pfd5iPKSxIQS/5/uKWGjeCntNu4ujoIg3C5rnDRIp4wcKIYXOu
 Nq0uGT52B4jtakb7jomXGX1/MZAHSRzUNUrup0UbwWCJEuvUEizq3G3Kg/Itvns5JzZAyGHk
 Jn0Sa9sTZCN+lNspvl1/t4F9ogBQbGOWPaslScjUQ5VDul8oLGMK1Zi+mj+SYFpQCXd7fwhP
 fl+yQlOdzGOGKHk9jqcaRHizuXtabQVIGrO8I52p26QJWaVqmMvJRWRqykxzk0Sw17/YDOBQ
 iEE0QOivBwkAEQEAAcLA9gQYAQgAIBYhBNjsZKRnTg5uMNlHlQbun4dcRC6dBQJk1Ng6AhsM
 AAoJEAbun4dcRC6dnnML/jLf8oN9BMkd/UaOtBh04YQQLR8TFwahbIZQZUakRteSaWILgGT6
 vuu19bbSaU3WAFHiB+ftuLYxCh9LB2YjEjoaDeFY+qOpYHsWKrE1g/rr5iEPyb+V3FZvd8a2
 fbSo7Hdw9n0jzAr6Yb6dMnU2FN6iRrIYoreEkEB5WbrFfmEyQGdxF45FGnu7mkLMGs4P8hiC
 Jpn73cdGB7Mj5+XWAcoYKDqXiKm6FL9Bfle7RO6FaI0m5JqQjGmsTLAIDaY6ZYSQmBzY8WzY
 5e4YlveowP9E+boqYhyPLGdDFVGhWwHMb/VkeFXAwsNtsfQfmpb/VmWs0urz8WkvYpiF6pZw
 Xe/DyZ2leVdCQVbhsUb4z1b1nAYAxVB+4yIqi5uc1cQYFzb1LPeMcQ0YVv9UAjqaYzP4vh6e
 2zRoeyL3H2PAQbodkBam6WiNHFG0HezOnSTxOHcpqx8s8bzgrJHGj6eUbQjxG27SGvTcy6Gs
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <0fc2eb61-c41e-4704-a329-a14b0529a1fd@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0004.namprd18.prod.outlook.com
 (2603:10b6:610:4f::14) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS8PR10MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: 49739fbd-1826-4ddb-5b8d-08dc97699829
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UzE0TFRZT0ltbElEZGV3d0VFRlBJMTlHbVFldWhwanVDL0xjbUZWNmZRa3RC?=
 =?utf-8?B?U0M3RUFIQjFLU1NuRkZrSEg5d2VWdGVCTTVxdldVVUl4WnR0cmRMN0M1d0V0?=
 =?utf-8?B?YURuSEI1OHE0VEM4RHJxWlBoNzM5VTZETUQraTdjbGw2YmtETW5hS2Nyb21q?=
 =?utf-8?B?QzNpb2hZcmRaRmRIbE5zaXdPS25TcENTTHVRTW9ma2VtQ3JqWUx5TmxuQkNJ?=
 =?utf-8?B?SUt5aWNHZFhaSlBWT1ZkNEdQaFF1bmNmRVo5UXo0Q3JIVklyYWNJYUNTYXB5?=
 =?utf-8?B?L240S0V3Q0Vjbkl2WVNHRWVKWVFNazhqQk9RZEEweDF6bTFXdEtlRnNtbUxQ?=
 =?utf-8?B?NUY1cE0rWTdiNWRyTGFkOWdOZzYvYVZoQSsxbFNuNHpmQWdCMS9lSW91eE5p?=
 =?utf-8?B?bUhTVHlpTEhIOTNhZW1MVSs0WFhhd2VZL0wvMTBML0ttbTcxZmliaFY4M2lP?=
 =?utf-8?B?V0IwTVk4c25GNUlReGtZc1ZiZklDdUY5Z0lKaHVadmxjUit3eTVrR0pnVjBJ?=
 =?utf-8?B?aUFuWVNCWWhUS2JwckRHQ1YxN2N4QWNsMXROZUdIaXptOFg2Rzc2YlNoV2VM?=
 =?utf-8?B?NUI5SkozdS8reHEwSUYzN1JsTXhVV3ZvSnR1NTZtQ0g1VEZ2MUpWMTgwc1lN?=
 =?utf-8?B?d3djUGNULzdrSWFrSzBLSjZjV2hoU01aajJyWDdBa25DSGk4UXpQNUhtaC80?=
 =?utf-8?B?dzl5Zit0QTJJZlNoS0hJVEVlRTJMdS9YaXFRUUdReWt3MDhudkV6bC9EZWhx?=
 =?utf-8?B?TnZacC9TSDZrZWxHSU9XdmlPMkxRMnB0SUVSVTZWSmhiakxsemk1RWVZWXBv?=
 =?utf-8?B?UHEyNkMwUE5zakcwS3A4Ny9JeXpJVUNMWHlwSGZzRHc5V1pSZExGWkI1TFRD?=
 =?utf-8?B?K3ZYcUlWSEdWMWhEYkxjSGRsR1d6QlpsZS9oc2dqRmlXQ3hBYWIzcXgwNUti?=
 =?utf-8?B?OHlGZnZtTzNjR2lBbDZ5UjJoeUNqN09zTEZSVzV1SDlOS1BoeVU0Zkp3eDVV?=
 =?utf-8?B?RTdCazhDNkx2L2d3Z1pNTno1RjY4R1RxVmhlMVdJKzV5Z1dBcktUdStLRTFR?=
 =?utf-8?B?OVdnRkJ6UnNIdWlNUENoYzJQSi9YOFVNdFJDek5hc0JaNWpHY3JsNGpnaDFM?=
 =?utf-8?B?Q1JxcU1ZVWlHZVRGTGE1ZUFJdHZlaTU5TlNvVGNXVWlRNjNGZ3lBN2hGV1VQ?=
 =?utf-8?B?SVM2RUZLTlNCNW1FeWFtbU1reTM3SzUyZUY2aVlSSEFBa2VQK2o5d3crWE5T?=
 =?utf-8?B?V2dteUlaTnB3RWtITXBRZ2t1WU44MEV4OURNM1FDZUVHY2JaKzRLcjlpalhU?=
 =?utf-8?B?UGwzMHhpSEJ0ZXRVaVR2TGN3RTZjd0VaSmNURXdGMVNaTW5zYi9lZlBmdzdX?=
 =?utf-8?B?dmt3eC94czNZN252ZnpHOWNobUhVNEFTTjU4RXliYkhDMmdISzJPMTJtUXFw?=
 =?utf-8?B?UDJDNFVDQjduUnJDb09UOExwS2UzS0R1alRFMUZlOHVVRmlPRkNIYjVmR3lS?=
 =?utf-8?B?UmwrNHUzNnRzQk1CbnY5a2JWYzZITkhINVJSTEF3NmMvZ3ptbEU1dloxVkJE?=
 =?utf-8?B?RUoyQmYydjd0ZG5CVW9iYTVmdVBZbG43L3liZ2NyVlQ4UzBRczZyOHppZ2g3?=
 =?utf-8?B?YXBaVjQ4OHhYYm10Sk9GbHcrUytsc3dSSnVRS0xVWXNRTkV1ZHNxcVpIT1Yr?=
 =?utf-8?B?YjBIV3BvVEY2RDc1UWtZaDVtaklzVEFCMHZaNEtEOVBSTVJYZnBmaWdLOWph?=
 =?utf-8?B?enplMGpOYVRQYStjRmxRZ2xoWEFSeEVtRnljRWphMlJCakpqekl0cURIaUlr?=
 =?utf-8?B?NVAvMU1KNVBRdnJLM3VHQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Yk9VOE5NbTNmVDRlNU5mN0krQzJCUDYzL3VwbG9WeGtETjlOQXBQS2xUQlMx?=
 =?utf-8?B?eUlDR0hzSGxBcy9rTjVUeGRLUWRpMXkwQkxzTzFCSjJnSHdwRnBWUm9UTVUz?=
 =?utf-8?B?UUVHbUdpWHZZL0pPOGxPaS9sRjFLNDNqTWRvTTNoNStZQi9BR2tlTzFBNUU1?=
 =?utf-8?B?eURIZ3pCU2cwQ3V2UFlaajBlTUViWXZRblU5V2c3b3ErWWNxSDhNYTNOU2dY?=
 =?utf-8?B?QjdqMTdtb0sxVUc5QWJDREdzKzE5elM1S2xXVVhkTXhrNi9OVGI0UGVTTFkz?=
 =?utf-8?B?cU1MVUlKc29PbUF4dU1uWjZpUW1vOEJRSkRQa1QycW5wT0ZzYkJrL1NBVERv?=
 =?utf-8?B?dmRZODIwZXJlNXpTTjU1MytRbXFtak1lZnR3UllsSElmK2hVQnZKK0lLdlVq?=
 =?utf-8?B?a0dnSHBKeWZsWW53RXh5OEMrbVRTTHBaSGd3bGJwUGFHeFZ5dldDczhCblNS?=
 =?utf-8?B?UkRvWncvUUxEcXhZcjdRQldobmp3d2xSRHNCa3lYUXR4dllOZHk2cWxDV1li?=
 =?utf-8?B?emxFN1NnaUpuWDlQNElCMnNpL3FRRkxJb3ZTcTlpd08rcVNXRzZ0TEU3R2xs?=
 =?utf-8?B?MzE5c25rMGdVZGhRVjMrY3BIQ296MTZ4eFUvS1JCbzZDUGR2OFRXa2tHeDAv?=
 =?utf-8?B?NG9oOFBqTHppYTZPWGJnbUVqMDVlKzVYOFM0LzUzb0xoS1FXVWdJS2VkaVpi?=
 =?utf-8?B?bnlZSERNdGtHclIvenFZS1B3Znh4REtkNm1qVi9wNFhMUmtpLzFpZlFYUTlz?=
 =?utf-8?B?ckFOU083bWxsdWtsbEpJMGY4cERHdnFyVmg2NEZpT1VVd1g5dmtEeUF6MExF?=
 =?utf-8?B?WVRmYnZ3NnI2QjFicWh5aU5oK1NXYXpvKzZGeTFxZ2trVEJIeTRkQVpKK1J5?=
 =?utf-8?B?MUpTbndQTENJbGx5K1MxcnNEUDh5VVVta0c3NlNsS28vbjQyYm1rQU9LRnNM?=
 =?utf-8?B?STdHQnFsa3lGY0RxVVNXa0VYek9qWVNqVE5OK3ZydHdPWVArVXk4VHoyemRx?=
 =?utf-8?B?S0w2c3FPMDJXbmtESVljWXpBbGFxcDMxKzQwNEc4MzVkYS9RRUxER3h5bllH?=
 =?utf-8?B?MUIvTlNXWkdCME1pTlZ3RDVzaGw1TFVGRzFtWkpGNWNTOUxnb1Rnci9YenB0?=
 =?utf-8?B?OThiR0lxODNaSzRUWk5Wc2M3eDVpSHJWMVc1NE9MVWNtY2tVOU04blRydEFm?=
 =?utf-8?B?NXF5RTNpUWRHZmpYWGliNGxSbTBvRStjVHJydlQwSzhFbXd1ZEo4L0Z0ZzBh?=
 =?utf-8?B?TDlGSTdpZkN6ZUNYUjhpRFA1RFd2NDZGZFhoWU1xa1p2S0ljdWNtUHQ3Q2VN?=
 =?utf-8?B?UmNEM01mSHpuWFBGdHZwa1FnMmFBZGk4S1NMcnViaFkxV2lFN3VjUUFjSmJT?=
 =?utf-8?B?ME16YzFxbW1ucWJMYnltME96R01nSVdaWE0xZVpyeDhQS2VRaU1XU1VJeHhz?=
 =?utf-8?B?UlJ2Yk4yTmpxNUV0eXVITEMraVlGaFR4ZWpydlYzektMSkxUVmRtSVUvY0NM?=
 =?utf-8?B?M1RpRW5FeGpmclpPTURTU1F0YS9rdzhkaTBBbUVCUnpOaVo0RjFhR0h0SXdZ?=
 =?utf-8?B?ZG1scXNVMDlkeTY5Z2t5bENjZXFZWFdNSVg5eVIrL1hHcnlNYXVmYjlyaWFQ?=
 =?utf-8?B?UW9IZE9kZklLa2FLSTJNQUJXOVc2ZlFGdHU3L2FDNDI1QzVlaU5zYTJza2Jk?=
 =?utf-8?B?VVVFWm5aYkttZXBqSTdVZEhZcWZVYlhXSUFHMkRQUkNBUDFMRE92MWVmdUVU?=
 =?utf-8?B?OWR4d0lzcEc0UXAvbHRuUHBveWVPdmYrU1p5QzV4VnZkTDREN3kxUVpROHRi?=
 =?utf-8?B?V21lKzdTZW5HTFkvcE9WbDY4RENpTFBQQnQwa1BKQ291WGsvUUErVnkxT1lE?=
 =?utf-8?B?eDNhUklPbW1MVnc0OTcxcVl3Vy8xdldmKzgwTEN1TnVmbjdKbGx6MGsxazJt?=
 =?utf-8?B?L0FkMW5qOEw0ZnVBNVZ0aCs2bUpoNXlTNlkvQUhpWm92M1FPZXhYWlFVUDds?=
 =?utf-8?B?K1lGMk8vUHBOcnZtYTJPRnN4bmRUbVlYY0dOT0Z3UDFJMG1wYkY4VU84NTlX?=
 =?utf-8?B?QzJhRTI2ZGlNYjUvNEV6OGxYQjlzQWNFNjk3Z3AxTVdJZjFWNFV0REgxeFRU?=
 =?utf-8?B?TUxiMkJLNXVuNXhtUzhnL2lXeEk0ZEM1aFhubTY2UUp0Ris1WHQyd1diVG0x?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49739fbd-1826-4ddb-5b8d-08dc97699829
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 11:58:16.3072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06KWfzgi4NUdDM/+p1niIAwCDHxABNDGqJuiy7i5bt5xIzWFG5BX9vPtZWojq09hDRi/JGGOGTR4SE5dtk29H/Sw09bDHBoXB8kV/F7cmmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7399
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Jun 2024 11:58:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16343



On 6/26/24 3:56 PM, Jan Kiszka wrote:
> On 26.06.24 15:41, Clara Kowalsky wrote:
>> In case of ext*, this detects and fixes file system errors in the
>> partition device before doing the partition mount.
>>
>> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>> ---
>>   .../initramfs-overlay-hook/files/overlay.hook          | 10 ++++++++--
>>   .../initramfs-overlay-hook/files/overlay.script.tmpl   |  8 +++++++-
>>   2 files changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>> index 8b00ecf..1a54853 100644
>> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>> @@ -22,6 +22,12 @@ esac
>>   
>>   . /usr/share/initramfs-tools/hook-functions
>>   
>> +hook_error() {
>> +    echo "(ERROR): $1" >&2
>> +    exit 1
>> +}
>> +
>>   manual_add_modules overlay
>> -copy_exec /usr/bin/mountpoint
>> -copy_exec /usr/bin/awk
>> +copy_exec /usr/bin/mountpoint || hook_error "/usr/bin/mountpoint not found"
>> +copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
>> +copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
>> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
>> index 42eb59c..6b404c6 100644
>> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
>> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
>> @@ -34,9 +34,15 @@ ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTION}"
>>   
>>   root_mount_storage=${rootmnt}${ovl_storage_path}
>>   storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
>> +partition_fstype=$(get_fstype "${ovl_partition_device}")
>>   
>>   if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
>> -	if ! mount -t $(get_fstype ${ovl_partition_device}) \
>> +	if [ $partition_fstype = "ext*" ]; then
>> +		if ! e2fsck -p -f "$partition_fstype"; then
>> +			panic "E2fsck on ${ovl_partition_device} not successful!"
> 
> Err, this will break the boot without even a chance to go back to
> factory state, no?
I would add a hook to a script which defines the action in case we 
cannot recover.

Quirin
> 
> Jan
> 
>> +		fi
>> +	fi
>> +	if ! mount -t ${partition_fstype} \
>>   		 -o ${ovl_mount_option} \
>>   		 ${ovl_partition_device} \
>>   		 ${rootmnt}${storage_mount_point}; then
> 


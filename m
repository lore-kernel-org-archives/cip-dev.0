Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9527.1793062488217871959
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Oct 2026 17:54:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bOU/FNwO;
 spf=pass (domain: siemens.com, ip: 52.101.66.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/KYpaIqQSn8CeUY3D0BgSv1bT11fD4Q8pGHlZ0fPaJ3ZDiP5bBOpLgyCgS+dhka601DPWrQ4OZmwX32VLzNnLrGOoR0eLjyI51HdjPvHfk5tn9j8LPAaHOq9KFXzLcdnCVMBhz+eqX6EA4ZcbZo0wh9qyx/z7SbgXDWYLBxdEN/j4sp1dgTUSYTa+bmYXuzWTnUfUE1QcOr9CRwBCnonusjzcNLBZqwYcwkQVB9/lC63HH15qo1YIQW4RtJ7HF5v7tDkHLBS9YO7f9VIaQeAf0L8QywGRHSX8ZZN2qQu1PqcmnQ4/IdXpREAecG/sBlaO7Xr+lwbdMz9XhRcwivUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsXKSaShqhkMIUC1x3EQSdmNW9Vunhu28/hrFeM6rQ4=;
 b=pfiQLV1fsDX9Z+kezu3T4AcFt2mnT+OzktJ567IahZtIsCrRgNtzDrnSes82oUrWeI/XOz7w0HZn6onjnQl9b56+ozrev3GfMu1qQDN6phw4WLtKi9jDjfbHHnwU2EnoFxo2mJsi3VtJrP2m2lVF/eez0QU1MKWPzsoS9zHpo6RT7ks0FnMBNVpC6T5LkezrelJ88+c8CLSiJpjx3jGuVFo2xCm2R0Xa8mwdtxixCpHlrt8rHKdDQMKVMfdxXg9DwS2QzOq4yrscF/JhyyEzwxkjcKeoZmquU3d9VwUpsB0oqoLd7M8ydQ6Ku+GFTFCtPZcBERHrG5y5TL8xBRZeHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsXKSaShqhkMIUC1x3EQSdmNW9Vunhu28/hrFeM6rQ4=;
 b=bOU/FNwOIgEjIQB6j+W7P2QzaeZOajJXXXALm8whkGwi26Ukt0mxmqLXfGKoweXO70i65PNPFBbfioeC5VebNxMvlh7xy92ER3lAqauU64vpaK4eA2f2eVRR8PWlKFjqX2PwR91cgyjtmch7MKVWVXsSYm85lgzSPNsHf7hEMX/ZRiQNH11v1Z9UBcc+Oq+/wmK9VL51EhOQ0s2vRd9nlsXoxxaltoKUkW+95F9aN+06Duok12liCR3i3AEcdXgr1Fyd0lfWoVjmCYRn61IMSoXXWAb1uTfi1VuP2aZzlrq1r8gEGgsEZUYuCYlXD0og4KtZ5z9inBv1Ew88pdx4+Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB8PR10MB3738.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:118::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.7; Tue, 27 Oct
 2026 00:54:44 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0569.006; Tue, 27 Oct 2026
 00:54:44 +0000
Message-ID: <067beb45-4754-4638-870b-3cccc8a8319e@siemens.com>
Date: Tue, 27 Oct 2026 08:54:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v3 0/1] start-qemu: allow more variable
To: "Niedermayr, Benedikt" <benedikt.niedermayr@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20260323101546.3273376-1-benedikt.niedermayr@siemens.com>
 <9a353cbd-f3b5-4f90-84dd-f27e9846d50e@siemens.com>
 <4e58ca62-392b-4ab4-98b0-9bdcfed4ab98@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <4e58ca62-392b-4ab4-98b0-9bdcfed4ab98@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB8PR10MB3738:EE_
X-MS-Office365-Filtering-Correlation-Id: a5380b3a-fd66-47e8-0516-08df33c4e3d3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|261009223027099003|261021123027099003|261022075727099003|261021121427099003|261022115727099003|10067099003|56012099006|6133799003|18002099003|55112099003|22082099003|261026121527099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: NIi1kFICDQRI6EJtPhwQhtnczR4EGz3Nl3cBCfr3nQRpKAM1MygAdU6P9j7mFJqHcKhvJ1r/33r7/k/hT+oOWMDPS66er9nA17sbBg+scSX2bztwCwO+WzqbEf76+JnkwIpHhElXMkGJ+XAChCRwWmtb9RSxGs9bIRFgrZN4S04/fltEZ46YLKZyh5SR0RW8ANktrq0wN9zv6GuTzN5QR7fgAOCWjpdxqFEX7HfX5pRd9W5Jr60XP7UrR8M4ULxA1JHqaYTvWbJ+cjrsVyKKwwX2QPbX5lL7qv6FZT8M/QXfTfwq8GebTGTXNFIvvO/j7W5qpxohqMwMOsiHRu3DoOJWMyENitk+NpATDwQ66ywE6Dxem4cUQXTSz3RO9Kw/xLaS1Um7B2Tn50zxoaFp2Ol6nCTOhUgFCFdmh7q10a71e0IYMm8nizQmHYVQmMkRxrjeQyTE2PxiaRdcM3c4V5VXXeMgy3VzY2mGuZ5YMtU+IB6t7QDFjRGYTZHVkdAkxLgCbCmDRCoWDj+/a2XCQXT5XqOPpqVh2NgBE/7PVuBD+jXlPRAXPa1RUFaWobDy6PMF3i9pKR08zTcDlC90mNm7BC4I/Mhh/6RqIzwO8JgAJmmQ1DI89XlhViGyO3dPk088DufskfxNZ4TdQMCweGhpOJ9VMPF0gBsAvdUsXjM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261009223027099003)(261021123027099003)(261022075727099003)(261021121427099003)(261022115727099003)(10067099003)(56012099006)(6133799003)(18002099003)(55112099003)(22082099003)(261026121527099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZStNZGthNENtMTZDRDRjSmoxajNUQ21XbXN5cGZWSHdsQ2xVMDlsQUxaSXgz?=
 =?utf-8?B?NTQ2WWdud09ha24xZ3ErOXY2UHMrWkFlWU0vSzg1YjRQb2FYcWc1dmphS1VC?=
 =?utf-8?B?eGQrWmNYM0I0bStUZDJHd2Z1ck1SVFhTTW1YMFFyOS91T3U1dW5GbHU1azlV?=
 =?utf-8?B?cmhDN3dIRjdIUXpGdHJwazhZLzNyMHdxdGxIUmFMKzdYWndTdEFEdVBOMWVa?=
 =?utf-8?B?STFsOWVrVzVtQ0xmeUwxM3puSG5DYkdQbmJjdU95a2NjYmdnTis2SVRMVnRw?=
 =?utf-8?B?eUh4S1RvVFk1MFZsMnRwNDBvQ2tGT2ZDSjRwMXZTamFSUmlEVElsUCs0b2x3?=
 =?utf-8?B?aVM2VnN6VWc5eXRQYWhOZXJVc2h4c1oxZjlCZ1puZjBkTjdFT3lEUzV1cDdD?=
 =?utf-8?B?d3JiNjdzd25RYjJaUmZwYUtOSk54cC92clUwaWxBRFNFbTczVU85NHFCTi9s?=
 =?utf-8?B?VThjeGErVHlvOHY0ZDNKWC9GT3VJcm1HOEJBT0ZKUTE0cjRvZkk0WjFFMDg5?=
 =?utf-8?B?R3VmSWFQR3p0dEZkZ3NqL2JQempQcnRZZkNOY1ZQUk9yT2g5djV3bElXYWpW?=
 =?utf-8?B?VzA0bjNQU0FabjVNQmRvYmFaTnpmWXFBcU1xOVJLK0RrelVTSC9IajVOdnJK?=
 =?utf-8?B?cFlGU3o1YzZLQ2lQMXBZWWk3YWJVYWhIQUk2Ykg1dGpjZEQzN2tlQ1V4TzZ2?=
 =?utf-8?B?WVFPU1FwTzVTSmdBMlZNbTZrRm9sdGtwWmpwZkVvdjI2bU1zZ3VLR3JjRkp6?=
 =?utf-8?B?YzFrenc3R2dXRlR3MmdnSkZwdmpVWWNBY0QrM2hscUlPS1JvV2NuQnBXTUlt?=
 =?utf-8?B?cEZZU3pzaU9zbS9qS3ZZbEY0UzVNeTl4L1FTS2hmc1J0MGV2NG1jZ1hGditB?=
 =?utf-8?B?MXZtMW5Wd3ZOZC80MTY4TG1FQWlIdmRBajBVNGhLZ04wdmlJSllYRmxLSEJu?=
 =?utf-8?B?U0p4WGdaTGhPdkN2b05tK2x6WHpKeHFVZS9DL0RGaXdJVWxqcWJNc0RPa2h2?=
 =?utf-8?B?UG5DOGJBMDVBM3N0RC9BNUJKbE54RndIbVcvTEk4bzltL2xNQjBqVUpwOXpw?=
 =?utf-8?B?TXcrcHZMNGpKdU9tSjEwZ3hLVXNlREs0eGJRNXhENGxOWDB3M2FlcTArMGFu?=
 =?utf-8?B?SUszUWtzUDRENGtRNkZOL21pVGl2YlFENVRwNHdzdmNSaHg3NDVPd0FybTE2?=
 =?utf-8?B?QzUwK3hNWi91Y3NMdTRRM3dNOU9sSER3aC9WWGljRitrSDJBL1FDN1B1UmQw?=
 =?utf-8?B?V1A3L3ZaOXU0bmxyYWRyTmxpUHFtQkpJVEpuWit0aVEyZnIvWTI2WkQxR0tn?=
 =?utf-8?B?NmJySUFLdkVsVEhjbkJFaXM0bGU4MHd5bXdZSVBjV01ZZzMzWWljbXlxZXFy?=
 =?utf-8?B?Skl5anFHSUt1a3BQTjkzODFjYUV0TUdLODJ3SGJhRFJBRUloUk5zWjRtdnVR?=
 =?utf-8?B?T24ybnRkVFRuYWRDS0RhVXNrUitRYXhJb1g4RjJINEtORnU4TkllV3d1S0xD?=
 =?utf-8?B?SmdlTXozVFFDR1hkZ0pkdlN2a3J0aGx6UUR0ZHBEcERveUN3N0xxTVJDNWR1?=
 =?utf-8?B?emdzQkdHQWxUWm94ZG9HcWd5YnJOYmRuU2VpczFZSjIraGhDWU52VWJYUDZL?=
 =?utf-8?B?OHVKOEl6aHg2YXBlQ2FvSFhsZ3U3QWozSmZTVXM3SThmYVZjaEl6cVFRT0E2?=
 =?utf-8?B?ZWVaanRZZU0wdWFsLzJrSWpVclpadStIdk92Mm5MY2JXWGxDdzZKU25TbUQy?=
 =?utf-8?B?R3ZLSFRFVkprdHFzZ1NPUlF0WFJ2azJLeGFVaGRDTnNKUGw4OTBkY3A1NVdk?=
 =?utf-8?B?cDNmSUdjYnhDa2F5bGZvWHlSeC9TWk5zZDJSVTNQUHBkVDBYVjVGaFN4VkF4?=
 =?utf-8?B?VjRqTzIxOW1yalRhVEVhb1VLYmZoaW9WeTlYMkZiamU3dDIrVGRGaXRFa2k4?=
 =?utf-8?B?NHZzVThhM3Z0ZGJjVzlJcHBXNUY4NU1DSHpTOEIyM1hjUk8ybUQrNVhLSnZD?=
 =?utf-8?B?cjlPanozUWMxTU9UVDUweWJUVFlJRS9lOGxVQlhsb3JjZUVUeGQxNlVYZHJm?=
 =?utf-8?B?QlFaRWc2RVlPd1pnNzdrRHJhVVlnYnF0RWlnQ0U0TmR0STJETG5IdGxKVTMy?=
 =?utf-8?B?dnc3MWtVUStWMUtYZ05DZkhwREQxMWdTbXIwZ3NrREVNbHFjVFdVVE9JQU4r?=
 =?utf-8?B?WXhDd1JiTUM3UlREeVAwaFVscFdmT3Jsa2pZZDl2QnlPN01xaHFBdFI2NHRw?=
 =?utf-8?B?cGNBM0pYKzROeUtlbkJhZHdpVlcyNm5mMXZNcEJMbWg0cXhvdENLYlFGNnJj?=
 =?utf-8?B?bjBMekJDdk9YTE1Ub1NDQ29tRzBTMDExTjBtVklFN2ttUXluYWQ5Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5380b3a-fd66-47e8-0516-08df33c4e3d3
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 00:54:43.9536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxmYF1RHjrnvpteVIbpmH2rlJ/+hx4r32yjIz9ewiS95ZP52503fqp/V1te1UDE3BYX2echTqYXzJzOzVevS5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3738
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 27 Oct 2026 00:54:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24551

On 26.10.26 23:11, Niedermayr, Benedikt wrote:
> On 3/23/26 12:28, Kiszka, Jan (FT RPD CED) wrote:
>> On 23.03.26 11:15, Benedikt Niedermayr wrote:
>>> Reposting this with proper subject now
>>>
>>> Changes since v2:
>>> - Fixed variable name DATA_ENCRYPTION -> IMAGE_DATA_ENCRYPTION
>>>
>>> Benedikt Niedermayr (1):
>>>    start-qemu: allow more variable injections
>>>
>>>   start-qemu.sh | 34 ++++++++++++++++++++++++----------
>>>   1 file changed, 24 insertions(+), 10 deletions(-)
>>>
>>> --
>>> 2.43.0
>>>
>>
>> Just to set expectations: candidate for post-v1.11.
> 
> Hi Jan,
> 
> Seems that this has been missed. I don't find any trace on current next.
> 

Thanks for reminding me. Applied now to next.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

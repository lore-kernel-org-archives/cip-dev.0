Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D297C83013
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 06:37:32 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.11])
 by mx.groups.io with SMTP id smtpd.web10.17490.1751438243059958944
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Jul 2025 23:37:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Mse6CHMb;
 spf=pass (domain: siemens.com, ip: 52.101.70.11, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vN0HzAaZ4WnJDcPXXzI6AZPQndGi0m5ZyuF3ZmQ5C8arX8Ngr85AOevju11zbi3C869iQCXUojGRgolfLCl0iZn7umC4itMzEdPqd0XRIzdD74uTcV2wCLigyp6wdoy5ttNOnVjwN0XiSDZcDhcpdyH3+pP6I+l9aJxsTPaqdzpC0vnDJoRz6y2q1ApBWwQv1R0vv+5PXI4vtTNyWG+2ksIQHtqYC91NjwD1c5eevYG85zo4piAH0Weuh8H8NVtZB2sBXZPsD581Iy6VLgfC5yuJi1kATtPtGyCm2z89DyUseLo5ZKPwkDZQ9qIdReOuWPVJN3n5duTzLUlfYNUOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xgvc6NOO6MTZwlbdX6c8qudAh6TTDrwDOwK7WmdJpMc=;
 b=OPfr4V/mZ+cd9EVKn2d/Wi/peSIW37WhtZCL0D/iHWbRXthYVNSiQ2fOned5uZxlNb4wPx3MnuW3MYhJR+gNdVb+kMAO33FTxRAqzNHH5bA2mLacHhl2Eo684385dKtNnOd3tloaVOFoI9WtJiNRSFgVOARohB+NfRVOw2Y8JrJPJEEx1emSG2pcdj1MGoSXvRenxyidBs7P6MC7ZZ5mUYsVPNFYtFmjgpk0uhx7TwS7h4oCWnDWZ0wV7abMd2E6HdGbO/TJLykMrG4NM6uhU6G9rlInnL3NPo8s/Bj6tcvz0qAd464aEEfgKeHpVD+C0NVwiUHCX1gjr1tx+PQguw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xgvc6NOO6MTZwlbdX6c8qudAh6TTDrwDOwK7WmdJpMc=;
 b=Mse6CHMbjcQMskthUqO0viWP/eAtzhmP7trEtrwuPydBxhKkqKa/YQnZOVihZ0Gt/EGEoOETr67+QqLqWz5lqqfaVU6JvKVw7RBoZ1nOKp9rQ3ueOsqdmf0EwZK6kuDM1Ciux3qJ5iC5f64bdHzKnEQd+PyPD9ZeFav5qcULkNuO/SvX/DsCWUgBHDlxfN47DE5ToFV6vIIBQ/9/sTAVSX0PLGj2ZliVwQlqIsNSBHNyxeeC1RTEQciW9TDgVJmHkUIexClRkEXxlU8MTONv9CaJPVoOubzbfiQvIvVxn7umnAMgJFJqSeHKkqvYJBexX1EGISES/sfangfcaY4qcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8708.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 06:37:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 06:37:19 +0000
Message-ID: <79d6a898-a915-4e7d-8731-3b245e8d3ecc@siemens.com>
Date: Wed, 2 Jul 2025 08:37:17 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>,
 Chris Paterson <Chris.Paterson2@renesas.com>
Subject: isar-cip-core: no support for 6.12 on RainboW-G20D-Qseven
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0237.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 692c9403-e3d6-4860-042d-08ddb932e48a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dDdtQ1RzOCtVMlNQRGowcE54TnRFVUtPSGhvbTl2YVNqaWhDejRKYkRSUTcv?=
 =?utf-8?B?RUNCaVBBaXdhOEd0RUdUei90QTRvamhNeFN5YU1QWE5KZUx5VXFuUmdOWlRo?=
 =?utf-8?B?NmlQMTV4cnpsK0RwZXJyeVNFZk8zaDJEWEJSUUdmMzd2SEJNNjJXMnJXU1ZD?=
 =?utf-8?B?ZFFFVU5OL1VJSFQ1YUZUdGFWeHdYeWtacWRLZ0VFN1dSYVV6SmlPaXBJSXBW?=
 =?utf-8?B?ZjRiVHpXSkFSdGFabDVKMmRibWMrd1A1QUt2VGhqb21BQWdmSnpBZTg5OHlj?=
 =?utf-8?B?aVN6SGtubzRCQTNyVXdhc0Jvb09XTENMNkhBMTFwVzZVR0xrbUQvdTlHbEwx?=
 =?utf-8?B?Q3luNDl6U1paMUxacCtEcTQ5ZDJLcnRkOTlEN0tTcUhKdnJxQkpMeDI0bFVo?=
 =?utf-8?B?cjNSVlVUU3Nka245SHZ1U0tpQUg3N3A0SVIvb0wzVXRQL3M4YXYrMUhwVklB?=
 =?utf-8?B?eEs2T0dJZlFkMUNudXJNTnl4dGJJSkFLQ3lHY2owZnhmRHpBUHdiZzQycWRm?=
 =?utf-8?B?dUF4SFBPdGFUTFpjYitOdU1QVlArWkJmenlPVFhGSExKaUFNY1dBd0FmR20y?=
 =?utf-8?B?cG5hQ3BRaTV0SUxhUlBmeUlQZERtSmVQaWNvR3AyeFcyWmROT1hZYzF5WmlY?=
 =?utf-8?B?UE9XYk80Y040TEtwQmZMQUw4V2RPcDRPUENNL1AyWlpqQ0pKejAyZURIS3ds?=
 =?utf-8?B?TXJKc2VYYmx6Y2hMbFZtOXJxRDZNOWQwSFptdG5UY0JybUN6M1N2YjlFa1I0?=
 =?utf-8?B?SWhscmYrSXg5Q0FkRERuOVF6blFldERQQm1EVXA0bWVvaktkdXlObDhXWkZK?=
 =?utf-8?B?V1N5aEt6V3RwUVBuMXhEbkNoU1hDamdxcXFieDZHMWhJRlU3MlBtSTZuUHJ4?=
 =?utf-8?B?R1FiUnozOWprU2RKdGp5TUlrYm5zMlVhS3FSdFhLNGNRcHFLZXZrSnNCeWVE?=
 =?utf-8?B?TDlwLzdINVMwek9XakUzV2ZZUmM5VVdhZG1rb2I3NXZCSGhUd00zeWJUSGkv?=
 =?utf-8?B?Y0J0WThyUHlVekx2WFhzZUFRR1lBdGszTDNYZU16OGgza2JPL0xoeTRicWhG?=
 =?utf-8?B?Z1luS09sZ0gwcTZqSTdFaXFHeWM5TlJWTEM1NkkvTDgzcnhDeHcvUmNnV0hu?=
 =?utf-8?B?SDBuREpTOERDbnV2ZHFKbnRyd2lWZjVQOTdHK1U3YklhRjgwUGFmdmZjV1FE?=
 =?utf-8?B?ZmFtcHQyMFB1RG1rOTZ0ZWUrSkFPSFR3bWwvS0JxcVlTRWFaS2pGYm5YU3NP?=
 =?utf-8?B?UTd0THZMdDNtTnBVZ3d4N1RuMjNjaWJBbTNLN3V2SXZxSU1RZGc3djZzRmgr?=
 =?utf-8?B?ek9Hdm9SRjRDRUFGNWtVSGhHZ1dSMFJmYzdwL29OUWhXQUY1eThhUUcyWGZK?=
 =?utf-8?B?Y0U0SWNQcElBYXFkQ2oxbkVxWS90S3pWOXJmRlExdGU5bi9DUk1sWjI5Q3I5?=
 =?utf-8?B?MWF5R0hjNXdZUUdtWTFQYjJxWThkVFdYTVJITzdqNGZuaktZZzhaYjBqUWhw?=
 =?utf-8?B?V3graG1qUkhCWllxY2NlTlFSS1gxelRCRjhaenlRenpLSFB5b1pJUTltOTdz?=
 =?utf-8?B?ejVzUURFRmtONm9YRkg1Nkg2ZHJGMk0yM0ZKdXRiY0ZUY3pHbnJnUHhBWGtX?=
 =?utf-8?B?OVNCKzh5d0NGSTM4clN0a2V0SEtZMUUxZE5HSGpBaUR6Wi9jcUdHZWpIRldG?=
 =?utf-8?B?ODROVTkwTGtqdE9Mem1DSWY1U1NjQWgzdGppQWxINFNvY1ozRUZKUThKMDc5?=
 =?utf-8?B?N0N0MmtuZjRwMU03bjI4NDBmSXQ4c2FBZXYweVl5bUk4NlliY1ZXZVhmZGlD?=
 =?utf-8?B?bDJEbFhRbmtwQ3ZBYWNaNGtMV3dZNjBSckdkUG9HWnZ4TzErckxSdUtIRXBX?=
 =?utf-8?B?cjF1b2tzdFFuQ1RrRWpJVk5HdUZLOXQyQ0t3OEp0eHdFMktuWURhb0N3cWtI?=
 =?utf-8?Q?TCcEWJ0uiD0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RVRSQW0yZzhGaXYwZzB6cnlWSVlZZHIxdnUvV0kzY29GSlRwVGxoZG03bVli?=
 =?utf-8?B?TGxqVW95TmtGci90dUlwQWx4aGlldHhxeHM1Uy9jRzFSNDJkR2VNT2x4MVFz?=
 =?utf-8?B?SXZIMmg4dER6VkFDQXJwUnI0b0QyOFR5UzJtVHFvenJwVkQwemhWbXVzcGky?=
 =?utf-8?B?RkFJV1MxSzlZRytrRFlRNjBXc3gyR0VZZXU0T2drOGZQQ04wRXBHVzVzVEFO?=
 =?utf-8?B?ZkFIVnpXcEkyejZSTzRIOTZSQlBjam5XTUlxTEpsZGw2MHpJblRsbnNOTEtL?=
 =?utf-8?B?b0pDc2FmdHdiQkFleVdBL21qR0lBeFI3Q21PWVVFQ1l4STc1amJWZEFmRTl2?=
 =?utf-8?B?U1JzLzBiR1dSaENIQkJIY0tPR0JlRmtGS0lnbURhUXg1WXhPTFVZMkpvOTds?=
 =?utf-8?B?VExTN3VJRXhjVlhPYXRaY0RmdkxCT0IwQ0k0YURWNmRlN1BxUTBxK2h2eVFT?=
 =?utf-8?B?Q2lNRGFCMVE3Z1ZOdXRWbzV4azlZK2lId3NmaWV3c1hkT3VUOUlMc0V3ajN4?=
 =?utf-8?B?VUZmUUFtaTBJWHZZaGxLdjkzbFdEQVZsUGx0dWdSQ2dwbXI4VXhqc0J6RXNI?=
 =?utf-8?B?cE0zQ0NTd2Rzdk1oTUtVd3dzbWFnb1dRYU9tamxVNzNib0RZVE5qa3orY2lH?=
 =?utf-8?B?RkdtQ1N5OTFDYW5jM25ycGFHeU9UUUNta09DSXBHcjZrbVdVR1dKUWR0cG55?=
 =?utf-8?B?U2M1dWxLcUZ0Y09oL3RBNjQ5RjVubFN0ZkRhck53LzdaeU04VW8xaGkzZGJ0?=
 =?utf-8?B?OHVJSkU3b3MrVHNVTTlWbkU1dU1PR2QzZjFCbzdabis4VTJNZXQrNU1PUU9p?=
 =?utf-8?B?b3MwY25xTFFLbXpKTkNhdy8zS3hxRGRlK0d3cmpuaXhENWdkcVNFbm50L3dV?=
 =?utf-8?B?b0IrNG82OUpMcWNXS1Q5VXMxM2oxcXoza1hoU2Y4d253VGg4VVJwR1pURFVU?=
 =?utf-8?B?blVYTlYvYXFFaERicG1DZENkTzVTQ1dJZ2RYZkFTbGthWkdLd0tOSTJGRUEy?=
 =?utf-8?B?bEVYSHVWOXFQdDZ6ZzdubTF1ZnVsZ3NLQ1Vkc1pQa0ZKb3RMRUhVZDc5Nnh2?=
 =?utf-8?B?R3hiZ3d6NVpkaW5kUjRYRGZjay9XRXBsVWYvd2cwNGY0ZEszN0l4TndXcGJ0?=
 =?utf-8?B?Y1NLL2wrZnR4R1VKVEllMEtxbXlwa2F6eWgvcFNiR1ZRbU91RUdoNmdaL1Zh?=
 =?utf-8?B?TzZrQno2L2NuR1poWTg1c2c5RXBFS2FWMU1CSkpyZTFseFQ2ZVhSREYrZ1c4?=
 =?utf-8?B?djFyallzdU5DTU40RDc0Mi9zSDRpd2pRdmU5cXltMnNHS0dTN0VjclBaMlBO?=
 =?utf-8?B?KzNPcHJSdVJ3ZG01bnoxV2RrYzZwbXhJMEdBanVQb0pRenQ3clBLOEZHaTlQ?=
 =?utf-8?B?SG1TQUJIVGJrK0xmdWNiQzRsOXpkendZSUZFSmNGbGd6aGFMczFJTGJSUlZ3?=
 =?utf-8?B?N1djNlV3b3E4MUxpMFBKNVZOcWpNckZvQWp5SVBrajBSTW83dW1ZVlhYeEc5?=
 =?utf-8?B?M1lxUGhwTkFReTV5d0dxbE1rc2U1YmUxNWJDU2x5dm5VeURFT2RwSG9kMkdU?=
 =?utf-8?B?SjRyamsrRTY1M0Vod0NBcDhTaVZMRmJ1QkRyeTE1Ukg2cEN5dWtTckxkbHVB?=
 =?utf-8?B?NUo5bUhkbUFHL2MvcHJyU1I2MkhCREg3eXVlNzNxQS82dHJRMXZCYWNHbWYz?=
 =?utf-8?B?NTM5eXNBQWwxMk96bW1NOERZYVRQUy8rZ2lDWFFBNlo2S0tEWFk2aWFvNlU5?=
 =?utf-8?B?OHBxeWsvV3ZUSEJURjVXZFJORitvTVhmTlhNYWJrTWRvczRUR010Q0VDeFF3?=
 =?utf-8?B?TzMxRm9ldkI5MlMzUE1pQ1N4dy9KOHAyWnNnZFFDdkdUSlI2Z0UycVRUNmdD?=
 =?utf-8?B?OUNPeWxMT0pyTEpEYkFRWVJUQ2h0VGVMZ0JZc25UaWx6MXpYU2paYTlTT2R2?=
 =?utf-8?B?QXZFUFJyM0EzUWxpQXdrZFZsY3lpZ3I3Y0dEaUVjanM1YkZXclRQWHRyUXlG?=
 =?utf-8?B?WXBkeGJwMEZkcng0MzJlNHkwSDA2S3lQaDBNVGVFbVQ5OEs2dmlORkxnVEJF?=
 =?utf-8?B?N3lOb01pZ053TGlsVDlSdDg1QzBZSzhyNHM3dmRWbHhPVXFHTVpoUk9NeHZY?=
 =?utf-8?Q?Y4xFZ/lHaDE1NeNXTUlto0s0F?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692c9403-e3d6-4860-042d-08ddb932e48a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 06:37:19.2380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xOsybYWhuLZuLTfHqg8NBM2ZGAoWOgCb6MimbMmj8a2YZwwVYVy1fVdUwg9apntbKnMeBDHYRvQN88NgOnv+HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8708
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 06:37:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19276

Hi all,

is that correct? At least we have no defconfig in cip-kernel-config for
6.12 + that target.

diff --git a/Kconfig b/Kconfig
index 582ceddc..e0788926 100644
--- a/Kconfig
+++ b/Kconfig
@@ -112,6 +112,7 @@ config KERNEL_6_1

 config KERNEL_6_12
 	bool "Kernel 6.12.x-cip"
+	depends on !TARGET_IWG20D

 endchoice


Jan

PS: defconfig for BBB is also missing in 6.12 - who want to forward port
that? Can do myself otherwise.

-- 
Siemens AG, Foundational Technologies
Linux Expert Center



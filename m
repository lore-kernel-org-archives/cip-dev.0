Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D38C36010
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 13:23:01 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.15])
 by mx.groups.io with SMTP id smtpd.web10.47349.1744032179029612086
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Apr 2025 06:22:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gp4Shfvx;
 spf=pass (domain: siemens.com, ip: 40.107.159.15, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiTU8v8uV3L3fo8J9MHZfoybOpa9as2MKWNJf7R4XDwOn2WlE4rTn9TSAjAM5rBZq6SZkHFSwzs04KHDFbbE/3YjUj6egV0GPtTNBOG+iFKT1eetZkexg6agf5On+jj1bI46+O0Hh/nlNE8Up9QkK4hKNNDE6pO4KS3s+lbXDwF+JTfOtQa0Y3RL0FlYGZkeR6Q7QGZG/A21G7sFHEPTFk3pT+vfaTizEjsPayLgiudLl56OFprTLxLDxUDIXx+RwsgYvwXdoAHtcmv9+DTFWhQtiQ1cSUnzsSuttk3iLp054my+DZu34g/ymmNbep72AsebCcvKBVXTU08ex9rQSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4KYT1/sXjQKIIhTErpa1qUUiKRKXiW6AaQ7uopXXJU=;
 b=vCysyrfSg/xL8bi3Voc8I0mYmF2ELq+GMURXQDekFWkr6X51ou19pkUEQXiNVO1tAwgvWZJpj+upsoKrfwuUe6mOUrC6Ucpw4PSQ10O2rwVJ8fdY6wDJIu7t+OH/EJ/6RPJ/3EhnuKSliYPKmLA7GNExrqgPWHIaKx96q1uN7djxTr7sHh5Yljhbe5qF4Wclt5ld+cVpMQOto9WOv3jHyZyGlUsMDoBf5PgRIFT9TeG7qLf1x9rwujseGEhErnO6QMxT1TWWKoMLe4ai45FqkkvARC1yoSdFpOPQ4XLndaQnXVjBy4S4WsZYefpFufJik3Tg/d+T+AgSDMHXz1LSNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4KYT1/sXjQKIIhTErpa1qUUiKRKXiW6AaQ7uopXXJU=;
 b=gp4ShfvxGPfZCzly+uug82MXtCP5REU5i/qOfGfIuINeJImew6/vZS15DgsH1OYmEYR52zyNOcnrvCKLRvEWXaKOZs9y1LwGU0OdQhPdnlSf36GD61muivek4Z/XbXTDTYb6N33/FQS9vhqd/LfifQDPQKvVcEd0jjBAfCOql/kPH3Op+Z9Hld2lGYq9wn8x7y+UJ0D0IJlJtOlCxvtmA9mKwOnDUXtGpGDSrdB/BY9o0u9pMz02A4WSbGJQZDqM69GpP2pR3dDroIqQEk+aP9Q4OI5bQpBVVO3/cUaFUyfUrqS7F3XJ/+5caVbf+ACoI0yRi2Dk1XmvOF/2eoIvoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7359.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:445::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 13:22:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 13:22:53 +0000
Message-ID: <e8179043-1293-4284-ba7d-d46aa1875bea@siemens.com>
Date: Mon, 7 Apr 2025 15:22:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 1/1] ebg-efi: add support to deploy
 additional files on boot partition
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, cedric.hombourger@siemens.com
References: <20250407130313.407117-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250407130313.407117-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ceb745f-5c94-423a-f24f-08dd75d74d40
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SkNOcjM5MjFOWUk5TzloUXkrK3d2UHhtTVRGRjMwVUVvNWliUkhhVXZrako2?=
 =?utf-8?B?b1piVTdaV25aWVRGSTNva3laODlqWDlGb1Z5bW8wRDI0bEdCa3VBbnhyZldZ?=
 =?utf-8?B?Y09hd1dhT0lQc1NiVjlZYXhwaEI3RG1SbFpwcmhBRkFJaHdsMmlqU2JEQkto?=
 =?utf-8?B?TGFKbHYzdVdHUFZFSG1OUFBlUmNPNk1URGQ0cDl3a3ZCVDU5SEZpc2Z2V3A4?=
 =?utf-8?B?L1d3QTR2NUI2NzVvVGdXcVIxMTFTczV4RTZnSjhQb3JML1V5VzZ2eVpLdmJz?=
 =?utf-8?B?MUY3SVdEVFR5dlNzSmFVcm9CdlUxK2JHajMrM0NEcEVBUVZJUm5pd1pzYnNq?=
 =?utf-8?B?N3l6MmkxVEtlY1puUzFIbjFtNmt5SjJoRGdZNWJ5NXViVFVaMXk2VzREUDF3?=
 =?utf-8?B?OXFsWkZHN2ZGdXluc1NIajBOTkFoVldkMVZib2grNFJlSlZtT3RQbTd6THFS?=
 =?utf-8?B?WXlnV2NvV0tKSHRjdlZaYXZOdklNK2pBb25EMHczK2xoS3IwaHZoSjVlbE80?=
 =?utf-8?B?Z2d4K1ZaSDBuTzNSMi96QnI4b25Od1FBSDVUVkFyU2dUZHRWS005a080WCs4?=
 =?utf-8?B?NDMwK2VVN3krdzEyRUtQYVZhOGlLN0hKaGlocks2bjVBWnh5WDNoVVpFbGhJ?=
 =?utf-8?B?U0NtbXllZC9TbUtxMW9HRWpMV1JabEJwazhFYjFpczBCZUZHSXVvQy9HT2Vs?=
 =?utf-8?B?SlNCck5nWS9QR1ZIMmZ0dHFaNHFlL0VCR2p4VG81QkovSzdhQU8rQ0h5R2RU?=
 =?utf-8?B?YmRndjRjVHh6R3FocktDWldxTjQ4MXk2RWUycWo2TnRwc1NXQno4d2Rxdjgw?=
 =?utf-8?B?VTh2QmNMWTZnMUltajFZMkovZlB1Z0JDcG5xZWZOZXlKdkczTW42RldxbFQx?=
 =?utf-8?B?QjV1WndQWFg4SGtlSE52clZnQUhMaGduK1ZXS2VtaHU1RjRXcExFQ29PSmpI?=
 =?utf-8?B?ajc5c3hXTGc0R1E1RWdoeERBeXFCdFRjL2I2d3lYVE9WSG83NHpjdVlXamZt?=
 =?utf-8?B?L2pSSXZKcVdTWE1rV09ZMlhOaWRERHpWWWtGOVR5czZWYXd6VnhIdW1WQXAr?=
 =?utf-8?B?K01OSldYU3ZVZHBjOWhYMjVxY2ZIWkxpWUdqQUp4T2w4ejJKdm96a3JWV2ww?=
 =?utf-8?B?d0VLUEhsbUJmbGc5OUdFaG1uMWpLTEdyRWJoWnRPVHZvdEJhcFVVbGhERllM?=
 =?utf-8?B?eGhoMFJXYnYrcDQ4VGNaL3NSeTFybW4rTkdDTjE3aXN4VVpUYkVORERhRC9u?=
 =?utf-8?B?cllZM0ljZ0prSGpEUVpzMENlYU9lTEprWXRsNTRUYzhneEtxQWMxZ0cvT0pS?=
 =?utf-8?B?VlFtRXNBTEp4Vnp6eDdHTHlESGdTZW10Y3hXNVlMc2pkaWV6ZXU5OTYvK01t?=
 =?utf-8?B?TnQ4MjhBNFdEQ1JMejlSS0hvSGdwcEJ0OW5RNEtuLzVhNEFJeTFYd3Q0Rnl2?=
 =?utf-8?B?TGVQK1pvcCtXUHE2VmY4N0RFR1p1NGxpTWJ4M1lyWVNTQmdnWTErelZ6VDd0?=
 =?utf-8?B?ajAzYTRvdVgrV0VQNVZRZ0ZnTXpyZWlBckVKdmY5SW1ZUUxZaGVWMWJNTGJo?=
 =?utf-8?B?eXF3ZTBWY0VhY1lIMndLTS9TMTdyN0JjOEFEaGNrcjNmVlFDb1lnanNXQlNG?=
 =?utf-8?B?bnM2TnlyUy8wRWxWenAvOGVScWl5MGYvZ3NPc0ZydGEyRlE3WkJpUnZ5d1hj?=
 =?utf-8?B?RHN2VSs2ZnJOUVBDbUtNU3NJanZqenRUZjR2QTJybFcrMWZZQUhnbVJDWkl0?=
 =?utf-8?B?b09BUUFuYXlIYkg0NVlDWUk4elJsNkFBUkVXTHdXNHNUd0FGa25LTWI5bGlI?=
 =?utf-8?B?Qk0zeGFhSEJDaW5jSEtRZi96ak0ySk0ydm5MU2k5K2ZacWQweUF1ZjFob0My?=
 =?utf-8?Q?2aPzUmLV+/f9K?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VEU5R25XbU9yWDhhSWFuOU1ZTnZlUTR2TW1FbGIzU254MUxzL0tmdVVKaFYr?=
 =?utf-8?B?NHlTSjFHbEJwczhvSWxXK2p4WVNsM2UxeEVwS094bnhBVnkxZWVnWUQ2ejRi?=
 =?utf-8?B?Q2gxWHFJd0xwNXFxaGh0Sms3OUFIOUE1Wlg0QzdFckpQeFdURm9jalMzS3E3?=
 =?utf-8?B?ejRJSXluSTRxSkVEK1hObTIzOHdwWWtRcGp2TW9qSndPY3o0eWpQTmxwY3J3?=
 =?utf-8?B?bjlndGlrV1F3a1Y0V0NRajMrQXpvbjQzVFRTV0hsVXRTVUFwb0NDRC9YM1hB?=
 =?utf-8?B?OGxDNWh5eTVOVkp2VTRiNnlHd01LTHlWK2Evc2xhZ2ZJSWx1azVTZGNkYUtr?=
 =?utf-8?B?eS8vaEJSeGV1QmRTTVprbitKT0QzNk84dFg2cW52bFBzbG5hRloyOUVvQ2ZW?=
 =?utf-8?B?UTNydXRCYnRrT2hMNWJ4L01MbjN3WnFOSkR4T2Z6Y1RoM1pNTXhPeWl3R0JL?=
 =?utf-8?B?bVdBK1ZESS9uOThQTnI4Ny96VlQxdW5qZFVkNVp4TC81NXU1ZjAvczV0K0l4?=
 =?utf-8?B?M1hLdDd3TGZHMzZKZ0JJMHNQQW1FZENXdDRDUmRTTUZvaGVnNXYycUFKZ1RK?=
 =?utf-8?B?UGk5Rk55NnV2aGZaTUg4bnpucU1xc1pMUFNtSjU1ZCt0bVMzUHFyOXRNdUtC?=
 =?utf-8?B?RkVscXRFelA4b2NESkZRelhuSXZDRVcybHJ1eXpVQ3F0M1RFU0lCendGeEI4?=
 =?utf-8?B?N0Z5MThTTjRQdTh4RldWSXU2cENrMkMrRVRZcUtDSm92ekxTRGp6UVpzOEox?=
 =?utf-8?B?Y1R5U0JMSlcvMmE4aC9UZXdwM0VYNnVNNmNiWm4zb01wZCtqMklCa095SXRy?=
 =?utf-8?B?bGVqaTBEcythcjJsckxMd3F3b25YNUQrQUt5Yzh4dmZqUC9kVTRYaEJJT0xS?=
 =?utf-8?B?dHpXY0FYQ2IrSjJIQmtvTWNMdzR6QVBJbmNtTGt2ZzdQOGRQaE5TRTZHK2Ju?=
 =?utf-8?B?SGMzTHFod1hyMXdtYk9wa3BZZ1VSS2JvN1NDaUEwWmhRcGJVQ28zVEkzOER3?=
 =?utf-8?B?YUVKbi9aRjkycmhiNUxpNUI4bVFGdCtQTWVzcmdhMkNaeng4YmVqUXpNVHgw?=
 =?utf-8?B?VGFJU0RjVTN1b3Z0UVVvajdnb0k0NFpaRGlXMUZubWpncitmdnphVEU4VmJT?=
 =?utf-8?B?UUZIK3YzM0RjMlJYaUROZjJEZGpTRFFiRXA1WWVnZEVqWVVqWEh3cEI2OXZI?=
 =?utf-8?B?WE9EYTIyRmsxV0w5bWNKR1FDcVFTYXdocUpiOEsxZ0NWZ3NPTUw5a0FQL0xZ?=
 =?utf-8?B?ajJ4bXdxOXljalVNY1Y2djhsZEtFaG5EUkN1NStlMW5HNXpvSlNtRzhBSzVL?=
 =?utf-8?B?NU13bFFUNG5vWDB2Y3pIM2U2bythZ1BrZkhvaGY2OTI4cVZldnMxRVFvOFNL?=
 =?utf-8?B?QmhycTRMT01DYldFOEFoYnB6cVR6QytaYVorN0Jvb2cvUW82eFdKU3o3djky?=
 =?utf-8?B?b2w5bzdVL2ZXQVYvQk9NNGg3WVE4RkI2cFdQMXpiN2RNKzc0MWNyNTgrWWE3?=
 =?utf-8?B?WFRoMWlaNjBPVjRoSmJ6MU5RU0xLdTNSOTdubGpFOFU1MFQvUndOY1JLbURG?=
 =?utf-8?B?OEloeE1PT1BqcTcwMTgzMEZUcVBsSFhxVUdNMFVhaGZ1cERRbHpMMzY0dEtv?=
 =?utf-8?B?REk0NnQwZEZYZFE5TGNFNWZDYkpDLzRDUVM5VXB5UzgzQVhKQStzdWt6NUZF?=
 =?utf-8?B?QmNYYWNXa3VET0NadTQ4SktjVUZCQVZXY2V2VnZSdVkxdXlnSW9ETFJwS2Vm?=
 =?utf-8?B?MHBDWUxCcEc2QjhpZm51cmlEV2VaUlJUOVJWNUYwUVJwMVhkRGdoaGVPQnVX?=
 =?utf-8?B?N2ZPeGVkMmxwZ0YySnJtU0hkazdtb0NEMEtqZkQ4ZkNoRHJiNkNHb2JHZUUw?=
 =?utf-8?B?ME9FbmJvK1pETytORFNGc1h3T0djdGorS2Q4VFB1UWpKaE9MRTJ1cExZaW03?=
 =?utf-8?B?bFdlWjE0MVY3anhHUnRYdEJZbUdreTZxRExEYXNJRE5ZbGk3bjZKN1hyNm1h?=
 =?utf-8?B?NEpmd2dNQWM5aDBIUi9VWmZIM0VRcWp4MVpWUUZrSkF0d01WOUI5dkM3NkZB?=
 =?utf-8?B?ZnlmRUpuOWZ5dU5lSWc3RjRpdjloM2gvUk9kWXd6MlJ0UUt5a1hJU1NHZFVk?=
 =?utf-8?B?dUNybXRtT2R6d0ZvSFJOQ1VQazZIWlRiUFc1Ny9IaStHVXgvS3R3akpYMXVY?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ceb745f-5c94-423a-f24f-08dd75d74d40
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:22:53.3060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyISwAVrDIdoVhLgu7zbjxrrmLwRf5hkjeXKGRKK5OABOmSd7QQ5LkWlpodav91HFk59OllM05yAY7k2KNa72g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7359
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Apr 2025 13:23:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18490

On 07.04.25 15:03, Felix Moessbauer wrote:
> Some embedded systems (like the RPi 4b) cannot directly boot EFI.
> Instead, they use a staged approach where a first stage loader then
> loads the EFI provider, which then boots the efi target. For that, both
> the first-stage loader, as well as additional config files need to be
> added to the initial boot partition.
> 
> The bootimg-efi-isar already supports this for both grub and
> systemd-boot by adding files to the IMAGE_EFI_BOOT_FILES bitbake
> variable. We now add the same support to the EBG wic plugin, by copying
> the code 1:1 to efibootguard-efi.py. We intentionally do not support
> the IMAGE_EFI_BOOT_FILES_* as these are neither documented, not exposed
> via the WIC_VARS.
> 
> Note, that by design these files are only copied to the ebg boot
> partition, but not to the A/B kernel partitions. While we are not yet
> EFI bootet, only a single partition is scanned by the firmware loader.
> Once we bootet EFI, there is no need for the additional files anymore.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
> Changes since v1:
> 
> - state why we don't support IMAGE_EFI_BOOT_FILES_* in commit message
> 
> No functional change otherwise.
> 
>  .../wic/plugins/source/efibootguard-efi.py    | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> index 48f7523..cce948e 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> @@ -29,9 +29,12 @@
>  
>  import logging
>  import os
> +import re
> +from glob import glob
>  
>  msger = logging.getLogger('wic')
>  
> +from wic import WicError
>  from wic.pluginbase import SourcePlugin
>  from wic.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
>  
> @@ -42,6 +45,51 @@ class EfibootguardEFIPlugin(SourcePlugin):
>  
>      name = 'efibootguard-efi'
>  
> +    @classmethod
> +    def _deploy_additional_boot_files(cls, boot_files, kernel_dir, part_rootfs_dir):
> +        # based on bootimg-efi-isar.py to get consistent behavior
> +        # list of tuples (src_name, dst_name)
> +        deploy_files = []
> +        for src_entry in re.findall(r'[\w;\-\./\*]+', boot_files):
> +            if ';' in src_entry:
> +                dst_entry = tuple(src_entry.split(';'))
> +                if not dst_entry[0] or not dst_entry[1]:
> +                    raise WicError('Malformed boot file entry: %s' % src_entry)
> +            else:
> +                dst_entry = (src_entry, src_entry)
> +
> +            msger.debug('Destination entry: %r', dst_entry)
> +            deploy_files.append(dst_entry)
> +
> +            install_task = []
> +            for deploy_entry in deploy_files:
> +                src, dst = deploy_entry
> +                if '*' in src:
> +                    # by default install files under their basename
> +                    entry_name_fn = os.path.basename
> +                    if dst != src:
> +                        # unless a target name was given, then treat name
> +                        # as a directory and append a basename
> +                        entry_name_fn = lambda name: \
> +                                        os.path.join(dst,
> +                                                     os.path.basename(name))
> +
> +                    srcs = glob(os.path.join(kernel_dir, src))
> +
> +                    msger.debug('Globbed sources: %s', ', '.join(srcs))
> +                    for entry in srcs:
> +                        src = os.path.relpath(entry, kernel_dir)
> +                        entry_dst_name = entry_name_fn(entry)
> +                        install_task.append((src, entry_dst_name))
> +                else:
> +                    install_task.append((src, dst))
> +
> +            for src_path, dst_path in install_task:
> +                install_cmd = "install -m 0644 -D %s %s" \
> +                              % (os.path.join(kernel_dir, src_path),
> +                                 os.path.join(part_rootfs_dir, dst_path))
> +                exec_cmd(install_cmd)
> +
>      @classmethod
>      def do_prepare_partition(cls, part, source_params, creator, cr_workdir,
>                               oe_builddir, deploy_dir, kernel_dir,
> @@ -100,6 +148,10 @@ class EfibootguardEFIPlugin(SourcePlugin):
>                                                 name)
>          exec_cmd(cp_to_deploy_cmd, True)
>  
> +        boot_files = get_bitbake_var("IMAGE_EFI_BOOT_FILES")
> +        if boot_files:
> +            cls._deploy_additional_boot_files(boot_files, kernel_dir, part_rootfs_dir)
> +
>          efi_part_image = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
>          part.prepare_rootfs_msdos(efi_part_image, cr_workdir, oe_builddir,
>                                    part_rootfs_dir, native_sysroot, None)

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


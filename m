Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119FACA0EE9
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 16:24:39 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.47])
 by mx.groups.io with SMTP id smtpd.web11.79951.1755534275263716197
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Aug 2025 09:24:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=G0cn2Hzl;
 spf=pass (domain: siemens.com, ip: 40.107.162.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnKjQf2XepFRrhgWSTqSA9pZmu6llJUwHJMHkgHURrDJac8bkkJ1RYgkQBTE4TjVmK9tZQhQKi7XyxW78LMRgz5hYP7K7qRBZKE7PH7SGp+HXMCS/seISZCDfGuPy+C1KWrbgACUqIIzTfC28veAi/stZQ1rm8vmS4KcXN7wbdl48L1oniNLR58sjwuPOcSj+fH97fDBXcJRej2p886zWNF6AIyU6G9CcA3BZBeyW2mOTzkLVWvjkqqyPLwa2WAufoVfW3wgqU+D/aW3D0m8+682Q9QkCmLI//whf28UWOLGHOz8M6axAC1klZrT/J9/tJvUXDnqn589tjiu77plLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzLW5j6kW3OFjj4EAaf5Jvj24qQsdsRXgz4G/ZMtYxo=;
 b=D9V/C+SMEHkp4iRV8+Gk+HfkIbRQ2cRTnfWMSFDawqC0x74yj3Ddwit8jWkZYFF4UyyXwGlHH6JfAdZhC5aovdZkf+UrCvljPiVaVz/KK3CBBpEOZecE+bVKIgs1pTJd0kPv4TzaUiURYFU8yCvLUWovyIQHorODMl5Kj+/6CaQuLm4jd/QI6W+Vw4MnSSaqWwZbu5qvDtneBkBLPRZ3DjqNvvWKlpl8jQ9cJFWRG7UbggxxSEUE4GXms8A9V1/u9Xpe3Ku8YEda2Az6WDjBoIzOHVL9j9OG0yvokY72QaroZaLD0dZR+rgRvehgKKkE64Jmrrt2q1GkAs1VhnrRXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzLW5j6kW3OFjj4EAaf5Jvj24qQsdsRXgz4G/ZMtYxo=;
 b=G0cn2Hzln/w6h746rYmkTQsVlm2Ie2ZUQdzF9gpPTJlRtU0Jqm9Ke3ydUgrbbHvhezeJ3EzQseeVsgMkvVb7Fi5TIT7d90FsnLo1ykBV2d2r6KsVGOQ4Pzr75GoEDE3vutV1W8KR2I5hpt/XkmYO99NXxE+vV3YBCQC2VGyZabbHvG0lY3LvD8/ViNND0J9MdnBbaQOgeJVORnkRXpf91bzg8NFBqym7c/UZGzZZiewbYFluLdmOLMne49NzfTOIfvMKx9oW0HBFY2bZ7bfeTmQothoa42qidrm3k/mrWbnIhjCeU4esVQ4FwBqURp8+Ljbr9B8rJFt8twLQaizZIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA3PR10MB9270.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 16:24:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 16:24:32 +0000
Message-ID: <c5172a2c-e796-4feb-876e-3be02e8e89d8@siemens.com>
Date: Mon, 18 Aug 2025 18:24:30 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] u-boot: Use hush shell in secure boot mode
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA3PR10MB9270:EE_
X-MS-Office365-Filtering-Correlation-Id: 3800dfe9-7098-41c0-fa2b-08ddde73b681
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OERUMHdYQzRtdGJneHRnaGFsaVcxQkZ5LzdYUnlsMFZlc3REbnZwTWpXNXgx?=
 =?utf-8?B?eFNBaGF0a0ZEZG91RXhTZVBVWngyNlV3cGRveFdlTzFPbnpQbENqQnpZRjd3?=
 =?utf-8?B?SkdsTVBLblJqN0pnYzEwN1FJeXpWZHR3VkRoeXlLbUxxTFNGWWFWd0Z5MHl0?=
 =?utf-8?B?ejJPcGx0MUNRUFh1SXF0Vkpha1JiRHMvNkdrV1B3YnhZdkVqQ0xHNDBiTlJ2?=
 =?utf-8?B?cFdEekY1QlJsSzZPcHBHSzk4aHdhNHpFVzFoWjd2eXRITGNqSVJZZGZEYUxp?=
 =?utf-8?B?UkRGQVBhdEJGMmxyNndXSEE0RU5VdUVEZFhGNnFUcnRpK3hVT1NjU2xQYzcy?=
 =?utf-8?B?RVVSaGhJTTdpa1pNQzNjMFc1RXJXQSsvYzBoS0FTV1ppdGExNDFQZlF5RU5E?=
 =?utf-8?B?SXM1aThZa1ZuZWVOZnVVb3AvdzNJWkdINTlWQTQydm5QWHhZSDlmQWIyRlFm?=
 =?utf-8?B?MHE0NjFDUjJjSlIxL0xxK3lpcWFSdUxHUzV5eEdOQWIxdkMzQVRtcEJqUm5F?=
 =?utf-8?B?VG9OYTJtR2pMdHBhOHkxWmU3c1FxVHRsSVRydzlOK2RoWVhGU0JVZFNZOFVj?=
 =?utf-8?B?T1htTUZSeWwyS05LWnFnRitvS2lQaFJvK25HaVUvbTZkeGZQSlVrYVZTTndj?=
 =?utf-8?B?QUtSclNFdkJxMFBRait6T0x6OHB3ek9xd0lBT1dibTloS0xvZmNWc3lYMWdP?=
 =?utf-8?B?ek5jRWZpYU1Xck9QSlZQT0NZcytzSmlLdXJ4YmlNUlgwWFc1Smtrd3RNMElo?=
 =?utf-8?B?ZG5xVlBzYWtaeWpFRVRpZlZWY21JVzZJbEF5RUNENnJsUVQrWnZtZ0gvYXNs?=
 =?utf-8?B?NHlVY1JFU3htUnpPM3pKd1pMQnMwN3lJQ242d28wK2wvRW5TTWxrYS8xQlRV?=
 =?utf-8?B?ZUswOVJFUzdKdS94TGtkclg1cDJEZjdUZGN2MXJPdVlscy8yV2tIZXM3NWJT?=
 =?utf-8?B?YldhVTdObS8rYm5CZ0tPVERlbVRneTVQVy9KeTF4Q2N6ancrM2lGd21oaDFr?=
 =?utf-8?B?dFBtT3FiVUhXQTdRTE1mMnFTbDlBSHk1V3FaUldXd0ZRMkZUWFJxUjlCWDN5?=
 =?utf-8?B?WG1RUlM1ejdhSFEyV09qQ0VRakFLWVFKMVdTUEw4azVhODZMQjhsSmtRREtp?=
 =?utf-8?B?ZDkvY045OFhqMEk5TkpPZTBOK2paMmFTMW92RmNaK3gwdjZ1dzNMZ2pVYjdE?=
 =?utf-8?B?UG9NSkI2TjFFNGFrUXE2T1lyTnkxYWdFSk02NVBtTVV5R2RVdEZVZ0h5bUc2?=
 =?utf-8?B?Sm91YU5GcGdtajBRZTZhcmhtVTUxeEJpenhvclBjaVhRK2ZMWGNtOTR5c1hK?=
 =?utf-8?B?ZjZMQndCcW1ET0FneGUwVUNKUDhCNlVDaFdpTnZ5UWNHKzFacE1ocUlNOTRH?=
 =?utf-8?B?Tkp2VEtIRWFjYzU1QnhhS0I4ZXJMbHl5QmdVOGhCOGtXZ1hTTWJrWnF3QXVR?=
 =?utf-8?B?ZU85K0Znakx2eVdBZzdVK0IwdVI4bGh3OW9pUTVnbmhGZ3NRQXZ3MCs5WHpE?=
 =?utf-8?B?blh0aHgrT1hZUDhWTTg4VHRSbGVkQVRvUzdsTVMrS05MaEJlcGNsaXJBbGpH?=
 =?utf-8?B?N01PczIyTlhQOGhkanJUVW4za3JtY3VjWGJqZWU0YVFKQWUwV1V4TW8yM2E1?=
 =?utf-8?B?Yi9YeWwvTGJ3bXBHaGJ3d25QYmpmU0JrSTEwVG1kRXN4U2MySDVNaEp3QzJx?=
 =?utf-8?B?VEZ3bDZ6cHZHWDZFSFVDQmhSemJRSytFRmJQa2d3bXpmNDZZc0xZQkpyY1Nv?=
 =?utf-8?B?NVNkdWRaSVQ2NVNMSlVSdTZEUk1EZjd1c1F6RnZzQ1BwaHcwMk9vcGkrcUt3?=
 =?utf-8?B?UW1zeW1JMFBGbTdtQkZ4Mis0dFBGWG5UeVQzdGhEd0JjMHBDcG5xZlh0ZERG?=
 =?utf-8?B?UWEwM2Q0eG56aG5JUkhMa1J0M20wS3haVVI0WlZzSHAyaGFTenVoTFNlWlhD?=
 =?utf-8?Q?vNEQv7k0wS0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?azhPeFoyOEF2V3VKcXVKYndJOHBKeFpHMy9IbEt0c3Z0ZnpnMGFmaFJxelBh?=
 =?utf-8?B?aGlMK1Y1RGJkNDNvVGJaaGhlMDMwUnRXRnh1Z0dLTjY0enQ2NFJ3dUY3R1ZP?=
 =?utf-8?B?RC9rdVpLc0VIMUpHMGxBR09hSGFFVVhqbkZucG5GS00zM1NvTXpKTnRFdGZl?=
 =?utf-8?B?Z2Fkd1phaGdndXhhRTliczU5dGh4dm9XNzJLd0xoME5wSXhnQUI1U1lmTGZt?=
 =?utf-8?B?SWNkOEVzV1Fic0d2UWFheDYyUHB3dlR5anl5TVpPWHdrVWF0SFlBMlVDV2l4?=
 =?utf-8?B?a1I0ZTRZNm5YOS8va3Ayb2V2NExuS085TXdGemtmSEErYlhna0FKSE5uVzVY?=
 =?utf-8?B?U1V0NDEyeWZMWXMvRlZZQlV3ZG50dkZHMXpoQkJyQnc2bXRFYWcrc25MWDN1?=
 =?utf-8?B?WXRvVVg0VTZNajNHOW16UnkyWEMyNTUvL0lsNFBJZ29LTFhDZWN4cUpYV1E5?=
 =?utf-8?B?TnJpTTg4SG1iaStHQXZpT1BhNDgrRzlmYkVNVHRWMTE5U2xpbHEydm5tb3hr?=
 =?utf-8?B?RGpCTEFzdVo2SktRT3UrbU9iWk5PZEJYZ1JLbmNZQmdUVitwZm5DelZLQlcz?=
 =?utf-8?B?ZmswZU1tZ29yU0plUHVzRVRSK1VWek9JK1I0YW9NcUExOHZDMkJqaWJNZVFv?=
 =?utf-8?B?SDRRZm5HQW9JYURERXZ0MHdHV2dVOUxrQ3QvWVRHUVNtcy9BVmRaZ3J5ZG8w?=
 =?utf-8?B?cEtZdkg0Sm4rUndtaEZJalRWSWtWd1dYQWdDYjZiczFlR0kveVBranpvUW5N?=
 =?utf-8?B?aUprMFBESFhEL3V4OUhnKzRlb0xuOHdKYVRlUGx6RDRXWWd2RHJ6YUVxcWNY?=
 =?utf-8?B?ZlA0T1pmMmdaTjVqM0wxY0VTcEhFdEZrK0xrZHlEbWt6eFJ1eEVZMlVCSkxh?=
 =?utf-8?B?QlhSL3pOT1ZwbWN0R3BpU0VQS21CNE13eVlsR0w4TGRZeWVqZk9MVURlczF0?=
 =?utf-8?B?dk1HZnllVzdlOG9aeXZkZlhFNWM5dHE1UVViS0h5bytHOE9tSUE2WC8xWGw4?=
 =?utf-8?B?c2dieFBMV3VTVlZ6TGE1eVpwbHZldm12M0ZBbXYrRjEyd1ZXcVBvbTYrTzhE?=
 =?utf-8?B?RjdFUWhJY24zQzR6TFBFTXpobm45OTlvWXdLWGFlb011VGFUZlA4TlZSMWVW?=
 =?utf-8?B?YnZXOVlPYWoyeW5FSVBlNVh6WGkrczZub1NaeVEySlE0Mk9pUHBteGw3NGJO?=
 =?utf-8?B?aUpQbi93ajJ3ZGZFVjRKb3JreDg1UERVSVFLVmh3NmdzQkVIbEdLbTR1bDRV?=
 =?utf-8?B?ZnV5QnMyRTlvSnlxNElxMjNCOGNFbjd3NFlKUVVBVHZUbm5zWXBMRWFuaEZq?=
 =?utf-8?B?TXVIOHhNSkt6Nzg2SFNPemZyUnM1V3ViRG00OUdiblUrR3ZFYVdDd25OQzFv?=
 =?utf-8?B?SitVN1NDUGVlR0JCWlNScDVCL3dmbVE1V2pqMFVvQnlOZ2hZZ3pObXFnN2l1?=
 =?utf-8?B?TW1yM2FHM01Iem9DeTBNRW5BeUkvamo3NW9HYmhnRThRTWVhazl6NUZXR2cw?=
 =?utf-8?B?NTU5UDJYcCt3WUpMbzdnd2hvbXVtMkFtZUthRUNTc1dVYmFOSTdzenF5d3dU?=
 =?utf-8?B?WnRJNW5oZVVvYUxIb3o5aHJGa2k5ME9rYnFrL1NhZFZONmJhUU55M2ptSWZV?=
 =?utf-8?B?Rm9WRUJNdTY2L2ZHZU95ZUF4SUJ2WWgyalJJakJxblBlSC9aL1ZIcHpFdU1l?=
 =?utf-8?B?cDJ5M0tnODU3RlNDdnEwRWRIL2FNUFZCZTNieDlhWDFReUgzT3hCS0wrUFY5?=
 =?utf-8?B?SDBZZ2lWaVBnSGUwd0YyWVQwTVhJRVFTOU8ya1ZxeVJaOUtwNzJibnJkMHZ6?=
 =?utf-8?B?VkZmdHpPN3cwcmtQa1puaEpVMFcvL0JkMVRlSDFEOW9ZejMwR2VYMXdlZ05X?=
 =?utf-8?B?SzJGVWllRlRHNXpNOEw5bG8xc250VXQ5Rk5wdGw4TW1ucHlDQkd6bWRKU0Rt?=
 =?utf-8?B?Y0hKU0tRcGVaNFVJUEpWM1hVcHNnSVo3YTNqVTRYVDN6N05ROWNWK21wUEQ1?=
 =?utf-8?B?R2s1MG15VWZub1BMbmQ2aXVNU3A3Zk5UZ0FhRlBaTkMwVmRBRmttVnZCSU5y?=
 =?utf-8?B?VGtJdEJKSGVpem9YaVNNOE5PZndEVU9URzErY3J5clBJOG5BamQ4VDE3YU5j?=
 =?utf-8?Q?eFxhGCiIxFKRvzSWRmdFsM5+F?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3800dfe9-7098-41c0-fa2b-08ddde73b681
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 16:24:32.2894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwDbbo6qN2cmOl9qCpqDa66k0X4gHKAiqTj6QEHWKhHh3W5WOUbeSBBHLTSXNipJ76Hazs/E0chNB+fk1EEMCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9270
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Aug 2025 16:24:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19760

From: Jan Kiszka <jan.kiszka@siemens.com>

While we are not providing ready-to-use U-Boot configurations here,
rather test setups, it would still be bad style to paper over this:

Only with the hush shell, it is not possible to gain a prompt by
interrupting the sleep after an unsuccessful boot. May also apply to
other commands.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/u-boot/files/secure-boot.cfg | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg b/recipes-bsp/u-boot/files/secure-boot.cfg
index 95371626..76ede89b 100644
--- a/recipes-bsp/u-boot/files/secure-boot.cfg
+++ b/recipes-bsp/u-boot/files/secure-boot.cfg
@@ -8,6 +8,7 @@
 CONFIG_BOOTDELAY=-2
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="bootflow scan -lb; echo 'EFI Boot failed!'; sleep 1000; reset"
+CONFIG_HUSH_PARSER=y
 CONFIG_USB_STORAGE=y
 CONFIG_EFI_PARTITION=y
 CONFIG_FS_FAT=y
-- 
2.43.0


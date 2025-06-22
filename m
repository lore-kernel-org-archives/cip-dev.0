Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50086C7115A
	for <webhook@archiver.kernel.org>; Sun, 22 Jun 2025 18:51:53 +0000 (UTC)
Received: from AS8PR03CU001.outbound.protection.outlook.com (AS8PR03CU001.outbound.protection.outlook.com [52.101.71.48])
 by mx.groups.io with SMTP id smtpd.web10.2781.1750618310678977617
 for <cip-dev@lists.cip-project.org>;
 Sun, 22 Jun 2025 11:51:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ELVHMxyA;
 spf=pass (domain: siemens.com, ip: 52.101.71.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDPfu4KVLUepeclmWZZrJ07TQWbDLDtsvfH/y+C6vQtnqppy9hL/uVQ7OGkmMKJc7Ql8WE+09/Ce6PjxHGP27Bn55IGBQDfecHst5xVMIXlj/Q6F8O9f4uQzJhPFFX6EhM7uCTZQoHfLVS5og3e5fl4i6n370eF7zf3upIwXpL4ky8L/Ku77QL0QFN5ikDgPmaH8CmiTNkEEj/kVlEr4JC/EwhcduYvW45ZYwMxJftBykokD365/AO49ZdOk1bDb/xNjbFSZNQ1c5zul4Z8uxydHF5ZgF/zjDTFppKynz4A7OA1bzyk1tiCgeRku43vCLvRYQ98cwPZcLyRlmNNw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66+6azXKs9EwsFrbNoGMWFdZI8Nzv2UjhLAEszXpwwk=;
 b=I/G9wkAQRTyQB7r3BCpOwyQivLLd+BumHu2knq8ZVyNMkqQCa+TkX8e90jXvEiqGEfhXIx7H4B15m9M297V98QRcoObX9P9aCL056MplIzjWQrisZscXOYnbLmMm08s7r17uRKK3nwXsvxHCvHbjSBRwngCiE/CMUib0IdvBep4PyTDHTt6o/PpeEw6JWGsguqOaNVkvl0RLWSQ/A6tU4V/p956pLiajWiqjPrXoyDi4u1FZJTWStW86Wz1JqSgLUuBCC73rL3MjiaKONE4oQAtDBcu2o/aohkzBzIecUarghmwpmnRGHrh2G7RlIA1J/T6wjfuz9J+/D+iEMnhrVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66+6azXKs9EwsFrbNoGMWFdZI8Nzv2UjhLAEszXpwwk=;
 b=ELVHMxyAx1K7Sbia58P8N90FtGhBt5R6+oqPbsuIB0//ECLFGPHmcXDRKaAI9ft7Bhq+LL0B5wWNGhcyXo0iFGuIJBijI8rMGrWR9bXPa9LqhdaF9U/4l1KMvICDlDnjwAOuF/bnvYeyy89AdXW7dqyzTQIxdO9iuKvnYzAxbQlSzhHLVAe5yLsuC9wA4dGyYOgzGEruIZsWVxa/OffKLoj/VBzUsFCGuT27k2yYJoc9sppetVvbQBEmS3AaCdHKQVvLGeeajNos5bksl/IG8athSY140a9frLcIaBHpxk9SLM4D9WxkrWllGc8oRT56jXMhFZx5Sc8gENudAZnBaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7864.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:490::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Sun, 22 Jun
 2025 18:51:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8857.025; Sun, 22 Jun 2025
 18:51:47 +0000
Message-ID: <61bd7c9a-b18e-44db-ac28-fb10941ed141@siemens.com>
Date: Sun, 22 Jun 2025 20:51:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Troubles with isar build for bbb
To: Nikola Trifunovic <nikola@trifunovic.at>, cip-dev@lists.cip-project.org
References: <c8233945-77ac-4a82-8016-f67a79054849@trifunovic.at>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <c8233945-77ac-4a82-8016-f67a79054849@trifunovic.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 5211c089-6416-433b-0a3a-08ddb1bdd71e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OTRTcFY0TXB6T1FzR0M4T1pMQWVGVTZObXY0YXlPQ2RTSXVzazlDMUxnbWxZ?=
 =?utf-8?B?VjNsbGp5NTg2ZHpOM1h6elM3YXR0aXp4K2xTMWNKaTZOY1Z4NW1BVE9FODFV?=
 =?utf-8?B?eDFOUUpHajdqYkRETC8vNDQ5TFdVSWV0djJaZGRZakZjWjI0aGlnRTBzcTRC?=
 =?utf-8?B?M1BFcGJpSGhtU3N2UGFjVVE4SlVmOGRSakhSbzZVSFZWVGlWdW12ZVNrMHo5?=
 =?utf-8?B?emk3OTJEN1d2U2gvM1ErZ3FhbHZXWEV0aTVRQm16cFBzcGFnTXdrTjU2Qlho?=
 =?utf-8?B?cVppSlI3OE9FTjNjZkpBTUY2em5KdWhkV2pGQlFTempzTDMwQmpIYk1oQU1v?=
 =?utf-8?B?aXJ3YkRPUmtTOHBhTXpDSzU5MGlhb2p3Nkl2bnhFR04yM3FtUjg2TUZaZ21P?=
 =?utf-8?B?UlhqOVdCeE5pdk8rOElQNGg1VDhBOXlLSkFZaEVoOE1MVjlGOXVFamlzSEln?=
 =?utf-8?B?UjB2UE1aRkZweUxheGtLdzJsSk5LOElEaXVpYnlnQmI5K2ZkbjdwUFFoODlu?=
 =?utf-8?B?RGVCRHRaM3V1VmFjdy83NkpjV1FjcHVXSjl4ZFg2SzR4WGRjcWcyMHVZOXpI?=
 =?utf-8?B?U0NwV0U4a3h0ZjhoamhQWjdmajVsSDhhd1dzRkxPbGlsQ0VFV1UzVG41aSty?=
 =?utf-8?B?R3h6UkFBalFUcWpqMVlFeHQ2a2NrQlJJRUJiTnhOb3VKWFRwOWdaOHUvZ1Vw?=
 =?utf-8?B?aWFwQmRiRnJBN1g5RmlXTXNMWkNkTE9DUzZtdy9JV3l3V3B4ZEZ4b1JIWHhP?=
 =?utf-8?B?c2oxL3ZpSktXL2hCRjdPUVZhcysreFhGa2EyclhrOFhxamRZQkVJZWNTVGRP?=
 =?utf-8?B?ZlN4T0NPZDZidFZCaW81dVl2Z1NXK3A5U1g0ZVdmYkFHT3ZlUDJZWUtNM2tx?=
 =?utf-8?B?TGlnWUp0NTdmK08yZ1lpWWxqRm5GdkF5SGNlbElwT2IwRElDRXZkRGNYcG5D?=
 =?utf-8?B?Q0FwRkZaRzFuaUM5c21oMk9XZHQrRWpkTmxiTmpkcFFLUW1XeGIyK01yQWtH?=
 =?utf-8?B?Y1Z2YmNDZ3BlY01pYmQ5T1dGR3BXczA1NTVWcVo4dFVkQUJ5TEI4T000cE9u?=
 =?utf-8?B?MGd1TDZrTkE2c3RsdWRoVURLWThKRXRUNTlTcVljaEtYODdjN1NWWCt4NlFk?=
 =?utf-8?B?c1JzOHlhekVJRk5LanhZYllPNVh2VENXeHdmWjE2a2VSL2Z4TFpGQ2xKWVVI?=
 =?utf-8?B?K2pnQXhVeTBEeUlHOE5DZEhaMmViVmhNS0xrU05SaThLWlpWT0Z3Vi81d3FQ?=
 =?utf-8?B?ZXA1cGRGdk45QUhSSlFkenN3ZnNQWUphV0dpYzBHRXZrUjFRRTJSV1VFS09D?=
 =?utf-8?B?eUo5RmZlNjZPbzBVTk9UMitUZGU0dG05ZkR2d1ViU09FTmk2Y1E0UTltdEVZ?=
 =?utf-8?B?d0d2dHV6dHFKdGtqUWJnaktZV3pJM3ZhVC90L2xNdXRJOXpVQ0doa2JPbWo1?=
 =?utf-8?B?SWRlOUwyOFNMK3RCSGtWZU5tLzBLV3VuVXU0QzFFaUdOVUFOME9OTFZtRk0w?=
 =?utf-8?B?LzJYaHUzbUZuRkkwT0psSWh5a1ZhV1dlZW1DVHVyV1JxOGhTNFFuNGZrMWI0?=
 =?utf-8?B?TWlVZGpHSUs2UmxHc09GSjMvMXFoYXFyclRaZzRveitpamNzUVpBcVlpd0dZ?=
 =?utf-8?B?em5icXE2RjZxZEV1ZU11OVJQK0JvZWJlaEdBOXFRa01nZzZPS01wcWpNTGE0?=
 =?utf-8?B?dmdya2JkdFZNV2Q5TTRaQjdNOVYzL0VDWTNvZVdQRzZPajZxNnVTbjlSa3Jl?=
 =?utf-8?B?SWhHQ0xsYS9UWmdQNVQzMVZ2c2hITXpDVzFYUTRZVW96UUhpU3ZPMktobFA5?=
 =?utf-8?B?VSs3WWwyMFV4YVVkTnFITHNnbnRkdnV3YVN5Sm9FM2x1OGo1NVJ5aFc1ZGgx?=
 =?utf-8?B?R2JUNVZYK1p0OGJIRkgvZnFiT2ZhekNUejJKMW1HN3VBaUE5YTEzVTM4REhj?=
 =?utf-8?Q?yAxpR/QXiyk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N09UMWFzWTQrT0tDK0lqamJUNVdDUythQldERVFKcVJ0OVJuK1ljRXRESzFI?=
 =?utf-8?B?K2o1Ym0rZjlZVDNxWGY5ZlNnK2k0RFlQc05FMVZCcERXQ2gxYjIxQThrZjl5?=
 =?utf-8?B?b3lzSkJkTEhLODY4SnV3NGpVVjcyV01pbDExcE5VZTFqWnZUVmZlRXZ2REgy?=
 =?utf-8?B?MkNBNXBTc1VicDY1SG5nc2QreVNUR08yV3RYK2J6aGNBaE5SQitiSVN6Q2pS?=
 =?utf-8?B?djZXWGJjMzVGOXNKa0NTbjNGV0gzcmovd05JdlJIN3o0WC9NL3dsa3dmSHRH?=
 =?utf-8?B?ZHUrcXFVZGI4bVVyUDlQUFA4WVFWaEd2RUIxblU1MHRnTldtVUxKakt5V2Fu?=
 =?utf-8?B?RFlBeUFUekIxT0xwTWhOTzFKdjNJdXpLQ1VPbFlscUptZnR2ZUhLYWpyVG8y?=
 =?utf-8?B?aXYvSkcySDY0WWxsNUZqLzRuWWNNZzd6TVBqZXU5bnVnSFJwMWRQUXRJdEVG?=
 =?utf-8?B?Sm9rSW90cHZPcWNNSHNFN24rTlIxRDNXZ3dNYVF3ODE5VkZXSy9maW5OWTBw?=
 =?utf-8?B?MmNiTGh2R0E4dzI3VG5IaUEyeXVKaFEzMmM1KzlhRlNCcDc2cWREZVRyWVBU?=
 =?utf-8?B?Unp0bithS3JXS2xEL2J1Q0piTzVJWjY1NkxIWHc5YXVLRjJ4ZmxNeFJqWGl6?=
 =?utf-8?B?MStMWkx4eUVBcmF4bDkwOWp3U1lld2RMUnFSOTcvZm94V1ZGT0ZLTXNJMUs2?=
 =?utf-8?B?UWVDdnNlaitFMTZBNGhjOU53VzlPTXcyalgyMkhkbDFvbDd3TVREcFZJelVD?=
 =?utf-8?B?NFdHeVVCT3BrbjFUNU1wNFV1VTlXUmJ6YmVVbm5wVkhXSEdEQlBUOUlPTy9i?=
 =?utf-8?B?endmZ2hCNEJCdnUxd0VqQktZV2tHKzJkYmtoT1pTdVQwNCtrNGpMeE4zUzBi?=
 =?utf-8?B?dzFmWEE3bWEvaFQzcUhXdG1raFNJZlJhZFdSMWxJZWhGOGFyMGpiNlpUZG1B?=
 =?utf-8?B?cE1BazhSVEdoMjMzbTA0dHdLbEVFWFdSOFQ2WHZBSithL2hvOUpXT2NYMHdu?=
 =?utf-8?B?cCt1T2ljTUIvb1pGbW5RbkxZZzhqRzgrNENuVlJqUXpPTk9kbzk2UXJCSTNE?=
 =?utf-8?B?NmltM29kVmRRNjBaN1RTRXdrcitpTkhJN3F6UU44SDNBQjFEbUh5WEJBZ2hP?=
 =?utf-8?B?UEkzdXAzakFpT3VLbHF2RVBOWXlrakRwbERaa1NodHJIeXl1SWRpV1JoRW1W?=
 =?utf-8?B?czR4WFZJRldLd04vVlZQM1VrUHMrRDRqcEJ4dlBoZE9NNFRUVFdnVFVJWGZJ?=
 =?utf-8?B?UVQ5cEg1NCtnZ1RzeGNidUVreDgxOUE5Vm5UVGtWVkhhUkxCdzFaNnBheVBP?=
 =?utf-8?B?dWdybnh0VGwxOC9yOHd1YUgwbG5NT3UxSWdIS0Qrclp6NXJ2WGZZbDd3MnpV?=
 =?utf-8?B?cUF1akJTSGkvVndIb3Rja0dnQ3lZVmc1NXBjN1d2bGQwYUtRZXBuNk5TL05I?=
 =?utf-8?B?L1N6bTFwMExML3dxNmFPRjVmRHMzQ2NtRHFwREZ0bjFRakl3VXNrOWY3SUtr?=
 =?utf-8?B?d1NZb0Nwb2lYS1Z1cEFSMFd5Rm50NXdBRmdMelBqaXNWTEx6R2xsaUc4MDRw?=
 =?utf-8?B?VjN5blZJWVlmakRQaFROVUZldldBK3NNQ1JseUJZZXcxOFlXNGVrK3VCTlJm?=
 =?utf-8?B?b0wwd3RldzlKS3R6M2w1OVpMVDE2YzNkcCsrQ3E3V0oyWVkxeUw5UjVuSlZP?=
 =?utf-8?B?WEZKYXRPeFl6Rmx5SDB0dU9weThYTDI2T25WTlhXdDlhYnJXc05LUjRxeERy?=
 =?utf-8?B?Y2tXMXA0bElsZmFyS3ZjaVpqSEFWYmVIOE1JL09rNkhRdkRhbFJsSFRzUHND?=
 =?utf-8?B?OWgyRkFNZm5QeGphMHpqMGNTV1YxZGlxZDQrRlNpazN3TUU0cXRCZkJVNW5L?=
 =?utf-8?B?VmVtWFZ0QzV3TTFoeUpmZ3VsQVdXeGpGU1JrUTdHM1ZlOUNSYy9qYkFuKzFy?=
 =?utf-8?B?Y0RMTis4bVNzK0wwRkFqY3RUYWJ4TTdWV3ZtS0Q2b2c1VVBweTgzSDR5WTlU?=
 =?utf-8?B?WlBBTnV1MXRkd2IxZkVyZEtZV0JjOC8vcjFnU3BNeXNmOGlRRzZCMDlKVy9x?=
 =?utf-8?B?SlZQQjZ5M1RTUUJhT2I2bXF0U0hmVWZTQU5UbEJmT1IyQlR3Q1RxOEpDeVQx?=
 =?utf-8?Q?NQcRtOgwObaN7oaq0sYjND0iA?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5211c089-6416-433b-0a3a-08ddb1bdd71e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2025 18:51:47.5600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjROpdWaus2DRBjH8qno08Eu+01ORSbOQ9wuAOeaaHV2WQyAQcfloXJit9rMZdBKjVxJm0+I3WLIW+zXiVkcxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7864
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 22 Jun 2025 18:51:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19158

Hi Nikola,

On 20.06.25 23:37, Nikola Trifunovic wrote:
> Hello,
> 
> I am having trouble getting my BeagleBone Black to run with the 5.10
> kernel and Buster distribution. The boot process ends with an ALERT in
> initramfs. I have attached the boot log to this email.
> I have tried two different builds, one with and one without the 'Head of
> selected CIP kernel branch' option.

Can you try without the part-uuid?

diff --git a/wic/bbb.wks b/wic/bbb.wks
index b46282dd..a797e95f 100644
--- a/wic/bbb.wks
+++ b/wic/bbb.wks
@@ -9,6 +9,6 @@
 part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/MLO" --no-table --align 128
 part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/u-boot.img" --no-table --align 384
 
-part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 25d57b24-f34d-412e-8c88-28629f23aa0d
+part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
 
 bootloader --append "rootwait console=ttyO0,115200"

If that allows to boot, please also check if kernel 6.1 (the latest one 
when that change was introduced) is working with --uuid and only our 
5.10 (config) has an issue.

> 
> I followed the instructions at https://gitlab.com/cip-project/cip-core/
> isar-cip-core, but the only difference is that I do not have a *.img
> file. The only file that looks like an image is "cip-core-image-cip-
> core-buster-bbb.wic".

Outdated README, indeed. Patch sent.

> 
> I assume that I am making a mistake or missing some steps.

We unfortunately have no CI-driven image testing for the BeagleBone 
Black, and that might have allowed some regression to sneak in.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


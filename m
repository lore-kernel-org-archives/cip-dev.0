Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E68CAC5AE
	for <webhook@archiver.kernel.org>; Fri, 26 Sep 2025 15:02:23 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.2])
 by mx.groups.io with SMTP id smtpd.web11.19606.1758898938090060147
 for <cip-dev@lists.cip-project.org>;
 Fri, 26 Sep 2025 08:02:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yy9cMIAO;
 spf=pass (domain: siemens.com, ip: 52.101.65.2, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTTCQI69aDCfN8/aP7GN0WrCit6BT/l8bwPWsDGBYGfjOngAbxl7oAUdnGiun7V/l7tWzih30DFkNEbYXgxOqjkG3lgp8BiafIVKRmf3EqlRf1uncewsi1BRUaJOe6M9SqRH+epbXzXVF3Tw6sfaHLJ98adb9Qph3ybxt9/CWm7gkbcAfye2A4hZX4XQ42Ig9aeBDcM+ORj9MPeb1/K5nSTjuehHWPzM7kl7PJ7akmB4Hz97yO7CRM4kjAB8Bb4S0AekbIaYP42Qm1yWL2+t2kbX5aAvxDtZ1kpCc/61fQc5D5JpJw/Ee8ZaaarEheHhB2D644YvtvQChjA/F45yAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pV0Y9GOlq7lo6TD2rfYU+wKSc5VYorqbmqZfbPp5qbg=;
 b=HYGc9P2zz+GoPT9/E6y2y+i5gu3DUalR+4lYw6kVbeCFToxSvPxw1wpLFo/fUOwjqU90cndLF5qt+UtlhYY8iBdzSkrZOZu79RXvIYA/Hl645wUjg3W0kjDDg8FS7+e6vcW6zchruY8Er6y2Bx5xIUPANFUwuoiA6VWuKa6VjsQefLpvhEzv4CKK39HGVzV32a3gaS70fgAZA/MYaHXI8BuJzViW/FVCL9dFR9Hx0mq6A11X+4N+W/L/9FI2c000wVnfxdzKjL3Pf68fzy0GlNzCH3UwZFBJ2GeEl2GvwZ7RsEF9U2fdXA/s719eqFSJNcKOguVNDDpN2oV/me+hrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pV0Y9GOlq7lo6TD2rfYU+wKSc5VYorqbmqZfbPp5qbg=;
 b=yy9cMIAOaM7yAQn9qbnJjQXRcPZfiVdlJ/WWcxhWtMoP0jtBzP5uGypqzkpfWopkvN80t4yiWIAuMtuPm2KgdZEgfUBickJBeU4KtPTgJHnLhvUxDsiGjb8/2CGkgFVjQ5O3r9HTEg7Hys8yLtNhHmMNJgRhvUsiZ/atIYTtzOCCwby7ui2Rc+Bh4RVuLroCc6lPTO6czWN0IDtT4LqcO9fGzwfbn2Noqh+GeKe8wLeDpcUzL69j5etLBHhnWrZ2i7zhXqJw7OCNP78H+H8/jdOaUCcWdnopOj+3ZzaxqKd9EEzY1ZMSvXU+5b4buIucCJKJBusWu/YtltVi7EKqug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6540.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Fri, 26 Sep
 2025 15:02:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 15:02:14 +0000
Message-ID: <9f751474-d66b-481e-9bb0-c262673b6cf8@siemens.com>
Date: Fri, 26 Sep 2025 17:02:13 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Reduce initial /var partition size to 512M
Content-Language: en-US
Cc: "shivanand.kunijadar@toshiba-tsip.com"
 <Shivanand.Kunijadar@toshiba-tsip.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c5ed157-29d4-401e-81a0-08ddfd0dad24
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aUF1OWltUDZjUk9DZjFUUng2Mng3T2hXUzhuOStSKzI3VzNXTjZtTXk3a2Js?=
 =?utf-8?B?WTROeWNVMVFCbkQ0MTZOTHAxVGNMbUJMT3Nqam1Kbk91THdrWDJjMnozZGFu?=
 =?utf-8?B?MHhLQ0ZXZnpoNUVlOVduOVhEa0EzRWZMSmFReENkY3ZTNVhZRzhXYTlpNXhB?=
 =?utf-8?B?YVY3K1B5eUhDd0Q3WGVGS205LzdTbUwwTE1LTXVZSEgzZ2tIeDJNWVoxUDgv?=
 =?utf-8?B?a2RaK0w3QVpQRWNBTUk4LzBkZzRMK3F4Z3JFc1l0RCt4Y1B0SVJ4eGhWNEJx?=
 =?utf-8?B?Z1p2MzNSSHpqVFFpTWlnNndSWjRkZWVEeGxCOHU2SnJ0UTlEYk9Ybi9pMkJj?=
 =?utf-8?B?eGVvNGE3b2lmVGl2ZUFBZ0NXNWhZQ3BMcE5RQlNiWlkyV1ZHZERtQnNHMlpn?=
 =?utf-8?B?ZklRNWJ5ek9TL0JrVURobTNHT1JlYjZ4Um4xejhpVjVNa01FNEZCa256bmdX?=
 =?utf-8?B?SGdaSy9SZUZIM3VSak1mRVF0NENTQWhDRjIzM0xLaUpiUXlRZlFKVzJQdkth?=
 =?utf-8?B?cXpUY21aOHdkY284YzF1S3FDVlJtNi9FcXBIZG8xTnBXTjhyTGpTYkJhM1lp?=
 =?utf-8?B?WWJmb1Bya0NrSE5OTndJQkJlNVNSM3V4clMrcTlxQlBMUXloRFVNQkdVR2hQ?=
 =?utf-8?B?ZDJYSmx3RnFTcys1RmlGS2huYUtSMDY1bkorRFJuYUtYSWh2L21KbllyOUNC?=
 =?utf-8?B?RGFySzhCaWI2WTdNNzRNRUZZZUlRTFlNY2E0bXAxcUtJWWdGYzJ6YjA3QXFz?=
 =?utf-8?B?UGF1VjFub2dnOEpReW9COHFYQk80U3lwM0p0SGFKZ0ZFZGtobHl2OWtwMGxL?=
 =?utf-8?B?UGxselhDaUoyZXk4UGZSdXV0alJldjlyR3BnUjBOOXRHU0tXdXdyWnJBbm9u?=
 =?utf-8?B?N0cvY0ZVVFB3NjBqNWFLQXZtZ0ZqdGlXS1ZqNlZtdGJuNTJHb20wcEpxOWNU?=
 =?utf-8?B?UmlGZ05ianAveit2U0kxSkFDMm9pWXhTRmEva210eldsMUZmaXcyMTNwQVJO?=
 =?utf-8?B?ZUVySnNhazJJWG1YZmFNTWxGc2lXOStEQ1g0WXoxRk83NlByWmNKOTRGV3NC?=
 =?utf-8?B?c040NnUrUFZxK3ZhOUNSRlBQQmxidFJxSnJqb1pwMkE3Tk5lYjRLcXc0VkNO?=
 =?utf-8?B?aTVFaVkwVjgxQUJ3L2V5amc4SGozM2RqclM1SVVRUE5YaGtSWkJKTmhMb3FW?=
 =?utf-8?B?dzc1a0J5YlE1VG8zSEVwSU9sbHhHNUNaMGtWSlRRQkh0dWNjVjRUV3Z2VTla?=
 =?utf-8?B?eC9VOVNGOUpDeEliRk1pbk90NENIMDFJc3N6R0txOTRoblQ0akZzNDdYYm9i?=
 =?utf-8?B?V3dzU3ArOTNFMitwYXVYQzNldVpMQUg1MXV5YUVwVVh2Qnp2TU04ZFJseWh0?=
 =?utf-8?B?aEw1akhKYUtqb2NPVnpmbG53aFR0RkhOZXdsN2NRYUZRODZBTWFOZTRXVERt?=
 =?utf-8?B?UGxGMWNjZFV4QVY3YWNIRG5UbFcxOFdObkVnNldsR2F0MlN3ZEVhdXh1Sko5?=
 =?utf-8?B?U2g0Z0NXdnNRaFVvZDFoRUV6UCtGOUp2VTQ5Q09ySFFBVzdhMkNiZ2VxdjR0?=
 =?utf-8?B?eG56SnJaU2VsTDhnbXY2MzgzaVoxQjEzZWllNVBrZ1pIM2c0d1RLME8vRmc1?=
 =?utf-8?B?S09ydVZsRGVQampUaXlUMkZoVXpkOGxLUEwwRFZpVG1uUDEzMVRyZTFvYTgv?=
 =?utf-8?B?UzNZYXRwYmZGOTY1Y3NKWE5DTGNudHF2eG0zaU5pcVF4ZFBkTUplbXI5eUk3?=
 =?utf-8?B?VmduRnAyUXJnREdaTzgvdFRocGVXajZXd3EzazFRZzY3N25NK2JiQitXRmQ1?=
 =?utf-8?Q?QfjjYIKNNzkrGsFORuLJ70Dua6bOt9oe3FSNc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bG9tbkpPRzVQeUNzeWM5WmNNZWZXM1FlTGJHbEMzV3BtcWhWUU1DTk1zZC9h?=
 =?utf-8?B?cEoyV1A1UlhkNlAyNGRnN3FhbGFJSGs3SERxWHBtMlFOL3UxQ1Vvb0l4RnlH?=
 =?utf-8?B?aWVqcSs5UGtXeCtNZXpkWXNEdUNhMzNlYXBaN1FOZjdrR3FqL1RLdFBkRU1O?=
 =?utf-8?B?RTNwVkVlWEFBR1BMTVVmcWVmTzBPNUovWmsrNGJtT1hHSytwNTM1Tzl1VEdC?=
 =?utf-8?B?c0pvQmkzZ1g2Z0o3MFRhbjM0U1I2YTcwV1pjVDM2dEhaWEtsaFBicDJnUE94?=
 =?utf-8?B?L01rcmhFWEwxQlhzZXVNYmVBQkYrNktReG16RFVZYzdxOCtMNHUwMldMMjlD?=
 =?utf-8?B?WURvMXVrMjdUSko4dUpJb3FHdkc1Z0RmdjFxb1R1clBSaEt2QkVnY3dqL29D?=
 =?utf-8?B?SjhYTUZSNmV5SUFjaVBMWHdIazZtNmhGci94aHh6eTdHSlJTcC9vR3R2OUR5?=
 =?utf-8?B?aWszUmhVVzNKRHZmU1ZaODhWU0hmVzZHZ2hHUENqcFY0eko2VUNpajZWeFNW?=
 =?utf-8?B?NVRTZEM3SEliVFprSXVyelBwTUYwV05UYWZSeXFoK3YrdlR4OGV0bmxSUmlO?=
 =?utf-8?B?Z0liZE9wL0cvSVgxcSs1eUwxdTI2VjdJRHFvL3ViY3E0cTQxRDYycWxqZ3gw?=
 =?utf-8?B?LzA1RDRXMXU1RVBqa2NtZUl4T2NKRW91MDdER1FKQ0hlbXNtZDZmMEF6bjhh?=
 =?utf-8?B?QkwyOE9aRThxaFZYU0V6dXRybGhSOHVTUm9qNERMenAxNEhNTm1MUERIV0tQ?=
 =?utf-8?B?WEE4UjgzYm5vdkViQ0FyYm4rZU5wWGtXd3IzYW1rV0RIendlVHYxUU5tZFhR?=
 =?utf-8?B?YXFYWTczKzVaYW85SDBqNjc5YzlWa0QyMkgzYnFUSndDTEFNRS9BZTBVdWl1?=
 =?utf-8?B?cmJLNWZoRGpjT2p3ZVJ6MktnQ2FtN1VvSk1adTAvcldZYjFialB5ZW5XTDE3?=
 =?utf-8?B?aUxpNXppaDI1aGhuMm9Kek05WVpQQXAxdStKSzNRczFqbGtTWGxIYVU3K2l4?=
 =?utf-8?B?RTJFbEVpT2lSVlJqcWluZFVZOXpybEZNTE1sMVVObjY2MllIYjlaWlloNmFP?=
 =?utf-8?B?cVNZWkRxbDFJeUVHUHZCTEQvYXJpVWszVDFobW5xejdJVjZFZkI1cUhJaTZV?=
 =?utf-8?B?cmoyZ1V4Z085aEFDSFBHVmU3by85V2dXSnZrKzllWS92NmpwRzRhRFlMMndG?=
 =?utf-8?B?RUg3bVlLOWxiSmxQbm5KTVRKMUlWWXJEU3ZwYUo1T3ZYWmJuSmwvK3c4RnN4?=
 =?utf-8?B?Z3dGay9UZ2IyamRzazBEWEo3MXdkcWJYc2Fqc21CWGd6ZjUvdHRwWHJBb3hG?=
 =?utf-8?B?OHc3YThiNUN6ZHFaZHE4b3Y2ZnJQTldhaHI1OU9CSTQ0eE43MmJ2Rm8wOXZS?=
 =?utf-8?B?bkROMFgwTlN5a3Q3aFg0ckM3VjE0Y2ZzZEFWZzdhSXpuTk0rY1N2STlRWE5L?=
 =?utf-8?B?Nmd4aityV0dra1lqdXlBNmxjNVoxWnh6VFlSdTcrbFVXSVBQQjZNOWtUWnlH?=
 =?utf-8?B?c2x0OW5jZjJhcHdqWHVPSHdpV200RUNqT3dXNERsQjVmOUl0eFNDS2N2VjNr?=
 =?utf-8?B?Yzd1dU9sVEoyVGhnRzEzeEdHNmNEYUdoWUtpbkN5Zk95bDl4ditjSzFIWUxw?=
 =?utf-8?B?eUF1UHpzdXlaTVFzTXlpdjhVaVNmeERtNUFNUWNEdGlYakNQRGtJVEVTd1li?=
 =?utf-8?B?WWdCcHhVSFBFR1NZWklKWGt6V1BMSjRBQ0FQM2VTTXBBdG50Q2MzNENHVktP?=
 =?utf-8?B?b3VteHJKMzRNWk01VEwxRE9haTBBQkpzSHBiZXIxYVh3SXVXNkdIczIzbEtE?=
 =?utf-8?B?SHZ4TERvc0taMlpKWnpWWjVFcG8vbmxXMGJrVTJZWGY5YjdQZEFkVzNKZ0xH?=
 =?utf-8?B?bVlvcHgzeUtYTVc5eWF4V2xOb1czcEJSVktibUhiREw2N2VxTk91U05WUHVy?=
 =?utf-8?B?b1BFVWVLTDdTRzVzV2JSUG85N3lpTmdnZGQxb1RVNDFpaUp6Tjl5ejJnOTlG?=
 =?utf-8?B?UTBvQjJrSnVrVkF6QkdLV0Fsbk8rbDkzZDJoOVZoVE0rRTN2UHY3SXZNTERu?=
 =?utf-8?B?RDN4Y3owMlJYMFFVbVk4RExzbnJGL1R4WGZlUkMxQzhhb2gzSVZKUDgvMXp2?=
 =?utf-8?Q?mfsjd/977LSmiYt5GyC3uKsn7?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5ed157-29d4-401e-81a0-08ddfd0dad24
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 15:02:14.0802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOzHPoCTDfBDDeo1OxreSj4fFDIPQ09TGQWrn8Vxby95jqdUsteUikvzNum8iXI4BK3BekRoefl6z3eyu2W40Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6540
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Sep 2025 15:02:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20148

From: Jan Kiszka <jan.kiszka@siemens.com>

Some boards already used that: This primarily reduces the time to
encrypt the partition when this is requested. If more space is needed,
it is still possible to enable expand-on-first-boot and place the image
on a larger medium.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Does not help with https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/11509181697, though.

 wic/bbb-efibootguard.wks.in                   | 2 +-
 wic/qemu-arm64-efibootguard-secureboot.wks.in | 2 +-
 wic/qemu-arm64-efibootguard.wks.in            | 2 +-
 wic/qemu-riscv64-efibootguard.wks.in          | 2 +-
 wic/x86-uefi-efibootguard-secureboot.wks.in   | 2 +-
 wic/x86-uefi-efibootguard.wks.in              | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
index c6236235..474105a2 100644
--- a/wic/bbb-efibootguard.wks.in
+++ b/wic/bbb-efibootguard.wks.in
@@ -16,6 +16,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # var and optional home are extra partitions
 ${WIC_HOME_PARTITION}
-part /var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 9947ed57-102f-4038-880c-9cf5cacaf153
+part /var --fstype=ext4 --label var --align 1024  --size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 9947ed57-102f-4038-880c-9cf5cacaf153
 
 bootloader --ptable gpt --append="rootwait console=ttyO0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
index 7ff70685..261a25f4 100644
--- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
@@ -5,6 +5,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # var and optional home are extra partitions
 ${WIC_HOME_PARTITION}
-part /var  --fstype=ext4 --label var  --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 815406da-387f-4e89-a0fb-6e617605c8c3
+part /var  --fstype=ext4 --label var  --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 815406da-387f-4e89-a0fb-6e617605c8c3
 
 bootloader --ptable gpt --append="panic=5"
diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
index 38db84b7..4b270a6c 100644
--- a/wic/qemu-arm64-efibootguard.wks.in
+++ b/wic/qemu-arm64-efibootguard.wks.in
@@ -8,6 +8,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # var and optional home are extra partitions
 ${WIC_HOME_PARTITION}
-part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9
+part /var --fstype=ext4 --label var --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9
 
 bootloader --ptable gpt
diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efibootguard.wks.in
index 6423bf49..ca12b5c7 100644
--- a/wic/qemu-riscv64-efibootguard.wks.in
+++ b/wic/qemu-riscv64-efibootguard.wks.in
@@ -8,6 +8,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # var and optional home are extra partitions
 ${WIC_HOME_PARTITION}
-part /var --fstype=ext4 --label var --align 1024  --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 0209689d-672f-4254-8b92-566d6d9fd1ae
+part /var --fstype=ext4 --label var --align 1024  --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 0209689d-672f-4254-8b92-566d6d9fd1ae
 
 bootloader --ptable gpt
diff --git a/wic/x86-uefi-efibootguard-secureboot.wks.in b/wic/x86-uefi-efibootguard-secureboot.wks.in
index d7b5cbd7..3e141e73 100644
--- a/wic/x86-uefi-efibootguard-secureboot.wks.in
+++ b/wic/x86-uefi-efibootguard-secureboot.wks.in
@@ -5,6 +5,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # var and optional home are extra partitions
 ${WIC_HOME_PARTITION}
-part /var  --fstype=ext4 --label var  --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 686a2e06-7f96-495b-beac-1731cb98eb0e
+part /var  --fstype=ext4 --label var  --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 686a2e06-7f96-495b-beac-1731cb98eb0e
 
 bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 panic=5"
diff --git a/wic/x86-uefi-efibootguard.wks.in b/wic/x86-uefi-efibootguard.wks.in
index 380e828d..cc317f06 100644
--- a/wic/x86-uefi-efibootguard.wks.in
+++ b/wic/x86-uefi-efibootguard.wks.in
@@ -9,6 +9,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
 
 # var and optional home are extra partitions
 ${WIC_HOME_PARTITION}
-part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid be5ae5e0-91d3-46ec-a7f7-c1ebfc0a7c28
+part /var --fstype=ext4 --label var --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid be5ae5e0-91d3-46ec-a7f7-c1ebfc0a7c28
 
 bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 "
-- 
2.51.0


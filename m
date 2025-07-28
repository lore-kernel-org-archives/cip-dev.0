Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9ACC87FC9
	for <webhook@archiver.kernel.org>; Mon, 28 Jul 2025 13:40:17 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.33])
 by mx.groups.io with SMTP id smtpd.web11.81688.1753710013683555969
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Jul 2025 06:40:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OakLrbwh;
 spf=pass (domain: siemens.com, ip: 52.101.69.33, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJ6aQRgolzdNliN7l05Uq642tH8N1FobP0J0Ayph1oSI54MQrc6LNX2q1wiEH/oYNKYgItG3PvVyGkKZdZdGyeFIS9L9nn4CuT8K1V47BKizuiIIvuhg5xV39YMTPt/vkzNAdToM+xXTtWwKad/NKjVJpFEhf8Gt/jUk6gRlVd8p+DPFjF8uPnJ4XosuLtV/Z4YskQmiGSFuniJilSrnOsfUwZpObjWwC5KuQ/Lo5OCd/uVFKX5H7O30+DjkEYFlo0NnE3ec8EfI4Zz9Ta5PnW0K2BcfWSgRgt5gr/wcPdBs1jPrQi1PVV2T5hmkPYMaei39h7jxHnviPikWsG4Y7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a51iX8oTx5VaxZGYe6TNRlKtlVg7YeJxBU8BhrmU47w=;
 b=ZTsYDhW3qoKbtWcvXJFEa/QvYHMvmaAAjEP7VEHxleWfA/ERTGHv9dqlQALBXjITR1LbniDr6R7yg1/fBZGsgUMO6vlglXBkIbmt1KYXWU6al+HWTbgCNVadxEn6xkxaIiMl5tdh/tX4VSHhTGR0G6lt4X23GeoTK0ONJ7cS4Yhqh6Ce4pY+8Zbh79Q5+9JMOd6ehx95w4GqpVItmp41MED6q61io3bGt7BvfFMpKh2Kvo6BcEfDIlbN/fkMNxHktZigXwQ1bB4f8XmNZ2ED5CeSjJU+xgh+54h/10dhdRF0gIemsmQzgrTvuiugXT/S1z92C6mZRF4j++uLx8nz1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a51iX8oTx5VaxZGYe6TNRlKtlVg7YeJxBU8BhrmU47w=;
 b=OakLrbwhbhRA0lUVf6CmZtsk66jl+dyGLc+DHgaPLaqNiFI6k8Dn991RSl2CRZ/7DU86cT5UdQRxN0sZQWWgS136yygnZQXqLiOfXQeSpt9cuUhYCK3Ec4Takh8z0eZi84P22eJSxOE1W/ZPYs0hUj005HQ4TmpF6seBCApR7EeLzXz1c3sMisxe/bfQ4pJ1iA4AdRo9eI1RG9C5+YfR5lMbqs7BQaBG6N8qU65hlnkTUT7zEjSjngeQfhnKLbrqSwegecDM8nTb41uJbJK7LcqQw0I0RPCG8ydxGhq3rB8h0uydjOwhGSn6eKrmlqmZZFr1LAryWXpRk5M415ruzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6722.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:564::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Mon, 28 Jul
 2025 13:40:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 13:40:10 +0000
Message-ID: <304794e1-3dab-46b1-9c9d-55bef5653dfe@siemens.com>
Date: Mon, 28 Jul 2025 15:40:08 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Update isar revision
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b272b35-2031-4595-4161-08ddcddc456f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Snpva0lLbnM4Nm1ISlExQmovS2c0RnNwU3lVcEdoT0I5RUlLUmlMOEh2Yk5R?=
 =?utf-8?B?Z2FyUVV0Z3JFc1pINXpvUnBGMGtQSyt4M2tVUmRGeXZyMlVyTkYyRGczbU5W?=
 =?utf-8?B?Y3VYbHNkN0IxT0duRWlHQmJKOHpNdUxnNkZuWnE3TUpuZFE1b05OL3o1VkpQ?=
 =?utf-8?B?T0hhdVNid2Q0aElHeEhWeU9scld4Q2NlcXN6RFZpWDZHWkFQa29PM0VZaWhh?=
 =?utf-8?B?UzZaQmxBRGt3ZXVRTENEUGtYT21QT3lsS3I3SERxQ0c4WllFU1VSVGFWRmFl?=
 =?utf-8?B?ekVaclI3dy9mcGptdXdhUzNMb2FpVUE4TVFtbitIZERZdStGZVNrekpQQWJa?=
 =?utf-8?B?R09HMklsTDF6LzY5akg1L3l6MGJkdjFmUkZlUXYvNSsybDVHbGF3ekkxem1j?=
 =?utf-8?B?SWV6dW1hd3RlN1NkZkFqL0FnTGhQak1CT2lPWTY0NlUrK2FIWHZkYk9SZU1V?=
 =?utf-8?B?R1UzaVFsQ1BPdGxTTVFKTlcvdEtkWFEzcVRvc3ZlS01NQzhJclpaYmloZkZi?=
 =?utf-8?B?aG82TWo1S2xFYWpTZ042ZCs2UDVLTWVWdHp0bk5waDdVc29QUUV1S2JMRVQz?=
 =?utf-8?B?ZXU0Sk1KeU5UdjBjSWJ0ODZsVnVoYS93UTBYL0YvemNZNXVHaDduVnlnLzd6?=
 =?utf-8?B?SmxMZ2VObG9mR25EMzlJOGMrbmp4WWFyWGJTWVpBYVFXUVc5TlVaSDhSR1o3?=
 =?utf-8?B?ZW9Qb3Fhajl1T0FBcStNLzAyZHR6Ums2b2x4RVM3UDdjeWRidGpBdkpXT2xD?=
 =?utf-8?B?Q1gwWTJQaTRHSGFiMDlIUTJwVW45WkhUclhmTUQ0b1lvVm9zY25vdHJNV3Y4?=
 =?utf-8?B?LzJsYUk3QXFOYVh2WFNvVFBmOFhKeEhNRzNuQm85R0t2K0ZkYlljRW0yQUMw?=
 =?utf-8?B?aGV0b3lvTjd2bkVOaFRJeDBncDk5RUdnWGNGdnR5YTRaNlpQTlg2NVB2MWdh?=
 =?utf-8?B?cmo3TkU4L25UZEhZdkl0QklLY2JVRkRkRzkxa3BxN1VlRjROdWk4UG1ydHhI?=
 =?utf-8?B?S2U0ZHBJb3grMlZOU3NWZ01hOWc4WHZLZm1JVVBhRjlSZzFFSEpJWU5tVkhw?=
 =?utf-8?B?WlA0WWZhNVMxR0s2WUFpOUdTTElUQUtGazFMSmFhbWtwQzNtem1SVExXcElE?=
 =?utf-8?B?SjRSN0FjbWh3SEIvaFUzR01BeEhCMDY0VWNHNEs3ZWNXcDBLd0R3ZUdDaGRM?=
 =?utf-8?B?alFCM3laVmZRa1EwcDc4WENHQ1JtbFp2MGNOS3FOOHhZLy9RY2NpeTZnU0U2?=
 =?utf-8?B?eXVPMjJlUDBNOFI2c1RkS0ZmaTFvRm9vRWwzYjlpTk9WRVN1SDltdjI1aVdz?=
 =?utf-8?B?S1djNXlKdkptUnNHc0RydEFsVjhTMnRNUWhsNjUyVHVkSXowSkdjaHpTUmJO?=
 =?utf-8?B?Sk9DUFhhc3NKN0pwTnhnZzJ1NmRPYXJoSU1YMHlUVUdzdnhsQUU4ZkJjSXU2?=
 =?utf-8?B?WU51WFlKeEZaeE01VTNKV25kNmZXS2ZvWVAySFBpdHg1VnFBY2VnMDFVRHRK?=
 =?utf-8?B?OFVWVHN4UUhSZTlRTXlOek1XWGM4YURDWFpuaG1zQU0xckxJMEcvdEpKd2ZZ?=
 =?utf-8?B?NDBFNldkRnprQmdXS0F4aGc0OVdsZnJDS0JkTlZUSlNqQzczSDg1OEUrb3Y3?=
 =?utf-8?B?NnAwMitUVE1GUE9PU0VKQ050WlB5TlBmL1AzSjNvV2U1UWlnNmNzVnFxS3lw?=
 =?utf-8?B?eGdNc0FLQi9IN2p2RlhJQWVhZ2FRU0tabCtQUEVDOG1zNEFNSExBazdSYkg4?=
 =?utf-8?B?cDRJYU1rTDBseUd3bXRxR3d0T0VnUVZYODJTL1FNMTNHNGpJZnE1TDVYWk5H?=
 =?utf-8?Q?lnmIOWGpc8gri2QbVdNssYHJLOptfv7V44DsA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bkFTdUZ0S0JZdmJ3RVNzWmQvb0tDeWZyVXAybGU5ZkxoMTExRkNZSjFsVEth?=
 =?utf-8?B?bkNiSEVRWFFiT1NsWXB6VkNNNVJRY1dzSms3dDRMRm55ODNia3ltSmpFT1Ex?=
 =?utf-8?B?MDRCNFdhc3JRU2NXYVZxVVpkYVpDb3NhUDF5THNtS0c5dEt3aW9USmdBQ0VZ?=
 =?utf-8?B?eEUvY2VHbEZsdFFtZW5ua2IwMkRTQy9LbVArSC8rTGJ6c2UvZlVqZHF3a2py?=
 =?utf-8?B?VlJzcXFleUFjaENKWG9MVEZLSXFIOWR1MzhFVjhWWTRtZkgwYXRrd3hoTkNp?=
 =?utf-8?B?Y1g2YWdjT2JxNW0yVE1Db2J1cm1Tb3lVNFAwanhraDBrWGdiR3JmL2QyS09p?=
 =?utf-8?B?OFRKZTYrT2lkZ2V0NE5CRUhTRnIyRkJ4REdtcHpmSXlUTkJxQi9YZko1SnVs?=
 =?utf-8?B?RTFaM0EremNDSENmMHdxcll1eVFUM1B4SWNkMWd3SHRKQ0w5dGhqVzBqUXdV?=
 =?utf-8?B?d2V4dFZnTXBaUThCbm1uWkFZOUpRU3hNSG94SFFCNDljZVROSmxrVmRVa3M3?=
 =?utf-8?B?U3ZXdXZobklCOWVtS082WjZDVGhtc1RXRGtKQmRKNWwrMDhFdkc0NldjYVpO?=
 =?utf-8?B?U3lRNnpzYzV0QngrSXl5WkRvYnZsQytUVGhkSFNZU1h5bUpoZyszRGVza25l?=
 =?utf-8?B?V0k5NDR1cTBNc0RBajhYYUNtTkRCWHRWVDJSQjdiY2V1MG8rdjlWdkROb28r?=
 =?utf-8?B?L052aXVsVEtDMUNqNE9naXdWS1BaQUZ0VERUSzlnV0VqRkNpcmkwN1Z4QTRK?=
 =?utf-8?B?MDFvQ2hwQ1FDS0ppWHZMQm9weVh1cDFkNWo4Uzc2TVZBeVAwcmk3Vlp0eHBx?=
 =?utf-8?B?OXAvWk1RYU9Zem5ZSlBtZmxxMDlOTGg3Tmw4VFZHUnk5SHdZbFF4eXI4anNG?=
 =?utf-8?B?YkpkZ2s4TkxCcnZYR1Y4VW1pdkwrcDJFeXd3NVR2SUNRMDcraTljNDR4eVov?=
 =?utf-8?B?RmZXWSt4NVg0NGFFU0FvU2JMb1cySkF2WVFxdjRnUVVwc0tjOHM4OWgyQ0Za?=
 =?utf-8?B?Q0M0bkhqL1ppdlNBSHhoSTYzV014dDZFT04yVDlVazBsOGNHTG9CRTFGNjVm?=
 =?utf-8?B?dTZaQjJxYUZmZVRuNmFEdTc4WjhNTEdTUmJMNFduRG9XeWs3OHplWjl1Y0JD?=
 =?utf-8?B?NmtXSndoZmdGQTQ3aWs5ZDVKYnZVdllvNEplbVFTc1I5UDRNdGZySC9SSTk3?=
 =?utf-8?B?WVJOVi8rMDRLbCt4aWQyYzc3ZTFwZFRONnc2ekMzanoxRUNnMVc1a1RRVkNN?=
 =?utf-8?B?bW5kQ0EwRlQ0T1UzeHlJbEI1TENYS2xzMVpxNk9vdnU0aXJBanZDZHlyYjRR?=
 =?utf-8?B?aTBSeHFXc3ZMemM5ZUQ1alhLZ1NRVnI3YTRNVGxxdGpKMGtFZExTSlcycUFh?=
 =?utf-8?B?akhDUURsMVRjVnVveXQ2Z2VLVzRVcWl1YW80aVZCRHhoWWEwUnFoaGpGc24z?=
 =?utf-8?B?YkZOV3U5TW9wSmVnRGhHUStSalh5THZ0Tmd5V3FZWVVoR3hDM2tUUnRCTDFJ?=
 =?utf-8?B?S0hQeDM1bVB5eHhQMlJvV2FXaTNJc3ZZQ0ROL3RkQ2svZktyTUduZ1NPNG1U?=
 =?utf-8?B?WnNJTTVTaVVMVDNlZFltQy9jcGNWSCtFeElwUzBrUndsZ1cwWGE5K0NRZ0Ew?=
 =?utf-8?B?Q3JwZU10aGV1VTBoTE1iTVJhT0FEVjA1QVV0ZnlhTklxT2pFdVlvTWRlbzJY?=
 =?utf-8?B?NElMcTFsTDhrSEhhcE40V3NHZW16VTYwYlJ4bkZJbDQvOFYycWI0RmxNc2tn?=
 =?utf-8?B?STQ4WVJhT0NLZWd0Q1pjZTk5djdSNlZEVmRNc2VQSXF1QVU4VS9rUXViSWov?=
 =?utf-8?B?Zlh6eFJJZk9PZmlMeGJ0YWZFTVJHakM4UUFra3kxd2pNcFlUeG9HNHd5bUpi?=
 =?utf-8?B?bkl2NURabnpoOUJvdXprTS80azlYNElQYkhQcFBWVVkya21EMG9qeGZYN2Q5?=
 =?utf-8?B?cVhZYk9FZ1NkRVRPZWhxd0RJNTZQS1RQWnlGWlc5UFRUV3NDL3JicFVjOU56?=
 =?utf-8?B?aXZJbDduUjJrYS84U25yYXJUNWMzWFlzTngxQ1Nza0wrRVhBMWl5cW1LeGsx?=
 =?utf-8?B?cW1TajBHN1lRMCs1ZnFXcksvVi9HQ3dmVG9tZGNZbTN5YTNRTWhLQkJOaldZ?=
 =?utf-8?Q?zcrL+NBLZ9TAztsGdrTeOIduh?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b272b35-2031-4595-4161-08ddcddc456f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 13:40:10.0123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GnvBANyTKWdeqx5S4dqnsB5ufeyv6jLVGjzTkvlDFYYXvMTmF3ikUiL18cemoeL5HxuQ1MLWt5Nse7m1R6SUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6722
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Jul 2025 13:40:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19602

From: Jan Kiszka <jan.kiszka@siemens.com>

Allows to drop the patch and also brings some smaller fixes.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../0001-Pull-buster-from-archive.d.o.patch   | 40 -------------------
 kas-cip.yml                                   |  6 +--
 2 files changed, 1 insertion(+), 45 deletions(-)
 delete mode 100644 isar-patches/0001-Pull-buster-from-archive.d.o.patch

diff --git a/isar-patches/0001-Pull-buster-from-archive.d.o.patch b/isar-patches/0001-Pull-buster-from-archive.d.o.patch
deleted file mode 100644
index 20c99172..00000000
--- a/isar-patches/0001-Pull-buster-from-archive.d.o.patch
+++ /dev/null
@@ -1,40 +0,0 @@
-From cfb78915e9c272c74bbfda7ab5f91bfa2892daf3 Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Wed, 16 Jul 2025 21:53:09 +0200
-Subject: [PATCH] Pull buster from archive.d.o
-
-Debian buster is now out of LTS, so update the URLs to continue allowing
-to build against it. Security updates are no longer provided this way.
-For supported packages, those are now coming from Extended LTS [1]. But
-as the provider is asking to not use their server heavily, we refrain
-from providing those sources here.
-
-[1] https://www.freexian.com/lts/extended/docs/how-to-use-extended-lts/
-
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- meta/conf/distro/debian-buster.list | 12 ++++++------
- 1 file changed, 6 insertions(+), 6 deletions(-)
-
-diff --git a/meta/conf/distro/debian-buster.list b/meta/conf/distro/debian-buster.list
-index b3a3b769..3fe0d61b 100644
---- a/meta/conf/distro/debian-buster.list
-+++ b/meta/conf/distro/debian-buster.list
-@@ -1,8 +1,8 @@
--deb	http://deb.debian.org/debian buster main contrib non-free
--deb-src	http://deb.debian.org/debian buster main contrib non-free
-+deb	http://archive.debian.org/debian buster main contrib non-free
-+deb-src	http://archive.debian.org/debian buster main contrib non-free
- 
--deb	http://deb.debian.org/debian-security buster/updates main contrib non-free
--deb-src	http://deb.debian.org/debian-security buster/updates main contrib non-free
-+deb	http://archive.debian.org/debian-security buster/updates main contrib non-free
-+deb-src	http://archive.debian.org/debian-security buster/updates main contrib non-free
- 
--deb	http://deb.debian.org/debian buster-updates main contrib non-free
--deb-src	http://deb.debian.org/debian buster-updates main contrib non-free
-+deb	http://archive.debian.org/debian buster-updates main contrib non-free
-+deb-src	http://archive.debian.org/debian buster-updates main contrib non-free
--- 
-2.43.0
-
diff --git a/kas-cip.yml b/kas-cip.yml
index a85a8d2a..d76d6d94 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,11 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 8e3122249a52db470efb32b92ed9c44e4b758712
-    patches:
-      00-archived-buster:
-        repo: cip-core
-        path: isar-patches/0001-Pull-buster-from-archive.d.o.patch
+    commit: d63a1cbae6f737aa843d00d8812547fe7b87104a
     layers:
       meta:
 
-- 
2.43.0


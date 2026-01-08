Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95608CF6AAC
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:31:10 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3037.1767864662688350346
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:31:03 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=aU39ZEdD;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.21, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRHclojCHNwPJZKJJO82CrW23aGGuiQNg1IrAa3+aUr55BkG+xUZm+tSxuMbnupD8sG8stC2ZPF5rTgvQ5/dTzIxTdSY+d25NqW7g4zTdVLPyq1xB/lzacdofzOj1qCZUPB5JHWHuVI/2VPPXncLrl9g/WauWficqNJQgdATYWu8tO2p5Br4PkQVBodUZ/J913ds+dYEPhrcwFNR4XLWp24fu6kBXksiqSC8AwqcXNes4TqbALlcMebLcuQO7OCtnL0PShkn6bOh3QtNAoq17O3MOGmodssVVwznkfSw7kLpPDhKwouHs1Sn9uJZEo6OPyI+nal/9b0snSiGXlvJRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9MBWx06l+IAMu8/m09p01Fis1wciOHWKLItPkk7Uto=;
 b=kUM6zFXj9OUBVQgKzzSBWwaeQlWfo17nrP1iM9WKGw+8Tv45NHhpUgSxcc1NmTEDplhbLanw2NF4KUunyhHQDhagBxkgy3z2QzSh6NmGODoxYMmoUrfuxUi9/+gM/P5qzYOevPvhQV/Poii8vmqEMnwBK76n9yor9FI4Ilc8hXwLCyvhUbifZxat/6qRhiygmpJNTyqvEKxVglLdX5pBgFLOXqCCyUKcq+8BG6AJNunAVX+biceSD+tLI5sSAHpdPnZB32vlKNxAKW1/vYvUMzYz/X3aTB0DsrclC+XDcerOL99b9BOXlFDy7reCYtLTjbyY3zwWeLyEMmiEpwsxKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9MBWx06l+IAMu8/m09p01Fis1wciOHWKLItPkk7Uto=;
 b=aU39ZEdD5Sgo44p9zL7OVfU/cjCE8evkhuWWBkI2Qd0E/0qK4lqC2whu099LNhgx53+74sAjLfkgAmdbiAqNOgf0qcc+BTt17ihwxaKMWnIX1euxavCOm5abaf9DylF4lFbHTSAf6E/Khmkt6uHazhFWaz7mbF6oLgqh4EGfLSE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14326.jpnprd01.prod.outlook.com (2603:1096:405:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.1; Thu, 8 Jan
 2026 09:30:59 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:30:59 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 05/19] i3c: Document I3C_ADDR_SLOT_EXT_STATUS_MASK
Date: Thu,  8 Jan 2026 10:30:09 +0100
Message-ID: <20260108093023.489513-6-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::13) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY7PR01MB14326:EE_
X-MS-Office365-Filtering-Correlation-Id: 7514bdbb-2f5f-4994-dea5-08de4e98a1c6
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Io48UdxjSbBt0aCw7lM053ajynl4986/0MBy76afYkqw9vDJbEbCOgHsGIra?=
 =?us-ascii?Q?bKxgK0IGQcA7rNEYHMZE2hTCU1SzF918JxAvgt5f9LiwknK/8BewGTd4LJVp?=
 =?us-ascii?Q?lTgFzTKYQG0Fw2hN42NeK2mvcLMSkEicJIZKxM+9zE7++UJ3+8GBtxEM6i+w?=
 =?us-ascii?Q?k6G4KJy2o2/RlxfpI7n/EL3JO7uTXadp9Hj13bdZugZSjlxMhsgNYPBofAWl?=
 =?us-ascii?Q?g4Je/JxpIK3R3K57jlMpdYp80zxKzsIMoCVf8PmUQPWfSOQAgLLnBGbscyDP?=
 =?us-ascii?Q?Ef2YmT3wAOaH8oYY7n/zioh0cGadHetwc+evbxxVn2UhPMWNh3fmZl6OxXMJ?=
 =?us-ascii?Q?vF/4/wBHIdyvwBwGegFe2tLRBbHKRxj5tNzLY34v94BIsnHXWxLdIKmZKwdp?=
 =?us-ascii?Q?W4OxQuD6OUYDUqOGHaQLPtkZE4SyWTCnG4uXo9ptc4GWcj1ZayBPrUrrAxsF?=
 =?us-ascii?Q?tsf40fidltvAyd7tXVPBboaZBAnsiiZ2PSxW6jmkZnOrCQXwiyPOEX70eqUL?=
 =?us-ascii?Q?LyLdtDzMKp18ZfgPNjnbKDYPXXoe0hfDyT3AMoqR0sJL4FURW807zKEOz+I8?=
 =?us-ascii?Q?7xYbwahSJxmkf8MW8SbwRtLl3zDjaHAfmt9dLPa+TNoKrYc8S049stNehA7Z?=
 =?us-ascii?Q?VoqxemOdN1Hx7Os0en1alL3jPEL6HgFxMRCdPy5gsRU8h+ALO4B8haufSNpR?=
 =?us-ascii?Q?NrIN245zxU114hQPrqKzC45ZQr7xPDreTxXdEibNsx2Xzh7WsFvZkzHo4r39?=
 =?us-ascii?Q?YnAAhvwEYPHC/2uPoeKWle0Xj8DN2tWUQwUNJtS7CMQJAO21xC4yf8f1ZI0n?=
 =?us-ascii?Q?TkLHxL6GO76fkL2lTsnu+2KY5tBWDtWYwGTYpVgvb3ae0XSmkhmKK1ZxUxoZ?=
 =?us-ascii?Q?jiEjI5I18V9X0AYdHcFeuFN8P+iIUoegblBKBpwX1Pfjke46NdtPz7Yk1NFF?=
 =?us-ascii?Q?bI+QxCRGsXNvx3I+rkBzGVjlVOe1duSDUN+dMhCdSErpgM2TkMkoiDHeJaoy?=
 =?us-ascii?Q?qQbArfcojO1CwxV6kgzHoqjweGWVNWGr1IrQD5KZVaU1KrJSVM1woDri8deD?=
 =?us-ascii?Q?OnbNJsQxPv9oH3EUq0iDQZyRLcH+LVYiyqCozDlMyohJ4kEEK8+uddxOGIRP?=
 =?us-ascii?Q?k4ys3pJLuXHjcvBqnWsVIHsrMnOJqOeT4052HwfLr28Bc0vsT0HCyXpOvOMC?=
 =?us-ascii?Q?7ZvB5SxDqazfU4pImyJT+x3xFRjy5dHeB6XdnVnDHFZEzBAz54MVy9tF9jZT?=
 =?us-ascii?Q?XNWsNH6WUN5AQfyWrgrp0gXMTQ+IgLEbC9vTrSf40hkMz6ADN/NdPs350b2o?=
 =?us-ascii?Q?lUN5ZADPETtmhX0HIYhjllahJVQK9KKsfRlv2LJQt0UeII40ybwxxXdBQ2b6?=
 =?us-ascii?Q?Ph/rD1F9MVn0IKotTQ7MphfKS0OeJ9Sz9k/lfisdnYIBK5PmyWh3FREwHNMH?=
 =?us-ascii?Q?Jhyj7vPRUzFnwgvzSEIsZ+8nQLLnu4c+XQJSqISyc+0rJtNSEaUBoYCw+wVs?=
 =?us-ascii?Q?whw4CQAHzPeal7EXL4g6p3DJAVgIMkGVk6JP?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cFVcUeIy9bTnlRq87R2zN1h1U8G49iAEyWs9R11cHAZQvl5qf0YXPLC323Af?=
 =?us-ascii?Q?Z1zU5maywI07HKFP1DltjV46w98GZbEOxAxMDVqzVA3dzzNnLPqeBSlSdxbn?=
 =?us-ascii?Q?GnJnYf0chlRdxdYibN4/8uBB8A+azBhR6+qHCJLmcEVDUWB4/BgcUQWh+hWN?=
 =?us-ascii?Q?xO4iIjE9pNG7YWAHsELE5KmXb0jvaXdkWjmCclVASYmaCpVXAH5P858Lu8EF?=
 =?us-ascii?Q?6EBL3wq9bRGpf6xvS7R+GTakWw2M+YlwrEAawV5nQurgEZHSJ7So3Zb7PwLP?=
 =?us-ascii?Q?TRRvnPj+WepZc/hniyPEtldJqMp08zxr+8k5D2zB/58Ru+JgMyvSN73ZfucW?=
 =?us-ascii?Q?U5I3nFlfzKf9nmS77TD/qRmI/tzpt1oANGAPopytsbkXQAg4wN2szjdSOUYJ?=
 =?us-ascii?Q?kYAbjRrufl6amBg286gZDwy8/nJAFqRFO9zTlXIZJtv8fzv9UYn1MuICSFh4?=
 =?us-ascii?Q?gufBZmD3OMl6gpcAhtgKGmJ6eIUf+jB9wudt8CSJLPQCV0Lm+CoSMgH4kApo?=
 =?us-ascii?Q?deaWBK8o9gJLHB8YtcKu15150svDUu4M8+fG9sGHbmMp4JwvgzI3ST/QV3e3?=
 =?us-ascii?Q?8BdI86jtFQ3n9d/C3hIRGNcdRptvvwbC6NC07kp8mlijya89+T7OlyNoeQK3?=
 =?us-ascii?Q?si9gef7jwskg1CJ+IaFvjiY/9kNPzu7Ccdr52Mm1SyB0foliphZGrDriRvI6?=
 =?us-ascii?Q?IrhGGnyBl4RP8DN82WRV7MKAyeBks+PceJk497G7omu+wNFyHTk3CmvsR8/M?=
 =?us-ascii?Q?zw0kfisXIxR3r6LmA9bAR4D7Uwy7694VN6+MlWIkyJaPb2cfvwee3uG6GZIZ?=
 =?us-ascii?Q?rOO6kIRGlCpZKpY64NXM4N186CjGHPLW8bCreAE7q44cJxoQRnlptx+DRZ3y?=
 =?us-ascii?Q?vzBTmsbU46FSXFA3ga7uvKf836hCDL65jsZRGeJvqL2NPBKIv4aPuHauXx57?=
 =?us-ascii?Q?K4ehYGyUCguKRmMVnrSeIFsjBXcaOTnfoMfxKus5nY2xrBta1Pwj3I8bunH4?=
 =?us-ascii?Q?9aAHoCP175EDashURCctJiQAggmyCjchjGDdSIMZnJ26uTQKfuMXKQClnxC1?=
 =?us-ascii?Q?ygpBDV4tby9Z0CpeRhZGVLzWnhtrN48Z6vqV9sG1vHV3n1fsZrsuGjZmSBUH?=
 =?us-ascii?Q?TjNtp4Igcz6KroXMwMc28tHwRO01Dy9MFDX190zOAaE6X0/BIc6VmAdrBuzP?=
 =?us-ascii?Q?CosHhHoLwOj7xV9YUFGPWwegum1+I/ePf4DYRvfQpePWNTMe+wn4LG6kvAOL?=
 =?us-ascii?Q?MIWYIwQTv55QTdSe8/r7lSf8oBrimxMKiSb867lT70hgUIoeLl2RLCKAYyGb?=
 =?us-ascii?Q?AmxgjgNs2YnqkTUlQitvP2qJ5YMpH7Godqi2Sah8n4UKiTwpL2NNOxlvnFWu?=
 =?us-ascii?Q?mJjfwpbmaLEMbJRto4sOgklem1cLtIBfXujAVaIQ7YazwAxEu8d9q+jt2N8l?=
 =?us-ascii?Q?sDrRyE/K67vPtIpiiNFQ40QRYXwlBpIpom26yxWG57mGPU4XejBX7jhWNAXN?=
 =?us-ascii?Q?kS5b7YHUSMERvjayzlG6jIQl6rBdSfB5Bpm3V9KEUTw341Bzz5gUFg0xqkUk?=
 =?us-ascii?Q?fTNCDqGoUdtpu5Fkm2jvxg6njNSodnMJFZiZmTQ87PcD+V9hv3zjch8KFBoo?=
 =?us-ascii?Q?F7l394oFlzBsXGyICY6D6hqbQXL2SKeb8tcrLtBRde+toCcz/1lyg7t7JyAv?=
 =?us-ascii?Q?SjIONcBB0Lqe5P+ZL+HivUT1mxDy1UUy7c6oveVj5O0vVRXwCrruoF0Z8k15?=
 =?us-ascii?Q?6Aph/D/pVs2MTXuPE6AsHO0mHgDq4gqDJpKeAeFvWmsZrGUDZujE?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7514bdbb-2f5f-4994-dea5-08de4e98a1c6
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:30:59.2877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxrKyePqEQo8GZoParzgl57TyAYjQVbIFC5SzFYbwRPfR8y1e+AweReJ4ChwHsgXejeqQ8Jra/SijO/RFlIJBYulLYjXzDzbKs3voaiSHqf221d7J2DzRF2Fog44ykU0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14326
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:31:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21463

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit f6ca73063754950bf3fbad753e3a9557e3aa85e3 upstream.

As the mask is part of the enum, document it.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/r/20241102132841.2446176-1-alexandre.belloni@=
bootlin.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 include/linux/i3c/master.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 6e5328c6c6af..12d532b012c5 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -298,6 +298,7 @@ enum i3c_open_drain_speed {
  * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
  * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
  * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
+ * @I3C_ADDR_SLOT_EXT_STATUS_MASK: address slot mask with extended informa=
tion
  * @I3C_ADDR_SLOT_EXT_DESIRED: the bitmask represents addresses that are p=
referred by some devices,
  *			       such as the "assigned-address" property in a device tree sourc=
e.
  * On an I3C bus, addresses are assigned dynamically, and we need to know =
which
--=20
2.43.0



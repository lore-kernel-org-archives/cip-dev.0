Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28098CA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:04 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.14])
 by mx.groups.io with SMTP id smtpd.web11.1027.1755706141819191484
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=lzQ+RwzW;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.14, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqYQQTT2BbC4a6+Kx1uFzJEiw0TSrNJLSvnoBO3osxCfDxAZu5R9hq1ThxqeEcYjvPAZ9QuhNGa153LOMVp5KM0O3B4Mca8Ckt191idrTZNcCH630MPFMxP1yVhxuB+iiR1AMQwkLPNMyIzkFa+0Xzj0xG10tIOdc3yQT4z61XQnMmKDPsmwBVEWEbeiPlHSB0HNLP4wz3+YZXCJuomCXbb7LdhXAE04D7cX0KBTYScTiLg1BVFVKc0wFjLtjGJDrckvESX0gYCZz77IKPAKyaZVcaKyS0p+DgR6u0cDZz8TkuLFg+fW2MspHSxgVhU+3f0uAWLgC6eYphygmG9IQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Es8/VqlcIMUWqMBfbmVqFDkLmQu7cjg6YygL3jzC5n8=;
 b=Re73AN7btuz3icQoo6OZbCO9SOTwubRd0FZOSKymIiFIViE4x2j6ghMttLFDIdK1EkiVyzB4kAc6NTk9wrjCvm92hXrTdr2OYZuIR8d1GNez1IxUz/p8SgABuXdVbqjKpz7brQ0u9/B+hGZLz1GzQopUhKx5T1sMftzizYsSg3l6yJI1jRf1VsjzqqftGEEEdIglE5CZ4a9MIoY63sasu2itEBsRkR8QHLHkrDkR/rI7JSxbnUQvpxnxqkkUSGue6YGeT/c0BuMBTgtjotMx2fGNX2sD6cFJN5X4Q7AHStsG6pOxmEqwnuVmiqoTV1S7u0s9fPo4onk7/vs7tiisWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Es8/VqlcIMUWqMBfbmVqFDkLmQu7cjg6YygL3jzC5n8=;
 b=lzQ+RwzWqeTEoFNkLZIiGQe/+Z5zaHqTPysRBFX6gNuj+DJYUVb7xfzLUwGLCI/N/tezkkVOVmtfS2DO4CZF4PV0wX4H6mzrlE+nHcgw+a1r7nyQP2PmC1gGxRm8Wr6hWOd9W6j3/DInWzP0/OWwVSAUZ+wa3XX2qeag0gynqok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSCPR01MB15595.jpnprd01.prod.outlook.com (2603:1096:604:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:09:01 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:01 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 15/55] media: rzg2l-cru: Remove unnecessary WARN_ON check in format func
Date: Wed, 20 Aug 2025 18:07:16 +0200
Message-ID: <20250820160758.801813-16-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSCPR01MB15595:EE_
X-MS-Office365-Filtering-Correlation-Id: f100ee1d-0393-4acd-36c4-08dde003e05d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Y+Q2t3XGhPacmwKfcMmx8lJ3Y3pUx/heIpWGWT/RMx6tH/WQkfNdXK0aDvxY?=
 =?us-ascii?Q?xWJ28EbZmmkIFG979soQTZ3vvSIcclH86as3rn6Z14LLFW06yMHIJD7V2iNz?=
 =?us-ascii?Q?ESblP5qy7k+v9xfLFVdq/XyzfxaDV054lk6q18hc8d0Tc3mpPW0TXJV9toIO?=
 =?us-ascii?Q?hJifsBYwNW6ayCANZkj5T3ZVOoB6sYc1HoZtFXoqQ2otR/+aG7lJZmomhmNj?=
 =?us-ascii?Q?AuvbCTNytfjUNDoFWhbPbHTARidksFaDLTrhovWD48xn1NDFTcDEtBMadqTJ?=
 =?us-ascii?Q?3rOB2GPoXRYyjk58YLsdw6lVGa5X4Ca5DoxIwDKDyAINsUNw8UOhbJm0qZk9?=
 =?us-ascii?Q?xlwe5vOvrlfjvMFOLBTie/0NQgdTKuHTFRWH0jNod4wEPRlhkVaGIkv3RBJx?=
 =?us-ascii?Q?D+7nTMgbwucv7kp8mX3hR3lhOoSnEid/llmYXoivPGeX9VCtmzSb1UztsI0g?=
 =?us-ascii?Q?XDBtNX65yObU99/kS6q/NdlGoSWlS1POBfs5b9e/ETKxWrMhsNXSAWIBh8QT?=
 =?us-ascii?Q?F2t+84D4GrgZESjgXFS1RAXZFn3MTwam+qqAj/g01qqacwiyQCUfxcGIS3wI?=
 =?us-ascii?Q?u1Ocnn2d57LAPvt12OyjUCAF8ckT2blXt8nWiidbmbRqeKIoQD3/7BgyJccG?=
 =?us-ascii?Q?oOyWuJ0JebNNKaYO+dsx0inENbW6+Rh/gssjJnG/cgV2c3eAR52Oe3S+rY83?=
 =?us-ascii?Q?Ki9TAstCwy8eRwQs37JonRrIF5nFTaqfROIbIxMX10TGN/xssCvpRq7EMxMO?=
 =?us-ascii?Q?WHmdjKC5qQjmxkpUKVAFrq+tbnCfWrcYU3m4fBPGrUwQWepiQX4Zxpa8amk/?=
 =?us-ascii?Q?HMvq4gX6PrM/PZFl6jatWYYeoSycdZidraMGPjC/8BDKZhNe1b98DfcC2XO6?=
 =?us-ascii?Q?IqKJXotGcT+8hxG0i7ToKdi3k5Diq6s/koCd31CvVuS6xLE0mFb6S6I8nx3+?=
 =?us-ascii?Q?nSU6LdlkgJ+YNyDOUP6OXr4Ne9FIebvRMvmL/3+R3yhaJMBKMOx/2CXNqAo4?=
 =?us-ascii?Q?QyKtm3buw6mjWkL+z0JrCpl5/sqovKMgh819HFLISTWsLwkb2Xrhv/u6zWbw?=
 =?us-ascii?Q?F2DieVUFSMXAAWgmSgFepzSsZjEUTrFLNdezt83nw2mOS3PkhXZa8qNDB9C6?=
 =?us-ascii?Q?R7colMJK0jDmTDS3g2AUJtqXMZLQ/ZNp6jqcNnrg618116rFqDuLTFeI9i6j?=
 =?us-ascii?Q?N8AwZCHgmt2A/NT2OnC7fBIud0DT3egXW0tmxKFhMO3c8Gaglkd6p/wJAhm+?=
 =?us-ascii?Q?E9Se6xYTx/I+YA/CErYNz3A57gABpz3mlMcAjDOkJndWNPAUKrHjvriQi8MJ?=
 =?us-ascii?Q?u+xPNhTmsTG0aLTiNh5nDRhQUmQg6C4qfrY5bQQ9f/UXzP1X603jWAJvex6z?=
 =?us-ascii?Q?WH8XSTIhlMJc95eXHBAp/OKgIvn5AXl4LMXMtpE3OcF0K/DA8DI9P3KVxiF1?=
 =?us-ascii?Q?toUYpVJBX9PT158xBVjNrrgoC66MNWsCnjriJA7g4L6wDSvZjvmFf8hDbiT/?=
 =?us-ascii?Q?bfw00UfKUnfNfcc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?z2RSOHYCc15MCNnmyb/B5W3s15rRLUfMrtoMEexkGpuXELIMA4+01cBs5ylj?=
 =?us-ascii?Q?EHKcoICcZxSUpYgzosX+gfhIvFT69LcCP5sSdMBpOZE1S1wMissIQWDDWllV?=
 =?us-ascii?Q?xbtD8Liw9IwfVPdXUBRESP1S7JV1bZMoRE92JGb0Z0aQDtBGnW+Xx1xXcG48?=
 =?us-ascii?Q?KGXiE9+wTO2yFMHQfyRweJyz3LxDheprCgWBA/KrbmcL/c9r7BOgCxMZLPmW?=
 =?us-ascii?Q?bjNxU3G4bd2YgrWDa/uOLkSaEMtllwZjVXmBWDfS48rPVX4a138Tw3Nz1iup?=
 =?us-ascii?Q?ZsAAUmoA7keBEHsBNAPzuTwcuiIHairkn2S7t49Fw/5pe1qGoxPChPXPfOzM?=
 =?us-ascii?Q?CQdPLLbGBgKuHZG557U9rVqfU7gpeULxQlBLdf7tD7iTHjlGXXqhVhkQzxkx?=
 =?us-ascii?Q?adUpVzvdHq65nXcyPOvUSzXqZfA4HfKMP0MtbqYmSy7GZDoT3nKhSvmUU+6V?=
 =?us-ascii?Q?3Un9JgRMtfirXPxHKku1FVOi2H63ooqWYXxtq6ZcR7vs34MVsANLToAIch71?=
 =?us-ascii?Q?VZZbOZxUDLvXqyKT5Bl6wKtrjTtfSE3HM3+KOUDIPFY5fukYLkve53UqoEFs?=
 =?us-ascii?Q?t1tMjEj3aFYwMfK4WK2G3/wKQ2Jc+I1XpHFDLll9+WpmbUhvBo5PbBhcMCQs?=
 =?us-ascii?Q?+Lc8LIT59pyuaPSfYtykzLPY6k7ZCktrrrpzZCBtJxFwNHjXLBQPVtTbNtDW?=
 =?us-ascii?Q?eCE2ilFN4lKUefpMqQBedOU2JfM79mXMe+lvDt0C/pHVQXvUKYy0bJiZun8Z?=
 =?us-ascii?Q?mo0n8+5ocDXF2Kiw7MFQve5AEdGnAkbjG/km31+Km/rKaDY8z3FJR3+l8c0h?=
 =?us-ascii?Q?tGucfTCWxZOqdD/Jah8qAZKsoZtitSDXcBVAHNdS8VdcNe1x6vJjG9mA98A6?=
 =?us-ascii?Q?zodyaKsLwYHu+6cAtiGvbaknDTNgO2rjpNjPyLu8RzBWLVlhSo6K5JYc33KW?=
 =?us-ascii?Q?G2PVAORlmrhql20kEvPcVgoh9qs16UjMEJjugDD+fsF4+vb+BZ1HoGvSBdeZ?=
 =?us-ascii?Q?JmhTXHkvFNIBvcMEVO9AROVly0RGcyFoBb1+C7sCoHtILQiQ9LWNGMaS9Oo3?=
 =?us-ascii?Q?6a8q+DXGkA5EMzLnfXol9yVf3xQaMaEQpVbKQ+/kgYHkO6OVXXk4Z5j+3Ho2?=
 =?us-ascii?Q?58e0U/m3W/Twu31WbAvGruWknBH739MNSE8taQqVOoIPYjQTDftF87H/qx+L?=
 =?us-ascii?Q?9rrHvdwhXOMWZ+hc40EuySRRay8P7wDRMDkSrL665baES5vUy356goMY10kk?=
 =?us-ascii?Q?wEmxqjOmaYJPJbD11pbP4n/XUj/K/odtQWsfq9myIRgbl8vRCFI37HHVlsBs?=
 =?us-ascii?Q?Teq/NPXzM03+Pduq99pdJm90oh8HMUHsy+jegMEIj7AMEEw6XsI3tN5H0iJE?=
 =?us-ascii?Q?QcBF1e74BD4ZPU8WVcxr+LDSUgt4lLheMryO1zf3HkoBSrEd5IIyxeULk3XN?=
 =?us-ascii?Q?hg0HJwQjvJBwOCI5ywzGinyht9gMI4ZZfr+t6hxZXMXp0ku0x5zpqpBtqxa6?=
 =?us-ascii?Q?g52PF1EgHzyiirvEk/cfuAFlt6fRNF97e9YcRcNPxVrotMWC7m4EvP3SsJq6?=
 =?us-ascii?Q?Btd7BkCJc7KKtsygpLluio0UJordbcDlTAx/pMCYMPWp1kGeZKkdW/lPnNeI?=
 =?us-ascii?Q?7nwlVmNur9ZUaIys2l97MSA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f100ee1d-0393-4acd-36c4-08dde003e05d
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:01.1071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcDGJ7dC5HFa7K2yHC2VPlhro2p6BnjlFFakXU7hXV4xtV+OjeGYiLav8Lv9BDzmcZv9ZuDQmi+OHg4VlxWTu5HamUamCwOV4HvoomdmxiR8FJybUHoQnf4A5lB1mbvI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19896

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 0e575e4eb6574f8530b22e8efa6419836cf1ca0d upstream.

`WARN_ON(!fmt)` check in `rzg2l_cru_format_bytesperline()` is unnecessary
because the `rzg2l_cru_format_align()` function ensures that a valid
`pixelformat` is set before calling `rzg2l_cru_format_bytesperline()`. As
a result, `rzg2l_cru_format_from_pixel()` is guaranteed to return a
non-NULL value, making the check redundant.

Additionally, the return type of `rzg2l_cru_format_bytesperline()` is
`u32`, but the code returned `-EINVAL`, a negative value. This mismatch is
now resolved by removing the invalid error return path.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-11-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index de88c0fab961..401ef7be58ec 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -835,9 +835,6 @@ static u32 rzg2l_cru_format_bytesperline(struct v4l2_pi=
x_format *pix)
=20
 	fmt =3D rzg2l_cru_format_from_pixel(pix->pixelformat);
=20
-	if (WARN_ON(!fmt))
-		return -EINVAL;
-
 	return pix->width * fmt->bpp[0];
 }
=20
--=20
2.43.0



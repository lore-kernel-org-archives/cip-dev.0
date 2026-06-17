Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7625ECD98F0
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:31:35 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.17])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10925.1781685086865668466
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:31:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=dcnT2Iz7;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.17, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPp02LMICxs+/lrni1PsYFA01G3aY/cbUM8M3fgnTyfkY0/GdY71vPcNlGpKPDCPdtI0slKOZ1JRPeeC9bULuJ8xs3KNkJq60DpMiqHbWZkciuPFFi2i5B9eDUy4qQtBayF6SFVrGCQ4mNVdZK3Bm0q4yQsV0BWg2sakY+UAGtTk4k1QUE5c8xQ4mzm7QrgtlzcwKbSiaBwYwm0h/yQ25OXw4rcxAWlpfCEDNRnqFL5gceTDNRzraHeX3UllRAWK5Sosfw52GIRFj7XE5yOHHjBTv2fzHa7bjl3QvTH3f9B/oXwN2KLA4XBp3eLu4hFOy/ehIT40Do6Ql/f5UfnUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqc/fQt+8XlALn4WaRaWstiQaELPcliMgnnkuq0FXfA=;
 b=f2e/WVxUz0TmLVIGSKuq6MplKXVEIvtkUidcPlFeK3v4xzm1iNITzQUQYOgmSmNMQ9lii1V9psJ59w8TIuWmrg31IiuChdhmE8sDFB9JEI/smD5QsGiNTwqQQy3+w03pIKM2j+8Wtnm6567Tr8EtoOC6epue0YC/9o2GX8klxfmCTMuBY50vvUWNpl0Szo0pIFbsKbEU+G1PQkMC8i28czM3lRkoJCySqbS0OfQ3iMFcViTIB/ii4z7k/dxLtAeG9ox/xSE+sTVMSpUMCAZ/K8Y5op31HfzzfXkmIXp+5GEuXyk2rRKtpxfFW93wlUf/9utlkpyWj1QuA369fKxOdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqc/fQt+8XlALn4WaRaWstiQaELPcliMgnnkuq0FXfA=;
 b=dcnT2Iz7Jic45W+0ozvN7PnT1Ur0F7is9ji/rsTkIyaz+fCbzlUajbsLe6BSdcxBmTdeTYIHu8hHXXZj4LUNBLNim9c1WHFxETlhAXxG4euOkALudpmzDDwLJuMI25SxGIPNvaDl/UXma+WeODIa/nEI1qpqjKgU/w7aCqKVQXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB10286.jpnprd01.prod.outlook.com (2603:1096:400:1de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:31:23 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:31:23 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 19/32] spi: rzv2h-rspi: remove call to spi_finalize_current_transfer()
Date: Wed, 17 Jun 2026 10:29:50 +0200
Message-ID: <20260617083003.1071543-20-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::18) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB10286:EE_
X-MS-Office365-Filtering-Correlation-Id: 718b1240-e856-4161-cc7a-08decc4ad0d6
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|52116014|376014|366016|1800799024|11063799006|56012099006|22082099003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info: 
	DNtX1uPYed6QwuoUgOQt4+JOmCkazYGD+iuSzJfdKoIkPK1cCS0bleDZhU31Hpe/pjC0GMXQvbEkruJ+c9ScCELJNmRSm9RYjd7yrHfFVX2FfZlf5J+NWLp5GIX9S5BZlWFY2kU3dPqowWts6RbE4qwBc9hd/W4DxsDcWfoGQ9pBxKL3tIrk6zEHWZUH3/8nY+gaMUlZ24oBo8U5eZpXlPuXvNbG/RI70pLslFiEhaV9++Q2sza5Dyo2kupkXjeY9swh+dwVDPcVQzR/osJoFfj6HUPqdG/ROvr487dfDk8a7v2QtLYoO1jeJ2N4kDVHF2pJdhHx9gpWktjqX5DqiPRMLbcMcF3+GirfaLSyxdnkrRkZHAue5F6bJ/mmqiLipi5BAG8n8F6h+xWNsBvC/E1ZA65wO8Udz7guSCVtUBV/CA/MViB5+yfzx42DP5Y3LIj8sKrFOUfTncbvNAuiErbUyvLmA7QYfpR2LJ1lNddtjXqi3pXYuLsc3i6c3Zk53kbEQQW+CtohO1tMVMcV2PELPaNmmJQvkLdoTa4w3xIL9Oay2mVT766r3xjkAKDyVYcpDU58X0iVdvPzuk7nONCSTUAvGZCbXraPZw32CN00pkCA0S1nfMghzdHRmit1XRPsXkICoM4hSOnPF/jhF7vVBuJ+aguWrPUfsGIsjOwsr1kE10fbZZJBmQLLk1QDJQLQ4lZFuxrCYfqpuzWsuw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(376014)(366016)(1800799024)(11063799006)(56012099006)(22082099003)(38350700014)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?k4Lx1/UlQOgfRIpvf5m5hGNHgrUwFZLUlnBsrgqdkwa0XwQ6ZUflQk1OX+lm?=
 =?us-ascii?Q?ssZMiZE6Rq+j19faQvdVZeMPupEFdaasVgKscsAzclbqNzJ3UlpRzZ8r/U7C?=
 =?us-ascii?Q?oVHvbncfaAZqcS8GfbuGb27wsYTiYWPZ4BN+sk8VLV111Eyg+rC5rR/dX6PU?=
 =?us-ascii?Q?9+XnAMYjVYLxyzKSqJ+vH/PiTvqmeOLbtFAubEPbDCehvqsBJfIQtobaHfaU?=
 =?us-ascii?Q?e51orhB+0hRSpd3Wa77evgIHDVk9cWbATkL5sR2HBg+gtkp1ZrllwamBXodo?=
 =?us-ascii?Q?yCjn4G8/k7OSklpr8+5YTSVTNaQLz6ttreHzpKf2NQ4ZjRasDkK9F1aNJ2DH?=
 =?us-ascii?Q?LugtBUwIufvW3uQfN8xaIPi1LDBpmggz5dWG3U6sOlQBe0Kt3N4cgwPlIAl2?=
 =?us-ascii?Q?ax1rmuoKnvuE6PcDxsZUPLFCFmXCgWqijJwy+hGasz4BLRsEZEA0Y5mTywbE?=
 =?us-ascii?Q?8ODdcM3SqayhxoHY50ALyGFqonGUSKm8LQQLud2B2ynwOUVKtT73yB6RQZGg?=
 =?us-ascii?Q?yPmp+JWL2TL5A8WX7GqfUdyeHVUJHJ4PU5/NnMvRyZ74svC5Djfmy57IDimo?=
 =?us-ascii?Q?g+Uq/a9ElTbC7a6WF70un/YDHL5K66fBmliQLfdn7wRVzlUhkto8TqsPH2ln?=
 =?us-ascii?Q?y+DPRk1+vMP6D34imMyE7nmFH+qy1QBDnp4nAYXJfyv6lCps28Oz5A4fag+j?=
 =?us-ascii?Q?sg55wgR58yVoi04CsICYFhfudB1BBKmByyZvaEmLXrjwd2KbRLSoJ6UgyM2Y?=
 =?us-ascii?Q?EpEiiEPToot4CkhW6vzxidLxTLk9cdqV71OnZeLJm7PIq2XDrEBAp28tb6A3?=
 =?us-ascii?Q?wGBfXOFaxrQRijJ2RxIbcqtPHD64yPXCJ5UzWl9jVGzrAYt7HMpGkvX/9ZKL?=
 =?us-ascii?Q?DceyyZ1c5ZAWaIiYfVrkVMFw3mmzmljzfWOlnYN+5qD/MlC3EwUgGGyeuqLV?=
 =?us-ascii?Q?DXTFMuxM2E35vf+aK6kN027Ah9pIyBQ40CUjomwAKDgEqF/VoUyt2acuZlDM?=
 =?us-ascii?Q?+qDus8drQjhIeJrtE/Pn2FLnpmqYwR++Y30htharsQ/eQn7Gq7GQKq4EJTYb?=
 =?us-ascii?Q?brD+xdQVyOp4cfYqA+HXFI4J0N/WnvSSWIun4zPD5BPM7CTGE/WM2Gaqns2r?=
 =?us-ascii?Q?n4Z7P9B8G64f3JztlC2Dp0iEzHetIs73uLUvlIONLE723zGnH976DCokL9Dd?=
 =?us-ascii?Q?6jTK9D4n5aDLE7r5a8bgBPpHMusz+cQ5a0I6cO31qMrx+TqQaeQyU+wtlqvu?=
 =?us-ascii?Q?WH/+Od9BrOliu1vDNU3W6WnJva08f3+Qv6/cLflCsfl096o062c7wf8kNMeO?=
 =?us-ascii?Q?BEQ51//98Gbq/NGd0yck16VLqlvUTuLpHnG2TU8RKBdRjurNEAO2OJ9pQ2a6?=
 =?us-ascii?Q?3AaMgYaPFzXiTIamTa1/0fM6VbAB2kkddELOm/UE0m4WJ8NOrTNxtjEX14jO?=
 =?us-ascii?Q?a6BmT+dPtSLgqbhHNgQ9AAL3TCE4eCjA3fghjqgoPlaS9ITkvAoycxd9c+Qk?=
 =?us-ascii?Q?q0dJXMJ+mob06+zcv3lL2YIz5RvcJ5kxJX46jWXEWvoV/34BZllM18jaK8v6?=
 =?us-ascii?Q?Dkb+dnQ1ZJ2JNwaw6GJfnhG8fxf6V3851vIkYD70YoxANm3KaqrPjhJz3WoV?=
 =?us-ascii?Q?yvQsVtQ8BC/rN7Z/FivZ1Ycoo3CBZjhYe6uR79b042uONYafi0zybcY731Jf?=
 =?us-ascii?Q?yjHBcykKUttrLaf4p4ayBBJ90ZAKPkR27NkU1Oi84DpIUsjowRytenwNc1TW?=
 =?us-ascii?Q?X6cVUUJHFYH8gFAzvfCnNJT8BthDNGe8kVc5Tyvd/zy5uoKYKdWN?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718b1240-e856-4161-cc7a-08decc4ad0d6
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:31:23.7712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHMyz1skmcH8ktyRRLfDy0KYqvPfox3S4CMZDixPYom5YDmDjujjpG2skpJSDT/FdZ2QAK/PphJuovh7YAZVdhDqldvtRaOU5b04Zyd2SovQf7CHCTroPMGHCLjKp+qx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10286
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:31:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23178

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 9e4830b35dc0d522f45e1ec3ee5b1ff1648afe1b upstream.

A call to spi_finalize_current_transfer() is only needed when the SPI
transfer is completed outside of the current context, when the
.transfer_one() implementation returns > 0.

Since the SPI transfer is completed in the current context, and we
return 0 from .transfer_one(), the SPI core assumes that the transfer
has completed and it does not wait for the completion variable that
would be set by a call to spi_finalize_current_transfer().

Remove the call to spi_finalize_current_transfer().

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251201134229.600817-3-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index d0c8e6fce025..62ca0d7eed98 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -247,8 +247,6 @@ static int rzv2h_rspi_transfer_one(struct spi_controlle=
r *controller,
=20
 	rzv2h_rspi_clear_all_irqs(rspi);
=20
-	spi_finalize_current_transfer(controller);
-
 	return ret;
 }
=20
--=20
2.54.0



Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719D8C35FF3
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:05 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.4])
 by mx.groups.io with SMTP id smtpd.web10.34465.1741778735297012135
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:25:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=M0iCLmEZ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.4, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCt7Swtlub3jIrw36k+wwoN3DoFSNeacYn/f4LuSYCYPit5G8XzBfevxMZBSUTvmW/WkYbZ4dQaH/nRM/ay7HlNIHFfAZXXnx72yJ7CP9oH8A4ew9xtM3XGVGX6x++aoy4iZBaDUl35AaLvapG/i6AGg/4ET3ElEDJJUfmmjBolRA2mAKRtzw41RNs2DMmLlGhrR+ygWO+InViY93o+tuS+lilCAV44aZX6SLaCWOlJlT4dXmTgTlLojT/VeF3lM11PkaoUofVaiwexB9oJ7AOH1Kc8uivciByV5PrEpRUUO5ZvD+Rr9f3RFC7eVCXJrd+7dNBIKJJadOg76d/DxjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAY1+TEmaDbPvxUSc7Bg4Ns5223fV1j+YEfKYa0+SYE=;
 b=FdDrzmA5F7k4xQh1YXdKFS8sVU3e5zJlAFgEZCCBAW5Ip7MvBIpu3+cQRWjaWHS/ZOrUR40KzYmgMQ+Md4UhAY1rAxaHczgTVkqnZ9S3kQWc+Cc+p/c1/5I4tWgyvvJfD5Wima1taW69wvDw8Lpuy1YoTCnCGhphHeOF6KYAxfxTI4Phw07Rg4t8HWrp0m1koaA3R1N20GEXdB0YjT5ZYZZWp4nV9oR97peMOkqdHiSSJPkIlg7YZUuf3fMj/CFJWaGH2cZHXZdYVHwArKmvBy/lbj8eYyNgD+9Lk3qaxrbbnRdaKQZxHLBXe2II3nhUAFn+Vgfav3Yjaki/3Ir+RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAY1+TEmaDbPvxUSc7Bg4Ns5223fV1j+YEfKYa0+SYE=;
 b=M0iCLmEZrG/8DRtJKKxfOT8cxhT39MV8ZPX/QBMBqS8JkRS1bAIKbjjJT9OYUGKuOKeTNOUaz1cE12+hYPAP0/gOibWbuWFgzVhLDptIWique2oWdwEmR8iafecVGe7j9hHA8Z46dpZ3GFI02GO9TyA5U0pFIpqNKzSbx9m/QnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB12752.jpnprd01.prod.outlook.com (2603:1096:604:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:25:33 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:25:33 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 40/85] pinctrl: renesas: rzg2l: Acquire lock in rzg2l_pinctrl_pm_setup_pfc()
Date: Wed, 12 Mar 2025 12:22:17 +0100
Message-ID: <20250312112302.1605750-41-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB12752:EE_
X-MS-Office365-Filtering-Correlation-Id: c5536885-43f2-40cc-861d-08dd61589a98
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tZHJ542dQOkxPqwQdBVKVV6h00Morp0nLOQ3NQlyUayYiD2J3hwqBJXPEc4I?=
 =?us-ascii?Q?zokR8UJw29DzRnGo2OAlnFvnlK4o1PJ1S0kLqhY53hcnG1NxoIai1tT1pLNL?=
 =?us-ascii?Q?UmHicxPpvUhAxDXZgDa4LP3aAhSTfhhwZKbEeUZwwfCOI7QUjF5ztHBq1jCe?=
 =?us-ascii?Q?qABs2tiYfMtB/yKPTaCNJ66su6SDaTAASRsC9GsnEwbAExI8YBBpQz+RJQ2R?=
 =?us-ascii?Q?58YyBLM6YGQOc8jC2n6e/pwH6iq3tB70fEgORjdpSul5E4rFUvORWI62LdXl?=
 =?us-ascii?Q?KBVzz0io69gkWYeaMUL9PJNsYueVzAnaMaFjcLcYkPWtYaV8Ae/+EWHW5D0R?=
 =?us-ascii?Q?CEp7cSsJ9iTUifJGK6Ao/QwN8HCXZaMOYiGrnQvhqtnEYFM5beAswpw8SZbt?=
 =?us-ascii?Q?VIyBDAlRzQYXf/xFAiEk1izSvLhuLvMFtC/W7SnoaPd6O4kthZjgpPaRSoch?=
 =?us-ascii?Q?uGF64puYyqH7B94jdAaBtROTOKHApenKUid3QEz7yEE+przySHnROcky2WBe?=
 =?us-ascii?Q?6y8ujscBPo0x897m18lLZsnD2CQVE6uag1wK50TZvbXSlkyMtidbQVRApWfs?=
 =?us-ascii?Q?jYkJR7OIBt+BdKNcwouLDrKWAhlMpTNk4oGz86BDl5d6nDUO5pnVAogU2byk?=
 =?us-ascii?Q?W45CI+gC20LzU6+LQMrJ/ie3leZ9H5jciDXAmSw4HYJX8L/mUKjcxF624o3K?=
 =?us-ascii?Q?BGxKHWWmXLqd7aTBnB5kPuja2W3H3/JuQ53ITh+zdSHp1kYJ5JERAW0kIQup?=
 =?us-ascii?Q?EmQ5UvP47g8AaQ0e1U0GTKol6hFTF9QiIDPAlSuOGDtl+q5C9hXDtuZz2T6Z?=
 =?us-ascii?Q?ZNcBGXFVZasg+oLa1YKWWfSW7odn6d/ItQf9RPooPIA/gQScqr0Jr8NWl8ll?=
 =?us-ascii?Q?HPKo38f7H3gMPUTxFWYapU6iVUlFgrfF9rbB3MHUgc4izdcC63qaRxvYg0nU?=
 =?us-ascii?Q?81ZnzwmU1hS5gaepamNI0dnyiJBCQNilse0mCTIQrNGRtWSm5Iv6tfYzNa8G?=
 =?us-ascii?Q?7/OvomhswNmyr8O4OVujQwEoF5Jka8Q6baYNVYLPHQxlN+HB/mN0kTB05jB7?=
 =?us-ascii?Q?jOm5F+PNYdYLW/uQ7xW6+tycikwQ3JjKC+pdOYT2hjxkY4OIOQoL4f0ffNWt?=
 =?us-ascii?Q?HS4U/eJeFQbH3CITeXDGbKh6IBzYrLCvXuH1LkPtH9SbEiWHa/s+kdY9+Kua?=
 =?us-ascii?Q?VQkqFUB6nMwydAHOZF7ZK1MTT1PeIV0Z08vgnCnDkTRjETR5+RNYO6pBef4e?=
 =?us-ascii?Q?q4UKmzvrAZPXH5rIuX8qphkq4nrybJ1iuBYk39CchdKQw4I4ha60fEEitCMA?=
 =?us-ascii?Q?0BJiTB/TIWfIq4SSGks2BNiI8alrsX3mmH1dp1Rg+wen9mkTJ+edx7nRJttz?=
 =?us-ascii?Q?Nq6IFlYT010HdQarHHgR9WZok+RKaQtUSAXTgijsDN9IuqsDfZ/RkrRy+92q?=
 =?us-ascii?Q?Seww4I9xB07D4uU6XfzQZzrMMxOwMdnB?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xDUFmDgaJ9rOxPbnebfDmwCbqdBy6KI5CCMDahIHvdI8pvweo4Kzx2Ml6PZM?=
 =?us-ascii?Q?97e973OBAUyJHwuEU82Z3GJ5nIgcow99tQaUZ3gmqJQx8PILd3ovMpk3gxEE?=
 =?us-ascii?Q?2up7ApcDtA4hwBsoxlY8vVfPXM7zxT4LmU0m0398Dj4nbytA2kA55B6EQo3F?=
 =?us-ascii?Q?0yFXCDJywj7UqTGT7nTMf2eOOF0NCxBbzeZgv59sPWY22sgJdUmf6HpqBBsP?=
 =?us-ascii?Q?1p5iQfmnDP0oGXFWRSUXuU7o+jzr8XaUrfVsJGg45II3Vx3LTAhwBas5yatV?=
 =?us-ascii?Q?tsK7XXvM1R/pOoJ41jE+kEi7lML4489xmVoaqPS3HzSgI+VFe7fX3/Ij7vq9?=
 =?us-ascii?Q?ZV50nmCKgd8pIK8V9WcLV4G6awkCAO11Du2a+mFIZqr8LoQpYnJM3jbCOG5I?=
 =?us-ascii?Q?g+ZUq7xzHGPvo1knXZjdhTX25wPxTLMT3UHGy3xaShaQ1yQTt7VltzPvoUQl?=
 =?us-ascii?Q?mtMUUOEVFp/vMdATmAiaQ60sGIRPjHBtswpx0oNhnFmgnFS5wD361KLVkquy?=
 =?us-ascii?Q?8VkcMLnMH4wB8l/VKR6wltJWyhTy/OpoXdYY4J3a2amC7izM86bGwa/4oJHH?=
 =?us-ascii?Q?7HACfdDFclSDOy36GnJxjozMb3FMKOJbebthxXvJdq8Du1C1aLaL/M83NibX?=
 =?us-ascii?Q?NRywJq6BD4VNgk811vYL+fqnnK/stzowDvpuQ+NXvLeeR7X8GOWQuyqIPMOJ?=
 =?us-ascii?Q?dUBxcCWYFpbiQoQQZXoUE1LYTDzVBRuvujx13MjdCWy76R9jn7Zd0bONpnrY?=
 =?us-ascii?Q?NRixJmJLaTj7s+R8lrtZFI+q8R5y5ASiG6CiKyDCbGAsBhHHeaRSYJodwPQ0?=
 =?us-ascii?Q?wiuUE9YF0oobLvSIi0/RoAy0wuKlrg6YsseNS2a5FsOSMWlXL8/NYGvmiOo2?=
 =?us-ascii?Q?IAc+afnC5XKJb3Fwrr9WzPSou/dW942qxvDzZ8u1OYEBOtbTqBQMwehngAZd?=
 =?us-ascii?Q?GXn32ws6IdDFLn8vr36G8J7j0DXRG8/qqN2lGpoc3RPNhevyLKRcGMf42OVU?=
 =?us-ascii?Q?9rA4rTu4Z7WxL53pfE2f2yJt2ebxwRlO5zLJ4n/cA3d/cGnBDYHpGx20ndtw?=
 =?us-ascii?Q?tgr3QHEkhyfng4rgpPKsrVx7Tfles0/KNDZCb4N4ugHFVPfW9l9iqUhMlreX?=
 =?us-ascii?Q?L+JQ/UQuy/3jbp76yebjOkMu8zSIyMJQQwP5+tGopawHR1SYVSSdoZyMvPrq?=
 =?us-ascii?Q?3cPw/QFDlNLlNgdoF6yb/uUUgBcAOZTaCZv6lodAoCwO3alm8d1pkxOQsrfC?=
 =?us-ascii?Q?Ow4Qu4KcAaK5rJ8Lthdd8IyxyIdqoYuvywl8ct2DMJTM4hE7gJEIJj/RlF6K?=
 =?us-ascii?Q?uCtSAx384GPlY4DJN4StIGnOwANzR0IBFAaNA7KE9N5nYaFN1A8CL8G+PAuL?=
 =?us-ascii?Q?ukVvJvr1DY3zP/uUaAHc/86FLQ7Vxu/Mf15slaeTdqzpE7tOivDHkojcOPrj?=
 =?us-ascii?Q?OO9GoYC4h2i3BR+KaocyysivxdfB54A0lKfqgYCmfeiGrzghoJ+u1Brv45A0?=
 =?us-ascii?Q?fac6RAYgRWeTdqOSuMWi5fwnGHROKYoEBV/+c5a0tRPqnjlTpymO9xZeAp2n?=
 =?us-ascii?Q?had1PhgFwC05wBDxDR2WZGVcwTgazYBChQbjoXz85SJ3zkFRDo7HWmxU4xaF?=
 =?us-ascii?Q?ufHL5BCBL8Yebcc5RJGfFUI=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5536885-43f2-40cc-861d-08dd61589a98
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:25:33.6354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRNBmuPG5kQcfeBVB3i1HybkTY//YI34+y4FCx5+jcYFl6LWwwT61ySNChP65vS1cfqSXeLbSO6hogD8yNdtHkzkG2xGNTwrOQsAjWMIGl/J9s+dpD0IKapH12lHqxa1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12752
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18132

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 951eaac107631b26649b00cf5f5d9d7d83d8bca4 upstream.

To keep consistency with rzg2l_pinctrl_set_pfc_mode(), acquire the lock
in rzg2l_pinctrl_pm_setup_pfc() during PFC setup.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://lore.kernel.org/r/20240530173857.164073-15-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 538959643cde..d42ce90af83a 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2541,7 +2541,9 @@ static void rzg2l_pinctrl_pm_setup_dedicated_regs(str=
uct rzg2l_pinctrl *pctrl, b
 static void rzg2l_pinctrl_pm_setup_pfc(struct  rzg2l_pinctrl *pctrl)
 {
 	u32 nports =3D pctrl->data->n_port_pins / RZG2L_PINS_PER_PORT;
+	unsigned long flags;
=20
+	spin_lock_irqsave(&pctrl->lock, flags);
 	pctrl->data->pwpr_pfc_lock_unlock(pctrl, false);
=20
 	/* Restore port registers. */
@@ -2586,6 +2588,7 @@ static void rzg2l_pinctrl_pm_setup_pfc(struct  rzg2l_=
pinctrl *pctrl)
 	}
=20
 	pctrl->data->pwpr_pfc_lock_unlock(pctrl, true);
+	spin_unlock_irqrestore(&pctrl->lock, flags);
 }
=20
 static int rzg2l_pinctrl_suspend_noirq(struct device *dev)
--=20
2.43.0



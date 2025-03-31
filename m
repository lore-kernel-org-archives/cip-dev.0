Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80606C3600B
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:46:31 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.63])
 by mx.groups.io with SMTP id smtpd.web11.48815.1743417990206988050
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:46:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=fnQkVliS;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.63, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tr/eg6TqRE5pWoClTEIu57ofyIWQreGtc54pRp5V+Ab+YleCU8cG6p68hWd56cB9kuW5RwoMxq6eMrVvjHG6iCzSbrVm/XgGECol7Nt8SwMv/rnX1eIzviXnj3nxYq9FD+oCSTpScclnpObbhSj5o4Q/bUBpYrCSDOcLU3jtmPMz/S56cesmqhLDzSlwg3DDyNswTiyGqDnVon1Ex7Em9LkaR7dSDGX+BX6VGBiBbIMyVlGN3K5fMFeULyNlgQb0zyz/j8fwtfj6tV85f+aeJibP3XV4vSMBNNCgJQQM3zJI/jihMaCtUwP7xVv//Nt/0mhFU/qR2uLdT9F4a0M+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWlxXsid7EHI8Qh7l1aCv3e0RK+rMnSjzpAmQ67xAds=;
 b=o0sSh91WfTfurjO8sMjMncxezM1io9YM45bcAYhx5YC5+/2yyKaQf+jsFPadQigZ7xYQvB47NSk8Gtswy1MwmuWfBNYvp33fCm/ywtLFgoodW38RV827ka6xP420gZlAYlY2SdsGy0xwrlh4nMGMLhvhycFLlVHByDeZFIxZtfgPXyFVjOd4v2A7qZHx0eDbVzhcB/BQpqSGcZ1sCnMTAEcJ94PVWpz0fFvh3S83dMdWwKiY6xUdiFHwokpm109bCE3gVYaum+xpeYEftt+KUYOzHR4hARIRXkakgBAJG3inBwDfCrp1Wdp7PVmPzJqPJdaDlenYCmxVabiqpCRKaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWlxXsid7EHI8Qh7l1aCv3e0RK+rMnSjzpAmQ67xAds=;
 b=fnQkVliShOn2SPEXVyuFml05OSd+g9eIdYU1PY5rZXOcEUewIBPB1zNxNJCSvYyKVn7v5WXlGRAxroiTtuyBqw4lZ55SyRK8+EPSFsQVycl2mV2pxnvyKHL8NDuWgVMQdTZ9L81FoRvEND926hrxtiAbSy0sW6yJeaY0lNNKiLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYWPR01MB10032.jpnprd01.prod.outlook.com (2603:1096:400:1e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.36; Mon, 31 Mar
 2025 10:46:25 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:46:25 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 18/43] pinctrl: renesas: rzg2l: Acquire lock in rzg2l_pinctrl_pm_setup_pfc()
Date: Mon, 31 Mar 2025 12:44:49 +0200
Message-ID: <20250331104514.79090-19-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYWPR01MB10032:EE_
X-MS-Office365-Filtering-Correlation-Id: 8742ca16-74ab-49b7-2aa8-08dd704148c7
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?FgB7GhoWDKVPUTsxLFA/C78r+xlj57AFYVRpNFdNCa8JVKwwv6qwbWcYZBp9?=
 =?us-ascii?Q?hKIsw8K+Bwxipfvi1IyvDfUXSBXQEnuVSKf+uOOcUmGyOv1lp2kaFBCpEe6o?=
 =?us-ascii?Q?dj4y+DwdQhdY1AXc7/qBV0ooyDHY/a/sMQ0KWY1Kp7FIhN9uhp3XSC74RWj+?=
 =?us-ascii?Q?uQGfCZgbtPU+0qIS5TKfy8Z5NN3n9SRLQY5AdUA0dKZGqZnZo/XQilWFYjVV?=
 =?us-ascii?Q?+0yVE5avLGL/7twtf6MPels33UCi2C32PfB9Pm+PMMqkbikSSr4M6Pzrj+MN?=
 =?us-ascii?Q?A9DMKAi9II3c3rjeTI3N1LfQo2dIr5gAg0FyTuDBgFi0sFzerrTK0mlxldFV?=
 =?us-ascii?Q?K6b96SltR9XpQexVvSToCk3u+pOaMf2BORHuSrkK4kgm/bTnwhpkxrWo8J6z?=
 =?us-ascii?Q?XZSUjn0GICrUeCDos1O2aym/b6eVspfXHiKvuI60cawCVD23nXBXOFnrgoFc?=
 =?us-ascii?Q?8n0I5Anu9CoL/DN4XxdR0MbPnGePiSRnlbt7kaWvyyF8z1GnQ9vxrdXBzL1Y?=
 =?us-ascii?Q?ONItGTILEZ9i0Mr1tFtBMYNe99mvl6w2iVEz4pqZJOML3BEdE+QrEQYMNlvf?=
 =?us-ascii?Q?QadCcMxIfhHJaotY1LwnoKxSWLJHu8w5Hg9FdcPhJeNZZA9kwEK6Kiw9N+z4?=
 =?us-ascii?Q?Rju1PwYIeCoZZ8GVMFGp903w019ctZ+LtcSqDsOlfT2I8tapYQY2szmS0/kp?=
 =?us-ascii?Q?QASdnGMUxm08ORIojxlkhlJh0MGUfHqO3pjYQmZMmpjVMW7rJ6ff6VdHvs4f?=
 =?us-ascii?Q?/QbWcu02Eu3okC2XHTJgcZuyURybe6TjG3dGdA4Yv0pp8+Il3yYEjygv1qk5?=
 =?us-ascii?Q?wGlbJO6r/ZDQP5W1RwD4EIj+cMgtvAFp9K5crdkrmewDIfvSsfYseHOp0+jc?=
 =?us-ascii?Q?vBswhR0ukYUPDH455aes2I/f/qElX/WfCLxt/EaTOzRJklRkYwc/er3HHEAm?=
 =?us-ascii?Q?obEbsl0X3TeqMXsis1RmdlrJbwKxeinpukK4am06HW4jg/DxiTEEAgoBFshW?=
 =?us-ascii?Q?g8T+Ms+fpwACvhjtwpYdrhaZJ4d3lfWc3f9xrasBDTFuyWlKYfvDxXDLf5s3?=
 =?us-ascii?Q?PqUlIGZ/wauRFZZQLMaC4u6zHgg2TcDWR1HyT4bFmGHVHE8owiIBdENQ1+au?=
 =?us-ascii?Q?F7bTI4y9YTnnfvss6WPEgUYxH8gYQN5mWJU88YwdO97v4HFDOTwr4N8WvHUl?=
 =?us-ascii?Q?KA7750kxDKCkb2fuz3rjObuRW6+9vyOcb1WFtjQS+hC2OudkOipWz+S82+Aj?=
 =?us-ascii?Q?evdaNYdsrUSe0HhmS5Qtqv1auaLpj/Kd2V0B5pvq7RmZzKloFczo1qrfV0Rw?=
 =?us-ascii?Q?++RoaCJVe5oDOYGJG+2JFGk41fBHSmFZHNDK0QX4voyRSt9zfgDc0yr8GO62?=
 =?us-ascii?Q?kDZ2hdhCBywDSj3k5qQJ1qlGx6F8j7JoiMK/ekVsYr4gNS5LNGT88umssSSS?=
 =?us-ascii?Q?g2mVko8MbTn6G8gmK2aZCQd0oiZuVjTDWQV9MbrRQshB2JRr9GrWLAp8ft4U?=
 =?us-ascii?Q?g8r+KZCJnAF3DgM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fIkDtHMtcoy8s5JIsQbjXQbwounjROpU9kK8EqyMikYFtbUz7q2EjHMoH8F7?=
 =?us-ascii?Q?LSBOn360vKjYHqU2tKSmL6MbYCjIzAuRTpgH6YBcA376dLKDql7TeYWJlPN4?=
 =?us-ascii?Q?RfuKdFuytYNtPizyYXh7K8tThcsl9K9STJgVfZ3h/gpyn6CKufE8IctwfRWN?=
 =?us-ascii?Q?jiASt6ZSq6R0a3GQz44u/AoG8tscKp6Xd3syjMohv2yJg4PGhff6m9Q6VgVP?=
 =?us-ascii?Q?Dq3sHZ59Q0Yawq1u7q1/1TyyRHfgIkQMNekF5N1tbew4TGaV89abZORaWHHf?=
 =?us-ascii?Q?5JVOAfdq6/PwOn3j5IC/dyiCWsAvrxytUgwYDUYFT1Bw7jBRkpabb2IFTCAd?=
 =?us-ascii?Q?FBLuklfTD0+z3W83U3RJbhxMAqLHRKvHr12SC1pw9o6afGlFZLZR1k8C0jjI?=
 =?us-ascii?Q?gdy2tmwBCV1Uv8aJ1Mf8ukUmbtpw+ARlKUXX+Uulu7eyv9h/NUSz33DOLouI?=
 =?us-ascii?Q?Jg1so48ZRBsyA5gBZ12l4efuDvyTpv8AuMSrbIZEc5fsfQzvMgZ8P1/r+URx?=
 =?us-ascii?Q?LbGNKBn9UoLReWr5GEsK9mf73EPRP1zoWbKjBUws05nUO00gi1A376WIOyNA?=
 =?us-ascii?Q?P+DRiPFwIKE/R9l8zg+QAjJsrFtAUjnqakGMuRMujMcWlq8ajW+ChpzH74mx?=
 =?us-ascii?Q?cc3JiAZzvQzFdIA7FI/TbkPV5o1o7a45ILsDCa0mdqNUI0hRaAP+uSjEMJQs?=
 =?us-ascii?Q?o88aRZZQ1moYvd94Y49yBB3GDunpcuCvJXAHtl/fCLWcMIvB9CPJR3rDa4sg?=
 =?us-ascii?Q?HXbu0lurkn5LfHJigJolCZ9fCwnOm43mQ51F8U07ysheX8ewxRDX9scmUkio?=
 =?us-ascii?Q?5EjOIV7rjdzYQYHxJ0VClwejxs9ydT5I70gg7AO6mXuekvLyfzW9iiA9dvw/?=
 =?us-ascii?Q?Y/n0vZ8AAVvD4aGLTuKLcCdotsarv8LV+xclvuqWsOGh2QN/5vFJgQJ+pqhu?=
 =?us-ascii?Q?IW5fog1ebHWWDOnuAh0QRegoE5E5Xn6NNvUQH291jzk6hLDAfNfsIPbsTM79?=
 =?us-ascii?Q?N2IZIXNgkx2kSu5/VLKU0QQHNyQp3DJPdMSVAPbepWRHIGrff5b5/FZrJwA7?=
 =?us-ascii?Q?wCLoAgXhUbOdcbMJR4PE7j6y7E7Mmb7Fx2k8clpKr7hrhowR0HHoQpc0ljop?=
 =?us-ascii?Q?PS+CD47g2Lc3O/0K09jqDYFAkDTeQz0z4YwNMVXLcedSrhJzYwnFOGuMpzKV?=
 =?us-ascii?Q?aRHAX5G4u6xv3owvJJQ0P7Z8F7CDU+WyPKfeFlGxpcdmztoIBQjcSp5g15+H?=
 =?us-ascii?Q?bUNhOM8pah8btQZkQxh2b6er8WPMCYAnX/eAr2xzeGY6fJkVijcdhQH2bT6/?=
 =?us-ascii?Q?YG0w9yHj0QH+lL8WhtOtNlPfNwQHFqe1+7Hu1h/x+WS/I/zSwfsA7cXwgDKo?=
 =?us-ascii?Q?BThfrK6KRS+PyqKkaQmiqoJ9iHmrKlPXav4x6sGovYzCfFUMQlUWp12QT823?=
 =?us-ascii?Q?O5vZyZohQoBojuyZA2yjpZT49iwstyxBipCr9X1FDm/4rHda+kp87FCX6/jl?=
 =?us-ascii?Q?SZUfDLYFFs+w6qQgnoP88rUGs1rysh09pi+LyqtDs2UuL8CXB5D5dxOAD9Rk?=
 =?us-ascii?Q?Vj5eu4Tgj2SMoqoJuLbGobPdfJSeR1wLPDPwLLGcJ9BOW9e7bc/CWtRFf0nM?=
 =?us-ascii?Q?cu6nrNp46eb3ZNOU5XsHoPM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8742ca16-74ab-49b7-2aa8-08dd704148c7
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:46:25.3698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/OXl7NzyM9bqRWukBUldeIg6O4l00f+6p61dA5tqmTtnvJA2gZyhakNveGTP/KtlkzleaD9F4wFkWfwMHzCHzNgqenC60+m9v4ATlslZJmk/k9OAtYAgyKvOw+48jaU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10032
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:46:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18406

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
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 538959643cde7..d42ce90af83ac 100644
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



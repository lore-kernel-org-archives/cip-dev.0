Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF24CD4F25
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:42:44 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7018.1778751757136873542
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:42:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=R+oangKS;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.43, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bE9mQP9A328i/ajXFmxMrwHu+q2RlizLL2uO/l/iECALhdskkuPkHUO86h0uoLQeTcjljATzaPaOaGSlaCqKLfPwiDY9t/JtNy9mTgizo9qxEZl2bcrCdXzc1v+dFmNgWQRm1kPj+JOazsGx9C6naTmT1txm+aqoLC3Jo9/xjxWgUi5lj6lx8irwxUon0YK6ex11Se3RppU3xAK4WoacdvPHnsqu7efPFj/Ic3xjOTdnbTS725dAH1IKcBu7pR9JQ9kib38RHwpuvUhKfDTn3m3Ctu1qZ8G5GP0lBGV7JHmim01KHlxlUlhHumi2nVoEdzxTfnJBi7e+rDoBY0jSNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4v4LBguXkMkFuOnnAC+92ZXUyjeouDbHQS7jq3Xl4Y=;
 b=CYHgfmokU3IVt0g0ReH09/wypFNotD7gzdm78moGNxNfuoUO0nV2j2KeobEOBpI43WaV4lJd0rK9QGGUTpE3qckvhqchLN07xIjOchylE1Mek8ZXnpWOgSRcILFjRMmtuDw1ckeH+RUYNiksRsfx/AcpKDNDIQPsKZCoRYuieUDRr0zQJgokK5x5GKwGOfzYRw/B6Ca4HEXzYh4yIhdjgYTSFNG3Gwkz8vtq2KFuolaeuG1NPos1P9sNyFS9a7F+FJapovtz2JxoKINSf9iKNr/IsepkU2DPPayc+kTU3KgsZkINzOUJ1IGEva+tVGygLerWyyLh0tfEL4l5reVYyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4v4LBguXkMkFuOnnAC+92ZXUyjeouDbHQS7jq3Xl4Y=;
 b=R+oangKSM9GYzF2vU2/0GTkBTOpm2kCLEZ1YzR+AMmXnh3jcd7ft6JRuh4ZhCFLU0RQBXqOVXBaklgSBty/yWSaemuMjiH1kOy03WDatij53tl2KvpEvkExiHj+pbNkkitIg2c/JYEVQ1oLExX6PYCHw6cok4c6sJEgaRxaibk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY4PR01MB13906.jpnprd01.prod.outlook.com (2603:1096:405:1fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:42:33 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:42:33 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.1.y-cip 04/17] PCI: rzg3s-host: Fix reset handling in probe error path
Date: Thu, 14 May 2026 09:41:39 +0000
Message-ID: <20260514094152.2215176-5-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
References: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0025.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::12) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TY4PR01MB13906:EE_
X-MS-Office365-Filtering-Correlation-Id: d484184a-3c8c-44b2-d899-08deb19d1f4b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|11063799003|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	qnSlbJDVLPcohtSwratvb9wspisnW64GEiL0eqWPFozWDy+CSVzJ6ngSZpR2vDzL66Z1Bylf1fLDo3JkQ5TFWXRdnJ1dTQ/nF5GPvLWBAYjxTAiS0NFSsJgw5aVytC6moal4qIrKzbziOL3auoZWw4yohXzpknDzM3+IahFuWCY6h6pdsOD55IawpWHvHfU5tDC+j0RqLH0wemOphCPbb6Vwc05iOVqUu5G8ulQAgScSUmqUvVcLQN0XRILdC0RDjXewkKm8VNCQSa+R8BQROKaDoB04pPVZxqNkZWor8ukyX+pP+zvLcyjt1l3KxOYfcY9oHJD2bxjPRJxkP7LrluRWp101fjm5mKL/DEoR88m0SgM11MKKxFdvntXje+g6PWwgKy8Xf9/g7Ovv/x1dXTYdez2rc4u8OiAAxTC8W2GgyYjUND6VUynqJ04K+gvm81VyG74Iqqmqfdi04XDH9se7ck90caj3eSCxYQyhuBC8ZD14iJPyaPT93M0uHUBW4W3GAxvRXUKP9qcC/LaLIn5L1lhcdDf49qIy1rwBsDMyy4Jtn3zyTrmf0O4OOjsJP2WIXfvx6Tk7dodWCABbKC4YyEWsjAXdR0zvWLbr6IYHFfdWSQWu2RzCnlYYrB+VJEwha9bRZVO/bkAM0XUZJnG/bcdMsJ53rZtwLttT1G+oyncFqiE4NwasOR6uVtaJKRyQuJvbokc7owHM9FsYXQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(11063799003)(18002099003)(56012099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qMfvSgA6TuDneME20vYdjr/6GTZgCSfm6xj4QdToCVFdl82k/uLhJLZNa8AU?=
 =?us-ascii?Q?mctDVMjI3+6EWR1sDv38JNYi78eFk2FD/swPVMjtTbR33twwXytfSWP34usR?=
 =?us-ascii?Q?xbgbdw27st0xnhiIYNejyum7he5p6X7FdjPWO3Ti3i+r8YCuXqX/sSEGtDPH?=
 =?us-ascii?Q?j1sJY5Kq6c+05Gj5jrWkbcnSNf/kuPKSqL2hXtrlU9LpFJgFHw8bvCH0INAX?=
 =?us-ascii?Q?hdU4uK3vFj1lBrio7jQGJbjmOrmr9IbBWOaN+6U0dJk+/5tc02faBxozhHQS?=
 =?us-ascii?Q?W/RuUh14mvTpL5CWUKUqa52HVWj7V0731EoPUstLZUVFD+JXtvgElhwPlehk?=
 =?us-ascii?Q?megJWja7Qnx/W/CjC0QbUSFZ4lgE0duRiXc7pgqsqGeEnDt1y6BENuPROMmv?=
 =?us-ascii?Q?IgpvqTGodTlBTyyKoJyLuFhwLdzyK6afHltk0wRR48tOik+A/WHeV/1rh6N8?=
 =?us-ascii?Q?ioWx9Vb+8l/tzb8VYuRRliupBL8CRJr0XPaKSLs99D/2iUxwGyFesm1X27KN?=
 =?us-ascii?Q?4Lkf7mUL+pVAvC4dQoPj0ow+ArwpXAIo5BpiUeZfFNaBrq1E4mvqqa6I3iWl?=
 =?us-ascii?Q?tskkfdnmZcL4S3DDUD5O+LaIyCYI0qRZEy0a6w0vlANq+9HOgHOu4uFcFfbw?=
 =?us-ascii?Q?IoE5HyKwxJFR48kmrkgkc7SiOCeV/OIXE4jupkmMOlTtXEfn9jKqDiuk4tCw?=
 =?us-ascii?Q?CrrC32QiVhVlMczlzMMxHhrLPlQLPbQxEwzvxImMuZTp1oZp3wSw57T5lZtM?=
 =?us-ascii?Q?XNW4wry89soGwehPcBKOp1yyELiJPiw67HzFjy/C/99mzVmm6fsWR8Xq1HCl?=
 =?us-ascii?Q?MtuujgkPhGyhs2NNNgX0eZXwt+WVWJFHTWGwF6S428U4kx44QQ6xPExiSBdj?=
 =?us-ascii?Q?TRQLifBRZihfpXag6pCF2HpLvQ9nlMKOj0VEkahmUJLhJdVKr1ZGEZfaAxvh?=
 =?us-ascii?Q?HGBXPJt+lB7H7oHYTHO62lhuf6r5xZ4jjpS7wYz+2rDw8pwLaoGFmrhajgsY?=
 =?us-ascii?Q?afrv9TRzOCqEZ+RGfsb+UMjRQN2FKSV8dwhzY3s/C3yoYUv+cSo4EKkaU9+2?=
 =?us-ascii?Q?4VLEbVcbvjsLAg47mNgRrPluvqzMNKru3u25tclbbX8usXP6CkVijL/0tLER?=
 =?us-ascii?Q?AwlO5/GD72gVgX7OnlE/XpXTdlMKSKGvykKinYXR6AeEisS6fq07yjIO30Va?=
 =?us-ascii?Q?hMjEjuDxBa0Agpy68UOKA3vkmVUeL2BVPmLL9+WXM5oTeclgMjKL28vqo85j?=
 =?us-ascii?Q?QmPHo7dRJNp1Oid2R8gwC0J3lXcuTu6wU4IKYHiQHhNkPxSORvox1HS30ZDj?=
 =?us-ascii?Q?k41iBY7viI8WVxV7GL1EvZIzTvfqsc6LNIrn94e8PBtzFaYAl27Utnkvsb1A?=
 =?us-ascii?Q?U//rN+FNKQERyXx4Sq38WhqiiOuur3TOxtXjv0TZWyz/3MVXjSQRGppD04IP?=
 =?us-ascii?Q?5923uMhpqFr1/gvn86WE8DK/yXKNe57dlAL1R+OwYXRbJUTdgj+lBNu3I3ls?=
 =?us-ascii?Q?PPGILd+MiSpUUwD+5LC2KtIfZNGYrQ3G2pjBdaft5riX+Ccqcpgzg5f00ZAc?=
 =?us-ascii?Q?LG3s0pOH/3iypMLJxTwmCPPEvKYv7WtBHFQuQJnbhuz1kRHzmeBn6FPk0TE+?=
 =?us-ascii?Q?kQgAGfOGkTfUqxGXY8eD8F4U4hBXbrC52U2t3+MFUayLazbdlajtsPn/1ZW8?=
 =?us-ascii?Q?Zp19XptNpfeOVzuV7TCs19wpgpbAUMD530G5tqa9nG8bq0MZVBa7BFdFKnfu?=
 =?us-ascii?Q?0qNm5ILXXq2kAyq9Wd0amoNattBGu5Y=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d484184a-3c8c-44b2-d899-08deb19d1f4b
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:42:32.9441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5Vcr0/60HaLQFSvvgeS0GMFBzY25BsaiCoQ0aT8nuq6BPHnlK8HvyFQbafybtDOnrcN853/MxWRLPGe5wDtDfOIwKrfsG4Hr2uhuuBUJo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13906
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:42:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22956

[ Upstream commit d284389d4576e7c8040dc4cbb66876e539c6d064 ]

Fix incorrect reset_control_bulk_deassert() call in the probe error
path. When unwinding from a failed pci_host_probe(), the configuration
resets should be asserted to restore the hardware to its initial state,
not deasserted again.

Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # RZ/V2N=
 EVK
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260306143423.19562-2-john.madieu.xa@bp.ren=
esas.com
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/control=
ler/pcie-rzg3s-host.c
index 46be4dba46be..5d524af316e4 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1611,8 +1611,7 @@ static int rzg3s_pcie_probe(struct platform_device *p=
dev)
=20
 host_probe_teardown:
 	rzg3s_pcie_teardown_irqdomain(host);
-	reset_control_bulk_deassert(host->data->num_cfg_resets,
-				    host->cfg_resets);
+	reset_control_bulk_assert(host->data->num_cfg_resets, host->cfg_resets);
 rpm_put:
 	pm_runtime_put_sync(dev);
 rpm_disable:
--=20
2.25.1



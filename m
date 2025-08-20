Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA5ACA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:10:14 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.49])
 by mx.groups.io with SMTP id smtpd.web11.1081.1755706211383205899
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:10:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=BNd0uWH5;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.49, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WR4mMhDNZU852qdTO8GW+6Rx3zr8tQpVwyHvkiJkgNHvpRfQKpKK2yQdJb7++ehwUp4tLyyMYoB3yDuTUpxRCyvXrQjIBSbiS9GadcvJ0VxxeDZRW8ds4S9cRMGpAStT4dVfiCqD7NZDqMrxfmSOzSCTWB5iRDY2sd79lQ65/Yt+3clXFIYG0g26kvduZHD0Moj/mNR/wKqMUZPM4/8Vz+hGyMNWl+GNmqLsQyGhxRj9svO0MdQGxs4iJABYAdbCUiccKaA4odDUEsqyW2QolA54M2Xp2gTyX2ecNKZHLgC8oMt1gLzMtLMXMPeuxYc96PwTXhzVyRy9FcEn+14FPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXD75gMdmE4vHoMeiW9Z85h97ILP+5WYS6zZseSm/YQ=;
 b=CkXXVd5h1p9SEb7eZERcATXJJ2+wrAoML86Sf3K+DsdBOaEmIYfUFODqzWAmV2Q7z8Px1Vh0k7l2ghNkVkzvaUSsdKGzOfHdh26Ub6DdwmAFkpMsmfCnbqr0zdLLtZdZP/yqEObYa1XcaOB3EE1QkXt3YNKmpFm/RXCnT8WAt+yKXcz8/qcBkFxinBZEogRe1mQWFY1wfza27eS5qMKSZULDlj/mYAlDWzM/2mgMcx3lhOt8zmQng1/TT0ldZkw+TH65t+Zckqaosn1OrzmSbU9XtNikng4Qo/x5DfBU3YiSBZH9JxxQk3nnqHuNtZjFJHOiicLsdlvGVsB+IXVQ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXD75gMdmE4vHoMeiW9Z85h97ILP+5WYS6zZseSm/YQ=;
 b=BNd0uWH53bkAqxTTj1KGReQHtSiHp6PQwEjtqXXDCgN2LU++WUYJx0tOPuvMEH/XVPPl9jCUWxI6FUDkZeyvZAH4XrSy+hBV5EpbzlO5ZbLbWDwY0Pa2ELalK6UT+GpKV+85IUNpeVfgJ6wZHVMS4o7G21IGoKaasS3qIvDYaV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:10:08 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:10:08 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 42/55] media: rzg2l-cru: Add function pointer to configure CSI
Date: Wed, 20 Aug 2025 18:07:43 +0200
Message-ID: <20250820160758.801813-43-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB9889:EE_
X-MS-Office365-Filtering-Correlation-Id: 391a9b60-dfca-449b-2f7e-08dde0040883
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?68pOQNEYoFGI7ObbLcM/anuiDK3Z7frbjVQJXbXpX10dv0LVpzPb/aE6LEY6?=
 =?us-ascii?Q?hhSv4+ng3UG7c3aEuljTl2xi6GhMk18zrdGr6jV05lQ/x4N7oR04cRvMJCRM?=
 =?us-ascii?Q?6Wo+ZZ7RF0s/p0A5ssoeyN4IRNxXyuMRCY8WEGnXuE+wj5S4BpPSQCkj3XVj?=
 =?us-ascii?Q?PgUGR860lqn6CqF4hv8JGHc+kWfiKBJYrEE8SATAbrW0nXAD+cpW5yXpZhZL?=
 =?us-ascii?Q?nx/unNojwNb/xZFxYk4k1GtYBOQlzLW4rt68dA7Js61Lx9nOLJ+uvH+mlCB8?=
 =?us-ascii?Q?xWgG6axZpBC9FhTcRS9817xikJomBlMXmJK5yY/U3Wu3ajH22fm38C2uhm4K?=
 =?us-ascii?Q?e2Oc4ZI7iW5MqUpEBknXQUURj+GBRIaJ1iTTnHFYpAb48n9rQVL1AkUQ9SrF?=
 =?us-ascii?Q?8b2K9VP9ssNfOvNBKPTVs/RnwzfnMpfiof92mbxsY07WXO1uqtaon45UH9P6?=
 =?us-ascii?Q?6jAd+EDF94a/G9pXJWKG4KQdRRIo7bn5tHWy1+uYXNh799YXJzlzf66PDI/y?=
 =?us-ascii?Q?MiFao4DKuV0nrm0YEH8eIZZP8gnN3z2SxAobtQy75q6qsVdIPEWnBw6q68zK?=
 =?us-ascii?Q?DaXQIAxld6NLS38VzMOt6/37he+gN2TMPKQLWr1zync61aMphzXWW/YsUa4B?=
 =?us-ascii?Q?afPvHMcSUTLxrU8NLyZBkF+GCspee1gRdB1thRBCa5LKoK3Neh1cnj7YEI9d?=
 =?us-ascii?Q?P1pNJ53vYgl5968098Ean4sMGeNaSqBveGlmA54QdYEz9ND1ivr+3g9JFwGZ?=
 =?us-ascii?Q?zNUEy33nwl2fztXroTbVl63PIeQPQpQ9yIGRnqoOCFlJSeWkvaY9+MJU3zgt?=
 =?us-ascii?Q?o9I7j9LcNh7WMXcHSLGeGTwMORRqLaaeLnQWXtFM60Ahhm7Xz/CoQGcyVKix?=
 =?us-ascii?Q?KXix8T2b43ZXr11y97SJY7YLIsDeznMlv4q2fqz3+RMOJF8Vfg39pZ9T9Zux?=
 =?us-ascii?Q?AGrOpaz6/DRoJCwtAIJQS/VsgCSsmxbBJa6AHl/ioTMzT4SNmBoHof6f4e9M?=
 =?us-ascii?Q?nzkCakAozcP1FDjMeZaKrdKqfgZbFV75wwhFApfYKgedrzuJkkdCz92Cpmo3?=
 =?us-ascii?Q?VjTnT5OkecxCPvw9dMKoiYncIBj8zfgn3odkC0gRQNs0pPnOg/FA60g/SZQ3?=
 =?us-ascii?Q?n3zfe47h0TVbBX3546LEHGmx0tFa4OvLBbFx5xH/h3DUIw+tTF0kYUpga6dd?=
 =?us-ascii?Q?kHH2HFKdBa3WKcFGvZsFpaCw+Pk6co9K8BrolXwGKYlg6GTpz3Hg8suQxHp4?=
 =?us-ascii?Q?v6wbiug75ur3naCWjH7fMhre/P54QR6775bX5rEyaM+kWKJ9a4y3qR1zOUfi?=
 =?us-ascii?Q?e7Y/1i7DdWQS9Zt/wfQ1Z6buxtBIX5XQNR4QdqBY8oNr0f6qraq2llaWTzVP?=
 =?us-ascii?Q?eFTq0nPKTU/sTqx2lKStqS/VJBmehEKlVCy7w26FgDd3bK/nr/UijH5Xydyv?=
 =?us-ascii?Q?G6rX0k0WH8UI4oQRs0YWcZXOYlYb6d5qTGl91TGJAKvcxFc3PHHMTnUBnyuK?=
 =?us-ascii?Q?NvDS35IAfq70Cew=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YErD3bTHpVpZgr8P6p6gjJj1nxOJCF14K+ed9Ul+dGgX2FWZ1uGmFuiRsLrR?=
 =?us-ascii?Q?GwSynfqqli6+5rTAUBeNhxm2US2y32Q8Sfd4QB3bxMAcNq7W08aUlnOhwwwY?=
 =?us-ascii?Q?dJGeVRITNgpFRgnZ3JS9xdSsaGSXLFNUMlHJ7gYLQVPf5MoeTGrDbDlNpu6E?=
 =?us-ascii?Q?Pr7lhw6aIZbTzulHjx8qNEgXXgNxW+pyFVHEJUfG/+zUhJIjJY+XgN9hOPPj?=
 =?us-ascii?Q?A1V4Pg+oUux+45d5D+tswUVDKtS+H9FkOcpNiuFtBJ0/AiSlRzyzRDlZfdrg?=
 =?us-ascii?Q?DkVQ29orJR8bQoZy0w+X5iTPtI1Hb9feVbtRqOO9qvJSLy5tBjPn2IZceXcE?=
 =?us-ascii?Q?R5HzN3MWKn/sUsk6vsqQd3Y2AYOb9c44q0wto2LhmNhtJKQulbMGqjbDVdBU?=
 =?us-ascii?Q?Plk6Q1cHzNofHQ1Lv16PYBZadayPORg5aO4LvG4k8XtCh8nKaDt6iaOGfeUa?=
 =?us-ascii?Q?XEfUggLobRv/i/ZHTl+/b2gfbuOpvSEj2r3CvvAyunApy4qhlaouNnVhhYA1?=
 =?us-ascii?Q?pMWUUX4810+IYJRzsCxmhdkDppqQ2CvhrzKlKKf2696wznlEBkr7l0Lf2utK?=
 =?us-ascii?Q?MPiNlnQSNLJuih19vvo/ePZr8fWPBDtmlWg+f3gEzUPWme6Gx95jw9kD344W?=
 =?us-ascii?Q?uOkWOCsVgGz87ZsNStFPTqeCCfmshAbK6+haT+KqEtgbth7XK7aja2QMrmb9?=
 =?us-ascii?Q?QvTLy7uC4kiK4tONKZgiiisr5Rwuzp5uBbEpGKGVL7Vx3oMTo4Yz58h1zTi/?=
 =?us-ascii?Q?mexUdpH8fKj7fWM06U6GfVXuLClqsnB4lt0e5371rARjsaQHaCHo9O/kcIx/?=
 =?us-ascii?Q?/QlZ/bdsD5BZOdhlw5AsgMIoQJ7Qz1srgQP/W8tOSTgnr1md78EWBpSlMv5u?=
 =?us-ascii?Q?QM9WWGAQFfsBozZQchv2H1S7LCzIOfkWv16oVWJRNTdZQF+al9KYr3JGBkjB?=
 =?us-ascii?Q?FFlv39hpE/YOsqUiAihObuH7XGRQjpzsitsdb60oPl1We+dua6Df5fWq4Gr2?=
 =?us-ascii?Q?HJYqNMlpbKuNqF3kPSodlAGEBEiwkPvJqGLhWV3jspdEeBVLEm7367S/0GCa?=
 =?us-ascii?Q?LadS0g4D9uhyQqPCotU9LIRf2YqYncTESOsp1X0rzy2ZLftxJuEPMpSL+ful?=
 =?us-ascii?Q?iDAoXKYxctni2qt3ZmFHJTk0PpgnGCBNwPVxJTLap+ObH+FXHyBW8rfZAGke?=
 =?us-ascii?Q?JJwxTt+aO0TuxkDsMhsQQE1vgvUuxYLj/Rjl3rEn/4JjhFr9Uf0dI29i30Hr?=
 =?us-ascii?Q?+GfeG2NxfLBa5jJcslY4RF/LJIXYsycVin3KG78uKDc5yAwGOka4hPXqiqlW?=
 =?us-ascii?Q?Q5cV/hntnQsCT27Q9sggDWT85eIpGof9y2NiXOMz87dED0goZzLmN15YoTZL?=
 =?us-ascii?Q?059hSJX9w4TK2UU9l+YAcunmLh9nMIcFBUTZWEL38GnP4ADb2sKAFPy6ODi/?=
 =?us-ascii?Q?MbUqs5Wqd+fYx0NJU2p1mBUY+xrZRXK8vtryRf8j00WZlk7UFZFoEd/XIKKv?=
 =?us-ascii?Q?ubhsBJyzSQplMGQeZo/MUztYo8688DBKESyjiLWepaBzoksCH9oJl+uhmfqN?=
 =?us-ascii?Q?uF/RGb7NrsNEWI0Hw+D1F0T+O2LYUZG7d4iFzWeneQ8pmt9eEdgsdIB+U1S7?=
 =?us-ascii?Q?Id077rFZ3aSSjcQteCCldrI=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391a9b60-dfca-449b-2f7e-08dde0040883
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:10:08.6887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Dwi4w8Nr2sIxGQRRpfjALgcDKBLRyWDnYrpuEHRPxzJHfDPbNY6V+bU66ksNbLsPv1udcTM0bvcwSSPf0qWtavKViJg7AGfqwm53ILjJKXObPZSv8T5mgRxZSJTFsMf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:10:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19923

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 3c3433c5b3a0c34dd36d770e2950ad3377d97372 upstream.

Add a `csi_setup` function pointer to the `rzg2l_cru_info` structure and
pass it as part of the OF data. On RZ/G3E and RZ/V2H(P) SoCs, additional
register configurations are required compared to the RZ/G2L SoC.

Modify `rzg2l_cru_csi2_setup()` to be referenced through this function
pointer and update the code to use it accordingly.

This change is in preparation for adding support for RZ/G3E and RZ/V2H(P)
SoCs.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-17-tommaso.merciai.xr=
@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c  | 1 +
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h   | 6 ++++++
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c | 8 ++++----
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index ccdac9785014..383b8eee22ba 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -360,6 +360,7 @@ static const struct rzg2l_cru_info rzgl2_cru_info =3D {
 	.enable_interrupts =3D rzg2l_cru_enable_interrupts,
 	.disable_interrupts =3D rzg2l_cru_disable_interrupts,
 	.fifo_empty =3D rzg2l_fifo_empty,
+	.csi_setup =3D rzg2l_cru_csi2_setup,
 };
=20
 static const struct of_device_id rzg2l_cru_of_id_table[] =3D {
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index 2e17bfef43ce..ccaba5220f1c 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -89,6 +89,9 @@ struct rzg2l_cru_info {
 	void (*enable_interrupts)(struct rzg2l_cru_dev *cru);
 	void (*disable_interrupts)(struct rzg2l_cru_dev *cru);
 	bool (*fifo_empty)(struct rzg2l_cru_dev *cru);
+	void (*csi_setup)(struct rzg2l_cru_dev *cru,
+			  const struct rzg2l_cru_ip_format *ip_fmt,
+			  u8 csi_vc);
 };
=20
 /**
@@ -187,5 +190,8 @@ void rzg2l_cru_enable_interrupts(struct rzg2l_cru_dev *=
cru);
 void rzg2l_cru_disable_interrupts(struct rzg2l_cru_dev *cru);
=20
 bool rzg2l_fifo_empty(struct rzg2l_cru_dev *cru);
+void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev *cru,
+			  const struct rzg2l_cru_ip_format *ip_fmt,
+			  u8 csi_vc);
=20
 #endif
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index ddd4c2ce12c5..91ff4206d822 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -242,9 +242,9 @@ static void rzg2l_cru_initialize_axi(struct rzg2l_cru_d=
ev *cru)
 	rzg2l_cru_write(cru, AMnAXIATTR, amnaxiattr);
 }
=20
-static void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev *cru,
-				 const struct rzg2l_cru_ip_format *ip_fmt,
-				 u8 csi_vc)
+void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev *cru,
+			  const struct rzg2l_cru_ip_format *ip_fmt,
+			  u8 csi_vc)
 {
 	const struct rzg2l_cru_info *info =3D cru->info;
 	u32 icnmc =3D ICnMC_INF(ip_fmt->datatype);
@@ -266,7 +266,7 @@ static int rzg2l_cru_initialize_image_conv(struct rzg2l=
_cru_dev *cru,
 	const struct rzg2l_cru_ip_format *cru_ip_fmt;
=20
 	cru_ip_fmt =3D rzg2l_cru_ip_code_to_fmt(ip_sd_fmt->code);
-	rzg2l_cru_csi2_setup(cru, cru_ip_fmt, csi_vc);
+	info->csi_setup(cru, cru_ip_fmt, csi_vc);
=20
 	/* Output format */
 	cru_video_fmt =3D rzg2l_cru_ip_format_to_fmt(cru->format.pixelformat);
--=20
2.43.0



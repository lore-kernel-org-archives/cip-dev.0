Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FA0CA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:08:54 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.48])
 by mx.groups.io with SMTP id smtpd.web11.1019.1755706131011798634
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:08:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=LZngSZK3;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.48, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fep5PX1HlhOpn4fw3tDs71c46nZJD2N/PEyhmf9N1Is8Qf8O9I2I5lfShkFJJviSInD3GrF/KBQVhfELvEMajDlgc0WS6TWFJPy00vF6rJQTTcs4ut6YZ1jmOjpXV0RYvNkql0DDyuwQGorcFgxrDesaheuogAVMtYXQTCW4Fow9pZwG2U5Vcu9KGxUeVNNDvMKuBGsNECLHcEwxU4i/zEz5Rr/3ZH9bXHa1Qpj93a7LeFssXNXOy3C0xhmH4/HnelGSpTz4ElIq9aSpoHRC9MtUKsL3yhytr5oXZ3W5e2AJCuQsxfsm/u9HpOdg0CwCEJs+HBFRANFMdPO60642cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hokTZYVcjXfFqZpn7xc/TqKmT99ZxqMuQIiMCmeoJag=;
 b=tJqBSEl9koI9e1aCz8YzeXvAXq55Ww2PdZJFiBW9RnBD5Z7Xk56x8HgQjQpC6guYnUAq/QTJzy32PhHrxw7e5mKnkoQhML7YSIIZx18/zp37XGV8sAC78Jj/0Xne6qoKaTImgxUbMPR9XYSAfEZM5edGJ4LjZ8SP9TEOOQXoOGRWDBBkbtKLeF2AT9KI0s26MIn2wK7mNeGPrdd5VGPyszTHqgd725FxoQvHykSY2kF524nvVbM3YKeIIBgYq9MEu1s4ifjSd/EJfBsRZ6DBF1LT9sogUPxzb29y2EUU6CocdnDLn/nHXo2jRaO5hAvaf7FcebGFape9ACeD422rWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hokTZYVcjXfFqZpn7xc/TqKmT99ZxqMuQIiMCmeoJag=;
 b=LZngSZK3a4Lu8040EW5XlRoQI63VQ/rhgMVHjEDhFX4syJg6AeyUZZD9j7naAEW6zosHmrQR01M2NEv7PuPfLNv0rAJ4rVpsv+i0lOUX56ob4sg2nsJ7+H0S9m+G4PXU6j2NOunAigx6jARVgtkVyaqYs/0yj10MWjV4jsInMZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSCPR01MB15595.jpnprd01.prod.outlook.com (2603:1096:604:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:08:48 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:08:48 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 10/55] media: rzg2l-cru: csi2: Implement .get_frame_desc()
Date: Wed, 20 Aug 2025 18:07:11 +0200
Message-ID: <20250820160758.801813-11-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7a254bfe-42f2-42ae-44f5-08dde003d8eb
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BEZl14NoZtk2MNix6lGtixk5b9fWpRMTHS/yaoiaQ/exS7bQ5dKxG+lBF4AU?=
 =?us-ascii?Q?szWsaukfdMmYkTHZ9sHwetcz2Hu+C77pylwORq5GvvaSBbfPYs4Nw7wzTTrg?=
 =?us-ascii?Q?CfoaxBdSTBuJmNE5+IRyvF8aU48VxpK/uLs4AXoGkKMp7dbV8ZzFGa4DOFie?=
 =?us-ascii?Q?NVFhy8HwTnNEDFpocpw16FCxWPO80MNhJK1waF/SG0iON9N/5fkocLIaV3WE?=
 =?us-ascii?Q?rGA39418GSZmz2347JrQylXNC7VF6eYFQjY6CfjHe9pn9f7SNkQZKcoNC57k?=
 =?us-ascii?Q?3cTLOPBENgsSx/YB7pVI7/M2pWjrycC2yUy6oIrVI1cttlYrFNUgpTAyvanZ?=
 =?us-ascii?Q?Lzpk3nMJBfTxHifvP1PJ3/zf3ha6oLiu0PziFCD4GOd+WBXN/KsPVcVWgv0O?=
 =?us-ascii?Q?Ta7tsdycv8BSQcn6UvmjyI9jsyeIYdbyKtX8q29h6Gru8/iVQSNyLZ/FzV/r?=
 =?us-ascii?Q?/A4JEWd6CLZrwKPr6iEVU8zrgtC0W3IVWDdIZoT0m0Y9VXvML8uQ2Eule/BA?=
 =?us-ascii?Q?5eDOdIn8sHcM24kmQTJr+St/1QN+3HX/YrxJALuiux/40DZpHd596asfrLPi?=
 =?us-ascii?Q?IcgwKURW9Ibe+UnwuytKXDr8niRcQYgzUJJwP5IyDP/nIRWFauZ0Ba9l9klb?=
 =?us-ascii?Q?5HK6/FkXEnDrIAfsz7kwwYiaC4a3xqi56na60OayLjox/8ph529YeZkgh3cu?=
 =?us-ascii?Q?eYs0QjT/Vc1zzrsmC/MfJZjTTwPlPGiXoTJHUJG8siNG9ijnSI7D8za9qK34?=
 =?us-ascii?Q?NxdgC1C/OEj7/IkISyUxnoQDymRt2OQclYC3nXYFvisOpuh/Vz4Syhh4ogcY?=
 =?us-ascii?Q?Noq2/wCQaX7WGDTfdJ9tB23hoDdMAnuMio9Fi/RzjyHPTm1dv1SDdXdL+oOr?=
 =?us-ascii?Q?MHkGYTQbjn3yy+LAwii478IKvtkAlC9lx3F+PQI2RAk1taz7xZs0+NyIkxUG?=
 =?us-ascii?Q?Cm0w3rnBoxoLq5G+iV8Ydildsy2ochUg06hyGJTdlGthnD1EKJxCufBBlIdO?=
 =?us-ascii?Q?Io/0Pb6aeN1Y+l5vJ7J+wqPmdTtymD+V+dqV3El4OUr+nj5C4sksJqWMUnoQ?=
 =?us-ascii?Q?KRN1qf+e4GPckTa7qwmhO2N7giBqxrI0Ezc6AR18th4VdTIb2yMdbI4IIkmU?=
 =?us-ascii?Q?oGbZirFLCOT1yKUo//3T+nV20J0/LfBm9IPXIPXaqitdZy5ureVDSnvXNIkv?=
 =?us-ascii?Q?/yYKuVgSWhisRjUJCloVJ8fr9ATbifNZLmZ1s6Pm4bfsiV2Tj1zWKHRTB/rO?=
 =?us-ascii?Q?Q3qaPUY1XvrjBYj3DwDnRNcYzZVfc9IQqrQHzuYardJ2tu1csUJR5adJTv1W?=
 =?us-ascii?Q?Lqh8pzFSE1kJkB3PoP1DmK2T1VeWDCxdC+7w/lZ+OlSOJoUga3l6277T5Ya/?=
 =?us-ascii?Q?sUDiU8wR9kN+m/B7SK49LK2lQIMFi+jno55FBBS0oS6c7oUPJWKfPZrDNy+8?=
 =?us-ascii?Q?QlKEH0jIiz5SV1N/7qc+W48ovSn+IRCe71gdtiUx7XmxKOx9pjs1y2DFtthz?=
 =?us-ascii?Q?ohL6bahHOyCDczE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1Wm0ITNkDcUl3OYNLz0/aPWyKU6SBaDspxCplOZ4u+/zUJ8EBaQRBTdG7KL/?=
 =?us-ascii?Q?PuNBaRe2TNff2OisEiEsm+4gg39H6Ox3973JPdDTqzDIHM9PG5GsmDnmpvd3?=
 =?us-ascii?Q?JTMJo++PcZ6HRHOjv0swV6elGTSUQxXUK4NoptPFX5A4wuJWfgroz8ZaPDIr?=
 =?us-ascii?Q?XqOCcHrVG8fF2jUjb8ejE8LxPLKlQSUWY+If6tzGjIG5P6Alwo5vGok6AnxU?=
 =?us-ascii?Q?agZGDZ1sMZQSjZkxux1nOlOkb8KjARxMUAh86wy9SLcKynu2kzFAHOYs5/RN?=
 =?us-ascii?Q?jjNRnEkF97VgWeWgCMVuKXbEs8ma3pQQIyd4kbWkShIr1LBm4VdyazVt0lBR?=
 =?us-ascii?Q?kLeLlnS+Tf9HWj/2+nPoHZkGwO+wJY3ttsy0G1mMujzhd3hJZWrbhl5FsAtw?=
 =?us-ascii?Q?Po2laH37r6ffNknR/nIJiH0x+yCPVa0vCOhdhUKnZELfQDomMyuTeByxZi0J?=
 =?us-ascii?Q?lcVtGc04IjrIGa+UTTIan8WfodthqErgdQzRFvO0iNdnkyEXtW6h8C/ln4ZZ?=
 =?us-ascii?Q?u90j7um+GxH9rjK0V4neuiRQZFRl3MMNAnUDprsOSjAJ+X/YFwlJe2HvKaBe?=
 =?us-ascii?Q?m9VxMupmHxAZnLHH2DSBDJzzoZ4pLNBtjshioYmV1Wcn7jw4CTM3a42ZgLwo?=
 =?us-ascii?Q?NeDNy6MO2UqNBktOdq/3Jg/4hiuEqF4bhqeVlytkW6G/g+Qve/5C672eK3nN?=
 =?us-ascii?Q?E4jjG7aGGGZ22lf9UX2GXPS0PWUhawGF/XcT7/djdLJiXSfP4yvUxgGneUk5?=
 =?us-ascii?Q?lGCP73crj/OeXjTTSLepE41zOU5KoBEX8WkxfvY+S1A2OFJr0H4YJ+CyDHae?=
 =?us-ascii?Q?X+NJbMTYywcLNuMvGKDBI+D7qAZQF8GrkrlgLaGHQc9LrBu4PJ8WnZk0OeDu?=
 =?us-ascii?Q?zSJWNDx1fItzborjgoF43zG0Z9d0/WeeOSHy9OrojalxNJ+3zeGjC9XYq4xU?=
 =?us-ascii?Q?Ea6bhXarbUXRCnAH4dQAcI8FZB+AWvJMV/o9O12lNeGZ6pgl9HEtjVCBWRRF?=
 =?us-ascii?Q?M92NuMCSZ9qBnhYSmBJu48vnrOioKv3LgpDxnjPR4064zirH6IIZK0h7Cisz?=
 =?us-ascii?Q?Y0k7yGiCYJAg64ekM456FsXcuPBLh+utB17DxkQ5yIuafPQgSm8GYkc/xUzM?=
 =?us-ascii?Q?PXQoTTvqKpdzRXKvy0BHqnLgH43YpKujxMmHl8vljUh6t21L5lJdUJxKpG6J?=
 =?us-ascii?Q?6+nvRa47xF5sQLwj8q8m7Yyf8zX4w5DBg9NOnJG5WNGPwYp3zh3LMeXEvkM8?=
 =?us-ascii?Q?cio6L+5euQn5pL/gQTDlCognCSt1MutCeopn5bAVfUyaYpjtYllMDkmerDeF?=
 =?us-ascii?Q?VVO3eFkQFIrpYpspuITrwl4nbaDpO/022bspwfiENJL1yR0PZkLSPECioMEN?=
 =?us-ascii?Q?Mswg7uVZLotawD72Fb+7spBl4hbR1hk45EnrXu4Q3xISFzJ3aFcsVc1wA1B7?=
 =?us-ascii?Q?NRsIVgUqYvCU1wWDLPYRIrzAznPEWNVobQyMi7lrri6X8D5Ckegqx9pOw3Y0?=
 =?us-ascii?Q?cq5irbSspMsMRSH51dyVpPHkCLcIZTdoLGZFNE1dUeh97xtz1R3f9PGkypb0?=
 =?us-ascii?Q?uYNuQr0diF/3Qb05FncdAx1e0uO6yuS4BkYbx3Rga+YjB7crfLh6egwBZ4Ue?=
 =?us-ascii?Q?snAUh+2rtsn9IZW0Rf9B+K0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a254bfe-42f2-42ae-44f5-08dde003d8eb
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:08:48.8192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZDMzjrmdvmew8Euh2U579b6/IVeCoJJTvhUISAZeHbkfrky0hbL3/AJGdwHykQ7x4OlTqbfdGReVRNf6UiPqECjCp5j10tCrmALmKjTObNt3n3YCpBealXw4d2yZtSz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:08:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19891

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 9e880cd9e9e8c2e54169e317985b61aafca5e2d8 upstream.

The RZ/G2L CRU requires information about which VCx to process data from,
among the four available VCs. To obtain this information, the
.get_frame_desc() routine is implemented. This routine, in turn, calls
.get_frame_desc() on the remote sensor connected to the CSI2 bridge.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-6-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-csi2.c   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index abacf53b944c..3fd0be6a3b65 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -582,6 +582,25 @@ static int rzg2l_csi2_enum_frame_size(struct v4l2_subd=
ev *sd,
 	return 0;
 }
=20
+static int rzg2l_csi2_get_frame_desc(struct v4l2_subdev *sd, unsigned int =
pad,
+				     struct v4l2_mbus_frame_desc *fd)
+{
+	struct rzg2l_csi2 *csi2 =3D sd_to_csi2(sd);
+	struct media_pad *remote_pad;
+
+	if (!csi2->remote_source)
+		return -ENODEV;
+
+	remote_pad =3D media_pad_remote_pad_unique(&csi2->pads[RZG2L_CSI2_SINK]);
+	if (IS_ERR(remote_pad)) {
+		dev_err(csi2->dev, "can't get source pad of %s (%ld)\n",
+			csi2->remote_source->name, PTR_ERR(remote_pad));
+		return PTR_ERR(remote_pad);
+	}
+	return v4l2_subdev_call(csi2->remote_source, pad, get_frame_desc,
+				remote_pad->index, fd);
+}
+
 static const struct v4l2_subdev_video_ops rzg2l_csi2_video_ops =3D {
 	.s_stream =3D rzg2l_csi2_s_stream,
 	.pre_streamon =3D rzg2l_csi2_pre_streamon,
@@ -593,6 +612,7 @@ static const struct v4l2_subdev_pad_ops rzg2l_csi2_pad_=
ops =3D {
 	.enum_frame_size =3D rzg2l_csi2_enum_frame_size,
 	.set_fmt =3D rzg2l_csi2_set_format,
 	.get_fmt =3D v4l2_subdev_get_fmt,
+	.get_frame_desc =3D rzg2l_csi2_get_frame_desc,
 };
=20
 static const struct v4l2_subdev_ops rzg2l_csi2_subdev_ops =3D {
--=20
2.43.0



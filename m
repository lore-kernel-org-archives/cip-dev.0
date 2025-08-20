Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D825CA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:54 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.1])
 by mx.groups.io with SMTP id smtpd.web11.1060.1755706188147995207
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=brflrw7X;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.1, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6nj9GlzLxfQwnFYsqDJRIIpBz/MAHMYyaDlLiDxL3reorW7ljuedZN/vSSObAPoQMR+owYijIkshRezA2m2iyTlW333Ez94QhM75WEjuphc6/BCcMI4mhDXo8S9GviKHSgvmcgmQs8xYYnrOyanEfEizwRCjgtFG+mGjm8yJSqYaU3AZPibo3tW8a/UNP7jh/ws/1gmo3vkh8LZrEd/1xbYymEk+ck0m4Z9OAy+0+HfmzHSLI6duK10D148lPQ9R6/q5nD0+7dYUVik3fxZKUN4Lgh9fZHI57jEXtOLFT37ee40wFWAyi9x0uKw1N2cyaFMJWn2eLeA98pOA31c5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYvrfpPKWy83RolpTn5ZZlzDYBFMTgH0ooYHnBWFlaM=;
 b=HfeiQkGVqkMooIDukr8NmiX2LWuISqy8+d2nGMNao1oIpZKrgece6TwdwwvAbNj7HpT2zwrn19olqdzF+uTgJVPT92heDsYgLD6P6wK+RlTMfe84rAzWaA9+rgka83UATPP/uKcLO6Rn8SeCN1z1JXzK0Ljlmmr3+tv6vELDJXsU5yiLYZ+o2W+yNo8dMkg5h4s4srwVg0/GJ8FBC89L3TrKGh1MQQGRKOyA0xRdesF8WKhBHNDunu95i8d87MedsoHtrzMNdFOJDzOm/j9puOjGLxDsznju1ARrOtpHSKeg7HwqZMW5m+LMEOcl6ydBStjIZidqfeM94TpNZX4pcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYvrfpPKWy83RolpTn5ZZlzDYBFMTgH0ooYHnBWFlaM=;
 b=brflrw7XeNr+Rn71ilggGBvmOPbCndTIV+olbDzoBa/nAm3NO+wXrUjlM76sat9gjwKyGR9GxBrZ+HcLHnwd4tnAk0fNV6JnSi/3SUlac2TBljlHUETDxkM8WNEExeEQwUtp3gx9CYrKPPv9ChEDdYDJdbsmHzA/s8RE+6R7tXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:09:46 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:46 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 33/55] media: rzg2l-cru: rzg2l-core: Use devm_pm_runtime_enable()
Date: Wed, 20 Aug 2025 18:07:34 +0200
Message-ID: <20250820160758.801813-34-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: f0af7db0-03e2-4258-1db1-08dde003fb2a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?toHD0Y4thGTGsF2APqR67OUz2SMoO8w1XUiiUslX2aeUmLwljRx7mqlfZKAN?=
 =?us-ascii?Q?Cnn8PL33E45c89v5iel551qh3MqtOVvEseYVr20Np9aZ9bUjhoChaqSt0sQD?=
 =?us-ascii?Q?9CK8ejVR3GmDZe/qB58YQ2QC/fZJmvtWGCKmwZv+fpzgkAhR3KjddRKzf7GS?=
 =?us-ascii?Q?TI/eWqeeL+AE/kPio5kckmrP+6JEkaalhbDBLtpux9mmwYOWQo6j0jtxnB3P?=
 =?us-ascii?Q?WVGD33bhZIBOR+yjar8VC3qBMIbZRc/cNGeICXGnPfpfGsKTTpjNBeqcK8HL?=
 =?us-ascii?Q?PtGXdzJJosLwKLK7QfHpJ17sHVu9iq+ZOt7/qmJrxWGtdgIet/3cQXvdaBSK?=
 =?us-ascii?Q?HHwl8/j39lVTfZdVniMW7GWvFrIs4842Et3k23upJgkLegTgVMnK0w6VJ1cC?=
 =?us-ascii?Q?H4bxB9ht3x6egK9gpsG1ko6BKYYRzguUdUcFYaT/010cco5pH+m6pa47zgE+?=
 =?us-ascii?Q?HA77WiQ416LDJNuZ2uctyLvv+xcM0sw5WrVdLPGvo14YQDbDnZP+ndrotI69?=
 =?us-ascii?Q?MhBjnysZO36CFiG4MjjW+mdAhKXlmuKUq6dS06S6v6V3yz4SMOQ9P7SNk57L?=
 =?us-ascii?Q?pTKYuS1qxlMUjWdGm2OkBVyTlv+Jwf0tiFTgLTxW8W30D1pXbBU+CO5ym2NA?=
 =?us-ascii?Q?5x1sE7N3FPD5w3D/5MqFOKH/ynqwYCxIIUOiY39iE444UiYXbkYSWtCDAFWQ?=
 =?us-ascii?Q?hysDN06a422Y5AiQvtIiW7LhiluC2bydmQkjSqReVdB6gloku8tRM6wskX+G?=
 =?us-ascii?Q?XlXhHWwQzxw+Mx6cmtxGOCPylDanKRsSQo/vARyGe1D/PvNODh89Hq/ZKw8y?=
 =?us-ascii?Q?9Q8sehzu7qNp4PLOwpwuAmdumnSZOjOHHegO9I+rdLpOh1SYb5x+npf+SONb?=
 =?us-ascii?Q?kAbtnsOvhBJZVPVv0lUIPMTtpEBW9yX7f5OW082/iBDSfp00aoKqBb9XGMN+?=
 =?us-ascii?Q?1bOBkFEZ3KdIRm5s90UJmTIFRxJcU+72+SpekkaxC5iGTOA/L5SiX4wMQaRX?=
 =?us-ascii?Q?ylWT+SqSomBFfK/SDK+6iH5pLboCS9lqIfL9PYtjlZRBzcCIO0IYshaPoX4b?=
 =?us-ascii?Q?8YNAcpHYbmOgZhwxeZt4Ma6JnOJvyrjOcyOyH0aM6+zhWIyftiIRzjM0ZdPg?=
 =?us-ascii?Q?uimevreU1PTTm0mcx7z3zsj/KlSw6dWHQSldNkt2fkas5zmutVaPhII1zcGE?=
 =?us-ascii?Q?/ynI2PoVmkOqP6rKf/qvPeZrY0JBMQOH8j4gWZ79CbasInEHR/J0QSCcDzAV?=
 =?us-ascii?Q?e62Dhts+VGsWvDnPGZyjEvG6fRP+6psVw4MgnnpVPCMOi1ePFNe8TEQKsmWo?=
 =?us-ascii?Q?pcIKi7BZHBAJ/BR08j/WbZn2x2BaChYFtmpgcMF1diNVBBy5IWQuROZuV19m?=
 =?us-ascii?Q?AV1psY2XKm/jvktA0i7Oo9W6PUuPzVZfx+yWnJ7Vot9O+N6GkSR1sIfd5KyL?=
 =?us-ascii?Q?Nc81apykPzbKvGWP2mTIKulxMBFjo0llvYJZSYjurttHqLczYgcMxMSuh+cX?=
 =?us-ascii?Q?s7oaGFykMoxeHQQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rtQu6CDqMPZIF+NvyBLxMWMzWGcIXUT3PoZ100HAalROSKB1uagq+575eRL6?=
 =?us-ascii?Q?gsb/hDlSQxRMxmbFgscScdms8EikLogIc8DOnnkE3703SGV1L+PrMVyty21A?=
 =?us-ascii?Q?cF3dOP5+mUj3iVtPPCB05YOguh4LBFqjsq2AL0r5Kljkr+ZqeC8trZYN7jVI?=
 =?us-ascii?Q?acqYPPZcQ/qLK5nKRlDpSY/h2acXK5zZSqe92Q2rF06Ogi8dsnELAyA9GeSu?=
 =?us-ascii?Q?fPtxR4ImesJ2P07g1XMlAsSIwACoAiRD+SwZ6ZUVLQgVzr9sRvS3FV3iEN/F?=
 =?us-ascii?Q?zu2MAJ4NrWfk3aRi6iykWR3HE9a0sHkED6DZo+ExMfswNSw/ZcOV33gBBkYL?=
 =?us-ascii?Q?FsRFb/6wnt01s6vyWwXWWchHyK6WTICG7oJ22F4U1eICSsscLDcPhzO8JyYb?=
 =?us-ascii?Q?wCJUP7JYLCU2YPRl0c6odzhAny3BvKvmJfmpwwQ+AGdbYYfuzhRKBl+5x9xK?=
 =?us-ascii?Q?VT5WJGdqqTDey9BYFsEAuoJSXT5+Xs1eX0P0dOD9JE7M6wGI2ZhJvEj5zQ4e?=
 =?us-ascii?Q?k/mqOabQRezf/VsbageFiHo1fQs0u3BaQvnCQA1p6OJZ2MwWw9TQ3KvLpho6?=
 =?us-ascii?Q?HKudOLEHbQlThzBH9yU5WkSZpaRPeFpIXySfi92KZHAleRKoWKx96MGKbiRt?=
 =?us-ascii?Q?VW00UXp/3XfsZosNaM33gBOyp9pIuiU05tm5gkzlu8N3S1WjLfjF0SsBkQYv?=
 =?us-ascii?Q?x17DifKgcYIFUobU6UsmK/9uuoZHPLE5nJbQqPJOP9G0BmYfvAqCTWGUoKSJ?=
 =?us-ascii?Q?Os72FR5Lut54hM/aOBQp03WYs++KlO2S6/k90Rxlh2LvbNoSkuItGm1d6eve?=
 =?us-ascii?Q?vMouXmZCMmQOi1pppbkbsefMxDw7GLRPyjJVSTweE9xnMnzEnP/9bH2CtJyA?=
 =?us-ascii?Q?zijUwu2JAyMGsdoSLrFx31/h8If85bSjL3tnWkSds4rfxbD5KOPEnQawpDOZ?=
 =?us-ascii?Q?coYvgYC+ElTziV3mDRhR4xvVq6SEuF1vJKNPy2KnieaDZnTCSpfRzCcvADnp?=
 =?us-ascii?Q?y+9bdnftMf2SDDO6dJ5nFj6aF1JdZnBTq+oIGPqLLW/gjsTVBSLuT4OBlAVS?=
 =?us-ascii?Q?osTMKWVn6RHuVlaeFPtKKZdpg0Z66EHk4ThwF2kiNnDMqjwkseF/dwMKJ5mW?=
 =?us-ascii?Q?c7utyd0xVM9Us+aEtK7LS2hJSGWI7cR3cFRrqxVcczYC++BJXMUiTd8hwo7L?=
 =?us-ascii?Q?seQkfrXU6XgMOHDr0fburxrIFoXAbej/dr62nIrBvuNjcX6I7wT1Km23/JbQ?=
 =?us-ascii?Q?v+OXLOc0mo9+Ve8t9JHXz5e473xH85QiE0yqX2Vj+W+2PTNTYIkkWd2sYHu5?=
 =?us-ascii?Q?xbn4TOb/rkkY8+CI1l/ilnZA7BaMPcyKYkSqzbgGuJqI9sLKR3tEH9ZBOo59?=
 =?us-ascii?Q?kSFK+p0/UgiMs5zb2p1DtduO6Zz+cOoovr5YBN6VaQsvD6/GAVnoPNONo7DS?=
 =?us-ascii?Q?p1Pt3tsJINO4trtVK0DsnpwJlhlX4gXyd98hdL6CcLk+ttW+BQsq5256tpsJ?=
 =?us-ascii?Q?OirkopQMwFpI+sQ/+w3TqixvN4kjtWrVyOYUG/e+l1Ex1y8O0+iNVWyQ2oRy?=
 =?us-ascii?Q?mF6yagpFJijjHBXXHpysoglShzCu15fWvBMPOXch+iaxjOU8heI4LrK47tJt?=
 =?us-ascii?Q?wId0qe0k+/fwggCo2plKc5U=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0af7db0-03e2-4258-1db1-08dde003fb2a
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:46.2773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOMYEHJB+ixRZxoCrsCS4Rj2IOMU7zwIPVu1b8CFivU6omaRQgNGwK2uRi7Wm0wyNLprbaPEb16ITo4sVXgOFuOhGbrRY65nPGasrAGSI7nauDq73GPdcEbfWEdLEoAV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19914

commit 2fc8cfe06e7628de825d53128fd38b3f0e19c989 upstream.

Use newly added devm_pm_runtime_enable() into rzg2l_cru_probe() and
drop unnecessary pm_runtime_disable() from rzg2l_cru_probe() and
rzg2l_csi2_remove().

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-8-tommaso.merciai.xr@=
bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index ca8b266e3eb6..4049d3f5a88e 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -287,7 +287,9 @@ static int rzg2l_cru_probe(struct platform_device *pdev=
)
=20
 	cru->num_buf =3D RZG2L_CRU_HW_BUFFER_DEFAULT;
 	pm_suspend_ignore_children(dev, true);
-	pm_runtime_enable(dev);
+	ret =3D devm_pm_runtime_enable(dev);
+	if (ret)
+		goto error_dma_unregister;
=20
 	ret =3D rzg2l_cru_media_init(cru);
 	if (ret)
@@ -297,7 +299,6 @@ static int rzg2l_cru_probe(struct platform_device *pdev=
)
=20
 error_dma_unregister:
 	rzg2l_cru_dma_unregister(cru);
-	pm_runtime_disable(dev);
=20
 	return ret;
 }
@@ -306,8 +307,6 @@ static void rzg2l_cru_remove(struct platform_device *pd=
ev)
 {
 	struct rzg2l_cru_dev *cru =3D platform_get_drvdata(pdev);
=20
-	pm_runtime_disable(&pdev->dev);
-
 	v4l2_async_nf_unregister(&cru->notifier);
 	v4l2_async_nf_cleanup(&cru->notifier);
=20
--=20
2.43.0



Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BF9CD98E2
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:30:34 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10728.1781685033650250753
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:30:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=bk/e1qX0;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.41, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRUp9WHh9OTOwNNogCYQJS284KgheMiYW6gHoCPPk5NAn7+faaxWJrft1FQGC7+otULh8cCQOV4B63WShxnk7HtOFETVl5mOItVmoOkLCHMNZZEpJsDe6MJQUfm++lqs/i1l7K46/QA1kp8E8conGpjO5g5HDClSGRdEo4oHOXQniXXbPVukcDHnlYG343Esdzp8htJXP7c8McGrZxBH8Cn/E1XyDi2la5rzPSbAjMr41Vjri+b67qecwZS2os1eovRhs25ykHoH2QZOUmNGpwOcwG1940RxTAuQDQ5KovPMpkK8YGm8yTj8P9nCYdPfbZhpABSeQ/nEParNbdZ8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5Q/xr86yTPwl8R9K/FAwbfbYYNV/t3eIcEfIUCg/Wk=;
 b=vqMdLzfl8GMLzIpJPgjF7Jml8wFESSBUVO6WmfKFEcNISeIm2FzyZcgS63HUL0LZFkOw9wFpgLbIPpdOayf10munIpcq2NgSU+KRD5p3zzX/8VPfeyeqSa9cWBl38+sjDcNAWQHFuFX2M4L6j+i2bWoW9x53tyPzTBM6nCtKQUHXCMy+wR5vKO7oL/DaptfcP0A6fn0Gx6ImPYNYh+u2mTIbEa2bBdsUyVamKvIr0uqBuOuax1mWsfb2gJ90gN0a7OXCZPXcKK4L32gCQI8cMH2S2gZPUdrfQoHBQbiDcyI1adOTa4IkfDXk2siymxawKgrMrhuqg5N8gOHIFeHAzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5Q/xr86yTPwl8R9K/FAwbfbYYNV/t3eIcEfIUCg/Wk=;
 b=bk/e1qX05c97HSMaVCO2IYmjM5g7ytd+rAZ4XaBikeYuxt4QJu+AeR1ePFKp8SZIlxWKqj+rUNJqA8ZgzXMuxlHy5fal71/upbP0U2ZPlb9NL9oE5/UdK/byxyWHl1BoqtNaqUwpXlVvXA5LYlFQfXXDWQ/ndXUJnBGrX2KTSGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8217.jpnprd01.prod.outlook.com (2603:1096:604:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:30:29 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:30:28 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 01/32] dmaengine: Add devm_dma_request_chan()
Date: Wed, 17 Jun 2026 10:29:32 +0200
Message-ID: <20260617083003.1071543-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::18) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa10ccd-789a-48c7-257f-08decc4aafff
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|56012099006|11063799006|6133799003|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	TBylQv4MSalP9BgvZY80rLy4fYzOsDe4Cyv1VGq8us4kScmPorpF4c4vfZvLm6wk2hBjOwIbd63WtjdVzKdyr4SpIU5KsNMKIsCEEpvUVGNzLCp6F3Vf8o15q4Wa8+HkpR5JNQ73l1/nisM1H6mnrb4k9VGL3nAKEJEx7JSiKPOSSO6KiDGJHbjhTivtFesgfINnH3YsZ93QzxLfO2vG4U3zSC3CRL2XkKdyDcmSndccJXNd7GBAHTW7jIqKiFjGiWlj8+BHLojACEJIwcglaPa5eil5rDGmTIctHVB++DVJLu8RpILihoXwYzETOELvF4lu2rMpt4gRIXk1Ayy3aGdYzPAtwp4d5eLu7XQzZfsw7chAF3R+vI6XPg3PKTaApC9d9um/DS7T2s5a44FfvcxnBsXRfqEm6szXDJFpPr5mKw6hFwFWEoRT/2DkAUjxQts0O7rAcFu0B/SG9CVVGwyhp107ZSDv70ub5BFIoGUsvgNueWKlNPVsC9W/6IWjEsqY/bzJDEUsdeHYP5tmtbUS3eigxfgJkQ4tqmaSu397PWdcQ4GpAGkNl/wrxD161avZVG//T2+G2SXXhl+B6QmSwrvlinS2tASlJ2DsSv7kmz0PIt2P9TUq50Lq7PkDNrZedIZR1put/hhdmPgPH2zr3vrUVq28A61V/BmI8zPhbk5y7r8zgVsTC6PHXjFWZsiuBHfNxP8duUQ4fUesmz0OT+4a1p0ncNKaxfqPxqY382hLDjUyqOgaBQa6WH1h
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(6133799003)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/z5Nb01r4eA41oEYDi9ThgDAHpEPaZDJwSj4utr8ctfkSnsgZ3t8QP+zNwZo?=
 =?us-ascii?Q?umITBuQqE/cTNdNjLNWLjtSpwctCFD+ifQsfNWWkZiAbKjSDDyhXszEMzxX2?=
 =?us-ascii?Q?d1Ip97M1ISOD/8Sy8TVGWBOvY7CM/22MuVP12j5Z6jKnfvmvx4GfhssEQxuC?=
 =?us-ascii?Q?NTuV8MvwAnPQzfzIuCW88S4S6t/C6Wd98JA8UqExf3pFndapLyfWzQnzYesh?=
 =?us-ascii?Q?jmTzr14DsGKcPIYAg6n4ToQPLP9tfWhbCkdqZY/nMk0q1AoJ0mT6xAOnqZoi?=
 =?us-ascii?Q?ycNP4jUCxsD+XzQ25BN1iCFjH30ddyxmQf1IVKfxna8+Pg/F4+TUrhNtH4D2?=
 =?us-ascii?Q?Bi2Uy7cuvKtb+82X6R7nCnXEy3Ce4F9Ymegk7U0D4q56nZNC1GZoipMdCW7z?=
 =?us-ascii?Q?FutUG3HBYE35yAgtgwEwcOCodXJk2bi5Easibp914gUqd9yIyU9J1MvYKsXi?=
 =?us-ascii?Q?q0deLNLiVzn9IcslM3OjzGayO5blvnF9v56e4ytwQRObX5q1KrbxS43dsWqr?=
 =?us-ascii?Q?ONDgPbpISLRKf+hpxuZpalwqjO8OsFPvDasxoRs5uY0hkSWFKk7CQmzryuCe?=
 =?us-ascii?Q?TRhgZtr3l8U9/1DbFHo8tbcqgs5XIdIoJZmihvV46hLr/EzEsoro0CEyYGr1?=
 =?us-ascii?Q?XoY3mx8+zO3EOhRFZ9Hf5ENQD6ZUI9or/FVN4xDZVmd0G+Imrkgf6I48+6J/?=
 =?us-ascii?Q?dk579mg3M+tGbN9z783RU1DayVYNUlPz1baF0kK11af9I2yOl5WGDXxh+Wrk?=
 =?us-ascii?Q?eaVEa4BUbH+KIby4WtZVjhzHAN3uCcGPm7cJsfAqUzNSrZXCOXxXH0/ta8og?=
 =?us-ascii?Q?rLmaWQdzJ2X82qeAyMDx9qqVjVHoGs6FLFMCl0wAIIPS99kASeQ2/ze21j1r?=
 =?us-ascii?Q?BIKZz3C3Z4J6xnc8jZw04NJ535UiSLmC3GyIR2rj5CRbiApq/O1nEv50LED9?=
 =?us-ascii?Q?MefnKNIpbG8sQarMl9GHSUtFeC4todWLo2OtdWmnMjv+lVdYhcKQSiUGDQRA?=
 =?us-ascii?Q?x5NZMu9uIIlF4woJSvZRjQHuSi5An6b3rOZXq12zG1/HGol1KumbMjP81PKF?=
 =?us-ascii?Q?rb1RAB0pJgxWK111hM+RSuR7AHinCofIKJgHN/hBEq/0mRBaSp617VsYd0uE?=
 =?us-ascii?Q?93cgNLD8ImpLbm3jycSd8h9wymp2WkWrPwYkwCvQbgwHIf+WU3KL6vIswdm+?=
 =?us-ascii?Q?cOTEVzqp2OOZCf2nz4H9V+D9pvhtgwO2mWavTtWcFZcOGQyTACFkXi849ueO?=
 =?us-ascii?Q?tO/+CUCuCMuA9QJaxLGzdko14j/dxGZO32EQ0t9M6pl26IxaMWYlahZQs7K7?=
 =?us-ascii?Q?iYLTdnx0g4qQ+aC4tA1sea3x7WW9tsknTxO8a9WciiHRo0fmHm1gQpDqBd2J?=
 =?us-ascii?Q?SqonMq/u2RojZxGSiY0yV5OajC0h9rARQOR4cWHvg9W4j7p/B3l3bhZdRCIs?=
 =?us-ascii?Q?FrjVKUSeCa+1sWBapFmU0VTxBXS4Hia+42hhZ5+Mf6ZGC+Wr6ol7Vn0KnJMi?=
 =?us-ascii?Q?XsE6Fe2w9sZm5l0j2HY3E+mek/dnlYESaoQ2+Sp5aRF+dGp4xgxV7OmlA9pf?=
 =?us-ascii?Q?1tLONnT1M3LfgNG0iTlv/sqgSbsbU9FgZUamHXU3pkrbYTuajAnAIdcSD0SZ?=
 =?us-ascii?Q?HsM86gHp/X5tLYZq3XIg0SS66pTqPuliIL5GnzXxk7xEcKHtA+uMdGCRS395?=
 =?us-ascii?Q?3L4NEeHn0ELJPB47GbgAhQxmEUPKf5/dQ9ovmMLnKyw2Fg10kN0kLzoo+mts?=
 =?us-ascii?Q?jt614VyId/XNgsqj+baGPXLRSFvBBLTJ4ZbLTOebsNE6C2nismcQ?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa10ccd-789a-48c7-257f-08decc4aafff
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:30:28.9287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Szt2kw3oaEsEg486vZqVnY4G6R5kFSCYcHHeqsDz+33Kogo2E7Mn08e5lRZPJzV/YyFiFBpkvrFLn+emcfS2OE+GQGl5YvtggCUmwPMMm0XQcuN2nfRykcyClQMjeUg6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8217
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:30:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23160

From: Bence Cs=C3=B3k=C3=A1s <csokas.bence@prolan.hu>

commit 08bf1663c21a3e815eda28fa242d84c945ca3b94 upstream.

Expand the arsenal of devm functions for DMA devices, this time for
requesting channels.

Signed-off-by: Bence Cs=C3=B3k=C3=A1s <csokas.bence@prolan.hu>
Link: https://lore.kernel.org/r/20250610082256.400492-2-csokas.bence@prolan=
.hu
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/dmaengine.c   | 30 ++++++++++++++++++++++++++++++
 include/linux/dmaengine.h |  7 +++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 892e8389232e..3911d8d0def4 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -926,6 +926,36 @@ void dma_release_channel(struct dma_chan *chan)
 }
 EXPORT_SYMBOL_GPL(dma_release_channel);
=20
+static void dmaenginem_release_channel(void *chan)
+{
+	dma_release_channel(chan);
+}
+
+/**
+ * devm_dma_request_chan - try to allocate an exclusive slave channel
+ * @dev:	pointer to client device structure
+ * @name:	slave channel name
+ *
+ * Returns pointer to appropriate DMA channel on success or an error point=
er.
+ *
+ * The operation is managed and will be undone on driver detach.
+ */
+
+struct dma_chan *devm_dma_request_chan(struct device *dev, const char *nam=
e)
+{
+	struct dma_chan *chan =3D dma_request_chan(dev, name);
+	int ret =3D 0;
+
+	if (!IS_ERR(chan))
+		ret =3D devm_add_action_or_reset(dev, dmaenginem_release_channel, chan);
+
+	if (ret)
+		return ERR_PTR(ret);
+
+	return chan;
+}
+EXPORT_SYMBOL_GPL(devm_dma_request_chan);
+
 /**
  * dmaengine_get - register interest in dma_channels
  */
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 3576c6e89fea..368a03920c92 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1489,6 +1489,7 @@ struct dma_chan *__dma_request_channel(const dma_cap_=
mask_t *mask,
=20
 struct dma_chan *dma_request_chan(struct device *dev, const char *name);
 struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
+struct dma_chan *devm_dma_request_chan(struct device *dev, const char *nam=
e);
=20
 void dma_release_channel(struct dma_chan *chan);
 int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)=
;
@@ -1525,6 +1526,12 @@ static inline struct dma_chan *dma_request_chan_by_m=
ask(
 {
 	return ERR_PTR(-ENODEV);
 }
+
+static inline struct dma_chan *devm_dma_request_chan(struct device *dev, c=
onst char *name)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline void dma_release_channel(struct dma_chan *chan)
 {
 }
--=20
2.54.0



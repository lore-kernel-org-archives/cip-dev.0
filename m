Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FEFCF6AAD
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:31:20 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3044.1767864670701669646
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:31:11 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=NsMY6VFM;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.49, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjtRQXvm0DpgmZSt3gluAlUw4EnDWLH748WX5di7AyBmgnhq8p6zTkiYUAcDb0QVcKt2qAkAjBbN5aaW745Ho4GoaHn8hY/qqTR/Z85qpoX03ek8mln874WgPjZz86wMVjtIwMEtipcT/mO4P3SCwfF0fekTS36zo6/9sTOZTSg6qHjjE6zkWcwGIF+MTdJ2gWhfWQzi35+xgl7WMqBaCICA2+eIM5mG+ujdGmNTRufE37HXAUkPjqHPR+4QWn93U4hZEFYGREQQRbeGulF2bPDlGlEd5UnQVjBapmhJMY+2IcqLFgtUfAnQk8N+tcYqn+JuLOLMwZ230DTv2rdMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMAPkXhfVxvNSl/wD6+an/YI5YultenxEXvf2jNWr+E=;
 b=QA11ezKYJ9buA6YCR0jyfY+YMwg8GdfQWYFURRFA55Wu0Fr/VKqRw7NICKr2dxttiHJtiSp2avbyzhM83obAsfPQsXHsyhRN9mlkKu04QIzr2DrOsafCYyHZyug+p/ylQdroE6JhUembMY28MTae6OxGr2fJ5q7/XRuoOhPJVABONW2Ns/1alpu9VDF3nPz8iUW/qoCYeL+LKshMpgSW3FPLP2B35AVu1t3GrLGUAAxdkt84xxfHykeM7WT/QN2fxG/Bop7PMUCE5zWGiChQ+qdZq2YJNHKErp9hcbqVMANwmGtZKfd924KeVaze1QnDdDKnjFuKAV0jxTBZwggTaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMAPkXhfVxvNSl/wD6+an/YI5YultenxEXvf2jNWr+E=;
 b=NsMY6VFMm0RD9UtlWb+LSRtJyfVUp3bhQiJL+x9MuvNHMHmA3EgbXUKCv3omkf8OqwWMvqIuz3MKRyYF8c+LBdqp+Mak9QjponrwCvBgZbGJ+SjvGWI0HcGE4uFjth2Txr53Gu/EJ1NKIYZEFz9RwQEc02jeO2u1dJ9/Szq8X9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14326.jpnprd01.prod.outlook.com (2603:1096:405:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.1; Thu, 8 Jan
 2026 09:31:08 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:31:08 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 08/19] i3c: Add more parameters for controllers to the header
Date: Thu,  8 Jan 2026 10:30:12 +0100
Message-ID: <20260108093023.489513-9-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 41d5170d-c263-43ef-5cf5-08de4e98a705
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?M248tkJJJ1RuM1gYN/+mPOzKe/U/28VZqHaqD3JPqllyyq3XXB7zlyfcMjCm?=
 =?us-ascii?Q?w90lOcWeTTIoPKuTjAUCMDr6QMJ+Hd2WsJfE4MZGJHNxigotMXsbW9P6Ak8g?=
 =?us-ascii?Q?1gtqUrUoGRVsHNN4TIPW0c+xfre0T56mln1svm571q6N5SNiUE+A6pG47JBE?=
 =?us-ascii?Q?UMcx/9Xrcta1B7wuwiX+JsbjyEh7RVaNsRdPr+UASJelPUMKgoSFZ2BxLV7K?=
 =?us-ascii?Q?vQH4td/eoqVHCBzwX48iwoBDYiyNrw+CX4YHN9BKLIGOVQJ20nqkEZSARfhh?=
 =?us-ascii?Q?0lL3PUjBq3w0BrxYobH+Pit2hvfjVae28CB59VqRBzkssMUPEbMu8b/iWLw1?=
 =?us-ascii?Q?b8Txzi0HAHwbF2UXeBH2/kDkbtT05GLNcl8SvXTIR198GjmxVRORT5Urm+7U?=
 =?us-ascii?Q?RevccRK/bU2ixOVX4EpaZ1kSJftZ2/7/+dtYjlf4yMDOw6no+fKmJI81/rPs?=
 =?us-ascii?Q?OVzS3pcrc8MIp1o64qQb9/HE2dR1qZ4nyFyUnGGqKV7/dnQy5Bna+6UgpNlB?=
 =?us-ascii?Q?Hl5UbztJPcnFNiqyGdQe/eCihyHG+hxRBQ69k2yhgYWlf09PLcRYj4BH/76l?=
 =?us-ascii?Q?jJn95B05rf9qr6w31F3E+Na/7iP/To0k72jrgUI4eKFVCbJEm/ErvQE4CDNj?=
 =?us-ascii?Q?UBBLPy8XHpTn3vEpbWcmIyFqbGWuMpmkFtLzLGkIJYdFeLHQR+ItOij13gnd?=
 =?us-ascii?Q?IcXl+kECN1Ab6d8eJ3lBqZ8a6Lil1YZ/Ma9+Rr5GfUlMH3SpOk+s3GuWwBDN?=
 =?us-ascii?Q?158JBP82LmXM/IHkergHEbcSLluETRqzRn/3fL6LdkYpEArZHTa04+bXcYPq?=
 =?us-ascii?Q?3AuAa3hxatq7Gj4it5aFs372MOeK6Rd0+FWW9d3k0d5Kw3cKKa7KrFEkLrUv?=
 =?us-ascii?Q?8X80A5w63puBIcMJDIQbFrt9dLrq9S8rkU9HY1TgRVd8X5ucc0X3uquKiCYS?=
 =?us-ascii?Q?2XCIHHzPG1mX/R5TEhbqv+WQthsf4SvtDyjVhkzrjgIzVDBww7yZxGvVgttT?=
 =?us-ascii?Q?AcK0G2GgHM3fOq0pu0sSj8nGBiGoVOqcwICo6CJQTWDULXIWsc4IVYCdTOqu?=
 =?us-ascii?Q?h5TfEFdk7vml3gzOlDRJlCZra+YSnQFO+I/4JQZTMXoy5cTC9Sz8YU/MrHvR?=
 =?us-ascii?Q?4OZdc366u+EIiEXn5IJ3+/RICtMTyQtHLSLpH66m4FgLnanZ0CEQ8mRDekW7?=
 =?us-ascii?Q?zu68hdtAvCRfehm8M9tLXvxK/rag4wrfDhEfuv2kJ4Z6MLRyM3kommKcJCc4?=
 =?us-ascii?Q?yab3SwyVhxsMo8DnfS3uJ74N9KEcdG4VA0BkxwfAHEYMdHT+4L6TYayBlAcF?=
 =?us-ascii?Q?liPAOwNK6E66oNQXYkpxCcIrkjjoIGeISs02zoFhJ9CMBGAewPGD7kXrx1Fu?=
 =?us-ascii?Q?u3+r8EMTtK8gV3pNCV7WS/7NlQuubpsq3N7OdBPR3PpfP63Wx3ia/7IO+5Dc?=
 =?us-ascii?Q?y0/FeYPyuf1Ou1ZqjA1FPPaNT2SYtGOoVyI12PXA4J8IWIxaA517PJod/Wro?=
 =?us-ascii?Q?tlpVbJLwI6zRx4N4hXu1pD6ohmczJ8Jmduk7?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RRjH2cL6W7EBCmwl5Fd4px+pu169mKSzSV5RjRtyoWwSdxqdPe3gjVZNVO+z?=
 =?us-ascii?Q?Ofig0KQTFfTLdens6+XgaRKBlQN4sf+5LDGRwmQGI9rjd+GxeMiHV3HSFmGN?=
 =?us-ascii?Q?nW4suWSOyBC99epd6GIpUvyM3fJKij/NvNGkVOGzSspaui1V1PI9PPcD1RiR?=
 =?us-ascii?Q?YioQ96FEk5fZ1DDa8KZOLgjrN3w/hAni1vEF9Bl0dEB3jHZIfBVUB2RG/s5/?=
 =?us-ascii?Q?pZbnae4RcXgx9jJ0rjkSj2gHAPZnH+AnwoKYmm4EB6RVtt5yYX9AB7HJr57h?=
 =?us-ascii?Q?w+6KO9ChZSRs9QHe2ALbNQJ9+aVbqXKmpPaPUW9a1/HtnGeKQ0Tp75ImuP6g?=
 =?us-ascii?Q?R/9LkS1wu+JncY5K+EYcahBX0lUgfxxDu6dJLs/fsH2FtQMXwWP2xlwtDc8b?=
 =?us-ascii?Q?6Wd9Dn3r8PB/P4k5ZdmEWss+9HPl24CdEK5Cu5zVnLpgoUCAkIf37ltl+kKW?=
 =?us-ascii?Q?5DcyqWVfu3ZV3EhBrO6zsyo2Ok7nMh8DO1LrptmIzMq4f4km2ZDH7FCc6ttQ?=
 =?us-ascii?Q?jrqInNscSnBt+k+us5UvzZ4MVXnVRIgPWfaLwtnLa9RkDgLXmQV4shkFyjBC?=
 =?us-ascii?Q?GiHQXIFGZULzCOG0ybDlk87uRxAdJ+7FyYlmFtytbkVsTebFyM/0y3CDJktS?=
 =?us-ascii?Q?aVVc8Fj/xnQLSizTWGrM3zhOlivjVPq8Q07VuINS29v1nID8JypCqb5hUmvH?=
 =?us-ascii?Q?JgdpdjnSUSMvQwJnTu1ndsOj+CqyXmmsclDQxyohcsPE3e8w2WWMuzlm98/w?=
 =?us-ascii?Q?u+idF+P07ArJ8Ak91mGQq/eYkUhndCKKM61EHiuVJ7lYNNicXWYe3SDXREom?=
 =?us-ascii?Q?ISRj0eIDBEINFI4xC3nnVTrKmxMIIAv6KtNcMnIb41PH1h84Ro/h8QIFbxRH?=
 =?us-ascii?Q?bkd5JInVSo9uPccMLiIz2cJXcsZURDetG61nMXSmb2LSHWddAqYVlDfRMiKJ?=
 =?us-ascii?Q?9DtNwJ+gwhF3+q6bxMn9EeHH+lAsr2FxCxsteNCru9od9XWrXT03mkDB90th?=
 =?us-ascii?Q?zURt5/uNCbSXH3nXILVDgkDW485mL+H1oaOoZ7lX5iKM1TFnwNZ3eQaFKnxt?=
 =?us-ascii?Q?F3ZmroT/n2B+UbPbThB3BTQ4D5n1TvR7vw4j+kepjqmDw+Y0n7m/06NJeWsF?=
 =?us-ascii?Q?Zb8gdSswdapl2nM6B6gL/jNWklGMrnoLGLc81EbRFd+juYnEyC+gaAHJySS5?=
 =?us-ascii?Q?33v6tDl7fOi0IzaG5O2eMS++lhQBqgZ72riNKD+qPnFRXihFF5Pdq3pdqUUW?=
 =?us-ascii?Q?2zJlW95oleMMsc0Yv3+9CXYkbZ9erknlg1t1tqQ+TwtBdHwVoUr1SNxk/SgN?=
 =?us-ascii?Q?btF12t2jlbwvM/bAFbgBORx+pCTKMB0aPVXKilXgd+YNJKFl4ISeOJA1vDW8?=
 =?us-ascii?Q?d3VE2AuYgfW1Ph1KdYmeP2QXMwVtTblogged8EnVHg+wVVEBNAlyOAAAhZ7L?=
 =?us-ascii?Q?DSNxGU9a1TyzCuyQSpmKG+eC127pUZwCRs5MgYM4EWf4QuUDLEwroX7ChTEP?=
 =?us-ascii?Q?FSFDodiBGpzj8+yHk26a2qmNAfzVE3E9sPshFef8I2dJrKZdI1DO+oNYVKWW?=
 =?us-ascii?Q?87lZ4zARIyigmuo/Osd85XzTTKAwg5zKKnYiknXa2sfRUa4kfN6G28W2nknH?=
 =?us-ascii?Q?QjCtvwR3tUvVan2R+WLw1I7EBTVyCyiV1TvGroPKEb54pHhnaOiFj/cx4d0L?=
 =?us-ascii?Q?KDJr1zG992cy/GJZfsYS/G00v+XhU+YonZ4B+Oyexqu1wv3BbCyiGQgBUvWG?=
 =?us-ascii?Q?6hu+gH4GhFcdvBe1o+vFIH3PVFJqcVxWYwC5hGVvHQv9vqAapFnD?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d5170d-c263-43ef-5cf5-08de4e98a705
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:31:08.1180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8E/R139G3bA1Ut5ufis5SB3p4iIPshSI2cEaK2I9LxIXqbtrSjOwC6Z+d549UR8fquR6hSX3chOYraX1qIqziZNp7/9M8r2uGfG+IqzcABVcgQalyB8ICvloMe1FfST
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14326
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:31:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21467

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 8acf1f3bae1ea48949458b67d68a72a95c3244a4 upstream.

Add standard timing value definition from specification.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20250724094146.6443-3-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 include/linux/i3c/master.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 7dfcbe530515..043f5c7ff398 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -254,6 +254,10 @@ struct i3c_device {
 #define I3C_BUS_I2C_FM_SCL_MAX_RATE		400000
 #define I3C_BUS_I3C_SCL_MAX_RATE	12900000
 #define I3C_BUS_I3C_SCL_TYP_RATE	12500000
+#define I3C_BUS_TAVAL_MIN_NS		1000
+#define I3C_BUS_TBUF_MIXED_FM_MIN_NS	1300
+#define I3C_BUS_THIGH_MIXED_MAX_NS	41
+#define I3C_BUS_TIDLE_MIN_NS		200000
 #define I3C_BUS_TLOW_OD_MIN_NS		200
=20
 /**
--=20
2.43.0



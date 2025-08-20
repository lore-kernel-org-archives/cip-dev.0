Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21979CA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:24 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.48])
 by mx.groups.io with SMTP id smtpd.web10.1087.1755706163021056235
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=KGK/ifNi;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.48, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mX3XMaMM1G3SNFuDRG/YDC7x8Z/d4NSkWkmtLBvEc6GJRq0DzUZzpH8wBJ7zYvNhCxcprRAmwsX54uiixyWwU9+BylPHayui9NSKwHK2FXklC6WcCVix79HklsVYDW0BAIZGuxiNV7BrlmSWWy2bX9h+b57lfa9nd3kKGmgMiPO7ynJ4tOVUDFg5HOwqAXSq7CYdA83EkkSadzSI0gyOaptqdogb6doF7zrNvS8YQtWOdADf1w3yTEdkdHRj3u57url19T6bRfcCsM6Onc+f5/+dy/eU7trUBzBSQjRnQ+weusUQPHbFgw/3yWlTprcZACzlbVoBPjvC32JQnRSeag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoemaA3RYMRIANreU5lrqRPeBWR4f522QfoYZ559T94=;
 b=EhpA7U46p+R8/1zc05aSAbDWoaN/NqNaMr/FvYFWTnY+9QKjKwa3WJx1E6AUelbY5oySNPChOrJ4K7s2FKwqiHNU22DpZNMYWSZFA9W/97CegpsFCHCx4a5l/0urFSe0dqEifENmeBgX2GO4EOjZCSCGRejnKY1d5PAYEh9IWmum8J31pBuGTPn5lIWRPz6t7yBrF1LPcHLK5cNlbVeIoAATfuG8FBM8ciaHH0GACmDSY4cIourovLLfe2Y8PYTQM6eozpXmVxaXgocy5dgpge9mGT7lTIzI7qnc8LIybXLrzOsAyjMGNBpgnI6vLHYORf6rD/+q5xMjwQzwbamHvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoemaA3RYMRIANreU5lrqRPeBWR4f522QfoYZ559T94=;
 b=KGK/ifNiGIN6cf5lmFA2D2X1CK1T8IEExJkYKwAVjUIgbGSsSoYy32wTyi8cpXyraywwBeDSYIiT2lQ9nMN87P6yIDRpFUMNKmYPqraP94amCTTFBRNG+4QhpKQpTgYqdNBz5S4KoFcpa8R78Hpsm88b3Cell8lq84lfpZdgOrw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:09:19 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:18 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 22/55] media: rzg2l-cru: csi2: Remove unused field from rzg2l_csi2_format
Date: Wed, 20 Aug 2025 18:07:23 +0200
Message-ID: <20250820160758.801813-23-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: cd942cfa-9df7-40ff-4f02-08dde003eae2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qLtjZJjEMrJCATnIvj487WxCAD5mftH7zRNho+EKjuXpYNWg5E3QDe50SIUA?=
 =?us-ascii?Q?kE6Rh3mbqVwv0takFhyWPkKrjHsSc19PsX9mPhXuFDEAeS66EIngmoxgap4y?=
 =?us-ascii?Q?Wg4PzPct6GJe8KCt+9efhzNQqHcPyPKG6yKPLGuP9pK8WDUEjiCanmOqBX3B?=
 =?us-ascii?Q?qZt1hbU8L4l6xp7T6mH7IH8Kv+eR1t65zu3xHSRPrZZfIG/Ra1gRGguADUpN?=
 =?us-ascii?Q?5aXrBm6vSlWAD1aIYd/Hmbke3Q5oBTXu/sUvvvgbD67XxrrrWGbjlcq1C9dQ?=
 =?us-ascii?Q?yCzYqlSKtkjlE9I8yg6tA83vrbAhiCdbnQrzRIXpY767y5N1GNJBGGDn0Rid?=
 =?us-ascii?Q?LQ4KCLBYqF/o8d4OvQ9LwNNaDupFPCytG1UKc0bLn2Irjo+TyFo+43Zx61xz?=
 =?us-ascii?Q?HTq3iNOx12I0sU7gCqI+obYLb7CoqR/nMDoSBj3twd2iYE5qv9YpVnTSpX92?=
 =?us-ascii?Q?ZbA+xFND9IgyAMv0O9GJdkp05kjNDLWqOBiAme9e7xVVuGi/TtUMYcfFAwqI?=
 =?us-ascii?Q?Q70lC6RN70wNq69cQ51PjgCVaTjxvrZyHqG7qZAwV5Ts7cKVp/r+GKNYApWE?=
 =?us-ascii?Q?qG/MVX9JUHz+Lms+Fgr0rPUMETcOtDJhg0PApgH4jWFQTIdM4fS3LR82jY2V?=
 =?us-ascii?Q?G/fAeq2dK/v15lZPzmr6pN2XBvcvDviZyRaj/7dUyMD585MHcGdwcgJ1eVqB?=
 =?us-ascii?Q?Rd2OHBkyuBRt8Tt9B9QYZOf8mp5aVoTe758XuXZaHbbK2J00DdvGqrAOOiDI?=
 =?us-ascii?Q?MVHFDYaH9vgA0NI8mckrXeh3sNNvIY+BdCMf2BFn1z5RZaSi7jQuUi87gQYB?=
 =?us-ascii?Q?KQbNRVwsVoXcmIzmBWqF1HD+Hsnxhs1snpzFE+W0zlNp6c8ZjuOj/TxAX1ps?=
 =?us-ascii?Q?nZorD7E/ck9EhAkiOksb8xcuSWLpCZjXho0oWGH3skr6Q/ZvYrgP0QKn20cN?=
 =?us-ascii?Q?H7uktWGKa3gM98enlWmSUd+ig1Ti02ZXU0Q5YVo6gLk3LUS+Fa9d1ZvESGge?=
 =?us-ascii?Q?fsH46lexfInHkaQVCry4xDeh/gCncjGiKxHGb1ohylDXlgysK7B0ivCqMqU2?=
 =?us-ascii?Q?dWC/eyIj9GpwjX3aArfnj5ALdlzEfFzPylkK/TIQbpj6PQMaAIcqnW5Y0lbu?=
 =?us-ascii?Q?mk78aMjVEnjW6xi5SQZbWkcWE0o/Y+1TCaUmuWnDNGJADX80TD3KpIgOHnWd?=
 =?us-ascii?Q?4YXryh5Imwjb7vZ1zZtfZe4TDb2klZiylDRhboQR00aHpss5AFR+oSb6N2Zs?=
 =?us-ascii?Q?fG1eM4b5HK+dj+EqEabFKNBGyIyGZ18W18+HsULWC7sJuKgZfyQ533W/Gv3e?=
 =?us-ascii?Q?+4EdLy7BMGvGmsNehP2TKueS9YrgXCK2xzfJ2vSspk6qOCWFrMFKHGjLCpXR?=
 =?us-ascii?Q?JkWNFPKhyeXxq79tXaD0X/+zdiNUHz7lwyp977Krob/6ST9qaOoONCBH7Ydp?=
 =?us-ascii?Q?pGuO/jXOVtBTs+/d4BsF9KTIZ0UOpkNUVG3+Xmd+a9IsVSQWrZOgSD7LkoKj?=
 =?us-ascii?Q?eAVtB6mLpKLBsMY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Th4bU9qbxLS+t/Q5Gks8CXAWNzuz52MWl4iUH5H76lN/eORLK3KRn+mgL35I?=
 =?us-ascii?Q?51iRPwE1Dqd0Lmec78KjnQBjZeCcd6bvQ9MzyvnlyHLfoLFo8oeUxW+MnonE?=
 =?us-ascii?Q?TiAhXuH2TZUuqQSCEyd5x406Mmh01F6JaKS0RCjRkoSwfh/qXQQ2Kj5gov9Y?=
 =?us-ascii?Q?0KvYjmCaoH1dkBqwm0N2TmkPuUK9tNp7E2Hh+Anliz39LT1Fmzy1I2nnwtJE?=
 =?us-ascii?Q?obSPpc5yQJIy3kzTroXxqkSytoshQsWkrltIP0EwTpVBob4o+BKhAjl9SbPw?=
 =?us-ascii?Q?9revjLFC34fGkVU2Mjzb/fxDvdIuDhZlXNbXI3o/zd3iZPPr577+9wnKAo8b?=
 =?us-ascii?Q?M56zNYL+fYwnJJvBsG4L7MfoWO0xvf2/9EcHi09BHUA5N4NPU2J7M72DSdO/?=
 =?us-ascii?Q?pD4sguJqvb4RtwpwVIlblZguYvdeHcu6PtI7p7rJ8TX4mp42bPls5rocKFvi?=
 =?us-ascii?Q?RYAR37vspwbU6p/kVBhjUAQeaL4O/tgS5Ln7TlWR9ij3KH+K8dSo/KzVFaDa?=
 =?us-ascii?Q?OnQLj0rIm1JPV3pcfqje91Dtf69vAysuJSOQsR+RHGvIc2/AeHPnPQ2BM5w5?=
 =?us-ascii?Q?mTXuVQ9mlGTyeLr2609+0nkT8d/O9PdBQzemUp3EsyTMHaslRcZEJ375qPho?=
 =?us-ascii?Q?Ag2CvSDNB6wHIESKdS+ULCcdcbpMV87Vtkor3TQ/Ig1xS4hk+fIGXdBs3R7Y?=
 =?us-ascii?Q?c1McE+gVs4fYenTIsPNPPNOm9JrsfFOzn3Dh5TxiD05B9wbolNvK1N0aD8qB?=
 =?us-ascii?Q?OcZm5bGrhgvQxSAJqk55JBEUYqiYB0StfKT0SzvJP7L+AEkPSJlwPAbFfSn0?=
 =?us-ascii?Q?SN1j7YpBQN3xOMwwJhfvfyN1KEAhctp5MgE7FltcBi9I0FTgCXNPuSZyOqOH?=
 =?us-ascii?Q?hAlIBjdeMEWCwVN3bF/zDpJ5Rcc6S9jj6ncM3kQix55Sr200060Jpc7P1XKD?=
 =?us-ascii?Q?pWt7UwU7Um5l55QliJRB4nmZCWBrPMxl8rvimaHeKagg3cZ2aSM2kXVPOvLZ?=
 =?us-ascii?Q?Gu22M8caWSACmVfxi7kyKMbA0lujyDyVIVoQnaLaec9gwpruFznWtzPeNrle?=
 =?us-ascii?Q?BMDSK+Jw5x378dBxq2rw77FO79e52PYokUj7ASRyp6Y+r+OtAkOFKlbZhBEr?=
 =?us-ascii?Q?mKXIBVPkUWqCt71Jftju0pFhLMgzxsW05klZo0IA6K0H2++18K+/0kFGF2Jp?=
 =?us-ascii?Q?TxP5hZyA6S08WLkzyYO/lexzgZ5i3cpZEUx8rGfrVFnuZKDv5fOkfqmmiDIB?=
 =?us-ascii?Q?/4F2aHOUTo9x8B90gl5EvZ0v4Lf/tHYSj+qCVKLgbSavE+PDs54l4t4/YCRp?=
 =?us-ascii?Q?aP4JHm2cfLGq19h3yM41oTqzuDfxqoPMKtoE8waA5iz9O7ziV8J37YYpUCuB?=
 =?us-ascii?Q?ukwIwX/QnIp4/5WmYkAOfLhn8pY4kdjd8whfDnBWvVjiwSX29uOSkYeCj/Iq?=
 =?us-ascii?Q?1svOprhG0sNTOKWPfguwaM6IUsCuI4+8e+amLSYxgq4hjO04UU7z3cHxwZwr?=
 =?us-ascii?Q?rKBXP9qeQp+ZjcmIniwUpx2ykBREDh5sm24CiSymixahDDcnzvuMMGGYLdj1?=
 =?us-ascii?Q?9l4W0CdNsacK9XOLoxhEwT9YwZ4R1SjbjzEYyCdY+7U81r1dCSk4LVxxA3+N?=
 =?us-ascii?Q?SNyr7aOG5DxJnn6aQm0/dnY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd942cfa-9df7-40ff-4f02-08dde003eae2
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:18.7482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8I02W86aHByE+iIr1EetwT5QQjeX9B0eRIdO+p6rZixHPPYbMNIEFXO4re5oe1Gxt5P/MB41P4w19xeGAw29rjOmBQ2CnX1iEgTEA2kBv5U1+HUG0k1kdInpG0BEzXAV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19903

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit fb2ebb89cf99e750ffdd570439d93234d06c031d upstream.

Remove the unused `datatype` field from the `rzg2l_csi2_format` struct and
update the `rzg2l_csi2_formats[]` array to reflect the updated structure.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-18-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index 3fd0be6a3b65..7b76d495cfe4 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -183,12 +183,11 @@ static const struct rzg2l_csi2_timings rzg2l_csi2_glo=
bal_timings[] =3D {
=20
 struct rzg2l_csi2_format {
 	u32 code;
-	unsigned int datatype;
 	unsigned int bpp;
 };
=20
 static const struct rzg2l_csi2_format rzg2l_csi2_formats[] =3D {
-	{ .code =3D MEDIA_BUS_FMT_UYVY8_1X16,	.datatype =3D 0x1e, .bpp =3D 16 },
+	{ .code =3D MEDIA_BUS_FMT_UYVY8_1X16, .bpp =3D 16 },
 };
=20
 static inline struct rzg2l_csi2 *sd_to_csi2(struct v4l2_subdev *sd)
--=20
2.43.0



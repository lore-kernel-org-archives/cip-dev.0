Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DFDCD98E2
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:30:54 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.10])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10736.1781685052674839573
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:30:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=VT1bOzKG;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.10, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnZVjQ1dtI0khjveeexQfjWNjyUhBTHlarTN1gs6RycNvF0p+9QgDZmvmu72nIGl/YvQ3bhCvKx21kfRHM/Vh2BreWDdvTTbHUk4Wcj+/at8dpaSyIA+yLcJUtE8oynDKm8Jle02D/gze34qeKqdjFGJevwShUED1TsK3+bf5jQBPUSZQq1aUHSHzboWFGvLKvvhJFjzefliSGBGvLdz9+n+HZQLVR5m/dco69yZsvCL+/I14x6N/Lyn8nQcuUBxuZJROpGnpk2tebC8HJ9sE0ELOcO4AEBT/Ocuh4WnCzNBuH2AESDWaSPsdHLFmv+fPdB4/9TrGAkD7nf6neskjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rdgRttA4UdlQTbxXfqykjwfo6hs73QbW4VGpNlYJ3Y=;
 b=lQAqzLfgCTMukcv+BqEuerXVGkwZDgvaPANkAIbqvXv5PXyaj3Dexk/94ne4u05xzb8mLa/8CkNBcfZPuhSHRgPorGh+PLkvRDQGqF9YCYTRIYOLlntTPZmyKpltyK2pyjJW8TsVjQ+sPzRz5T/PmkCs5hTQ5mPp5jB+c0vWA3d5oJtqCpAQVJ6ANDU82/sStLz4NMOMc567GzRVklO6Pe5IxzhdF5cXRHYD7SxznrAngwn14urdRC/0yTCS4FixNRZ6TExcfAAz9zHRaOMcqyMD++XubTvi0h25iXvAYyFegei0uAhkpXLXNUwaPoao5Cas0uzMtHumCrlgqlm/3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rdgRttA4UdlQTbxXfqykjwfo6hs73QbW4VGpNlYJ3Y=;
 b=VT1bOzKGf7MlcY50T4jKUukh8WQvfV+Ba5weK3iL71X4YCuINvxkJ6H5JfJ9dc2Uq+22uusE1VQm5FUVVME8Y/LH3zaqx2Y2srxwtsWRRPWuEeBbm5uolp0mIIgv1h/rRhEf5qDh0ncZBiqm0Y6yP91UEsBt8/qg6j1KwyqKlfc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8217.jpnprd01.prod.outlook.com (2603:1096:604:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:30:47 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:30:47 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 07/32] spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/G3E SoC support
Date: Wed, 17 Jun 2026 10:29:38 +0200
Message-ID: <20260617083003.1071543-8-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: b1e2e9ad-9b35-4363-d7e1-08decc4abb11
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|56012099006|11063799006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	9FVFp8Wg3Ut4/kFqwpcNcXiWqp7z2syYG7NZQiVhUXWr/1LaaVAbliBpfJRXsurAubEZ0KGIcHICWgoSgjsaSuD/3qFE3WkeCNmNLYbo/b1m1xFKTBDAhLOJ5RAEcfZN/vvseaQObJRK1T58bwPfhVdjw2SrHI0DPoMQjNvlDdWJX13O5tsKvUfJw5i5FVBsuYPsNZiP7co4E3dIOo0YAWzFz2zofX4QSQ8DpAucpEBAoMvWRi4J+g75a5+KduAQa0W6Tp/RLVRBPdZUHuqDME2YI4JFvwpcUPGK3e9AU2RXsQpXFvXst+NMyd8erqB6Pt/L90DXrX1dyk23msGtrChGnDPfnUsOG4P/+qkeqRD2TxsnsaX5mB9HQDWcZTiiiRDL1Monhh41nYFBGPSCq3+Ux0mqIoYrVSPypDWbGAY1xU+fb94ImM2fdcuPGJBwfa7DWqseLMRnEBsehRYo3LxiU3uqku7X3hBORWY+fUAcJLVCJ0Obo0RlRgG5V+2IEd0V/Pjw9t/uHHUq2PzuOmq5IgH/s7xsnRLJFZO5yx4ZcBfJZJ8ozgWLkVPahhXlwvSKagSA1zz08V/6cymIrftrJ08NBhnGQyQCXXfqF8vTJaJLeIZTknrwzJoGZdn+DganKjFhcV453fM+pTckIJ+EXih8EQ55ubaWply8o7gZN5V+fhSnNIoG5B4CawFmGKgrKKgT6B5cZrUKmiI17Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hN05fHCot9rcvlFJja5u/9Z8zt3PVWthrqy4iNlfqQayfLT7OjMSqe9gP1RB?=
 =?us-ascii?Q?2PL9HjpBOZYUp01MQ0tYmH6ucTbo9WfAGO8FKniQkfW9wF0fuUTyiPueVNzI?=
 =?us-ascii?Q?HkG1xjvVRmNwQQsm/ruQT7VSHu5tqtYYLCgDTXMBhXAd1sIwtxuLq+TeZCAw?=
 =?us-ascii?Q?QILjzQ4A0k78DjYysfLqq9KNRV2f/GmzPk9xoZsjDLsW2csOuiBK5oGyBBVe?=
 =?us-ascii?Q?2H5uoYkWSYXGJN6gpIHRWawPiQqFrJ6amqpLmPCB6qAeuxMCq55XPGx/6eO0?=
 =?us-ascii?Q?kF/46EhU3cILNuZ6H6JIPT87ClRuFy8KZM/SIvuPUEdtKcqX5M1oq09dQ8/t?=
 =?us-ascii?Q?0LAoQRUyg5A2AVU8aZjGfYND3p8VVxYl1GMAkuhVk8LYAvk6sn5fx79hLGa8?=
 =?us-ascii?Q?m4VTGdC3GK7HEeIqyDDyY8n1gl/QHarR3OuJovQSJ6BRCjsV6RreyCVMUT+U?=
 =?us-ascii?Q?FwG22LNzeJ9Cwai5AFnks52DeccFZWC1VeVjCnI3AtQcjxLcExEeyNyEaW8z?=
 =?us-ascii?Q?mN+r+YMmpSuw4j3rn8bOzmRSBvPnhhG0+LlZ2yd1/ka/2pZv608SrXhozCEK?=
 =?us-ascii?Q?diioG7O2eQ27klJwGHI87OAINT1Vi4+iG+PCQkSwQ0NBS8HpPr6x+i5IEEe7?=
 =?us-ascii?Q?FEz4/Du4z4/2rRnrEzpp4cpB2l+wzKpWYH78mzm8efFpf3GDa4TnwzC33OB4?=
 =?us-ascii?Q?gZ6J6DDUdTMH9XxxYfuwofGjyWJgmfAEQMXbVnPouGebbfrgP3YKseQGzS0o?=
 =?us-ascii?Q?U2hzj7+JoKGsE+0O9hpnh9ux+vowDfQ5BIH7+vv3GuHK8XXdbMd6aydYjdHj?=
 =?us-ascii?Q?kS/ngZsPxomHKh5GqNl44mRXuSM03ubUVluC4tfN2TQck9Ik6iJidWBlIsi8?=
 =?us-ascii?Q?4bMCv+adpu15JZYPwqEYB5ofz+FVfms0pkQXs6UdFkYifLthFxeAcScBTpEK?=
 =?us-ascii?Q?RlX6I57bmbN4doGvMjOVD7mP9f3R9lvBasdipV856LEsWSJxDcCLGZQkQ3wR?=
 =?us-ascii?Q?AhW5hIPndGN7cJY7NSh+Tn5WFubcTOxSPKvEEN5ZFk7dBwyfwFAxMo9U1gh0?=
 =?us-ascii?Q?5/OsxMxY/xK5vSM7qvXyFBOln5RF4MH7qZnAkt0WyxcNE8mIaVY8DbyIq5gv?=
 =?us-ascii?Q?4vVREc9Jw7YBzeoOlbZislj+v2z3YjedHJNGV+603U7LIcYH81NB+7BEdxeE?=
 =?us-ascii?Q?q6ef6kI1O/rXs8y/sFQ1G2qklkDKwUX9lZPwlkvtTJzR+EvtwNFojtX0a8ci?=
 =?us-ascii?Q?ZrPlirt+1g64sqbfMbG91S/kLVNkBF+1SwJfrtTZ3d/FQLTd4BV3NDEGYvZE?=
 =?us-ascii?Q?IN19Pmrh4VnoBLLHY5EIpjrw6VTfs9pgqsgXTDzRjVn/FokaIyxJ+9MdEgn/?=
 =?us-ascii?Q?KcS7D+hv21QjyNvFaAUqojmy8Rg2AbVsROy900pErCFFnotr42eTXibpzcuW?=
 =?us-ascii?Q?SBdgZIE0qFIGEo3avwZUuVTaFFa7CAtl3mq/9t9A+UjxgO3h4PCUush5DxuA?=
 =?us-ascii?Q?tucUNdoU+EqSj9570v9a8DQirNwYzZJr8uUIX/pvk/UNu5rQQ81qIYaKlQ+c?=
 =?us-ascii?Q?7GeT4EyLY0uLcJBbtrhPL1LBBNbDYhWHNs0y946MtX6k+rZJtv+XoQzxsCix?=
 =?us-ascii?Q?bjwId0uHZd07v6cB2wLXWS0IeVZxtoZpr/eU+dC6UESjjoHU26YfoJBvQSKQ?=
 =?us-ascii?Q?M0ax1WCBepz7LRgGuinTzkXCnvjDn2U1V+SbWyut7gCk+npuPG80Rq5th2qb?=
 =?us-ascii?Q?jsSkm/rYWQWziHUYzc4BbtazVpkwxzn3iNcMBFrFzN91/tezj7O4?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e2e9ad-9b35-4363-d7e1-08decc4abb11
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:30:47.6000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZqmEiAQMCZal8lONX+8ai//fDeTHN/EJmrMriI1N4BP4S9EfzTjY46BF/ht4NQjr2P4NKyPKZp6DPbYaCE/+qyCgMdtJtkEAJ6aIdHcJDQYbDRe/KbrtAI31GxKqa7Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8217
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:30:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23166

commit 5b7ac8ca0eae522735d24f7c5c2296c8094328b1 upstream.

Document the RSPI controller on the Renesas RZ/G3E SoC. The block is
compatible with the RSPI implementation found on the RZ/V2H(P) family.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/f6b43f0dc64e13b1c9942c164dea30002d4c4466.177=
1344527.git.tommaso.merciai.xr@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml =
b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
index 0f49d1d697b3..a96b049b39e2 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
@@ -17,7 +17,9 @@ properties:
     oneOf:
       - const: renesas,r9a09g057-rspi # RZ/V2H(P)
       - items:
-          - const: renesas,r9a09g056-rspi # RZ/V2N
+          - enum:
+              - renesas,r9a09g047-rspi # RZ/G3E
+              - renesas,r9a09g056-rspi # RZ/V2N
           - const: renesas,r9a09g057-rspi
=20
   reg:
--=20
2.54.0



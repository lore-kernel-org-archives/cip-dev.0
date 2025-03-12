Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8087FC35FF7
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:05 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.30])
 by mx.groups.io with SMTP id smtpd.web11.34807.1741778692204196169
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:24:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=TIWOi/Eb;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.30, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7URSXKAip1UA8j/fsqaLkGvZtj8KR5SBUxH8pRuS0qZ5emngDGhSe7rH6D6F5KKJQcSrCMhNmv1+ciTb6vFcnRYBt4NiiZ0kGX2P742myNW/L6wpD5QmRxj1wNPO/68fqov1BQaqTKuHSWEn8v2ybmlI2MkoiodQFUnayGSSAXB5oVNZfORkiuikyquLJC/2/9wqyRakGVq6EvzXLt0x7QV9FexdOyNJS/4QQUXxmf12zsgE2CNQVcg10MdP19oP7h6753gLqZUAtkZMMNqB8oWwhC4nsejBvX3yBznil2g0DW23OdvR2oWf96HT4N8ABJRx44BAiLHxm9ISSjL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBn3+j3bCqBQVeYtX4QDwz3zNExQgmfu+3LR6gcNXlI=;
 b=D6/imE0u7sUp7kU9kWr/Hkuqu3zCgDTuo/97+pK1fEX4EAdsbIZwbL/iVk3ic7MG5Q/fn64+i0FiNOOv2ohy1vPbLY+5iemyiWKoEnwpUUQD67hZXEZ+uznEvMT6Lgwm9UtTIZhKGaWkGYTi6qBSCert+0Ec7XspV8yZkHYOogfCs/srwxnRIm2F3ef831FXwYARs0gc0HpEwA6S1ZY6rARHGB6deYMxLo1l8NfriMnp54z/b3C8a4NHPxwqjhZ1IqhI0lBcoC2uRTnGrhdTht02riUP4l6QekPDruMQdRjWIunO/Mn9q3pSnFYvXeArxyQBr1wGWxONu+zK0Bmymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBn3+j3bCqBQVeYtX4QDwz3zNExQgmfu+3LR6gcNXlI=;
 b=TIWOi/EbYjeQ4lFB7tM7htcBn3kTajkvA2MNmzR3daUgX3zeQ6rCpk1WH4ocGlROVj7g4Y3k3e3lHfYbakZQRZE7ZgYyWz/0BSCQM2wxb7LG0ZsLtM5mhrH7J26XhtdLdRIR/Pi2trQdySCFkJwafnX5ov5P3DBXaz6GO4hkp3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB12752.jpnprd01.prod.outlook.com (2603:1096:604:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:24:49 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:24:49 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 25/85] dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Remove the check from the object
Date: Wed, 12 Mar 2025 12:22:02 +0100
Message-ID: <20250312112302.1605750-26-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB12752:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c556c1-b73e-4708-f6b7-08dd6158806d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?P+Gu93cB88b479wpylhISAVjaD2RNxIbk7hN1kjV3bO5VwDACSDGnBltvzez?=
 =?us-ascii?Q?UcF2Jg7z+rl292Cq1y0zC9rxvIHROCAOeQqkDORA9pVIPtCMnJ9XX+e+79P6?=
 =?us-ascii?Q?VRef16eVedM3lJOwy3y1GoI64D73ob5QeK7FHn+SjhSb1JQrB/3R/w+HryS2?=
 =?us-ascii?Q?Z5DrIZmXxABVlfZvV8J0TgKXuhuz5M7QnoigtP2Xex90/hqwEehQAzAMhAUv?=
 =?us-ascii?Q?2ofclrX/eAPfn46bOABs4iUNTUhNC431isAWhXAPdMH21/HFhaGcUuIRiTMc?=
 =?us-ascii?Q?lK8WfIHks+Xxo0YU2LGHILEnkn7cwPusWSXty9uZjY6o4unHBBMomgoeeeo+?=
 =?us-ascii?Q?g76F9P5NGSUt5PbUMNr+cRZXYiO3hqSwy6CxWfhwMoCGvlnxg1oDA8UyRnfw?=
 =?us-ascii?Q?Xb0KifkwRAF/eCOzXtwAE07p7LuqS5NbaC7b3DMDJiCWKkgfo16SBcAuY7de?=
 =?us-ascii?Q?k9jrb9nz5BRker/lFBt9mpn9QUzilPF6WZZpQJq1OxLcAHJpq0LmDaJfbdbP?=
 =?us-ascii?Q?LNey/lMzSunzSxo3cmeYalq9jK2ZEA6HFpf7g/ZAb4Rs39mf7bDxZeEoz368?=
 =?us-ascii?Q?MiCwzLoAf91dkVeHbaPf3bKil5Us6yTIWWa+QmGfAk4i5PZtl8RvcCHaaSXt?=
 =?us-ascii?Q?IrMhdX2qErdc/rjiuARTxXlLTCVqrcQd2HeywZK1dAN66h3A9U7AEWW98yum?=
 =?us-ascii?Q?POG1AhwrJtR99OZUgRf67evNAh7tmFZJ9nUH5GvpKkW2TApMdCqdxqjCKq9A?=
 =?us-ascii?Q?PcuRRuKvafgW57P877QVevFarI5VfnKLnzd9Cv+CNxJ9DdRNyMo4D6V/cONS?=
 =?us-ascii?Q?CVZDf7WVADJbjN6r90U1LUiNEDtjIUQNhL+R6Fk0hgQuc8aYRCl0sbZJAous?=
 =?us-ascii?Q?5+8e5l5k0XZ/lAjr81sUW+RYwSUakwBR630GCCmB1Ynz9LS086jdOdh9/osK?=
 =?us-ascii?Q?ok2ifEtfQSJgaaeTtM4fjdrDLWLGJS4PL6PxzaNTtvUuZd8wpx8FQriyvgpS?=
 =?us-ascii?Q?o4z21UxiOHuh5rOmvbtuo8ubUwN76Xo6p/eB9Fhy3tNOJOInVy1uUmWXlRwN?=
 =?us-ascii?Q?XeUqYvxG8Jlocdstwubcgri23gEVSpzUnFY8Z0u3V1pmdB9Vx9yncknlVGpS?=
 =?us-ascii?Q?Rq1oaJaAJ5rQMV8I8eL7G0XEZ1aSuTC7MkQWP87DQ+PqFC6ULSzyrVTGka51?=
 =?us-ascii?Q?Zc3WUgYnmiOmrpVF9kcHsqEbJZWsSXgUUX5T9N8+RYfXDzNEhGUoWL7686Zd?=
 =?us-ascii?Q?GGEXPv3iQDTJjI4L24xwXwr/Ql5GaPU3v02tCcxuMmc2/tLdxfQk3rvkuxDX?=
 =?us-ascii?Q?gMBEQEubCcEdgoQWQJIwkdLN+NuqrUJqCE1R/Z7ZXxxzfEcq2kQ8cVBStJQn?=
 =?us-ascii?Q?6Rk3hugx/FjbUUbl9KKYAvsUhf6HcGa3+zORRYfuaNgGxmx3ZYp2aUEo2mGl?=
 =?us-ascii?Q?/sXcnIyCwi/0wHiaUrw7nE59nc6ZX2yP?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Q2nDUc8XJ51lbfbS1qYJ5Yz70RzcRjI9AjLgA3vh7wScjDY7MdiCxA2u470G?=
 =?us-ascii?Q?pMkOF5P4AUDIxrRVDwYyEyeMpw1yi7ohrW8WE4m9PF23eRqmdMazvOVtkI+O?=
 =?us-ascii?Q?JOC0L7D0nulPf8i4hipWWk02RZzR7ViBqRLhLWA3adQ6bBeMgHRVq6xM/eU0?=
 =?us-ascii?Q?spanhiFKV8SmCNO/77i3vHiWqqe5JgqifryPnO1iTw9gaGxLtF3C6riIJKzA?=
 =?us-ascii?Q?DBkycHnWLZZbcku9QsSVQ9yHCLZG+ltIhd4Nh1kMvS9eqs62Z6n2aIGOwfdU?=
 =?us-ascii?Q?+o3/vLbGoh0353GkAaqQeX31TMYFW+uKpT6O0GimGA4xSBcWMo++HNWvTdOo?=
 =?us-ascii?Q?079bcUcF+aMRcVeYhdvvrmkebgiwc1er6Zm5f7Ua4xUpZIWHk96uEoIRNs0q?=
 =?us-ascii?Q?4Co/53KY5v06hJbKG1spRBFAuXEZSIVw44fyKI7REDNdYXT4XuAZQhMHy8Ag?=
 =?us-ascii?Q?xdgx6IxE5hV1l5rzJsEhnRwaOailUCZkUKMyLut0xrAzExNOezp18iPJQJGB?=
 =?us-ascii?Q?4Rglt7LMYIs5NYGltceJRHeWjU0yyvxbf9rbhG1IjtSNzUBxKQ8JwoP6jhHq?=
 =?us-ascii?Q?PQz5WhgVQHrdpUorYFWKtSo9fR5Bsxb4OFNLAT38o7AtZiPFhXup5zrKBopZ?=
 =?us-ascii?Q?P9OdKGT/ciZCYhf8FWC77ItuPN2P/P/pZigdLBEpeo/LIL8S8nOE5rn/Iry3?=
 =?us-ascii?Q?juYm8pLs0sNXmRB2TGOZ7I0vG/+oYQAgGxbaxcYeE0SRV/AtcYJFMNZ7K0gz?=
 =?us-ascii?Q?//Se4orUwz1iQt68JHq+Xuhpqh1kaDrpB6/23Rmuf4hVMELTGRApDu98/4t4?=
 =?us-ascii?Q?mD09K633ccSJEjh3DLsE6Jk04hdJC8V0QEMVoHtOAjB1DUrFjIJafMcrSK/G?=
 =?us-ascii?Q?ClQkOc4HvkejG+H/p8FvQkB00euWAth09CvYg8zhy8sRGYxwooWZvH1hO44h?=
 =?us-ascii?Q?x1H5g1ONzBTwtDtr21ZGrQPPWiCjCUilzeP5NjcF7lh32DNe3Ybh8xgMEgij?=
 =?us-ascii?Q?zLc4XNLIzlwrAewkGr2eUHDx+nM7dhvaIo8WEhCTFDrbC7FgodHmu+/rT+4z?=
 =?us-ascii?Q?aycjxNhbElUwQ35dk0tJUfi5OydCLmEwwFEJPp5CjoDn2WdR7ZhyVMB+d68l?=
 =?us-ascii?Q?Tk/XJbmIda+1LzUgtuxb1pHgmZYZ9xVga6wf/t4G4ojuqvOLp6GXJU2Ek/0u?=
 =?us-ascii?Q?NVlqu37wW5dIAuz5kE7/S5Q4wWSPTLzUo4dorB66XX4eCYkFi3zOq3Q44Owh?=
 =?us-ascii?Q?f6xmSMNAMHWvDvgApsv/6eTv30W1PW0EnJyMQaUL7YX4KW/XpLmTe229OrHK?=
 =?us-ascii?Q?wra3OhUB73ICxLJA6IgUONMU1UnPZOJAy7Kyduv+V16Tli9RVbC3vFw78NE/?=
 =?us-ascii?Q?97HvPc8VDlQN+7pQr6FLGO600ZyLNaidTsvIACmq1V237w7WfNkAFbDd0ris?=
 =?us-ascii?Q?y6ENdtYD4Wd6pnOgWhGQCboWfip8/ZVUtb9wkmEanv1xpgYY6rQWNY5cPMyn?=
 =?us-ascii?Q?MJ33hYiHyS9kxe0IAge8fCeYBifvZat9Ni7omzorTGMeRJSgtdiunBg9WGEi?=
 =?us-ascii?Q?wXp0dBc86BqotEv2vDXcdWSvhmSpjPpdWa1COfy74T1VZ8/hNxiZ7+iSWtrR?=
 =?us-ascii?Q?MZ9+tZPGqp1YNCtPkq1iQXc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c556c1-b73e-4708-f6b7-08dd6158806d
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:24:49.7517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9IcxRWVxVI11bfdmZgRXLkY48rjBkinbskjylPJK5uGIBFgTN4FDtnOOjI+BFfWSjhmFPJzSxyPx0pFKiTpf4p0zHycFoTtGPl7enJWFRYD/7mhPbsoC032uVyZszIkr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12752
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18117

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 26771100519af263e3b04b635bc917f8dfbdb77c upstream.

Drop the bogus check from object as this didn't really add restriction
check.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240423175900.702640-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml   | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctr=
l.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.ya=
ml
index 845225d58cd0..235cefe60f5d 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -78,21 +78,6 @@ additionalProperties:
         - $ref: pincfg-node.yaml#
         - $ref: pinmux-node.yaml#
=20
-        - if:
-            properties:
-              compatible:
-                contains:
-                  enum:
-                    - renesas,r9a08g045-pinctrl
-          then:
-            properties:
-              drive-strength: false
-              output-impedance-ohms: false
-              slew-rate: false
-          else:
-            properties:
-              drive-strength-microamp: false
-
       description:
         Pin controller client devices use pin configuration subnodes (chil=
dren
         and grandchildren) for desired pin configuration.
--=20
2.43.0



Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97AAC36007
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 11:00:59 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.60])
 by mx.groups.io with SMTP id smtpd.web10.18676.1742554849009449281
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 04:00:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=GS1wL0E8;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.60, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDFTAYBABExu5lijiq4KGI3L+E0U9MoNJ9/2s5ffdeTvXtebPK+l61JjAWaHoDNwBIudT7qLwJv0s0zMdT7MnLQmELSXOWUWShFi5HgbLBv9leNnpE+UY4kE7GNpY5B65DmZ50v2M4xOwsc7uR3cGbXTR9eH0dnlAYQdT9nrg8Y4dMYmE+FEFs4zJNdVASeOGsDJz9lE/ZQ2QL79s1WgDVq8hEANqUniENVFtzMHKRJSSc/2xStO8gYjfaIlOmF58O2+QkvwJCIsKvUDWeaiq58R/WPUvHehti+WLM7Qdd/zbgbn9wiWdOj3ZRRIkH+cl+6Y1p2lhvPjyT8Qe69wJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KQYEkNK0rQzNoi/zLl2r2V5eIExP2XLM42s64WPQkk=;
 b=hnOppci7UzEBwCtENAgdTI9j9JbswmS0vu+8ujg6DubUufyWNQp5Fy+8lGjBJrTpYNtK1I1M0NzjqTcgmmaLwB36cqyL+/zsjCY4WnGF73R8QIAm7LpQTBVsLchLXjKBvanjAY5KtRzEN2KMiYQS8Yf/bXofDaE1UzDbWf/ERn0ZgxPN2YoPd1eJWdSuBwG6BvN27NxWoH+pnIcjJi0+0k3uthYCyhSTJI+FwF9M6DjV1UnX77VJUchQVeMTSW+gh+FeTumnSIfPLAqAr1F7JokjQQuva2Taj1HZmNZ0uEZCJScTr/nczQfH4D8TxSiWV97VckkG5abFTztzy5anVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KQYEkNK0rQzNoi/zLl2r2V5eIExP2XLM42s64WPQkk=;
 b=GS1wL0E8/nuuaj3SJam1a4Il+pHSzmMg+C7Deq6x+IdYQJYycik1xnmFDP7e2UU/mZVibAYyDt+gNumsHkPsUDOwF1OkOBU01aOCPYudeSCBI6YcMM8hJfHDoYuXD35cCzdq3WLKUbVlXVs9vFyI6giqe4kfwowr1xI2S/99N7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB12437.jpnprd01.prod.outlook.com (2603:1096:604:2e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 11:00:47 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:00:47 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 02/21] dt-bindings: soc: renesas: Document RZ/G3E SMARC SoM and Carrier-II EVK
Date: Fri, 21 Mar 2025 12:00:02 +0100
Message-ID: <20250321110021.3612805-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB12437:EE_
X-MS-Office365-Filtering-Correlation-Id: 9643e748-4bee-4011-5636-08dd6867a28b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pgRo0aErLqSJuJkQWX4EoCL8V4LbO0xyAQtsJ5xWHTl3iB+uZTy+KSIFG+Tc?=
 =?us-ascii?Q?F+HV01FFBPxkzm3Iq7w9X5T8rjY9FNACxkS7ZQ0LnUnPSjrrQV5OE7SYdOxF?=
 =?us-ascii?Q?nHKxdbuHBs8MMI5mLmEkaMlp3qmyC5pTnCC6WGJbOVMDPBEGfN0+lrw/4DuW?=
 =?us-ascii?Q?5AiXJacuc/G+0p3Jzwg6Q9i5adgK6I/AOy+VpiNqrVdNe7Urz7c9v4t/uyc+?=
 =?us-ascii?Q?sBkRIFoLjSd/XNxKQtm+T+lKr5Ha6f4S7WQmpyckcxOSfDfFD8wqdJ+BdLnp?=
 =?us-ascii?Q?qjMnDxFE63c007DXM3A4+xJHWTRD8Mr0813bx1EYWmCgovBY4xhoCp3FD9+/?=
 =?us-ascii?Q?ByHBy/0E5V8rgvetkDrO1zPQL8yRk7bngW+CRSL1gm1/TFMMa+QnIxuiFsFI?=
 =?us-ascii?Q?L7oAqWifnTYh/Vi/JQaGer3cSA20sxtCwPc84Vm25hf9OWWallpk65qs6yWh?=
 =?us-ascii?Q?QmNTNsx0Ot5flKfaY8SKBkfiWw7mn20vJlmKVlFlOJq2HCMf/SNP6utrnRox?=
 =?us-ascii?Q?UT7eefHKiO5MPY8bNc9qmDRgTd4tT24fHo08VsVmY6SHP/QcOZh6jVRgNl6+?=
 =?us-ascii?Q?vES2D30t/9pAekkTgPdBzpTaiQrbsJHzmV4uWdCEsiMC0XtMqADyzo8ufD8K?=
 =?us-ascii?Q?hVd5xyF1ynqd5HPrJNJOdUyIxwFsUt2DDaPSY28RhBcL7FqpBFxBNrkoYqTg?=
 =?us-ascii?Q?7QawzBJ1bJpga2EqtbgaGkUNOF8CrHxQXxOJG7BA2eotkvguBNlWFflnBKWn?=
 =?us-ascii?Q?4X2fq9j5/Z/odq9MGf/bz8FFtLoPlxcooYQ1nce4Qq7RHrjb6j4K4RwmVQkM?=
 =?us-ascii?Q?qj+PdRGjcZdczMTANQOhnFbMyHFjUJkjFcj+Yy6T74Y9DyqUXGAcD1qSw3wR?=
 =?us-ascii?Q?N0FIsF9OE/jV/V/VrtX7YXiR2z8Rjb3QJLvUr9DRLoKNd12y+zGB1VD865IW?=
 =?us-ascii?Q?MIWiIZ3N0rtkFLVfPoTycRUSysho4bRryjUwReDpYxXeaGTUXlk7ThC9OEFN?=
 =?us-ascii?Q?MXGC5Jeyoiv2RhcHy2eXxMGdJ+GL/JKpTFXZibldxIMj5JWk3TYh2NABB5A4?=
 =?us-ascii?Q?8DJZn9YgCS4ZHTqK/KBOqOsSkH01YxMedVENINzLrD5nhWetr3QbS9xXGz8E?=
 =?us-ascii?Q?EHwouwxO4V+X7Cl7iUmTiwVepTwip29Kd3vGhk91fF8GvX2FtuIwsbE7J/cH?=
 =?us-ascii?Q?UcY3oIM0tY0RR5V3H/ccx6Uo75nV298vqMSUugohDY/HObDrDdJFDb8Fd4D5?=
 =?us-ascii?Q?YOIwdyB4oP1meelRdVv5KGh3m1OxU0jRFTiiri8LeOkZKjOmrMFJ4MsDRLEO?=
 =?us-ascii?Q?uuqObzxTlVXIEpuRmlYe8x9okhj5GuQ2kVgGCii+7Z1lZMqg7o85Qk93b1OI?=
 =?us-ascii?Q?t9VnjNMYptQH8A8YEilrFw5O3+HgiRPdBt53K/cD7DdHAnDMwcBtzKTcRsVB?=
 =?us-ascii?Q?dBsHi0FUFKPW/bU4KAXpvMYRjpCx5AqR?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XlXfmbE2/Yp3Um7itcZnHgw7Q1c8Ptk+Afeo8aBZtJs//hbq6VCDLgEaeSi1?=
 =?us-ascii?Q?RRaYLUlee1GM/tC4/Ns3UDj7h9e0QSFYVoa4UVYnGcMcCDTKEBJJyCHGr5hn?=
 =?us-ascii?Q?BtWI50yFbMrJ4uNfNDJNZAL/cXbcyxD3O9CYfNnecNwHszOP2PwKeR//PjWX?=
 =?us-ascii?Q?Tu3yaZU8DXTSIbXQgyMGlsT+K7zQsYqzWHZU2cdl3SEaHwJXxXBW/8+GuQ3b?=
 =?us-ascii?Q?lVhLwgh+1kurGk1Q6ohD9+QpjXJsaBBylkh7dd3Q0VVvtOdra0j10gPRefRd?=
 =?us-ascii?Q?g/ll7e2XhjKq0zUsNsG7qNG9ss6ywZHhfbcheK+D7biZtXiOwKkcdGQEsAAB?=
 =?us-ascii?Q?0MZzr6lG++/+jeMZWqNBJxHPdMZqk0MIH4645kVpHn9nspft6Imvo2eK//a5?=
 =?us-ascii?Q?pH6BSesuYXXhCD1bs5T/QkopRlyRNuGEVR7WCRbjPH1hYFB9SnFBnkF8X5AO?=
 =?us-ascii?Q?z3uvqkRGdZuhTso3mUQVGO+nASugJnkhPf/7s4P51ElERTODutv7kzaSvoN6?=
 =?us-ascii?Q?HtDleZdaLsycu/8VBqcLXpzEMugKIu1LNtxc7MEkL5tXZ9gjoA00qPni+lDo?=
 =?us-ascii?Q?D3B9AR/oxGYTC8qoKHRG/5OV8qpLeuvJYzumt8Zowl59v3tsQqxtQriUjFLw?=
 =?us-ascii?Q?YfBwOOMgw9EVIFTWceeHZA63HU7eDCCUqhskPjoRFQPiISufy6r9m1ieOpiK?=
 =?us-ascii?Q?AAR1dtG2gVkNVk8qeqzYyrf9QPX6bTXHjVmXKXyUJ7BEk5z0RH9SWW5407Lo?=
 =?us-ascii?Q?PqL7UqVWTLldu6FxR4OlymK9XtHUJsTvnNJd5UgQln8Su87fkNDJ8QtN8dsp?=
 =?us-ascii?Q?BV7Lf6Bhpf4O7gytkQUObXZmNuawrlc+HMn8BfuC+urfiu6od4YVV+Qsb4zC?=
 =?us-ascii?Q?LRC8sdY0wSVN7xIvsk4ewk1Qt58gNnMoMNd646GQyZAM8ZvCDyB8g8zRoMyH?=
 =?us-ascii?Q?cc9r2HcXcM1h348zGElU1P4jLgPufGhj8Inp+6FBPlDyQmlS573O49RnTer4?=
 =?us-ascii?Q?s82WiEgV9AZbjfIawRx/Rs6CwYnozwalk8jDbZtWjee9uQFH8+CuvDXERbRU?=
 =?us-ascii?Q?CKYSxPBF4PWTVkkgG9mBhO0DZ9uZ2Cskjd1h8o2rWymtI6i58h7psa3Ie7VK?=
 =?us-ascii?Q?UiZIYZjxVbiQTGXzP5SjBwoHkkARPjowEKB39P8UQ7BuzrF0o7CKhUIiVNhw?=
 =?us-ascii?Q?8NoeS9qBvfj0RZDUfElzGAxNiOOXU2GwI5ekNglBaTblCNvxcrCWS3BVrtU4?=
 =?us-ascii?Q?uNJIeU6adLBMxn7sMbhx05xWQwrklq5jWQILIEvTk/g7L7TzlVX14YNAPpv2?=
 =?us-ascii?Q?BKMeXzkzajrK4SV+Pl/h08CZgGqZNffc0giHuTfzi0g2YuIOxKprVQZuH4pr?=
 =?us-ascii?Q?H1jGmKTUi3xnGDdfZJb3g+BxS2iNT6DrLyODoO16wDr3zGaHCRCyOwj+hTP1?=
 =?us-ascii?Q?CVCBo8JRAo5GLdWE5kje6/4nuklt1OsLTbp25I0jViJfz6JQ5m9yJ7QFibP2?=
 =?us-ascii?Q?X184hmuZ0yF10O4GLTpLUl0eYUXnTwA4Eihmt27yea+NEB3pKjmJJN/Lg6Y3?=
 =?us-ascii?Q?QbpAiLodbMxcwFAO5HtRr/C0QnhnuOUFVseNreSBFxNVy6V6z+KosTy+Nt4F?=
 =?us-ascii?Q?ohBpNUOfeeTw4uhpv550I2I=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9643e748-4bee-4011-5636-08dd6867a28b
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:00:47.5245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1Av7ZzK5MLERBtCc4m5O1OVOfgI8jV2d65RAUN48+JoxWY5oWyZGXOBQDgb4O5h6Kn/Y70nTon+3jqzw35gLekJFXxzwO7mh9S6VHTbqr2p5vJFjDz8GAoYDNzlQmF2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12437
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 11:00:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18309

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 2bf1a3ca1df7ed93e5ac82ff672753a4edbb6e80 upstream.

Document the Renesas RZ/G3E SMARC Carrier-II EVK board which is based
on the Renesas RZ/G3E SMARC SoM. The RZ/G3E SMARC Carrier-II EVK
consists of an RZ/G3E SoM module and a SMARC Carrier-II carrier board.
The SoM module sits on top of the carrier board.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241203105005.103927-4-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/renesas.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documenta=
tion/devicetree/bindings/arm/renesas.yaml
index 8de30b478d18..05a96ac138b8 100644
--- a/Documentation/devicetree/bindings/arm/renesas.yaml
+++ b/Documentation/devicetree/bindings/arm/renesas.yaml
@@ -487,6 +487,10 @@ properties:
=20
       - description: RZ/G3E (R9A09G047)
         items:
+          - enum:
+              - renesas,smarc2-evk # RZ SMARC Carrier-II EVK
+          - enum:
+              - renesas,rzg3e-smarcm # RZ/G3E SMARC Module (SoM)
           - enum:
               - renesas,r9a09g047e27 # Dual Cortex-A55 + Cortex-M33 (15mm =
BGA)
               - renesas,r9a09g047e28 # Dual Cortex-A55 + Cortex-M33 (21mm =
BGA)
--=20
2.43.0



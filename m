Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476CEC3DA4A
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 09:48:50 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.70])
 by mx.groups.io with SMTP id smtpd.web10.4029.1742377726533161170
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 02:48:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=B+78i0v/;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.70, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAviPW1zA7SDnTCpcfSeVjb5i8cNOMgOUAmaJDn68RROa8av4J/sjYLgrv9XqWBLolXGA5r9giIMa4jy8KjnEYPAnDfLE8h5EP37s/yLgMRcJ3LVpXIDsjm8pCKoZVvuYEB0LibgP0b9Fbw3jEBh2d72OTTNlQj4lMEYojmPpg076DFCeefzrbNl2hM6NrrNbcaD9TX3EDPEe2vmmAnaTJUaIDCxyWzzYPNvab1v7JOqvVAZoJ7VToxBQMmWdC0zU3cpJYySfHpn9QhTwXwdEw6JaZubl/7LiKnBYug2NYOOOiRwERNO8CgWvG66QXb72Xxth8oBdQORCxcBNuySTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kn3EIYslS8Daf/EyHwyt+sFcZ/vS8ECK8aXc/wyqXnw=;
 b=NtqRuJk6NWPgvx7zcfGafHx5PiWE+ZQ6wM8K96A267VjfgQ+1TBr2Pm78OKt/wo8KSetwx8D2spQVEhm4Cji5efbIfBgUDrdT32rWQb8fVaZk+tBtV3H1KjFJZHTzYJiooZV/1+atqnOfJS7T0fBvXGGi+h0Rw/lUdbNqZlzuWor0XqrDCgH1EJtixtOkF3haPShMKvzgBbPzHOhuRKWnyMQpOq2fqUTzO9anG2DMy2zGfRFnjqY0yk3KNlxaSly8Xa7zhwKKs+8s6TE7xdPYhlZIX0vVEE9YyQrPt0oRR4UTKbp1PxsHLfutrt1d/nRj7/hhSXwTE5SAUrrDskdbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn3EIYslS8Daf/EyHwyt+sFcZ/vS8ECK8aXc/wyqXnw=;
 b=B+78i0v/bLaS0/3whiHNJ3vhPwBENgndsRbJz47K0vCWLmEpcnbznCoXXX9l3fW0x8O3HMDZ1iKFGO+sk9t1HPJO/vJge6XRmynXGLmRqC9Gj0WbXSAVLGzqOAzOBBw1s3kJwwuj0HguLQmC/c7SGxFSZKE17Y9PVb0M7voQ3Bs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB13904.jpnprd01.prod.outlook.com (2603:1096:405:1fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 09:48:42 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 09:48:42 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 05/12] dt-bindings: serial: renesas: Document RZ/G3E (r9a09g047) scif
Date: Wed, 19 Mar 2025 10:47:47 +0100
Message-ID: <20250319094754.2404386-6-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319094754.2404386-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250319094754.2404386-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB13904:EE_
X-MS-Office365-Filtering-Correlation-Id: c95565fc-586c-45c2-2dac-08dd66cb3bd1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?JTpO8Xx61SvTkXGui8NC5nbnGa8t9fOzVNeFD5Bvz5EwAFTuvcPYvdp1BwSu?=
 =?us-ascii?Q?ovQ9hC4vaF1NYUTneUErrugb7OCtuChkB8zNLHU5au0sBRxyocAp3uNlXdv8?=
 =?us-ascii?Q?lwbU965Hbnv1mERJsv4pJTN/EDFmqdWc/tKsL9lRBfB5TxUbSiNzYy2varUQ?=
 =?us-ascii?Q?w1VVeF6/QXyhSyDAG9naPyUsYUY2pzyBkzbi+o4xOBfUjpaEPy903/oor88L?=
 =?us-ascii?Q?RDfQo9phJiNEx5xn1FZwam4jaeUERq3DyZeAcJJvRUV2bYeOh+3x5kszs1Hx?=
 =?us-ascii?Q?OUTRsAiVDTPxQIItOfvQ4/ri5wpitPfcJD9TaJ1BzHvRnw/rr0MchJaIsGl+?=
 =?us-ascii?Q?v2I/Bq8+oNGm6nGjVjvIu/aw94GMeiV09Dr+EHZ+TSwZ2zKGGOp0A6WlxFxv?=
 =?us-ascii?Q?oB+kAeeKnR/vgLsgZ3Z1N0DZMBV+PufSRSQjHfvDUjOBZzn3RUOeMEk97WvB?=
 =?us-ascii?Q?RZd/31G56xrhNbWUEAWtGMecMV3602KVQaUL+dhOQVd80vuMhMv9C0k7kIKk?=
 =?us-ascii?Q?TbjsgN0cfFLDriludPeHgRjJN49W2SauMkkv5Mh5hfq4sIByrH6Vn2DfkCej?=
 =?us-ascii?Q?jI0TbklYON5YiR7EAmdfkGhZjNzwjMGE5lYJUBlLkzQ7nID9cHitKGwM4aOy?=
 =?us-ascii?Q?al+LFQayP9QbSyPYLkqkm6V7++yAttxTAWZvvo/uw1FkEubQuac9jsrwKRCT?=
 =?us-ascii?Q?kVt0/qyLNekBa6NqasFuPIt1+Qc0netfMn3RMuYveEFfc5bDM58dE1FbNQQd?=
 =?us-ascii?Q?RkuEewZXh3InjRZ1zgKwOsUiI1qg9Dv1ofaict5OSWn3/G3hArT2p7+MGOhp?=
 =?us-ascii?Q?aQGsL4Fn8wpPUixCpMqc+PmyJHPd1Gq4Gnm6KROwtIHmSGBxjeEp3Ttpck/o?=
 =?us-ascii?Q?hxsk3sojtYly3uYbEuLq1vMlQNaNro5ln9EzPHrLQHeh6M0lq+IY+Vx4cNXN?=
 =?us-ascii?Q?kHeDB9YpCd9cIT7bnTyNIAz9iByd9Tj4uVoFMbC0HYfSvQxil2iWvCAYBy75?=
 =?us-ascii?Q?QfgVBniAARTmbmIvZPViVXaHxBZEfP/MJj/9jtarM92gSPNZt+KLMfnCBdTw?=
 =?us-ascii?Q?1O4nchyllNz65nCO2L8vpvDHt3sRbOk4yOFaCVtJ392OzhmVPEBuiytM5mLK?=
 =?us-ascii?Q?kA5V2g1lKYwNbP6Q5zCMf7G1Cqnm89sPRj053U3R89Kbgh72c9NTZb525oZo?=
 =?us-ascii?Q?i7Xer5XU6r5ysolTddT1VYAXflFR+sEzi+Z+dTk0rcoHiCd/tx9NLs7BNGi0?=
 =?us-ascii?Q?vYr3YGHHeXRkSoTk3LVz7EmrGp2OxikI1TMKVWnT+VaJPauMF2fBzd5SkhpP?=
 =?us-ascii?Q?wg+MUjKOClpSxtqhd9YIqsv9AfhXJR6UE7R9B9XSHz59T/N94elrKteq2K7G?=
 =?us-ascii?Q?K9hh6gxMsws34h5SJ18cxRZBQ25dHMlPuaIjBpiZQnwyoAuzOEIDEpK8TGgp?=
 =?us-ascii?Q?y9uIlpljT0Um+HNHRCmWmSD2XITPzLsV?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?j0DaeRgnofpsXDQwW2SWd62hCdf5gxxxZ6Gfs1/BB6chiNnTPernzk/ye6qO?=
 =?us-ascii?Q?iSsZoOGI2OtD1FSH4KfMa0zLEH2gLTgyPUfN1c3snjK7YtDKkz//mdffzrZC?=
 =?us-ascii?Q?sEuLV8A9Eej3TKs4ObuNYZzNpBvCm0sCj/56I/3lHokZyWXlcq3s5ifOFzGZ?=
 =?us-ascii?Q?HBI1wABDSicYe8ZSesBqYxCn816ttiqQC4s3QB+9whGpuuy+x+JB7DQm2Y9N?=
 =?us-ascii?Q?7HAfj74p67elzZu1h6/33KvMVPKzf6RbsCPiCFGOdvSVLA1BAbZiVNNRKY7D?=
 =?us-ascii?Q?YRm/7HeUJ6dZyUZjbYODla8p+d4278btfAwnpkTvd4q6zWhU9yTTjvqV27Av?=
 =?us-ascii?Q?uoqu/NYhla0bsC0SUkJe0n+v1ks6boiybjDnNQ46ypOoqw40i8fik3SlVZdg?=
 =?us-ascii?Q?tE7Zkkbyg7J8zzwE259SrkJHQnur8M+BeuCrOGXCtqAaOceT89cml4My9MWE?=
 =?us-ascii?Q?gxDf+i6OjfWt7pAToyKV1QOUzNpvpoXv9IOFaWskJQoya9Y4RhHMFk7VuRcY?=
 =?us-ascii?Q?MbjIZEnLT6zNDlnIlimD31dOz8RVstj1S68p3JnviSjfYb1sApk2+s+z8N+h?=
 =?us-ascii?Q?o5anvKcBpLnjUXh/2MMfEafp8mpZkjSdc/t9aiEKWGDBPF5cUOPO3ROtWgrq?=
 =?us-ascii?Q?xtLe+aeqwakdhvEfI+j9k0apJs3KkljFE7HVHlVKHclW81W2rIr+cWw1bFxU?=
 =?us-ascii?Q?OwrKT+H1yOQt4Oe/iDAK8F0FLe5CXQIGQ1BCcrQ0AeXu1Zg8sw+n/oEFJR1A?=
 =?us-ascii?Q?wf0tCUfjFdKlaQwkFcJRK3TOQpJLOPsAFGyG7F12RTWwfYn9VtkgCzKhMHnA?=
 =?us-ascii?Q?sbTOC2qs/KaM/B1FwvgU0CW67MSeoUsaJ2+51c0eC4YDdgUxiLHLehdi2aXj?=
 =?us-ascii?Q?l2yTyPSkS1ZM65CJOQZ+EOBlNAEf+HkDmYlyKiozmum+LZMggrcrdlWoeusl?=
 =?us-ascii?Q?unTG4lThJiMA5g0E3a27AVEe8G3Kz1NlyuEOs1UbZoENiuGI+MI2L1TW5qmY?=
 =?us-ascii?Q?Fn7bMWQk8pTmmEG8ElBbbtcFpIKzSn11NviqhgiSbKBxQgRbirfeaEYmy1xK?=
 =?us-ascii?Q?2Imkh8fPTVVH+6ikuq+xGsH/SCgaYz3ZXqCnGSRDZGk6/uieHAnGWNIh+fhX?=
 =?us-ascii?Q?2s6c0NQcCLLSL/UBSVD2U3mjJoLY2rJbOkYcf1+JofJXfv+oOxkYwwYYv46t?=
 =?us-ascii?Q?9+HoMoRp0P03qgoCDfLKBiHXHDj8WwUZkshjmZqeHLxKBN7ek3L6T2UF9/yW?=
 =?us-ascii?Q?ylzZLK6KT9tHJNJATNn58d1nHTprEhOi10QOjNEmchkfhLMrqytsocuxsqzw?=
 =?us-ascii?Q?pnlcoKkahREYGeAzK7WQJ96jX9/ox10iNGOZ3gFSNHIeRPhtA+FVu9qHswqs?=
 =?us-ascii?Q?mOTTZ7VlrcP+U6WQ5OalFBIZnDk7ELP9hIjxDYeTBxZZ323x98cJkoGHDGtD?=
 =?us-ascii?Q?XSVm5v7QSTQX8TQJSz/psHEbuX2DxVx4N0LOMKo+tuOL9Be6hIiPYRb9biwE?=
 =?us-ascii?Q?CYILqAacLR7PUWNMUKtlCTN8268Z7mUXX1T0+gkf8RqFJ+AhNyoqVpa4E/Gb?=
 =?us-ascii?Q?0d75bevQUjCY1h0K8eFE32t0RTzGm916dZjnOKED5omXxapiWmrvLA6W+8G1?=
 =?us-ascii?Q?eS5q7BBHZ+uUwWRDgGtIEUI=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95565fc-586c-45c2-2dac-08dd66cb3bd1
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 09:48:42.8103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qc88oRy4fzB+zd7jz+/nHw+gAoY6F5R2U2DiIlQ3OlDVr9vEiZvWf3m4dwz5KVBCr6Yo6Mge17+h/GfP76cxH86aQiOZ2T2Wvp/VVCnAU5trkpjljNISP6awKY2bPFl/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13904
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 09:48:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18252

From: Biju Das <biju.das.jz@bp.renesas.com>

commit d828c6726fe5642d1c71e9edbc4799c959b471cf upstream.

Document scif bindings for the Renesas RZ/G3E (a.k.a r9a09g047) SoC.
SCIF interface in Renesas RZ/G3E is similar to the one available in
RZ/V2H.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20241122124558.149827-2-biju.das.jz@bp.rene=
sas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/D=
ocumentation/devicetree/bindings/serial/renesas,scif.yaml
index 7b997adec92f..8fb7fcc99720 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -80,6 +80,11 @@ properties:
=20
       - const: renesas,scif-r9a09g057       # RZ/V2H(P)
=20
+      - items:
+          - enum:
+              - renesas,scif-r9a09g047      # RZ/G3E
+          - const: renesas,scif-r9a09g057   # RZ/V2H fallback
+
   reg:
     maxItems: 1
=20
--=20
2.43.0



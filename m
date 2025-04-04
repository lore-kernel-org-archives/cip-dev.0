Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360B1C36010
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 07:39:11 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.30])
 by mx.groups.io with SMTP id smtpd.web11.5802.1743752343094004074
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Apr 2025 00:39:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=nJNcZdpB;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.30, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuEVCxk2cuvzjwsvCs6o4bjqymNPLwUA7GrdUMPQCZRcqFeOHCFh2QtOaQlVgBuXef6/8sOF1+QRGM5J4Ei18igbtus9j5OP75Lbh/wp4ORbhZ4+0koKu8KyGiWNOpR9ElUbqW/A42bbYzOJZ3XOUC74vo44PyVm1IDRDLcWkUEp37y1GNEwwQqOFRXVFCnKtMRNES6N95Kkat4+3d6wJ++pAlJ58Jj5Tz32hp4bZV7kc0BFU+r0j5pApZnAj/GhfodTD8d5w0Y5PO7m8YxkGy8mccs6j5IdYDH9+tP3XsGPkT5+wcHfH16Ei2Ih9N4PAvvwbaAyLfLvDTHOB9JlCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAqdoJgkcepDSZOO92RROSJJJgtd3damWsXaxYgHDSA=;
 b=WHU0GpkhCDwOaPj2sfsu4mG143jyuG4XUVj8paLdaFitSvHwe6GwE5oigN7Kd4eS8S7wfFDqaP+2cY1Ch/D6PyTZFIn/dNIcGUILxdMezjo9aqzyiwGbUX46Av+uHB2ro8Yiwi6ZqKRjz+lfOXADSYYvF7PRnd5Cjukz/jRpPHQSZvRzxSpCG3Z7aKBpQkKjD2o0xcrEfzdPSyHLguNdnD+E1EZTLHtSDL2kQu68rBvDHv0wgBmImg4kMfhyYp5FJLQIbFTcSzGipAvmb563lVU8daJ8yTgA67JtIDzLUMByQs2ctIu7E5msZCk6vuMYjton0sK5W38lf1RBoqreAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAqdoJgkcepDSZOO92RROSJJJgtd3damWsXaxYgHDSA=;
 b=nJNcZdpBPh2/1WSOcf2T0diu3kWg5wKwR83WE9jIX9KMCplOkmNJIE7dDJf7Kgv8wOreChaWSw1UqyYDNuyMNKhU55Zu4553EXI6HKnO0pUX2/EqY9k4elKzrUPEbOZV+cNRMsoaRuSe/q1ndKhWW0/QaoyTQNxHYOBdU0FSWHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13254.jpnprd01.prod.outlook.com (2603:1096:604:313::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Fri, 4 Apr
 2025 07:38:55 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.038; Fri, 4 Apr 2025
 07:38:55 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 4/9] dt-bindings: i2c: renesas,riic: Document the R9A08G045 support
Date: Fri,  4 Apr 2025 09:38:14 +0200
Message-ID: <20250404073819.173272-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404073819.173272-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250404073819.173272-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0438.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13254:EE_
X-MS-Office365-Filtering-Correlation-Id: 46047392-34ed-405e-dd86-08dd734bc0ed
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?X/T+8TBohMp1JVJGBlqqRJwQwg7y3ik1xFHGMDFD97pYiRpIHcHIjkvyfwgX?=
 =?us-ascii?Q?4PCnyRK6odv8ObL7W5Q6QLxDwWPzvObsyEcrPitPjjwV4oQ40G+yug46OnEc?=
 =?us-ascii?Q?cx3XjTkBXCTkGzhITrBsxa8xw/qrIs/dxhxtGOG8NUu6OhTpBKhyFM16Txhw?=
 =?us-ascii?Q?dskHeI9ZuftTswxfFWkBECWhH1sWjKtX4tWUePLnJon67TZOzzDOynOHcn+Z?=
 =?us-ascii?Q?x7CMAyAAOJvPU6Sev+fvxQS7cU5GbHsfR4anD2dNYyGilPI3EMzSXcE0NXYK?=
 =?us-ascii?Q?WiaR0t0LOGx+Ka7jJUd2D3DesO3kw58CR4S/GmWJ2ispAmq8vPq8BWIzcxih?=
 =?us-ascii?Q?BEZoKp4eAyxwAfac9sqviWkhcnkMH16kuE+Doxsk9staNHCdsrlI5b8VO16o?=
 =?us-ascii?Q?CIs9RlPv7ws4euo8ybNpBGFTdidJMYzra4jcWKpqpnNxWdvk8hxH3Q200ppD?=
 =?us-ascii?Q?CsHng7Xk6tTcsoRlo6UNvzKMtO3cy7xonliR9Z8ULSjQIfmCDv2nqBhQoCr/?=
 =?us-ascii?Q?HHc8/OjMVaKohxKQuXpwkOR3RdaSN+y41hw7d91RXn0XfFmsTrMXdYB4XX39?=
 =?us-ascii?Q?PUQCMEwzI/oet7KC0KHdOITuxAciTOGPUEjz1fKsaA6iBjTCC/01RwUX/CJL?=
 =?us-ascii?Q?7A/Wi1vXScYVhBt8vA5VGWTjB7wrmrZ1+aJ2n0MXlgAxb/H/l3aRzXXTRmG7?=
 =?us-ascii?Q?lolBeWktsYFNSZ91kZ+PB0dbrGcDsveYJ32pGJVvIuYs/0X/speGRA81unPF?=
 =?us-ascii?Q?kkGMP7w1ig18hMydkflqmq4VfkvZUbAYXOEz/Nz/VYU+PVXkkzu7fUWy026H?=
 =?us-ascii?Q?nO4sdSioNRAdn1U/UKv7MmQ2YGMmNKLO/ZSHZ8SedEEucP835dH4GEVbHGVo?=
 =?us-ascii?Q?SQG3ROkNHV0wyiAT5QnKa2r7iWXr3DmF6iISafJt3PtKSUzPFoSACDtJFuO5?=
 =?us-ascii?Q?f02lEzqKfk1GTfLzlDKtim5HskauBgcHP/0t8kpCVC2rjFmIm3W+6zxvfHib?=
 =?us-ascii?Q?wHmI6/bMwz/D22okNEODRaYBLGVGsJRV302utVwfVLW8+9a7n9BDcI/ozXBN?=
 =?us-ascii?Q?9D2rsx/oE0gmhuoUItX6T8xpzdKayZYf3A+bklsMJwBmd2m/Pa1WW03GyYKg?=
 =?us-ascii?Q?CuQ0seVH8cIrjjmYBIf7Q9E4eppquRrbTTVExP0u+l/Vb/sHwOFHULGA0rjZ?=
 =?us-ascii?Q?9r0lMJym/glOOdSmeJHAQS+AnjFydTduYAhn1/113f0GG+YMhEISvr/Kw2ml?=
 =?us-ascii?Q?vMH3E69p1JAQ9riiCF/ifyymArE3BvjvsbJoDLH77nFLF0GmEBPHAprCzFP9?=
 =?us-ascii?Q?KgyKD4tMepBB1xhzDQcoDbPAOLiAGSi3hlBbRFVxvgl5Q8T/qoLWe4Jg6pWT?=
 =?us-ascii?Q?+06xyhraHxvhX3Tsm15JLM+PY2ce7nyDfazainpPu76MjcOUrO1GTHkrNdVy?=
 =?us-ascii?Q?VqlpHPz2PJBpYpxmX2KpDcS1E/nS4LCo?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hBSFvCZXjdCVSymeAX8r5mGKpxWWfwLPAzkUatQwSseRfFcG7Oq0wfcpKcSo?=
 =?us-ascii?Q?qSeaajWu8eAybzEqt4qUAZ+cnvvDXOS137dlTfzYSC9htO6jJlYBJvTTvHkA?=
 =?us-ascii?Q?JBj8TBk5u0mdzjf9BcQ5mW5HpcQJcxogOduJkTvYxRAR++qWdMZmORDR7/6b?=
 =?us-ascii?Q?AfIK1AnAFF1xAApN0yOUM+PABbDZhJW2dqBsV0Kq5QTEQ21+MwXTiUeDrsDB?=
 =?us-ascii?Q?7GjYSHpaH9qKsiHry4V3gAwwk2ZkKRFPQ8CTVWAXfV6cUJEd08uIp7qXffV1?=
 =?us-ascii?Q?0+QOokATzdKDC7icOxwuZVtOeata4Ou7wkGC77cIRcElES12AtcXpvxb54qL?=
 =?us-ascii?Q?eM3R5yMhH2r+84AU/uXq3q309WgbRcL+3omg+spej2pPczm0JmkFY7zxvDTs?=
 =?us-ascii?Q?3ir/cpUx5LtAnx156UZ2Pt/+iD1whPRhuYDIfcLXz+D4fqYxIY4pLRuxRsrR?=
 =?us-ascii?Q?b/S4N8HBAilqF+hV4vxWkeLp38C4pidiAAeQcD4IKn+4J9UPoGB9zRMaDoEv?=
 =?us-ascii?Q?c8PQlqKuoWqM65MSEmmqR1lQSHpr/Kag6KNKwId6B6vw/VI5BtCdcQwGn0Y6?=
 =?us-ascii?Q?afTST2ziRpLw9shnjfp2HJozZpLnaD39M8w8tVZekD4PVr0NVolx/r7M4Amp?=
 =?us-ascii?Q?v4BiaGzjuYZoWUytbN2ZV3a2AkFQWh4Sya8FU9lOBxkb1exQBiBa4KFK/E3I?=
 =?us-ascii?Q?PBguBikYnIlhwK1SAB+fAu4yj+wYNUOMsc4QI3x1XKlICMkH/Kftejk7l3Cn?=
 =?us-ascii?Q?MmqpknjYscELpSFAUK8lxYZANqdYOcYtU82UhTa38YR4fbm7jIZCnI1RgNnl?=
 =?us-ascii?Q?jwUXB2mLwVopbxS9IYvk77xbq8yM+24M5LFFE7wGrryIOS+QPUDlUM3Pt0RJ?=
 =?us-ascii?Q?6goI1aAbBkbbeumQyJ3vfRYcLAKWt2BHx9Csh0rtYwtIZBtC5WkxTozGwRD1?=
 =?us-ascii?Q?9P4zwV1dh+OeaXVVxuq0j0CzFU1nRfrjmSgF3mLzlSc+rSbdAdwiXTW6fZeG?=
 =?us-ascii?Q?bXYFOnNHVlQuwb6Ivg6x8uoQ8cMopRdaK5cNnwA/Tq3nd4mmXJbTsL9kZV9u?=
 =?us-ascii?Q?dueM6pl/3SGNZ1FaGK1YRD8OY8O/EaGOI6CEj0sCztQUkgA2OUoXEkriATX0?=
 =?us-ascii?Q?jYST7fI20MXgfJYApUefZ5Fw3uqdGuxxmotVxwX6Zq9hQxTJmEzqpcCuLV3W?=
 =?us-ascii?Q?AZ1wdG8QG+hkCXfRZMQ2/btwegfN1L0yibS05wgfFricZgtLwYB4GMCvMzLG?=
 =?us-ascii?Q?01E71QINOtSY7ehnf7C/jGgBpAA9mVbV1nnetOW+a1y8hW2Senx6RaAgtlIB?=
 =?us-ascii?Q?Q64XUm0ZLxHK9NfJeNKI/YXqlzV2FVNjf3g/B0x2xGBMlSIKLXPhkiV3l1Ck?=
 =?us-ascii?Q?d8gosTWudHPHRAfTJ4HfYbMXS5iYi+rKFuUyyjPsRGKBX+jqP8fTXQWkx2Sp?=
 =?us-ascii?Q?R42L4Y9EkFqgUo+eaNFwSeWdqL/fC2kCaI1D600K9d/539TnOFg6zs+7wZCx?=
 =?us-ascii?Q?Bs47sU2XMN+odseyjDIzUfm/1rq4BjDgAsOA1gqhSrTStAp1codlvb9z0LXw?=
 =?us-ascii?Q?FiGvyHxd/faw/AuqxuIRf48MhJWB2acgC54El7n5J9dIMyzfEDxhp51Os58B?=
 =?us-ascii?Q?6NS+ymASrQKg2I6q+bA7mwc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46047392-34ed-405e-dd86-08dd734bc0ed
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 07:38:55.7717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mA1uMFzE3rJXFMGNRB+F3IDMxjSKezO00Oa/7ZRUYKV/05Iu8surcN6zYTzGuog2U0GchNVUCBqqjoHUmXTrJ0PVUBpL98r5hY7uX+ws0PBATlnYSE87rDU9o/cYaee/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13254
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Apr 2025 07:39:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18468

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit caad8883e4202c4ba002b9b1adc62e123f739394 upstream.

Document the Renesas RZ/G3S (R9A08G045) RIIC IP. This is compatible with
the version available on Renesas RZ/V2H (R9A09G075).

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/devicetree/bindings/i2c/renesas,riic.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml b/Docu=
mentation/devicetree/bindings/i2c/renesas,riic.yaml
index 91ecf17b7a81a..60578c3ad4b97 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
+++ b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
@@ -25,6 +25,10 @@ properties:
               - renesas,riic-r9a07g054  # RZ/V2L
           - const: renesas,riic-rz      # RZ/A or RZ/G2L
=20
+      - items:
+          - const: renesas,riic-r9a08g045   # RZ/G3S
+          - const: renesas,riic-r9a09g057   # RZ/V2H(P)
+
       - const: renesas,riic-r9a09g057   # RZ/V2H(P)
=20
   reg:
--=20
2.43.0



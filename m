Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382A4C3601E
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 07:39:11 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.30])
 by mx.groups.io with SMTP id smtpd.web11.5802.1743752343094004074
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Apr 2025 00:39:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=NkZBS+6m;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.30, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrsI+cZsNJJMtPKhJ92gcpzFb26F4S3r67yQ50JBn00+VSkqsTdd3VktWMIf7yxHsfMle55wGSq7I3Nldvzd3J1hz21zlvW0BkiT9GKCnaakp6ieLpttJ80c3hw0J2T0BRjUyb4g5XdkDkiF1biTYVg0NXuWbOBjjhuFeOo8do4yeDmrIiJd8ye8zNx3AzYBJu9XUiC+aYIQ1b6nLYrdUczoTEBe2HMr4AzxiBofqVSca8qpaLT00jaUf8t69rak/HZWeYoIXv5YR/+qBZpGfYREQPHeevICbp12FHW6F6lxr1hltUAyLdWukfkQGyGQdGpERHiVYiDUXO9aOZsYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QH0ZCxc41P4cm0NfazxSq9CIhJ3sXEoGHtxmWF4hZhk=;
 b=ijIBTuR6BwV1u4aL3RhUA+YmbFJ4wv31XaySHU/PBoDD2NzVRP2TcnNJY3JGfGkmfS+M829PaVLYRqkRMz0gwzjANzdUYQ18AYsx3Vr4AmHq4eWdGBKDBnMcgfpJTSlQPEe0eQYdILMIGd8m9uykFIasBTQluad8f5EOrn6fUm/aTJxKiLPWw5WktVxmLlm27NDlnmpqvq/ahNqVaYMb3BQwN38ZG8v9Y31Ae0nIVPbarC9FurbVrrPC34yI/aZ1YD9HVsHvJA9+Dk6ked3p9mPwyUx1FXUfSwL0LaTzTLBdR3lK0eaG7YT8rXR9C34Ijmb1OxdJZDxtRhJ8Fc+M5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QH0ZCxc41P4cm0NfazxSq9CIhJ3sXEoGHtxmWF4hZhk=;
 b=NkZBS+6mIXG4sXJYfYWqK81vftxh1jRh7coFY5j7VbA9vg2VlVYtUEgTEaiUmmkNp/CE030N8B88q9Dw7IT1v9xIa5jh30Csv2xW/yJxDNZxz3KlaE2Bk+/SNhEqqUYD3UqpVBJ+CiVSactmHcCogiFh3RAPHVs1ReaiMuqxp4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13254.jpnprd01.prod.outlook.com (2603:1096:604:313::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Fri, 4 Apr
 2025 07:38:58 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.038; Fri, 4 Apr 2025
 07:38:58 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 5/9] dt-bindings: i2c: renesas,riic: Document the R9A09G047 support
Date: Fri,  4 Apr 2025 09:38:15 +0200
Message-ID: <20250404073819.173272-6-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2d671b6d-f87f-47bb-fa23-08dd734bc2d2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XOvPK2qvJk0yVaL7LuWPqBFDfWJ2z2q0M2uzw9Z0HFLm85sWo1UYY90baWT3?=
 =?us-ascii?Q?stMPsL0FDeO7ZPtSsw4TJLOuk93zmJBYrY6Y212CLKPFPvNfrZZ7pdM6IgFX?=
 =?us-ascii?Q?7OKs3MwofTBis2G5v+oT4rpcznOE8FbS9Vz1tFeH+c9v0KZ6eNqF7k7INoE6?=
 =?us-ascii?Q?kSP/sNly8nHnURtKXmZaonnHweDQqlvi5b2ioHNVy8uSHPSnYVZgGM2JHcMi?=
 =?us-ascii?Q?3RU76joSWKF32EKZ/f8d1QPETorbpPPhHHzwrvcW2PJ6Pj10Hqvl6M8BCgZy?=
 =?us-ascii?Q?5RlYgputgYeJsf7HlezzYozQkvpFr4OCpShkdm76Dot03D9McQWk+/Ul+Mbp?=
 =?us-ascii?Q?IA5Ow2knzjs/QI7dRgwM+iIHy2fUu0LqCxg3fSqPEQRLMDtkvF3sFeHwopRS?=
 =?us-ascii?Q?vzjOJpzY8YgLsaVcYvy7o6V3y4rRKun6NszNzNq85od52uiNGoxWM4HYbMaj?=
 =?us-ascii?Q?UHpUQOr9S4teggi7EaRN9eB1O2ryaEMFeqU0pirNvwpvoZpqzcZJBKErhryn?=
 =?us-ascii?Q?7kEMR/Y4YG8jJiv7HLfiUfrjP26vVzkMswdRqaza3K0LjZO7xEptdOCcaYay?=
 =?us-ascii?Q?uPzb98cKN+q05015xm+GhbgjFrcUyNDm1xcMWQ0CgoSJrG6jrcW3sQJQ8Qc/?=
 =?us-ascii?Q?ENMch4vi1M4Wd1r85IJZuhkR2pGIC3mKHd2fS2Wb0rmr7AXnPGKQBGOiaG0l?=
 =?us-ascii?Q?MNb5UMLDjvwF5ZsPOtiJMPt9cbg+a6ntQFui8duW+V3ai/nRJqPXac36ESkL?=
 =?us-ascii?Q?a0C5dc2H74KVYjYfWYsiB5I2UzNkDcyV5hgwFno1hFQiBCzVQB5fEkwHe2fp?=
 =?us-ascii?Q?ogsMcOOz0KPdM1Qfkbs6YRvbn9yX8JRlYnow4c3qttnBKqDcZGjfkwBskx49?=
 =?us-ascii?Q?ZpHg4FH6OlHWvtzCBSqFIpRIlFyo5WooxsElm5UlaqF7+0i2UaWH+5hqx6Sx?=
 =?us-ascii?Q?J76mHf6IHBrzh3qqI/UREZpIRkjrWWKL+0wnsMHv1ut+ZzjCncuspkPGtUu9?=
 =?us-ascii?Q?lY1nlCB2o805+d24zuHrZr6kH+hGym3mzUElc7BPbvW/sjR5PymqvXJ6JoJQ?=
 =?us-ascii?Q?UtZaY7vqwI9q27WaRJMAybtR9vA6n69yJwgaGihI365Ck5RIJ9tz2SwqcqjX?=
 =?us-ascii?Q?KsitYD+xFu+FrXotj5Jk8X/jV185MZCDeuoMZQD9KUa5Y/297MR1H2WGGnqn?=
 =?us-ascii?Q?vtoLZGpCFHQAi4JKXFEna+IJ4aWZYYlKIaJxhyqLbhl+cMbCcUdx0EC2QajT?=
 =?us-ascii?Q?lqwEjwRp9vA3fDFb7jwd0Aa6jVAWzNK3Dq1FYkXoZBtKKRSroj30LVHXyUap?=
 =?us-ascii?Q?eA5K8NZwo3ep7gXDQF1LSJYyaSnwwaOal8XyRAAGBRjUKvi3fgThIc44e4wn?=
 =?us-ascii?Q?+h/TShLT30kybaG2dX7fgdn2GTg+XozU2GhPzIujI1+FMG+cWAOVd0WbZ9vF?=
 =?us-ascii?Q?Xc/kIxAQi/2scBn8n0fEteleVTlniWJ/?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OPJfD7grqwVBYlj8s84vxnGKDhilScXkPHHa21zomkQ3Nypwzg2pv2G72BWH?=
 =?us-ascii?Q?15JMGl/F2p+3l3V28IUftMTdo3hLv+x/wWujKSpvM6v0lPNcxMe8A550qmE8?=
 =?us-ascii?Q?quX8+BOddJozd6IW5a3SqbNDdS1ltekEo24ZrN09G8GF9Tz6cY5/CHt6+Fos?=
 =?us-ascii?Q?IlIeBwD5HeesOfCRwjJsqqoMuE3sQswtMviJmCg6JL9mLUmjeQ0MN7FK6tiD?=
 =?us-ascii?Q?Y4i8ULqDr/WAmwT2/LE/pUooMdp1D/lsi308wMG3phT9kTojkAK/i4KY/6cJ?=
 =?us-ascii?Q?OMN6v1c1CgYewRbufiBPVYAfoPa/k+MXqwG7jbi4X1//05kOu4A7LBUTZwAM?=
 =?us-ascii?Q?Mzy1DfA5vEWoFSayPl3jd4wU13auHoUoKL1vy7I0QWPaV8PoIDv2v7LuHHbf?=
 =?us-ascii?Q?BVzMpE4lGg5efKYi6eVtGwaalnXfnaDGSo88y9tMVWWHh+ApZMy398AwGEQo?=
 =?us-ascii?Q?f11vkSRK1BCWmvegEUfDArD56L9r7JT2xbr9D/KzB7XvHMsAhUvlXRxGh7iT?=
 =?us-ascii?Q?PcLM/LwUudkmTRqCseYqpZvhGYoGazdJEHTYeGccHFRg8oUUrJ7888FpiX1M?=
 =?us-ascii?Q?XNj/OaaSzKVYN1dt8T4EfRXI4P+wUNgYiuSRPXfDrUWR02hDdrjY3HS6IqoU?=
 =?us-ascii?Q?xHS33AcjTOPAgzkaO6wN2QPC9Y30CF4D+wpj0sA0JhEgvGTUa59jtmlHOTdF?=
 =?us-ascii?Q?wmI+hC2rdy+gkfWaeDN1QckXa5GSma8fV5x514R7kz4DwRLOFHG5MhjSJ3Vk?=
 =?us-ascii?Q?X7uRvVbIfAZ+JiVI0zq126UoYi4ogj6CgwGKqDC0y72vXBmqXfjbsH+PD4ht?=
 =?us-ascii?Q?uMM6A7+YQ1Z+Nw83wRAf1PdUy5gDqu9ifJhqkgWV5fF85aoQ/x9uGx4MtKrK?=
 =?us-ascii?Q?1dJp3Fv3Hc6OU6WOQQQdBi/rd5j0NDcQc1y0CJyloffkDUaPMy40aNFdnNBw?=
 =?us-ascii?Q?eRsd70OvMDhVZSL/p68hQtrGAwEp8B1aX4BCrl3ykYlRFZX/ZEt54jPNPUFU?=
 =?us-ascii?Q?GmKYdJlyjYu+28RTcKEEXacrN8lOV5qV9EDqA1jey4qwDxW1CCyUM4RcIieb?=
 =?us-ascii?Q?KaryN+b19LQ48c/8E8jjv1HqC8ZTjtw0AOtQ36kG0Zhd2u3IceHayE08B7Jb?=
 =?us-ascii?Q?E4udBCiasxKunJ8xFnAV7BQxExx8U0r+kUv2TImAGJhh1wG70ij+QSUuH55p?=
 =?us-ascii?Q?6UgaEa3V30Bqcisfhjy6QSWLhcaRpcv3aA633YIsPjfmrO074pIbL2+x3uVt?=
 =?us-ascii?Q?RMfoRvgoBBkFArzV9D9YXMkesbhsl4vlTGOr9owF2Is+vZ5u3giEUVU/YNiX?=
 =?us-ascii?Q?DM9T5TJg9yE7kd40bg35eE9QGNuhrDRjCxsn7YH+K9812cATSyPXxKvjAjtV?=
 =?us-ascii?Q?O70y8o04acuBvaErZy6ytUMnM24laQ52/W/gIOQsSVzccxhwplFeMd/AqY8e?=
 =?us-ascii?Q?sme1cqWeO/mFiI6YnzVBogtIqHkelTeuyl8v4k+PUspsfq4336/GunMs47T7?=
 =?us-ascii?Q?fP8sEVU4jEosbDdw4ttnn4JhOq83kh7J4OqZKfrw8ylACYHcDFjE+Sv/Uxq+?=
 =?us-ascii?Q?2PxP7wYYocSuBcMUhgLQKlUX4n4PaEknKfdYeH6Ft4NW+wzF6V+18QDi0SMw?=
 =?us-ascii?Q?ddP044jwK5tVNerOaNHyq2I=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d671b6d-f87f-47bb-fa23-08dd734bc2d2
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 07:38:58.5927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNWlWMuEbaQeiPbUwW+G77b40HwVitxbTh3NV5nbXZSrFPskTv54Swf/Wo4CwX4rjz/nRYJd81L7HiBM6ZOjYZoWDPQywdwVd9pWIrjT1/hOGUdjq/ZHuCV1D6hBP+KX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13254
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Apr 2025 07:39:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18469

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 567ef9035f820ecd3e6fcc142003f396848b31f7 upstream.

Document support for the I2C Bus Interface (RIIC) found in the Renesas
RZ/G3E (R9A09G047) SoC. This IP is compatible with Renesas RZ/V2H
(R9A09G057) RIIC IP.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20241216202436.185773-1-biju.das.jz@bp.rene=
sas.com
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/devicetree/bindings/i2c/renesas,riic.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml b/Docu=
mentation/devicetree/bindings/i2c/renesas,riic.yaml
index 60578c3ad4b97..7656c6d8ded18 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
+++ b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
@@ -26,7 +26,9 @@ properties:
           - const: renesas,riic-rz      # RZ/A or RZ/G2L
=20
       - items:
-          - const: renesas,riic-r9a08g045   # RZ/G3S
+          - enum:
+              - renesas,riic-r9a08g045   # RZ/G3S
+              - renesas,riic-r9a09g047   # RZ/G3E
           - const: renesas,riic-r9a09g057   # RZ/V2H(P)
=20
       - const: renesas,riic-r9a09g057   # RZ/V2H(P)
@@ -89,6 +91,7 @@ if:
           - renesas,riic-r9a07g043
           - renesas,riic-r9a07g044
           - renesas,riic-r9a07g054
+          - renesas,riic-r9a09g057
 then:
   required:
     - resets
--=20
2.43.0



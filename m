Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D861CCD98F0
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:30:44 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.28])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10903.1781685042426952964
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:30:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=u/a2K/y6;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.28, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IN9MZEn/fEsJXIMklnBl/nqY6LFTG5kZM04Y3EaGFJDSEdM8dRuwfsKjGmIvpcSXXdrH2vX0poT5Ux07awIVArUTYauW11wLp1NRqirH5Rrs+R/CWnBEiy2lB+lWpcsqWoWZZoZ1VTErcWvBnupBjRU20Ew0OnjbqOYruXjJwj3uakOByl2HQX9YhmtymYhrYB9dIIJtzwq1vAa9HOg6Uxd0MrinE2Widg/q2oA9m6R32Xh5GpDQAuZEJB5+gtw+ubradB/kyIWZOagtgCqwhTB5T3ZKGrWurRS31vegiO2nEI1BH6komhlZd2JX4IhR3OgScBbboYhBAxNZRphFfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9TfcjyziYyW6wDnohbDHjTSj56Ft3gC82t7ZbyyqKk=;
 b=SvstZWYayJLDDIDxSyOGWB9gOMzvayyRN4cLoJweu9thb009N+P7n0MJXXO2ZSlZR0xnp/nCb1T3J/d1wVrLM25numPY6mZ7su5iFWXlbeZ2TOQ7njdaFT2Yb6SZ21f9Z7R/HAJb3kUqC05MfN13trP1PqOWFdDvMZR7V8KLxNhN7Rn/NbDH2vTP3na7M4aT6b8nSpz7ejgL76Pv/8izkVup/cTTyZ5QuMhJpHWt+9u6B1Rx7iS8LI3kY3mv2X8ofbTwXKjo95YaU9B+t5z6dorLPD5VfwBlYpsn5Jw6EBz62MB/PBz5C8PdoH3vW4225GiJl2YNapC48fkQO49T7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9TfcjyziYyW6wDnohbDHjTSj56Ft3gC82t7ZbyyqKk=;
 b=u/a2K/y6ht52UYQVrjPg+zHmFF2aXVvHPhuln7CVj9YzYIY/1k/nunSZqjbaK1deUsu97/mQj76UMRIQ03g9O7n0kLkN2nrTV217gD2e/uL49IdY37l8Ru8JitWdtqfQ+fbVhEX5rRRA4YRlN/2gju9S3tQmOMYmrcos2kTo5DA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8217.jpnprd01.prod.outlook.com (2603:1096:604:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:30:41 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:30:41 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 05/32] spi: dt-bindings: renesas,rzv2h-rspi: allow multiple DMAs
Date: Wed, 17 Jun 2026 10:29:36 +0200
Message-ID: <20260617083003.1071543-6-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2510add6-3e43-4fc4-bbe1-08decc4ab73d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|56012099006|11063799006|3023799007|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	FkmJ/aDeYKCs478l65L31qkr9U2K+I8hhQeisEhQqWrsnBpij1rdc8cOvqeUWMFKuckIiJbvXUeeeCi9Opz4Qou7Ww2MbeOoLN4AyP3Dfdoi1GQbfwYArYZu0R35ATFsee/LHO6z43pwRc5HJ3zRZ1c7Xf8mdbgJcqgx2l6z1c76+2XIsg7Y23h6NNN5Ht9laDhdetaoCn8OR+TVwXxWcktpL2ZhFFOMOUGZCfzE4l19pLhI4VWD7ghJ15xVo/64AfdF30H8ctdPwZoDWnFjOaEp6ji+gfUyTunhb1wkqEFrdA3rV6JVW4ZykKvXozNnZU5SyQ8ZZuk/P5Zabws+4Dp0BGzyxo9olZAAfppNzzl1TScptdPI8kdmT8hdVlltCnP3z7KapPDH1BXo7km1vdXkICxtQ0Vp2l4Ghe6lJQp4L4SxMC8rlgh1Gjm0EU8BBEVVDHQDJrQyW0FgO7n5I21hq9paANNrCctHZxSn+yJlR+09lLZ++VdtpAeMof24EKdEXYOAP8r/TyovHrkd1JNEmueH+W6i2n/SEJrKp5dxb5kHxBBKt9ylOMxaHbnbGs4rA5poBCfEFwZacgI05D2XsMnDsZrHmVVIhcxjsWUXmuFwuugDtzSdVsl4lk+WSj6bL0bxUVsD8vW8WCaqiNPEW1TU69shyWxKe+iw7mopdb0LiLLa6K1vIHyha/RhZkUHz9tskQIEylXmLXcbgQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(3023799007)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Y05XMPovdvaH82UI0MGw9Gq3wJUcRTO1mUIIL20r6EMyTD5A9Nm7h9VltXUg?=
 =?us-ascii?Q?BTVNQa0Gy42dmzMjPGqR53ZoyKdZPVIOHOsKmWh+7F9yu26FLTUE0qWYVuhd?=
 =?us-ascii?Q?suJlnD1n1HdaE+AtSIoIObLCYuPHNZOC42DhJgbXtwBG8bj6Z5cqICtYVuxG?=
 =?us-ascii?Q?8OlP77VdNNCaQ33uBcUnhTr4om+DVeFr3cYEA2HJxVlkwSWEhzAvz0Ex7Uvz?=
 =?us-ascii?Q?VER7YmBU9QekmGW4GHMumQYnzFZBp6pzv9MXhQP6VhXGKk860sC48qkSyAcE?=
 =?us-ascii?Q?Vgd2TX9ozwGfVRC0XbASFEfi2b7iNFnUkmp2y0eVIw7JnOWeJW5WrumSQ/Rd?=
 =?us-ascii?Q?+i34IaITALa4YH7YIA4CeFnrkcvyjLYI2CJRre9faLKde1bgbvQNlQ5Qetjg?=
 =?us-ascii?Q?kD/ixjvK4eKSs+PlHb4uuY7NS3Grr8mXj0K8bXB8XgNQvyXGwjl5rBmDyY0Z?=
 =?us-ascii?Q?ah5tTiPdG0XuL6mP0kaENuaM3HD+J0PbJ7Q5JwN0/XLxz1m5Vha+ypX/VMU0?=
 =?us-ascii?Q?L4XmhL4cZGPja8CXZqK+X+vdKKgPo4sR8D2SY1He8aAHK+4cH2n4dM7bhdZy?=
 =?us-ascii?Q?NYpmJAGElQvJSwztEpIY69twYWeKUoFhMCZ7Na8+YS5/BtK0W3k35OEewK2J?=
 =?us-ascii?Q?wIGwdq2VC4GPmSxlOme8Z0HYvHUAdMf/l3MlS8NejaBCQlMudzD/TiVidtLP?=
 =?us-ascii?Q?S+vWi6q4Go3vo41SrK5OxmqBy80D2JE5a440rLjM4+2PnaguWs4pjW1CIlqM?=
 =?us-ascii?Q?jPW15Gg2uT9sQpITixb4YQyDwv/A4HWznL1fckYNgFdyFCxXm0Gf8JMhMMD4?=
 =?us-ascii?Q?pd6VO0rimN6RcFn4Q+0vr46s2mXh0p9MYdMaRyteh+Z45A0NjUD83AOVFBOJ?=
 =?us-ascii?Q?tV0K1FYSKgqnehTfofc3XLB1gZC3R3AGdAP6Q0CmF7lIHJENBnpVolbHsOyy?=
 =?us-ascii?Q?3kxjXy9X6MQ+4mVFHbMf6zWlZ120RIcBTguZ+FRJ4nxC8QJoMNud52tBn+wd?=
 =?us-ascii?Q?ok3B9Q9IEF64Lmvb1mkqWrDbl9AdD+YI/pP9XIDNJvPza/ofS0pfmCWEJ2Yi?=
 =?us-ascii?Q?MAppP/7KrjlrT/AFMfS2b3AKSb85pd/lQdez18N/uvMzsuARCr6G7QKCsUfn?=
 =?us-ascii?Q?29PczJURlBIMsFxaUr/Qfi/kCg0Fal4NNEUZT5Z/ZBeuE7oldrzrgjWpX3Ch?=
 =?us-ascii?Q?21THBa5EM7qFPl0GCLlMixssHTZY1oc20MrYiz7JVIGN0NRIJjD8/GQnV9D1?=
 =?us-ascii?Q?26ILchUt3lig9KKos5CLxN+wCD4MU9963T4Wu+u7SkMHzNhvGeMb47LpE25T?=
 =?us-ascii?Q?w+IooqU7TovuEsJ7kp/nB2Gai4Cp4E5QMjEEmUGYsYkaDoB/FDzPQC2wjL8A?=
 =?us-ascii?Q?sZghsWLKFZAOCPVdwAp08nHVHNb5qQbMPmV6bYsLoKUHLejf0s93jk52rc0y?=
 =?us-ascii?Q?SDnsc4T9NaCYAhJJ6CKDQM+DE6/gY1EF1xwoI9AFgMkUMEUd0ufRW9yyQkZd?=
 =?us-ascii?Q?89VfHsxiWUh7ELhRXTyVKpGZ4F6DEaGCLUTT6lefs9ToNpbruynfodSg/9gZ?=
 =?us-ascii?Q?1xDOY2ckjqUWNJWKgKgf4+YdOgScyjwGBRqAJMFaDUXgbc5lyP9sv8A04DY6?=
 =?us-ascii?Q?utcNiV5Tt1/MPFyij5wErX5EBNT/qtvS39LvJu/O6SXBdUFrIQ4aBCSkjy2O?=
 =?us-ascii?Q?Sj8HygSYh2hqCjU+tpp/D/PGdADCaR7EJCFoAjIqt4w0eXOkIOJ/bZOWM4aH?=
 =?us-ascii?Q?hCiBeUbEIa0Iqs+h/BPxSmXDSaNCvRrFhgbqBACct085D8Vb3Kkp?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2510add6-3e43-4fc4-bbe1-08decc4ab73d
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:30:41.0516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6E9FjDm++TVwbe5Nw+cDWSlcWadYDLvrSw6hSTEuh4vwL0wsKPwOunEDlAUh2kfxoUWNrV2k0lndhcxypBNraDmZ4VuHTblSpG16bhRHiUN71D3iWHzs/Gfyc+8bTjDy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8217
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:30:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23164

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 4d28f38f64ef69ab27839069ef3346c3c878d137 upstream.

All supported SoCs have multiple DMA controllers that can be used with
the RSPI peripheral. The current bindings only allow a single pair of RX
and TX DMAs.

The DMA core allows specifying multiple DMAs with the same name, and it
will pick the first available one.

There is an exception in the base dt-schema rules specifically for
allowing this behavior (dtschema/schemas/dma/dma.yaml).

dma-names:
  anyOf:
    - uniqueItems: true
    - items:
        # Hack around Renesas bindings which repeat entries to support
        # multiple possible DMA providers
        enum: [rx, tx]

Allow multiple DMAs to have the same name and only restrict the possible
names of the DMA channels, not their count.

For RZ/T2H and RZ/N2H SoCs, limit the number of DMA channels to 6, as
they have 3 DMA controllers.

For RZ/V2H and RZ/V2N SoCs, limit the number of DMA channels to 10, as
they have 5 DMA controllers.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20260128215132.1353381-2-cosmin-gabriel.tani=
slav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[tm: Removed allOf block to resolve conflicts]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../devicetree/bindings/spi/renesas,rzv2h-rspi.yaml    | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml =
b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
index d7c32eb9b981..21f53d9fea66 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
@@ -57,12 +57,16 @@ properties:
       - const: tresetn
=20
   dmas:
-    maxItems: 2
+    minItems: 2
+    maxItems: 10
=20
   dma-names:
+    minItems: 2
+    maxItems: 10
     items:
-      - const: rx
-      - const: tx
+      enum:
+        - rx
+        - tx
=20
   power-domains:
     maxItems: 1
--=20
2.54.0



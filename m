Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C6EC35FFF
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 11:01:49 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.3])
 by mx.groups.io with SMTP id smtpd.web11.18721.1742554904074568291
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 04:01:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=c7UaF3NY;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.3, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cI/Ot7njEoMEiIgXp6aSZhGMK4S36JfU1DRdRUVZrtTON+cK01tmjB9CxkzRSd+UBvVqPx9MPZghudoHekPBcFK6KkfQMyMz97xSZSb2RxbpYjBizfaBeiLpuVG8qu9VeqP2YjM8CE716UIR4Qs2iB6hvnC97LWss1Gqz8gtVmMfgAaOvPYgp7rmsnkiTdc6ROXJA7kwHI1pUx7W558acKydo3urk5pjVmMAuLmEI8vJxZ29mVLjSStshm95jF+l9R9As8lv8NdqRLPccRIX2NGNCBIeX57iwLdCp2OoDT56FbZHncEnTUo9dH82pb9eguzk4nvHpBeBbkKSKvGwVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFR7NnC+6KYxde1mexzdjE+uSrieNV/aV0ve8fYu9EU=;
 b=Wyn5qabKdlAH2HjcQKQTdS7Fe4y7mACrgCuwNbrg/Tp/85aa0HE4WzYf0YuXhJvbajVSaka3SNpbR6eXCm6waVeR5fL3O9UqjsEfVqC4SCuTZz4SDWrK24j9BlwhTL21dRqxfd8s2KxS9yKang84ZWSKTmFUrTT8tJeE5QpU6SHo77tTpe9xpxALBJTClQG0oTJjp06/ZCpMM7QmvcyiOR4P8Ic7jaqNImmXzxwkQzerJyCvcn4gPu25zLRA5MPc+yt3ehu8R2Uda833dzkG0HiYwkQJVnLb2GZvjNnxnOTtDmPEHMszWxiA1/4Gb/BSfXi+wIAGgGK/gu6dE3vS5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFR7NnC+6KYxde1mexzdjE+uSrieNV/aV0ve8fYu9EU=;
 b=c7UaF3NYZ1gj0QFy5PGDxQaO2bhq/vevw+8PoxaGgfpxWpKOUhiAxa050vbGiw4H7mFisJutKiUQ8npkq96m7TWxm7fIk+I5G/sR7rjn8XtGwmA+O3RTLKhcFbsLdqDEwW0MG/Pv/eSUJDYqvjIxBdYJwuKtAc3cUeQn1XtiQ/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS3PR01MB8652.jpnprd01.prod.outlook.com (2603:1096:604:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 11:01:42 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:01:42 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 21/21] arm64: defconfig: Enable R9A09G047 SoC
Date: Fri, 21 Mar 2025 12:00:21 +0100
Message-ID: <20250321110021.3612805-22-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS3PR01MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: b70e3727-1a6f-426c-e83e-08dd6867c2e6
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6shlXWYY+GBtDeYXpM4+wBmux7vP/DHAiH0ECpFaR7Gxw+tvEphGeEz3Hps5?=
 =?us-ascii?Q?l1a1Vq82gQRfym/40Qg3xJECncnIUAmfjM4zAohAooNrDxs6eD2u84RN1+2Q?=
 =?us-ascii?Q?d0O0uLKivVWIaUtUlQakUy4zysr40hQfMmijVpi782s/nNhGRQOLoEclMrl2?=
 =?us-ascii?Q?b5yW5lv7M0bi5SSwyvqNj708ZxTqfXdQTsPabEjGSVhSao39IRm9F74olxUd?=
 =?us-ascii?Q?ZDGac0MZWbgLt/bXtrwkMytOCEJq4MEvIyPdROAk2c32j21AZWLRE02iWQRP?=
 =?us-ascii?Q?6CK/fqJtRb8tC/EMR2t5/CQKGfLRSe5oLS75c5dSpTfiyobBKhwmXx632cAZ?=
 =?us-ascii?Q?z6ADI4glD/2Kq5yIcOX2hbxC4Oj59m9PRMRbymT1FEN9/UWI8VRrHlcmarqq?=
 =?us-ascii?Q?mt37/BdCxAj26ZEKfDqDFQlnMOYppdd8tv5znfCnyHR+5QeOhprRObKY3qsB?=
 =?us-ascii?Q?61Vihn+CxvbGB/xbROPvorceWReqlOCOSulUmC4zou7QKahQfjTERtdyyA+X?=
 =?us-ascii?Q?7KJIV8rzO/n+8f8G6z1G0ScdCeIrWXkpDQZ0aH3y/mZPZDRXK2zszoN88ZsH?=
 =?us-ascii?Q?qXMjm54/zeHtjsI6bQ7/Ht9aHWXyo6jmgozu0ZcRbPpQlNdooNyThLQMUO/T?=
 =?us-ascii?Q?gZwW483P07/iZVI/xkRSxRln3KbOXmSG7HYD2WR7b8P5RcUWwhLzw+O79Ar2?=
 =?us-ascii?Q?/livp9eCZ7WbO4JdI8spy1PxeOKuIeCEwD2nitOjtIVOpX0j3B7Ukgo2zCVF?=
 =?us-ascii?Q?UhrNZ8nWHWjhCkLJ/Z6PwlkrFF1bb5iy3cl9cO2vXMkmH3C2c5s0zH5jLXCJ?=
 =?us-ascii?Q?JRwESHaWhA4M96svGQrerxBBVkLMCTyee1sdrBax7E2UZcNGUb5RLiEATxdb?=
 =?us-ascii?Q?cfvi+2nSSFvKHYcR0SPLkWHXyPzKIsyN14SKsVol63cjb5nb5wOzopGoJAaG?=
 =?us-ascii?Q?9eWwgdiM848PuCxHN55O+/Hljo9r0PhGq53fcfG09m2Kj1K01cCmpshtLDuE?=
 =?us-ascii?Q?WZPRP50SJ3TuOQuowjtaRNaRNGZECCDRKxixUF/8/qC2vsJazx7BTR3JeuDs?=
 =?us-ascii?Q?S3OqfhoOD6u7tejHXgxUmqBCNSAUPQfdkFkO/lpXTeB2h3iuyEaXVoBBXFdB?=
 =?us-ascii?Q?dwuVO3DvWm1ukm4YT6seP+zgeZtgZCkBQMFLw4hNtTIZ8dg723JUyCmtrspA?=
 =?us-ascii?Q?BvH13n3xiVruxlrEKyh15nHMZONgkqGK3CRP3pTdexpY2sky2zIUB57enhgJ?=
 =?us-ascii?Q?1b8vv+SmP5WQljr2p5OE7oejAY/fK5+QEAhi5Y1xzyn1/6+mSyWNhNFCBN7S?=
 =?us-ascii?Q?gWH0yAS/ei/yre4YWr06IRVZivydh/4qAmFIiekmngGNaPBy2YdRMLno3stZ?=
 =?us-ascii?Q?5s6tKuO8CdxItlYA4BKUAAWqNwzYBTC+JysgsCGT21mjGNlDXxe1CwdU5GSY?=
 =?us-ascii?Q?mgDygX34ykorNNqMJA49WWWe3daTkPnr?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0mfwWsXi8BNFTkwtc6N/q7e1qHw9wg3aFvqntZnlb/h2t/kVRkIraNYt4rZZ?=
 =?us-ascii?Q?+vJL3ri9JMC11pweYmxAmkHy9NqCnnn3u3qn9egOOwyBKd+2l6mHtFb45RvH?=
 =?us-ascii?Q?wXVp9C1OGQODQ3N/vFol5g8xv8XtMx7wbRTlEMQoLalE0/RVE/tEmOpVN3o7?=
 =?us-ascii?Q?jya/NtGk2l6AsJYZK5YU0aqptMvVTRSrC33TY/bmeHZSTpmZ23HavW3GgTtZ?=
 =?us-ascii?Q?OWsNKAJa+5B7WZ3iXC48VJXVfjSF1rZFW5nzD5PNbV+PyaOebdZdBnIQCLiZ?=
 =?us-ascii?Q?3OObQ9kHuQCFcKon5zdYa2rDR5EEcm8q2bbf44bjLzCxmf3P3ZZHzKLNzNCM?=
 =?us-ascii?Q?balLUChaJdnQSkiFvzFWAmaTMJR4kusDnmBaaWJyg9rdlAtoMm/WIB8fWKWq?=
 =?us-ascii?Q?r+ONG+V9sh6lgb4SBSjOhvs+2ftkB63jE8rPEm9dh3gQQnCntvpjVaNCF7Sr?=
 =?us-ascii?Q?v6dkPGsfBktwaLSwDP/4H01OWLfD3QZh3ov0SA2XwWSfLiybAyKiFIkZESXH?=
 =?us-ascii?Q?X1qXFYPV6ctxeNObdOdQSm3z07S51OS8Wd0FzpvwTjTQMj7TNQxBPeIFl9RW?=
 =?us-ascii?Q?SLFMqZBRCLFDwf3ISvvawtq8kkBZ1Ft8QYNBzpt2M7BJW+s1zxUsJFNGNNyn?=
 =?us-ascii?Q?WTN5wHbLymjbrf/yX2qb/WaHIBcTYdYzEhMaliLPuUBdRrPWB+FOnIMrRykV?=
 =?us-ascii?Q?rbplIJxIBE7iGC4K14s87Iih/58HM+LQWva4tiG961VTasPA5wolXdXfMSny?=
 =?us-ascii?Q?xnk0sAV5YQoD2w7f13WykhnTOVFO2UEASaaGvrIouBUd0NVG3gm5V6mosinD?=
 =?us-ascii?Q?STaOAu6ufXjDbszRzdKJzUH+wWtd6kkoxD3tlDZCvWYeughrndUhL8+OJ+89?=
 =?us-ascii?Q?NwCFBkOwPQP5RtWdUGR0yHO3u2hSbI3I4Ym7uOsZJA6URJNTAxqjVo6VlbIM?=
 =?us-ascii?Q?ZwAMWxYYmI4hoyp2hrFcwNfgSI2Sw+OHkLFNW4vuscejaMemYUYYazwbgPmO?=
 =?us-ascii?Q?LffWDbTHOvGafvJHrPtyZ9/Mqbzqzm28SgN0qE5STWP1wrAcd+T4HPrHM7+Q?=
 =?us-ascii?Q?oIbkDcGapMlR1xJHL67PIMSacGemM5ChO4vk4AaQ6a5efHZ+ViIqvXw78Uu/?=
 =?us-ascii?Q?qKSQpz2XQVy3nF1lNDWcOmEM+IcGPbEHyIUZELDFsCDNGKVZ8ryxJsk7wRRa?=
 =?us-ascii?Q?ysi207cIQTr90qjUzbqy2cqQ9kms1U54v1YpjOJfF8JkW5NMYXpmSqjIZXos?=
 =?us-ascii?Q?qwu1J+jsFWubSSiBGf7ejjtq+R9RpVTBCH76Kav9IdfpHXzl3pnV0r+/aA06?=
 =?us-ascii?Q?hRatz1xDEElHtdgoxKaDKVLq/HFR9rIAEevqJf7rOaOPjs1M9vlHipykztXZ?=
 =?us-ascii?Q?nur4Dla0h7ZFyBOtxWEh3qXU8pMzqyg5vX7XNwog0zNQBRUA6DWdXbYURtRa?=
 =?us-ascii?Q?ljlU5Fn1l3INZRQjwZevnf9cpM2961L/0/FbjvLghfs7vitXUJDR0nf2/1B9?=
 =?us-ascii?Q?dGnfv3euGA+b0iCpqxrmMlJy/PlYvENgDVbIR9ysBq6rOIAOApxWAMj6OazG?=
 =?us-ascii?Q?Zi/29l4mV7Y9y4gtdNeNx1KaqRqv7FKn79mDXTAxZ+9RiXWXN6LyUjvpSEfp?=
 =?us-ascii?Q?DTnRfeh42b+Zmte/G1AkgBU=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70e3727-1a6f-426c-e83e-08dd6867c2e6
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:01:42.1122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UnTH9gMWKWJbVsA4UpRrYieu8UKFEMSz9SB+7LuxkifbDkZCtrGRpL3sP9IKd3MUoNVJb6ijqj0VrSOKsRkslai2oEUssOYdGXSFc8IN/uVuyc0IGZ5gCDoSY7KYnYOf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8652
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 11:01:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18328

From: Biju Das <biju.das.jz@bp.renesas.com>

commit a40f02b2923b6d58e76cfef760b8ed61a00f1d53 upstream.

Enable support for the Renesas RZ/G3E (R9A09G047) SoC in the ARM64
defconfig.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241203105005.103927-14-biju.das.jz@bp.renes=
as.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a15bfa82fe59..459c1fac90ff 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1182,6 +1182,7 @@ CONFIG_ARCH_R9A07G044=3Dy
 CONFIG_ARCH_R9A07G054=3Dy
 CONFIG_ARCH_R9A08G045=3Dy
 CONFIG_ARCH_R9A09G011=3Dy
+CONFIG_ARCH_R9A09G047=3Dy
 CONFIG_ROCKCHIP_IODOMAIN=3Dy
 CONFIG_ROCKCHIP_PM_DOMAINS=3Dy
 CONFIG_ARCH_TEGRA_132_SOC=3Dy
--=20
2.43.0



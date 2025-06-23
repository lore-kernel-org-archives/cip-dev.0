Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F089FC77B7F
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 10:28:08 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.22])
 by mx.groups.io with SMTP id smtpd.web11.16546.1750674485062861037
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 03:28:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=o4jySiD8;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.22, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1d6Oddnl1reNoEczxf2vOTmqvDtejFRrD/u/o8Eh51/6TrMwbe934WvcNvmNMKmn7RCous9I7gAkoW+xYNkkmgglS324d4CYPkPx64E1DiWpm6TcqLogLgClehy40WtN1Bm+XsK3VlJcbohh9hhGk9BgyaxILrun816/Q5IvAWDkO8ye1zJ/quCwZ8IYaHMUE7DzMZSTJPU3FNNkg1syUKAz844Rb2fH05uOvSHv0/F10a/I+4Jy12b9y2taRzSWaiO8ivKifPjO4cMjmvg4DVpW2wYWF3qtHde21CYxINf8U44L3Q3VTDgBLlVbUgX2SQH/jQHcM5o0Tf7hratYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iafSIavYTpzoyedpc6FoL+CbSj1BTGDaOWs5qTkhEQ=;
 b=m2L1yCrso4BiuDjqJpsdC+R5JNhC1O+zHdTO5Co/zjwZG6VvfbArlnyBgRe8scbM1KLKsVZR1UnSbDPyLxhnKyf+6mo3yEqWmDI0kayn3aHGz6wFoYzIXW4SuQA4+bMaSh5mGSIPYDZxr4Cv4s0dubttKrZlCfvJmZkm9hQzIJcNQ6gHu9UzYjmTSb2N5jZStYTxJNLUK6BjYZ4SKgwWXiRskVRwjtmScDahh+98EbZkGUHu1hAWnVSGic4ZA9ekL+peoUBaBUAQjzmZPQJCGo08eO5QuajGitimrCycOgIFeY7xYmBPQGRyxSSdkQKwXXuwmqw0nH5lx9Oz+eCWTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iafSIavYTpzoyedpc6FoL+CbSj1BTGDaOWs5qTkhEQ=;
 b=o4jySiD8HTDPQv3fpEgOjFlWIOXdjyp48PTPiG2kBnyF3L9mITLlnj3OIxKM57E8w0N50UrXoOB00dshFL9r+reG6YD2o6orLLdnUDHBfSUH9ZKLHnoPUAhYwZ0Qi0Ctns0eWWdi5SrEP2UEvd6OLgnpI0PZfTxhrN/C8DjnL/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS0PR01MB5747.jpnprd01.prod.outlook.com (2603:1096:604:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 10:28:04 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:28:04 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 4/8] dt-bindings: watchdog: renesas,wdt: Document RZ/G3E support
Date: Mon, 23 Jun 2025 12:27:26 +0200
Message-ID: <20250623102730.1493286-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623102730.1493286-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623102730.1493286-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS0PR01MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: c2977b86-925f-4a36-a100-08ddb240a2fa
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4nWaDe0H6HKQQXHcYKXHi5B5QLwoKF5oI+jHZtTkcJEV4+LlTvA7oiLB+n0u?=
 =?us-ascii?Q?mFzcqJ+PHVGQyFkmC2KGF3Loi0toKpH5WJdkV3FBV38vv/jxEiUAQAOEXtx4?=
 =?us-ascii?Q?Z4qvMmPdsmg6wSJd2gsOhfq+lB1njQVj7YZyMdUyGp7DMBtxa7GgPGMSFpxW?=
 =?us-ascii?Q?J83QSS1Gxh0jp9algTKwlR0iuH/5jc58PZeZpiRCdwUHFWtO4JacvkXu3UPf?=
 =?us-ascii?Q?E9Y3hvf9HwufzJhpcaGP1P6CfGSOF3IblCpOKIMd5B7IqhsOJTIBSGk+MeYQ?=
 =?us-ascii?Q?tkgEVwtdb0T1/Jd5cnU9EXADy7QYKB3CcKREIRiUBHtu9//a9QEoSRzShM+N?=
 =?us-ascii?Q?rIode0AZi6q4IMQ9592S0uuXgjmWWKvyAcBRkR+J0GMCGNfM20RYPABHY65p?=
 =?us-ascii?Q?y+PBApmO3XnEIZ2rE/VEeaf+dFtnBTpVIlNBV64jtJqRwnzM6pOyrpFk0zuY?=
 =?us-ascii?Q?iJzfV0yNOKSqk61KU/tcfAEHL3f83g/M7E+V4ypMaNlL3k5zkG+Wksy1unS8?=
 =?us-ascii?Q?ku1sHfQKZzyagRos3iTNgEWFfBl2lUmYcn187UNgJX5j1hmOlyNLdIrax4y3?=
 =?us-ascii?Q?NOOItyj+5FH3urcMdPyV2lqgjL2ezW64am6KmG/QQVH0lex75eMIKM2oPsxh?=
 =?us-ascii?Q?kEgIpJ1R2EqR/OsJFXOq9YHUh7zyHPoOhcAQ44D5eSRgTyKin5N/LrK+l+fW?=
 =?us-ascii?Q?3zgno12AN2H8N7u/bloeBshoDP+vk5N0CljwnrICxYitf1C9kHNV8KOP/7HE?=
 =?us-ascii?Q?0YPVNg0c9Go8hFGkvPFX4IOSlwBKuqjW1SuYOFb6DD2iTWj1Rx5voP8CaC7G?=
 =?us-ascii?Q?H7B7COgaXWFtuucfU10i4Yc1CPB2JlDiqUoxPsS3WQHAHYzbbPt8/vQN6IYD?=
 =?us-ascii?Q?sqsLsX57X+bsXwHUqY1WZY1LltnQrPRQTFg5jhIbza3iFmH/I7oCHcbBnun1?=
 =?us-ascii?Q?VgwEEUhIEs4VTQcoQ6YqM/eDOy2iyrRp+Y6Dk1ci24fTA/dHuA3XaYx7o6+I?=
 =?us-ascii?Q?jZw590vGweXzmM06X2yUAziwhxvADru9dGidH9WmgB+epeWW/qG7Zp3qwLnx?=
 =?us-ascii?Q?EFDd7Zv7u9B+PUgpX//zScYACElDB2ocqfe/wIqbNR71PHrbm3r473NN5n7z?=
 =?us-ascii?Q?Qsay1zh2k+mNvtaa4XBe0A2eX9O09zkMKIPkRrycDDSejpgCE0XpAf922A/+?=
 =?us-ascii?Q?WoE3Jf33N7SQW05y87j4w9dsFHOODc2EqMmcjM/spCBNjIs/JllDB+jw3RJe?=
 =?us-ascii?Q?JsmZ4ViL1FfG6S1XPrfF2NLEQzT5twc9E/C/pn1HGFIGmv88UPKjYQYB6wiQ?=
 =?us-ascii?Q?uYsiViSq0EVAoQzPYXILO61slSCvLU47/kd5vktt5lsB63oFrbyPg8B81aj6?=
 =?us-ascii?Q?KFOGntd5XHNw6qocLG0HHvpEqnQUbOt1lRVVQhNWfMkG+p69vm/NYw+iJ6Tf?=
 =?us-ascii?Q?kkkKGBLhV4sSj6BWL5o4d8NfWbGbOUdaHF1R3USfNFJ3MRDgc6fOK5nQYZr7?=
 =?us-ascii?Q?78I8UL/8sK1Gktg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DO708jfC0ff9UehZMj+iAoipxs4DCthFKIP8K9GQY44ZHCI0z9lcJ4vmj7BV?=
 =?us-ascii?Q?7bWcwPoztoLCkeDSUrAoYVMpgsIIDPl9fa1ReRwglUp/K0qB4uMi74ZEEDf5?=
 =?us-ascii?Q?0fuId/SQyHyrYQesQO2E6Pg0Wk7WRXc/DLQYmI+TYOuiz2IqmEPYJ9sPwkXO?=
 =?us-ascii?Q?wSgGqOi30QyYHwv6Zt0J43rEmJjaCdSHdBE+TkrhppTmCTQ2FkeHjLg5Of17?=
 =?us-ascii?Q?O5IZG13Q7YuDKy9EiTGApovXDDMDsPxlEP1s5QsiuGe56jHD29VIv/dATYUW?=
 =?us-ascii?Q?p3m1Jm/3L8wUXUF8wQ8j1SPGxT3ZkbP8G+tHlK+HQ5DBYXzyuOC7bLnCpzBW?=
 =?us-ascii?Q?AF4W25c8h/cXMrUpQbny1b8wrUy+SHWgXBykztg0yHtNHYpmG4kG9DlVWePn?=
 =?us-ascii?Q?oXA8LRrl03UzikfxHRZ+Mvesve3aVZocJDphQm6TlO1RXmfheaI78dBTpGJ6?=
 =?us-ascii?Q?3058yhJpIySW3RvVkCXWU3gsnXEVY5B6E9BufvFtiMmpvLmmqqWG7WFwzlsT?=
 =?us-ascii?Q?9zwRk2dEa/OU1QpV6eDACFiMCe3ZTDjQ+FG5lPZK4ZnwoRGrhcTbNlSS1O6P?=
 =?us-ascii?Q?eLVonAFyBX+8rQZ/a1Xwl1SVSzCX1WcwwlLtV+sJdPvqWHu4evXgKG+nSo1a?=
 =?us-ascii?Q?NP0aE0ltSta1hShmuixRNduABScDE4zlLti3u1GdOtE45mJb3C6TOeO3e8Xg?=
 =?us-ascii?Q?OVNoctXESLEdRWKM+uM+0VxdwSCHQ2LJ5Yx5WERARNNl+rVTWCNekqHRRn8i?=
 =?us-ascii?Q?GXB3BKl+O9IraktqO8OzBrnVBfj1p7Pq691jACtH1JNmZdOf4pEU2DSX4+wa?=
 =?us-ascii?Q?6BCARWVdnWqz20E1rRGGV44y9z7ogR7xogQam4rvcrqYSSeqs2eDn3lD83hG?=
 =?us-ascii?Q?bcTVH+beYESqHLM198/CHRGDxRgU18GngIRgn03veNN/PJQedAB/64f1mdzo?=
 =?us-ascii?Q?rDX3Y0ez5XoRH4W76OZI1pIhe5w9bRYVonJ01VvT9jtdulj19xVP6etyQ+TA?=
 =?us-ascii?Q?TezWRsTpbMyuwn28NXIp1Y20ysMJason8d/ge9qXdNWL5TnFPOUVfCG7d21t?=
 =?us-ascii?Q?3BsIKzPtS8P/Ogj0gY4q2L0jQx62iWwPj7R5FyKpTDIEvDZdqzh4bf1jqef9?=
 =?us-ascii?Q?O+YJc/aANZ/ICnOZFmDtfb6KI07m8v3/TCI2xGfvrlIcey8zv2tySbVctFdb?=
 =?us-ascii?Q?zIIzcesAxjeqjy+K7mvju5H0yW/oobHL/72LXO4UMF/7RbwcDPikiJ2Fj1YG?=
 =?us-ascii?Q?HmBRmAze4xawEb4YMYHTu0INZ9+T2dpWLfGKZ13IEFt68ITMl4jSaiwBDfPS?=
 =?us-ascii?Q?otlBAi8T5rUqMWM6lYonC8b7TQ48mgNF1M43OT7oPB8dibKq1PMMv70bCFwe?=
 =?us-ascii?Q?uqr+BsFPxEDcFivDb5Y2RH/ooAq1hSl6Ue2P/RyzCGsyAbVaxs4wb39yf+dA?=
 =?us-ascii?Q?yBbRNHW2Y5fpoxHKUIrXnMP9JcPKcK0Niop3r6VgRdTGEYK3c5gvbn+SUScn?=
 =?us-ascii?Q?qn/6fbF52x0vswY/pcx/xpv8XmUE7zjN0pYUqSEtK5r+tzyZg5045CvcltIV?=
 =?us-ascii?Q?/xO2KQlkkaN0zOctChB0tpxGP9a1555UUZ/x067Moh1y81VwI3gvtV0FOu9z?=
 =?us-ascii?Q?KqgzWA3rFgWPy5TLQL976Gw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2977b86-925f-4a36-a100-08ddb240a2fa
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:28:03.9790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Demh+d+P+vgYAngHurZyAgk++Xsh773rnAh0W1vzIi0Ji4Bik+lVNS9RSk6H6iwPyYEgOmAWaccuCLasnlm1Od2UbvQHJiC8224GLhFyQrjw+EK8xzeOD/aWHzihMiBO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5747
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 10:28:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19169

From: Biju Das <biju.das.jz@bp.renesas.com>

commit c40524d1615a72548adc30dbfb15c981fd03dacb upstream.

Document the support for the watchdog IP available on RZ/G3E SoC. The
watchdog IP available on RZ/G3E SoC is identical to the one found on
RZ/V2H SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250126132633.31956-2-biju.das.jz@bp.renes=
as.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/=
Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
index 62ffba8545f9..b8dddcafdc54 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
@@ -73,6 +73,10 @@ properties:
               - renesas,r8a779g0-wdt     # R-Car V4H
           - const: renesas,rcar-gen4-wdt # R-Car Gen4
=20
+      - items:
+          - const: renesas,r9a09g047-wdt # RZ/G3E
+          - const: renesas,r9a09g057-wdt # RZ/V2H(P)
+
       - const: renesas,r9a09g057-wdt       # RZ/V2H(P)
=20
   reg:
--=20
2.43.0



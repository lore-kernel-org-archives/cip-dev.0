Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEFFC77B7F
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:47:42 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.1])
 by mx.groups.io with SMTP id smtpd.web11.381.1750690061331242570
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:47:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=o53hiooX;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.1, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frBPm5ScihInvEf8OyuHQF0OmgiBps+k38bunbxSm8kre3h1CLA8UvrOWE7eJYFujRqn60aiLayTZak7s0/kdbmELm365HX2ZhDfoV8WSZaeDxxp41PVkrqlaQaHryHrQ4GCyDF/V4JxmMx4IJ0FqhncQ9VhAEXghjp/R3mPoh+jMTkqNE5M9TIU4NzaAYiYYJJN3LxHJQk9YA1fBgZD8qgijDz8XuZCRnVnqekflOwUFebOyJrhh4+qAUb9zu0aB1OD09oCCNB5MZJbwm040HfZhASONg2GMDZIlSn64E2vaA+PfHZMUIiXddCiWEjsOw5eNmVAtiVXjA7V0WCGRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdBoUWPmD+ZLo3Z5nNkLOWvrDsjyO7Im0FvEDLEfvsc=;
 b=vLqw2rH4NapGzxxQ6LTlU60QZKN0TL4XxJKaEvH/1F/QuzX3SHEPHtXHmhPjJmFZK9bauRSpfFoC7OEDQMGYb+vX5Y2Y1CCnliNK+zpejdfBMPSTrsguRGPyndk5lcFJekuFVJK+HkXs40LddJvqu/oaq5k0MXENKa0kmtXCLEqWsK60oz6mQiso4brRNFPnFA1giJA3VY88VXErcQ+vF2BBkEGbWYfMvvIRXIiYaUiFZCB8digi7PQn9oQi58bjKk9EMymL7z6EPWOcAdqMLn6sA/9WHR0GmwYOlcqvq5QunlDr4pX3I/f36V1ZL1lkL1kZhI4Mm45XbE71cde31g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdBoUWPmD+ZLo3Z5nNkLOWvrDsjyO7Im0FvEDLEfvsc=;
 b=o53hiooX/Wcq3I2BSX9bpVBtBe6o6/ucsQll3xcsHmrlnR73g5wr7Cq1Ait6tXsNx1rmer4Iuq+3y2u/asAnPEsW27GY6JbnWj4MAvQGKE2bt+zvE2CMbYT5i3ugJusx47+9S8JKrtZ8ooRpaDgDGAVR3PvoVTM5KzUOugTSIVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB16379.jpnprd01.prod.outlook.com (2603:1096:604:342::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 23 Jun
 2025 14:47:39 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:47:39 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 12/17] mmc: renesas_sdhi: Use of_get_available_child_by_name()
Date: Mon, 23 Jun 2025 16:46:34 +0200
Message-ID: <20250623144639.2119707-13-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB16379:EE_
X-MS-Office365-Filtering-Correlation-Id: efa9df40-7535-4292-6e89-08ddb264e6bb
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?MlVQcZQXv9HBi/CzZFVOoMYoIUnYNQaWxgK/ZNDEjjRFf3QuDfXUi/tW5Ihw?=
 =?us-ascii?Q?yRopY0feZsz7Abc8JgKbggS8sDSJQlguLOI9lL/PWoR2SoB2RwQJDzkZr5w8?=
 =?us-ascii?Q?n4tlUtwXdJWh66IlfQdG8/2tVdvgqbp2zl4u2NGTP0hHHSEEF+Atf3UfRcYD?=
 =?us-ascii?Q?ASXxd2F0o0TPnutr4E1aIpi/vHtUzCmvqyzBRAmZMIujrhN+2cQrEq4PxWrP?=
 =?us-ascii?Q?YiF0EdN8kM9/+j2CybtMXFLtWJloD1TLv08/ANB94SWFleP7OKR3/e1TAtol?=
 =?us-ascii?Q?NHEmbUBoZh3tfwgA/koyaNLyIzu1OcEcQKR+82UdZ6z5oWyGS07nwdU6OrHG?=
 =?us-ascii?Q?+3bsSrVrSYroyHUSpYk+nh5aPBSI8i8VezLAJX1dCY809onCpOI0QGPa1M75?=
 =?us-ascii?Q?uy5DgYwYId00Q0HVtGrkgTZ4RHZv1ZSnsvcD3ao+JRRabXk+e7OfmvptCqtf?=
 =?us-ascii?Q?IiKGuxurYUK4Fc95B3tOj+XoMi4N29ZgGwDcFkAlXNhb/KwwfhttqCof60mI?=
 =?us-ascii?Q?f/CQ+uajeglBIQl5ID/upI1MJ3uEKrKMbcE2C3ndNfBsfEGVv1BjiLJ60FCV?=
 =?us-ascii?Q?lZB/7KkBGc4fqsdl6/R0iQHbd9j1xnlX2zotT0fES/yU3OMLBGU0VsYshytL?=
 =?us-ascii?Q?jtCgHgYtNz5wna7jYa1qtzdVa/Aru/IFAc6TQwtIf9hZJf+70X+H+REGC5S2?=
 =?us-ascii?Q?JMhqC55zzlYCkiBnc+JAGX9KndDaqNf17yuju4LuQkQZDthZVm2K13cBJkrg?=
 =?us-ascii?Q?QQWAk4GuTNbDMQ0B9pB+/xOlObVtYOmzLmZLlgfwT3ra0Z9lnvfwxGz08XCe?=
 =?us-ascii?Q?6+gRlE3HxBJZZq60y0G4rs8y28RLcTRUdyGzS4RgrUiGuzcIT+bjqugDgfDT?=
 =?us-ascii?Q?RLJVNuAWnoJ50kp9TwI5yrv4VSfAkQUnK1lddcsgtO2n4+OUk7UmNCDAte2w?=
 =?us-ascii?Q?aSXqSPLmcDkKjueyfgQZGN8FUn8zJs2b82kgWjZlRQdpF1tmmGn8KCrbTDxI?=
 =?us-ascii?Q?BmuwufEMWLT0q6Y5kLSmUgJkg1rHvY+sgggfVpBQrhMthkESl4sXpeCFgsBk?=
 =?us-ascii?Q?LtC3WGwkEUKjRkYS2RNOXtvmFOk00i6HDP2IGla+3CkEAIHMwpsGhsBaoFme?=
 =?us-ascii?Q?K6xCKUxDXCaGpuc8qeeLPlVaKIN4W9CLZW6QPGXsOSvthVYD+rTVAZgVckXx?=
 =?us-ascii?Q?9/4Ie3WcshmueNWMwMc4SZE+FG5XEjQTiipqoWcNfukWytqkBsgXanPqTkNv?=
 =?us-ascii?Q?G3/gnzrYRBrOhDwU2cTsz3LHXlVJCbaNSM55IZD3CUzzJzeC69disR+i4CpJ?=
 =?us-ascii?Q?Dda2jQLSpv1NfeBotg2FsPzzitukmTbzSu2/30NouAjKf7szzY+P231QN2vu?=
 =?us-ascii?Q?SaO45ZE8UbZn6gA98ovTK9D5TKhwsaomjYUyWh3as/b+SDDQHy8TuEu7kw8P?=
 =?us-ascii?Q?zJ2clA0R3J1rf2KaIM7EvZA8YQxJyf8iAEK7j2eZgE0tC+B3nZIXRf7p+geF?=
 =?us-ascii?Q?aYz32YYoAm2Wn6M=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yyBYBzguFe80RmMeKXL2NV0tHJZkOPoAocQxD7XfZguguVonhrqsft7Mwig5?=
 =?us-ascii?Q?I33jith6l9DJJijTiVK12jMKVY5f/ixcFqppPeGYIHV/KSjcOzOgNG5rGUe1?=
 =?us-ascii?Q?Hw9RKkBEUnDcDl+zjpnrFVsyuzaqG5lXiZxmdsxZyJQnARnuW9q7LKulS8qQ?=
 =?us-ascii?Q?qmi+bnLCL9M7SSq7rUaFjbcno4skjsaab51mWbk1nvKrosgyI88sAmiNYopc?=
 =?us-ascii?Q?q6BKzs/KpEYdGKW3pnvH6xPf4Q3ZXslhxVfAV3h3lx4emOl17WyMn9tvPpG3?=
 =?us-ascii?Q?GlJN70kwf/QAwg6elJJQnJTtX9xJff+4W7KvB3d/Z7I0CdiMC4MWs77qTCZ+?=
 =?us-ascii?Q?7ewovIEwxXlj16eiUkmIXEZqA5NBAFsfz9x9YaNl9iBEnyCchHrZlznBApYz?=
 =?us-ascii?Q?CCJttXohj/d5yw2TXfHVlHU11gxysKfWpup9Y5DGCE/77eQ/Yk/10DAkhbxb?=
 =?us-ascii?Q?rVIYmnawHr3sAvbd+xsCiQMx74oPERQv1ioBQotCpHh2h8iVTnoMZ3nQNNRu?=
 =?us-ascii?Q?PDUdlTQJHS83jL0K8bP3jOozW+dX7KVe5r1d+q0eZMAwDQ9MI8GhyVqJ8q/m?=
 =?us-ascii?Q?Wek2WwPPpQz/Cw6WiQ7cj0M+RwsvVC/Ns0aaoUj1aeyXZAOsqXvNMSjYBMht?=
 =?us-ascii?Q?QqfPBXaA3Lh73A+mKa2vNwjEClzPwZlLkPCGgr2UPpL00RcdBmQ0BtSe9Ifx?=
 =?us-ascii?Q?a3hiV0++2MR/Yr7cfdm6AvMr95VozTi79WAaap8IYobVIMrGQ4ii/S9AQVxz?=
 =?us-ascii?Q?qbcDwg7oj7mtjtzgSn4FKVr0NOI9qtK5zwYPGCDllSrdWXkS/AQLqSRELEoU?=
 =?us-ascii?Q?pO3GUNaxASTszZnTnQx28mbrJISLAyX9o1pUDdI2b+Irxb1+gt0REanrWcvL?=
 =?us-ascii?Q?98hxD82IeX0+WCGb+5972Rujajx5gJEHCddSJWrLAsslkr30p/kE3aZLYEZr?=
 =?us-ascii?Q?TjWZXrDX8gH/O/X5/nUiWf82aDSRMGbRhynkDZ5Jk9Hhoz8HZGMzDRjjWmYR?=
 =?us-ascii?Q?Jw4m6ILXojNRlTdd1Vatcg60QS1GTkv/gF2XASHEA8xWDmkAcusupi2cWJPm?=
 =?us-ascii?Q?QagDHxdl7anbJeHDj0XeC5v0f/LibFRlRX15cZncBEP2SVzjVcRDpgycVMJK?=
 =?us-ascii?Q?zHJoxm0kmIBF280y3ATM4N6r7W7xk7ajy1K+aovhEW/xtUVCKeZ4J8SW/Bmf?=
 =?us-ascii?Q?KmYs8ZvWJzrAfg9xX7G24t950viNT91oDnFKERXpEugU4I5vX6Yxq50nY+Dn?=
 =?us-ascii?Q?PGHPRqxGt5R1LSGKSu8KgNO8OSH1Qqs0jH1lyjMUF1P1f27rlDc2MGEayn5A?=
 =?us-ascii?Q?w8OarMmZkU5cS4lmT5eW2g+aLQNasbnC8gHSJAzxnHjBImdSmcECbMSniwcJ?=
 =?us-ascii?Q?vl7q8v+1/ba2mzSG2n3y4YGvjSAAenazqL8ofJ29dmhOdvFIlEFiP07VZ+8i?=
 =?us-ascii?Q?jod5GzD5MCl/O3+PMLPnMSrq48/YfNR4oW2ZFOEI8rYt155zSM7N+CGtevvL?=
 =?us-ascii?Q?fE9/kdKiwlCxdup29H8sy5VtaDP/ODHMQ2W1EjPYXzxk9QimE2WezSLYAol5?=
 =?us-ascii?Q?2nb+WsdL7bOUpnD9Siqr7nMhtGlg/G9mwHe6Nm9VcLCNbl6sWIjoyZMC7qm9?=
 =?us-ascii?Q?/jaeYtBTPI70cm+T0bd8ImA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa9df40-7535-4292-6e89-08ddb264e6bb
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:47:39.4884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GU2A9VAjHC0MFoBVAc1ZnkUPzP1zUPgbU4iPXpvPnWrxMPb5zoFH2eQyn36ZU2cjTOPKSpnFsoJ0INQ3Tu4VGL073CVX2b2Rl4u2GQA+Y9LQXBD0XppLd5dNr7kqbtNu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16379
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:47:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19199

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 18da3ecdbaf6f140eb45818fd848b85d2c414db6 upstream.

Use the helper of_get_available_child_by_name() to simplify
renesas_sdhi_probe().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20250407092144.35268-1-biju.das.jz@bp.renes=
as.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesa=
s_sdhi_core.c
index cb089997e4bb..725bd37b8c21 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1164,12 +1164,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (ret)
 		goto efree;
=20
-	rcfg.of_node =3D of_get_child_by_name(dev->of_node, "vqmmc-regulator");
-	if (!of_device_is_available(rcfg.of_node)) {
-		of_node_put(rcfg.of_node);
-		rcfg.of_node =3D NULL;
-	}
-
+	rcfg.of_node =3D of_get_available_child_by_name(dev->of_node, "vqmmc-regu=
lator");
 	if (rcfg.of_node) {
 		rcfg.driver_data =3D priv->host;
 		rdev =3D devm_regulator_register(dev, &renesas_sdhi_vqmmc_regulator, &rc=
fg);
--=20
2.43.0



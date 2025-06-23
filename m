Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1333BC7115B
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 10:28:19 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.5])
 by mx.groups.io with SMTP id smtpd.web11.16552.1750674494754861355
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 03:28:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=wiT39wtt;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.5, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tawWyVfI0FTjFHF/jB+VJ8GlytQgac6CyBagR3lgU9bo3HloWlWlBUafG3M84AWgFUHMsdCwAXLm4Hr1JQbBhFJeA65YiTTig8EWuIKPHKwt4sHdPce7yqZf33W+XF4T+s0ajliuVWXfTuYHCULgBp0iIlVfUCn+eOWCBylH+OY6fIYp40a5cirtUWyrDVikEvj9Fcw79F/qFrv/TkjF1SoX5uyJZPLMuXTTxdd4Jamqs0pkR+dCoZC1Bit6TXjVTqWWy4mTVj5OZDZ1CWNNn+h4m1yvIriAjieH9pGY+vd42biL+AjFS3FuSSYWBHTGDX+4ICjid91UARkj7DVxUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/qCwMs4jOo94xxIWtIwxnbB6rNpcBKD65Mytcr52NY=;
 b=fNg/AFtLJCZ3WH2WQ7+Iv7XMqWgaEZQD9GXNUojVz3KrV0LjdxdTKou6YGXso4VxHzVS4WmPT+C5PEBY9kP089BUTTjGk15DwZ2chTKvtrnoDByaDfCeBR54/rFaVhyuMo3AYJ/xVZZ6uH2DJe4oyc8o/h7Nhs/mqp+/ytjnV7YceMGkIbylD233PTX7u9dANp91muw8Bes7CuxGCOycNkmifgIE1YYUunfRPzyzgIKzLiPBq7GOz/Ij2bTqbMdld2FLK/VZG7sq/qWSX7dOCXEyB7WTZ6ddNwJsvDiBUf0l/hCeeoEV7b1USU9gaSw87WtpVclM2axW81J/5u8/tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/qCwMs4jOo94xxIWtIwxnbB6rNpcBKD65Mytcr52NY=;
 b=wiT39wttI7LmW7j0oe9C+9KPJWhUxvMi6Rq/irHiA/mdls8x/dNv3go3arynX8fbaRf9QEklfCRZu9dB5IKbnioHIRc4Oqd+5G/cRX9ilbh5s8d6kU2dZtjLsQU3HmGzvdXfpFXUt5Sfn4nwdz+Dw/GoGHfAmVIXPutk5lvfATk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS0PR01MB5747.jpnprd01.prod.outlook.com (2603:1096:604:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 10:28:12 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:28:12 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 7/8] arm64: dts: renesas: rzg3e-smarc-som: Enable watchdog
Date: Mon, 23 Jun 2025 12:27:29 +0200
Message-ID: <20250623102730.1493286-8-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 739b8de9-4275-4dd5-e816-08ddb240a7d2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HehLW0tKhLKXhtbx55tTxuLgRuhJZz9I3bJ6IxLGyMsRZxfUU3pzTE6BRZQj?=
 =?us-ascii?Q?GTOS5u0KBq7T7FZww61YwG7rAId4H+IDJVnBfAu7A6wmrRRVZJ5dKjHOPuVr?=
 =?us-ascii?Q?PJDZvvbb/3tFmDsFkN/9nwe55wXW+GnAZacQFaBjpisEay2THbaguY1H2SOv?=
 =?us-ascii?Q?xsxcErVaCD4tyRi48j9A38qsF7YhGLlDZOO/2pGvB4s85/G3+b0dgmWrkpZq?=
 =?us-ascii?Q?3N50lkEKz7lKhYIEU3k2PhV7G4taclRpq9vxjQlMQs3IwmdUHekOm1/oFLld?=
 =?us-ascii?Q?zo42EwjKL2Xg487lfbNQ8mEG47Ng1btzTWGiaya9+pXqePWefdrpl0jU8EXv?=
 =?us-ascii?Q?H32UkSvCxnVQuus0ZPeQZgXcwPdc3vArMYnN/SRsTkPFmQeqgeXNLkYFw/6L?=
 =?us-ascii?Q?tPTWmlMHOz5XmnTGZPWp9N8ZwkicDDZer9fIJQnnZV1gYo9R3jSb5behan+g?=
 =?us-ascii?Q?W+bMVqfUGqjR4X+/E6EAhMcn74RIS6urmWxyAChPQGp1oBOobPrO/V/t28rx?=
 =?us-ascii?Q?amOZV4kaORMd185WbfXrXjaFI8ds268SPEY3tcxFQChZSpOeA6gvxSaIRR60?=
 =?us-ascii?Q?UZVxYz9yh+fvVAYLP+grciqZ4GCeGciW2LrHn/cbFb7I8eoPDls5ZuHKoQnS?=
 =?us-ascii?Q?Vw3Z07dTqli4BQUfPkwRt8C5BvRMLnHHK5FcFN28bRv34lSrpNG7tSxcy++K?=
 =?us-ascii?Q?/EX7VuwtZgyxw8CnmSB+Tubb/CJGY0l/oCjyUWlwQpWJN2OrlQEXMALWpyAL?=
 =?us-ascii?Q?Est5e4KpeUMJs0/0MDRR/794Xcef7dIpZanDSa22h5dDtcKzlTHP1/cDHsJj?=
 =?us-ascii?Q?kT7cPvfa1x8ELfShSrylCexnw3BYnPAWW4WhRPF0IKUyJD9d0bbEse3IPk2h?=
 =?us-ascii?Q?b/fM2+dpciiS4d73lOijJ7Jb2Xy7JIBSrcBJXrFAkFqHrJCeSwd+7LkHitj2?=
 =?us-ascii?Q?k+wAuNX8tBoPIFwveqZPzASZ2S7OMp0bYK4RViLqjVhsQuxjosysNpjkm+H0?=
 =?us-ascii?Q?45Hyxwc8ZC3ME+x0hVhvJsRxKn6bAHfRXmSlzlVzu2h9mcuW7Z+lVaYe5pEG?=
 =?us-ascii?Q?geHRzV1TpStwMlQEQ0UbHqJf+A8+9spwbm6lu7WOiSG1KFUS5+f1MqF136EF?=
 =?us-ascii?Q?3d0gr5DkeYvPA4/FuFYWpW7NahgEN/keajjW1DlWhKNPXoerA2Vk6BisCOo9?=
 =?us-ascii?Q?oX+1Qx73Qe4UHRVjwKQ83IzjzDHOwhlR/GJGBEswAh50k3eVU5IMzQ+UWopW?=
 =?us-ascii?Q?Z4jR4xjM8kRXz67fivFi431ZvVatIwDBQw7P1WlgSoSpqLmzCkWfq7K4x1uS?=
 =?us-ascii?Q?LD/v17MN1p6nFIZo/BB0XyDd1DWauuwnm3Af4CCqwKDEfNCXLKfW5RJ0XMMg?=
 =?us-ascii?Q?QxIQa1bekurzntJvks6xpi53nB2F1mFpqeZqXAvBuACqqcCgOFfjQRP2E+G8?=
 =?us-ascii?Q?X+jqArru8lCffK97ImvKamX61FZnzybWW4C1wzR88Ka21IBeYfybl8hkSMAX?=
 =?us-ascii?Q?UEQSujyzaNkEPjk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?73grhMLf2umoQnLwHfS2IOvvehStoWYrKItvc2RE9pOOmOFqsDoCE+L4ezwe?=
 =?us-ascii?Q?Etgpzu7qvGPP2IVjFvmP1x0QRBHYWuvC43KDaERQpSC+BZlEPQ8Sb+eFvsFG?=
 =?us-ascii?Q?N9iYbNJY0SEYqHi9ijUTlEbP2ncBJzjR5PeKmbKE+kshU/1Kyl6WZdymCb5p?=
 =?us-ascii?Q?FXPAxRfbODJj/8T+yky6oiAOFO/v+1Bsm3D1IrxZFSjcPzHjtGfmxbajd2NS?=
 =?us-ascii?Q?NoEu2ZniHO5zySKo+R5m7jmne+TQO5mGcNCD7RwDSmhbTo9XkmXVYN/1eQM8?=
 =?us-ascii?Q?x+Gwr062QFOrMUby9CbB9I1Kq3nnSuuxy9ABOb8ZSh51H1u1wkBUc5vfE5W6?=
 =?us-ascii?Q?nvZ7laIZhXc2E489Fbb9lOg6rEY1KYeuTFvxIFE86jesPqWMCoVyLkCATmiB?=
 =?us-ascii?Q?eogb+ZS74scE60PY6vH+Utz8awBf5HvYPi2ToqSM7osV2/meHf+j6d78dHz3?=
 =?us-ascii?Q?yGYhbBnVTkTxM8IiH6Bz67fNDjeP1xzDlqVW73uIZZccDdmWV6j5UYwz/IMj?=
 =?us-ascii?Q?rIOO6G17QVIQeWUm7BbPvaqGXH9ON8wQayKuam0E1wKWFbJYh/Qz/nunRm6F?=
 =?us-ascii?Q?csjTw5dSgRz+QZclsnjLSzmre2+OtcaGo2OR/IUhEyhpC9/6b3MNyOAejFx7?=
 =?us-ascii?Q?FJJtXE5Fo95lW84lal3mRAPQMuSzxQa2Bpr20o4PaDK0ooAhe81ufzS4mhXB?=
 =?us-ascii?Q?ayeUB3vYTUIMYD5VtBKlfSfB6ThJY04Q27pvtomsEP6Rz1K13hy55Tfbduwx?=
 =?us-ascii?Q?tgs/U3VY2I//OwNBYw/BgJB1Cho+Qpv0Dwzh0faA1Uit8x/XWmlcRU9o0H20?=
 =?us-ascii?Q?mrizglBIXWe0yKGO04GWTeoFjqfIrJMeJ+53LIWEnkfxuczO4DtoXS6e4QWb?=
 =?us-ascii?Q?g83313xicphwnMMsOAxYww109+kl6sbyXhg6PyxZ9h3BFnBHp8S8nValYqAv?=
 =?us-ascii?Q?L6iSCc0t3gRRoJPPs8Ixg4HM7FNDvlx4HlRq283MVwDay2elgark/Jg0Esu7?=
 =?us-ascii?Q?v7dhcxlk7Tbd7mz4qUvWo4/cMMOSfRQNfr+KhAD5qE0mDNMLMWw8fXmtrqNl?=
 =?us-ascii?Q?uz6R5HYG/0uQLzt1jTlKX+d604fXnBehY/2G9FBOP/QmZsqwkCFVs3tgznlp?=
 =?us-ascii?Q?UQTculbf2szUOHhVZ8wtwY5q3Mg+EXhxLIJXc4Jg48QP281MFzbgdU+5mAUP?=
 =?us-ascii?Q?Dyegv3w3uIPYYGOuAlkWs0X7SIKz5CACmiv9I7OtmdWrni5AXWMZQDi4kUJG?=
 =?us-ascii?Q?q0G992iAAh2iS/UgWFcQBfg91afV1awpwjsReKX8LQq+SoIzFhgcLde6WFhL?=
 =?us-ascii?Q?771BM0LkFJS7L/n+m0p8NSnbE+4tWNHSuOah3LymUXQy1wdJGgD+X/tkIcHn?=
 =?us-ascii?Q?lQVRtB2wjHVrEYv+Y1YXW3/htAYccBr80PS/tfMCop49YdzBZbfvmcWvfZ3C?=
 =?us-ascii?Q?BOpCVWdhHscdBsibe9xRPG+954GYYr8dsZIYdxuGs8fuM9cI/Ofldrzy0ial?=
 =?us-ascii?Q?iOUl8vLympYxZ4mL21K+MlyyaGMpTcvBIBFOqa9Zp7O2xZQSVSSaqVkLu+uX?=
 =?us-ascii?Q?lvpqZpq1SP3AVJ8Q5iVocxX/MRB4jARQeGob1Gida8z40Eeps7XFT0oyKVDl?=
 =?us-ascii?Q?7DkbPbDJdnvyYEw1Y8/gr1k=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739b8de9-4275-4dd5-e816-08ddb240a7d2
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:28:12.3626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ketlDHMNJh93csx20gqXWKS8z6CHRPIJT80CsJKQKttzHCVvFjITtsnu3mcl0ghDh9sgWoTXn5RhEA4n+WUhCtKir5dA9fBl0f/mGx1Xm+A4ifg6Td2VXigBz6BuXmc5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5747
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 10:28:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19172

From: Biju Das <biju.das.jz@bp.renesas.com>

commit db2bbe1e6c48f03ed1f5ac57f5614d02351dcb4c upstream.

Enable WDT1 watchdog on RZ/G3E SMARC SoM platform.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250115103858.104709-6-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/=
boot/dts/renesas/rzg3e-smarc-som.dtsi
index 6b583ae2ac52..f4ba050beb0d 100644
--- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -26,3 +26,7 @@ &qextal_clk {
 &rtxin_clk {
 	clock-frequency =3D <32768>;
 };
+
+&wdt1 {
+	status =3D "okay";
+};
--=20
2.43.0



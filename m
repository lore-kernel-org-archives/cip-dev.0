Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500B0C369A0
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 07:40:31 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.38])
 by mx.groups.io with SMTP id smtpd.web10.6119.1743752419160886156
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Apr 2025 00:40:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=TFz0dKyE;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.38, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtnxwIgBdjALMS9a2AKb711qrh8HppYHfVXoQP8HpEKxi8Opw0BeNTBEX2OavoK5OT/VboK8Y+2RFjCsL5f7cPWCCUYjTDYPnINb31mdVUFGRy+rfYhgJQzxqdq1qtk/9AEL1pTX0fKQgAMO3MMom044oZM2B01pvSvgIVOryJF7pL6mksz0nporkJrBUO9QWYKlgm8hCaYcA0qAUmTycYf9jKjCH4P9GS4+QLPULJ+Ja+U/OlYOebfCaicvFJgCiU7Tx2fkQSQpIR0zwOIk0UIr/ITxEDjeFDd6260AkIVmjwiy7XODjL2/d4sr3jVjqZ6uUL94/v/6E1N8+bQRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjBgkwSk9QZVy1ev0AzWx3qF3pwuY/3Om24W/gs+AEA=;
 b=bq42P5dvqzGlic3McfKPnZRCIwPm24EHf1Lhd6p3FeQMlx5qtb85NrSMg0baJ4+RGqAR8LdkDfCU44vdM/hWlSxSnUz7iabjQ9WmClbmK3ivkcM0rwj6ib6o7oQTgJ8CmG882S0ZNGu4qrvRPZH4xwGjrhVJMnkDrIeCjxXF1M5guKiOmxTx+X6BKDDurXQ5mspLBySD2SiYHtKHOkwtPTc2QUJU97fuawfYTtYn/AAiF4GPSbTESzEADrFaUwXZ5TXtF+GDlBN6LjxmyBSuhQrECuE5k/yQ+wpGktD7Ft74+rMjnDV2YheiR8bWHrcLwmBLJ/+x5b/83g7SRT0+Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjBgkwSk9QZVy1ev0AzWx3qF3pwuY/3Om24W/gs+AEA=;
 b=TFz0dKyEH70cgq0RYhgi05m7P/jXtbFqcvISU2Mbv9O+PYepmDevej8MOYnIysnm22XXy7+NEAX5iqAGsyVOCDCWNCWluLcN7hTuYTZZMaxM67plxueCizciKCRFe9A2LJ74s1Ibh6H5Zv1ghrb7Nrn1LC4dit7T9jIEp2dJC6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB11793.jpnprd01.prod.outlook.com (2603:1096:604:236::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Fri, 4 Apr
 2025 07:40:13 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.038; Fri, 4 Apr 2025
 07:40:13 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 0/3] Add RZ/G3E RIIC support
Date: Fri,  4 Apr 2025 09:39:51 +0200
Message-ID: <20250404073954.173387-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::20) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS7PR01MB11793:EE_
X-MS-Office365-Filtering-Correlation-Id: 04936383-37d8-4e72-8a35-08dd734bef08
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?OFF1oT6FrmGZGF1Uf5zX12ki6pZXvlZXqoAkgoYEDZvh6IDbHN0jArt5yjPy?=
 =?us-ascii?Q?BaNNJOIU9KeOTWvKQ5H2cZX8vbKhq2Es6g+jYWxsd+6vdhLx3NEIFn/xGJjz?=
 =?us-ascii?Q?Vcx8OyrIb4GqerYBM0+01q4ge3rjsxYt6YCr4Xh9+NDyfBhYUs/j9YFO4fSi?=
 =?us-ascii?Q?jgqyW1efrZ40xE4RT+wv4T09b7rfDbE//ywhZYxXowXdGQoSel+sZDhuKc3u?=
 =?us-ascii?Q?DM4S+hGtzHts0vDOA9zwRfu223DakGUIdTHQwGWYy7aYoNJL/+BnDLKfbm7z?=
 =?us-ascii?Q?SfSvOCTNpbUTu6mta+swvCRCHxUC34d3GA7CBBwHsCO1RXwDf1r55sVD6iTI?=
 =?us-ascii?Q?+5svvOroo0AgHokt6zB0kazu+yV8CWEESh1rDV8/+KTXgrmLhGrwe/wJNIoO?=
 =?us-ascii?Q?qM2pDElerFQb2+iU3JUPYnH27UVahU6mgM9AtzJFWs6z+Ic+60dk+r2Q3uMr?=
 =?us-ascii?Q?lSTC0/UQToUaWoyRaFA90iJ43c7hUABfAjGX0BrJxTtNG+9La6WAo/XsbF9G?=
 =?us-ascii?Q?F1/RsmF+ePQUdgtFxpgKAAwxZEEkLobEzTF8FZXU7TMgQ0qm+9naGe75ddbY?=
 =?us-ascii?Q?ChfKmWsZKzVpFNgxZFtwL7C8Ie96Y3bqRbkHcwRZIC1HHpiVJfpfbPWYP8ST?=
 =?us-ascii?Q?RXC78+0IS+uPQOPUnFsx4mNtzAi2e+PbW+/NE6y31ohki5T0XaTGZSdnWbNB?=
 =?us-ascii?Q?GeHVpU8xEEjOaklJtpQjxMOBG9byFbOiz1rwumepFhT5mxOvnGv9e9UtCMRO?=
 =?us-ascii?Q?ZasXZty6MPtI3ZYnbe4ATdYpckKa3gQSBIqmJdMEDN83/5lv0y0Yfe4Bs9IG?=
 =?us-ascii?Q?nDf7KHM8W3KSe6aVSLBj5iMU3XvetHsUoW+mxrBC+1+LktoC4Q8i4Xo56x2H?=
 =?us-ascii?Q?zsFYn/bvfKbSxPe4gld+YDhVfJvNcXhm+Ow+z/EbgO5LhosLnlOExNcdNlWK?=
 =?us-ascii?Q?BnUARF1DQAk3jS5D+gcqr9ec+Zk6b08attF5+8sdZm7K4+5hwLgZOijFByG8?=
 =?us-ascii?Q?ay8OXWgs8Odwtmo5F+PnUecWljRgvlkQ6HdCVFz2lMswzMQI9mGUUhTYCESR?=
 =?us-ascii?Q?xIZW6gZuG5xLjxsrQ2Hn3J3zMYaepWfGKgJKAigAFWnw369YIQ3neqzb0YoN?=
 =?us-ascii?Q?etC7MVOzEgMoL4D9ViT/DD4QtJ7jLKVfLw8eL4zYgibVbQab+z3NyoqRs7QR?=
 =?us-ascii?Q?5hM87iAEjrn+eWxfF4LdVYpjLtgd5yrBl+FomAo671aIn14Yz/3ucmYuFzTx?=
 =?us-ascii?Q?mZ6w29Tpmpl8RjRhRIo2eMEz5vZmPADMLhv1SWeB8oTeHWgMiDr3J0e12itW?=
 =?us-ascii?Q?6xG5FLLANntyDcFhgzuR8gjYLpUsc6RkIVDgithDaG+ZBBxUtdr2kNPusbN3?=
 =?us-ascii?Q?MC1BGbZBw9faieKuAz2Ai5tvGo4f8brqx89x+gATBfAr1OIZkf2MQObQ6R9K?=
 =?us-ascii?Q?HzXrGd5/CefaEOcl/0KUqELA+DTGwo1H?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5SYmLZBFupQCyyptm8UI3aEWrGZvwAcAVmtcNqzcxrtchqTZmpcnRbDeMNd7?=
 =?us-ascii?Q?EFZDx6ImqeNvAMBVQD5/lN7D08UhuRlYoIBIRe+gbdG99JwvLjFNjTcTWDyH?=
 =?us-ascii?Q?wmRvdXaeDShDC0t+1/YiGJ2BUuHWgiLdIVmKPrvZuU1KLNlSTloYVP4ia/Rk?=
 =?us-ascii?Q?bJbmA7BDEdCvPlY5TWmQDZ1RC/uh4cZL5s7+Nk8xPDZ9IC7U3l6ro4BfMPc7?=
 =?us-ascii?Q?jP34nE/l6drKA5XhB5MDFNT5eF75g9BhO9KIhlksPnfX0tU2+7koPXSHys8i?=
 =?us-ascii?Q?Gel4DJFNrXf8IDRcWy4kSK8Q556Zm0Ts0nB75XpGVujXPZlxXH/lkmm2ayKi?=
 =?us-ascii?Q?GL8udxlsnfGgblUkGU6qFs2xZ+uv5U8Om0U0YySHE0QfFiCgU/urFlo3RJUm?=
 =?us-ascii?Q?stp76B6KZkKz6AA8KwdKVyORzRw5kfyHCaL8hLt2mwrRe5NB5sgwBQtnj1/M?=
 =?us-ascii?Q?tUNgzYwTrlAVSpvY2WMpNDg62aFKHgt/Jjsa7FOJjjwjWljOvpd0G4ks9Z8L?=
 =?us-ascii?Q?OgW+x82qd1Q9cp3cK4JaeUvUa/AP468K4KjJMTD2OwQ27JE+ywUIt8XrQ/Rt?=
 =?us-ascii?Q?/r/JE+E//okHwIYWAzghxCQV67z2cBis52+4dryBljr6HsdIf27Cab3cyNAJ?=
 =?us-ascii?Q?TC2vurOqFxYfnKuFcU972zlkHJ94gGelcSu7Y/upSia04R0qCC2KOtOVv8F6?=
 =?us-ascii?Q?8yvDGjkMegfAfTDrjbfkHeBe8bctcvufCqShyZG4QbS1wOjofQFVXBZpRZRK?=
 =?us-ascii?Q?XstH6+kY0Eexu72ig17RnYihcqd//edpn7q+kZ722X4ReucqfNyjH4wwUFYy?=
 =?us-ascii?Q?3iq3D4AgD9q1bnpjk0TGO84h+LVqgfVm43LHOUAMtA51hfEaKEtYuHgMXdSf?=
 =?us-ascii?Q?voPjUqnu957XMyBw4TrV6U+ObmnzpmycZDWSpN/FPQ2r8J8ZA+c9d22giz7E?=
 =?us-ascii?Q?1rUOiufno3CYj2FmK2UTXFap1KHpvkKyZTa4BA4lmz2EiKwnNNFHwf42Jb2/?=
 =?us-ascii?Q?BSPdXahOniQWpUTSvUt69gvyk4k3UvYKxuJVHWzgr1gUOemMi+Hy6rMejmRd?=
 =?us-ascii?Q?341gjdR0giJzipxaBZGvny3bZ5AfYk3ZX1iIjah9/OqKwIUzdd4D9POn7W70?=
 =?us-ascii?Q?l1pZ42fQobFy421KYgO91dYiNFumx4uu0tT/yklNBZOxK8DSLri9llB7vCFL?=
 =?us-ascii?Q?Cgx7D88Ve1BYyDwpUS8haMTAWtyyl1cy7qMuAPn//J7TFK8Ji/oxL8BziqVO?=
 =?us-ascii?Q?WZdp2+zldJuEg80eI3XZyB8ZFL2scntSwANgPmFpaxsh9xH4syKZ+DulZnTw?=
 =?us-ascii?Q?Q5FLELe3repL1bmIvV/o05IibaN1+H/8KvE7Otuz6ULpGcyBAYX3UJuYUA92?=
 =?us-ascii?Q?qYOFUhwPUuAbUeQ/pSTdxbslitmoIPyBSwFwwLmIdxz8MTPkVsb4FyyX13DC?=
 =?us-ascii?Q?vZLXLxzRrwxh8zkbMl/kjdwPK7Dr3Df7TJ5mfSw9nXzSkzOgbsPwSAk1VFGw?=
 =?us-ascii?Q?CYwbjLxUJftdWItzkuHHeOOvQh8ifdIT4RfDd0kAVp4BLdtmbGIVQuZJs3Ae?=
 =?us-ascii?Q?MujJmAnjzdmtwkY9k1P/TASW3EyT7XkVw/H1tBruIcy5ueVcIvj+dSkqO/cm?=
 =?us-ascii?Q?k7DsrzEhzhW5+/QIVuwi05A=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04936383-37d8-4e72-8a35-08dd734bef08
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 07:40:13.0640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YQ/FtMVqPUM0bflK1n2f4KfDgXTiFTq2NyOTxXzrYKeYCdobx9QuvYCelluTwxeOSork4FBQQBYeG7Fg0cjIZRnDYs/s/j6LpAtZlmzRRHCVLOSaeesQhrJEZuIV9Ut
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11793
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Apr 2025 07:40:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18474

Dear All,

This patch series adds support for the I2C Bus Interface (RIIC) found in th=
e
Renesas RZ/G3E (R9A09G047) SoC to linux-6.12.y-cip kernel.

All patches are cherry-picked from mainline kernel.

base commit: 18d2300f61bca arm64: dts: renesas: r9a09g047e57-smarc: Add SCI=
F pincontrol

Thanks & Regards,
Tommaso

Biju Das (3):
  clk: renesas: r9a09g047: Add I2C clocks/resets
  dt-bindings: i2c: renesas,riic: Document the R9A09G047 support
  arm64: dts: renesas: r9a09g047: Add I2C nodes

 .../devicetree/bindings/i2c/renesas,riic.yaml |   5 +-
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    | 189 ++++++++++++++++++
 drivers/clk/renesas/r9a09g047-cpg.c           |  32 +++
 3 files changed, 225 insertions(+), 1 deletion(-)

--=20
2.43.0



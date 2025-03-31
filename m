Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE85DC3600B
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 11:07:31 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.57])
 by mx.groups.io with SMTP id smtpd.web11.49164.1743419245820480194
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 04:07:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=hWt1c8Za;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.57, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Leo7ymCe1ZJmA8rFXtREpfHA1yQkz16lrs95NWX6a7CtWOHgZCW2P3pRZ99aW7vToNOE2d0tfCqjhiH0o1f48biUpN87oyrPWECjqGHYmrgpSIb2HyhN+z/189d8QM1xC57bI3HrZc8omPsmrnGIJYalGeytkrVwEvQ5iqtX7a0CKMAYVdLrQMtW3BYICUTsp3dR1l7AoH9UQMNfGmG+C35d96MzOD6+ycaz0CH2xqqm/k2Mx6A4jgrACRFX6lBD7X9XLSVDgv6AhRB81c0pBsgTctZGB8MkM6r2uh4lQmjuY5oEMGwaY19Wr/h+mdeLXiQN3OY/PmbRgKPt2Tj/tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCcKPx8LjMr5ivzJiBbq+CbtwzYu/9wE7ru3v5d6WjA=;
 b=Hnz68b6lwDlruaz1Rk19oIWhYadzoF8zAIqQ0x6RO8OAlZ8wsW5IKuHjLBANdQf8iXH92hIFzA1HZAhi+OTlmb1JtxWvg0rMidbKkzUE1YVOHJ1482AmxpZUWy3hdn9dtT0I16SAiQzSJ/UG5D0nPSX9i7VlVUFb8fgxpXHR9iK5p/+H7YQZe7SpTyc2gq1gB0G68tN9PSieNmC+L26mwQQtMoNh4wA855aJGXOr3o6VCf3a0Gzp6cF4keV+ts+63zxQbuPsSH/ji/lFMvxSuY+z+V8DPQs7c+iyUqk5rK+jXEmBROIToYDb+1+gnzwSOyYdJ/TnxLgbStrhBZ799Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCcKPx8LjMr5ivzJiBbq+CbtwzYu/9wE7ru3v5d6WjA=;
 b=hWt1c8Zae+VphK31Dl8hremJh6/JEKu1zWqddQOhq5yS3unses7jh/ge/KW6couHbKG+B5nXbI8sQqh/PvPoXeGu7hJPDoNxYdq/fAAZcSMcMHC7u+R/bu8wOOcFXWmvYbn/lMrxAul+w7j6fA2oY1FzEV8jGJ3z1RSsTPU9Rjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB15065.jpnprd01.prod.outlook.com (2603:1096:604:370::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 11:07:20 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 11:07:20 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 00/13] Add RZ/G3E pinctrl support
Date: Mon, 31 Mar 2025 13:06:46 +0200
Message-ID: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::20) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS7PR01MB15065:EE_
X-MS-Office365-Filtering-Correlation-Id: dbbb09b7-ae2a-44b1-8848-08dd704434ac
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?aoiEaMQMrcx+vXWQ5ii+iCk0c6U21uhvSXA8j9VHkCYU4OYBb3pqrOPYQKVF?=
 =?us-ascii?Q?OZlMYY07SDw7jae85/y0HnXukkeT7Ve1+1FHMW0Rpuv8DT9DHA+DzamMAdXn?=
 =?us-ascii?Q?NR+sNhWAFJHyEHU1L+PFEvGoa/k8kLt6+prqbYrGXoy4+3wxnPnK2OzgAkfz?=
 =?us-ascii?Q?s9vJX2bxXuGfEG4r1YaeLuPVgDqtiM+fvm6Ub6lgBs8odCNFxm4wdRxAK0fx?=
 =?us-ascii?Q?3WJy0nFTW1sJ43xKjW6RpQcg/oaC1wRDvxEPSdPWByXSQgo2+G1Vw4qgl9hW?=
 =?us-ascii?Q?4WrrsPIagvMopql0L+vmtT39oeyoNNu08cgEIKaNr/ZaFfWI5yyWnZCowbOS?=
 =?us-ascii?Q?yPmS5w1LQWOOOIjFx15mPpbFPUtHUT+4IwSQVmlB+l7nMfQQLzuEGVwmuXwJ?=
 =?us-ascii?Q?rQcryrkDg8AqsQa3ojgN7NBplnzwt+cpxpphG3y3TGsIcHjAF0TvrjEgutNn?=
 =?us-ascii?Q?gLqEj3hwHKuAlCfnX+ohxc2jOQ2wnCaAzcQpoQDUE6iPB7Uwn6fXBQoeAMLK?=
 =?us-ascii?Q?XdMS2NZo803WgLmekvvqZihDmBQzvoZ85F6+2vhEQReannyQAjD9KcMHQ7jQ?=
 =?us-ascii?Q?f+KHN9v/egH8VNvKLMOyMKpIqwpY05CEJTpF4VGEF6/w6jXRdwkiZLAVnH3z?=
 =?us-ascii?Q?XIQg3SOfaorGO8qWYkPSkhw6HmTEnbQmaKYVVWLPsbmpIVgk2HRHk99X2SsK?=
 =?us-ascii?Q?pD4LYLN8D9PboVqvGHZGrvedDmLOtmDTsAkI/wBSnOauElbwJBIcLEHcY5sx?=
 =?us-ascii?Q?RE0SptdOGV5CySc5L+zaarc3Jpg5udWfX///vJPM5bGirK5tWWosCpngRsS2?=
 =?us-ascii?Q?PB5hfAlVoSklGtllaB8U2fA4JCk0PoBvbpTaYh/VRYVcupzXU2upATSSdkl8?=
 =?us-ascii?Q?Heht3L0i3rUhNKdS8KRquAobU5fhtTz4S9gQacJtTkrE1TeUpHXe2E/3hSe3?=
 =?us-ascii?Q?0BWC30EZetxqHc2IYEoNEke1SfD6UCbmeDnlHhN2bKitSgrNo/GGyIMEj/0R?=
 =?us-ascii?Q?+/a59gbDvQptUOcTEnaUAnztN+hB3z+xvGsepwcJIcDBLm9s5bYGLF59gipj?=
 =?us-ascii?Q?Bt1+kSf5mBAIPaH0LBGzh3jOHzy/lTgDb34xzqwxQ29cT+58Qctr/P9z3ugX?=
 =?us-ascii?Q?lkyVRg3Vw/9de7Iub1zSMHOlYw9HHD1MBKm+Zl43K9fUrQ816g8nN5XFoFZh?=
 =?us-ascii?Q?pY9G1gBn1zcei9rSBJ0KsBCz+bl/61eXHZUlJOS4dp1iIp4+xWcZH/cGeO3o?=
 =?us-ascii?Q?IdP3CK808nMVRyCtK325ZO9FhBnTjw0BgPzPXkdPjBe6/0VXIxVXimPdDDrW?=
 =?us-ascii?Q?AEDwvRDblNaVJ6yuIufmqTENeurAuH4q75ZgL1ZI/OC1NLPQqD14SZgZJxWZ?=
 =?us-ascii?Q?XRvHkAbW724Eh+igyZZFYH0VBF3VpsXoHw0qqe2KmwQpZHij/wmzeEyTZ/eB?=
 =?us-ascii?Q?HYLy0UaWwQY1fyQxcIaOTnsNDfXfdlE/?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?v1CME/k33dNJ6Sxb8BKBlvbp8Kmzm0NoSt89P8FuPBhfme9ClTJ9lugISt/S?=
 =?us-ascii?Q?1XPQnO7Z5Ja4IXwxAyWnH7RlAJ/ZMsxzE6g8zWPG5yQg9LwAariQJKWOtqqD?=
 =?us-ascii?Q?ZMcl3YQKMPHs3eCrLhDZOu8p6s5/o9afLeeCy5iaQWHLqnlPzuEOALGWip4A?=
 =?us-ascii?Q?KZzfcQbo5CUSfIch+TjrEPUngifivXviIPgYTOX6RqZR3UR9riosKQnc2F8O?=
 =?us-ascii?Q?kTkMHsCH9ostJ/lmj/fKnOBI9y1NozzcRyrKknqTblSbY9ZLG4iVnJRmdgS/?=
 =?us-ascii?Q?j/ekJ/yszk8YHXdYfY6XVHqc0ALu7OVaMMTAtjD5jgnemP61vxWNNlQb+qxH?=
 =?us-ascii?Q?6S6pKoUveV/KBoL87GlylTj25S77+TJ5kmSsGNVhABhbVManYFGMDtqK8i3o?=
 =?us-ascii?Q?RZ0L0HmF408JsIwQDV9A+aZrb9OTWVIsJqsG3zv2FY5xK04bQXdu/c89QlUI?=
 =?us-ascii?Q?P2xC9Yssqy2KUxWzV7ASb8+KSVqbh2RZPwCJWUDtOfkBkcNpUvSBnimrCsYT?=
 =?us-ascii?Q?574hY8+dZU7dFCp90jyhTiZPY2J5YyNi0lT6PLtGMZ6zXnejStu1m1+R62Tw?=
 =?us-ascii?Q?MqiRYcwHGceh53mxs9u2ODT+OQ8p8cALsJXB3JceAvDqkqsJjfsyx1QEO/N7?=
 =?us-ascii?Q?nI97S4niRexcpu3ly7Wjq+vls0pbf1e9RcEeDyo4ePVQ9gFM6ObtDftlInqz?=
 =?us-ascii?Q?HBm56ARevxHZgBvYlmhq6NbNeEq5lk6gUsLJuonO/ozGdJONq5pO/bcUKh1U?=
 =?us-ascii?Q?Sa/jQc9DjpftkNh0N/i1MVjlFUF51gdSiodSQQnQVB/e92xgyAOYyhOa9wnF?=
 =?us-ascii?Q?42I4oB3V32qJ1HSJPd8ZHFod/dpdfG4L6XYL2Y1EEs+aumtemi2rY7SQhr3e?=
 =?us-ascii?Q?d7yIQC4QSd5PrshvH+t42ot3DGFevTFU2Ww7Vl5CLvIgbywiDrkT0F3ueDjd?=
 =?us-ascii?Q?gUcsmPll2gfBO3EJnQlkwzascqwropwtBco17mNJuOcZYTwJd23uDeEFC1rF?=
 =?us-ascii?Q?KRxOC8o1xrqEkH7RvyXLUZ0ReHxS5+kCpcTgVTaMPOfPIj7mBfS0eyWVClAh?=
 =?us-ascii?Q?Z2XRP6yt7L+9+4H34hlMo0Ms5EqKFziiio+1+ax2CcTZpyRb5h9CS1EcLuqY?=
 =?us-ascii?Q?twCBu61I5RUp/tbrxRb42rHTbRsrMS4r/7D6xK/dDgc/FAEQgwmbBqlVSTYK?=
 =?us-ascii?Q?ygSrCCrhg0KrBSpkpz7GuDo1iKOLdvPkNPIFdSZKDm1AB4qUhR6RSHhyqeSF?=
 =?us-ascii?Q?c7E3q+OYi1jzUveE53gql08DGrMXbkl723mbUkx8CYm1YsHtkh4G5YWw0EBT?=
 =?us-ascii?Q?SQFM65/IVmcrKRHOQxQt4phpPzjJqHcShx1Ce59Gp3KTTn6gFwy0FrtSlAzK?=
 =?us-ascii?Q?3IWoD7ylH+e9yaw7ARLqw+xP+63d+1hkPJrQpHgwI6qv9zCFKcMVnN9fmZHB?=
 =?us-ascii?Q?EunuaseMRTciE9JljGSP1mCJ/ktXcltfUJAIBfrNkGoZ2PGZThHkr+KNdFn0?=
 =?us-ascii?Q?TmDuIGikr9RfTH31WmuLnayI9UBhwQVsoOLWQ/9fHEDG3+DrOeRVVUFwN8Ih?=
 =?us-ascii?Q?IRCJ7qg4KZYgK6CqvFlmWJrxAAaXfCo5R4vIfcKAsNY73qrcsQEjxkYHtJV+?=
 =?us-ascii?Q?mSeaxFhid5qLMn6BbTnfZ08=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbb09b7-ae2a-44b1-8848-08dd704434ac
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 11:07:20.3708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUzy1AS3Rwv/XjvbnxPCarhd+D5+Q0Q1Syq75OtxAdy9OltgsPhfhZJqyVSrkA0QkeVnnE+/2RHcasVVQT+XBQW4Bx5tMwSZT8Lgowalnu+yUEsdNRIcRDuQVGfxq4lG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15065
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 11:07:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18432

This patch series adds pin controller support for the Renesas RZ/G3E(R9A09G=
047)
SoC to linux-6.12.y-cip kernel, this series adds also device node for SCIF
pincontrol into RZ/G3E SMARC EVK board dts.
The RZ/G3E PFC (Pin Function Controller) is almost similar to the one found
into the RZ/V2H which is in turn similar to the one found into the RZ/G2L S=
oC,
for this reason pinctrl-rzg2l.c has been re-used.

All patches are cherry-picked from mainline kernel.

base commit: 5a8fa9a11dd1b arm64: defconfig: Enable R9A09G047 SoC

Thanks & Regards,
Tommaso

Biju Das (6):
  dt-bindings: pinctrl: renesas: Add alpha-numerical port support for
    RZ/V2H
  dt-bindings: pinctrl: renesas: Document RZ/G3E SoC
  pinctrl: renesas: rzg2l: Update r9a09g057_variable_pin_cfg table
  pinctrl: renesas: rzg2l: Add support for RZ/G3E SoC
  arm64: dts: renesas: r9a09g047: Add pincontrol node
  arm64: dts: renesas: r9a09g047e57-smarc: Add SCIF pincontrol

Fabrizio Castro (1):
  pinctrl: renesas: rzg2l: Remove RZG2L_TINT_IRQ_START_INDEX

Lad Prabhakar (6):
  dt-bindings: pinctrl: renesas: Document RZ/V2H(P) SoC
  dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Allow schmitt and open
    drain properties
  pinctrl: renesas: rzg2l: Move RZG2L_SINGLE_PIN definition to top of
    the file
  pinctrl: renesas: rzg2l: Add support for enabling/disabling open-drain
    outputs
  pinctrl: renesas: rzg2l: Add support for configuring schmitt-trigger
  pinctrl: renesas: rzg2l: Use gpiochip_populate_parent_fwspec_twocell
    helper

 .../pinctrl/renesas,rzg2l-pinctrl.yaml        |  23 +-
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  13 +
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  13 +
 drivers/pinctrl/renesas/Kconfig               |   1 +
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 254 ++++++++++++++++--
 .../pinctrl/renesas,r9a09g047-pinctrl.h       |  41 +++
 .../pinctrl/renesas,r9a09g057-pinctrl.h       |  31 +++
 7 files changed, 351 insertions(+), 25 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/renesas,r9a09g047-pinctrl.h
 create mode 100644 include/dt-bindings/pinctrl/renesas,r9a09g057-pinctrl.h

--=20
2.43.0



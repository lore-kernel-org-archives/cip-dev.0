Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8F4C44516
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:13:19 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.18])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13233.1784293996904857854
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:13:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=XX2FkYQ6;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.18, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8N4a90zjMd5/gSI/8oY5IzLYiJEhL4u3cZz+nqSXYNKhUeDO0gJYuNm5/kIXgU+E6sAMI+6eRr0frlV/qy6qnLzF/nwz8XXPH4C+vfvGub0spxir5JXCesoROYZTlcCuxgH+KF/dlGzP6okU80hE8s5Ivdkcj0FfITmcZfMU7BS/mxNCRREK2aeh3/BqlbdoIm7MumPZQAWNAiYcyZxUPJCP1tpZbcflnSCWo9WyGzOfwQSYzu2NaqLZ7VE3hNchrW7q0DgHPhJM7zEdS6S0cTr050hk/VckBN0OPt2lU7SRO+8KTQarLZZ7xutIUVqIk79kuv8Ucna5Fs+z2s0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mq+HKoi1Srwj3s0SAP46v/sX2W5nPrw/RgP6HrGn2p4=;
 b=gW/NI+qysSWMFa4tJXHfynLoAp746tL+oEG9o2887w7BLG0BvqiNt95n2FagnVkVjJoKqXmTERLEzBiBDYcX4fnyUpyPMzzEFDOqdHAbTs8LknfqrkQNwQ1cN+AkzAwydY2FKlRU+ljDBH1pFqkpRneeaPOFnPzPVqPihroc84ijbs4ZKlix7BDRu/eJO+OeJj10J2yJuXgE4yNWrsYtbYdEQUDGIMog3h15yyOYaFOXhQgCNBlqgKX2mD29krDk7jyUlws+0n3tL7TCLpU9746WtpXnNLmydjj2FoCog3VnJl4v7rVuQSZUWI1O2Ne0Cxnh0ery2rJS5tRewNx+gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mq+HKoi1Srwj3s0SAP46v/sX2W5nPrw/RgP6HrGn2p4=;
 b=XX2FkYQ6rnp1JTr7TPlJiz0vNRNtG6IRgyLeFTAubkKIy6/yyBRnku2QxhtFQe7X4Ix7khVH3fJ5WI1lt56jaOsvZqd0FFwJ7de/8I7PSAACGEj0TlNmQfU0Hk5E4CTqyIE3Iud98xafCjv6hv7tjmgj+Xfml2saFyOyBIUk6Nc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY7PR01MB13783.jpnprd01.prod.outlook.com (2603:1096:405:1fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:13:12 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:13:12 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 00/23] Add p3t1085 and p3t1755 support
Date: Fri, 17 Jul 2026 15:12:18 +0200
Message-ID: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::6) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TY7PR01MB13783:EE_
X-MS-Office365-Filtering-Correlation-Id: 940ea1dd-5110-47db-4caf-08dee4052754
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|6133799003|11063799006|56012099006|3023799007|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	Lia/eMYQRI7MPCBDRNK32DKVqCy4+PVsZFBGqFZ1FGDf9LenPxBmx41XTcSTO1fBfzSbVDVON4481kTP5Omj9fyqdG2jjkP6fTU++tj7mIasENZkt0a8yiIM9/qTcYPA9awscXxMqkViqrl60rFvOnScHUVkEj8t3uvL5Pxhs7yTfPEDLgfOiSEKtrK1/ks+Uwp98uNqgE74dobd5m6F4qqfCvY9/P0y6bWKyIbuCL/fwMVWrvcqsr81hKAEQ+6vz+rNzZDHE956yryZjqRwQWlmcZxqXKUv/9nMzgjdiKA29vctI7HzFDCiUcuIQKFzKNUqkPPKqgsfa2AqBp8qIFmHVZ4XP3kYB5eGFYEVYLOu8S2C17xTRq02TLDSjaoaESZQ0gFOrxxrWLFq5JHZojQy91CYvNU9iuwPq2Fgd9XLc85n9TZ2eTmFeh1MJhCoTSpqxxCs0O9uFuU8bb13ivIJrFmv3biM89apDIwVmMeLd2+CrAuaublKgRdcHwRETCtvxjW3E5dltgM019buv+aj8uD19pbl+INEWmxNC4Yw91JbrsMLEkQSRjZaxRIi9kJZTQswstWY3pFdyU/AtvMm8k1VWyl06V0l8cCueiHWwf2lJy2jkn3BwnWxzyM94zX0sHSnCoVBXs7GT4JFljJhmnnhX46e4C8BwrRbqj87X5ASabFVbA8QWgpHcrUlgXnkH46F25wbIKXSWXVPJQ0RC+C2tN70ZDm7JZehZpU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(6133799003)(11063799006)(56012099006)(3023799007)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GvbW9XlckScbIE2vh78xxTgX3v0R/pgq2wWUV7L2rlgQUPIGoiHK5LQGAwFo?=
 =?us-ascii?Q?z8T8pe/O3NGbF5d4W2pe0wleIa4l4r1DsLy/zqNKHQojGEp1B3zyVENEL5FR?=
 =?us-ascii?Q?yVO55vRUA9Cf3g73ltp/mXCIT4UXW/LBpvVP85mhwWtcii6GqSrgGGEpQwIF?=
 =?us-ascii?Q?nlNWmACvIC0X8y3Ou9Q2tn1EumK97TlQVE/4W8YjrLULOw+LftAyrRZc7OD+?=
 =?us-ascii?Q?UeIbEn6rISqu278RoOT7HmLAOg9BeRtWgrVe8khbtlQd/SUSGQlu0sFnMJMq?=
 =?us-ascii?Q?ko343Yb00MhkOHkneSZzVcmTLOhSvbu/oZrEku6DUrPvSK6HTxPU9byqjNA5?=
 =?us-ascii?Q?eMXlIINdmEDb6Xx5A04i5n7IcRuWjB28KCbIxaFMqjHAKtGF0S7tdSYUc2eM?=
 =?us-ascii?Q?vSTPGuOxzmoFGA4B6HqFtXglVe9gBXsHvXpC49JOeCKrbPqXxfzt5iWhoU1D?=
 =?us-ascii?Q?HLS6xnjO7MC11/Qyf/iv7LrmaAAgShJ1W5iVGFp0CrBtgyn5dx+/gagH5k2V?=
 =?us-ascii?Q?WDZxO4YLOA1dYD8cc4JZGSjtPnhC6Qh4qCC3lOpfsDG5ymrwofy4FW+UEw5p?=
 =?us-ascii?Q?uj2oiEVWKeuGOWsMDFpZd+Tv7C6kCGtoPHQcVRuQJ7y+hyWphqFsFFd97gur?=
 =?us-ascii?Q?zdHNzzVKBPmojOEIVm5QavxrsMtD3eqP3JwO1+B1OjWV6LTtPyLlBVDS6HXc?=
 =?us-ascii?Q?9ibir/IOHN6cwJMQqRzkEPajdGIupjyjwhZIzunLF9cK0ek3QHpY1UqE0rDh?=
 =?us-ascii?Q?wr0IdbAcOwfwO1Crp036w232dIbFnHT4bJiU9pQPmBP8k8UpuJg09tOcO4DP?=
 =?us-ascii?Q?O3ob3m/bLrGr/TC3DvoNjMikkZQ2HYOmAXdM/mGFSIUIHr7+gYqgcSr/q+Dn?=
 =?us-ascii?Q?SjFjxBQdDZs9yFXI8ZbM7wuq/a8yDvcue46KKGyR0tUrfPNLXAOnFflPiGdW?=
 =?us-ascii?Q?F9jf2Kc/V5BoLMpeN1VtEebWkBeJ1JTXn5e4+4ERhYMa9iY3y1HXH1WNWlbK?=
 =?us-ascii?Q?PGGVVu3kETZyxELXEUTcdxgtJRFN0pwCNZX9wmLpRJpuP/K4HUwaweh9oiY6?=
 =?us-ascii?Q?wTb3dRMOqH2MHOyjYEUaGXUfZ1nhLHbg4E/z84FdUHVePO7g8z7tsPjZkrjF?=
 =?us-ascii?Q?Eb+dbPSvPeUAGcc3OEO3yoVpKS43Wr2UUOkV8ohH4K+tgKzdu8Tu59Xtq00X?=
 =?us-ascii?Q?i247HM1cy2GYTw7VWmnVqGYWxKS+3AKar0xR4GJ//Ppn46+RsYUiKGIz89F/?=
 =?us-ascii?Q?QpsPGcAcKYnPPDgauwnAX16uV2NhJKXihHEnrGIAJ2ajQaZhcDXxFEDSA0gA?=
 =?us-ascii?Q?ivrozHmxDHp3qhgpRaW95LHHPaDX7Xl0G+OwfiQqelivFOAwlJMSrBXFGfSo?=
 =?us-ascii?Q?9el73NjRDuUvWck0Vm3hM1nbcmj5nzG8zm3DThzrDYJFRT292BRIdaqWONJ9?=
 =?us-ascii?Q?p6V7CjAX4DIY1ypEuRRyPIuvAwlYUnL4nUOJvjhI5BB5S8JW4BKNoj5osnpo?=
 =?us-ascii?Q?D/Ht8LK9wKbcOj3KtRQ2ouHBs3XkEyvAPQfIo9a84GIIXmHuPqwlVm++LuEy?=
 =?us-ascii?Q?MxlNUojKPBORPKacScBU6z3C5S8q7/4YEfhgw176Btx9RfCEv4WRp53KIryT?=
 =?us-ascii?Q?8T5GMF5wBP06wpuLcG6caCpB1WbTB54BNAk87+AlAPq9R4VQTYtYXcbO3MZN?=
 =?us-ascii?Q?Vfp3SBNNgLULHpWf532wFyp8JPPvihDGDTxnIec+tW+q/yZ7CoRg+6XM5JCr?=
 =?us-ascii?Q?HqmWsMdADvR6MSykX4akABt14sb8gwE/1MdDGDxesAerYk80siNk?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940ea1dd-5110-47db-4caf-08dee4052754
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:13:12.0449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPbQ9Jn+aIToDhuDhRjr9VUjxU1opF9qsSaAQWZl+H6tUUHkndoYEL2DldH1/aeq/j9DHFCo/1Q52ZNRX0054A7XvVHiLImmmdUe/hQ2427nBcf0cSw79NBpv91hI3lU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:13:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23628

Dear All,

This series adds p3t1085 and p3t1755 i3c sensors support into linux-6.1.y-c=
ip
kernel.

Kind Regards,
Tommaso

Abdel Alkuor (3):
  dt-bindings: hwmon: (lm75) Add AMS AS6200 temperature sensor
  hwmon: (lm75) Add AMS AS6200 temperature sensor
  hwmon: (lm75) Fix tmp112 default config

Andrew Davis (1):
  hwmon: (lm75) Remove use of i2c_match_id()

Frank Li (4):
  dt-bindings: hwmon: ti,tmp108: Add nxp,p3t1085 compatible string
  hwmon: (tmp108) Add NXP p3t1085 support
  hwmon: (tmp108) Add helper function tmp108_common_probe() to prepare
    I3C support
  hwmon: (tmp108) Add support for I3C device

Guenter Roeck (1):
  hwmon: (lm75) Hide register size differences in regmap access
    functions

Jarkko Nikula (2):
  hwmon: (tmp108) Do not fail in I3C probe when I3C regmap is a module
  hwmon: (lm75) Fix I3C transfer buffer pointer for incoming data

Krzysztof Kozlowski (1):
  hwmon: (lm75) fix Wvoid-pointer-to-enum-cast warning

Luca Ceresoli (1):
  hwmon: (lm75) remove now-unused include

Stanislav Jakubek (2):
  dt-bindings: hwmon: ti,tmp108: document V+ supply, add short
    description
  hwmon: (tmp108) Add basic regulator support

Th=C3=A9o Lebrun (1):
  dt-bindings: hwmon: lm75: use common hwmon schema

Wolfram Sang (7):
  dt-bindings: hwmon: lm75: Add NXP P3T1755
  hwmon: (lm75) Add NXP P3T1755 support
  hwmon: (lm75) simplify lm75_write_config()
  hwmon: (lm75) simplify regulator handling
  hwmon: (lm75) Remove superfluous 'client' member from private struct
  hwmon: (lm75) separate probe into common and I2C parts
  hwmon: (lm75) add I3C support for P3T1755

 .../devicetree/bindings/hwmon/lm75.yaml       |  37 +-
 .../devicetree/bindings/hwmon/ti,tmp108.yaml  |  18 +-
 Documentation/hwmon/lm75.rst                  |  16 +-
 Documentation/hwmon/tmp108.rst                |   8 +
 drivers/hwmon/Kconfig                         |   5 +-
 drivers/hwmon/lm75.c                          | 399 +++++++++++++-----
 drivers/hwmon/tmp108.c                        |  73 +++-
 7 files changed, 419 insertions(+), 137 deletions(-)

--=20
2.54.0



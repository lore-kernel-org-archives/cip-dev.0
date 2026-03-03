Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B34EC0469
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 09:22:17 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.10])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14370.1772529732365280893
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 01:22:13 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=vF48nODr;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.10, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVxSRBNlIZuJJmUsc0fSst8R4XeCUkqxanR3rpjrwnLwykktdC+oHV8JCAWeGKsi7PQL8mtuBKEP5dNiGzDmehIXVGYOlYbe6DHpQjY9fLN/GVSE7/IdismVViMMMhe3jE24vva7gH16Dg/qq2qy5nrLJDcv0hgYYVWcxVxIB6WdByNfRMiEh8TzwaOfQZ4cEAln6qXT4EZ7MNUjhoXG97PH0sJRmcu9AdDZLlGfgByoJwqJQj3eJBx05x8pppQIEzKlzMJOm5jCyXIV6zGH3rwsAvF33VKVmnyiDbAecWjoktBt9a1NzdfYUBrH9q727WUE/agxKf+4lC64FS91DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDZtRvVZjFFozwxz6Xvqo3lfSsUABoZnYFd/ZnzpzFU=;
 b=fc9HUaE/fvPUEUIHdukAzdaViujmxiKTbycC6cJgYwG4jDKNY5UcqUrpKhae2xUMwXQc12XdKYq4NJWjhnDCvcGvIEcUJ/uIqMBSrONl7da4cHifz3OSzPNL3cyxs7kmIzWXzba8rw620wZ+xNJ+DZ1bT/tA9d3MPE99bC4SYAcJOpSwyV2fB6GsDxq8780Qx5hwlrEmuHu4W/Y1pGiz1RnIQXevzX92ET8IV9iCJGGlrBTBVZC60ltwNfFMXii2N8TrarYO9zxIZXfupHzAgSVIc7X87a03oUExGxvf84SsN+mHd5Rf5A5xF847Kpv3xYlXd2yp1ElKZ7jIJ4Ewsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDZtRvVZjFFozwxz6Xvqo3lfSsUABoZnYFd/ZnzpzFU=;
 b=vF48nODr3J2mskh/Y6t/CbG/WMsY9KDRDZkYEpm/mQe6UE31INooyzaveKEehPKXk4noHZgUnggijFSOR+LPj5SOjzi74oGQIKwkepClPCIBtXK3CTZ1SWsPJdnGC/53ouEvyi7cmohaNS9AOMs1FYJ/bA8fkyrJ0tppwHRfgmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS9PR01MB13190.jpnprd01.prod.outlook.com (2603:1096:604:30c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 09:22:08 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 09:22:08 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 0/9] i3c: renesas: Add suspend/resume support
Date: Tue,  3 Mar 2026 10:21:31 +0100
Message-ID: <20260303092140.12732-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::8) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS9PR01MB13190:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e50e82-c09b-471c-2502-08de79065756
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	+fVdi0nMzSOSm0YTMlcNtFdFDla4/ojaySNXNt7PUiZTiHPtFygZwWOIbfy9/YWdvMYHJPGeQ+VjIJfIFnQ5xHdXJA2JKtvJcQCMofoc5szNlRT1oxVPvdU8hn/cR8zz8rHroKWtBVcN42dyz0r/0+oPxlX/NHFxEKtylz9mjimVUTim50UI4PAfy3ZVDA3F7gdohwpQmKBHAC6CV7xXIzd9bmsT5RT3uKjeQTCLnNk39S5K+Z7xUHK5v8fxt29gKWzc0dCZqlrvH6rSwQumNBtzhdZLeH2na8Bz6QjgmQtQ1StBoer7RoJGbHWF30cZpk58Uz4LaL+ePWCYBq8a45Ns5J1jIgAg7FuHYaOyf9fWDujaZZn9xRXtDxc8xyej+49qznQSnJI8BVAe/3q5Titlo7CoapUd+aOhmX92oXegtg+0CnWfvcmwumHMywZUk4CyaSGOvBLDmcptxupL6Z6irah6EdU9nryH8HnHBzXvA7Ux6B+yfobjQCcwSBXw2A/O38aPdBqJ9oVvZ6SNVjt57tA7kXZ7OO+J0NLpFUhCpSfnv+dAKg4d6P1bthQg51ACUhhRhwextIClJbXsH+3nkh9mn1VYf2ahJO7A0D+K1ovGYK7Ry/2xaMvf1Q3Fe114I8Ss8I2oSSKgSlZ6O36HX+4dGPQLj73xqldZWLRelwDW0FkcopPX7pPRhesMIRth/MRrMz3shVM3nUhnd9mL0LgJ2vktQiqi4CxtQh7ezUm5frJ5nnXwnqjHI+/ce4Wlm5KRlqX600JFu8YHlB4WmfoEWbOBd+8R0e8QMmk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WdpwkeWNET+oIaaB1dcR21Br1SE+Y52EqoLCD0Rzjhry2aWD9sRnjThZOy8P?=
 =?us-ascii?Q?mGFJOQClQPojHPZmfonMP8yGrThlzDyNJwgsY97907ZmumgLRfJDbDMKlLuz?=
 =?us-ascii?Q?j1zr4JewSJLHwTGtiuqbNPqTs3SZYoo0ZbnE4F2REb2ukZWeaoeQKoZIqAqj?=
 =?us-ascii?Q?Tc17HxvkzHHZFM80ozJI8KwiYlkBI8/JbTrWJcdj6h6HiRNLIdXICYSG2biC?=
 =?us-ascii?Q?E44jkm9w5YbX1Y85Qs6l+NAihQf1PMNFGRmM110zEaej+VuT5mxf0fhrq9YV?=
 =?us-ascii?Q?Z+1o/Be1yLZNEquGuyRv1DO2x25syldSM5wLYYGuYq4s0HZK+PrwSSUxN7nk?=
 =?us-ascii?Q?XhUUxvuj+48I5lWqV3Lvc7QQeaCawsnOgTJxfyCYazXxedSljzvEYjHLwqRb?=
 =?us-ascii?Q?IrgyDqXoCusueWxUd3TYgsRRW7Pw0QWBNzeFmpc/8J6NuUNXrtQqD6wxwy9n?=
 =?us-ascii?Q?71PvMHN8CiK5xqb+cWUKszD0OjoIL+hW3OuzMaL7IQPnXpN/eZszoAjGtjuQ?=
 =?us-ascii?Q?bKeYsJW32Q8uQGq+Au2dlRAaXUmO5hHMm9818tbIHL3vxP5VjTR7xPybL2ir?=
 =?us-ascii?Q?djOuYNubdKul4uZYRvIYQPXpAl2vOhJoUgBn4sq+aGdgdDe4SLFppVL3swEw?=
 =?us-ascii?Q?/xwe2x5V6u+u1cDhLlyjJdM/F4UCPHUQ3eC7rkunqt8KJbIrBC07EmttuJQF?=
 =?us-ascii?Q?YOzWld2gZt/G2WxCLC/2lGD9fZvMNtWgV050Z72bUE/ygGpe/ZwFwesKd+Uk?=
 =?us-ascii?Q?MvcUS2/3Uj1XeNN4wmlUKuj+/F0pKc5euy34gMOBbPsD9OV+m9Mbhbq2XoQs?=
 =?us-ascii?Q?ngVJaeDPBPCZf8tO7qL5/Z5X4BrMOX5bpq/zm/0udhHuJYCLs07chQnoXgZ/?=
 =?us-ascii?Q?nCEFhl3cCSFsSqgyn0ygeKRzIHCjmbaGoZhkf73CYLAXWN2+iRw5N1nhzL/v?=
 =?us-ascii?Q?A24OzouDlvu5izISMhB46c7aZsc3WjlzhGKRJYlROuNSpzonZ5GMuVTRn49h?=
 =?us-ascii?Q?N0rzJIJKjfWeqwdwqEC+KXdtvqLGL6hSkDGJygUHQTW9TXsy89JYnWfAev36?=
 =?us-ascii?Q?3Hj5w1CxFMx3ne+nMhYXKJ6QCjDoZNLbw+OGX0EBRqjNQGe1u44ekgJtUYec?=
 =?us-ascii?Q?3VVnY92oU987u1s5Jl8m7BlYCv1TvBepxkAgSVILfAXPxQ6dba/hHqYiRGww?=
 =?us-ascii?Q?hiehxpygmYuLyGgBcL7sKuCxlvobEg9ttB/A7kmvBawNwUget0Wy/HSaClDi?=
 =?us-ascii?Q?neIwApITKm/koACv9gRkHy1hcnoXccRARCSWQMvITDFxeyH65zXNJ8876qnz?=
 =?us-ascii?Q?2lFUNrglo9IZLkxCYiNvMFT2nhz5b3nVuL6lDYvzpg+VoY2lPtnZCuBNwW1A?=
 =?us-ascii?Q?hwWQeNh4Q6cb74tQSvkpwLT0DB1b8ilJoUjXPW+uM8EzYqPQHRdaZpMqPTvg?=
 =?us-ascii?Q?s/FafyH9o0mGyhlkoWvfma59cqSI0cwZOzOb+WyazR+q2FurWE4DrxR+y46K?=
 =?us-ascii?Q?rcJlr67BWK0brbJ/qn5XUa+FahsJASOR8clkJ8JKPTshZrnUQmqnV+G1J6zk?=
 =?us-ascii?Q?P05HAeHK+ihW7SutzW6dT+uk8OG/GVPTRUnO2WTIgAWCKErzXpnzxzvsJMvK?=
 =?us-ascii?Q?GnwhwJTlE5/Wp/95YYxUMMf1KrI0DkvxyUzwu9Uds4UJ+gDrpH+PQWFj/dcx?=
 =?us-ascii?Q?e2MOzohE4G2L7Kz7H+u7TujMKdRwfUZP/2cdfMPTUEB8qJK/w3HE0PkGIhOF?=
 =?us-ascii?Q?fJLgir1EZCoVfKlJxzB9/x5nucsUzwL0/9GuG/vjlkPQ7SiUsVNy?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e50e82-c09b-471c-2502-08de79065756
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:22:08.1113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3da3+q8qAcxLIi4M2sS5SDR6p8xe8I3Xccp+GyN4Wtaa8Z4pOnMEgffiRA9MWwcFf7K+aE7fJg3q4znje/4TRaZQ3kjEQlbWXWPQaHO0qsKa30a3BPAiS9VVRvxEq37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13190
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 09:22:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22041

Dear All,
This series enable I3C on RZ/G3E SoM and adds suspend/resume support to the
Renesas I3C controller driver into linux-cip-6.1.y.

The series also includes patches required to backport:

 - devm_clk_bulk_get_all_enabled()

Into linux-cip-6.1.y, which are used by the main suspend/resume patch.

Thanks & Regards,
Tommaso

Bartosz Golaszewski (1):
  clk: provide devm_clk_get_optional_enabled_with_rate()

Cristian Ciocaltea (1):
  clk: Provide devm_clk_bulk_get_all_enabled() helper

Shradha Todi (1):
  clk: Provide managed helper to get and enable bulk clocks

Tommaso Merciai (5):
  arm64: dts: renesas: rzg3e-smarc-som: Enable I3C support
  i3c: renesas: Switch to clk_bulk API and store clocks in private data
  i3c: renesas: Store clock rate and reset controls in struct
    renesas_i3c
  i3c: renesas: Factor out hardware initialization to separate function
  i3c: renesas: Add suspend/resume support

Wolfram Sang (1):
  i3c: renesas: Simplify return statement in 'renesas_i3c_daa'

 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  14 +
 drivers/clk/clk-devres.c                      |  69 +++++
 drivers/i3c/master/renesas-i3c.c              | 248 ++++++++++++------
 include/linux/clk.h                           |  66 +++++
 4 files changed, 313 insertions(+), 84 deletions(-)

--=20
2.43.0



Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBDFCA0FE0
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:43 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.31])
 by mx.groups.io with SMTP id smtpd.web11.896.1755705934534822841
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Ag6KsG4u;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.31, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoNTp6Ncm/3XvopGw3TqiBsHYGm1CLEPS5nB6RbCRPkPZfE4jBKOMzHHofZDxU6/732YSt4edk9bQAuj9Lkz0vgX3iA3fPzqVRj9DlT9skq2npXvOZi6/MEic38rtLqY3Mfbkt7b/O2Yl5BBr8sJH81zcSd7cRw1tMEO1zqicSJKt9/3IVkgABn4X+qNZUmrBQEOWaPohvhnLDO/NfhhyY9SV6ZSoCpdFK1QlODfeI3XgMe0cVuaxCh1xojbiWHHeJUyRg0vC2ITpO3Li05wJK/ANyHDUMKnFtnhJEcVCcYxu/sSu6jzhDNW8yDqB/0nnsJgSLSeNynpG95mqCS2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NFhHhrE55IT1As08F21LZU8hIRMaC8UFXUQVUGpfjI=;
 b=db+kE7SGxHBFx7LFAdtnlMdpRwgMdIjf4PW+JwV43ferhOTCQxZNKPTd5Ms3P31IJ5Zmg6fdDZRZiO7cTJb3wDU+zhTMXcYVikj8oSWyH1TjMO2Fng7TWYiQ0u1neaTrVBs+vMJbz1ieJ1EI9+nv7s9vWe+h7b6lcy0uBohV9iwTG7DUGA/pRTqnvY+DjrSVaPkiJOpwVab0CJoz8OIptqOvyD62C1xL9hNXVLt6gzrCo6mCUDXWKtcxo0hrTpLAr6E9TInXyzGPpUjr6GI4lja+uhB8RfnooxdYftJTAl7SGFXuK2tbq1vkUvyiH18zpLZZ027Z8g/RKsxVckyufw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NFhHhrE55IT1As08F21LZU8hIRMaC8UFXUQVUGpfjI=;
 b=Ag6KsG4u0XxvXabCcIVKstCa5YdV6yczIcooVDjKV+P2c+k/RYpfYNhBLtANE3bBmdLVUGQA3wUXQjbDJGituUw/F8iPpGfXf8QEnPs911+hR/O+kCbm88JY6iRZ6Ivcbyndg1fIDvlHpXqWF0QzWFI3xQ4qgLWU9bG63sNaJpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB10458.jpnprd01.prod.outlook.com (2603:1096:400:2fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:05:33 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:05:33 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 21/55] media: rzg2l-cru: Use `rzg2l_cru_ip_formats` array in enum_frame_size
Date: Wed, 20 Aug 2025 18:03:37 +0200
Message-ID: <20250820160413.801341-22-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYWPR01MB10458:EE_
X-MS-Office365-Filtering-Correlation-Id: 426893be-8284-4963-8504-08dde003647d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?WNsJ903UpRaMx+hdd8Lxs3fDmvPGxbR8TCHEk9bUsiILsZq+r14jpynlY2XE?=
 =?us-ascii?Q?Bh47EVjr5GCe8hd7J+L2mK9Rs7+hoXc1QPfnyDRfC8lBoMVTDz6COcOo0A6A?=
 =?us-ascii?Q?zZuad375JNK2LsNh+Ln66QzyjpZCFR9Ac5zw8wPRSdvvE5NHDSFb3bh451Ai?=
 =?us-ascii?Q?Bz0xoQUWUSkyhce0UuSlf6ntHO6tDIr2++372FtbeaeVNCnkPgQ2vwMFOGPg?=
 =?us-ascii?Q?xCJaWkl5uPGskYL+LQLpXLZznh1A6TVZ+9cah6F7vsPFzhvhrbDKe0iOs1rO?=
 =?us-ascii?Q?mfYbaW3657RrBPueweYRoQbG/fviMPtTNaQ5qaMSNZRjXiV16ctlRn5W4T+R?=
 =?us-ascii?Q?JBMzElqx9hjW3kiC3sZ062rAo1k7ENW1MjWiTDm24iW1MpkRxlk+tkJWSTfP?=
 =?us-ascii?Q?1IcIWwcwbirvnKt5dwEU4JaaAARu11t1XmQEOj9Y4hO6tV6udhATv4TZZoj2?=
 =?us-ascii?Q?6gvzfxEy7VcP/1b+7IrnIaCIteL+4M6cpKoUJuf2lG6RzP3Q/e4qvHRvv2Km?=
 =?us-ascii?Q?N/eJsckzRtQbNAbUZyBAEsbOfvC2d8qVEUqHTyAUrwaWpZIAAbcv3ghU/FHx?=
 =?us-ascii?Q?pCHbboSSr5oRJhKDze5rvB/rzE1qwysJk1fbjluPSnAA34IvjNQN1h6tQ/JH?=
 =?us-ascii?Q?ju9UWtnzWgER9pjU78jXarOwdL2lFvZsBttI0Dj9aPTySOd8PJqxFGQolEiw?=
 =?us-ascii?Q?gysBRLxFpYOUtG3CAAn9OfkqWj0oJiaEOWPRpYeRozuUsvvtVnVCkVI4VTXJ?=
 =?us-ascii?Q?K4624y7+TgSG/JgftSzNBsEA1aKr04flH8Nm9+xiXV+7jxABGpgZrHaJnaYl?=
 =?us-ascii?Q?Ui5YNsIbyWLNn21B45+MqwVNIOhE1hqxjXnYAe6+vqad5A17uAjN7t2k8LC6?=
 =?us-ascii?Q?/0uYPHngf3w6dCUhq8eMrNZpn83PZoxfBSUo/7cYx/u/ikRzz6L7HWr2T59N?=
 =?us-ascii?Q?vlyCjIeeDr9gCGAer/J6xII9WOs6H47VbUMNgJowaE8MyC1T043pr64AZuQR?=
 =?us-ascii?Q?2fY/Ra2DUkfxHkmfICs8Umjv14YxsJl1IWqXn8mV+yt42sBqg1ZPv+SCGWo+?=
 =?us-ascii?Q?Rg0r+p8AtRqUpVlO+TQeapsW+wkY4WDVRmATT9uu0M/lIgT72hIATYi0Sd/t?=
 =?us-ascii?Q?iopnEh6EfnJdGQeTdwHjDOxNA7SwOpaP5CaiNpRzlj9adBXnpkPoVKAl1/+8?=
 =?us-ascii?Q?q3wz+uAauf2AKBE8g5YvkeNjMKw8gjHs0neb8318pyn9vIK6WSadA0VCnGQT?=
 =?us-ascii?Q?tXbaAvYI23VYXonUU8snlA59IgzUeBYHTmD+nypbOawr5kjmANXrvYQTr0sJ?=
 =?us-ascii?Q?HsdHPzVS0Pep8CoAIryBaxaHeQWvvDAnmuwYxJP8UkAdXD9/6sz+8y15Psmh?=
 =?us-ascii?Q?5Rw74Dy72ZOddptQhebJl7rRGv5WNW80AKn4lWnJDnYNypogoGRXQKm2Age2?=
 =?us-ascii?Q?RBWIJR/ridrUQS0R9rOW7vuJEdRqRfObi3H3O9LlbQ8olbMpP7U9pXeqKEqf?=
 =?us-ascii?Q?V73ajABLx8er8CA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?buMtIBs0a9M0XyAg81QrFGqWMzum4jj7b8uXwatWu2LhgJezGVuj1x0r9pS4?=
 =?us-ascii?Q?Zagi3/fnrt4TZANB1Ii68VhpB6vvS8nQAv+5w2Jp9s+2mt+BiWtqBExd6X/U?=
 =?us-ascii?Q?7mcQXLPRXlUgVvDfEBE5hJrAqeTikp/cZNab2BJYRGHgBpxRrREDJgiCDjuf?=
 =?us-ascii?Q?hPL8Xoso7SXh3pmXh4yF8meMdUKYmrl0VW9j+TmQnDNGpASDLbuCJhZTaNEq?=
 =?us-ascii?Q?hSXmT032c/2aoUXHs6BqwMAMFJI9z+f/Au/JxfwblaDC3jmBYA90BZMPtL5H?=
 =?us-ascii?Q?9qGjhZt/0tPq2JSoHUdoSWW8ObBsU4966PVyrsjzUhttla0C20CLV/QlxrrS?=
 =?us-ascii?Q?UbH10MsLDJ0iV+EHC6JtHF8r3YKkQSlBPqlhcklPykmotyMM4vHtnJwaPR3d?=
 =?us-ascii?Q?MSBE1kwbk+d6WcQMMyavacXCIWzULMsMFPLKHsU8Q0IUVpaB+K+wiTajMW6A?=
 =?us-ascii?Q?fQQ1VJfRqr5IouiDIk9JB34h2LMe3rbLlBsQ0NrXGNH2GtZoy4rSuyp5X8hF?=
 =?us-ascii?Q?Fm055ulkBzJFzLLziafmrz6taDmKmfi4uA24LDCA57VID3GFLhY+MOo07loM?=
 =?us-ascii?Q?vLwCKH8pVzfapXrbQReoW58OT4xda/Rk7cYB0RV2ugwyMWWckS1YsKTh1iuH?=
 =?us-ascii?Q?L4FCdUlcjIdhuHz5soSffx/0EFVRYfvxU10J/ulq5am4x7R4yH2YhpmN4Nhr?=
 =?us-ascii?Q?OZL6DuX1MGcKalE+MAml0Gq1FxnfEcX+u2jV19CF+piXqLI8lbV4DdsfqlLF?=
 =?us-ascii?Q?QH+OnE4Xhi20t3uw2CQ3CRj3yZdPsJb7JNoH0wvJ7j5EbjcaWsVCl4qqHUFC?=
 =?us-ascii?Q?9Xom3TkPnv56xAvO2uQ7pW89c7rd3eXH4DHQrf7c/933gsRDwEl6WYw1V/iK?=
 =?us-ascii?Q?1TMEmqoDfVinhiv5W1n+Cuj3CIt5kvbE8LBRfY2VQKShmIUWP+P52TmA5bKq?=
 =?us-ascii?Q?6JQTSI/yLj7wrCjXjJ8Rtu9EyewcK3QtDfjwIweorbNod335GklaxCEHsB7Q?=
 =?us-ascii?Q?WLqE7Nw7TlM3Rjec7TpHeFVoWSKp0jomvmKSiDSc9G7FnDQqBTwah4ekAMYu?=
 =?us-ascii?Q?IeDL8CzwLmvINvxduAdQ6WMkimXL//4ZE+OFscpUeyUUsARfAS6j3pi3HRaQ?=
 =?us-ascii?Q?SFAK/3tO/BfCBTOkP54EWVW8zpLAiFCFq0Ib5q/s1eRSUG8WH2MYFHrtSG60?=
 =?us-ascii?Q?ZzGs3gaoi7EEnHJ+fAtDkKa/83lAQ+m47CY4QqxQGFwcNXvkBAS47U16jhZ+?=
 =?us-ascii?Q?Gw3Lhd+x7tzmgAACZkC+h8HuMQPZ1Sc0kUroSwlksMG9tSaj+1fr+z5RlkZ+?=
 =?us-ascii?Q?01ts+i8No8qdw5Tp8DpkjEFxDFCtTlUCCphpGPdkevQ/RIiZjGwsNAc8VibK?=
 =?us-ascii?Q?yT/0y6cjvTUsvp3QQcnbIEe7LY5vHJY2uYRiUKLeo9zlXYwgbAdIYimVn6u5?=
 =?us-ascii?Q?phcrhXZ4yYiFrP8kF8mIuNdjsfuIVFp3plM4mP0BJHADZKjY30ULyiiIQJ0I?=
 =?us-ascii?Q?tXMcF3C23wCmGZHj6y3iwaBrnjlWXJ2DACRctVV9z4W514L4eFGiDdJc7ZJ5?=
 =?us-ascii?Q?lOGrhvK0RhX19hr2mpmfcbV+LCS9cx4KrC25LQX3Or/CNh6qKZvk6JNnlJBz?=
 =?us-ascii?Q?WsCclAiqN+JqJHbo1fjiljY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 426893be-8284-4963-8504-08dde003647d
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:33.5362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8u47NRBYjDqmwuaY992UaEH7/EYlByuIqqQkNe0HXtp3f3GJH6xGPTmCzT5c+U/tGqAkfi2eGBpRiJRTu1zsI4CYLE0MLYt4GypdtGC6Ramssri4/gmEft6bFd6O/mY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19846

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit ec37ac1ad27a361fe2c4ec61e521f2a347ef311e upstream.

Use the `rzg2l_cru_ip_formats` array in `rzg2l_cru_ip_enum_frame_size()`
to validate the format code.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-17-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c b/drivers/=
media/platform/renesas/rzg2l-cru/rzg2l-ip.c
index ecc353eca2b6..9ccecdb67688 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
@@ -165,7 +165,7 @@ static int rzg2l_cru_ip_enum_frame_size(struct v4l2_sub=
dev *sd,
 	if (fse->index !=3D 0)
 		return -EINVAL;
=20
-	if (fse->code !=3D MEDIA_BUS_FMT_UYVY8_1X16)
+	if (!rzg2l_cru_ip_code_to_fmt(fse->code))
 		return -EINVAL;
=20
 	fse->min_width =3D RZG2L_CRU_MIN_INPUT_WIDTH;
--=20
2.43.0



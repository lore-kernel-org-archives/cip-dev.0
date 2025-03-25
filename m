Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B49C3600C
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 14:57:22 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.4])
 by mx.groups.io with SMTP id smtpd.web10.67888.1742914638712880176
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Mar 2025 07:57:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=YsZoqImP;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.4, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8F8OZDWdroqTeMBnC3TyXHUXWtlwBszJNPrNJDe2ZvkxIos2PYIAUQbkK9kRppNc5t6oOM3q8VkUXhweko2rz6vL1H/4xv4tRyT9h4zbRSsD49iGhujiHKndNt5aUVD7PsQI9p3xj+THGuM2yNQhI0lxWFUaqneUYu4kPS1Vs90ahRzSkCaYJoK3qRX2TXmqvabvFEZsSOrCs5s48UFEtHITy95MRLnbnJk3p6Fqg+LUJbIK1ZKSoRkAj3TdNMzy82zt0LJEiUjXPTVFwf52zAflCgIk0aaUCMKdIAVv1y3dGDx4eVbEWqD5LMi45yXvw1qZczEcMQSbCRzI+yC8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+q2bf0EdW34WMbZsj8Wu1nalSpG3PLoug3zXKWfD0t4=;
 b=DCve0lkpfWjVVPUVKyBSZdtWbJ50qUJP9ZdiKeztpc4t6J7i+bcxXGnEs4Qedl2VdLfGxLIwqYxYcLiyhQRrHa2Hqpg6PshH/Uh2zHpqbrLcTKXWH2e310dVnLHkiCKFb22KdvsBTyPAr6nLVbQn9iP5/jnle6imdd1uaEbP5BKBaYX+2YgRBAwr9RiR+W+5uHG9A9dem79MQEhvsZcX64iecpkGRFzCdY6hrKdwvRT+eD4VwzqOA0f2+t6aSDtfzC2e/da+aOQ3nxLUnYrt9kLj9NaUZUWReBZDPCkwKJPKnmOZVKhZ/AVqd316yLQXhifTiUVxPaJ5jc25CtAVcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+q2bf0EdW34WMbZsj8Wu1nalSpG3PLoug3zXKWfD0t4=;
 b=YsZoqImP1qeSYUo9bjG53r8pXcDSYs8CLubZcJlFuNLZq/jT/8zxLDtHeQLE+CTKr++2uv9byoZB1QmDTUrl4714yxCvWtOXEj61RDoiXACimR5xWMNKMHdHQ+GU0r7K2FBn0P7OaYAgcdcEE1WAnOIvk/QJMS3TfJHbN8jYAYQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB13248.jpnprd01.prod.outlook.com (2603:1096:405:117::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 14:57:16 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 14:57:16 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 15/16] soc: renesas: Add RZ/G3E (R9A09G047) config option
Date: Tue, 25 Mar 2025 15:56:09 +0100
Message-ID: <20250325145611.3595454-16-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYRPR01MB13248:EE_
X-MS-Office365-Filtering-Correlation-Id: cf17561c-384f-4b66-287a-08dd6bad5588
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+oJn3QcMtT+gIIZxxhpZR59eNDQg6Iy8EWn2hBuT7BBxfIfjp18RXR31zoGt?=
 =?us-ascii?Q?MKxhdnJ9PuGQsGJmf3LrJcvhcl/rz1s1s2EJQ9BiwWjn82ARryfRVBddOX6w?=
 =?us-ascii?Q?dIU0/AEaVBaWOq+XLq5CT6r6F8rjP9hQV+yd10WMqz2CTFJdXxJH6kAQMt58?=
 =?us-ascii?Q?koQW5JUgkwwE0951CMqucyoDV8SHs6WfMUiXg5GeVcEr2YDXiOQMCFFvCEAq?=
 =?us-ascii?Q?lawyZKgiO3HxOLxA+0cMHURmLIsX1Gxvt4/5CbaRuaFZXOaiXpz03Fs10Uns?=
 =?us-ascii?Q?lVHCuUri87Hg7jAPTIXYBfXe2oYoebLKzvRAFjWByd1byyiwhhreAnWAPz0Y?=
 =?us-ascii?Q?SE+WxNOJGkgDFTLOAuwNcB7i1fNiMhWJgvdDywfXVpwKIH9JHVn20UTD70zw?=
 =?us-ascii?Q?nFnpXer2gMqRxB+5ztLd6D2XqfGmTqNnV5ZOcGsiGWaw19gOVlga77LfXXzd?=
 =?us-ascii?Q?OAbgdpMhpvrF/bJmQv0lXAU0R9XN+2bZeOo6zqtVpMUrrwD7o8CnNbi6KITI?=
 =?us-ascii?Q?XXNUjklwmzTzqG6PUChF8XYRfPyQm3WD2/hUcXehCUxJlVNKt+C+6CBUyGHd?=
 =?us-ascii?Q?Z1Rc1r0EZ2JAtQFHe/9j5wMdAEHhfeyQlN9IkW0M1k1340z+NttWOQJD41sV?=
 =?us-ascii?Q?5yzGu+2qEwo95ju9+/HuCJTnJaQexCUtXt8i0zRqgBgcELViOzkCXsf2gq1j?=
 =?us-ascii?Q?Uj09crz9oBj2Gyn/WPdxkNe/uuMUnD9xMfPk7h4BQp84HtAMrYadwKtOB7TX?=
 =?us-ascii?Q?a/DFuRwtyC5K4h3+Ukg+1tjFKD0B0OCDMqttPkyVuV+bbuMA8HyyLsI6wSeX?=
 =?us-ascii?Q?QkqfF/TCMSuGZFAj0HZp77J9dV+awQ8vd8NyVI5iNHJlGiM7TDp+FANsBHVf?=
 =?us-ascii?Q?QaRD3NXDYH/LIFbulagjieygoAWwxWo62Cw77BczYxr1laCceazTMMvsEIxT?=
 =?us-ascii?Q?3DgTE8G+Yjgl45psPvslGw1NDS+Qy+kNwXgspBXQVIjDc6MnNLwJDruMYH5l?=
 =?us-ascii?Q?VKmDcW1blXcuwbKJ0VtcrvsE/lOVoTkyujl2LeQpvM/GRwSIRLLtOPQW8kHs?=
 =?us-ascii?Q?xiC5rBqh7GMuoAHBZXbUxvOMbPO7oVxrBniyuHwfwrZNRHkdYNcYWoNgeKhk?=
 =?us-ascii?Q?tBZaiw4rpko/S+HBGvYZwybXMqEeTA5udiPfXMOZegC3HrAo4ykSjKAZclaH?=
 =?us-ascii?Q?43PpsV1QfWJA4Z5ogQ/s8Yo3iZzoPIk3cdxtQT/2BZ+puPmXk2z2fuRAqWLK?=
 =?us-ascii?Q?n+YzfhPzknJHVbefOyAtn8OX5slFKdDm6bgV8fyVkqVgcsGpPGrf7weSK0Kw?=
 =?us-ascii?Q?76HT/GnjUa5OuzgLwZ6SzScvzyaYZ7XVnqPMSAxMau2nKiMzCWUfps4kp+mC?=
 =?us-ascii?Q?N6WRLzyVnzy03pOSO4wFmPVo9mQOFsstosOaB05BywmYe9SFm0o/Ym1Fju92?=
 =?us-ascii?Q?q9pyXnMEg6ZMJdLPAvtynPDM1ggtKnuH?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Vst0Nu2Kz1eWsFV6KwcaBhdg59qCdlL4wz/8ZH4RxvN5gHn6RfhKnwioiMeX?=
 =?us-ascii?Q?AUNQzyzToBFvvLdkwNq4xSiBuZSBSthdQNLxejtY/7vt8x/vyTh8YoEveX+K?=
 =?us-ascii?Q?a2nSsPj4kGuN9zGvo3rNJ2UzEZwqZQT5Bikd18QIiGG1CWp/RmArNUoVaeUc?=
 =?us-ascii?Q?9flHzMETMEPeOUM53ReKzZrdYY5Q8rMb4zCz3nCzh3MdxfgsnTzIutR4YxS/?=
 =?us-ascii?Q?qaeraQ5M0DNgts4pv8SV+hXPn84yfZRM42M051201o+x7oZQazPow9yjctOF?=
 =?us-ascii?Q?t7W53yJZC0WrbP+CHjuqBdgv0GM2yp4hvPDPdxoNvLEjL8CFRqapQny8nVyF?=
 =?us-ascii?Q?6Ifo3mI+X6IS0Mu7tnxIlbV7sjBmEjCkkG4Ie45YNkRhqxsfS82/4eU5/wy9?=
 =?us-ascii?Q?wU5T/IKclXpOvSK32RqtfBkLzUS3hZdP5skPtuyP9DZtKmuAdaehCV21ClCt?=
 =?us-ascii?Q?e1MfJQRffkgpRgnGIqaxIYzF2btgXjGX2UK0gDc025RD0vasEEz4ZqTIP6DL?=
 =?us-ascii?Q?TVVLNAsbPwpXtESYHKR4Nh4Jl3j0PwEBftRDj5YOGy/gm7jDEHP7GegqYwB7?=
 =?us-ascii?Q?20CEJJYdlc3NmuQVkqFjU8Tbj8wIKtouvzPvndtRzGgy+tTYu4qoHM+nCMvm?=
 =?us-ascii?Q?sGcGlpXOQGZ5HUMs2OHQlLeCwIPe40O/QJNUdd7SnGWPAHe9lj25VxmnjUW6?=
 =?us-ascii?Q?UGjvKxwhO/woATKgJoxFKnh6s4YFK7VtkYes1Rc8tSXmg2AZElw4UeW985FJ?=
 =?us-ascii?Q?Wsy6xJ1oPy5qD9w0LutwA370xU8zCM4M4zd+wXYpOFRKm92nG0YBooIAwVT+?=
 =?us-ascii?Q?0UZ2sQKvHex0dmYxgNFsi0sySaFZVU0siPB33FbpVBRpIPc+FV04NiHq4M3S?=
 =?us-ascii?Q?ilOhAev30dXYC6GQvJTpOJHVgvBKFix3ixb0y//sYE0V6177OpCAkH9DhvV+?=
 =?us-ascii?Q?lfExjlBMa/9fyaOiJ3XBmRU2QlTc4ibzDNiyvSt3gxdUq+t1EwycxlNW+nMp?=
 =?us-ascii?Q?lM+mhmEqviBf4C2qdkarDsjLsZE1vbolOKd4Q7Gb3s/flVNl7pTI7IhG+qwG?=
 =?us-ascii?Q?PXTlMVFIg5JueCzr+iRlJz2Tu3o9YF8oQLnC0yTvqj/EV/a627bKIJE4zGGg?=
 =?us-ascii?Q?R2K/UwjweE7BuHbBnye7RIjbVaQhKLOO4cSnga9bhBs3ZnAWDV7TAF4nTnjl?=
 =?us-ascii?Q?yeOiHSgN+BtWCsWVksjfojyPu/naK/rmC7Zh0bYcVTgosNAdM4bTuh41yrIG?=
 =?us-ascii?Q?sDu7r7lhnbW3rXtL2C5pyyfsa499XvbeQYTiAeIBpVHmlEDBCkwBGIpawl/n?=
 =?us-ascii?Q?KG3UbbgXTTisLbGvWENW3n0/iB5jsgHSXu6uxb0rtAQYJi5IxmBdv0J4eRxZ?=
 =?us-ascii?Q?Q/FRhJbves9lb9Bqttub3JhXYtzuoGxk9Ob0w4q2fZu3bDbV+DtyQjR3jTxB?=
 =?us-ascii?Q?FyBQqJ2DhszG/bCdms5ooju6WSQqE6xkvbww9O0wo1XwX0FpFH16fWM3Q26A?=
 =?us-ascii?Q?1BxgkeZngo8cF9+fEUqarLz90CjSNVu80GPxSJ66E3jaNRx1NMo/HIbTVYMR?=
 =?us-ascii?Q?eDbg5QXOxVf3lce0Qu5VJvcwYuURfCmODcPQXCe5uEDcOeHSn6dZ36GYU9uD?=
 =?us-ascii?Q?FOSgSxyqHur4ZdqIzT4sHLM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf17561c-384f-4b66-287a-08dd6bad5588
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:57:16.8516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jltpNhx+u2i9X5J2h/mfPrC1Pfmivld+9Q0k1cb2dyrmJFuCYrw9x4Z8NhN94usTkdsZCMDJozHhRxt2bWSZQ7WmtGFtHOU+dPMZZNdEu8Y9/pASLfToEJB7Bz/iK9F/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13248
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Mar 2025 14:57:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18365

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 12e0bd600e3c2f33f9db0e3b91f6b8d8d95b7dbe upstream.

Add a configuration option for the RZ/G3E SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241203105005.103927-6-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 5d94c3f314944..e5c760657ec52 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -345,6 +345,11 @@ config ARCH_R9A09G011
 	help
 	  This enables support for the Renesas RZ/V2M SoC.
=20
+config ARCH_R9A09G047
+	bool "ARM64 Platform support for RZ/G3E"
+	help
+	  This enables support for the Renesas RZ/G3E SoC variants.
+
 config ARCH_R9A09G057
 	bool "ARM64 Platform support for RZ/V2H(P)"
 	help
--=20
2.43.0



Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17462C36008
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:16 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.55])
 by mx.groups.io with SMTP id smtpd.web11.34841.1741778772365524594
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:26:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=uySTlQfL;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.55, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keDCMPZIyR2pp1lNYjKPRkwN3QViQCQrG3XhP4K7UJcbTTOCumeFBa37wC2yPe0Ef0x/RBBxHS3L71Zs5VseWEMYhUyj9XPzDg3Kmb2qLz5Pf+w8i7U4+RpDDJOXhy0T6T0Luq6hiW3H+OytGx+Ms3SrbEx4WTycwYTqCAOYhLpDvfLZhXhvewMbmhbV3g9hT9S5UF8JC9OHaiMKqUSfTSZDRUGZOIuSJUJ/HJ4W7YzGBuTYEPhmbUb5q8PH6A6S724Jv7ROtWp72aRIkRbQUSHGOwnEtt9RgxR+Cha5liDyPro85h+SsaZ+W1ee94mjkwXczlT7D0QKpm1OzaH5Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crDAE0ZI6b0+YPVcqrha/Z2ZnfmkKSiRuy1+laohobM=;
 b=vvzbTw4UAY96j0se00BQqYpu+fXX2tRzjaaN1eRg7jaHbb18N4SFnyX/88eaT6F1Cu7TnBkpjoa6S4jU2yxbJCk8Fiu2jv65eFiCNDPmxxbX5jPw3yxQ9LziQ8nOw0rnP27TdQuY94xfzNv4JM+YhVM/Z77ZMFeAmLAfzRfgcZl0gSnQ0Yx5nmZphtjjiR6AknANJrafJiLfB+Rc5Gz1ZIjcu8tuRgu/dxHrUJ3FyabkNkkOuyBvnOHY7RqQpxZ06mFuWLUykLL8a+YF/HWW4F8y71ZHfMYgAWCct7Rjoia5ILTrk93izyMOUcn2Acd4Arv3t1vH7NpAOKjLWTfP9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crDAE0ZI6b0+YPVcqrha/Z2ZnfmkKSiRuy1+laohobM=;
 b=uySTlQfLRch5CuJnwjEApPlEHL23kNT33EDnwmOcJwxS6m5h7CmvUuX8bE3AEGgo5FwNjglU+e0YWwT0P3dI4Y7pN8RAf55A1JOI/a0LQUkvvjoe18KMhfkTM27OmVPl590rcHjAH2XoHHAEsFmnUzj5HGTR14fENqruv2zBa6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYWPR01MB10982.jpnprd01.prod.outlook.com (2603:1096:400:397::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:26:09 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:26:09 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 52/85] pinctrl: renesas: Switch to use kmemdup_array()
Date: Wed, 12 Mar 2025 12:22:29 +0100
Message-ID: <20250312112302.1605750-53-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYWPR01MB10982:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f165070-5d7f-4194-291b-08dd6158afca
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QbDAkWdROF07N5QFK8LpUefi/Ey1JJzZyhgKSogKixeq70X+cuSS8EuEcaRz?=
 =?us-ascii?Q?bxlbI8LXt1PzscrfgloqK9XLOOhUmYohtocEVafVGtvqSYMLv/5SxKtHzAr+?=
 =?us-ascii?Q?SHnYuQJVqi7Iv9Wc9/efcsuNznSQvWicHETgyRpSmdwWA/qy3jO8NzYYDPps?=
 =?us-ascii?Q?cdaLi/ro5pU6coGj+729bWnXVWF978eGM/a4gJvdoe5AutUdN80X6VzQtArY?=
 =?us-ascii?Q?nWLa3eG3vKT9KI6OtsrmKelPGGu+FHCiowSHbMAn2XPBq02ScA7W8xUpdega?=
 =?us-ascii?Q?jHKrXa3jFqJi6JYDc7nssjss/uJiGpAbiZyIZMljfZMi1rRIecaTgMf6llkC?=
 =?us-ascii?Q?CIZQwCS9F9eXRZO00yneCDDKUWwIA1MOY8lFqDEeWxgbm838rhQDEfrKNWWg?=
 =?us-ascii?Q?ggwaENVFldVPNIQMxzerpA6Qu5T5ElxAg+mYC8y5+yYbHR6j35BiDwMor3cP?=
 =?us-ascii?Q?LFRxuljzzZAPm9EIzzyKovhWL1JmnZa1yxHZRCR4hap0KiC/oUKzaitAsleL?=
 =?us-ascii?Q?pTuzUn9/buL472jsITf7tX2Q5SbwAwIgaR9HfOC3uAepxQmEBwrWGX5LniPb?=
 =?us-ascii?Q?cooEm1a8MqvhbOmRSNpyNdRvfI6wtHYpGceHuon025ubB/1Z4oxBqxRKocAq?=
 =?us-ascii?Q?8CQbmGaXT0MNptf+xjHmwBemDa1GZ74tq0Is4mgi47Qg+ST2a3V4vKtpqdgD?=
 =?us-ascii?Q?A2Rh16ffov77MV8nY/EUdck86Ypp1cgYHC9yflRZVWIdlY8VSuLEyAx+vC0k?=
 =?us-ascii?Q?wBgonFyIBsxyxykcuhzc5c/WTgtV5AsvDddtKRnM0hd63mof6BmylGYzYFtm?=
 =?us-ascii?Q?Xu4oT+9PbRxRcKRn4IZy48Y7hWGVJIhWVzv4aAAoSr+uF1H/TaEAjND79/ln?=
 =?us-ascii?Q?6Lc4HhC8CTKJtxxxwan/foWJiLaCHJQACpSof1056r0plpCb5IPVBwhguwU9?=
 =?us-ascii?Q?VrHbRXV5TKJ6O1bpKoMqdO7moRL0DPsiKR6Rlev1p1UeHUdJvGyu6EfLuuT+?=
 =?us-ascii?Q?gl0jVIu/H0Vj66oDhtg28h45cbCjYBZeLg8lNorD4d7H+GaEG/C9GLI5xIaC?=
 =?us-ascii?Q?PbQZ5h8eKxIHIGYpBadP6jB9uEYUTPwsWWa0aOS9AcZu7WzbImYbDVimnLiR?=
 =?us-ascii?Q?Nr3UwL6kn6wehoxzDMI4wamUG3zkPNPOKYivrrgPF13+in1BI7Js1BKcR0nm?=
 =?us-ascii?Q?biJ8lTg6BgNZD14bg+QWi3H1IdlYOZRNuo+4JoThtyATMX1x7mH3jiuzWz2y?=
 =?us-ascii?Q?PYobXz0wHjxNyitjwuXSBMcvFyPJbA5RVq1k4C5Q+yJDPLMijsGS9pAhjwzK?=
 =?us-ascii?Q?I9FN511pYg37bMwy7J3wWrHuR0uarv/3BDb1aHPQopcVgBy+90u2CdSh3hVq?=
 =?us-ascii?Q?1qBsHzEtUKSCGmu/uGvF9P+0onkvO12g9vxp1epNmwNhK2R7UnmIP4g5Z1ny?=
 =?us-ascii?Q?XP/fkXY/3nrdacPLUJyrGSeuiWyUoPwE?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Zj5kcPiUrd+HojANCNgO9DA+orxAok3FExXdG8EU86zMKRxsXj6k8Dghgub2?=
 =?us-ascii?Q?FWrdNiXzw/LAUuFHYvGfIXCeo+0RNRKN2jCEglLbV091b79ivpp6fItagE3F?=
 =?us-ascii?Q?uxEZuYDRfD6vwgPuLbWAvyKsuaE73VdFlfXDnIwdnmeSHe26yJQNHgs6oOEz?=
 =?us-ascii?Q?kkitvvfPhU3QograCupOBD2Q2r9TWhUH36g1ow1R6cip8qOhST4KyTQW+tF9?=
 =?us-ascii?Q?VkyL6fVxKHMzfZhgG8dQT8PVtS4iu7+t5hJVzNQvK0TFkFN04dm6lEcoHvhk?=
 =?us-ascii?Q?udxZ8wWqD2d3imxVUFSXUL4zzCEVEBFpT0hoQET+q7S7h75yDwbYA2Vf1UDb?=
 =?us-ascii?Q?wQWyWQwUk2UhMEPAvj4uxo9XdjxWVTQLfGFDE1NF9NVPsKHlwXRQLPCzL4DR?=
 =?us-ascii?Q?v1zj2FWAVaPV4HyDJVdkVazGmTGgezykqftWgsU42e3VxrXoTGxK8SeCsvg2?=
 =?us-ascii?Q?S23gyhIahY5Qr5sWKipXbKXecdAy/xsN1yxgkYo5zcNzxSHkro6Yq9ZNSUGI?=
 =?us-ascii?Q?KY4LSOwRUhQpSSQgkv5Uxc+S+I9TvW8jv9qWnK6xL9yp7Scigsh0rwqomN9w?=
 =?us-ascii?Q?5nZX9be/Bpf3JuSgEOLn+bXoWQI6upF4E1O3r5OnqR5umQQlANtFOSlEdy3x?=
 =?us-ascii?Q?MRFSSxBfD92XdNza4oze/SGWuI5O9XqIS2Dr1b7NDkAjW8h6FSBJ/HgbnvBt?=
 =?us-ascii?Q?Qj+oU+nvAo7jcC6/V/XbfMUPfx7OKznokCQgubS0Ve0tB/NObL+UtYcQb68r?=
 =?us-ascii?Q?UAZmdX6W0P2lKszHKfAEcdk9+yhOiMOxnRls0YtI2KzptcS8qb5d6cNp0EDk?=
 =?us-ascii?Q?lnHax4Fl5pH6ykrlkPV65W7nSHq4YXY4NVSg0RFrv/sZyYqfR00wmNC1XZ4k?=
 =?us-ascii?Q?eoy2CgH1eKv2C+AhPH7xw0u+hLH52urMJjSCQvDl7Bg5hqp1LC6dnHczgEbe?=
 =?us-ascii?Q?fQyb5F0l2Y62A4jsM010G5TJjnLnEpcGiOMj3FYlr2fAVHTSeK6CBoc2aETg?=
 =?us-ascii?Q?o4q8IIBAcbMQFRbn/s0n4BOaKWNG3W6gxOofWUb6XrUannpbeqzhZcuBzDdV?=
 =?us-ascii?Q?8vJFRKwc7VGAficlPRlAYu0oAGWsHXAbxs/2Y5YoTQP6dPS4nit4ragjVNLe?=
 =?us-ascii?Q?v1gjK7WABPPJXNsTEzaYO8DQDkmeBbdx78LmhtKlMLwj+j2JTdVw/oQ0ZqBe?=
 =?us-ascii?Q?2txZl8P3tp6mMn3fXPtWbVC4AyHWXXfA9nJFIgukRU/AQ69EXgxAyYIhGfEA?=
 =?us-ascii?Q?ZfATKATY+f4AUs5PSHEgbVNzwsqPcR5uNaWrglxte6QWaqiHnWdJb1r+fhy/?=
 =?us-ascii?Q?VyRFwRyVI6v80dWbO4mEk1QurqUiGmjHawOo3DEHLHZNZycWPWQw09qjxUYJ?=
 =?us-ascii?Q?udvxhKu9VZDHBPbTK9jOeIYWl+0w6kMQlheAb4XKpw4jkI2YySopP6wUT927?=
 =?us-ascii?Q?phw67vdsJVSs8FMt54ubXyar1AL+ZcMIA6wi9yO4ND+TB0HRuxcRzSUHe61u?=
 =?us-ascii?Q?4RBFstkRIbnkk5GLmrcoL63aD+oomysDN7jb9UR2H258XeS/OAUXdaxkzCIl?=
 =?us-ascii?Q?gW/ad0lLqmAltfoxWnDWVm6wEIMIko8mPsVP4F8bPD7ig1Xts8cfCJ/aK0ba?=
 =?us-ascii?Q?JwP2XJ89R4yaXtkB3+tMtuE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f165070-5d7f-4194-291b-08dd6158afca
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:26:09.4248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bk3YoX7Ztito0AJDEdUCP+HYFvbFWZSV/Y38h5MU8NueR2NeTQy4YMNEKUTHOn5qol8Kdd7ud+XEE72AHxsD2LfY+fkkYZxVGHUCwOd+L3pSTnaAclQ4ki5OEVBYiFR6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10982
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18144

From: Shen Lichuan <shenlichuan@vivo.com>

commit 5e633f572bbae9397ee50347bbe0529894de4137 upstream.

Let kmemdup_array() take care of multiplication and possible overflow.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240822061438.14617-1-shenlichuan@vivo.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 3 +--
 drivers/pinctrl/renesas/pinctrl-rzv2m.c | 3 +--
 drivers/pinctrl/renesas/pinctrl.c       | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index bc671807bad5..4c111fb27845 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -527,8 +527,7 @@ static int rzg2l_map_add_config(struct pinctrl_map *map=
,
 {
 	unsigned long *cfgs;
=20
-	cfgs =3D kmemdup(configs, num_configs * sizeof(*cfgs),
-		       GFP_KERNEL);
+	cfgs =3D kmemdup_array(configs, num_configs, sizeof(*cfgs), GFP_KERNEL);
 	if (!cfgs)
 		return -ENOMEM;
=20
diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/rene=
sas/pinctrl-rzv2m.c
index c2845f665412..32fa51abc2d3 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -196,8 +196,7 @@ static int rzv2m_map_add_config(struct pinctrl_map *map=
,
 {
 	unsigned long *cfgs;
=20
-	cfgs =3D kmemdup(configs, num_configs * sizeof(*cfgs),
-		       GFP_KERNEL);
+	cfgs =3D kmemdup_array(configs, num_configs, sizeof(*cfgs), GFP_KERNEL);
 	if (!cfgs)
 		return -ENOMEM;
=20
diff --git a/drivers/pinctrl/renesas/pinctrl.c b/drivers/pinctrl/renesas/pi=
nctrl.c
index b74147800319..0cbeb70c1d7b 100644
--- a/drivers/pinctrl/renesas/pinctrl.c
+++ b/drivers/pinctrl/renesas/pinctrl.c
@@ -87,8 +87,7 @@ static int sh_pfc_map_add_config(struct pinctrl_map *map,
 {
 	unsigned long *cfgs;
=20
-	cfgs =3D kmemdup(configs, num_configs * sizeof(*cfgs),
-		       GFP_KERNEL);
+	cfgs =3D kmemdup_array(configs, num_configs, sizeof(*cfgs), GFP_KERNEL);
 	if (cfgs =3D=3D NULL)
 		return -ENOMEM;
=20
--=20
2.43.0



Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15531.1794914931770418210
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:28:52 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=fF4bTSaa;
 spf=pass (domain: siemens.com, ip: 52.101.72.43, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vd7ylqQXGpfefYLusgfxqmXqjR62b+aUl7iKu4La0s8XhBsotFoeQsbQ8xEmXiLQDal6kvip/fa5xVFRy/3h7D4MMYw5t97GL6RppBnj4JHS5SuMxIYPlB4b99VEYJpndKyvtxz7Kl8xOu3Vou2BxIlyFtzSXjjFmajl/b+k35zo3MZGaSVIbWEggj+xFrdxUsN4B7afH2xwRi2ULzYa7bDHY2HFXlRmRxS1oJu8VmEOWAIMmdalzJ3SXflrn6OQ1X9T3I6fS2QoVbX169Z9tjstSYPVjfrnMJSJn8IpdlV/SIUyAxyIMcR0rSKysT5O1NT6TcaQC+OYH4YVoapvUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fG3/9xIIpSb39t8TLeTk1ztSiSL06/Invo9El/ADUyA=;
 b=rNFbWSCOUvZy+53MWWgugvqmGxY758ba4qhqvR6wqnX93TFo09b1LQvLNS5UWvUoi/p3YSOXkZL72K5D7OTQkEoM3J93DhhojK6MJQ4eeoagCpwsjXRtMSZOt+5lGcf9zJNn7jH+EFBJcdJSRYccQQVJhdyY5rjPzhOXYVadYDJ+44FYef+rzurnebfpGSp/phDsREClZGNhq7KuoEHLs+nNpm9tQ71fFUIEweQBr9xi5wTgKd6UEi8YkcdVBu8bCWrt2PbKCoSAxA3iLK6gWDIInIVYaZ99XlUR5reHKkgoTk5OK+jXPxub5ggAVn5gGBXvOkwyy7cwtQrwLnpSkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG3/9xIIpSb39t8TLeTk1ztSiSL06/Invo9El/ADUyA=;
 b=fF4bTSaavlZVvc4uQxrVdT62KsGPTsQcBBTlk97s6KNE8J/mmkepSA7FEsniUfJgbJXHtWR2JwXO4+TWvy/vPtzvcAanQ5VajjK8LjMrsGUqTVqVINtWXocg2puQ6IU6GBjGeHyVXIQOI2UBROvBM935CdQlrNu1MP1cqLs2sujhmt7cfTkvYWmizGldeG7vyDpdMbLtj6Ji4oEDniyOrJWGepJ/1bFXa9uhrfYDoVv+towU92r830IcaJKMlqZPawHUOZIXLxjxin3lnmhFodak5xpA+zTzD856QtiBtecj54GUQaNXdLj8/EYCcBDmgrsa75+pv9VJ4uFSLvbjbA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AM7PR10MB3144.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 11:28:44 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0639.005; Tue, 17 Nov 2026
 11:28:44 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v3 07/19] read-only-rootfs: do not mount LABEL=var from fstab
Date: Tue, 17 Nov 2026 12:28:21 +0100
Message-ID: <20261117112833.316234-8-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
References: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::18) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AM7PR10MB3144:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a0c0bb-8bee-46fa-5d54-08df449deff4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261022075727099003|11063799006|56012099006|261026140227099003|261028144727099003|10067099003|261022105027099003|261022115727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: D79E9EyWCHshkmd2Zy7HFBMD/58YHq3rBMX8Tp7/UeJF7gjimRvOy0WUoyRQQZRWJ8qNvrz3DKwg2fZ1YSiXhevKp2saGM+sGMi0luz4VOjDANcKhh+frZvcCSdrdBQ1r9QjM4BxSiipV4tvAsesq/SjOGAeKLD5EowhznGn8pcLtByPqdQ0a6Q+nhrpd6M+G1QoWFE7WbAT0/8n0pIbz+dy+Vfk3+45TPkOby4kGiGxF8nURZUo8D2IsQHwmmFZiAdp0Tf1EYzS6q7QTsCcM8XJE8dzAYYld9MhGabdd9BS8+jCzqvjzCNfQBtv31LF+FvfTy+q7RPI8GDkZXVTBXPw4LuWjuu7zmdn63GkD0q+ATIfoUjH++yydI9WIjzN8BpR8vca57WBxJRArIkdj/3De6bPOGR/5YnGoMUMVk7oUN+26Q6ILgg4GUkQkwQ6pH9Q9R5Uip+aOfEsPbNmi1NLiK9VQn4BxtEfgfwGacaU7m+8UcU3RqoZyGr93y/Ohiv0ph5/gNGtBrhTmsLwDi76XJd/6B/Caw/G3MLrV8+SteWlYD/iUKFyvTLMdgs5K1vcDog1lebxG2RlsKuzXLX/m7H69fexI68y2HTF6f96fpQAQBklPmbTXnx3SJkxfLCPudxJiZX2oDtI6SB/FJuRyqUuqUC27gzC/BeN48I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261022075727099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(261022115727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Milu5DCXBywPe9p6k1okSFMu1zLIbBRfMtGH64FC9MNtBPCHBQ/XDWp2nV3c?=
 =?us-ascii?Q?9QmpbSDFpk2kWOKFSGYjIcrqcVJRZaxX9NUr5F3VQ65ufkcCDa7ru1oXQ42f?=
 =?us-ascii?Q?/G9iN2KwfoCUi+eTc7jHEfv3bKgQ2WpxRSmNq8kyZM7Hag8cOoxXA7YsDk69?=
 =?us-ascii?Q?i2C5KZxUWTcaHgJmZVQ3wEdXWCJgYFa9hGIQ9NHeTO3G4WEEjg2LJu5uvlw6?=
 =?us-ascii?Q?usB6RxCpwuejdHFNrxa32UZnSR6fV6WHVe/GSZh62nCjxys2Q8ReZtyNLxce?=
 =?us-ascii?Q?qt1B2ajYrOUyoC74cQaObhzgoVLgz1e9/8UiLZrNuyVfvaCdbOYWPUpKZNI/?=
 =?us-ascii?Q?fdcCa0yK7SeFe8+hDr/6G6FhDa3sIekMItRZlGv1dbLwSpdU4LkCf0woy/G5?=
 =?us-ascii?Q?lDOg3yG8V+7JSitb32Hdd1Kz2l2rwVIF2GcCmb2mCmNxxAa7m1aI4CnRIw/K?=
 =?us-ascii?Q?6IP6kesOOPyMqtXfEvcmXY+U5W45S4HCybmXLaYjrPLZvKycmY746VnURax9?=
 =?us-ascii?Q?i81xDQDnOtYsxmaPbZMZOGKddCeUOpND1QlDxLIgLVD0bXiK5IuQFgsukb6t?=
 =?us-ascii?Q?UuwEDKOGjHMv/1kpEVEnwx0ExzUXubmp5Ojxs2EXTHlQ4+4YyTApYqKX92Ha?=
 =?us-ascii?Q?7kAeev9yxpb09lFSLmAjk2V+bh3WgpbhWOhuhmnJl2JtmDQcXzpNhbSlqUUc?=
 =?us-ascii?Q?nRVEVlStAb1XmKIYrCmaGUFnktg5Dt3cXeSGxPGmiIgqYsjc65eNsyY7ZTTX?=
 =?us-ascii?Q?V9shJaaP0/ZHAx7j77+C/U7DsJzjRdlB73HjDRyfyg0VHzeZaGWPIIA6/mPc?=
 =?us-ascii?Q?WOs4WVVcP/VOqKZcal3uSl/nOvipypbswruTUM1MqfQXIcaoz1scbqCxBWU6?=
 =?us-ascii?Q?VoqQd4sYUAB8aq90zTJsayNohRfdK9wWBlQxiInIkbFFG3kjFit2FXQXfknO?=
 =?us-ascii?Q?Zz/UhZrvnL6yLTphrwwW4LHGFRptRw5dvDKGQRd7qG/0KxmeZzEzOHSKvMX2?=
 =?us-ascii?Q?AsYv8clGc22Qgz+WxFKNnEG7uUed1itr8f+GP4k6ECPXGT8tm/qnAiXGNS+b?=
 =?us-ascii?Q?oWoMkEkKQ28tvZMBqlzg5LM2hUS+8K0hWDuFqGuPL8G7982I5ExWv18+/K/R?=
 =?us-ascii?Q?zS7t6UpJQe977dXtP5VpY0mMLo1YoKNCMOSQzva3yUrDArLrneyK2Cof7YpQ?=
 =?us-ascii?Q?rxOG3Nwi7zJr3u8lsdkgImxiBJ0Un7OivzKb8DMAtFOtUvZ0ba169rI5uTkO?=
 =?us-ascii?Q?hvfYJ5sT6Tt2JLx9wk8Fjsg8oG5yIgO5O7jpEGotA8xm0A4/C51hhu+Za/x1?=
 =?us-ascii?Q?ff45TnzV7V/JxLDXomi7F/gYCiY9/DgLA2vTi/F6BBGkSXMuuKFu/2LOdE8+?=
 =?us-ascii?Q?n6yuICq5kAEmh/ODbjqapxD0/JMbLBhpHrr29UEoLl1g+/wROr6Mte+/wsuX?=
 =?us-ascii?Q?n/2ZIkVJOP78NTzAyZznUM7lAre/IJuwqWf8Lvhn19yf07fryDEuRgrd4RcP?=
 =?us-ascii?Q?AoT8QyCT9KH6PynhtfiyR4VlMatCYYvNzCRTPV4WUM4Rq5Ip/uic7F8bQa5L?=
 =?us-ascii?Q?XKra/4pqws9RGF/CTqXgK+Sq6jv4qDqRZ4R5e0VhPM7DL4X3cMoEoq4JgVwL?=
 =?us-ascii?Q?Vct7V2EEEymI9bZNbN/p8l9aNQfuHoCyhMbVF+MU8aN305sZD6AdCgx1QY/S?=
 =?us-ascii?Q?3uAdPvKYXWpm++gWFR3HoZ5zjl9eFy2UT3k60aiskwaRlWgB1bcK7hQJCpBa?=
 =?us-ascii?Q?Hi7zWRO8TDp1ssIsBVINefxP5jtZWtU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a0c0bb-8bee-46fa-5d54-08df449deff4
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:28:43.9914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bsSIZgK+mMHPydtAza54xxNVBXMJ0p1HspMNZQWIThRAJ2tFET7zWGXuurF92t/nYdX3DAapf0DImKEf5YeIxJK9u073Q5nUoSrZXNJovts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3144
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:28:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24824
Content-Type: text/plain; charset="utf-8"

The initramfs already mounts /var, with different options than the fstab
entry. With initramfs-tools the additional LABEL=3Dvar line is merely
redundant, but dracut fails on it, as it is incompatible with how the
initrd mounts /var.

Drop the line; /var is mounted without it, and it is easier to reason
about where /var comes from.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/read-only-rootfs.bbclass | 1 -
 1 file changed, 1 deletion(-)

diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-=
only-rootfs.bbclass
index c280ea23..613fe6ef 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -98,7 +98,6 @@ image_configure_fstab() {
     run_privileged tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
 # Begin /etc/fstab
 /dev/root	/		auto		defaults,ro			0	0
-LABEL=3Dvar	/var		auto		defaults			0	0
 proc		/proc		proc		nosuid,noexec,nodev		0	0
 sysfs		/sys		sysfs		nosuid,noexec,nodev		0	0
 devpts		/dev/pts	devpts		gid=3D5,mode=3D620			0	0
--=20
2.47.3


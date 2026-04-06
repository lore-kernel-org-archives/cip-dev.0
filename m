Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0BBFB5178
	for <webhook@archiver.kernel.org>; Mon,  6 Apr 2026 23:18:24 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.55444.1775483669219319567
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Apr 2026 06:54:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GHvBflBo;
 spf=pass (domain: siemens.com, ip: 52.101.66.6, mailfrom: sari.sercan@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phf7oEoXes09Q47D9qxhSu39xXOqoLZVGu/bpk8JZwrGKsaVDsOYGnIH2AQCs/3kC7s/HPqxKchI8PX5xp9pNPSJBg/Sq9GK1j6UixRQRva3558zlZSTntvjoBrDhIiV7F8WOjy/IaA73S8hwiLuo4FYg26qf/7+EYoy3imXJ6s6V55kGm/EzBQL9C5p6uL5H4IW/ncRyZHv7Eo+vvg4p27uacnCcn1n0LAf3sZXkP4xqgiK9NvAeUjZz/QrDtomSHnFYa1ezhWs3Hg6p6ojRnVq29NJ9aSRGvBQsRReCPlwZq8qCDPWKFCo+RCnhfB28Er/13a20zYrMS4lP4Z/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFAYGtc8E5cVS55MjNHpMOyV8k5NF0sTrAHi7z8ZeMU=;
 b=PYmKWVJb0k535FAXGDp93urtdxL9wPKjP/en59k7wNLJls4lHoJtkvjaYup2NxEnbhl0tw4qE/ZiFBxD3XMPEMJP9bIjhnaQx6lgmEtBxzMQd1QycdkNz3ewHYf8RXYPOiY/7vwbw1NOv/Qdij2foEdt1rzPnmiRGtDwFOfTxng3AudSD++0ZniZw6DhfrW3Tw11OxEtZVLa7/4VYS6P7u8PATsKzkU0mDKcVEXnRXQwCnPkHd9jX4Pgt7nO6/f9Qxnwk1G8ojcUyfNDhtWpNNLWm/BeM84/3hrITi0BekSp7uQqAurrc6o0c45xmzjFakPggZiBcT45ESgUZtNGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFAYGtc8E5cVS55MjNHpMOyV8k5NF0sTrAHi7z8ZeMU=;
 b=GHvBflBo+erqHwFqFRS6qcASa4hNbDRLl13DQ11zQ++rx2kBAS5WfQN184e27IiVcyY2N8ZjUCYeJd1HOfSA45RQgGer9QGAUHlW0GtbY4ev+gW/y9dFt5zqZqwqxFklk2n62DykT7eG1XcBRSBQHI4TKQBpR4d50HJEEEIpH97JAOHvpUp5YDC949CD3Sc4BimCxnMxQxbcAaM05l3e6oOJfj25txxeyPfdtY0YFixRXbabv90+Hm9QuViVTVqyUFvNVE3dBO1KkJMQjwECht+NK1EF+JRSxMAkTSyM7fnt7oCSrkvm/fDgIksHPSAkzW+XrUOa/oL13N4R74Y1Vw==
Received: from DB9PR10MB6643.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d1::13)
 by DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Mon, 6 Apr
 2026 13:39:53 +0000
Received: from DB9PR10MB6643.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8117:18c:aa5c:aeae]) by DB9PR10MB6643.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8117:18c:aa5c:aeae%7]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 13:39:52 +0000
From: "Sari, Sercan" <sari.sercan@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH] encrypt_partition: evict stale systemd SRK handle before enrollment
Thread-Topic: [isar-cip-core][PATCH] encrypt_partition: evict stale systemd
 SRK handle before enrollment
Thread-Index: AdzFrE0U1CjmWJSZTSmRfxe/rVshUQ==
Date: Mon, 6 Apr 2026 13:39:52 +0000
Message-ID: 
 <DB9PR10MB6643CE84D750B5014B3606DCF05DA@DB9PR10MB6643.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: tr-TR, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=356ddcc8-5558-4384-a453-c92e9cc3762e;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-04-06T09:55:48Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB6643:EE_|DB8PR10MB3706:EE_
x-ms-office365-filtering-correlation-id: 6304e4b7-fe9b-4d6a-f3f7-08de93e1fb6e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|55112099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 
 7tfQhGxvq2uIwofnRR6f6GwgItVz6TNbu6DgCZrzZS5SZRN1y40IqI5MKCQYm+eKuzp4H4MO/4PlgY9h9eQuBSl0UdFRbE2ZJxWYlui/0hdFOfXhdsgU0fMFPYnzHyf/9gk4/eBkNyZ5ERoTf9JEycagF3MIdhgLeJod8GrlPAMmqLrYMg9XdLUwCvqRKgGAsz/j/Vju+dnnCE1TnI2ffZQwvxDbK0i9mmlCOEnZxSOokz7ZwVij7EjGVaIQ+Wmww51AaeGxCiw8Az/VhrQcexMs1Sw4L4Q41ZhiMSpwar3L6xjWyOZvnjw4WwI5dhoP5JkdajzpneQiNeBnE55nS4DJlI6gD/DDEghzpDvKRpOH9sGr91kCyZlEZUDyAolQ27nnGOLdZef4voY0mGYVgDFnA4HTgR6VB3sp1anTlIPLmg2AJcWVgY3ez7tRXUmjSTw/UwvKGiWHFswgFp7m/uvr1CQgTVG9sRzcwnKMXpCZBM/SbQITQHeYx5ZCf2qCARggTz7JKEY6kqmCWoZv+gc06CSxAlEhP3a0yVAQNCDodueQ9jUvfXKNDhlNhaqjOHB3j4VCT1gn1pCARXnOhIeqA/2aoBKAgY2IM9pbHGB9WjQGWE0yhOSGkW7R1afVPRNApRqbKI0QKSKXP0NYpnrjR6Yx6W5JMqxAGId7zcE4AUHJv87Hqt+7gV9YFZiFcgR4x3M8tDe5c6w++9skLdhFiTwFCdorR+9e/YS5GUtIC9+Z97SzUNHu1qypA0qQNYBPpI+T2q+nV4uUmEn3EzDLI2vF6rNrowLcr9ZSd1s=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB6643.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(55112099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-9?Q?d2xkAegZ3mqsKZYxQ2D8ny0SyKoVQzce+OZzXBYid1YQeKhsvqIvteOS3m?=
 =?iso-8859-9?Q?0B1mm2xU2v+f3mPDhj6IcJIVFblV22di0RyfVSEJppKcHr4RPPpdHRpV5Y?=
 =?iso-8859-9?Q?+KFDtMbUy6sJMlFosCSgE6BJJGtrttJHM43Lvk8PUF1lzBHhnOQMm8RAHc?=
 =?iso-8859-9?Q?FTx0PcUBY6OZoUGlUtKTY1ATKNt89kMxTqXYLAmoYZR4n7d0fs2YmvAkyV?=
 =?iso-8859-9?Q?UNZ0N/8S/gl5WC/F+vfC7aO159wwQY4hKitwz8p5WyAOBADaUhW2qHAu5z?=
 =?iso-8859-9?Q?bWFQD+LPxSe3YlKKZhxmzFqBIpFjF9huyGCHIHWPAJbsuOgzKQvZMczyjx?=
 =?iso-8859-9?Q?sF0Lq8N99K7hwho2lPgXEjURhL2zP2dxKsANTUTphzfgbncqAi99mu+smN?=
 =?iso-8859-9?Q?XGa4iQWYud5wzhreEPf1KykABFAtwWxwT6gGH8zQoVaYxbok9qmzRXH4V+?=
 =?iso-8859-9?Q?UmY7GBL0h4utrQpF7k2/R9KxdRLZWKZzmmwSLBPDK6lbb5DEdGGHGt4yek?=
 =?iso-8859-9?Q?5/PSsmCU8C5gCzj4lnHML4fgLcmbn0oKGZHWVTAh5uRxi/9/FRovkS7KPx?=
 =?iso-8859-9?Q?CCvlEAhPqs8BT8nAPAokcnLHRCwUHQCh7PJ27XcEHwHfDqNJ1yjVvGkS+W?=
 =?iso-8859-9?Q?2ZsrkmGHQPQrvb4xGsJPegrg/Y1/jER5ia3AgYZnJ/8EcTqVyQrlBNfemv?=
 =?iso-8859-9?Q?f6B7/J1/ROyKzVXPWhTYSs/4lNhg66tRq/8fV3fx+Bpo/LugYzEkpBvIKL?=
 =?iso-8859-9?Q?7QoozthdmyF1PsxlvNmV2rahzJmh09sHfUrnnaWXhNk36h+N4GbfOriyHv?=
 =?iso-8859-9?Q?MdlZTaVFWXaFj1tAsX+hS25TpLB12Q1gI2a3AuqLrPvSFBAPMa8EBKlk2r?=
 =?iso-8859-9?Q?I5b5BOzDnun7lrA9V5Loyd7+jn0lX3KCvVo1ZUUf+tZo6IAbD9uTX8OuAQ?=
 =?iso-8859-9?Q?X9XP8Apd95e+gbiYCaNjPgHQqDmTsohNZs7nXAUXm/eRtwNmp07Zq0QyAd?=
 =?iso-8859-9?Q?ESuExe9o9LSHf+bke9DDTeCnG1pyDMynLpP5KXd/IWGrS8wL1pdAQYMRtP?=
 =?iso-8859-9?Q?5YDLPnjfw5xIimQDm+yv4p588sOQMqWSx5NghfkwYvwBoU+M/aoNfRKNkO?=
 =?iso-8859-9?Q?U9USAOvwu49M6OUqPTFZRUhHlwDueBLfVe4PsTvK5r6prulWI0OgVFg9rY?=
 =?iso-8859-9?Q?q30GgJQ0TzQnQNSyGen61EXKjXlc4FX298hwII+0y/nTH6cC3aO3jpw8TZ?=
 =?iso-8859-9?Q?/Y6EFBHRPQY9JxCYxs9/QQ14NCf51bCECPrVBTTyiF/iuv2XV/7yL7J8pk?=
 =?iso-8859-9?Q?RQU1CGWNTokZLeh57Ek5vzLC7FdG/VrmTEEYzwqjRvDzBlDQ2dyIsz77L4?=
 =?iso-8859-9?Q?PrpPFi1VhwUGaArM8mxe80uBIej0MEi2tFKMjGtuOUj8MPelNx8Wx7Bgdz?=
 =?iso-8859-9?Q?IVr+QmPKiYFJwSaq2xJu3FAE7eVQUiQq3QOYo9ndWzU/sOlaC8Q+Fas58y?=
 =?iso-8859-9?Q?csMonpuPhV2Tms9bWLZIt0FLgsiTrLPlUnPVxNk7olRe2X+DyPth6bHfke?=
 =?iso-8859-9?Q?r8LSr7bPC1tMc4v7UY3QlSlX8pQPe+qgAMpIsC76qwut20GK5Jg4QNLpou?=
 =?iso-8859-9?Q?0eoKndttLeT6G1CGzPrhBmyWfWZVyIKsDC4inN2ENLNlkntLD2gQFhYJPV?=
 =?iso-8859-9?Q?zYGZd9IFJ7ryeNokySxXNvrxTpBK5w7szQu/TXjMkAzM7WXYnQobDbvEUF?=
 =?iso-8859-9?Q?IVOO71qGT9K3N3c35vmKio72pnraa8UBbToQEunSvKDbc63cYl7ohDP7r+?=
 =?iso-8859-9?Q?ZMcSYjX2cQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB6643.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6304e4b7-fe9b-4d6a-f3f7-08de93e1fb6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 13:39:52.8405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 25yQuGw791xPsOXXmBEJm9M9zI+cM6gQnDRVsPAqRjOh0WydAt9Tljjrk1IMeyiAWVvqTrv/kW8wuxGqkAqa5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3706
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Apr 2026 23:18:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22619

systemd-cryptenroll persists its TPM2 SRK at handle 0x81000001
evict any stale handle before enrollment to avoid
"Failed to seal to TPM2: State not recoverable".

Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
---
 .../files/encrypt_partition.systemd.script                   | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_part=
ition.systemd.script
index 1b7c83b..841219c 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script
@@ -26,6 +26,11 @@ enroll_tpm2_token() {
 	#tpm_key_algorithm=3D"$4"
 	#pcr_bank_hash_type=3D"$5"
=20
+	# systemd-cryptenroll persists its TPM2 SRK at handle 0x81000001
+	# evict any stale handle before enrollment to avoid
+	# "Failed to seal to TPM2: State not recoverable".
+	tpm2_evictcontrol -C o -c 0x81000001 2>/dev/null || true
+
 	# check systemd version and export password if necessary
 	if [ -x /usr/bin/systemd-cryptenroll ]; then
 		systemd_version=3D$(systemd-cryptenroll --version | \
--=20
2.25.1


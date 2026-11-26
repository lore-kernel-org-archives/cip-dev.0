Received: from TYPPR03CU001.outbound.protection.outlook.com (TYPPR03CU001.outbound.protection.outlook.com [52.101.126.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13911.1795700146775552875
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 05:35:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Zj1YxOWH;
 spf=pass (domain: siemens.com, ip: 52.101.126.46, mailfrom: badrikesh.prusty@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G97swNbfbjmm/XuEuA7zPUh71W14IClNZdpRmH6kEFft6ZxNGvMC3Wpb2SEZ9XGFxncur0H/HHVe2t7k1LRLL8jVRLrEAJQTI3rTqJ7cqZxYHJF45s3Y2slBkYStvtF+/CCrmc/pMCMSbJ02y4N5IlotHrxgrjCCoyOv8FunWDoUsvu1nHnJE6Bj8Ir6qDv5Fwv/+s+K8073P878H4XMC/34n6UPapYn70IA0pumYAD5JvMAaKH8yi0jP9FrdEloU7OnUkYSICThEvhvPUuDqQYOweM3RssQAREd+pqXZV0FoSq7fNY4o5ePjWOQxBz+WRNy5RYIw3eYfaq2Uoj1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgrmdPEqlMYiOL3YtObbIqbwG702Y0QQuMsd64p8bqc=;
 b=a0Twub1bfSvwov91u4thSCr7LnuATsXeHUV4j1ZycF+mRyxLr5uRkSEO3g8vanibLXU0Etinr+SK2kUic7dDeUkpLtr+9j44NUvviKhjyu53C9pCD2GMELDcnQuIJ3NL5pPTA9SXzRl6LuwpPnQHqTihsljrHgIja5S0kWQ+MV5YLY9A//AfLvjJEJk42eVVB4KdBKMKIL1JsfZvmTnPM3myCuB0981hW5SBfbKcy/sRyB3CGm+YVG6sHUE6MsF9UbqQuj4XZ5h3akA75VMMSjChZ3GCR8M5We+zlEn3+zwExeQgNkdcEZKO0VcGuy4TQPK8cZX/aznxB0u5tziDlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgrmdPEqlMYiOL3YtObbIqbwG702Y0QQuMsd64p8bqc=;
 b=Zj1YxOWHaByuVV1dLq+YJmqzjaTmRXvA60+yMmjCBJQbbRTKGP5Y00r3eL6EN/CR1z6lHX7HsqSD/7Z/JkQNlRZ2jrjXscl1Cj5eUEEyPXXaOMaxyrc8I/qnG4voql2GaT0Ew/g6pUQE9p8jh8S/I/ZQrSoRevc9PNx18gajbGbmltF+EnZ+h6NaCMGX5m18GqvWAOz64+4YLTJp6AwWed7RVKQ8fAnejxc0x4Xue9+53tykKJoJhhPfKLUSbrzIWD6IUOdCX1Y64eyEo1uAXc5EJ0Y7t/wBlmef7YtL2yp4O68SaWFywaxm4GcWT12yHRk+ktjvM/7HURPGQpjWjg==
Received: from JH0PR06MB6656.apcprd06.prod.outlook.com (2603:1096:990:2f::7)
 by OSNPR06MB8345.apcprd06.prod.outlook.com with HTTP via P2P; Thu, 26 Nov
 2026 13:35:40 +0000
Received: from JH0PR06MB6656.apcprd06.prod.outlook.com
 ([fe80::6009:8c68:86fa:d195]) by JH0PR06MB6656.apcprd06.prod.outlook.com
 ([fe80::6009:8c68:86fa:d195%5]) with mapi id 15.21.0662.001; Thu, 26 Nov 2026
 13:35:40 +0000
From: "Prusty, Badrikesh" <badrikesh.prusty@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "Prusty, Badrikesh" <badrikesh.prusty@siemens.com>
Subject: RE: [cip-dev] [isar-cip-core][RFC][PATCH] swupdate: deploy
 SWU_ROOTFS_TYPE artifact alongside swu
Thread-Topic: [cip-dev] [isar-cip-core][RFC][PATCH] swupdate: deploy
 SWU_ROOTFS_TYPE artifact alongside swu
Thread-Index: AQHdfal330Pd3+5H0UOUYaNl/itQQLdAWGKQ
Date: Thu, 26 Nov 2026 13:35:40 +0000
Message-ID: <JH0PR06MB66569C8B9C7894C0642310F991422@JH0PR06MB6656.apcprd06.prod.outlook.com>
References: <18EB9B2411C8B34B.1905714@lists.cip-project.org>
In-Reply-To: <18EB9B2411C8B34B.1905714@lists.cip-project.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=55ef5bf8-9429-49a0-b86c-782b183067bd;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-11-26T13:27:16Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-traffictypediagnostic: JH0PR06MB6656:EE_|OSNPR06MB8345:EE_
x-ms-publictraffictype: Email
client-request-id: a40c703a-c4d6-4662-9658-2b27ddceeead
request-id: 37aa71ac-0749-4408-ebeb-08df4bc2298c
x-ms-office365-filtering-correlation-id: 37aa71ac-0749-4408-ebeb-08df4bc2298c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261009223027099003|18002099003|22082099003|55112099003|4133799003|10067099003|56012099006|11063799006|261102123227099003|261028144727099003|261026130827099003|261026140227099003|261026135527099003|261026121527099003|261022105027099003|261021133027099003|261022075727099003|261021135927099003|261022115727099003|261022113327099003|261021123027099003|38070700021|261021121427099003|261021130227099003;
x-microsoft-antispam-message-info: j04/jVhZD/5ClGvPn/GXwSJ537rXdmYHP1Sd8TJFAneRhNczb9olxrERV9rOgv5JP5vXUrKQhnP9oqvpReo90FTOQNlR3zQ6FLSofs9PBBDaN9VeHJnG/VQQCupkW7qUIdGSIsftXLXzFVfC5CeepL9kabNdjUDPFCwEkenjzDlL92y6JGAJdtpkM/MphGx6ST4wZ1c0veInaWTCU09OeOw128Yvh7P4Owk848a87yK5ie6zv22Qojx195Nttc2urtrwEwnbLSPZYWzlbR/DJWTYyEj62GLzlSoXZV8Tbr9kQCHZ4bW2UW8Mjk+bQcRzbj05DBbW1sZDw9Tl/tRMtzDmJDDAy8UzyDzb2XfuD9wBBX3AYoYHIJ8VsKRGOztDCyjZGYzRTeUSei1+py2ehiGj7pFoJ6eoiWY65eN1JRarbWXwCGCDMNyk1nFnEqW2fRDRPrero+HbKDaAp9q9rbZp3HEKyh7YngVoMqFgajdjCbSp/+hbbF7aCa2K0XE1suhx3WbVKLtpnN8TMj1dpwibYdplN9ICivy4+X1KnbIcscEewwGMIEXRZOGJB/9DL31c8ibkkVZDMoPdaHTFxLSbG5Z7QHv2VeJeJQ+aacqsT9LMYfg/2BbM64BjGryYL3Nam3Up5ijkVyqvTRAZtZp2QuifRN1wSseoSPuI7NjSR1+8cMrWhaZ5uHKrm2LFJcZHtTlTFD9jpvV+fHM7cC8B2PP45vlxgEI19wY3o4o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261009223027099003)(18002099003)(22082099003)(55112099003)(4133799003)(10067099003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026130827099003)(261026140227099003)(261026135527099003)(261026121527099003)(261022105027099003)(261021133027099003)(261022075727099003)(261021135927099003)(261022115727099003)(261022113327099003)(261021123027099003)(38070700021)(261021121427099003)(261021130227099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pUPx9nnmk74kVIVP901DjLtu+qpoRe76clmGAyRSuBz+Idzddzhy0oOUiCSD?=
 =?us-ascii?Q?VQ5hD8udiXEjpe1sy4Oqo9wZ0byMrDnmZ3mD3tRaIzL8NZqP8EV1nKhz9u+z?=
 =?us-ascii?Q?mOGlarV0A+AZcZC9TW20vTj1cAO3ok20SjZpNtY6wGfdqsjuBEPGzCkE+121?=
 =?us-ascii?Q?uSeoJ0q44HlVmREuflQpSgIvNNqrlz6rjK3ODczvjrACc6xNI1MUtX2paq/A?=
 =?us-ascii?Q?hheWMK5rlC1+ddWEGqk42F9x3QsG+UN0ThOlswTnYqZAWUPBDh4JXaZUuIg4?=
 =?us-ascii?Q?kryjoIxLkEbXIgF/Sagt58981zw/rOR9O1w4y4UOeZ91H1fuQDbLfvsIAo3D?=
 =?us-ascii?Q?Wys/P573Vvbs0i+J4010AzVy501I2bgnKAPJ7OtQGdJkynDejCYPQ2WvTzIG?=
 =?us-ascii?Q?nO34+4f+JL/YVYLEEWMLaSrdk9DOmEx7KRcF5f6E2Mz+nPKOXy7osN9ruYsi?=
 =?us-ascii?Q?nHlgsVLfvizCdc0VBQ2GEPjyi3BFdPhxWX6+HE0SpESMZEQS8EkKg+JC1EDz?=
 =?us-ascii?Q?oKMrcqBMj6NOUcUUpBNs6NAsmNC7w1K3E+R3vMU0vCmqHDy0CpeBgQplWI1m?=
 =?us-ascii?Q?njn3l93d8yKBPhBPLAWoVn/BDwbaYSL46uLwU08VUjaYNZlBjkbuSgFPxBl7?=
 =?us-ascii?Q?1cUFLudLXPVCWpKOsw95NmbEflbkw/MZ/gMBkHwRJaT7u9hCuVs7OHJUHGAt?=
 =?us-ascii?Q?HOipXG8e1YQuqC3ssFykPpGr+SaTmcRSQVSYvDNYTwOI0F1Yek7veFWlynLG?=
 =?us-ascii?Q?FFt9CpdBCJa3IrUdPh/Cwx0FmFTWGfX4yWZ+747mZZKofG4DwYOZ1eMwltgZ?=
 =?us-ascii?Q?7g0AVQ9gQ7ZkMBY43fykLWkhNwNrqTdJu0mIzsoj3DF0t83AfQOlCCwKwMGt?=
 =?us-ascii?Q?EQFi+poIbaMEDp40kwP4MJXP18iL+zvNVwRb0j1MBzh13IeoVLolVwpu0IN/?=
 =?us-ascii?Q?ClXjZ84beqcetj+LJgs/PzZTlSC6IzyHmkQF05JeMBKi4z1Uq03s5DcZi7GC?=
 =?us-ascii?Q?qq3hb5/HqHNBVNeUN0WnU/mbt4jjdPBdwrGBZcORtvJ7it/trwg8EyCELGUM?=
 =?us-ascii?Q?x62mhg2FBK050SK6uHV9Y32saMyCJbLwaOmU7BoBzJ44BKg2qAWx70HqMFJF?=
 =?us-ascii?Q?5ZU1qeI3kvotufBDt3lqhr9N2CeZAlvcO7MyCmqF48Awupc/T51fFXbLwoQ8?=
 =?us-ascii?Q?Jfy73IwURQIqe5hee79s8rwQAh2/qG60YnLZpr8yYV6r1HUXe0uxi+xb6oT2?=
 =?us-ascii?Q?5zIJ4mA9Qp9j5vzqOeEbO7Zf/oaJLfjSqvOS0Bdbr78ciQ+DOB/REvhgj0Sy?=
 =?us-ascii?Q?8jKIQ2IILPK8tJMKp+Ij04pNNxwPkR5lZg2bNWRqYwVsv4ZpKESHHU70gf4G?=
 =?us-ascii?Q?zuJZ5RKPpMKlA4ClpAmQ52QxImy+atg+LIZt/t9DWMNug8eAnNo8IwBUYlzZ?=
 =?us-ascii?Q?dV9DLLztGFUZ+nZddGzI1YNlF8oGKiyv9gPZYtIJGOGB3ZHRyVAOrryYHN8h?=
 =?us-ascii?Q?ibOk+Z2qxvdunls/YqcblVG04Q6Q2a/kWvPP6BulaekjYDh33owiFiBk+w33?=
 =?us-ascii?Q?hk7s4prDZJsvzwMaixRFrqtYbhXUPN0bPKdRm9fJ3/Ivb+bKCR7MPyH7BF0Z?=
 =?us-ascii?Q?n9lrkmTc/TD2QY6T2kDMUenNHuhSfjrxqKN5rCvFx91bUqvhuBUBCQZ+v5QG?=
 =?us-ascii?Q?eQYeA+nRnQTux9lbbKI3vypoe36Bjoiq0sIYaKjwtzp5N7IM4I764alZ3UPT?=
 =?us-ascii?Q?w2Etl8kmrA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6656.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37aa71ac-0749-4408-ebeb-08df4bc2298c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 13:35:40.2585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rXS2bTF/fWA0nGasf0zvI4xgYk3XPxRNHuuJl0U4wjvIRIc37I3QqLDLVaZY4hgfHJ98JRJuaXPafSupF1tq/WrBKDNT0vTtmRcVgcRT0kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8345
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 13:35:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25106

Hi Jan,

In meta-lx1, we updated to a newer Isar revision and noticed that .squashfs=
 / .verity artifacts are no longer
retained in tmp/deploy/images/<machine>/. This is due to upstream Isar comm=
it 63935232 ("image: remove
unrequested intermediate image types"), which cleans up intermediate image =
types not explicitly listed in
IMAGE_FSTYPES.

Because recipes-core/images/swupdate.inc currently only appends swu to IMAG=
E_FSTYPES, the payload
image is treated as intermediate and cleaned up. This breaks delta update b=
uilds, which expect
${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE} to copy from DEPLOY_DIR_IMAGE to ${TOP=
DIR}/previous-image.

Since isar-cip-core is currently on an older Isar commit, this isn't visibl=
e on next yet, but it will be needed once Isar
is bumped. For testing I used:

```
diff --git a/kas-cip.yml b/kas-cip.yml
index 13251a7..6b03ff1 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:

   isar:
     url: https://github.com/ilbers/isar.git
-    commit: bbb81cd0eec51f224123efedcd7cd7c9f610a7e7
+    commit: aabb66eb0170bcd623ee4987472afebbcadf8f50
     layers:
       meta:
```


Please take a look at the RFC patch and let me know your thoughts.


Many Thanks,
Badrikesh

-----Original Message-----
From: Badrikesh Prusty via cip-dev <badrikesh.prusty=3Dsiemens.com@lists.ci=
p-project.org>
Sent: 26 November 2026 18:54
To: cip-dev@lists.cip-project.org
Cc: Kiszka, Jan (FT RPD CPC) <jan.kiszka@siemens.com>; Prusty, Badrikesh (F=
T FDS CES LX PBU 2) <badrikesh.prusty@siemens.com>
Subject: [cip-dev] [isar-cip-core][RFC][PATCH] swupdate: deploy SWU_ROOTFS_=
TYPE artifact alongside swu

[You don't often get email from badrikesh.prusty=3Dsiemens.com@lists.cip-pr=
oject.org. Learn why this is important at https://aka.ms/LearnAboutSenderId=
entification ]

In upstream Isar commit 63935232 ("image: remove unrequested intermediate i=
mage types"), Isar began cleaning up intermediate image types that are not =
explicitly listed in IMAGE_FSTYPES.

Previously, swupdate.inc added ${RO_ROOTFS_TYPE} to IMAGE_TYPEDEP:wic, but =
only added "swu" to IMAGE_FSTYPES. With the upstream change, the underlying=
 rootfs artifact (such as .squashfs, .verity, or .erofs) was treated as an =
unrequested intermediate dependency and removed from DEPLOY_DIR_IMAGE once =
wic and swupdate completed.

However, delta update generation (in delta-update.bbclass) explicitly expec=
ts ${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE} to be present in the deploy directo=
ry to create binary deltas against previous release artifacts.
Explicitly append ${SWU_ROOTFS_TYPE} to IMAGE_FSTYPES in swupdate.inc so th=
e payload filesystem artifact is deployed and retained.

Reference: https://github.com/ilbers/isar/commit/63935232
Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
---
 recipes-core/images/swupdate.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdat=
e.inc
index 699c961..bbedbdd 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -22,7 +22,7 @@ python __anonymous() {  include recipes-core/images/swupd=
ate-${SWUPDATE_BOOTLOADER}.inc

 IMAGE_TYPEDEP:wic +=3D "${RO_ROOTFS_TYPE}"
-IMAGE_FSTYPES:append =3D " swu"
+IMAGE_FSTYPES:append =3D " swu ${SWU_ROOTFS_TYPE}"
 # input is already compressed
 SWU_COMPRESSION_TYPE =3D ""

--
2.43.0


Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DC3ECAAA1
	for <webhook@archiver.kernel.org>; Mon, 24 Oct 2022 12:29:07 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.50])
 by mx.groups.io with SMTP id smtpd.web11.18528.1666614541837448079
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Oct 2022 05:29:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Dp1IX6Vt;
 spf=pass (domain: siemens.com, ip: 40.107.22.50, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iljluCQqEOqugnndS2SqYK4f8sQOZuE87B6ybeDyxWlpKebHvR2Pl6v94997Eu8Qaqn3CCfCXqikRZqWin2Y7VOKuY4VP8Bo5u2OJYeCbVVWE8+F5G4k28oiMgRadYp/pDWnHXbaCw/njHqj65S+bDkM6f6K1nupDwiOxBNndoREtfXZIJejPi7hLwxy/w/fkgtBjN+mNdif3u1EMnXxxbeJO/22mrOXYr4LkYF8hznFrkF5UnnxEcjIIyYzrVz3/K0oaPquRkW/xCH0v1S7vs+thEDBs4L+n9FWISqm+yEB7cMR7zfN1XYf69cxaLATVNrMhzIQzMbQr9pdxb2dVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uswttgO+ANoZLnR3XGKcwIA1oHvjycnlkNaUJrI6cRM=;
 b=doC1i3KizxjuuqanpnG4ISrCVJdp1wkfuzrCgbWwnZGEnRJqsFYSxNwf2JvzxhNJm8bGeYp/b1TdA/GyaPFTAKSypvI1kXPTf6LStMN3ykrs6kwNAYMQozVhp8dIo1Hj6TqE3Xf8DO6Fx8jCZpHeUcTfkCuiTurP3h/uIz9chKpTVRQyra0Mq4E9AUND/z/Ma5qtgHoBsx0Rd4+Xvn3DmO8PWSLYfvnoFDCz4U17YJAQrrUsR0KIeNMCGoBeDahwWR6G5MbpQQSKtBYm2bSSatc9Pqfiu8vJDxK4YEgMufE9kC4Bzw80+GhcfR0gRHl0paOPiJx9syGit6/omZ88Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uswttgO+ANoZLnR3XGKcwIA1oHvjycnlkNaUJrI6cRM=;
 b=Dp1IX6VtL+jhlHeClhsczfFpA4CRs+lppAe9PZlqCQbclzjPQQLFY47x49FgP1zmw/FfIwuLYhmGOIe3yvGV79h9PvvbDV+OKKhSx7pvMCzGJpRuX/JTEFfLIQ0+R9rn8+OzY9a3IOfxTbebb1rmof9+s6CnEEPK75C7zM62n16X3a2jjtjOf5hTWy7dFd919QwHx0plS7+8/4zWMEaAx3JTs8bZpvCMyO+ruWpb8SN/BCGH2zPfcYgDvjScCFI7zK0TqI2PRqPiAExX0yFXOank56kfoQSsSgoUSTRfxH6G9nKYOIvCFw6T/G16cHZhfVr/Q4nE0wD5fWWIu0okfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by PAXPR10MB5783.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:249::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 24 Oct
 2022 12:28:59 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f%8]) with mapi id 15.20.5746.026; Mon, 24 Oct 2022
 12:28:59 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 8/8] no merge - manually instructions test secure boot
Date: Mon, 24 Oct 2022 14:27:25 +0200
Message-ID: <20221024122725.383791-9-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221024122725.383791-1-sven.schultschik@siemens.com>
References: <20221024122725.383791-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0307.eurprd06.prod.outlook.com
 (2603:10a6:20b:45b::32) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|PAXPR10MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: 7394d642-3233-4596-f3bf-08dab5bb53cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rHzLuuUqPh1IlqF5Du066JC4o+2/vEvpZr7gmNDmGq0my2vv+qSlKpQFTlzbOxzGK2+9IBfRZqaTCgZpi2i9GcGn1heAYt2muYDrxtGtpYWivnQxQSLiqpjNzCPPFyZQKs98ciHLV//93s6JUuVjfr0bMaE5Z4ckd5gQmP8Mn5yyKMnkLhwiA/sAoyA6KV6Fe70YSxecyGU3/2obr4V9lJD8i8v6SZfZm9CV4bO24WowLSUJxSdNz8Zll9ts4pNKJa0lrn4AZDAZ6JjcGT7lp39VSrFSkINEXQwqTPh0cML4naE9b7ZosKqEh8mBpwsQLgrD8XPZZ33Eb1KJc2CKNtNlP4tv8y2PaXH+3HxW18svlGv4c38+Gs7QPy5b78/6OoNSqkHm4bPlfbmig/ktgcBWsIbP4A64RCRNTcyp46ShcwOMZD8rVOgbGC4u+yXVFe/4L7IOGGGjN+V+t2YbF8zyogPnuT9ShRtliGvygZ2an93etTTndVETLvguF+GizQtHZ2/j+k9qbtoi4mCmKBW+77BVHG1gH+G0+TNtaJsKQb8uG5QxrMjPu9apT3CvVFmQJtfgDDQ0dl6W5Ivl3/kPDFEtQ158f0IpIZhaBEYRHKza5NumfNS7I2odtLyfJrgaKFnFb30nI36CymNrULxGNgov4kfR1G2P2BpgkiXPkykQP+L2aPPHat/VwgJVtZT2SrL/IWVoDHeZ0iFdNA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199015)(6486002)(5660300002)(186003)(83380400001)(2616005)(316002)(2906002)(1076003)(86362001)(38100700002)(6916009)(6512007)(4326008)(8936002)(66476007)(107886003)(8676002)(478600001)(9686003)(26005)(66946007)(6666004)(6506007)(36756003)(66556008)(82960400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3si3aW8cUqLXS7JtI0r912iXgE7rZMEQCTEWa9RMFgnWcSmuV72UTdkhRKLz?=
 =?us-ascii?Q?synUDu+woOCFcz5nXqRBw5jIugMM1sbCWuxM3Wv2d7a5GI6KTtSG4i1Crhgk?=
 =?us-ascii?Q?Psn8knSrKIUti0l6NkeWg7H8unEJQdxLOiJeNU6qam/c0diiF9KsEJ5iEQmH?=
 =?us-ascii?Q?vUrWPDAaoZPPfHGc8FkdBztg2jJA9rzLlUpYi5k8y/m5rL5tbSUufHK7Qveh?=
 =?us-ascii?Q?RglulDZ3RcbwYuK3UhuTbL5CzKrBVuREUVX1w4+3qyqRawy72Gl6XMxDa1ti?=
 =?us-ascii?Q?mRh02s5WdtUZozlzh5T9sfZVDtUI8ZNZAfp0y4YKMaP1D3cJzlCuhyuK/Vcx?=
 =?us-ascii?Q?duygJjw7qUbtFnH5RbvUXsSMZ0dqSbohLzkuM7O43uMqFOcc1ig7sqMXPBGF?=
 =?us-ascii?Q?b8EXjciub/61cxJGsyXKS7SpjBpKnE61HY6eC1d6+uoNWZNemAXRWtF5Xt9q?=
 =?us-ascii?Q?QvTa2ZJ4dDu3U7eWMEOOwji+y4Ypd7EBjMj1o4PD7XUCXwXWW1iNYZG2OCEP?=
 =?us-ascii?Q?k2SjW4gt0GGH4YYQ0jJx9BBFopAQ6rEKBl7n3891yC7UnZPLoVC+XkvPZNcT?=
 =?us-ascii?Q?l3NNu1M1ncnTH6CzUwMk3z77qysTMptv5SlYkxpQgA2F6YcjSzcfNCtWCLyT?=
 =?us-ascii?Q?7ylZugX/LFBV3GqqeGiZ4M6EZjYOUfo/VaqvXvzOdbImBbDh/5aDMTOZ7BCj?=
 =?us-ascii?Q?IWOOEsW1sUH/gtTBKsPtC+hGnlilGm0ieqPvDXtTwH1nHQG8qVoplJZSeE5e?=
 =?us-ascii?Q?ehf0CycmeWyXcAdEFtPGfoPD17vgHVlpB2GLp2pi9I7kkJv1xqe1oWsIQ9CB?=
 =?us-ascii?Q?MzS/iU5PiDhX6uYA4y787mJK0K/OoLJZtN9FdbttXRa0UZEzwJhtiiX2sjIB?=
 =?us-ascii?Q?j3d9AHHiWhf4Lxgbd0SPrsR4kPeFypXdFdarmRovlDO1xF2fv3Xbi83iTqen?=
 =?us-ascii?Q?BufnM4V7aZDaIrL6AeUhOVpegaiHvBdLhvEHRM6VTuhZUdz+BItHqsHS8QnX?=
 =?us-ascii?Q?awhehNZJSaWMvjNZS09e4ufZjctRvKwq2tbpc3s1/EbJsZW+pJU+d4KSFIq0?=
 =?us-ascii?Q?8xGB90lJgB78eJtAO1vsI4MehsGXrNLt0ldei63sPA2rebMTXMcu9pZUcH2e?=
 =?us-ascii?Q?tooZDz2BT+V89hgyn1FF0tQnmS4GAbCCy0vHiUkBucIVOrGLTj55s7qpm7KG?=
 =?us-ascii?Q?S5zz6MehRboTKndis1o02HLOCqOQa6ElD7cUV7VQxxru8H44w2REIA0A7KRp?=
 =?us-ascii?Q?FZMcs09E2TnWKD1d+vMPNnnv4YLl9accWIIQlpobNhz1UUYI69tU6EmzGFzm?=
 =?us-ascii?Q?n0hA+JxCl1GH9JtxuArej8lUTiErAK106VbgkaUCXfgINOyGtAE4XOqPy6t8?=
 =?us-ascii?Q?C3/plX5M/9LvLz9VZPfeaIbeljpaoiUTUr6RdK6+YCRqj9YVhmeZYEx540uA?=
 =?us-ascii?Q?BgvR4u6jjKBJxyQ2ATrDQj8jOC3pORYIXg9OaA6P+IBlqzMUYWMWMNkzXA70?=
 =?us-ascii?Q?6FvkAgAfm4ffjuVNa4IoETXCghdD1HZ6cxmjyfTzZwQ6sum3JPvBQrzwUaQW?=
 =?us-ascii?Q?JpZCroxFIq+wya87cLmvPAwp1TnV7LPf/SeQdhu2WRZ616OLJFPDpzbnAGdY?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7394d642-3233-4596-f3bf-08dab5bb53cc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 12:28:59.8298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rztwup27HIi1cjJpcL6qupyxl/NVgJ/fjSpntG+UmvasUkwPDuP/7WeWnR2gEH3nUkoYCI5hLq7L+ELyBPUdpmzJbROZBxZsnycnVRZTD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Oct 2022 12:29:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9812

From: Sven Schultschik <sven.schultschik@siemens.com>

This patch is not ment for merge but shows how to generally test the implem=
entation of the optee and rpmb driven secure boot qemu setup.

Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
---
 README.md                                     |  65 ++++++++++++++++++
 keys/helloworld.efi                           | Bin 0 -> 4576 bytes
 recipes-bsp/u-boot/files/secure-boot.cfg.tmpl |   2 +-
 start-qemu.sh                                 |   3 +-
 4 files changed, 68 insertions(+), 2 deletions(-)
 create mode 100644 keys/helloworld.efi

diff --git a/README.md b/README.md
index e30ff3a63..6aa3f7d19 100644
--- a/README.md
+++ b/README.md
@@ -55,6 +55,71 @@ or via bmap-tools
=20
     bmaptool copy build/tmp/deploy/images/bbb/cip-core-image-cip-core-bust=
er-bbb.wic.img /dev/<medium-device>
=20
+## Running Secure Boot Target Images and test it
+Create a folder named `keys` if not exist and within this folder create th=
e signing keys and db
+
+```bash
+#PK
+openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=3DSIEMENS_TEST_PK/ -k=
eyout PK.key -out PK.crt -nodes -days 365
+cert-to-efi-sig-list -g 11111111-2222-3333-4444-123456789abc PK.crt PK.esl
+sign-efi-sig-list -c PK.crt -k PK.key PK PK.esl PK.auth
+
+# KEK
+openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=3DSIEMENS_TEST_KEK/ -=
keyout KEK.key -out KEK.crt -nodes -days 365
+cert-to-efi-sig-list -g 11111111-2222-3333-4444-123456789abc KEK.crt KEK.e=
sl
+sign-efi-sig-list -c PK.crt -k PK.key KEK KEK.esl KEK.auth
+
+# db
+openssl req -x509 -sha256 -newkey rsa:2048 -subj /CN=3DSIEMENS_TEST_db/ -k=
eyout db.key -out db.crt -nodes -days 365
+cert-to-efi-sig-list -g 11111111-2222-3333-4444-123456789abc db.crt db.esl
+sign-efi-sig-list -c KEK.crt -k KEK.key db db.esl db.auth
+```
+
+Put an bootable `.efi` file in it or use the `helloworld.efi` provided and=
 sign it.
+
+```
+sbsign --key db.key --cert db.crt helloworld.efi
+```
+
+The `start-qemu.sh` has additional `-hdb fat:rw:keys` added with this patc=
h to mount the `keys` folder.
+
+Start the qemu with following command
+
+```
+FIRMWARE_BIN=3D./build/tmp/deploy/images/qemu-arm64/flash.bin ./start-qemu=
.sh aarch64
+```
+
+In this test patch there is as well the possibility added to stop in the u=
-boot. So if you see a 5 sec timer ticking press Enter to stop.
+
+Now add the keys to the environment my typing
+
+```
+fatload virtio 1:1 40000000 PK.auth
+setenv -e -nv -bs -rt -at -i 40000000:$filesize PK
+fatload virtio 1:1 40000000 KEK.auth
+setenv -e -nv -bs -rt -at -i 40000000:$filesize KEK
+fatload virtio 1:1 40000000 db.auth
+setenv -e -nv -bs -rt -at -i 40000000:$filesize db
+```
+> The address 40000000 depends on your DRAM setup. You can check with `bdi=
nfo`
+
+> $filesize is set by fatload
+
+### Boot signed efi binary
+
+```
+fatload virtio 1:1 40000000 helloworld.efi.signed
+ =20
+bootefi 40000000 ${fdtcontroladdr}
+```
+
+### Try same binary but unsigned
+This should fail with `Image not authenticated. Loading image failed`
+```
+fatload virtio 1:1 40000000 helloworld.efi
+=20
+bootefi 40000000 ${fdtcontroladdr}
+```
=20
 ## Community Resources
=20
diff --git a/keys/helloworld.efi b/keys/helloworld.efi
new file mode 100644
index 0000000000000000000000000000000000000000..c021d94ae576271f1f472bd2e5f=
380ed1830a2ff
GIT binary patch
literal 4576
zcmeHKYfKbZ6h1SvJSx^Kg7`w6;o+lE>w`Af8X2%q+e(Xoefa|rRv{uFPz#|cL$D1A
ziD9CqO=3D~TtHE}mhYK@xOmxv~9Q<GY>r2V(h{ve?bDWy6pZoe~omt7WOn<n)acQbqL
zJ@-4`{m!{}c4l*5r2o`1^K;8|MCN4^m3icG9Gx^nj*;c~rPG4$O%f4bfu^Dp9T<ez
znwTIiBs>H$u^Tzj^^cyFwXVwQ(!0ZSa%QcpcQw=3Dl#<{TmfDMgQDbG9F^o4s=3DA=3D4Wr
zxr;}9PCz>}eVMsHqJzamr@c{`?q`V(jy824?^23-8E<1c5>1X9E|A=3DDi1||?Pq8Q4
zk{!CGQ%0|`MnBsnQCiDF-D;8OROlS{nPa#h)2$6GGMSs>t|_vI<VC%Kc`bT@$^K!V
zZ}w=3D@=3DeAB>FCMWYaby`1oi+ql92q^D?#J``UM0@M{3CI?HQIE+)}9P5nT&i5S1~Zd
z(5woMwUW`pn&Rl%A6i?G=3DQpg)YxIHdP}T}tkDZ@bm-Pp7?u^teDMhz<ZB_7h-SV9Z
zXw*(D9K-%#=3Dk)QooDP70WSi_Bfv)SNird=3DdaNnwnaI33ytN3+ttEz4po(Q{knh{)=3D
zB8_|*S64)5tyh_`tazGk^*7O31$j!*`dRfAXMwh!W)jIU-k+$kZ<rc&2gMS687Z`9
zAc_icq|*8a{c}<@rD<Ih%eXP^q?$J`NG9)fL-!IpkGbg2-$>@VcGaAX`UmRLr_A#N
zYBCldQm4bn(}+Q>(sauwOM@32RA@x$)?V=3DTw@T*uZZeh4T*q0Sz&>?G(<wti4A#_Y
zlE&(I5L~=3DB$h8N1+hbr49F_i9BlH|>%W_{Y-H4h#hMH!(N1MK~&xE#=3Dw)89X0M{oO
z_4)++;`^N%yI~U)qo+@q<Dqoj`s>w%w`JMrAxda(#{JMq^pO8t%njyhYnkt{anZWP
zag476zDwY3{i-&m-$0DiN@jS>j_{bv!I<ljWPS*J-nF`w=3D<~h7wd;RRG9~1%bm~@@
zESZ72VclTeI+E>mPl{NY4lM5RvAPbV*z+FDw=3DgI6F&X=3DCJ}bz_Sl-(M;I(r(o@yQe
z-tG@9Hu((nwdT0vp^NV?8ukVGpZA{|#(1N0+~m})X#%$&9GZ$ca1OW}xKfRx8^@q8
zlN668(`kaQODXC-r_vDa+ro1x!Y0yC2~lAZ@%=3D5gYdV=3Dj;7h@H6gC<57HkpGP}v;)
zCVr0!@w;~NSNJk<e`HK|4jn~&HgFhQ8d3Yva`i?QDee16`Q}~3UAp5d^a8Ir=3DsVU{
zM2<mT6Pog)h~ky<vh;lpGE-rjDPkA-e1*jn@f7P_MAG0gnF<}O4OhRCWS`eka5a-W
z$hoAJm!`i~o}A7)Q_y#yk9m{lTfoIUT$kIJ{{<KKi%1#Fga)3I1fJu0%-3eBrV=3DV6
z6}E=3DzsRFi&>gW-82seL~J$BKCu+ja*Pq2-Mt+Fxoz?a(Cz2u@=3DFsWd5(Oxi?!m3~|
zfwvsJdf@omMGg3#jA;iLTq3F(=3Dt|&sW4s&vT51$Ao8YO$r<#^y{$+cv602%rKA&E)
z)m7koClH*ON?R$La_9;4@YI7Q)*G(1Uaare7DQzt<2*Zd4XvbAh^q&~c4%;oX$mkF
zP%dQw`wSIKf*W5suD#1v$Jy|Hxa>WtK*lA|?yp}h=3DD2oT=3DgLXz7UcPNwdY-#j5Qa#
zR)<fZa^u;`p{WY`f?3}kAKdvJP+mKs+7tP*fa6@p?~DIT=3D0Fv%96V8eKhgKvnU4++
z9m{Nu`El0r3XgZsKzZBH&sSnUOCsaT^=3D&PySG+UWw&F_cTM5*$B;$PU(be;}Z9mi#
zyFY_Ezpki#RNb(zeN9XLrjAQn=3DRN&obD~-G+<h6lF~80~@5G4-Z4NQGtol16cYM{{
ztI_=3D92)`jnwcFUcoFEFk1AZ%Tcs;b+9AOs<JN^w+IPam!3kbc3YfddSRe`ArOjY3j
zsK8E;&LoKv@lwVu@H_q{`cC-6TQMArCxK5CfKOqaq!9nF4{eWQ!1$};0r0+<d{Fos
z#DgGB_;uLHcntWNM-9_?QQ*}usYh(TMB%^JTLjMsV%<E9x#2&u&3{esT(!MKi-rH9
zc<?wC|HK&>)|nTU@58n~ObmSNVf_tassUqecwYz4kS|>43-B}kw$K^amlHN#p;ck)
F{tfI&1hD`B

literal 0
HcmV?d00001

diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl b/recipes-bsp/u-=
boot/files/secure-boot.cfg.tmpl
index 8e6428238..63d73f70a 100644
--- a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
+++ b/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
@@ -1,5 +1,5 @@
 ### Secure boot config
-CONFIG_BOOTDELAY=3D-2
+CONFIG_BOOTDELAY=3D5
 CONFIG_USE_BOOTCOMMAND=3Dy
 CONFIG_BOOTCOMMAND=3D"setenv scan_dev_for_boot 'if test -e ${devtype} ${de=
vnum}:${distro_bootpart} efi/boot/boot${EFI_ARCH}.efi; then load ${devtype}=
 ${devnum}:${distro_bootpart} ${kernel_addr_r} efi/boot/boot${EFI_ARCH}.efi=
; bootefi ${kernel_addr_r} ${fdtcontroladdr}; fi'; run distro_bootcmd; echo=
 'EFI Boot failed!'; sleep 1000; reset"
 CONFIG_EFI_VARIABLES_PRESEED=3Dy
diff --git a/start-qemu.sh b/start-qemu.sh
index 18946a6c9..ac73d8d3b 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -179,7 +179,8 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 			${QEMU_PATH}${QEMU} \
 				-drive file=3D${IMAGE_PREFIX}.wic,discard=3Dunmap,if=3Dnone,id=3Ddisk,=
format=3Draw \
 				-bios ${u_boot_bin} \
-				${QEMU_COMMON_OPTIONS} "$@"
+				${QEMU_COMMON_OPTIONS} "$@" \
+				-hdb fat:rw:keys
 			;;
 		*)
 			echo "Unsupported architecture: ${arch}"
--=20
2.30.2



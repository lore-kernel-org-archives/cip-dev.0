Return-Path: <SRS0=715y=G4=lists.cip-project.org=bounce+64572+6139+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B54C433E0
	for <cip-dev@archiver.kernel.org>; Mon, 25 Jan 2021 17:28:09 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3C221707
	for <cip-dev@archiver.kernel.org>; Mon, 25 Jan 2021 17:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3C221707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6139+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id AIozYY4521723xNfTAZdMno6; Mon, 25 Jan 2021 09:28:07 -0800
X-Received: from EUR02-AM5-obe.outbound.protection.outlook.com (EUR02-AM5-obe.outbound.protection.outlook.com [40.107.0.45])
 by mx.groups.io with SMTP id smtpd.web11.227.1611595686740391711
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Jan 2021 09:28:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLLsEoE7nzspFbttHumi8M/583lncHwYbD37/vjMd+VTpzScGhMAS+/HEaKhIyG3Y8AAtwsIITQAij3RTPWGGLaRaHY7apJNZ22N/RcFqhGrZNL4fUuWzd/dTXpKPyHJeXe4uQCv+c3Pyyz5NZA8J4t+WeBHSrzLOSz1Jmb4bNRqmhGndHr9LdP6aOyKxVVIA2zcom+1z2M1kv3pADcTq6txtEX/IEMdEOWeJSqkA57y269igtvuT38tnT/p9Edy0jB3XRGFOC27C3s1tWziuuvAemnrA7yG2psRSQGe6UrPKPRXV/pLqQPqr19QZgHsFxncUtlSoF1ounFuYpgXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5vA8CbnTIXpibM1oDQh8rVI122YvCt4Rnf62RoHxRg=;
 b=e065ZQ08dS/AF6AV5ZucvYSNkBaNtILpXkh4IpZYFjacC0XhcZXZR2VjqA9Gzn/b/egWQSXa8ktfhtTQ6Z6hGZd0OwLC9oQfulR3cWkroR4RZLvGqEa3RWd3Xxgy9YkzGeQRUacu3Yw0ipaXAXn0ALaLQvMwFmd7GESxh9S//swurqgsShYgHNoPY7+hC5jsrkiQfoeFaalSbTB8OoAqKFRKZ7bukfYAjYzpR7eaHZmHLxazEGf/QqKccIee4A87FU3wiOke8xI43DCqn24263C4iu6qc6AWCDPndVbLsYvawo3j8Jr7qOkFLXIOMyZaCixlzOPpnewSZwlMb0+iRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
X-Received: from AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:49::10)
 by AM8PR10MB4788.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:362::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Mon, 25 Jan
 2021 17:28:02 +0000
X-Received: from AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc9b:2590:a1cf:3301]) by AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc9b:2590:a1cf:3301%7]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 17:28:02 +0000
From: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Subject: [cip-dev] [isar-cip-core][PATCH] linux: Fix warning if USE_CIP_KERNEL_CONFIG is not defined
Thread-Topic: [isar-cip-core][PATCH] linux: Fix warning if
 USE_CIP_KERNEL_CONFIG is not defined
Thread-Index: AQHW8z9vfoT2gtYwUEOw7qaBRcDZ8Q==
Date: Mon, 25 Jan 2021 17:28:02 +0000
Message-ID: <20210125172748.839290-1-florian.bezdeka@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [178.27.123.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a78e530-b9ba-4e41-925b-08d8c156918d
x-ms-traffictypediagnostic: AM8PR10MB4788:
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <AM8PR10MB47880C0826390055FF35A9A2F6BD0@AM8PR10MB4788.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 IK2YhjlJnUG51yEtHyzys9/5Uy0/N19/j5uQIMYSobowttSeHcX9tVlXb2kAlOxMvcasg4qxw4EAxjIbJN0UhecZQFO2y4yCQMr6Cggfe1pGt3rc1ZNKXd5NuWHiQPTUwxBuiFeESdmB8oUY4GSyPqNy8DpQee8zI6bvCOhab5fxB6q7S8nVBHkfiNEbIuzE0tuIEvVngc63R/XzSNb3Jae+/JL43qp8y32Q6Z/YGTA0XhqLh2dyb813JfD9hz5eJZkgOXR/Nbui5F4g4u9uzhJJyki0WA3MuGRS/JCTUna+Kl9Pizrg87w7VGzpLNbK5EjIP2NLwioi3rpXXGA+z73fF4rK5Od3MPX5CPqqfs/Qlpuka5xyWHX3BOuQMBJpnrwtFpGq1oDbuk/A4x5vSL9VBwvKw8dERvfNpypNI3S0brjprBdLuopnNPbplLcug/z+Eout1Li4J4JXJohj7w==
x-ms-exchange-antispam-messagedata: 
 =?iso-8859-1?Q?mJcJdYYMBqnbkAKuxZDVyvPSuD0Aosh5zs4l1moQRuRLy9fUpZEAEChlqD?=
 =?iso-8859-1?Q?DHMMUJ3ZLZSqWXBNxrFbiGMQiuKMXGbzPCL4VPhhns/+GMj27tLnKsj/RQ?=
 =?iso-8859-1?Q?WIeiPD0Hw3r00QqhaY6SuYHTTcRTW8r/hyZ0r57jSbTMdFryofPPZwQg/I?=
 =?iso-8859-1?Q?/W1Miesm9A+sHsKLwIYy4jZMQogphAOfrSczKnFvEMX30930nXuX37GxYk?=
 =?iso-8859-1?Q?t9IGLA6h1u6bjj/7kh8R++YpdMQi/MVbVkplJEJ3yOjS2Cw4+j4H4IAASs?=
 =?iso-8859-1?Q?PtfT17ZFc+b3TN4gMx6UhsUgWe1LG1l5yRig0iliRETWCN4zUj0YMEAbHT?=
 =?iso-8859-1?Q?WoW5q8NntQQ9FtYrCtmvGDiAvilJYyEObwOARs/ue+5NjVIVlZ/BPivmcZ?=
 =?iso-8859-1?Q?JOpwgpEgOefRKxTN+N4YArep/yZw605E7+B0FPSZdJNqirnJsUDnI+Ivg0?=
 =?iso-8859-1?Q?cmDF5VBklnvM5GhlJDpgW3aNUAx/OcqwYbW7CPUae1qFG6yp893LmrRknK?=
 =?iso-8859-1?Q?UeBkpXuy5gVljVyvbijvG5W1hv6wpBdH34UJ+y//wasby1PqBYP5eRpCSQ?=
 =?iso-8859-1?Q?2WcVH5aRRhITR1o9ybMR99tOXNacF8o0E8fdiCZlu1RXBKaAQL47oLwAm3?=
 =?iso-8859-1?Q?2AZMKXDVycP9mkEl/P1qsLCUDdrs/qyPmB8mF4h9Uj7uM70DXFScgqbqKp?=
 =?iso-8859-1?Q?V39nMF9Tz64A5AjEwtBEdlzDh8OdlJd4NeflzpeLD/KrdZ3BltWncZkHLi?=
 =?iso-8859-1?Q?D8wOIH21pBxRDyHituPjH4rQmzuY5pcjBMdsI7BneqGmwKIMftEL1FaJHe?=
 =?iso-8859-1?Q?TBct+lxVOmpW2Cpu32b6DEHFFhbeNzrkRH6GZR3Z/Jqz4nBNFv1PZycVaj?=
 =?iso-8859-1?Q?HS3sxRck7oI1jndae6JZKcEl9CFjOV70fkjnmqwasm5jhQu8fq6f1dHICx?=
 =?iso-8859-1?Q?GbUfY/Y4qJZ2CECJW2n8HswQURXDR/GPcic8/jCK6jTYD/lseop8WS+7oB?=
 =?iso-8859-1?Q?akYfDUd6sLUIAmK4hf5HtaETMkqXjc8Vhxeig3kVMS1EK9YMTydDO1vqb4?=
 =?iso-8859-1?Q?oz9kjueVFu3mM/hqM+E9UyVLiDFFND1OkTEJ0Xyase4SgDn7s/YsTq1DPR?=
 =?iso-8859-1?Q?FMTYFz/w=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a78e530-b9ba-4e41-925b-08d8c156918d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 17:28:02.5078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M9wdR+H/X+UEFJx2nYHeflZqkHs6eaZMQjTanl9BBz5iDW8yhuFoXMaXt3TkjltaMRaqnQaFH2Ux+aKINN26s53ujzjhk/YnbeUGhOvU5uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4788
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: pBEPLdXVA7keBATsJcPl4GKGx4520388AA=
Content-Type: multipart/mixed; boundary="hNjh5hk6epCIGUMqr0pp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611595687;
 bh=o7sfy8p95EUEM1jjTYvUgZTprv9Ge8QVLFwwUer4/yI=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=XmPyiOlpqBGlq1TDwQYuTLDbtLAwxH9h7frIqdiC/St1ohu3OQRmxUJc4xSIansXrzv
 VWK+olYDcekXeqZ3TezfJ8fMtn07Omrcm8osTvlDO6LX6VeOdjAPSWP+KeAJyJWaJaonz
 YONwFx12GgPs8No5K2FT5egsheaYcoADerY=

--hNjh5hk6epCIGUMqr0pp
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

USE_CIP_KERNEL_CONFIG may not be defined in all layers using the
isar-cip-core layer, so we end up with the following warnings:

WARNING: /work/cip-core/recipes-kernel/linux/linux-cip_4.19.140-cip33.bb: U=
nable to get checksum for linux-cip SRC_URI entry ${MACHINE}_defconfig: fil=
e could not be found
WARNING: /work/cip-core/recipes-kernel/linux/linux-cip-rt_4.4.231-cip47-rt3=
0.bb: Unable to get checksum for linux-cip-rt SRC_URI entry ${MACHINE}_defc=
onfig: file could not be found
WARNING: /work/cip-core/recipes-kernel/linux/linux-cip_4.4.230-cip47.bb: Un=
able to get checksum for linux-cip SRC_URI entry ${MACHINE}_defconfig: file=
 could not be found
WARNING: /work/cip-core/recipes-kernel/linux/linux-cip-rt_4.19.135-cip31-rt=
13.bb: Unable to get checksum for linux-cip-rt SRC_URI entry ${MACHINE}_def=
config: file could not be found

${MACHINE}_defconfig needs to be added to SRC_URI only if
USE_CIP_KERNEL_CONFIG is set to "1".

There is one in-tree machine definition (the bbb) that does not set
USE_CIP_KERNEL_CONFIG to "1" but still needs the defconfig added.
A machine specific SRC_URI was set to take care of that.

Closes #7.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---

Some additional notes:
  - That's my first contribution, so review carefully ;-)
  - Both branches (master, next) are affected
  - The gitlab MR: [1]
  - The gitlab issue: [2]

  [1]  https://gitlab.com/cip-project/cip-core/isar-cip-core/-/merge_reques=
ts/10
  [2]  https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/7


 recipes-kernel/linux/linux-cip-common.inc | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/lin=
ux/linux-cip-common.inc
index 6db1d1d..9aca9af 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -11,21 +11,18 @@
=20
 KERNEL_DEFCONFIG ?=3D "${MACHINE}_defconfig"
=20
-def conditional(variable, checkvalue, truevalue, falsevalue, d):
-    if d.getVar(variable) =3D=3D checkvalue:
-        return truevalue
-    else:
-        return falsevalue
-
 require recipes-kernel/linux/linux-custom.inc
=20
 SRC_URI +=3D " \
     https://gitlab.com/cip-project/cip-kernel/linux-cip/-/archive/v${PV}/l=
inux-cip-v${PV}.tar.gz \
     "
=20
-SRC_URI_append =3D " ${@conditional("USE_CIP_KERNEL_CONFIG", "1", \
-    "git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protoco=
l=3Dhttps;destsuffix=3Dcip-kernel-config;name=3Dcip-kernel-config", \
-    "file://${KERNEL_DEFCONFIG}",d)}"
+SRC_URI_append =3D " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kern=
el-config.git;protocol=3Dhttps;destsuffix=3Dcip-kernel-config;name=3Dcip-ke=
rnel-config" \
+    if d.getVar('USE_CIP_KERNEL_CONFIG') =3D=3D '1' else '' \
+    }"
+
+SRC_URI_append_bbb =3D "file://${KERNEL_DEFCONFIG}"
+
 SRCREV_cip-kernel-config ?=3D "7f2930b9667372f94f2edb42ca9cf6fc6c0aed50"
=20
 S =3D "${WORKDIR}/linux-cip-v${PV}"
--=20
2.29.2

--hNjh5hk6epCIGUMqr0pp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6139): https://lists.cip-project.org/g/cip-dev/message=
/6139
Mute This Topic: https://lists.cip-project.org/mt/80109577/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--hNjh5hk6epCIGUMqr0pp--

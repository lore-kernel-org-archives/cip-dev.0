Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4B5C6FA99
	for <webhook@archiver.kernel.org>; Fri, 10 Mar 2023 13:03:59 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (APC01-TYZ-obe.outbound.protection.outlook.com [40.107.117.66])
 by mx.groups.io with SMTP id smtpd.web11.15308.1678440423114297759
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Mar 2023 01:27:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fGFuBdFZ;
 spf=pass (domain: siemens.com, ip: 40.107.117.66, mailfrom: srinuvasan.a@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJ0Za8kYnU3/ZDK9MMwQEQ9aE/zj6sTyYnN/7kMiUMCikyIqapfkO0XxUmqE3n2tnPmXvwwmzs28DJHWKffJEsYcvcifjZFDilLodvEzJE9vPSxH9JvJwCWwm4sNtEzLheQ2w2jv6lU9cAdomTUQ+/INn0UBsaKoTBS5AjwYSW8V978ue7dcCwFuubO4BlcJ1tYxhECn4VoDVuHY+EwgK9mRAkL7FdxeIeyavRyaxH56SrsN9r0XEUMoLUBWZ9Y8SKDyeelOn6eLOz9chPnT7jSXq9Adlqz4BZ8qrEXEB5SBds+Hf1mnp0tyVtIcsax+q4Ecs4434PyvXftuTyOSwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHjlsD95gpdV+VMu8x/RWORP49NmTkaTjb1iAnAbNwY=;
 b=dAsFKFpKFSYOdCuQfKXn4RkvyuyGXOdqVcDeOAgmbwn+uhiYWM84XPvkRdYwEqzXvtXZ1TYbsPkXniBddTCyD9xzCfU8p5xtCTZM30l3RLWzLD8ygIv1Rq5yvRvvo/Tq473BejLxLLMoM8TA7HJ3Pe2nQ5X+SiBCEDgs3SqD2BYnbXlm+dhXveuooLiMs9GiYmSSl+IPHkgiTVX1oJigsN04mJh9ayefbumaiUSNCHXiBjj2/laFf4onHFAavjEs8VFxHh3vxF7zo4TA3SUPGVMHt1xwApoyioGMrg5rB8Tbq0q6lRojNgnJUl745ZvpG/MghZiDqVX9FMj4lslr9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHjlsD95gpdV+VMu8x/RWORP49NmTkaTjb1iAnAbNwY=;
 b=fGFuBdFZLWEK/ruUhcmwuf91CkuJ8599eeeHKCZaPYjIZG+Fdv+Bia/DYF+DT7YOSiGN8Ddkf/9neNjf1/2aeT92Uw2GbrimDv2WvHvMGwt9hRAkNvQAQ7/ugmKY9Il6B7IuxQjLKoF6Xgu5hhYCayHau/H7VwviuqD8G2he/cZvdMEHybHJbCjrL/k34fqrUckIYy5jwU6+nDvGoWAonU71jejfIQxz8JHNARhQVyuenUYSXPxq0Ay2vYqRj9c3UD6PuxaUfeDxWRi2IsMnWTD+k+YHJKz9MUmFDaILB2aYBy0Jb9Cr+Dm0w0aUg8c0yCsvYic11cy5oG83m8y0zQ==
Received: from PUZPR06MB5747.apcprd06.prod.outlook.com (2603:1096:301:f4::12)
 by TYZPR06MB4463.apcprd06.prod.outlook.com (2603:1096:400:8f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 09:26:59 +0000
Received: from PUZPR06MB5747.apcprd06.prod.outlook.com
 ([fe80::c53b:e4c8:c232:6cb9]) by PUZPR06MB5747.apcprd06.prod.outlook.com
 ([fe80::c53b:e4c8:c232:6cb9%5]) with mapi id 15.20.6178.018; Fri, 10 Mar 2023
 09:26:59 +0000
From: "Arjunan, Srinu" <srinuvasan.a@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH] ebg-secure-boot-snakeoil: drop space in remove override
Thread-Topic: [cip-dev] [isar-cip-core][PATCH] ebg-secure-boot-snakeoil: drop
 space in remove override
Thread-Index: AQHZUB5HifRKOhZ+AECI84UHHth7ca7zxFtg
Date: Fri, 10 Mar 2023 09:26:59 +0000
Message-ID: 
 <PUZPR06MB5747937D583ADEE275F79B6888BA9@PUZPR06MB5747.apcprd06.prod.outlook.com>
References: <1749D0C69BA8621B.3736@lists.cip-project.org>
In-Reply-To: <1749D0C69BA8621B.3736@lists.cip-project.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=d9f15d7f-7dc1-4a57-95c7-29033ec3a65b;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-03-10T09:25:46Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5747:EE_|TYZPR06MB4463:EE_
x-ms-office365-filtering-correlation-id: 4e40ac99-9596-4732-0249-08db2149997f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /FQMvLxJHNGOojFbRtHYBFS0w4mvH5MIXVY/shD4XdzmWxpA40q4/M32JYfX+niKw+8ha1UFsO6YhXcAVVyw7g6U/47vS9tLd1Rbjc7+f9uPJn1aS9Bq2Z6OCynOZsQ8vLw+HnnndLPNmsvrPWFheR+JRWrUFfzRdkXKSa7/x1iX3mU+JfUsVDUTQF3pj0TpCbM5EE0MUXNXrYJj64zXb1rVWBwyPSSmLiO0B+3V2Dl+hMc+0NamYQCZAdpGvpOtdQeyucoyTWJHD8QGC9bsClYDULz3PK7xKBrVB+a4r/h0gOqA1/3dgxCxuLb4W4RBvLXmiSs9NeZM9fv+W2kA7X+xXhofbOgoroCjMYYCTs2208582w5HgwMbEIRNZedaBvg4qxa/HaQ57L9cMfpulqhMp8yuzGYKoBs3irbtJ7c+7xHTcd3HuzhOChRNwEwu8KPlqQu3HqOo0MzQnVSYFKH8M0KonbQosA0PvA+JCG3tAr5fTrjlL9s5SfK6Gnim8aJrxZInWYzSqD9nln6O/oAkU1Mj1Y/b1ruCpYOfcOQ6Yagco1aCintcFdMB+2bFxu/SMCYC76hCyg2vuSqkWcsB4VEhbRupTFu17rsOYHOgN7YEPKDk6Q5/iLYK/kF66v4D3sHzk6fUANUKcTrIYP90lIvq5ROcVoHlD2iQbuO/zfT8axTAzG6cm5If6DhchmehyBuJv1lVeNSiWKZnJA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5747.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199018)(33656002)(83380400001)(82960400001)(6506007)(107886003)(9686003)(53546011)(26005)(52536014)(7696005)(71200400001)(186003)(41300700001)(66446008)(6916009)(66556008)(66476007)(66946007)(8936002)(76116006)(86362001)(8676002)(2906002)(64756008)(5660300002)(4326008)(478600001)(38100700002)(316002)(55016003)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?vxH9E3qyrIjzHL3Pn+4Os25PD3f8CK5FrqmVxzPMY0+8yGwaCgxGC4CKxQrr?=
 =?us-ascii?Q?g9UY5YLXZwvoyadnwpnjeW+P/kINWkSRcIs/677HyNE35RLl5PeIu5qdPHiT?=
 =?us-ascii?Q?uIwBF/Tv1e6NMPNmdCsrvwlxqVMvOQaImrmW8LxUzr3oR4jT2WnGjoAJQPXv?=
 =?us-ascii?Q?PpF3isezSj3Y5sC6UQe29sB6zOL1bCjC8P7YYMviAZIFm52P4MiKNKabQa9l?=
 =?us-ascii?Q?4w1HPiKu6skR7RNxVqVVA2csB6kKYBId+9zeTL7WCG/TPdmjbgEnnl97BxAc?=
 =?us-ascii?Q?N8yf/Va994So2fANjkYNzhG/Y0SrPEId0+a7nymMpMCdRAifzVsl4Jm3x7s/?=
 =?us-ascii?Q?4P2EfegPiwO59FjC2opd1mXLSXN+KwCuhqwDkAOIlw2QfD2NxzFujrTQDj6j?=
 =?us-ascii?Q?FoZZ34umX6Hp092XrIhGeEg0TPdAiLzS07m+at2Xfm6r1USQ3dobA3oiJWUl?=
 =?us-ascii?Q?vmhxp1OEnMEJsXDFgR/r/A6yWqsW9NxFMJnSyZwF908s/Buax2V/lcrGcB2h?=
 =?us-ascii?Q?pVhquPekaCDhZNstYpPfXzRF8nHGe0sdZU/qnxIPlr+LhIDdZq7Msd4eBpV7?=
 =?us-ascii?Q?4jnFL/bIH7mPt7YsW7yon3gC+iKLPXJN5+5ff7f0Z5j31xq/nVBfrbru63Or?=
 =?us-ascii?Q?cVvkwvGhm84XKIjdG1yRuGHRvm9BrpWF+Ruaf9xQDkCpeVIzAR7E/kqZGBvI?=
 =?us-ascii?Q?/HZOEnzLh8YDy7OO/8jp9PRagxE/brnzsa1LnB1SOEgsGNNNZmFJSB8/dkjF?=
 =?us-ascii?Q?QQDVw/bEgnBYE47ZR/ZMJfIk1uhCDyw4IElm9kR9z86OBC7/HEUgKaB3qZn7?=
 =?us-ascii?Q?KrpbOpvzc3w6MSgGRVIMGpmvsIemVqeZDa/1UevgffOkegQpIl0odk4fUzDj?=
 =?us-ascii?Q?3Mxd52ZDlPUqHGAtUk3w6JfP5c/zbL9I5ba8CSSbnPxsRiAjNRApVf4Z1aRZ?=
 =?us-ascii?Q?4vUXha1wCHyi94fv4yhLfxNHcTEB/i4MVBuObSBPHwgUr6hm588RN+pd5rYy?=
 =?us-ascii?Q?lL4u3mB8Bw9t8s+4InJVia6Ea6P5J/E2EjP2HhGWykP7eofd8CCEt8eL7gU0?=
 =?us-ascii?Q?noocGPBr6bK61SKUTwwoYzPvCW3Nr87awEW1tWEmlq+3zCeF+Pl3ApHwXErK?=
 =?us-ascii?Q?lLHs1EeiwePMRuF7olGGNtsmBGj5SXjzgEwGkYDX+o3AlQSHQ2q4oVo3lr0N?=
 =?us-ascii?Q?JA/XU2ghK8pSJ2Rt56FHVZzt/KpneCBVT/OobX6+bxxVaV0j/TjLBtuHdR6r?=
 =?us-ascii?Q?ch9jDfvmo/HIYMI35lKvdyCbANGzIH+yITDdTgV53E4J96R+MFBCauTrOw0B?=
 =?us-ascii?Q?BbwZJzlQ4AhPLskHOM/WlqH+PWF1vqr7UCbiUgq+o3hCpItSCJ+LA+RffNjF?=
 =?us-ascii?Q?0AmOj9YoTVp7U2Nyd5QYUgMAsZaSWrAVV5PCPzAsXli4z4PI5x7hjol8gGJL?=
 =?us-ascii?Q?tMlhlsI9luej4g9pAPWfdnnLaTXJqFhSsQ4gwDd/tpoFemr9iXw93Ul7+HnJ?=
 =?us-ascii?Q?AJdLSe5klbuirzYYvZTtkcC/8h8USZydd7PSLNJLJ9l9AQpocYA54qji89Sz?=
 =?us-ascii?Q?scleUZbF84s0TcPyr62PkfZD66tQ8OXVCzLPM3WC?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5747.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e40ac99-9596-4732-0249-08db2149997f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 09:26:59.4155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PG5bPuPruICF35eYvB3qizCNm8E3wDqc4CO1v4rZ007GCoHiFae0BzNogq1sG9v3IyvoBLTRCpYn9K0M1HnHQqsFTTfBfW9+1zskIrZCgpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4463
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Mar 2023 13:03:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10975

Can you please merge this change?

-----Original Message-----
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Srinuvasan A
Sent: 06 March 2023 16:54
To: cip-dev@lists.cip-project.org
Cc: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>; Arjunan, Srinu (DI SW CAS=
 ES LI PBU RSOL) <srinuvasan.a@siemens.com>
Subject: [cip-dev] [isar-cip-core][PATCH] ebg-secure-boot-snakeoil: drop sp=
ace in remove override

From: Srinuvasan A <srinuvasan.a@siemens.com>

remove does not need leading spaces in front of the package, hence drop thi=
s one.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 doc/README.secureboot.md             | 2 +-
 kas/opt/ebg-secure-boot-snakeoil.yml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md index 54d6=
7c7..bc238fb 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -154,7 +154,7 @@ local_conf_header:
     WKS_FILE =3D "${MACHINE}-efibootguard-secureboot.wks.in"
     INITRAMFS_INSTALL:append =3D " initramfs-verity-hook"
     # abrootfs cannot be installed together with verity
-    INITRAMFS_INSTALL:remove =3D " initramfs-abrootfs-hook"
+    INITRAMFS_INSTALL:remove =3D "initramfs-abrootfs-hook"
=20
 local_conf_header:
   secure-boot: |
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot=
-snakeoil.yml
index 3d0e3c9..f787c82 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -22,7 +22,7 @@ local_conf_header:
     WKS_FILE =3D "${MACHINE}-efibootguard-secureboot.wks.in"
     INITRAMFS_INSTALL:append =3D " initramfs-verity-hook"
     # abrootfs cannot be installed together with verity
-    INITRAMFS_INSTALL:remove =3D " initramfs-abrootfs-hook"
+    INITRAMFS_INSTALL:remove =3D "initramfs-abrootfs-hook"
=20
   secure-boot: |
     IMAGER_BUILD_DEPS +=3D "ebg-secure-boot-signer"
--
2.34.1



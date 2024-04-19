Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6606BC04FF6
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 12:24:52 +0000 (UTC)
Received: from SINPR02CU002.outbound.protection.outlook.com (SINPR02CU002.outbound.protection.outlook.com [52.101.133.5])
 by mx.groups.io with SMTP id smtpd.web11.13283.1713504767548026859
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Apr 2024 22:32:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lk/o+jbL;
 spf=pass (domain: siemens.com, ip: 52.101.133.5, mailfrom: srinuvasan.a@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3DHCr7hUDpELBzVHGUd7rosmi89moKBUNEDfTbEnXMxEv/cc2ScDiItHX37ZCPG1brtpBD8h1szisd9MX4wZQriLf1Fu5OzxG7Wz66ulVD6QLdILkZz02UmoHZob7KvU99/jpAR2IgjhlyztUvJuGkmiwLmoeS3wz0qGVaSOS8ewGZkLCuWzJ45bBOOKcQfs+iZjtBaV6ERum+31/kAta7va0b4dkiFU/R25S2WyKzuwJ5CFOoW69G06f6ZmBmrrgha2kwMhw831AoraL6b3dLOolrSZS8v9Oku/Gbxx44supIasnEn4V8NHXS6/P+zfg+z6Mx6+sM9Hbwrt+FYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZnxlRhCXOWX9JSqw/28v+eBsAanA/Up8o3t697YNw4=;
 b=DxbZcGVciU5t/xDQk5bpnjm23tlYQbraukJsOhqepc1SVGZGYIy1s4o0EVEb7R0VutWsExIDJO3aU+mePGKEgsZJ4jfzSx98BWQajV59x+mZ1q8zlIW/mWKQThFw4CXagYeBcPkLwAODlf8A90CaMPmjUHUIujvn8aXtsVctHKaN40C5OEs8kujnh6G213R7zdh1+504MBzr9++SBYqGSkZjrtMFpQjQMlM/BEg86kMEZcmtn4UIogH6IV7ndwMvLdc+rhpXj84a8AuXilMKbmxcsMRqokrcpwQLXtNsL3VcamkPv19Tn2vORR5NgGa9rYTagE0/gXc/p/Nlpn03Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZnxlRhCXOWX9JSqw/28v+eBsAanA/Up8o3t697YNw4=;
 b=lk/o+jbLQJ04OUI29Lta4a0HiXjviImgzK0Sa2m64ioG52RZje15p7JVhtf34l3CPAFszxYpAzvi8MVc+wzqIpmZVJKEQ8JwYNuuysWBy9ePWOe17bJeht0kgj4LZgQRhn8Qap3OEdljGQIvRaHucbu54Adh40i9er/iuyWOuBFZ1V3uQY8EZsKUATphPup3S7Y2XNUrl+FP0pdJdyKtasjf48Fy9J0OONaU4emzT3D3EAe3XRaB5jJrySeHrKZaR/lJa54MJiZQSYgZptzPasGUTTrFL+mSVN2Q4heKP4ZNefrB2CjkeI0D0tnM2vzkftQ/c90mhbWS9O0BlKKk2w==
Received: from PUZPR06MB5747.apcprd06.prod.outlook.com (2603:1096:301:f4::12)
 by SI2PR06MB5019.apcprd06.prod.outlook.com (2603:1096:4:1a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Fri, 19 Apr
 2024 05:32:42 +0000
Received: from PUZPR06MB5747.apcprd06.prod.outlook.com
 ([fe80::6cb9:5483:5aa3:ffbe]) by PUZPR06MB5747.apcprd06.prod.outlook.com
 ([fe80::6cb9:5483:5aa3:ffbe%5]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 05:32:42 +0000
From: "Arjunan, Srinu" <srinuvasan.a@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kumar, Rakesh" <kumar.rakesh@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v1 1/1] recipes-devtools/secure-boot-secrets: Resolve duplicate Provides in debian/control
Thread-Topic: [cip-dev] [isar-cip-core][PATCH v1 1/1]
 recipes-devtools/secure-boot-secrets: Resolve duplicate Provides in
 debian/control
Thread-Index: AQHakYV1WMO5THyNpUmY4d0k9q3xR7FvEadg
Date: Fri, 19 Apr 2024 05:32:42 +0000
Message-ID: 
 <PUZPR06MB57474EDF254D8282A170D624880D2@PUZPR06MB5747.apcprd06.prod.outlook.com>
References: <20240418101522.583817-1-kumar.rakesh@siemens.com>
 <20240418101522.583817-2-kumar.rakesh@siemens.com>
In-Reply-To: <20240418101522.583817-2-kumar.rakesh@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-04-19T05:32:40Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=048c78ab-9c72-494f-a6dc-880714c2af35;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5747:EE_|SI2PR06MB5019:EE_
x-ms-office365-filtering-correlation-id: 87d1d058-ccf6-4226-0ff3-08dc60322269
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 bCMm//d48gqvIKO51TYhmepjBi4sGzqCUCf1LeCEz3z4hwRAWMYGFvT59/dTq1sE1EduVX3Q9yEaFMHwFH8agUTKvgjUw4cQX8NnPxKSwO7zyx+JtSUg7XJIH2QOrwnzCPRrmI1WKEWTrf6bXDN7JO0lEEIaNIa01l4NKJokIVd7czaCM8X1vd5DGZsl5G2GVGrxDTAFRhwKF5KPS0c7I2nvKCTR0LSZ6oy9zeVjfW5w+dwnefgpkrr2nO6RRNi0sJz/Ta6lc8O12PBdNgYiMly7kYNSjRCa/mZ1hpe3OUCJBp0ZSrKpZPIqRvBw4sRCYEHyj8ykcMYkvg1lgD0wlmONutoea0P9iLoPZpszXqOqZdzG6lGdZzM52k4Jols/bvkSpWiVsVCAb1AQl5Bc5Px8SaWLZ1TauQWZ1DoOzSUoqFufcrW7ahSt0dAH6dq6h86wDi2fdkPxZSLJ902B5X52NQEMxzcozb4/g01VQSkd8//iXH0+CcmwjgFXP96iFa7fQvhbyGsc/8BQP5GNs4YM82M9mJac2xxpSq/SwVkq6notHDENDMB2cH6+nmiPs6xNIkVhQCLK4IDpZIMdii9vrLH0IvTxQ1xpJ8vvItQu9LKab1xaIsy7n8U+8s8ykXHaIRlPHYMS0rIgtqxzfQVsO5A2G012R4TkqmabtKkIfhANCChxggVFguuHMEBuKehgmhQA7uvbI6Wo0QwRJmjDBGtJfiFxkXImWCOMmro=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5747.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?N7jN9UrWAh1mXRIS61mHcUxFWFKPUXdWCBOe3U7nYYQvFOkoD7c5KliM0gPj?=
 =?us-ascii?Q?WHwluluy0q363Huw9INlX+qxFxrCTXwd3FBj0MwdOC7NVPe9S4TRQ1ahCoA7?=
 =?us-ascii?Q?XO+wsIb/TDCsAPWIkDQCgSaVDeU9kijsTsPpp1qK+oqH8eDjqs/Z4rDOxkeg?=
 =?us-ascii?Q?zlW1siqA1vbR4GFbyi6zch9HrHjBbZ2LpK6gtqzRMRoKmnYtJKqs6afDtbvS?=
 =?us-ascii?Q?LzZduuHnNpwPdnODjlAkZyy8zsytVSQMaG+TO+H1ClXrCUtolFl9msU6pQID?=
 =?us-ascii?Q?aeEez+Wh38a7jttUkeESVQzMyGpeD8ih5KdEkyrUMf9jwTj1dhOxr4xkdQca?=
 =?us-ascii?Q?GjEOqPHO6qZ8pGt+o/5ppOpv/VBwj4Ph8t6IA5RyueWANDVmP641d//kQ8uK?=
 =?us-ascii?Q?8JhpyspAOvIkz9R3qvvCl4gc2KNGWHT6fBML2o98ShVQmG/cKKo4AkuvUwVA?=
 =?us-ascii?Q?OLKOrGbArPZgYgXluMgDAxf5SWOLbZAQk6dlzw8kVj1B+RyAe5zuoerS4R2l?=
 =?us-ascii?Q?N9GrmF9tHPFS9JkXEpZ7rWCk/9JhmYwG3zkNcLCnkZdq3pDokWQyLZQtiyK7?=
 =?us-ascii?Q?rpMo9bfc1VnIumhrczPr/FTTbi6ynthvBv/msc2Sj25QiMDpVikn0s/1F4Nh?=
 =?us-ascii?Q?Y7iXA/WrPdciRfSOPp3wd7fGsWnGJGMZ3X75mvJ2/KnE9bnv1pFuJSp7XDz+?=
 =?us-ascii?Q?rZI+9Uy7bXFi/Fp5Rukb7HbgGkhmPKL6py1zKl8ujdvlSsErFuqpnk+9nOaU?=
 =?us-ascii?Q?bleiCC1UgTiuxjv/J/JPb5J5di3IGwCjk99RSwZkTIwMTBNW14kOHnr+OJCv?=
 =?us-ascii?Q?yfeTykyFd+Tvytaz2E34XtGyIya+8hzghEnmc0grBljt/bf/3PiJojT5sRDg?=
 =?us-ascii?Q?fhBOgcBzpp0w1dkq0s0HaXQu7InMBxgQyGlaOW3ygJawihVqP9qhLXjVmzEK?=
 =?us-ascii?Q?8Z/i4GkgCNKp2cNMgz+Tvip25ZT6fBhua7JdpL/vg72+n0Iu3Bmr0nx7U2Uv?=
 =?us-ascii?Q?wH/nRpNBdsSqzfp/GoKUyaKUbDetHAOLabJwrFqZwTsv5uyPNZrdo1gQBAG0?=
 =?us-ascii?Q?sFftGdi6P9ELqtpWgC9CDmB9i5uFK2sfgkRfBraWv6WjbeQumjyeOsRBeGS1?=
 =?us-ascii?Q?4mNre+gRT9+F97TE/2QAlO2cf/w0XWo3zFLEBpIxJQ2wILH+UKQeXGbuc0Hu?=
 =?us-ascii?Q?JAuPoa2kHvkQfvNK3aVQmdIvHDTQYH35fYOAkKBIJX+DSJ0QBCIBiWfqMn8F?=
 =?us-ascii?Q?6D0rrw8ML9zOxzF7BIAx7H0o/j6B1d19dh9G51K82qYkgyA+eECnDwxARJ4J?=
 =?us-ascii?Q?NFl29+P+yi+haEqbanMLbMvUEtkXU1Gk/gRO1p5xAqoGK8qPV7i/GDRuI7TO?=
 =?us-ascii?Q?QFyt8/ahc1RyEtTJc2r780sSAjgLYhmlKjYt4B4f20aRTlWZzFUwfsBQNh3T?=
 =?us-ascii?Q?wDsL/Ef61+eIQzb8biUvTN7G/TifPqivzBbMSkDfINtGZ27b+1hukl2g5+Gc?=
 =?us-ascii?Q?SrNvbMu812v78t/NcRMMCZhFxDkjo1zVroubcOZoGuYzaNI43kUGZC87Fd1c?=
 =?us-ascii?Q?ocw1mDKEh2I3P/puF97FyKxS6hmzrY4QbXe0p51Q?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5747.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d1d058-ccf6-4226-0ff3-08dc60322269
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 05:32:42.1442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qYMeJ9NsciIORqNmeXqg6igL34FJdBX7JxBizXNeij/ChqcluUSX6gsMldSpgPkV8NapUbaCBLo6xNGIg3B5sMWkMBhzCASWV4wjEr9SHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5019
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 12:24:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15696

Please correct commit message , remove "ad", Moreover ISAR now supports the=
 "DEBIAN_PROVIDES", why can't you directly use this variable to declare vir=
tual packages to satisfy the dependencies.

Many thanks,
Srinu

-----Original Message-----
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Rakesh Kumar via lists.cip-project.org
Sent: 18 April 2024 15:45
To: cip-dev@lists.cip-project.org
Cc: Kumar, Rakesh (DI CTO FDS CES LX PBU RSOL 1) <kumar.rakesh@siemens.com>
Subject: [cip-dev] [isar-cip-core][PATCH v1 1/1] recipes-devtools/secure-bo=
ot-secrets: Resolve duplicate Provides in debian/control

Previously, the debian/control file contained a duplicate Provides line, wh=
ich caused a build failure ad below
| DEBUG: Executing shell function do_dpkg_source
| dpkg-source: error: syntax error in secure-boot-custmpk-0.1/debian/contro=
l at line 16:
| duplicate field Provides found

Use DEBIAN_PROVIDES to resolve the duplicate Provides problem to ensure tha=
t the build process completes successfully.

Signed-off-by: Rakesh Kumar <kumar.rakesh@siemens.com>
---
 recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc b=
/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
index 76233b3..559d295 100644
--- a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
+++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
@@ -12,6 +12,7 @@
 inherit dpkg-raw
=20
 PROVIDES +=3D "secure-boot-secrets"
+DEBIAN_PROVIDES =3D "${PROVIDES}"
=20
 SB_KEY ??=3D ""
 SB_CERT ??=3D ""
@@ -29,6 +30,3 @@ do_install() {
     install -m 0700 ${WORKDIR}/${SB_CERT} ${TARGET}/secure-boot.pem  }
=20
-do_prepare_build:append() {
-    echo "Provides: secure-boot-secrets" >> ${S}/debian/control
-}
--
2.39.2



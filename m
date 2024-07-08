Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC6DC3DA42
	for <webhook@archiver.kernel.org>; Mon,  8 Jul 2024 09:48:57 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (APC01-TYZ-obe.outbound.protection.outlook.com [40.107.117.83])
 by mx.groups.io with SMTP id smtpd.web11.76119.1720432133246544716
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jul 2024 02:48:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sxon2JbT;
 spf=pass (domain: siemens.com, ip: 40.107.117.83, mailfrom: srinuvasan.a@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKyXoUJ5Y0Em75rfpNCtBIpV+EUVwneAyR3+XyqZGHyouK87wqozkExhhplpbf/XtioYFxQTIl0cSsvBfLObj6d84Dy/3q6ETYfha0j7k1VE+1QBOBwxbbsRhEaHAVlroQhaViJZu6Mxk0YJ1qDCq2Y6lF4a8d1F6dbhY7J4+lIqE0uQaR1oNPUe4wK5kyGq9trfNG7XfWTsxh7UEPXd9mhgTKa5bXH0rseAfx+gGx8KQqC5NX8lVrOuu/HpXvdoEAENMgJX1hfBlEL9UUzL/vduPEUsrHBTvYoBK+oqJL1H7qEwEmLguQz+psCPtJaB51deuw8C8JAZxU1rrhAmhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIIVH0CgE+sV6ZvK7PbvLbq+K/isB0bAXgNymdKZQ7c=;
 b=bTjBwB9yVfmLp/iH15V9sBeimEI7T1e0+wsjEbiETypo5BXpF7j729JupKm2QHuOmr6XvPUGW7xLsFJYE0xcztNZ8Qw8cxDb2Dqzs/oAYjh/sDKhRy2POrUxwjIJj9mQL3mJQmnbKR+kkQ7XRqVazE/m+scQ3l3ShXqjdKEY3VyIlS5R020P081QFg+SksS0odPaHq7fiqpp9xcSlVSzznK+r16AU4XjCXkwD0bFY+eXcZeCNOBT8F4M9jjyF6ZpsVBrdzv0NLXNDmfXFs0Ysrsu9aZloEDJygP3KoP2je+9vqULkSvj705Wp4SI5kR8Z+/9Yp3pXwiBw7IlWh+2eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIIVH0CgE+sV6ZvK7PbvLbq+K/isB0bAXgNymdKZQ7c=;
 b=sxon2JbT1p19bnhnwQc7wgaYZ2oT2UysGclFVKLwNdrdsJ+tucHsCZZSQSFiMKaOj7kpBTCg9tIHEGkNDz6stnQgfs1NUyezWxPWPe1Cn+Q/QVxez8Ixqs/xrxM5P8BEN1eldfx0AA/6GuhLhzqIHmkWC/2jYrJqxt9hHRSWRLvl/UFaFMWe/Irxyd2OPvhLPM3Bbk/jyTsE7AsisEMdLnMdm1vwWSAZ0WYExx7udTnFTt1e9CjgGHnpp9yS7lkG3ZA4plt6GCpCEpK3dlr5T0lirsM7JrgyMBrT6kX7/rlLDgizvvfViCFk8eeeSbzQpb6SA6TsS4oPBtwaW1Pd7A==
Received: from PUZPR06MB5747.apcprd06.prod.outlook.com (2603:1096:301:f4::12)
 by TYSPR06MB7207.apcprd06.prod.outlook.com (2603:1096:405:8f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Mon, 8 Jul
 2024 09:48:48 +0000
Received: from PUZPR06MB5747.apcprd06.prod.outlook.com
 ([fe80::d3a4:b94e:29d0:29e5]) by PUZPR06MB5747.apcprd06.prod.outlook.com
 ([fe80::d3a4:b94e:29d0:29e5%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 09:48:48 +0000
From: "Arjunan, Srinu" <srinuvasan.a@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: RE: [isar-cip-core][PATCH v2] kas/opt/expand-on-first-boot.yml: add
 an optional expand-on-first-boot
Thread-Topic: [isar-cip-core][PATCH v2] kas/opt/expand-on-first-boot.yml: add
 an optional expand-on-first-boot
Thread-Index: AQHazJU/JLgAX4DxdESnNcpNtSkIwLHsnr0w
Date: Mon, 8 Jul 2024 09:48:47 +0000
Message-ID: 
 <PUZPR06MB5747DEDBB966921AF4CF40C488DA2@PUZPR06MB5747.apcprd06.prod.outlook.com>
References: <1d3cd14c-24a1-47cb-b48c-b9a711491702@siemens.com>
 <20240417153712.104378-1-srinuvasan.a@siemens.com>
In-Reply-To: <20240417153712.104378-1-srinuvasan.a@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-07-08T09:48:45Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=f9d462e4-0a37-436a-9fca-f860ee4b2368;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5747:EE_|TYSPR06MB7207:EE_
x-ms-office365-filtering-correlation-id: 492d072a-30c9-4882-e9f8-08dc9f332a3c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Dgb5SsYtWniVSdTS9aOxxoIBmjyV2GD5/QRZiskqR3hZ9KXZXKHyIeAvpsHv?=
 =?us-ascii?Q?lkSAqsHp89x73Z23/fnpvwRu1wZXs9tg7uRcNrfQbjzWfNsu4v3AWXIBQPkE?=
 =?us-ascii?Q?Nvm+FtliuX3OWBZ1bhqQTKrh5VBl/xTBb2mVBRTs65xGY0vhi3C7EA6pXSKw?=
 =?us-ascii?Q?6258jcsFp94RCnM/lPZMYnkxMzn8Z0084pWztRYZPt6XJvED1rYDubRGNETp?=
 =?us-ascii?Q?+K6UwU3l0pzjswUeHuoapw05aD8C3Gh30XEmLWPZr+k6noN/nHmepW1cdh1O?=
 =?us-ascii?Q?bEOHzANYP5+F5RPhI/s9QmE3CW49MXN/o6ZvPSr/bQUVP/wR9RMh2bMJANOh?=
 =?us-ascii?Q?sWIl81PtjZbJJAUwx7HUrWYU5om+XmCRZyHeVvXRhnfEwY+CPVzIo+yAxF/8?=
 =?us-ascii?Q?GWv4ZAfetB4otlw73JzLLr6tODCQQPwmHErpLec0Nv0/zLraeM+7q/AuE2SS?=
 =?us-ascii?Q?xBPwIq2uH5U3kYiWUI7+vBA9QPQWDUeGkNMKTN6Z46EzI0WsBN+AEJmXhFMM?=
 =?us-ascii?Q?JhxQ7qABcvjsj+Y22f1q6qJ8OG/Ogac0fbbJi+etMPD0bPd1lEcF2kDT1TQ/?=
 =?us-ascii?Q?Z1xrID5Xainb26YyMKU8lZKAlG5bRS9bkLeC2Quc7+DBOQi5SESFdumBTac1?=
 =?us-ascii?Q?wIgB+cbH17enPxvmEk6fO4sx1TPNOTUo9BGDodgBkUlFklUxEyPxwjgU4Svp?=
 =?us-ascii?Q?0hh/xg7xv3ey7sZLog/fAHL/3+TIrfWITqkFjTKPSNMGRtq8ClyKFFgpnMSX?=
 =?us-ascii?Q?Cz1E1pTJcX4mdcu38tHvnN2VCOtIp2xjU8V2rvCebB46+tR2EU4DZLoCJVlG?=
 =?us-ascii?Q?b4DJPK8sou4FWfkgB8Fx4+kjwbY47ZKg+M3wPWbn7wa4+X01It86QxZDHXaW?=
 =?us-ascii?Q?QpJz3PkFu8e+lsiPOsXzf3SNupcG9IZpibOLb2oL2dsyljmuSB5iBoQksBdc?=
 =?us-ascii?Q?OEQvPDWBD0uLdMn3NBwB6NwqOOg7czuhvkqsEp5myDnS7RnvqDKGIEhPQVJX?=
 =?us-ascii?Q?gLj0RRamYvqF+RscG24Ea2ZdW8vkG8Ssh+b9sbmEDRHidPrrIOiN34wCWGgq?=
 =?us-ascii?Q?iOp82Ns9fCyCSaK8fNkfew2eobehgK/0qFRV5iuvZgU4sERDyOWFFRIja6sd?=
 =?us-ascii?Q?s0IVlPHwfLai84vf64GhZxEJG0Awbn7btgnCiyFtt497D9qjH49mSu/qmRLT?=
 =?us-ascii?Q?Uf9+jtbbI/VdWy883hNDcwjf9jrR1605pshP/g8QDquIpbX5O5coMXumAwEc?=
 =?us-ascii?Q?pFZV1X1f6eKyIAjmzbRRlRnzecLQlvNErYkb7VbBoatczXRUDZfJFjl/D0Uc?=
 =?us-ascii?Q?xDDaWJLrBk5TVqWjgh+vS/dMTa9zUsUV9uFAh/W2k6b/uoGufOMlyroewaN1?=
 =?us-ascii?Q?1hh5jQ9Id1C6NewFq+De0cr8ohqXT7E0LpHiE42yDrgj7a7UDQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5747.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?wBMqTLErOIcFkH5o2zjvMIplrNLChWZXZxEo9gRVnCYFWN1J8jffz//a8w5G?=
 =?us-ascii?Q?O0awmdQRGcMZ8UeG/Hd/V0zAtSwkhz0ekCGqTC/6JG00OAlx4behGqDpoC/G?=
 =?us-ascii?Q?kh0g7OqQUE9FtRXifs86JqK1ZrvRewgP27wjkx+lZzBKSkRsrqAqmFtm5rLr?=
 =?us-ascii?Q?vPz7ZJGDJC/5r3DhQrE4YD/fAso+sZHRADvS7Jvs4HT8es3/yCuDDJhsdvRD?=
 =?us-ascii?Q?h1FmaVbfoUba2drc+PzRKH7VyZsBaaSC9Kg25wrAOhLjdpGGrDoJdulJyNPz?=
 =?us-ascii?Q?6tvCIQ3fGneJhZ0VgeKeNCJbDFjgbvEtPuKIu95XjOT8BTaX47UGf+2jQxnO?=
 =?us-ascii?Q?1Y97oRI3zVVvMkQVKy714P75RHVb6RpIFQJt/2u0fltgOskOkVFU+1f/Mq4M?=
 =?us-ascii?Q?0MC7a6oiJEKkA6YioTArhsiAuym2N/liIALE2+TTtFJJx7wyyptGe/185qgt?=
 =?us-ascii?Q?WJLP0ctdQqeFF16lwrkD2mMPqc9c/5fwl+87P77YtN7YYHirCrCJtuHb0bz4?=
 =?us-ascii?Q?3uWJEItZzJ9QAko4aUYF5/q+R5y9w7CFEqha8on1VQIWpMvArm3X0/90LuBC?=
 =?us-ascii?Q?5h3B1wtU9cMFhAUKu2cT9K7T4Kr1/dqVJuPzC5YNoI2CSE+vVezJs5r31Xx4?=
 =?us-ascii?Q?+PnizsRgDpEamYXPRCWpknT8cMn48KBRJDRQiW+++V2s/mvtv6QGMQaAqSnZ?=
 =?us-ascii?Q?ZMbBbrgseUgHHYRWjwR52vz2McoEijsL2GiyYm7tTAVJt0eW6gga4FRodvOT?=
 =?us-ascii?Q?UNS9ljGvWJbQKh+PyE473TgK6oRsyK0K3L1EnG9T6OP8et7aIv0pST0jtGO1?=
 =?us-ascii?Q?f2aa0xCjS2GEla07s87d42g8zU369bO1sx/fakhtjKvVah9KVDPYhT07yL5E?=
 =?us-ascii?Q?BOSnDqZduzuPy0BuJZb1rL0gW81LRDVZbPyQ6k5rrO9st5UDsh1RZo0wHEeS?=
 =?us-ascii?Q?nVuxSQffi263Mcpk3XRnoece066btebuV58UMu6tRIk+NSNRPY9VrFRMVgYy?=
 =?us-ascii?Q?5iOswEREeeyF88sXVTHSLQ12vU/spnMYKxAXZKiGy5mrtO4bX1aAZ3hF9+l0?=
 =?us-ascii?Q?0FM93s2uDe3hIFfo04yBsQsLbNhjl3GP5StFpGibGyACQPyy1t8cHqtd2WQF?=
 =?us-ascii?Q?3TS3Cfd4yGMGcnKhMULxC/ZnGgIEjsb0+dOjT+vm30A2PgcM2RUfEKUhWtVF?=
 =?us-ascii?Q?knKfc/dZdrzc/orHluW58iqwpmS5HguA8eMJ6l+AE0gvG3ISlw/17jJAt41x?=
 =?us-ascii?Q?JnOXc4QmF434SRE+SSo7cxxWBMjLjzccs1gM0rRcU9NoV/XbRj8qcEgTImBU?=
 =?us-ascii?Q?BzfebZPPKCSHwxGT6JHXaGkdHT0hVSfUzxGsE5i4dE7EuPKWDG5TEaFKt75p?=
 =?us-ascii?Q?Ss4VHuSwRTf275c7CXsIh66gXprjXh52kZ8SmdXhTQwtQoPpCPmwTMnQGtPF?=
 =?us-ascii?Q?UR3lxummdKjwZDb5+rXY81CFZ3lmbzYw3X1HDfKjiT1mwOLdhPuqyDOC7HO1?=
 =?us-ascii?Q?FdjYu/72qn3WOIsb7R0dX6SRsgR+u8k6RnwAPwqf6Qx4jnao4gQAQR/6NRZ9?=
 =?us-ascii?Q?WF6bBIUmO9lUERU3RxZOW9dmNTqYMe4SzCORxgw2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5747.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492d072a-30c9-4882-e9f8-08dc9f332a3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 09:48:48.0194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2U4CV89idU/zVYWhNC+gqGbz8vOKcc7MpNSoyPd3k6ytnt9we+/w+U4YrtirdzqLQh9aIoDXVCL/Pk5HcAKclTWMmzRTeyYFrSDNnvNualo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7207
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jul 2024 09:48:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16429

Hi Jan,

Any Update on this patch?

Thanks,
Srinu

-----Original Message-----
From: Arjunan, Srinu (DI CTO FDS CES LX PBU 2) <srinuvasan.a@siemens.com>=20
Sent: 17 April 2024 21:07
To: cip-dev@lists.cip-project.org
Cc: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>; Arjunan, Srinu (DI CTO FD=
S CES LX PBU 2) <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH v2] kas/opt/expand-on-first-boot.yml: add an=
 optional expand-on-first-boot

From: Srinuvasan A <srinuvasan.a@siemens.com>

Add expand-on-first-boot package as an optional file, this would be helpful=
 to understand/debug the expand-on-first boot specifically w.r.t LUKS suppo=
rt, this systemd service expands the last partition on a the boot medium to=
 the full size of that medium and then deactivates itself.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 Kconfig                          |  9 +++++++++
 kas/opt/expand-on-first-boot.yml | 17 +++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 kas/opt/expand-on-first-boot.yml

diff --git a/Kconfig b/Kconfig
index 96f590a..ec7c686 100644
--- a/Kconfig
+++ b/Kconfig
@@ -151,6 +151,15 @@ config KAS_INCLUDE_DEBIAN
=20
 comment "Image features"
=20
+config EXPAND_ON_FIRST_BOOT
+        bool "expand-on-first-boot"
+        default n
+
+config KAS_INCLUDE_EXPAND_ON_FIRST_BOOT
+        string
+        default "kas/opt/expand-on-first-boot.yml"
+        depends on EXPAND_ON_FIRST_BOOT
+
 config IMAGE_TESTING
 	bool "Test extensions"
=20
diff --git a/kas/opt/expand-on-first-boot.yml b/kas/opt/expand-on-first-boo=
t.yml
new file mode 100644
index 0000000..03d666b
--- /dev/null
+++ b/kas/opt/expand-on-first-boot.yml
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Srinuvasan Arjunan <srinuvasan.a@siemens.com> # #=20
+SPDX-License-Identifier: MIT #
+
+header:
+  version: 14
+
+local_conf_header:
+  package-expand-on-first-boot: |
+    IMAGE_INSTALL:append =3D " expand-on-first-boot"
--
2.34.1



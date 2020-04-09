Return-Path: <SRS0=A+aE=5Z=lists.cip-project.org=bounce+64572+4570+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AF7C2BA1B
	for <cip-dev@archiver.kernel.org>; Thu,  9 Apr 2020 06:04:57 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA9720757
	for <cip-dev@archiver.kernel.org>; Thu,  9 Apr 2020 06:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="tsqxlWsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA9720757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4570+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HAAQYY4521723xPQAZ0cUpb4; Wed, 08 Apr 2020 23:04:56 -0700
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.107])
 by mx.groups.io with SMTP id smtpd.web12.3877.1586412295272384903
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Apr 2020 23:04:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJO/otSiQig/scopgvpO4InRvjA/gLpJeRRSqAldQpKDl6GM5cq/8ZfbZi5bZAeHlYO9ZoN7OJb60kx8cuunDGfLSKkbFPtRauG7FGISLlahS3xlsb5REPG3KSQIElsr6wR/S8f0qa4d3CP5RmtySXO8S1GyQiL8XpjCPOultEC7r1nU+6V0DQP+IZsTzLQEJ9emfeHgh1N1+Yus4Yhh5uhvNDV/FeQC3sYX4gEjdAkIEyUjz+2I6vjjR5Twe1z6INkUUEq7xNbyLQhu4bpv/3zVL7yAgd1U2O0rME3dS7sJPTJsoxSJ0SUAQA3c2M9gVisCe3UQjIZwK7MmqYiu0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qg/vLwqTJ9u3z2r6eAgvvpTfgDRY7EJ9yipH/1GILQs=;
 b=A7zAKzkICk9KHpunqZ/o26PaaQPJg29ZzgDLvVRq1xUFbgbN+Y1wkM1Ry+YWKSDR1PCqW+6epAe/8SlTbwV6jGi1nxdG7IkorE8GujsML+Pd9OfMnb+NwJ4itxFB49X15+Ps69Hz3bBYpJpe3rQ8IpEwudZKA/E9a75KOcgpt1b+g+ve9/fQp+TvmiNOfbmsUubiiWTAqwp5PmMMdBUd3ISgYnG8mApBbEUNV82ISa2256CUeyGkaLckBFM5GxpznSNdHd18/n7Yr3aLxuirtDA1+iqJq7goaC0Zf7YOVn5XM9CQ9MoA8lBvXW/7UUHep/SL2l4zGklI2CRxu8JC4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (20.179.172.148) by
 TY2PR01MB4537.jpnprd01.prod.outlook.com (20.179.171.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.17; Thu, 9 Apr 2020 06:04:52 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::e845:c7d4:4f:c3cc]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::e845:c7d4:4f:c3cc%7]) with mapi id 15.20.2878.023; Thu, 9 Apr 2020
 06:04:52 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <daniel.sangorrin@toshiba.co.jp>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [cip-dev] CIP Core target EOL dates
Thread-Topic: [cip-dev] CIP Core target EOL dates
Thread-Index: AQHWDi+WZUh8VszNUEeNfK5rzK+HSqhwRpWw
Date: Thu, 9 Apr 2020 06:04:52 +0000
Message-ID: 
 <TY2PR01MB49726008788B51961ACCB8A2A0C10@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: <871roxxm84.fsf@kokedama.swc.toshiba.co.jp>
In-Reply-To: <871roxxm84.fsf@kokedama.swc.toshiba.co.jp>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 93a34d14-fdbe-4030-39d1-08d7dc4beb73
x-ms-traffictypediagnostic: TY2PR01MB4537:
x-microsoft-antispam-prvs: 
 <TY2PR01MB45373273EC71F1CDDA6DA2EDA0C10@TY2PR01MB4537.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 y3dHLo6YuHM+KU9guO2KRfSJQkOZOSkIAiWqZ8TLoh4gznIm/XC7Kb9N76Ib/0odlMwGy21Oy6X68s+qwu3s5ApRc8ntE1bioQUznLkSSlPQ+oU2TTcAdgqbKfZeL5MbjecjffPJBD9dgDiJ9vDc+24Ug+zbOglblIO9Yq/+ZEQa1VZoVMGuXw6CmtCt+wI7tcxHTbsooL8vnSjab1ZMPVhdbJfDI7uzIFUEZ0NqLlw9imgerwlsiCz9GHYfOGnHREmcH+UcvUYRvY91ocjwK58n2JS168tiLf+9ahFN3mp8wB5PgNHM2fEP12PX4PNWHwNRnI3HHghyJWCUvmcPUNPfuNxeq5YN6q2lBansTYAds9MKyhGA4l+11FTklCOObSBuHlB4vo8H/nGzmVtXvKHjerkeHvjBk+/OtKd7GRkQSsTvsvftldsuKjrSebS6xsDbmGpdgY/+3uqpxordvPo32qmn8W3NE4hBDINFosp4WMX0/wKpFd9dQAmvhMLJCrIVrEojL43x0cov5NEgNw==
x-ms-exchange-antispam-messagedata: 
 EPsoh8e3u9pqKIAFHE1mdsFOda9mEXKvCKjd4n5mFxXj5LdMOw8cMn0TIi+EGduISop5a5N7PpLg1OoIYfTx+fae7F3FBu90ncfnfqJo+eCA9kOTEATrJj9rHl+1G5NFKO/RemZtFblvlXB1TdO4Cw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a34d14-fdbe-4030-39d1-08d7dc4beb73
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 06:04:52.5490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pZKaLpkkfc0nlA1Xo3/gIH28UkzmIxFVsDMhLDhfZ4vQ3Phmqit9d6RrC87HBwMWS+G3dj6hgzBTY+pEAJnOfDrVsPEOBIb8nZ6vW9tqBV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4537
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: S1ZZK0DoFaBkL2ymnRDppasLx4520388AA=
Content-Type: multipart/mixed; boundary="I8CzM32YPYNHDnC9AXmM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1586412296;
 bh=A35h0D6D1OBO1ST+22MglYojDwRymllYcSNn/cDhNS4=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=tsqxlWsQ8vbfu6JrHEUfNUm0zF+ftOmjO9y1+bWQcputvcXKOCtv7XeDHUCASWPXm74
 rXl60zT71sPIyfjrEqNiJrlaXmbfssXQ8OPfPcvwZ69U9xv9Xk6Rk2nARMoFU1j+9VUqc
 oO5KrhRJUjhGDegjbAR42SyU0csBvjPNriA=

--I8CzM32YPYNHDnC9AXmM
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Punit-san,

Thanks for initiating the discussion.

Regarding the EOL of "v4.19" x "Debian Buster", it should be "2029-01-11" i=
f we follow the following rule.

>     earlier of (Kernel, Debian) release date + 10 yrs

- SLTS4.19 kernel release date: Jan 11, 2019
https://docs.google.com/presentation/d/1R2r7_hVijKN1VTuVc92IE4U94p9AUU90bMF=
UoGRroUI/edit?pli=3D1#slide=3Did.p7
- Debian Buster release date: July 6, 2019
https://www.debian.org/releases/buster/

> Ideally, the dates for the Core components should be aligned with CIP mai=
ntained kernels but there doesn't seem to be any public documentation for t=
he CIP kernel EOL dates. Let me know if this is written down somewhere.

The projected EOLs are stated in the above document.
Regarding the web site, I noticed that the following page is not updated.

https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipkernelmaint=
enance

I will discuss this inside the kernel team.

Best regards,
--
M. Kudo

-----Original Message-----
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of punit1.agrawal@toshiba.co.jp
Sent: Thursday, April 9, 2020 2:27 PM
To: cip-dev@lists.cip-project.org
Cc: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>; Kazuhiro Hayashi <ka=
zuhiro3.hayashi@toshiba.co.jp>
Subject: [cip-dev] CIP Core target EOL dates

Hi,

CIP is planning to support the Kernels + Debian Rootfs combinations marked =
with 'x' in the table below.

+----------+----------+-----------+-----------+
|          | Debian 8 | Debian 9  | Debian 10 |
|          |  Jessie  |  Stretch  |  Buster   |
|  Kernel  |          |           |           |
+----------+----------+-----------+-----------+
|   v4.4   |    x     |     x     |           |
+----------+----------+-----------+-----------+
|  v4.19   |          |     x     |     x     |
+----------+----------+-----------+-----------+

So far, the details of when the support is expected to end haven't been exp=
licitly called out for Core components. It would be good to rectify this in=
 order to set expectations and gather feedback from the user community.

In addition, it will be helpful in estimating the required effort and plann=
ing to resource the projects appropriately.

To start the conversation, I would like to propose the following target EOL=
 dates for each of the supported combination.

Note: All the dates are in YYYY-MM-DD format

+----------+--------------+--------------+--------------+
|          |   Debian 8   |   Debian 9   |  Debian 10   |
|          |    Jessie    |   Stretch    |    Buster    |
|  Kernel  |              |              |              |
+----------+--------------+--------------+--------------+
|   v4.4   |  2025-04-26  |  2026-01-10  |              |
+----------+--------------+--------------+--------------+
|  v4.19   |              |  2027-06-17  |  2019-10-18  |
+----------+--------------+--------------+--------------+

The proposed dates have been calculated as

    earlier of (Kernel, Debian) release date + 10 yrs

The choice of duration (10 yrs) is arbitrary and should be adjusted based o=
n requirement and available resources. Also, some of the combinations could=
 be dropped if there are no users for them.

Ideally, the dates for the Core components should be aligned with CIP maint=
ained kernels but there doesn't seem to be any public documentation for the=
 CIP kernel EOL dates. Let me know if this is written down somewhere.

All feedback welcome.

Thanks,
Punit


The relevant Debian[0][1][2] and Kernel[3] release dates are copied below f=
or reference.

Debian Release Dates
--------------------
Jessie  - 2015-04-26
Stretch - 2017-06-17
Buster  - 2019-07-06

Linux Kernel Release Dates
--------------------------
v4.4  - 2016-01-10
v4.19 - 2018-10-18


[0] https://www.debian.org/releases/jessie/
[1] https://www.debian.org/releases/stretch/
[2] https://www.debian.org/releases/buster/
[3] https://www.kernel.org/category/releases.html

--I8CzM32YPYNHDnC9AXmM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4570): https://lists.cip-project.org/g/cip-dev/message=
/4570
Mute This Topic: https://lists.cip-project.org/mt/72890803/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--I8CzM32YPYNHDnC9AXmM--

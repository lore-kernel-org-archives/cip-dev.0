Return-Path: <SRS0=H/VZ=52=lists.cip-project.org=bounce+64572+4574+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009F9C2BA19
	for <cip-dev@archiver.kernel.org>; Fri, 10 Apr 2020 03:00:41 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 600C320936
	for <cip-dev@archiver.kernel.org>; Fri, 10 Apr 2020 03:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="O+kvbeqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600C320936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4574+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YzdeYY4521723x8gXEomw4G1; Thu, 09 Apr 2020 20:00:39 -0700
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.112])
 by mx.groups.io with SMTP id smtpd.web12.2595.1586487638288453338
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Apr 2020 20:00:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SO74K0nuZFR7KO663pY353bLvcgumFepJ1ntAHprQdkS4J9U5i+OP+/DqJsF4MF9vS61SW1CAbbuI2sDcTPYeMbuAxTpwrJ/ZSJQCJjZzlmCf+4ttrAgIjD6gpldgszMx9hctYpgsa3Y+SPhX0Y0JMb+HTKSjMMRIfbDndC0az6mLA/1NY3pCUJ0Zbh7RT8FzCtDrhwHBjJW/a+4YqorZUVWva/HBhuNF37GbltjaDD+5WiCYyRMkj7k0tOIpoIsiqGDjNRMxZN33kI6WcfwWB528vrOLi0bDW+XQcJOkEqW1AqQuzEy+VUpqkJ/RIHW8mLk1eH/Rqmy1VSbnPqksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdG8jA0+P1llMKrVvbLBpEop0kOLsDx6VI/S0bbjJcc=;
 b=T6KOwUIaBrNCcuEMiZxppffT0QcB+oGjRx3XCrkY4Iz0Gw8GPhLjmCR8PBPYf0+9ewbrTveZKBhQtF+Sz2Xx2Zg5/HaCRgLKYLQZZs67NfPtftj/4lgKIsu8TPL5yfPhV4+aVq08f6XVPxe12Ckp2/mucglk+9RuA1Mdly/0UDEzk9sHpnsCOgrd5y2tJpPJjW39k9039nW4fdFphLM5HMdZkKy+ObzUZJKlfiOf/O8tGfAg9QLSu01cjgVLjQMatGYVv+x4BvxGEAwpHhGsfxG3BjL4cjK4AvqZHMy2ranUhikVuAIvR69b+MkF08filPOMWAZMhPnar+/hCewsNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (20.179.172.148) by
 TY2PR01MB2012.jpnprd01.prod.outlook.com (52.133.182.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.17; Fri, 10 Apr 2020 03:00:24 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::e845:c7d4:4f:c3cc]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::e845:c7d4:4f:c3cc%7]) with mapi id 15.20.2878.023; Fri, 10 Apr 2020
 03:00:24 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <punit1.agrawal@toshiba.co.jp>
CC: <cip-dev@lists.cip-project.org>, <daniel.sangorrin@toshiba.co.jp>,
	<kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [cip-dev] CIP Core target EOL dates
Thread-Topic: [cip-dev] CIP Core target EOL dates
Thread-Index: AQHWDi+WZUh8VszNUEeNfK5rzK+HSqhwRpWwgAFVLQeAAAbLgA==
Date: Fri, 10 Apr 2020 03:00:24 +0000
Message-ID: 
 <TY2PR01MB497250EBBA0891A39A6B022DA0DE0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: <871roxxm84.fsf@kokedama.swc.toshiba.co.jp>
	<TY2PR01MB49726008788B51961ACCB8A2A0C10@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <87mu7kw128.fsf@kokedama.swc.toshiba.co.jp>
In-Reply-To: <87mu7kw128.fsf@kokedama.swc.toshiba.co.jp>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eaf1d14a-e879-45da-f283-08d7dcfb50da
x-ms-traffictypediagnostic: TY2PR01MB2012:
x-microsoft-antispam-prvs: 
 <TY2PR01MB2012B15585576F5E0C0C5E36A0DE0@TY2PR01MB2012.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 E1bBDBSAVEVRQpZAOWc4wxxP362f6IWC279C5YfWoFFrelPHp+NqTfKxi84loK0YPMFQdVvOQbk43I0k/DT2ogPIZdk5U139CsxSR7MtY1MSH54jjWGeissiYKPTJTACqF2BIQZ2kiq36MCMUKa3JCEh6xKQgCbevn94ifQeQaE56mllKJOBjA6hufZK5DRSvAwNeBkdDUOI4xzTZcp1wEncpGVXG3qAkqoh0D8CJz5l7e+eVHz/gl3aAgKiDEe8g/2gs9FaruuxvY67jirpsVU0jXf08mZxcwSgSSd5DqntY5UixlMAxfPAB/umr6sNfguodBYlyW9gqR0FdlynalAP2he9hVy42rdZZ6Z/jXuHuge/YYy/q558ZjVQJ7cPN79xdifIwA3e0P1UwcjzDKajOLUF9XFWsm6Bm0/UHQM4BTCmN9z3ybNm2v5ir9Gu64/TU+TQm8Ft0+WyYSVH0AjXvoTso2BzuIvm+UC79Tz9CxuMCrSe3tXFh0gl3l1Bcri3YjHyK3a5+e+NnIVECQ==
x-ms-exchange-antispam-messagedata: 
 pGczV0ooK7zUOebNLly9Pk1ggwq5HQ0UsDhkiMOSepUuOzVKveGwfbfRzcxQi/aclPNOYGg+LRhAFSPqZ63dftS2DhgpaVioJjlsJxrroO+LKXnvjsua+8eagFZxFcgfAl/6z+vV4pqR8UwyZW+Gtg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf1d14a-e879-45da-f283-08d7dcfb50da
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 03:00:24.6773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SeMper3cogSP5MxCDc2VzwPsu3tuyOfsUepWLU1vk0iIc+GeM7V1Fm6pF5+/5RoplOCZauHv4vSHwAxuFaTrxzytJiGlHYbbK+9T/IOCYwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2012
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4Ri4zj7qq9VOKvx7jfoOTLASx4520388AA=
Content-Type: multipart/mixed; boundary="JBUiyyJO1uiB94JPIYPU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1586487639;
 bh=Bvalc7WY8WGRLDLnwjimevVcCKGszm2Ae25cJ73LyHs=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=O+kvbeqbtM8TRKmSIrzfvE9S9svTw9qa8vG+WjX27MxmmyhW2wmJeTSpvOwL5VSqB0U
 NV2mSDMYXXF1buyP3vNDjOdhtxS+7ou5qgWv8pvgc4wbJaJjZKtpL7es03wtZNkl2D4tu
 4I6dMlvVVgVJOYXgyUxhnOU3Nj7bmHVHwE8=

--JBUiyyJO1uiB94JPIYPU
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Punit-san,

I also calculated, and my conclusion is the following.

Debian
- Jessie	=092015-04-26
- Stretch =092017-06-17
- Buster	=092019-07-06
CIP SLTS Kernel
- SLTS4.4	2017-01-17
- SLTS4.19	2019-01-11
* https://docs.google.com/presentation/d/1R2r7_hVijKN1VTuVc92IE4U94p9AUU90=
bMFUoGRroUI/edit?pli=3D1#slide=3Did.p7

Combination	Earlier date btw two
---------------------------------------
4.4 x Jessie	2015-04-26 -> EOL: 2025-04-26
4.4 x Stretch	2017-01-17 -> EOL: 2027-01-17
4.19 x Stretch	2017-06-17 -> EOL: 2027-06-17
4.19 x Buster	2019-01-11 -> EOL: 2029-01-11

+----------+--------------+--------------+--------------+
|          |   Debian 8   |   Debian 9   |  Debian 10   |
|   SLTS   |    Jessie    |   Stretch    |    Buster    |
|  Kernel  |              |              |              |
+----------+--------------+--------------+--------------+
|   v4.4   |  2025-04-26  |  2027-01-17  |              |
+----------+--------------+--------------+--------------+
|  v4.19   |              |  2027-06-17  |  2029-01-11  |
+----------+--------------+--------------+--------------+

By doing this, I felt dizzy... :) So I would appreciate it if you can doub=
le-check.

Best regards,
--
M. Kudo

-----Original Message-----
From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>=20
Sent: Friday, April 10, 2020 11:02 AM
To: =1B$B9)F#!!2m;J!J=1B(BCTJ=1B$B!!=1B(BOSS=1B$B;v6H?d?J<<!K=1B(B <masash=
i.kudo@cybertrust.co.jp>
Cc: cip-dev@lists.cip-project.org; daniel.sangorrin@toshiba.co.jp; kazuhir=
o3.hayashi@toshiba.co.jp
Subject: Re: [cip-dev] CIP Core target EOL dates

Hello Kudo-san,

Thanks for your comments.

"masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp> writes:

> Hi, Punit-san,
>
> Thanks for initiating the discussion.
>
> Regarding the EOL of "v4.19" x "Debian Buster", it should be=20
> "2029-01-11" if we follow the following rule.
>
>>     earlier of (Kernel, Debian) release date + 10 yrs

For the calculation, I used the upstream kernel release date as reference =
but we can use CIP kernel release dates from your slides.

I wasn't sure if CIP maintenance is based on upstream release or CIP relea=
se.

With that update, the proposed dates look like -

+----------+--------------+--------------+--------------+
|          |   Debian 8   |   Debian 9   |  Debian 10   |
|          |    Jessie    |   Stretch    |    Buster    |
|  Kernel  |              |              |              |
+----------+--------------+--------------+--------------+
|   v4.4   |  2025-04-26  |  2026-01-10  |              |
+----------+--------------+--------------+--------------+
|  v4.19   |              |  2027-01-17  |  2029-01-11  |
+----------+--------------+--------------+--------------+

Note: There's a typo in my original mail - for Debian Buster (v4.19) the E=
OL date should've been 2029-10-18.

[...]

>> Ideally, the dates for the Core components should be aligned with CIP=
=20
>> maintained kernels but there doesn't seem to be any public=20
>> documentation for the CIP kernel EOL dates. Let me know if this is=20
>> written down somewhere.
>
> The projected EOLs are stated in the above document.
> Regarding the web site, I noticed that the following page is not updated=
.
>
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipkernel
> maintenance
>
> I will discuss this inside the kernel team.

Thanks. It would be good to publish the information on CIP website. It's e=
asier to find and reference.

Once agreed, we should do the same for Core components as well.

Thanks,
Punit


[...]

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On=
=20
> Behalf Of punit1.agrawal@toshiba.co.jp
> Sent: Thursday, April 9, 2020 2:27 PM
> To: cip-dev@lists.cip-project.org
> Cc: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>; Kazuhiro=20
> Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
> Subject: [cip-dev] CIP Core target EOL dates
>
> Hi,
>
> CIP is planning to support the Kernels + Debian Rootfs combinations mark=
ed with 'x' in the table below.
>
> +----------+----------+-----------+-----------+
> |          | Debian 8 | Debian 9  | Debian 10 |
> |          |  Jessie  |  Stretch  |  Buster   |
> |  Kernel  |          |           |           |
> +----------+----------+-----------+-----------+
> |   v4.4   |    x     |     x     |           |
> +----------+----------+-----------+-----------+
> |  v4.19   |          |     x     |     x     |
> +----------+----------+-----------+-----------+
>
> So far, the details of when the support is expected to end haven't been =
explicitly called out for Core components. It would be good to rectify this=
 in order to set expectations and gather feedback from the user community.
>
> In addition, it will be helpful in estimating the required effort and pl=
anning to resource the projects appropriately.
>
> To start the conversation, I would like to propose the following target =
EOL dates for each of the supported combination.
>
> Note: All the dates are in YYYY-MM-DD format
>
> +----------+--------------+--------------+--------------+
> |          |   Debian 8   |   Debian 9   |  Debian 10   |
> |          |    Jessie    |   Stretch    |    Buster    |
> |  Kernel  |              |              |              |
> +----------+--------------+--------------+--------------+
> |   v4.4   |  2025-04-26  |  2026-01-10  |              |
> +----------+--------------+--------------+--------------+
> |  v4.19   |              |  2027-06-17  |  2019-10-18  |
> +----------+--------------+--------------+--------------+
>
> The proposed dates have been calculated as
>
>     earlier of (Kernel, Debian) release date + 10 yrs
>
> The choice of duration (10 yrs) is arbitrary and should be adjusted base=
d on requirement and available resources. Also, some of the combinations co=
uld be dropped if there are no users for them.
>
> Ideally, the dates for the Core components should be aligned with CIP ma=
intained kernels but there doesn't seem to be any public documentation for =
the CIP kernel EOL dates. Let me know if this is written down somewhere.
>
> All feedback welcome.
>
> Thanks,
> Punit
>
>
> The relevant Debian[0][1][2] and Kernel[3] release dates are copied belo=
w for reference.
>
> Debian Release Dates
> --------------------
> Jessie  - 2015-04-26
> Stretch - 2017-06-17
> Buster  - 2019-07-06
>
> Linux Kernel Release Dates
> --------------------------
> v4.4  - 2016-01-10
> v4.19 - 2018-10-18
>
>
> [0] https://www.debian.org/releases/jessie/
> [1] https://www.debian.org/releases/stretch/
> [2] https://www.debian.org/releases/buster/
> [3] https://www.kernel.org/category/releases.html
>
>=20

--JBUiyyJO1uiB94JPIYPU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4574): https://lists.cip-project.org/g/cip-dev/message=
/4574
Mute This Topic: https://lists.cip-project.org/mt/72890803/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--JBUiyyJO1uiB94JPIYPU--

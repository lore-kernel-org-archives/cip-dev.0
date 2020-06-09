Return-Path: <SRS0=T9so=7W=lists.cip-project.org=bounce+64572+4772+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770A5C433E0
	for <cip-dev@archiver.kernel.org>; Tue,  9 Jun 2020 03:54:52 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD7A2078C
	for <cip-dev@archiver.kernel.org>; Tue,  9 Jun 2020 03:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="L/CuDRp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD7A2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4772+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ZUhaYY4521723xe2q4XD0SBN; Mon, 08 Jun 2020 20:54:51 -0700
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.89])
 by mx.groups.io with SMTP id smtpd.web10.7540.1591674890164746946
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2020 20:54:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zz9n0y5sAFepxtvNoNQofUu2Y0tvHKclKVo9p87Pw3/BUvNZMVwBFOkkj5Q4vBWhYYFRs459znzuMhl2ABSqVfg3JGwbT3ZP06SXgm/h535GkczhzUsmEGnx/6JKiE9C5rGnUUpdt/9UL5GhGnU16K/3qYkpSnuXg4OloaCGukkS4ChI9TicjWHx8B71lG+prreCmL6OCOm7XcpXJNYFvVdqxx3+KDMYxS4l3O+f5Hv1veOs6wkEzl2mrL0HauBkZnBG8s5sIk4c0aOhEdByKuRa5GSn+N9JRvso2iqrWdNXSNd6CgkukQ7MavvvtsOz3WcrLfCD1g4vD3oYebwkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSuVN0SU0rLbpzp4dALHBj2MmQfqfElOgQVuD2Q2PGE=;
 b=BxJsCGopUc9ZAU/9GN+ADaVkHB9N6aRAMqAJcUJkYOhQWvnXp9RIlXUlkfE7LMudXJWnYxRMpLXW4oLIg6U4guU5YI+DIOgilSQWAtqEOseX5M9yNoicPbJS8qkUdEA5DB7csBkqO28U07scyjgyL/JznFhluCgLYSHUhJtKuE2GgYu3vzpJeKXHzjTLY3YEKsjBV/O4tz7idxzmgE7S6GX6GwFOIojiM31OIeyYbOzpwzvqV6CrRRNugFvGmfx+t4dCpwFo3w2Ki9CSGnPdwpMyo7Za/Kr1F1m7aVLtP3SDNfayKRA3hxJcJ+Ee5hFQFfIRuKz5ezRxb/ocXfyCdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
X-Received: from HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 (2603:1096:202:22::12) by HK2PR01MB3091.apcprd01.prod.exchangelabs.com
 (2603:1096:202:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 03:54:46 +0000
X-Received: from HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 ([fe80::712b:170d:f873:68a3]) by HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 ([fe80::712b:170d:f873:68a3%6]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 03:54:46 +0000
From: "johnsonch.chen@moxa.com" <JohnsonCH.Chen@moxa.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/3] ARM: dts: am335x: Replace numeric pinmux address with macro defines
Thread-Topic: [PATCH 4.4.y-cip 0/3] ARM: dts: am335x: Replace numeric pinmux
 address with macro defines
Thread-Index: AQHWPXz3m8Oq8l9Bi06Yy7524OP+n6jOiWKggACzqICAAFqyIA==
Date: Tue, 9 Jun 2020 03:54:46 +0000
Message-ID: 
 <HK2PR01MB32819F56BCF1EA97DF34F5E8FA820@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
References: 
 <HK2PR01MB3281084A8DA1542518F65818FA850@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
 <HK2PR01MB32818C637F6FB1F0AE969A95FA850@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
 <20200608213019.GA2851@amd>
In-Reply-To: <20200608213019.GA2851@amd>
Accept-Language: zh-TW, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.51.145.16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c55f4336-666c-44c8-fb76-08d80c28da01
x-ms-traffictypediagnostic: HK2PR01MB3091:
x-microsoft-antispam-prvs: 
 <HK2PR01MB3091BF1409303D29F3901110FA820@HK2PR01MB3091.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 ZYwpBJi1lg2UP2gf0oozoxmhG3TFveBUZWlo4B7hUB93WMbfx4szn9VyvzScwXvHRSLOo9CW2AhfqydZMZxknjObj2m4mNaSbALQg1rETqLEotL7CpmD/oKdgQ+PCnaF8ar4U+Cg4AeLwvPKyiCh8HTTD7zMMkzZ9uqldvmlpdrGNbkXAQN/9QSrn2n8/9t9Il7o0rfKq4Mn35KhyZF8zWnzvCBdiVT66XjnZjqR3aX0w8O/2MzmoCbhcRmRWs6eaoQGuGB5N2Z2BjOL8X29Iddh37CCQE/o1CkXgq26Oljvf65SQtqpjpAa07BHTA6v
x-ms-exchange-antispam-messagedata: 
 Deoe4eYq/WqFBn7rr/q4lt2U1Ifn1q7dqbBG4FJdsYG1xwPGqrsnCrWpiiFSTOLGsRd2bjf5mtERA86aC0R0Qeq2SZNNatGDxV/t5/Ek+hEPUj7iyyLg9QUtRJFyYT23CYAOnDJbXnYYPsHcvwtPLHGf+LYwPlFZ9ttE7yiXr2j0z14SZsFoMHcmHV1Kex9hYLuyJse6VqH0sqqQirZ8VzGy/VkaxRLRT3rvkJHs7YXsCztOReisdqcBHkjc00soSIBgjsggGm8lVSQVsWEyYy/Yj1T32w4nFN65S9AVzn+yG++u15ut2I3vQK8386bFef5D1rnxox+/VzQ4Y3JdjpHkzPnfV7B5xdbdOPL/1mKOZ1CfKH1uJslUi7/2DpGVyerpKNZzeACqnXgwdVcuMoaTOjc3da9hP6GES57AFiQIg/u699baXnhxRStDKpqrS3e502cxg9QpzjXkTOmraRdjWyNoivzA0aszWGNihVk=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55f4336-666c-44c8-fb76-08d80c28da01
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 03:54:46.6624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1hrjztahRM34N3tbj4KIXTSXi9CRg36EwMd/hy3iBb3iLOoQvttUlmJ80LOQzePZubqPXtkc21nvojDDpzfsBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR01MB3091
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: BHT3OM4unjRVtslYXlxNpSesx4520388AA=
Content-Type: multipart/mixed; boundary="j55rSJa2AVDeIYy1uqTj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591674891;
 bh=ENZLMdzINqWGmSu2c8kzD+63LHvOLpnxr3R+C8bB0FU=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=L/CuDRp/iFShL38rV0zzUQzJnBOkewaEESBE4625yWArsXOKSdg0SNy7v4f/tIKP3Jv
 8tVo26N6wWx9kEyCt5xSEX7v4zLVU3aXlzT8y7yveQiJGZThvsMRHtfXEAlO+70DBC69F
 isqMJqb8J3NMkpifpOV1voWigFzpkxVD9z0=

--j55rSJa2AVDeIYy1uqTj
Content-Language: zh-TW
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi,
>=20
> Hi!
>=20
> > > Tony Lindgren (1):
> > >   ARM: dts: am33xx: Added AM33XX_PADCONF macro
> > >
> > >  arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts | 116
> +++++++++++-----------
> > >  include/dt-bindings/pinctrl/am33xx.h           | 130
> ++++++++++++++++++++++++-
> > >  include/dt-bindings/pinctrl/omap.h             |   1 +
> > >  3 files changed, 188 insertions(+), 59 deletions(-)
> > >
> > These should be the following:
> >
> > Christina Quast (3):
> >   ARM: dts: am33xx: Added macros for numeric pinmux addresses
> >   ARM: dts: am33xx: Added AM33XX_PADCONF macro
> >   ARM: dts: am335x: moxa-uc-8100-me-t: Replaced register offsets with
> >     defines
>=20
> There's nothing obviously wrong with the patches (and they won't break
> anything but am335x-moxa platform, so they are low risk).
>=20
> On the other hand, I don't see any obvious benefit. Whether we use hex
> constants or symbolic constants affects readability, but has no effect on
> functionality.
>=20
> Do you have any patches on top of these that rely on symbolic constants i=
n the
> dts? Are there any changes in the generated .dtb?
> What is the benefit of this series (besides cleanup)?

Thanks for your response!

If macros of numeric pinmux addresses is used, we don't need to see AM335X'=
s Technical Reference Manual again and again to find out the meaning of eac=
h pinmux address, just check "am33xx.h". Besides, it helps us to configure =
module pin's for different device trees easily. For example of mii, If we w=
ant to configure module of mii pin, we check module in "am33xx.h" can pick =
register names we want to modify. It's hard to remember pin address number =
for the specific module to us.

If AM33XX_PADCONF is taken, we can make sure both of pin's direction and mu=
x mode are actually set, and it helps us to debug.

We have many boards based on AM335x SoC. Some dts rely on symbolic constant=
s and some dts are not. I think this patch series can let us develop boards=
 with AM335x SoC easiler.

> Best regards,
>=20
> Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

Best regards,
Johnson

--j55rSJa2AVDeIYy1uqTj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4772): https://lists.cip-project.org/g/cip-dev/message=
/4772
Mute This Topic: https://lists.cip-project.org/mt/74749053/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--j55rSJa2AVDeIYy1uqTj--

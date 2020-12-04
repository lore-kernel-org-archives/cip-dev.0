Return-Path: <SRS0=QbJH=FI=lists.cip-project.org=bounce+64572+5944+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D40C433FE
	for <cip-dev@archiver.kernel.org>; Fri,  4 Dec 2020 17:17:37 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D4D22B40
	for <cip-dev@archiver.kernel.org>; Fri,  4 Dec 2020 17:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D4D22B40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5944+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 1TKwYY4521723xRzbcLozdM5; Fri, 04 Dec 2020 09:17:35 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.110])
 by mx.groups.io with SMTP id smtpd.web08.17628.1607102254748941207
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Dec 2020 09:17:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IT2DKrA6n12diF8tzZFjeXsT/38aAWivBsCbkcUCMQFPpePv2iTPi1yvoVfa7czPSuAXuqi0TaRe/rS0yBfOaKrKys0UM0NIq6pEUcYMXruZ4eRP+b/PKjVm8iB4bbLdZswuuNpysjclRdPjctmb6Ufbj/mDILiN/qX/a9vNafmvuCyJEP/AJiIKsIiXQI1uOpIHlQbq5WuJD4N8VHLBh8IzZnFrpfB3GDesvsQXPoy+QvReIXy8p/+/hK7THPE97pu3WnrZBz8bPvnIBlioCOFKPZLvuyOkTjMPxUnFtzQsDJlETm4MKFclLMqGFxFsfdBlTTQT3BlY9OMUe9PxEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smMqnD2iG0ViO0dP5nNSiJN2PJr8AfCj/dkzgsR0/+Q=;
 b=kdk//DqbXCG8d9qqUMhFWWVbyjW2i61t6iSYk4+6CB601oF2dUrm2wEVcUjQDuDwObFZ8sqhFJOO5zYHL4FLDpdtfNJn0NPgH2fYG9lPK9AsY0sOQMRM6iTp8GHpevJ4ymZRO5ruORBwcykuwzDuuZVSYn+E+jSOeEfmPCcz0v6Z4K82x0xBn3m1VCMiW6NNjqiQ1XpRWQ5hvwUD7A9amOJg4LfZ8WEF1dfQOHNFaIHFHQRZYb/xDFBAeKbwFSDvw8IgnBFgIvvT7W07gHTDH6MLY648O6V5u7lnxJUIT5Sxv5YMO0zcgGWVrlg7wdshRiMhkNXfT9YeqHabUWiMPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSAPR01MB5108.jpnprd01.prod.outlook.com (2603:1096:604:6f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Fri, 4 Dec
 2020 17:17:32 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::89ef:c893:5ca0:260b]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::89ef:c893:5ca0:260b%5]) with mapi id 15.20.3632.017; Fri, 4 Dec 2020
 17:17:32 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Pavel
 Machek <pavel@denx.de>
CC: "kernel-build-reports@lists.linaro.org"
	<kernel-build-reports@lists.linaro.org>, "kernelci-results@groups.io"
	<kernelci-results@groups.io>
Subject: Re: [cip-dev] cip/linux-4.4.y-cip usb: 4 runs, 2 regressions (v4.4.243-cip51-21-g1d9a9094c010)
Thread-Topic: [cip-dev] cip/linux-4.4.y-cip usb: 4 runs, 2 regressions
 (v4.4.243-cip51-21-g1d9a9094c010)
Thread-Index: AQHWyTW565IDJR4KpEOoWEG5JoVPTqnnJdQAgAAEOLA=
Date: Fri, 4 Dec 2020 17:17:32 +0000
Message-ID: 
 <OSAPR01MB238504B0E42A849BF97CF39AB7F10@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: <5fc87876.1c69fb81.a7e0a.0844@mx.google.com>
 <20201204164008.GB1781@duo.ucw.cz>
In-Reply-To: <20201204164008.GB1781@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.219.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a5859fae-6265-4bb1-6822-08d898787c80
x-ms-traffictypediagnostic: OSAPR01MB5108:
x-microsoft-antispam-prvs: 
 <OSAPR01MB51087B7E283EF64B13AD15A6B7F10@OSAPR01MB5108.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 KbcIv7XcRgvgxsbO4m7SkhxCrxBr/43at9ul1VcmpZ4kwkZblk+TceRw+m840WeghjPx3WS4i/KtGfMB/OeaZY1u6ADe8VLrEmwVc+glqkz14OGoJnb5FLZRFwMbfyYlIvLVzdXSnFGzsoSzcmIUJefqV+wlU6t3xr5XZU0VbvVfxKz+rFGi+fuJO8hoZr+ahIG6r0Uwh4oA+O5jt8eggsIZIw7tLfYahecHPJM+saooa6IL9EQe/GCIGshCiooZCvrDZ44q7sAyCIGCzhSeDrZoTTRySLcEDN4Qn3TDHZyTHMhmBD9y2y0rB0+iz67q8zaPr3TjyP6bPpXg+SGhr1xXOskV4wJJNKSZZoVvZ30BxMuONWrB5UIo8HVmmgl43Bn17dKyI/x3+qZ2ZXDRzw==
x-ms-exchange-antispam-messagedata: 
 =?Windows-1252?Q?ZOneGqo+dQAtXXiTcLiMQ1Kv3ZTnBlMWoXfy+6ikBsDfzDahXEf4C7Ln?=
 =?Windows-1252?Q?3RKoYp8NF7fVWT4UIsYFKylNN840LhnmUykn6tz5sSo2td+77LGkIwlE?=
 =?Windows-1252?Q?gwJw5OeCTkCmz15xQ2XGnuVy23dwJ61o2/67Uc11mxd3Qh4+roZn5b7Z?=
 =?Windows-1252?Q?zGF+Onr4WWC8eANvglLvUEcB3vIgm2EfeBvEqvJwcmS+DTqkh/RwXscW?=
 =?Windows-1252?Q?yRDvGQ1hYrqfHhRJEFNVD+3izK8NXmgOEuih/tFBvvYQLgS/WeGYTj+/?=
 =?Windows-1252?Q?4BCLMH3gpp2O3eyxh/S8BnrzIBav9PKe+ItcM2W7q05Xkd1zjXXLzFqR?=
 =?Windows-1252?Q?5hm/y+2WVwEVhH1+8brNulov687riqkbq0ppivqChtsP94zDWDcyPSsc?=
 =?Windows-1252?Q?hTSNzxh/5ZfzG8d+9YS4A5SwJP+exmYcmowMmW3x8IIBi7iy5wI6hHgL?=
 =?Windows-1252?Q?Map37kjfjcQSdHoBhRernJQf4g5qzCWZGBF0P6gH6rPiq2UjDXUSAvit?=
 =?Windows-1252?Q?a+XBIpvmLaAclN8t68H1LhGc6mLlyirqTcysrKko+ajUsg2zL2rmceaG?=
 =?Windows-1252?Q?HtkoWqN43PGn48ELBbK6fxCUvS4doyI6WMySvVocd3GSzQAVHcDib6LQ?=
 =?Windows-1252?Q?1mWnR1PqrV7gRRm/zdDDFAOqT2O/KoRES1X0DxIw3QkzfKehX3wI/J7F?=
 =?Windows-1252?Q?7HI7q7F1xLHBBMNMOCOqhZtGORCsdiHPC2eonFn6aCQCuUyPoDWryHTo?=
 =?Windows-1252?Q?NHEupmGunYx+6znJT4xnHUL39at3KaARkRBciTG32nZ0ZTB6zf/ovIby?=
 =?Windows-1252?Q?CRs5aXA1bzcxQIf938KYhMNPMBk51XRCBHfT5R6FMFiZzAMUfh91C0FG?=
 =?Windows-1252?Q?nq1oBuKGDyj9ZW3H9vt/vpZ67y9CG/B980yFaOlwEtb4fengoaYuMpOF?=
 =?Windows-1252?Q?TyifIEWpuZtE9OdzWrxpmRT3cPsed+svV/tE9JPmExAnEpcZK/Fvwqx4?=
 =?Windows-1252?Q?Ofnn4LMgqaFubyQUHE6zjXDjPC7ZX2MZxD+dJDle9D//ybi0T8w=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5859fae-6265-4bb1-6822-08d898787c80
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 17:17:32.4383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RpTMQ8xFKeJy7fUg8l156rWxx+mWINDxo3e+3dYm23m/nI4WghhIP4MlyKRjLFVMFL913dAZ+pbl1dbkpU1slpHMnPX5oPBYti6ymHDnELI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB5108
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PKQoxj16WEZvFbosV9IiwFmQx4520388AA=
Content-Type: multipart/mixed; boundary="XfUzUOlmrFZdtKyIhfl4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1607102255;
 bh=+oU4FR8SyN7OQVOdE7XEpegVoA4cmOeevecMbCapAoM=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=sgH73Z1AZ41u9NJwUccqW5Lhe1BGgIHSs8IU5mGiigQ8xHCcFCbXwJVSBoPXojcE4Yq
 eQyVqY30DdRn7uKyOfhlNahvvSMqR9wV780IAa+u1S3ZQrwmvS/GP8/dAt9zI4zdDRSEw
 uXl1Gc5I6xSabQ6lMKoAJNTrv+FBc4/+8so=

--XfUzUOlmrFZdtKyIhfl4
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello Pavel,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: 04 December 2020 16:40
>
> *** gpg4o | HINT: Error while checking message with detached signature
> (PGP/MIME signature)!
> Couldn't locate the original MIME source of the mail to verify the signat=
ure!
> gpg4oh32.dll:: func_IV Init OK ***
>
> Hello, bot. Can you speak english?

Beep boop.

I've recently enabled these email reports. They come from KernelCI.org.
I meant to say yesterday, but forgot :(

>
>
> > cip/linux-4.4.y-cip usb: 4 runs, 2 regressions (v4.4.243-cip51-21-
> g1d9a9094c010)
> >
> >
> >=A0=A0 * usb.compare-freeze:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fkerne
> lci.org%2Ftest%2Fcase%2Fid%2F5fc871ebf573faf8a4c94cca&amp;data=3D04%7
> C01%7Cchris.paterson2%40renesas.com%7C41794d29ba6043ec1c0508d89873
> 4870%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C6374269681917
> 60690%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l
> uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DnzJf3VqtNFu
> zMZzElil70%2BeuQ1CSeidKlM4LBLh%2Flt4%3D&amp;reserved=3D0
> >=A0=A0=A0=A0=A0=A0=A0=A0 new failure (last pass: v4.4.243-cip51-10-gd746=
6739b72e9)
> >
> >=A0=A0=A0=A0 2020-12-03 05:04:20.932000+00:00=A0 + /usr/sbin/rtcwake -d =
rtc0 -m freeze -
> s 1
> >=A0=A0=A0=A0 2020-12-03 05:04:20.932000+00:00=A0 rtcwake: assuming RTC u=
ses UTC ...
> >=A0=A0=A0=A0 2020-12-03 05:04:20.937000+00:00=A0 rtcwake: wakeup from \"=
freeze\"
> using rtc0 at Thu Dec=A0 3 05:04:23 2020
> >=A0=A0=A0=A0 2020-12-03 05:04:20.954000+00:00=A0 [=A0=A0 18.787404] PM: =
Syncing filesystems
> ... done.
> >=A0=A0=A0=A0 2020-12-03 05:04:20.967000+00:00=A0 [=A0=A0 18.792542] Free=
zing user space
> processes ... (elapsed 0.001 seconds) done.
> >=A0=A0=A0=A0 2020-12-03 05:04:20.968000+00:00=A0 [=A0=A0 18.800704] Free=
zing remaining
> freezable tasks ... (elapsed 0.001 seconds) done.
> >=A0=A0=A0=A0 2020-12-03 05:04:20.972000+00:00=A0 [=A0=A0 18.809224] Susp=
ending console(s)
> (use no_console_suspend to debug)
> >=A0=A0=A0=A0 2020-12-03 05:04:23.674000+00:00=A0 [=A0=A0 18.865290] hub =
3-1:1.0: activate --> -
> 113
> >=A0=A0=A0=A0 2020-12-03 05:04:23.675000+00:00=A0 [=A0=A0 18.867538] PM: =
suspend of devices
> complete after 51.550 msecs
> >=A0=A0=A0=A0 2020-12-03 05:04:23.685000+00:00=A0 [=A0=A0 18.868293] PM: =
late suspend of
> devices complete after 0.750 msecs
> >=A0=A0=A0=A0 ... (66 line(s) more)
>
>
> I'm not sure where you see failure here, plus I find it hard to
> believe that we have broken anything between
> v4.4.243-cip51-10-gd7466739b72e9 and v4.4.243-cip51-21-g1d9a9094c010.

Looking at the full test log [0] it looks like a comparison (before.txt wit=
h after-freeze.txt) has gone wrong. Presumably some corrupt data?

05:04:29.997473  + lava-test-case compare-freeze --shell diff -u before.txt=
 after-f[   27.830724] <LAVA_SIGNAL_STARTTC compare-freeze>
05:04:30.009142  reeze.txt
05:04:30.009390  --- before.txt[   27.841181] <LAVA_SIGNAL_ENDTC compare-fr=
eeze>
05:04:30.009581  	2019-02-14 10:12:01.895000001 +0000
05:04:30.020487  +++ after-freeze.txt	2019-[   27.848337] <LAVA_SIGNAL_TEST=
CASE TEST_CASE_ID=3Dcompare-freeze RESULT=3Dfail>
05:04:30.020750  02-14 10:12:11.459256544 +0000
05:04:30.032157  @@ -1,4 +1,5 @@
05:04:30.032446   0424:9514
05:04:30.032634  +0424:ec00
05:04:30.032840   04f2:b443
05:04:30.033020   1d6b:0002
05:04:30.033195   1d6b:0002

[0] https://storage.kernelci.org/cip/linux-4.4.y-cip/v4.4.243-cip51-21-g1d9=
a9094c010/arm/multi_v7_defconfig/gcc-8/lab-collabora/usb-rk3288-veyron-jaq.=
html

>
> Can you elaborate what is wrong, and maybe re-run tests with
> v4.4.243-cip51-10-gd7466739b72e9 to see if this is maybe some kind of
> random failure?

Perhaps random. I'm not sure how to trigger test re-runs through KernelCI.o=
rg. I'll ask if it's possible.

Kind regards, Chris

>
> Best regards,
>
> =A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 =A0=A0=A0=A0=A0=A0=A0 Pavel
> --
> DENX Software Engineering GmbH,=A0=A0=A0=A0=A0 Managing Director: Wolfgan=
g Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--XfUzUOlmrFZdtKyIhfl4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5944): https://lists.cip-project.org/g/cip-dev/message=
/5944
Mute This Topic: https://lists.cip-project.org/mt/78682105/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--XfUzUOlmrFZdtKyIhfl4--

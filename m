Return-Path: <SRS0=oz3j=LP=lists.cip-project.org=bounce+64572+6567+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1F8C4743C
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 22:22:27 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4DAB60720
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 22:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DAB60720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6567+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MKtrYY4521723x4ZQr3I7cgc; Mon, 21 Jun 2021 15:22:26 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.98])
 by mx.groups.io with SMTP id smtpd.web08.820.1624314139696541534
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Jun 2021 15:22:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8Xnx5NxZiBdY/HpnRPyWzYnMmUijF/Mlpp8+ZO+8Qk3dOT6gHfL7mD2/Q5UKHY6r5/OC7+y3aZ2zzB3+8ra9dqbAUX3ZJbSFruNk1c9dVLEr59iXtChZRTPnTbHURZ5JBT8MnezQbkukib6+kbyA3VdUfElSrCgNK1/CQ8H6FGFkVpEp4S2SkLPBwh2CbSyY583cimY77dkjS1eMX2t9IftsQWYayyFBWAHqvaEmiAZVORCb13OUe5BvMOAuZOGawZ7ZmT6lzEwVrvj84QJnykaQ3u0amwUp9aJMr8TEg9jlhL118CDh0mg6GLn+s5/4PMt1qulg0eXHsNlgTXdOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICxlbGyANWDluCB1gNQQNL+LQI3kuxhEpgyVhLcmzQQ=;
 b=BE+PeRY8ZBVUd5Uk3o/fBWrbwmQf867O7eZxxlC9W4aRuwBSAq8tsP8i96i+mi4OovjlUS7Pfv4kwQPDbH3Q5Mz6932M31f6Yx7eUDlu1QXxTTnMR7Dk9I5vbyIGPpfRw8+Z/rCAiZc8z1TEeqZ7yw6HfSYKHaGmVgNovWEvyxau1xZHUloW4tdLRdY2/Ob75hKEb6PC0uQZc06mEy8JAPYIHScCvGFFUTNrq1EloeBZ451rWoT/9hNmNLeTigUftcpon1glO33d0K7mUL5ntnUI9sfdZd/BzZ9+QOUweSkAccfbvbkwkjrVjT3L4DFw553MGs7sPouFVRCg+dqQ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OSZPR01MB6214.jpnprd01.prod.outlook.com (2603:1096:604:e8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 22:22:17 +0000
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::d99e:8b7f:9620:c032]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::d99e:8b7f:9620:c032%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 22:22:17 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Michael
 Adler <michael.adler@siemens.com>
Subject: Re: [cip-dev] Failing -stable-rc tests
Thread-Topic: Failing -stable-rc tests
Thread-Index: AQHXZtTA75fwnI1y+E+zKqDgBaUn1Kse9diQgAALmACAAAdGAA==
Date: Mon, 21 Jun 2021 22:22:17 +0000
Message-ID: 
 <OSZPR01MB6877AFFB8EA22912F95F336DB70A9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <20210621193629.GA22045@duo.ucw.cz>
 <OSZPR01MB6877C72DEA6B911F7DC43441B70A9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
 <20210621215112.GA554@duo.ucw.cz>
In-Reply-To: <20210621215112.GA554@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.219.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 560036d5-def2-40d5-e1db-08d935030745
x-ms-traffictypediagnostic: OSZPR01MB6214:
x-microsoft-antispam-prvs: 
 <OSZPR01MB62143A769423BB3503DD216DB70A9@OSZPR01MB6214.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 f/wyfanOijamJY3Ncyn1AJGHM7jYKMraS9vSburpxZdjv3ZKOa+T7QC6gVUFL0IPniIUazL0wMm9QE6zckLNXCoSsAv0Cej2+7t87RsDlgTpZmLJfkMSp9OY/rYoPccRMqurvWdfdbF46RGAip+F+pklnvnsfGzv/Qa8xNdWF51k3cK0T30Xcs4jnWLhAPYf5vRyJHnZLbhFQr4cL/bqjygzxWJN1Xo3pqWsJCiG2DHHMFPOl/Q/JylH7ULGwiPt7eaPOAadatzi5DvTyetAQqvweuPPCTfy/LXlkPzm7Xk/cbZT/EtR6MuuB90wx9PFZpBbEkJv8KsXR2/o/3UOks4cFuE3ZrZmc4DkmISQkR0eBYDiiQW7nJ3yQg0zatEoPSTlIn/vUqtz2aCSaMsuFJfLb8OfVdGuFNETgFNmB6ta6NcxnrwA1iEnwdrmbxnSatA2e/1YDtLg/N+3+kk4RXanoFPOva/yiaHzRSqOS/a6+lUGqNVJmYE4D6+t/ojL0MlugjsSxl7iIcWjohny6rNE8TeZMumpfSPxseqmFzhnM5r0X8DICMS7i4SA5LLBYvHT0pEdJOJyBQfvqhIjW6WL+x5fO2vDCMZmECwRehrRoP5zzP4ILwFgJCro/QFeneEf4KckG/ts27or/oeZ2SrVwB+8Yx4QvXdfW/Mo302ZsdZThywN6dAGUIZvhYpGv5f3+pJu3pRw+jO9PNkqKHdr1rkWuaR/ztbTyh4Dui8=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?S1DJvCXIfQ0cYaigjFXTTBeJqZ9cvy7lSNRGBGlkL1S/fDUS6ZEmg/hu?=
 =?Windows-1252?Q?8HGoBp2cSikHQy8XRE5RTpTWeLXS/noYJ0d83Au9JKe2D9+h0yCbu/BK?=
 =?Windows-1252?Q?xK0ZdFx0lVePo4hh6KVD/gSWOJ0X8cEeksqZYAaG4VgeoQRiFoi2RTuj?=
 =?Windows-1252?Q?BANZTWO3XczncV0QxWdGooQrKPDsB4zRFt9EaInxjfw7NlzqA5x/CFnw?=
 =?Windows-1252?Q?62/0pgEm6rSG8KHWk1xEXcqOoB1anAR3MVler+/zb1pRTqZldSw/PaW1?=
 =?Windows-1252?Q?2fHqi+YDr9R0+8u71w8PP014aUALWUziy8IZk+KDuxGDiVu/2mFaMMaQ?=
 =?Windows-1252?Q?7WzDgdLy+EOx4tr/gWbId3Njok255D3ET+39Qv6IEbP2aiJdsxRfQabU?=
 =?Windows-1252?Q?c6btlJ16qnYZ5oJwtJeydq91kcxG9QZFwVlndRQuamh81T5C46CZbfzW?=
 =?Windows-1252?Q?G5pt3eGCTpDN0E8fZxUaYTNs/Ysd8BnvWgsWDTDk4WtmTw9GdAJWXznt?=
 =?Windows-1252?Q?5f+LPSFrSgAGfHakHsbgBafqSIQo77syOi3F+GetZDiEkBL+wNrPY7E2?=
 =?Windows-1252?Q?QX4Pu45mvsEV2fVIq6qnOYVH7KD70yMHDumOw7ft+Y63c6z/uiHOeI4P?=
 =?Windows-1252?Q?xP7tr0907otZBvHGIkx3jd6DjeECjUtL4nWNAnXZuI0q8d8N6GPsgaGf?=
 =?Windows-1252?Q?C/Bcc2NhzI6g9wmlZqouitfXgRBjprjVa05jKMD/Fvm0EYyGLAObgUFt?=
 =?Windows-1252?Q?Zuf6SjmSqNWLmUBg5InI/z/V8erF+hBm1gYCfXo7DoTFUy0g8jThMr5C?=
 =?Windows-1252?Q?ZIuEyhsyOvApGCXTXWzz2dFCRStqe2xgTbUxhAB0qXccPDtoc9gsYnJe?=
 =?Windows-1252?Q?PoCA3DMbLMeOaPu/vCxUWU7l3Wo07OQv6fzsGBhb9lZG+uOl3kXZ2BUt?=
 =?Windows-1252?Q?sOzdO+PHHQBL7q3WizuuASF2ctnrhBWMlDTQ/Omh+j9T5D4TFU1zX2w6?=
 =?Windows-1252?Q?tAiQThCaapubbaHyyh6SBBGJy0+t7VNG1yt6DzQ/sjMPf8Roxm2BSg3o?=
 =?Windows-1252?Q?hOJJxBaXYc8nJQwg2zgdxTI3/g9KLne6bnK+HTeNOb2mP7IPEFvW/XB3?=
 =?Windows-1252?Q?L7Y4dX4kqoGISEbg6VcW0A+GQmgXcVu2UiPiUp531T/iQh7s9L9RBOQX?=
 =?Windows-1252?Q?QGG3Tg+7jax7yNkliEyQbsssM0oyCqxQ2JVCEsOYfQFFrTcSS3KyJhD6?=
 =?Windows-1252?Q?Wm2wjVb94NjdYofM/MDIcX0CcjO7AIKnDnmp7Hrv6uMsXJYq6r/01iKF?=
 =?Windows-1252?Q?RIbJD/pHXxHWhcHm0rogeOvkLXCoVkQoCWiZ7SX39pNfZN5x2hQmXcCU?=
 =?Windows-1252?Q?yd/pHXb5IB5l0C653JtNgA4vWXVWCMws9PW2wtyqCFx7hvBOHDlcM89l?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560036d5-def2-40d5-e1db-08d935030745
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 22:22:17.1894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jQ1wR8toYHR1mJ0GCWZHqT5K7M+MK6s+fzfkuNCwd7/cP412PqXy2uv/dohd1YS9oyY/GmgAMiWSAC8mJ+8CkMtn5t3iHyUuWZ/mpWG718Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6214
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 1Mc3TQ9V87afAV0RRVE3i9uhx4520388AA=
Content-Type: multipart/mixed; boundary="wSdJUa9HvMOMuin4xafA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624314146;
 bh=Xork/wJW0Apo+fmYTObWzBhPD5DNGNJX5p+zPQx4Lro=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=wMgS+47aHb+/nfsw5D5tSMYe/KMf/kzdUjYeYrR/I/d7WYwdXZpiacfmfWF8xEzNvve
 FYmTP7PHERAR3GU5zwhWFjlDETWBZ4Q/ureF8nBrIgSoYfOFGM0oD7Zcb8A5BJbaabKO2
 sM02cVx+PXqZMGsZHb6V1Py6PZu5pRKFkpc=

--wSdJUa9HvMOMuin4xafA
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 21 June 2021 22:51
>
> Hi!
>
> > > From: Pavel Machek <pavel@denx.de>
> > > Sent: 21 June 2021 20:36
> > >
> > > Hi!
> > >
> > > This is one of the common failures:
> > >
> > > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> > > /jobs/1364210937
> >
> > Thanks for sharing the details.
> > We'll take a look.
>
> I re-tried, and now I got this:
>
> https://lava.ciplatform.org/scheduler/job/302528

This is something we sometimes see in LAVA. It's not 100% reliable in getti=
ng the serial connection to the board up and running :(

>
> I'll retry once more, I believe it will go way.

Yea. It's annoying though.=20
Same test, same board: https://lava.ciplatform.org/scheduler/job/302551

Kind regards, Chris

>
> Best regards,
> =A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 Pavel
>
> --
> DENX Software Engineering GmbH,=A0=A0=A0=A0=A0 Managing Director: Wolfgan=
g Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wSdJUa9HvMOMuin4xafA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6567): https://lists.cip-project.org/g/cip-dev/message=
/6567
Mute This Topic: https://lists.cip-project.org/mt/83697468/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--wSdJUa9HvMOMuin4xafA--

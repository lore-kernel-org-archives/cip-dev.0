Return-Path: <SRS0=Qxn+=BX=lists.cip-project.org=bounce+64572+5117+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF6EC433E3
	for <cip-dev@archiver.kernel.org>; Thu, 13 Aug 2020 11:43:16 +0000 (UTC)
Received: from web01.groups.io (unknown [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A369208B3
	for <cip-dev@archiver.kernel.org>; Thu, 13 Aug 2020 11:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="f/Ngf1qB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A369208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5117+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id yhtdYY4521723xcU2zqamftN; Thu, 13 Aug 2020 04:43:08 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.128])
 by mx.groups.io with SMTP id smtpd.web10.5238.1597302672116207919
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2020 00:11:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3cuTwYTUfKc+RZ+nF096Ro8K3gsAXuwg1AWmOuswOhvaZa/S/QmFvt96srX5lDO56NATqKE+T/tznnLTUV8TF1mUN1nfpydbl/KtJQnrKKjW+ju6aCNqOy1X7+KZvbf0KB0ta3r++D1Arl9n0fts9gTeT+BA8UqyllaehaySH+El1cM2Q924gAb92n6hPrPIP44y+DYRhnS5z0eixy6MOZ7ROc7AQqYAWe/fNLk+B15CGymGy7cYHDSz9CYKkunEFjmuDBzQzQ75zU+ds7XasnM+OD+8sZPrgTExcgFTn2GHf+fU6BwF6YP6O3G84OnzZpYe5geEJYYt0W8nOSqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EriLV2r2n85czBG9NtutIkzoCaoLBeGmBLJZ6H7Xtnw=;
 b=XJEqqOUY8yldpyZfXqX2wt6sKL4hV3dqv2AVHujOB4vPfUBZGF5VjvRZ2lLMX4WbMJOAw996aCDVbPNuMZunBcgKuhO1ILCsvV1kh8KcTaJLkXmg+c5wNRQ5gKc+OJ9z3N7AkCXP7rNnUz611J2KT0q3xl95QOGCt4GVaPwur5qNSspfF57eOQHugKXkQPXVo3qFI2u+OXB8Jfj9PqJ7R7859zndKU9pAELzRuy8/ssaw2eKw+GI48pI0pAnOgIj7MzhVsxaoDZaSFNF8jZbzg5TrQ+xZkWKB/681/SvvtEvUNL3ZmFYXl3ZFOdpFe88pG6GURZ+65or0vir1reKKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::15) by TYAPR01MB4463.jpnprd01.prod.outlook.com
 (2603:1096:404:12b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Thu, 13 Aug
 2020 07:11:09 +0000
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee]) by TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee%7]) with mapi id 15.20.3283.015; Thu, 13 Aug 2020
 07:11:09 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Chris
 Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [linux-cip:linux-4.19.y-cip 7/17] drivers/gpu/drm/drm_atomic.c:1264:1: warning: no previous prototype for 'drm_atomic_get_old_private_obj_state'
Thread-Topic: [linux-cip:linux-4.19.y-cip 7/17]
 drivers/gpu/drm/drm_atomic.c:1264:1: warning: no previous prototype for
 'drm_atomic_get_old_private_obj_state'
Thread-Index: AQHWblc6UyTwUPv9eECCBW1u6/T3Caky6F9AgAH7DgCAAMD6EA==
Date: Thu, 13 Aug 2020 07:11:08 +0000
Message-ID: 
 <TYBPR01MB5309CA4CE2F17CE1B864EA5686430@TYBPR01MB5309.jpnprd01.prod.outlook.com>
References: <202008092247.i5TR1Oel%lkp@intel.com>
 <TYBPR01MB53096578ABB1E74E2E2153DA86450@TYBPR01MB5309.jpnprd01.prod.outlook.com>
 <20200812193746.GB19363@amd>
In-Reply-To: <20200812193746.GB19363@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.219.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1486590-c935-4760-6326-08d83f580d96
x-ms-traffictypediagnostic: TYAPR01MB4463:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TYAPR01MB44634F8AEFDAA797CFE21F3986430@TYAPR01MB4463.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 czDRgLW0Lndi066lsPTIyRzJ3dv1lEdw/KFJO/LOYDTGeASwEroSp593eyJmcvGv3KKWss//B71ElS0GcUWuhygtOeiyaDMagLH8JMttB1LaG3JOV8zkQoCK7hOFMCRWizO2krKOswcywZ98U2y75AoXSswrbfyyaJLE3LksY9SsaKWLIydzYLLIj+E1VoYVjDnDlMSu+sFIX7vSHxZmeCfdcokSwakTfBszkMWw84psTt3Z3A3N3Pj5fnNZr97ecW+Cq8h2fObNFdrOpaOLC+qIMdKMq6tz1hZE+TvZnr5YMetO6Tfocsh2yObSa4MX
x-ms-exchange-antispam-messagedata: 
 jxOt0OmAACbHOgP0o9gD/L4GRqdrSRxCyw7OTFnOHiZ1dXpZHrW86XWZQLbdM6eW7TaGCGqcUv4Jbrc0GuI5nMBrLe9odHZqT12mx+YWqCEPr1EqDspxn24uf0msOTUS0mlZYbZD9qq/kgrDS6QPXTDKoVdAF8OB5HhZXrhZ7l2ki7Yc/H8/2B28rCCe9+Yy0339sr9aHfBVk4Lu1ShxysJ6UDwNhYU3HCpGc90VDiLoPah6zXmBm+M2CMe90eHyT6i5YVLBotviC4waBHure1H7GS+HhLR8BIls+1ohw2seysGfoaNoGHo+4VE//FRM+rV2Jj0Igp48AUAm5A+9oJU02rvoC9So7eaxxlG+mcYAo0jfHS6a1les+HDYDoeyx0yMv4FBqVBwKCQ6fhq49DTr1tPM+RwchkYczF3AJQOpMsUToLkJIMul1/eLivNJI3R2aIqS/R0TKcekU79Zr/hmFkDUOZgT2+MFwwWn5ujNpt6RFAXJfyTVSgNE2vpOGL3S+KeIcE3+OaYArI2KemiWpGW3EK2LlHdy4dWmgdOetywINhMvt3u7KDDjJSvqEPE2BaUuhVoCbLMCgU4hHFV3UsXtOqkTjPQTHgPSQefCthSsD59LOwqdzke8+1O5LAPGIEqGMYPcnb+QSZyvHQ==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5309.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1486590-c935-4760-6326-08d83f580d96
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 07:11:08.7988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Ix5TEnUUXCNI5F2ObzzAeOT+lGuA/ZMtZFMHfu+QZXLb4/IH2NlWw201svve0cdDcWUi2e2d634KgjIMSFm4m2K1E48JAtcoHdLCjwypNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4463
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: kojywQO8ppU18IUBcydXflaXx4520388AA=
Content-Type: multipart/mixed; boundary="BXmG14R6FUaL8JcvwtPc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597318988;
 bh=YJS6KQau9yRB/pYFBb4qZSu8Lz5cAW8L55J/Wtfjy64=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=f/Ngf1qB5t3BkrGAhDvyRqHWv1yW9mXX26buNNQE1QuXkjbQr9CECYTOre88EYhf+cq
 XWKkk+FGLgQcLcRcWdruz/q4YF3yjdZORvDfEIqWWztfiD0fmSg2k9FDfBtG5QjVOpLX4
 5aM+CumUX4a2fLlmSxjDTjX1yMOQovwdLSk=

--BXmG14R6FUaL8JcvwtPc
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thanks for the feedback.

> drivers/gpu/drm/drm_atomic.c:1264:1: warning: no previous prototype for
> 'drm_atomic_get_old_private_obj_state'
>
> Hi!
>
> > I have received a warning message mail from Kernel test robot. I have
> investigated this issue and found there were lots of warnings with
> architecture by following the steps mentioned in this mail.
> >
> > Then I investigated this particular issue and found that issue is
> > caused by bad commit done by me while backporting. The below backport
> commit has extra functions from patch1(0001-drm-Add-
> drm_atomic_get_old-new_private_obj_state.patch), but the corresponding
> header is missing.
> >
> > cip commit: cacc2a81b9872aa8830353110b1252021f124ae8
> > upstream commit: 1b27fbdde1df172dba604855c45078d741f8c858
> >
> > I have attached 3 patches, that looks like fixes the issue mentioned by
> kernel robot.
> >
> > How do we proceed here?
> > drop cip commit: cacc2a81b9872aa8830353110b1252021f124ae8 and apply
> the 3 patches to fix this issue?
> >
>
> First I want to make sure: we are talking about commit
> 60b4667275b60d92c760d48df95f5b80bbcfde6e? Because I don't see
> cacc2a81b9872aa8830353110b1252021f124ae8 around.

Yes, I am talking about 60b4667275b60d92c760d48df95f5b80bbcfde6e.

Cheers,
Biju



Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647

--BXmG14R6FUaL8JcvwtPc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5117): https://lists.cip-project.org/g/cip-dev/message=
/5117
Mute This Topic: https://lists.cip-project.org/mt/76126617/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--BXmG14R6FUaL8JcvwtPc--

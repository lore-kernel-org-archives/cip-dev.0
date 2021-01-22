Return-Path: <SRS0=uAz3=GZ=lists.cip-project.org=bounce+64572+6135+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F8FC433E0
	for <cip-dev@archiver.kernel.org>; Fri, 22 Jan 2021 09:40:44 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4375239D1
	for <cip-dev@archiver.kernel.org>; Fri, 22 Jan 2021 09:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4375239D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6135+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id poi7YY4521723xlhGFCI6sRR; Fri, 22 Jan 2021 01:40:43 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.99])
 by mx.groups.io with SMTP id smtpd.web12.6859.1611308442127247952
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Jan 2021 01:40:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gL9ifIcXSbsLoJvjMjd3dLqrHgPzj78oa9ooM+3gLrexGUKIJ8B4/eqoAMN/SExhfRwdNOn6Fs8HD6lcqZS5uaKSBpb6Y6PoRq8lPjM/WRnbcvHkHVGb00oCN43JgOG+zTikDaGKzi48ZFYeEBGk7948jw0vKLe/v0ySfnQKn2IbwIZjYtJS8NYwLArsKZIqYrpp6Kx7u9WbHayxlcoc1SJnwy4SjA4uc2oe/YuzIOn/fpaXpXZOXBmdOFoik+Dh+A+acOK1qeaILMsJnKfFmzpGXWIyCiaMNvCu7HRPLfhQd4VcXK/NgflCjkwX/gMX1zkuwZViSoyvf3zP7CODzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCwBWBV8maukifhHCNbZL2/MhNc/OIRpuTJuT0RIZqo=;
 b=Jx+WxQoA5Wl0jiMWgKY2knEWW7S9oVHtQl2Ld3FkarwabcXF81/6habojGdk4jQMeYgISGR8603gj9+AlQt2KlbmTaq8E757lvfQ4doHYmUToRR2tY5jqABY9YZZoJIrbzYKeIjQBrGxNAOHkY4xDEchxkvu9ohQJ0xrY995vAkgH0muRATcPq5nA2weojG57gtZgXLTtlj1MEDXEi3GJzRS+Yz9rrjb82K9lOIoH9li6QMRHwmxrBAQ5uFqBickZ1RXF4JQH2mLtZR5TbZk9cWq50pFTCgH3FJTgnBcFqT0dt19b9844VU9U0YqDpcfvzMNVFFFntSvFUBITMYYdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSAPR01MB3459.jpnprd01.prod.outlook.com (2603:1096:604:32::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 22 Jan
 2021 09:40:39 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::cd38:9c3a:b3f0:a0d7]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::cd38:9c3a:b3f0:a0d7%7]) with mapi id 15.20.3784.011; Fri, 22 Jan 2021
 09:40:39 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "masashi.kudo@cybertrust.co.jp"
	<masashi.kudo@cybertrust.co.jp>
CC: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Starting 5.10.y branch?
Thread-Topic: Starting 5.10.y branch?
Thread-Index: AQHW72HlPA6UF/bjyUyPfgKXamDqLaozZgrQ
Date: Fri, 22 Jan 2021 09:40:39 +0000
Message-ID: 
 <OSAPR01MB2385DC8D8417F5B3DF5AB473B7A00@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: <20210119182125.GA17515@duo.ucw.cz>
 <TY2PR01MB497256384FF6FC1115BC3F34A0A30@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <20210120192433.GA24348@duo.ucw.cz>
In-Reply-To: <20210120192433.GA24348@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.129.175.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c70414d4-fa23-4716-728a-08d8beb9c747
x-ms-traffictypediagnostic: OSAPR01MB3459:
x-microsoft-antispam-prvs: 
 <OSAPR01MB3459F0B0595B40361F065ECAB7A00@OSAPR01MB3459.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 JGvnzESs6M5c+gztb4+By+CXS2XcHJU8zOdysF5EcArgoFVhftqiDI9u5z0KbG21WFIG+OPi0VFLWVNXz8ICXZA+LSnTsp8LxLT4pHAndd7n2YiljRfIjEPIty9PZVIMpE3ZcPA5y/kCqUVqFcF8fit1cnh1+2uabeT7PlxqIAQQMThtY5KtDuYoXCOTBBw70t+6J26USORlb+9s4Pq7Zi+fZQ0pslv25stOz9ViXlY/q2A3G1luWqhorJQe36cB6mrVwhFomGpn168bsu0gDteG4/KCehAvWCt4DCLWHcSTp9IrWXhnuFTrO5LPF/ZgfEoburYhbzP/vz+G1J9IdLKO+X08f6u787gvJqntIXn/2CJyIt5EJ/vp5g8tuaiQS6j2WOfcaD57RmC1rtdVKF5cB2CWZeIQ2L/O/YkqAW/5lVm8jpj35JRuyNl2CWKpWtj6sBjCTQ2mZQVBxeyXtA==
x-ms-exchange-antispam-messagedata: 
 =?Windows-1252?Q?sG4ZuxA/JbTI6l6zA7G4/XgnrY/BQ5WBrxAFSUn+QaCtXTkPYgGManS7?=
 =?Windows-1252?Q?H3UjUxkFACpqDmDMti5ntIaWK6pfJVWpu1TZyApWPYee2xwQQcSbsM3F?=
 =?Windows-1252?Q?fjXNiLSBg5Mwk/VagcL/gvZ54EYWfcja9CEbOTANIdjIzSgUKjsa7dOq?=
 =?Windows-1252?Q?2h+JdWVc/X18RvV+PW5Wt/itWPD5zvhDeoHsZ0k5YkMl2QGOcgBQHOoq?=
 =?Windows-1252?Q?fw2kXaGMwHP71WMqSCuDRyjmadSIU1Kc4NH6FKQxsrIQbeXhQPuZE8EW?=
 =?Windows-1252?Q?ir9TgVatg3gLVhTIqTVGYxfEHGl5iQgxrtHh4+YUcvTatV6ba3vr5cO+?=
 =?Windows-1252?Q?0LPMB8wPoHoBT4zeKMzKkQVr0C55lUwxbrVJDKAsqbaRrRGq7ecuAJm3?=
 =?Windows-1252?Q?BrmDeYuY7r0GODc18dpia0GK6xQRFaAMfXHbOqxjlm5SYl7+fuen2HJQ?=
 =?Windows-1252?Q?PPS1sIfyuAt5+HQQRZEiaa8hnhDz8l+vSlhd9z4bvlOBcQG02UJwtVpR?=
 =?Windows-1252?Q?3iVNNbVI9u9yI7cpoPvwI90z/9Gr5d68acg6t/2dE0JEv9cw2JVQOdTw?=
 =?Windows-1252?Q?H4KRmWc06Px5SGWJAOqK4KHEd23I6tBTD2ZHySo6vph7XQnmHsM+r9L0?=
 =?Windows-1252?Q?q10xPrMby6GUHnH3Pd/jnnezaEH3oyhxMUlLyEZhRmLPGX1h8EmfEcwz?=
 =?Windows-1252?Q?/eSwdkJvajbGhdUa6O+UVoxNFRhmo+jTNOnyibKcbxQ8D6pjg65gGBHD?=
 =?Windows-1252?Q?uipBgR3/bxlBuowP65Xjo8es5bIXiseChZESBQofJz4Wd+5ngJKskH/c?=
 =?Windows-1252?Q?CNWycRERObLCn2S3Ca/DPH19Vh6chTr5tpqUy3T7E4E1vdkzYXEC+ZIj?=
 =?Windows-1252?Q?pJmqoIWT2D6K32yeZOZR+4/X6TVH3Jy27xukbXiogW1kMjlruCwxBwXM?=
 =?Windows-1252?Q?M1P9Px83gJ5a+ljF7HYPwIEXSEc9BnszIwH2fIIubrpaltvjuRCbicq6?=
 =?Windows-1252?Q?ZFLZNJx7c/iexCqpnAZbzY09SfXTJLa8TuIJRb2URVZwwDPlFdo=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70414d4-fa23-4716-728a-08d8beb9c747
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 09:40:39.3641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C/umh3t8u+aA/R10BADLPNgZTcICEr0a2TfkBjdPOLhSNYmWi/zwLtgR1Xc9tAOCyIuqv8+BSDpBfuad6AfIlFGtuJtU905+oDKwdLiiPYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3459
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PQQ4Q7M7zPYeQh5lioFkiP2Yx4520388AA=
Content-Type: multipart/mixed; boundary="NlB2lO3B7kalI91PSb9a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611308443;
 bh=6P20zP0tMo25caq3hBr29EchKeqrF/j5Ovrk9DcQEV0=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=ZC1BIzfsaTkMxc9+fXmX3CVwE8VYz0Mgzq7hejah2t//xmZ6bSCCENfcyq+0PYn9fLs
 OV9InXwM7zeXvJy5LkUJY7bvVKZjFyoBck48OC0uxuAknsGdi6+lmgA/vTaqu57CUjmQO
 G04akiGjwICmFtRJF7LC5sV737z1+cy1JzQ=

--NlB2lO3B7kalI91PSb9a
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello,

> From: Pavel Machek <pavel@denx.de>
> Sent: 20 January 2021 19:25
>
> Hi!
>
> > Thanks for your offer. Yes, please do so!
>
> Done.
>
> I put .gitlab-ci.yml in the repository, which points to
>
> https://gitlab.com/cip-project/cip-testing/linux-cip-
> pipelines/raw/master/trees/linux-5.10.y-cip.yml

Thank you for doing this.

>
> AFAICT it can be provided by simply copying linux-5.10.y.yml, but I
> guess I should let Chris do that.

This is now done. And the first 5.10-cip pipeline is almost completed:
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/245356155

Kind regards, Chris

>
> Best regards,
> =A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 =A0=A0=A0=A0=A0=A0=A0 Pavel
>
> --
> DENX Software Engineering GmbH,=A0=A0=A0=A0=A0 Managing Director: Wolfgan=
g Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--NlB2lO3B7kalI91PSb9a
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6135): https://lists.cip-project.org/g/cip-dev/message=
/6135
Mute This Topic: https://lists.cip-project.org/mt/79958721/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--NlB2lO3B7kalI91PSb9a--

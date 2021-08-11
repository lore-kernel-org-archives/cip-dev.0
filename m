Return-Path: <SRS0=mfiV=NC=lists.cip-project.org=bounce+64572+6671+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F05C4338F
	for <cip-dev@archiver.kernel.org>; Wed, 11 Aug 2021 08:03:21 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C39960EB5
	for <cip-dev@archiver.kernel.org>; Wed, 11 Aug 2021 08:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9C39960EB5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NpDeYY4521723xaqCvZtRayD; Wed, 11 Aug 2021 01:03:20 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.90])
 by mx.groups.io with SMTP id smtpd.web12.4824.1628668998094207702
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Aug 2021 01:03:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIARGr9ZXmwuildLOL0VW0v9crmxfrVxFTDyviVbOyrMungVhSUt/Duo8gqS7HesX7rgIVRfeq1e6Wz2WIAgrw0bkE9M0cCkvMJIo/DfE5QnBV+L+Cf12QS9PUUfdIpXt+NwFkYnJ31MDTvar9vuQ3Oty3dEyBQa8kVZSmafJMFm1QyB94afr8Pi6y+LjmI5KG5DOWs6plFH6cPy2BdYyAolNQagIzU8MSDq18kMa6M0GA1OcgZPLh024H2I8rz/Lc0UkMBeXuD3W/iKWUJ9PSc7oKzI3fYbPSZL0GT5/yB7SdjzXaDoTODqycidT+FYdg54i7450mPdthGBDTVz/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3ReTM4DMvEFmWTyaWCHXNMqaFmuaeL7biV5ua9u+54=;
 b=TK7p3LAhZ2aNnl3DbMIXPrh9h4MsA46Q+cgKBM0yO8+LP2NBug1pRGukInpaT8yrWEWcdqwQDeWbBjoHKciPwlQp2w7qrB/3keW/aP7g2AppTklcke7TdtKPCnXWARXUS7PusgWHwfY8hk2rWXw2FwdSsmxFc/3cpRUzMtbHnVD+yFSDoq942h17sGjsJHvIBo8Qmkgrxdm1s9y+SRsD8cCVVTkmQCwrVMaYdnaAOeePk+L5nnE5Cn6KTKdkCiqWzYDJirPUG9HUerJy3m2iYOts5/E9K716SBpUoHINWQXHXIUP6FFas87LYhbfA6UHw/oZXRAvIRX9MxHDh9oiqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OSZPR01MB6710.jpnprd01.prod.outlook.com (2603:1096:604:112::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Wed, 11 Aug
 2021 08:03:14 +0000
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::7841:8a53:7327:d552]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::7841:8a53:7327:d552%3]) with mapi id 15.20.4394.023; Wed, 11 Aug 2021
 08:03:14 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] -stable-rc tests failing
Thread-Topic: -stable-rc tests failing
Thread-Index: AQHXjnutwozlPbvn0kGggfTL9fZabatt8RzA
Date: Wed, 11 Aug 2021 08:03:14 +0000
Message-ID: 
 <OSZPR01MB68775BA605A2B969F3B22612B7F89@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <20210811063943.GA23723@duo.ucw.cz>
In-Reply-To: <20210811063943.GA23723@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e327b804-94f5-4a53-0fe7-08d95c9e7854
x-ms-traffictypediagnostic: OSZPR01MB6710:
x-microsoft-antispam-prvs: 
 <OSZPR01MB6710A8B99DBCF52C69B21D3FB7F89@OSZPR01MB6710.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: 
 r0alMTgz4sEUkh8Gz+uleDk6/ADK5FXan853CBfC481GnKj3QOzYMsycbmLQOQB5rtCgrrm5z1TZCDAngmdOjm8BS41ckAAEfHX9Un3jLOmADRVcfh1J26EZDCGuZ9lazm0MXESeenPgvFYaas8s/5k625XW8Iq7q4Z1vn3nFk0QWl+cf8BnT1Jg1dxNsOXD1/bCp6Mb775MAMIAQxIkBlJk8rA/xrOPntKPvHuSP0zaj9EQvZVz8r1ctQU+ymofJwF7P36cr0ITv+T3ie9KUS5n2vdIpJNbN4sVOpZtvx3lfsaAF5+JkrbGsafgCmR+jliNqG4uy9UFpCbgZ8nsRwNEw56DJpgHSNaCvJlu8CY4u8MoVmpphV48bk2B++dp8gOIxX7gCBEF4RJfBbsC2GqZKWQGcFi03YT2D6XwhOYWymSqTNRmwMsff2mDKCC0XddkUXg0FKOR+zhAslUZKzAFAYACaMtXsC6drRuNQtHcQw7lnTZ4KeQatLi7lyseMbLUBhP3k2/eKuzhKLSR/B3B8ydchu128RHlguyKJcw0wJzQ/mZdc24tgVIk21ZbDHEPLjKAIiAv2tUneYTdrtN8kA3mUAHrA9bgLuck0vfJMLSM2Rof1DV+LgoiW5kHWNLRMzLM9pxJDYDAXHOSeljrpiIHC8j+tpsm4QF28qeanQOjbAokRCvuL9osxAdxFY4H8VvH27x4qpIdkV4KEtM+Fb9G+wAJcZYepfVJye+V6TUMMXPbTpeDLASTkLnngkMAjMEGhrAelNFnTbfx8FXUIH+gVkUrdALNhKeVsTl1+IxNWOKj9v04bId80F9XwVcp8ukWLAleTxzyerQHAg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?Q+4PL2gqccbiIAF8cSGKYCoZmJ/Q3k7lbK1ypmTMqXP0BtELuoSl7/cK?=
 =?Windows-1252?Q?5xJkaTmk8EmXdWRInvVVT6vpRy4GI0rO/Cre0fUQyHItnG8vL6m5R6ca?=
 =?Windows-1252?Q?FR1u723Vf6026LIwRU3Wochh9Rv6qjlZSMv6brMXv/RRhHpmRellQuHH?=
 =?Windows-1252?Q?qmuFCOhvL/TrBGR1yd3kEQB05h+d3f91qtcWok1o8gmGr7JESozUIgKq?=
 =?Windows-1252?Q?pVbqfYanVmMD1OZNUmaHdIc9QFFHDvTWPDLin/ClOhQSUfUbom4uUi+D?=
 =?Windows-1252?Q?X8vOGJIjy2bw58H78rP77eHM19dW1XQSAE04dU5NtPw4FTzETwNuyzgG?=
 =?Windows-1252?Q?Wt1fNcjBHQSfKXYdlbyvhllkVQZsTtads0Fhp144aQhz1X9u8b5VTUvJ?=
 =?Windows-1252?Q?BzW+PI+/ZbjJ7t1ahG+v4vnsaW3HfbFsW9LzZvQnX2+MqAHUinL17XVM?=
 =?Windows-1252?Q?czTx2eKH3hUknwr1hiYJ6eAop/kk3hdRczwL++gREQaI5GbWddEuV1U+?=
 =?Windows-1252?Q?lRBEALvmxrbVydV/bOO1SINSba/bCDw9i/mw7wcAAV4yyEYKAYgiNhQi?=
 =?Windows-1252?Q?kzDk+b88vQ0V6puozO/ZuopOyL8eknTCOLax4jrUnAMKK7EutPW2FTHJ?=
 =?Windows-1252?Q?YYd5TSKw8ITdfCuqOrs5zBfbljfe4zcs1xAywIsJnRXAjiEEqhn1qSZF?=
 =?Windows-1252?Q?q0ZTqvij1KGccqk55oV9CqQ5CXuYYdCB16OxHmf89EjC7iyBmiPTi34f?=
 =?Windows-1252?Q?Og3hWSlj8LJ8l2aTl0hg9fOPEToDgK/u6nwAHbO4AfyEMG9qcHbjRecx?=
 =?Windows-1252?Q?i/MLh8QsXv6hdQGwtDrhTQLpKgNxw286Ajqs+CXzHP7C+TjBo4mSuHhB?=
 =?Windows-1252?Q?uNF5CosaH8q/nEtln6pF9kjWaZXjmx590v6tzaGwBhVAElL8dH49kTBY?=
 =?Windows-1252?Q?Hzc76xXQVfS2Z2GHJmBXBhOpQROgj/ecWVmQMbcO7NU3fw19HDWv4y4v?=
 =?Windows-1252?Q?uV4PWZY/Ia83qhDg8Jqz7+eTNQhBxJzCYgIwvDgjOotWEaNGrZzPCMG4?=
 =?Windows-1252?Q?WCWArH31af86OcEDJ6t4jOervbYh7PZptp4plPdsk+F2z6+v9tAFhAhF?=
 =?Windows-1252?Q?7O+qo1N372IPrjkRUsdTQ+X3F1Zi7pqvzrLUqKntXlUz+IgAAJSQg9Q8?=
 =?Windows-1252?Q?sI/7VorilTBMtSYt+jYxW5WEKlKOwes+vksCsl2dLIR34xXS7dDvR06T?=
 =?Windows-1252?Q?dhPS3I1+PPqolYHDOi8q6LpGNAtX+poJeeHhwsU3qE37cNmBJLO8+DJQ?=
 =?Windows-1252?Q?thUwh5mLEAZ8rTD4MtR+KwkMR8Cs8zHOhUZDj+aQseCmGZg6XBDaxoZ8?=
 =?Windows-1252?Q?6orrRBSjYVwTQFOoevA8JK942tRIyojdq0PfNEzprFvIfwT/GTsVPQle?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e327b804-94f5-4a53-0fe7-08d95c9e7854
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 08:03:14.0569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yA+q/lV3YxXaYVcnJVlsqHnCVEiktnyXsesgmMTkd8pH1D6w/02WZRRHA5bEtyvQ5hDSZs3qZSVPwMAR93j/WF+EXE08Yguosbz+nkZkG/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6710
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: SkNLNvvXRiD6zW92aFx2UsLrx4520388AA=
Content-Type: multipart/mixed; boundary="QoiX5pMHeiRSdOovzOkf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628669000;
 bh=AsFDyWan2cikl3WVY1qeBHYr2mnZfQLoh6k2PX0QVAs=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=YQEDNuwRHfu1TcAuszSk0VwxiSpHczH0vQveA/TlVAnPOBHBdT5u+buyyYcR0weCMdj
 g+N+OcnjtW7FREA7ytK81MzqUSYRepPdfsqJH9qPCtEVN7QPO1fLDbie09eHJtqtEB3YZ
 ZDyyw2QV4LlRYSiKiLVS/HLroVPO045z+yw=

--QoiX5pMHeiRSdOovzOkf
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 11 August 2021 07:40
>
> Hi!
>
> -stable-rc testing seems to be failing more than usual.
>
> This is the "usual" failure:
>
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> /jobs/1493077012
>
> WARNING: Retrying...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error=3Dinvalid argument
> 2170ERROR: Downloading artifacts from coordinator... error couldn't execu=
te
> GET against https://gitlab.com/api/v4/jobs/1492901612/artifacts?: Get
> https://gitlab.com/api/v4/jobs/1492901612/artifacts?: dial tcp: i/o timeo=
ut
> id=3D1492901612 token=3D9gNGsuaZ
> 2171FATAL: invalid argument
> 2173
> Uploading artifacts for failed job
>
> But I don't usually see this one:
>
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> /jobs/1492901660
>
> Job #371616: Submitted
> 219Health: Unknown
> 220Device Type: r8a7743-iwg20d-q7
> 221Device: None
> 222Test: boot
> 223URL: https://lava.ciplatform.org/scheduler/job/371616
> 224
> 226ERROR: Job failed: execution took longer than 2h0m0s seconds

It looks like the LAVA server has stopped processing jobs. Our queue has be=
come very large!
I'll have to see what died and no doubt reboot it and the labs.

Sorry for the pain.

Kind regards, Chris

>
> Links where all the failures can be seen are:
>
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linu=
x-
> 4.4.y
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linu=
x-
> 4.19.y
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linu=
x-
> 5.10.y
>
> I'll try hitting some resubmit buttons, but help would be welcome.
>
> Best regards,
> =A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 =A0=A0=A0=A0=A0=A0=A0 Pavel
> --
> DENX Software Engineering GmbH,=A0=A0=A0=A0=A0 Managing Director: Wolfgan=
g Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--QoiX5pMHeiRSdOovzOkf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6671): https://lists.cip-project.org/g/cip-dev/message/=
6671
Mute This Topic: https://lists.cip-project.org/mt/84811238/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--QoiX5pMHeiRSdOovzOkf--

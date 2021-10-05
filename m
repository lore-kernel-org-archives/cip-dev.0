Return-Path: <SRS0=70nz=OZ=lists.cip-project.org=bounce+64572+6785+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE692C433EF
	for <cip-dev@archiver.kernel.org>; Tue,  5 Oct 2021 13:41:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20BFB615A3
	for <cip-dev@archiver.kernel.org>; Tue,  5 Oct 2021 13:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 20BFB615A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MFbGYY4521723xEmsQcqMMiQ; Tue, 05 Oct 2021 06:41:18 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.100])
 by mx.groups.io with SMTP id smtpd.web11.561.1633441276831276202
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Oct 2021 06:41:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLQwPwsPZDJt+gMshzsinU9YIEWf9NxPQbifVsqLux9ScGT5oZmCnvxR4uYTc4q3q0FboDU5d+uFt8Cg9V6IIere+i5xBmPcdjDUbW3T4oM8B32nIkAxoSTpa2m6NZovv4Ube+vCXzFTN8bjbTb+xBcW2f+n4QgHAUQCPAmcyhwh9e8/EcxzRUuRDbjYGNm+b43W4GYZ2qKmNYTbc99jyzJB0gt4Qbbz1ZQ+eTephKX/MSP5NNb5rlwTQY/EWrNIE8aSGxLRceUDWggi5QGhglr3oCmGvanOplcPCWj4LtBk46e9Jd9w/cY+wph3QMhSyLjJwWYXmKhv8yTfcJfZ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YR5Xoj/Pc7My+4+8aOH4PlKC7PiwG8s3SIbtpQ1UOMY=;
 b=husxytPj3GMnmHhGz2iHc0H/qy5zDXt1BIcFEkBP6fnmpI30Rb5Te0vtbmg4JWpzaUyjC2D8H/a+R7wdXNrFHtCAkU3NyOHljhpkkEed0dCP76M+CROSiADUPZR7GXQ4cGiZ5FqD3Xqn60nlT034H6G7OLrBUn+kDB0QG96bxbvuF1aNxcdxUGd9FmZ8TddHcCuAPyHg0d4ANDfmfOUIqFIi4IFQ4FfFBDsaKtQ+sxHHuJIM7OFG96mHAISWDHCfcVLNsR6EtxHox/OZSWG4hFCwRsFIpfGw0NTtdEquf7lpdpx/VotyIWkeFx7SJTPlLsil6/8APFN1h9iPN7jJAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OSBPR01MB2182.jpnprd01.prod.outlook.com (2603:1096:603:20::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 13:41:08 +0000
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::b4aa:d600:b596:8ba0]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::b4aa:d600:b596:8ba0%7]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 13:41:08 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "Bhola, Bikram" <Bikram_Bhola@mentor.com>, Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Jan
 Kiszka <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] Prompt timeouts on ipc227e board -- randomness related?
Thread-Topic: Prompt timeouts on ipc227e board -- randomness related?
Thread-Index: AQHXskjVa8mpvXuxmkSBmLL4hUsxqau5PKuggAM0bxCAB+PCoA==
Date: Tue, 5 Oct 2021 13:41:08 +0000
Message-ID: <OSZPR01MB68770F80AE64400871800F6EB7AF9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <20210925200625.GA19637@duo.ucw.cz>
 <OSZPR01MB6877A8787F60CB9D584474CAB7A89@OSZPR01MB6877.jpnprd01.prod.outlook.com>
 <a34a0fcb84f449ef83e2843bec5a6d02@SVR-IES-MBX-03.mgc.mentorg.com>
In-Reply-To: <a34a0fcb84f449ef83e2843bec5a6d02@SVR-IES-MBX-03.mgc.mentorg.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26f84de9-ead0-4cff-58ff-08d98805c98a
x-ms-traffictypediagnostic: OSBPR01MB2182:
x-microsoft-antispam-prvs: 
 <OSBPR01MB2182CB18C2B46A454C061AC5B7AF9@OSBPR01MB2182.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: 
 wefZPdc/S9yeysbMtFITylLuxoVpiCwGI7X8SywcO5nxlWoV+LC8c+B0/NQBtJBpocLTqdA8i3fMuWUWgc7dcs69bMN65WZ6MReVLE3KswDgTA42ylGsas4gyw1CSCM6YmrsCozztjK2m9YJ2JVyoiTi2O56AN64SQtleeS5uhwoXpQRibBWQvf6yQXMPyQ++FfikDHuylx3nkpJ0tTTcC9WO84xONkf+EYE0Mli2zR9HxtAAptUAypuTWGKiBN+mJb7V1rcTS4SAH6SmLaTbXtrLKKgFoNhLv6WXUbL3PphynFW1jMEP6kV5LEOCzbbPqLjOrg2TS3a4svrK86fhVu3GnYOohfUJ1vcAUKJAF9u4Rvs0Q4iVjXDbSUPm/zgP5xeQOE7RTGYJcpUrLbTIo1h1DgewXA80LIen63zsEw351l894x92FlmKCrCEyOmCMQ0JNd46YtPudlm8KX4XAL6tJD5az24NTHpv7j8Z8lfSmlQ+kkIx8OD7UHhs5cWoxlLFncuTR8e5NfZM8VvVY8QAv73dyDHzBHcUDwBeaVmRANuqV24/Oal0HW20D80ZRU5Kfw1jJi7nwXYdLkjmVKK+29PMOTVkioJuoKIuBXstS/27jL7jzHrTvXDVjQ6pm6SNDkG+BBO5ZOnsAOW5vQubDYVqmZRs23ACGic11V8+fwxQqxTv2xAj46uhfrHxLWlUkR9QbMRN3wmY6GB45w3WXb1ANZdQAiBeF07R+neWKwYVPyOOUXyfibHP1V7xQQQ/tauey8Ca54jFaVZ2SqzSYbYKOr/lLUF63AARqE=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?/bPiMZh/lVOhIT9SGB4/+C37wawDyZrXEhVUlwlI6CNXvHangleojLcB?=
 =?Windows-1252?Q?8rri2HsR5ki8IjUdDgdXTPWWiNeSODRdUamrhQ0S7ii03th1FINi4/BJ?=
 =?Windows-1252?Q?PqbDAKpHoOqRsgS4F9BLSlZBlaPKAFH51oxKfstQiF/PQ4AHyWQyCKwC?=
 =?Windows-1252?Q?1m4ZO/guJRISjW96hUpiaJ6bQVM7ZBFko+ICR/8dviWLvOEvi62lAA8M?=
 =?Windows-1252?Q?/ZLQcqG6z6dirHXCuTjb5uHIBwMQb9QoSlfpgauFyvISD4iWyf7HC/A6?=
 =?Windows-1252?Q?mfT5gBCgDUmLUufIYHNUg5G/W/NVi8GUpcX1YEMt07xeQ9nAcOUYWrGL?=
 =?Windows-1252?Q?QWfGsdwRdaTYoKH9Lip7bpI7nwF3YZ9i0kCuS3PTWy144m0JBB5N2Jns?=
 =?Windows-1252?Q?xXWKRjZ19mX3HJkulFeHgbLRUXWc6sEwofyoLiM5TwOdzNU9etQudRNi?=
 =?Windows-1252?Q?sfNy1GK3sC1OvspvuwyiDW6WWbk0Y9Aevo6njrgOtfCt3UPS4+waRxoy?=
 =?Windows-1252?Q?yPUzxa4SprMkVH3KkTSOTZBFsYlEoCJWRZjLYnVwa98c3x4jqskk257g?=
 =?Windows-1252?Q?AF2jtMlkS5fxVAKWfYlVvH6sTiBubET6yngvqJgxww+q+Y+eWIqX3mdi?=
 =?Windows-1252?Q?4TxjkT+eWz/L5upwZF/WeK5OanyGbIR3R6+OYe0zx2NHgr8/cFncAkny?=
 =?Windows-1252?Q?4nAlTryVjZcR4E4wlcjcgvwJPhFEaIeL8f0KHdVv/qMdC4brHFoq3VnM?=
 =?Windows-1252?Q?8bXBR54xc2BhWVgWxxmVf+OqH72LuIAJa7Zk48uz+8XVPkEMM+0VWzXd?=
 =?Windows-1252?Q?l95aLq3X3uoZUu8tZy90spEbPYWyCLAMlyYXgEigEfk2nQnq/VsNDolL?=
 =?Windows-1252?Q?F5+UfVMk44dxwey1I1j6y6qXo0lefK/IduI9dpWDDEEE5h6qtX6AjJQK?=
 =?Windows-1252?Q?BhrXLjV1kbmDByEV0kts37J4zXGMX8x04AB7Vs1xC5fV4VBvJBLS2d3t?=
 =?Windows-1252?Q?Fn+FT+iNZ89FAjBshsT1aEEFT3J2Npu77W6utEH+ZH5nrwDWRO0cGE5z?=
 =?Windows-1252?Q?r52Z/Ctfjt0Q8UKk3XfAY0zG+WdUJfzC6uwdO9MdyQ/89yH5NNZYMr3e?=
 =?Windows-1252?Q?QmI2f2mjVR+Ghukv1d2NWlFB/exfS+qqvXrAx8XzAuWuUqDGSSfSTo8b?=
 =?Windows-1252?Q?/xNncf/Vt52Q8z+jS6jR7SUnxgpXRO3VbuJc0Fv/zShW5z/hUiixKeC4?=
 =?Windows-1252?Q?vCjOHNmBNeLMJ/km+tdTaeulfBQ0I5/U/Pc/uu0vtkPquaTkMbUmzlmT?=
 =?Windows-1252?Q?XWNqVkPE0BcrzAahHhrKg7UJAaMzmN02yIN8bX+8YqpZ05AL62gRKJxO?=
 =?Windows-1252?Q?lJuJRkEU4gX6La5b+5C2zCVf8VME4CIEs7E=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f84de9-ead0-4cff-58ff-08d98805c98a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 13:41:08.5782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FPzUz/UgDh6aizl0yBFm7nF6pLToZPE2md4esHg0mJS+cXQrWPwxoQNCWSzSRw/tTm1Wu0Nz3Lmb9JR85ahuFBuLGLFPONg4FIK4jJGHtVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2182
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: bGxWVm1dL10quTb86Fh9YdWcx4520388AA=
Content-Type: multipart/mixed; boundary="MWwAcg8MDdNSMarM4dYd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633441278;
 bh=YGosPEOd4zDxecYDIHxegAo0Y81c1OUtWAEmhOsSGP0=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=X5fS2dPAJHvqv259BkubTz8UV7QsvYsVLV59HYAQbgyUE/+pkTLjb5MSMEXdueGSnXB
 gMZ5FLIKGCD9ilWMDO+Sl0oBF9XSDBW/+Pm3tlz5dQxvd0tGVdbLX0mtNf4tYEJOVZdai
 9v4+b9bkjxFY7Ng7Y7VDyUw5NPabZWV92So=
Message-ID: <20211005134108.tFhfqrNiUqrI7HWYHOPYEsEDb1ZTzf-6vreScGmLp_Q@z>

--MWwAcg8MDdNSMarM4dYd
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello Bikram,

> From: Bhola, Bikram <Bikram_Bhola@mentor.com>
> Sent: 30 September 2021 12:19
>=20
> Hi Chris,
>=20
> We investigated the failure job and looks like before getting login promp=
t job
> timeout is happening . In the job definition  file - job timeout is menti=
oned
> 15mins and  sometimes due to slow network issue, it takes more time while
> downloading, untar  and deploying image. So we are seeing timeout during
> login prompt or in some cases in earlier stages also.  The work in progre=
ss to
> double up the network bandwidth within a few weeks, which will reduce the
> occurrence of this type of issues.

Thank you for your investigation.
I've have increased the timeout as you have suggested:
https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/merge_requests/49

One additional thing I've noticed, the default x86 character delay during b=
oot is 500ms, which seems a long time inbetween each character sent to the =
platform
https://lava.ciplatform.org/scheduler/device/x86-simatic-ipc227e-01/deviced=
ict#defline5

Has a lower value for boot_character_delay ever been tried?

Kind regards, Chris

>=20
> Time being, with an increased job timeout to 20mins, failure is not obser=
ved.
> We tested 10 times to be working fine.
> Example :
> https://lava.ciplatform.org/scheduler/device/x86-simatic-ipc227e-01
>=20
>=20
> changes in the job definition file
> https://lava.ciplatform.org/scheduler/job/444336/definition=20
> Current implementation
> ------------------------
> timeouts:
>   job:
>     minutes: 15
>=20
> Need to Modify
> -----------------------------------
> timeouts:
>   job:
>     minutes: 20
>=20
>=20
> Regards,
> Bikram
>=20
> -----Original Message-----
> From: Chris Paterson <Chris.Paterson2@renesas.com>
> Sent: 28 September 2021 15:38
> To: Pavel Machek <pavel@denx.de>; Bhola, Bikram
> <Bikram_Bhola@mentor.com>
> Cc: cip-dev@lists.cip-project.org; Jan Kiszka <jan.kiszka@siemens.com>
> Subject: RE: Prompt timeouts on ipc227e board -- randomness related?
>=20
> Hello Pavel,
>=20
> > From: Pavel Machek <pavel@denx.de>
> > Sent: 25 September 2021 21:06
> >
> > Hi!
> >
> > It is not first time I see this failure:
>=20
> Thank you for reporting the issue.
>=20
> Bikram is going to take a look for us (thank you).
>=20
> Kind regards, Chris
>=20
> >
> >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flava.=
c
> iplatform.org%2Fscheduler%2Fjob%2F444336&amp;data=3D04%7C01%7CChris.
> Paterson2%40renesas.com%7Cacb37b995a6c41d2090808d98404189e%7C53d
> 82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637685975391318359%7CUn
> known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6
> Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DyIPWAcblC17x6PpT3TSiGT
> QWiiinQiSuu9a3HRg4u3Q%3D&amp;reserved=3D0
> >
> >
> > [[0;32m  OK  [0m] Started Login Service.
> > [[0m[0;31m*     [0m] (1 of 2) A start job is running for=85ate sshd hos=
t keys
> (7s /
> > no limit)[K[[0;1;31m*[0m[0;31m*    [0m] (1 of 2) A start job is running
> for=85ate
> > sshd host keys (8s / no limit)[K[[0;31m*[0;1;31m*[0m[0;31m*   [0m] (1 o=
f 2)
> > A start job is running for=85ate sshd host keys (9s / no limit)[K[
> > [0;31m*[0;1;31m*[0m[0;31m*  [0m] (2 of 2) A start job is running
> for=85evices-
> > eth0.device (8s / 1min 30s)[   19.855328] systemd[1]: apt-daily-
> > upgrade.timer: Adding 3min 2.027476s random time.
> > [   19.864207] systemd[1]: apt-daily.timer: Adding 1h 54min 15.794344s
> > random time.
> > [   21.406490] systemd[1]: apt-daily-upgrade.timer: Adding 55min
> 47.041488s
> > random time.
> > [   21.415357] systemd[1]: apt-daily.timer: Adding 11h 48min 4.457495s
> > random time.
> > [   22.049807] systemd[1]: apt-daily-upgrade.timer: Adding 3min 54.1254=
06s
> > random time.
> > [   22.058500] systemd[1]: apt-daily.timer: Adding 8h 34min 47.388595s
> > random time.
> > [   22.511646] systemd[1]: apt-daily-upgrade.timer: Adding 25min
> 13.015405s
> > random time.
> > [   22.520510] systemd[1]: apt-daily.timer: Adding 11h 58min 24.212170s
> > random time.
> > [K[[0;32m  OK  [0m] Started Regenerate sshd host keys.
> > wait for prompt timed out
> > end: 2.3.4.1 login-action (duration 00:00:24) [common]
> > case: login-action
> > case_id: 9417066
> > definition: lava
> > duration: 23.98
> >
> > Any idea what is going on there? Is it just a test problem, or do we
> > have kernel regression that only happens sometimes?
> >
> > Best regards,
> > 								Pavel
> > --
> > DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--MWwAcg8MDdNSMarM4dYd
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6785): https://lists.cip-project.org/g/cip-dev/message/=
6785
Mute This Topic: https://lists.cip-project.org/mt/85867572/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--MWwAcg8MDdNSMarM4dYd--

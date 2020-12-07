Return-Path: <SRS0=2vx7=FL=lists.cip-project.org=bounce+64572+5947+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED84FC4361B
	for <cip-dev@archiver.kernel.org>; Mon,  7 Dec 2020 12:38:22 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496D1233FA
	for <cip-dev@archiver.kernel.org>; Mon,  7 Dec 2020 12:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496D1233FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5947+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 1zaIYY4521723xhPZBUcG6Ao; Mon, 07 Dec 2020 04:38:21 -0800
X-Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by mx.groups.io with SMTP id smtpd.web09.3726.1607331732694395906
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Dec 2020 01:02:13 -0800
X-Received: from [IPv6:2a00:5f00:102:0:8cc5:dff:fe97:23e8] (unknown [IPv6:2a00:5f00:102:0:8cc5:dff:fe97:23e8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: gtucker)
	by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 396831F44CE1;
	Mon,  7 Dec 2020 09:02:10 +0000 (GMT)
Subject: Re: [cip-dev] cip/linux-4.4.y-cip usb: 4 runs, 2 regressions (v4.4.243-cip51-21-g1d9a9094c010)
To: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org
Cc: "kernelci-results@groups.io" <kernelci-results@groups.io>,
 "kernel-build-reports@lists.linaro.org"
 <kernel-build-reports@lists.linaro.org>
References: <5fc87876.1c69fb81.a7e0a.0844@mx.google.com>
 <20201204164008.GB1781@duo.ucw.cz>
 <OSAPR01MB238504B0E42A849BF97CF39AB7F10@OSAPR01MB2385.jpnprd01.prod.outlook.com>
 <20201204174810.GA8507@duo.ucw.cz>
From: Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <77b48183-fab3-0d6f-df99-ceaf2eaafc07@collabora.com>
Date: Mon, 7 Dec 2020 09:02:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201204174810.GA8507@duo.ucw.cz>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: udO4lCasHWapJTF1Wgwuxniax4520388AA=
Content-Type: multipart/mixed; boundary="kgJoUg40FYNspIIZxURh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1607344701;
 bh=qPrfcaM/q8Xcs4WiQlBKxjpYPFhsir0NqG70IxVjkYQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=dlTv+rAxdcUydRksOxhVlBWyxStjCo/+2izjIXfIUN3q1FnVNtI8/KxCg7CIvPXtTjf
 7iHV+z69Yvt5ssf/25dNzm1zEg78YVEzczWYEMYZvmqqQT7aFj0LvV8GvI8MJisE26RLG
 we5a6YkRVEiz2TRu9a63PMuoEVgMEiDSxVA=

--kgJoUg40FYNspIIZxURh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04/12/2020 17:48, Pavel Machek wrote:
> Hi!
>=20
>>> *** gpg4o | HINT: Error while checking message with detached signatur=
e
>>> (PGP/MIME signature)!
>>> Couldn't locate the original MIME source of the mail to verify the si=
gnature!
>>> gpg4oh32.dll:: func_IV Init OK ***
>>>
>>> Hello, bot. Can you speak english?
>>
>> Beep boop.
>>
>> I've recently enabled these email reports. They come from KernelCI.org=
.
>> I meant to say yesterday, but forgot :(
>=20
> No problem :-).
>=20
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 2020-12-03 05:04:20.968000+00:00=C2=A0 [=C2=
=A0=C2=A0 18.800704] Freezing remaining
>>> freezable tasks ... (elapsed 0.001 seconds) done.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 2020-12-03 05:04:20.972000+00:00=C2=A0 [=C2=
=A0=C2=A0 18.809224] Suspending console(s)
>>> (use no_console_suspend to debug)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 2020-12-03 05:04:23.674000+00:00=C2=A0 [=C2=
=A0=C2=A0 18.865290] hub 3-1:1.0: activate --> -
>>> 113
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 2020-12-03 05:04:23.675000+00:00=C2=A0 [=C2=
=A0=C2=A0 18.867538] PM: suspend of devices
>>> complete after 51.550 msecs
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 2020-12-03 05:04:23.685000+00:00=C2=A0 [=C2=
=A0=C2=A0 18.868293] PM: late suspend of
>>> devices complete after 0.750 msecs
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 ... (66 line(s) more)
>>>
>>>
>>> I'm not sure where you see failure here, plus I find it hard to
>>> believe that we have broken anything between
>>> v4.4.243-cip51-10-gd7466739b72e9 and v4.4.243-cip51-21-g1d9a9094c010.
>>
>> Looking at the full test log [0] it looks like a comparison (before.tx=
t with after-freeze.txt) has gone wrong. Presumably some corrupt data?
>>
>> 05:04:29.997473  + lava-test-case compare-freeze --shell diff -u befor=
e.txt after-f[   27.830724] <LAVA_SIGNAL_STARTTC compare-freeze>
>> 05:04:30.009142  reeze.txt
>> 05:04:30.009390  --- before.txt[   27.841181] <LAVA_SIGNAL_ENDTC compa=
re-freeze>
>> 05:04:30.009581  	2019-02-14 10:12:01.895000001 +0000
>> 05:04:30.020487  +++ after-freeze.txt	2019-[   27.848337] <LAVA_SIGNAL=
_TESTCASE TEST_CASE_ID=3Dcompare-freeze RESULT=3Dfail>
>> 05:04:30.020750  02-14 10:12:11.459256544 +0000
>> 05:04:30.032157  @@ -1,4 +1,5 @@
>> 05:04:30.032446   0424:9514
>> 05:04:30.032634  +0424:ec00
>> 05:04:30.032840   04f2:b443
>> 05:04:30.033020   1d6b:0002
>> 05:04:30.033195   1d6b:0002
>=20
> This looks like USB id's. (1d6b: is Linux foundation, common in USB
> hubs). So I believe this tells us that someone plugged in device
> 0424:ec00 -- ID 0424:ec00 Standard Microsystems Corp. SMSC9512/9514
> Fast Ethernet Adapter ... and I don't think we have a bug to solve
> here.

This test dumps all the USB vendor/product IDs in a text file
before suspending the device, then does it again after resuming.
It then compares them to see if all the USB devices came back
from suspend.  In this case, it looks like the USB-Ethernet
adapter device failed.  This may be an intermittent issue, or
maybe it sometimes takes longer to resume and the test missed it
after resume.

If this was a clear regression, an automated bisection would have
most likely found the breaking commit.  There hasn't been any,
and since it's pretty unlikely anything between these 2 revisions
broke anything it's most likely an unstable test result.  It
shouldn't be specific to the CIP kernel tree, let's see if we get
the same problems in other kernel trees (stable, mainline, next).
We may also adjust timing in the test if that is what is causing
the problem.  It's not a suspend/resume performance test.

Thanks,
Guillaume

--kgJoUg40FYNspIIZxURh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5947): https://lists.cip-project.org/g/cip-dev/message=
/5947
Mute This Topic: https://lists.cip-project.org/mt/78682105/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--kgJoUg40FYNspIIZxURh--

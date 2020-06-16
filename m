Return-Path: <SRS0=C02c=75=lists.cip-project.org=bounce+64572+4798+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608BBC433E0
	for <cip-dev@archiver.kernel.org>; Tue, 16 Jun 2020 07:01:16 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF8C12074D
	for <cip-dev@archiver.kernel.org>; Tue, 16 Jun 2020 07:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="DVj/wMNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8C12074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4798+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PfmMYY4521723xJvk3QWUU9F; Tue, 16 Jun 2020 00:01:15 -0700
X-Received: from peak.toshiba-tesi.com (peak.toshiba-tesi.com [202.56.254.199])
 by mx.groups.io with SMTP id smtpd.web10.5319.1592290873773804848
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jun 2020 00:01:14 -0700
IronPort-SDR: VQX0YCbN/de5QiOxORVdNNh+7MvqdS8IG0o4AeIN5g8tkPBilBBGJb7aNxNAw/6QF/J9lriy+1
 gHDY7Xh551oA==
X-IronPort-AV: E=Sophos;i="5.73,518,1583173800"; 
   d="scan'208";a="4334959"
X-Received: from unknown (HELO TOSBLRMBX0119.TOSHIBA-TSIP.COM) ([172.28.80.118])
  by peak.toshiba-tesi.com with ESMTP; 16 Jun 2020 12:59:45 +0530
X-Received: from TOSBLRMBX0119.TOSHIBA-TSIP.COM (172.28.80.118) by
 TOSBLRMBX0119.TOSHIBA-TSIP.COM (172.28.80.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 16 Jun 2020 12:30:23 +0530
X-Received: from TOSBLRMBX0119.TOSHIBA-TSIP.COM ([::1]) by
 TOSBLRMBX0119.TOSHIBA-TSIP.COM ([fe80::fc54:5765:a052:196%9]) with mapi id
 15.01.1847.003; Tue, 16 Jun 2020 12:30:23 +0530
From: "Dinesh Kumar" <dinesh.kumar@toshiba-tsip.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: "cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Share your suggestions for supporting session lock requirement in CIP
Thread-Topic: [cip-dev] Share your suggestions for supporting session lock
 requirement in CIP
Thread-Index: AQHWQuXuAAvd+ZmcWEi6SGN7et7uCajayvOQ
Date: Tue, 16 Jun 2020 07:00:23 +0000
Message-ID: <32eb6554a6e8483c853c0a3ef4d91ecf@TOSHIBA-TSIP.COM>
References: <3999decc9e9743b7b4061b38b91f4575@TOSHIBA-TSIP.COM>
 <03bbeb30-2599-a061-cf48-f4f2b1341408@siemens.com>
In-Reply-To: <03bbeb30-2599-a061-cf48-f4f2b1341408@siemens.com>
Accept-Language: en-IN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.28.80.121]
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Y3NLXWR65sWBuBVxrqoflVG0x4520388AA=
Content-Type: multipart/mixed; boundary="1K3JFgVTVfWlJEkD0f0Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1592290875;
 bh=NnqBoBLhbRQnBUZj4gCVLUezAXXt7pLKWFiw4GYnMo8=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=DVj/wMNe6tJPm33wonkaiqMrYyT9auliyXS+IZlwLlNHuAIePatAYJVndsGtudH6o1a
 3dnjrOl8aefcwgs1Yu64PHRqpMgkmC/d0PuhY0qMVJN8oaV/aqRuGf2mOFXE0XYRxXVKp
 lNfKHGPskmme5htx1UZyTMK/U//99mUYjiY=

--1K3JFgVTVfWlJEkD0f0Q
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

Thanks for your review comments.
Kindly refer my response and let me know your opinion.

Thanks & Regards,
Dinesh Kumar


-----Original Message-----
From: Jan Kiszka <jan.kiszka@siemens.com> =

Sent: 15 June 2020 12:52
To: cip-dev@lists.cip-project.org; Dinesh Kumar <Dinesh.Kumar@TOSHIBA-TSIP.=
COM>
Cc: cip-security@lists.cip-project.org
Subject: Re: [cip-dev] Share your suggestions for supporting session lock r=
equirement in CIP

Hi Dinesh,

On 10.06.20 15:02, Dinesh Kumar wrote:
> Hi All,
> =

> IEC-62443-4-2 has following two requirements related to session terminati=
on and session lock.
> CR2.5 Req-1 Session lock: Component should support session lock after a c=
onfigurable time period of inactivity.

Why not simply enforce log out also for local (terminal) sessions?
Dinesh>>Yes, we can do that by using TMOUT.  However, we were just trying i=
f we can achieve session lock with some existing packages or minimal change=
s in CIP. But that does not seem to happen.
                 Our idea of sharing this detail here was if anyone can sug=
gest achieving session lock with some Debian packages without any modificat=
ions in the packages.   =

                 TMOUT is our backup option.             =


> CR2.6 Req-2 Remote session termination: Component should support =

> terminating remote session after a configurable time of inactivity
> =

> CR2.6 Req-2 can be met by adding system variable TMOUT.
> =

> For meeting CR2.5 we need following changes in CIP.
> =

> 1.       Systemd code changes
> =


Why?
Dinesh>>Since idle_action=3Dlock is disabled in current systemd code. We en=
abled with changes described in this email. Though it works but we are not =
sure about side effects.

> 2.       Add deamon which subscribes to dbus notification(sample code att=
ached)
> =


Why is IdleAction=3Dlock in logind.conf insufficient?
Dinesh>>It's sufficient but disabled.

> 3.       Add vlock Debian package which performs session lock

What is still missing after configuring this package?

And what about physlock?
Dinesh>>We quickly checked physlock, it's better alternate to vlock. But fi=
rst we have to decide systemd changes, since vlock or physlock only work if=
 systemd code changes are enabled.

> =

> 4.       Enable dbus in systemd

What do you mean by that?
Dinesh>>Sorry for confusing you. I meant dbus is an optional dependency of =
systemd package which is required to be enabled in CIP if we want to achiev=
e session lock with systemd.

> =

> Systemd code change are as follows.
> =

> =

> --- a/src/login/logind.c
> =

> +++ b/src/login/logind.c
> =

> @@ -1019,7 +1019,7 @@ static int =

> manager_dispatch_idle_action(sd_event_source *s, uint64_t t, void *us
> =

>                      (m->idle_action_not_before_usec <=3D 0 || n >=3D =

> m->idle_action_not_before_usec + m->idle_action_usec)) {
> =

>                          log_info("System idle. Taking action.");
> =

> =

> =

> -                        manager_handle_action(m, 0, m->idle_action, fals=
e, false);
> =

> +                        manager_handle_action(m, 0, m->idle_action, =

> + false, true);
> =

>                          m->idle_action_not_before_usec =3D n;
> =

>                  }
> =


What is the semantic of this code change? Can this be sold as a feature to =
systemd so that it may become configurable (avoid the patch)? Or is it even=
 a generic feature that everyone wants?
Dinesh>>This code simply enables idle_action=3Dlock. I am not sure why they=
 have kept it disabled. Should we post this change in upstream and ask them=
 whether it can be made configurable?

> It means there are several changes required in CIP as well as it would be=
 difficult to maintain for long term, if we chose this option.
> =

> My request is, if anyone has any better idea to achieve session lock, ple=
ase share so we can evaluate it further.

Always think upstream first: Describe your feature clearly and sell it to t=
he component that can implement it best. Once accepted, we can still look i=
nto how to bridge the time best until it hits a Debian release.

So, please describe the problem technically, including why existing tools d=
o not fulfill the requirements. And which tools or methods you examined alr=
eady.
Dinesh>>Thanks for your inputs. =

                 We have raised our query in systemd ML to know why lock ac=
tion is disabled but no one has responded so far.

Jan

--
Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate Competence Ce=
nter Embedded Linux
The information contained in this e-mail message and in any
attachments/annexure/appendices is confidential to the =

recipient and may contain privileged information. =

If you are not the intended recipient, please notify the
sender and delete the message along with any =

attachments/annexure/appendices. You should not disclose,
copy or otherwise use the information contained in the
message or any annexure. Any views expressed in this e-mail =

are those of the individual sender except where the sender =

specifically states them to be the views of =

Toshiba Software India Pvt. Ltd. (TSIP),Bangalore.

Although this transmission and any attachments are believed to be
free of any virus or other defect that might affect any computer =

system into which it is received and opened, it is the responsibility
of the recipient to ensure that it is virus free and no responsibility =

is accepted by Toshiba Embedded Software India Pvt. Ltd, for any loss or
damage arising in any way from its use.


--1K3JFgVTVfWlJEkD0f0Q
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4798): https://lists.cip-project.org/g/cip-dev/message=
/4798
Mute This Topic: https://lists.cip-project.org/mt/74795832/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--1K3JFgVTVfWlJEkD0f0Q--

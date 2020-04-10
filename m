Return-Path: <SRS0=k6eo=52=lists.cip-project.org=bounce+64572+4575+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E868C2BA2B
	for <cip-dev@archiver.kernel.org>; Fri, 10 Apr 2020 06:25:36 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B47920801
	for <cip-dev@archiver.kernel.org>; Fri, 10 Apr 2020 06:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="QDSRFu5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B47920801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4575+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qeozYY4521723xjIvqgkScKN; Thu, 09 Apr 2020 23:25:35 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web11.4314.1586499933483274509
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Apr 2020 23:25:34 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 03A6PQGe015169; Fri, 10 Apr 2020 15:25:26 +0900
X-Iguazu-Qid: 2wHHmtTgl89ZO4PzQ9
X-Iguazu-QSIG: v=2; s=0; t=1586499926; q=2wHHmtTgl89ZO4PzQ9; m=yzBOrKdgduMDrwqJmKdpeiM0JgyqjJxnppR9oxslJIA=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1112) id 03A6PPSU039977;
	Fri, 10 Apr 2020 15:25:25 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 03A6PPVh018141;
	Fri, 10 Apr 2020 15:25:25 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 03A6POTD008694;
	Fri, 10 Apr 2020 15:25:24 +0900
From: punit1.agrawal@toshiba.co.jp
To: "masashi.kudo\@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
Cc: cip-dev@lists.cip-project.org, <daniel.sangorrin@toshiba.co.jp>,
        <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [cip-dev] CIP Core target EOL dates
References: <871roxxm84.fsf@kokedama.swc.toshiba.co.jp>
	<TY2PR01MB49726008788B51961ACCB8A2A0C10@TY2PR01MB4972.jpnprd01.prod.outlook.com>
	<87mu7kw128.fsf@kokedama.swc.toshiba.co.jp>
	<TY2PR01MB497250EBBA0891A39A6B022DA0DE0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Date: Fri, 10 Apr 2020 15:25:23 +0900
In-Reply-To: <TY2PR01MB497250EBBA0891A39A6B022DA0DE0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
	(masashi's message of "Fri, 10 Apr 2020 03:00:24 +0000")
X-TSB-HOP: ON
Message-ID: <87h7xrx3fw.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: iMIJ0FzuO3jRIhqSgKzhPuKlx4520388AA=
Content-Type: multipart/mixed; boundary="BcgLn5PYJyK7zE3BMQat"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1586499935;
 bh=ddl5lAlTV46u+nzB5Qj6SOX9oZoC2L/N6hU90qQC/jM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=QDSRFu5CWqwuZEnmq261ea2MKtRMmJnRwgGooodtIuIUQPwgeZ+4GVGFj9jh+ZO68Zt
 nGwyZB+GwajY4rrS6Z5ULBCLtPTGhbquWbHaMixnAA3LQDsrUbBTLT98e63LtNmVnbQ8g
 M3csOMfOP4jFTOMXKX58yCd2TLcbFK3uKrU=

--BcgLn5PYJyK7zE3BMQat
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Kudo-san,

"masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp> writes:

> Hi, Punit-san,
>
> I also calculated, and my conclusion is the following.
>
> Debian
> - Jessie	=092015-04-26
> - Stretch =09	2017-06-17
> - Buster	=092019-07-06
> CIP SLTS Kernel
> - SLTS4.4	2017-01-17
> - SLTS4.19	2019-01-11
> * https://docs.google.com/presentation/d/1R2r7_hVijKN1VTuVc92IE4U94p9AUU=
90bMFUoGRroUI/edit?pli=3D1#slide=3Did.p7
>
> Combination	Earlier date btw two
> ---------------------------------------
> 4.4 x Jessie	2015-04-26 -> EOL: 2025-04-26
> 4.4 x Stretch	2017-01-17 -> EOL: 2027-01-17
> 4.19 x Stretch	2017-06-17 -> EOL: 2027-06-17
> 4.19 x Buster	2019-01-11 -> EOL: 2029-01-11

> +----------+--------------+--------------+--------------+
> |          |   Debian 8   |   Debian 9   |  Debian 10   |
> |   SLTS   |    Jessie    |   Stretch    |    Buster    |
> |  Kernel  |              |              |              |
> +----------+--------------+--------------+--------------+
> |   v4.4   |  2025-04-26  |  2027-01-17  |              |
> +----------+--------------+--------------+--------------+
> |  v4.19   |              |  2027-06-17  |  2029-01-11  |
> +----------+--------------+--------------+--------------+
>
> By doing this, I felt dizzy... :) So I would appreciate it if you can
> double-check.

I definitely went through it a couple of times and still made an obvious
mistake. Thanks for re-calculating and checking. The two sets match so I
am happy to accept them.

Let's wait to see if there is any more feedback on duration of support
or the methodology. We can then move to the next steps.

Thanks,
Punit

>
> Best regards,
> --
> M. Kudo
>
> -----Original Message-----
> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>=20
> Sent: Friday, April 10, 2020 11:02 AM
> To: =E5=B7=A5=E8=97=A4=E3=80=80=E9=9B=85=E5=8F=B8=EF=BC=88CTJ=E3=80=80OS=
S=E4=BA=8B=E6=A5=AD=E6=8E=A8=E9=80=B2=E5=AE=A4=EF=BC=89 <masashi.kudo@cyber=
trust.co.jp>
> Cc: cip-dev@lists.cip-project.org; daniel.sangorrin@toshiba.co.jp; kazuh=
iro3.hayashi@toshiba.co.jp
> Subject: Re: [cip-dev] CIP Core target EOL dates
>
> Hello Kudo-san,
>
> Thanks for your comments.
>
> "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp> writes:
>
>> Hi, Punit-san,
>>
>> Thanks for initiating the discussion.
>>
>> Regarding the EOL of "v4.19" x "Debian Buster", it should be=20
>> "2029-01-11" if we follow the following rule.
>>
>>>     earlier of (Kernel, Debian) release date + 10 yrs
>
> For the calculation, I used the upstream kernel release date as referenc=
e but we can use CIP kernel release dates from your slides.
>
> I wasn't sure if CIP maintenance is based on upstream release or CIP rel=
ease.
>
> With that update, the proposed dates look like -
>
> +----------+--------------+--------------+--------------+
> |          |   Debian 8   |   Debian 9   |  Debian 10   |
> |          |    Jessie    |   Stretch    |    Buster    |
> |  Kernel  |              |              |              |
> +----------+--------------+--------------+--------------+
> |   v4.4   |  2025-04-26  |  2026-01-10  |              |
> +----------+--------------+--------------+--------------+
> |  v4.19   |              |  2027-01-17  |  2029-01-11  |
> +----------+--------------+--------------+--------------+
>
> Note: There's a typo in my original mail - for Debian Buster (v4.19) the=
 EOL date should've been 2029-10-18.
>
> [...]
>
>>> Ideally, the dates for the Core components should be aligned with CIP=
=20
>>> maintained kernels but there doesn't seem to be any public=20
>>> documentation for the CIP kernel EOL dates. Let me know if this is=20
>>> written down somewhere.
>>
>> The projected EOLs are stated in the above document.
>> Regarding the web site, I noticed that the following page is not update=
d.
>>
>> https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipkernel
>> maintenance
>>
>> I will discuss this inside the kernel team.
>
> Thanks. It would be good to publish the information on CIP website. It's=
 easier to find and reference.
>
> Once agreed, we should do the same for Core components as well.
>
> Thanks,
> Punit
>
>
> [...]
>
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On=
=20
>> Behalf Of punit1.agrawal@toshiba.co.jp
>> Sent: Thursday, April 9, 2020 2:27 PM
>> To: cip-dev@lists.cip-project.org
>> Cc: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>; Kazuhiro=20
>> Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
>> Subject: [cip-dev] CIP Core target EOL dates
>>
>> Hi,
>>
>> CIP is planning to support the Kernels + Debian Rootfs combinations mar=
ked with 'x' in the table below.
>>
>> +----------+----------+-----------+-----------+
>> |          | Debian 8 | Debian 9  | Debian 10 |
>> |          |  Jessie  |  Stretch  |  Buster   |
>> |  Kernel  |          |           |           |
>> +----------+----------+-----------+-----------+
>> |   v4.4   |    x     |     x     |           |
>> +----------+----------+-----------+-----------+
>> |  v4.19   |          |     x     |     x     |
>> +----------+----------+-----------+-----------+
>>
>> So far, the details of when the support is expected to end haven't been=
 explicitly called out for Core components. It would be good to rectify thi=
s in order to set expectations and gather feedback from the user community.
>>
>> In addition, it will be helpful in estimating the required effort and p=
lanning to resource the projects appropriately.
>>
>> To start the conversation, I would like to propose the following target=
 EOL dates for each of the supported combination.
>>
>> Note: All the dates are in YYYY-MM-DD format
>>
>> +----------+--------------+--------------+--------------+
>> |          |   Debian 8   |   Debian 9   |  Debian 10   |
>> |          |    Jessie    |   Stretch    |    Buster    |
>> |  Kernel  |              |              |              |
>> +----------+--------------+--------------+--------------+
>> |   v4.4   |  2025-04-26  |  2026-01-10  |              |
>> +----------+--------------+--------------+--------------+
>> |  v4.19   |              |  2027-06-17  |  2019-10-18  |
>> +----------+--------------+--------------+--------------+
>>
>> The proposed dates have been calculated as
>>
>>     earlier of (Kernel, Debian) release date + 10 yrs
>>
>> The choice of duration (10 yrs) is arbitrary and should be adjusted bas=
ed on requirement and available resources. Also, some of the combinations c=
ould be dropped if there are no users for them.
>>
>> Ideally, the dates for the Core components should be aligned with CIP m=
aintained kernels but there doesn't seem to be any public documentation for=
 the CIP kernel EOL dates. Let me know if this is written down somewhere.
>>
>> All feedback welcome.
>>
>> Thanks,
>> Punit
>>
>>
>> The relevant Debian[0][1][2] and Kernel[3] release dates are copied bel=
ow for reference.
>>
>> Debian Release Dates
>> --------------------
>> Jessie  - 2015-04-26
>> Stretch - 2017-06-17
>> Buster  - 2019-07-06
>>
>> Linux Kernel Release Dates
>> --------------------------
>> v4.4  - 2016-01-10
>> v4.19 - 2018-10-18
>>
>>
>> [0] https://www.debian.org/releases/jessie/
>> [1] https://www.debian.org/releases/stretch/
>> [2] https://www.debian.org/releases/buster/
>> [3] https://www.kernel.org/category/releases.html
>>
>>=20
>
>=20

--BcgLn5PYJyK7zE3BMQat
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4575): https://lists.cip-project.org/g/cip-dev/message=
/4575
Mute This Topic: https://lists.cip-project.org/mt/72890803/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--BcgLn5PYJyK7zE3BMQat--

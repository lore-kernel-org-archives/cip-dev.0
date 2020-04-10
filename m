Return-Path: <SRS0=72Os=52=lists.cip-project.org=bounce+64572+4573+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A46C2BA19
	for <cip-dev@archiver.kernel.org>; Fri, 10 Apr 2020 02:02:18 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4722E20730
	for <cip-dev@archiver.kernel.org>; Fri, 10 Apr 2020 02:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="igZhClb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4722E20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4573+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id eOfRYY4521723xxCel2opAAf; Thu, 09 Apr 2020 19:02:17 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web11.1844.1586484136400329050
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Apr 2020 19:02:17 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 03A229eY017299; Fri, 10 Apr 2020 11:02:09 +0900
X-Iguazu-Qid: 34trDAmeHztAtvJ9us
X-Iguazu-QSIG: v=2; s=0; t=1586484129; q=34trDAmeHztAtvJ9us; m=9KcXGmybrmOF/QH2sE1zjg6BN+D6E8tbMESZGoqrWDQ=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1513) id 03A2281u022441;
	Fri, 10 Apr 2020 11:02:08 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 03A228FU006983;
	Fri, 10 Apr 2020 11:02:08 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 03A228XX011948;
	Fri, 10 Apr 2020 11:02:08 +0900
From: punit1.agrawal@toshiba.co.jp
To: "masashi.kudo\@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
Cc: <cip-dev@lists.cip-project.org>, <daniel.sangorrin@toshiba.co.jp>,
        <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [cip-dev] CIP Core target EOL dates
References: <871roxxm84.fsf@kokedama.swc.toshiba.co.jp>
	<TY2PR01MB49726008788B51961ACCB8A2A0C10@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Date: Fri, 10 Apr 2020 11:02:07 +0900
In-Reply-To: <TY2PR01MB49726008788B51961ACCB8A2A0C10@TY2PR01MB4972.jpnprd01.prod.outlook.com>
	(masashi's message of "Thu, 9 Apr 2020 06:04:52 +0000")
X-TSB-HOP: ON
Message-ID: <87mu7kw128.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: JEq3Pi0Zf0KMZwU85bh5BD79x4520388AA=
Content-Type: multipart/mixed; boundary="B3RhqGFaf1R4II7MkuqR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1586484137;
 bh=EZl0z/PE+2AW24tieVxhzNIzo83QkRD/816eY6Vhxjs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=igZhClb0aQd4qYlTjPKUcEWtXYQkZsc+BRDew7WFdu2C8OT9dSKnlppoiTCMxYd0da/
 E5o7oG7t4mx3deqpJ7Gep9GlyuRt7PHCknYJ2iaLaZSoyIuAqWMzvwOAna0OTpzORoxWC
 c/N5fZd92Zr7YHXhc4SzcDtETLaUD054g+c=

--B3RhqGFaf1R4II7MkuqR
Content-Type: text/plain

Hello Kudo-san,

Thanks for your comments.

"masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp> writes:

> Hi, Punit-san,
>
> Thanks for initiating the discussion.
>
> Regarding the EOL of "v4.19" x "Debian Buster", it should be
> "2029-01-11" if we follow the following rule.
>
>>     earlier of (Kernel, Debian) release date + 10 yrs

For the calculation, I used the upstream kernel release date as
reference but we can use CIP kernel release dates from your slides.

I wasn't sure if CIP maintenance is based on upstream release or CIP
release.

With that update, the proposed dates look like -

+----------+--------------+--------------+--------------+
|          |   Debian 8   |   Debian 9   |  Debian 10   |
|          |    Jessie    |   Stretch    |    Buster    |
|  Kernel  |              |              |              |
+----------+--------------+--------------+--------------+
|   v4.4   |  2025-04-26  |  2026-01-10  |              |
+----------+--------------+--------------+--------------+
|  v4.19   |              |  2027-01-17  |  2029-01-11  |
+----------+--------------+--------------+--------------+

Note: There's a typo in my original mail - for Debian Buster (v4.19) the
EOL date should've been 2029-10-18.

[...]

>> Ideally, the dates for the Core components should be aligned with CIP
>> maintained kernels but there doesn't seem to be any public
>> documentation for the CIP kernel EOL dates. Let me know if this is
>> written down somewhere.
>
> The projected EOLs are stated in the above document.
> Regarding the web site, I noticed that the following page is not updated.
>
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipkernelmaintenance
>
> I will discuss this inside the kernel team.

Thanks. It would be good to publish the information on CIP website. It's
easier to find and reference.

Once agreed, we should do the same for Core components as well.

Thanks,
Punit


[...]

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Behalf Of punit1.agrawal@toshiba.co.jp
> Sent: Thursday, April 9, 2020 2:27 PM
> To: cip-dev@lists.cip-project.org
> Cc: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>; Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
> Subject: [cip-dev] CIP Core target EOL dates
>
> Hi,
>
> CIP is planning to support the Kernels + Debian Rootfs combinations marked with 'x' in the table below.
>
> +----------+----------+-----------+-----------+
> |          | Debian 8 | Debian 9  | Debian 10 |
> |          |  Jessie  |  Stretch  |  Buster   |
> |  Kernel  |          |           |           |
> +----------+----------+-----------+-----------+
> |   v4.4   |    x     |     x     |           |
> +----------+----------+-----------+-----------+
> |  v4.19   |          |     x     |     x     |
> +----------+----------+-----------+-----------+
>
> So far, the details of when the support is expected to end haven't been explicitly called out for Core components. It would be good to rectify this in order to set expectations and gather feedback from the user community.
>
> In addition, it will be helpful in estimating the required effort and planning to resource the projects appropriately.
>
> To start the conversation, I would like to propose the following target EOL dates for each of the supported combination.
>
> Note: All the dates are in YYYY-MM-DD format
>
> +----------+--------------+--------------+--------------+
> |          |   Debian 8   |   Debian 9   |  Debian 10   |
> |          |    Jessie    |   Stretch    |    Buster    |
> |  Kernel  |              |              |              |
> +----------+--------------+--------------+--------------+
> |   v4.4   |  2025-04-26  |  2026-01-10  |              |
> +----------+--------------+--------------+--------------+
> |  v4.19   |              |  2027-06-17  |  2019-10-18  |
> +----------+--------------+--------------+--------------+
>
> The proposed dates have been calculated as
>
>     earlier of (Kernel, Debian) release date + 10 yrs
>
> The choice of duration (10 yrs) is arbitrary and should be adjusted based on requirement and available resources. Also, some of the combinations could be dropped if there are no users for them.
>
> Ideally, the dates for the Core components should be aligned with CIP maintained kernels but there doesn't seem to be any public documentation for the CIP kernel EOL dates. Let me know if this is written down somewhere.
>
> All feedback welcome.
>
> Thanks,
> Punit
>
>
> The relevant Debian[0][1][2] and Kernel[3] release dates are copied below for reference.
>
> Debian Release Dates
> --------------------
> Jessie  - 2015-04-26
> Stretch - 2017-06-17
> Buster  - 2019-07-06
>
> Linux Kernel Release Dates
> --------------------------
> v4.4  - 2016-01-10
> v4.19 - 2018-10-18
>
>
> [0] https://www.debian.org/releases/jessie/
> [1] https://www.debian.org/releases/stretch/
> [2] https://www.debian.org/releases/buster/
> [3] https://www.kernel.org/category/releases.html
>
> 

--B3RhqGFaf1R4II7MkuqR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4573): https://lists.cip-project.org/g/cip-dev/message=
/4573
Mute This Topic: https://lists.cip-project.org/mt/72890803/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--B3RhqGFaf1R4II7MkuqR--

Return-Path: <SRS0=3KfV=7I=lists.cip-project.org=bounce+64572+4642+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1A0C433DF
	for <cip-dev@archiver.kernel.org>; Tue, 26 May 2020 11:42:38 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BBDE2084C
	for <cip-dev@archiver.kernel.org>; Tue, 26 May 2020 11:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="NKnKsUdW"
Authentication-Results: mail.kernel.org; dmarc=permerror header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4642+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id mvvdYY4521723xFNyOmv308V; Tue, 26 May 2020 04:42:38 -0700
X-Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk [78.40.148.184])
 by mx.groups.io with SMTP id smtpd.web10.49073.1590493356958917129
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 May 2020 04:42:37 -0700
X-Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
	by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
	id 1jdXyP-00010l-49; Tue, 26 May 2020 12:42:21 +0100
Message-ID: <1d9dc0f0e1d9689eb7b6578127e93f2907c54b17.camel@codethink.co.uk>
Subject: Re: [cip-dev][isar-cip-core] version management
From: "Ben Hutchings" <ben.hutchings@codethink.co.uk>
To: daniel.sangorrin@toshiba.co.jp, Chris.Paterson2@renesas.com
Cc: cip-dev@lists.cip-project.org, dinesh.kumar@toshiba-tsip.com, 
	jan.kiszka@siemens.com
Date: Tue, 26 May 2020 12:42:19 +0100
In-Reply-To: <OSBPR01MB2053A08090E5533C7323928DD0B30@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: 
	<TYAPR01MB2064041238490898AD56BF62D0B90@TYAPR01MB2064.jpnprd01.prod.outlook.com>
	 <15ecf2778057028f916e644742e6a66ed115f052.camel@codethink.co.uk>
	 <OSBPR01MB2053A08090E5533C7323928DD0B30@OSBPR01MB2053.jpnprd01.prod.outlook.com>
Organization: Codethink Ltd.
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: I83OLmCdJCPjypsrxBUCQyR9x4520388AA=
Content-Type: multipart/mixed; boundary="b5sorH4bf79PnqSdb1wP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1590493358;
 bh=uVRJhhXW0YY2mxoQTc4SYL3iHAyH9sDnT7rXpW3/DUc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=NKnKsUdW99baQXY2/tDoEdQZ13FkLc2yckG8fgflnqAdFYIBQXmsd5QWdqklH+ZJ21Z
 Pggv2wEhFlVfjjhsmD2+xo34o72VJOZ9MNe3tQLWgEC2lfS/D8H0LvHV0NXvpKZ2WT6YT
 w5dGp8t8FffBxVubWpik5M4L7yCi812/jFY=

--b5sorH4bf79PnqSdb1wP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2020-05-25 at 14:50 +0000, daniel.sangorrin@toshiba.co.jp wrote:
> Thanks for your comments Ben.
> 
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Behalf Of Ben Hutchings
> > > I agree that we need to version our releases. In Debian there are
> > > point versions, but I don't think we need to follow that. Maybe we
> > > can just use a number such as the date of the release (eg. 20200519
> > > <-- yearmonthday).
> > 
> > Including punctuation in the date may make it more readable.  Also the
> > day-of-month could be omitted if there will be no more than one release
> > per month.
> 
> My preference was including the day-of-month because
> a) the kernel sometimes gets released in less than a month. But that's in case we release at the same pace.
> b) if we release a version that has a problem, we can release a new one quickly the next day.

OK.

> > > Some questions regarding versioning:
> > >    * should we also store metadata associated with a release?
> > > 	* a package list manifest for each release (dpkg -l)?
> > >         * the cip-core branch and commit
> > >         * the cip-kernel branch and commit
> > >         * md5sum of the image
> > 
> > An md5sum would help to detect accidental corruption, but that's all.
> > Any release needs to be cryptographically signed, and that will provide
> > a much stronger integrity check.
> 
> Good point, thank you.
> 
> We can create a PGP signature on gitlab-ci

Possibly... but then:

1. You have to make sure that builds are only signed when the source is
from a tag signed by one of a defined set of trusted keys.
2. You have to somehow keep the signing key secret, while the CI
configuration is mostly public.
3. I would be wary of putting that much trust in shared infrastructure.

> and send it to S3 together with the OS image. Should we put the
> public key (and fingerprint) on the image release wiki?
[...]

I certainly wouldn't feel confident about a public key fingerprint on a
wiki.  It should be somewhere that is clearly official and difficult
for an unauthorised person to change.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom


--b5sorH4bf79PnqSdb1wP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4642): https://lists.cip-project.org/g/cip-dev/message=
/4642
Mute This Topic: https://lists.cip-project.org/mt/74318282/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--b5sorH4bf79PnqSdb1wP--

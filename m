Return-Path: <SRS0=j8hf=7E=lists.cip-project.org=bounce+64572+4639+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721CFC433E0
	for <cip-dev@archiver.kernel.org>; Fri, 22 May 2020 13:04:43 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E783D2070A
	for <cip-dev@archiver.kernel.org>; Fri, 22 May 2020 13:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="pq6ZlWu6"
Authentication-Results: mail.kernel.org; dmarc=permerror header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4639+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ShKKYY4521723xbgAdpMULzl; Fri, 22 May 2020 06:04:42 -0700
X-Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk [78.40.148.184])
 by mx.groups.io with SMTP id smtpd.web12.12527.1590152680247092803
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 May 2020 06:04:40 -0700
X-Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
	by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
	id 1jc7Ln-0007x3-S2; Fri, 22 May 2020 14:04:36 +0100
Message-ID: <15ecf2778057028f916e644742e6a66ed115f052.camel@codethink.co.uk>
Subject: Re: [cip-dev][isar-cip-core] version management
From: "Ben Hutchings" <ben.hutchings@codethink.co.uk>
To: cip-dev@lists.cip-project.org, dinesh.kumar@toshiba-tsip.com, 
	jan.kiszka@siemens.com
Date: Fri, 22 May 2020 14:04:34 +0100
In-Reply-To: <TYAPR01MB2064041238490898AD56BF62D0B90@TYAPR01MB2064.jpnprd01.prod.outlook.com>
References: 
	<TYAPR01MB2064041238490898AD56BF62D0B90@TYAPR01MB2064.jpnprd01.prod.outlook.com>
Organization: Codethink Ltd.
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: GkarEFe3u4WoRFOxWREGem7cx4520388AA=
Content-Type: multipart/mixed; boundary="NYpelfPOrnUpRQAQftxL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1590152682;
 bh=Htw+O0RclyJJyGv4juaI9bovN2b8kdhAzCtfgWSNr/U=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=pq6ZlWu6W/DWlu8MsqH2+Hs7ZbJr3QO/7Q5W+k1D4T7/n2pKTdt8+Vz7xcD6IuqQkL8
 t3RKuYFbK8nr9xKU/6bGM0KNQMkJ08OHQit7gzpWoo6vEkPpBLUyoESIANO0rLFvBKkUy
 h/vNVSj+b/WWSJEkMpf2Ah/IImB14Igq/qA=

--NYpelfPOrnUpRQAQftxL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-05-19 at 03:11 +0000, Daniel Sangorrin wrote:
> Hello Dinesh, Jan, all
> 
> Dinesh raised an important issue on another thread. I created a new thread to discuss about it.
> 
> > From: Dinesh Kumar <Dinesh.Kumar@TOSHIBA-TSIP.COM>
> [...]
> > I have a question, while planning this activity can we define some version for CIP Core itself? As currently we have
> > CIP Kernel versions and versions for individual application packages.
> > e.g. If we want to share CIP Kernel and CIP Core version for IEC assessment we lack CIP Core version.
> > May be we can discuss it in upcoming CIP Core meeting.
> 
> I agree that we need to version our releases. In Debian there are
> point versions, but I don't think we need to follow that. Maybe we
> can just use a number such as the date of the release (eg. 20200519
> <-- yearmonthday).

Including punctuation in the date may make it more readable.  Also the
day-of-month could be omitted if there will be no more than one release
per month.

> Some questions regarding versioning:
>    * should we also store metadata associated with a release?
> 	* a package list manifest for each release (dpkg -l)?
>         * the cip-core branch and commit
>         * the cip-kernel branch and commit
>         * md5sum of the image

An md5sum would help to detect accidental corruption, but that's all. 
Any release needs to be cryptographically signed, and that will provide
a much stronger integrity check.

>    * do we need repository management infrastructure?
>        * mirror part of the debian repository (only the packages that we need)
>        * create snapshots for each release including the source code packages
> 
> Storing metadata should not be too difficult, just add some script
> code to gitlab-ci.
> 
> Keeping snapshots would require much more work and resources. I think
> this is not necessary since we are not going to rebuild images, and
> if we wanted we could do it somehow from the package list manifest
> and the upstream Debian ftp servers.

We should certainly record all the inputs for an image; that's a
requirement for reproducible builds.  Ideally this record would be
sufficient for someone to repeat the image build in an automated way,
either straight away or at any point in the future.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom


--NYpelfPOrnUpRQAQftxL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4639): https://lists.cip-project.org/g/cip-dev/message=
/4639
Mute This Topic: https://lists.cip-project.org/mt/74318282/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--NYpelfPOrnUpRQAQftxL--

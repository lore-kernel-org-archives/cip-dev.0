Return-Path: <SRS0=tBFH=DN=lists.cip-project.org=bounce+64572+5500+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F490C4363D
	for <cip-dev@archiver.kernel.org>; Tue,  6 Oct 2020 21:28:00 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 050A5206BE
	for <cip-dev@archiver.kernel.org>; Tue,  6 Oct 2020 21:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="KJHZb1vY"
Authentication-Results: mail.kernel.org; dmarc=permerror header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5500+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 40IyYY4521723xHpyfa5dPYZ; Tue, 06 Oct 2020 14:27:58 -0700
X-Received: from imap3.hz.codethink.co.uk (imap3.hz.codethink.co.uk [176.9.8.87])
 by mx.groups.io with SMTP id smtpd.web12.775.1602019677268096995
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Oct 2020 14:27:57 -0700
X-Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
	by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
	id 1kPuUr-0008BR-Gw; Tue, 06 Oct 2020 22:27:45 +0100
Message-ID: <5ed0afedad32a65488c6ae6184560bd6d02b37b5.camel@codethink.co.uk>
Subject: Re: [cip-dev] [cip-kernel-sec] reports: add script to convert reports to csv format
From: "Ben Hutchings" <ben.hutchings@codethink.co.uk>
To: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>, sz.lin@moxa.com, 
	wens@csie.org
Cc: cip-dev@lists.cip-project.org
Date: Tue, 06 Oct 2020 22:27:44 +0100
In-Reply-To: <20200925050756.1960978-2-daniel.sangorrin@toshiba.co.jp>
References: <20200925050756.1960978-1-daniel.sangorrin@toshiba.co.jp>
	 <20200925050756.1960978-2-daniel.sangorrin@toshiba.co.jp>
Organization: Codethink Ltd.
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 9DFlZWPnacmgVyft4rTvuBBQx4520388AA=
Content-Type: multipart/mixed; boundary="o5atTMiKTnUP4UbiAozu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602019678;
 bh=AI8F5w1c91bB8+uqVozg6rH+4RcZkG5shDmW6NJH/S8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=KJHZb1vYSD2ZZckTgClp9Q5e0mO9qn5rFeLNXv34ZnLUI1hSrLjtqez3mZlgOxkQX0d
 c5ReHWgkrLGQ9IntZByfiXaRKNHsZkTVRrHzoj7Mn3TLXzKNqhlJANzmCq1JCAA7hp5Ot
 bc/EtZKe50ap+lOKo0ZKGuO/dxXgKcaxKa0=

--o5atTMiKTnUP4UbiAozu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2020-09-25 at 14:07 +0900, Daniel Sangorrin wrote:
> The text version is probably enough for developers but
> customers usually prefer to have a CSV that you can
> open with a spreadsheet program and contains additional
> information. CVEs are sorted in rows according to their
> criticality.
[...]

I think this script is trying to do too many different things:

1. Importing data from NVD
2. Importing data from Debian security tracker
3. Parsing an existing report (!)
4. Generating a new report

1. If there's useful information from NVD that belongs in reports, and
the license allows us to redistribute it, we should add an import
script that adds that to the issue files (and extend the schema if
necessary).  We can then use that in any of the reporting scripts.

2. I'm not sure why the script is using Debian's general security
tracker.  Debian's kernel-sec normally has better information for
kernel issues, and the import_debian.py script already imports that.

3. The output of report_affected.py is intended to be human-readable,
and just happens to be relatively easy to parse.  If you want to use
its output as input, that should either be done by adding a structured
format (e.g. JSON) for the intermediate file, or by sharing code
between the two reporting scripts so there's no need to use an
intermediate file.

Other comments:

- The new script needs to be documented in README.md.

- Any files created in the process of importing data should go under
the import/ subdirectory.

- Error handling needs improvement, e.g.:

> +def download_file(src, file, bar=""):
> +    """Re-download file when an error occurred due to network connection problem.
> +    """
> +    for i in range(3):
> +        try:
> +            wget.download(src, file, bar)
> +            break
> +        except:
> +            pass

This doesn't check whether there was a network error; it retries in
case of *any* error.  The except block should specify which exception
types we want to handle.

> +    if not os.path.exists(file):
> +        print("ERROR: Can't download %s" % src)

Error messages should go to stderr.

> +        exit(1)

This should call sys.exit.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom


--o5atTMiKTnUP4UbiAozu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5500): https://lists.cip-project.org/g/cip-dev/message=
/5500
Mute This Topic: https://lists.cip-project.org/mt/77073673/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--o5atTMiKTnUP4UbiAozu--

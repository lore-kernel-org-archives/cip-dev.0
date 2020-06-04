Return-Path: <SRS0=bwnN=7R=lists.cip-project.org=bounce+64572+4709+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D74DC433E6
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:55:36 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E36B72077D
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="fZow/iHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36B72077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4709+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id q8IkYY4521723xiVpV2xIg8n; Thu, 04 Jun 2020 04:55:35 -0700
X-Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mx.groups.io with SMTP id smtpd.web11.9973.1591261837830105823
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Jun 2020 02:10:37 -0700
X-Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id CC0932065C
	for <cip-dev@lists.cip-project.org>; Thu,  4 Jun 2020 09:10:36 +0000 (UTC)
X-Received: by mail-lj1-f179.google.com with SMTP id b6so6355472ljj.1
        for <cip-dev@lists.cip-project.org>; Thu, 04 Jun 2020 02:10:36 -0700 (PDT)
X-Gm-Message-State: fR6pIlVKKUKYF7Dv3hvZWG9Nx4520388AA=
X-Google-Smtp-Source: ABdhPJxctFQRX6w3AXDCvp88YMBU7cte+7y2CV3JyyCpdKMCQkSee9tm5AO2A/x0tPM4pwL9k6eHS4vKX8kCdJkGVtE=
X-Received: by 2002:a2e:8896:: with SMTP id k22mr61540lji.331.1591261835149;
 Thu, 04 Jun 2020 02:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200603152825.GA26103@amd>
In-Reply-To: <20200603152825.GA26103@amd>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 4 Jun 2020 17:10:25 +0800
X-Gmail-Original-Message-ID: <CAGb2v67G-yqZpw-bxh+8KggAAP=7VwE4G9dsnt07vZm9AYNmpA@mail.gmail.com>
Message-ID: <CAGb2v67G-yqZpw-bxh+8KggAAP=7VwE4G9dsnt07vZm9AYNmpA@mail.gmail.com>
Subject: Re: [cip-dev] CVE-2020-10742 -- nfs client weirdness with max_rqst_size
To: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="rvGE2aq4Q3pvr8xT6qA2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591271735;
 bh=TEyserZjmjWh2vt7Z8Ymm4KIFRVa/BXJ44+f+7pISPE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=fZow/iHXg/u6SqS93NY7R+x5JzvV8hYQrQfpRLRXkGkUyQhZactFg1oMdnlZUGmrDgY
 m+HrQvaqF7nYOmPIHSQd3gRwmGS0+TQ0Yry966XxwNTnhxCgEWin3Rf8sNR3TpzPMCNh5
 BGofGrZk4ZfSl1z0rMeYmxZUrDXWSSfjuw8=

--rvGE2aq4Q3pvr8xT6qA2
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Jun 3, 2020 at 11:28 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> I did a bit of research on CVE-2020-10742.
>
> Unfortunately, RedHat is a bad player here, and bug reports are partly
> hidden from public.
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1824270
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1835127
>
> The bug does not seem especially bad (it looks like it needs specific
> configuration to trigger), and Salvatore Bonaccorso was not able to
> trigger it in 4.19.118.
>
> Original report is for 3.10 kernels, so that makes some sense.

SUSE reports it was introduced in v3.5 and fixed in v3.16.

See https://bugzilla.suse.com/show_bug.cgi?id=1171984 .

ChenYu

> I don't believe we need to do anything here.
>
> Best regards,
>
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> 

--rvGE2aq4Q3pvr8xT6qA2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4709): https://lists.cip-project.org/g/cip-dev/message=
/4709
Mute This Topic: https://lists.cip-project.org/mt/74651769/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--rvGE2aq4Q3pvr8xT6qA2--

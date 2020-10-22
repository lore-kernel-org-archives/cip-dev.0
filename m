Return-Path: <SRS0=Ty36=D5=lists.cip-project.org=bounce+64572+5639+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89208C4363A
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 10:01:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2725A2245F
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 10:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="n4XsJBPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2725A2245F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5639+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ITd5YY4521723x4cIMVpjkUn; Thu, 22 Oct 2020 03:01:09 -0700
X-Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web11.8034.1603360868306408505
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Oct 2020 03:01:08 -0700
X-Received: by mail-lf1-f48.google.com with SMTP id b1so1483472lfp.11
        for <cip-dev@lists.cip-project.org>; Thu, 22 Oct 2020 03:01:08 -0700 (PDT)
X-Gm-Message-State: NpBYZz2tMwCymlKDyUDLqzMDx4520388AA=
X-Google-Smtp-Source: ABdhPJzRQtlHCOPzL5J2Wu95H0m/1y6WD8W/bt73KtNwuFTawiCjdRgd6EB9Z3RRIzbV0O3t4CvzDg==
X-Received: by 2002:a19:c154:: with SMTP id r81mr638654lff.154.1603360866118;
        Thu, 22 Oct 2020 03:01:06 -0700 (PDT)
X-Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id r24sm226029ljk.112.2020.10.22.03.01.05
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 03:01:05 -0700 (PDT)
X-Received: by mail-lf1-f51.google.com with SMTP id a9so1497597lfc.7
        for <cip-dev@lists.cip-project.org>; Thu, 22 Oct 2020 03:01:05 -0700 (PDT)
X-Received: by 2002:a19:4281:: with SMTP id p123mr536290lfa.398.1603360865591;
 Thu, 22 Oct 2020 03:01:05 -0700 (PDT)
MIME-Version: 1.0
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 22 Oct 2020 18:00:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v65SBE5GnV4o-6y-PMz-on2Mav6iDVeuJ3KRVYgx76a__w@mail.gmail.com>
Message-ID: <CAGb2v65SBE5GnV4o-6y-PMz-on2Mav6iDVeuJ3KRVYgx76a__w@mail.gmail.com>
Subject: [cip-dev] Direct Pushes for cip-kernel-sec
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>, 
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, =?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="NmMVS2BaLpLVaBf6Gdlg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603360869;
 bh=GJCmd6BIgt4K6a232VpaMxVuW6UHopjP9/qYWx0/yr0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=n4XsJBPvJz3TGbYgQI7cDYgeeOyyqknwMEmNtJcJxINabI9I4AfvfjWaOI1KymRYcwq
 tO84bJV5KwLEOUxDBISxAmpMQo7RsqmsuwaYDkP7QI4of5ICho1r5jnfbayekjtSc7kLO
 Co9x1b+hBM2wyZN++LxWg7Fl8xjpxKPg5gU=

--NmMVS2BaLpLVaBf6Gdlg
Content-Type: text/plain; charset="UTF-8"

Hi,

After today's CIP weekly meeting, Pavel proposed the idea of skipping
merge requests for the cip-kernel-sec repository:

17:25 < pave1> wens: I see that currently merges to cip-kernel-sec are
               approved, etc... which adds a delay.
17:25 < pave1> wens: Would it be possible to direct pushes, so we can
               colaborate in the repository?
17:25 < wens> pave1: I don't have push access to cip-kernel-sec
17:26 < pave1> wens: Who can I talk to to get you one?
17:26 < pave1> wens: Because repository that is delayed like this... is not too
               useful.
17:28 < wens> not sure who has admin access, maybe szlin would know.
17:28 < iwamatsu> wens: I can add permisson, maybe
17:28 < pave1> iwamatsu: That would be nice. cip-kernel-sec is kind of
               dashboard, not a code repository.
17:28 < pave1> iwamatsu: So approving commits only delays stuff...
17:29 < wens> right, we are mostly pulling in data from other projects.
17:29 < pave1> wens: Right. Plus, you announce CVEs here, and it would be very
               nice to be able to git pull and have the information available.
17:29 < wens> occasionally we have to fill in data ourselves, but maybe we
              could do those separately with review, while having the automated
              scripts just push directly?
17:30 < iwamatsu> wens: I just send invite.
17:30 < pave1> wens: I'd prefer not to do reviews. It is our internal status,
               it does not go into product.
17:30 < wens> iwamatsu: thanks. looks like I can merge stuff now.
17:30 < pave1> wens: if we make mistake, we fix a mistake.
17:31 < pave1> iwamatsu: Thanks a lot!
17:31 < wens> pave1: so, auditing instead of reviewing
17:31 < pave1> wens: Yes, I guess.
17:32 < wens> bwh isn't around right now. we should let him know.
17:32 < pave1> Yes, I guess we need to discuss that.
17:32 < wens> I am in favor of pushing directly.
17:33 < iwamatsu> +1
17:33 < pave1> +1 :-)

Ben, could you share your thoughts on this?


Regards
ChenYu
Moxa

--NmMVS2BaLpLVaBf6Gdlg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5639): https://lists.cip-project.org/g/cip-dev/message=
/5639
Mute This Topic: https://lists.cip-project.org/mt/77727077/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--NmMVS2BaLpLVaBf6Gdlg--

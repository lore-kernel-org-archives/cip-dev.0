Return-Path: <SRS0=PPwt=EC=lists.cip-project.org=bounce+64572+5674+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10483C4363A
	for <cip-dev@archiver.kernel.org>; Tue, 27 Oct 2020 06:49:42 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 018FD2225C
	for <cip-dev@archiver.kernel.org>; Tue, 27 Oct 2020 06:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="J9F4gWOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018FD2225C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5674+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TgGvYY4521723xcAiDMHNZ5N; Mon, 26 Oct 2020 23:49:39 -0700
X-Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web08.10108.1603781378390088711
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Oct 2020 23:49:38 -0700
X-Received: by mail-lf1-f46.google.com with SMTP id a9so897103lfc.7
        for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2020 23:49:38 -0700 (PDT)
X-Gm-Message-State: ItD4gmsQ6Qy7UDDpwoRQxCE9x4520388AA=
X-Google-Smtp-Source: ABdhPJzGVwCz1OCjKz7RkEo4r1XD1NIICsISmUHJAUYEwM5AAwAIOZ0erjnphm9m+L1fE6Vzr8OWFQ==
X-Received: by 2002:a19:5215:: with SMTP id m21mr299084lfb.238.1603781376103;
        Mon, 26 Oct 2020 23:49:36 -0700 (PDT)
X-Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id f6sm60610ljg.83.2020.10.26.23.49.35
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 23:49:35 -0700 (PDT)
X-Received: by mail-lj1-f182.google.com with SMTP id x6so512580ljd.3
        for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2020 23:49:35 -0700 (PDT)
X-Received: by 2002:a2e:8116:: with SMTP id d22mr396746ljg.331.1603781375521;
 Mon, 26 Oct 2020 23:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAGb2v65SBE5GnV4o-6y-PMz-on2Mav6iDVeuJ3KRVYgx76a__w@mail.gmail.com>
 <fd3abdebef90cfa62fb03acc0057274737e886cc.camel@codethink.co.uk>
In-Reply-To: <fd3abdebef90cfa62fb03acc0057274737e886cc.camel@codethink.co.uk>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Tue, 27 Oct 2020 14:49:24 +0800
X-Gmail-Original-Message-ID: <CAGb2v66mLYZGYxf-b+LYfA9DRaYB597UGNVKyXiec=jorcDHuw@mail.gmail.com>
Message-ID: <CAGb2v66mLYZGYxf-b+LYfA9DRaYB597UGNVKyXiec=jorcDHuw@mail.gmail.com>
Subject: Re: [cip-dev] Direct Pushes for cip-kernel-sec
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>, 
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, =?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="3bjnw8aJ01hE6G17TUFa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603781379;
 bh=FJVB59g9ERZdDf+nsohaKfM7FX46kyXpAnLcGm0brFM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=J9F4gWOeHMK7jYgqAGrPbF9YQXGdPaATjktV19NO0uogiYOqGYTkDAgLjRaG1SL0h1I
 kMdtLdPZdKKoG1lk04g7UaE5cri1kFsCA8RL0CKwLqW8jKQRsowULpjTwuspbA/sVjnzD
 unFZBCzTRyXvCbo8+YQ3sAerk+1YihboQUk=

--3bjnw8aJ01hE6G17TUFa
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 23, 2020 at 1:27 AM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
>
> On Thu, 2020-10-22 at 18:00 +0800, Chen-Yu Tsai wrote:
> > Hi,
> >
> > After today's CIP weekly meeting, Pavel proposed the idea of skipping
> > merge requests for the cip-kernel-sec repository:
> [...]
> > Ben, could you share your thoughts on this?
>
> I was going to suggest you do that, for other reasons.  I didn't
> realise you weren't able to do so.  It looks you have been granted that
> permission now, is that right?

Yes. So in the future I'll push all script-imported updates directly.
Would you still like to review manual data input, or should I push those
directly as well?

ChenYu

--3bjnw8aJ01hE6G17TUFa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5674): https://lists.cip-project.org/g/cip-dev/message=
/5674
Mute This Topic: https://lists.cip-project.org/mt/77727077/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--3bjnw8aJ01hE6G17TUFa--

Return-Path: <SRS0=jSJU=KA=lists.cip-project.org=bounce+64572+6419+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B069BC433B4
	for <cip-dev@archiver.kernel.org>; Wed,  5 May 2021 07:56:40 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A685C61004
	for <cip-dev@archiver.kernel.org>; Wed,  5 May 2021 07:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A685C61004
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6419+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qlkSYY4521723xrPnOL2g2Iy; Wed, 05 May 2021 00:56:39 -0700
X-Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web08.4766.1620201398061364070
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 May 2021 00:56:38 -0700
X-Received: by mail-lf1-f46.google.com with SMTP id h4so1339264lfv.0
        for <cip-dev@lists.cip-project.org>; Wed, 05 May 2021 00:56:37 -0700 (PDT)
X-Gm-Message-State: 2NBrj7qgcRM7nMi4dAirP3s8x4520388AA=
X-Google-Smtp-Source: ABdhPJwwzjTfSi1pVm0FsJqy4W5ggYF5uTnpnsU/4+kEIB1vz7QNL5ikKpd96WIG2s7Rz/HYZKoHag==
X-Received: by 2002:a05:6512:38c9:: with SMTP id p9mr19903839lft.572.1620201395970;
        Wed, 05 May 2021 00:56:35 -0700 (PDT)
X-Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id p20sm1985504ljn.86.2021.05.05.00.56.35
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 00:56:35 -0700 (PDT)
X-Received: by mail-lf1-f48.google.com with SMTP id z9so1259723lfu.8
        for <cip-dev@lists.cip-project.org>; Wed, 05 May 2021 00:56:35 -0700 (PDT)
X-Received: by 2002:ac2:53a5:: with SMTP id j5mr19558069lfh.618.1620201395538;
 Wed, 05 May 2021 00:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAGb2v65PfUtwZX8c+W2Yygk3XTOTxfXU0SoFUjXUAh2wYuHmyA@mail.gmail.com>
 <20210505075149.GA29521@amd>
In-Reply-To: <20210505075149.GA29521@amd>
Reply-To: cip-dev@lists.cip-project.org
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Wed, 5 May 2021 15:56:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v64aHtMy_TxaKPHjyw6vEaTn+msY9De-T6s5Xo1hRdWtOg@mail.gmail.com>
Message-ID: <CAGb2v64aHtMy_TxaKPHjyw6vEaTn+msY9De-T6s5Xo1hRdWtOg@mail.gmail.com>
Subject: Re: [cip-dev] Cip-kernel-sec Updates for Week of 2021-05-05
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org, 
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Content-Type: multipart/mixed; boundary="f0bNjksHskFHz6c3MSkz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620201399;
 bh=75k6EcIyrtdfUA9e1Zn0rUA9rFQnHxwrFfpKqKXh2qA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Ym0HhtenrP3QKXn8tyVVtQperNftdA7Cur12ajZ6OSMf4nM93WuClgsHg8ew4XitlAP
 QegOt8h+ki+n5Gfa7XOsKoKT6S2b80fDtDQ2+NfCo3oPivb+gzPcMstGhozeERmxfvSXH
 Cj8qfBDGnR+aWhSiX09z1OptuzHfsT1J26I=

--f0bNjksHskFHz6c3MSkz
Content-Type: text/plain; charset="UTF-8"

On Wed, May 5, 2021 at 3:51 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > Two new CVEs this week:
> >
> > - CVE-2021-31829 [bpf: stack pointer protection from speculative
> > arithmetic] - fixed
> >   Fixes just landed in mainline as part of the merge window. Fixes not
> > tagged for stable.
>
> Could you push your changes to cip-kernel-sec?

Done. Sorry about that.

> These are queued for 5.10.35 and 4.19, I believe they may be related.
>
> v |8373088d4 b9b34d o: 5.10| bpf: Fix masking negation logic upon negative dst register
> a |fbb1ea771 b9b34d o: 4.19| bpf: Fix masking negation logic upon negative dst register
> a |024fb2412 801c60 o: 5.10| bpf: Fix leakage of uninitialized bpf stack under speculation

I only looked through my inbox. And our scripts don't pick things up
from the stable-queue. In any case they will be picked up once the
stable kernels including them are released.


ChenYu

--f0bNjksHskFHz6c3MSkz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6419): https://lists.cip-project.org/g/cip-dev/message=
/6419
Mute This Topic: https://lists.cip-project.org/mt/82597445/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--f0bNjksHskFHz6c3MSkz--

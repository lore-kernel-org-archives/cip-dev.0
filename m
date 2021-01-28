Return-Path: <SRS0=/GM8=G7=lists.cip-project.org=bounce+64572+6148+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAEDC433E0
	for <cip-dev@archiver.kernel.org>; Thu, 28 Jan 2021 09:36:57 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830F864DBD
	for <cip-dev@archiver.kernel.org>; Thu, 28 Jan 2021 09:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830F864DBD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6148+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id tH0DYY4521723xJhZsU79D4V; Thu, 28 Jan 2021 01:36:55 -0800
X-Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
 by mx.groups.io with SMTP id smtpd.web10.22272.1611826614593003083
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Jan 2021 01:36:55 -0800
X-Received: by mail-lj1-f172.google.com with SMTP id f2so5488010ljp.11
        for <cip-dev@lists.cip-project.org>; Thu, 28 Jan 2021 01:36:54 -0800 (PST)
X-Gm-Message-State: 1inUGUlbU8nib9gXwXXw9JTtx4520388AA=
X-Google-Smtp-Source: ABdhPJx9lnRm2gbGENC9MF+p1ZyvwxGQVI+al92E5nOoNBJlCsmTnOiKRyOJESy/FDOO7iXm1BZsLA==
X-Received: by 2002:a2e:84d6:: with SMTP id q22mr7679496ljh.223.1611826612477;
        Thu, 28 Jan 2021 01:36:52 -0800 (PST)
X-Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id v23sm1784929ljg.97.2021.01.28.01.36.52
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 01:36:52 -0800 (PST)
X-Received: by mail-lf1-f45.google.com with SMTP id e2so3085547lfj.13
        for <cip-dev@lists.cip-project.org>; Thu, 28 Jan 2021 01:36:52 -0800 (PST)
X-Received: by 2002:ac2:5293:: with SMTP id q19mr6936248lfm.303.1611826611894;
 Thu, 28 Jan 2021 01:36:51 -0800 (PST)
MIME-Version: 1.0
References: <CAGb2v67U62fBOE-OxbfGkOa-SJhmiJQQCXDvJ3bd44sWhsoTig@mail.gmail.com>
 <CAGb2v65bFWTC_c0TAdL2GExpB48b_GcFXeM4PCte0NZb2U38Vw@mail.gmail.com> <20210128085224.GA29422@amd>
In-Reply-To: <20210128085224.GA29422@amd>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 28 Jan 2021 17:36:40 +0800
X-Gmail-Original-Message-ID: <CAGb2v67YirQ0Qv5xtQEjhUWiWzD3rFEtPXXEwUX=p3tmNbQ2sA@mail.gmail.com>
Message-ID: <CAGb2v67YirQ0Qv5xtQEjhUWiWzD3rFEtPXXEwUX=p3tmNbQ2sA@mail.gmail.com>
Subject: Re: [cip-dev] Cip-kernel-sec Updates for Week of 2021-01-28
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="nBFm03MqHlcpaFHQzdtd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611826615;
 bh=peflHUD0PCAnLH2gXV/5hTf0aUHNbRRMJbGl4PGFISw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=oyIQgUw+tc/ArEIMBnrd+plLQ7n62hQWRZOQU+DIPfF3Wq2GM3eAs4lvM6AcxCUb0by
 Cp6n812B1QgPjAZeAo+PCtcTjF2JInGQU1VZdJ5UIyoMtXv/iWJa2EZevpoA2mQIN882m
 5rs0esK96bm1C3W4PATF92buQ4jKcVK605w=

--nBFm03MqHlcpaFHQzdtd
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Jan 28, 2021 at 4:52 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > Also, information for CVE-2020-27066 still hasn't been disclosed, and
> > the affected commit is still unclear.
>
> According to
>
> https://nvd.nist.gov/vuln/detail/CVE-2020-27066
>
> "In xfrm6_tunnel_free_spi of net/ipv6/xfrm6_tunnel.c, ..."
>
> That source file is in use by 4.4 & 4.19, rt & non-rt. There are no
> recent commits in that file in -next, so I believe it is not fixed in
> next or mainline.

Debian maintainers speculate it might be related to 4c59406ed003
("xfrm: policy: Fix doulbe free in xfrm_policy_timer").

Of course we won't really know until Google discloses the facts.

ChenYu

> Many of our configs enable it as a module:
>
> pavel@amd:~/cip/cip-kernel-config$ grep 6_XFRM_MODE_TUN */*/*
> 4.19.y-cip/arm/moxa_mxc_defconfig:CONFIG_INET6_XFRM_MODE_TUNNEL=m
> 4.19.y-cip/arm/siemens_imx6.config:CONFIG_INET6_XFRM_MODE_TUNNEL=y
> 4.19.y-cip-rt/x86/siemens_i386-rt.config:CONFIG_INET6_XFRM_MODE_TUNNEL=m
> 4.19.y-cip/x86/plathome_obsvx2.config:CONFIG_INET6_XFRM_MODE_TUNNEL=m
> 4.19.y-cip/x86/plathome_obsvx2_defconfig:CONFIG_INET6_XFRM_MODE_TUNNEL=m
> 4.19.y-cip/x86/siemens_ipc227e_defconfig:#
> CONFIG_INET6_XFRM_MODE_TUNNEL is not set
> 4.4.y-cip/arm/moxa_mxc_defconfig:CONFIG_INET6_XFRM_MODE_TUNNEL=m
> 4.4.y-cip/arm/siemens_am57xx-pxm3.config:CONFIG_INET6_XFRM_MODE_TUNNEL=m
> 4.4.y-cip/arm/siemens_dcu2.config:CONFIG_INET6_XFRM_MODE_TUNNEL=y
> 4.4.y-cip/arm/siemens_imx6_defconfig:CONFIG_INET6_XFRM_MODE_TUNNEL=y
> 4.4.y-cip-rt/x86/siemens_i386-rt.config:CONFIG_INET6_XFRM_MODE_TUNNEL=m
> 4.4.y-cip/x86/plathome_obsvx1.config:CONFIG_INET6_XFRM_MODE_TUNNEL=m
> 4.4.y-cip/x86/siemens_iot2000.config:CONFIG_INET6_XFRM_MODE_TUNNEL=y
> 5.10.y-cip/arm/moxa_mxc_defconfig:CONFIG_INET6_XFRM_MODE_TUNNEL=m
> 5.10.y-cip-rt/x86/siemens_i386-rt.config:CONFIG_INET6_XFRM_MODE_TUNNEL=m
> 5.10.y-cip/x86/plathome_obsvx2_defconfig:CONFIG_INET6_XFRM_MODE_TUNNEL=m
> 5.10.y-cip/x86/siemens_ipc227e_defconfig:#
> CONFIG_INET6_XFRM_MODE_TUNNEL is not set

--nBFm03MqHlcpaFHQzdtd
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6148): https://lists.cip-project.org/g/cip-dev/message=
/6148
Mute This Topic: https://lists.cip-project.org/mt/80176441/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--nBFm03MqHlcpaFHQzdtd--

Return-Path: <SRS0=62Q9=ND=lists.cip-project.org=bounce+64572+6677+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8DFC4338F
	for <cip-dev@archiver.kernel.org>; Thu, 12 Aug 2021 11:13:50 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3F0B6103A
	for <cip-dev@archiver.kernel.org>; Thu, 12 Aug 2021 11:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A3F0B6103A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XcylYY4521723xOIDvsAmDX0; Thu, 12 Aug 2021 04:13:49 -0700
X-Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
 by mx.groups.io with SMTP id smtpd.web10.20619.1628766827076047104
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Aug 2021 04:13:48 -0700
X-Received: by mail-ot1-f54.google.com with SMTP id r19-20020a0568301353b029050aa53c3801so7285931otq.2
        for <cip-dev@lists.cip-project.org>; Thu, 12 Aug 2021 04:13:46 -0700 (PDT)
X-Gm-Message-State: PpE3gHPkKEqMnIqnuLhw7EOBx4520388AA=
X-Google-Smtp-Source: ABdhPJz/Dcggzy30Ty6S5j8xiic52DOVWU6F42wCsJf+fbqCcOgpImSgsFKuAq0vxkvBpmjbp4imuQljE/t+5CeRL/c=
X-Received: by 2002:a05:6830:b8b:: with SMTP id a11mr3023364otv.179.1628766825718;
 Thu, 12 Aug 2021 04:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAODzB9q2GjB-rsuq-Ro43yZvVKHY-joQKiXWYx_iqowfwexVCA@mail.gmail.com>
 <20210812054337.GA26920@duo.ucw.cz> <CAODzB9p0uk5rg9ctkoXyD7VJVAzVQxqqdWwQmOhZYK=7UyShXw@mail.gmail.com>
 <20210812095201.GA32674@duo.ucw.cz>
In-Reply-To: <20210812095201.GA32674@duo.ucw.cz>
From: =?UTF-8?B?5biC5bed5q2j576O?= <masami.ichikawa@miraclelinux.com>
Date: Thu, 12 Aug 2021 20:13:09 +0900
Message-ID: <CAODzB9rSPEm7N-PStqq=oe4qQ4owB_bvkCPnvQ=2Se2SmS1KJQ@mail.gmail.com>
Subject: Re: xilinx_emaclite CVE -- was Re: [cip-dev] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="iibPEQgQ1kbrGh9eoPFC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628766829;
 bh=RZjtCABS3x0J4bnCjhdPv6mYr1adP2ALQfVwfNx84Fw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=JwKPunHFq7DoonNy869xXOobr5pI/h54vF8TGfXqI5UwIs4BthCXNYs2aRi5L1VWGvu
 hZrXHlXgq2EigUBT06Jo/DC1JNedHHvpbfpMMDP2YNfv1e8oIkJAgsc+msCKvqHMyz85S
 q5cLxETqH1pK25kgKCCsyjMPKwiJAJm/Bws=

--iibPEQgQ1kbrGh9eoPFC
Content-Type: text/plain; charset="UTF-8"

Hi !

On Thu, Aug 12, 2021 at 6:52 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > > > * CVE detail
> > > >
> > > > New CVEs
> > >
> > > > CVE-2021-38205: net: xilinx_emaclite: Do not print real IOMEM pointer
> > > >
> > > > xemaclite_of_probe() in drivers/net/ethernet/xilinx/xilinx_emaclite.c
> > > > leaks kernel memory layout.
> > > >
> > > > Fixed status
> > > >
> > > > mainline: [d0d62baa7f505bd4c59cd169692ff07ec49dde37]
> > > > stable/5.13: [8722275b41d5127048e1422a8a1b6370b4878533]
> > >
> > > This affects our kernels (I looked at 5.10.57 and 4.4.277). On one
> > > hand we could ask for backport, on the other... I'm not sure it is
> > > serious enough to warrant any action.
> > >
> >
> > I think this vulnerability seems to be low priority because an
> > attacker needs another vulnerability to abuse this vulnerability.
> > However, it would be nice to backport the patch too.
>
> So I tried to apply the patch to 4.4, but it rejects, because types
> changed in the meantime.
>
> In particular eccd5403814b4e762e270ef0464bb86fb217b1bf and
> 18af77c50fede5b3fc22aa9f0a9b255a5c5285c9 change the printk.
>
> It seems we are actually using the driver in one of the configs:
>
> ./4.4.y-cip/arm/toshiba_zynq.sources:drivers/net/ethernet/xilinx/xilinx_emaclite.c
>
> Patch for 4.4 should look like this:
>
> diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> index 909a008f9927..26cd42bfef0c 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> @@ -1180,9 +1180,8 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
>         }
>
>         dev_info(dev,
> -                "Xilinx EmacLite at 0x%08X mapped to 0x%08X, irq=%d\n",
> -                (unsigned int __force)ndev->mem_start,
> -                (unsigned int __force)lp->base_addr, ndev->irq);
> +                "Xilinx EmacLite at 0x%08X mapped to 0x%p, irq=%d\n",
> +                (unsigned int __force)ndev->mem_start, lp->base_addr, ndev->irq);
>         return 0;
>
>  error:
>

Thank you for your work!
This patch looks good to me.

> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> 
>

Regarads,

-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--iibPEQgQ1kbrGh9eoPFC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6677): https://lists.cip-project.org/g/cip-dev/message/=
6677
Mute This Topic: https://lists.cip-project.org/mt/84836349/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--iibPEQgQ1kbrGh9eoPFC--

Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D80C433F5
	for <webhook@archiver.kernel.org>; Mon,  6 Dec 2021 09:46:31 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web10.49513.1638783989675977782
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Dec 2021 01:46:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=pO1mbBLs;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.51,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-ed1-f51.google.com with SMTP id y12so40115944eda.12
        for <cip-dev@lists.cip-project.org>;
 Mon, 06 Dec 2021 01:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KeaVL1yiPmydEfhUdyAw20zUBlpcPiovqnaDa0yhS7g=;
        b=pO1mbBLsu8eXBwDP/OBni0vNnukTue/nyebCz6a6bGOJv+nKZLqQsaocQPFndMj/xF
         bmOOHKuvJsbdBaN/pd6WGvNihXaNJjNkPqRjBgcfjiHC/R5N2VakmtB7dTMdRTAIqXBB
         i+Lh+r0WWBtC97CDyFTGgfvfu6pAqLqAmZBbjrVBnuzI9yutz2MDZyNdqA8bGysI4HQt
         esoqmt2RkVnG4uOXEpgddbXxK2RgQ90CLLUe/dlIlnocZA2yUzH8ufnaEWymtn+azSTn
         i6fV7iq37vMfGmyBx19M9O9xi8nNrRRmba+jWri+2alPkGHFOX237NbzWmhJIiXce19v
         La6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KeaVL1yiPmydEfhUdyAw20zUBlpcPiovqnaDa0yhS7g=;
        b=ctA9yLmzusY/gSaCuiF4rgiNddAZQ/4qxSyEoAMpEtuPESExrMYgTk0aAPDdoU3Ou6
         2Tty/ftWacgCr930+nJtcrOeWwTTsyNbejRqExa5BPN9eBGIvG9Kcly7jbmxZdbc3vtS
         lVf1QKc5NYrw8zCdyUYYXhtfOHnNKvDMCc9TT5ltKd0E3BGSs14f85yJhn0h0zxS5Hmn
         yQfbuzz7aziY1tWd3/mMz0VCkg2ERl6iXZcTuaPCNPvIqL0kpFQc4BtCzYkkkFJbcmf7
         CSlPWkLFCwJbaeD/9HHSa0MktC51SuUWmyIr56WsVBKdX6z3FJghFs9950F8TTJ92EeO
         /E5A==
X-Gm-Message-State: AOAM53157MAIG4D3L0+SzldgZ4wYrFQLS1PoJtSbcvzPCSQ3rNTqWbaa
	a3YuNr45pybu8tf6vbvxmAPXMgfSa5SlOV8Yo4PsUmR/j8ERxmE=
X-Google-Smtp-Source: 
 ABdhPJyc9ZGBzGXaTGsbcRPcoE7yqqtYOHSvSEbOqgym4FQXmoTMr8BOK6N7g7AHukcEIVljIMJqzfiPf43g5M8REa8=
X-Received: by 2002:a05:6402:438a:: with SMTP id
 o10mr54309048edc.353.1638783973871;
 Mon, 06 Dec 2021 01:46:13 -0800 (PST)
MIME-Version: 1.0
References: 
 <TYAPR01MB62524C420EECB609794B0587926B9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
 <16BE20D57E8AF05F.1147@lists.cip-project.org>
In-Reply-To: <16BE20D57E8AF05F.1147@lists.cip-project.org>
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date: Mon, 6 Dec 2021 18:43:21 +0900
Message-ID: 
 <CANgtXuOD5-Yy88YP8v4Wi6f7pZmcxMbzx+X+rU3vLMBb9AX19g@mail.gmail.com>
Subject: Re: [cip-dev] [ANNOUNCE] Release v5.10.83-cip1 / First release of the
 CIP 5.10.y Linux kernel
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com, pavel@denx.de, Chris.Paterson2@renesas.com,
	masami.ichikawa@cybertrust.co.jp, uli@fpond.eu,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Content-Type: multipart/alternative; boundary="000000000000a0678705d27720ed"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Dec 2021 09:46:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7070

--000000000000a0678705d27720ed
Content-Type: text/plain; charset="UTF-8"

On Mon, Dec 6, 2021 at 6:36 PM Alice Ferrazzi via lists.cip-project.org
<alice.ferrazzi=miraclelinux.com@lists.cip-project.org> wrote:
>
> On Sun, Dec 5, 2021 at 8:24 AM Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp> wrote:
> >
> > Hi all,
> >
> > We release v5.10.83-cip1, which is the first release of the CIP 5.10.y
Linux kernel !
> > This is based on v5.10.83 with some additional updates for the Renesas
reference
> > boards.
> >
> > You can get this release via the git tree at:
> >
> >   v5.10.83-cip1:
> >     repository:
> >       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
> >     branch:
> >       linux-5.10.y-cip
> >     commit hash:
> >       2332f07a324fd78d7c7436deeed23cd7db441ea7
> >     added commits:
> >       CIP: Add a number to the version suffix
> >       dt-bindings: pci: rcar-pci-ep: Document missing interrupts
property
> >       dt-bindings: timer: renesas: tmu: Document r8a774e1 bindings
> >       dt-bindings: PCI: rcar-pci-host: Document r8a774e1 bindings
> >       memory: renesas-rpc-if: Make rpcif_enable/disable_rpm() as static
inline
> >       spi: spi-mem: Fix passing zero to 'PTR_ERR' warning
> >       clk: renesas: r8a774a1: Add RPC clocks
> >       clk: renesas: r8a774b1: Add RPC clocks
> >       clk: renesas: r8a774c0: Add RPC clocks
> >       pinctrl: renesas: r8a77990: Add QSPI[01] pins, groups and
functions
> >       pinctrl: renesas: r8a77990: Optimize pinctrl image size for
R8A774C0
> >       pinctrl: renesas: r8a77951: Add QSPI[01] pins, groups and
functions
> >       pinctrl: renesas: r8a77951: Optimize pinctrl image size for
R8A774E1
> >       pinctrl: renesas: r8a7796: Add QSPI[01] pins, groups and functions
> >       pinctrl: renesas: r8a7796: Optimize pinctrl image size for
R8A774A1
> >       pinctrl: renesas: r8a77965: Add QSPI[01] pins, groups and
functions
> >       pinctrl: renesas: r8a77965: Optimize pinctrl image size for
R8A774B1
> >       Add configuration for gitlab-ci.
> >
>
> In the link here under there is the difference with Linux stable v5.10.83:
> https://www.diffchecker.com/1Ber9vjb
>
> Other than having linux-5.10.y-cip tested on more boards,
> respectively 164 builds vs 184 builds for CIP kernel.
> We could also test CIP kernel on arm64,
> Linux stable looks not yet tested on arm64 with KernelCI.
> I currently don't see any relevant difference from both build tests.

From KernelCI log, we had two regressions on the baseline-nfs test on
linux-5.10.83-cip1 from
v5.10.8-8301-g3d6168cb89f6.
From what I could see Linux stable v5.10.83 didn't get under baseline-nfs
test,
so we don't have a comparison for this test.
The logs can be found here:
https://lists.cip-project.org/g/cip-dev/message/7063

Thanks,
Alicef

-- 
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

--000000000000a0678705d27720ed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Dec 6, 2021 at 6:36 PM Alice Ferrazzi via =
<a href=3D"http://lists.cip-project.org">lists.cip-project.org</a> &lt;alic=
e.ferrazzi=3D<a href=3D"mailto:miraclelinux.com@lists.cip-project.org">mira=
clelinux.com@lists.cip-project.org</a>&gt; wrote:<br>&gt;<br>&gt; On Sun, D=
ec 5, 2021 at 8:24 AM Nobuhiro Iwamatsu<br>&gt; &lt;<a href=3D"mailto:nobuh=
iro1.iwamatsu@toshiba.co.jp">nobuhiro1.iwamatsu@toshiba.co.jp</a>&gt; wrote=
:<br>&gt; &gt;<br>&gt; &gt; Hi all,<br>&gt; &gt;<br>&gt; &gt; We release v5=
.10.83-cip1, which is the first release of the CIP 5.10.y Linux kernel !<br=
>&gt; &gt; This is based on v5.10.83 with some additional updates for the R=
enesas reference<br>&gt; &gt; boards.<br>&gt; &gt;<br>&gt; &gt; You can get=
 this release via the git tree at:<br>&gt; &gt;<br>&gt; &gt; =C2=A0 v5.10.8=
3-cip1:<br>&gt; &gt; =C2=A0 =C2=A0 repository:<br>&gt; &gt; =C2=A0 =C2=A0 =
=C2=A0 <a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux=
-cip.git">https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git=
</a><br>&gt; &gt; =C2=A0 =C2=A0 branch:<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 l=
inux-5.10.y-cip<br>&gt; &gt; =C2=A0 =C2=A0 commit hash:<br>&gt; &gt; =C2=A0=
 =C2=A0 =C2=A0 2332f07a324fd78d7c7436deeed23cd7db441ea7<br>&gt; &gt; =C2=A0=
 =C2=A0 added commits:<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 CIP: Add a number =
to the version suffix<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 dt-bindings: pci: r=
car-pci-ep: Document missing interrupts property<br>&gt; &gt; =C2=A0 =C2=A0=
 =C2=A0 dt-bindings: timer: renesas: tmu: Document r8a774e1 bindings<br>&gt=
; &gt; =C2=A0 =C2=A0 =C2=A0 dt-bindings: PCI: rcar-pci-host: Document r8a77=
4e1 bindings<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 memory: renesas-rpc-if: Make=
 rpcif_enable/disable_rpm() as static inline<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 spi: spi-mem: Fix passing zero to &#39;PTR_ERR&#39; warning<br>&gt; &gt=
; =C2=A0 =C2=A0 =C2=A0 clk: renesas: r8a774a1: Add RPC clocks<br>&gt; &gt; =
=C2=A0 =C2=A0 =C2=A0 clk: renesas: r8a774b1: Add RPC clocks<br>&gt; &gt; =
=C2=A0 =C2=A0 =C2=A0 clk: renesas: r8a774c0: Add RPC clocks<br>&gt; &gt; =
=C2=A0 =C2=A0 =C2=A0 pinctrl: renesas: r8a77990: Add QSPI[01] pins, groups =
and functions<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 pinctrl: renesas: r8a77990:=
 Optimize pinctrl image size for R8A774C0<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0=
 pinctrl: renesas: r8a77951: Add QSPI[01] pins, groups and functions<br>&gt=
; &gt; =C2=A0 =C2=A0 =C2=A0 pinctrl: renesas: r8a77951: Optimize pinctrl im=
age size for R8A774E1<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 pinctrl: renesas: r=
8a7796: Add QSPI[01] pins, groups and functions<br>&gt; &gt; =C2=A0 =C2=A0 =
=C2=A0 pinctrl: renesas: r8a7796: Optimize pinctrl image size for R8A774A1<=
br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 pinctrl: renesas: r8a77965: Add QSPI[01] =
pins, groups and functions<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 pinctrl: renes=
as: r8a77965: Optimize pinctrl image size for R8A774B1<br>&gt; &gt; =C2=A0 =
=C2=A0 =C2=A0 Add configuration for gitlab-ci.<br>&gt; &gt;<br>&gt;<br>&gt;=
 In the link here under there is the difference with Linux stable v5.10.83:=
<br>&gt; <a href=3D"https://www.diffchecker.com/1Ber9vjb">https://www.diffc=
hecker.com/1Ber9vjb</a><br>&gt;<br>&gt; Other than having linux-5.10.y-cip =
tested on more boards,<br>&gt; respectively 164 builds vs 184 builds for CI=
P kernel.<br>&gt; We could also test CIP kernel on arm64,<br>&gt; Linux sta=
ble looks not yet tested on arm64 with KernelCI.<br>&gt; I currently don&#3=
9;t see any relevant difference from both build tests.<br><br><div>From Ker=
nelCI log<span class=3D"gmail_default" style=3D"font-size:small">,</span> w=
e had two regressions on the baseline-nfs test<span class=3D"gmail_default"=
 style=3D"font-size:small"> on linux-5.10.83-cip1 from</span></div><div><ta=
ble class=3D"gmail-table gmail-table-hover gmail-table-striped gmail-table-=
condensed gmail-clickable-table gmail-big-table gmail-dataTable gmail-no-fo=
oter" id=3D"gmail-new-regression-table" role=3D"grid" aria-describedby=3D"n=
ew-regression-table_info" style=3D"width:1172px"><tbody><tr role=3D"row" cl=
ass=3D"even"><td class=3D"gmail-kernel-column">v5.10.8-8301-g3d6168cb89f6<s=
pan class=3D"gmail_default" style=3D"font-size:small">.</span></td><td clas=
s=3D"gmail-date-column-count gmail-pull-center gmail-sorting_1"><br></td></=
tr></tbody></table><span class=3D"gmail_default" style=3D"font-size:small">=
</span>From what I could see Linux stable v5.10.83 didn&#39;t get under bas=
eline-nfs test,<br></div>so we don&#39;t have a comparison for this test.<b=
r><div>The logs can be found here:</div><div><div style=3D"font-size:small"=
 class=3D"gmail_default"><a href=3D"https://lists.cip-project.org/g/cip-dev=
/message/7063">https://lists.cip-project.org/g/cip-dev/message/7063</a></di=
v></div><div><br></div><div><div style=3D"font-size:small" class=3D"gmail_d=
efault">Thanks,</div><div style=3D"font-size:small" class=3D"gmail_default"=
>Alicef</div><br></div>-- <br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Cy=
bertrust Japan Co.,Ltd.<br>Alice Ferrazzi<br><a href=3D"mailto:alice.ferraz=
zi@miraclelinux.com">alice.ferrazzi@miraclelinux.com</a><br>=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D</div>

--000000000000a0678705d27720ed--


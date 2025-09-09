Return-Path: <hirotaka.motai@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB82CA0FED
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 08:09:42 +0000 (UTC)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
 by mx.groups.io with SMTP id smtpd.web10.7255.1757405373559486376
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Sep 2025 01:09:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=pBEUcaNU;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.169, mailfrom: hirotaka.motai@miraclelinux.com)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e9d74ec040cso3753440276.2
        for <cip-dev@lists.cip-project.org>; Tue, 09 Sep 2025 01:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1757405372; x=1758010172; darn=lists.cip-project.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PezpYHcGzufrrnMRaEEFUUdcDFC4u0mSeDrnlQtXfbE=;
        b=pBEUcaNUkccqNURVl7sG0xHsHm0KNbNrPYcCgih2oZk9gDHHbwEO9ATTND/zkwflAs
         Lrl5L7A4cSrXYLjPoAXk4qDK5lKfhoVgroQNWjubcppKevEknRc3OxiFnCiXV5ANtY/y
         UUI2T2HmvbmbC12t3xk9+vYSaohC1YPmFKstuSe9D9GJnEdXQpYvXHf+enC4r3fS7yhs
         x0ahfFAYR+mBoMO5cbZvn654XGAi/QBsUR3Hl0Mw6JeRtJ5D+ulxbohvh6nhosDZLFRE
         tQdSulPyR92uzEATlskQisxKNsi32qOI2mH4hnn4/ZGRqWd3GQ30Upm3GXxBOjduSA3n
         T+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405372; x=1758010172;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PezpYHcGzufrrnMRaEEFUUdcDFC4u0mSeDrnlQtXfbE=;
        b=sy5pxMTcLROcD5hK0+1/jRjCfoa76ROwd1t3JR0qnbXo5F8m6KnsqAr1IkJn274L+J
         oeVvsY1EQi/MT5iq3CNk0j/+3amNwtthooXSqw5FoAc2yHTqDrgIyvwBoM3T08eJU0dh
         sIGym4RQMDZlcgXKR8ssZgyYZLDPgNZXOsD9kOWXZRp4Kvs0vsNaFUHuD4eOT1jFv88K
         Ps02/v+H7PjgoLbnprso305YpQ1POFoqdSnYOCBLGiDJjy2X17fNcMdH/RV5erVHAQOs
         KzW0hQDL3Fgb/4dBF7yEvMnyVysFPCljgbP+Q1r1FphnKIjqOydjdEC9WeMZusXnanXN
         OAkg==
X-Forwarded-Encrypted: i=1; AJvYcCWByd2Frtlsba0UGJLggt2b1Zr8BCp7B0MWJqSJNdCLBdYBDiAWoHw29ilUrezwPshUXen0EC6b@lists.cip-project.org
X-Gm-Message-State: AOJu0YxuM/tpw/4+8R3h/0jLXHGhzqy7lTSG6ZjOZgOeZy7Pao7KHIxv
	44RyneqTdb/nhsBq8RgzLKBakiPVZuNRV+QWMpjyDjknPkI5WK+/MoSyICVIovgUb/+5IC3CDwM
	i46tvjXx2166DXQ7ftRGRiRw2RB5TjgLuAW9KTy7xQA==
X-Gm-Gg: ASbGnct/VgdO/XYVd6umzAYb6fvv4OPEdu/M+2rFBH/2Ecsh4G1XbZuE57rwspbLEo5
	C4ceM/BBMfJN5uY9v2u8g/gLnp8Q3nQr/Bwtg2w3CEx6PoIsEAElVuRQ/eIRViaFQZEwN5Ljf6u
	0Co2yIn76zm3MwkGMvWiXi5knKguCLto25wWYHEOCuFzySoqWul/yqJGleOZwhaETY8aIow1Nrq
	JgQt4Ho
X-Google-Smtp-Source: AGHT+IFaXIgUoRFe8Wxy5WdjYEFVIXnCZUj7JEdckiPFlcLesCux+vLuAP7oXnOmkSIbryC4mHy0fa2qU2jIHUxT2S4=
X-Received: by 2002:a05:690c:620d:b0:71c:7eb:3556 with SMTP id
 00721157ae682-727f30ae6d6mr95979427b3.15.1757405372633; Tue, 09 Sep 2025
 01:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250718100926.3151777-1-hirotaka.motai@miraclelinux.com>
 <20250718100926.3151777-6-hirotaka.motai@miraclelinux.com> <5e015ea3-6300-4a5b-9bba-b4fb5b52896f@siemens.com>
In-Reply-To: <5e015ea3-6300-4a5b-9bba-b4fb5b52896f@siemens.com>
From: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
Date: Tue, 9 Sep 2025 17:08:56 +0900
X-Gm-Features: Ac12FXzwXFUarFz7SkxbjN2G3uKdrf4CSzJJ0jLZo0wW1bmk0KrMc-USXTMen9o
Message-ID: <CANqL_VKGwC4Bdg4Vco4NGSF6jh6X5BQ9923J1cyon1CiWM2OOQ@mail.gmail.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH 5/5] zynqmp-zcu102: add README.zynqmp-zcu102
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Sep 2025 08:09:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20024

Hello Jan,

Sorry for the late reply and thanks your comments.

2025=E5=B9=B48=E6=9C=885=E6=97=A5(Tue) 18:01 Jan Kiszka <jan.kiszka@siemens=
.com>:
>
> On 18.07.25 12:09, Hirotaka Motai wrote:
> > Signed-off-by: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
> > ---
> >  doc/boards/README.zynqmp-zcu102.md | 48 ++++++++++++++++++++++++++++++
> >  wic/zynqmp-zcu102.wks.in           |  2 +-
> >  2 files changed, 49 insertions(+), 1 deletion(-)
> >  create mode 100644 doc/boards/README.zynqmp-zcu102.md
> >
> > diff --git a/doc/boards/README.zynqmp-zcu102.md b/doc/boards/README.zyn=
qmp-zcu102.md
> > new file mode 100644
> > index 000000000000..87566dbdad67
> > --- /dev/null
> > +++ b/doc/boards/README.zynqmp-zcu102.md
> > @@ -0,0 +1,48 @@
> > +# ISAR CIP Core: Instructions for the Zynq UltraScale+ MPSoC ZCU102 ev=
aluation board
> > +
> > +## Build the CIP Core image
> > +
> > +Set up `kas-container` as described in the [top-level README](../../RE=
ADME.md).
> > +Then build the base image,
> > +
> > +```
> > +$ ./kas-container menu
> > +```
> > +
> > +Select below options to create base image,
> > +and click on Build to start the build.
> > +
> > +* Kernel 6.1.x-cip
> > +* Bookworm (12)
>
> Is this a recommendation or a requirement? I assume that 6.12 + trixie
> will also work, won't it? What about older versions? Again, any
> requirements should also be expressed in Kconfig.

Based on my testing, this version combination worked.
I think 6.12 + trixie will likely work as well.
Since our request is to support kernel 6.1 and newer in isar-cip-core,
I=E2=80=99ll update it to allow only Bookworm and Trixie.

> > +
> > +After the build is finished, insert a SDCard and flash the image.
> > +
> > +## Prepare to boot from QSPI
> > +
> > +The board must be prepared to boot from QSPI.
> > +
> > +Please refer to the official website of the board below:
> > +- https://www.amd.com/en/products/adaptive-socs-and-fpgas/evaluation-b=
oards/ek-u1-zcu102-g.html
> > +
> > +and configure the board.
> > +
> > +## U-boot settings
> > +
> > +In order to boot from the SDCard, we need to set some environment vari=
able on u-boot.
> > +Switch on the board and the u-boot intaractive command line to set the=
 environment variables.
> > +
> > +```
> > +u-boot > setenv cip_serverip '192.168.0.1'
> > +u-boot > setenv cip_tftppath '/tftp'
> > +u-boot > setenv cip_nfspath  '/nfsrootfs'
> > +u-boot > setenv cip_kernel   'Image'
> > +u-boot > setenv cip_fdt_file 'zynqmp-zcu102-rev1.0.dtb'
> > +u-boot > setenv cip_bootargs 'setenv bootargs "console=3DttyPS0,115200=
n8 root=3D/dev/nfs rw nfsroot=3D${cip_serverip}:${cip_nfspath},vers=3D4,tcp=
,hard ip=3Ddhcp"'
> > +u-boot > setenv cip_bootcmd 'setenv autoload no && setenv initrd_high =
0xffffffff && setenv fdt_high 0xffffffff && dhcp && setenv serverip ${cip_s=
erverip} && tftpboot ${kernel_addr_r} ${cip_tftppath}/${cip_kernel} && tftp=
boot ${fdt_addr_r} ${cip_tftppath}/${cip_fdt_file} && run cip_bootargs && b=
ooti ${kernel_addr_r} - ${fdt_addr_r}'
> > +```
>
> Does the original firmware for the ZCU102 lack distro boot support? If
> not, you could use u-boot-script, and none of the above should be
> needed. See also how I once enabled the Ultra96 boards in [1].

Thanks.
Instead of using a command, I will recreate it using u-Boot script.

> > +
> > +you can boot from the Network via TFTP/NFS servers as follows:
> > +
> > +```
> > +u-boot > run cip_bootcmd
> > +```
> > diff --git a/wic/zynqmp-zcu102.wks.in b/wic/zynqmp-zcu102.wks.in
> > index a40d4bc9329c..0775db770717 100644
> > --- a/wic/zynqmp-zcu102.wks.in
> > +++ b/wic/zynqmp-zcu102.wks.in
> > @@ -8,9 +8,9 @@
> >  #
> >  # SPDX-License-Identifier: MIT
> >  #
> >  # short-description: Create SD card image for ZynqMP ZCU102
> > -# long-description: Creates a partitioned SD card image for Zynq Ultra=
Scale+ MPSoC ZCU102.
> > +# long-description: Create a partitioned SD card image for Zynq UltraS=
cale+ MPSoC ZCU102.
>
> Please fold into patch 3.

Yes, I will do in version 2.


> >  #
> >
> >  # SD card is partitioned as follows,
> >  #  1st partition: fat32, 448MB, for kernel image and dtb
>
> Jan
>
> [1] https://github.com/siemens/jailhouse-images
>


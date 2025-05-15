Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EE3C3ABD8
	for <webhook@archiver.kernel.org>; Fri, 16 May 2025 06:10:33 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
 by mx.groups.io with SMTP id smtpd.web11.9632.1747306745320434390
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 May 2025 03:59:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=IWBSsZqN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.219.170, mailfrom: bot@kernelci.org)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e73e9e18556so828725276.0
        for <cip-dev@lists.cip-project.org>; Thu, 15 May 2025 03:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1747306744; x=1747911544; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V9+mVn5DpGutOyYf0/d8dK/KQJNJqgH/er06PyGP5Cs=;
        b=IWBSsZqNWVJeFFsIGoWsExI/EKgafe7OpHrXtwFVbprVTzzHtDYSKumYsF86DWEtr5
         gjqMNaeEi8j4GPg3707BPs3jDWbXQxoflfP4oLzFeBJw1Q2y+Zr/kMlZOD+MPLYZ6vCp
         KYkWHXFsgxlt+wElFyma9L8xZLhM63RTrBzauUTxFErrLa9pQu7Y8VbCHoIh05ySn7xC
         1ACQ/Gmzv6rthXmZhavvKWKI722PFZ9heOVGe5oa6SyLvRFraAc5TAMF83fNJ50fXOum
         pzgNYKWvANk1/NvNcp3QQHomgYH7pUEYvzJkIKbWjVXyJ1nJKFBq9cTuHlD0uPEz8O0Q
         +kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747306744; x=1747911544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9+mVn5DpGutOyYf0/d8dK/KQJNJqgH/er06PyGP5Cs=;
        b=q6vhT7rBQjx7qgdyEJof3fLvuWL6ceQOx4lBhi/1+P/oq5b7wnjwHsE8eKpWL2r0NP
         YRwjiEJY3iTswl6cQuk6ILaq4cu0iRL36RFjhU02s1vOc19ktSbh45KsRShatVqWiQY9
         Q1NfnAHLForCMbQxp5IWHS0jkGkZWPuqYkQ/sb++42XIf4XFwIDdQTtMZF7D+Zw+4oca
         DRSSgrfv3ak41myah9FnOzQZSt6GO76tx4LjcAPZ3o3Ln6AOgIxGAFn+vbfnlu9fOg3y
         d+GozQ7GuKVu3J7UZMqnrIoDhH1HCCkwttsCtP+4r1N5RP2svDdHITeMKH2wdUqhsn0a
         o9Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUISs4MajNBkZdAXHEBrajKqS285e7LNu9vekFYkqx/s+VVBlAe+W7nlpjlSGQEr29VktiuiY8G@lists.cip-project.org
X-Gm-Message-State: AOJu0YzyI9PfOZYnUtARx/oVIBPtFWtBSTCsmTydDHF36Fa/UnmyeOYY
	fIjPnrLuaJRsrUnxoBFyG2kzzxkdDwuu95ljpnueAtvQZgIAjJDnq0xXPa2f64GJaOpCQyyzEWo
	Z8eYgiphkL02mj7wZzHdm5VpWWB1PLCm7basAHA==
X-Gm-Gg: ASbGncu8CqD5FQSTHCcziFw7jwpbLBCrFm+nUKHHFJk+gQIfhRMvBdCCg60/eZUdBvs
	Vg5oX/ObzENU14ooOpezmObKRQZo1o6xWrHSS11as/6FGBVehuLxOq5bQvRhoAg3P25QNs3ZA0B
	9jqbctZJ2F827wiEyTvWMkJvz1+k/H/70=
X-Google-Smtp-Source: AGHT+IGskM+Ymcd7Rrrg0MEahnkkJlPaW8Ev5Wxx03tYb0gSriO1Z+b/fnlRZzlXHY4VDOJSLprdyotx4cJHAWzRP6E=
X-Received: by 2002:a05:6902:2e0e:b0:e7b:4d7a:1410 with SMTP id
 3f1490d57ef6-e7b4f8870bcmr3946639276.20.1747306744336; Thu, 15 May 2025
 03:59:04 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 May 2025 03:59:03 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 May 2025 03:59:03 -0700
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Thu, 15 May 2025 03:59:03 -0700
X-Gm-Features: AX0GCFtrLMwYBqZj95un2s3tagWA70jd2G34GL2bCyL6JX9P4jcjixsu-J5dB20
Message-ID: <CACo-S-3a2m4JJFhaPAP+8+EdfDTs950ncTOjnwTkUtFVS=Fq+Q@mail.gmail.com>
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIGNpcC9saW51eC01LjEwLnktY2lwOiAoYnVpbGQpIHVua25vd24gdHlwZSBuYW1lIOKAmGlycXJldHVybl904oCZIGluIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vcmVuZXNhcy8uLi4=?=
To: kernelci-results@groups.io
Cc: gus@collabora.com, cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 May 2025 06:10:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18919

Hello,

New build issue found on cip/linux-5.10.y-cip:

---
 unknown type name =E2=80=98irqreturn_t=E2=80=99 in
drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.o
(drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:bad69ae5a6031018d1b7534daa162=
3f5b6bc4cef
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
- commit HEAD:  f32dc72d4e2a5cadfdfca58f84404d51cae038a0


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c:532:8: error:
unknown type name =E2=80=98irqreturn_t=E2=80=99
  532 | static irqreturn_t rzg2l_cru_irq(int irq, void *data)
      |        ^~~~~~~~~~~
drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c: In function
=E2=80=98rzg2l_cru_irq=E2=80=99:
drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c:612:16: error:
implicit declaration of function =E2=80=98IRQ_RETVAL=E2=80=99
[-Werror=3Dimplicit-function-declaration]
  612 |         return IRQ_RETVAL(handled);
      |                ^~~~~~~~~~
drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c: In function
=E2=80=98rzg2l_cru_start_streaming_vq=E2=80=99:
drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c:642:15: error:
implicit declaration of function =E2=80=98request_irq=E2=80=99; did you mea=
n
=E2=80=98request_key=E2=80=99? [-Werror=3Dimplicit-function-declaration]
  642 |         ret =3D request_irq(cru->image_conv_irq, rzg2l_cru_irq,
      |               ^~~~~~~~~~~
      |               request_key
drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c:643:27: error:
=E2=80=98IRQF_SHARED=E2=80=99 undeclared (first use in this function)
  643 |                           IRQF_SHARED, KBUILD_MODNAME, cru);
      |                           ^~~~~~~~~~~
drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c:643:27: note:
each undeclared identifier is reported only once for each function it
appears in
drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c:676:9: error:
implicit declaration of function =E2=80=98free_irq=E2=80=99
[-Werror=3Dimplicit-function-declaration]
  676 |         free_irq(cru->image_conv_irq, cru);
      |         ^~~~~~~~
cc1: some warnings being treated as errors
  CC [M]  drivers/media/rc/keymaps/rc-encore-enltv-fm53.o

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## defconfig+arm64-chromebook+CONFIG_CPU_BIG_ENDIAN=3Dy+debug+kselftest+tin=
yconfig
on (arm64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:68259dfefef071f536bb27ad


#kernelci issue maestro:bad69ae5a6031018d1b7534daa1623f5b6bc4cef

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org


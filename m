Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38579D116EA
	for <webhook@archiver.kernel.org>; Fri, 28 Nov 2025 22:33:12 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5215.1764369188046440820
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Nov 2025 14:33:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Br1bxsdk;
 spf=pass (domain: gmail.com, ip: 209.85.160.173, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ee14ba3d9cso20934581cf.1
        for <cip-dev@lists.cip-project.org>; Fri, 28 Nov 2025 14:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764369187; x=1764973987; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqMWBVNB3Ap55WHnv+uGpJFWuBTxeBsKljY+v+qixp8=;
        b=Br1bxsdkskc6wdt5uKdRPEkqrKedWC7SybpNWJvyUCj2eLghQxn36B4VgoTzqIE5RD
         +6cCKL722UcSklM6pBK1AIcssd1Ldr/0VmLfeT9Mv1BRs/CSRAeAwagy+Dt8zVQR6KJq
         DofRIGwfDTKRwTV8l9s0TnNF9QuSR+kvPcPvxHObd/APvFVOMHtyl3oHyDDOTcCy9J7k
         7hHneAS245m5JQXVheLeWOq0YqvU1IpQGcuh+XYFyAn6YivIe+rV1ooHqbfKBshjA/q4
         sMsHMKQrQiKjWn970rQ6VGivHwvtS2UoIBRppy4vq+rgzVdnt1axbgq4e5oitDTHNMyC
         KuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764369187; x=1764973987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rqMWBVNB3Ap55WHnv+uGpJFWuBTxeBsKljY+v+qixp8=;
        b=sPHBKrIt6MxO3ey+yv2um99vhY2SWLUpQPPdGRTmWzRfRHz4xj5PC+pTALeugXXL/e
         nroVciHwE6G7eWsVeOCPPXtdIWYLcCW0PbtWpk2HSJ9xQ9v+GN5lgpZbpsJmSfF8L4ct
         YDP3zzBlOEux3DD1hesV80ZebawQqeIKZdinOd0sScBSnju0qNYHQKHFnJexvxsGE1qR
         aZGl2XDL36Xv096FCXoVkdjeKCPvw6xhXu1TVUMR419GL9Lg1/QX8oyJIM1yiVhUDaQr
         OfHsV39KKTzR9Epiyr3o5KUyErmanwCL2fjeUc1Bf6D1zaX4Njst18IIlicy60tsBhcT
         3t+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBK2A6jCTmFqpeUIZ+0JM/yusCQfsU2vdhdqXRQAAepO3cvXdJLXwH4xRE/BopFsjRyeiv9xuX@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw94YapnH5Uu13g0qVNPsxltjfjGJmONPltK9cmcKMxlbFroxHE
	kGq3Y3aSAx9TJdKI8UkUtFqIENTSXxPkiPj18RlwmNAWvxod+b23gOVhlpoKUmW+sFLYgOwt7kh
	w9pT6ptMG6+4Bxeqejs4nMJnND61Mj2M=
X-Gm-Gg: ASbGnctA1J31S5DiG28widgsvRtCaz+3z/xmlr32j1PmdOxhtR7v/zvRqkTgiqhOldX
	ObPPoX4B3IgZVfAW0EaC8y903cMHHrz16xnCmY1VtgRKSzqZJW2s8BJh6YZfWCL5JBchKyPwLEQ
	MDfuL+sYsXHkTQqnmEsqZmPleKfhjd/QgGvE8C3TCYxpvT08cG61SJLcldNcA05INv9ersNnOIL
	Ghk3jLhgYSfSFEkqgngUSvs6UleCts+Iw7/SvNFuMVABxEwr8KiRGGlGcwEPAltuVAQ
X-Google-Smtp-Source: AGHT+IE3ihZi44c7JXRkAT66mNMjsR5EYKpGPeU5E9IFd6k35f3EntXkuAq+fhJCTDZakz/Nvo+tLT79gFlsjh6rBmo=
X-Received: by 2002:ac8:5846:0:b0:4e8:a413:bb3a with SMTP id
 d75a77b69052e-4ee58890063mr426188231cf.46.1764369186971; Fri, 28 Nov 2025
 14:33:06 -0800 (PST)
MIME-Version: 1.0
References: <d557dd8e-3f5e-403e-b741-7e4c32dee062@siemens.com>
In-Reply-To: <d557dd8e-3f5e-403e-b741-7e4c32dee062@siemens.com>
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Sat, 29 Nov 2025 07:32:55 +0900
X-Gm-Features: AWmQ_bnafj3PPIUGEqBXX1FGYDmX5FkqLBFzsaE8xeUuyXrRuja6ynE3kY8OxEM
Message-ID: <CACe6DC7pQn6xFA4N0h4TFLu2feTiU2chePjOSB6dRk9DnkSD7g@mail.gmail.com>
Subject: Re: [cip-dev] Enable KVM for x86 qemu lava devices
To: jan.kiszka@siemens.com
Cc: Chris Paterson <Chris.Paterson2@renesas.com>, cip-dev <cip-dev@lists.cip-project.org>, 
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Nov 2025 22:33:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20768

Hi all,

2025=E5=B9=B411=E6=9C=8828=E6=97=A5(=E9=87=91) 19:18 Jan Kiszka via lists.c=
ip-project.org
<jan.kiszka=3Dsiemens.com@lists.cip-project.org>:
>
> Hi all,
>
> it's almost embarrassing, but we are still struggling to get our CI
> running with trixie images. Another blocker was identified today, and
> that is insufficient CPU features when running with TCG(!) qemu machines
> for x86 in LAVA. I played with lifting TCG features levels up, but
> didn't find a matching CPU model yet, and that might also be because of
> missing qemu support in general.
>
> Both from the feature perspective (forky will raise the arch level e.g.)
> and the parity with local execution (start-qemu.sh), we should really
> switch to KVM devices only (for x86).
>
> Quirin identified that the following labs still have KVM off:
>
> - https://lava.ciplatform.org/scheduler/worker/lab-cip-cybertrust
> - https://lava.ciplatform.org/scheduler/worker/lab-patersonc
> - https://lava.ciplatform.org/scheduler/worker/lab-cip-renesas
>
> Can we change this?

FYI: We can enable it by setting "kvm: true"  in the qemu board settings.

```
boards:
  - name: qemu-foo-01
    type: qemu
    slave: lab-bar
    kvm: true
    raw_custom_option:
      - "{% set user_commands =3D {'start_tpm': {'do':'\"/usr/bin/sh
/usr/local/bin/swtpm_start.sh\"','undo':'\"/usr/bin/sh
/usr/local/bin/swtpm_finish.sh\"' },'manual_kill':
{'do':'\"/usr/bin/pkill -15 swtpm\"'}} %}"
    tags:
      - sw-update-testing
      - swtpm-jobs
```

Best regards,
  Nobuhiro
>
> Thanks,
> Jan
>
> PS: This one is currently under test and consequently fails depending on
> the device:
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/321c401d1d=
e763ab9b7c7afb0c13d26f0a70b7c5
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#20764): https://lists.cip-project.org/g/cip-dev/messa=
ge/20764
> Mute This Topic: https://lists.cip-project.org/mt/116511474/4520494
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [iwamatsu@gmai=
l.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


--=20
Nobuhiro Iwamatsu


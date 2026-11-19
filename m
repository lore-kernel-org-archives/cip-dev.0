Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12423.1795087075861252948
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Nov 2026 03:17:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20260707.gappssmtp.com header.s=20260707 header.b=YWHdKh0d;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.178, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b3402105b9so16321477b3.0
        for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2026 03:17:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795087075; cv=none;
        d=google.com; s=arc-20260327;
        b=ThXou3Kem2LaNzCcxcNpfdzR0x8R4ozt5m1fyBIF/PwGeFQVwNPZeYnOa64yEdlEDt
         WVm4iT8dHWJSCYx8BqZESgk3/MtNdyjwTBbf6K6k4TC22vPDy2rWBOP3f+M/y8SPhXRw
         GzOiAVh29uUM9t4rJS7AJIRWw3BAbrYkEuvALt3qELtqDkJZJi12wXnWA9PKeabZD474
         I6qZsBs2OhJ0zeXlCVp4fGKnuB/P8j5u1W+qfiPSCxWycM9l00weZoFft7ai10alWAHd
         6o9dxgYzXLtBPU0JG81nXSiqUncDpLVBFIXGDNQItNiPgVd+OMylb3E+GeTsgpQWcHyA
         EbgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8CM9GGeGff80wAPePdHbR73gfUaVx1XMoWPCFEQRR/o=;
        fh=9LvmEefjjy53baDGM8Yegh7402p53jH+XUS7LxvQgLA=;
        b=iJfsZXMWLF4c73CN3x0z9Yl8gD7vwtKjCOkxQV/FtB67QyRLgIEEFN1bTnsI5hhIsA
         7xMoOR0/98wAAM0EZW8+NpfVV2Vjv8Fdt9p8fym5UG+zV+DR7Xzo3UQ3qwz781zEv1id
         w0cKUGMaW3VKkOAPgap8ZM0rNaeOtB8zzibdUDktPnO14y0pE8KPZemnZK+Rim1FPLxc
         /3BWwNAIWOiOHF2t7DA39k+gwGIo0yvS/hGuNLlNfp3hyPIb45MRvLxRpV6jJldX/Tv3
         dp7kYdEuW9Sko6oM+Xoup4p2g2j/e3veA5Tds2MkBwVUdgGW2cmzIvoxy9C8bSn7NzUJ
         kA7Q==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20260707.gappssmtp.com; s=20260707; t=1795087075; x=1795691875; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8CM9GGeGff80wAPePdHbR73gfUaVx1XMoWPCFEQRR/o=;
        b=YWHdKh0d/Ex9yuAZKbXoyJVLnKJ1RazQ8dLtq30UMsTzZLa7GegGgfn767c4vMtGUZ
         r+Ne+o2YRvZMp34gLiJJVCx/qGLsN8ekfz03Guy7F0ZYQ/02YpQhEshdlvDRd2w2z2CZ
         rpjjMafogJv+9PF+8sqGZB5bUr5VQRXjP/MOh4/HwUp6p9CosO76ZBuW9//jv2uoKFiQ
         2BshLPH4xnSJ/pGeuXvNTClI4WJ1iKh7ERVS20tilCs3x4AfCTXZWXjBeC+GMNvxHkDR
         VxPWaZYKXGNWUME+eoDN3CmaU7EQlOwLby20x/UoeT7wO5a+tbUfky+GV3tjxlOEYuDy
         ju3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795087075; x=1795691875;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8CM9GGeGff80wAPePdHbR73gfUaVx1XMoWPCFEQRR/o=;
        b=ddUgZca+Mmi/mhTPh+aXVJK0aqXcM9i5dIDy+ZB+Dt43ogBVnsz9ocnUHUc56AtJzy
         +Q/JdhAJNB/YZOvO1QlzP4+1uFZRUMBY+qcTvxpLqvYzfMDqzSuceAtf7lD/lhokUPPA
         4V/YVDoLj0xazcwBRnMSiJOKYuO0Dah0iIQmMQqnqfpcoQ2q0MMyloVECr6gNnzcDmmh
         UNQOFkgdVAg44laGRo0dkfHldU6AWpYgh31TTLL9bXDAjsvCsoVhLSlKwPhtEG/1xVJ8
         xsEDhUBBbPdGdGFSKkGx9TUhF8wjYTfmZE+M0vDHQwV9c5HQD9+5XFt1wYiN0mWHvnU5
         xmug==
X-Gm-Message-State: APuU4Z87Rdo5mPrQZfWhrycRufsx1nTiYKROyzWyD8ogjte69h1tgc5P
	GaBUCAQjRveHUGbPDBIfUSXoCLrAr8l4C8ZrBZOS7AdQB+9r+2PY0VUM2CLjl9zJe60MosctojF
	ZYjssEhbqRGfanL9TeXlhve3TpbkQubBrY6b0IiqqmQ==
X-Gm-Gg: AZFdTZc3SSvQqqdN/E+KbkAxmds/tGhRByiAkxWYfJksNP6HONn95kZpNXNSmRIGYlD
	3Y6FOecMCe1c+JBOhm6VeQ+y7e8t+/gDa7ilQaZCRXaqcn2/bvl8CWsPqL91QSsEL2kRf21BF3Y
	R0Pva5dhZXPzqmB3zJ9GaCmBGRF5u+5ezfZyVq4Z2+lwZ2NmobL9ewGNEAR61Kvyh0XfUduQ5kh
	19qzQ1nEw62Dg683i+iPxkJLDJhcB0RNcsydj6MNSCl2MsJsPmkC9xVPpq7eA2PWKVj9GT0JERE
	LiHAM7Rl59b13c7fBTSDaJMV17+O1IzrfgWbkezXuJs4gi3TPYy/gKoRvyFYmDvfEwdv2lGMNUz
	GZhdJSFIVgALesokRyZ3QvjP/3EMxRnI91HK4xVLG6dH65JdOCwdh7viKnVK+IE+LljtJkrT0NH
	6WfBF58CZ1
X-Received: by 2002:a05:690c:dc2:b0:8b0:ee4a:326c with SMTP id
 00721157ae682-8b4fede8080mr20112337b3.111.1795087074585; Thu, 19 Nov 2026
 03:17:54 -0800 (PST)
MIME-Version: 1.0
References: <CAODzB9q9ieR9nEhh=sCVdOFJU+a2q3dRJZQOPkf=3QWXqzuBwA@mail.gmail.com>
 <198a5254-e4f0-4ad6-b47b-7c0090af09e7@siemens.com>
In-Reply-To: <198a5254-e4f0-4ad6-b47b-7c0090af09e7@siemens.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 19 Nov 2026 20:17:20 +0900
X-Gm-Features: Aa3M54qJ3dIaOm9ovsDFmToobTi_e6uwFzsQgsVsBA3_4-zKu0IXbJRK_L8ZltE
Message-ID: <CAODzB9pGjVV-sdRfn3TmfjxVfPhJsgEEyoJ_4pDGpp5GAEQYeg@mail.gmail.com>
Subject: Re: [kernel-cve-report] New CVE entries this week
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2026 11:17:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25013

Hi,

2026=E5=B9=B411=E6=9C=8819=E6=97=A5(=E6=9C=A8) 16:45 Jan Kiszka <jan.kiszka=
@siemens.com>:
>
> On 18.11.26 23:22, Masami Ichikawa wrote:
> > Hi!
> >
> > It's this week's CVE report.
> >
> > This week reported XXX new CVEs and XXX updated CVEs.
>
> Did we suffer from an overflow of these 3 digits now, crashing your
> script? :D
>

OOPS. Sorry about that. I forgot to update that line.

This is the correct text.

This week reported 31 new CVEs and 6 updated CVEs.

> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center


Regards,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFFBEDF155
	for <webhook@archiver.kernel.org>; Fri, 13 Feb 2026 11:43:42 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.69850.1770983022075004665
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Feb 2026 03:43:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GBUuKxnf;
 spf=pass (domain: gmail.com, ip: 209.85.222.182, mailfrom: iwamatsu@gmail.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cb3b3e643dso57109885a.2
        for <cip-dev@lists.cip-project.org>; Fri, 13 Feb 2026 03:43:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770983021; cv=none;
        d=google.com; s=arc-20240605;
        b=Boj2xmWYdfS1IXPHXfx4oNARmPKTKBZlMjQUlQJpC/jFKcWQYPg5BkRUiM9SUVm87W
         E7y/cXwc1YXKOAlE5deQsm/DFOI/tKzvVdYfWkYnkVVBJtCVOSV1QzxPUFh+IoDDwTWZ
         GJbxtK2nuWpvRiTsJChVIagY/mT9oIaPPUFHjVTbbvHybM/Zq9Fr9xqNcgT8HAiXhi8r
         dU9ocWuybFL4K6sQJU4Qahv41LvfBrVCOvjLmL7n4e9QZcajtE7SXMonanC6AWJXKEZs
         Ei6JHwkm0mVlv0+r1f6hy+lVzItVS21wMXtt/BBzsRZmXuKYBYZHI42+js8Um3jNKYVD
         1pYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r+3x+0FBSEziB1noTwMT/qIbJG2EAWB2XaDU62/otNA=;
        fh=zzSGIlCOBGBiZSwOfda0nUpqUKsOxY0SqqB799lfqHg=;
        b=JvRFsOpf2PW3+lbjjiBKLoxE5EjLCPogvvAuUO6nWLWO/OHrWzgYzijrwgb1nchw/j
         wHhnpD4RnvHRTTf/A19bbhA9RKS5xWB5Z482EdTVY3j1I9woBqTzeMepo2nQMuE3aQcm
         ZWyWjnml+QtQjyITdXMViBL7UFKPb2R7gRennhvkG0lSIPcDNhBNu18x4cX4MsRUFbat
         /sO1C4bGGo+1Olzaos8ws0cXuy9SdSO4X3xUbD1W4vx7MUVpS9vZq1QaLoPjkIx02pdT
         GaT4Llf20XGSjB8Sz+G6WYfddfdjonlqDBHbqKP9WFKV4MGypjuLbY9dB8jYSj8R6/EX
         S0eg==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770983021; x=1771587821; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+3x+0FBSEziB1noTwMT/qIbJG2EAWB2XaDU62/otNA=;
        b=GBUuKxnfNBRJqDFNSJOFoBjqr8gXsG0KhOewZiGWPskVOLiTVgpG4CXxVR57qcpqE4
         3UeUksk12+71rvmLTFwh6NyhBM7eNOkCsEfiAyb6Ud62LsKiU42DJ+WFNdhxnHvV8N6D
         fGtrZfU80rzrfx13bgJXa6YGP6t021eeytFu5OV4nGK6NsaG7N0U1BVvdzyzdWhQJvXg
         XKbB+gipfF1owZOkRPds2TJqfmdcvlMO9tzW/Xzq2t76oLl71tG+gf/KtMv1A6dTKokp
         dQieDcSGIuHNUnnDVC6CVn8FlMzLyc/SH6znuLAF00N/VSt7Pl6LPNTy0vNfQDgQVFDS
         qZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770983021; x=1771587821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r+3x+0FBSEziB1noTwMT/qIbJG2EAWB2XaDU62/otNA=;
        b=vJYIMqyNBDJcVqOor3jeacoTyOJyxIuaXen5y/2YF2+IJ1EJG2OfMPYVj/IqJ+x3nx
         7/q+qPO+eAvWeSbFY2YuP0lDyhNAC63qZYZq/kBTjlapYMvcHRGbdv3a4GI91Hnj/X4A
         ltG7MJNrt2eF1prwP/ydIEqTgih7QngR1sFcJweh+zvvW0dgJQrVm02c5Yub7wFAXt5f
         s4D1H5nF9xzF0F5TYPI5y8C1FjNegiC4YXrSPczLItOW9MTxdOrD9fhA7b0kyi6KhWZp
         95inbGaueE4uAdOrFOK6zcVdnc69wSNfLaLz1CPAoP1It3vm42ocd2gg5PKg2Mj7UNwE
         HGtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgfKkdQa3KpwBjx0EluFYGy+sFtymhART+56ZiCE/eFa1ZKNqpBpjU9JGTV04LCAFaSHRw83y5@lists.cip-project.org
X-Gm-Message-State: AOJu0YzUAuC6xiH88csx8BVNDJmUeJZLsd8BQSUmGIp+s5AIo38E6Pqx
	ywObPjK3LYsvZtx3pSSDFONCs9FUtxan0+tzEvCsQQyBaiQf8MiFGEz/J/lfG+s0iox3950f0kE
	NRZd5ZguT0etvnF/iOQrW2XFpwAzTmFA=
X-Gm-Gg: AZuq6aLl7/9b9KlAWGTXnUR8IMAvhuV3nXSU5Wo+9vZYOrvX6eaECfd21itXMJ8QQqT
	Co2m/LXN4XodE0yH9wZ2Z8NfAKqG+GtLli55ZHMitEAB6bRYs8xDST0/aX1E4P0/FUpDb7153gl
	XfqhKAXN5cDl70RsGMbs/s+fXAb9tn/gR6UJfGI8fgD9V2TQp9iWbj1QZnBax3mXOT3KBLuMmKB
	+j0XaCbxurNr/93UZC/18ddOtpakgtr/RL/IkBT0tdcptCr+VwFYhRVgA6PnXcOWoAYRuJ9TeuV
	FAHB
X-Received: by 2002:ac8:5f50:0:b0:4ee:428e:bf0f with SMTP id
 d75a77b69052e-506a8259d21mr15713781cf.2.1770983020862; Fri, 13 Feb 2026
 03:43:40 -0800 (PST)
MIME-Version: 1.0
References: <TY7PR01MB14818948CDCC24C4DE8F193D0CD61A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <e3ba1e13-a952-4e32-9893-040801f3edeb@siemens.com>
In-Reply-To: <e3ba1e13-a952-4e32-9893-040801f3edeb@siemens.com>
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Fri, 13 Feb 2026 20:43:29 +0900
X-Gm-Features: AZwV_QjRBfpYOVhEExNDtv_JyJr1uYBEQPWpfVquD6-b_I8fBkjNCIilhGqDkZ0
Message-ID: <CACe6DC5LCgdoPRddKHO+KwnDw6MSaFCfKHmZPb7R1TNyQhSfqA@mail.gmail.com>
Subject: Re: [cip-dev] [ANNOUNCE] Release v5.10.249-cip69, v6.1.162-cip51 and v6.12.69-cip17
To: jan.kiszka@siemens.com
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org, 
	pavel@nabladev.com, masami.ichikawa@cybertrust.co.jp, uli@fpond.eu, 
	chris.paterson2@renesas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Feb 2026 11:43:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21872

Hi Jan,

2026=E5=B9=B42=E6=9C=8813=E6=97=A5(=E9=87=91) 16:34 Jan Kiszka via lists.ci=
p-project.org
<jan.kiszka=3Dsiemens.com@lists.cip-project.org>:
>
> On 13.02.26 03:39, nobuhiro.iwamatsu.x90@mail.toshiba wrote:
> > [ANNOUNCE] Release v5.10.249-cip69, v6.1.162-cip51 and v6.12.69-cip17
> >
> > Hi all,
> >
> > CIP kernel team has released Linux kernel v5.10.249-cip69, v6.1.162-cip=
51 and
> > v6.12.69-cip17.
> > The linux-5.10.y-cip tree has been updated base version from v5.10.247 =
to
> > v5.10.249, the linux-6.1.y-cip tree has been updated base version from =
v6.1.159
> > to v6.1.162, and the linux-6.12.y-cip tree has been updated base versio=
n from
> > v6.12.66 to v6.12.69.
> > This release includes updates for Renesas ARM64 SoCs. Please check the =
following
> > information.
> >
>
> Thanks! Did you also trigger the tarball generation, and is just
> kernel.org a bit slow to perform them?

Hmm, that's a bit odd.

I am executing the tar generation trigger  with git push.
I just confirmed that the trigger was running.
I will wait a bit, and if the archive is not created, I will ask to admin.

>
> Jan
>

Best regards,
  Nobuhiro

--=20
Nobuhiro Iwamatsu


Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21F1CD6E4A
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 02:44:44 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22553.1780499640844472177
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2026 08:14:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intwineconnect.com header.s=google header.b=KCgRuEhs;
 spf=pass (domain: intwineconnect.com, ip: 209.85.218.53, mailfrom: lnasby@intwineconnect.com)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-befd83e0521so177800566b.1
        for <cip-dev@lists.cip-project.org>; Wed, 03 Jun 2026 08:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780499639; cv=none;
        d=google.com; s=arc-20240605;
        b=FzNOzZp6ohi4xM2HT9grRtLCmJVbIZZHLy09sYt9mOHljI/6adxNoHgbF5FsLMTu8s
         kjNjfyHkikZxcmigpccn89331w85Rds1m7d/W6t2PTigAN4JsUGZRv38RM6u9lpIfpB5
         tpH6b+TWv3bmm/kUyHClTFtnmfr7I0fJtZeJPZv6RA3Rx8zWEIY78WZyhiEE+o/B9ptu
         z5kLGFcE5Zz0F570s6GwwN/mRcpii6Fu3Ue0XL3OqF1w3mpLeKAvzB0GQwSGsrR2Nb5I
         ZKmoFagkje7t9J4gnVug2KuacnwieH9HLyizz5aJ1MMU9+2C9/rBdRhGOWEL4gguT2y+
         MpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=v5DIxstwXf/43sQuiO9qrK0lWGSX3vc7fmGTwxEBF6o=;
        fh=RaKH4vXZgYv/1PYcQkfLRK5D2CnBMLe+KcXQA6BQxAs=;
        b=FD/XiG8SZkrALXfJXauGtvC2wUNyDEEesxk42JPPgzyuufrWUlGTAOMR4IszuPefjx
         rI1UCnL+aleuEVv+B/zkgCVCbb+VC0i9i9x+ru8ZlyzLVuMzUU1P7XxIrbNvhbuJXxzf
         MAzohn9z7KSaumu0Pg7psUWN4Johs6KjByohr6jzWx9DIVIBDJKHirvPsyjvGTFFlPw8
         Hlu9XESDXpwQ5q1VftGMYo6ZcXRnoqaWLyok5KxnBy19P43Ktsiv6oiWIxIHIeHcxNSm
         LemBvt/X9gZeaCxMyGJQWcH0NDkPCSHa/LJ/V+mNpV9FVcfy6yOLKq8EWzx6JjAX5Oqb
         fcaQ==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intwineconnect.com; s=google; t=1780499639; x=1781104439; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v5DIxstwXf/43sQuiO9qrK0lWGSX3vc7fmGTwxEBF6o=;
        b=KCgRuEhsi/FAKf+hBI/SApYZ0uyaIsO3dR3Lg7ZLH/wWiahfXJFTlpwcie6Z9NM77Z
         c02vYqHQObUSStd/0s0plVN2OCggqizW6gnew6eHv26w1vhZJLc+j1M5xJ1M8lmkfcms
         x9uQ50GVERMp4CQLJrVaVVPLT0BmPAf7ioTVMgu0luo0aLflNl9Ub/U7/qH9UWOImYPK
         6kXW1x6JxLE4nTBUJX/d8KDhJ3VJMeYL0UaYYn/92ceHHnoRDfDHaCbeiz+jkzyCkqTb
         PDVTUfGpwlmoZJB8yHeRmal2JiDD+7hVdJRdp3K++tvFnpqjRdg4dsXfZn4hq+yPuY+y
         hc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499639; x=1781104439;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5DIxstwXf/43sQuiO9qrK0lWGSX3vc7fmGTwxEBF6o=;
        b=DuNletVlDcB8+Oi0eFbfM4TvGoBmZAN1cCYqbugAFXIhJGeLqzpGXxIEeaTCm//vQE
         5tVCmS74f9abDq7Hw6LT0nWn7TG119UpnxPWVi4trOA4L1GUFYAoJXiW+8+F03voa7kk
         Hs++LiyBZ8JdZGGXvFojITKebDeq3VTUoXDEw5t6Fc3IJNuYVozt1PSNhPSFw/p0YzqP
         SEuXLYcA+OIB7T/Y3KzFku8LKenzYeqX6mpRDviy5G2D00ht7JvDUbNJPejeYGKC8yFm
         I+69XdDSG9oVzPiZxlgwiYeXJ33Bs0vbMvI6AOWjNcnA3mCWWshkkT/ZcPDiFfZaHDQ0
         zIWg==
X-Gm-Message-State: AOJu0YzqV+gMTAjqZ/qDG2npLEH8/OUomGZHnJM7CFaWtRaofGxky7OK
	PfpHA5CgNkNq1T8WN72AtSiO5JZEUhPIwZGUIQMGJWv/nSLfCNtIjDcJl70BmhxxWWHL4tG0a9Y
	ZJCVzAC/gLUAYKg8RI5MblK09G6FU2SgTs8whr5O7/efwtNZOpEAPkBw=
X-Gm-Gg: Acq92OFrl9s5ngvuJliHVFzG2OsGnkXa1BwHDMVf/6nSXURTS0zpR/1Y/uJP1njTZzT
	B191+gFvV5XY9JyQxgFzYYPtAn96tOj8jW950MDn8idrLq8N0n0jC283tZNqwJA27tx2Gq9fQ6a
	8CGb/L9wtVQ/8Y2SQZ191ZEgt8ftk0p2r++MsCU6TtFlDQ89fvFLF+Nks7H3LCPS0qtr7sLg3rf
	vt1/8FZUspc/JnQtzPZedpi7bhTR8c7HbKoGAovoL90Y0gzLtzf6Jnvv7UmRvHgwVfoZwfIPx0T
	rUoMtlG/WxZykhb3KQ8fYU72Z2Or1fgQunA2iYgkZJFttxK+SB/BDdjRalQ+Kxm6UwYPNVoRwbU
	o111rYg==
X-Received: by 2002:a05:600c:4f05:b0:490:9dc3:3483 with SMTP id
 5b1f17b1804b1-490b610dc80mr44670645e9.2.1780499278968; Wed, 03 Jun 2026
 08:07:58 -0700 (PDT)
MIME-Version: 1.0
From: Luke Nasby <lnasby@intwineconnect.com>
Date: Wed, 3 Jun 2026 17:07:48 +0200
X-Gm-Features: AVHnY4LkIRiihvuSqYRhMzwuedak1F-J2686z76Zb4CqeoNwuxeH88y0spTOhsY
Message-ID: <CAJ6VbX+9vr3_KsyK59Pr3Nv3g_Tr8yN=ZQ=F78NH_wYxNmoo1w@mail.gmail.com>
Subject: v4.19.325-cip133 pipeline failure question
To: cip-dev@lists.cip-project.org
Content-Type: multipart/alternative; boundary="0000000000000bcb2c06535acbc2"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Jun 2026 02:44:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23041

--0000000000000bcb2c06535acbc2
Content-Type: text/plain; charset="UTF-8"

Hello,

I noticed that one of the tests in the pipeline for v4.19.325-cip133 shows
a failure that seems non-trivial:
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2558173750

In particular, it seems like a handful of specific CVE-related tests are
failing. Is this kernel considered stable for release though? It is quite
possible that I do not understand something related to these failures, but
I am just curious to know if I should wait for this to be fixed, or if this
version is currently safe to include in another project.

Thanks!
- Luke Nasby

--0000000000000bcb2c06535acbc2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>I noticed that one of=
 the tests in the=C2=A0pipeline for v4.19.325-cip133 shows a failure that s=
eems non-trivial:=C2=A0<a href=3D"https://gitlab.com/cip-project/cip-kernel=
/linux-cip/-/pipelines/2558173750">https://gitlab.com/cip-project/cip-kerne=
l/linux-cip/-/pipelines/2558173750</a></div><div><br></div><div>In particul=
ar, it seems like a handful of specific CVE-related tests are failing. Is t=
his kernel considered stable for release though? It is quite possible that =
I do not understand something related to these failures, but I am just curi=
ous to know if I should wait for this to be fixed, or if this version is cu=
rrently safe to include in another project.</div><div><br></div><div>Thanks=
!</div><div>- Luke Nasby</div></div>

--0000000000000bcb2c06535acbc2--


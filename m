Return-Path: <arisu.tachibana@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9075BC02198
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 10:18:48 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.17792.1739528323296664241
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Feb 2025 02:18:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=3QdvK2zv;
 spf=pass (domain: miraclelinux.com, ip: 209.85.214.172, mailfrom: arisu.tachibana@miraclelinux.com)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220e83d65e5so19939605ad.1
        for <cip-dev@lists.cip-project.org>; Fri, 14 Feb 2025 02:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1739528322; x=1740133122; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIKCYHX48LZ4y5c+eskIJ+WKI5WENsS3E8Y3XhDimew=;
        b=3QdvK2zv6unrkvEdjxUxDDYCCliLxXy7FPjNz2sS++BRP5/Cy61lqEuVHtSpDnOJAJ
         UB77VhQAO6FIcfjIzAktC5khvFfsv4v3Amp1iDerxC1kPkp4TBLCol2+8CFJTHNnjfhp
         9FGW9pcjje8cqhMTpbQev32SMb85LyiOzdv2WB4tADDp52UfI2wdrqZk0XLUl/7MByaP
         5Bhjq8TnCEE50y1zJ49eT4U0S1wDtmhmbEy8WIqHBZ4uX3pGvixvhRfvr79jGJpOxaRc
         ILVuUOR6e24zyhLsrsAfyn+UwURKHAv/PEUf2kUx//N0GmhSJUyOVjstFojaLlP+W7mA
         fnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739528322; x=1740133122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIKCYHX48LZ4y5c+eskIJ+WKI5WENsS3E8Y3XhDimew=;
        b=G4xoDAYoVbwsnxz+ra9bJNc8UGcQJyHG4xk/8SaYOBc3b3keTwNhMEI51Ar057GXJD
         WWLMatMBuWRZrmLnHXpMm2Pq8bCt6rGGPreJ3uXKX5vpAiFAmO2aDiiee3HCvRYkYaou
         X8JfzXq47FFwG8qvwAtTSWk2hBMIlk0fN+R/yrOZYuU+2wD2d2AknzF93Bg9Ouj/G/Qz
         dPEgMSzxctb7VBb8HVkvkD55rgw+idq6fpm8OJ2AqtK8yDToGEOXxZgwuhaAH9uoeSyR
         mh63ktFgxLfy/Hq9a7h9x5E8aBThPsuc7haiSTNI0pbijl6NMDnDxgqn+UFz3aO35Ct4
         0gDA==
X-Gm-Message-State: AOJu0Yycq6L9m+/gz88sMYPOji+qsvm6tj5RHgV0cmi4AnP1oCKJX0cL
	ORnRoOztVVetVi3fIfZQy3yQNvAFuXyH5LBpB+O1U+R4Y3QbmZ6qZNqDCUHzjgvqncnMm9M6NHs
	uSM8EfpYsQHDeild9WsipAnTzVdDP2+Z5+D8nKRV3HxNGzRIp4Q==
X-Gm-Gg: ASbGnctW9LEbCcQNKTae8c8/zzOVQkM4zRELm5XW1steEQYY771Ps/h12uZPYBR4r5c
	7K9iLG8/w0cs5sQQRz3JS3p7/d3TSW3b/HFPTPAJVUNeb/L44AFOAe2EVGFQEkErHIdP81dt6
X-Google-Smtp-Source: AGHT+IFDkWf49Ap7eDZ/ziC/j13xXP2skamdFt6g9rn72Ihk/Fkp0sdzrneKkQM8ddB/WRzJQzEimjmrCoCxQnv6aws=
X-Received: by 2002:a05:6a00:2ea3:b0:730:9204:f0c6 with SMTP id
 d2e1a72fcca58-7322c4310b4mr15254204b3a.16.1739528322674; Fri, 14 Feb 2025
 02:18:42 -0800 (PST)
MIME-Version: 1.0
References: <1733593115.596079.1739239912119@webmail.strato.de>
In-Reply-To: <1733593115.596079.1739239912119@webmail.strato.de>
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Fri, 14 Feb 2025 19:18:06 +0900
X-Gm-Features: AWEUYZkE_exo4RHlBTpJZeQcMimsg3rjRXcHOL_87yB2czgt3Xefw_N3FXKvNgQ
Message-ID: <CANgtXuPttHLDcdO7U-WaNS3tTeRUkDB6LBiTt1T0mvsCMjKwOA@mail.gmail.com>
Subject: Re: [cip-dev] [ANNOUNCE] Release v4.19.325-cip117
To: cip-dev@lists.cip-project.org
Cc: "pavel@denx.de" <pavel@denx.de>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, 
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>, 
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>, 
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Feb 2025 10:18:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17837

On Tue, Feb 11, 2025 at 11:12=E2=80=AFAM Ulrich Hecht via
lists.cip-project.org <uli=3Dfpond.eu@lists.cip-project.org> wrote:
>
> Hi,
>
> the CIP kernel team has released Linux kernel v4.19.325-cip117. The linux=
-4.19.y-cip tree's base version has been updated to v4.19-st1. The trees ar=
e up-to-date with kernel 5.4.289. This is the first 4.19 release maintained=
 exclusively by CIP

I noticed that v4.19.325-cip117 and v4.19-st1 tags are both a lightweight t=
ag,
instead of the usual annotated tag with the PGP signature.
Same is for linux-4.4.y-cip branch.

Thanks,
Arisut

>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17800): https://lists.cip-project.org/g/cip-dev/messa=
ge/17800
> Mute This Topic: https://lists.cip-project.org/mt/111115352/5945227
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10069364/59452=
27/404292488/xyzzy [arisu.tachibana@miraclelinux.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


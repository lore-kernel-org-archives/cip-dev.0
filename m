Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DD2FF8855
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 21:20:13 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4394.1778015998051705217
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 May 2026 14:19:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=amZ3mUoL;
 spf=pass (domain: gmail.com, ip: 209.85.222.169, mailfrom: iwamatsu@gmail.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8ee7ffd738dso34711885a.1
        for <cip-dev@lists.cip-project.org>; Tue, 05 May 2026 14:19:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778015997; cv=none;
        d=google.com; s=arc-20240605;
        b=LIXv/tCgITCztYxKAFr3nKG8V5Xi33Kq+BljoKr4+rx64wJRxuNWw5ghd7IEe4sfIy
         0PoD/SrrU05EiSC4qJ/IJTX7tdiJFDaLHlnY33abwRg+HmMMuvGedPiTweqUToJvB60C
         X0oFCzdpxxf1chq1IVhHrJdixhf2bPhwP+cvgTAxbT+KmpZ3DkcNbozzPM5JNbAvw4xG
         y7ZiRhaFjyLo7tcyO5qGDjyQwH42MniwIxqdgyNGblgBy8uNuqwMwEKOHUXFHjti9S/d
         gzSDPKAuQKX6OnJrr6s7jmAvkKk8tmY3zyhqgros4Yy8HHxd4MEZM42GRNi7/X0ec1MD
         g8Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DpROl45b3aYL1zPqRfGBdSTBKWaKZhtkO4hIVBKgaII=;
        fh=MLyK+s9s/4K0jWUJnXD1s553KlT/G0Ko38b9YaaAfAc=;
        b=IUdu8BU11M0BvMCyAsIMcmOtI/65pELFgi1uxAZeBzZl30pbCHoWbP/UrBMLfuHf/e
         B068LtDXW8nf1Ko7VL9lUe8Hlo/9cTBNGAQ0jCJU4M3wOP1nusUX+cUQMvu0PWmwAbHg
         wALj0Gf2t+79KYmt4fYYQZ4ahKsLUd+w+fs3ULJ1NGsc4DXL4ZeR2yI6WU51FFUZ/8Bq
         8lWebiCkQgiIS6ZIaZrRWd4gZ6KkyXH1CIOvvvImZ+4C7hhoU3HomV2jEwA9cOn1hT/i
         GGzd6yL7qCU9Hu7FCMvbg5OEbPPQnbwtPVh2O7owgsAxCYETu/iLgzK17QT/BbIfdmYn
         MlNA==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778015997; x=1778620797; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpROl45b3aYL1zPqRfGBdSTBKWaKZhtkO4hIVBKgaII=;
        b=amZ3mUoLKfypB21oNTedlosb6Q0gQMVqHLptVOmNX2VPO5mv2IGDLHEG9gpwfFndP0
         TbT+D1GRnpeSioPjL/Lu57yDdRGXCAeV5IeVzfkip/CSin1r9ymQHfFrvMcOqr9k6Z6a
         PKdSewoRAgOaSzzO/GRiQo5fHrCzFolwoCc2X/KJXQZZJraQaVprjS0/2gmE1z4jNmD6
         ++UxPmHjzzjN6Im8IfiP8N/Z9xmjK1envcHlQPd5QXQ+xnipY7F0eI7Xucxuh7oZWEh2
         IpqVJCMDSk6haa9UBJh2e+LHjbRDBEZoJC0IiiVxLmGjHXPn2VBbSg6tQ/3EUDzcwxJ7
         7v9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778015997; x=1778620797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DpROl45b3aYL1zPqRfGBdSTBKWaKZhtkO4hIVBKgaII=;
        b=K7Yx7leroTB9+ASH2uYxerjayPCJGcVf5ZFYdfjb5kixDggc0yWlC6Bf3cXXY3hQUm
         tzNn8/zvu4fIySRn7hWHgshOcj6xS8g3xZOdPx+o5ghuJ6t6odBQZphr89CqkMiLRpKH
         Jv7tSN3gxdEyQRH9DpmrtXPRLM2sWr6xxCrJdcIROyICYbXhKXNm+xNkydiI2CGxmXsU
         wPIS9FkAqOrG+dAugfRHR1CqWCjqPq9xB2bp+xBE6cTMHWNAy20R9ZettXiKrNFwzbxK
         9Rnh9RrG1hMJoFMLGZ7UGKXERDDvNgcoM/cWf0FD45Ef/Bh0nKoPlSsQ8yw0KFEE8EzG
         cPRg==
X-Forwarded-Encrypted: i=1; AFNElJ+mzDKFSe9jDynF0T+DEP8pA62AM8X4mAdypXt1T+vSdEUzB2Z+h60w8zj59m7hJAWPy4oq9Ypo@lists.cip-project.org
X-Gm-Message-State: AOJu0YzyLmZwSovRjNDCQ2kShKbTNeOJtjiV4e98DI1VNUFzNjiZoao5
	l0crpKezToeOXNOIPKdWjIE4kQBzWOJzR9JzbYLiAsgkTo41Hc4fi+TPHNSKdIhHVnkaSxosOM3
	hLNc6aeLn1tL1tWow1mZ6wPwrlPqTrcw=
X-Gm-Gg: AeBDies3IbIRbIPrSTS5VNRXuzfYyOPGx6gtGJ1e4rRIzu7bZRPYs81TZwZ7mYyrZm/
	Md+4p4HsywyJZ1tu+7EVM7hDOlCyEzIHTguZfUEt0UdDevI4Q7u6Lbn3LBJSlaqxj7ypoa4P5rJ
	CVDiPzSkLHfDw173wwNTPINCFHLzO0ccAv6f1KS+VQRT1BqnJkRG4L+Br8e/kDYes4C4ALRn4OG
	qmB+hE7+4R7n86rAllOrXycUFIV4sCNe+6vrvQKbMyCtZS37VIB/RneywS8X+zd/IkkLYCHtQY7
	SpQfmRoI1yQBF0A=
X-Received: by 2002:ac8:5f07:0:b0:50e:2ebc:1cc0 with SMTP id
 d75a77b69052e-5130529992amr74508951cf.16.1778015996871; Tue, 05 May 2026
 14:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260504064804.7021-1-ovidiu.panait.rb@renesas.com> <afhpP9iuTPGkJVoM@duo.ucw.cz>
In-Reply-To: <afhpP9iuTPGkJVoM@duo.ucw.cz>
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Wed, 6 May 2026 06:19:41 +0900
X-Gm-Features: AVHnY4K2VQ3OyI4i09rbOR-hOvYLVP94dY1YuuWUxti1z_nbm7Cmj2EyOerKnks
Message-ID: <CACe6DC4JUXC=O8-cbJGGwZnpgyQz=G97gF75goB9gQoFiaJp-A@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/9] Add USB3 support for RZ/V2H and RZ/V2N
To: pavel@nabladev.com
Cc: ovidiu.panait.rb@renesas.com, cip-dev@lists.cip-project.org, 
	nobuhiro.iwamatsu.x90@mail.toshiba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 May 2026 21:20:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22892

Hi all,

2026=E5=B9=B45=E6=9C=884=E6=97=A5(=E6=9C=88) 18:39 Pavel Machek via lists.c=
ip-project.org
<pavel=3Dnabladev.com@lists.cip-project.org>:
>
> Hi!
>
> > This series adds USB3 support for the Renesas RZ/V2H and RZ/V2N SoCs.
> >
> > Patches were cherry-picked from mainline kernel.
>
> This looks okay to me.
>
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>
> I can apply the series if it passes testing and there are no other
> comments.

I reviewed this series, looks good to me too.
I will apply this with Pavel's reviewed-by tag.

>
> Best regards,
>                                                                 Pavel

Best regards,
   Nobuhiro


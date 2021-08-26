Return-Path: <SRS0=Nd+3=NR=lists.cip-project.org=bounce+64572+6708+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084CEC4320E
	for <cip-dev@archiver.kernel.org>; Thu, 26 Aug 2021 12:44:35 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 551146109E
	for <cip-dev@archiver.kernel.org>; Thu, 26 Aug 2021 12:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 551146109E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id IdxsYY4521723xBF3WBAj3un; Thu, 26 Aug 2021 05:44:34 -0700
X-Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
 by mx.groups.io with SMTP id smtpd.web09.29631.1629981870977614884
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Aug 2021 05:44:33 -0700
X-Received: by mail-oo1-f52.google.com with SMTP id z3-20020a4a98430000b029025f4693434bso886531ooi.3
        for <cip-dev@lists.cip-project.org>; Thu, 26 Aug 2021 05:44:30 -0700 (PDT)
X-Gm-Message-State: 7iaRZYM9Dt4A1dT8ZWU1u7DLx4520388AA=
X-Google-Smtp-Source: ABdhPJwCxsOTGaywyw39NrzBe0QaF8SXfvpnseFrTr7vZLbaKZGdk5d30RkLZxp7BT3rM+6aP2e28pLbOVpHgClINqo=
X-Received: by 2002:a4a:a552:: with SMTP id s18mr2949620oom.1.1629981869920;
 Thu, 26 Aug 2021 05:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAODzB9qV4uxi2EHoPbK8D_mW6cO-Ni2x+tVUMAUYzKGK7y+COw@mail.gmail.com>
 <169ED2F66B4753DB.9667@lists.cip-project.org> <20210826115127.GA15147@duo.ucw.cz>
In-Reply-To: <20210826115127.GA15147@duo.ucw.cz>
From: "Masami Ichikawa" <masami.ichikawa@miraclelinux.com>
Date: Thu, 26 Aug 2021 21:43:54 +0900
Message-ID: <CAODzB9o9FD7MdERqkkMf67K+4EUUyVXok2NXEk9Y6YTajtj_tw@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="6kvTvrrO1dVQpRiHDhER"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629981874;
 bh=rygA6uEmPXdvorh7XO3hQXsQsOIMubnpHGib69vYlsM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=gw9pqqypNUxXqB81ih70ZJ+YNjtaTmFflZNe0TcupqQDhD0DuqaLV+Jsos9se8EgUUv
 HaH54ViE0eVWk4tsfF2xHggPZIwo1c7vIrfyWU2/HZjygcRJI+UDB774NcEASSXfaRXFr
 H/scNSJXdchk4ugdHhoWcB2gbaOIFhgnM1s=

--6kvTvrrO1dVQpRiHDhER
Content-Type: text/plain; charset="UTF-8"

Hi !

On Thu, Aug 26, 2021 at 8:51 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > > CVE-2021-3600: eBPF 32-bit source register truncation on div/mod
> > >
> > > The vulnerability has been introduced since 4.15-rc9. 4.4 is not
> > > affected. 4.19 is not fixed yet as of 2021/08/26.
> > >
> > > mainline: [e88b2c6e5a4d9ce30d75391e4d950da74bb2bd90]
> > > stable/5.10: [1d16cc210fabd0a7ebf52d3025f81c2bde054a90]
> > > stable/5.4: [78e2f71b89b22222583f74803d14f3d90cdf9d12]
> >
> > I took a look into this. Apparently 4.14 and 4.19 is affected. (
> > https://seclists.org/oss-sec/2021/q2/228 )
> >
> > Due to BPF 32-bit subregister requirements (see bpf_design_QA.rst)
> > top 32 bits should be always zero when the 32 bit registers are in
> > use. So it could be possible to use BPF_JMP instead of BPF_JMP32.
>
> Hmm, no; that is what original code did and what is known not to work
> for reasons I don't fully understand.
>
> Anyway, I asked on the lists, and according to Thadeu Lima de Souza
> Cascardo Ubuntu did some work on it and is likely to do some more.
>

Thank you for asking.

> Oh, and we may want watch CVE-2021-3444, it is apparently related and
> not yet fixed in 4.19.
>

I see. We keep track of it.

> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> 
>

Regards,

-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--6kvTvrrO1dVQpRiHDhER
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6708): https://lists.cip-project.org/g/cip-dev/message/=
6708
Mute This Topic: https://lists.cip-project.org/mt/85151460/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6kvTvrrO1dVQpRiHDhER--

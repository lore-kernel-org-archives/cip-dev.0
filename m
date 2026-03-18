Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A09F1088E46
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 22:11:23 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26692.1773871878150604601
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Mar 2026 15:11:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GGSExGYP;
 spf=pass (domain: gmail.com, ip: 209.85.214.179, mailfrom: iwamatsu@gmail.com)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b04fc8851cso2728115ad.0
        for <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2026 15:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773871877; cv=none;
        d=google.com; s=arc-20240605;
        b=IQyIzsU5cm8SdX452pyGNIKJQ0mLTm1JX2xpXWNaBAhbJt8dLd5QQ2Y8Z8O4N0FyGZ
         fyny/Fc1rZ6df5Oi/mySKg7RAMfaArVNaIWcLTNxczk9peof352/TW5me8wYwHBTyyOC
         a9wEs02QLcDw+OBrdj3jpdsVC3L44CZvdWEw9hDGxtZRBuL6w/6ikIag3YEaQHj7RVmn
         ZwSvrDXlnRTK35FU/GAsF6Q+mMm5o5OyK/Oa4cdMD9LaHBzzMs2KDPZRQ2esOGjjT03f
         66LMQYTRacyH368jtu+mfWdMVQk0Zy/z4HpFsAMFF9JI+W71S2fDhZ4M8b4iQjVq2NlM
         DYTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h6Bd8jprow9fvPtn2O0llzHcwQx2gzQAlElT+bsBqmw=;
        fh=h9QGIKntC242rn3EPvD7ley5xpsEarv7XfB55Ef5+10=;
        b=O/QAmMBTR4Hf3Zn4NxPfbrl9Ff5Fb3OWE0rw/76a+/7k0y2+TpcumyP6VwtstVzuc3
         GkIpDvOeK3/RERp3KmkxziLteaI/yJWS5pOoJv/vtcMHpf9E5sdbDyqDwAeofhgWxcWX
         u6MSI0iXxsH5jmWy/T1CHTBfz0pe/Ifsxqzr8yDef8HMBGqdRlHzFV0dcJV9/eA1sm8R
         5FmKnuABVC1KRUDfwu5qN7khaldLNgr1eoTA7+5hsFFXHPfnUJASRdPz7N+A1cQDTqtl
         l9gUXcWmlaxNR8DkvxIMyG9MTfd+CiSFwkoevTRlLdvbPOLS2XRn2QfPHOAALheAEWEe
         7LKg==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773871877; x=1774476677; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6Bd8jprow9fvPtn2O0llzHcwQx2gzQAlElT+bsBqmw=;
        b=GGSExGYP7ROBFIH9l6Kh/5ZmoDoRO0h25DiwULGA9/RKxB2mgwOwkqIAFEioNyloKk
         Zk4MymvAp/HZU0Hw+5ElcTq7Dodwq+6BtpdRrxvufl2DuwwohemmfV3UGRM/X3EGRTb1
         31AV2AND/8sTRS/bjOecrVtHc+zWK0DRjD8nEw9pZ2zlOoVXtJtf98CONhU1k/UpILsq
         tgdqtNbyvqi3dlYrixcOiXAYQw6qWzhEKaaK9etcjoHxeAQcYOqgNlJ5nGy6tE5oEojW
         /JofuPiJz9rC58j/BQZj5PdSWpUpoVl/Nq3nY6gZ28T2ZZ8jG7Yj90sUebxHg3PW9Bwa
         1l8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773871877; x=1774476677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h6Bd8jprow9fvPtn2O0llzHcwQx2gzQAlElT+bsBqmw=;
        b=Hu17luXFWM8NvR6scbHgSMIboZOiDniqgn8TX04N0ab+Sdbx2SRHbU1tvouCzTRjGJ
         Gm5u6+5EebujpriA6ohnwBj5y01jmDjQYoWX5HgvYUYH0ZYAx401E4esQ6pZJK5pJne/
         OAirXxb0y9qTv00Gf9I4HJarBrrqq4sfs1nVd/yaOxHcuo8B3/m86r0tG0R9BVDL0znx
         yZAkNXWpRI0ytIrSRNt43+eqD8Dxc4Oejba/9KOWnflrQKbXJCpNAIYZUd0umMSd89TI
         R1I30b1/ZZooR/eE7ZiJ3hJqFYhNPybKstrLHz22PNBzE9e0Z/ZTHQF/hQX8STAm+VvJ
         azOA==
X-Gm-Message-State: AOJu0YxOERkqUohpObTmRHILNq2lEKjjSUq2nzi24dfrSB47aoSelu3v
	pWjD4rvtZuFXHE4w8SFz/FV5w62hkn4mpZIEDM2TIgHfjbJ3i8jdthimCn9Vf4rPPKnRxP4kxgV
	wjGuo/48in/auD+pLXWOW1zY1MhKvu+s=
X-Gm-Gg: ATEYQzxliLOA1ljFixZpg5SSphZR1qJNvOOMJpeD5vmD6PSzA0MmcVNrkAYEeSeubG5
	ZpVM2VRZ/NTPtUW65mVsO0XL7BZNYa5tHd4clgudmtvp4K5uaX0VIJIkERsmemwrM/WObs4uJ4e
	SDDav9U/gjpsjTNPYpRHgm4zEk5BfIkRCjSOcX51QQm+Vs+1VQh5qxiAXGqBoUoTjimi1GBRMXq
	snW36OXQkXGRRGBtnLUNRwfNTsEtFnhTL+IRizLP3ljHKXzjwuBLFMIXCmpelrH2Q++mJB6G35K
	oRE=
X-Received: by 2002:a17:903:1986:b0:2b0:6140:aa65 with SMTP id
 d9443c01a7336-2b06e3ca13amr48874385ad.30.1773871877522; Wed, 18 Mar 2026
 15:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260311123638.25773-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260311123638.25773-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Thu, 19 Mar 2026 07:11:04 +0900
X-Gm-Features: AaiRm51dqq57TbLReHTVbJiMGiVVw9Puf4CjpZP-H8yAWUlUPY8uZPTzcmYdfTM
Message-ID: <CACe6DC4fGvWoSG=9uU8U3h4prtqY7h1TjWXfjFk0aTz2KTBFcg@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/2] arm64: dts: renesas:
 r9a09g077/r9a09g087: Add DT nodes for SCI channels 1-5
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: cip-dev@lists.cip-project.org, 
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Pavel Machek <pavel@nabladev.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2026 22:11:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22505

Hi all,

2026=E5=B9=B43=E6=9C=8811=E6=97=A5(=E6=B0=B4) 21:36 Lad Prabhakar via lists=
.cip-project.org
<prabhakar.mahadev-lad.rj=3Dbp.renesas.com@lists.cip-project.org>:
>
> Hi all,
>
> The RZ/T2H and RZ/N2H SoCs expose six SCI controllers; sci0 was already
> present in the SoC DTSI. This patch adds the remaining SCI nodes
> (sci1-sci5) to the respective SoC DTSIs.
>
> Note the patches have been picked up from upstream and manually merged
> to resolve conflicts.
>
> Note, these patches apply on top of the RSPI series [0].
>
> [0] https://lore.kernel.org/all/20260309150619.761962-1-cosmin-gabriel.ta=
nislav.xa@renesas.com/
>
> Cheers,
> Prabhakar
>
> Lad Prabhakar (2):
>   arm64: dts: renesas: r9a09g077: Add DT nodes for SCI channels 1-5
>   arm64: dts: renesas: r9a09g087: Add DT nodes for SCI channels 1-5
>
>  arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 70 ++++++++++++++++++++++
>  arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 70 ++++++++++++++++++++++
>  2 files changed, 140 insertions(+)

I reviewed this series, looks good to me.
I can apply this, if tests are OK and there is no other comment.

Best regards,
  Nobuhiro
--=20
Nobuhiro Iwamatsu


Return-Path: <SRS0=DVmZ=66=lists.cip-project.org=bounce+64572+4623+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6288CC433E0
	for <cip-dev@archiver.kernel.org>; Sat, 16 May 2020 13:45:42 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C155C2065C
	for <cip-dev@archiver.kernel.org>; Sat, 16 May 2020 13:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Q2iK5jyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C155C2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4623+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5OJCYY4521723xbYqYuJzNbN; Sat, 16 May 2020 06:45:41 -0700
X-Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web11.5174.1589636740372108367
 for <cip-dev@lists.cip-project.org>;
 Sat, 16 May 2020 06:45:40 -0700
X-Received: by mail-wm1-f66.google.com with SMTP id z4so3739782wmi.2
        for <cip-dev@lists.cip-project.org>; Sat, 16 May 2020 06:45:39 -0700 (PDT)
X-Gm-Message-State: kawUM8ek09Kbm7HKwr4Qi8YKx4520388AA=
X-Google-Smtp-Source: ABdhPJwDfJIlcjmSDoG0Ns4U1Yz9147JCZRoRnICfdxVDnLVIVScdu6eknmT34yvpzlOrLI30BdB8QG0cTk23Thjh/E=
X-Received: by 2002:a1c:2888:: with SMTP id o130mr9116559wmo.138.1589636738118;
 Sat, 16 May 2020 06:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200511150426.GA18173@duo.ucw.cz>
In-Reply-To: <20200511150426.GA18173@duo.ucw.cz>
From: "Angelo" <angelo.compagnucci@gmail.com>
Date: Sat, 16 May 2020 15:45:01 +0200
Message-ID: <CA+TH9Vm8dN918_yu0reQCHzh7hu62F8SefD96tx5T_XrEy634g@mail.gmail.com>
Subject: Re: [cip-dev] [ANNOUNCE] v4.19.120-cip25-rt10
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com, SZ.Lin@moxa.com, 
	Ben Hutchings <ben.hutchings@codethink.co.uk>, Chris.Paterson2@renesas.com
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="XxFBPSUfOLATWFZ9FHnG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1589636741;
 bh=KARaUI0/69v5nIPxLRTEoYfyTd0LHHrMcQkWFHxC2Fs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Q2iK5jyhOkYqu2Dy5D9Zuc2Ys2KB2icWN5VaDCXd1FE3a0n+IXgo0Lb5NF2ZZfCMgaV
 ndOSDSk2Uq0NAQnOI+hx4Ungi/azLtDDx4wFkHG4+PwZtEJTI+UlBVk9IIPQkJA4jR25D
 Lveg9wWhPGZfg9OjXr2jUITRorb4f4ACvyA=

--XxFBPSUfOLATWFZ9FHnG
Content-Type: text/plain; charset="UTF-8"

Il giorno lun 11 mag 2020 alle ore 17:04 Pavel Machek <pavel@ucw.cz> ha scritto:
>
> Hi!
>
> v4.19.120-cip25-rt10 should be available at kernel.org. (-cip26 was
> not available when I started the -rt update, thus it is based on
> -cip25 patches forward ported to 4.19.120. There should not be big
> difference besides the version number.)
>
> Trees are available at
>
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip-rt
>
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip-rt-rebase
>
> And their content should be identical.

Tag 4.19.120-cip25-rt10 doesn't seem to be there (only
v4.19.120-cip25-rt10-rebase)

>
> Best regards,
>                                                                 Pavel
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> 



-- 
Profile: http://it.linkedin.com/in/compagnucciangelo

--XxFBPSUfOLATWFZ9FHnG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4623): https://lists.cip-project.org/g/cip-dev/message=
/4623
Mute This Topic: https://lists.cip-project.org/mt/74137657/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--XxFBPSUfOLATWFZ9FHnG--

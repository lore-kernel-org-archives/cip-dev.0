Return-Path: <SRS0=2Oxv=KA=lists.cip-project.org=bounce+64572+6428+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9C8C433ED
	for <cip-dev@archiver.kernel.org>; Wed,  5 May 2021 11:15:28 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF30613C7
	for <cip-dev@archiver.kernel.org>; Wed,  5 May 2021 11:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF30613C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6428+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id WNNIYY4521723xK5sguYCWPX; Wed, 05 May 2021 04:15:27 -0700
X-Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web08.6238.1620213324789766435
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 May 2021 04:15:25 -0700
X-Received: by mail-lf1-f53.google.com with SMTP id j10so1969862lfb.12
        for <cip-dev@lists.cip-project.org>; Wed, 05 May 2021 04:15:24 -0700 (PDT)
X-Gm-Message-State: H1raKfCnKBjVUaMw2Udh3sgox4520388AA=
X-Google-Smtp-Source: ABdhPJw37UYzhgRxbxK5hl+Qu4v1TBteUMmv0QS7T3GCPe+2PqZt6ZT7Qmwt8aw38jUIicmm4snSEA==
X-Received: by 2002:a19:7405:: with SMTP id v5mr6497472lfe.455.1620213322513;
        Wed, 05 May 2021 04:15:22 -0700 (PDT)
X-Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id e8sm2015758ljk.7.2021.05.05.04.15.22
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 04:15:22 -0700 (PDT)
X-Received: by mail-lj1-f180.google.com with SMTP id w4so1917055ljw.9
        for <cip-dev@lists.cip-project.org>; Wed, 05 May 2021 04:15:22 -0700 (PDT)
X-Received: by 2002:a2e:8942:: with SMTP id b2mr9770921ljk.488.1620213322203;
 Wed, 05 May 2021 04:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAGb2v65PfUtwZX8c+W2Yygk3XTOTxfXU0SoFUjXUAh2wYuHmyA@mail.gmail.com>
 <20210505083439.GC29521@amd>
In-Reply-To: <20210505083439.GC29521@amd>
Reply-To: cip-dev@lists.cip-project.org
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Wed, 5 May 2021 19:15:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v65-tTjXP72bFziWS_1LhHMg+0vfxLbRiiKux3=VXqg+WA@mail.gmail.com>
Message-ID: <CAGb2v65-tTjXP72bFziWS_1LhHMg+0vfxLbRiiKux3=VXqg+WA@mail.gmail.com>
Subject: Re: [cip-dev] Cip-kernel-sec Updates for Week of 2021-05-05
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org, 
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Content-Type: multipart/mixed; boundary="oG4ianGfqUt9co4KDEHe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620213327;
 bh=jMDJZbqmIxZI8hJjkIz/2xMJ+sInUZhrunBrtc0qO1o=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=BZJuTOXswPhQm4Tttef7UG3l+EL7958mTs096jFNpW1nDBZmhzqfndC8ClZD2J8CiBW
 X1P4xjY0iKPMD20On4dlNZ/poAnEvB3jbsiy8D1sHKFV2yAPXX80wvWsVefDGgbPYjP5y
 WtlnCNo062mcA/M2PRx00aMJfoDzukTU1gQ=

--oG4ianGfqUt9co4KDEHe
Content-Type: text/plain; charset="UTF-8"

On Wed, May 5, 2021 at 4:34 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > - CVE-2021-31916 [md: dm_ioctl: out-of-bounds array access] - fixed
> >   Likely needs backport to 4.9 and earlier.
>
> Backport is trivial in this case.
>
> > Additionally, one old CVE is now fixed:
> > - CVE-2020-26541
>
> This is UEFI secure boot, and it is more of "implement missing
> blacklist functionality" than a bugfix.
>
> If someone uses secure boot on UEFI, we may need to do this, but
> perhaps noone is doing that.

No idea. All the servers I touched at work were still booting via
legacy BIOS. Mind you that these were old servers. The latest machine
we have, an AMD EPYC 7002, is UEFI only. I never looked at the
settings though.

ChenYu

> Best regards,
>                                                                 Pavel
>
> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> index eab3f7325e31..a6e6a852c9e8 100644
> --- a/drivers/md/dm-ioctl.c
> +++ b/drivers/md/dm-ioctl.c
> @@ -524,7 +524,7 @@ static int list_devices(struct dm_ioctl *param, size_t param_size)
>          * Grab our output buffer.
>          */
>         nl = get_result_buffer(param, param_size, &len);
> -       if (len < needed) {
> +       if (len < needed || len < sizeof(nl->dev)) {
>                 param->flags |= DM_BUFFER_FULL_FLAG;
>                 goto out;
>         }
>
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oG4ianGfqUt9co4KDEHe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6428): https://lists.cip-project.org/g/cip-dev/message=
/6428
Mute This Topic: https://lists.cip-project.org/mt/82597445/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--oG4ianGfqUt9co4KDEHe--

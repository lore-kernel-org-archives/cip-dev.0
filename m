Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A1EFF8855
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 21:09:33 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4202.1778015370189415244
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 May 2026 14:09:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=nmCh+95e;
 spf=pass (domain: gmail.com, ip: 209.85.160.174, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-506aa68065eso40825471cf.1
        for <cip-dev@lists.cip-project.org>; Tue, 05 May 2026 14:09:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778015369; cv=none;
        d=google.com; s=arc-20240605;
        b=XvXOmAkUiED+SXFyq6r1q8NqvEjHkNJI7BqFYrKHc10Jus72HS3zlPv/1FH5OkLzuh
         u4/1OsRlQ2PWu+XQlFTLC3OJZT/WprRG3Je5RllPP+msPIVd7YSMMFnKjn72DPgbD4U2
         sgH1MgN5yUf8NMHslkSj+hCOgqE/lNZRMbI3r41peDbAGS6gm1MYLUtYn66XRDTclEv+
         VgZOvGfY5Ycq1iD64blMHbH4hFNO7y8qphFTldm49TD9Ufw0rnOrT1VdDQoeCY7CU+n0
         2Lvbv2RV4ucdp9zP009FfqljlAxamMGxmCkOpVc6xknAt0kODKPU2NkEsgrcXQ0aLKOs
         +MNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OzNtJ304Tv4aS6HwLQaxWjSIndNtiEcKGkGUbNDXBTI=;
        fh=t2lfLlfZyxM7MAzS9bme+Si9BbeedF+2Vm/Hk+tg7E4=;
        b=eCi6EFgLr2cWEVDb7DZM41ISs9u5qigWKRWtg4VJi7L1kl7c9PfG4ynM4lLRVZDv1v
         n1cDnQCm/1w9Ayd0JEuAtfDaO+gPCLbyc8RZAnfTf96Fr7ZzEWBtZCNJxt60BAtCXvVt
         gRBfb0NRfGYufjgQHq/3+l2onLGaaNKB/pKNLuwhfBLSKjLCgxA61RoW8XaHvAs4Nk4x
         2qKdg2kqIvGZcw2VgHbHNSI2MGxGllEzCQfcxr3hI9uckWeE55enRWHrukk9fW4ouP1b
         0yk4CttfPOJLIPcpXVgnJ8poIVrG3KA/ooztF1M+0FWL3tqzhCcq2iy+3Z0cMsz29tL2
         tiqw==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778015369; x=1778620169; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzNtJ304Tv4aS6HwLQaxWjSIndNtiEcKGkGUbNDXBTI=;
        b=nmCh+95eL59KJ/8Ln+AdSQvzkRrf8+p7CXyqt/km+aaXCfZaulTH8IhNkGmXjrhP6b
         gLZYpdLn9/zc/o621O3xsZnAdE6qveXYXKHccgrfdGCeNKYz9Z/P1qTrhpEv4dxffxK+
         pNvLSSGUZAnRvDwIgLybMElXnhKvNkhplww1CvGfMWuPRdTk1CDK0vIwjkh9WDrOoHgT
         1UEiFLNeyPBESpZ23MNOfHl50gdEXlNrH2NNd3GgurCK33RhAaTYpe0gnWWQvyjgpy+A
         mRLGIEtV8Ut4wgUi7V8erR0SulJA2mr/KlwYjY6qhCbVaSCuPAHbbISvKl9D9mVtsJYa
         0BKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778015369; x=1778620169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OzNtJ304Tv4aS6HwLQaxWjSIndNtiEcKGkGUbNDXBTI=;
        b=KOA4OoihsDfYCf8fq1z3QEW3+kmoZ8argDrBd0/8XdIDeZ4xUF9W6EJGY2kbZX8db7
         1ZRilMq1a3J2/ftcy/jSmqkDnchoRmBLMJUrTo5ICUHvP6QBBRVKb4UJtOm5Rc4EDUz+
         sxMtfZipr7UJgtewi3zXlC/U6hpc21uLTrqu3mxl3K2XoARs047SOCMFNE0NqXmTEWMP
         gWDHZOV1Y9JhynDO0HmvUy85ICA6y9zDXKnX+Dd946X32zTDtwLsUh9hqIta0WRZv3H6
         IHsNWiUN2gI+4BN9N4VrEgWFzFuiyAEYneuA0zlbQeBC0RS6VlbIP5pInj4xDV/8xtMF
         z+ZQ==
X-Gm-Message-State: AOJu0YyV8R7bx7YpmhepvEJYBKZZsTRunnn5usoB5G7hm8BgzJphohKM
	gewqMlAXpl1w1zuNtpl3ji0LVKBYHMpEzxdZQKBmKy6TqyCyJIMuO6WVCftFJvEjVSJN8pmRDaw
	eJ/Khy69ylIMdraCVK19e5GluYoIJrck=
X-Gm-Gg: AeBDietsjXutUDVb4qqmHTJ7Pf+89gZZlhJIs0ZqkpSJIZYO9rqmvfsPz3sRa5N4NIH
	rEHWtBJRz93/ZdTkssymg3DspQqQhklT/6rJ28tox5DOxxTbgfEvKAkKx+YbrzFZ9hkLUOlZ2dB
	GsHIFLHmZ8XFxXPd9s8b6HouBZMT3u3UyU+RcPMqDLxr3FxSm2GtySIXaMjl7nZqeK+6ZmfqkEV
	y0giYV4XeEzhFUvse1f1h+qIKCJmaBcssAss+jH8Aej0hCbZUe9GvfC/Sy4BM6T2EjcoPyfHurk
	Ic69qHcY0T0Bpv6mZ5vgoMesDA==
X-Received: by 2002:a05:622a:2309:b0:50f:c5f0:f2fd with SMTP id
 d75a77b69052e-51461fb193emr11263021cf.47.1778015369060; Tue, 05 May 2026
 14:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <483138290.348854.1777919283323@webmail.strato.de>
In-Reply-To: <483138290.348854.1777919283323@webmail.strato.de>
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Wed, 6 May 2026 06:09:16 +0900
X-Gm-Features: AVHnY4K4KGWbQxbYjzHsxhyU3yVsQm-XG0iT6hofxqcxdYalyM0moa04KM4M6Yg
Message-ID: <CACe6DC5-xC4N2497RRuD_Rrb1EqT4gNqnrrC+JpB2T5hkkMsuQ@mail.gmail.com>
Subject: Re: [cip-dev] Request for review for 4.19-st16, 4.19-cip132
To: uli@fpond.eu
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, 
	"pavel@nabladev.com" <pavel@nabladev.com>, 
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 May 2026 21:09:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22891

Hi Uli,

Thanks for your updating linux-4.19.y tree.

2026=E5=B9=B45=E6=9C=885=E6=97=A5(=E7=81=AB) 3:28 Ulrich Hecht via lists.ci=
p-project.org
<uli=3Dfpond.eu@lists.cip-project.org>:
>
> Hi!
>
> Here are the manual backports for the upcoming 4.19 kernel release. As al=
ways they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/c=
ip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc
>
> c2d401e101f6f x86/CPU: Fix FPDSS on Zen1
> f6b624b78e703 seg6: separate dst_cache for input and output paths in seg6=
 lwtunnel
> 5e61028ae2137 netfilter: nft_ct: fix use-after-free in timeout object des=
troy
> f7c9c8b6a3c7e apparmor: fix differential encoding verification
> 48287285f14b5 apparmor: fix missing bounds check on DEFAULT table in veri=
fy_dfa()
> 91c9727179f31 ext4: convert inline data to extents when truncate exceeds =
inline size
> ffa20b32fd35c virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE is=
 cleared and napi_tx is false
> 2ae9ce04a67ad ipv6: fix NULL pointer deref in ip6_rt_get_dev_rcu()
> 29acc58f3339c crypto: authenc - use memcpy_sglist() instead of null skcip=
her
> 65888314e8d59 crypto: algif_aead - use memcpy_sglist() instead of null sk=
cipher
> 1ace4d448870d crypto: doc - fix kernel-doc notation in chacha.c and af_al=
g.c
> 5b3a91c42591d xen/privcmd: fix double free via VMA splitting
>
> Most copy-fail-related patches did not require a manual backport from 5.1=
0, but in case somebody wants to give them a quick look anyway:
>
> ebdc118c0b26e crypto: af_alg - Fix page reassignment overflow in af_alg_p=
ull_tsgl
> c179b717b58fe crypto: authencesn - Fix src offset when decrypting in-plac=
e
> 7b115c6573f4d crypto: authencesn - Do not place hiseq at end of dst for o=
ut-of-place decryption
> 3a3b130398dee crypto: algif_aead - snapshot IV for async AEAD requests
> 0bf0afd65c4bd crypto: algif_aead - Revert to operating out-of-place
> 02b8603f1d1c9 crypto: algif_aead - Fix minimum RX size check for decrypti=
on
> ab59e176f0f35 crypto: scatterwalk - Backport memcpy_sglist()

a5c28748776c3 soc: fsl: qbman: fix race condition in qman_destroy_fq
This commit will result in several build errors.
```
drivers/soc/fsl/qbman/qman.c: In function 'qman_destroy_fq':
drivers/soc/fsl/qbman/qman.c:1751:34: error: implicit declaration of
function 'qman_shutdown_fq' [-Werror=3Dimplicit-function-declaration]
 1751 |                         leaked =3D qman_shutdown_fq(fq->fqid);
      |                                  ^~~~~~~~~~~~~~~~
drivers/soc/fsl/qbman/qman.c: At top level:
drivers/soc/fsl/qbman/qman.c:2604:12: error: static declaration of
'qman_shutdown_fq' follows non-static declaration
 2604 | static int qman_shutdown_fq(u32 fqid)
      |            ^~~~~~~~~~~~~~~~
drivers/soc/fsl/qbman/qman.c:1751:34: note: previous implicit
declaration of 'qman_shutdown_fq' with type 'int()'
 1751 |                         leaked =3D qman_shutdown_fq(fq->fqid);
      |                                  ^~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[4]: *** [scripts/Makefile.build:303:
drivers/soc/fsl/qbman/qman.o] Error 1
make[3]: *** [scripts/Makefile.build:544: drivers/soc/fsl/qbman] Error 2
```

Best regards,
  Nobuhiro





>
> Thank you!
>
> CU
> Uli
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#22864): https://lists.cip-project.org/g/cip-dev/messa=
ge/22864
> Mute This Topic: https://lists.cip-project.org/mt/119148315/4520494
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [iwamatsu@gmai=
l.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


--
Nobuhiro Iwamatsu


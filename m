Return-Path: <SRS0=vk6v=LM=lists.cip-project.org=bounce+64572+6532+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B919C2B9F4
	for <cip-dev@archiver.kernel.org>; Fri, 18 Jun 2021 02:22:12 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CA4C6120A
	for <cip-dev@archiver.kernel.org>; Fri, 18 Jun 2021 02:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA4C6120A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6532+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NMcpYY4521723xXQf7oNb43h; Thu, 17 Jun 2021 19:22:10 -0700
X-Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
 by mx.groups.io with SMTP id smtpd.web09.2641.1623982928568309963
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Jun 2021 19:22:10 -0700
X-Received: by mail-oi1-f182.google.com with SMTP id r16so8836247oiw.3
        for <cip-dev@lists.cip-project.org>; Thu, 17 Jun 2021 19:22:08 -0700 (PDT)
X-Gm-Message-State: 6dFE9psLAJZb2dB69TebS1qPx4520388AA=
X-Google-Smtp-Source: ABdhPJzg1aTeP8NIzQrA0Nqz7HJYfYAVl7dGl1nVC+wgo84/zA/18My1JMDmt2kb2eAX7RX1VinlQNLgT67UIDgqPZQ=
X-Received: by 2002:aca:ef06:: with SMTP id n6mr5625169oih.66.1623982927302;
 Thu, 17 Jun 2021 19:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAGb2v65PfUtwZX8c+W2Yygk3XTOTxfXU0SoFUjXUAh2wYuHmyA@mail.gmail.com>
In-Reply-To: <CAGb2v65PfUtwZX8c+W2Yygk3XTOTxfXU0SoFUjXUAh2wYuHmyA@mail.gmail.com>
From: =?UTF-8?B?5biC5bed5q2j576O?= <masami.ichikawa@miraclelinux.com>
Date: Fri, 18 Jun 2021 11:21:31 +0900
Message-ID: <CAODzB9oQY6RFOK_kYmY-=6v61=rkFLZWoF8_nw5ZmpeWuOryJQ@mail.gmail.com>
Subject: Re: [cip-dev] Cip-kernel-sec Updates for Week of 2021-05-05
To: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="Dv1hG1PgKYQZBIe0aaeE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623982930;
 bh=Avk5bfFigwvy/mQ/SwUiYf8l7OSKQ8W3qsAk7tn2XO0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=euejSwAA3SMd50PqxrTRj79dtz0lwxOUYqFFBJmwG+zWEw7UP8uM2ZwQ2QYdRgVF73I
 cHGDM+4P9PNeW+LnIKMTVX0DP2XcyvJjdQSwRby0sim2rD6rms3THR3A1XI3qoECFo762
 JpD6t0deQBgsOJJVdL2bDx8zyhOSoNOrVIA=

--Dv1hG1PgKYQZBIe0aaeE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

May I ask some questions?

2021=E5=B9=B45=E6=9C=885=E6=97=A5(=E6=B0=B4) 13:37 Chen-Yu Tsai (Moxa) <we=
ns@csie.org>:
>
> Hi everyone,
>
> Two new CVEs this week:
>
> - CVE-2021-31829 [bpf: stack pointer protection from speculative
> arithmetic] - fixed
>   Fixes just landed in mainline as part of the merge window. Fixes not
> tagged for stable.
>

I'm looking into CVE-2021-31829. The issues/CVE-2021-31829.yml in
cip-kernel-sec repository describes this bug was introduced by commit
2c78ee898d8f10ae6fb2fa23a3fbaec96b1b7366.
The bug fix commit b9b34ddbe2076ade359cd5ce7537d5ed019e9807[1] has
Fixes tag which said "Fixes: 979d63d50c0c ("bpf: prevent out of bounds
speculation on pointer arithmetic")"
so, CVE-2021-31829.yml's introduced-by section may be
979d63d50c0c0f7bc537bf821e056cc9fe5abd38 ?

Also, one of a patch that fix CVE-2021-29155 has Fixes tag, that said
"Fixes: 2c78ee898d8f ("bpf: Implement CAP_BPF")[2]"
so, issues/CVE-2021-29155.yml's introduced-by section may be
2c78ee898d8f10ae6fb2fa23a3fbaec96b1b7366 ?

1:https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/patch/?id=3D=
b9b34ddbe2076ade359cd5ce7537d5ed019e9807
2:https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch=
/kernel/bpf/verifier.c?id=3D9601148392520e2e134936e76788fc2a6371e7be

> - CVE-2021-31916 [md: dm_ioctl: out-of-bounds array access] - fixed
>   Likely needs backport to 4.9 and earlier.
>
> Additionally, one old CVE is now fixed:
>
> - CVE-2020-26541
>
>
> Regards
> ChenYu
>
>=20
>

Regards,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--Dv1hG1PgKYQZBIe0aaeE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6532): https://lists.cip-project.org/g/cip-dev/message=
/6532
Mute This Topic: https://lists.cip-project.org/mt/82597445/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Dv1hG1PgKYQZBIe0aaeE--

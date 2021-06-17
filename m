Return-Path: <SRS0=V1Y0=LL=lists.cip-project.org=bounce+64572+6525+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E545AC48BE5
	for <cip-dev@archiver.kernel.org>; Thu, 17 Jun 2021 02:45:29 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4982360FF1
	for <cip-dev@archiver.kernel.org>; Thu, 17 Jun 2021 02:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4982360FF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6525+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5vPfYY4521723xHF66XHluJ7; Wed, 16 Jun 2021 19:45:28 -0700
X-Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
 by mx.groups.io with SMTP id smtpd.web10.2667.1623897926194071124
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Jun 2021 19:45:28 -0700
X-Received: by mail-oi1-f175.google.com with SMTP id x196so4806026oif.10
        for <cip-dev@lists.cip-project.org>; Wed, 16 Jun 2021 19:45:26 -0700 (PDT)
X-Gm-Message-State: xHNROjtnf9EOSxexBGyeObFIx4520388AA=
X-Google-Smtp-Source: ABdhPJycpS+PullTZwAzYk0nySFqkyTDdkvkMfKe83JaRtUC66xdbvdr7R8Uq4lmPNfxRHzomVfDLdtdwO9K10nZGHU=
X-Received: by 2002:aca:ef06:: with SMTP id n6mr1723785oih.66.1623897925330;
 Wed, 16 Jun 2021 19:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210610170538.GA12973@amd>
In-Reply-To: <20210610170538.GA12973@amd>
From: =?UTF-8?B?5biC5bed5q2j576O?= <masami.ichikawa@miraclelinux.com>
Date: Thu, 17 Jun 2021 11:45:14 +0900
Message-ID: <CAODzB9p=OOF-GtZWL=Uebgjk4ar4Si0FkESAsGabshct=hgY8g@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entries this week
To: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="4czr87VFjSGqWMg8LboT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623897928;
 bh=2c66LCXPiHJSATFp1CMsQZX9HOpD42KwxnHhcDStEp0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=GQPk6WoNm+vMVHo+tisIAIJkTgHv6dU6n6kbjZdtN+E2zkteMjX0klnkTgceCHAgkTo
 mx9zsrgBns2NxzVEw1B/7SJeHa13H23IDzVikHj7k9IdjBsaFX3izRASKWKkNLcun5KmN
 yeTfvMPXakX1mMr8cGVH9Pex9ylJww1jXwg=

--4czr87VFjSGqWMg8LboT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

2021=E5=B9=B46=E6=9C=8811=E6=97=A5(=E9=87=91) 2:05 Pavel Machek <pavel@den=
x.de>:
>
> Hi!
>
> These are the new issues this week:
>
> Best regards,
>                                                                 Pavel
>
> * 2021-06-04
>
> CVE-2021-33200 -- BPF fix turned out to be buggy.
>
> * 2021-06-09
>
> CVE-2021-0606 -- EoP in GPU DRM Driver / reported by android, probably u=
pstream commit e7cdf5c82f1773c3386b93bbcf13b9bfff29fa31 ... may be interest=
ing?
>
> CVE-2021-3587 -- redhat Bugzilla 1968057: CVE-2021-3587 kernel: nfc: Nul=
l pointer dereference in llcp_sock_getname
>
> CVE-2020-36385 -- An issue was discovered in the Linux kernel before 5.8=
.1. net/bluetooth/hci_event.c has a slab out-of-bounds read in hci_extended=
_inquiry_result_evt, aka CID-51c19bf3d5cf.
>

According to the CVE-2020-36385.yml, it describes 'RDMA/ucma: Rework
ucma_migrate_id() to avoid races with destroy'. However, the
description of 'An issue was discovered in the Linux kernel before
5.8.1 ...' seems like CVE-2020-36386.

> CVE-2020-36387 -- An issue was discovered in the Linux kernel before 5.8=
.2. fs/io_uring.c has a use-after-free related to io_async_task_func and ct=
x reference holding, aka CID-6d816e088c35.
>
>
>
>
>
>
>
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
>=20
>

Sincerely,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--4czr87VFjSGqWMg8LboT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6525): https://lists.cip-project.org/g/cip-dev/message=
/6525
Mute This Topic: https://lists.cip-project.org/mt/83449660/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--4czr87VFjSGqWMg8LboT--

Return-Path: <SRS0=qY/j=LO=lists.cip-project.org=bounce+64572+6543+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D479C48BDF
	for <cip-dev@archiver.kernel.org>; Sun, 20 Jun 2021 23:51:41 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DAB36109E
	for <cip-dev@archiver.kernel.org>; Sun, 20 Jun 2021 23:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DAB36109E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6543+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id QYOTYY4521723xY7BqrjCiWt; Sun, 20 Jun 2021 16:51:39 -0700
X-Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
 by mx.groups.io with SMTP id smtpd.web10.39959.1624233097686281373
 for <cip-dev@lists.cip-project.org>;
 Sun, 20 Jun 2021 16:51:39 -0700
X-Received: by mail-oi1-f172.google.com with SMTP id t40so18031237oiw.8
        for <cip-dev@lists.cip-project.org>; Sun, 20 Jun 2021 16:51:37 -0700 (PDT)
X-Gm-Message-State: 0dafUEz0c0oiSc43O7o3vUTGx4520388AA=
X-Google-Smtp-Source: ABdhPJz0asmUm9Savfv9/2gA9jGidJXIeynTPyACKWzkGNDAmHHL4Tavf5UVGYzMRIPFsNnoa2KFidxo7u/sOKEevpY=
X-Received: by 2002:aca:5bd4:: with SMTP id p203mr14974697oib.116.1624233096885;
 Sun, 20 Jun 2021 16:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210618080359.GB25229@amd>
In-Reply-To: <20210618080359.GB25229@amd>
From: =?UTF-8?B?5biC5bed5q2j576O?= <masami.ichikawa@miraclelinux.com>
Date: Mon, 21 Jun 2021 08:51:01 +0900
Message-ID: <CAODzB9p-2BvtDAOugEeghkki7RVg2RGq8G9L2kFKrd+j19nvEw@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="FkD4Ny1Z0ATsOggu7gVK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624233099;
 bh=ZicFgVgl6BqdpZ9FMSj7st7I3baM/Vsg/KAxbgaMOs4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=QsBFaIriw3qgTzjZZVcxahQQWZj6Eo9Xy9OsVZ9gbv7Uw1abO8Wf2jNLB8HJ32xi5yq
 y51E1/pl6ujONe/6VZJk16fEjvU4yqjVUoPdH/JndaUBe8gSyEQ6aSVilH49bnjPETH1u
 MI8IbBtIT+zfaXp/eA2xg396LQGRyZH1WiA=

--FkD4Ny1Z0ATsOggu7gVK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

2021=E5=B9=B46=E6=9C=8818=E6=97=A5(=E9=87=91) 17:04 Pavel Machek <pavel@de=
nx.de>:
>
> Hi!
>
> In last import, CVE-2020-36385 and CVE-2020-36386 was confused. That's
> fixed now. And we have following new issues:
>
> * 2021-06-13
>
> CVE-2021-0129 -- Passkey Entry protocol of the Bluetooth Core is
> vulnerable to an impersonation, fixed 4.9+
>
> CVE-2021-0512 -- HID arrays, fixed 4.9+
>
> CVE-2021-28691 -- Xen, fixed 5.10+
>
> CVE-2021-3573 -- Bluetooth UAF, fixed 4.9+
>
> * 2021-06-18
>
> CVE-2021-32078 -- ARM: footbridge:, hopefully noone uses this
>
> CVE-2021-34693 -- can: bcm: fix infoleak in struct bcm_msg_head
>
> CVE-2020-36386 -- An issue was discovered in the Linux kernel before
> 5.8.1. net/bluetooth/hci_event.c has a slab out-of-bounds read in
> hci_extended_inquiry_result_evt, aka CID-51c19bf3d5cf.
>

Thank you for the update.

> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
>=20
>


--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--FkD4Ny1Z0ATsOggu7gVK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6543): https://lists.cip-project.org/g/cip-dev/message=
/6543
Mute This Topic: https://lists.cip-project.org/mt/83449660/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--FkD4Ny1Z0ATsOggu7gVK--

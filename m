Return-Path: <SRS0=m3Xj=DB=lists.cip-project.org=bounce+64572+5471+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE1DC4363D
	for <cip-dev@archiver.kernel.org>; Thu, 24 Sep 2020 20:51:44 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9276022208
	for <cip-dev@archiver.kernel.org>; Thu, 24 Sep 2020 20:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="tuQxoWBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9276022208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5471+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id kkuHYY4521723xGybzhtXZbD; Thu, 24 Sep 2020 13:51:43 -0700
X-Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
 by mx.groups.io with SMTP id smtpd.web11.28003.1600980701593161261
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2020 13:51:42 -0700
X-Received: by mail-oo1-f47.google.com with SMTP id k13so216100oor.2
        for <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2020 13:51:41 -0700 (PDT)
X-Gm-Message-State: bijsyMG9pfFzNCHjlFpAMF9Vx4520388AA=
X-Google-Smtp-Source: ABdhPJyGjQ6yk9Jx7MymvwGSs9dAGKD/TagG2+g+id2FLYtWzWBOyEKJWHRNOzLYO9ZpSnGV1+7sdB1LkXe0IlqSKgY=
X-Received: by 2002:a4a:9b01:: with SMTP id a1mr748064ook.51.1600980700546;
 Thu, 24 Sep 2020 13:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200924101732.GA30460@duo.ucw.cz>
In-Reply-To: <20200924101732.GA30460@duo.ucw.cz>
From: "Nobuhiro Iwamatsu" <iwamatsu@nigauri.org>
Date: Fri, 25 Sep 2020 05:51:14 +0900
Message-ID: <CABMQnVJeW7Vj_zptkCPpk9bX2M66X93X1_2D+mj3JOUe-OVzDg@mail.gmail.com>
Subject: Re: [cip-dev] CVE-2020-0427 / pinctrl: devicetree: Avoid taking direct reference to device name string
To: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="eBKuU3GDxfdnQRZaqYRJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1600980703;
 bh=BQoeMuFqaEFOqq/gUkzIEikiv3CcNuuAk7bDyEwAOi8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=tuQxoWBYCqead+WckLHkV7mNSoto/QMAse9iJNR5VKE2S5JECTktUZV9BzJx4q8c0XI
 YbQNqJPSOj5dy91zfA/YlVZpsmC1CIamA2tmm+Zsr9oUmqHOm5bXupzlGF8VnO3fbaNhL
 whahehZpWiCAgCBpQnlMbaH7x2P6WfFL21w=

--eBKuU3GDxfdnQRZaqYRJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

2020=E5=B9=B49=E6=9C=8824=E6=97=A5(=E6=9C=A8) 19:17 Pavel Machek <pavel@uc=
w.cz>:
>
> Hi!
>
> Backport to 4.4 was very easy (there was single dev_err that prevented
> patch for applying), and backported patch tests okay:
>
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/19393334=
6

Thanks for your work.
It looks like there is no issue.

>
> Best regards,
>                                                                         =
Pavel

Best regards,
  Nobuhiro

> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/=
blog.html
>
>=20
>


--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6

--eBKuU3GDxfdnQRZaqYRJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5471): https://lists.cip-project.org/g/cip-dev/message=
/5471
Mute This Topic: https://lists.cip-project.org/mt/77054335/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--eBKuU3GDxfdnQRZaqYRJ--

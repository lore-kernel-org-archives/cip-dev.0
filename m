Return-Path: <SRS0=gdHi=FA=lists.cip-project.org=bounce+64572+5882+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D9AC56202
	for <cip-dev@archiver.kernel.org>; Thu, 26 Nov 2020 09:07:46 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D21720B80
	for <cip-dev@archiver.kernel.org>; Thu, 26 Nov 2020 09:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="dz7ZKvEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D21720B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5882+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ioVIYY4521723xExPbYyHc8f; Thu, 26 Nov 2020 01:07:43 -0800
X-Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web10.2694.1606381662640525883
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2020 01:07:43 -0800
X-Received: by mail-lj1-f169.google.com with SMTP id b17so1485156ljf.12
        for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2020 01:07:42 -0800 (PST)
X-Gm-Message-State: AKh7iWa2vbooEImTvslUGimSx4520388AA=
X-Google-Smtp-Source: ABdhPJzzTcgjB5eXPX+cTkjtchwDSFYm85qElgwZbAUCnotDPNyBUH1vNhLW4XSpgfWK9cRADVfAAg==
X-Received: by 2002:a2e:9893:: with SMTP id b19mr907268ljj.99.1606381660035;
        Thu, 26 Nov 2020 01:07:40 -0800 (PST)
X-Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id l6sm242484lfk.150.2020.11.26.01.07.39
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 01:07:39 -0800 (PST)
X-Received: by mail-lf1-f46.google.com with SMTP id u19so1441989lfr.7
        for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2020 01:07:39 -0800 (PST)
X-Received: by 2002:a19:ca05:: with SMTP id a5mr1017325lfg.571.1606381659667;
 Thu, 26 Nov 2020 01:07:39 -0800 (PST)
MIME-Version: 1.0
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 26 Nov 2020 17:07:27 +0800
X-Gmail-Original-Message-ID: <CAGb2v64vn7cst37ZyueSkcE+pBZU759_6o-_rRExDvXs+wD8Kw@mail.gmail.com>
Message-ID: <CAGb2v64vn7cst37ZyueSkcE+pBZU759_6o-_rRExDvXs+wD8Kw@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2020-11-26
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="0h3CxyNleLMqwBIhrQaW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606381663;
 bh=lKbEpwPl7W1DHruS5eomWG8n7NqV/E1fzsLy9AUX5eY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=dz7ZKvEdZ1H2uEk7YkBtrE3m+o6Jw0YHe9QfadtZjNiDXR7lM9DhXzUxq7HFdDwiKet
 N7zbzJJN+oer09PeHz8Gl8E/EbRSjwg7LLNu2W3HuLiEFu3xJtLfqSJmdrwH8eWQ7U1iw
 50QkTSm6UPeVtqTgaHK+U8uzmgerYXY+EK0=

--0h3CxyNleLMqwBIhrQaW
Content-Type: text/plain; charset="UTF-8"

(Resent from correct email address.)

Hi everyone,

This week we have six new issues:

- CVE-2020-15436 [blockdev UAF] - Fixed in all stable kernels

- CVE-2020-15437 [serial/8250 NULL pointer dereference] -
  Fixed in all stable kernels

- CVE-2020-27777 [powerpc/rtas usage check] - Fix backported to 4.14+

Since no member requires ppc support, we can ignore this.
Though if anyone wishes to look into this, this might require backporting
to 4.4 and 4.9.

- CVE-2020-28915 [fbcon_get_font() global-out-of-bounds] -
  Fixed in all stable kernels

- CVE-2020-28941 [accessibility/speakup] - Fixed in relevant stable kernels

- CVE-2020-4788 [powerpc/power9 speculation] - Fixed in 4.9, 4.19, and mainline

The stable commits were imported from Debian, which only tracks 4.9 and 4.19.
4.9 requires one less commit compared to 4.19 and mainline. I suspect 4.14
and 5.4 might also contain the fixes, but manual matching would be required.


Regarding old issues:

CVE-2020-27673 is fixed for 4.9 with one less commit than mainline, due to
a feature introduced later. I suspect 4.4 might be the same, but this will
require some manual matching.

CVE-2019-12881 marked as fixed for all stable kernels.

CVE-2020-slab-out-of-bounds-read-fbcon is now CVE-2020-28974.


Regards
ChenYu
Moxa

--0h3CxyNleLMqwBIhrQaW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5882): https://lists.cip-project.org/g/cip-dev/message=
/5882
Mute This Topic: https://lists.cip-project.org/mt/78526203/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--0h3CxyNleLMqwBIhrQaW--

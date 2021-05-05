Return-Path: <SRS0=uyvf=KA=lists.cip-project.org=bounce+64572+6417+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45461C433B4
	for <cip-dev@archiver.kernel.org>; Wed,  5 May 2021 04:37:04 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51D496112D
	for <cip-dev@archiver.kernel.org>; Wed,  5 May 2021 04:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D496112D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6417+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id obNMYY4521723xgWkqlZH9WR; Tue, 04 May 2021 21:37:02 -0700
X-Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web11.3609.1620189421847510678
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 May 2021 21:37:02 -0700
X-Received: by mail-lf1-f43.google.com with SMTP id z13so734194lft.1
        for <cip-dev@lists.cip-project.org>; Tue, 04 May 2021 21:37:01 -0700 (PDT)
X-Gm-Message-State: mhw5MNvx3pTZ7bjY005pBGGxx4520388AA=
X-Google-Smtp-Source: ABdhPJxofpplvZRSduiIuTXMQnDL1rmBGraAUnCFjqFffKiqtvI7pNe+AIkPBMlggGNqiYnh6XZmxA==
X-Received: by 2002:a05:6512:3090:: with SMTP id z16mr10451339lfd.402.1620189419651;
        Tue, 04 May 2021 21:36:59 -0700 (PDT)
X-Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id u12sm429329lfr.192.2021.05.04.21.36.59
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 21:36:59 -0700 (PDT)
X-Received: by mail-lj1-f169.google.com with SMTP id e12so789439ljn.2
        for <cip-dev@lists.cip-project.org>; Tue, 04 May 2021 21:36:59 -0700 (PDT)
X-Received: by 2002:a2e:9810:: with SMTP id a16mr1108889ljj.78.1620189419157;
 Tue, 04 May 2021 21:36:59 -0700 (PDT)
MIME-Version: 1.0
Reply-To: cip-dev@lists.cip-project.org
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Wed, 5 May 2021 12:36:48 +0800
X-Gmail-Original-Message-ID: <CAGb2v65PfUtwZX8c+W2Yygk3XTOTxfXU0SoFUjXUAh2wYuHmyA@mail.gmail.com>
Message-ID: <CAGb2v65PfUtwZX8c+W2Yygk3XTOTxfXU0SoFUjXUAh2wYuHmyA@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2021-05-05
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Content-Type: multipart/mixed; boundary="S6o39BqnFaLGSd4TFXIe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620189422;
 bh=jTgmHL6HiZdVSuooaNgDv2uat047ugT5bIqYuM2ozPA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=C7/LnDarpOi5GXEKh/bmbGgqgF30LO6U+hs9/pKrffVOaYteo09h0qDYNv+NIWr33Kj
 XBWLR/qLwxviSrrD1HWparnZ/34GTmHpxxolEB9ntNZEQcN/VplGIG2T0+A4dzE9OdUsf
 5KK2MHx6Ke0svDlxPViL856Io9cB7C91IcQ=

--S6o39BqnFaLGSd4TFXIe
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Two new CVEs this week:

- CVE-2021-31829 [bpf: stack pointer protection from speculative
arithmetic] - fixed
  Fixes just landed in mainline as part of the merge window. Fixes not
tagged for stable.

- CVE-2021-31916 [md: dm_ioctl: out-of-bounds array access] - fixed
  Likely needs backport to 4.9 and earlier.

Additionally, one old CVE is now fixed:

- CVE-2020-26541


Regards
ChenYu

--S6o39BqnFaLGSd4TFXIe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6417): https://lists.cip-project.org/g/cip-dev/message=
/6417
Mute This Topic: https://lists.cip-project.org/mt/82597445/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--S6o39BqnFaLGSd4TFXIe--

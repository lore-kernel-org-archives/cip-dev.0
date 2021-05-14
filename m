Return-Path: <SRS0=wid2=KJ=lists.cip-project.org=bounce+64572+6454+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E174C433ED
	for <cip-dev@archiver.kernel.org>; Fri, 14 May 2021 04:50:33 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE7261447
	for <cip-dev@archiver.kernel.org>; Fri, 14 May 2021 04:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE7261447
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6454+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TrOoYY4521723x3Ai358U6BF; Thu, 13 May 2021 21:50:31 -0700
X-Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web10.4566.1620967829189693971
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 May 2021 21:50:31 -0700
X-Received: by mail-ej1-f49.google.com with SMTP id l4so42890043ejc.10
        for <cip-dev@lists.cip-project.org>; Thu, 13 May 2021 21:50:28 -0700 (PDT)
X-Gm-Message-State: rKOPT7SZVRpNVfUbe8jGPhaCx4520388AA=
X-Google-Smtp-Source: ABdhPJzqaDU0bY49eeQAKm9ULlPt9kvWxkIJTXNd2TM4FYSnWysnYNAJWxEARVAJ0AzkLghQL8/cFB5ue6DZuGZKsq4=
X-Received: by 2002:a17:907:10ca:: with SMTP id rv10mr9448022ejb.377.1620967827515;
 Thu, 13 May 2021 21:50:27 -0700 (PDT)
MIME-Version: 1.0
From: "Alice Ferrazzi" <alice.ferrazzi@miraclelinux.com>
Date: Fri, 14 May 2021 13:49:51 +0900
Message-ID: <CANgtXuNnyyN4cNCUmE_1-uZwGfgj4V-DVrYDCbgicdA0UJpAjA@mail.gmail.com>
Subject: [cip-dev] lava.ciplatform.org offline lab
To: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="hip0ortdy0oN1dCnWIEE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620967831;
 bh=yK4rYhTN++4uki1zWjuW9BpMM46TMsEFbHWaQv+RhgA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=sY022inXlFOoAp5shANzdo1F6pOk0+10lAmBGeAzWtFLkdfvu+HET4KggIT4luXBsgg
 Sn/wyFmk1iNCuFw6VZbGH0i78M1NUMr2v2MStfm4DEOfrwVEBU4BxLcbPjimGIKE5ANVc
 ijzG6eHLMnB1LK2Q+qyOx1G2xrjFfDR4LE4=

--hip0ortdy0oN1dCnWIEE
Content-Type: multipart/alternative; boundary="0000000000008d3f5405c242fbe7"

--0000000000008d3f5405c242fbe7
Content-Type: text/plain; charset="UTF-8"

Hello,

the laboratory on lava.ciplatform.org except for lab-cip-cybertrust are all
offline.
https://lava.ciplatform.org/scheduler/allworkers
any information on this ?

thanks,
Alice

-- 
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

--0000000000008d3f5405c242fbe7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small">Hel=
lo,</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><=
div class=3D"gmail_default" style=3D"font-size:small">the laboratory on <a =
href=3D"http://lava.ciplatform.org">lava.ciplatform.org</a> except for lab-=
cip-cybertrust are all offline.</div><div class=3D"gmail_default" style=3D"=
font-size:small"><a href=3D"https://lava.ciplatform.org/scheduler/allworker=
s">https://lava.ciplatform.org/scheduler/allworkers</a></div><div class=3D"=
gmail_default" style=3D"font-size:small">any information on this ?</div><di=
v class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D=
"gmail_default" style=3D"font-size:small">thanks,</div><div class=3D"gmail_=
default" style=3D"font-size:small">Alice<br></div><br>-- <br><div dir=3D"lt=
r" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D=
"ltr"><div><div dir=3D"ltr"><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br=
><span>Cybertrust Japan Co.,Ltd.</span><br>Alice Ferrazzi<br><a href=3D"mai=
lto:alice.ferrazzi@miraclelinux.com" target=3D"_blank">alice.ferrazzi@mirac=
lelinux.com</a><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br></div></div=
></div></div></div></div>

--0000000000008d3f5405c242fbe7--

--hip0ortdy0oN1dCnWIEE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6454): https://lists.cip-project.org/g/cip-dev/message=
/6454
Mute This Topic: https://lists.cip-project.org/mt/82817310/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--hip0ortdy0oN1dCnWIEE--

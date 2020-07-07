Return-Path: <SRS0=uK5A=AS=lists.cip-project.org=bounce+64572+4885+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A888C433DF
	for <cip-dev@archiver.kernel.org>; Tue,  7 Jul 2020 21:46:49 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15C47206C3
	for <cip-dev@archiver.kernel.org>; Tue,  7 Jul 2020 21:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="XRiKSVaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C47206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mab-labs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4885+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id IMepYY4521723xDl3eOEiA4s; Tue, 07 Jul 2020 14:46:48 -0700
X-Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
 by mx.groups.io with SMTP id smtpd.web12.338.1594158406535508368
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jul 2020 14:46:47 -0700
X-Received: by mail-lj1-f195.google.com with SMTP id s9so51739629ljm.11
        for <cip-dev@lists.cip-project.org>; Tue, 07 Jul 2020 14:46:46 -0700 (PDT)
X-Gm-Message-State: 7WHSIsgRQBuCfcLIYJEQxcQTx4520388AA=
X-Google-Smtp-Source: ABdhPJx45LkqbVsuQ8X/4WFQiOi/1AgysovFZxP+DbNffQHjXjqadzhfe3pyRfMWz7MuQmAN1ILcblvgPDX1HdEwlyU=
X-Received: by 2002:a2e:a58a:: with SMTP id m10mr7358057ljp.16.1594158404178;
 Tue, 07 Jul 2020 14:46:44 -0700 (PDT)
MIME-Version: 1.0
From: "Mohammed Billoo" <mab@mab-labs.com>
Date: Tue, 7 Jul 2020 17:46:33 -0400
Message-ID: <CALkjhPoWz-M1XkBa3EH6L703Ahp3gaewn=iNojyVmxXhAyNcFw@mail.gmail.com>
Subject: [cip-dev] Vagrant 2.2.8, 2.2.9 issue
To: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="6urYJQyLvZIiAtdAe49r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594158408;
 bh=JkyDYLzEfvI0dWoKMBmob9CzcfgHDenu3iuFJTkn8MQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=XRiKSVaY5pTLoS2CIGwmV+oKbsSLgDeGv3uwT2CsOD/ZZvPyg7hQ8p41XD3fqcOLDT2
 zuoXfwh+1isSnx3pxLRzCClwnIUVrAvSx4Kwj6ZC/pnFrnXwOGUZ4h+l9HM6l4zekC45x
 vXQKD6fviGchcqt9c0xRcvC5RlinBiabh3A=

--6urYJQyLvZIiAtdAe49r
Content-Type: multipart/alternative; boundary="00000000000065a93405a9e0edf4"

--00000000000065a93405a9e0edf4
Content-Type: text/plain; charset="UTF-8"

All,

Just wanted to document an issue as well as a/my workaround when using
vagrant 2.2.8/2.2.9. After installing vagrant 2.0.2 using apt-get in Ubuntu
18.04, it complained that I had a too new version of VirtualBox. Not
wanting to downgrade VirtualBox because I have other VMs that I use for
other work, I decided to install from source. I went with the tagged
version 2.2.9 and ran into the following issue (which also exists for
2.2.8):

https://github.com/hashicorp/vagrant/issues/11636

I installed from the master branch and didn't have the issue.

Just documenting this in case anyone else has the same issue.
-- 
Mohammed A Billoo
Founder
MAB Labs, LLC
www.mab-labs.com
201-338-2022

--00000000000065a93405a9e0edf4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>All, <br></div><div><br></div><div>Just wanted to doc=
ument an issue as well as a/my workaround when using vagrant 2.2.8/<a href=
=3D"http://2.2.9.">2.2.9.</a> After installing vagrant 2.0.2 using apt-get=
 in Ubuntu 18.04, it complained that I had a too new version of VirtualBox.=
 Not wanting to downgrade VirtualBox because I have other VMs that I use fo=
r other work, I decided to install from source. I went with the tagged vers=
ion 2.2.9 and ran into the following issue (which also exists for 2.2.8):<b=
r></div><div><br></div><div><a href=3D"https://github.com/hashicorp/vagrant=
/issues/11636">https://github.com/hashicorp/vagrant/issues/11636</a></div><=
div><br></div><div>I installed from the master branch and didn&#39;t have t=
he issue.=C2=A0</div><div><br></div><div>Just documenting this in case anyo=
ne else has the same issue.<br></div><div>-- <br><div dir=3D"ltr" class=3D"=
gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>M=
ohammed A Billoo</div><div>Founder</div><div>MAB Labs, LLC</div><div><a hre=
f=3D"http://www.mab-labs.com" target=3D"_blank">www.mab-labs.com</a></div><=
div>201-338-2022<br></div></div></div></div></div>
<br>-- <br>Mohammed Billoo<br />MAB Labs, LLC<br />www.mab-labs.com

--00000000000065a93405a9e0edf4--

--6urYJQyLvZIiAtdAe49r
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4885): https://lists.cip-project.org/g/cip-dev/message=
/4885
Mute This Topic: https://lists.cip-project.org/mt/75364850/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--6urYJQyLvZIiAtdAe49r--

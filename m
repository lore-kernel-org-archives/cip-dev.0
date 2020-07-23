Return-Path: <SRS0=soOh=BC=lists.cip-project.org=bounce+64572+4980+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D7AC433E4
	for <cip-dev@archiver.kernel.org>; Thu, 23 Jul 2020 00:08:22 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A7B022B47
	for <cip-dev@archiver.kernel.org>; Thu, 23 Jul 2020 00:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="anGEDXot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7B022B47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mab-labs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4980+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 2b3lYY4521723x0H8z63pUMG; Wed, 22 Jul 2020 17:08:21 -0700
X-Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
 by mx.groups.io with SMTP id smtpd.web10.2078.1595462899068204829
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 17:08:19 -0700
X-Received: by mail-lj1-f176.google.com with SMTP id q7so4471363ljm.1
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jul 2020 17:08:18 -0700 (PDT)
X-Gm-Message-State: UdZ3DlWQrp7CCMxyXmpLZXMtx4520388AA=
X-Google-Smtp-Source: ABdhPJwuRd2V3SDfMBHJ6CdFVP0eDYlOzErr5IbZ0/uYABRvAUy1CMhCPf8+j3jxRy+Bnj9aShSef5dOvTlT9uLTrUk=
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr796546ljg.344.1595462896859;
 Wed, 22 Jul 2020 17:08:16 -0700 (PDT)
MIME-Version: 1.0
From: "Mohammed Billoo" <mab@mab-labs.com>
Date: Wed, 22 Jul 2020 20:08:06 -0400
Message-ID: <CALkjhPoWijfuk3aJn+z6A0JqzeAZVUFuGpr=_iWR2Qi4YcAOag@mail.gmail.com>
Subject: [cip-dev] Resource describing the Deby workflow?
To: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="W8QHeD4xMKKoZv7ceMta"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595462901;
 bh=qfoNIEh5ZcNDM7wRgdQAk2wtAsW68RlwtdhIYcJ4WQg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=anGEDXotI8c9iV/3hSyObLK6vMn0tDlLT9xSSLmF11lAe6eKQ3RpFDj4hSyyfU8D7Eh
 xzdqmqkiLEjAAAIesAR+4zmqSAYnF3i8g1doxbN1s3ABnGl9Ze5iyVfTEuKtYx+2H2wm7
 g2RCsUzu4odbrN1+SKxo8SbhjgI4g0hliAc=

--W8QHeD4xMKKoZv7ceMta
Content-Type: multipart/alternative; boundary="000000000000384e7105ab10a775"

--000000000000384e7105ab10a775
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm almost done getting SSL working between the BBB and hawkbit. The last
piece of the puzzle is to get NTP working on the BBB (since I need valid
time to ensure that the server certificate is valid). Unfortunately, I'm
having a hard time understanding the proper way to add utilities or modify
configurations in Deby. It's similar enough to Yocto where I tried creating
bbappend recipes and failed miserably. I stumbled upon successfully adding
openssl to the rfs, but don't know why it worked. Can anybody point me to a
good resource that can describe the proper Deby workflow?

As an example, I want to install NTP and then modify its configuration so
that it points to the hawkbit server.

Thanks
-- 
Mohammed A Billoo
Founder
MAB Labs, LLC
www.mab-labs.com
201-338-2022

--000000000000384e7105ab10a775
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>I&#39;m almost done gett=
ing SSL working between the BBB and hawkbit. The last piece of the puzzle i=
s to get NTP working on the BBB (since I need valid time to ensure that the=
 server certificate is valid). Unfortunately, I&#39;m having a hard time un=
derstanding the proper way to add utilities or modify configurations in Deb=
y. It&#39;s similar enough to Yocto where I tried creating bbappend recipes=
 and failed miserably. I stumbled upon successfully adding openssl to the r=
fs, but don&#39;t know why it worked. Can anybody point me to a good resour=
ce that can describe the proper Deby workflow? <br></div><div><br></div><di=
v>As an example, I want to install NTP and then modify its configuration so=
 that it points to the hawkbit server. <br></div><div><br></div><div>Thanks=
<br></div><div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" data-smart=
mail=3D"gmail_signature"><div dir=3D"ltr"><div>Mohammed A Billoo</div><div>=
Founder</div><div>MAB Labs, LLC</div><div><a href=3D"http://www.mab-labs.co=
m" target=3D"_blank">www.mab-labs.com</a></div><div>201-338-2022<br></div><=
/div></div></div></div>
<br>-- <br>Mohammed Billoo<br />MAB Labs, LLC<br />www.mab-labs.com

--000000000000384e7105ab10a775--

--W8QHeD4xMKKoZv7ceMta
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4980): https://lists.cip-project.org/g/cip-dev/message=
/4980
Mute This Topic: https://lists.cip-project.org/mt/75736954/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--W8QHeD4xMKKoZv7ceMta--

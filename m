Return-Path: <SRS0=DIdx=45=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD79C10DCE
	for <cip-dev@archiver.kernel.org>; Thu, 12 Mar 2020 19:50:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C72D20637
	for <cip-dev@archiver.kernel.org>; Thu, 12 Mar 2020 19:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QAlaDcsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C72D20637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 77F0985DE1;
	Thu, 12 Mar 2020 19:50:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bEmgxpy9PVoL; Thu, 12 Mar 2020 19:50:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 09D4E85D4C;
	Thu, 12 Mar 2020 19:50:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1830C0177;
	Thu, 12 Mar 2020 19:50:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 836D0C0177
 for <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2020 19:50:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 80410877DC
 for <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2020 19:50:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AEX7mjdrctcu for <cip-dev@lists.cip-project.org>;
 Thu, 12 Mar 2020 19:50:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 341FF877D6
 for <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2020 19:50:45 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id w17so4533573oic.9
 for <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2020 12:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=4nqsT6D8tmu54F1alsfMNpXucAx17bxXR3aHKoffApI=;
 b=QAlaDcsRn+96JsJ+NPqk4fQ50VadDypw8NKa5InRbaimZP3LC8xPAE0jdAyosclNF7
 IbJ1ufQuCJrMu9KZHWw0EfpKqdE5i7Q6T3TqCfDBtzf1k4eg55y/xN4I1NZuW+lHU+wG
 9hzbbKFm79q0+N0e/J90kGI/Mvmsrcj4J661c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=4nqsT6D8tmu54F1alsfMNpXucAx17bxXR3aHKoffApI=;
 b=j8JcWYfg2lml8Gu9yxmrGbC3pa3EL7KVzbfQDSKtIIHmDT5LmduXr5a5L3Z0MHitpY
 Nrt5B736ac8CaPiPaBM+RgUPoLO6HznW1o3J39Gcde4nok26lsp+3rVEMgVykn3aRkHv
 j1mjwwyn8GHaoEHMAqB+sg2wlxvfYmOED6MTYurbV5+/OP5FoJKxALaNug4ih9d8U7ev
 S4R3YgEOOn9F6aIk8XsUhoj88pXyLoORfY0eXjWzMQNKtKFYoNqASre5L5mK7IIKq8mf
 RhGeEzlhxF4fN4H3jHFdsU2qOa1cbnMfYx5KzuKpjxc5t/1ddrT2KFS8LUvr71FXbHix
 EOIg==
X-Gm-Message-State: ANhLgQ1DJnwxs3qd67cZg+mYw18Ylg/iiVM68X+hf3bujP445/9LGmPm
 K1G3XYPHTVGZXoY1FSBoy9SDdsCqZ7Gr2EwlWBoVYw==
X-Google-Smtp-Source: ADFU+vvODBRbnBITT5nZJCbPMRGN1py51BWGBnZDeMNNc69OeG9jQ3Sy1ZD7d3wMmwbYDtN5d+9Eaur247lhxqIGRuE=
X-Received: by 2002:aca:a9d4:: with SMTP id s203mr4175896oie.106.1584042644268; 
 Thu, 12 Mar 2020 12:50:44 -0700 (PDT)
MIME-Version: 1.0
From: Neal Caidin <ncaidin@linuxfoundation.org>
Date: Thu, 12 Mar 2020 15:50:28 -0400
Message-ID: <CAODMxsLOOk7EZwoUgd5fNpXpOoR16ZunzZe0W6nL5NrLN2JWSw@mail.gmail.com>
To: cip-members@lists.cip-project.org, cip-board@lists.cip-project.org, 
 cip-security@lists.cip-project.org, cip-dev@lists.cip-project.org
Subject: [cip-dev] April 6 cutover from Mailman2 to Group.io
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3454110174305344073=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

--===============3454110174305344073==
Content-Type: multipart/alternative; boundary="0000000000001f025305a0adab80"

--0000000000001f025305a0adab80
Content-Type: text/plain; charset="UTF-8"

[x-posted]
Dear CIP community,

These Mailman2 email lists will be converted starting on Monday, April 6
and may take up to 24 hours to complete.

There is no action required on your part.

Any emails that are sent during the downtime will be queued up and come
through when the system is up and running.

Please let me know if you have any questions.

Best regards,
Neal

*Neal Caidin*
Program Manager, Program Management & Operations
The Linux Foundation
+1 (919) 238-9104 (w/h)
+1 (919) 949-1861 (m)
ncaidin@linuxfoundation.org

--0000000000001f025305a0adab80
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>[x-posted]</div>Dear CIP community,<div><br></div><di=
v>These Mailman2 email lists will be converted starting on Monday, April 6 =
and may take up to 24 hours to complete.=C2=A0</div><div><br></div><div>The=
re is no action required on your=C2=A0part.=C2=A0</div><div><br></div><div>=
Any emails that are sent during the downtime will be queued up and come thr=
ough when the system is up and running.</div><div><br></div><div>Please let=
 me know if you have any questions.</div><div><br></div><div>Best regards,<=
/div><div>Neal</div><div><br></div><div><div><div dir=3D"ltr" class=3D"gmai=
l_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div =
dir=3D"ltr"><span><font color=3D"#888888"><div dir=3D"ltr"><div dir=3D"ltr"=
><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"l=
tr"><div dir=3D"ltr"><b style=3D"color:rgb(136,136,136)"><font color=3D"#66=
6666"><font color=3D"#888888">Neal Caidin</font></font></b><br><div style=
=3D"color:rgb(136,136,136)"><span style=3D"border-collapse:collapse"><div><=
font color=3D"#666666"><font>Program Manager, Program Management &amp; Oper=
ations</font></font></div><div><font color=3D"#666666"><font>The Linux Foun=
dation</font></font></div><div><font color=3D"#666666">+1 (919) 238-9104 (w=
/h)<br>+1 (919) 949-1861 (m)</font></div><div><font color=3D"#666666"><a hr=
ef=3D"mailto:ncaidin@linuxfoundation.org" target=3D"_blank">ncaidin@linuxfo=
undation.org</a></font></div></span></div></div></div></div></div></div></d=
iv></div></div></div></font></span></div></div></div></div></div></div></di=
v>

--0000000000001f025305a0adab80--

--===============3454110174305344073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============3454110174305344073==--

Return-Path: <SRS0=EZCl=5S=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5601DC43331
	for <cip-dev@archiver.kernel.org>; Thu,  2 Apr 2020 20:57:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F1E620719
	for <cip-dev@archiver.kernel.org>; Thu,  2 Apr 2020 20:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FEd5CvsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1E620719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DBE2F25C66;
	Thu,  2 Apr 2020 20:57:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0b3BrL2a5IoX; Thu,  2 Apr 2020 20:57:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4E1E52047A;
	Thu,  2 Apr 2020 20:57:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 316ECC1D85;
	Thu,  2 Apr 2020 20:57:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AD41C07FF
 for <cip-dev@lists.cip-project.org>; Thu,  2 Apr 2020 20:57:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 526DC22193
 for <cip-dev@lists.cip-project.org>; Thu,  2 Apr 2020 20:57:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J0RQQQUBkGXQ for <cip-dev@lists.cip-project.org>;
 Thu,  2 Apr 2020 20:57:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com
 [209.85.166.175])
 by silver.osuosl.org (Postfix) with ESMTPS id EFE2E2047A
 for <cip-dev@lists.cip-project.org>; Thu,  2 Apr 2020 20:57:09 +0000 (UTC)
Received: by mail-il1-f175.google.com with SMTP id t11so5115808ils.1
 for <cip-dev@lists.cip-project.org>; Thu, 02 Apr 2020 13:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=JgLwxtimvS9fI/h2fhbuV/m4X5wWGd1q7Qc4ptJzPUs=;
 b=FEd5CvsGIQlMtRlzLgwqU5NFoBmVIdGN16CXWifzW6ew8K/lpaOqcFQuM+WGNtsyq9
 Y53FyYqbmIbpsRGnLdC+BqnJcYTPXj/tP3iAcmRPMgqAi+l3LZzVP+l5r3H8ZrmUZkzV
 eZGRn5KkCuJt8b3c1FmyOBmL2vXAvN7NIO5bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=JgLwxtimvS9fI/h2fhbuV/m4X5wWGd1q7Qc4ptJzPUs=;
 b=MTC7WIp2gDidQohwg+Ni+IkdDZetzaiRdgIwCCiAXql9TMFn03CbUopIIxO2obzzZo
 0HrAZW/hLfVYP6FkRsh5p26n0S6PY2O9XzHbbmB5I0DRNItzDb6b1yZFvXh0ZQhWpt6m
 xAZm8H3Y6bLW0SxM48ebC9skzTGJRTk+CtzENLWNwJBWSg0VR3Dgod0mC3odM9d5da6R
 sqgBS5lxgg99cJtqxc3lMqdb9y2NUnBsoWVQjGjGofZwLPQ7131uM2PTJnsE+MV1QrZi
 eXWQ3yzetUuHVsK8Roc85v/BOSdyVUHkSEHttnHd5haCOflynnA5syMu8pjli5Wjr5fU
 GDIQ==
X-Gm-Message-State: AGi0PuZeqChyqBsy1D24PySkmoD0tygOtIUJuTJYJNYHtvuJj6ybGb0h
 NvgWyEjpc56rof3EMLvjqnqWo+0Mepp+tvTdgrD9uw==
X-Google-Smtp-Source: APiQypJcwTwbbZMoZ2FAXUmiGL5fsJXhWr6o9XRzRC5LThedRJPHqdSvJLl+nCPerLFd6IbPUXEaddN7Hu1gdLZ6Dv8=
X-Received: by 2002:a92:7eda:: with SMTP id q87mr5061702ill.179.1585861029146; 
 Thu, 02 Apr 2020 13:57:09 -0700 (PDT)
MIME-Version: 1.0
From: Neal Caidin <ncaidin@linuxfoundation.org>
Date: Thu, 2 Apr 2020 16:56:53 -0400
Message-ID: <CAODMxsK_vgo-=FikL1Z2iYXtetRh+KpRJNL4MchmfXvLMqBTUA@mail.gmail.com>
To: cip-board@lists.cip-project.org, cip-members@lists.cip-project.org, 
 cip-security@lists.cip-project.org, cip-dev@lists.cip-project.org
Subject: [cip-dev] Mailman2 to Groups.io reminder
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
Content-Type: multipart/mixed; boundary="===============0634486643779298577=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

--===============0634486643779298577==
Content-Type: multipart/alternative; boundary="0000000000004e4e9305a2550b32"

--0000000000004e4e9305a2550b32
Content-Type: text/plain; charset="UTF-8"

[cross posted]

Reminder.  Mailman2 to Groups.io email is scheduled to start on

Pacific - 2 pm , Monday, April 6
Eastern - 5 pm, Monday April 6
CET - 11 pm, Monday April 6
JST - 6 am, Tuesday, April 7

It is expected to take several hours, but could be as much as a full 24
hours.

When the migration is completed, I will send out the links so that you can
access email archives.

Best regards,
Neal


*Neal Caidin*
Program Manager, Program Management & Operations
The Linux Foundation
+1 (919) 238-9104 (w/h)
+1 (919) 949-1861 (m)
ncaidin@linuxfoundation.org

--0000000000004e4e9305a2550b32
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">[cross posted]<div><br></div><div>Reminder.=C2=A0 Mailman2=
 to Groups.io email is scheduled to start on=C2=A0</div><div><br></div><div=
>Pacific - 2 pm , Monday, April 6</div><div>Eastern - 5 pm, Monday April 6<=
/div><div>CET - 11 pm, Monday April 6</div><div>JST - 6 am, Tuesday, April =
7</div><div><br></div><div>It is expected to take several hours, but could =
be as much as a full 24 hours.=C2=A0</div><div><br></div><div>When the migr=
ation is completed, I will send out the links so that you can access email =
archives.</div><div><br></div><div>Best regards,</div><div>Neal</div><div><=
br></div><div><br clear=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signat=
ure" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"l=
tr"><span><font color=3D"#888888"><div dir=3D"ltr"><div dir=3D"ltr"><div><d=
iv dir=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div=
 dir=3D"ltr"><b style=3D"color:rgb(136,136,136)"><font color=3D"#666666"><f=
ont color=3D"#888888">Neal Caidin</font></font></b><br><div style=3D"color:=
rgb(136,136,136)"><span style=3D"border-collapse:collapse"><div><font color=
=3D"#666666"><font>Program Manager, Program Management &amp; Operations</fo=
nt></font></div><div><font color=3D"#666666"><font>The Linux Foundation</fo=
nt></font></div><div><font color=3D"#666666">+1 (919) 238-9104 (w/h)<br>+1 =
(919) 949-1861 (m)</font></div><div><font color=3D"#666666"><a href=3D"mail=
to:ncaidin@linuxfoundation.org" target=3D"_blank">ncaidin@linuxfoundation.o=
rg</a></font></div></span></div></div></div></div></div></div></div></div><=
/div></div></font></span></div></div></div></div></div></div></div>

--0000000000004e4e9305a2550b32--

--===============0634486643779298577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============0634486643779298577==--

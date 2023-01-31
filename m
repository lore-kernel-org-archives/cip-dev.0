Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3375C38142
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 18:01:06 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
 by mx.groups.io with SMTP id smtpd.web10.418.1675186798460629266
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Jan 2023 09:39:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=UcGIHKBB;
 spf=pass (domain: gmail.com, ip: 209.85.128.176, mailfrom: vadym.haidamaka@gmail.com)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-4fd37a1551cso212922147b3.13
        for <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 09:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tJ9uUdcHDfO8SK4bu5RCcuoga0/epDFHJHMmyCBQrd8=;
        b=UcGIHKBBaD8uAn+FR7cYKo71RvlZHXAvseF54ZBgNgS3n8DRNfIw6RXbPJqU46EoKb
         Vn+yT8f9uMYUJOnuJI91Wq9TErVr3nhC20Z0eyFKXjV36Bf+uwHa4myKR6LOe0hkSIbN
         P2nJnclC+6rONrwSwzfZj8755RrtCUue4Trsh6kXcDFL5qbdBbM00fyuWaT33vvhqB4k
         AjLAuOFIwjAnxQDXovj9zsUxVWqTqSwXaVOpqPQnSLnKRXeO93YQmiB2LX6pE0VWBqT/
         H8dxqJx2+Kx3r0DSbCB1JK/Qjk/2Hp6nckv2t5YpcqeQ9wEBf3c7WnSHDXJwySyVl+7L
         /LgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJ9uUdcHDfO8SK4bu5RCcuoga0/epDFHJHMmyCBQrd8=;
        b=S0MRxoKkCdSQTp7dboEHQwKaIRa0XMPZlbcq/w9Ff9ol1ZPHKfzZ1PDmDsci0cqQcj
         liBBbA5LBwykyPVEFWQrUvn+JGB5mROlrM55p58G5zRfXEVlsCfUS/p+c06qvx1hY8KV
         ZG2CPSorvTGRckDht3YDQQsa0nQNiMP8vsqUUnx1ht09qT/0kMF+CMIKK0+pgInRS6s0
         +srts3I+juBdKYtDenzT8NPnIJD4g1zQ2c/DW3c0861tu7zRGZcQnblPBrVVWqUZW0Q+
         207kEItn4vvo6DNC9tvTGPnE8GuOTkKC84CE6EYPrWW7usw4d0ce/O7vklbuZhu3d+p+
         QVfQ==
X-Gm-Message-State: AO0yUKV9GXl/rr66k7J/9ua9R4oMqPkjWMlD4sA1oPxcIWX0oXZZSsFN
	Q/iRFaMMTOYEhCL7Atmas1cks3JH5J/sfET96JPvc6YDa+4XYg==
X-Google-Smtp-Source: AK7set+5s3BQSthXgEyMqzSxBPbWRENURd4m+FMFSri36Oligdb+ee/QTftCIUhDmu1KW9tUhwWYYB9JgKe4dAQ0xr4=
X-Received: by 2002:a0d:e0c6:0:b0:506:f14b:f1af with SMTP id
 j189-20020a0de0c6000000b00506f14bf1afmr2811714ywe.37.1675186797395; Tue, 31
 Jan 2023 09:39:57 -0800 (PST)
MIME-Version: 1.0
From: Vadym Haidamaka <vadym.haidamaka@gmail.com>
Date: Tue, 31 Jan 2023 19:39:46 +0200
Message-ID: <CAJDaTYk6Q7zVPv6bVicqoXq8v6p0+x17+DiuuR22_OMWn7G1bw@mail.gmail.com>
Subject: 4.9 SLTS support
To: cip-dev@lists.cip-project.org
Content-Type: multipart/alternative; boundary="000000000000fdc53005f392d175"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 18:01:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10546

--000000000000fdc53005f392d175
Content-Type: text/plain; charset="UTF-8"

Hi,

Would Linux kernel 4.9 be supported by the CIP project as a next SLTS
version?
Because 4.9.337 is the latest released version
https://lore.kernel.org/lkml/Y7lbu6%2F0P7Q%2FP3oj@kroah.com/T/ and now it
became EOL.
If yes, would it be possible to upgrade the wiki page
https://wiki.linuxfoundation.org/civilinfrastructureplatform/start ?

Thank you in advance.

Vadym Haidamaka

--000000000000fdc53005f392d175
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Would Linux kernel 4.9 be supported=
 by the CIP project as a next=C2=A0SLTS version?</div><div>Because=C2=A04.9=
.337 is the latest released version=C2=A0<a href=3D"https://lore.kernel.org=
/lkml/Y7lbu6%2F0P7Q%2FP3oj@kroah.com/T/">https://lore.kernel.org/lkml/Y7lbu=
6%2F0P7Q%2FP3oj@kroah.com/T/</a> and now it became EOL.</div><div>If yes, w=
ould it be possible to upgrade the wiki page=C2=A0<a href=3D"https://wiki.l=
inuxfoundation.org/civilinfrastructureplatform/start">https://wiki.linuxfou=
ndation.org/civilinfrastructureplatform/start</a> ?</div><div><br></div><di=
v>Thank you in=C2=A0advance.</div><div><br></div><div>Vadym Haidamaka</div>=
</div>

--000000000000fdc53005f392d175--


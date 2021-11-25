Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81958C433F5
	for <webhook@archiver.kernel.org>; Thu, 25 Nov 2021 02:42:29 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by mx.groups.io with SMTP id smtpd.web11.7324.1637808147265642170
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Nov 2021 18:42:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=X8D56q1L;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.180,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f180.google.com with SMTP id r26so9425070oiw.5
        for <cip-dev@lists.cip-project.org>;
 Wed, 24 Nov 2021 18:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=dvvn7l7aw47oAwOekk4tx4irKJe4mpsvmcc6vijbxq4=;
        b=X8D56q1L4MVKPwJwdvZVlWNpXTx4Xu7Ik06qeUveQ2pfEwcxoZdkxTODkjUQEIOqmZ
         DztWnZ+I69DvNvUxuoL+5dg01sDga72VgyV6POszENVOTClRE/NfSl11Ci/y7hWaN/8z
         YOkIVfn3fN5KSiAWRBFU6V9/1E4u51j6uq3U/dbLBJNGfsuLVB4GW8+kfvA+XHl0vsRh
         E3ZJVvgaK9w+4llYUO9Zr5FRQUKv/xmZayU6aUX0qkhsJdd4PMHJxvO/1vXdus9TmLLN
         MEAaIhxZGBY/dSITcyR32OGWM+E5VjHtEm9/uYL/X7p6RcLbFPiJ3rguOTrrAK9ZlxQ1
         z1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dvvn7l7aw47oAwOekk4tx4irKJe4mpsvmcc6vijbxq4=;
        b=x2N1jMej41pY4RMVQBRSN8jJbFew2PN1aX1VeNBSvpfRj6jpvQ6aelFKrbZn/wCmpw
         TeePA1BNwG6mjB6GoM6V7W9EuxQrF4btWgZrucknKJzEr2U5uzm7z+7fxpMvv5fbZM/u
         qZ6s8ui7989fBJzHrIPVaFSS6hrOVUiO8FosSFq0OaA0JzbR42yvuDSGjvAPlnPkXMiY
         vmpdGMbwZ/WkoZYeUEZlkWHuqCa1gcXZGdG6X45iGCM/IRsrsT2epDh8MNPy7fuEHCkQ
         psE+X8PlqU0mSD4J5PpoVQhSxg6YYzUQkiRZ55g4ZpcDbxxQB14t48d1f/U5w/1vGVVt
         oskw==
X-Gm-Message-State: AOAM532c4kRD/TjvaqpmpMcKHMwr1Ib+fO8N80bbZdbn88mHbDnEI2FD
	ssmSCLU5aS99h0xtgC1dieUuR4HsGKSBmCXlVEPUHZtg6WmZsg==
X-Google-Smtp-Source: 
 ABdhPJxudZxmKuEvrtHFJa26zhzxXEpmEfqvWGxdtCztDn2c490uaOQlGK+iUpiaoAd1pHekygax+9QApgbd6S1cbj4=
X-Received: by 2002:aca:b407:: with SMTP id d7mr11423697oif.116.1637808146264;
 Wed, 24 Nov 2021 18:42:26 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 25 Nov 2021 11:41:50 +0900
Message-ID: 
 <CAODzB9qEJUBAGggEaTmc27Lr0opreM8wv5D_HStKT6UH=+a_UA@mail.gmail.com>
Subject: New CVE entries in this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="000000000000c4c36c05d193ec29"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Nov 2021 02:42:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7008

--000000000000c4c36c05d193ec29
Content-Type: text/plain; charset="UTF-8"

Hi !

It's this week's CVE report.

This week reported two new CVEs.

* New CVEs

CVE-2021-33098: Improper input validation in the Intel(R) Ethernet ixgbe
driver for Linux before version 3.17.3 may allow an authenticated user to
potentially enable denial of service via local access.

CVSS v3 score is 5.5 MEDIUM.

Intel released fixed version of driver kit. Not sure this CVE affects
mainline's source code.

Fixed status

Intel released fixed version of driver kit.

CVE-2021-4001: bpf: Fix toctou on read-only map''s constant scalar tracking

CVSS v3 score is not provided.

This bug was introduced in 5.5-rc1 and fixed in 5.16-rc2.  Patch for 5.15
is in stable-rt tree. Patch for 5.4(
https://lore.kernel.org/stable/163757721744154@kroah.com/) and 5.10(
https://lore.kernel.org/stable/1637577215186161@kroah.com/) are failed to
apply. However, this bug was introduced in 5.5-rc1 so 5.4 can be ignored?
Fixed status

mainline: [353050be4c19e102178ccc05988101887c25ae53]

* Updated CVEs

CVE-2021-3640: UAF in sco_send_frame function

5.10 and 5.15 are fixed this week.

Fixed status

mainline: [99c23da0eed4fd20cae8243f2b51e10e66aa0951]
stable/5.10: [4dfba42604f08a505f1a1efc69ec5207ea6243de]
stable/5.14: [2c2b295af72e4e30d17556375e100ae65ac0b896]
stable/5.15: [b990c219c4c9d4993ef65ea9db73d9497e70f697]
stable/5.4: [d416020f1a9cc5f903ae66649b2c56d9ad5256ab]

CVE-2021-43975: atlantic: Fix OOB read and write in hw_atl_utils_fw_rpc_wait

The mainline kernel was fixed in 5.16-rc2.

Fixed status

mainline: [b922f622592af76b57cbc566eaeccda0b31a3496]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26555: BR/EDR pin code pairing broken

No fix information

CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
Provisioning Leads to MITM

No fix information.

CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioning

No fix information.

Regards,

-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--000000000000c4c36c05d193ec29
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi !<br><br>It&#39;s this week&#39;s CVE report.<br><br>Th=
is week reported two new CVEs.<br><br>* New CVEs<br><br>CVE-2021-33098: Imp=
roper input validation in the Intel(R) Ethernet ixgbe driver for Linux befo=
re version 3.17.3 may allow an authenticated user to potentially enable den=
ial of service via local access.<br><br>CVSS v3 score is 5.5 MEDIUM.<br><br=
>Intel released fixed version of driver kit. Not sure this CVE affects main=
line&#39;s source code.<br><br>Fixed status<br><br>Intel released fixed ver=
sion of driver kit.<br><br>CVE-2021-4001: bpf: Fix toctou on read-only map&=
#39;&#39;s constant scalar tracking<br><br>CVSS v3 score is not provided.<b=
r><br>This bug was introduced in 5.5-rc1 and fixed in 5.16-rc2.=C2=A0 Patch=
 for 5.15 is in stable-rt tree. Patch for 5.4(<a href=3D"https://lore.kerne=
l.org/stable/163757721744154@kroah.com/">https://lore.kernel.org/stable/163=
757721744154@kroah.com/</a>) and 5.10(<a href=3D"https://lore.kernel.org/st=
able/1637577215186161@kroah.com/">https://lore.kernel.org/stable/1637577215=
186161@kroah.com/</a>) are failed to apply. However, this bug was introduce=
d in 5.5-rc1 so 5.4 can be ignored?<div>Fixed status<br><br>mainline: [3530=
50be4c19e102178ccc05988101887c25ae53]<div><br></div><div>* Updated CVEs<br>=
<br>CVE-2021-3640: UAF in sco_send_frame function<br><br>5.10 and 5.15 are =
fixed this week.<br><br>Fixed status<br><br>mainline: [99c23da0eed4fd20cae8=
243f2b51e10e66aa0951]<br>stable/5.10: [4dfba42604f08a505f1a1efc69ec5207ea62=
43de]<br>stable/5.14: [2c2b295af72e4e30d17556375e100ae65ac0b896]<br>stable/=
5.15: [b990c219c4c9d4993ef65ea9db73d9497e70f697]<br>stable/5.4: [d416020f1a=
9cc5f903ae66649b2c56d9ad5256ab]<br><br>CVE-2021-43975: atlantic: Fix OOB re=
ad and write in hw_atl_utils_fw_rpc_wait<br><br>The mainline kernel was fix=
ed in 5.16-rc2.<br><br>Fixed status<br><br>mainline: [b922f622592af76b57cbc=
566eaeccda0b31a3496]<br><br>Currently tracking CVEs<br><br>CVE-2021-31615: =
Unencrypted Bluetooth Low Energy baseband links in<br>Bluetooth Core Specif=
ications 4.0 through 5.2<br><br>There is no fix information.<br><br>CVE-202=
0-26555: BR/EDR pin code pairing broken<br><br>No fix information<br><br>CV=
E-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning<br><=
br>No fix information.<br><br>CVE-2020-26557: kernel: predictable Authvalue=
 in Bluetooth Mesh<br>Provisioning Leads to MITM<br><br>No fix information.=
<br><br>CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioni=
ng<br><br>No fix information.<br><br>CVE-2020-26560: kernel: impersonation =
attack in Bluetooth Mesh Provisioning<br><br>No fix information.<br><br>Reg=
ards,<br><br>-- <br>Masami Ichikawa<br>Cybertrust Japan Co., Ltd.<br><br>Em=
ail :<a href=3D"mailto:masami.ichikawa@cybertrust.co.jp">masami.ichikawa@cy=
bertrust.co.jp</a><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :<a href=3D"mailto=
:masami.ichikawa@miraclelinux.com">masami.ichikawa@miraclelinux.com</a></di=
v></div></div>

--000000000000c4c36c05d193ec29--


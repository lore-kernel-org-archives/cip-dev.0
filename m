Return-Path: <whyshall.dev@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008AEC43458
	for <webhook@archiver.kernel.org>; Thu,  9 Jul 2026 04:53:49 +0000 (UTC)
Received: from mail-oo2-f4.google.com (mail-oo2-f4.google.com [74.125.231.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2268.1783572827891924605
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 21:53:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=KPqWXiOO;
 spf=pass (domain: gmail.com, ip: 74.125.231.132, mailfrom: whyshall.dev@gmail.com)
Received: by mail-oo2-f4.google.com with SMTP id 46e09a7af769-7e9f37a2160so362063a34.0
        for <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 21:53:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783572827; cv=none;
        d=google.com; s=arc-20260327;
        b=jZBqlLcb/RidpLapVJMZBzhmYmhV1534SP3Dgj8E/etY5ljj1vr+QLTaWa3suB9WZ3
         QPYf3mlZdKHGVVsCUKsI93JI6qSpZmiw8hc1s29aAvyPm1ZesY3EFEsb44eAKLlfbyg9
         UOxw+EyZVLJ/pbf0hf6NifuJjPCUmvjUNEH7IM46JWojwK7mqCMtOQ2rX7j35+VtFvxn
         srkNdj7kmJzME9uhw/dDau1WBp1qV36FRe3NYpmhsIUYtjBnO3MrkVfcnEqTatbNje8p
         vM7atzN6h1uxJJCCkRl9X845vTd91CR+wY7I+bnOTBxz7GTfiyzm62PAynyQBi2mSWp5
         pcXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=1/Htsa56u/JRtEHYrlLrjnxaT83oJe59cRDx/FYQ0DY=;
        fh=RaKH4vXZgYv/1PYcQkfLRK5D2CnBMLe+KcXQA6BQxAs=;
        b=HiYriOTwC5aS0AWv4fYLuFFfRqZnWK6KFsy/lz44K54bMYB84kygqAOomKs7Y0hZE6
         ieS8dsWHF3avpbKdF4ryPx/ww+vJYpQK5u28DUK8eC2BP8ijhnKirP7w2lvCfX9hWMej
         UW4/2jhIlXemnAMFgE16zS1O8wVF7g6bb0XZuswXFg65osOzj4TJb8GayA3iyY/nYAII
         I4JCyGpXe/pXXFi+nPFrwCjB07jkmW5A+PUul5ZR3O4/7aC9w8f/e6bHlEP7YrJnvadu
         EGfNMiXPoXasTs8ZKUIsyGRPFyspOCQLHD7sJv+bTNSHR0UDxn5cg7+vbg+0dZi4n2o7
         0AvA==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783572827; x=1784177627; darn=lists.cip-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1/Htsa56u/JRtEHYrlLrjnxaT83oJe59cRDx/FYQ0DY=;
        b=KPqWXiOO9G0BgeYY9A9lql6hzajACZtvmcDSXno2UOY1s+qh3IsO+JD8NPNJwWmTjW
         sROx33Hyyy7Fq/R+i2+ean9+TxOOm7ZK8fKNpz1/bmP6zW5f0a0vDboDXvr3xjqkoFrG
         l4L9G06h93o07bSc62+P9kzhc2Mxity2S7C/kgg6dXpYjInbnSo2nmIMQ+jS9kQtlknE
         DI7t5bEvGEhYyz/eIaZ1GRKxsQFOJNSrZs0gX2Ya7vdz6UOpLWA2MXbtG/n7BHWe4Kl3
         94D507+34upfPLkZTmzv93eaQqkfQ9S331Zn9uXfU8HWa6xrRyT6RQrtaUBHXzMrCYrK
         qoxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783572827; x=1784177627;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1/Htsa56u/JRtEHYrlLrjnxaT83oJe59cRDx/FYQ0DY=;
        b=gxsfak/62j+ndm3w12+TCa9JmLvmYDh1YWDUQjn+kmRGB03SB82jGzcXFgdKnbO6Bm
         ikB80nuWhGRIp0w3uF3/F8t+1H978gmZnLo2BknViTsN7OAa9k+0wviNqttN0+e1R0CE
         garMYAXkTVOlggJX3aFvNr6kpSg43kB5D1rq9/upXsGBqSK7/zQN4AehF7ToBDFJVh8Z
         VRoWnWDj9bhwHtcGjZUWsGrvFT5JrPh1ODBEbKd8vceu5bUhI8EsLUJrBUXoNuXiEds4
         YHo4Lgf9ZwMvF21TTU2HKm/QTmxN7drM9a/SH6hwCVCjIzORZ6n2KaFRuUflv8nCn3An
         22kg==
X-Gm-Message-State: AOJu0Yy87gZ1Iwlb3RZtW72v/xlbpG+/dHNTXbOwT9CNguWqG9CB29gl
	iimsEMgQzQPUyz+AzM1XMD28rWJo7IVofSjxKk4YJs/I/D12O+aibVvlq1XRGV/7N/5ydy2Fp3m
	whx022Xh0IAkNVUazST81IXX4pDeYDIqE7eSd4yw=
X-Gm-Gg: AfdE7cnckj/fF+A5sO8U67qQ78il2xox0mP4HJhnWCuQhh15K7JzC3ao2wTco8KdtW8
	XvT1G7PIRLB2NHsBX+DeounIWJGZVOyQ771YKWbEBuEhuLYFe5kxFroVKaiCYQqzHFk9yz8aPxC
	FfhiC+tlZS5kuCuluny+Oqm+MxieWzf4f5EK4bGOIOF7VwYZp2cJvpallH4qPdxp+/6K8dSCY8N
	EzGrvIqd09NuMo+PQw/YM1HcxlIK6S+KmXcy3mCMpNk2yWTdklTwVyvuGTdKdimtg+D/vMe
X-Received: by 2002:a05:6820:4ccb:b0:6a1:4507:3544 with SMTP id
 006d021491bc7-6a36d8ea5edmr3761936eaf.28.1783572826850; Wed, 08 Jul 2026
 21:53:46 -0700 (PDT)
MIME-Version: 1.0
From: whyshall <whyshall.dev@gmail.com>
Date: Thu, 9 Jul 2026 10:23:35 +0530
X-Gm-Features: AUfX_my4jccLDr7W7nrjyY1exCFqgo6r4kY7jGz8ugt7aewI-hpEs9yRo4rZV5k
Message-ID: <CAOksrezPuEAoJ86FHMS_ajoH0h7pe3usksyo84n5rF9RKHfu4g@mail.gmail.com>
Subject: Urgent: Regarding Fixing of Security Vulnerabilities
To: cip-dev@lists.cip-project.org
Content-Type: multipart/alternative; boundary="000000000000c68a330656266867"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jul 2026 04:53:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23552

--000000000000c68a330656266867
Content-Type: text/plain; charset="UTF-8"

 Hi ,

We are planning to migrate our product to the Linux Kernel 4.19.y CIP
release to benefit from its long-term maintenance and security updates.

We have a few questions regarding security vulnerability tracking for the
CIP kernel:

   1. Is there any tool, dashboard, or documentation available to determine:
      - The Kernel CVEs applicable to a specific 4.19.y CIP release.
      - Which CVEs have already been fixed till the given CIP release.
      - Which CVEs are still outstanding.
      2. Is there a published roadmap or policy indicating how unresolved
   Kernel CVEs are evaluated and scheduled for backporting to the 4.19.y CIP
   branch?
   3. For CVEs that remain unfixed in the CIP kernel:
      - What are the expected implications or risks for users of the CIP
      release?
      - Are these vulnerabilities typically already addressed in the
      upstream mainline Linux kernel, with backporting to CIP pending due to
      compatibility or maintenance considerations?
      4. If there are unfixed vulnerabilities that are considered critical
   for our product, what is the recommended approach to address them?


   - Does the CIP project provide any guidance or best practices for
      evaluating, backporting, or mitigating such vulnerabilities?
      - If a required fix is available only in the upstream mainline
      kernel, are there any recommendations or guidelines for safely
backporting
      it to the CIP kernel?

Any guidance on the recommended process or tools for tracking the security
status of CIP kernel releases would be greatly appreciated.

Thank you for your support.

--000000000000c68a330656266867
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"color:rgb(0,0,0);font-family:roboto;font-siz=
e:13.3333px;line-height:normal">=C2=A0Hi ,<br></div><p style=3D"color:rgb(0=
,0,0);font-family:roboto;font-size:13.3333px;line-height:normal"><span styl=
e=3D"line-height:normal">We are planning to migrate our product to the Linu=
x Kernel 4.19.y CIP release to benefit from its long-term maintenance and s=
ecurity updates.</span><br></p><p style=3D"color:rgb(0,0,0);font-family:rob=
oto;font-size:13.3333px;line-height:normal"><span style=3D"line-height:norm=
al">We have a few questions regarding security vulnerability tracking for t=
he CIP kernel:</span><br></p><ol start=3D"1" style=3D"color:rgb(0,0,0);font=
-family:roboto;font-size:13.3333px"><li><span style=3D"line-height:normal">=
Is there any tool, dashboard, or documentation available to determine:</spa=
n><ul><li><span style=3D"line-height:normal">The Kernel CVEs applicable to =
a specific 4.19.y CIP release.</span><br></li><li><span style=3D"line-heigh=
t:normal">Which CVEs have already been fixed till the given CIP release.</s=
pan><br></li><li><span style=3D"line-height:normal">Which CVEs are still ou=
tstanding.</span><br></li></ul></li><li><span style=3D"line-height:normal">=
Is there a published roadmap or policy indicating how unresolved Kernel CVE=
s are evaluated and scheduled for backporting to the 4.19.y CIP branch?</sp=
an><br></li><li><span style=3D"line-height:normal">For CVEs that remain unf=
ixed in the CIP kernel:</span><ul><li><span style=3D"line-height:normal">Wh=
at are the expected implications or risks for users of the CIP release?</sp=
an><br></li><li><span style=3D"line-height:normal">Are these vulnerabilitie=
s typically already addressed in the upstream mainline Linux kernel, with b=
ackporting to CIP pending due to compatibility or maintenance consideration=
s?</span><br></li></ul></li><li><div style=3D"line-height:normal"><span sty=
le=3D"line-height:normal">If there are unfixed vulnerabilities that are con=
sidered critical for our product, what is the recommended approach to addre=
ss them?</span><br></div></li></ol><ul style=3D"color:rgb(0,0,0);font-famil=
y:roboto;font-size:13.3333px"><ul><li><div style=3D"line-height:normal"><sp=
an style=3D"line-height:normal">Does the CIP project provide any guidance o=
r best practices for evaluating, backporting, or mitigating such vulnerabil=
ities?</span><br></div></li><li><div style=3D"line-height:normal"><span sty=
le=3D"line-height:normal">If a required fix is available only in the upstre=
am mainline kernel, are there any recommendations or guidelines for safely =
backporting it to the CIP kernel?</span><br></div></li></ul></ul><p style=
=3D"color:rgb(0,0,0);font-family:roboto;font-size:13.3333px;line-height:nor=
mal"><span style=3D"line-height:normal">Any guidance on the recommended pro=
cess or tools for tracking the security status of CIP kernel releases would=
 be greatly appreciated.</span><br></p><p style=3D"color:rgb(0,0,0);font-fa=
mily:roboto;font-size:13.3333px;line-height:normal"><span style=3D"line-hei=
ght:normal">Thank you for your support.</span></p></div>

--000000000000c68a330656266867--


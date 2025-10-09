Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B667CAC5BB
	for <webhook@archiver.kernel.org>; Fri, 10 Oct 2025 06:22:14 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.web11.3741.1760024573856659408
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Oct 2025 08:42:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intwineconnect.com header.s=google header.b=fShEPT3W;
 spf=pass (domain: intwineconnect.com, ip: 209.85.218.43, mailfrom: lnasby@intwineconnect.com)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b4f323cf89bso197551266b.2
        for <cip-dev@lists.cip-project.org>; Thu, 09 Oct 2025 08:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intwineconnect.com; s=google; t=1760024572; x=1760629372; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6fyymjxlbKAMtCAGdsmzkw1ihn9llmhSe2oG1N7J1xU=;
        b=fShEPT3WUUvtqAXmCkF60mU05tro6QS7YsfhU6Dtut9FUAj31DgRTcvIu6mxbe2OPt
         JY+Tf8XlPMQaCp0HLJQ8JzWW4pseCRcRiPTGmLdhSCEMwFJZZnX7NvmkQuCWanGrOFVM
         ie9PKH5UWdzzqyn+WC+sc44cC8WDyrxxeJ3LXkDz/owUdnqgjaif3nB6FIP+jeqZP8Gb
         YY1riNFh9kbv4AZ5wkKXolMCwYjeTYwUq7DQB4GRYILp1iDjX0D9FvWKXK5bpzn/M6Kl
         GizNC81cVqdBf66Df0SduiV5au+D/RfDU/ZQeSzRfdoWIlIhG/Xf2/KMEb8MZsY0sx40
         EIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760024572; x=1760629372;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fyymjxlbKAMtCAGdsmzkw1ihn9llmhSe2oG1N7J1xU=;
        b=a1o0dLl3tSUPOLxJn/WmdXJa+h78ddxsx5+QVwsIfq4SZPJhIGAmNg8futEiIkXXaT
         vs1OBzfknCO85B/aYL5xhI2wKpa0ZfmqtyIzKF96uT0vNxMuFbzT7t5fFzHdVOW/7rFD
         ikzcEbb35dP/jQcyuH+wN3VMdtuy4M7fFMPKsINalAapDcDFPyCrLVXpWeT74vRfdUbI
         2Zb93wTRsPhq5ww3hkMGXh1+XzjmlOxxX8rnB9+ESQX9IsfSFbdFxq2weHPku6xexGaH
         vve+c3IOEL5qz8sFpf625h+cBoUXwzYtNz1A1iWVpYDcy095hBYzwBK7ylyDm8Yhq5HT
         8R6Q==
X-Gm-Message-State: AOJu0YzZ2BhbXDRXw3kcDUqu2uxxhHJREsHtlKbXcJCrY9XpunBIa0F9
	i5Oc4z2B03Y5OaS/XxZ87QFat0aniOvvWdqndwSPbwyUNfaiDLE4QldUTChKT/Pqiln2Z43xNMY
	8Vv/3fo2cS8uE7zS7cFp2EEx+k+V5a/r7/L1m6bRiL+MgCYuA74VfYY4=
X-Gm-Gg: ASbGnctU9FdtKhtnU9tOD28pIDttiaIcbCm9q+lBTAcdhtzmimW2HKua1NcD14gSHOC
	YxcwXmBs89ymF5DHbQ2AYhpXMuIErGZHUQdpIFRgDTFH+xB4I2fB//RUZNo1Qz07gKX/0mMEWnZ
	YEgu2kYVlFItChcuhUDp+G9l5UKiPmukcUItapt7VQ6FgtBIOUIick8YBtiivBOA79DKhYQqNlk
	v8FDdnnJDwUyhwD13MZZGXpE/1W7Q==
X-Google-Smtp-Source: AGHT+IEq7Tkb2ojAcynIQ+i8Hr7OaXVIgIB+0wdfzYrvhlVGCaBOkPbRvSJ0kwngJLZtMvUv7PhqwQmwNgQ5UQCkqGQ=
X-Received: by 2002:a17:906:6b9a:b0:b45:1063:fb65 with SMTP id
 a640c23a62f3a-b50abaafd40mr722301766b.39.1760024208870; Thu, 09 Oct 2025
 08:36:48 -0700 (PDT)
MIME-Version: 1.0
From: Luke Nasby <lnasby@intwineconnect.com>
Date: Thu, 9 Oct 2025 17:36:37 +0200
X-Gm-Features: AS18NWCn8mjGZeVLkDf4x0BSLetqU5772vdnquqddZmQUgDQj6TI0IB9f1Z5WjU
Message-ID: <CAJ6VbXKtYC2r6+obQvCza9jtWTCsfRbzNGWFa6_MwZALR9qvJg@mail.gmail.com>
Subject: v4.19.325-cip124 pipeline failure
To: cip-dev@lists.cip-project.org
Content-Type: multipart/alternative; boundary="000000000000c420cc0640bb9191"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Oct 2025 06:22:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20166

--000000000000c420cc0640bb9191
Content-Type: text/plain; charset="UTF-8"

I noticed that the pipeline for v4.19.325-cip124 fails most of its tests.
Should these be re-run, or should we assume this kernel is untested
currently? Just curious as to if these kernel versions are safe to
incorporate in another project, or if we should wait til these tests pass,
or use another version that passes its gitlab pipeline.

Thanks!

--000000000000c420cc0640bb9191
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I noticed that the pipeline for v4.19.325-cip124 fail=
s most of its tests. Should these be re-run, or should we assume this kerne=
l is untested currently? Just curious as to if these kernel versions are sa=
fe to incorporate=C2=A0in another project, or if we should wait til these t=
ests pass, or use another version that passes its gitlab pipeline.</div><di=
v><br></div><div>Thanks!</div></div>

--000000000000c420cc0640bb9191--


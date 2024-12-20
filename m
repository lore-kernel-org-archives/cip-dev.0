Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45038E77188
	for <webhook@archiver.kernel.org>; Mon, 23 Dec 2024 00:24:50 +0000 (UTC)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
 by mx.groups.io with SMTP id smtpd.web10.679.1734738636442414253
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Dec 2024 15:50:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=X7yAhXuB;
 spf=pass (domain: gmail.com, ip: 209.85.160.44, mailfrom: stephenecker240@gmail.com)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-29ff5c75c21so1807549fac.0
        for <cip-dev@lists.cip-project.org>; Fri, 20 Dec 2024 15:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734738635; x=1735343435; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fl/YM+9PF3UM8TsseT94pUKg09z99jn6dU5WoF8ep2Q=;
        b=X7yAhXuBdQTJ45gXeZAOYBkm5ZE3cXDjBzqk4w7zK/8IrKA48hdSAwQdltFhg73HmG
         HW0NpaCYtcmwDZZWwDUk4hq9aQsFo+gE1J7Tg3wcnfUdOCmZ9EXhmOFMIMYwAX2vgQmk
         swo90BBXZK/XSXV1b2Q7SFGc/s0MJP8H2ziSn6Vakh4AD4JhmaKcBzYoOGMktbeGCcqj
         K+UCfX3ypgH/nZA7eDmsOonSybxEFGcd9CjctEirPNT1Ahq6wC1Eq3917zAlEZ0Y1cUr
         uUXSV8+kUfEejSFkW3wFfLUIxIEyZPd5JP40yAyZINmlqU4uU88K1J4Ye9MiQG0Bt1OL
         8WEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734738635; x=1735343435;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fl/YM+9PF3UM8TsseT94pUKg09z99jn6dU5WoF8ep2Q=;
        b=c4C6Zl+D1wTkcnnHUbRR6anvBuHTfc58U/r0Nnko5gXhmcMA9nbi+H+F+1RfXPggOa
         nH2fx2274ZLBSY5uDt7hirmA+OcwZbI9C6UJxmBhdgleR9kWHleRfrzSPJ4ZpcvViMz5
         JAZbyuYCOGwH1lFMuOpKqhuM7oD5hKBb4pVw0gRMbS2dzjYb3nFyFF+HBux4hWr+Z/oL
         SdOMWoBBJxtgVJaknQIl8+aAAL3pt5t4BfTW4vdwaRj6MxYNzTmXJZ9qBD34j3eoH6vr
         swIqWYWUrcVLO6XGoLYSooP5j6hVS4X26McUES3loUnQlAwkqUUbRZWY/7YyLBxYsCWN
         k+8w==
X-Gm-Message-State: AOJu0Yz0D0SMn4mNrn+/np6uWLBZyqoPUPUUkAMAvDERewb1RPOu/Hbj
	/S/no+uUJKQzgl9ZD5EUbAESnUJz9K8BBcM6PiUaYHxmUSyb6rrc8SVs5KCu5zw61C1Dz23YNuB
	jvaNiufPgZqr7YUVEMKgS33mPwr0TrA==
X-Gm-Gg: ASbGncvLikZq3l5NizKBgPZiaHuCr+4w97O5OUNdMo8ngIHvSz54926eFD32hzJedsk
	brqb0VbhKaBBHFjr7MW95cAdTQRvpZQ5L1R/N
X-Google-Smtp-Source: AGHT+IGy6XQjcCp9qoCZxQCGNN+GzMF0sAhMpvjsDLddi2rRCWcFpgbPi0nmo9lWSj5rYUaxLHlxZfDhylvh1hxNXrA=
X-Received: by 2002:a05:6870:8927:b0:29d:e45d:dc51 with SMTP id
 586e51a60fabf-2a7fca4632amr3005137fac.2.1734738635515; Fri, 20 Dec 2024
 15:50:35 -0800 (PST)
MIME-Version: 1.0
From: Stephen Ecker <stephenecker240@gmail.com>
Date: Fri, 20 Dec 2024 17:50:23 -0600
Message-ID: <CAK9C7GBFw=nN8mZWB_aC00QFYDxF19-4__1RPf_5kbKyuNmrPA@mail.gmail.com>
Subject: Efibootguard & empty fstab in initramfs
To: cip-dev@lists.cip-project.org
Content-Type: multipart/alternative; boundary="00000000000025ed950629bc507a"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Dec 2024 00:24:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17490

--00000000000025ed950629bc507a
Content-Type: text/plain; charset="UTF-8"

Hello, I am using efibootguard with the swupdate recipes and the image
cannot boot as the fstab is empty.  Any ideas on where to look regarding
how the initramfs is created, for debugging this issue?

Thanks,
  Stephen

--00000000000025ed950629bc507a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hello, I am using efibootguard with the swupdate recipes =
and the image cannot boot as the fstab is empty.=C2=A0 Any ideas on where t=
o look regarding how the initramfs is created, for debugging this issue?=C2=
=A0<div dir=3D"auto"><br></div><div dir=3D"auto">Thanks,=C2=A0</div><div di=
r=3D"auto">=C2=A0 Stephen</div></div>

--00000000000025ed950629bc507a--

